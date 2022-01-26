class APIData
{
	bool m_success = false;
	string m_error;

	APIDataEvent@[] m_events;

	bool m_compFinished = false;

	API::Competition@ m_competition;
	API::CompetitionRound@[] m_rounds;
	API::CompetitionRound@ m_currentRound;
	API::Match@[] m_matches;
	API::LiveRanking@[] m_matchesRankings;

	string m_matchesMapUid;
	string m_matchesMapName;

	private void AddEvent(APIDataEvent@ event)
	{
		m_events.InsertLast(event);
	}

	void Clear()
	{
		m_success = false;
		m_error = "";

		m_events.RemoveRange(0, m_events.Length);

		m_compFinished = false;

		@m_competition = null;
		m_rounds.RemoveRange(0, m_rounds.Length);
		@m_currentRound = null;
		m_matches.RemoveRange(0, m_matches.Length);
		m_matchesRankings.RemoveRange(0, m_matchesRankings.Length);

		m_matchesMapUid = "";
		m_matchesMapName = "";
	}

	void RefreshAsync()
	{
		m_events.RemoveRange(0, m_events.Length);

		try {
			if (m_competition is null) {
				if (Setting_Verbose) {
					trace("No competition yet, calling LoadCompAsync");
				}
				LoadCompAsync();
				m_success = true;
				return;
			}

			if (m_currentRound is null) {
				if (Setting_Verbose) {
					trace("No current round yet, calling LoadRoundsAsync");
				}
				LoadRoundsAsync();
				m_success = true;
				return;
			}

			if (m_matches.Length == 0) {
				if (Setting_Verbose) {
					trace("No matches yet, calling LoadMatchesAsync");
				}
				LoadMatchesAsync();
				m_success = true;
				return;
			}

			if (Setting_Verbose) {
				trace("Ready, calling LoadRankingsAsync");
			}
			LoadRankingsAsync();
			m_success = true;

		} catch {
			m_success = false;
			m_error = getExceptionInfo();
			error("Exception while loading data from API: " + m_error);
		}
	}

	void LoadCompAsync()
	{
		Clear();

		@m_competition = g_api.GetCompetitionAsync(Setting_CompetitionId);
		if (m_competition is null) {
			error("Competition with ID " + Setting_CompetitionId + " not found.");
			return;
		}

		LoadRoundsAsync();
	}

	void LoadRoundsAsync()
	{
		API::CompetitionRound@ currentRound;

		m_rounds = g_api.GetCompetitionRoundsAsync(m_competition.m_id);
		if (m_rounds.Length == 0) {
			throw("Competition with ID " + m_competition.m_id + " has no rounds!");
			return;
		}

		for (uint i = 0; i < m_rounds.Length; i++) {
			auto round = m_rounds[i];
			if (round.m_status != "COMPLETED") {
				@currentRound = round;
				break;
			}
		}

		API::CompetitionRound@ newRound = null;

		if (currentRound is null) {
			warn("Competition is finished! No more in-progress rounds for competition " + m_competition.m_id + ".");
			m_compFinished = true;
			@newRound = m_rounds[m_rounds.Length - 1];

		} else {
			m_compFinished = false;
			@newRound = currentRound;
		}

		if (newRound !is m_currentRound) {
			AddEvent(NewRoundEvent(m_currentRound, newRound));
		}
		@m_currentRound = newRound;

		LoadMatchesAsync();
	}

	void LoadMatchesAsync()
	{
		auto arrRoundMatches = g_api.GetRoundMatchesAsync(m_currentRound.m_id);

		API::Match@[] res;
		for (uint i = 0; i < arrRoundMatches.Length; i++) {
			auto rm = arrRoundMatches[i];

			auto match = g_api.GetMatchAsync(rm.m_id);
			if (match is null) {
				error("Couldn't fetch match with ID " + rm.m_id);
				return;
			}

			res.InsertLast(match);
		}

		m_matches = res;

		LoadMapInfoAsync();

		LoadRankingsAsync();
	}

	void LoadMapInfoAsync()
	{
		string currentMapUid;

		for (uint i = 0; i < m_matches.Length; i++) {
			auto match = m_matches[i];
			if (match.m_mapUids.Length != 1) {
				error("Unexpected number of maps in match " + match.m_id + " (there are " + match.m_mapUids.Length + " maps)");
				continue;
			}

			if (i == 0) {
				currentMapUid = match.m_mapUids[0];
			} else if (match.m_mapUids[0] != currentMapUid) {
				warn("Inconsistent map UID's across matches (match " + match.m_id + " differs from match " + m_matches[0].m_id + ")");
			}
		}

		if (currentMapUid == m_matchesMapUid) {
			return;
		}

		m_matchesMapUid = currentMapUid;

		auto app = cast<CGameManiaPlanet>(GetApp());
		auto dataFileMgr = app.MenuManager.MenuCustom_CurrentManiaApp.DataFileMgr;
		auto mapResult = dataFileMgr.Map_NadeoServices_GetFromUid(0, m_matchesMapUid);
		while (mapResult.IsProcessing) {
			yield();
		}
		if (mapResult.HasSucceeded) {
			m_matchesMapName = mapResult.Map.Name;
		} else {
			error("Unable to get map name from UID " + m_matchesMapUid);
			m_matchesMapName = "";
		}
		dataFileMgr.ReleaseTaskResult(mapResult.Id);
	}

	void LoadRankingsAsync()
	{
		API::LiveRanking@[] res;
		for (uint i = 0; i < m_matches.Length; i++) {
			auto match = m_matches[i];

			auto liveRanking = g_api.GetMatchLiveRanking(match.m_id);
			res.InsertLast(liveRanking);

			if (i < m_matchesRankings.Length) {
				auto oldLiveRanking = m_matchesRankings[i];

				for (uint j = 0; j < liveRanking.m_participants.Length; j++) {
					auto participant = liveRanking.m_participants[j];
					auto oldParticipant = oldLiveRanking.GetParticipant(participant.m_accountId);

					if (oldParticipant is null) {
						continue;
					}

					if (oldParticipant.m_score != participant.m_score) {
						AddEvent(ScoreChangeEvent(match, liveRanking, participant));
					}
				}
			}

			//TODO: Check if liveRanking.m_matchStatus != match.m_status
			//MatchStatusChangeEvent
		}
		m_matchesRankings = res;

		//TODO: If all matches have the completed status
		if (Setting_AdvanceRound) {
			Setting_AdvanceRound = false; //TODO: Remove

			print("All matches completed, round finished - loading next round!");
			m_currentRound.m_status = "COMPLETED";

			int index = m_rounds.FindByRef(m_currentRound);
			if (index == -1) {
				throw("Unable to find current round in list of rounds! This is a bug.. Please report!");
				return;
			}

			if (index == int(m_rounds.Length) - 1) {
				warn("Last round finished!");
				AddEvent(CompFinishEvent());
				m_compFinished = true;
				return;
			}

			auto newRound = m_rounds[index + 1];
			AddEvent(NewRoundEvent(m_currentRound, newRound));
			@m_currentRound = newRound;

			LoadMatchesAsync();
		}
	}
}

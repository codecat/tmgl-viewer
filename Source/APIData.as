class APIData
{
	API::Competition@ m_competition;
	API::CompetitionRound@ m_currentRound;
	API::Match@[] m_matches;
	API::LiveRanking@[] m_matchesRankings;

	string m_matchesMapUid;
	string m_matchesMapName;

	void Clear()
	{
		@m_competition = null;
		@m_currentRound = null;
		m_matches.RemoveRange(0, m_matches.Length);
		m_matchesRankings.RemoveRange(0, m_matchesRankings.Length);

		m_matchesMapUid = "";
		m_matchesMapName = "";
	}

	void Refresh()
	{
		if (m_competition is null) {
			LoadCompAsync();
			return;
		}

		if (m_currentRound is null) {
			LoadRoundsAsync();
			return;
		}

		if (m_matches.Length == 0) {
			LoadMatchesAsync();
			return;
		}

		LoadRankingsAsync();
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

		auto rounds = g_api.GetCompetitionRoundsAsync(m_competition.m_id);
		for (uint i = 0; i < rounds.Length; i++) {
			auto round = rounds[i];
			if (round.m_status != "COMPLETED") {
				@currentRound = round;
				break;
			}
		}

		if (currentRound is null) {
			error("Unable to find current round in competition " + m_competition.m_id + ".");
			return;
		}

		@m_currentRound = currentRound;

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
			res.InsertLast(g_api.GetMatchLiveRanking(match.m_id));
		}
		m_matchesRankings = res;
	}
}

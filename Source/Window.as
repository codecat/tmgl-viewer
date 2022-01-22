class Window
{
	bool m_refreshingClear = true;
	bool m_refreshing = false;
	int m_refreshTime = 10;

	string m_compName;

	string m_roundName;
	int m_roundId;

	string m_mapUid;
	string m_mapName;

	array<Match@> m_matches;
	array<Streamer@> m_mainStreams;

	/*
	void LoadFakeInfo()
	{
		m_compName = "TMGL Show";

		for (int i = 0; i < 4; i++) {
			m_matches.InsertLast(Match(i + 1));
		}

		m_mainStreams.InsertLast(Streamer("Trackmania", "https://twitch.tv/trackmania"));
		m_mainStreams.InsertLast(Streamer("Wirtual", "https://twitch.tv/wirtual"));

		m_roundName = "STEP 1 - ROUND 1";
		m_mapName = "POLEPARTY";
	}
	*/

	void Clear()
	{
		m_compName = "";

		m_matches.RemoveRange(0, m_matches.Length);
		m_mainStreams.RemoveRange(0, m_mainStreams.Length);

		m_roundName = "";
		m_mapUid = "";
		m_mapName = "";
	}

	Match@ GetMatchFromID(int id)
	{
		for (uint i = 0; i < m_matches.Length; i++) {
			auto match = m_matches[i];
			if (match.m_id == id) {
				return match;
			}
		}
		return null;
	}

	void UpdateFromApiData(const APIData &in data)
	{
		if (!data.m_success) {
			return;
		}

		bool newRound = (m_roundId != data.m_currentRound.m_id);
		bool newRoundJustStarted = (newRound && m_roundId != 0);

		m_compName = data.m_competition.m_name;

		m_roundName = data.m_currentRound.m_name;
		m_roundId = data.m_currentRound.m_id;

		m_mapUid = data.m_matchesMapUid;
		m_mapName = data.m_matchesMapName;

		if (newRound) {
			m_matches.RemoveRange(0, m_matches.Length);
		}

		m_mainStreams.RemoveRange(0, m_mainStreams.Length);
		for (uint i = 0; i < Data::Streamer::Global.Length; i++) {
			auto streamer = Data::Streamer::Global[i];
			m_mainStreams.InsertLast(Streamer(streamer.m_name, streamer.m_link));
		}

		for (uint i = 0; i < data.m_matches.Length; i++) {
			auto apiMatch = data.m_matches[i];
			auto match = GetMatchFromID(apiMatch.m_id);
			auto rankings = data.m_matchesRankings[i];

			if (match is null) {
				if (m_matches.Length >= 4) {
					warn("Unexpected new match ID " + apiMatch.m_id + " when there are already " + m_matches.Length + "! This is really bad!");
				}

				@match = Match(apiMatch.m_id, m_matches.Length + 1);
				m_matches.InsertLast(match);
			}

			match.m_joinLink = apiMatch.m_joinLink;

			if (apiMatch.m_status == "COMPLETED") {
				match.m_status = MatchStatus::Completed;
			} else if (apiMatch.m_status == "PENDING") {
				match.m_status = MatchStatus::Warmup;
			}

			//TODO: Update progressively instead of re-building the list
			match.m_players.RemoveRange(0, match.m_players.Length);
			for (uint j = 0; j < rankings.m_participants.Length; j++) {
				auto participant = rankings.m_participants[j];
				auto player = Data::Player::FromID(participant.m_accountId);

				MatchPlayer@ newPlayer = MatchPlayer();
				newPlayer.m_accountId = participant.m_accountId;
				newPlayer.m_score = participant.m_score;

				if (player is null) {
					error("Unable to find player data for " + participant.m_accountId);
				} else {
					newPlayer.m_displayName = ColoredString(player.m_nickname);
					newPlayer.m_teamTag = ColoredString(player.m_teamTrigram);
				}

				match.m_players.InsertLast(newPlayer);
			}

			match.m_streamers.RemoveRange(0, match.m_streamers.Length);
			for (uint j = 0; j < match.m_players.Length; j++) {
				auto player = match.m_players[j];
				auto streamer = Data::Streamer::FromPlayerID(player.m_accountId);
				if (streamer is null) {
					continue;
				}

				bool exists = false;
				for (uint k = 0; k < match.m_streamers.Length; k++) {
					auto existingStreamer = match.m_streamers[k];
					if (existingStreamer.m_link == streamer.m_link) {
						exists = true;
						break;
					}
				}

				if (!exists) {
					string name = streamer.m_name;
					if (streamer.m_language != "English") {
						name += " (" + streamer.m_language + ")";
					}
					match.m_streamers.InsertLast(Streamer(name, streamer.m_link));
				}
			}
		}

		if (newRoundJustStarted) {
			//TODO: Play a sound
			print("New round just started: " + m_roundName);
		}
	}

	void LoopAsync()
	{
		// Wait until the window is visible
		while (!Setting_Visible) {
			yield();
		}

		APIData data;

		m_refreshing = true;
		m_refreshingClear = true;

		data.Refresh();
		UpdateFromApiData(data);

		m_refreshing = false;
		m_refreshingClear = false;
		m_refreshTime = Setting_RefreshTime;

		while (true) {
			sleep(1000);

			if (Setting_Visible && --m_refreshTime == 0) {
				trace("Refreshing data..");

				m_refreshing = true;

				data.Refresh();
				UpdateFromApiData(data);

				m_refreshing = false;
				m_refreshTime = Setting_RefreshTime;
			}
		}
	}

	void Render()
	{
		if (!Setting_Visible) {
			return;
		}

		string title = "\\$e61" + Icons::Trophy + "\\$z TMGL Match Viewer";
		if (!m_refreshingClear && m_compName != "") {
			title += "\\$666 - " + m_compName;
		}

		UI::SetNextWindowSize(800, 370);
		if (UI::Begin(title + "###TMGL Match Viewer", Setting_Visible)) {
			if (m_refreshingClear) {
				RenderWaiting();
			} else {
				RenderContents();
			}
		}
		UI::End();
	}

	void RenderWaiting()
	{
		UI::Text("Loading data, please wait..");
	}

	void RenderContents()
	{
		// Header
		UI::PushFont(g_fontHeader26);

		UI::Text(m_roundName.ToUpper());
		UI::SameLine();

		vec2 cursorPos = UI::GetCursorPos();
		float spaceLeft = UI::GetContentRegionAvail().x;
		vec2 textSize = Draw::MeasureString(m_mapName, g_fontHeader26);

		UI::SetCursorPos(cursorPos + vec2(spaceLeft - textSize.x, 0));
		UI::Text(m_mapName);
		//TODO: Button to open Trackmania.io

		UI::PopFont();
		UI::Separator();

		// Matches
		if (UI::BeginChild("Matches", vec2(0, -40), true)) {
			if (m_matches.Length > 0) {
				UI::Columns(m_matches.Length, "Matches");
				for (uint i = 0; i < m_matches.Length; i++) {
					auto group = m_matches[i];
					UI::PushID(group);
					group.Render();
					UI::PopID();
					UI::NextColumn();
				}
				UI::Columns(1);
			}
			UI::EndChild();
		}

		UI::Separator();

		// Main streams
		UI::AlignTextToFramePadding();
		UI::Text("Main streams:");
		UI::SameLine();
		for (uint i = 0; i < m_mainStreams.Length; i++) {
			if (i > 0) {
				UI::SameLine();
			}
			m_mainStreams[i].Render(false);
		}

		// Refresh indicator
		if (m_refreshing) {
			UI::SameLine();
			UI::SetCursorPos(UI::GetCursorPos() + vec2(UI::GetContentRegionAvail().x - 20, 0));
			UI::Text("\\$e61" + Icons::HourglassO);
		}
	}
}

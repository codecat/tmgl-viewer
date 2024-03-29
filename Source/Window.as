class Window
{
	string m_error;

	uint64 m_lastFullReload = 0;

	bool m_refreshing = false;
	int m_refreshTime = 10;
	bool m_reloadData = true;

	string m_compName;
	bool m_compFinished = false;
	bool m_roundFinished = false;
	int m_roundIndex = -1;

	string m_roundName;

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

	void SendNotify(const string &in text)
	{
		UI::ShowNotification(
			"\\$s" + Icons::Trophy + " TMGL Match Viewer",
			"\\$s" + text,
			vec4(0xE0/255.0f*0.75f, 0x60/255.0f*0.75f, 0x10/255.0f*0.75f, 1.0f)
		);
	}

	void Clear()
	{
		m_error = "";

		m_compName = "";
		m_compFinished = false;
		m_roundFinished = false;
		m_roundIndex = -1;

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

	void HandleApiDataEvent(APIDataEvent@ ev)
	{
		auto evMatchStatusChange = cast<MatchStatusChangeEvent>(ev);
		if (evMatchStatusChange !is null) {
			print("Event: Match status changed: " + evMatchStatusChange.m_match.m_name + " to " + evMatchStatusChange.m_newStatus);
			if (Setting_Sounds) {
				Audio::Play(g_soundMatch);
			}
			if (evMatchStatusChange.m_newStatus == "COMPLETED") {
				SendNotify("Match completed! " + evMatchStatusChange.m_match.m_name);
			} else {
				SendNotify("Match status changed: " + evMatchStatusChange.m_match.m_name + ": " + evMatchStatusChange.m_newStatus);
			}
			return;
		}
	}

	void UpdateFromApiData()
	{
		if (!g_apiData.m_success) {
			m_error = g_apiData.m_error;
			return;
		} else {
			m_error = "";
		}

		for (uint i = 0; i < g_apiData.m_events.Length; i++) {
			HandleApiDataEvent(g_apiData.m_events[i]);
		}

		m_compName = g_apiData.m_competition.m_name;
		m_compFinished = g_apiData.m_compFinished;
		m_roundFinished = (g_apiData.m_currentRound.m_status == "COMPLETED");
		m_roundIndex = g_apiData.m_currentRoundIndex;

		m_roundName = g_apiData.m_currentRound.m_name;

		m_mapUid = g_apiData.m_matchesMapUid;
		m_mapName = g_apiData.m_matchesMapName;

		m_mainStreams.RemoveRange(0, m_mainStreams.Length);
		for (uint i = 0; i < Data::Streamer::Global.Length; i++) {
			auto streamer = Data::Streamer::Global[i];
			m_mainStreams.InsertLast(Streamer(streamer.m_name, streamer.m_link));
		}

		for (uint i = 0; i < g_apiData.m_matches.Length; i++) {
			auto apiMatch = g_apiData.m_matches[i];
			auto match = GetMatchFromID(apiMatch.m_id);
			auto rankings = g_apiData.m_matchesRankings[i];

			if (match is null) {
				if (m_matches.Length >= 4) {
					warn("Unexpected new match ID " + apiMatch.m_id + " when there are already " + m_matches.Length + "! This is really bad! Clearing the matches list even though this shouldn't happen..");
					//HACK: Figure out why this happens!
					m_matches.RemoveRange(0, m_matches.Length);
				}

				@match = Match(apiMatch.m_id, m_matches.Length + 1);
				m_matches.InsertLast(match);
			}

			match.m_joinLink = apiMatch.m_joinLink;
			match.m_status = MatchStatusFromString(apiMatch.m_status);

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
			match.m_players.SortDesc();

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
	}

	void LoopAsync()
	{
		// Wait until the window is visible
		while (!Setting_Visible) {
			yield();
		}

		m_refreshTime = 0;

		while (true) {
			if (m_reloadData) {
				m_reloadData = false;
				m_lastFullReload = Time::Now;

				Data::LoadAsync();

				g_apiData.Clear();
				Clear();
				Refresh();

				m_refreshing = false;
			}

			if (m_refreshTime > 0) {
				m_refreshTime--;
			}

			if (Setting_Visible && !m_compFinished && m_refreshTime <= 0 && Data::Competition::Active) {
				if (Setting_Verbose) {
					trace("Refreshing data..");
				}

				m_refreshing = true;

				g_apiData.RefreshAsync();
				UpdateFromApiData();

				m_refreshing = false;

				m_refreshTime = Setting_RefreshTime;
			}

			sleep(1000);
		}
	}

	void PrevRoundAsync()
	{
		m_refreshing = true;

		m_matches.RemoveRange(0, m_matches.Length);

		g_apiData.PrevRoundAsync();
		UpdateFromApiData();

		m_refreshing = false;
	}

	void NextRoundAsync()
	{
		m_refreshing = true;

		m_matches.RemoveRange(0, m_matches.Length);

		g_apiData.NextRoundAsync();
		UpdateFromApiData();

		m_refreshing = false;
	}

	void Refresh()
	{
		m_refreshTime = 0;
	}

	void ReloadData()
	{
		m_lastFullReload = Time::Now;
		m_reloadData = true;
		m_refreshing = true;
	}

	void Render()
	{
		if (!Setting_Visible) {
			return;
		}

		string title = "\\$e61" + Icons::Trophy + "\\$z TMGL Match Viewer";
		if (m_compName != "") {
			title += "\\$666 - " + m_compName;
		}

		UI::SetNextWindowSize(800, 370);
		if (UI::Begin(title + "###TMGL Match Viewer", Setting_Visible, UI::WindowFlags::NoCollapse | UI::WindowFlags::MenuBar)) {
			if (UI::BeginMenuBar()) {
				if (UI::BeginMenu(Icons::User + " Controls")) {
					if (UI::MenuItem(Icons::Refresh + " Refresh all", "", false, !m_refreshing)) {
						ReloadData();
					}

					if (UI::MenuItem(Icons::Refresh + " Refresh", "", false, !m_refreshing)) {
						Refresh();
					}

					UI::Separator();

					if (UI::MenuItem(Icons::ArrowLeft + " Last round", "", false, Data::Competition::Active && m_roundIndex > 0)) {
						startnew(CoroutineFunc(this.PrevRoundAsync));
					}

					if (UI::MenuItem(Icons::ArrowRight + " Next round", "", false, Data::Competition::Active && m_roundFinished && !m_compFinished)) {
						startnew(CoroutineFunc(this.NextRoundAsync));
					}

					UI::EndMenu();
				}
				UI::EndMenuBar();
			}

			if (m_error != "") {
				UI::Text("\\$f66" + Icons::TimesCircle + " \\$faa" + m_error);
			}

			if (!m_refreshing && !Data::Competition::Active) {
				RenderInactive();
			} else if (m_compName == "") {
				RenderWaiting();
			} else {
				RenderContents();
			}
		}
		UI::End();
	}

	void RenderInactive()
	{
		UI::Text("There is currently no active competition.");

		if (Data::Competition::Notice != "") {
			UI::Separator();
			UI::TextWrapped(Data::Competition::Notice);
		}

		if (Time::Now - m_lastFullReload > 2000 && UI::Button(Icons::Refresh + " Refresh")) {
			ReloadData();
		}
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

		UI::PopFont();

		if (m_refreshing) {
			UI::BeginDisabled();
		}

		if (m_roundFinished && !m_compFinished) {
			if (UI::GreenButton("Next round " + Icons::ArrowRight)) {
				startnew(CoroutineFunc(this.NextRoundAsync));
			}
			UI::SameLine();
		}

		if (m_refreshing) {
			UI::EndDisabled();
		}

		UI::PushFont(g_fontHeader26);

		string mapName = m_mapName.ToUpper();

		vec2 cursorPos = UI::GetCursorPos();
		float spaceLeft = UI::GetContentRegionAvail().x;
		vec2 textSize = Draw::MeasureString(mapName, g_fontHeader26);

		UI::SetCursorPos(cursorPos + vec2(spaceLeft - textSize.x, 0));
		UI::Text(mapName);
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

		if (m_refreshing) {
			// Refresh indicator
			UI::SameLine();
			UI::SetCursorPos(UI::GetCursorPos() + vec2(UI::GetContentRegionAvail().x - 20, 0));
			UI::Text("\\$e61" + Icons::HourglassO);

		} else if (m_compFinished) {
			// Competition finished indicator
			UI::SameLine();
			UI::SetCursorPos(UI::GetCursorPos() + vec2(UI::GetContentRegionAvail().x - 20, 0));
			UI::Text("\\$6f6" + Icons::CheckCircle);
		}
	}
}

class Window
{
	bool m_refreshingClear = true;
	bool m_refreshing = false;
	int m_refreshTime = 10;

	string m_compName;

	array<Group@> m_groups;
	array<Streamer@> m_mainStreams;

	string m_roundName;
	string m_mapUid;
	string m_mapName;

	/*
	void LoadFakeInfo()
	{
		m_compName = "TMGL Show";

		for (int i = 0; i < 4; i++) {
			m_groups.InsertLast(Group(i + 1));
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

		m_groups.RemoveRange(0, m_groups.Length);
		m_mainStreams.RemoveRange(0, m_mainStreams.Length);

		m_roundName = "";
		m_mapUid = "";
		m_mapName = "";
	}

	void UpdateFromApiData(const APIData &in data)
	{
		m_compName = data.m_competition.m_name;

		//

		m_roundName = data.m_currentRound.m_name.ToUpper();
		m_mapUid = data.m_matchesMapUid;
		m_mapName = data.m_matchesMapName;
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

		UI::Text(m_roundName);
		UI::SameLine();

		vec2 cursorPos = UI::GetCursorPos();
		float spaceLeft = UI::GetContentRegionAvail().x;
		vec2 textSize = Draw::MeasureString(m_mapName, g_fontHeader26);

		UI::SetCursorPos(cursorPos + vec2(spaceLeft - textSize.x, 0));
		UI::Text(m_mapName);
		//TODO: Button to open Trackmania.io

		UI::PopFont();
		UI::Separator();

		// Groups
		if (UI::BeginChild("Groups", vec2(0, -40), true)) {
			if (m_groups.Length > 0) {
				UI::Columns(m_groups.Length, "Groups");
				for (uint i = 0; i < m_groups.Length; i++) {
					auto group = m_groups[i];
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

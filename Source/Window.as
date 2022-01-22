class Window
{
	WindowData m_data;

	bool m_refreshingClear = true;
	bool m_refreshing = false;
	int m_refreshTime = 10;

	void LoopAsync()
	{
		// Wait until the window is visible
		while (!Setting_Visible) {
			yield();
		}

		m_refreshing = true;
		m_refreshingClear = true;

		m_data.RefreshAllAsync();

		m_refreshing = false;
		m_refreshingClear = false;

		while (true) {
			sleep(1000);

			if (Setting_Visible && --m_refreshTime == 0) {
				trace("Refreshing data..");

				m_refreshing = true;

				m_data.RefreshAsync();

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
		if (!m_refreshingClear && m_data.m_compName != "") {
			title += "\\$666 - " + m_data.m_compName;
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

		UI::Text(m_data.m_roundName);
		UI::SameLine();

		vec2 cursorPos = UI::GetCursorPos();
		float spaceLeft = UI::GetContentRegionAvail().x;
		vec2 textSize = Draw::MeasureString(m_data.m_mapName, g_fontHeader26);

		UI::SetCursorPos(cursorPos + vec2(spaceLeft - textSize.x, 0));
		UI::Text(m_data.m_mapName);
		//TODO: Button to open Trackmania.io

		UI::PopFont();
		UI::Separator();

		// Groups
		if (UI::BeginChild("Groups", vec2(0, -40), true)) {
			if (m_data.m_groups.Length > 0) {
				UI::Columns(m_data.m_groups.Length, "Groups");
				for (uint i = 0; i < m_data.m_groups.Length; i++) {
					auto group = m_data.m_groups[i];
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
		for (uint i = 0; i < m_data.m_mainStreams.Length; i++) {
			if (i > 0) {
				UI::SameLine();
			}
			m_data.m_mainStreams[i].Render(false);
		}

		// Refresh indicator
		if (m_refreshing) {
			UI::SameLine();
			UI::SetCursorPos(UI::GetCursorPos() + vec2(UI::GetContentRegionAvail().x - 20, 0));
			UI::Text("\\$e61" + Icons::HourglassO);
		}
	}
}

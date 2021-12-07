class Window
{
	bool m_visible = true;

	array<Group@> m_groups;
	array<Streamer@> m_mainStreams;

	Window()
	{
		for (int i = 0; i < 4; i++) {
			m_groups.InsertLast(Group(i + 1));
		}

		m_mainStreams.InsertLast(Streamer("Trackmania", "https://twitch.tv/trackmania"));
		m_mainStreams.InsertLast(Streamer("Wirtual", "https://twitch.tv/wirtual"));
	}

	void Render()
	{
		if (!m_visible) {
			return;
		}

		UI::SetNextWindowSize(800, 370);
		if (UI::Begin("\\$e61" + Icons::Trophy + "\\$z TMGL Match Viewer", m_visible)) {
			// Header
			UI::PushFont(g_fontHeader26);
			UI::Text("STEP 1 - ROUND 1");
			UI::PopFont();

			UI::Separator();

			if (UI::BeginChild("Groups", vec2(0, -40), true)) {
				// Groups
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
		}
		UI::End();
	}

	void LoopAsync()
	{
		//TODO
		while (true) {
			yield();
		}
	}
}

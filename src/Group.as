enum GroupStatus
{
	Unknown,
	Warmup,
	Live,
	Completed,
}

class Group
{
	int m_num;

	GroupStatus m_status = GroupStatus::Unknown;
	array<GroupPlayer@> m_players;
	array<Streamer@> m_streamers;

	Group(int num)
	{
		m_num = num;

		//NOTE: Testing data
		switch (m_num) {
			case 1:
				m_status = GroupStatus::Live;
				m_players.InsertLast(GroupPlayer("Alpha", "T"));
				m_players.InsertLast(GroupPlayer("Beta", "GW"));
				m_players.InsertLast(GroupPlayer("Charlie", "XD"));
				m_players.InsertLast(GroupPlayer("Delta", "DG"));
				m_streamers.InsertLast(Streamer("LuckersTurbo", "https://twitch.tv/luckersturbo"));
				m_streamers.InsertLast(Streamer("Jnic", "https://twitch.tv/jnic"));
				break;

			case 2:
				m_status = GroupStatus::Warmup;
				m_players.InsertLast(GroupPlayer("Echo", "AAA"));
				m_players.InsertLast(GroupPlayer("Foxtrot", "BBB"));
				m_players.InsertLast(GroupPlayer("Golf", "CCC"));
				m_players.InsertLast(GroupPlayer("Hotel", "ATTAX"));
				m_streamers.InsertLast(Streamer("Kitboga", "https://twitch.tv/kitboga"));
				break;

			case 3:
				m_status = GroupStatus::Completed;
				m_players.InsertLast(GroupPlayer("India", "T1"));
				m_players.InsertLast(GroupPlayer("Juliette", "GW"));
				m_players.InsertLast(GroupPlayer("Kilo", "XD"));
				m_players.InsertLast(GroupPlayer("Lima", "DG"));
				m_streamers.InsertLast(Streamer("Lirik", "https://twitch.tv/lirik"));
				break;

			case 4:
				m_status = GroupStatus::Live;
				m_players.InsertLast(GroupPlayer("November", "T1"));
				m_players.InsertLast(GroupPlayer("Oscar", "GW"));
				m_players.InsertLast(GroupPlayer("Papa", "XD"));
				m_players.InsertLast(GroupPlayer("Quebec", "DG"));
				m_streamers.InsertLast(Streamer("Missterious", "https://twitch.tv/missterious"));
				break;
		}

		//NOTE: More testing data
		for (uint i = 0; i < m_players.Length; i++) {
			if (m_status != GroupStatus::Warmup) {
				m_players[i].m_score = Math::Rand(0, 3);
			}
		}
		if (m_status == GroupStatus::Completed) {
			int winningPlayer = Math::Rand(0, m_players.Length);
			m_players[winningPlayer].m_score = 3;
		}
		m_players.SortDesc();
	}

	void Render()
	{
		float columnWidth = UI::GetContentRegionAvail().x;

		// Header text
		string headerText = "GROUP " + m_num;
		switch (m_status) {
			case GroupStatus::Warmup: headerText = "\\$e82" + Icons::CircleO + "\\$z " + headerText; break;
			case GroupStatus::Live: headerText = "\\$e22" + Icons::Circle + "\\$z " + headerText; break;
			case GroupStatus::Completed: headerText = "\\$6f6" + Icons::CheckCircle + "\\$z " + headerText; break;
		}
		UI::PushFont(g_fontHeader20);
		UI::Text(headerText);
		UI::PopFont();

		// Players
		for (uint i = 0; i < m_players.Length; i++) {
			m_players[i].Render(i + 1, m_status == GroupStatus::Completed);
		}

		// Join button
		if (UI::Button(Icons::PlayCircleO + " Join server", vec2(columnWidth, 0))) {
			print(m_num);
		}

		// Stream button
		for (uint i = 0; i < m_streamers.Length; i++) {
			m_streamers[i].Render(true);
		}
	}
}

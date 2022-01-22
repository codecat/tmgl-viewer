enum MatchStatus
{
	Unknown,
	Warmup,
	Live,
	Completed,
}

class Match
{
	int m_id;
	int m_num;

	string m_joinLink;

	MatchStatus m_status = MatchStatus::Unknown;
	array<MatchPlayer@> m_players;
	array<Streamer@> m_streamers;

	Match(int id, int num)
	{
		m_id = id;
		m_num = num;
	}

	void Render()
	{
		float columnWidth = UI::GetContentRegionAvail().x;

		// Header text
		string headerText = "GROUP " + m_num;
		switch (m_status) {
			case MatchStatus::Warmup: headerText = "\\$e82" + Icons::CircleO + "\\$z " + headerText; break;
			case MatchStatus::Live: headerText = "\\$e22" + Icons::Circle + "\\$z " + headerText; break;
			case MatchStatus::Completed: headerText = "\\$6f6" + Icons::CheckCircle + "\\$z " + headerText; break;
		}
		UI::PushFont(g_fontHeader20);
		UI::Text(headerText);
		UI::PopFont();

		// Players
		for (uint i = 0; i < m_players.Length; i++) {
			m_players[i].Render(i + 1, m_status == MatchStatus::Completed);
		}

		// Join button
		if (g_canJoinServers && m_joinLink != "") {
			if (UI::Button(Icons::PlayCircleO + " Join server", vec2(columnWidth, 0))) {
				auto app = cast<CGameManiaPlanet>(GetApp());
				app.ManiaPlanetScriptAPI.OpenLink(m_joinLink, CGameManiaPlanetScriptAPI::ELinkType::ManialinkBrowser);
			}
		}

		// Stream button
		for (uint i = 0; i < m_streamers.Length; i++) {
			m_streamers[i].Render(true);
		}
	}
}

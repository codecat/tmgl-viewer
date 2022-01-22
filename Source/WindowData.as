class WindowData
{
	string m_compName;
	int m_compId;

	array<Group@> m_groups;
	array<Streamer@> m_mainStreams;

	string m_roundName; //
	string m_mapUid;
	string m_mapName;

	void Fake()
	{
		/*
		m_compName = "TMGL Show";

		for (int i = 0; i < 4; i++) {
			m_groups.InsertLast(Group(i + 1));
		}

		m_mainStreams.InsertLast(Streamer("Trackmania", "https://twitch.tv/trackmania"));
		m_mainStreams.InsertLast(Streamer("Wirtual", "https://twitch.tv/wirtual"));

		m_roundName = "STEP 1 - ROUND 1";
		m_mapName = "POLEPARTY";
		*/
	}

	void Clear()
	{
		m_compName = "";

		m_groups.RemoveRange(0, m_groups.Length);
		m_mainStreams.RemoveRange(0, m_mainStreams.Length);

		m_roundName = "";
		m_mapUid = "";
		m_mapName = "";
	}

	void RefreshAllAsync()
	{
		Clear();

		auto comp = g_api.GetCompetitionAsync(Setting_CompetitionId);

		if (comp !is null) {
			m_compName = comp.m_name;
			m_compId = comp.m_id;
		}

		RefreshAsync();
	}

	void RefreshAsync()
	{
		API::CompetitionRound@ currentRound = null;

		auto rounds = g_api.GetCompetitionRoundsAsync(m_compId);
		for (uint i = 0; i < rounds.Length; i++) {
			auto round = rounds[i];
			if (round.m_status != "COMPLETED") {
				@currentRound = round;
				break;
			}
		}

		if (currentRound !is null) {
			m_roundName = currentRound.m_name.ToUpper();
		}
	}
}

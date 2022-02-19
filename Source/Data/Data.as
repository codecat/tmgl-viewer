namespace Data
{
	bool CanJoinServers = false;

	void LoadAsync()
	{
		trace("Loading data..");

		Competition::LoadAsync();
		Player::LoadAsync();
		Streamer::LoadAsync();

		if (Player::FromID(g_currentAccountId) !is null) {
			warn("Current user is a TMGL player.");
			CanJoinServers = true;
		}

		auto streamerPlayer = Player::FromStreamerID(g_currentAccountId);
		if (streamerPlayer !is null) {
			warn("Current user is a streamer for " + streamerPlayer.m_nickname + ".");
			CanJoinServers = true;
		}

		auto streamerGlobal = Streamer::GlobalFromPlayerID(g_currentAccountId);
		if (streamerGlobal !is null) {
			warn("Current user is a global streamer.");
			CanJoinServers = true;
		}

		trace("Data loaded!");
	}
}

namespace Data
{
	class Player
	{
		string m_id;

		string m_nickname;
		string m_team;
		string m_teamColor;
		string m_teamTrigram;

		string m_streamerId;

		Player(const string &in id, const Json::Value &in js)
		{
			m_id = id;

			m_nickname = js["Nickname"];
			m_team = js["Team"];
			m_teamColor = js["TeamColor"];
			m_teamTrigram = js["TeamTrigram"];

			m_streamerId = js["StreamerId"];
		}
	}

	namespace Player
	{
		dictionary g_items;

		void Load()
		{
			g_items.DeleteAll();

			auto jsPlayers = Json::FromFile("Data/Players.json");
			auto playerIds = jsPlayers.GetKeys();

			for (uint i = 0; i < playerIds.Length; i++) {
				string playerId = playerIds[i];
				g_items.Set(playerId, @Player(playerId, jsPlayers[playerId]));
			}
		}

		Player@ FromID(const string &in id)
		{
			Player@ ret;
			if (g_items.Get(id, @ret)) {
				return ret;
			}
			return null;
		}

		Player@ FromStreamerID(const string &in id)
		{
			auto keys = g_items.GetKeys();
			for (uint i = 0; i < keys.Length; i++) {
				auto player = cast<Player>(g_items[keys[i]]);
				if (player.m_streamerId == id) {
					return player;
				}
			}
			return null;
		}
	}
}

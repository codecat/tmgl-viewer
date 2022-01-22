namespace Data
{
	class Streamer
	{
		string m_name;
		string m_link;
		string m_language;

		Streamer(const Json::Value &in js)
		{
			m_name = js["name"];
			m_link = js["link"];
			m_language = js["language"];
		}
	}

	namespace Streamer
	{
		Streamer@[] Global;

		dictionary g_items;

		Streamer@ FromPlayerID(const string &in id)
		{
			Streamer@ ret;
			if (g_items.Get(id, @ret)) {
				return ret;
			}
			return null;
		}

		void Load()
		{
			Global.RemoveRange(0, Global.Length);
			g_items.DeleteAll();

			auto jsStreamers = Json::FromFile("Data/Streamers.json");

			auto jsGlobal = jsStreamers["global"];
			for (uint i = 0; i < jsGlobal.Length; i++) {
				auto jsStreamer = jsGlobal[i];
				Global.InsertLast(Streamer(jsStreamer));
			}

			auto jsPlayers = jsStreamers["players"];
			auto playerIds = jsPlayers.GetKeys();
			for (uint i = 0; i < playerIds.Length; i++) {
				string playerId = playerIds[i];
				g_items.Set(playerId, @Streamer(jsPlayers[playerId]));
			}
		}
	}
}

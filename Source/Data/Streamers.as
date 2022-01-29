namespace Data
{
	class Streamer
	{
		string m_name;
		string m_link;
		string m_language;
		string m_id;

		Streamer(const Json::Value &in js)
		{
			m_name = js["name"];
			m_link = js["link"];
			m_language = js["language"];

			if (js.HasKey("id")) {
				m_id = js["id"];
			}
		}
	}

	namespace Streamer
	{
		Streamer@[] Global;

		dictionary g_items;

		Streamer@ GlobalFromPlayerID(const string &in id)
		{
			for (uint i = 0; i < Global.Length; i++) {
				auto streamer = Global[i];
				if (streamer.m_id == id) {
					return streamer;
				}
			}
			return null;
		}

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

			//TODO: New Json::FromFile is only available in unreleased Openplanet update
			auto fileStreamers = IO::FileSource("Data/Streamers.json");
			auto jsStreamers = Json::Parse(fileStreamers.ReadToEnd());
			//auto jsStreamers = Json::FromFile("Data/Streamers.json");

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

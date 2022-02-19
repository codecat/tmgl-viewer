namespace Data
{
	namespace Competition
	{
		bool Active = false;
		int ID = 0;
		string Notice = "";

		void LoadAsync()
		{
			auto req = Net::HttpGet("https://openplanet.dev/plugin/tmglviewer/config/competition");
			while (!req.Finished()) {
				yield();
			}
			//TODO: Error checking
			auto jsCompetition = Json::Parse(req.String());

			if (jsCompetition.HasKey("active")) {
				Active = jsCompetition["active"];
			} else {
				Active = false;
			}

			if (!Active) {
				warn("Competition is not active.");
			}

			if (jsCompetition.HasKey("id")) {
				ID = jsCompetition["id"];
			} else {
				ID = 0;
			}

			if (jsCompetition.HasKey("notice")) {
				Notice = jsCompetition["notice"];
			} else {
				Notice = "";
			}
		}
	}
}

namespace API
{
	class Match
	{
		int m_id;
		string m_liveId;
		string m_name;

		int64 m_startDate;
		int64 m_endDate;

		string m_joinLink;
		string m_serverStatus;
		string m_status;

		Match(const Json::Value &in js)
		{
			m_id = js["id"];
			m_liveId = js["live_id"];
			m_name = js["name"];

			m_startDate = int64(double(js["start_date"]));
			m_endDate = int64(double(js["end_date"]));

			m_joinLink = js["join_link"];

			auto jsServerStatus = js["server_status"];
			if (jsServerStatus.GetType() == Json::Type::String) {
				m_serverStatus = jsServerStatus;
			}

			auto jsStatus = js["status"];
			if (jsStatus.GetType() == Json::Type::String) {
				m_status = jsStatus;
			}
		}
	}
}

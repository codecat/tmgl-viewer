namespace API
{
	class CompetitionRound
	{
		int m_id;
		string m_name;
		int64 m_startDate;
		int64 m_endDate;
		string m_status;
		int m_matchCount;

		CompetitionRound(const Json::Value &in js)
		{
			m_id = js["id"];
			m_name = js["name"];
			m_startDate = int64(double(js["start_date"]));
			m_endDate = int64(double(js["end_date"]));

			auto jsStatus = js["status"];
			if (jsStatus.GetType() == Json::Type::String) {
				m_status = jsStatus;
			}

			m_matchCount = js["nb_matches"];
		}
	}
}

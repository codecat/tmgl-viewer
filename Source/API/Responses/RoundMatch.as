namespace API
{
	class RoundMatch
	{
		int m_id;
		string m_name;
		string m_liveId;
		bool m_completed;

		RoundMatch(const Json::Value &in js)
		{
			m_id = js["id"];
			m_name = js["name"];
			m_liveId = js["clubMatchLiveId"];
			m_completed = js["isCompleted"];
		}
	}
}

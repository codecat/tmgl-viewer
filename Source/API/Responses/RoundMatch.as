namespace API
{
	class RoundMatch
	{
		int m_id;
		string m_name;
		bool m_completed;

		RoundMatch(const Json::Value &in js)
		{
			m_id = js["id"];
			m_name = js["name"];
			m_completed = js["is_completed"];
		}
	}
}

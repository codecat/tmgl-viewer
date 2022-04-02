namespace API
{
	class Competition
	{
		int m_id;
		string m_liveId;
		string m_name;

		Competition(const Json::Value &in js)
		{
			m_id = js["id"];
			m_liveId = js["liveId"];
			m_name = js["name"];
		}
	}
}

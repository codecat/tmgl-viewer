namespace API
{
	class MatchParticipant
	{
		string m_id;

		MatchParticipant(const Json::Value &in js)
		{
			m_id = js["id"];
		}
	}
}

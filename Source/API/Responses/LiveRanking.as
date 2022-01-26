namespace API
{
	class LiveRankingParticipant
	{
		string m_accountId;
		int m_score;

		LiveRankingParticipant(const Json::Value &in js)
		{
			m_accountId = js["account_id"];
			m_score = js["score"];
		}
	}

	class LiveRanking
	{
		LiveRankingParticipant@[] m_participants;

		LiveRanking(const Json::Value &in js)
		{
			auto jsParticipants = js["participants"];
			for (uint i = 0; i < jsParticipants.Length; i++) {
				auto jsParticipant = jsParticipants[i];
				m_participants.InsertLast(LiveRankingParticipant(jsParticipant));
			}
		}

		LiveRankingParticipant@ GetParticipant(const string &in id)
		{
			for (uint i = 0; i < m_participants.Length; i++) {
				auto participant = m_participants[i];
				if (participant.m_accountId == id) {
					return participant;
				}
			}
			return null;
		}
	}
}

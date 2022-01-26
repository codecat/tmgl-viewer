class APIDataEvent
{
}

class CompFinishEvent : APIDataEvent
{
}

class NewRoundEvent : APIDataEvent
{
	API::CompetitionRound@ m_oldRound;
	API::CompetitionRound@ m_newRound;

	NewRoundEvent(API::CompetitionRound@ oldRound, API::CompetitionRound@ newRound)
	{
		@m_oldRound = oldRound;
		@m_newRound = newRound;
	}
}

class MatchStatusChangeEvent : APIDataEvent
{
}

class ScoreChangeEvent : APIDataEvent
{
	API::Match@ m_match;
	API::LiveRanking@ m_liveRanking;
	API::LiveRankingParticipant@ m_participant;

	ScoreChangeEvent(API::Match@ match, API::LiveRanking@ liveRanking, API::LiveRankingParticipant@ participant)
	{
		@m_match = match;
		@m_liveRanking = liveRanking;
		@m_participant = participant;
	}
}

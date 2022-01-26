interface IAPI
{
	API::Competition@ GetCompetitionAsync(int compId);
	API::CompetitionRound@[] GetCompetitionRoundsAsync(int compId);
	API::RoundMatch@[] GetRoundMatchesAsync(int roundId);
	API::Match@ GetMatchAsync(const string &in matchLid);
	API::MatchParticipant@[] GetMatchParticipants(int matchId);
	API::LiveRanking@ GetMatchLiveRanking(int matchId);
}

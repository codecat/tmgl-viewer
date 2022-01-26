class ProdAPI : IAPI
{
	string m_base = "https://competition.trackmania.nadeo.club/";

	ProdAPI()
	{
		NadeoServices::AddAudience("NadeoClubServices");
	}

	private void DumpToDisk(const string &in path, const string &in data)
	{
		string filePath = IO::FromDataFolder("TMGLResponses");
		if (!IO::FolderExists(filePath)) {
			IO::CreateFolder(filePath);
		}

		filePath += path.Replace("/", "_");
		if (!IO::FolderExists(filePath)) {
			IO::CreateFolder(filePath);
		}

		filePath += "/" + Time::Stamp + ".json";

		IO::File f(filePath, IO::FileMode::Write);
		f.Write(data);
	}

	private Json::Value GetJsonAsync(const string &in path, Json::Type expectedType)
	{
		auto req = NadeoServices::Get("NadeoClubServices", m_base + path);
		req.Start();
		while (!req.Finished()) {
			yield();
		}

		string str = req.String();

		if (Setting_DumpResponses) {
			DumpToDisk(path, str);
		}

		auto ret = Json::Parse(str);

		if (ret.GetType() == Json::Type::Object && ret.HasKey("exception")) {
			auto jsException = ret["exception"];
			if (jsException.GetType() == Json::Type::Boolean && bool(jsException)) {
				throw("Exception from server in request to \"" + path + "\": " + str);
			}
		}

		if (ret.GetType() != expectedType) {
			throw("Was expecting json type " + tostring(expectedType) + " but got " + tostring(ret.GetType()) + " in request to \"" + path + "\"");
		}

		return ret;
	}

	API::Competition@ GetCompetitionAsync(int compId)
	{
		return API::Competition(GetJsonAsync("api/competitions/" + compId, Json::Type::Object));
	}

	API::CompetitionRound@[] GetCompetitionRoundsAsync(int compId)
	{
		auto js = GetJsonAsync("api/competitions/" + compId + "/rounds", Json::Type::Array);

		API::CompetitionRound@[] ret;
		for (uint i = 0; i < js.Length; i++) {
			ret.InsertLast(API::CompetitionRound(js[i]));
		}
		return ret;
	}

	API::RoundMatch@[] GetRoundMatchesAsync(int roundId)
	{
		auto js = GetJsonAsync("api/rounds/" + roundId + "/matches", Json::Type::Object);

		API::RoundMatch@[] ret;
		auto jsMatches = js["matches"];
		for (uint i = 0; i < jsMatches.Length; i++) {
			ret.InsertLast(API::RoundMatch(jsMatches[i]));
		}
		return ret;
	}

	API::Match@ GetMatchAsync(int matchId)
	{
		return API::Match(GetJsonAsync("api/matches/" + matchId, Json::Type::Object));
	}

	API::MatchParticipant@[] GetMatchParticipants(int matchId)
	{
		auto js = GetJsonAsync("api/matches/" + matchId + "/participants", Json::Type::Array);

		API::MatchParticipant@[] ret;
		for (uint i = 0; i < js.Length; i++) {
			ret.InsertLast(API::MatchParticipant(js[i]));
		}
		return ret;
	}

	API::LiveRanking@ GetMatchLiveRanking(int matchId)
	{
		return API::LiveRanking(GetJsonAsync("api/matches/" + matchId + "/live-ranking", Json::Type::Object));
	}
}

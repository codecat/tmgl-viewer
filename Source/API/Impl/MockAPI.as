const int MOCK_API_SLEEP_TIME = 50;

class MockAPI : IAPI
{
	API::Competition@ GetCompetitionAsync(int compId)
	{
		if (compId != 1896) {
			error("Unexpected mock competition ID: " + compId);
			return null;
		}

		trace("GetCompetitionAsync");

		sleep(MOCK_API_SLEEP_TIME);

		return API::Competition(Json::Parse("""{
	"id": 1896,
	"live_id": "LID-COMP-3kf51ym0sumijwx",
	"creator": "f85883d3-263f-4c2b-9705-027368d098f1",
	"name": "TMGL Show match",
	"participant_type": "PLAYER",
	"description": null,
	"registration_start": null,
	"registration_end": null,
	"start_date": 1642668027,
	"end_date": 1642677747,
	"matches_generation_date": null,
	"nb_players": 16,
	"spot_structure": "{\"version\":1,\"rounds\":[{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"competition_participant\",\"seed\":1},{\"spot_type\":\"competition_participant\",\"seed\":5},{\"spot_type\":\"competition_participant\",\"seed\":9},{\"spot_type\":\"competition_participant\",\"seed\":13}]},{\"spots\":[{\"spot_type\":\"competition_participant\",\"seed\":2},{\"spot_type\":\"competition_participant\",\"seed\":6},{\"spot_type\":\"competition_participant\",\"seed\":10},{\"spot_type\":\"competition_participant\",\"seed\":14}]},{\"spots\":[{\"spot_type\":\"competition_participant\",\"seed\":3},{\"spot_type\":\"competition_participant\",\"seed\":7},{\"spot_type\":\"competition_participant\",\"seed\":11},{\"spot_type\":\"competition_participant\",\"seed\":15}]},{\"spots\":[{\"spot_type\":\"competition_participant\",\"seed\":4},{\"spot_type\":\"competition_participant\",\"seed\":8},{\"spot_type\":\"competition_participant\",\"seed\":12},{\"spot_type\":\"competition_participant\",\"seed\":16}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":0,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":3,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":1,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":2,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":1,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":2,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":0,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":3,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":0,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":3,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":1,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":2,\"rank\":4}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":1,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":2,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":0,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":0,\"match_position\":3,\"rank\":4}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":0,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":0,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":1,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":1,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":0,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":0,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":1,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":1,\"rank\":4}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":2,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":2,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":3,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":3,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":2,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":2,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":3,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":1,\"match_position\":3,\"rank\":4}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":0,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":0,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":1,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":1,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":0,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":0,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":2,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":2,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":1,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":1,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":3,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":3,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":2,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":2,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":3,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":2,\"match_position\":3,\"rank\":4}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":0,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":0,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":1,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":1,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":0,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":0,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":2,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":2,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":1,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":1,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":3,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":3,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":2,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":2,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":3,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":3,\"match_position\":3,\"rank\":4}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"competition_participant\",\"seed\":1},{\"spot_type\":\"competition_participant\",\"seed\":6},{\"spot_type\":\"competition_participant\",\"seed\":11},{\"spot_type\":\"competition_participant\",\"seed\":16}]},{\"spots\":[{\"spot_type\":\"competition_participant\",\"seed\":2},{\"spot_type\":\"competition_participant\",\"seed\":5},{\"spot_type\":\"competition_participant\",\"seed\":12},{\"spot_type\":\"competition_participant\",\"seed\":15}]},{\"spots\":[{\"spot_type\":\"competition_participant\",\"seed\":3},{\"spot_type\":\"competition_participant\",\"seed\":8},{\"spot_type\":\"competition_participant\",\"seed\":9},{\"spot_type\":\"competition_participant\",\"seed\":14}]},{\"spots\":[{\"spot_type\":\"competition_participant\",\"seed\":4},{\"spot_type\":\"competition_participant\",\"seed\":7},{\"spot_type\":\"competition_participant\",\"seed\":10},{\"spot_type\":\"competition_participant\",\"seed\":13}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":0,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":3,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":1,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":2,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":1,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":2,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":0,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":3,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":0,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":3,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":1,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":2,\"rank\":4}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":1,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":2,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":0,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":5,\"match_position\":3,\"rank\":4}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":0,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":0,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":1,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":1,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":0,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":0,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":1,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":1,\"rank\":4}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":2,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":2,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":3,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":3,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":2,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":2,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":3,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":6,\"match_position\":3,\"rank\":4}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":0,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":0,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":1,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":1,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":0,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":0,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":2,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":2,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":1,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":1,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":3,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":3,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":2,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":2,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":3,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":7,\"match_position\":3,\"rank\":4}]}]}},{\"match_generator_type\":\"spot_filler\",\"match_generator_data\":{\"matches\":[{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":0,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":0,\"rank\":2},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":1,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":1,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":0,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":0,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":2,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":2,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":1,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":1,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":3,\"rank\":1},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":3,\"rank\":2}]},{\"spots\":[{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":2,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":2,\"rank\":4},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":3,\"rank\":3},{\"spot_type\":\"match_participant\",\"round_position\":8,\"match_position\":3,\"rank\":4}]}]}}]}",
	"leaderboard_id": 6911,
	"team_leaderboard_id": null,
	"manialink": null,
	"rules_url": null,
	"stream_url": null,
	"website_url": null,
	"logo_url": "https://trackmania-prod-club-public.s3-eu-west-1.amazonaws.com/manual/competitions/tmgl/logo_tmgl.png",
	"vertical_url": "https://trackmania-prod-club-public.s3-eu-west-1.amazonaws.com/manual/competitions/tmgl/vertical_tmgl.png",
	"allowed_zones": [],
	"deleted_on": null,
	"auto_normalize_seeds": true,
	"region": null,
	"auto_get_participant_skill_level": "DISABLED"
}"""));
	}

	API::CompetitionRound@[] GetCompetitionRoundsAsync(int compId)
	{
		if (compId != 1896) {
			error("Unexpected mock competition ID: " + compId);
			return {};
		}

		trace("GetCompetitionRoundsAsync");

		sleep(MOCK_API_SLEEP_TIME);

		auto js = Json::Parse("""[
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5018,
		"position": 0,
		"name": "Step 1 - Track 1",
		"start_date": 1642668027,
		"end_date": 1642668867,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "MANUAL",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 4
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5019,
		"position": 1,
		"name": "Step 1 - Track 2",
		"start_date": 1642668927,
		"end_date": 1642669767,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "MANUAL",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5020,
		"position": 2,
		"name": "Step 1 - Track 3",
		"start_date": 1642669827,
		"end_date": 1642670667,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "MANUAL",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5021,
		"position": 3,
		"name": "Step 1 - Track 4",
		"start_date": 1642670727,
		"end_date": 1642671567,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "MANUAL",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5022,
		"position": 4,
		"name": "Step 1 - Track 5",
		"start_date": 1642671627,
		"end_date": 1642672527,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "TMGL_2022",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5023,
		"position": 5,
		"name": "Step 2 - Track 1",
		"start_date": 1642673247,
		"end_date": 1642674087,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "MANUAL",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5024,
		"position": 6,
		"name": "Step 2 - Track 2",
		"start_date": 1642674147,
		"end_date": 1642674987,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "MANUAL",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5025,
		"position": 7,
		"name": "Step 2 - Track 3",
		"start_date": 1642675047,
		"end_date": 1642675887,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "MANUAL",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5026,
		"position": 8,
		"name": "Step 2 - Track 4",
		"start_date": 1642675947,
		"end_date": 1642676787,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "MANUAL",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	},
	{
		"qualifier_challenge_id": null,
		"training_challenge_id": null,
		"id": 5027,
		"position": 9,
		"name": "Step 2 - Track 5",
		"start_date": 1642676847,
		"end_date": 1642677747,
		"lock_date": null,
		"status": null,
		"is_locked": false,
		"auto_needs_matches": true,
		"match_score_direction": "DESC",
		"leaderboard_compute_type": "TMGL_2022",
		"team_leaderboard_compute_type": null,
		"deleted_on": null,
		"nb_matches": 0
	}
]""");

		API::CompetitionRound@[] ret;
		for (uint i = 0; i < js.Length; i++) {
			ret.InsertLast(API::CompetitionRound(js[i]));
		}
		return ret;
	}

	API::RoundMatch@[] GetRoundMatchesAsync(int roundId)
	{
		if (roundId	!= 5018) {
			warn("Unexpected mock round ID " + roundId);
		}

		trace("GetRoundMatchesAsync");

		sleep(MOCK_API_SLEEP_TIME);

		auto js = Json::Parse("""{
	"matches": [
		{
			"id": 3468,
			"name": "TMGL Show match - Step 1 - Track """ + (roundId - 5017) + """ - 1",
			"club_match_live_id": "LID-MTCH-lg4yu1hltc0bqgg",
			"is_completed": false
		},
		{
			"id": 3469,
			"name": "TMGL Show match - Step 1 - Track """ + (roundId - 5017) + """ - 2",
			"club_match_live_id": "LID-MTCH-yz0a1eyby24flxj",
			"is_completed": false
		},
		{
			"id": 3470,
			"name": "TMGL Show match - Step 1 - Track """ + (roundId - 5017) + """ - 3",
			"club_match_live_id": "LID-MTCH-rivbs45ysmh5pxl",
			"is_completed": false
		},
		{
			"id": 3471,
			"name": "TMGL Show match - Step 1 - Track """ + (roundId - 5017) + """ - 4",
			"club_match_live_id": "LID-MTCH-s3j05umbxrdokmj",
			"is_completed": false
		}
	]
}
""");

		API::RoundMatch@[] ret;
		auto jsMatches = js["matches"];
		for (uint i = 0; i < jsMatches.Length; i++) {
			ret.InsertLast(API::RoundMatch(jsMatches[i]));
		}
		return ret;
	}

	API::Match@ GetMatchAsync(const string &in matchLid)
	{
		trace("GetMatchAsync");

		int matchId = 3478; //TODO

		sleep(MOCK_API_SLEEP_TIME);

		auto js = Json::Parse("""{
	"id": """ + matchId + """,
	"live_id": "LID-MTCH-uo40zijydob4b4c",
	"name": "TMGL Show match - Step 1 - Track 1 - """ + (matchId - 3467) + """",
	"start_date": 1642668027,
	"end_date": 1642668867,
	"score_direction": "DESC",
	"game_settings": {
		"gameinfos": {
			"game_mode": 0,
			"chat_time": 10000,
			"finishtimeout": 1,
			"allwarmupduration": 0,
			"disablerespawn": 0,
			"forceshowallopponents": 0,
			"script_name": "TrackMania/TM_CupShort_Online.Script.txt"
		},
		"filter": {
			"is_lan": 1,
			"is_internet": 1,
			"is_solo": 0,
			"is_hotseat": 0,
			"sort_index": 1000,
			"random_map_order": 0
		},
		"script_settings": [
			{
				"name": "S_RoundsPerMap",
				"type": "integer",
				"value": "11"
			},
			{
				"name": "S_FinishTimeout",
				"type": "integer",
				"value": "5"
			},
			{
				"name": "S_EnableAmbientSound",
				"type": "boolean",
				"value": "0"
			},
			{
				"name": "S_EnableWinScreen",
				"type": "boolean",
				"value": "0"
			},
			{
				"name": "S_CompetitionName",
				"type": "text",
				"value": "TMGL Show match"
			},
			{
				"name": "S_MatchPosition",
				"type": "integer",
				"value": "0"
			}
		],
		"startindex": 0,
		"maps": [
			{
				"file": "",
				"ident": "gwJD2yBw6E_ivaKfCijXxffiLD9"
			}
		]
	},
	"dedicated_cfg": {
		"authorization_levels": [
			{
				"name": "SuperAdmin",
				"password": "SuperAdmin"
			},
			{
				"name": "Admin",
				"password": "Admin"
			},
			{
				"name": "User",
				"password": "User"
			}
		],
		"masterserver_account": {
			"login": "",
			"password": "",
			"validation_key": ""
		},
		"server_options": {
			"name": "",
			"comment": "",
			"hide_server": 1,
			"max_players": 20,
			"password": "",
			"max_spectators": 64,
			"password_spectator": "",
			"keep_player_slots": false,
			"ladder_mode": "forced>",
			"ladder_serverlimit_min": null,
			"ladder_serverlimit_max": null,
			"enable_p2p_upload": true,
			"enable_p2p_download": false,
			"callvote_timeout": 60000,
			"callvote_ratio": -1.0,
			"callvote_ratios": [],
			"allow_map_download": false,
			"autosave_replays": false,
			"autosave_validation_replays": false,
			"referee_password": "",
			"referee_validation_mode": 0,
			"use_changing_validation_seed": false,
			"disable_horns": false,
			"clientinputs_maxlatency": 0,
			"server_plugin": "server-plugins/Club/ClubPlugin.Script.txt",
			"server_plugin_settings": [
				{
					"name": "S_DisableReadyManager",
					"type": "boolean",
					"value": "1"
				}
			],
			"disable_profile_skins": null
		},
		"system_config": {
			"connection_uploadrate": 800000,
			"connection_downloadrate": 800000,
			"allow_spectator_relays": false,
			"p2p_cache_size": 600,
			"force_ip_address": null,
			"server_port": 2000,
			"server_p2p_port": 3461,
			"client_port": 0,
			"bind_ip_address": null,
			"use_nat_upnp": null,
			"gsp_name": "",
			"gsp_url": "",
			"xmlrpc_port": 5021,
			"xmlrpc_allowremote": false,
			"scriptcloud_source": "nadeocloud>",
			"blacklist_url": "",
			"guestlist_filename": "",
			"blacklist_filename": "",
			"title": "Trackmania",
			"minimum_client_build": "",
			"disable_coherence_checks": false,
			"disable_replay_recording": true,
			"use_proxy": false,
			"proxy_login": "",
			"proxy_password": "",
			"workerthreadcount": 1,
			"packetassembly_multithread": true,
			"packetassembly_packetsperframe": 30,
			"packetassembly_fullpacketsperframe": 5,
			"trustclientsimu_c2s_sendingrate": 128,
			"delayedvisuals_s2c_sendingrate": 64
		}
	},
	"server_config": null,
	"server_id": 167303,
	"server_status": "DELETED",
	"join_link": "#join=tphM7GYKTHyZ_SkVNGaqVg@Trackmania",
	"status": "COMPLETED",
	"participant_type": "player",
	"manialink": null,
	"deleted_on": null,
	"group": "LID-COMP-3kf51ym0sumijwx",
	"policy": null,
	"region": null
}""");

		return API::Match(js);
	}

	API::MatchParticipant@[] GetMatchParticipants(int matchId)
	{
		trace("GetMatchParticipants");

		sleep(MOCK_API_SLEEP_TIME);

		auto js = Json::Parse("""[
	{
		"participant": "0c857beb-fd95-4449-a669-21fb310cacae",
		"rank": 4,
		"score": 0,
		"position": 0,
		"team_position": null,
		"level": 0,
		"mvp": false,
		"leaver": null,
		"eliminated": false
	},
	{
		"participant": "52f28ccd-89d1-4863-a119-822c7c7b6695",
		"rank": 2,
		"score": 5,
		"position": 1,
		"team_position": null,
		"level": 0,
		"mvp": false,
		"leaver": null,
		"eliminated": false
	},
	{
		"participant": "1e9ce296-c819-4590-b938-ec230f67f0a8",
		"rank": 3,
		"score": 3,
		"position": 2,
		"team_position": null,
		"level": 0,
		"mvp": false,
		"leaver": null,
		"eliminated": false
	},
	{
		"participant": "05477e79-25fd-48c2-84c7-e1621aa46517",
		"rank": 1,
		"score": 6,
		"position": 3,
		"team_position": null,
		"level": 0,
		"mvp": false,
		"leaver": null,
		"eliminated": false
	}
]""");

		API::MatchParticipant@[] ret;
		for (uint i = 0; i < js.Length; i++) {
			ret.InsertLast(API::MatchParticipant(js[i]));
		}
		return ret;
	}

	API::LiveRanking@ GetMatchLiveRanking(int matchId)
	{
		trace("GetMatchLiveRanking " + matchId);

		sleep(MOCK_API_SLEEP_TIME);

		auto js = Json::Parse("""{
	"match_status": "COMPLETED",
	"participants": [
		{
			"account_id": "05477e79-25fd-48c2-84c7-e1621aa46517",
			"score": 6
		},
		{
			"account_id": "52f28ccd-89d1-4863-a119-822c7c7b6695",
			"score": 5
		},
		{
			"account_id": "1e9ce296-c819-4590-b938-ec230f67f0a8",
			"score": 3
		},
		{
			"account_id": "0c857beb-fd95-4449-a669-21fb310cacae",
			"score": 0
		}
	]
}""");

		return API::LiveRanking(js);
	}
}

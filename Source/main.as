Resources::Font@ g_fontHeader26;
Resources::Font@ g_fontHeader20;

Window@ g_window;

string g_currentAccountId;
bool g_canJoinServers = false;
IAPI@ g_api;

void RenderMenu()
{
	if (g_window !is null && UI::MenuItem("\\$e61" + Icons::Trophy + "\\$z TMGL Match Viewer", "", Setting_Visible)) {
		Setting_Visible = !Setting_Visible;
	}
}

void RenderInterface()
{
	if (g_window !is null) {
		g_window.Render();
	}
}

void Main()
{
	auto app = cast<CGameManiaPlanet>(GetApp());
	auto menuManager = app.MenuManager;
	while (menuManager.MenuCustom_CurrentManiaApp is null) {
		yield();
	}
	auto currentManiaApp = menuManager.MenuCustom_CurrentManiaApp;
	while (currentManiaApp.LocalUser is null || currentManiaApp.LocalUser.WebServicesUserId == "") {
		yield();
	}

	g_currentAccountId = currentManiaApp.LocalUser.WebServicesUserId;

	@g_fontHeader26 = Resources::GetFont("Fonts/Montserrat-Bold.ttf", 26);
	@g_fontHeader20 = Resources::GetFont("Fonts/Montserrat-Bold.ttf", 20, -1, -1, true);

	Data::Load();

	if (Data::Player::FromID(g_currentAccountId) !is null) {
		warn("Current user is a TMGL player.");
		g_canJoinServers = true;
	}
	auto streamerPlayer = Data::Player::FromStreamerID(g_currentAccountId);
	if (streamerPlayer !is null) {
		warn("Current user is a streamer for " + streamerPlayer.m_nickname + ".");
		g_canJoinServers = true;
	}

	//@g_api = MockAPI();
	@g_api = ProdAPI();

	@g_window = Window();
	g_window.LoopAsync();
}

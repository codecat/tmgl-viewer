Resources::Font@ g_fontHeader26;
Resources::Font@ g_fontHeader20;

APIData@ g_apiData;
Window@ g_window;

string g_currentAccountId;
IAPI@ g_api;

Audio::Sample@ g_soundMatch;

void RenderMenu()
{
	if (g_window !is null && UI::MenuItem("\\$e61" + Icons::Trophy + "\\$z TMGL Match Viewer", "", Setting_Visible)) {
		Setting_Visible = !Setting_Visible;
	}
}

void RenderInterface()
{
	if (!Setting_AlwaysVisible && g_window !is null) {
		g_window.Render();
	}
}

void Render()
{
	if (Setting_AlwaysVisible && g_window !is null) {
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

	// Something stupid in Nadeo's new authentication.. not sure what's up, but this waits for proper auth
	while (currentManiaApp.LocalUser.WebServicesUserId == currentManiaApp.LocalUser.Login) {
		yield();
	}

	g_currentAccountId = currentManiaApp.LocalUser.WebServicesUserId;

	@g_fontHeader26 = Resources::GetFont("Fonts/Montserrat-Bold.ttf", 26);
	@g_fontHeader20 = Resources::GetFont("Fonts/Montserrat-Bold.ttf", 20, -1, -1, true);

	@g_soundMatch = Resources::GetAudioSample("Audio/Match.wav");

	//@g_api = MockAPI();
	@g_api = ProdAPI();

	@g_apiData = APIData();

	@g_window = Window();
	g_window.LoopAsync();
}

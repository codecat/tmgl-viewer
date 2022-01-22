Resources::Font@ g_fontHeader26;
Resources::Font@ g_fontHeader20;

Window g_window;

IAPI@ g_api;

void RenderMenu()
{
	if (UI::MenuItem("\\$e61" + Icons::Trophy + "\\$z TMGL Match Viewer", "", Setting_Visible)) {
		Setting_Visible = !Setting_Visible;
	}
}

void RenderInterface()
{
	g_window.Render();
}

void Main()
{
	@g_fontHeader26 = Resources::GetFont("Fonts/Montserrat-Bold.ttf", 26);
	@g_fontHeader20 = Resources::GetFont("Fonts/Montserrat-Bold.ttf", 20, -1, -1, true);

	Data::Load();

	@g_api = MockAPI();
	//NadeoServices::AddAudience("NadeoClubServices");

	g_window.LoopAsync();
}

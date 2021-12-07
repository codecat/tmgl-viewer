Resources::Font@ g_fontHeader26;
Resources::Font@ g_fontHeader20;

Window g_window;

void RenderMenu()
{
	if (UI::MenuItem("\\$e61" + Icons::Trophy + "\\$z TMGL Match Viewer", "", g_window.m_visible)) {
		g_window.m_visible = !g_window.m_visible;
	}
}

void RenderInterface()
{
	g_window.Render();
}

void Main()
{
	@g_fontHeader26 = Resources::GetFont("fonts/Montserrat-Bold.ttf", 26);
	@g_fontHeader20 = Resources::GetFont("fonts/Montserrat-Bold.ttf", 20, -1, -1, true);

	NadeoServices::AddAudience("NadeoClubServices");

	g_window.LoopAsync();
}

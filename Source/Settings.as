[Setting hidden]
bool Setting_Visible = false;

[Setting category="General" name="Competition ID" description="After changing this, click 'Refresh all' in the Controls tab!"]
int Setting_CompetitionId = 1896; // totd: 1860

[Setting category="General" name="Refresh time in seconds"]
int Setting_RefreshTime = 10;

[Setting category="Debug" name="Verbose logging"]
bool Setting_Verbose = true;

[Setting category="Debug" name="Dump responses to disk"]
bool Setting_DumpResponses = false;

[Setting category="Debug" name="Advance round"]
bool Setting_AdvanceRound = false;

[SettingsTab name="Controls"]
void RenderControlsSettings()
{
	UI::Text("Click the 'Refresh all' button to force a refresh of the entire competition.");
	if (UI::Button(Icons::Refresh + " Refresh all")) {
		g_apiData.Clear();
		g_window.Clear();
		g_window.Refresh();
	}

	UI::Text("A soft refresh is the same as an automatic refresh.");
	if (UI::Button(Icons::Refresh + " Soft refresh")) {
		g_window.Refresh();
	}
}

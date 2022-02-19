[Setting hidden]
bool Setting_Visible = false;

[Setting category="General" name="Refresh time in seconds" min=10 max=60]
int Setting_RefreshTime = 10;

[Setting category="General" name="Enable notification sounds"]
bool Setting_Sounds = true;

[Setting category="General" name="Always show window" description="Displays the window even when the overlay is hidden"]
bool Setting_AlwaysVisible = true;

[Setting category="Debug" name="Verbose logging" description="Enable verbose logging of requests. Enable only if needed!"]
bool Setting_Verbose = false;

[Setting category="Debug" name="Dump responses to disk" description="Dump responses to disk. Enable only if needed!"]
bool Setting_DumpResponses = false;

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

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

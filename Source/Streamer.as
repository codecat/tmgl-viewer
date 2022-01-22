class Streamer
{
	string m_name;
	string m_link;

	Streamer(const string &in name, const string &in link)
	{
		m_name = name;
		m_link = link;
	}

	void Render(bool fullwidth)
	{
		float columnWidth = 0;
		if (fullwidth) {
			columnWidth = UI::GetContentRegionAvail().x;
		}
		if (UI::ColoredButton(Icons::Twitch + " " + m_name, 0.8f, 0.6f, 0.6f, vec2(columnWidth, 0))) {
			OpenBrowserURL(m_link);
		}
	}
}

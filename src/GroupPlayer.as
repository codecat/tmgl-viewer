const vec4 TAG_COLOR_BRONZE = vec4(194/255.0f, 129/255.0f,  85/255.0f, 1);
const vec4 TAG_COLOR_SILVER = vec4(158/255.0f, 158/255.0f, 158/255.0f, 1);//vec4(174/255.0f, 176/255.0f, 176/255.0f, 1);
const vec4 TAG_COLOR_GOLD   = vec4(204/255.0f, 153/255.0f,  14/255.0f, 1);//vec4(223/255.0f, 169/255.0f,  22/255.0f, 1);

class GroupPlayer
{
	string m_accountId; // Will this be available?
	string m_displayName; // Will we have to query this?
	string m_teamTag;
	int m_score = 0;

	GroupPlayer(const string &in displayName, const string &in teamTag)
	{
		m_displayName = displayName;
		m_teamTag = teamTag;
	}

	void Render(int position, bool ended)
	{
		Controls::Tag(vec2(35, 0), m_teamTag);
		UI::SameLine();
		UI::AlignTextToFramePadding();

		if (ended) {
			switch (position) {
				case 1: Controls::Tag(Icons::Trophy + " " + m_displayName, TAG_COLOR_GOLD); break;
				case 2: Controls::Tag(Icons::Trophy + " " + m_displayName, TAG_COLOR_SILVER); break;
				case 3: Controls::Tag(Icons::Trophy + " " + m_displayName, TAG_COLOR_BRONZE); break;
				default: UI::Text(m_displayName); break;
			}
		} else {
			UI::Text(m_displayName);
		}
		UI::SameLine();

		string scoreText = tostring(m_score);
		vec2 cursorPos = UI::GetCursorPos();
		float spaceLeft = UI::GetContentRegionAvail().x;
		vec2 textSize = Draw::MeasureString(scoreText);

		UI::SetCursorPos(cursorPos + vec2(spaceLeft - textSize.x, 0));
		UI::Text(scoreText);
	}

	int opCmp(const GroupPlayer &in other)
	{
		if (other.m_score > m_score) {
			return -1;
		} else if (other.m_score < m_score) {
			return 1;
		}
		return 0;
	}
}

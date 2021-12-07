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

	void Render(int position)
	{
		Controls::Tag(vec2(35, 0), m_teamTag);
		UI::SameLine();
		UI::AlignTextToFramePadding();

		UI::Text(m_displayName);
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

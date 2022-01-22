namespace UI
{
	bool ColoredButton(const string &in text, float h, float s = 0.6f, float v = 0.6f, const vec2 &in size = vec2())
	{
		UI::PushStyleColor(UI::Col::Button, UI::HSV(h, s, v));
		UI::PushStyleColor(UI::Col::ButtonHovered, UI::HSV(h, s + 0.1f, v + 0.1f));
		UI::PushStyleColor(UI::Col::ButtonActive, UI::HSV(h, s + 0.2f, v + 0.2f));
		bool ret = UI::Button(text, size);
		UI::PopStyleColor(3);
		return ret;
	}

	bool RedButton(const string &in text, const vec2 &in size = vec2()) { return ColoredButton(text, 0.0f, 0.6f, 0.6f, size); }
	bool GreenButton(const string &in text, const vec2 &in size = vec2()) { return ColoredButton(text, 0.33f, 0.6f, 0.6f, size); }
	bool DarkButton(const string &in text, const vec2 &in size = vec2()) { return ColoredButton(text, 0.78f, 0.0f, 0.12f, size); }

	bool ToggledButton(bool toggle, const string &in text, const vec2 &in size = vec2())
	{
		if (!toggle) {
			return DarkButton(text, size);
		}
		return GreenButton(text, size);
	}
}

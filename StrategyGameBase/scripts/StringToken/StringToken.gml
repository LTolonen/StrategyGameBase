/// @function StringToken
/// @param text
/// @param colour
/// @param font
function StringToken(_text, _colour, _font) : Token(TOKEN_TYPE.STRING) constructor
{
	text = _text;
	colour = _colour;
	draw_set_font(_font);
	width = string_width(text);
	height = string_height(text);
}
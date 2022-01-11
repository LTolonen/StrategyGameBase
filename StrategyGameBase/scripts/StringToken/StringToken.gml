/// @function StringToken
/// @param text
/// @param colour
/// @param font
function StringToken(_text, _colour, _font) : Token(TOKEN_TYPE.STRING) constructor
{
	text = _text;
	colour = _colour;
	font = _font;
	draw_set_font(_font);
	width = string_width(text);
	height = string_height(text);
	
	static TokenDraw = function(_x, _y)
	{
		draw_set_colour(colour);
		draw_set_font(font);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(_x, _y, text);
	}
}
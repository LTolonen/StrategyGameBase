/// @function font_get_char_info
/// @param font
/// @param char
function font_get_char_info(_font, _char)
{
	var _font_info = font_get_info(_font);
	return _font_info.glyphs[$ _char];
}
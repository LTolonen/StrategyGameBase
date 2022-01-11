/// @function SpaceToken
/// @param font_space_width
/// @param font_height
function SpaceToken(_font_space_width, _font_height) : Token(TOKEN_TYPE.SPACE) constructor
{
	width = _font_space_width;
	height = _font_height;
}
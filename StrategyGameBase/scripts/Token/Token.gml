enum TOKEN_TYPE
{
	STRING,
	SPRITE,
	SPACE,
	NEW_LINE
}

/// @function Token
/// @param token_type
function Token(_token_type) constructor
{
	token_type = _token_type;
	width = 0;
	height = 0;
	
	/// @function TokenDraw
	/// @param x
	/// @param y
	static TokenDraw = function(_x, _y)
	{
	}
}
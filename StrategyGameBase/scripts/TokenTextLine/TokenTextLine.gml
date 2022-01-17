/// @function TokenTextLine
/// @param line_height
/// @param max_width
/// @param y_offset
function TokenTextLine(_line_height, _max_width, _y_offset) constructor
{
	height = _line_height;
	max_width = _max_width;
	
	x_offset = 0;
	y_offset = _y_offset;
	
	token_positions = new List();
	width = 0;
	
	/// @function TokenTextLineCanAddToken
	/// @param token
	static TokenTextLineCanAddToken = function(_token)
	{
		if(max_width == -1)
			return true;
		return width+_token.width <= max_width;
	}
	
	/// @function TokenTextLineAddToken
	/// @param token
	static TokenTextLineAddToken = function(_token)
	{
		token_positions.ListAdd({
			token : _token,
			x_offset : width,
			y_offset : (height - _token.height) div 2
		});
		width += _token.width;
	}
	
	/// @function TokenTextLineRemoveLastToken
	static TokenTextLineRemoveLastToken = function()
	{
		if(token_positions.ListSize() <= 0)
			return;
		var _last_token = token_positions.ListPopLast().token;
		width -= _last_token.width;
	}
	
	/// @function TokenTextLineGetNumTokens
	static TokenTextLineGetNumTokens = function()
	{
		return token_positions.ListSize();	
	}
	
	/// @function TokenTextLineDraw
	/// @param x
	/// @param y
	static TokenTextLineDraw = function(_x, _y)
	{
		for(var i=0; i<token_positions.ListSize(); i++)
		{
			var _token_position = token_positions.ListGet(i);
			_token_position.token.TokenDraw(_x+x_offset+_token_position.x_offset,_y+y_offset+_token_position.y_offset);
		}
	}
}
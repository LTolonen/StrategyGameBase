/// @function TokenTextLayout
/// @param token_text
function TokenTextLayout(_token_text) constructor
{
	max_width = _token_text.max_width;
	max_height = _token_text.max_height;
	line_height = _token_text.font_height+_token_text.line_separation;
	halign = _token_text.halign;
	valign = _token_text.valign;
	
	x_offset = 0;
	y_offset = 0;
	width = 0;
	height = 0;
	lines = new List();
	TokenTextLayoutInit(_token_text);
	
	/// @function TokenTextLayoutInit
	/// @param token_text
	static TokenTextLayoutInit = function(_token_text)
	{
		///Fit the tokens to each line
		var _capacity_reached = false;
		for(var _source_line_index=0; _source_line_index<_token_text.lines.ListSize(); _source_line_index++)
		{
			var _source_line = _token_text.lines.ListGet(_source_line_index);
			if(!TokenTextLayoutCanAddLine())
				break;

			var _current_line = TokenTextLayoutAddLine();
			for(var i=0; i<_source_line.ListSize(); i++)
			{
				var _token  = _source_line.ListGet(i);
				if(_current_line.TokenTextLineCanAddToken(_token))
				{
					_current_line.TokenTextLineAddToken(_token);	
				}
				else if(TokenTextLayoutCanAddLine())
				{
					var _current_line = TokenTextLayoutAddLine();
					if(_current_line.TokenTextLineCanAddToken(_token))
					{
						_current_line.TokenTextLineAddToken(_token);	
					}
					else
					{
						_capacity_reached = true;
						break;
					}
				}
				else
				{
					_capacity_reached = true;
					break;
				}
			}
		
			if(_capacity_reached)
				break;
		}
	
		//Determine the width by taking the width of the widest line
		for(var _line_index = 0; _line_index<lines.ListSize(); _line_index++)
		{
			var _line = lines.ListGet(_line_index);
			width = max(width,_line.width);
		}
		
		//Alignment
		if(halign != fa_left)
		{
			for(var _line_index = 0; _line_index<lines.ListSize(); _line_index++)
			{
				var _line = lines.ListGet(_line_index);
				if(halign == fa_center)
					_line.x_offset -= _line.width div 2;
				else
					_line.x_offset -= _line.width;
			}
		}
		
		if(valign == fa_middle)
			y_offset = -(height div 2);
		else if(valign == fa_bottom)
			y_offset = -height;
	}
	
	/// @function TokenTextLayoutCanAddLine
	static TokenTextLayoutCanAddLine = function()
	{
		if(max_height == -1)
			return true;
			
		return height + line_height < max_height;
	}
	
	/// @function TokenTextLayoutAddLine
	static TokenTextLayoutAddLine = function()
	{
		var _line = new TokenTextLine(line_height, max_width, height);
		lines.ListAdd(_line);
		height += _line.height;
		return _line;
	}
	
	/// @function TokenTextLayoutDraw
	/// @param x
	/// @param y
	static TokenTextLayoutDraw = function(_x, _y)
	{
		for(var i=0; i<lines.ListSize(); i++)
		{
			var _line = lines.ListGet(i);
			_line.TokenTextLineDraw(_x+x_offset,_y+y_offset);
		}
	}
}
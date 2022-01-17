/// @function TokenText
/// @param text
/// @param font
/// @param colour
function TokenText(_text, _font, _colour) constructor
{
	font = _font;
	colour = _colour;
	draw_set_font(font);
	font_height = font_get_char_info(font,"|").h;
	font_space_width = font_get_char_info(font," ").w;
	
	lines = new List();
	TokenTextAddString(_text);
	
	halign = fa_left;
	valign = fa_top;
	max_width = -1;
	max_height = -1;
	line_separation = 0;
	
	layout = -1;
	
	/// @function TokenTextAddString
	/// @param text
	/// @param [colour]
	static TokenTextAddString = function(_text, _colour = -1)
	{
		var _text_length = string_length(_text);
		if(_text_length == 0)
			return self;
		
		layout = -1;
		
		//Convert the text to individual tokens
		var _from_position = 1;
		for(var _to_position=1; _to_position<=_text_length+1; _to_position++)
		{
			var _is_end_of_string = _to_position == _text_length+1;
			var _is_space = false;
			var _is_new_line = false;
			if(!_is_end_of_string)
			{
				_is_space = string_char_at(_text,_to_position) == " ";
				_is_new_line = string_char_at(_text,_to_position) == "\n";
			}
			if(!_is_end_of_string && !_is_space && !_is_new_line)
				continue;
				
			var _segment_length = _to_position-_from_position;
			if(_segment_length > 0)
			{
				var _segment = string_copy(_text,_from_position,_segment_length);
				var _token_colour = _colour;
				if(_token_colour == -1)
					_token_colour = colour;
				TokenTextGetCurrentLine().ListAdd(new StringToken(_segment,_token_colour,font));
			}
			
			if(_is_space)
				TokenTextGetCurrentLine().ListAdd(new SpaceToken(font_space_width,font_height));
				
			if(_is_new_line)
			{
				if(lines.ListSize() == 0)
					lines.ListAdd(new List());
				lines.ListAdd(new List());
			}
			
			_from_position = _to_position+1;
		}
	}
	
	/// @function TokenTextAddSprite
	/// @param sprite_index
	/// @param image_index
	/// @param [colour]
	static TokenTextAddSprite = function(_sprite_index, _image_index, _colour = -1)
	{
		layout = -1;
		var _line = TokenTextGetCurrentLine();
		_line.ListAdd(new SpriteToken(_sprite_index, _image_index, _colour));
	}
	
	/// @function TokenTextGetCurrentLine
	static TokenTextGetCurrentLine = function()
	{
		var _num_lines = lines.ListSize();
		
		//If there are currently no lines, add a line and return it
		if(_num_lines == 0)
		{
			var _line = new List();
			lines.ListAdd(_line);
			return _line;
		}
		
		return lines.ListGet(_num_lines-1);
	}
	
	/// @function TokenTextGetLayout
	static TokenTextGetLayout = function()
	{
		if(layout != -1)
			return layout;
		
		layout = new TokenTextLayout(self);
		return layout;
	}
	
	/// @function TokenTextSetMaxSize
	/// @param [max_width]
	/// @param [max_height]
	static TokenTextSetMaxSize = function(_max_width = -1, _max_height = -1)
	{
		if(max_width != _max_width || max_height != _max_height)
			layout = -1;
		max_width = _max_width;
		max_height = _max_height;
	}
	
	/// @function TokenTextSetAlignment
	/// @param halign
	/// @param valign
	static TokenTextSetAlignment = function(_halign, _valign)
	{
		if(halign == _halign && valign == _valign)
			return;
		layout = -1;
		halign = _halign;
		valign = _valign;
	}
	
	/// @function TokenTextSetLineSeparation
	/// @param line_separation
	static TokenTextSetLineSeparation = function(_line_separation)
	{
		if(_line_separation == line_separation)
			return;
		layout = -1;
		line_separation = _line_separation;
	}
	
	/// @function TokenTextDraw
	/// @param x
	/// @param y
	static TokenTextDraw = function(_x,_y)
	{
		var _layout = TokenTextGetLayout();
		_layout.TokenTextLayoutDraw(_x,_y);
	}
}

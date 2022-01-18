/// @function GuiText
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
/// @param token_text
function GuiText(_gui,_depth,_x,_y,_width,_height,_token_text) : GuiElement(_gui,_depth,_x,_y,_width,_height) constructor
{
	token_text = _token_text;
	token_text.TokenTextSetMaxSize(_width,_height);
	
	static GuiElementOnResize = function()
	{
		token_text.TokenTextSetMaxSize(_width,_height);	
	}
	
	static GuiElementDraw = function()
	{
		draw_rectangle(x,y,x+width-1,y+height-1,true);
		var _text_x = x;
		var _text_y = y;
		
		if(token_text.halign == fa_center)
			_text_x += width / 2;
		else if(token_text.halign == fa_right)
			_text_x += width;
			
		if(token_text.valign == fa_middle)
			_text_y += height / 2;
		else if(token_text.valign == fa_bottom)
			_text_y += height;
			
		token_text.TokenTextDraw(_text_x,_text_y);
	}
	
	/// @function GuiTextSetAlignment
	/// @param halign
	/// @param valign
	static GuiTextSetAlignment = function(_halign, _valign)
	{
		token_text.TokenTextSetAlignment(_halign,_valign);
	}
}
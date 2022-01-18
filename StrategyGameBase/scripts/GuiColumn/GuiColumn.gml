/// @function GuiColumn
/// @param gui
/// @param depth
/// @param [fixed_width]
/// @param [weighting]
function GuiColumn(_gui, _depth, _fixed_width, _weighting) : GuiElement(_gui,_depth,0,0,0,0) constructor 
{
	fixed_width = _fixed_width;
	weighting = _weighting;
	is_fixed_width = !is_undefined(_fixed_width);
	
	static GuiElementDraw = function()
	{
		draw_rectangle(x,y,x+width-1,y+height-1,true);	
	}
}
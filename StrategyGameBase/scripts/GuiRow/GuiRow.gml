/// @function GuiRow
/// @param gui
/// @param depth
/// @param [fixed_height]
/// @param [weighting]
function GuiRow(_gui, _depth, _fixed_height, _weighting) : GuiElement(_gui,_depth,0,0,0,0) constructor 
{
	fixed_height = _fixed_height;
	weighting = _weighting;
	is_fixed_height = !is_undefined(_fixed_height);
	
	static GuiElementDraw = function()
	{
		draw_rectangle(x,y,x+width-1,y+height-1,true);	
	}
}
/// @function GuiTestRectangle
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
/// @param colour
function GuiTestRectangle(_gui, _depth, _x, _y, _width, _height, _colour) : GuiElement(_gui,_depth,_x,_y,_width,_height) constructor
{
	is_hoverable = true;
	colour = _colour;
	highlight_border_thickness = 4;
	
	static GuiElementDraw = function()
	{
		if(GuiElementIsHovered())
		{
			draw_set_colour(c_white);
			draw_rectangle(x-highlight_border_thickness,y-highlight_border_thickness,x+width-1+highlight_border_thickness,y+height-1+highlight_border_thickness,false);
		}
		draw_set_color(colour);
		draw_rectangle(x,y,x+width-1,y+height-1,false);
	}
}
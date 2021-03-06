enum PARENT_RELATIONSHIP
{
	NONE,
	ALIGN,
	FIT
}

enum CORNER
{
	TOP_LEFT = 0,
	TOP_RIGHT = 1,
	BOTTOM_LEFT = 2,
	BOTTOM_RIGHT = 3
}

/// @function GuiElement
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
function GuiElement(_gui, _depth, _x, _y, _width, _height) constructor
{
	gui = _gui;
	depth = _depth;
	x = _x;
	y = _y;
	width = _width;
	height = _height;
	
	is_active = true;
	is_visible = true;
	is_hoverable = false;
	is_selectable = false;

	padding_h = 0;
	padding_v = 0;
	
	parent_element = -1;
	parent_relationship = PARENT_RELATIONSHIP.ALIGN;
	parent_anchor_corner = CORNER.TOP_LEFT;
	self_anchor_corner = CORNER.TOP_LEFT;
	parent_alignment_x_offset = 0;
	parent_alignment_y_offset = 0;
	
	child_elements = new List();
	
	gui.GuiAddElement(self);
	
	static GuiElementDraw = -1;
	static GuiElementUpdate = -1;
	static GuiElementOnDestroy = -1;
	
	/// @function GuiElementOnMove
	/// @param previous_x
	/// @param previous_y
	static GuiElementOnMove = -1;
	
	/// @function GuiElementOnResize
	/// @param previous_width
	/// @param previous_height
	static GuiElementOnResize = -1; 
	
	static GuiElementOnClick = -1;
	static GuiElementOnClickDown = -1;
	static GuiElementOnHover = -1;
	static GuiElementOnUnhover = -1;
	static GuiElementOnDeselect = -1;
	GuiElementOnEnterGuiState = array_create(GUI_STATE_TYPE.COUNT,-1);
	
	/// @function GuiElementDestroy
	static GuiElementDestroy = function()
	{
		if(GuiElementOnDestroy != -1)
			GuiElementOnDestroy();
			
		//Remove this element from its parent's child list
		if(parent_element != -1)
		{
			parent_element.child_elements.ListRemoveItem(self);	
		}
		
		//Destroy the elements children
		while(child_elements.ListSize() > 0)
		{
			var _child_element = child_elements.ListPopLast();
			_child_element.GuiElementDestroy();
		}
		
		gui.GuiRemoveElement(self);
	}
	
	/// @function GuiElementSetParent
	/// @param parent_element
	static GuiElementSetParent = function(_parent_element)
	{
		if(_parent_element == parent_element)
			return;
			
		//Remove from old parent's child list
		if(parent_element != -1)
			parent_element.child_elements.ListRemoveItem(self);	
		
		parent_element = _parent_element;
		
		if(parent_element != -1)
			parent_element.child_elements.ListAdd(self);
			
		GuiElementAlignToParent();
	}
	
	/// @function GuiElementSetFitToParent
	static GuiElementSetFitToParent = function()
	{
		parent_relationship = PARENT_RELATIONSHIP.FIT;	
		GuiElementAlignToParent();
	}
	
	/// @function GuiElementSetAlignmentToParent
	/// @param parent_anchor_corner
	/// @param self_anchor_corner
	/// @param [x_offset]
	/// @param [y_offset]
	static GuiElementSetAlignmentToParent = function(_parent_anchor_corner, _self_anchor_corner, _x_offset=0, _y_offset=0)
	{
		parent_relationship = PARENT_RELATIONSHIP.ALIGN;
		parent_anchor_corner = _parent_anchor_corner;
		self_anchor_corner = _self_anchor_corner;
		parent_alignment_x_offset = _x_offset;
		parent_alignment_y_offset = _y_offset;
		GuiElementAlignToParent();
	}
	
	/// @function GuiElementAlignToParent
	static GuiElementAlignToParent = function()
	{
		if(parent_element == -1)
			return;
		if(parent_relationship == PARENT_RELATIONSHIP.FIT)
		{
			var _x = parent_element.x + parent_element.padding_h;
			var _y = parent_element.y + parent_element.padding_v;
			var _w = parent_element.width - parent_element.padding_h * 2;
			var _h = parent_element.height - parent_element.padding_v * 2;
			GuiElementMoveTo(_x,_y);
			GuiElementResize(_w,_h);
		}
		else if(parent_relationship == PARENT_RELATIONSHIP.ALIGN)
		{
			var _x = parent_element.x+parent_alignment_x_offset;
			var _y = parent_element.y+parent_alignment_y_offset;
			switch(parent_anchor_corner)
			{
				case CORNER.TOP_RIGHT:
					_x += parent_element.width;
					break;
				case CORNER.BOTTOM_LEFT:
					_y += parent_element.height;
					break;
				case CORNER.BOTTOM_RIGHT:
					_x += parent_element.width;
					_y += parent_element.height;
					break;
			}
			switch(self_anchor_corner)
			{
				case CORNER.TOP_RIGHT:
					_x -= width;
					break;
				case CORNER.BOTTOM_LEFT:
					_y -= height;
					break;
				case CORNER.BOTTOM_RIGHT:
					_x -= width;
					_y -= height;
					break;	
			}
			GuiElementMoveTo(_x,_y);
		}
	}
	
	/// @function GuiElementSetDepth
	/// @param depth
	static GuiElementSetDepth = function(_depth)
	{
		if(_depth == depth)
			return;
			
		depth = _depth;
		
		// Ensure the element is in the correct place in the Gui's element list
		gui.GuiRemoveElement(self);
		gui.GuiAddElement(self);
	}
	
	/// @function GuiElementMoveTo
	/// @param x
	/// @param y
	static GuiElementMoveTo = function(_x, _y)
	{
		if(_x == x && _y == y)
			return;
		var _previous_x = x;
		var _previous_y = y;
		x = _x;
		y = _y;
		
		//Align child elements
		for(var _child_index=0; _child_index<child_elements.ListSize(); _child_index++)
		{
			child_elements.ListGet(_child_index).GuiElementAlignToParent();
		}
		
		if(GuiElementOnMove != -1)
		{
			GuiElementOnMove(_previous_x, _previous_y);	
		}
	}
	
	/// @function GuiElementResize
	/// @param width
	/// @param height
	static GuiElementResize = function(_width, _height)
	{
		if(_width == width && _height == height)
			return;
		var _previous_width = width;
		var _previous_height = height;
		width = _width;
		height = _height;
		
		//Align child elements
		for(var _child_index=0; _child_index<child_elements.ListSize(); _child_index++)
		{
			child_elements.ListGet(_child_index).GuiElementAlignToParent();
		}
		
		if(GuiElementOnResize != -1)
		{
			GuiElementOnResize(_previous_width,_previous_height);	
		}
	}
	
	/// @function GuiElementIsHovered
	static GuiElementIsHovered = function()
	{
		return (gui.hover_element == self);	
	}
	
	/// @function GuiElementIsSelected
	static GuiElementIsSelected = function()
	{
		return (gui.selected_element == self);	
	}
	
	/// @function GuiElementGetLeft
	static GuiElementGetLeft = function()
	{
		return x;	
	}
	
	/// @function GuiElementGetTop
	static GuiElementGetTop = function()
	{
		return y;	
	}
	
	/// @function GuiElementGetRight
	static GuiElementGetRight = function()
	{
		return x+width;	
	}
	
	/// @function GuiElementGetBottom
	static GuiElementGetBottom = function()
	{
		return y+height;	
	}
}
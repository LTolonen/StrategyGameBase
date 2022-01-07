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
	
	parent_element = -1;
	child_elements = new List();
	
	gui.GuiAddElement(self);
	
	static GuiElementDraw = -1;
	static GuiElementUpdate = -1;
	static GuiElementOnDestroy = -1;
	static GuiElementOnResize = -1;
	static GuiElementOnClick = -1;
	static GuiElementOnClickDown = -1;
	static GuiElementOnHover = -1;
	static GuiElementOnUnhover = -1;
	static GuiElementOnDeselect = -1;
	static GuiElementOnEnterGuiState = array_create(GUI_STATE_TYPE.COUNT,-1);
	
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
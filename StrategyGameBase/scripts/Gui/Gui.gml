/// @function Gui
function Gui() constructor
{
	elements = new List();
	
	hover_element = -1;
	selected_element = -1;
	left_clicked_element = -1;
	
	input_provider = new InputProvider();
	game_event_queue = new List();
	
	
	gui_state = -1;
	GuiEnterState(new GuiState(self,GUI_STATE_TYPE.NONE));
	
	/// @function ObserverOnNotify
	/// @param game_event
	static ObserverOnNotify = function(_game_event)
	{
		game_event_queue.ListAdd(_game_event);
	}
	
	/// @function GuiAddElement
	/// @function element
	/*
		Adds a GUI Element to the GUI.
		The element is inserted in the element list such that the list is in descending order by depth
	*/
	static GuiAddElement = function(_element)
	{
		var _index = 0;
		for(var i=elements.ListSize()-1; i>=0; i--)
		{
			if(elements.ListGet(i).depth >= _element.depth)
			{
				_index = i+1;
				break;
			}
		}
		elements.ListInsert(_element,_index);
	}
	
	/// @function GuiRemoveElement
	/// @param element
	static GuiRemoveElement = function(_element)
	{
		elements.ListRemoveItem(_element);
	}
	
	/// @function GuiProcessInput
	/*
		Should be called each frame in the Begin Step Event
	*/
	static GuiProcessInput = function()
	{
		if(mouse_check_button_released(mb_left))
		{
			if(left_clicked_element != -1 && left_clicked_element.is_active && left_clicked_element.GuiElementOnClick != -1)
			{
				left_clicked_element.GuiElementOnClick();	
			}
			left_clicked_element = -1;
		}
		
		var _previous_hover_element = hover_element;
		hover_element = -1;
		for(var i=elements.ListSize()-1; i>=0; i--)
		{
			var _element = elements.ListGet(i);
			if(!_element.is_active || !_element.is_hoverable)
				continue;
			
			if(point_in_rectangle(mouse_x,mouse_y,_element.GuiElementGetLeft(),_element.GuiElementGetTop(),_element.GuiElementGetRight(),_element.GuiElementGetBottom()))
			{
				hover_element = _element;
				break;
			}
		}
		
		if(left_clicked_element != hover_element)
			left_clicked_element = -1;
			
		if(_previous_hover_element != hover_element)
		{
			if(_previous_hover_element != -1 && _previous_hover_element.is_active && _previous_hover_element.GuiElementOnHover != -1)
			{
				_previous_hover_element.GuiElementOnUnhover();	
			}
			if(hover_element != -1 && hover_element.GuiElementOnHover != -1)
				hover_element.GuiElementOnHover();
		}
		
		if(mouse_check_button_pressed(mb_left))
		{
			var _previous_selected_element = selected_element;
			if(hover_element == -1)
			{
				selected_element = -1;
			}
			else if(hover_element.is_selectable)
			{
				selected_element = hover_element;
				left_clicked_element = hover_element;
				if(left_clicked_element.GuiElementOnClickDown != -1)
				{
					left_clicked_element.GuiElementOnClickDown();	
				}
			}
			
			if(_previous_selected_element != selected_element)
			{
				if(_previous_selected_element != -1 && _previous_selected_element.is_active && _previous_selected_element.GuiElementOnDeselect != -1)
				{
					_previous_selected_element.GuiElementOnDeselect();	
				}
			}
		}
	}
	
	/// @function GuiUpdate
	/*
		Should be called each frame in the Step Event
	*/
	static GuiUpdate = function()
	{
		if(gui_state.GuiStateUpdate != -1)
			gui_state.GuiStateUpdate();
			
		//Copy the list of elements to iterate over in case the list gets updated during iteration
		var _elements_to_update = elements.ListCopy();
		for(var i=0; i<_elements_to_update.ListSize(); i++)
		{
			var _element = _elements_to_update.ListGet(i);
			if(!_element.is_active || _element.GuiElementUpdate == -1)
				continue;
			_element.GuiElementUpdate();
		}
	}
	
	/// @function GuiDraw
	/*
		Should be called each frame in the Draw Event
	*/
	static GuiDraw = function()
	{
		for(var i=0; i<elements.ListSize(); i++)
		{
			var _element = elements.ListGet(i);
			if(!_element.is_active || !_element.is_visible || _element.GuiElementDraw == -1)
				continue;
			_element.GuiElementDraw();
		}
	}
	
	/// @function GuiEnterState
	/// @param gui_state
	static GuiEnterState = function(_gui_state)
	{
		if(gui_state == _gui_state)
			return;
		gui_state = _gui_state;
		for(var i=0; i<elements.ListSize(); i++)
		{
			var _element = elements.ListGet(i);
			if(!_element.is_active)
				continue;
			if(_element.GuiElementOnEnterGuiState[_gui_state.gui_state_type] != -1)
			{
				_element.GuiElementOnEnterGuiState[_gui_state.gui_state_type](_gui_state);
			}
		}
	}
}
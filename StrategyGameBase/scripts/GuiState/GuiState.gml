enum GUI_STATE_TYPE
{
	NONE,
	COUNT
}

/// @function GuiState
/// @param gui
/// @param gui_state_type
function GuiState(_gui,_gui_state_type) constructor
{
	gui = _gui;
	gui_state_type = _gui_state_type;
	
	static GuiStateUpdate = -1;
}
enum GAME_EVENT_TYPE
{
	INPUT_REQUESTED,
	COUNT	
}

/// @function GameEvent
/// @param game_event_type
function GameEvent(_game_event_type) constructor
{
	game_event_type = _game_event_type;
}
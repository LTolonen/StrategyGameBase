/// @function GameController
/// @param 
function GameController() constructor
{
	input_provider = -1;
	current_input_request = -1
	game_state = new GameState();
	
	GameControllerOnInput = array_create(INPUT_TYPE.COUNT,-1);
	
	/// @function GameControllerInit
	static GameControllerInit = function()
	{
		game_state.GameStateInit();
		GameControllerRequestInput(new InputRequest(INPUT_REQUEST_TYPE.MAIN));
	}
	
	/// @function GameControllerRequestInput
	/// @param input_request
	static GameControllerRequestInput = function(_input_request)
	{
		current_input_request = _input_request;
		if(input_provider == -1)
			return;
		
		input_provider.current_input_request = _input_request;
		
		game_state.GameEventSubjectNotify(new InputRequestedGameEvent(_input_request));
	}
	
	/// @function GameControllerProcessInput
	/// @param input
	static GameControllerProcessInput = function(_input)
	{
		if(current_input_request == -1)
			return false; 
			
		if(!current_input_request.InputRequestValidateInput(_input,game_state))
			return false;
			
		if(GameControllerOnInput[_input.input_type] == -1)
			return false;
		
		current_input_request = -1;
		
		GameControllerOnInput[_input.input_type](_input);
		return true;
	}
}
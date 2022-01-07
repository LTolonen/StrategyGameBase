enum INPUT_REQUEST_TYPE
{
	MAIN,
	COUNT	
}

/// @function InputRequest
/// @param input_request_type
function InputRequest(_input_request_type) constructor
{
	input_request_type = _input_request_type;
	
	/// @function InputRequestValidateInput
	/// @param input
	/// @param game_state
	/*
		This function should be implemented for each type of InputRequest
		Return true if the input is valid on the GameState and false if not
	*/
	static InputRequestValidateInput = function(_input, _game_state)
	{
		return true;	
	}
}
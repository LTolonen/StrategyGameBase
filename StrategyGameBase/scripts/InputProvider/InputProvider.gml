/// @function InputProvider
function InputProvider() constructor
{
	controller = -1;
	current_input_request = -1;
	
	/// @function InputProviderRegister
	/// @param controller
	static InputProviderRegister = function(_controller)
	{
		if(_controller.input_provider != -1)
			throw "Attempted to register InputProvider to Controller that already has an InputProviderRegistered";
		if(controller != -1)
		{
			controller.input_provider = -1;	
		}
		controller = _controller;
		controller.input_provider = self;
	}
	
	/// @function InputProviderProvideInput
	/// @param input
	static InputProviderProvideInput = function(_input)
	{
		if(controller == -1)
			throw "Attempted to provide input without a controller";
		if(current_input_request == -1)
			throw "Attempted to provide input without an InputRequest";
		
		var _result = true;
		return _result;
	}
}
/// @function GameEventSubject
function GameEventSubject()
{
	observers = new List();
	
	/// @function GameEventSubjectAddObserver
	/// @param observer
	static GameEventSubjectAddObserver = function(_observer)
	{
		if(observers.ListFindItemIndex(_observer) != -1)
			return;
		observers.ListAdd(_observer);
	}
	
	/// @function GameEventSubjectRemoveObserver
	/// @param observer
	static GameEventSubjectRemoveObserver = function(_observer)
	{
		observers.ListRemoveItem(_observer);
	}
	
	/// @function GameEventSubjectNotify
	/// @param game_event
	static GameEventSubjectNotify = function(_game_event)
	{
		for(var i=0; i<observers.ListSize(); i++)
		{
			observers.ListGet(i).ObserverOnNotify(_game_event);
		}
	}
}
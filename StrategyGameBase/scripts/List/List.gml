/// @function List
function List() constructor
{
	num_items = 0;
	items = array_create(0);
	
	/// @function ListAddItem
	/// @param item
	static ListAddItem = function(_item)
	{
		items[num_items++] = _item;
	}
	
	/// @function ListGet
	/// @param index
	static ListGet = function(_index)
	{
		return items[_index];
	}
	
	/// @function ListFindItemIndex
	/// @param item
	static ListFindItemIndex = function(_item)
	{
		for(var i=0; i<num_items; i++)
		{
			if(items[i] == _item)
				return i;
		}
		return -1;
	}
	
	/// @function ListRemoveItemAtIndex
	/// @param index
	static ListRemoveItemAtIndex = function(_index)
	{
		array_delete(items,_index,1);
		num_items--;
	}
	
	/// @function ListRemoveItem
	/// @param item
	static ListRemoveItem = function(_item)
	{
		var _item_index = ListFindItemIndex(_item);
		if(_item_index == -1)
			return;
		ListRemoveItemAtIndex(_item_index);
	}
	
	/// @function ListEmpty
	static ListEmpty = function()
	{
		num_items = 0;
		items = array_create(0);
	}
	
	/// @function ListShuffle
	static ListShuffle = function()
	{
		//Knuth Fisher-Yates shuffle
		for(var i=num_items-1; i>=0; i--)
		{
			var j = irandom_range(0,i);
			var _temp_item = items[j];
			items[i] = items[j];
			items[j] = _temp;
		}
	}
	
	/// @function ListCopy
	static ListCopy = function()
	{
		var _copy = new List();
		_copy.num_items = num_items;
		array_copy(_copy.items,0,items,0,num_items);
		return _copy;
	}
}
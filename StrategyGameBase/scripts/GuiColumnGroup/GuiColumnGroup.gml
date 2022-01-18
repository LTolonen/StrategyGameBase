/// @function GuiColumnGroup
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
function GuiColumnGroup(_gui, _depth, _x, _y, _width, _height) : GuiElement(_gui, _depth, _x, _y, _width, _height) constructor
{
	column_separation = 0;

	fixed_width_total = 0;
	weighting_total = 0;
	
	columns = new List();
	
	static GuiElementOnDestroy = function()
	{
		//Destroy the columns when the column group is destroyed
		for(var _column_index=0; _column_index<columns.ListSize(); _column_index++)
		{
			var _column = columns.ListGet(_column_index);
			_column.GuiElementDestroy();
		}
	}
	
	static GuiElementOnResize = function()
	{
		GuiColumnGroupAlignColumns();	
	}
	static GuiElementOnMove = function()
	{
		GuiColumnGroupAlignColumns();	
	}
	
	/// @function GuiColumnGroupAlignColumns
	static GuiColumnGroupAlignColumns = function()
	{
		var _remaining_width = width - padding_h * 2 - column_separation * (columns.ListSize()-1) - fixed_width_total;
		var _column_y = y+padding_v;
		var _column_height = height - padding_v * 2;
		var _next_column_x = x+padding_h;
		
		for(var _column_index=0; _column_index<columns.ListSize(); _column_index++)
		{
			var _column = columns.ListGet(_column_index);
			_column.GuiElementMoveTo(_next_column_x,_column_y);
			var _column_width;
			if(_column.is_fixed_width)
				_column_width = _column.fixed_width;
			else
				_column_width = _remaining_width * _column.weighting / weighting_total;
			_column.GuiElementResize(_column_width,_column_height);
			_next_column_x += column_separation + _column_width;
		}
	}
	
	/// @function GuiColumnGroupAddFixedColumn
	/// @param width
	static GuiColumnGroupAddFixedColumn = function(_width)
	{
		var _column = new GuiColumn(gui,depth,_width,);
		columns.ListAdd(_column);
		fixed_width_total += _width;
		GuiColumnGroupAlignColumns();
		return _column;
	}
	
	/// @function GuiColumnGroupAddWeightedColumn
	/// @param weighting
	static GuiColumnGroupAddWeightedColumn = function(_weighting)
	{
		var _column = new GuiColumn(gui,depth,,_weighting);
		columns.ListAdd(_column);
		weighting_total += _weighting;
		GuiColumnGroupAlignColumns();
		return _column;
	}
	
	/// @function GuiColumnGroupGetNumColumns
	static GuiColumnGroupGetNumColumns = function()
	{
		return columns.ListSize();	
	}
	
	/// @function GuiColumnGroupGetNumColumn
	/// @param column_index
	static GuiColumnGroupGetColumn = function(_column_index)
	{
		return columns.ListGet(_column_index);	
	}
}
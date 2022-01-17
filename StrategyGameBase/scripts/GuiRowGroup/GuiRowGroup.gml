/// @function GuiRowGroup
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
function GuiRowGroup(_gui, _depth, _x, _y, _width, _height) : GuiElement(_gui, _depth, _x, _y, _width, _height) constructor
{
	row_separation = 0;

	fixed_height_total = 0;
	weighting_total = 0;
	
	rows = new List();
	
	static GuiElementOnResize = function()
	{
		GuiRowGroupAlignRows();	
	}
	static GuiElementOnMove= function()
	{
		GuiRowGroupAlignRows();	
	}
	
	/// @function GuiRowGroupAlignRows
	static GuiRowGroupAlignRows = function()
	{
		var _remaining_height = height - padding_v * 2 - row_separation * (rows.ListSize()-1) - fixed_height_total;
		var _row_x = x+padding_h;
		var _row_width = width - padding_h * 2;
		var _next_row_y = y+padding_v;
		
		for(var _row_index=0; _row_index<rows.ListSize(); _row_index++)
		{
			var _row = rows.ListGet(_row_index);
			_row.GuiElementMoveTo(_row_x,_next_row_y);
			var _row_height;
			if(_row.is_fixed_height)
				_row_height = _row.fixed_height;
			else
				_row_height = _remaining_height * _row.weighting / weighting_total;
			_row.GuiElementResize(_row_width, _row_height);
			_next_row_y += row_separation + _row_height;
		}
	}
	
	/// @function GuiRowGroupAddFixedRow
	/// @param height
	static GuiRowGroupAddFixedRow = function(_height)
	{
		var _row = new GuiRow(gui,depth,_height,);
		rows.ListAdd(_row);
		fixed_height_total += _height;
		return _row;
	}
	
	/// @function GuiRowGroupAddWeightedRow
	/// @param weighting
	static GuiRowGroupAddWeightedRow = function(_weighting)
	{
		var _row = new GuiRow(gui,depth,,_weighting);
		rows.ListAdd(_row);
		weighting_total += _weighting;
		return _row;
	}
	
	/// @function GuiRowGroupGetNumRows
	static GuiRowGroupGetNumRows = function()
	{
		return rows.ListSize();	
	}
	
	/// @function GuiRowGroupGetRow
	/// @param row_index
	static GuiRowGroupGetRow = function(_row_index)
	{
		return rows.ListGet(_row_index);	
	}
}
/// @function SpriteToken
/// @param sprite_index
/// @param image_index
/// @param [colour]
function SpriteToken(_sprite_index, _image_index, _colour = -1) : Token(TOKEN_TYPE.SPRITE) constructor
{
	sprite_index = _sprite_index;
	image_index = _image_index;
	colour = _colour;
	width = sprite_get_width(sprite_index)
	height = sprite_get_height(sprite_index);
	
	static TokenDraw = function(_x, _y)
	{
		if(colour != -1)
		{
			gpu_set_fog(true,colour,0,0);
			draw_sprite(sprite_index,image_index,_x,_y);
			gpu_set_fog(false,colour,0,0);
		}
		else
			draw_sprite(sprite_index,image_index,_x,_y);
	}
}
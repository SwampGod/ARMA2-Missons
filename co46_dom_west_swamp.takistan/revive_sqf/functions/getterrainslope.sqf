//Last modified 11/8/7
//Returns an average slope value of terrain within passed radius.
Private["_centerHeight","_direction","_height","_position","_radius"];
_position = _this Select 0;
_radius = _this Select 1;

GetSlopeObject SetPos _position;
_centerHeight = GetPosASL GetSlopeObject Select 2;
_height = 0;
_direction = 0;

for "_count" from 1 to 8 do {
	GetSlopeObject SetPos [(_position Select 0)+((sin _direction)*_radius),(_position Select 1)+((cos _direction)*_radius),0];
	_direction = _direction + 45;
	_height = _height + abs (_centerHeight - (GetPosASL GetSlopeObject Select 2));
};

_height / 8
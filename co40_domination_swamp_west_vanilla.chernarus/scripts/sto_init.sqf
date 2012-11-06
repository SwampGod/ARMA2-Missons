// STO_init.sqf
// © FEBRUARY 2010 - norrin

_plane 		= _this select 0;
_speedThen  = 0;

while {alive _plane} do
{	
	while {!local _plane} do {sleep 1;};
	_speenThen = (speed _plane) + 2;
	sleep 2;
	if (getPos _plane select 2 < 5 && getPos _plane select 2 < 50 && !isNull (driver _plane) && (speed _plane) > _speedThen && speed _plane > 5) then 
	{	
		_dir = getDir _plane;
		_plane setVelocity [(velocity _plane select 0) + (4 * (sin _dir)), (velocity _plane select 1) + (4 * (cos _dir)), velocity _plane select 2];
		//hintSilent "boost";
	};
};


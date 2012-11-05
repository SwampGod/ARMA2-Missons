/*
ONCONNECT SCRIPT

© JULY 2009 - norrin
*/
_heal_yourself = NORRN_revive_array select 8;
_AI_disabled = getNumber(missionConfigFile >> "disabledAI");
// @NORRIN:     THE MISSIONCONFIG ENTRY IS NAMED disabledAI AND NOT AIdisabled, Xeno

if (!isDedicated) then {
	if (!isNull player && !alive player) exitWith {titleText ["Unit selected is dead please press escape, return to the unit selection menu and choose the same or another playable unit", "BLACK FADED", 5]};

	if (!isNull player && player distance getMarkerPos "Boot_Hill" < 50) exitWith {titleText ["Unit selected is dead please press escape, return to the unit selection menu and choose the same or another playable unit", "BLACK FADED", 10]};
	if (!isNull player && (player distance getMarkerPos "respawn_west" < 50 || player distance getMarkerPos "respawn_east" < 50 || player distance getMarkerPos "respawn_guerrila" < 50 || player distance getMarkerPos "respawn_civilian" < 50)) exitWith {
		titleText ["Unit selected is unconscious please press escape, return to the unit selection menu and choose another playable unit", "BLACK FADED", 10]
	};
	r_name_player = name player;
};

// if (isServer && !local player) then {
	// if (_AI_disabled == 0) then {
		// {if (!isNull (missionNamespace getVariable _x)) then {[missionNamespace getVariable _x, NORRN_player_units] execVM "revive_sqf\Revive_player.sqf"}}forEach NORRN_player_units;
	// };
// };

// {if (_AI_disabled == 0 && !isNull (missionNamespace getVariable _x) && (missionNamespace getVariable _x) in (units (group player))) then {[missionNamespace getVariable _x, NORRN_player_units] execVM "revive_sqf\Revive_player.sqf"}}forEach NORRN_player_units;

if (!isDedicated) then {
	//if (_AI_disabled == 1) then {[player, NORRN_player_units] execVM "revive_sqf\Revive_player.sqf"};
	[player, NORRN_player_units] execVM "revive_sqf\Revive_player.sqf";

	if (_heal_yourself == 1) then {[player] execVM "revive_sqf\heal_sqf\player_heal.sqf"};
};

MouseEvents = {
	_x =0;
	_y =0;
	_param = _this select 1;
	_type = _this select 0;
	switch (_type) do {
		case "MouseMoving": {
			_x = _param select 1;
			_y = _param select 2;
			OFPEC_MouseCoord = [_x, _y];
		};
		case "MouseButtonDown": {
			_x = _param select 2;
			_y = _param select 3;
			_button = _param select 1;
			OFPEC_MouseButtons set[_button, true];
		};
		case "MouseButtonUp": {
			_x = _param select 2;
			_y = _param select 3;
			_button = _param select 1;
			OFPEC_MouseButtons set[_button, false];
		};
		case "MouseZChanged": {
			if (((_this select 1) select 1) > 0) then {
				if (OFPEC_range_to_unit > 2) then {
					OFPEC_range_to_unit = OFPEC_range_to_unit - OFPEC_camzoomspeed;
				};
			} else {
				if (OFPEC_range_to_unit < OFPEC_maxzoomout) then {
					OFPEC_range_to_unit = OFPEC_range_to_unit + OFPEC_camzoomspeed;
				};
			};
		};
	};
};
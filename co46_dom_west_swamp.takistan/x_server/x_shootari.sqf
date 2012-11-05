// by Xeno
#include "x_setup.sqf"
private ["_angle","_center_x","_center_y","_height","_i","_number_shells","_pos_enemy","_radius","_type","_wp_array","_x1","_xo","_y1","_kind"];
if (!isServer) exitWith {};

_pos_enemy = _this select 0;
_kind = _this select 1;

_radius = 30;
_height = switch (_kind) do {case 0: {150};case 1: {150}; case 2: {1}};

_center_x = (_pos_enemy) select 0;
_center_y = (_pos_enemy) select 1;

_type = if (d_enemy_side == "EAST") then {
	if (_kind == 0) then {"G_40mm_HE"};
#ifndef __ACE__
	if (_kind == 1) then {"ARTY_Sh_105_HE"} else {"ARTY_SmokeShellWhite"};
#else
	if (_kind == 1) then {"ACE_ARTY_Sh_105_HE"} else {"ACE_ARTY_SmokeShellWhite"}
#endif
} else {
	if (_kind == 0) then {"G_30mm_HE"};
#ifndef __ACE__
	if (_kind == 1) then {"ARTY_Sh_122_HE"} else {"ARTY_SmokeShellWhite"}
#else
	if (_kind == 1) then {"ACE_ARTY_Sh_122_HE"} else {"ACE_ARTY_SmokeShellWhite"}
#endif
};


if (_kind in [0,1]) then {
	_number_shells = 3 + (ceil random 3);
#ifdef __TT__
	if ((floor random 3) == 0) then {["doarti", _pos_enemy] call XNetCallEvent};
#else
	if ((__XJIPGetVar(d_searchintel) select 5) == 1) then {["doarti", _pos_enemy] call XNetCallEvent};
#endif
} else {
	_number_shells = 1;
}; 

_wp_array = [];
while {count _wp_array < _number_shells} do {
	_angle = floor random 360;
	_x1 = _center_x - ((random _radius) * sin _angle);
	_y1 = _center_y - ((random _radius) * cos _angle);
	_wp_array set [count _wp_array, [_x1, _y1, _height]];
	sleep 0.0153;
};
sleep 9.25 + (random 8);
private ["_trails", "_netshell"];
if (_kind == 1) then {
#ifndef __ACE__
	_trails = getText (configFile >> "CfgAmmo" >> _type >> "ARTY_TrailFX");
	_netshell = getText (configFile >> "CfgAmmo" >> _type >> "ARTY_NetShell");
#else
	_trails = getText (configFile >> "CfgAmmo" >> _type >> "ACE_ARTY_TrailFX");
	_netshell = getText (configFile >> "CfgAmmo" >> _type >> "ACE_ARTY_NetShell");
#endif
};
for "_i" from 0 to (_number_shells - 1) do {
	_shell = createVehicle [_type, (_wp_array select _i), [], 0, "NONE"];
	_shell setVelocity [0,0,-150];
	if (_kind == 1) then {["d_artyt", [getPosASL _shell, _trails, _netshell]] call XNetCallEvent};
	_xo = ceil random 10;
	 sleep 0.923 + (_xo / 10);
};

_wp_array = nil;
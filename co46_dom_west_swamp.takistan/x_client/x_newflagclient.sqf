// by Xeno
#include "x_setup.sqf"
private ["_box", "_flag"];
if (!X_Client) exitWith {};

_flag = _this;

[format ["d_paraflag%1", count __XJIPGetVar(resolved_targets)], position _flag,"ICON","ColorYellow",[0.5,0.5],"Parajump",0,"mil_flag"] call XfCreateMarkerLocal;
player reveal _flag;

if (d_jumpflag_vec == "") then {
	_flag addAction ["(Choose Parachute location)" call XBlueText,"AAHALO\x_paraj.sqf"];
} else {
	_flag addAction [(format ["(Create %1)",[d_jumpflag_vec,0] call XfGetDisplayName]) call XBlueText,"x_client\x_bike.sqf",[d_jumpflag_vec,1]];
};

#ifdef __ACE__
if (d_jumpflag_vec == "") then {
	_box = "ACE_RuckBox" createVehicleLocal (position _flag);
	clearMagazineCargo _box;
	clearWeaponCargo _box;
	_box addweaponcargo ["ACE_ParachutePack",10];
};
#endif
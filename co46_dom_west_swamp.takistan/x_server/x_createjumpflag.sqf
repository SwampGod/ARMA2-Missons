// by Xeno
#include "x_setup.sqf"
private ["_posi", "_ftype", "_flag", "_jump_flags"];
if (!isServer) exitWith {};

// create random position
_posi = [d_old_target_pos, d_old_radius select 0] call XfGetRanPointCircleOld;
while {count _posi == 0} do {
	_posi = [d_old_target_pos, d_old_radius select 0] call XfGetRanPointCircleOld;
	sleep 0.04;
};

if (count _posi > 0) then {
	_flag = createVehicle [(call XfGetOwnFlagType), _posi, [], 0, "NONE"];
	_jump_flags = __XJIPGetVar(jump_flags);
	_jump_flags set [count _jump_flags, _flag];
	["jump_flags",_jump_flags] call XNetSetJIP;
	
	["d_n_jf", _flag] call XNetCallEvent;
	_s = if (d_jumpflag_vec == "") then {"NewJumpFlag"} else {"NewJumpVehFlag"};
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,_s,true];
};
// by Xeno
#define THIS_FILE "x_recruitaiaction.sqf"
#include "x_setup.sqf"
private ["_grpplayer", "_exitj", "_rank", "_target"];

_grpplayer = group player;

if (player != leader _grpplayer) exitWith {
	"You are currently not a group leader, no AI available. Create a new group!" call FUNC(HQChat);
};

PARAMS_1(_target);

if (player distance _target > 50) exitWith {
	"You are too far away from the AI recruit building!" call FUNC(HQChat);
};

GVAR(current_ai_num) = 0;
{
	if (!isPlayer _x && alive _x) then {
		__INC(GVAR(current_ai_num));
	};
} forEach units _grpplayer;

createDialog "XD_AIRecruitDialog";
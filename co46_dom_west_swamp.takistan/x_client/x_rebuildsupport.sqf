// by Xeno
#include "x_setup.sqf"
private ["_id", "_facindex", "_no"];

_id = _this select 2;
_facindex = _this select 3;

if (d_with_ranked && (score player < (d_ranked_a select 13))) exitWith {
	(format ["You need %2 points to rebuild a factory, your current score is: %1!", score player,(d_ranked_a select 13)]) call XfHQChat;
};
if (d_with_ranked) then {["d_pas", [player, (d_ranked_a select 13) * -1]] call XNetCallEvent};

player removeAction _id;

["d_del_ruin", (d_aircraft_facs select _facindex) select 0] call XNetCallEvent;
sleep 1.021;

"Rebuilding support building. This will take some time..." call XfHQChat;

["d_f_ru_i", _facindex] call XNetCallEvent;
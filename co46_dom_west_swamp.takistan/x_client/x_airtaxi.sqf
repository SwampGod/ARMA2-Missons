// by Xeno
#include "x_setup.sqf"
private "_exitj";
if (!X_Client) exitWith {};

if (!d_heli_taxi_available) exitWith {"An air taxi is allready on the way to your position!" call XfHQChat};

if (FLAG_BASE distance player < 500) exitWith {"You are less than 500 m away from the base, no air taxi for you!" call XfHQChat};

_exitj = false;
if (d_with_ranked) then {
	if (score player < (d_ranked_a select 15)) exitWith {
		(format ["You can't call an air taxi. You need %2 points for that, your score is %1!", score player,(d_ranked_a select 15)]) call XfHQChat;
		_exitj = true;
	};
	["d_pas", [player, (d_ranked_a select 15) * -1]] call XNetCallEvent;
};

if (_exitj) exitWith {};

[player, "Calling in air taxi..."] call XfSideChat;

sleep 5;

"Air taxi will start in a few seconds, stand by. Stay at your position!" call XfHQChat;

d_heli_taxi_available = false;

["d_air_taxi", player] call XNetCallEvent;
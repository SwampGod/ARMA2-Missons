// by Xeno
#define THIS_FILE "x_airtaxi.sqf"
#include "x_setup.sqf"
private "_exitj";
if (!X_Client) exitWith {};

if (!GVAR(heli_taxi_available)) exitWith {"An air taxi is allready on the way to your position!" call FUNC(HQChat)};

if (FLAG_BASE distance player < 500) exitWith {"You are less than 500 m away from the base, no air taxi for you!" call FUNC(HQChat)};

_exitj = false;
if (GVAR(with_ranked)) then {
	if (score player < (GVAR(ranked_a) select 15)) exitWith {
		(format ["You can't call an air taxi. You need %2 points for that, your score is %1!", score player, GVAR(ranked_a) select 15]) call FUNC(HQChat);
		_exitj = true;
	};
	[QGVAR(pas), [player, (GVAR(ranked_a) select 15) * -1]] call FUNC(NetCallEvent);
};

if (_exitj) exitWith {};

[player, "Calling in air taxi..."] call FUNC(SideChat);

sleep 5;

"Air taxi will start in a few seconds, stand by. Stay at your position!" call FUNC(HQChat);

GVAR(heli_taxi_available) = false;

[QGVAR(air_taxi), player] call FUNC(NetCallEvent);
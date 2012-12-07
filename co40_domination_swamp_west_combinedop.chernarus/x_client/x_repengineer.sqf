// by Xeno
#define THIS_FILE "x_repengineer.sqf"
#include "x_setup.sqf"
private ["_aid","_caller","_coef","_damage","_damage_ok","_damage_val","_fuel","_fuel_ok","_fuel_val","_rep_count","_breaked_out","_rep_action","_type_name", "_exitit"];

_caller = _this select 1;
_aid = _this select 2;

_truck_near = false;
if (player distance TR7 < 21 || player distance TR8 < 21) then {_truck_near = true};
if (!GVAR(eng_can_repfuel) && !_truck_near) exitWith {
	hintSilent "You have to restore your repair/refuel capability at base first or take one of the two Salvage trucks with you.";
};

_exitit = false;
if (GVAR(with_ranked)) then {
	if (score player < (GVAR(ranked_a) select 0)) then {
		(format ["You need %2 points to repair/refuel a vehicle, your current score is: %1!", score player,(GVAR(ranked_a) select 0)]) call FUNC(HQChat);
		_exitit = true;
	};
	if (_exitit) exitWith {};
	if (time >= GVAR(last_base_repair)) then {GVAR(last_base_repair) = -1};
};
if (_exitit) exitWith {};

if (GVAR(with_ranked) && (player in (list GVAR(engineer_trigger)) && GVAR(last_base_repair) != -1)) exitWith {
	"You have to wait until you can repair a vehicle at base again." call FUNC(HQChat);
};

if (GVAR(with_ranked)) then {if (player in (list GVAR(engineer_trigger))) then {GVAR(last_base_repair) = time + 300}};

_caller removeAction _aid;
if !(local _caller) exitWith {};

#ifdef __ACE__
if (GVAR(objectID2) isKindOf "Tank" || GVAR(objectID2) isKindOf "Wheeled_APC") exitWith {hint "Not possible for a tank or wheeled APC!"};
#endif

_rep_count = switch (true) do {
	case (GVAR(objectID2) isKindOf "Air"): {0.1};
	case (GVAR(objectID2) isKindOf "Tank"): {0.2};
	default {0.3};
};

_fuel = fuel GVAR(objectID2);
_damage = damage GVAR(objectID2);

_damage_val = _damage / _rep_count;
_fuel_val = (1 - _fuel) / _rep_count;
_coef = switch (true) do {
	case (_fuel_val > _damage_val): {_fuel_val};
	default {_damage_val};
};
_coef = ceil _coef;

hintSilent format ["Vehicle status:\n---------------------\nFuel: %1\nDamage: %2",_fuel, _damage];
_type_name = [typeOf (GVAR(objectID2)),0] call FUNC(GetDisplayName);
(format ["Repairing and refuelling %1... Stand by", _type_name]) call FUNC(GlobalChat);
_damage_ok = false;
_fuel_ok = false;
GVAR(cancelrep) = false;
_breaked_out = false;
_breaked_out2 = false;
_rep_action = player addAction["Cancel Service" call FUNC(RedText),"x_client\x_cancelrep.sqf"];
for "_wc" from 1 to _coef do {
	if (!alive player || GVAR(cancelrep)) exitWith {player removeAction _rep_action};
	"Still working..." call FUNC(GlobalChat);
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 3.0;
	waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
	if (GVAR(cancelrep)) exitWith {_breaked_out = true};
	if (vehicle player != player) exitWith {
		_breaked_out2 = true;
		hintSilent "You have entered a vehicle, service canceled";
	};
	if (!_fuel_ok) then {_fuel = _fuel + _rep_count};
	if (_fuel >= 1 && !_fuel_ok) then {_fuel = 1;_fuel_ok = true};
	if (!_damage_ok) then {_damage = _damage - _rep_count};
	if (_damage <= 0.01 && !_damage_ok) then {_damage = 0;_damage_ok = true};
	hintSilent format ["Vehicle status:\n---------------------\nFuel: %1\nDamage: %2",_fuel, _damage];
};
if (_breaked_out) exitWith {
	"Service canceled..." call FUNC(GlobalChat);
	player removeAction _rep_action;
};
if (_breaked_out2) exitWith {};
GVAR(eng_can_repfuel) = false;
player removeAction _rep_action;
if (!alive player) exitWith {player removeAction _rep_action};
if (GVAR(with_ranked)) then {
	_parray = GVAR(ranked_a) select 1;
	_addscore = switch (true) do {
		case (GVAR(objectID2) isKindOf "Air"): {_parray select 0};
		case (GVAR(objectID2) isKindOf "Tank"): {_parray select 1};
		case (GVAR(objectID2) isKindOf "Car"): {_parray select 2};
		default {_parray select 3};
	};
	if (_addscore > 0) then {
		[QGVAR(pas), [player, _addscore]] call FUNC(NetCallEvent);
		(format ["You get %1 point(s) for repairing/refueling!", _addscore]) call FUNC(HQChat);
	};
};
[QGVAR(rep_ar), GVAR(objectID2)] call FUNC(NetCallEvent);
(_type_name + " repaired and refuelled") call FUNC(GlobalChat);

// by Xeno
#include "x_setup.sqf"
private ["_aid","_caller","_coef","_damage","_damage_ok","_damage_val","_fuel","_fuel_ok","_fuel_val","_rep_count","_breaked_out","_rep_action","_type_name"];

_caller = _this select 1;
_aid = _this select 2;

_truck_near = false;
if (player distance TR7 < 21 || player distance TR8 < 21) then {_truck_near = true};
if (!d_eng_can_repfuel && !_truck_near) exitWith {
	hintSilent "You have to restore your repair/refuel capability at base first or take one of the two Salvage trucks with you.";
};

if (d_with_ranked && (score player < (d_ranked_a select 0))) exitWith {
	(format ["You need %2 points to repair/refuel a vehicle, your current score is: %1!", score player,(d_ranked_a select 0)]) call XfHQChat;
};
if (d_with_ranked) then {
	if (time >= d_last_base_repair) then {d_last_base_repair = -1};
};
if (d_with_ranked && (player in (list d_engineer_trigger) && d_last_base_repair != -1)) exitWith {
	"You have to wait until you can repair a vehicle at base again." call XfHQChat;
};
if (d_with_ranked) then {if (player in (list d_engineer_trigger)) then {d_last_base_repair = time + 300}};

_caller removeAction _aid;
if (!(local _caller)) exitWith {};

#ifdef __ACE__
if (d_objectID2 isKindOf "Tank" || d_objectID2 isKindOf "Wheeled_APC") exitWith {hint "Not possible for a tank or wheeled APC!"};
#endif

_rep_count = switch (true) do {
	case (d_objectID2 isKindOf "Air"): {0.1};
	case (d_objectID2 isKindOf "Tank"): {0.2};
	default {0.3};
};

_fuel = fuel d_objectID2;
_damage = damage d_objectID2;

_damage_val = (_damage / _rep_count);
_fuel_val = ((1 - _fuel) / _rep_count);
_coef = switch (true) do {
	case (_fuel_val > _damage_val): {_fuel_val};
	default {_damage_val};
};
_coef = ceil _coef;

hintSilent format ["Vehicle status:\n---------------------\nFuel: %1\nDamage: %2",_fuel, _damage];
_type_name = [typeOf (d_objectID2),0] call XfGetDisplayName;
(format ["Repairing and refuelling %1... Stand by", _type_name]) call XfGlobalChat;
_damage_ok = false;
_fuel_ok = false;
d_cancelrep = false;
_breaked_out = false;
_breaked_out2 = false;
_rep_action = player addAction["Cancel Service" call XRedText,"x_client\x_cancelrep.sqf"];
for "_wc" from 1 to _coef do {
	if (!alive player || d_cancelrep) exitWith {player removeAction _rep_action};
	"Still working..." call XfGlobalChat;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 3.0;
	waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
	if (d_cancelrep) exitWith {_breaked_out = true};
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
	"Service canceled..." call XfGlobalChat;
	player removeAction _rep_action;
};
if (_breaked_out2) exitWith {};
d_eng_can_repfuel = false;
player removeAction _rep_action;
if (!alive player) exitWith {player removeAction _rep_action};
if (d_with_ranked) then {
	_parray = d_ranked_a select 1;
	_addscore = switch (true) do {
		case (d_objectID2 isKindOf "Air"): {(_parray select 0)};
		case (d_objectID2 isKindOf "Tank"): {(_parray select 1)};
		case (d_objectID2 isKindOf "Car"): {(_parray select 2)};
		default {(_parray select 3)};
	};
	if (_addscore > 0) then {
		["d_pas", [player, _addscore]] call XNetCallEvent;
		(format ["You get %1 point(s) for repairing/refueling!", _addscore]) call XfHQChat;
	};
};
["rep_ar", d_objectID2] call XNetCallEvent;
(format ["%1 repaired and refuelled", _type_name]) call XfGlobalChat;

// by Xeno
#include "x_setup.sqf"
private ["_chopper","_nr","_in_air_var","_kbvar"];
_chopper = _this select 0;
_nr = _this select 1;

_in_air_var = format ["mrr%1_in_air", _nr];
_kbvar = format ["Dmr%1_available", _nr];

while {(X_JIPH getVariable _in_air_var) && !isNull (driver _chopper)} do {sleep 2.453};
if ((X_JIPH getVariable _in_air_var) && isNull (driver _chopper)) then {
	[_in_air_var,false] call XNetSetJIP;
	d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E",_kbvar,true];
};
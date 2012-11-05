// by Xeno
#include "x_setup.sqf"
private ["_chopper","_nr","_in_air_var","_kbvar"];
_chopper = _this select 0;
_nr = _this select 1;

_in_air_var = format ["mr%1_in_air", _nr];
_kbvar = format ["Dmr%1_available", _nr];

while {(X_JIPH getVariable _in_air_var) && !isNull (driver _chopper)} do {sleep 2.453};
if ((X_JIPH getVariable _in_air_var) && isNull (driver _chopper)) then {
	[_in_air_var,false] call XNetSetJIP;
	#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,_kbvar,true];
	#else
	d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W",_kbvar,true];
	#endif
};

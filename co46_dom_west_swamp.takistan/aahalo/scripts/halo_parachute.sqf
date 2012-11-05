private ["_array1", "_vehicle", "_pos"];

"RadialBlur" ppEffectAdjust [0.0, 0.0, 0.0, 0.0];
"RadialBlur" ppEffectCommit 1.0;
"RadialBlur" ppEffectEnable false;

_para_unit = _this select 0;
if (_para_unit == player) then {
	_para_unit removeAction (_this select 2);
};

_array1 = ["FR_TL","FR_R","FR_Marksman","FR_Light","FR_Corpsman","FR_AR","FR_GL","FR_Sapper","FR_AC","FR_Miles","FR_Cooper","FR_Sykes","FR_OHara","	FR_Rodriguez","RUS_Soldier1","RUS_Soldier2","RUS_Soldier3","RUS_Soldier_GL","RUS_Soldier_TL","RUS_Soldier_Marksman","RUS_Soldier_Sab"];

_vehicle = createVehicle ["BIS_Steerable_Parachute", position _para_unit,[],0,"FLY"];
waitUntil {!isNil "_vehicle"};

_pos = [position _para_unit select 0, position _para_unit select 1, (position _para_unit select 2)];
_vehicle setPos _pos;
_para_unit moveInGunner _vehicle;
sleep 0.001;
_vehicle lock true;

//playsound "BIS_Steerable_Parachute_Opening"; // sound doesn't exist!

if (_para_unit == player) then {
	setAperture 0.05;
	setAperture -1;
	_para_unit switchMove "para_pilot";
	[_vehicle, _para_unit] execVM "aahalo\scripts\parachute.sqf";
} else {
	[_vehicle, _para_unit] execVM "aahalo\scripts\parachute_ai.sqf";
};

if (_para_unit != player) exitWith {};

"DynamicBlur" ppEffectEnable true;
"DynamicBlur" ppEffectAdjust [8.0];
"DynamicBlur" ppEffectCommit 0.01;
sleep 1;
"DynamicBlur" ppEffectAdjust [0.0];
"DynamicBlur" ppEffectCommit 3;
sleep 3;
"DynamicBlur" ppEffectEnable false;

"RadialBlur" ppEffectAdjust [0.0, 0.0, 0.0, 0.0];
"RadialBlur" ppEffectCommit 1.0;
"RadialBlur" ppEffectEnable false;

if (d_with_ai) then {
	if (alive player) then {[[position player select 0, position player select 1, (position player select 2) + 10], velocity player, direction player] execVM "x_client\x_moveai.sqf"};
};

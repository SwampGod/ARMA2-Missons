#include "x_setup.sqf"
private ["_aid","_caller"];
_caller = _this select 1;
_aid = _this select 2;
_caller removeAction _aid;
if (!(local _caller)) exitWith {};
["rep_ar", d_objectID2] call XNetCallEvent;
disableUserInput true;
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3.0;
WaitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
disableUserInput false;
deletevehicle evi1;
tskobj_13 setTaskState "SUCCEEDED";
obj_13_var = true; publicVariable "obj_13_var"; "obj_13_marker" setmarkertype "EMPTY";
[objNull, ObjNull, tskobj_13, "SUCCEEDED"] execVM "CA\Modules\MP\data\scriptCommands\taskHint.sqf";

{
	if (isPlayer _x) then {	_x addScore 100 };
} forEach units group player




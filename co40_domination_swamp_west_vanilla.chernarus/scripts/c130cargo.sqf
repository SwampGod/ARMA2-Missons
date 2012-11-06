_vec = _this select 0;
if (typeOf _vec == "C130J") then {
	_id = _vec addaction ["Load cargo", "scripts\cargoscript.sqf", ["load"]];
	_vec setVariable ["act1",_id];
	_vec setVariable ["cargo",""];
	player sidechat "Cargosystem active.";
};

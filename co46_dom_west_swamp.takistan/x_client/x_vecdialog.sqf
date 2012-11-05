// by Xeno
#include "x_setup.sqf"

#define __control(numcontrol) (_XD_display displayCtrl numcontrol)
private ["_vec", "_caller", "_ok", "_XD_display", "_control", "_vec_name", "_hasbox", "_ctrl_but_drop", "_ctrl_but_load", "_move_controls", "_pic", "_index", "_pos"];
if (!X_Client) exitWith {};

disableSerialization;

_vec = _this select 0;
_caller = _this select 1;

if (!alive _vec) exitWith {};
#ifdef __ACE__
if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {
	"Vehicle destroyed!!!" call XfGlobalChat
};
#endif

d_curvec_dialog = _vec;

_ok = createDialog "XD_VecDialog";

_XD_display = __uiGetVar(X_VEC_DIALOG);

if (getText (configFile >> "CfgVehicles" >> typeOf _vec >> "picture") != "picturestaticobject") then {
	__control(44444) ctrlSetText getText (configFile >> "CfgVehicles" >> typeOf _vec >> "picture");
} else {
	__control(44444) ctrlSetText "";
};

_vec_name = [_vec, "d_vec_name", "Normal"] call XfGetVar;
if (_vec_name == "") then {_vec_name = "Normal"};

__control(44446) ctrlSetText getText (configFile >> "CfgVehicles" >> d_the_box >> "icon");
__control(44445) ctrlSetText _vec_name;

_hasbox = _vec getVariable "d_ammobox";
if (isNil"_hasbox") then {_hasbox = false};
if (AmmoBoxHandling) then {_hasbox = true};

if (_hasbox) then {
	__control(44447) ctrlSetText "\CA\ui\data\objective_complete_ca.paa";
	__control(44452) ctrlEnable false;
} else {
	__control(44447) ctrlSetText "\CA\ui\data\objective_incomplete_ca.paa";
	__control(44448) ctrlEnable false;
};

_move_controls = false;

if (_caller != driver _vec) then {
	_ctrl_but_load ctrlEnable false;
	_ctrl_but_drop ctrlEnable false;

	_vtype = _vec getVariable "d_vec_type";
	if (!isNil "_vtype") then {
		if (_vtype == "MHQ") then {
			if (!(_caller in _vec)) then {
				lbClear 44449;
				{
					_pic = getText(configFile >> "cfgVehicles" >> _x >> "picture");
					_index = __control(44449) lbAdd ([_x,0] call XfGetDisplayName);
					__control(44449) lbSetPicture [_index, _pic];
					__control(44449) lbSetColor [_index, [1, 1, 0, 0.5]];
				} forEach d_create_bike;

				__control(44449) lbSetCurSel 0;
			} else {
				_move_controls = true;
			};
		};
	};
} else {
	_move_controls = true;
};

_vtype = _vec getVariable "d_choppertype";
if (!isNil "_vtype") then {_move_controls = true};

if (d_WithMHQTeleport == 1) then {
	__control(44453) ctrlShow false;
};

if (_move_controls) then {
	__control(44453) ctrlShow false;
	__control(44449) ctrlShow false;
	__control(44451) ctrlShow false;
	__control(44450) ctrlShow false;
	__control(44459) ctrlShow false;
	__control(44462) ctrlShow false;
	_control = _XD_display displayCtrl 44454;
	_pos = ctrlPosition _control;
	_pos = [(_pos select 0) + 0.17, _pos select 1,_pos select 2,_pos select 3];
	_control ctrlSetPosition _pos;
	_control ctrlCommit 0;
	_control = _XD_display displayCtrl 44446;
	_pos = ctrlPosition _control;
	_pos = [(_pos select 0) + 0.17, _pos select 1,_pos select 2,_pos select 3];
	_control ctrlSetPosition _pos;
	_control ctrlCommit 0;
	_control = _XD_display displayCtrl 44447;
	_pos = ctrlPosition _control;
	_pos = [(_pos select 0) + 0.17, _pos select 1,_pos select 2,_pos select 3];
	_control ctrlSetPosition _pos;
	_control ctrlCommit 0;
	_control = _XD_display displayCtrl 44448;
	_pos = ctrlPosition _control;
	_pos = [(_pos select 0) + 0.17, _pos select 1,_pos select 2,_pos select 3];
	_control ctrlSetPosition _pos;
	_control ctrlCommit 0;
	_control = _XD_display displayCtrl 44452;
	_pos = ctrlPosition _control;
	_pos = [(_pos select 0) + 0.17, _pos select 1,_pos select 2,_pos select 3];
	_control ctrlSetPosition _pos;
	_control ctrlCommit 0;
} else {
	_depl = _vec getVariable "D_MHQ_Deployed";
	if (isNil "_depl") then {_depl = false};
	if (_depl) then {
		__control(44462) ctrlSetText "Undeploy MHQ";
		if (_hasbox) then {
			__control(44448) ctrlEnable true;
			__control(44452) ctrlEnable false;
		} else {
			__control(44448) ctrlEnable false;
			__control(44452) ctrlEnable true;
		};
	} else {
		__control(44453) ctrlEnable false;
		__control(44459) ctrlEnable false;
		__control(44451) ctrlEnable false;
		__control(44449) ctrlEnable false;
	};
};

waitUntil {!dialog || !alive player};

if (!alive player) then {closeDialog 0};
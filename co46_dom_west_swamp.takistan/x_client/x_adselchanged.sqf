// by Xeno
#include "x_setup.sqf"
#define __ctrl(vctrl) _ctrl = _display displayCtrl vctrl
#define __ctrlinfo(vctrl) _ctrlinfo = _display displayCtrl vctrl
private ["_ctrl", "_display", "_ctrlinfo", "_selection", "_control", "_selectedIndex", "_strp", "_unit", "_posunit", "_sel", "_endtime"];

disableSerialization;

_selection = _this select 0;

_control = _selection select 0;
_selectedIndex = _selection select 1;

if (_selectedIndex == -1) exitWith {};

_control ctrlEnable false;
_strp = _control lbData _selectedIndex;

_unit = missionNamespace getVariable _strp;
d_a_d_cur_uid = getPlayerUID _unit;
d_u_r_inf = nil;
_display = __uiGetVar(D_ADMIN_DLG);
d_a_d_cur_name = _control lbText _selectedIndex;
__ctrlinfo(1002);
_ctrlinfo ctrlSetText format ["Receiving player information for %1 from server...", d_a_d_cur_name];
["d_g_p_inf", d_a_d_cur_uid] call XNetCallEvent;

["d_admin_marker", [0,0,0],"ICON","ColorBlack",[1,1],"",0,"Dot"] call XfCreateMarkerLocal;
"d_admin_marker" setMarkerTextLocal d_a_d_cur_name;
_posunit = getPosASL _unit;
"d_admin_marker" setMarkerPosLocal _posunit;

__ctrl(11010);

_ctrl ctrlmapanimadd [0.0, 1.00, getPosASL (vehicle player)];
_ctrl ctrlmapanimadd [1.2, 1.00, _posunit];
_ctrl ctrlmapanimadd [0.5, 0.30, _posunit];
ctrlmapanimcommit _ctrl;

_endtime = time + 30;
waitUntil {!isNil "d_u_r_inf" || !dialog || !alive player || time > _endtime};

if (!dialog || !alive player || time > _endtime) exitWith {};

_control ctrlEnable true;

if (count d_u_r_inf == 0) exitWith {_ctrlinfo ctrlSetText format ["Player information for %1 not stored on server...", d_a_d_cur_name]};

_ctrlinfo ctrlSetText format ["Player information for %1 received...", d_a_d_cur_name];

__ctrl(1003);
_ctrl ctrlSetText d_a_d_cur_name;

__ctrl(1004);
_ctrl ctrlSetText d_a_d_cur_uid;

__ctrl(1005);
_ctrl ctrlSetText str(_unit);

_sel =
#ifndef __TT__
6;
#else
7;
#endif
__ctrl(1006);
_ctrl ctrlSetText str(d_u_r_inf select _sel);

__ctrl(1009);
_ctrl ctrlSetText str(score _unit);

__ctrl(1007);
_ctrl ctrlEnable (if (d_u_r_inf select _sel == 0) then {false} else {true});

__ctrl(1008);
_ctrl ctrlEnable (if (d_a_d_cur_name == d_name_pl) then {false} else {true});

__ctrl(1010);
_ctrl ctrlEnable (if (d_a_d_cur_name == d_name_pl) then {false} else {true});
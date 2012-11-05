// by Xeno
#define THIS_FILE "x_uifuncs.sqf"
#include "x_setup.sqf"

FUNC(initArtyDlg) = {
	private ["_ctrl", "_rank", "_sels"];
	_ctrl = __uiGetVar(D_ARTI_DISP) displayCtrl 888;
	{_ctrl lbAdd _x} forEach ["HE", "DPICM", "Flare", "Smoke", "SADARM"];
	_ctrl lbSetCurSel 0;
	_ctrl = __uiGetVar(D_ARTI_DISP) displayCtrl 889;
	if (!GVAR(with_ranked)) then {
		{_ctrl lbAdd _x} forEach ["1", "2", "3"];
	} else {
		_rank = rank player;
		_sels = switch (true) do {
			case (_rank in ["PRIVATE","CORPORAL"]): {["1"]};
			case (_rank in ["SERGEANT","LIEUTENANT"]): {["1", "2"]};
			default {["1", "2", "3"]};
		};
		{_ctrl lbAdd _x} forEach _sels;
	};
	_ctrl lbSetCurSel 0;
};

FUNC(FireArty) = {
	private ["_ctrl", "_idx"];
	_ctrl = __uiGetVar(D_ARTI_DISP) displayCtrl 889;
	_idx = lbCurSel _ctrl;
	if (_idx == -1) exitWith {};
	GVAR(ari_salvos) = _idx + 1;
	
	_ctrl = __uiGetVar(D_ARTI_DISP) displayCtrl 888;
	_idx = lbCurSel _ctrl;
	if (_idx == -1) exitWith {};
	GVAR(ari_type) = switch (_idx) do {
		case 0: {"he"};
		case 1: {"dpicm"};
		case 2: {"flare"};
		case 3: {"smoke"};
		case 4: {"sadarm"};
		default {""};
	};
};

FUNC(glselchanged) = {
	private ["_selection", "_control", "_selectedIndex", "_real_list", "_vlist"];
	disableSerialization;
	PARAMS_1(_selection);

	_control = _selection select 0;
	_selectedIndex = _selection select 1;

	if (_selectedIndex == -1) exitWith {};

	_real_list = [50, 25, 12.5];
	_vlist = ["No Gras", "Medium Gras", "Full Gras"];
	if (GVAR(graslayer_index) != _selectedIndex) then {
		GVAR(graslayer_index) = _selectedIndex;
		setTerrainGrid (_real_list select GVAR(graslayer_index));

		(format ["Gras layer set to: %1",_vlist select GVAR(graslayer_index)]) call FUNC(GlobalChat);
	};
};

#ifndef __A2ONLY__
FUNC(blselchanged) = {
	private ["_selection", "_control", "_selectedIndex", "_bar", "_class", "_pic"];
	disableSerialization;
	PARAMS_1(_selection);

	_control = _selection select 0;
	_selectedIndex = _selection select 1;

	if (_selectedIndex == -1) exitWith {};

	_bar = switch (GVAR(side_player)) do {
		case west: {GVAR(backpackclasses) select 0};
		case east: {GVAR(backpackclasses) select 1};
	};

	_control = __uiGetVar(GVAR(BACKPACK_DIALOG)) displayCtrl 1001;

	_class = _bar select _selectedIndex;
	_pic = getText (configFile >> "cfgVehicles" >> _class >> "picture");

	_control ctrlSetText _pic;

	_control = __uiGetVar(GVAR(BACKPACK_DIALOG)) displayCtrl 1003;
	_control ctrlSetText ("Selected: " + getText (configFile >> "cfgVehicles" >> _class >> "displayName"));
};

FUNC(take_backpack) = {
	private ["_control", "_sel", "_bar", "_typeold", "_oldbpobj", "_dispname"];
	disableSerialization;

	_control = __uiGetVar(GVAR(BACKPACK_DIALOG)) displayCtrl 1000;

	_sel = lbCurSel _control;

	if (_sel == -1) exitWith {};

	_bar = switch (GVAR(side_player)) do {
		case west: {GVAR(backpackclasses) select 0};
		case east: {GVAR(backpackclasses) select 1};
	};

	_typeold = "";
	_oldbpobj = unitBackpack player;

	if (!isNull _oldbpobj) then {
		_typeold = typeOf _oldbpobj;
		removeBackpack  player;
	};

	player addBackpack (_bar select _sel);

	_dispname = getText (configFile >> "cfgVehicles" >> (_bar select _sel) >> "displayName");

	(_dispname + " taken...") call FUNC(GlobalChat);

	clearWeaponCargo (unitBackpack player);

	[QGVAR(p_o_a2), [GVAR(string_player), unitBackpack player]] call FUNC(NetCallEvent);

	_bar = _bar - [_bar select _sel];

	if (_typeold != "") then {
		if !(_typeold in _bar) then {
			_bar set [count _bar, _typeold];
		};
	};

	switch (GVAR(side_player)) do {
		case west: {GVAR(backpackclasses) set [0, _bar]};
		case east: {GVAR(backpackclasses) set [1, _bar]};
	};

	if (!isNull _oldbpobj) then {
		[QGVAR(p_o_a2r), [GVAR(string_player), _oldbpobj]] call FUNC(NetCallEvent);
	};
};
#endif

FUNC(pmselchanged) = {
	private ["_selection", "_control", "_selectedIndex"];
	disableSerialization;
	PARAMS_1(_selection);

	_control = _selection select 0;
	_selectedIndex = _selection select 1;

	if (_selectedIndex == -1) exitWith {};

	if (GVAR(show_player_marker) != _selectedIndex) then {
		GVAR(show_player_marker) = _selectedIndex;
		execVM "x_client\x_deleteplayermarker.sqf";
	};
};

FUNC(teamstatus_dialog) = {
	if (!X_Client) exitWith {};

	disableSerialization;

	if (isNil QGVAR(ICE_TeamStatusDialog_open)) then {
		GVAR(ICE_TeamStatusDialog_open) = false;
	};
	if (GVAR(ICE_TeamStatusDialog_open)) exitWith {};

	if (isNil QUOTE(FUNC(TeamStatusD))) then {
		__cppfln(FUNC(TeamStatusD),scripts\TeamStatusDialog\TeamStatusDialog.sqf);
	};

	if (isNil "TSD9_funcs_inited") then {
		call compile preprocessFileLineNumbers "scripts\TeamStatusDialog\TeamStatusDialogFuncs.sqf";
	};

	if (vehicle player == player) then {
		GVAR(teamstatus_dialog_params) = [player, player, 0, ["Page", "Team"],"HideOpposition","HideVehicle","DeleteRemovedAI","AllowPlayerInvites"];
	} else {
		GVAR(teamstatus_dialog_params) = [player, player, 0, ["Page", "Vehicle"],["VehicleObject", vehicle player],"HideTeam","HideGroup","HideOpposition","DeleteRemovedAI","AllowPlayerInvites"];
	};
	createDialog "ICE_TeamStatusDialog";
	["init_teamstatus", {call FUNC(TeamStatusD);["init_teamstatus"] call FUNC(removePerFrame)},0] call FUNC(addPerFrame);
};

FUNC(showsidemain_d) = {
	if (!X_Client) exitWith {};

	disableSerialization;

	PARAMS_1(_which);

	if (_which == 1 && __XJIPGetVar(GVAR(current_target_index)) == -1) exitWith {};
	if (_which == 0 && (__XJIPGetVar(all_sm_res) || __XJIPGetVar(GVAR(current_mission_index)) == -1)) exitWith {};

	_display = __uiGetVar(X_STATUS_DIALOG);

	_ctrlmap = _display displayCtrl 11010;
	ctrlMapAnimClear _ctrlmap;

	#ifndef __TT__
	_start_pos = position FLAG_BASE;
	#else
	_start_pos = if (GVAR(player_side) == west) then {position WFLAG_BASE} else {position EFLAG_BASE};
	#endif
	_end_pos = [];
	_exit_it = false;

	_markername = "";
	switch (_which) do {
		case 0: {
			_markername = format ["XMISSIONM%1", __XJIPGetVar(GVAR(current_mission_index)) + 1];
			_end_pos = markerPos _markername;
			if (str(_end_pos) == "[0,0,0]") then {_exit_it = true};
		};
		case 1: {
			_end_pos = markerPos QGVAR(dummy_marker);
			_markername = (GVAR(target_names) select __XJIPGetVar(GVAR(current_target_index))) select 1;
		};
	};

	if (_exit_it) exitWith {};

	_dsmd = __pGetVar(GVAR(sidemain_m_do));
	if (isNil "_dsmd") then {_dsmd = []};
	if !(_markername in _dsmd) then {
		_dsmd set [count _dsmd, _markername];
		__pSetVar [QGVAR(sidemain_m_do), _dsmd];
		_markername spawn {
			private ["_m", "_a", "_aas"];
			_m = _this; _a = 1; _aas = -0.06;
			while {GVAR(showstatus_dialog_open) && alive player} do {
				_m setMarkerAlphaLocal _a;
				_a = _a + _aas;
				if (_a < 0.4) then {_a = 0.4; _aas = _aas * -1};
				if (_a > 1.3) then {_a = 1.3; _aas = _aas * -1};
				sleep .1;
			};
			_m setMarkerAlphaLocal 1;
			__pSetVar [QGVAR(sidemain_m_do),[]];
		};
	};

	_ctrlmap ctrlmapanimadd [0.0, 1.00, _start_pos];
	_ctrlmap ctrlmapanimadd [1.2, 1.00, _end_pos];
	_ctrlmap ctrlmapanimadd [0.5, 0.30, _end_pos];
	ctrlmapanimcommit _ctrlmap;
};

FUNC(admindialog) = {
	private ["_display", "_ctrl", "_units", "_index"];
	if (!X_Client) exitWith {};

	disableSerialization;

	_hxhx = __pGetVar(GVAR(p_isadmin));
	if (isNil "_hxhx") then {_hxhx = false};
	if (!_hxhx) exitWith {};

	xr_phd_invulnerable = true;
	__pSetVar ["ace_w_allow_dam", false];

	createDialog "XD_AdminDialog";
	_ctrl = __uiGetVar(D_ADMIN_DLG) displayCtrl 1001;

	_units = if (isMultiplayer) then {playableUnits} else {switchableUnits};
	lbClear _ctrl;
	{
		if (!isNull _x) then {
			_index = _ctrl lbAdd (name _x);
			_ctrl lbSetData [_index, str(_x)];
		};
	} forEach _units;

	_ctrl lbSetCurSel 0;

	0 spawn {
		private ["_ctrl", "_units", "_index"];
		disableSerialization;
		GVAR(a_d_p_kicked) = nil;
		_ctrl = __uiGetVar(D_ADMIN_DLG) displayCtrl 1001;
		while {alive player && GVAR(admin_dialog_open)} do {
			if (!isNil QGVAR(a_d_p_kicked)) then {
				GVAR(a_d_p_kicked) = nil;
				lbClear _ctrl;
				_units = if (isMultiplayer) then {playableUnits} else {switchableUnits};
				{
					if (!isNull _x) then {
						_index = _ctrl lbAdd (name _x);
						_ctrl lbSetData [_index, str(_x)];
					};
				} forEach _units;
				_ctrl lbSetCurSel 0;
			};
			sleep 0.2;
		};
		if (GVAR(admin_dialog_open)) then {
			closeDialog 0;
		};
		xr_phd_invulnerable = false;
		__pSetVar ["ace_w_allow_dam", nil];
		sleep 0.5;
		deleteMarkerLocal QGVAR(admin_marker);
	};
};

FUNC(adselchanged) = {
	#define __ctrl(vctrl) _ctrl = _display displayCtrl vctrl
	#define __ctrlinfo(vctrl) _ctrlinfo = _display displayCtrl vctrl
	#define __CTRL2(A) (_display displayCtrl A)
	private ["_ctrl", "_display", "_ctrlinfo", "_selection", "_control", "_selectedIndex", "_strp", "_unit", "_posunit", "_sel", "_endtime"];

	disableSerialization;

	PARAMS_1(_selection);

	_control = _selection select 0;
	_selectedIndex = _selection select 1;

	if (_selectedIndex == -1) exitWith {};

	_control ctrlEnable false;
	_strp = _control lbData _selectedIndex;

	_unit = __getMNsVar2(_strp);
	GVAR(a_d_cur_uid) = getPlayerUID _unit;
	GVAR(a_d_cur_unit_name) = name _unit;
	__TRACE_1("adselchanged","_unit");
	GVAR(u_r_inf) = nil;
	_display = __uiGetVar(GVAR(ADMIN_DLG));
	GVAR(a_d_cur_name) = _control lbText _selectedIndex;
	__ctrlinfo(1002);
	_ctrlinfo ctrlSetText format ["Receiving player information for %1 from server...", GVAR(a_d_cur_name)];
	[QGVAR(g_p_inf), GVAR(a_d_cur_uid)] call FUNC(NetCallEvent);

	[QGVAR(admin_marker), [0,0,0],"ICON","ColorBlack",[1,1],"",0,"Dot"] call FUNC(CreateMarkerLocal);
	QGVAR(admin_marker) setMarkerTextLocal GVAR(a_d_cur_name);
	_posunit = getPosASL _unit;
	QGVAR(admin_marker) setMarkerPosLocal _posunit;

	__ctrl(11010);

	_ctrl ctrlmapanimadd [0.0, 1.00, getPosASL (vehicle player)];
	_ctrl ctrlmapanimadd [1.2, 1.00, _posunit];
	_ctrl ctrlmapanimadd [0.5, 0.30, _posunit];
	ctrlmapanimcommit _ctrl;

	_endtime = time + 30;
	waitUntil {!isNil QGVAR(u_r_inf) || !GVAR(admin_dialog_open) || !alive player || time > _endtime};
	
	if (count GVAR(u_r_inf) == 0) exitWith {};

	if (!GVAR(admin_dialog_open) || !alive player || time > _endtime) exitWith {};

	_control ctrlEnable true;

	if (count GVAR(u_r_inf) == 0) exitWith {_ctrlinfo ctrlSetText format ["Player information for %1 not stored on server...", GVAR(a_d_cur_name)]};

	_ctrlinfo ctrlSetText format ["Player information for %1 received...", GVAR(a_d_cur_name)];

	__CTRL2(1003) ctrlSetText GVAR(a_d_cur_name);
	__CTRL2(1004) ctrlSetText GVAR(a_d_cur_uid);
	__CTRL2(1005) ctrlSetText str(_unit);

	_sel = 7;
	__CTRL2(1006) ctrlSetText str(GVAR(u_r_inf) select _sel);
	__CTRL2(1009) ctrlSetText str(score _unit);
	__CTRL2(1007) ctrlEnable ((GVAR(u_r_inf) select _sel) >= 1);
	__CTRL2(1008) ctrlEnable (GVAR(a_d_cur_name) != GVAR(name_pl));
	__CTRL2(1010) ctrlEnable (GVAR(a_d_cur_name) != GVAR(name_pl));
};

FUNC(vdsliderchanged) = {
	private "_newvd";
	disableSerialization;
	#define __ctrl(numcontrol) (_XD_display displayCtrl numcontrol)
	_XD_display = __uiGetVar(X_SETTINGS_DIALOG);
	_newvd = round (_this select 1);
	__ctrl(1999) ctrlSetText ("Viewdistance: " + str(_newvd));
	setViewDistance _newvd;
};

FUNC(adminspectate) = {
	xr_phd_invulnerable = true;
	player setVariable ["ace_w_allow_dam", false];
	if (__TTVer) then {
		if (GVAR(side_player) == east) then {
			KEGs_ShownSides = [east, west];
		} else {
			KEGs_ShownSides = [west, east];
		};
	} else {
		KEGs_ShownSides = [GVAR(side_player)];
	};
	KEGs_can_exit_spectator = true;
	KEGs_playable_only = true;
	KEGs_no_butterfly_mode = true;

	[player, objNull, "x"] execVM "spect\specta.sqf";
};

FUNC(fillunload) = {
	private ["_control", "_pic", "_index"];
	disableSerialization;
	_control = __uiGetVar(GVAR(UNLOAD_DIALOG)) displayCtrl 101115;
	lbClear _control;

	{
		_pic = getText (configFile >> "cfgVehicles" >> _x >> "picture");
		_index = _control lbAdd ([_x,0] call FUNC(GetDisplayName));
		_control lbSetPicture [_index, _pic];
		_control lbSetColor [_index, [1, 1, 0, 0.8]];
	} forEach GVAR(current_truck_cargo_array);

	_control lbSetCurSel 0;
};

#ifndef __A2ONLY__
FUNC(fillbackpacks) = {
	private ["_control", "_bar", "_control2", "_pic"];
	disableSerialization;
	_control = __uiGetVar(GVAR(BACKPACK_DIALOG)) displayCtrl 1000;
	lbClear _control;

	_bar = switch (GVAR(side_player)) do {
		case west: {GVAR(backpackclasses) select 0};
		case east: {GVAR(backpackclasses) select 1};
	};

	{_control lbAdd getText (configFile >> "cfgVehicles" >> _x >> "displayName")} forEach _bar;

	_control lbSetCurSel 0;

	_control = __uiGetVar(GVAR(BACKPACK_DIALOG)) displayCtrl 1002;
	_control2 = __uiGetVar(GVAR(BACKPACK_DIALOG)) displayCtrl 1004;

	if (!isNull (unitBackpack player)) then {
		_pic = getText (configFile >> "cfgVehicles" >> typeOf (unitBackpack player) >> "picture");

		_control ctrlSetText _pic;
		_control2 ctrlSetText ("Current Backpack: " + getText (configFile >> "cfgVehicles" >> typeOf (unitBackpack player) >> "displayName"));
	} else {
		_control ctrlSetText "";
		_control2 ctrlSetText "";
	};
};
#endif

FUNC(unloadsetcargo) = {
	private ["_index", "_disp"];
	disableSerialization;
	_disp = __uiGetVar(GVAR(UNLOAD_DIALOG));
	_index = lbCurSel (_disp displayCtrl 101115);
	if (_index < 0) exitWith {closeDialog 0};
	GVAR(cargo_selected_index) = _index;
	closeDialog 0;
};

FUNC(x_create_vec) = {
	private "_index";
	disableSerialization;
	_index = lbCurSel (__uiGetVar(X_VEC_DIALOG) displayCtrl 44449);
	closeDialog 0;
	if (_index < 0) exitWith {};
	[0,0,0, [GVAR(create_bike) select _index, 0]] execVM "x_client\x_bike.sqf";
};

FUNC(fillRecruit) = {
	private ["_control", "_pic", "_index", "_control2", "_tt"];
	disableSerialization;
	_control = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1000;
	lbClear _control;
	
	{
		_pic = getText (configFile >> "cfgVehicles" >> _x >> "picture");
		_index = _control lbAdd ([_x,0] call FUNC(GetDisplayName));
		_control lbSetPicture [_index, _pic];
		_control lbSetColor [_index, [1, 1, 0, 0.8]];
	} forEach GVAR(UnitsToRecruit);

	_control lbSetCurSel 0;
	
	GVAR(current_ai_num) = 0;
	GVAR(current_ai_units) = [];
	{
		if (!isPlayer _x && alive _x) then {
			__INC(GVAR(current_ai_num));
			GVAR(current_ai_units) set [count GVAR(current_ai_units), _x];
		};
	} forEach units group player;
	
	_control2 = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1030;
	_control2 ctrlSetText ("Your current AI units (" + str(GVAR(current_ai_num)) + "/" + str(GVAR(max_ai)) + "):");
	
	_control = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1001;
	lbClear _control;
	{
		_tt = typeOf _x;
		_pic = getText (configFile >> "cfgVehicles" >> _tt >> "picture");
		_index = _control lbAdd ([_tt,0] call FUNC(GetDisplayName));
		_control lbSetPicture [_index, _pic];
		_control lbSetColor [_index, [1, 1, 0, 0.8]];
	} forEach GVAR(current_ai_units);
	
	if (count GVAR(current_ai_units) > 0) then {
		_control lbSetCurSel 0;
	};
	
	if (GVAR(current_ai_num) == 0) then {
		(__uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1011) ctrlShow false;
		(__uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1012) ctrlShow false;
	};
	if (GVAR(current_ai_num) == GVAR(max_ai)) then {
		(__uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1010) ctrlShow false;
	};
};

FUNC(recruitbuttonaction) = {
	if (__pGetVar(GVAR(recdbusy))) exitWith {};
	__pSetVar [QGVAR(recdbusy), true];
	private ["_exitj", "_rank", "_control", "_idx", "_torecruit", "_grp", "_unit", "_ctrl", "_pic", "_index", "_control2"];
	if (GVAR(current_ai_num) >= GVAR(max_ai)) exitWith {
		format ["You have already %1 AI units under your control!",GVAR(max_ai)] call FUNC(HQChat);
		__pSetVar [QGVAR(recdbusy), false];
	};
	__INC(GVAR(current_ai_num));
	__TRACE_1("recruitbuttonaction",GVAR(current_ai_num));
	
	if (player != leader (group player)) exitWith {
		"You are not a group leader, recruiting AI not possible" call FUNC(HQChat);
		__pSetVar [QGVAR(recdbusy), false];
	};
	
	_exitj = false;
	if (GVAR(with_ranked)) then {
		_rank = rank player;
		if (_rank == "PRIVATE") exitWith {
			"You current rank is private. You can't recruit soldiers!" call FUNC(HQChat);
			_exitj = true;
		};

		if (score player < ((GVAR(points_needed) select 0) + (GVAR(ranked_a) select 3))) exitWith {
			(format ["You can't recruit an AI soldier, costs %2 points, your current score (%1) will drop below 10!", score player, GVAR(ranked_a) select 3]) call FUNC(HQChat);
			_exitj = true;
		};

		_max_rank_ai = switch (_rank) do {
			case "CORPORAL": {3};
			case "SERGEANT": {4};
			case "LIEUTENANT": {5};
			case "CAPTAIN": {6};
			case "MAJOR": {7};
			case "COLONEL": {8};
		};
		if (GVAR(current_ai_num) >= _max_rank_ai) exitWith {
			(format ["You allready have %1 AI soldiers under your control, it is not possible to recruit more with your current rank...", _max_rank_ai]) call FUNC(HQChat);
			_exitj = true;
		};
		// each AI soldier costs score points
		[QGVAR(pas), [player, (GVAR(ranked_a) select 3) * -1]] call FUNC(NetCallEvent);
	};

	if (_exitj) exitWith {
		__pSetVar [QGVAR(recdbusy), false];
	};
	
	_control = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1000;
	_idx = lbCurSel _control;
	if (_idx == -1) exitWith {
		__pSetVar [QGVAR(recdbusy), false];
	};

	_torecruit = GVAR(UnitsToRecruit) select _idx;
	_grp = group player;
	_spawnpos = [];
	if (player distance __XJIPGetVar(GVAR(AI_HUT)) < 20) then {
		_spawnpos = position GVAR(AISPAWN);
	} else {
		if (!isNil QGVAR(additional_recruit_buildings)) then {
			_exitit = false;
			{
				if (!isNil "_x") then {
					if (!isNull _x) then {
						if (player distance _x < 20) then {
							_spawnpos = player modelToWorld [0,-15,0];
							_exitit = true;
						};
					};
				};
				if (_exitit) exitWith {};
			} forEach GVAR(additional_recruit_buildings);
		};
	};
	if (count _spawnpos == 0) exitWith {
		__pSetVar [QGVAR(recdbusy), false];
	};
	
	_unit = _grp createUnit [_torecruit, _spawnpos, [], 0, "FORM"];
	[_unit] join _grp;
	_unit setSkill 1;
	_unit setRank "PRIVATE";
	if (GVAR(with_ranked)) then {
		_unit addEventHandler ["handleHeal", {_this call FUNC(HandleHeal)}];
	};
	if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant") == 1) then {
		[_unit] execFSM "fsms\AIRevive.fsm";
	};
	[QGVAR(p_group), [_grp, player]] call FUNC(NetCallEvent);
	
	GVAR(current_ai_units) set [count GVAR(current_ai_units), _unit];
	
	[QGVAR(addai), _unit] call FUNC(NetCallEvent);
	
	if (GVAR(current_ai_num) == GVAR(max_ai)) then {
		(__uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1010) ctrlShow false;
	};
	
	_ctrl = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1011;
	if (!ctrlShown _ctrl) then {
		_ctrl ctrlShow true;
	};
	_ctrl = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1012;
	if (!ctrlShown _ctrl) then {
		_ctrl ctrlShow true;
	};
	
	_control = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1001;
	_pic = getText (configFile >> "cfgVehicles" >> _torecruit >> "picture");
	_index = _control lbAdd ([_torecruit,0] call FUNC(GetDisplayName));
	_control lbSetPicture [_index, _pic];
	_control lbSetColor [_index, [1, 1, 0, 0.8]];
	
	_control2 = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1030;
	_control2 ctrlSetText ("Your current AI units (" + str(GVAR(current_ai_num)) + "/" + str(GVAR(max_ai)) + "):");
	
	__pSetVar [QGVAR(recdbusy), false];
};

FUNC(dismissbuttonaction) = {
	__TRACE("dismissbuttonaction");
	if (__pGetVar(GVAR(recdbusy))) exitWith {};
	__pSetVar [QGVAR(recdbusy), true];
	__TRACE("dismissbuttonaction2");
	private ["_control", "_idx", "_unit", "_ctrl", "_control2"];
	_control = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1001;
	_idx = lbCurSel _control;
	__TRACE_1("dismissbuttonaction",_idx);
	if (_idx == -1) exitWith {
		__pSetVar [QGVAR(recdbusy), false];
	};
	
	__DEC(GVAR(current_ai_num));
	__TRACE_1("dismissbuttonaction",GVAR(current_ai_num));
	
	_control lbDelete _idx;
	
	_unit = GVAR(current_ai_units) select _idx;
	GVAR(current_ai_units) set [_idx, -1];
	GVAR(current_ai_units) = GVAR(current_ai_units) - [-1];
	
	if (!isPlayer _unit) then {
		if (vehicle _unit == _unit) then {
			deleteVehicle _unit;
		} else {
			moveOut _unit;
			[_unit] spawn {
				private ["_unit"];
				PARAMS_1(_unit);
				waitUntil {sleep 0.212;vehicle _unit == _unit};
				deleteVehicle _unit;
			};
		};
	};
	
	_ctrl = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1010;
	if (!ctrlShown _ctrl) then {
		_ctrl ctrlShow true;
	};
	
	if (GVAR(current_ai_num) == 0) then {
		(__uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1011) ctrlShow false;
		(__uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1012) ctrlShow false;
	};
	
	_control2 = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1030;
	_control2 ctrlSetText ("Your current AI units (" + str(GVAR(current_ai_num)) + "/" + str(GVAR(max_ai)) + "):");
	__pSetVar [QGVAR(recdbusy), false];
};

FUNC(dismissallbuttonaction) = {
	if (__pGetVar(GVAR(recdbusy))) exitWith {};
	__pSetVar [QGVAR(recdbusy), true];
	private ["_control2", "_ctrl", "_control"];
	_has_ai = false;
	{
		if (!isPlayer _x) then {
			_has_ai = true;
			if (vehicle _x == _x) then {
				deleteVehicle _x;
			} else {
				moveOut _x;
				[_x] spawn {
					PARAMS_1(_unit);
					waitUntil {sleep 0.212;vehicle _unit == _unit};
					deleteVehicle _unit;
				};
			};
		};
	} forEach units group player;
	if (_has_ai) then {"All AI soldiers dismissed !!!!" call FUNC(HQChat)};
	(__uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1011) ctrlShow false;
	(__uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1012) ctrlShow false;
	GVAR(current_ai_num) = 0;
	
	_control2 = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1030;
	_control2 ctrlSetText ("Your current AI units (" + str(GVAR(current_ai_num)) + "/" + str(GVAR(max_ai)) + "):");
	
	_ctrl = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1010;
	if (!ctrlShown _ctrl) then {
		_ctrl ctrlShow true;
	};
	
	_control = __uiGetVar(GVAR(RECRUIT_DIALOG)) displayCtrl 1001;
	lbClear _control;
	
	GVAR(current_ai_units) = [];
	__pSetVar [QGVAR(recdbusy), false];
};

FUNC(fillgdfdialog) = {
	private ["_disp", "_basem", "_ctop", "_basepist", "_cpist", "_cfg", "_type", "_size", "_img", "_i", "_ctrl", "_cpos", "_endtime"];
	disableSerialization;
	_disp = __uiGetVar(GVAR(RscGearFast));
	#define CTRL(A) (_disp displayCtrl A)
	#define __cfgM(MAG) configFile>>"CfgMagazines">>MAG

	_basem = 109;
	_ctop = 0;
	_basepist = 122;
	_cpist = 0;
	{
		_cfg = __cfgM(_x);
		_type = getNumber(_cfg >> "type");
		if (_type < 256) then {
			_size = _type / 16;
			_img = getText(_cfg >> "picture");
			CTRL(_basepist) ctrlSetText _img;
			__INC(_basepist);
			_cpist = _cpist + _size;
		} else {
			_size = _type / 256;
			_img = getText(_cfg >> "picture");
			CTRL(_basem) ctrlSetText _img;
			__INC(_basem);
			_ctop = _ctop + _size;
		};
	} forEach (magazines player);

	if (_ctop < 12) then {
		for "_i" from _ctop to 12 do {
			_img = if (_basem < 115) then {
				"\ca\ui\data\ui_gear_mag_gs.paa"
			} else {
				"\ca\ui\data\ui_gear_mag2_gs.paa"
			};
			CTRL(_basem) ctrlSetText _img;
			__INC(_basem);
		};
	};
	if (_cpist < 8) then {
		for "_i" from _cpist to 8 do {
			CTRL(_basepist) ctrlSetText "\ca\ui\data\ui_gear_hgunmag_gs.paa";
			__INC(_basepist);
		};
	};

	_ctrl = CTRL(1000);
	_cpos = ctrlPosition _ctrl;
	_cpos set [0, SafeZoneX + safeZoneW - 0.228];
	_ctrl ctrlSetPosition _cpos;
	_ctrl ctrlCommit 0.3;

	0 spawn {
		private ["_endtime", "_disp", "_ctrl", "_cpos"];
		disableSerialization;
		_endtime = time + 3;
		waitUntil {time >= _endtime || !alive player || __pGetVar(xr_pluncon)};
		_disp = __uiGetVar(GVAR(RscGearFast));
		_ctrl = CTRL(1000);
		_cpos = ctrlPosition _ctrl;
		_cpos set [0, SafeZoneX + safeZoneW + 0.01];
		_ctrl ctrlSetPosition _cpos;
		_ctrl ctrlCommit 0.3;
		GVAR(mag_check_open) = false;
	};
};
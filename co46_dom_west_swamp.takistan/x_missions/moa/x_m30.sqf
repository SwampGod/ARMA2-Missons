// by Xeno
#include "x_setup.sqf"
private ["_trigger", "_cm", "_endtime", "_ran", "_i", "_newgroup", "_units", "_leader"];
x_sm_pos = [[1179.44,7422.92,0]]; //  cruise missile
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "One of our planes has lost a cruise missile in the northern territories, bad luck for us, it didn't explode. Find it and destroy it before the enemy gets it's hands on it. Be aware they are also heading for the crash site!";
	d_current_mission_resolved_text = "Good job. The cruise missile is down.";
};

if (isServer) then {
	_trigger = objNull;
	_exact_pos = [x_sm_pos select 0, 300] call XfGetRanPointCircleOld;
#ifndef __OA__
	_cm = "CruiseMissile2" createVehicle _exact_pos;
#else
	_cm = "Chukar_EP1" createVehicle _exact_pos;
#endif
	_cm lock true;
	_cm setDir (random 360);
	_cm setPos _exact_pos;
	__AddToExtraVec(_cm)
	_cm addEventHandler ["killed", {_this call XKilledSMTargetNormal;(_this select 0) spawn {sleep 2;deleteVehicle _this}}];
	sleep 20;
	_time_over = 3;
	_enemy_created = false;
	d_cruise_m_enemy = false;
	_endtime = time + (15 * 60);
	while {true} do {
		if (isNull _cm || !alive _cm || d_cruise_m_enemy) exitWith {};
		if (_time_over > 0) then {
			if (_time_over == 3) then {
				if (_endtime - time <= 600) then {
					_time_over = 2;
					d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSM",["1","","10",[]],true];
				};
			} else {
				if (_time_over == 2) then {
					if (_endtime - time <= 300) then {
						_time_over = 1;
						d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSM",["1","","5",[]],true];
					};
				} else {
					if (_time_over == 1) then {
						if (_endtime - time <= 120) then {
							_time_over = 0;
							d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSMTwoM",true];
						};
					};
				};
			};
		} else {
			if (!_enemy_created) then {
				_trigger = [_exact_pos, [20,20,0,false], [d_enemy_side,"PRESENT",false], ["this","d_cruise_m_enemy = true",""]] call XfCreateTrigger;
				_enemy_created = true;
				_estart_pos = [_exact_pos,300] call XfGetRanPointCircleOuter;
				_unit_array = ["basic", d_enemy_side] call x_getunitliste;
				_ran = [3,5] call XfGetRandomRangeInt;
				for "_i" from 1 to _ran do {
					_newgroup = [d_enemy_side] call x_creategroup;
					_units = [_estart_pos, (_unit_array select 0), _newgroup] call x_makemgroup;
					sleep 1.045;
					_leader = leader _newgroup;
					_leader setRank "LIEUTENANT";
					_newgroup allowFleeing 0;
					[_newgroup, _exact_pos] call XAttackWP;
					extra_mission_remover_array = [extra_mission_remover_array, _units] call X_fnc_arrayPushStack;
					sleep 1.012;
				};
				_unit_array = nil;
			};
		};
		sleep 5.223;
	};

	if (!isNull _trigger) then {deleteVehicle _trigger};

	if (d_cruise_m_enemy && !isNull _cm) then {
		_cm removeAllEventHandlers "killed";
		d_side_mission_winner = -878;
	};

	d_cruise_m_enemy = nil;

	d_side_mission_resolved = true;
};
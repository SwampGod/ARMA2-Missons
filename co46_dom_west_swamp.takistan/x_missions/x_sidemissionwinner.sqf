// by Xeno
#include "x_setup.sqf"
private ["_bonus_pos","_bonus_string","_bonus_vehicle","_s", "_bonus_number"];

if (!X_Client) exitWith {};

_bonus_number = _this;

sleep 1;

deleteMarkerLocal (format ["XMISSIONM%1", x_sm_oldmission_index + 1]);
if (x_sm_type == "convoy") then {deleteMarkerLocal (format ["XMISSIONM2%1", x_sm_oldmission_index + 1])};

d_current_mission_text="No new side mission available...";

if (d_side_mission_winner != 0 && _bonus_number != -1) then {
	if (d_with_ranked) then {
		_get_points = false;
		if (isNil "d_sm_p_pos") then {
			_posi_array = x_sm_pos;
			_posione = _posi_array select 0;
			if (player distance _posione < (d_ranked_a select 12)) then {_get_points = true};
		} else {
			if (!(isNil "d_sm_p_pos") && d_was_at_sm && x_sm_type != "convoy") then {
				if (player distance d_sm_p_pos < (d_ranked_a select 12)) then {_get_points = true};
			} else {
				if (!(isNil "d_sm_p_pos")) then {
					if (player distance d_sm_p_pos < (d_ranked_a select 12)) then {_get_points = true};
				};
			};
		};
		if (_get_points) then {
			(format ["You get %1 extra points for helping solving the sidemission!",(d_ranked_a select 11)]) call XfHQChat;
			[] spawn {
				sleep (0.5 + random 2);
				["d_pas", [player, (d_ranked_a select 11)]] call XNetCallEvent;
			};
		};
		d_sm_p_pos = nil;
	};

	_bonus_vehicle = "";
	_bonus_pos = "your base.";
	#ifndef __TT__
	_type_name = d_sm_bonus_vehicle_array select _bonus_number;
	_bonus_vehicle = [_type_name,0] call XfGetDisplayName;
	#endif

#ifndef __TT__	
	_bonus_string = format["Your team gets a %1, it's available at %2", _bonus_vehicle, _bonus_pos];
#else
	_team = switch (d_side_mission_winner) do {
		case 1: {"Team East gets"};
		case 2: {"Team West gets"};
		case 123: {"Both teams get"};
	};
	_bonus_string = format["%1 a bonus vehicle, it's available at %2", _team, _bonus_pos];
#endif

	if (d_SidemissionsOnly == 1) then {
		hint  composeText[
			parseText("<t color='#f0ffff00' size='1'>Sidemission resolved</t>"), lineBreak,lineBreak,
			"Congratulations...", lineBreak,lineBreak,
			d_current_mission_resolved_text, lineBreak, lineBreak,
			_bonus_string
		];
	} else {
		hint  composeText[
			parseText("<t color='#f0ffff00' size='1'>Sidemission resolved</t>"), lineBreak,lineBreak,
			"Congratulations...", lineBreak,lineBreak,
			d_current_mission_resolved_text
		];
	};
} else {
	_s = switch (d_side_mission_winner) do {
		case -1: {"The sidemission target died due to a tragic accident..."};
		case -2: {"The enemy decided to destroy the sidemission target by itself..."};
		case -300: {"The convoy reached its destination..."};
		case -400: {"None or less than 8 prisoners made it back to base..."};
		case -500: {"The enemy officer was killed..."};
		case -600: {"The prototype was destroyed before it reached your base..."};
		case -700: {"The pilots where killed before they reached the base..."};
		case -878: {"The enemies reached the cruise missile before us..."};
		case -879: {"The enemy has launched the scud before we could destroy it..."};
		default {""};
	};
	if (_s != "") then {
		hint  composeText[
			parseText("<t color='#f0ff00ff' size='1'>" + "Sidemission not resolved" + "</t>"), lineBreak,lineBreak,
			_s
		];
	};
};

sleep 1;
d_side_mission_winner = 0;
/*
MARKER COLOR SCRIPT

� OCTOBER 2008 - norrin (norrins_nook@iprimus.com.au)
*/
_Base_1 = NORRN_revive_array select 13;
_Base_2 = NORRN_revive_array select 14;
_Base_3 = NORRN_revive_array select 15;
_Base_4 = NORRN_revive_array select 16;

_no_enemy_sides = NORRN_revive_array select 22;

while {true} do {
	if (_no_enemy_sides in [1,2]) then {
		if (no_base_1) then {_Base_1 setMarkerColor "ColorRed"} else {_Base_1 setMarkerColor "ColorGreen"};
		if (no_base_2) then {_Base_2 setMarkerColor "ColorRed"} else {_Base_2 setMarkerColor "ColorGreen"};
		if (no_base_3) then {_Base_3 setMarkerColor "ColorRed"} else {_Base_3 setMarkerColor "ColorGreen"};
		if (no_base_4) then {_Base_4 setMarkerColor "ColorRed"} else {_Base_4 setMarkerColor "ColorGreen"};
	};

	if (_no_enemy_sides == 2) then {
		if (no_base_1b) then {_Base_1 setMarkerColor "ColorRed"} else {_Base_1 setMarkerColor "ColorGreen"};
		if (no_base_2b) then {_Base_2 setMarkerColor "ColorRed"} else {_Base_2 setMarkerColor "ColorGreen"};
		if (no_base_3b) then {_Base_3 setMarkerColor "ColorRed"} else {_Base_3 setMarkerColor "ColorGreen"};
		if (no_base_4b) then {_Base_4 setMarkerColor "ColorRed"} else {_Base_4 setMarkerColor "ColorGreen"};
	};
	sleep 3;
};
// by Xeno
#include "x_setup.sqf"

// I'm using x_mXX.sqf for the mission filename where XX (index number) has to be added to sm_array
d_mission_filename = "x_m";

// sm_array contains the indices of the sidemissions (it gets shuffled later)
// to remove a specific side mission just remove the index from sm_array
#ifdef __DEFAULT__
sm_array = if (__OAVer) then {
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,36,40,41,42,44,46,47,49,50,51,52]
} else {
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,36,37,38,39,40,41,42,44,45,46,47,48,49,50,51,52]
};

if (__OAVer) then {
	if (d_enemy_side == "WEST") then {
		sm_array = sm_array - [7,11];
	};
};

if (!isNil "d_with_carrier") then {sm_array = sm_array - [3]};

if (d_FastTime == 0) then {sm_array = sm_array - [51,52]};
#endif
#ifdef __TT__
sm_array = if (__OAVer) then {
	[0,1,2,3,4,5,6,7,8,10,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,36,40,42,44,46,47]
} else {
	[0,1,3,4,5,6,7,8,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,31,32,33,34,36,37,38,39,40,41,42,45,46,47,48,49,50]
};
#endif
#ifdef __EVERON__
sm_array = [0,1,3,4,6,7,8,10,11,12,13,14,15,16,17,20,21,22,24,27,32,33,34,37,38,40,42,44,50,51,52];

if (d_FastTime == 0) then {sm_array = sm_array - [51,52]};
#endif

number_side_missions = count sm_array;

// just for debugging
// it will create markers at each sidemission position
#ifdef __SMMISSIONS_MARKER__
[] spawn {
	sleep 1;
	{
		_ffolder = if (__OAVer) then {"moa"} else {"m"};
		// for EVERON... this game does like nested preprocessor commands only sometimes
		//_ffolder = "mev";
		_mfolder = "x_missions\" + _ffolder + "\%2%1.sqf";
		[1,1] call compile preprocessFileLineNumbers (format [_mfolder, _x, d_mission_filename]);
		_start_pos = x_sm_pos select 0;
		_name = format ["Sidemission: %1", _x];
		_marker= createMarkerLocal [_name, _start_pos];
		_marker setMarkerTypeLocal "DOT";
		_name setMarkerColorLocal "ColorBlack";
		_name setMarkerSizeLocal [0.2,0.2];
		_name setMarkerTextLocal _name;
	} forEach sm_array;
};
#endif

if (isServer) then {
	// if set to false sidemissons won't get shuffled so you are able to set up a specific order of sidemissions
	d_random_sm_array = true;
	
	XKilledSMTargetNormal = {
		d_side_mission_winner = if (side (_this select 1) == d_side_player) then {2} else {-1};
		d_side_mission_resolved = true;
	};
#ifdef __TT__
	XKilledSMTargetTT = {
		d_side_mission_winner = switch (side (_this select 1)) do {case east:{1}; case west:{2}; default{-1};};
		d_side_mission_resolved = true;
	};
	
	XfAddSMPoints = {
		switch (side (_this select 1)) do {case west: {__INC(sm_points_west)};case east: {__INC(sm_points_east)}};
	};
#endif
	XKilledSMTarget500 = {
		d_side_mission_winner = -500;
		d_side_mission_resolved = true;
	};
	
	// these vehicles get spawned in a convoy sidemission. Be aware that it is the best to use a wheeled vehicle first as leader.
	// at least wheeled AI vehicles try to stay on the road somehow
#ifndef __OA__
	d_sm_convoy_vehicles = switch (d_enemy_side) do {
		case "EAST": {["BTR90","BMP3", "2S6M_Tunguska", "KamazRepair", "KamazRefuel", "KamazReammo", "T90"]};
		case "WEST": {["LAV25","AAV", "HMMWV_Avenger", "MtvrRepair", "MtvrRefuel", "MtvrReammo", "M1A2_TUSK_MG"]};
		case "GUER": {["BRDM2_Gue","BMP2_Gue", "Ural_ZU23_Gue", "V3S_Gue", "V3S_Gue", "V3S_Gue", "T72_Gue"]};
	};
#else
	d_sm_convoy_vehicles = switch (d_enemy_side) do {
		case "EAST": {["BTR60_TK_EP1","BMP2_TK_EP1", "ZSU_TK_EP1", "UralRepair_TK_EP1", "UralRefuel_TK_EP1", "UralReammo_TK_EP1", "T72_TK_EP1"]};
		case "WEST": {["M1126_ICV_M2_EP1","M2A3_EP1", "M6_EP1", "MtvrRepair_DES_EP1", "MtvrRefuel_DES_EP1", "MtvrReammo_DES_EP1", "M1A2_US_TUSK_MG_EP1"]};
		case "GUER": {["BTR40_MG_TK_GUE_EP1","BRDM2_TK_GUE_EP1", "Ural_ZU23_TK_GUE_EP1", "V3S_Repair_TK_GUE_EP1", "V3S_Refuel_TK_GUE_EP1", "V3S_Reammo_TK_GUE_EP1", "T55_TK_GUE_EP1"]};
	};
#endif
};
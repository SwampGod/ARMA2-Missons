// init_related_scripts.sqf ArmA2 revive
// � JULY 2009 - norrin 

_mission_end_function = NORRN_revive_array select 0;
_max_respawns = NORRN_revive_array select 38;
_mobile_spawn = NORRN_revive_array select 51; 
_no_enemy_sides = NORRN_revive_array select 22;
_mobile_man = NORRN_revive_array select 53;
_mobile_type = NORRN_revive_array select 60;

// if (isServer && _mobile_spawn == 1) then {NORRN_camo_net = false; publicVariable "NORRN_camo_net"};
//if (_mobile_spawn == 1) then {r_ms_base_1 = _Base_1};

Norrn_AIBehaviour = Compile PreprocessFile "revive_sqf\functions\AIBehaviour.sqf";
Norrn_WaterFix = Compile PreprocessFile "revive_sqf\functions\WaterFix.sqf";
GetTerrainSlope = Compile PreprocessFile "revive_sqf\functions\GetTerrainSlope.sqf";
Norrn_SlopeFix = Compile PreprocessFile "revive_sqf\functions\SlopeFix.sqf";
Norrn_CallOut = Compile PreprocessFile "revive_sqf\functions\CallOut.sqf";
Norrn_UncAnimFix = Compile PreprocessFile "revive_sqf\functions\UncAnimFix.sqf";
Norrn_LeaderFix = Compile PreprocessFile "revive_sqf\functions\LeaderFix.sqf";
Norrn_LivesRemain = Compile PreprocessFile "revive_sqf\functions\LivesRemain.sqf";
Norrn_RespawnPos1 = Compile PreprocessFile "revive_sqf\functions\RespawnPos1.sqf";
Norrn_RespawnPos2 = Compile PreprocessFile "revive_sqf\functions\RespawnPos2.sqf";
Norrn_RespawnPos2AI = Compile PreprocessFile "revive_sqf\functions\RespawnPos2AI.sqf";
Norrn_Call4Help = Compile PreprocessFile "revive_sqf\functions\I_need_help.sqf";
Norrn_AI_throwSmoke = Compile PreprocessFile "revive_sqf\functions\AI_throwSmoke.sqf";
NORRN_DropWeapons = Compile PreprocessFile "revive_sqf\functions\dropWeapons.sqf";
NORRN_load_wounded = Compile PreprocessFile "revive_sqf\load_wounded\load_wounded.sqf";
NORRN_respawn_chance = Compile PreprocessFile "revive_sqf\functions\respawn_chance.sqf";
NORRN_respawn_time = Compile PreprocessFile "revive_sqf\functions\respawn_time.sqf";
NORRN_createBody = Compile PreprocessFile "revive_sqf\functions\createBody.sqf";
NORRN_uncTimer = Compile preprocessfile "revive_sqf\functions\uncTimer.sqf";
NORRN_UNC_CAM = Compile preprocessfile "revive_sqf\cam_follow.sqf";
Norrn_DialogBlink = 0;

mission_Over = false;
[] execVM "revive_sqf\revive_init.sqf";

if (isServer) then {
	[NORRN_player_units] execVM "revive_sqf\isplayer.sqf";
	
	// mission_Over = false;
	// publicVariable "mission_Over"; 

	// if (_mission_end_function == 1) then {[NORRN_player_units] execVM "revive_sqf\mission_end.sqf"};

	// if (isNil "d_init_started") then {
		// if (_no_enemy_sides > 0) then {[] execVM "revive_sqf\marker_color.sqf"};
	// };

	// if (_mobile_spawn == 1) then {
		// if (_mobile_type == 0) then {
			// [r_mobile_spawn_vcl, 0] execVM "revive_sqf\mobile\move_spawn.sqf"
		// } else {
			// NORRN_mobile_man = ObjNull;
			// [_mobile_man, 1] execVM "revive_sqf\mobile\move_spawn.sqf"
		// };
	// };
};

//if (_mobile_spawn == 1) then {[] execVM "revive_sqf\mobile\mobile_marker.sqf"};

// if (player == _mobile_man) then {
	// [_mobile_man, _mobile_man] execVM "revive_sqf\mobile\mobile_spawn.sqf";
	// NORRN_mobile_man = player;
	// publicVariable "NORRN_mobile_man";
// };

OFPEC_MouseCoord = [0.5,0.5];
OFPEC_MouseScroll = 0;
OFPEC_MouseButtons =[false,false];
OFPEC_camzoomspeed = 1.0;
OFPEC_maxzoomout = 400;
OFPEC_range_to_unit = 5;

// if (_max_respawns == 2000) then {[str(player)] execVM "revive_sqf\respawn\init_respawn.sqf"};
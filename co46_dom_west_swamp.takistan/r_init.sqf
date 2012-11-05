#include "x_setup.sqf"
/*
  ARMA2 REVIVE SCRIPT - AI enabled or disabled

  © NOVEMBER 2009 - norrin (norrin@iinet.net.au)

  Version:  0.3g ArmA2
*/

waitUntil {X_INIT};
T_MP = X_MP;
T_INIT 	= X_INIT;
T_Server 	= X_Server; 
T_Client 	= X_Client; 
T_JIP 	= X_JIP;
if (X_Client) then {if (isMultiplayer) then {waitUntil {!isNil "d_still_in_intro"};waitUntil {local player && !d_still_in_intro}} else {waitUntil {local player}}};
sleep 3;

_mission_end_function = 0;
_call_out_function = 1;
_water_dialog = 1;
_unconscious_drag = 1;
_load_wounded= 1;
_altUnc_animation = 0;
_JIP_spawn_dialog = 0;
_time_b4_JIP_spawn_dialog = 10000;
_perpetual_server = 0;
NORRN_player_units = d_player_entities;
_max_respawns = d_NORRN_max_respawns;
_JIP_respawns = [0,30];
_revive_timer = 1;
_revive_time_limit = d_NORRN_revive_time_limit;
_revive_damage = 0;
_unconscious_markers = 1;
_caseVAC = [1, ["MASH","HMMWV_Base"]];
_mediVAC = [];
_chance_ofDeath = [0,0];
_dualTimer = 0;
_deadSpectator_cam = 1;
_no_respawn_points = 3;
_Base_1 = "base_spawn_1";
_Base_2 = "Respawn 1";
_Base_3 = "Respawn ";
_Base_4 = "";
_Base_free_respawn = [1,1,1,0];
_respawn_at_base_addWeapons = 0;
_respawn_at_base_magazines = [];
_respawn_at_base_weapons = [];
_respawn_position = 2;
_respawnAtBaseWait = [0,0];
_objectiveBasedRP = [];
_mobile_spawn = 0;
_mobile_base2_start = "";
_mobile_type = 0;
_mobile_man = objNull;
_mobile_man2 = objNull;
_soldier = switch (d_own_side) do {
	case "EAST": {"soldierEB"};
	case "WEST": {"soldierWB"};
	case "GUER": {"soldierGB"};
};
_soldier2 = switch (d_own_side) do {
	case "EAST": {"RU_Soldier_Medic"};
	case "WEST": {"USMC_Soldier_Medic"};
	case "GUER": {"GUE_Soldier_Medic"};
};
_soldier2a = switch (d_own_side) do {
	case "EAST": {""};
	case "WEST": {"FR_Corpsman"};
	case "GUER": {""};
};
_can_revive = "soldierWB";
_can_revive_2 = "soldierGB";
_can_revive_3 = "";
_can_revive_4 = "";
_can_be_revived = "soldierWB";
_can_be_revived_2 = "soldierGB";
_can_be_revived_3 = "";
_can_be_revived_4 = "";
_medic_1 = "US_Soldier_Medic_EP1";
_medic_2 = "BAF_Soldier_Medic_DDPM";
_medic_3 = "";
_medic_4 = "";
_medpacks = 1;
_stabilisation = 0;
_bleeding = 1;
_medic_medpacks = 10;
_unit_medpacks = 10;
_medic_bandages = 10;
_unit_bandages = 10;
_medic_stable = 0;
_unit_stable = 0;
_stabTime_tillDeath = 0;
_r_side_enemy = switch (d_enemy_side) do {
	case "EAST": {"EAST"};
	case "WEST": {"WEST"};
	case "GUER": {"RESISTANCE"};
};
_no_enemy_sides = 1;
_enemy_side_1 = _r_side_enemy;
_enemy_side_2 = "";
_enemy_side_3 = "";
_enemy_side_4 = "";
_r_side = switch (d_own_side) do {
	case "EAST": {"EAST"};
	case "WEST": {"WEST"};
	case "GUER": {"RESISTANCE"};
};
_allied_side_1 = _r_side;
_allied_side_2 = _r_side;
_allied_side_3 = "";
_allied_side_4 = "";
_follow_cam = 1;
_follow_cam_distance = 250;
_follow_cam_team = 1;
_top_view_height = 70;
_visible_timer = 1;
_unconscious_music = 0;
_nearest_teammate_dialog = 1;
_all_dead_dialog = 1;
_respawn_button_timer = d_NORRN_respawn_button_timer;
_distance_to_friend = 250;
_all_dead_player = 1;
_all_dead_distance = 10000;
_reward_function = 1;
_revives_required = 1;
_team_kill_function = 1;
_no_team_kills = 1;
_heal_yourself = 1;
_no_of_heals = d_NORRN_no_of_heals;
_lower_bound_heal = 0.1;
_upper_bound_heal = 0.8;
_goto_revive = 0;
_AI_smoke = 1;
_AI_aware = 0;
_AI_cover = 1;
_AI_dismount = 0;
_call_for_AI_help = 0;
_goto_revive_distance = 500;
_drop_weapons = 0;
_cadaver = 0;
_bury_timeout = 12;
NORRNCustomExec1 ="";
NORRNCustomExec2 ="";
NORRNCustomExec3 ="";
NORRNCustomExec4 ="";
NORRNCustomExec5 ="";
NORRN_revive_array = [];
NORRN_revive_array = [_mission_end_function,_all_dead_dialog,_JIP_spawn_dialog,_nearest_teammate_dialog,_unconscious_markers,_follow_cam,_call_out_function,_revive_timer,
_heal_yourself,_goto_revive,-1,_respawn_at_base_addWeapons,_no_respawn_points,_Base_1,_Base_2,_Base_3,_Base_4,_time_b4_JIP_spawn_dialog,
_can_revive,_can_revive_2,_can_be_revived,_can_be_revived_2,_no_enemy_sides,_enemy_side_1,_enemy_side_2,_respawn_button_timer,_distance_to_friend,
_revive_time_limit,_respawn_position,_no_of_heals,_lower_bound_heal,_upper_bound_heal,_follow_cam_distance,_goto_revive_distance,_respawn_at_base_magazines,
_respawn_at_base_weapons, _Base_free_respawn, _revive_damage, _max_respawns, _unconscious_drag,_AI_smoke,_visible_timer,_allied_side_1,_allied_side_2,_follow_cam_team,
_water_dialog, _unconscious_music, -1, -1, _AI_aware,_AI_cover,_mobile_spawn,"",_mobile_man,_altUnc_animation,_top_view_height,
_all_dead_player,_all_dead_distance,_AI_dismount,_call_for_AI_help,_mobile_type,_load_wounded,_perpetual_server,_JIP_respawns,_caseVAC,_mediVAC,_chance_ofDeath,_dualTimer,
_respawnAtBaseWait,_objectiveBasedRP,_mobile_base2_start,_mobile_man2,_can_revive_3,_can_revive_4,_can_be_revived_3,_can_be_revived_4,_medic_1,_medic_2,_medic_3,_medic_4,
_medpacks,_stabilisation,_bleeding,_medic_medpacks,_unit_medpacks,_medic_bandages,_unit_bandages,_stabTime_tillDeath,_enemy_side_3,_enemy_side_4,
_allied_side_3,_allied_side_4,_deadSpectator_cam,_drop_weapons,_cadaver,_bury_timeout,_reward_function,_revives_required,_team_kill_function,_no_team_kills,_medic_stable, _unit_stable];

[] execVM "revive_sqf\init_related_scripts.sqf";
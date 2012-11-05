// by Xeno
#include "x_setup.sqf"
private ["_ok","_oldpos","_exitj"];

disableSerialization;

_ari_num = (_this select 3) select 0;
_ari_target = (_this select 3) select 1;

_ariavailstr = switch (_ari_num) do {
	case 1: {"ari_available"};
	case 2: {"ari2_available"};
};

_firstsecondstr = switch (_ari_num) do {
	case 1: {"First"};
	case 2: {"Second"};
};

_arti_markername = switch (_ari_num) do {
	case 1: {"arti_target"};
	case 2: {"arti_target2"};
}; 

if (!(X_JIPH getVariable _ariavailstr)) exitWith {
#ifndef _TT__
	_str = _firstsecondstr + " artillery currently not available...";
#else
	_str = "Artillery currently not available...";
#endif
	_str call XfHQChat;
};

_exitj = false;
if (d_with_ranked) then {
	_score = score player;
	if (_score < (d_ranked_a select 2)) exitWith {
		(format ["You don't have enough points to call an artillery strike. You need %2 points for a strike, your current score is %1", _score,(d_ranked_a select 2)]) call XfHQChat;
		_exitj = true;
	};
};

if (_exitj) exitWith {};

["arti1_marker_1",position player,"ELLIPSE","ColorYellow",[ArtiOperatorMaxDist,ArtiOperatorMaxDist],"",0,"","FDiagonal"] call XfCreateMarkerLocal;

d_ari_type = "";
d_ari_salvos = 1;
_oldpos = position _ari_target;
_ok = createDialog "XD_ArtilleryDialog";
if (d_with_ranked) then {
	_XD_display = __uiGetVar(D_ARTI_DISP);
	_rank = rank player;
	if (_rank in ["PRIVATE","CORPORAL"]) then {
		_control = _XD_display displayCtrl 11007;
		_control ctrlShow false;
		_control = _XD_display displayCtrl 11008;
		_control ctrlShow false;
	} else {
		if (_rank in ["SERGEANT","LIEUTENANT"]) then {
			_control = _XD_display displayCtrl 11008;
			_control ctrlShow false;
		};
	};
};
D_ARTI_HELPER = switch (_ari_num) do {
	case 1: {D_AriTarget};
	case 2: {D_AriTarget2};
};
D_ARTI_MARKER_HELPER = _arti_markername;
onMapSingleClick "D_ARTI_HELPER setpos _pos;D_ARTI_MARKER_HELPER setMarkerPos _pos";

waitUntil {d_ari_type != "" || !dialog || !alive player};

onMapSingleClick "";
deleteMarkerLocal "arti1_marker_1";
if (!alive player) exitWith {if (dialog) then {closeDialog 0}};
if (d_ari_type != "") then {
	if (!(X_JIPH getVariable _ariavailstr)) exitWith {"Somebody else allready executed an artillery strike, artillery currently not available..." call XfHQChat};
	
	if (player distance [position _ari_target select 0,position _ari_target select 1,0] > ArtiOperatorMaxDist) exitWith {
		(format ["You are to far away from your selected target, no line of sight !!! Get closer (<%1 m).", ArtiOperatorMaxDist]) call XfHQChat;
		_ari_target setpos _oldpos;
		_arti_markername setMarkerPos _oldpos;
	};
	
	_no = objNull;
	if (d_arti_check_for_friendlies == 0) then {
		if (d_ari_type == "he" || d_ari_type == "dpicm") then {
			_man_type = switch (d_own_side) do {
				case "WEST": {"SoldierWB"};
				case "EAST": {"SoldierEB"};
				case "GUER": {"SoldierGB"};
			};
			_pos_at = [position _ari_target select 0,position _ari_target select 1,0];
			_no = nearestObject [_pos_at, _man_type];
		};
	};
	
	if (!isNull _no) exitWith {
		"Friendlies near artillery target. Aborting artillery strike..." call XfHQChat;
		_ari_target setpos _oldpos;
		_arti_markername setMarkerPos _oldpos;
	};

	if (d_with_ranked) then {
		if ((d_ranked_a select 2) > 0) then {["d_pas", [player, (d_ranked_a select 2) * -1]] call XNetCallEvent};
	};
	["d_say", [player,"Funk"]] call XNetCallEvent;
	#ifndef __TT__
	player kbTell [d_kb_logic1,d_kb_topic_side_arti,"ArtilleryRequest",["1","",d_ari_type,[]],["2","",str(d_ari_salvos),[]],["3","",str(getPosASL _ari_target select 1),[]],["4","",str(getPosASL _ari_target select 0),[]],true];
	#else
	_topicside = switch (_ari_num) do {
		case 1: {"HQ_ART_W"};
		case 2: {"HQ_ART_E"};
	};
	_logic = switch (_ari_num) do {
		case 1: {d_hq_logic_en1};
		case 2: {d_hq_logic_ru1};
	};
	player kbTell [_logic,_topicside,"ArtilleryRequest",["1","",d_ari_type,[]],["2","",str(d_ari_salvos),[]],["3","",str(getPosASL _ari_target select 1),[]],["4","",str(getPosASL _ari_target select 0),[]],true];
	#endif
	["ari_type", [d_ari_type,d_ari_salvos,player,_ari_target,_ariavailstr,_ari_num]] call XNetCallEvent;
} else {
	"Artillery canceled" call XfHQChat;
	_ari_target setpos _oldpos;
	_arti_markername setMarkerPos _oldpos;
};

// by Xeno
#define THIS_FILE "x_artillery.sqf"
#include "x_setup.sqf"
private ["_ok","_oldpos","_exitj"];

if (!alive player) exitWith {};
if (vehicle player == player && position player select 2 > 10) exitWith {};

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
	case 1: {QGVAR(arti_target)};
	case 2: {QGVAR(arti_target2)};
}; 

if !(X_JIPH getVariable _ariavailstr) exitWith {
#ifndef _TT__
	_str = _firstsecondstr + " artillery currently not available...";
#else
	_str = "Artillery currently not available...";
#endif
	_str call FUNC(HQChat);
};

_exitj = false;
if (GVAR(with_ranked)) then {
	_score = score player;
	if (_score < (GVAR(ranked_a) select 2)) exitWith {
		(format ["You don't have enough points to call an artillery strike. You need %2 points for a strike, your current score is %1", _score, GVAR(ranked_a) select 2]) call FUNC(HQChat);
		_exitj = true;
	};
};

if (_exitj) exitWith {};

_exitIt = false;
if (GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
	if (__XJIPGetVar(GVAR(ari_blocked))) then {
		"Somebody else is calling an artillery strike... you have to try again later..." call FUNC(HQChat);
		_exitIt = true;
	};
};
if (_exitIt) exitWith {};

if (GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
	[QGVAR(ari_blocked),true] call FUNC(NetSetJIP);
};

["arti1_marker_1",getPosASL player,"ELLIPSE","ColorYellow",[GVAR(ArtiOperatorMaxDist),GVAR(ArtiOperatorMaxDist)],"",0,"","FDiagonal"] call FUNC(CreateMarkerLocal);

GVAR(ari_type) = "";
GVAR(ari_salvos) = 1;
GVAR(ARTI_HELPER) = switch (_ari_num) do {
	case 1: {GVAR(AriTarget)};
	case 2: {GVAR(AriTarget2)};
};
GVAR(ARTI_MARKER_HELPER) = _arti_markername;
_oldpos = getPosASL _ari_target;
createDialog "XD_ArtilleryDialog";

waitUntil {GVAR(ari_type) != "" || !GVAR(arti_dialog_open) || !alive player || __pGetVar(xr_pluncon)};

deleteMarkerLocal "arti1_marker_1";
if (!alive player || __pGetVar(xr_pluncon)) exitWith {
	if (GVAR(arti_dialog_open)) then {closeDialog 0};
	if (GVAR(with_ai)|| GVAR(with_ai_features) == 0) then {
		[QGVAR(ari_blocked), false] call FUNC(NetSetJIP);
	};
};
if (GVAR(ari_type) != "") then {
	if !(X_JIPH getVariable _ariavailstr) exitWith {"Somebody else allready executed an artillery strike, artillery currently not available..." call FUNC(HQChat)};
	_ppl = getPosASL player;
	_ppl set [2,0];
	if (_ppl distance [getPosASL _ari_target select 0,getPosASL _ari_target select 1,0] > GVAR(ArtiOperatorMaxDist)) exitWith {
		(format ["You are to far away from your selected target, no line of sight !!! Get closer (<%1 m).", GVAR(ArtiOperatorMaxDist)]) call FUNC(HQChat);
		_ari_target setPosASL _oldpos;
		_arti_markername setMarkerPos _oldpos;
	};
	
	_no = objNull;
	if (GVAR(arti_check_for_friendlies) == 0) then {
		if (GVAR(ari_type) == "he" || GVAR(ari_type) == "dpicm") then {
			_man_type = switch (GVAR(own_side)) do {
				case "WEST": {"SoldierWB"};
				case "EAST": {"SoldierEB"};
				case "GUER": {"SoldierGB"};
			};
			_pos_at = [getPosASL _ari_target select 0, getPosASL _ari_target select 1, 0];
			_no = nearestObject [_pos_at, _man_type];
		};
	};
	
	if (!isNull _no) exitWith {
		"Friendlies near artillery target. Aborting artillery strike..." call FUNC(HQChat);
		_ari_target setPosASL _oldpos;
		_arti_markername setMarkerPos _oldpos;
	};

	if (GVAR(with_ranked)) then {
		if ((GVAR(ranked_a) select 2) > 0) then {[QGVAR(pas), [player, (GVAR(ranked_a) select 2) * -1]] call FUNC(NetCallEvent)};
	};
	[QGVAR(say), [player,"Funk"]] call FUNC(NetCallEvent);
	#ifndef __TT__
	player kbTell [GVAR(kb_logic1),GVAR(kb_topic_side_arti),"ArtilleryRequest",["1","",GVAR(ari_type),[]],["2","",str(GVAR(ari_salvos)),[]],["3","",mapGridPosition getPosASL _ari_target,[]],true];
	#else
	_topicside = switch (_ari_num) do {
		case 1: {"HQ_ART_W"};
		case 2: {"HQ_ART_E"};
	};
	_logic = switch (_ari_num) do {
		case 1: {GVAR(hq_logic_en1)};
		case 2: {GVAR(hq_logic_ru1)};
	};
	player kbTell [_logic,_topicside,"ArtilleryRequest",["1","",GVAR(ari_type),[]],["2","",str(GVAR(ari_salvos)),[]],["3","",mapGridPosition getPosASL _ari_target,[]],true];
	#endif
	[QGVAR(ari_type), [GVAR(ari_type),GVAR(ari_salvos),player,_ari_target,_ariavailstr,_ari_num]] call FUNC(NetCallEvent);
} else {
	"Artillery canceled" call FUNC(HQChat);
	_ari_target setpos _oldpos;
	_arti_markername setMarkerPos _oldpos;
};

if (GVAR(with_ai)|| GVAR(with_ai_features) == 0) then {
	[QGVAR(ari_blocked),false] call FUNC(NetSetJIP);
};
#include "x_setup.sqf"
if (!X_Client) exitWith {};
private ["_array","_control","_display","_ok","_oldpos"];

if (!__XJIPGetVar(para_available)) exitWith {"Transport chopper in the air... Drop not available!" call XfHQChat};

_score = score player;
if (d_with_ranked && (_score < (d_ranked_a select 16))) exitWith {(format ["You don't have enough points to call in an air drop. You need %2 points for an air drop, your current score is %1", _score,(d_ranked_a select 16)]) call XfHQChat};

["arti1_marker_1",position player,"ELLIPSE","ColorYellow",[d_drop_max_dist,d_drop_max_dist],"",0,"","FDiagonal"] call XfCreateMarkerLocal;

x_drop_type = "";
_oldpos = position X_DropZone;
disableSerialization;
_ok = createDialog "XD_AirDropDialog";
_display = __uiGetVar(D_DROP_DIALOG);
_control = _display displayCtrl 11002;
_array = x_drop_array select 0;
_control ctrlSetText (_array select 0);
if (count x_drop_array > 1) then {
	_control = _display displayCtrl 11003;
	_array = x_drop_array select 1;
	_control ctrlSetText (_array select 0);
} else {
	ctrlShow [11003, false];
	ctrlShow [11004, false];
};
if (count x_drop_array > 2) then {
	_control = _display displayCtrl 11004;
	_array = x_drop_array select 2;
	_control ctrlSetText (_array select 0);
};

onMapSingleClick "X_DropZone setpos _pos;""x_drop_zone"" setMarkerPos _pos;";

waitUntil {x_drop_type != "" || !dialog || !alive player};
onMapSingleClick "";

deleteMarkerLocal "arti1_marker_1";
if (!alive player) exitWith {if (dialog) then {closeDialog 0}};
if (x_drop_type != "") then {
	if (player distance [position X_DropZone select 0, position X_DropZone select 1, 0] > d_drop_max_dist) exitWith {
		(format ["You are to far away from the drop point, no line of sight !!! Get closer (<%1 m).", d_drop_max_dist]) call XfHQChat;
		x_dropzone setpos _oldpos;
		"x_drop_zone" setMarkerPos _oldpos;
	};
	[player, format ["Calling in %1 air drop", x_drop_type]] call XfSideChat;
	if (d_with_ranked) then {["d_pas", [player, (d_ranked_a select 16) * -1]] call XNetCallEvent};
	["x_dr_t", [x_drop_type,markerPos "x_drop_zone",player]] call XNetCallEvent;
} else {
	"Air drop canceled" call XfHQChat;
	x_dropzone setpos _oldpos;
	"x_drop_zone" setMarkerPos _oldpos;
};
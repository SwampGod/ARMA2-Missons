// by Xeno and Carl Gustaffa
#include "x_setup.sqf"

if (isNull __XJIPGetVar(d_searchbody)) exitWith {};

_body = _this select 0;

if (alive _body) exitWith {"He is still alive, you can't search him then..." call XfGlobalChat};
if (player distance _body > 3) exitWith {"You are too far away from the body..." call XfGlobalChat};

"Checking body, please wait" call XfGlobalChat;
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!alive player) exitWith {"You died before you finished checking the body." call XfGlobalChat};

if (isNull __XJIPGetVar(d_searchbody)) exitWith {"Somebody else allready searched the body..." call XfGlobalChat};

["d_rem_sb_id"] call XNetCallEvent;
sleep 0.1;
["d_searchbody",objNull] call XNetSetJIP;

_intelar = __XJIPGetVar(d_searchintel);
_intelnum = _intelar call XfRandomFloorArray;

if (random 1 < 0.8) then {
	if ((_intelar select _intelnum) != 1) then {
		switch (_intelnum) do {
			case 0: {
				"Hmm. Interresting. Codenames used when they are launching attack on our base. Could be useful." call XfGlobalChat;
				sleep 2;
				_intelar set [0, 1];
				["d_searchintel",_intelar] call XNetSetJIP;
				["d_intel_upd", [0, d_name_pl]] call XNetCallEvent;
			};
			case 1: {
				"Very nice. Seems these airdrop codes for main targets could prove useful." call XfGlobalChat;
				sleep 2;
				_intelar set [1, 1];
				["d_searchintel",_intelar] call XNetSetJIP;
				["d_intel_upd", [1, d_name_pl]] call XNetCallEvent;
			};
			case 2: {
				"Yeah. Finally able to know when those fighters show up. Now, if we only had something to fight them with." call XfGlobalChat;
				sleep 2;
				_intelar set [2, 1];
				["d_searchintel",_intelar] call XNetSetJIP;
				["d_intel_upd", [2, d_name_pl]] call XNetCallEvent;
			};
			case 3: {
				"Jolly bloody crap good. Finally some early warnings possible against those attack choppers." call XfGlobalChat;
				sleep 2;
				_intelar set [3, 1];
				["d_searchintel",_intelar] call XNetSetJIP;
				["d_intel_upd", [3, d_name_pl]] call XNetCallEvent;
			};
			case 4: {
				"Code name for the MG chopper. Could be useful." call XfGlobalChat;
				sleep 2;
				_intelar set [4, 1];
				["d_searchintel",_intelar] call XNetSetJIP;
				["d_intel_upd", [4, d_name_pl]] call XNetCallEvent;
			};
			case 5: {
				"Niiiiice. They can shell us, but they can't hit us. Not anymore." call XfGlobalChat;
				sleep 2;
				_intelar set [5, 1];
				["d_searchintel",_intelar] call XNetSetJIP;
				["d_intel_upd", [5, d_name_pl]] call XNetCallEvent;
			};
			case 6: {
				"Don't they know they shouldn't put tracking devices on their patrol vehicles? Handy." call XfGlobalChat;
				sleep 2;
				_intelar set [6, 1];
				["d_searchintel",_intelar] call XNetSetJIP;
				["d_intel_upd", [6, d_name_pl]] call XNetCallEvent;
			};
		};
	} else {
		"The information you found is allready known." call XfGlobalChat;
	};
} else {
	"You couldn't find any documents of value" call XfGlobalChat;
};
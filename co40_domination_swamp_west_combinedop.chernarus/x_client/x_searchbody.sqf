// by Xeno and Carl Gustaffa
#define THIS_FILE "x_searchbody.sqf"
#include "x_setup.sqf"

if (isNull __XJIPGetVar(GVAR(searchbody))) exitWith {};

PARAMS_1(_body);

if (alive _body) exitWith {"He is still alive, you can't search him then..." call FUNC(GlobalChat)};
if (player distance _body > 3) exitWith {"You are too far away from the body..." call FUNC(GlobalChat)};

"Checking body, please wait" call FUNC(GlobalChat);
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!alive player) exitWith {"You died before you finished checking the body." call FUNC(GlobalChat)};

if (isNull __XJIPGetVar(GVAR(searchbody))) exitWith {"Somebody else allready searched the body..." call FUNC(GlobalChat)};

[QGVAR(rem_sb_id)] call FUNC(NetCallEvent);
sleep 0.1;
[QGVAR(searchbody),objNull] call FUNC(NetSetJIP);

_intelar = __XJIPGetVar(GVAR(searchintel));
_intelnum = _intelar call FUNC(RandomFloorArray);

if (random 1 < 0.8) then {
	if ((_intelar select _intelnum) != 1) then {
		switch (_intelnum) do {
			case 0: {
				"Hmm. Interresting. Codenames used when they are launching attack on our base. Could be useful." call FUNC(GlobalChat);
				sleep 2;
				_intelar set [0, 1];
				[QGVAR(searchintel),_intelar] call FUNC(NetSetJIP);
				[QGVAR(intel_upd), [0, GVAR(name_pl)]] call FUNC(NetCallEvent);
			};
			case 1: {
				"Very nice. Seems these airdrop codes for main targets could prove useful." call FUNC(GlobalChat);
				sleep 2;
				_intelar set [1, 1];
				[QGVAR(searchintel),_intelar] call FUNC(NetSetJIP);
				[QGVAR(intel_upd), [1, GVAR(name_pl)]] call FUNC(NetCallEvent);
			};
			case 2: {
				"Yeah. Finally able to know when those fighters show up. Now, if we only had something to fight them with." call FUNC(GlobalChat);
				sleep 2;
				_intelar set [2, 1];
				[QGVAR(searchintel),_intelar] call FUNC(NetSetJIP);
				[QGVAR(intel_upd), [2, GVAR(name_pl)]] call FUNC(NetCallEvent);
			};
			case 3: {
				"Jolly bloody crap good. Finally some early warnings possible against those attack choppers." call FUNC(GlobalChat);
				sleep 2;
				_intelar set [3, 1];
				[QGVAR(searchintel),_intelar] call FUNC(NetSetJIP);
				[QGVAR(intel_upd), [3, GVAR(name_pl)]] call FUNC(NetCallEvent);
			};
			case 4: {
				"Code name for the MG chopper. Could be useful." call FUNC(GlobalChat);
				sleep 2;
				_intelar set [4, 1];
				[QGVAR(searchintel),_intelar] call FUNC(NetSetJIP);
				[QGVAR(intel_upd), [4, GVAR(name_pl)]] call FUNC(NetCallEvent);
			};
			case 5: {
				"Niiiiice. They can shell us, but they can't hit us. Not anymore." call FUNC(GlobalChat);
				sleep 2;
				_intelar set [5, 1];
				[QGVAR(searchintel),_intelar] call FUNC(NetSetJIP);
				[QGVAR(intel_upd), [5, GVAR(name_pl)]] call FUNC(NetCallEvent);
			};
			case 6: {
				"Don't they know they shouldn't put tracking devices on their patrol vehicles? Handy." call FUNC(GlobalChat);
				sleep 2;
				_intelar set [6, 1];
				[QGVAR(searchintel),_intelar] call FUNC(NetSetJIP);
				[QGVAR(intel_upd), [6, GVAR(name_pl)]] call FUNC(NetCallEvent);
			};
		};
	} else {
		"The information you found is allready known." call FUNC(GlobalChat);
	};
} else {
	"You couldn't find any documents of value" call FUNC(GlobalChat);
};
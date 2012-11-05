// by Xeno
#include "x_setup.sqf"
private ["_grpen", "_grpru"];

if (isServer) then {
	waitUntil {!isNil "x_creategroup"};
	_grpen = [west] call x_creategroup;
	d_hq_logic_en1 = _grpen createUnit ["Logic",[0,0,333],[],0,"NONE"];
	[d_hq_logic_en1] joinSilent _grpen;
	["d_hq_logic_en1", d_hq_logic_en1] call XNetSetJIP;
	_grpen = [west] call x_creategroup;
	d_hq_logic_en2 = _grpen createUnit ["Logic",[0,0,334],[],0,"NONE"];
	[d_hq_logic_en2] joinSilent _grpen;
	["d_hq_logic_en2", d_hq_logic_en2] call XNetSetJIP;

	_grpru = [east] call x_creategroup;
	d_hq_logic_ru1 = _grpru createUnit ["Logic",[0,0,335],[],0,"NONE"];
	[d_hq_logic_ru1] joinSilent _grpru;
	["d_hq_logic_ru1", d_hq_logic_ru1] call XNetSetJIP;
	_grpru = [east] call x_creategroup;
	d_hq_logic_ru2 = _grpru createUnit ["Logic",[0,0,336],[],0,"NONE"];
	[d_hq_logic_ru2] joinSilent _grpru;
	["d_hq_logic_ru2", d_hq_logic_ru2] call XNetSetJIP;
} else {
	waitUntil {!isNil {__XJIPGetVar(d_hq_logic_ru2)}};
	d_hq_logic_en1 = __XJIPGetVar(d_hq_logic_en1);
	d_hq_logic_en2 = __XJIPGetVar(d_hq_logic_en2);
	d_hq_logic_ru1 = __XJIPGetVar(d_hq_logic_ru1);
	d_hq_logic_ru2 = __XJIPGetVar(d_hq_logic_ru2);
};

#ifdef __OA__
d_hq_logic_ru1 kbAddTopic["HQ_E","x_bikb\domkboa.bikb"];
#else
d_hq_logic_ru1 kbAddTopic["HQ_E","x_bikb\domkb.bikb"];
#endif
#ifdef __OA__
d_hq_logic_ru1 kbAddTopic["HQ_ART_E","x_bikb\domkboa.bikb"];
#else
d_hq_logic_ru1 kbAddTopic["HQ_ART_E","x_bikb\domkb.bikb"];
#endif
d_hq_logic_ru1 setIdentity "DHQ_RU1";
d_hq_logic_ru1 setRank "COLONEL";
d_hq_logic_ru1 setGroupId ["HQ"];

#ifdef __OA__
d_hq_logic_ru2 kbAddTopic["HQ_E","x_bikb\domkboa.bikb"];
#else
d_hq_logic_ru2 kbAddTopic["HQ_E","x_bikb\domkb.bikb"];
#endif
d_hq_logic_ru2 setIdentity "DHQ_RU2";
d_hq_logic_ru2 setRank "COLONEL";
d_hq_logic_ru2 setGroupId ["HQ1"];

#ifdef __OA__
d_hq_logic_en1 kbAddTopic["HQ_W","x_bikb\domkboa.bikb"];
#else
d_hq_logic_en1 kbAddTopic["HQ_W","x_bikb\domkb.bikb"];
#endif
#ifdef __OA__
d_hq_logic_en1 kbAddTopic["HQ_ART_W","x_bikb\domkboa.bikb"];
#else
d_hq_logic_en1 kbAddTopic["HQ_ART_W","x_bikb\domkb.bikb"];
#endif
d_hq_logic_en1 setIdentity "DHQ_EN1";
d_hq_logic_en1 setRank "COLONEL";
d_hq_logic_en1 setGroupId ["Crossroad"];

#ifdef __OA__
d_hq_logic_en2 kbAddTopic["HQ_W","x_bikb\domkboa.bikb"];
#else
d_hq_logic_en2 kbAddTopic["HQ_W","x_bikb\domkb.bikb"];
#endif
d_hq_logic_en2 setIdentity "DHQ_EN2";
d_hq_logic_en2 setRank "COLONEL";
d_hq_logic_en2 setGroupId ["Crossroad1"];

#ifndef __TT__
d_kb_logic1 = switch (d_enemy_side) do {
	case "EAST": {d_hq_logic_en1};
	case "WEST": {d_hq_logic_ru1};
};
d_kb_logic2 = switch (d_enemy_side) do {
	case "EAST": {d_hq_logic_en2};
	case "WEST": {d_hq_logic_ru2};
};
d_kb_topic_side = switch (d_enemy_side) do {
	case "EAST": {"HQ_W"};
	case "WEST": {"HQ_E"};
};
d_kb_topic_side_arti = switch (d_enemy_side) do {
	case "EAST": {"HQ_ART_W"};
	case "WEST": {"HQ_ART_E"};
};
#endif

if (!isDedicated) then {
	waitUntil {X_INIT};
	sleep 1;
	waitUntil {!isNil "d_still_in_intro"};
	waitUntil {!d_still_in_intro};
	switch (playerSide) do {
	#ifdef __OA__
		case west: {player kbAddTopic["HQ_W","x_bikb\domkboa.bikb"]};
		case east: {player kbAddTopic["HQ_E","x_bikb\domkboa.bikb"]};
	#else
		case west: {player kbAddTopic["HQ_W","x_bikb\domkb.bikb"]};
		case east: {player kbAddTopic["HQ_E","x_bikb\domkb.bikb"]};
	#endif
	};
	#ifdef __OA__
	player kbAddTopic["PL" + str(player),"x_bikb\domkboa.bikb"];
	#else
	player kbAddTopic["PL" + str(player),"x_bikb\domkb.bikb"];
	#endif
	#ifndef __TT__
	if (__OAVer) then {
		d_kb_logic1 kbAddTopic["PL" + str(player),"x_bikb\domkboa.bikb"];
	} else {
		d_kb_logic1 kbAddTopic["PL" + str(player),"x_bikb\domkb.bikb"];
	};
	#else
	_ll = switch (playerSide) do {
		case west: {d_hq_logic_en1};
		case east: {d_hq_logic_ru1};
	};
	if (__OAVer) then {
		_ll kbAddTopic["PL" + str(player),"x_bikb\domkb.bikb"];
	} else {
		_ll kbAddTopic["PL" + str(player),"x_bikb\domkboa.bikb"];
	};
	#endif
	if (!d_with_ai) then {
		if (str(player) in d_can_use_artillery) then {
			switch (playerSide) do {
			#ifdef __OA__
				case west: {player kbAddTopic["HQ_ART_W","x_bikb\domkboa.bikb"]};
				case east: {player kbAddTopic["HQ_ART_E","x_bikb\domkboa.bikb"]};
			#else
				case west: {player kbAddTopic["HQ_ART_W","x_bikb\domkb.bikb"]};
				case east: {player kbAddTopic["HQ_ART_E","x_bikb\domkb.bikb"]};
			#endif
			};
		};
	} else {
		switch (playerSide) do {
		#ifdef __OA__
			case west: {player kbAddTopic["HQ_ART_W","x_bikb\domkboa.bikb"]};
			case east: {player kbAddTopic["HQ_ART_E","x_bikb\domkboa.bikb"]};
		#else
			case west: {player kbAddTopic["HQ_ART_W","x_bikb\domkb.bikb"]};
			case east: {player kbAddTopic["HQ_ART_E","x_bikb\domkb.bikb"]};
		#endif
		};
	};
};

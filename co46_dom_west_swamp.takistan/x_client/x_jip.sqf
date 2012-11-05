// by Xeno
#include "x_setup.sqf"
if (!X_Client) exitWith {};

if (!isNil "d_jip_started") exitWith {};
d_jip_started = true;

#ifdef __OLD_INTRO__
execVM "x_client\x_intro_old.sqf";
#else
if (ismultiplayer) then {execVM "x_client\x_intro.sqf"};
#endif

if (d_FastTime == 0) then {
	if (X_Client && !X_Server) then {
		0 setOvercast 0;
		[] spawn {
			waitUntil {!isNil {__XJIPGetVar(currentTime)}};
			while {true}do {
				sleep 1;
				skipTime (__XJIPGetVar(currentTime) - DayTime);
			};
		};
	};
};

execVM "x_client\x_setupplayer.sqf";

#ifdef __CARRIER__
sleep 2;
player setPosASL [position player select 0, position player select 1, 9.26];
#endif
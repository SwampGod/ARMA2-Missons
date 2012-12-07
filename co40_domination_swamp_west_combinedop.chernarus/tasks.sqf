#define THIS_FILE "x_tasks.sqf"
#include "x_setup.sqf"
private "_current_target_index";

waitUntil {sleep 0.03;!isNull player};
waitUntil {sleep 0.03;!isNil QGVAR(MaxNumAmmoboxes)};

_dompic = "pics\dtwo.paa";

_briefing = format ["
Welcome to...<br/>
  <img image='pics\domination.paa' width='300' height='40' />     <img image='" + _dompic + "' width='50' height='50' /><br/><br/>
You have to free the island from all enemy forces.<br/>
To clear a target kill all enemies, destroy the radio tower at the main target site, solve the main target sidemission and capture all depots.<br/>
<br/><br/>
There are several side missions available that will get you some extra vehicles if you solve them.
<br/><br/>
Once a main target is clear, a flag gets created in a random place from where you can jump with the HALO parajump script (if enabled, not available in the TT version).
<br/><br/>
You can transport all vehicles with your blackhawk or Mi8 choppers, except heavier vehicles like M1, T72/T90 and Shilka.
<br/><br/>
The MHQs are your mobile respawn points.<br/>
You can drop an ammo crate from a MHQ or if you are the pilot of a helicopter (but you have to load a crate at base first)!<br/>
The maximum number of ammo crates simultaneously is %1. An ammo crate gets only deleted if the crate was destroyed.<br/>
Reload a crate into chopper 1,2,3 or W or in one of the MHQs, otherwise you will end up at the next target without any crate.<br/>
Once deployed you can teleport from one MHQ to the other, enable satellite view or create a bike.
<br/><br/>
The engineers can repair and refuel all vehicles and aircraft.<br/>
That only works once if no salvage truck or repair truck is near an engineer (reload and refuel capability can be restored at base).
Engineers can also load static weapons like D30, DSHKM, etc, into their 5to salvage trucks, and unload them wherever they want. 
Engineers are also able to flip tanks that are lying upside down when they have a repair truck near them (in the AI version every player can do that).<br/>
Engineers can also repair or rebuild the service buildings at base if the enemy destroys them (not available in the TT version).
<br/><br/>
",
#ifndef __TT__
GVAR(MaxNumAmmoboxes)
#else
str (GVAR(MaxNumAmmoboxes)) + " for both teams"
#endif
];

_briefing = _briefing + "
The flag at your base can be used as a teleporter to your mobile respawns or you can choose parajump there (if enabled).
<br/><br/>
If a vehicle that you've won for solving a sidemission or clearing a main target gets destroyed you can transport the wreck with chopper 4 (W) to the wreck repair point at your base and you'll get a new one after some time.<br/>
Chopper 4 (W) can only transport wrecks, nothing else.
<br/><br/>
The artillery operators can fire artillery strikes about every six minutes. They are also able to rescue hostages (in the AI version every player can do that). You have to bring the hostages to the flag at your base.
<br/><br/>
The leaders of team Alpha or team Charlie (alpha_1 and charlie_1) can call in air drops (in the AI version every player can do that). A chopper will bring an artillery cannon or a vehicle or a ammobox.<br/>
(Not available in the TT version).
<br/><br/>
MG Gunners can place MG nests, medics can place mashes.
<br/><br/>
If you have the freelook bug/headbug press the Fix Headbug button in the status dialog (available at mobile respawn) to fix this annoying bug.<br/>
You can also change the viewdistance and other settings in the status dialog.
<br/><br/>
It is also possible to put the primary weapon in your backpack. You are then able to take another primary weapon and switch between the weapon in the backpack and the currently selected weapon.
<br/><br/>
SHIFT-G brings up a quick magazine check.
<br/><br/>
The revive system used in Dom is a little bit different to what you may be used to.<br/>
Unconscious units play a death animation and not the usual roll around on the ground animations.<br/>
When map respawn is available choose one of the rotating and size changing markers to respawn (does only work if the marker is green!)<br/>
You can drag unconscious units in prone position too.
<br/><br/>
Open the paramaters dialog in the server lobby to see a list of available features that you can change ingame before mission start (an admin must do that).<br/>
Other things can be changed by editing the i_xxx.sqf files of the mission.
<br/><br/>
Scrolling the mouse wheel while pointing at a vehicle will show the crew of the vehicle (same if you are inside a vehicle).
<br/><br/>
Mission by Xeno<br/><br/>
Uses load/unload scripts (enhanced) from -eutf-Myke, Dr.Eyeball's Teamstatus Dialog, Mandos parachute, heliroute, spectating from Kegetys (complete rewrite), SAT View from Vienna, weather winter by ruebe and animated letters from BIS.<br/>
(All those scripts are heavily modified).
<br/><br/>
Have a lot of fun !
";

_diary1 = player createDiaryRecord ["Diary", ["Briefing",_briefing]];

waitUntil {!isNil {__XJIPGetVar(GVAR(current_target_index))}};
_current_target_index = __XJIPGetVar(GVAR(current_target_index));

GVAR(task1) = player createSimpleTask ["obj1"];
GVAR(task1) setSimpleTaskDescription ["Waiting for orders...","Waiting for orders...","Waiting for orders..."];
if (_current_target_index == -1) then {
	GVAR(task1) settaskstate "Created";
} else {
	GVAR(task1) settaskstate "Succeeded";
};



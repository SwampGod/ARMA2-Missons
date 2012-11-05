// by Xeno
#include "x_setup.sqf"
private "_radar";
if (!isServer) exitWith {};

_radar = _this select 0;
deleteVehicle _radar;
d_banti_airdown = true;

d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellBaseRadarDown"];
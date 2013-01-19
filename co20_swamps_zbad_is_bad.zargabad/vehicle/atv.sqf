_atv = _this select 1;

hint "Creating ATV, Please wait.";
sleep 1;
hint "Creating ATV, Please wait. .";
sleep 1;
hint "Creating ATV, Please wait. . .";
sleep 1;
hint "Creating ATV, Please wait. . . .";
sleep 1;
hint "";

_atv = "ATV_US_EP1" createVehicle (position player);
_atv setDir getDir player;

sleep 0.01;
player moveInDriver _atv;

_atv addWeaponCargo ["M110_NVG_EP1",2];
_atv addMagazineCargo ["20Rnd_762x51_B_SCAR",24];
_atv addWeaponCargo ["MAAWS",2];
_atv addMagazineCargo ["MAAWS_HEAT",12];
_atv addAction ["Repair Vehicle","scripts\veh_repair.sqf",nil,1,true,true,"","(!canMove _target or (damage _target>0 and damage _target<1)) and player distance _target<4"];

if (driver _atv == player) then {

hint composeText [parsetext format["<t size='1.1' align='center' color='#FFA500'>ATV Info%1</t><br/><br/><t size='0.9' align='center' color='#FFFFFF'>This vehicle has been loaded with 2 MAAW Launchers, 12 MAAW rockets, 2 M110 NV rifles and 24 magazines.%1</t>"]];

sleep 8;

hint "";

};
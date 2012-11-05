class TeleportModule {
	idd = -1;
	movingEnable = false;
	objects[] = {};
	onLoad="uiNamespace setVariable ['X_TELE_DIALOG', _this select 0];_test = 0 spawn x_teleupdate_dlg";
	class controlsBackground {
		class bg1 : RscBG {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH";
			idc = 100101;
			colorBackground[] = {0.106, 0.133, 0.102, 1};
		};
	};
	class controls {
		class respawn: XD_ButtonBase {
			idc = 100102;
			text = "Teleport"; 
			action = "0 execVM 'x_client\x_beam_tele.sqf'";
			x = 0.625;
			y = 0.67;
			w = 0.3;
			default = true;
		};
		class cancelb: XD_ButtonBase {
			idc = 100103;
			text = "Cancel"; 
			action = "CloseDialog 0";
			x = "SafeZoneX + 0.05";
			y = 0.91;
			w = 0.3;
		};
		class BaseButton: XD_ButtonBase {
			idc = 100107;
			text = "Base"; 
			action = "[0] execVM 'x_client\x_update_target.sqf'";
			x = 0.625;
			y = 0.34;
			w = 0.3;
		};
		class Mr1Button: XD_ButtonBase {
			idc = 100108;
			text = "Mobile Respawn One";
			action = "[1] execVM 'x_client\x_update_target.sqf'";
			x = 0.625;
			y = 0.41;
			w = 0.3;
		};
		class Mr2Button: XD_ButtonBase {
			idc = 100109;
			text = "Mobile Respawn Two";
			action = "[2] execVM 'x_client\x_update_target.sqf'";
			x = 0.625;
			y = 0.48;
			w = 0.3;
		};
		class Tdestination : SXRscText {
			idc = 100110;
			x = 0.625;
			y = 0.55;
			w = 0.3;
			h = 0.1;
			sizeEx = 0.025;
			text = "";
		};
		class dtext : SXRscText {
			x = 0.85;
			y = 0.92;
			w = 0.3;
			h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.03921;
			XCTextBI;
			text = "Domination! 2";
		};
		class maprespawn : XD_RscMapControl {
			idc = 100104;
			x = 0.07;
			y = 0.27;
			w	= 0.51;
			h	= 0.5;
			colorBackground[] = {1, 1, 1, 1};
		};
		class mr1inair : SXRscText {
			idc = 100105;
			x = 0.623;
			y = 0.75;
			w = 0.3;
			h = 0.1;
			sizeEx = 0.02;
			text = "";
		};
		class mr2inair : SXRscText {
			idc = 100106;
			x = 0.623;
			y = 0.772;
			w = 0.3;
			h = 0.1;
			sizeEx = 0.02;
			text = "";
		};
		class respawncaption : SXRscText {
			idc = 100111;
			x = 0.35;
			y = 0.07;
			w = 0.6;
			h = 0.2;
			font = "Zeppelin32";
			sizeEx = 0.03921;
			XCTextBI;
			text = "Select Teleport Destination";
		};
		class changepos : SXRscText {
			idc = 100112;
			x = 0.155;
			y = 0.72;
			w = 0.6;
			h = 0.2;
			font = "Zeppelin32";
			sizeEx = 0.03921;
			XCTextBI;
			text = "Changing position... Stand by!";
		};
	};
};

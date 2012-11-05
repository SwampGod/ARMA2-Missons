#ifdef __OLD_INTRO__
class Titel1 {
	idd=-1;
	movingEnable=0;
	duration=10;
	name="titel1";
	class controls {
		class titel1: XC_RscText {
			idc=66666;
			style="16+2+512";
			lineSpacing=0.95;
			text="Made 2010 by Xeno";
			x=0.39;y=0.91;w=0.9;h=0.7;
			colorBackground[]={0,0,0,0};
			colorText[]={0.8,0.9,0.9,0.7};
			size=0.57;
			sizeEx = 0.026;
		};
	};
};
#endif
class XDomLabel {
	idd=-1;
	movingEnable=0;
	duration=9;
	fadein = 1;
	fadeout = 1;
	name="XDomLabel";
	sizeEx = 256;
	onLoad = "uiNamespace setVariable ['XDomLabel', _this select 0]";
	class controls {
		class DPicture : XD_RscPicture {
			idc = 50;
			x=0.26; y=0.4; w=0.5; h=0.07;
			text="pics\domination.paa";
			sizeEx = 256;
		};
	};
};
class XDomTwo {
	idd=-1;
	movingEnable=0;
	duration=9.5;
	fadeout = 1;
	name="XDomTwo";
	sizeEx = 256;
	onLoad = "uiNamespace setVariable ['XDomTwo', _this select 0]";
	class controls {
		class Picture : XD_RscPicture {
			idc=50;
			x=2; y=0.35; w=0.15; h=0.15;
			text="pics\dtwo.paa";
			sizeEx = 256;
		};
	};
};
class D_Lightning1 {
	idd = -1;
	movingEnable = 0;
	duration = 0.6;
	fadein = 0.2;
	fadeout = 1.3;
	name = "D_Lightning1";
	class controls {
		class Lightning_BG {
			idc=-1;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "Bitstream";
			sizeEx = 0.023;
			x = 0.6;y = 0.3;w = 0.3;h = 0.3;
			text = "ca\Data\data\blesk_b_ca.paa";
		};
	};
};
class D_Eyeflare {
	idd = -1;
	movingEnable = 0;
	duration = 0.4;
	fadein = 0.1;
	fadeout = 1.1;
	name = "D_Eyeflare";
	class controls {
		class Eyeflare_BG {
			idc=-1;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 0.8};
			font = "Bitstream";
			sizeEx = 0.023;
			x = 0.74;y = 0.3;w = 0.15;h = 0.15;
			text = "ca\Data\data\eyeflare_ca.paa";
		};
	};
};
class XDomAward {
	idd=-1;
	movingEnable=0;
	duration=9;
	fadein = 1;
	fadeout = 1;
	name="XDomAward";
	sizeEx = 256;
	class controls {
		class Picture : XD_RscPicture {
			idc=50;
			x=0.01; y=0.8; w=0.15; h=0.2;
			text="pics\award.paa";
			sizeEx = 256;
		};
	};
};
class XA2Logo {
	idd=-1;
	movingEnable=0;
	duration=9;
	name="XA2Logo";
	fadein = 1;
	fadeout = 1;
	sizeEx = 256;
	class controls {
		class Picture : XD_RscPicture {
			idc=50;
#ifndef __OA__
			x=0.35;y=0.1;w=0.3;h=0.2;
			text="\ca\ui\data\ui_logo_main_ca.paa";
#else
			x=0.3;y=0.1;w=0.4;h=0.35;
			text="ca\ui\data\logo_arma2ep1_ca.paa";
#endif
			sizeEx = 48;
		};
	};
};
class D_SayHello {
	idd=-1;
	movingEnable=0;
	duration=10;
	fadein = 2;
	fadeout = 2;
	name="D_SayHello";
	onLoad = "uiNamespace setVariable ['D_SayHello', _this select 0]";
	class controls {
		class thetext: XC_RscText {
			idc=50;
			style="16+2+512";
			lineSpacing=0.95;
			text="";
			x=0.39;y=0.91;w=0.9;h=0.7;
			colorBackground[]={0,0,0,0};
			colorText[]={0.8,0.9,0.9,0.7};
			size=0.57;
			sizeEx = 0.026;
		};
	};
};
#ifdef __CARRIER__
class XCarrierTitel {
	idd=-1;
	movingEnable=0;
	duration=9;
	name="XCarrierTitel";
	fadein = 1;
	fadeout = 1;
	class controls {
		class carrierTitel : XC_RscText {
			lineSpacing=0.95;
			style="16+2+512";
			x=0.35; y=0.335; w=0.3; h=0.2;
			text="Carrier";
			size=0.57;
			sizeEx = 0.04;
			colorBackground[]={0,0,0,0};
			colorText[]={0.8,0.9,0.9,0.7};
		};
	};
};
#endif

class xvehicle_hud {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 1;
	duration = 1e+011;
	name="xvehicle_hud";
	onLoad = "uiNamespace setVariable ['DVEC_HUD', _this select 0]";
	class controls {
		class vehicle_hud_name {
			type = 0;
			idc = 64432;
			style = 0;
			x = 0.87;y = 0.725;w = 0.2;h = 0.2;
			font = "Zeppelin32";
			sizeEx = 0.019;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class vehicle_hud_speed {
			type = 0;
			idc = 64433;
			style = 0;
			x = 0.87;y = 0.755;w = 0.2;h = 0.2;
			font = "Zeppelin32";
			sizeEx = 0.019;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class vehicle_hud_fuel {
			type = 0;
			idc = 64434;
			style = 0;
			x = 0.87;y = 0.785;w = 0.2;h = 0.2;
			font = "Zeppelin32";
			sizeEx = 0.019;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class vehicle_hud_damage {
			type = 0;
			idc = 64435;
			style = 0;
			x = 0.87;y = 0.815;w = 0.2;h = 0.2;
			font = "Zeppelin32";
			sizeEx = 0.019;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class vehicle_hud_direction {
			type = 0;
			idc = 64436;
			style = 0;
			x = 0.87;y = 0.845;w = 0.2;h = 0.2;
			font = "Zeppelin32";
			sizeEx = 0.019;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
	};
};
class chopper_hud {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 1;
	duration = 1e+011;
	name="chopper_hud";
	onLoad="uiNamespace setVariable ['DCHOP_HUD', _this select 0]";
	class controls {
		class vehicle_hud_start {
			type = 0;
			idc = 64438;
			style = 0;
			x = 0.3;y = 0.3;w = 0.6;h = 0.4;
			font = "Zeppelin32";
			sizeEx = 0.04;
			colorText[] = {1.0, 1.0, 1.0, 0.9};
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class vehicle_hud_start2 {
			type = 0;
			idc = 64439;
			style = 0;
			x = 0.3;y = 0.37;w = 0.4;h = 0.4;
			font = "Zeppelin32";
			sizeEx = 0.03;
			colorText[] = {1.0, 1.0, 1.0, 0.9};
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class vehicle_hud_start3 {
			type = 0;
			idc = 64440;
			style = 0;
			x = 0.3;y = 0.43;w = 0.5;h = 0.4;
			font = "Zeppelin32";
			sizeEx = 0.03;
			colorText[] = {1.0, 1.0, 1.0, 0.9};
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class vehicle_hud_start4 {
			type = 0;
			idc = 64441;
			style = 0;
			x = 0.3;y = 0.49;w = 0.5;h = 0.4;
			font = "Zeppelin32";
			sizeEx = 0.03;
			colorText[] = {1.0, 1.0, 1.0, 0.9};
			colorBackground[]={0,0,0,0};
			text = "";
		};
	};
};
class chopper_lift_hud {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 0;
	duration = 1e+011;
	name="chopper_lift_hud";
	onLoad="uiNamespace setVariable ['DCHOP_LIFT_HUD', _this select 0]";
	class controls {
		class chopper_hud_background {
			idc = 64437;
			type = 0;
			XCTextBlack;
			font = "Bitstream";
			colorBackground[] = {0, 0.3, 0, 0.1};
			text = "";
			style = 128;
			sizeEx = 0.015;
			x = 0.3;y = 0.4;w = 0.42;h = 0.4;
		};
		class chopper_hud_type {
			type = 0;
			idc = 64438;
			style = 0;
			x = 0.31;y = 0.73;w = 0.42;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_icon {
			type = 0;
			idc = 64439;
			style = 48;
			x = 0.62;y = 0.723;w = 0.083;h = 0.07;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[] = {0,0,0,0};
			text = "";
		};
		class chopper_hud_edge {
			type = 0;
			idc = 64440;
			style = 0;
			x = 0.80;y = 0.005;w = 0.42;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_dist {
			type = 0;
			idc = 64441;
			style = 0;
			x = 0.31;y = 0.37;w = 0.25;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_height {
			type = 0;
			idc = 64442;
			style = 0;
			x = 0.6;y = 0.37;w = 0.2;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_back {
			type = 0;
			idc = 64443;
			style = 48;
			x = 0.45;y = 0.6;w = 0.1;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_forward {
			type = 0;
			idc = 64444;
			style = 48;
			x = 0.45;y = 0.5;w = 0.1;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_left {
			type = 0;
			idc = 64445;
			style = 48;
			x = 0.4;y = 0.55;w = 0.1;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_right {
			type = 0;
			idc = 64446;
			style = 48;
			x = 0.5;y = 0.55;w = 0.1;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_middle {
			type = 0;
			idc = 64447;
			style = 48;
			x = 0.45;y = 0.55;w = 0.1;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
		class chopper_hud_icon2{
			type = 0;
			idc = 64448;
			style = 48;
			x = 0.458;y = 0.56;w = 0.083;h = 0.07;
			font = "Zeppelin32";
			sizeEx = 0.02;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			text = "";
		};
	};
};
class chopper_lift_hud2 {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 0;
	duration = 1e+011;
	name="chopper_hud2";
	onLoad="uiNamespace setVariable ['DCHOP_HUD2', _this select 0]";
	class controls {
		class chopper_hud_type {
			type = 0;
			idc = 61422;
			style = 0;
			x = 0;y = 0.005;w = 0.42;h = 0.1;
			font = "Zeppelin32";
			sizeEx = 0.02;
			XCTextHud;
			colorBackground[]={0,0,0,0};
			text = "";
		};
	};
};
#define IDCPLAYER 5200
#define IDCUNDEFINED -1
#define SECONDARY_FONT "Bitstream"
#define ST_LEFT 0x00
class PlayerNameHud {
	idd = -1;
	duration = 1e+011;
	name="PlayerNameHud";
	onLoad = "uiNamespace setVariable ['X_PHUD', _this select 0]";
	objects[] = {};
	class controls {
		class PlayerNameDisp {
			type = 0;
			idc = IDCUNDEFINED;
			style = ST_LEFT;
			colorText[] = {0.75,0.75,0.75,1};
			colorBackground[] = {0,0,0,0};
			font = SECONDARY_FONT;
			text = "";
			sizeEx = 0.020;
			w = 0.165;h = 0.018;x = 0.5;y = 0.5;
		};
		class Player00:PlayerNameDisp {idc = IDCPLAYER +  0;};
		class Player01:PlayerNameDisp {idc = IDCPLAYER +  1;};
		class Player02:PlayerNameDisp {idc = IDCPLAYER +  2;};
		class Player03:PlayerNameDisp {idc = IDCPLAYER +  3;};
		class Player04:PlayerNameDisp {idc = IDCPLAYER +  4;};
		class Player05:PlayerNameDisp {idc = IDCPLAYER +  5;};
		class Player06:PlayerNameDisp {idc = IDCPLAYER +  6;};
		class Player07:PlayerNameDisp {idc = IDCPLAYER +  7;};
		class Player08:PlayerNameDisp {idc = IDCPLAYER +  8;};
		class Player09:PlayerNameDisp {idc = IDCPLAYER +  9;};
		class Player10:PlayerNameDisp {idc = IDCPLAYER + 10;};
		class Player11:PlayerNameDisp {idc = IDCPLAYER + 11;};
		class Player12:PlayerNameDisp {idc = IDCPLAYER + 12;};
		class Player13:PlayerNameDisp {idc = IDCPLAYER + 13;};
		class Player14:PlayerNameDisp {idc = IDCPLAYER + 14;};
		class Player15:PlayerNameDisp {idc = IDCPLAYER + 15;};
		class Player16:PlayerNameDisp {idc = IDCPLAYER + 16;};
		class Player17:PlayerNameDisp {idc = IDCPLAYER + 17;};
		class Player18:PlayerNameDisp {idc = IDCPLAYER + 18;};
		class Player19:PlayerNameDisp {idc = IDCPLAYER + 19;};
		class Player20:PlayerNameDisp {idc = IDCPLAYER + 20;};
		class Player21:PlayerNameDisp {idc = IDCPLAYER + 21;};
		class Player22:PlayerNameDisp {idc = IDCPLAYER + 22;};
		class Player23:PlayerNameDisp {idc = IDCPLAYER + 23;};
		class Player24:PlayerNameDisp {idc = IDCPLAYER + 24;};
		class Player25:PlayerNameDisp {idc = IDCPLAYER + 25;};
		class Player26:PlayerNameDisp {idc = IDCPLAYER + 26;};
		class Player27:PlayerNameDisp {idc = IDCPLAYER + 27;};
		class Player28:PlayerNameDisp {idc = IDCPLAYER + 28;};
		class Player29:PlayerNameDisp {idc = IDCPLAYER + 29;};
		class Player30:PlayerNameDisp {idc = IDCPLAYER + 30;};
		class Player31:PlayerNameDisp {idc = IDCPLAYER + 31;};
		class Player32:PlayerNameDisp {idc = IDCPLAYER + 32;};
		class Player33:PlayerNameDisp {idc = IDCPLAYER + 33;};
		class Player34:PlayerNameDisp {idc = IDCPLAYER + 34;};
		class Player35:PlayerNameDisp {idc = IDCPLAYER + 35;};
		class Player36:PlayerNameDisp {idc = IDCPLAYER + 36;};
		class Player37:PlayerNameDisp {idc = IDCPLAYER + 37;};
		class Player38:PlayerNameDisp {idc = IDCPLAYER + 38;};
		class Player39:PlayerNameDisp {idc = IDCPLAYER + 39;};
		class Player40:PlayerNameDisp {idc = IDCPLAYER + 40;};
	};
};
class XProgressBar {
	idd = -1;
	movingEnable = 0;
	objects[] = {};
	duration = 1e+011;
	name = "XProgressBar";
	onLoad="uiNamespace setVariable ['DPROGBAR', _this select 0]";
	onUnload = "";
	controlsBackground[] = {};
	class controls {
		class XProgressBarBackground : XC_RscText {
			style = 128;
			idc = 3600;
			x = 0.3;y = "((SafeZoneH + SafeZoneY) - (1 + 0.165))*-1";w = 0.4;h = 0.06;
			colorBackground[] = {0,0,0,0.5};
		};
		class XProgressBarX : XC_RscText {
			style = 128;
			idc = 3800;
			x = 0.31;y = "((SafeZoneH + SafeZoneY) - (1 + 0.175))*-1";w = 0.02;h = 0.04;
			colorBackground[] = {0.543, 0.5742, 0.4102, 0.8};
		};
		class XProgress_Label: XC_RscText {
			idc = 3900;
			text = "Capturing Camp";
			x = 0.405;w = 0.2;y = "((SafeZoneH + SafeZoneY) - (1 + 0.1))*-1";
			sizeEx = 0.035;
			colorBackground[] = {1,1,1,0};
			XCMainCapt;
		};
	};
};
class DOM_RscNothing {
	idd = -1;
	movingEnable = 0;
	duration = 0.5;
	fadein = 0;
	fadeout = 1.5;
	name = "DOM_RscNothing";
	class controls {
		class DOM_RscNothing_BG2 {
			idc = 2;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			XCTextBlack;
			font = "Bitstream";
			sizeEx = 0.023;
			x = "SafeZoneX";y = "SafeZoneY";w = "SafeZoneW + 0.05";h = "SafeZoneH + 0.05";
			text = "";
		};
	};
};

class D_ScreenDirt {
	idd = -1;
	movingEnable = 0;
	duration = 5;
	fadein = 0.1;
	fadeout = 5;
	name = "D_ScreenDirt";
	class controls {
		class ScreenDirt_BG {
			idc=-1;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {0.9, 0.9, 0.9, 0.8};
			font = "Bitstream";
			sizeEx = 0.023;
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW + 0.05";
			h = "SafeZoneH + 0.05";
#ifndef __OA__
			text = "ca\missions_ew\img\screen_dirt_ca.paa";
#else
			text = "pics\screen_dirt_ca.paa";
#endif
		};
	};
};

class D_ScreenBlood1 {
	idd = -1;
	movingEnable = 0;
	duration = 2;
	fadein = 0.1;
	fadeout = 5;
	name = "D_ScreenBlood1";
	class controls {
		class ScreenBlood_BG {
			idc=-1;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {0.9, 0.9, 0.9, 0.8};
			font = "Bitstream";
			sizeEx = 0.023;
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW + 0.05";
			h = "SafeZoneH + 0.05";
#ifndef __OA__
			text = "ca\missions_ew\img\screen_blood_1_ca.paa";
#else
			text = "pics\screen_blood_1_ca.paa";
#endif
		};
	};
};

class D_ScreenBlood2 {
	idd = -1;
	movingEnable = 0;
	duration = 2;
	fadein = 0.1;
	fadeout = 5;
	name = "D_ScreenBlood2";
	class controls {
		class ScreenBlood_BG {
			idc=-1;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {0.9, 0.9, 0.9, 0.8};
			font = "Bitstream";
			sizeEx = 0.023;
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW + 0.05";
			h = "SafeZoneH + 0.05";
#ifndef __OA__
			text = "ca\missions_ew\img\screen_blood_2_ca.paa";
#else
			text = "pics\screen_blood_2_ca.paa";
#endif
		};
	};
};

class D_ScreenBlood3 {
	idd = -1;
	movingEnable = 0;
	duration = 2;
	fadein = 0.1;
	fadeout = 5;
	name = "D_ScreenBlood3";
	class controls {
		class ScreenBlood_BG {
			idc=-1;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {0.9, 0.9, 0.9, 0.8};
			font = "Bitstream";
			sizeEx = 0.023;
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW + 0.05";
			h = "SafeZoneH + 0.05";
#ifndef __OA__
			text = "ca\missions_ew\img\screen_blood_3_ca.paa";
#else
			text = "pics\screen_blood_3_ca.paa";
#endif
		};
	};
};

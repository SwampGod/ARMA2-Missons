#include "x_setup.sqf"
class XD_StatusDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['X_STATUS_DIALOG', _this select 0]";
	objects[] = {};
	class controlsBackground {
		class XD_BackGround : XC_RscText {
			idc = -1;
			type = 0;
			style = 48;
			x = 0;
			y = 0;
			w = 1.93;
			h = 1.35;
			XCTextBlack;
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
			font = "Zeppelin32";
			sizeEx = 0.032;
		};
	};
	class controls {
		class XD_TeamStatusButton: XD_ButtonBase {
			idc = 11009;
			text = "Team Status";
			action = "CloseDialog 0;player execVM 'x_client\x_teamstatus.sqf'";
			x = 0.68;
			y = 0.62;
		};
		class XD_SettingsButton: XD_ButtonBase {
			idc = -1;
			text = "Settings";
			action = "CloseDialog 0;[] execVM 'x_client\x_settingsdialog.sqf'";
			x = 0.68;
			y = 0.68;
		};
		class XD_FixHeadBugButton: XD_ButtonBase {
			idc = -1;
			text = "Fix Headbug"; 
			action = "closeDialog 0;player spawn XsFixHeadBug";
			x = 0.68;
			y = 0.74;
		};
		class XD_MsgButton: XD_ButtonBase {
			idc = -1;
			text = "Msg System"; 
			action = "CloseDialog 0;[] execVM 'x_msg\x_showmsgd.sqf'";
			x = 0.68;
			y = 0.8;
		};
		class XD_AdminButton: XD_ButtonBase {
			idc = 123123;
			text = "Admin Dialog"; 
			action = "CloseDialog 0;[] execVM 'x_client\x_admind.sqf'";
			x = 0.68;
			y = 0.86;
		};
		class XD_CloseButton: XD_ButtonBase {
			idc = -1;
			text = "Close"; 
			action = "closeDialog 0";
			default = true;
			x = 0.68;
			y = 0.98;
		};
		class XD_ShowSideButton: XD_LinkButtonBase {
			x = 0.06;
			y = 0.11;
			w = 0.15;
			h = 0.1;
			sizeEx = 0.029;
			text = "Side Mission:";
			action = "[0] execVM 'x_client\x_showsidemain.sqf'";
		};
		class XD_ShowMainButton: XD_LinkButtonBase {
			x = 0.68;
			y = 0.13;
			w = 0.125;
			h = 0.1;
			sizeEx = 0.032;
			text = "Main Target:";
			action = "[1] execVM 'x_client\x_showsidemain.sqf'";
		};
		class XD_SideMissionTxt : XC_RscText {
			idc = 11002;
			style = ST_MULTI;
			sizeEx = 0.02;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.08;
			y = 0.18;
			w = 0.45;
			h = 0.15;
			text = "";
		};
		class XD_SecondaryCaption : XC_RscText {
			x = 0.08;
			y = 0.30;
			w = 0.30;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Secondary Main Target Mission:";
		};
		class XD_SecondaryTxt : XC_RscText {
			idc = 11007;
			style = ST_MULTI;
			sizeEx = 0.02;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.08;
			y = 0.37;
			w = 0.45;
			h = 0.04;
			text = "";
		};
		class IntelCaption : XC_RscText {
			idc = 11019;
			x = 0.08;
			y = 0.38;
			w = 0.30;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Intel found:";
		};
		class IntelTxt : XC_RscText {
			idc = 11018;
			style = ST_MULTI;
			sizeEx = 0.02;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.08;
			y = 0.45;
			w = 0.45;
			h = 0.07;
			text = "";
		};
		class XD_WeatherInfoCaption : XC_RscText {
			x = 0.08;
			y = 0.49;
			w = 0.45;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Weather Information:";
		};
		class XD_WeatherInfo : XC_RscText {
			idc = 11013;
			style = ST_MULTI;
			sizeEx = 0.02;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.08;
			y = 0.56;
			w = 0.45;
			h = 0.04;
			text = "";
		};
		class XD_MainTargetNumber : XC_RscText {
			idc = 11006;
			x = 0.81;
			y = 0.13;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.032;
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			colorBackground[] = {1, 1, 1, 0};
			text = "";
		};
		class XD_MainTarget : XC_RscText {
			idc = 11003;
			x = 0.68;
			y = 0.17;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.032;
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			colorBackground[] = {1, 1, 1, 0};
			text = "";
		};
#ifdef __TT__
		class XD_NPointsCaption : XC_RscText {
			x = 0.68;
			y = 0.23;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			colorBackground[] = {1, 1, 1, 0};
			text = "Points (West : East):";
		};
		class XD_GamePoints : XC_RscText {
			idc = 11011;
			x = 0.68;
			y = 0.26;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			colorBackground[] = {1, 1, 1, 0};
			text = "";
		};
		class XD_KillsCaption : XC_RscText {
			x = 0.68;
			y = 0.30;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			colorBackground[] = {1, 1, 1, 0};
			text = "Kills (West : East):";
		};
		class XD_KillPoints : XC_RscText {
			idc = 11012;
			x = 0.68;
			y = 0.33;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorText[] = {1, 0, 0, 1};
			colorBackground[] = {1, 1, 1, 0};
			text = "";
		};
#endif
		class XD_Map : XD_RscMapControl {
			idc = 11010;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.08;
			y = 0.61;
			w = 0.45;
			h = 0.33;
			showCountourInterval = false;
		};
		class XD_HintCaption : XC_RscText {
			idc = -1;
			x = 0.45;
			y = 0.05;
			w = 0.55;
			h = 0.1;
			sizeEx = 0.02;
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			colorBackground[] = {0, 0, 0, 0};
			text = "Click on 'Side Mission:' or 'Main Target:' caption to show it on the map";
		};
		class XD_RankCaption : XC_RscText {
			x = 0.68;
			y = 0.39;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			sizeEx = 0.032;
			text = "Your current rank:";
		};
		class XD_RankPicture : XD_RscPicture {
			idc = 12010;
			x=0.69; y=0.465; w=0.02; h=0.025;
			text="";
			sizeEx = 256;
			colorText[] = {0, 0, 0, 1};
		};
		class XD_RankString : XC_RscText {
			idc = 11014;
			x = 0.72;
			y = 0.428;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			sizeEx = 0.032;
			text = "";
		};
		class XD_ScoreCaption : XC_RscText {
			x = 0.68;
			y = 0.475;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			sizeEx = 0.032;
			text = "Your score:";
		};
		class XDC_ScoreP : XC_RscText {
			idc = 11233;
			x = 0.785;
			y = 0.475;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			sizeEx = 0.032;
			text = "0";
		};
		class XDCampsCaption : XC_RscText {
			x = 0.68;
			y = 0.52;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			sizeEx = 0.032;
			text = "Camps captured:";
		};
		class XDCampsNumber : XC_RscText {
			idc = 11278;
			x = 0.825;
			y = 0.52;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			sizeEx = 0.032;
			text = "";
		};
		class XD_MainCaption : XC_RscText {
			x = 0.12;
			y = 0.05;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			text = "STATUS DIALOG";
		};
		class Dom2 : XC_RscText {
			x = 0.12;
			y = 0.98;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCMainCapt;
			text = "Domination! 2";
		};
	};
};

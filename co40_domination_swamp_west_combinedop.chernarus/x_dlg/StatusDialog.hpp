#include "x_setup.sqf"
class XD_StatusDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['X_STATUS_DIALOG', _this select 0];d_showstatus_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['X_STATUS_DIALOG', nil];d_showstatus_dialog_open = false";
	objects[] = {};
	class controlsBackground {
		class XD_BackGround : XD_RscPicture {
			x = 0;
			y = 0;
			w = 1.2549;
			h = 1.03;
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_background_controls_ca.paa";
		};
	};
	class controls {
		class XD_TeamStatusButton: XD_ButtonBase {
			idc = 11009;
			text = "Team Status";
			action = "CloseDialog 0;call d_fnc_teamstatus_dialog";
			x = 0.68;
			y = 0.56;
		};
		class XD_SettingsButton: XD_ButtonBase {
			text = "Settings";
			action = "CloseDialog 0;call d_fnc_settingsdialog";
			x = 0.68;
			y = 0.62;
		};
		class XD_FixHeadBugButton: XD_ButtonBase {
			text = "Fix Headbug"; 
			action = "closeDialog 0;player spawn d_fnc_FixHeadBug";
			x = 0.68;
			y = 0.68;
		};
		class XD_MsgButton: XD_ButtonBase {
			text = "Msg System"; 
			action = "CloseDialog 0;call d_fnc_showmsg_dialog";
			x = 0.68;
			y = 0.74;
		};
		class XD_AdminButton: XD_ButtonBase {
			idc = 123123;
			text = "Admin Dialog"; 
			action = "CloseDialog 0;call d_fnc_admindialog";
			x = 0.68;
			y = 0.8;
		};
		class XD_CloseButton: XD_ButtonBase {
			text = "Close"; 
			action = "closeDialog 0";
			default = true;
			x = 0.68;
			y = 0.91;
		};
		class XD_ShowSideButton: XD_LinkButtonBase {
			x = 0.07;
			y = 0.07;
			w = 0.15;
			h = 0.1;
			sizeEx = 0.029;
			text = "Side Mission:";
			action = "[0] call d_fnc_showsidemain_d";
		};
		class XD_ShowMainButton: XD_LinkButtonBase {
			x = 0.68;
			y = 0.09;
			w = 0.125;
			h = 0.1;
			sizeEx = 0.032;
			text = "Main Target:";
			action = "[1] call d_fnc_showsidemain_d";
		};
		class XD_SideMissionTxt : XC_RscText {
			idc = 11002;
			style = ST_MULTI;
			sizeEx = 0.02;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.08;
			y = 0.14;
			w = 0.45;
			h = 0.15;
			text = "";
			shadow = 0;
		};
		class XD_SecondaryCaption : XC_RscText {
			x = 0.08;
			y = 0.26;
			w = 0.30;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Secondary Main Target Mission:";
		};
		class XD_SecondaryTxt : XD_SideMissionTxt {
			idc = 11007;
			y = 0.33;
			w = 0.45;
			h = 0.04;
		};
		class IntelCaption : XD_SecondaryCaption {
			idc = 11019;
			y = 0.34;
			text = "Intel found:";
		};
		class IntelTxt : XD_SideMissionTxt {
			idc = 11018;
			y = 0.41;
			w = 0.45;
			h = 0.07;
		};
		class XD_WeatherInfoCaption : XD_SecondaryCaption {
			y = 0.45;
			w = 0.45;
			text = "Weather Information:";
		};
		class XD_WeatherInfo : XD_SideMissionTxt {
			idc = 11013;
			y = 0.52;
			w = 0.45;
			h = 0.04;
		};
		class XD_MainTargetNumber : XC_RscText {
			idc = 11006;
			x = 0.81;
			y = 0.09;
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
			y = 0.15;
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
			y = 0.2;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			XCTextBlack;
			colorBackground[] = {1, 1, 1, 0};
			text = "Points (West : East):";
		};
		class XD_GamePoints : XC_RscText {
			idc = 11011;
			x = 0.68;
			y = 0.23;
			w = 0.27;
			h = 0.1;
			sizeEx = 0.025;
			XCTextBlack;
			colorBackground[] = {1, 1, 1, 0};
			text = "";
		};
		class XD_KillsCaption : XD_NPointsCaption {
			y = 0.27;
			text = "Kills (West : East):";
		};
		class XD_KillPoints : XD_GamePoints {
			idc = 11012;
			y = 0.3;
			text = "";
		};
#endif
		class XD_Map : XD_RscMapControl {
			idc = 11010;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.08;
			y = 0.57;
			w = 0.45;
			h = 0.31;
			showCountourInterval = false;
		};
		class XD_HintCaption : XC_RscText {
			idc = -1;
			x = 0.45;
			y = 0.01;
			w = 0.55;
			h = 0.1;
			sizeEx = 0.02;
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			colorBackground[] = {0, 0, 0, 0};
			text = "Click on 'Side Mission:' or 'Main Targets:' caption to show it on the map";
		};
		class XD_RankCaption : XC_RscText {
			x = 0.68;
			y = 0.34;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			sizeEx = 0.032;
			text = "Your current rank:";
		};
		class XD_RankPicture : XD_RscPicture {
			idc = 12010;
			x=0.69; y=0.415; w=0.02; h=0.025;
			text="";
			sizeEx = 256;
			colorText[] = {0, 0, 0, 1};
		};
		class XD_RankString : XC_RscText {
			idc = 11014;
			x = 0.72;
			y = 0.378;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			sizeEx = 0.032;
			text = "";
		};
		class XD_ScoreCaption : XD_RankCaption {
			y = 0.42;
			text = "Your score:";
		};
		class XDC_ScoreP : XC_RscText {
			idc = 11233;
			x = 0.79;
			y = 0.42;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			sizeEx = 0.032;
			text = "0";
		};
		class XDCampsCaption : XC_RscText {
			x = 0.68;
			y = 0.465;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			sizeEx = 0.032;
			text = "Camps captured:";
		};
		class XDCampsNumber : XC_RscText {
			idc = 11278;
			x = 0.834;
			y = 0.465;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			sizeEx = 0.032;
			text = "";
		};
		class XDRLivesCaption : XC_RscText {
			idc = 30000;
			x = 0.68;
			y = 0.51;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			sizeEx = 0.032;
			text = "Lives left:";
		};
		class XDRLivesNumber : XC_RscText {
			idc = 30001;
			x = 0.79;
			y = 0.51;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			sizeEx = 0.032;
			text = "0";
		};
		class XD_MainCaption : XC_RscText {
			x = 0.12;
			y = 0.01;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			text = "STATUS DIALOG";
		};
		class Dom2 : XC_RscText {
			x = 0.12;
			y = 0.91;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCMainCapt;
			text = __DOM_NVER_STR__;
		};
	};
};

class XD_SettingsDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['X_SETTINGS_DIALOG', _this select 0]";
	objects[] = {};
	class controlsBackground {
		class XD_BackGround : XC_RscText {
			idc = -1;
			type = 0;
			style = 48;
			x = 0;
			y = 0;
			w = 1.93;
			h = 1.3;
			XCTextBlack;
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
			font = "Zeppelin32";
			sizeEx = 0.032;
		};
	};	
	class controls {
		class XD_ViewDistanceCaption : XC_RscText {
			idc = 1999;
			x = 0.12;
			y = 0.15;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Viewdistance:";
		};
		class XD_ViewDistanceHint : XC_RscText {
			idc = 1997;
			x = 0.12;
			y = 0.168;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.010;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.5, 0.5, 0.5, 0.8};
			text = "Click on the slider to change the VD";
		};
		class VD_Slider : XC_SliderH {
			idc = 1000;
			x = 0.125;
			y = 0.226;
			w = 0.17;
			h = 0.03;
		};
		class XD_GraslayerCaption : XC_RscText {
			idc = 1998;
			x = 0.12;
			y = 0.25;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Select Gras Layer";
		};
		class XD_GraslayerHint : XC_RscText {
			idc = 1996;
			x = 0.12;
			y = 0.268;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.010;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.5, 0.5, 0.5, 0.8};
			text = "Click on the number to change the layer";
		};
		class GraslayerCombo:XD_UIComboBox {
			idc = 1001;
			x = 0.125;
			y = 0.326;
			w = 0.17;
			h = 0.03;
			onLBSelChanged = "[_this] execVM 'x_client\x_glselchanged.sqf'"; 
		};
		class XD_PlayermarkerCaption : XC_RscText {
			idc = 1501;
			x = 0.12;
			y = 0.35;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Player Marker";
		};
		class XD_PlayermarkerHint : XC_RscText {
			idc = 1500;
			x = 0.12;
			y = 0.368;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.010;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.5, 0.5, 0.5, 0.8};
			text = "Click on the box below to activate/deactivate";
		};
		class PlayermarkerCombo:XD_UIComboBox {
			idc = 1002;
			x = 0.125;
			y = 0.426;
			w = 0.17;
			h = 0.03;
			onLBSelChanged = "[_this] execVM 'x_client\x_pmselchanged.sqf'"; 
		};
		class PlayernamesCaption : XC_RscText {
			idc = 1601;
			x = 0.12;
			y = 0.45;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Show Player Names";
		};
		class PlayernamesHint : XC_RscText {
			idc = 1600;
			x = 0.12;
			y = 0.468;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.010;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.5, 0.5, 0.5, 0.8};
			text = "Click to turn on/off";
		};
		class PlayernamesCombo:XD_UIComboBox {
			idc = 1602;
			x = 0.125;
			y = 0.526;
			w = 0.17;
			h = 0.03;
			onLBSelChanged = "[_this] execVM 'x_msg\x_pnselchanged.sqf'"; 
		};
		class XD_CloseButton: XD_ButtonBase {
			idc = -1;
			text = "Close"; 
			action = "closeDialog 0";
			default = true;
			x = 0.68;
			y = 0.945;
		};
		class XD_MainCaption : XC_RscText {
			x = 0.12;
			y = 0.05;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			text = "SETTINGS DIALOG";
		};
		class XD_PointsCaption : XC_RscText {
			y = 0.55;
			x = 0.12;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Points needed for";
		};
		class XD_PointsCaption2 : XC_RscText {
			x = 0.12;
			y = 0.58;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "different ranks:";
		};
		class XD_CorporalPic : XD_RscPicture {
			x=0.13; y=0.647; w=0.02; h=0.025;
			text = "\CA\warfare2\Images\rank_corporal.paa";
			sizeEx = 256;
			colorText[] = {0, 0, 0, 1};
		};
		class XD_CorporalString : XC_RscText {
			x = 0.16;
			y = 0.61;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Corporal";
		};
		class XD_CorporalPoints : XC_RscText {
			idc = 2001;
			x = 0.25;
			y = 0.61;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "";
		};
		class XD_SergeantPic : XD_RscPicture {
			x=0.13; y=0.677; w=0.02; h=0.025;
			text = "\CA\warfare2\Images\rank_sergeant.paa";
			sizeEx = 256;
			colorText[] = {0, 0, 0, 1};
		};
		class XD_SergeantString : XC_RscText {
			x = 0.16;
			y = 0.64;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Sergeant";
		};
		class XD_SergeantPoints : XC_RscText {
			idc = 2002;
			x = 0.25;
			y = 0.64;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "";
		};
		class XD_LieutenantPic : XD_RscPicture {
			x=0.13; y=0.707; w=0.02; h=0.025;
			text = "\CA\warfare2\Images\rank_lieutenant.paa";
			sizeEx = 256;
			colorText[] = {0, 0, 0, 1};
		};
		class XD_LieutenantString : XC_RscText {
			x = 0.16;
			y = 0.67;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Lieutenant";
		};
		class XD_LieutenantPoints : XC_RscText {
			idc = 2003;
			x = 0.25;
			y = 0.67;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "";
		};
		class XD_CaptainPic : XD_RscPicture {
			x=0.13; y=0.737; w=0.02; h=0.025;
			text = "\CA\warfare2\Images\rank_captain.paa";
			sizeEx = 256;
			colorText[] = {0, 0, 0, 1};
		};
		class XD_CaptainString : XC_RscText {
			x = 0.16;
			y = 0.7;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Captain";
		};
		class XD_CaptainPoints : XC_RscText {
			idc = 2004;
			x = 0.25;
			y = 0.7;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "";
		};
		class XD_MajorPic : XD_RscPicture {
			x=0.13; y=0.767; w=0.02; h=0.025;
			text = "\CA\warfare2\Images\rank_major.paa";
			sizeEx = 256;
			colorText[] = {0, 0, 0, 1};
		};
		class XD_MajorString : XC_RscText {
			x = 0.16;
			y = 0.73;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Major";
		};
		class XD_MajorPoints : XC_RscText {
			idc = 2005;
			x = 0.25;
			y = 0.73;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "";
		};
		class XD_ColonelPic : XD_RscPicture {
			x=0.13; y=0.797; w=0.02; h=0.025;
			text = "\CA\warfare2\Images\rank_colonel.paa";
			sizeEx = 256;
			colorText[] = {0, 0, 0, 1};
		};
		class XD_ColonelString : XC_RscText {
			x = 0.16;
			y = 0.76;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Colonel";
		};
		class XD_ColonelPoints : XC_RscText {
			idc = 2006;
			x = 0.25;
			y = 0.76;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.025;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "";
		};
		class XD_GeneralCaption : XC_RscText {
			x = 0.35;
			y = 0.15;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "General mission settings";
		};
		class XD_GeneralCaptionHint : XC_RscText {
			x = 0.35;
			y = 0.174;
			w = 0.45;
			h = 0.1;
			sizeEx = 0.018;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 0.6};
			text = "Click on the textbox and use up and down cursor to browse.";
		};
		class XD_GeneralTxt : XC_RscText {
			idc = 2007;
			style = 16;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.358;
			y = 0.24;
			w = 0.5;
			h = 0.29;
			sizeEx = 0.029;
			text = "";
		};
		class XD_MedicsCaption : XC_RscText {
			x = 0.35;
			y = 0.51;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.029;
			colorbackground[] = {0, 0, 0, 0};
			XCTextBlack;
			text = "Medics (player names)";
		};
		class XD_MedicsTxt : XC_RscText {
			idc = 2008;
			style = 16;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.358;
			y = 0.58;
			w = 0.5;
			h = 0.04;
			sizeEx = 0.029;
			text = "";
		};
		class XD_ArtilleryCaption : XC_RscText {
			x = 0.35;
			y = 0.59;
			w = 0.3;
			h = 0.1;
			sizeEx = 0.029;
			colorbackground[] = {0, 0, 0, 0};
			XCTextBlack;
			text = "Artillery operators (player names)";
		};
		class XD_ArtilleryTxt : XC_RscText {
			idc = 2009;
			style = 16;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.358;
			y = 0.66;
			w = 0.5;
			h = 0.04;
			sizeEx = 0.029;
			text = "";
		};
		class XD_EngineerCaption : XC_RscText {
			x = 0.35;
			y = 0.67;
			w = 0.3;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Engineers (player names)";
		};
		class XD_EngineerTxt : XC_RscText {
			idc = 2010;
			style = 16;
			lineSpacing = 1;
			colorbackground[] = {0.643, 0.5742, 0.4102, 0.4};
			x = 0.358;
			y = 0.74;
			w = 0.5;
			h = 0.04;
			sizeEx = 0.029;
			text = "";
		};
		class Dom2 : XC_RscText {
			x = 0.12;
			y = 0.945;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCMainCapt;
			text = "Domination! 2";
		};
	};
};
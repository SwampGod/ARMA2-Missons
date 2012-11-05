#include "x_setup.sqf"
class XD_ParajumpDialog {
	idd = -1;
	movingEnable = true;
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
		class XD_MainCaption : XC_RscText {
			x = 0.12;
			y = 0.05;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			text = "PARAJUMP";
		};
		class XD_CancelButton: XD_ButtonBase {
			idc = -1;
			text = "Cancel"; 
			action = "closeDialog 0;onMapSingleClick ''";
			x = 0.68;
			y = 0.945;
			default = true;
		};
		class XD_ArtiMapText : XC_RscText {
			x = 0.12;
			y = 0.12;
			w = 0.7;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Choose your parachute location and then single click for jump position";
		};
		class XD_ArtiMapText2 : XC_RscText {
			x = 0.12;
			y = 0.77;
			w = 0.7;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
	#ifndef __ACE__
			text = "Press Esc to deploy. Deploy between 220 feet and 120 feet.";
	#else
			text = "Don't forget to open your parachute!";
	#endif
		};
		class XD_ArtiMapText3 : XC_RscText {
			x = 0.12;
			y = 0.80;
			w = 0.7;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
	#ifndef __ACE__
			text = "!!!! REMEMBER TO PRESS ESC !!!!";
	#else
			text = "!!!! REMEMBER TO OPEN YOUR PARACHUTE !!!!";
	#endif
		};
		class XD_Map : XD_RscMapControl {
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.12;
			y = 0.2;
			w = 0.76;
			h = 0.58;
			showCountourInterval = false;
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

// by Vienna
class SAT_Satellitenbild {
	idd = -1;
	movingEnable = true;
	controlsBackground[]={};
	onLoad="uiNamespace setVariable ['SAT_Satellitenbild', _this select 0]";
	class controls {
		class Text1 {
			idc = -1;
			type = 0;
			style = 0x02;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {0,0,0,0.5};
			font = Bitstream;
			sizeEx = 0.03;
			x=0.3;
			y=0.01;
			w=0.4;
			h=0.04;
			text="SATELLITE CAMERA";
		};
		class Nordpfeil : Text1 {
				style = 48;
				x = 0.915;
				y = 0.20;
				w = 0.04;
				h = 0.10;
				text = "pics\Nordpfeil.paa";
			};
		class KreuzText : Text1 {
			idc = 17020;
			style = 0x00;
			colorText[] = {1,0,0,1};
			sizeEx = 0.018;
			x = 0.16;
			y = 0.007;
			text = "200m x 200m";
		};
		class KreuzC : KreuzText {
			style = 48;
			x = 0.485;
			y = 0.48;
			w = 0.03;
			h = 0.04;
			text = "pics\Kreuz.paa";
		};
		class KreuzLO : KreuzC {
			x = 0.13;
			y = 0.006;
		};
		class KreuzRO : KreuzLO {
			x = 0.838;
		};
		class KreuzLU : KreuzLO {
			y = 0.952;
		};
		class KreuzRU : KreuzLU {
			x = 0.838;
		};
		class KreuzLO2 : KreuzC {
			idc = 17021;
			x = 0.13 +0.22;
			y = 0.006+0.295;
		};
		class KreuzRO2 : KreuzLO2 {
			idc = 17022;
			x = 0.838-0.22;
		};
		class KreuzLU2 : KreuzLO2 {
			idc = 17023;
			y = 0.952-0.295;
		};
		class KreuzRU2 : KreuzLU2 {
			idc = 17024;
			x = 0.838-0.22;
		};
		class TextNSat : XD_ButtonBase {
			idc=-1;
			x=0.90;
			y=0.50;
			colorBackground[] = {1, 1, 1, 0.6};
			text="50m to N";
			action="'N' spawn d_satelittenposf";
		};
		class TextSSat : TextNSat {
			y=0.55;
			text="50m to S";
			action="'S' spawn d_satelittenposf";
		};
		class TextWSat : TextNSat {
			y=0.60;
			text="50m to W";
			action="'W' spawn d_satelittenposf";
		};
		class TextESat : TextNSat {
			y=0.65;
			text="50m to E";
			action="'E' spawn d_satelittenposf";
		};
		class TextZone : TextNSat {
			y=0.70;
			text="to center";
			action="'X' spawn d_satelittenposf";
		};
		class TextZ1 : TextNSat {
			y=0.75;
			text="Zoom on";
			action=
			"\
			'ZE' spawn d_satelittenposf;\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17020) ctrlSetText '75m x 75m';\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17021) ctrlShow  false;\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17022) ctrlShow  false;\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17023) ctrlShow  false;\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17024) ctrlShow  false\
			";
		};
		class TextZ0 : TextZ1 {
			y=0.80;
			text="Zoom off";
			action=
			"\
			'ZA' spawn d_satelittenposf;\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17020) ctrlSetText '200m x 200m';\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17021) ctrlShow  true;\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17022) ctrlShow  true;\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17023) ctrlShow  true;\
			((uiNamespace getVariable 'SAT_Satellitenbild') displayCtrl 17024) ctrlShow  true\
			";
		};
		class TextN1 : TextNSat {
			y=0.85;
#ifndef __OA__
			text="NVG on";
			action="camUseNVG true";
#else
			text="TI on";
			action="true setCamUseTI 1";
#endif
		};
		class TextN0 : TextN1 {
			idc=-1;
			y=0.90;
#ifndef __OA__
			text="NVG off";
			action="camUseNVG false";
#else
			text="TI off";
			action="false setCamUseTI 1";
#endif
		};
		class Exit : TextNSat {
			y=0.95;
			text="Exit";
			action="closeDialog 0";
			default = true;
		};
	};
};

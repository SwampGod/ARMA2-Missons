#define CT_STATIC			0
#define CT_BUTTON			1
#define CT_EDIT				2
#define CT_SLIDER			3
#define CT_COMBO			4
#define CT_LISTBOX			5
#define CT_TOOLBOX			6
#define CT_CHECKBOXES		7
#define CT_PROGRESS			8
#define CT_HTML				9
#define CT_STATIC_SKEW		10
#define CT_ACTIVETEXT		11
#define CT_TREE				12
#define CT_STRUCTURED_TEXT	13 
#define CT_3DSTATIC			20
#define CT_3DACTIVETEXT		21
#define CT_3DLISTBOX		22
#define CT_3DHTML			23
#define CT_3DSLIDER			24
#define CT_3DEDIT			25
#define CT_OBJECT			80
#define CT_OBJECT_ZOOM		81
#define CT_OBJECT_CONTAINER	82
#define CT_OBJECT_CONT_ANIM	83
#define CT_USER				99
// Static styles
#define ST_HPOS				0x0F
#define ST_LEFT				0
#define ST_RIGHT			1
#define ST_CENTER			2
#define ST_UP				3
#define ST_DOWN				4
#define ST_VCENTER			5
#define ST_TYPE				0xF0
#define ST_SINGLE			0
#define ST_MULTI			16
#define ST_TITLE_BAR		32
#define ST_PICTURE			48
#define ST_FRAME			64
#define ST_BACKGROUND		80
#define ST_GROUP_BOX		96
#define ST_GROUP_BOX2		112
#define ST_HUD_BACKGROUND	128
#define ST_TILE_PICTURE		144
#define ST_WITH_RECT		160
#define ST_LINE				176
#define ST_SHADOW			256
#define ST_NO_RECT			512
#define ST_TITLE			ST_TITLE_BAR + ST_CENTER
#define FontHTML			"Zeppelin32"
#define FontM				"Zeppelin32"
#define Dlg_ROWS			36
#define Dlg_COLS			90
#define Dlg_CONTROLHGT		((100/Dlg_ROWS)/100)
#define Dlg_COLWIDTH		((100/Dlg_COLS)/100)
#define Dlg_TEXTHGT_MOD		0.9
#define Dlg_ROWSPACING_MOD	1.3
#define Dlg_ROWHGT			(Dlg_CONTROLHGT*Dlg_ROWSPACING_MOD)
#define Dlg_TEXTHGT			(Dlg_CONTROLHGT*Dlg_TEXTHGT_MOD)

class NORRNRscText {
	access = ReadAndWrite;
	type = CT_STATIC;
	idc = -1;
	style = ST_LEFT;
	x = 0; y = 0;
	w = 0; h = 0;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	font = FontM;
	sizeEx = 0.02;
	text = "";
};

class NORRNRscListBox {
	type = CT_LISTBOX;
	style = ST_LEFT;
	idc = -1;
	colorSelect[] = {1, 1, 1, 1};
	colorSelectBackground[] = {0.2, 0.4, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0.02, 0.11, 0.27, 0.4};
	font = FontM;
	sizeEx = 0.02;
	rowHeight = 0.02;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorFocused[] = {0.02, 0.11, 0.27, 0.4};
	colorShadow[] = {0.2, 0.2, 0.2, 0.8};
	colorBorder[] = {0.4, 0.4, 0.4, 1};
	borderSize = 0.03;
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.15, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.15, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.15, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.15, 1};
};

class NORRNRscButton {
	type = CT_BUTTON;
	idc = -1;
	style = ST_CENTER;
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.7};
	colorBackground[] = {0.04, 0.22, 054, 0.7};
	colorBackgroundActive[] = {0.04, 0.22, 0.54, 0.9};
	colorBackgroundDisabled[] = {0.04, 0.22, 0.54, 0.4};
	colorFocused[] = {1, 1, 1, 0.4};
	colorShadow[] = {0, 1, 0, 0};
	colorBorder[] = {0, 1, 0, 0};
	font = FontM;
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.15, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.15, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.15, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.15, 1};
	sizeEx = 0.02;
	offsetX=0;
	offsetY=0;
	offsetPressedX = 0.002; 
	offsetPressedY = 0.002;
	borderSize=0;
	default = false;
};

class NORRNRscNavButton:NORRNRscButton {
	w=0.1;h=0.04;
	x=0.90;
	sizeEx = 0.022;
	colorText[] = { 0, 0, 0, 1 };
	colorDisabled[] = { 0, 0, 1, 0.7 };   
	colorBackground[] = { 1, 1, 1, 0.5 };
	colorBackgroundDisabled[] = { 1, 1, 1, 0.5 };   
	colorBackgroundActive[] = { 0.5, 0.5, 0.5, 0.5 }; 
	colorFocused[] = { 0.31, 0.31, 0.31, 0.31 }; 
	colorShadow[] = { 0, 0, 0, 0.5 };
	colorBorder[] = { 0.5, 0.5, 0.5, 0.5 };	
};

class NORRNRscActiveText {
	access = ReadAndWrite;
	type = 11;
	idc = -1;
	style = 2;
	x = 0; y = 0;
	h = 0; w = 0;
	font = "TahomaB";
	sizeEx = 0.04;
	color[] = {1, 1, 1, 1};
	colorActive[] = {1, 0.5, 0, 1};
	soundEnter[] = {"", 0.1, 1};
	soundPush[] = {"", 0.1, 1};
	soundClick[] = {"", 0.1, 1};
	soundEscape[] = {"", 0.1, 1};
	text = "";
	default = 0;
};

class NORRNRscControlsGroup {
	type = 15;
	idc = -1;
	style = 0;
	x = 0; y = 0;
	w = 0; h = 0;
	class VScrollbar {
		color[] = {1, 1, 1, 1};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = false;	
	};

	class HScrollbar {
		color[] = {1, 1, 1, 1};
		height = 0.028;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = false;	
	};

	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};

	class Controls {};
};
	
class NORRNRscCombo {
	idc = -1;
	type = CT_COMBO;
	style = ST_LEFT; 
	colorSelect[] = {1, 1, 1, 1 };
	colorSelectBackground[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	colorScrollbar[] = {0, 0, 0, 1};
	colorBackground[] = {0, 0, 0, 1};
	colorBorder[] = {0, 0, 0, 1};
	colorShadow[] = {0, 0, 0, 1};
	soundSelect[] = { "", 0, 1 };
	soundExpand[] = { "", 0, 1 };
	soundCollapse[] = { "", 0, 1 };
	borderSize = 0;
	font = "TahomaB";
	sizeEx = 0.02; 
	rowHeight = 0.025;
	wholeHeight = 0.3;
	text = "";
	maxHistoryDelay = 0;
	default = true;

	x = 0; y = 0;
	w = 0; h = 0;

	thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
	arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
	border = "\ca\ui\data\ui_border_scroll_ca.paa";

	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;

	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};

class NORRNmouseHandler : NORRNRscControlsGroup {
	onMouseMoving = "[""MouseMoving"",_this] call MouseEvents";
	onMouseButtonDown = "[""MouseButtonDown"",_this] call MouseEvents";
	onMouseButtonUp = "[""MouseButtonUp"",_this] call MouseEvents";
	onMouseZChanged = "[""MouseZChanged"",_this] call MouseEvents";
	idc = 2501;
	type = 15;
	style = 0;
	x = 0.0; y = 0.0;
	w = 1.0; h = 1.0;
	colorBackground[] = {0.2, 0.0, 0.0, 0.0};

	class VScrollbar {
		color[] = {1, 1, 1, 1};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = false;
	};
	class HScrollbar {
		color[] = {1, 1, 1, 1};
		height = 0.028;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = false;	
	};
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
	
	class Controls {};
};

class NORRNRscPicture {
	type = CT_STATIC;
	idc = -1;
	style = ST_PICTURE;

	x = 0.1;
	y = 0.1;
	w = 0.4;
	h = 0.2;
	sizeEx = Dlg_TEXTHGT;

	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1,1,1, 1};
	font = FontM;

	text = "";
};

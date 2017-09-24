scriptName "voyagerCompass.sqf";

/*
	author - Unknown_GTX aka JonVeD

	version: 1.1
    -console dependency removed

	description:
		Generates a lightweight and fully customizable compass ui on your screen resembling the one from battlegrounds.
		Easily place your markers on the map and they will update on everyones compass.

	Methods of usage:

		mission-creators : init.sqf
			nul = [] execVM "voyagerCompass.sqf";

	known issues:
		- currently only the point-profile from battlegrounds is available. and custom colors dont save.

	Todo:
		- Optimize saving method.
		- Add color support for markers.

  Warning:
    Guys dont go below this line. You wont survive the chaos i wrote down here and call "code".
    Actually. Here is an on point representation of the code: https://gfycat.com/IckyGrimyIchneumonfly
*/

disableSerialization;
/// coordinates of compass angles
compass_pos = [
[3400, -225   ,"SE" ],
[3401, -210   ,"140"],
[3402, -195   ,"165"],

[3403, -180    ,"S" ],

[3405, -165   ,"195"],
[3406, -150   ,"210"],
[3407, -135   ,"SW" ],
[3408, -120   ,"240"],
[3409, -105   ,"255"],

[3410, -090    ,"W" ],

[3421, -075   ,"285"],
[3422, -060   ,"300"],
[3423, -045   ,"NW" ],
[3424, -030   ,"330"],
[3425, -015   ,"345"],

[3426, 0       ,"N" ],

[3427, 015   ,"15"  ],
[3428, 030   ,"30"  ],
[3429, 045   ,"NE"  ],
[3430, 060   ,"60"  ],
[3431, 075   ,"75"  ],

[3432, 090   ,"E"   ],

[3433, 105   ,"105" ],
[3434, 120   ,"120" ],
[3435, 135   ,"SE"  ],
[3436, 150   ,"150" ],
[3437, 165   ,"165" ],

[3438, 180   ,"S"   ],

[3439, 195   ,"195" ],
[3440, 210   ,"210" ],
[3441, 225   ,"SW"  ],
[3442, 240   ,"240" ],
[3443, 255   ,"255" ],

[3445, 270   ,"W"   ],

[3446, 285   ,"285" ],
[3447, 300   ,"300" ],
[3448, 315   ,"NW"  ],
[3449, 330   ,"330" ],
[3450, 345   ,"345" ],

[3451, 360   ,"N"   ],

[3452, 375   ,"15"  ],
[3453, 390   ,"30"  ],
[3454, 405   ,"NE"  ],
[3455, 420   ,"60"  ],
[3456, 435   ,"75"  ],

[3457, 450   ,"E"   ],

[3458, 465   ,"105" ],
[3459, 480   ,"120" ],
[3460, 495   ,"SE"  ],
[3461, 510   ,"150" ],
[3462, 525   ,"165" ],

[3463, 540   ,"S"   ],

[3464, 555   ,"195" ],
[3465, 570   ,"210" ],
[3466, 585  ,"SW"   ]
];
///
///
compass_pos_a3 = [

[3410, 0       ,"no" ]
];
///
fnc_removeString =
{
  params ["_from", "_to", "_string"];
  _stringArray = _string splitString "";

  _stringArray deleteRange [_from, _to];

  _stringArray = _stringArray joinString "";
  private _returnMe = _stringArray;
  _returnMe
};

nc_loaded = false;
nc_lb_type = [compass_pos, compass_pos_a3];
nc_colorOption = "f9f9f9";
nc_lb_colorOption = [nc_colorOption,"FFFFFF","000000"];
nc_lb_fontOption = [
"EtelkaMonospacePro",
"EtelkaMonospaceProBold",
"EtelkaNarrowMediumPro",
"LucidaConsoleB",
"PuristaBold",
"PuristaLight",
"PuristaMedium",
"PuristaSemiBold",
"RobotoCondensed",
"RobotoCondensedBold",
"RobotoCondensedLight",
"TahomaB"];



nc_x							   = 0.5;
nc_y							   = 0.01;

nc_w   				       = 3;
nc_span              = 2;
nc_type              = compass_pos;
nc_fontSize          = 1.1;
nc_alphaNumber			 = 0.8;
nc_alpha             = "E6";

nc_fontOption        = "RobotoCondensed";
nc_needle            = 1;
nc_shadow            = 1;
nc_checkbox_marker   = 1;
nc_fontOptionNumber  = 8;


nc_barOffsetX        = (nc_x * safezoneW + safezoneX);
nc_barOffsetY        = (nc_y * safezoneH + safezoneY);
nc_marker_offset = 0.04 + nc_barOffsetY;

folder = profileNamespace getVariable "profile_folder";

if (isNil {folder}) then {
  profileNamespace setVariable ["profile_folder",[0.499889,0.0346965,3.16098,1.86439,0,1.18143,"C0",0.753254,"PuristaLight",0,1,1,-0.0340903,5,1,0,"B1B1","FFFFFF"]];
  saveProfileNamespace;
  folder = profileNamespace getVariable "profile_folder";
};



("compassTitle" call BIS_fnc_rscLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
/// addaction

disableSerialization;

nc_x							   = folder select 0;
nc_y							   = folder select 1;
nc_w        				 = folder select 2;
nc_span              = folder select 3;
nc_type              = folder select 4;
nc_fontSize          = folder select 5;
nc_alpha             = folder select 6;
nc_alphaNumber			 = folder select 7;
nc_fontOption        = folder select 8;
nc_needle            = folder select 9;
nc_shadow            = folder select 10;
nc_checkbox_marker   = folder select 11;
nc_yM                = folder select 12;
nc_fontOptionNumber  = folder select 13;
nc_colorNumber 			 = folder select 14;
nc_typeNumber 			 = folder select 15;
nc_colorCustom			 = folder select 16;
nc_color						 = folder select 17;

//nc_w_marker  = nc_w;
nc_barOffsetX        = (nc_x * safezoneW + safezoneX);
nc_barOffsetY        = (nc_y * safezoneH + safezoneY);
nc_marker_offset = nc_yM + nc_barOffsetY;

nc_dialog_controls = [
	[1000,"nc_background",[1,"",[0.29375 * safezoneW + safezoneX,0.225 * safezoneH + safezoneY,0.170156 * safezoneW,0.759 * safezoneH],[-1,-1,-1,-1],[0.07,0.07,0.07,1],[-1,-1,-1,-1],"","RscText"],[]],
  [1004,"nc_background_char",[1,"",[0.304062 * safezoneW + safezoneX,0.489 * safezoneH + safezoneY,0.149531 * safezoneW,0.264 * safezoneH],[-1,-1,-1,-1],[0.03,0.03,0.03,1],[-1,-1,-1,-1],"","RscText"],[]],
  [1001,"nc_background_pos",[1,"",[0.304062 * safezoneW + safezoneX,0.28 * safezoneH + safezoneY,0.149531 * safezoneW,0.154 * safezoneH],[-1,-1,-1,-1],[0.03,0.03,0.03,1],[-1,-1,-1,-1],"","RscText"],[]],
  [1007,"nc_background_features",[1,"",[0.304062 * safezoneW + safezoneX,0.808 * safezoneH + safezoneY,0.149531 * safezoneW,0.11 * safezoneH],[-1,-1,-1,-1],[0.03,0.03,0.03,1],[-1,-1,-1,-1],"","RscText"],[]],
  [1002,"nc_background_title_pos",[1,"STAND & SPOT",[0.304062 * safezoneW + safezoneX,0.247 * safezoneH + safezoneY,0.149531 * safezoneW,0.033 * safezoneH],[-1,-1,-1,-1],[0.11,0.11,0.11,1],[-1,-1,-1,-1],"","RscText"],[]],
	[1103,"nc_background_pos_x",[1,"X",[0.314375 * safezoneW + safezoneX,0.291 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"HORIZONTAL POSITION. Set the correct horizontal position you desire.","RscStructuredText"],[]],
	[1104,"nc_background_pos_y",[1,"Y",[0.314375 * safezoneW + safezoneX,0.324 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"VERTICAL POSITION. Set the correct vertical position you desire.","RscStructuredText"],[]],
  [1106,"nc_background_pos_w",[1,"W",[0.314375 * safezoneW + safezoneX,0.357 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"WIDTH. Exact range of visibility for points.","RscStructuredText"],[]],
  [1107,"nc_background_pos_s",[1,"S",[0.314375 * safezoneW + safezoneX,0.39 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"SPAN. Change the distance between the points.","RscStructuredText"],[]],
	[1003,"nc_background_title_char",[1,"CHARACTERISTICS",[0.304062 * safezoneW + safezoneX,0.456 * safezoneH + safezoneY,0.149531 * safezoneW,0.033 * safezoneH],[-1,-1,-1,-1],[0.11,0.11,0.11,1],[-1,-1,-1,-1],"","RscText"],[]],
  [1100,"nc_background_fontSize",[1,"sS",[0.314375 * safezoneW + safezoneX,0.544 * safezoneH + safezoneY,0.020625 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"SIZE-FONT. Determines the size of the individual cardinal points.","RscStructuredText"],[]],
  [1102,"nc_background_fontAlpha",[1,"A",[0.314375 * safezoneW + safezoneX,0.577 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH],[1,1,1,0.5],[0,0,0,0],[-1,-1,-1,-1],"TRANSPARENCY. Set the visibility of the whole compass.","RscStructuredText"],[]],
  [1109,"nc_background_fontColor",[1,"#",[0.314375 * safezoneW + safezoneX,0.621 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH],[1,0,0,1],[0,0,0,0],[-1,-1,-1,-1],"COLOR-CODE. put #HEX color here for custom color.","RscStructuredText"],[]],
  [1110,"nc_background_shadow",[1,"Shadow",[0.402031 * safezoneW + safezoneX,0.709 * safezoneH + safezoneY,0.0360937 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"SHADOW. Enable the dropshadow for the cardinal points.","RscStructuredText"],[]],
	[1111,"nc_background_invert",[1,"Invert",[0.355625 * safezoneW + safezoneX,0.709 * safezoneH + safezoneY,0.0309375 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"INVERT. Switch between the option of the needles being at the top or bottom of the cardinal points.","RscStructuredText"],[]],
  [1006,"nc_background_title_features",[1,"MARKERS & FEATURES",[0.304062 * safezoneW + safezoneX,0.775 * safezoneH + safezoneY,0.149531 * safezoneW,0.033 * safezoneH],[-1,-1,-1,-1],[0.11,0.11,0.11,1],[-1,-1,-1,-1],"","RscText"],[]],
	[1112,"nc_background_pos_markerY",[1,"Y",[0.314375 * safezoneW + safezoneX,0.83 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"VERTICAL OFFSET. Set the correct vertical offset you desire.","RscStructuredText"],[]],
	[1113,"nc_background_visibility",[1,"Visbility",[0.402031 * safezoneW + safezoneX,0.874 * safezoneH + safezoneY,0.0360937 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"VISIBILITY. Toggle it.","RscStructuredText"],[]],
  [1114,"nc_background_info_soon",[1,"more features soon",[0.314375 * safezoneW + safezoneX,0.874 * safezoneH + safezoneY,0.0825 * safezoneW,0.022 * safezoneH],[1,1,1,0.3],[0,0,0,0],[-1,-1,-1,-1],"INFO. Future updates coming. Stay tuned","RscText"],[]],
	[1115,"nc_background_impressum",[1,"Voyage Compass 1.0",[0.304062 * safezoneW + safezoneX,0.94 * safezoneH + safezoneY,0.0825 * safezoneW,0.022 * safezoneH],[1,1,1,0.3],[0,0,0,0],[-1,-1,-1,-1],"Creator: Unknown_GTX aka JonVeD","RscText"],[]],
  [2400,"nc_save",[1,"SAVE",[0.412344 * safezoneW + safezoneX,0.94 * safezoneH + safezoneY,0.04125 * safezoneW,0.022 * safezoneH],[0.07,0.07,0.07,1],[0.93,0.93,0.93,1],[0.07,0.07,0.07,1],"Permanently save changes. (stays even after restarting the game)","RscButton"],[],
  ["profileNamespace setVariable ['profile_folder',folder]; saveProfileNamespace;"]],
	[2401,"nc_close",[1,"X",[0.391719 * safezoneW + safezoneX,0.94 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH],[0.07,0.07,0.07,1],[0.93,0.93,0.93,1],[-1,-1,-1,-1],"Close without save.","RscButton"],[],
  ["(uiNamespace getVariable 'nc_dialogDisplay') closeDisplay 2"]],
	[2800,"nc_shadow",[1,"",[0.391719 * safezoneW + safezoneX,0.709 * safezoneH + safezoneY,0.0103125 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"SHADOW. Enable the dropshadow for the cardinal points.","RscCheckBox"],[],
	[nc_shadow, "folder set [10, (_this select 1)]; nc_shadow = (_this select 1); if (nc_shadow == 1) then { _comp = [nc_type, nc_needle, nc_fontSize, 2, nc_fontOption, nc_alpha, nc_colorOption] call fnc_loadCompass; }else{ _comp = [nc_type, nc_needle, nc_fontSize, 0, nc_fontOption, nc_alpha, nc_colorOption] spawn fnc_loadCompass;};"]],

	[1901,"nc_x",[1,"",[0.340156 * safezoneW + safezoneX,0.302 * safezoneH + safezoneY,0.0979687 * safezoneW,0.011 * safezoneH],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"HORIZONTAL POSITION. Set the correct horizontal position you desire.","RscSlider"],[],
	[[/*range*/0,1, nc_x], "folder set [0, (_this select 1)]; nc_barOffsetX = ((_this select 1) * safezoneH + safezoneY)"]],

	[1900,"nc_y",[1,"",[0.340156 * safezoneW + safezoneX,0.335 * safezoneH + safezoneY,0.0979687 * safezoneW,0.011 * safezoneH],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"VERTICAL POSITION. Set the correct vertical position you desire.","RscSlider"],[],
	[[/*range*/0,1, nc_y], "folder set [1, (_this select 1)]; nc_barOffsetY = ((_this select 1) * safezoneH + safezoneY)"]],

	[1902,"nc_w",[1,"",[0.340156 * safezoneW + safezoneX,0.368 * safezoneH + safezoneY,0.0979687 * safezoneW,0.011 * safezoneH],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"WIDTH. Exact range of visibility for points.","RscSlider"],[],
	[[/*range*/0,5, nc_w], "folder set [2, (_this select 1)]; nc_w = (_this select 1)"]],

	[1903,"nc_s",[1,"",[0.340156 * safezoneW + safezoneX,0.401 * safezoneH + safezoneY,0.0979687 * safezoneW,0.011 * safezoneH],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"SPAN. Change the distance between the points.","RscSlider"],[],
	[[/*range*/1,3, nc_span], "folder set [3, (_this select 1)]; nc_span = (_this select 1)"]],

	[2100,"nc_type",[1,"",[0.319531 * safezoneW + safezoneX,0.511 * safezoneH + safezoneY,0.118594 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"TYPE. Decide what kind of compass you want.","RscCombo"],[],
	[["Arma 3","Battlegrounds"], "folder set [15, (_this select 1)]; nc_type = (_this select 1); _comp = [nc_type, nc_needle, nc_fontSize, nc_shadow, nc_fontOption, nc_alpha, nc_colorOption] call fnc_loadCompass", nc_typeNumber]],

	[1904,"nc_fontSize",[1,"",[0.340156 * safezoneW + safezoneX,0.555 * safezoneH + safezoneY,0.0979687 * safezoneW,0.011 * safezoneH],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"SIZE-FONT. Determines the size of the individual cardinal points.","RscSlider"],[],
	[[/*range*/0.8,1.4, nc_fontSize], "folder set [5, (_this select 1)]; nc_fontSize = (_this select 1); _comp = [nc_type, nc_needle, nc_fontSize, nc_shadow, nc_fontOption, nc_alpha, nc_colorOption] call fnc_loadCompass"]],

	[1905,"nc_fontAlpha",[1,"",[0.340156 * safezoneW + safezoneX,0.588 * safezoneH + safezoneY,0.0979687 * safezoneW,0.011 * safezoneH],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"TRANSPARENCY. Set the visibility of the whole compass.","RscSlider"],[],
	[[/*range*/0,1,nc_alphaNumber], "folder set [7, (_this select 1)]; _clr = [0,0,0,(_this select 1)] call BIS_fnc_colorRGBAtoHTML; _cutBelow = [0,1, _clr] call fnc_removeString; _cutAbove = [2,6, _cutBelow] call fnc_removeString; nc_alpha = _cutAbove; _comp = [nc_type, nc_needle, nc_fontSize, nc_shadow, nc_fontOption, nc_alpha, nc_colorOption] call fnc_loadCompass; folder set [6, nc_alpha]; "]],

	[2103,"nc_font",[1,"",[0.319531 * safezoneW + safezoneX,0.665 * safezoneH + safezoneY,0.118594 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"FONT.  Switch between different looks with the font.","RscCombo"],[],
  [["EtelkaMonospacePro","EtelkaMonospaceProBold","EtelkaNarrowMediumPro","LucidaConsoleB","PuristaBold","PuristaLight","PuristaMedium","PuristaSemiBold","RobotoCondensed","RobotoCondensedBold","RobotoCondensedLight","TahomaB"],
  "folder set [13, (_this select 1)];folder set [8, (nc_lb_fontOption select (_this select 1))]; nc_fontOptionNumber = (_this select 1); nc_fontOption = nc_lb_fontOption select (_this select 1); _comp = [nc_type, nc_needle, nc_fontSize, nc_shadow, nc_lb_fontOption select (_this select 1), nc_alpha, nc_colorOption] call fnc_loadCompass", nc_fontOptionNumber]],

  [1005,"nc_color_code",[1,"",[0.326719 * safezoneW + safezoneX,0.621 * safezoneH + safezoneY,0.04125 * safezoneW,0.022 * safezoneH],[1,1,1,1],[0.03,0.03,0.03,1],[-1,-1,-1,-1],"","RscEdit"],[]],
	[2102,"nc_color",[1,"",[0.371094 * safezoneW + safezoneX,0.621 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"COLOR. Choose between predefined colors.","RscCombo"],[],
	[["Custom","White","Black"], "folder set [14, (_this select 1)]; folder set [17, (nc_lb_colorOption select (_this select 1))]; nc_colorOption = nc_lb_colorOption select (_this select 1); _comp = [nc_type, nc_needle, nc_fontSize, nc_shadow, nc_fontOption, nc_alpha, nc_lb_colorOption select (_this select 1)] call fnc_loadCompass", nc_colorNumber]],

	[2801,"nc_invert",[1,"",[0.345312 * safezoneW + safezoneX,0.709 * safezoneH + safezoneY,0.0103125 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"INVERT. Switch between the option of the needles being at the top or bottom of the cardinal points.","RscCheckBox"],[],
	[nc_needle, "folder set [9, (_this select 1)]; nc_needle = (_this select 1); _comp = [nc_type, nc_needle, nc_fontSize, nc_shadow, nc_fontOption, nc_alpha, nc_colorOption] call fnc_loadCompass"]],

	[1906,"nc_markerY",[1,"",[0.340156 * safezoneW + safezoneX,0.841 * safezoneH + safezoneY,0.0979687 * safezoneW,0.011 * safezoneH],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"VERTICAL OFFSET. Set the correct vertical offset you desire.","RscSlider"],[],
	[[/*range*/-2,2, nc_yM], "folder set [12, (_this select 1)]; nc_marker_offset = (_this select 1) + nc_barOffsetY"]],

	[2802,"nc_visibility",[1,"",[0.391719 * safezoneW + safezoneX,0.874 * safezoneH + safezoneY,0.0103125 * safezoneW,0.022 * safezoneH],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"VISIBILITY. Toggle it.","RscCheckBox"],[],
	[nc_checkbox_marker, "folder set [11, (_this select 1)]; nc_checkbox_marker = (_this select 1)"]]
	];

//[idc, "name", [1, "text", [pos], [text_color], [background_color], [active_color], "Tooltip", "-1"],[]],

with uiNamespace do {
  nc_dialogDisplay = findDisplay 46 createDisplay "RscDisplayEmpty";
};
{
  _idc  = _x select 0;
  _type = (_x select 2) select 7;
  _pos  = (_x select 2) select 2;

  _tooltip = (_x select 2)select 6;
  _background_color = (_x select 2) select 4;
  _txt  = (_x select 2) select 1;



  _display = uiNamespace getVariable "nc_dialogDisplay";


  switch (_type) do {
    case ("RscText"): {
      _ctrl = _display ctrlCreate [_type, _idc];
      _ctrl ctrlSetText _txt;
      //hint format ["x: %1, x: %2, x: %3, x: %4", _posx, _posy, _posw, _posh];
      _ctrl ctrlSetTextColor [1, 1, 1, 1];
      _ctrl ctrlSetBackgroundColor _background_color;
    };
    case ("RscStructuredText"): {
      _ctrl = _display ctrlCreate [_type, _idc];
      _ctrl ctrlSetText _txt;
      _ctrl ctrlSetTextColor [1, 1, 1, 1];
      _ctrl ctrlSetBackgroundColor _background_color;
    };
    case ("RscSlider"): {
      _sliderRange_start = ((_x select 4) select 0) select 0;
      _sliderRange_end = ((_x select 4) select 0) select 1;
			_sliderPos = ((_x select 4) select 0) select 2;
      _func = compile ((_x select 4) select 1);

      _ctrl = _display ctrlCreate [_type, _idc];
      _ctrl sliderSetRange [_sliderRange_start, _sliderRange_end];
			_ctrl sliderSetPosition _sliderPos;
      _ctrl ctrlAddEventHandler ["SliderPosChanged",_func];
    };
    case ("RscCombo"): {
      _ctrl = _display ctrlCreate [_type, _idc];
      _func = compile ((_x select 4) select 1);
      for "_i" from 0 to (count ((_x select 4) select 0)-1) do
      {
        _lbItem = ((_x select 4) select 0) select _i;
        _index = _ctrl lbAdd _lbItem;
      };
			_indexy = (_x select 4) select 2;
			_ctrl lbSetCurSel _indexy;
      _ctrl ctrlAddEventHandler ["LBSelChanged",_func];
    };
    case ("RscCheckBox"): {
      _ctrl = _display ctrlCreate [_type, _idc];
      if ((_x select 4) select 0 == 1) then {
        _ctrl cbSetChecked true;
      };
      _func = compile ((_x select 4) select 1);
      _ctrl ctrlAddEventHandler ["CheckedChanged",_func];
			if (nc_needle == 1) then {
			  _ctrl ctrlSetChecked true;
			}else{_ctrl ctrlSetChecked false;};
    };
    case ("RscButton"): {
      _ctrl = _display ctrlCreate [_type, _idc];
      _ctrl ctrlSetText _txt;
      _func = compile ((_x select 4) select 0);
			_ctrl ctrlAddEventHandler ["ButtonClick",_func];
    };
    case ("RscEdit"): {
      _ctrl = _display ctrlCreate [_type, _idc];
      _ctrl ctrlSetTextColor [1, 1, 1, 1];
      _ctrl ctrlSetBackgroundColor [0, 0, 0, 1];
			_ctrl ctrlAddEventHandler ["KeyUp",{nc_colorOption =  ctrlText ((uiNamespace getVariable "nc_dialogDisplay") displayCtrl 1005); _comp = [nc_type, nc_needle, nc_fontSize, nc_shadow, nc_fontOption, nc_alpha, nc_colorOption] call fnc_loadCompass}];
			_ctrl ctrlSetText nc_colorOption;

		};
  };
  _ctrl = _display displayCtrl _idc;
  _ctrl ctrlSetPosition _pos;
  _ctrl ctrlCommit 0;
  _ctrl ctrlSetTooltip _tooltip;
  //systemChat str (uiNamespace getVariable "nc_dialogDisplay")
} forEach nc_dialog_controls;


fnc_loadCompass = {

  disableSerialization;
  params ["_compassType", "_ncNeedle","_ncFontSize","_ncShadow","_ncFontOption", "_ncAlpha", "_ncColorOption"];

  _display = uiNamespace getVariable "RscTitleDisplayEmpty";
	for "_i" from 3399 to 3499 do
	{

		ctrlDelete (_display displayCtrl _i);
	};
	_compass = nc_lb_type select _compassType;
  _compassNeedle = _display ctrlCreate ["RscStructuredText", 3399];
  _compassNeedle ctrlSetStructuredText parseText format["<t shadow=2><t shadowColor='#ff0000' align='center' size='%1' color='#f9f9f9'>|</t>", 0.65];

  for "_i" from 0 to (count _compass - 1) do
  {

    _idc = ((_compass select _i) select 0);
    _dir = ((_compass select _i) select 2);
    _arrayIndex = _i;//_compassType find _x;

    nc_sizeX = 0.65 * _ncFontSize;

    if (_arrayIndex % 6 == 3) then
    {
      nc_sizeX = 1 * _ncFontSize;
    };
    if (_arrayIndex % 6 == 0) then
    {
      nc_sizeX = 0.8 * _ncFontSize;
    };

    _edit = _display ctrlCreate ["RscStructuredText", _idc];

    _var_needle = "";
    switch (_ncNeedle) do {
      case (1): {
        _var_needle = _dir + "<br />|</t>";
      };
      case (0): {
        _var_needle = "|<br />" + _dir + "</t>";
      };
    };
    _edit ctrlSetStructuredText parseText ("<t shadow=" + str _ncShadow + "><t shadowColor='#000000' align='center' size='" + str nc_sizeX + "' font='" + _ncFontOption + "' color='#" + _ncAlpha + _ncColorOption + "'>" + _var_needle);
    _edit ctrlCommit 0;
  };
};
_comp = [nc_type, nc_needle, nc_fontSize, nc_shadow, nc_fontOption, nc_alpha, nc_colorOption] call fnc_loadCompass;
nc_loaded = true;


///
sup = 0.1;
waitUntil {nc_loaded};
systemChat "compass init complete";

/// rendering of compass
currentMarkers = [];
combMarkers = [];

["0", "onEachFrame",{

  _compassNeedle = ((uiNamespace getVariable "RscTitleDisplayEmpty") displayCtrl 3399);
  _compassNeedle ctrlSetPosition [nc_barOffsetX - (0.1/2),nc_barOffsetY,0.1,0.015 * safezoneH];
  _compassNeedle ctrlCommit 0;

  {
    _ctrl = _x select 0;
    _pos = (_x select 1) / 100;
    _degreeControl = ((uiNamespace getVariable "RscTitleDisplayEmpty") displayCtrl _ctrl);
    _playerDir = (getDir player)/100;

    _controlPos = (ctrlPosition _degreeControl) select 0;

    if (_controlPos > ((nc_w / 10 * safezoneW + safezoneX) - (0.1/2)) && _controlPos < (1 - ((nc_w / 10 * safezoneW + safezoneX))- (0.1/2))) then {
      _degreeControl ctrlSetPosition [ nc_barOffsetX + ((_pos - _playerDir) / nc_span) - (0.1/2),nc_barOffsetY,0.1,0.4];
    }else{
      _degreeControl ctrlSetPosition [ nc_barOffsetX + ((_pos - _playerDir) / nc_span) - (0.1/2),nc_barOffsetY,0.0,0.4];
    };
    _degreeControl ctrlCommit 0;
  } forEach compass_pos;


  {
    _ctrl  = _x select 0;
    _marker = _x select 1;
    _ctrl2 = _ctrl + 100;

    _playerDir = (getDir player)/100;
    _relativeDir = ([player, markerPos _marker] call BIS_fnc_relativeDirTo)/100;

    _MarkerControl  = ((uiNamespace getVariable "RscTitleDisplayEmpty") displayCtrl _ctrl);
    _MarkerControl2 = ((uiNamespace getVariable "RscTitleDisplayEmpty") displayCtrl _ctrl2);

    _controlPos = (ctrlPosition _MarkerControl) select 0;
    _controlPos2 = (ctrlPosition _MarkerControl2) select 0;

    if (_controlPos > (((nc_w / 10 * safezoneW + safezoneX) - (0.1/2)) * nc_checkbox_marker) && _controlPos < (((1 - (nc_w / 10 * safezoneW + safezoneX))- (0.1/2)) * nc_checkbox_marker)) then {
      _MarkerControl  ctrlSetPosition [ nc_barOffsetX + (_relativeDir / nc_span)            - (0.05/2),nc_marker_offset,0.05,0.09];
    }else{
      _MarkerControl  ctrlSetPosition [ nc_barOffsetX + (_relativeDir / nc_span)                   - (0.05/2),nc_marker_offset,0.00,0.09];
    };

    if (_controlPos2 > (((nc_w / 10 * safezoneW + safezoneX) - (0.1/2)) * nc_checkbox_marker) && _controlPos2 < ((((1 - (nc_w / 10 * safezoneW + safezoneX))- (0.1/2))) * nc_checkbox_marker)) then {
      _MarkerControl2 ctrlSetPosition [ nc_barOffsetX + (_relativeDir / nc_span) - (3.6/nc_span)  - (0.05/2),nc_marker_offset,0.05,0.09];
    }else{
      _MarkerControl2 ctrlSetPosition [ nc_barOffsetX + (_relativeDir / nc_span) - (3.6/nc_span)  - (0.05/2),nc_marker_offset,0.00,0.09];
    };

    _MarkerControl  ctrlCommit 0;
    _MarkerControl2 ctrlCommit 0;
  } forEach combMarkers;
}] call BIS_fnc_addStackedEventHandler;
///

while {true} do {
  /// create double array ([marker], [idc,marker])
  {
	if !(_x in currentMarkers) then {
      _display = uiNamespace getVariable "RscTitleDisplayEmpty";
      _index = allMapMarkers find _x;
      _idc = 5500 + _index;

      _edit  = _display ctrlCreate ["RscStructuredText", _idc];
      _edit2 = _display ctrlCreate ["RscStructuredText", _idc + 100];

      _edit ctrlSetPosition [-2, -2, 0.05, 0.05];
      _edit2 ctrlSetPosition [-2, -2, 0.05, 0.05];

      _img =  getText (configfile >> "cfgMarkers" >> markerType _x >> "icon");
      _txt = parseText format ["<img image='%1' align='center'/>", _img];
      _edit ctrlSetStructuredText _txt;
      _edit2 ctrlSetStructuredText _txt;

      _edit  ctrlCommit 0;
      _edit2 ctrlCommit 0;

      currentMarkers pushBack _x;
      combMarkers pushBack [_idc, _x];
      systemChat format ["created: %1", _x];
    };
  } forEach allMapMarkers;
  ///

  /// delete IF marker from [idc,marker] aint alive anymore
  {
    if !((_x select 1) in allMapMarkers) then {
      _display = uiNamespace getVariable "RscTitleDisplayEmpty";
      ctrlDelete (_display displayCtrl (_x select 0));
      ctrlDelete (_display displayCtrl ((_x select 0)+100));
      combMarkers = combMarkers - [_x];
      currentMarkers = currentMarkers - [_x];
    };
  } forEach combMarkers;
  ///
  sleep 0.2;
};

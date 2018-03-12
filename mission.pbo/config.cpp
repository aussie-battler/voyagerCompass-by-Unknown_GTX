

class CfgXM8
{
	extraApps[] = {"Compass"}; 
	
		class settings
	{
		controlID = 4070;
		appID = "App01";
		title = "Settings";
	};
	
	class healthScanner
	{
		controlID = 4120;
		appID = "App02";
		title = "Health Scanner";
	};
	
	class slothMachine
	{
		controlID = 4140;
		appID = "App03";
		title = "Sloth Machine";
	};
	
	class Compass 
	{
		title = "Compass";
		controlID = 80000;					//IDC:50200 -> 50102 || These need to be unique and out of range from each other
		logo = "ExAdClient\XM8\Apps\compass\compass.paa";
        	quickFunction = "ExileClientXM8CurrentSlide = 'apps';closeDialog 0;[] execVM 'ExAdClient\XM8\Apps\compass\voyagerCompass.sqf'";
	};		

}; 

/*
	XM8 Extra apps,  the Exile way of doing it
	
	Here is an example app layout:
	class XM8_App01_Button: RscExileXM8AppButton1x1
	{
	    textureNoShortcut = "";  	// Path to picture. This can be via mission file or client side PBO
	    text = "";					// The name of the app to be display on the button
	    onButtonClick = "";			// The code to fire when the app is clicked
	    resource = "";				// The name of the resource to load for the app, leave as an empty string if you just want to run code without a GUI, like BOOM or spawning a bike
	};
*/

class XM8_App01_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "\exile_assets\texture\ui\xm8_app_settings_ca.paa";
    text = "Settings";
    onButtonClick = "['settings', 0] call ExileClient_gui_xm8_slide";
    resource = "XM8SlideSettings";
};

class XM8_App02_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "\exile_assets\texture\ui\xm8_app_health_scanner_ca.paa";
    text = "Health Scanner";
    onButtonClick = "['healthScanner', 0] call ExileClient_gui_xm8_slide";
    resource = "XM8SlideHealthScanner";
};

class XM8_App03_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "\exile_assets\texture\ui\xm8_app_slothMachine_ca.paa";
    text = "Sloth Machine";
    onButtonClick = "['slothMachine', 0] call ExileClient_gui_xm8_slide";
    resource = "XM8SlideSlothMachine";
};

class XM8_App04_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "\exile_assets\texture\ui\xm8_app_boom_ca.paa";
    text = "BOOM!";
    onButtonClick = "call ExileClient_system_breaching_detonate";
    resource = "";
};

class XM8_App09_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "ExAdClient\XM8\Apps\compass\compass.paa";
    text = "Compass";
    onButtonClick = "ExileClientXM8CurrentSlide = 'apps';closeDialog 0;[] execVM 'custom\compass\voyagerCompass.sqf'";
    resource = "";
};

class XM8_App06_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

class XM8_App07_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

class XM8_App08_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

class XM8_App09_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

class XM8_App10_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

class XM8_App11_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

class XM8_App12_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

class XM8_App13_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

class XM8_App14_Button: RscExileXM8AppButton1x1
{
    textureNoShortcut = "";
    text = "";
    onButtonClick = "";
    resource = "";
};

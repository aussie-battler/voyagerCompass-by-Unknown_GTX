**Install: voyagerCompass HUD by Unknown_GTX from your XM8.**

1. Install ExAd by @Janski https://goo.gl/VBxFFa

2. Drop the compass folder into your.mission\ExAdClient\XM8\Apps\compass
   
3. In config.cpp search for class CFGXM8

Add the following to extraApps[] = { };

"ExAd_Unit" 

The line should now read:  extraApps[] = {"Compass"};

4. Underneath the extraApps line add the compass button:

class CfgXM8
{
	extraApps[] = {"Compass"}; 
	

	class Compass 
	{
		title = "Compass";
		controlID = 50200;					//IDC:50200 -> 50102 || These need to be unique and out of range from each other
		logo = "ExAdClient\XM8\Apps\CHVD\compass.paa";
        quickFunction = "ExileClientXM8CurrentSlide = 'apps';closeDialog 0;[] execVM 'ExAdClient\XM8\Apps\compass\voyagerCompass.sqf'";
	};		

}; 

Bog thanks to Unknown_GTX for this cool script.

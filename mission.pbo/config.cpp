

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


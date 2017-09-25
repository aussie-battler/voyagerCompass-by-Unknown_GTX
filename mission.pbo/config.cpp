

class CfgXM8
{
	extraApps[] = {"Compass"}; 
	

	class Compass 
	{
		title = "Compass";
		controlID = 80000;					//IDC:50200 -> 50102 || These need to be unique and out of range from each other
		logo = "ExAdClient\XM8\Apps\compass\compass.paa";
        quickFunction = "ExileClientXM8CurrentSlide = 'apps';closeDialog 0;[] execVM 'ExAdClient\XM8\Apps\compass\voyagerCompass.sqf'";
	};		

}; 


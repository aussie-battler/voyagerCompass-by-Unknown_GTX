**voyagerCompass HUD by Unknown_GTX. V1.1**

**Install for Arma3 Exile XM8 apps:**

1. Install ExAd by @Janski https://goo.gl/VBxFFa

2. Drop the compass folder into your.mission\ExAdClient\XM8\Apps\compass
   
3. In config.cpp search for class CFGXM8

Add the following to extraApps[] = { };

"ExAd_Unit" 

The line should now read:  extraApps[] = {"Compass"};

4. Underneath the extraApps line add the compass button:
```
class Compass 
{
title = "Compass";
controlID = 80000; //IDC:50200 -> 50102 || These need to be unique and out of range from each other
logo = "ExAdClient\XM8\Apps\compass\compass.paa";
quickFunction = "ExileClientXM8CurrentSlide = 'apps';closeDialog 0;[] execVM 'ExAdClient\XM8\Apps\compass\voyagerCompass.sqf'";
};		
```

Big thanks to Unknown_GTX for this cool script.

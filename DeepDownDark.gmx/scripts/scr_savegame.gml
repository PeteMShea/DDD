if (file_exists("Save.sav")) file_delete("Save.sav");
ini_open("Save.sav");

// weapons
for (i =1; i <25; i+=1)
    {
        keystring = "Weapon_" + string(i);
        ini_write_real("WeaponUnlocks",keystring,global.WeaponUnlocked[i]);
    }

// items
for (i =1; i <25; i+=1)
    {
        keystring = "Equip_" + string(i);
        ini_write_real("EquipUnlocks",keystring,global.EquipUnlocked[i]);
    }
    
//next item in a blackbox
ini_write_real("GameplayGlobals","NextItem:",global.nextitemweapon);    


//story
ini_write_real("StoryGlobals","NextCategory:",global.nextcategory);   
ini_write_real("StoryGlobals","categorycap1:",global.categorycap[1]);
ini_write_real("StoryGlobals","categorycap2:",global.categorycap[2]);
ini_write_real("StoryGlobals","categorycap3:",global.categorycap[3]);

ini_write_real("StoryGlobals","categorycount1:",global.categorycount[1]);
ini_write_real("StoryGlobals","categorycount2:",global.categorycount[2]);
ini_write_real("StoryGlobals","categorycount3:",global.categorycount[3]);
     

ini_close();

  

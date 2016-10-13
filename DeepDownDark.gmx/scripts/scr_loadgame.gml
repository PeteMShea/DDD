if (file_exists("Save.sav"))
{
    ini_open("Save.sav");
    blank = 0;
    
    // weapons
    for (i =1; i <25; i+=1)
        {
            keystring = "Weapon_" + string(i);
            global.WeaponUnlocked[i] = ini_read_real("WeaponUnlocks",keystring,blank);
        }
    
    // items
    for (i =1; i <25; i+=1)
        {
            keystring = "Equip_" + string(i);
            global.EquipUnlocked[i] = ini_read_real("EquipUnlocks",keystring,blank);
        }
        
    //next item in a blackbox
    global.nextitemweapon = ini_read_real("GameplayGlobals","NextItem:",blank);
    
    //whether quick restarting or not
    global.reboot = ini_read_real("GameplayGlobals","reboot:",true);
    
        
    //monsters seen
    global.sporeseen = ini_read_real("GameplayGlobals","sporeseen:",blank);
    global.spikerseen = ini_read_real("GameplayGlobals","spikerseen:",blank);
    global.ballplantseen = ini_read_real("GameplayGlobals","ballplantseen:",blank);
    global.gauntseen = ini_read_real("GameplayGlobals","gauntseen:",blank);
    global.grabberseen = ini_read_real("GameplayGlobals","grabberseen:",blank);
    global.formlessseen = ini_read_real("GameplayGlobals","formlessseen:",blank);
    

    //story progress
    global.nextcategory = ini_read_real("StoryGlobals","NextCategory:", 1);
    global.categorycap[1] = ini_read_real("StoryGlobals","categorycap1:", blank);  
    global.categorycap[2] = ini_read_real("StoryGlobals","categorycap2:", blank); 
    global.categorycap[3] = ini_read_real("StoryGlobals","categorycap3:", blank); 
    
    global.categorycount[1] = ini_read_real("StoryGlobals","categorycount1:", 1); 
    global.categorycount[2] = ini_read_real("StoryGlobals","categorycount2:", 1); 
    global.categorycount[3] = ini_read_real("StoryGlobals","categorycount3:", 1); 

    
    
    ini_close();
}
else
{
    show_debug_message("****** Trying to load Save file but does not exist *******");

}

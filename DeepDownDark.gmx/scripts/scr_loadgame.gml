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
    
    
    
    ini_close();
}
else
{
    show_debug_message("****** Trying to load Save file but does not exist *******");

}

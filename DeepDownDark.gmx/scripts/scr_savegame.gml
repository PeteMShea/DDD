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
    

ini_close();

  

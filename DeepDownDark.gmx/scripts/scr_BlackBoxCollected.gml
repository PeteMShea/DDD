// calculate which item to unlock

unlockeditem = false;
countID = 1;

while(unlockeditem == false)
    {
        if global.nextitemweapon == 1 && unlockeditem == false
            {
                itemID = global.WeaponProgression[countID];      //sets next item in the unlock progression
                
                if global.WeaponUnlocked[itemID] == false
                    {
                        global.WeaponUnlocked[itemID] = true;
                        itemunlockedstring = global.WeaponName[itemID];
                        show_debug_message("Unlocked " + itemunlockedstring);
                        unlockeditem = true;
                        global.nextitemweapon *= -1;
                    }
                else 
                    {
                        countID += 1      
                    }
            }    
        if global.nextitemweapon == -1 && unlockeditem == false
            {
                itemID = global.EquipProgression[countID];      //sets next item in the unlock progression
                
                if global.EquipUnlocked[itemID] == false
                    {
                        global.EquipUnlocked[itemID] = true;
                        itemunlockedstring = global.EquipName[itemID];
                        show_debug_message("Unlocked " + itemunlockedstring);
                        unlockeditem = true;
                        global.nextitemweapon *= -1;
                    }
                else 
                    {
                        countID += 1      
                    }
            }  
    }

//now update the Save file
script_execute(scr_savegame);    
    

//now create the message panel
inst = instance_create(0, 0, obj_MessagePanel);

with (inst)
    {
        messagestring1 = "BLACK BOX FOUND!";
        messagestring2 = "ACQUIRED BLUEPRINT FOR";
        messagestring3 = other.itemunlockedstring;    
    }



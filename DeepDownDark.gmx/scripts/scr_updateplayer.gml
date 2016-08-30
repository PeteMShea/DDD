basestrength = 100;
baseattack = 60;
basedefence = 80;
baseforward = 70;
baserear = 50;
basesanity = 80;

// Weapon and Equip upgrades applied to the player- called on player create and on item purchase

if global.WeaponEquipped[1] == true
    {
        obj_player.shoot_rate = 9;
        obj_player.turret = false;
    }
if global.WeaponEquipped[2] == true
    {
        obj_player.shoot_rate = 6;
        obj_player.turret = false;
    }
if global.WeaponEquipped[3] == true
    {
        obj_player.shoot_rate = 4;
        obj_player.turret = false;
    }
if global.WeaponEquipped[4] == true 
    {
        obj_player.turret = true;
        obj_player.shoot_rate = 9;
        obj_player.turretturn = 1.0;
    }
if global.WeaponEquipped[5] == true 
    {
        obj_player.turret = true;
        obj_player.shoot_rate = 6;
        obj_player.turretturn = 2;
    }    
if global.WeaponEquipped[6] == true 
    {
        obj_player.turret = true;
        obj_player.shoot_rate = 4;
        obj_player.turretturn = 3;  //turns 3 times in a frame
    }
        
//update the player Attributes for all equipped items
for (i = 1; i < 25; i += 1)
{
    if global.WeaponEquipped[i] == true
    {
        if global.WeaponAttMod[i] == 1 global.strength = basestrength + global.WeaponAttBoost[i]
        if global.WeaponAttMod[i] == 2 global.attack = baseattack + global.WeaponAttBoost[i]    
        if global.WeaponAttMod[i] == 3 global.defence = basedefence + global.WeaponAttBoost[i]
        if global.WeaponAttMod[i] == 4 global.forward = baseforward + global.WeaponAttBoost[i]
        if global.WeaponAttMod[i] == 5 global.rear = baserear + global.WeaponAttBoost[i]
        if global.WeaponAttMod[i] == 6 global.baseSanity = basesanity + global.WeaponAttBoost[i]                                   
    }


}





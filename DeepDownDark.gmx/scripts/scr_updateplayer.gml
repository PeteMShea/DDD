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
        obj_player.turretturn = 3;  
    }
if global.WeaponEquipped[7] == true 
    {
        obj_player.bulletdamage = 0.5;
        obj_player.bulletfire = 1;
    }
if global.WeaponEquipped[8] == true 
    {
        obj_player.bulletdamage = 1.0;
        obj_player.bulletfire = 1;        
    }
if global.WeaponEquipped[9] == true 
    {
        obj_player.bulletdamage = 1.0;
        obj_player.bulletfire = 2;        
    }    
    
    
                
//update the player Attributes for all equipped items
for (i = 1; i < 25; i += 1)
{
    if global.WeaponEquipped[i] == true
    {
        if global.WeaponAttMod[i] == 1 basestrength += global.WeaponAttBoost[i]
        if global.WeaponAttMod[i] == 2 baseattack += global.WeaponAttBoost[i]    
        if global.WeaponAttMod[i] == 3 basedefence += global.WeaponAttBoost[i]
        if global.WeaponAttMod[i] == 4 baseforward += global.WeaponAttBoost[i]
        if global.WeaponAttMod[i] == 5 baserear += global.WeaponAttBoost[i]
        if global.WeaponAttMod[i] == 6 basesanity += global.WeaponAttBoost[i]                                   
    }
}

global.strength = basestrength;
global.attack = baseattack;
global.defence = basedefence;
global.forward = baseforward;
global.rear = baserear;
global.baseSanity = basesanity;



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
        obj_player.bulletfire = 0;
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
if global.WeaponEquipped[10] == true 
    {
        obj_player.bulletdamage = 1.0;
        obj_player.bulletfire = 3;        
    }    
if global.WeaponEquipped[11] == true 
    {
        obj_player.bulletdamage = 1.0;
        obj_player.bulletfire = 4;        
    }
if global.WeaponEquipped[12] == true 
    {
        obj_player.bulletdamage = 1.0;
        obj_player.bulletfire = 5;        
    }         

    
    
    
    

    
//Equipment Upgrades


if global.EquipEquipped[1] == true
    {
        global.startHealth = 120;
        global.playerHealth = 120;
    }

if global.EquipEquipped[2] == true
    {
        global.startHealth = 150;
        global.playerHealth = 150;        
    }     
if global.EquipEquipped[3] == true
    {
        global.startHealth = 200;
        global.playerHealth = 200;        
    }     
if global.EquipEquipped[4] == true
    {
        obj_player.damagemult = 10;     //how much collision damage does- base level 15
        obj_player.mindamage = 3.0;     //base level 0.5;
    } 
    

if global.EquipEquipped[13] == true
    {
        obj_player.goldmagnetrange = 120;     //range gold particles drawn to player
        obj_player.magnetstrength = 50;
    }    
if global.EquipEquipped[14] == true
    {
        obj_player.goldmagnetrange = 300;     //range gold particles drawn to player
        obj_player.magnetstrength = 80;
    }      
if global.EquipEquipped[15] == true
    {
        obj_player.goldmagnetrange = 400;     //range gold particles drawn to player
        obj_player.magnetstrength = 100;
        obj_player.magnetextract = 250;
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
    if global.EquipEquipped[i] == true
    {
        if global.EquipAttMod[i] == 1 basestrength += global.EquipAttBoost[i]
        if global.EquipAttMod[i] == 2 baseattack += global.EquipAttBoost[i]    
        if global.EquipAttMod[i] == 3 basedefence += global.EquipAttBoost[i]
        if global.EquipAttMod[i] == 4 baseforward += global.EquipAttBoost[i]
        if global.EquipAttMod[i] == 5 baserear += global.EquipAttBoost[i]
        if global.EquipAttMod[i] == 6 basesanity += global.EquipAttBoost[i]                                   
    }    
}

global.strength = basestrength;
global.attack = baseattack;
global.defence = basedefence;
global.forward = baseforward;
global.rear = baserear;
global.baseSanity = basesanity;



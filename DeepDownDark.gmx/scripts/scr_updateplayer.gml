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
    }
    









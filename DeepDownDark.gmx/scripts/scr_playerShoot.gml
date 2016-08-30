

    // shoot counter limits fire rate
    if shoot_counter <= 0
    {
            

        if turret == false
            {        
                bulletangle = image_angle;
                bulletx = x + lengthdir_x(shipscale, image_angle);
                bullety = y + lengthdir_y(shipscale, image_angle);
            }
        if turret == true
            { 
                bulletangle = obj_sharkturret.image_angle;
                bulletx = obj_sharkturret.x + lengthdir_x(32, obj_sharkturret.image_angle);;
                bullety = obj_sharkturret.y + lengthdir_y(32, obj_sharkturret.image_angle);
            }        
        if obj_player.bulletfire == 1
            {
                var inst;
                inst = instance_create(bulletx, bullety, obj_bullet);        
                with (inst)
                {
                    image_angle = obj_player.bulletangle;
                    destx = other.bulletaimx;
                    desty = other.bulletaimy;
             
                }
            }
        if obj_player.bulletfire == 2       //double fire- spawn two bullets offset from centre axis slightly (len below)
            {
                offsetx1 = 0 + lengthdir_x(4, bulletangle + 90);
                offsety1 = 0 + lengthdir_y(4, bulletangle + 90);
                offsetx2 = 0 + lengthdir_x(4, bulletangle - 90);
                offsety2 = 0 + lengthdir_y(4, bulletangle - 90);            
                var inst;
                inst = instance_create(bulletx + offsetx1, bullety + offsety1, obj_bullet);        
                with (inst)
                {
                    image_angle = obj_player.bulletangle;
                    destx = other.bulletaimx + other.offsetx1;
                    desty = other.bulletaimy + other.offsety1;             
                }            
                var inst;
                inst = instance_create(bulletx + offsetx2, bullety + offsety2, obj_bullet);        
                with (inst)
                {
                    image_angle = obj_player.bulletangle;
                    destx = other.bulletaimx + other.offsetx2;
                    desty = other.bulletaimy + other.offsety2;             
                }             
            
            
            }            
        shoot_counter = shoot_rate;
    
    }

    else
    {    
        shoot_counter -= 1;
    } 

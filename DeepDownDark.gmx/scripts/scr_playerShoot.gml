

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
        var inst;
        inst = instance_create(bulletx, bullety, obj_bullet);        
        with (inst)
        {
            image_angle = obj_player.bulletangle;
            destx = other.bulletaimx;
            desty = other.bulletaimy;
     
        }
        
        shoot_counter = shoot_rate;
    
    }

    else
    {    
        shoot_counter -= 1;
    } 

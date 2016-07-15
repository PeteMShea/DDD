

    // shoot counter limits fire rate
    if shoot_counter <= 0
    {

        var inst;
        inst = instance_create(x, y, obj_bullet);
        with (inst)
        {
            image_angle = obj_player.image_angle;
            destx = other.aimx;
            desty = other.aimy;
     
        }
        
        shoot_counter = shoot_rate;
    
    }

    else
    {    
        shoot_counter -= 1;
    } 

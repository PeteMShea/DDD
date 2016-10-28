if landing == 1     
 //left leg planted, swing right foot down
    {
        while (collision_circle(x + lengthdir_x(34 * global.RM, image_angle + 220), y + lengthdir_y(34 * global.RM, image_angle + 220), 4 * global.RM, obj_block, false, true) == noone)
            {
                //instance_create(x + lengthdir_x(36 * global.RM, image_angle + 220), y + lengthdir_y(36 * global.RM, image_angle + 220), obj_debug); 
                fx = x + lengthdir_x(34 * global.RM, image_angle + 145)     //position of the ship's foot right now
                fy = y + lengthdir_y(34 * global.RM, image_angle + 145)
                             
                image_angle -=1;
                nx = x + lengthdir_x(34 * global.RM, image_angle + 145)     //position of the ship's foot after rotation
                ny = y + lengthdir_y(34 * global.RM, image_angle + 145)
                x -= (nx-fx);
                y -= (ny-fy);
            }
        landing = 3;
        
    }

if landing == 2      //right leg planted, swing left foot down
    {
        while (collision_circle(x + lengthdir_x(34 * global.RM, image_angle + 145), y + lengthdir_y(34 * global.RM, image_angle + 145), 4 * global.RM, obj_block, false, true) == noone)
            {
                fx = x + lengthdir_x(34 * global.RM, image_angle + 220)     //position of the ship's foot right now
                fy = y + lengthdir_y(34 * global.RM, image_angle + 220)
                //instance_create(fx, fy, obj_debug);               
                image_angle +=1;
                nx = x + lengthdir_x(34 * global.RM, image_angle + 220)     //position of the ship's foot after rotation
                ny = y + lengthdir_y(34 * global.RM, image_angle + 220)
                x -= (nx-fx);
                y -= (ny-fy) 
            }
        landing = 3;            
    }


if landing == 3
    {
        landing = 3      //eagle has landed
        landingthrust = false;
        speed_x = 0;
        speed_y = 0;
        hudx = view_xview[0];
        hudy = view_yview[0];
        instance_create(hudx, hudy, obj_PauseLanded);
        show_debug_message("the eagle has landed");
        dest_x = x + lengthdir_x(64, image_angle);
        dest_y = y + lengthdir_y(64, image_angle);
        vx = (dest_x - x);
        vy = (dest_y - y);
        len = sqrt(vx * vx + vy * vy);   
        vx = vx / len;
        vy = vy / len;
        auto_x = vx;
        auto_y = vy;
        autothrust = 10.0;
        //show_debug_message("auto_x: " + string(auto_x) + " , " + "auto_y: " + string(auto_y));
          
    }  

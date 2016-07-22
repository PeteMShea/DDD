if landing == 1     
 //left leg planted, swing right foot down
    {
        while (collision_circle(x + lengthdir_x(30 * global.RM, image_angle + 225), y + lengthdir_y(30 * global.RM, image_angle + 225), 4 * global.RM, obj_block, false, true) == noone)
            {
                fx = x + lengthdir_x(32 * global.RM, image_angle + 135)     //position of the ship's foot right now
                fy = y + lengthdir_y(32 * global.RM, image_angle + 135)              
                image_angle -=1;
                nx = x + lengthdir_x(32 * global.RM, image_angle + 135)     //position of the ship's foot after rotation
                ny = y + lengthdir_y(32 * global.RM, image_angle + 135)
                x -= (nx-fx);
                y -= (ny-fy);
            }
        landing = 3;
        
    }

if landing == 2      //right leg planted, swing left foot down
    {
        while (collision_circle(x + lengthdir_x(30 * global.RM, image_angle + 135), y + lengthdir_y(30 * global.RM, image_angle + 135), 4 * global.RM, obj_block, false, true) == noone)
            {
                fx = x + lengthdir_x(32 * global.RM, image_angle + 225)     //position of the ship's foot right now
                fy = y + lengthdir_y(32 * global.RM, image_angle + 225)              
                image_angle +=1;
                nx = x + lengthdir_x(32 * global.RM, image_angle + 225)     //position of the ship's foot after rotation
                ny = y + lengthdir_y(32 * global.RM, image_angle + 225)
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

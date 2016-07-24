
                           
thrustcounter = 20; //minimum number of frames thrust is applied before deceleration starts

max_thrust = max_backthrust; 
               
// Calculate normalised vectors for moving player to dest
destx =  x - lengthdir_x(16 * global.RM, image_angle);
desty =  y - lengthdir_y(16 * global.RM, image_angle);
                
        
                
// increase thrust over duration of button held
thrust *= thrustacc;
thrust = clamp(thrust, min_thrust, max_thrust);
                
joystickused = 0;

if thrustparticles == true effect_create_below(ef_spark, x + lengthdir_x(16 * global.RM, thrustdir), y + lengthdir_y(16 * global.RM, thrustdir), 0.1, thrustcolour);
if trails == true && backthrust == false
    {
        backthrust = true;
        inst = instance_create(x , y , obj_sharkBThrust);
        with (inst)
            {
                image_angle = obj_player.image_angle;
            }
    } 

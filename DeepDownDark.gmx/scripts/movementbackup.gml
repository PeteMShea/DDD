if global.pause == false 
{


// Movement
if autopilot <= 0
        {
         // joystick input   
            joyx = gamepad_axis_value(0, gp_axisrh);
            joyy = gamepad_axis_value(0, gp_axisrv);
            
            //show_debug_message("X: " + string(joyx) + "Y:" + string(joyy));
            //show_debug_message("X: " + string(joyleftx) + " Y:" + string(joylefty));
        
                
        // mouse input calculate direction and apply accelerating thrust    
        if mouse_check_button(mb_left)
            {
            
                thrustcounter = 20; //minimum number of frames thrust is applied before deceleration starts
                
                // Calculate normalised vectors for moving player to dest
                destx = mouse_x;
                desty = mouse_y;
                
        
                
                // increase thrust over duration of button held
                thrust *= thrustacc;
                thrust = clamp(thrust, min_thrust, max_thrust);
                
                joystickused = 0;
              
                if thrustparticles == true effect_create_below(ef_spark, x + lengthdir_x(16, thrustdir), y + lengthdir_y(16, thrustdir), 0.1, thrustcolour);
                if trails == true
                {
                    inst = instance_create(x , y , obj_sharkthrust);
                    with (inst)
                    {
                        image_angle = other.image_angle;
                    }
                } 
        
            }
        else
        {
            thrustdir = image_angle;
        }


if joyx != 0 || joyy != 0
    {
        thrustcounter = 20; //minimum number of frames thrust is applied before deceleration starts
        jx = -joyx
        jy = -joyy
        thrustdir = point_direction(0, 0, jx, jy);
        
        if thrustparticles == true effect_create_below(ef_spark, x + lengthdir_x(16, thrustdir), y + lengthdir_y(16, thrustdir), 0.1, thrustcolour);
        if trails = true
        {
            inst = instance_create(x , y , obj_sharkthrust);
            with (inst)
            {
                image_angle = other.image_angle;
            }
        }    
    }   

}  

if autopilot > 0
{
        autopilot -= 1;
        
        thrustcounter = autothrust; //minimum number of frames thrust is applied before deceleration starts
                        
        // Calculate normalised vectors for moving player to dest
        speed_x = auto_x;
        speed_y = auto_y;
                        
             
        //show_debug_message ("destx: " + string(destx) + ", auto_x: " + string(auto_x) + "desty: " + string(desty) + ", auto_y: " + string(auto_y));   
                        
                        
        joystickused = 0;
                      
        if thrustparticles == true effect_create_below(ef_spark, x + lengthdir_x(16, thrustdir), y + lengthdir_y(16, thrustdir), 0.1, thrustcolour);
        if trails == true
            {
                inst = instance_create(x , y , obj_sharkthrust);
                with (inst)
                {
                    image_angle = other.image_angle;
                }
            } 

}

    
// thrust control
if thrustcounter >= 0 && autopilot <=0
    {
        
        // reset deceleration to base value 
        deceleration = inertia; 
        
        vx = (destx - x);
        vy = (desty - y);
    
        len = sqrt(vx * vx + vy * vy);
    
        vx = vx / len;
        vy = vy / len;
        
        
        // Multiply normalised vector by ship thrust
    if joyx != 0 || joyy != 0
        {
            thrust_x = -joyx * thrust;
            thrust_y = -joyy * thrust;
        }
    
    else
        {        
            thrust_x = vx * thrust;
            thrust_y = vy * thrust;
        }       
         
        // Add thrust from player input to player's current speed 
        speed_x += thrust_x;
        speed_y += thrust_y;
        
        speed_x = clamp(speed_x, -max_speed, max_speed);
        speed_y = clamp(speed_y, -max_speed, max_speed);
        
        thrustcounter -= 1;
        
        thrustdir = point_direction(x, y, x - thrust_x, y - thrust_y); 
        
        image_index = 1; 

    }

    
        
    // when minimum number of thrust time has passed begin decelerating  
    if thrustcounter <= 0
    {

                //reset thrust
            thrust = min_thrust;
        
        // reduce speed by deceleration amount each frame
        speed_x -= (speed_x * deceleration/1000);
        speed_y -= (speed_y * deceleration/1000);
        
        //reduce deceleration by decay amount each frame (clamped to 0)
        deceleration -= decay;
        deceleration = clamp(deceleration, 0, inertia);
        
        image_index = 0; 
     
    } 
   

//  collision detection
//if place_meeting(x- speed_x, y - speed_y, obj_block)
if collision_circle(x- speed_x, y - speed_y, shipscale, obj_block, false, true) || collision_circle(x- speed_x, y - speed_y, shipscale, obj_asteroid, true, true)
{

    if collision_circle(x- speed_x, y - speed_y, shipscale, obj_asteroid, true, true)

        {
        var inst;
        //instance_create(x - speed_x + lengthdir_x(32, thrustdir), y - speed_y + lengthdir_y(32, thrustdir), obj_debug);
    
            
        inst = instance_nearest(x - speed_x, y - speed_y, obj_asteroid);
        if inst != noone
            {
                ax = (inst).x;
                ay = (inst).y;
                avector = point_direction(ax, ay, x, y);
                loc_x = ax + lengthdir_x(16, avector);
                loc_y = ay + lengthdir_y(16, avector);
                extended_x = x + lengthdir_x(32, thrustdir);
                extended_y = y + lengthdir_y(32, thrustdir); 
                with(inst)
                {    
                    //show_debug_message(string(inst));
                    hit_x = other.x;
                    hit_y = other.y;
                    ext_x = other.extended_x;
                    ext_y = other.extended_y;
                    hitspeed_x = other.speed_x;
                    hitspeed_y = other.speed_y;
                    asteroidhit = 1;        // 1 = hit by player
                }
            }
        }
    else
    // if hit something other than asteroid- calculate collision point loc_x, loc_y based upon thrustdir
        {
            l_angle = point_direction(x, y, x - speed_x, y - speed_y);
            loc_x = x + lengthdir_x(shipscale, l_angle);
            loc_y = y + lengthdir_y(shipscale, l_angle);
        
        }    

    
    //show_debug_message(string(global.playerspeedX) + " , " + string(global.playerspeedY));

    bounce_y = speed_y * bouncemult;
    bounce_x = speed_x * bouncemult;
    
    speed_x = -bounce_x;
    speed_y = -bounce_y;
 
    //trigger damage unless in cooldown time   
    if hitcollide <= 0
        {    
            hitcollide = damagecooldown * 60;  
        }
    
        
             
} 

// Player has collided with bad thing
if hitcollide >= (damagecooldown * 60)
    {
        damagespeed = sqrt(speed_x * speed_x + speed_y * speed_y);
        damage = (damagespeed * damagemult * armour)
        global.playerHealth -= damage ;
        
        script_execute(scr_shipvisualdamage, x, y, loc_x, loc_y, damage);
        
          hitcollide -= 1;
        global.playerdamaged = 20;
     }
else
    {
        hitcollide -= 1;

    }     
  
  
// Apply movement to player- inverted thrust so subtracted
    x -= speed_x
    y -= speed_y


// rotation 
var facingMinusTarget = image_angle - thrustdir;
var angleDiff = facingMinusTarget;

if(abs(facingMinusTarget) > 180)
    {
        if(image_angle > thrustdir)
        {
            angleDiff = -1 * ((360 - image_angle) + thrustdir);
        }
        else
        {
            angleDiff = (360 - thrustdir) + image_angle;
        }
    }

var leastAccurateAim = 2;
if(angleDiff > 0)
    {
        image_angle -= turnSpeed;
    }
else if(angleDiff < 0)
    {
        image_angle += turnSpeed;
    }
        
// Firing
if mouse_check_button(mb_right) || gamepad_button_check(0, gp_shoulderrb)

{
    if turret == true
        {
            aimx = mouse_x;
            aimy = mouse_y;
        }
    else
        {
            aimx = x - lengthdir_x(100, image_angle);
            aimy = y - lengthdir_y(100, image_angle);
        }
    script_execute(scr_playerShoot, aimx, aimy, shoot_counter);   
}    


// add trails

if trails == true
{
    inst = instance_create(x , y , obj_redtrail);
    with (inst)
        {
            image_angle = other.image_angle;
        }
}    
    
    
    
// Apply animation to ship if in damage state

if global.playerdamaged >0 
    {
            //image_index = 1; 
            global.playerdamaged -= 1;
         
    }
else
    {
            //image_index = 0; 
    }


// check if player has reached exit

if y >= 384 * 8 + 120
{

vx = view_xport[0];
vy = view_yport[0];
instance_create( vx, vy, eff_fadetoblack );



}









}




//show_debug_message ("thrustdir: " + string(thrustdir));


    
 //    show_debug_message("Speed: " + string(speed_x) + " , " + string(speed_y) + "Thrust:" + string(thrust) + "Deceleration:" + string(deceleration))
 
 
 











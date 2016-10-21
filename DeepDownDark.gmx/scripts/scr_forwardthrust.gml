
                           
thrustcounter = 20; //minimum number of frames thrust is applied before deceleration starts

max_thrust = max_forwardthrust;
                
destx =  x + lengthdir_x(16 * global.RM, turn_angle);
desty =  y + lengthdir_y(16 * global.RM, turn_angle);                
        
                
// increase thrust over duration of button held
thrust *= thrustacc;
thrust = clamp(thrust, min_thrust, max_thrust);
                
joystickused = 0;

if thrustparticles == true effect_create_below(ef_spark, x + lengthdir_x(16, thrustdir), y + lengthdir_y(16, thrustdir), 0.1, thrustcolour);
if trails == true
    {
        inst = instance_create(x , y , obj_sharkthrust_trail);
        with (inst)
            {
                image_angle = obj_player.image_angle;
            }
    }

if playthrustsound == false
                            {
                                //show_debug_message("THRUST!");
                                playthrustsound = true;                                                                
                                if!audio_is_playing(snd_SharkEngine) audio_play_sound(snd_SharkEngine, 100, true);                                
                                audio_sound_gain(snd_SharkEngine, 0.5, 0);
                            }    

// explosion first

if deathstart == false
    {
        obj_HUD.hidden = true;
        instance_create(px, py, obj_explosion128);
        alarm[0] = 10;
        deathstart = true;
        rings = 4;
        inst = instance_create(px, py, obj_blackbox);
        with(inst)
        {
            image_xscale = 0.5;
            image_yscale = 0.5;
            depth = 3;
            rotspeed = random_range(-3, 3);
            speed_x = random_range(-0.5, 0.5);
            speed_y = random_range(-0.5, 0.5);
        }
    }

if deathstart == true
    {
        //now throw out a load of debris in rings
        debrisspeed = 1.0;
          
        if alarm[0] <= 0
            {
                if rings > 0
                    {  
                        rings -= 1;
                        debrisangle = 0;
                        for(i=0; i<36; i+=1)
                            {
                                //if alarm[0] <= 0 
                                   // {                    
                                        debrisangle += random_range(-5,5);
                                        debrisspeed = random_range(debrisspeed *0.4, debrisspeed *0.5);    
                                        dx = px + lengthdir_x(16 * global.RM, debrisangle);
                                        dy = py + lengthdir_y(16 * global.RM, debrisangle);        
                                        inst = instance_create(dx, dy, obj_shipdebris)
                                        with(inst)
                                            {
                                                direction = other.debrisangle;
                                                speed = other.debrisspeed;       
                                            }
                                        debrisangle +=10;
                                        alarm[0] = 10.0; 
                                    }
                                //debrisspeed -= 0.25
                    }     
            }
    
    }

startfade -= 1;

if startfade <=0 && global.dead == false
    {    
        global.dead = true;
        deathdone = false;        
    }    
    
    
if global.dead == true
{
    deathdone = true;
    if !instance_exists(eff_fadetoblack)
    {
        inst = instance_create(px,py, eff_fadetoblack)      //eff_fadetoblack
        with(inst)
            {
                fadeSpeed = 0.5;
                fadeAlpha = 0;
                finalAlpha = 0.9;
                fadeDone = false;
                fadeOut = 30;        
            }
    }
    if !instance_exists(obj_deathmenu) instance_create(x,y, obj_deathmenu);
    showmenu = true;
}

//return(deathdone)



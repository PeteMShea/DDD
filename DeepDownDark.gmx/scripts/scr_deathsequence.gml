// explosion first

if deathstart == false
    {
        instance_create(px, py, obj_explosion128);
        alarm[0] = 10;
        deathstart = true;
        rings = 5;
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
                        for(i=0; i<12; i+=1)
                            {
                                //if alarm[0] <= 0 
                                   // {                    
                                        debrisangle += random_range(-10,10);
                                        debrisspeed = random_range(debrisspeed *0.4, debrisspeed *0.5);    
                                        dx = px + lengthdir_x(16, debrisangle);
                                        dy = py + lengthdir_x(16, debrisangle);        
                                        inst = instance_create(dx, dy, obj_shipdebris)
                                        with(inst)
                                            {
                                                direction = other.debrisangle;
                                                speed = other.debrisspeed;       
                                            }
                                        debrisangle +=30;
                                        alarm[0] = 10.0; 
                                    }
                                //debrisspeed -= 0.25
                    }     
            }
    
    }

startfade -= 1;

if startfade <=0 
    {    
        global.dead = true;        
    }    
    
    
if global.dead == true
{
    inst = instance_create(px,py, eff_fadetoblack)      //eff_fadetoblack
    with(inst)
        {
            fadeSpeed = 0.5;
            fadeAlpha = 0;
            finalAlpha = 0.8;
            fadeDone = false;
            fadeOut = 30;        
        }
    instance_create(x,y, obj_deathmenu);
    showmenu = true;
}



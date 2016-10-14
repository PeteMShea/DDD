// create  floatblocks

if nugget == false
{
bx -= 8 * global.RM
by -= 10 * global.RM
}


var ix;
for (ix = 0; ix < 4; ix +=1)
    { 
    var i;
    for (i = 0; i < 5; i += 1)
        {
            if nugget == false
            {
                instance_create (bx, by, obj_asteroidblock);
                script_execute(scr_blockburstvfx, bx, by);
            }
            
            if gold > 0
                {
                    inst = instance_create (bx, by, obj_goldpickup);
                    with(inst)
                        {
                            direction = random_range(0,360);
                            speed = 0.2;
                        }                    
                    gold -=1;
                }
            if nugget == true
                {
                    inst = instance_create (bx-4, by-4, obj_goldpickup);
                    with(inst)
                        {
                            direction = random_range(0,360);
                            speed = 0.2;
                        }
                    instance_create (bx+4, by+4, obj_goldpickup);
                    with(inst)
                        {
                            direction = random_range(0,360);
                            speed = 0.2;
                        }                                      
                    gold -=1;                
                }
           if nugget == false bx += 4
        }
        if nugget == false bx -= 16 * global.RM
        if nugget == false by += 4 * global.RM
    }

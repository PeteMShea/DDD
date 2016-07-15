// create  floatblocks
bx -= 8
by -= 10


var ix;
for (ix = 0; ix < 4; ix +=1)
    { 
    var i;
    for (i = 0; i < 4; i += 1)
        {
            instance_create (bx, by, obj_asteroidblock);
            script_execute(scr_blockburstvfx, bx, by);

            
            if gold > 0
                {
                    instance_create (bx, by, obj_goldpickup);
                    gold -=1;
                }
            bx += 4
        }
        bx -= 16
        by += 4
    }

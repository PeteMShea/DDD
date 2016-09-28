// create mouth debris


var ix;
for (ix = 0; ix < 2; ix +=1)
    { 
    var i;
    for (i = 0; i < 2; i += 1)
        {
            instance_create (bx, by, obj_grabberdebris);

            //script_execute(scr_particleburst, bx, by);
        }

    }

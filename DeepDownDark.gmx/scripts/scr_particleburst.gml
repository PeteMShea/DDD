// create a small cloud of inert cheap particles

for (ix = 0; ix < 2; ix +=1)
    { 
    var i;
    for (i = 0; i < 3; i += 1)
        {
            inst = instance_create (bx, by, obj_particle);
            with(inst)
            {
                image_blend = other.colour;
            }
            bx += 1

        }
        bx = x
        by += 1
    }

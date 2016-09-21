// create random bits of debrid
r = irandom_range(1,2)
p = irandom_range(1,2)

loc_x = bx
loc_y = by

for (ix = 0; ix < r; ix +=1)
    { 
    var i;
    for (i = 0; i < p; i += 1)
        {
            instance_create (bx, by, obj_WreckDebris);
            bx += 1

        }
        bx = loc_x
        by += 1
    }

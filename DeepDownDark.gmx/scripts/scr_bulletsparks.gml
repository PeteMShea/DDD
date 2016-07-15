// create bulletsparks

var ix;
for (ix = 0; ix < irandom_range(1,3); ix +=1)
    { 
    var i;
    for (i = 0; i < irandom_range(1,3); i += 1)
        {
            instance_create (bx, by, obj_bulletspark);
        }

    }

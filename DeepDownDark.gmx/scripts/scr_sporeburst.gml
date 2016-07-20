// create spines and debris

spawnangle = random_range(-10, 10);

for (i = 0; i< irandom_range(5, 10); i+=1)
{
    inst = instance_create(bx, by, obj_sporespine);
    with(inst)
        {
            angle = other.spawnangle;
        }
    spawnangle += random_range(35, 50);
}

//now debris
bx -= 8
by -= 10

var ix;
for (ix = 0; ix < 2; ix +=1)
    { 
    var i;
    for (i = 0; i < 2; i += 1)
        {
            instance_create (bx, by, obj_sporedebris);
            script_execute(scr_blockburstvfx, bx, by);
            bx += 4
        }
        bx -= 16
        by += 4
    }

// Collision detection and resolution
var inst;
inst = instance_place(x, y, obj_blastblock);
if inst != noone
    {
        //create debris tinyblocks
        bx = x
        by = y

        var ix;
        script_execute(scr_blockburstvfx, bx, by);
        //destroy instance of block hit
        with (inst) instance_destroy();
        
        //destroy the bullet
        instance_destroy();
    }
    
var gold;
gold = instance_place(x, y, obj_gold);
if gold != noone
    {
        instance_create(x, y, obj_goldpickup);
        speed_x = hspeed * 0.75
        speed_y = vspeed * 0.75
        with (gold) instance_destroy();
        
        //destroy the bullet
        instance_destroy();
    }


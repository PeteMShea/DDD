//spawn rocks and destroy weeblocks

//first find all blastblocks within range and remove hitpoints from them

radius = 36;

num = instance_number(obj_blastblock);

for (var i = 0; i < num; i++ )
    {
        list[i] = instance_find(obj_blastblock, i)
        test = list[i]
        if test != noone
        {
        if point_distance(locx, locy, list[i].x + 4, list[i].y + 4) <= radius
            {
                //create debris tinyblocks
                bx = list[i].x
                by = list[i].y
                colour = c_black;
                script_execute(scr_particleburst, bx, by, colour);
                with (list[i])
                    {
                        if hitpoints > 0
                            {
                                sprite_index = alt_sprite;
                                image_index = irandom_range(0,5);
                                hitpoints -= 3;     // random_range(1.5, 2.5);
                            }
                        if hitpoints <= 0
                            {
                                instance_destroy();
                            }
                    }            
            }
       }        
    }

// next spawn grabber blocks
for (i = 0; i <= irandom_range(7, 11); i += 1)
{
    instance_create(locx + irandom_range(-8, 8), locy + irandom_range(-8, 8), obj_grabberblock);
    
}




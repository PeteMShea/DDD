// generic LOS check between two points


vx = (lineendx - linestartx);
vy = (lineendy - linestarty);
            
len = sqrt(vx * vx + vy * vy);
                    
vx = vx / len;
vy = vy / len; 



for (count = 0; count < linedistance; count +=2)
{
    if hit == 0
        {
            test = collision_point(linestartx + vx*count, linestarty + vy*count, obj_block, false, true);
            if debug == true instance_create(linestartx + vx*count, linestarty + vy*count, debug_spot);
            if test != noone hit = count else hit = 0        
        } 
}

return (hit);



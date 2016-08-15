// generic LOS check between two points looking just for the player


vx = (lineendx - linestartx);
vy = (lineendy - linestarty);
            
len = sqrt(vx * vx + vy * vy);
                    
vx = vx / len;
vy = vy / len; 



for (count = 0; count < linedistance; count += 4)           //number here determines spacing between points in ray test- higher, faster but less precise
{
    if hit == 0
        {
            test = collision_point(linestartx + vx*count, linestarty + vy*count, obj_asteroid, false, true);
            //if debug == true instance_create(linestartx + vx*count, linestarty + vy*count, debug_spot);
            if test != noone hit = count else hit = 0        
        } 
}

return (hit);



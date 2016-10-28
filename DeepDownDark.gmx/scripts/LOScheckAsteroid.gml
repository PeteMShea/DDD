// generic LOS check between two points looking just for the player


vx = (lineendx - linestartx);
vy = (lineendy - linestarty);
            
if vx != 0 || vy != 0 len = sqrt(vx * vx + vy * vy) else len = 0;

if len != 0
{                    
vx = vx / len;
vy = vy / len; 
}



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



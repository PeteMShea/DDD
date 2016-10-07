                // set up an array for weeblock types
        var i;
         i = 35;
         repeat(36)
            {
                weeblocktype[i] = 0;
                i -= 1;
            }
        
        weeblocktype[0] = "empty";
        weeblocktype[1] = obj_weeblock;
        weeblocktype[2] = obj_blastblock;
        weeblocktype[3] = obj_gold;
        weeblocktype[4] = obj_weeblockendNcap;
        weeblocktype[5] = obj_weeblockendScap;
        weeblocktype[6] = obj_weeblockendWcap;
        weeblocktype[7] = obj_weeblockendEcap;
        weeblocktype[8] = obj_vine;
        weeblocktype[9] = obj_vineNcap;
        weeblocktype[10] = obj_vineScap;
        weeblocktype[11] = obj_vineWcap;
        weeblocktype[12] = obj_vineEcap;
        weeblocktype[13] = obj_weeblock_N;
        weeblocktype[14] = obj_blastblock_N;
        weeblocktype[15] = obj_weeblock_NE;
        weeblocktype[16] = obj_weeblock_NW;
        weeblocktype[17] = obj_weeblock_S;
        weeblocktype[18] = obj_blastblock_S;
        weeblocktype[19] = obj_weeblock_SE;
        weeblocktype[20] = obj_weeblock_SW;        
        weeblocktype[21] = obj_weeblock_E;        
        weeblocktype[22] = obj_weeblock_W;
        weeblocktype[23] = obj_blastblock_E;                       
        weeblocktype[24] = obj_blastblock_W;
        weeblocktype[25] = obj_vineNBase;                 
        weeblocktype[26] = obj_vineSBase;   
        weeblocktype[27] = obj_vineEBase;   
        weeblocktype[28] = obj_vineWBase;                           
        weeblocktype[29] = obj_goldNBase;   
        weeblocktype[30] = obj_goldSBase;  
        weeblocktype[31] = obj_goldEBase;                  
        weeblocktype[32] = obj_goldWBase;          
        weeblocktype[33] = obj_goldNCap;          
        weeblocktype[34] = obj_goldSCap; 
        weeblocktype[35] = obj_goldECap;         
        weeblocktype[36] = obj_goldWCap;         
                
                
// Initialise 8 x 8 Array- all set to 0 (place block)

ax = 0;
ay = 0;
 
for (i = 0; i < gridsize; i +=1)
    {
     repeat(gridsize)
        {
        bigblock[ax, ay] = 0;
        walkblock[ax, ay] = 0;
        //show_debug_message(string(ax) + " , " + string(ay));
        ax += 1;
         }
    ax = 0;        
    ay += 1;          
    }

    
    
// Iterate through first two rows of the Array deciding whether to remove a block or not

for (u = 0; u < gridsize; u +=1)
    {
        for (v = 0; v < 2; v +=1)
        {
            spacechance = basechance;
            newbigblockvalue = 0;
            randroll = random(1);
 
            // these variables are used to check the adjacent bigblock squares- w, e, n, s
            uw = 0;
            ue = 0;
            vn = 0;
            vs = 0;           
            if u >0 uw = 1
            if u <gridsize-1 ue = 1
            if v >0 vn = 1
            if v <gridsize-1 vs = 1            
 
            // adjust spacechance based on adjacent bigblock values
            
            if bigblock [u-uw, v] == 1 || bigblock [u+ue, v] == 1 || bigblock [u, v-vn] == 1 || bigblock [u, v+vs] == 1
                {
                    spacechance += 0.1;
                    newbigblockvalue =  1;

                }

            if bigblock [u-uw, v] == 2 || bigblock [u+ue, v] == 2 || bigblock [u, v-vn] == 2 || bigblock [u, v+vs] == 2
                {
                    spacechance += 0.2;
                    newbigblockvalue = 2;
                }
                                       
            if bigblock [u-uw, v] == 3 || bigblock [u+ue, v] == 3 || bigblock [u, v-vn] == 3 || bigblock [u, v+vs] == 3
                {
                    spacechance += 0.2;
                    newbigblockvalue = 3;
                } 
                           
            if randroll < spacechance
            
                {
                    bigblock[u , v] = 1 + newbigblockvalue;
              
                }
             //show_debug_message(string(u) + " , " + string(v) + " spacechance:" + string(spacechance) + " bigblock value:" + string (bigblock[u, v]));     
        }
    }
 





// define bottom row to exit
for (i = 0; i<8; i+=1)
{
    bigblock [i, 3] = 1;
}
bigblock [7, 2] = 1;        //one extra block leading to bottom row
bigblock [3, 3] = 1;        //chamber where formless is
bigblock [4, 3] = 1;
bigblock [5, 3] = 1;




       
// Set up a predefined start position free from blocks

starthuge = 0;
endhuge = 0;

bigblock [starthuge, 0] = 5         // 5 is array value for empty but visited
bigblock [7, 2] = 1

// now we walk through the grid from starthuge to endhuge 
walk_x = starthuge;
walk_y = 0;
exit_x = 7;
exit_y = 2;
dir_x = 0;      //this is the direction to go in -ve is left, +ve right, 0 other axis- one of dir_x and dir_y should always be 0
dir_y = 0;
dif_x = 0;
dif_y = 0;
walkloop = 0;
downlast = false;

show_debug_message("walk x: " + string(walk_x) + " ,walk y: " + string(walk_y) + " ,exit_x: " + string(exit_x) +  " ,exit_y: " + string(exit_y));


while (walkloop <= 64)          //this is just a debug safety check- walkloop is set to 65 when exit square is reached
{
    
    walkloop += 1;
    
    dif_x = abs(exit_x - walk_x);        //absolute value (always +ve) of difference between pos and goal
    dif_y = abs(exit_y - walk_y);
    
    // first calculate the optimal direction to travel in- choose the longest direction
    if dif_x > dif_y
        {
            dir_x = sign(exit_x - walk_x);
            dir_y = 0; 
        }
    else
        {
            dir_y = sign(exit_y - walk_y);
            dir_x = 0;     
        }
       
    innerloop = false
        
    while (innerloop == false)
        {    
            
        // next check if the desired square is free and if so, walk there
        if bigblock[walk_x + dir_x, walk_y + dir_y] == 1  
            {   
                walk_x += dir_x;
                walk_y += dir_y;
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                totalwalkblocks += 1;
                walkblock[walk_x, walk_y] = totalwalkblocks;
                //show_debug_message("into clear space");
            }

        if walk_y + 1 < 2 && bigblock[walk_x, walk_y + 1] != 5  && innerloop != true && downlast == false    //move down
            {
                walk_y += 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                totalwalkblocks += 1;
                walkblock[walk_x, walk_y] = totalwalkblocks;                
                //show_debug_message("headed down");
                downlast = true;            
            } 
        
        if walk_x + 1 < gridsize && bigblock[walk_x + 1, walk_y] != 5 && innerloop != true    //move right
            {
                walk_x += 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                totalwalkblocks += 1;
                walkblock[walk_x, walk_y] = totalwalkblocks;                
                //show_debug_message("headed right");        
            }
        if walk_x - 1 > 0 && bigblock[walk_x - 1 , walk_y] != 5  && innerloop != true    //move left
            {
                walk_x -= 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                totalwalkblocks += 1;
                walkblock[walk_x, walk_y] = totalwalkblocks;                
                //show_debug_message("headed left");              
            }

                     
        //show_debug_message("walk x: " + string(walk_x) + " ,walk y: " + string(walk_y) + " ,dir_x: " + string(dir_x) +  " ,dir_y: " + string(dir_y));
    
        if walk_x == exit_x && walk_y >= exit_y 
            {
                walkloop = 65;        //have we reached the destination- if so stop both while loops
                innerloop = true;
            }        
                
    }    
 
}

    
// Draw Huge Blocks in each Array Space (if 0)

for (u = 0; u < gridsize; u +=1)
    {
        for (v = 0; v < 4; v +=1)
        {
    
            if bigblock[u , v] == 0
                {
                    //show_debug_message("Big Block ref" + string(u) + " , " + string(v) + " , array: " + string(bigblock[u,v]) );   
                    script_execute(scr_genHugeBlocks, u, v, bigblock[u,v]);
                    
                    blockindex = (bigblock[u, v] * -1) - 1;
                    //tile_add(tileset_hugeblocks, leftx, topy, width, height, u * 384 * global.RM +64 * global.RM , v * 384 * global.RM +64 * global.RM, 10);                                                         
                   // show_debug_message("u: " + string(u) + " ,v: "+ string(v) + " ,blockindex = " + string(blockindex));
                                                  
                    inst = instance_create( u * 384 * global.RM +64 * global.RM , v * 384 * global.RM +64 * global.RM , obj_hugeblock)
                    with (inst)
                        {
                            if random(1) < 0.5
                                {
                                    image_index = other.blockindex;
                                    
                                }
                            else
                                {
                                    image_index = 15;                                                                    
                                }
                        //show_debug_message("blockindex = " + string(other.blockindex));   
                        }
                   //instance_deactivate_object(inst);
                   //if random(1) < hugeblockoverlaychance instance_create(u * 384 * global.RM +64 * global.RM , v * 384 * global.RM +64 * global.RM , obj_hugeblockoverlay);
                                
                }
      
        }
    }

show_debug_message("Huge Blocks done, totalwalkblocks = " + string(totalwalkblocks));    

//Now iterate through each space big block & add normal blocks based upon adjacent big blocks
//show_debug_message("Block Array started");
// Build an array for the normal blocks
                    // Initialise 64 x 64 Block Array- (0 = no block)
  
                            bu = 0;
                            bv = 0;
                    
                            for (i = 0; i < 144; i +=1)
                                {
                                    repeat(144)
                                    {
                                        block[bu, bv] = 0;
                                        //show_debug_message(string(bu) + " , " + string(bv));
                                        bu += 1;
                                    }
                                    bu = 0;        
                                    bv += 1;          
                                }

//show_debug_message("Block Array done");                        
                            
for (u = 0; u < gridsize; u +=1)
    {
        for (v = 0; v < 3; v +=1)
        {
                //BALLPLANTS
                if walkblock[u, v] > 0 && walkblock[u, v] >= (totalwalkblocks * ballplantstartblock) && walkblock[u, v] <= (totalwalkblocks * ballplantendblock)    
                    {                        
                                                
                        ballplantdensity = ballplantdensitymin + (ballplantdensityrange * ((walkblock[u,v]- totalwalkblocks * ballplantstartblock)/(totalwalkblocks * ballplantendblock - totalwalkblocks * ballplantstartblock)))
                        if ballplantdensity > 0 show_debug_message("Adding ballplants at Walkblock: " + string(walkblock[u,v]) + " with chance: " + string(ballplantdensity));                        
                    }
                else ballplantdensity = 0;            

                //SPIKERS
                if walkblock[u, v] > 0 && walkblock[u, v] >= (totalwalkblocks * spikerstartblock) && walkblock[u, v] <= (totalwalkblocks * spikerendblock)    
                    {                        
                                                
                        spikerdensity = spikerdensitymin + (spikerdensityrange * ((walkblock[u,v]- totalwalkblocks * spikerstartblock)/(totalwalkblocks * spikerendblock - totalwalkblocks * spikerstartblock)))
                        if spikerdensity > 0 show_debug_message("Adding spikers at Walkblock: " + string(walkblock[u,v]) + " with chance: " + string(spikerdensity));                        
                    }
                else spikerdensity = 0;                             
            
            script_execute(scr_genBlocks, u, v, bigblock[u,v], gridsize, starthuge, endhuge, ballplantdensity, spikerdensity)


             
        }

    }

show_debug_message("New Blocks done");    

  
     
// Now iterate through each space big block and add wee blocks

for (v = 0; v < 4; v +=1)     

    {
        for (u = 0; u < gridsize; u +=1)
        {
            if bigblock[u, v] >= 0
            {
                //GAUNTS
                if random(1) < gauntchance && walkblock[u, v] > 0 && walkblock[u, v] >= (totalwalkblocks * gauntstartblock) && walkblock[u, v] <= (totalwalkblocks * gauntendblock)    
                    {                        
                                                
                        gauntdensity = gauntdensitymin + (gauntdensityrange * ((walkblock[u,v]- totalwalkblocks * gauntstartblock)/(totalwalkblocks * gauntendblock - totalwalkblocks * gauntstartblock)))
                        show_debug_message("Adding Gaunts at Walkblock: " + string(walkblock[u,v]) + " with density: " + string(gauntdensity));                        
                    }
                else gauntdensity = 0;
                
                //FUNGHI SPAWNS
                if random(1) < sporechance && walkblock[u, v] > 0 && walkblock[u, v] >= (totalwalkblocks * sporestartblock) && walkblock[u, v] <= (totalwalkblocks * sporeendblock) 
                    {
                        sporedensity = sporedensitymin + (sporedensityrange * ((walkblock[u,v]- totalwalkblocks * sporestartblock)/(totalwalkblocks * sporeendblock - totalwalkblocks * sporestartblock)))
                        show_debug_message("Adding Spores at Walkblock: " + string(walkblock[u,v]) + " with density: " + string(sporedensity));                        
                        sporeoffsetangle = startsporeoffsetangle;
                        sporeoffsetdistance = startsporeoffsetdistance;
                    }
                else sporedensity = 0;                
                //instance_create( 64 * global.RM  + (u * 384 * global.RM ), 64 * global.RM  + (v * 384 * global.RM ), obj_debug);
                script_execute(scr_testWeeblocks, u, v, gridsize, starthuge, endhuge, gauntdensity)
                currentblock +=1;
                //show_debug_message("Wee Block Done " + string(u) + " , " + string(v));
            }
             
        }

    }

    
//now rebuild array and go through all of the newblocks in lower half of map adding weeblocks

// Initialise 98 x 36 Block Array- (0 = no block)
xblocks = 98;
yblocks = 36 
bu = 0;
bv = 0;
for (i = 0; i < yblocks+1; i +=1)
    {
        repeat(xblocks+1)
            {
                block[bu, bv] = 0;
                //show_debug_message(string(bu) + " , " + string(bv));
                bu += 1;
            }
            bu = 0;        
            bv += 1;          
    }        
        
// now iterate through the array assigning big block values
bx = 0;
by = 0;
yoffset = 1664;

for (bx = 0; bx < xblocks; bx +=1)
    {
        for (by = 0; by < yblocks; by +=1)
        {
                inst = instance_position(bx * 64 + 8,yoffset + by * 64 + 8, obj_newblock);
                if inst != noone
                    {
                        block[bx,by] = 1;
                            
                    }
                if instance_position(bx * 64 + 8,yoffset + by * 64 + 8, obj_borderblock) != noone
                {                
                    block[bx,by] = 1;
                  
                }
                //show_debug_message("Block " + string(bx) + " , " + string(by) + " : " + string(block[bx,by]));                        
            }       
    }

      
            
show_debug_message("Lower half of map New Blocks assigned");

// iterate through all the blocks in lower half of map and calculate neigbour values for them
goldcount = 0;

bx = 1;
by = 1;

for (bx = 1; bx < xblocks; bx +=1)
    {
        for (by = 0; by < yblocks; by +=1)
        {

            if block[bx, by] == 0
            {
                //show_debug_message("Block " + string(bx) + " , " + string(by));
                //instance_create( bx * 64, by * 64, obj_debug);
                // found an empty square- now check for neighbours
                var n;
                var e;
                var s;
                var w;
                n = 0;
                e = 0;
                s = 0;
                w = 0;
                
                if bx > 0 && block[bx - 1, by] == 1 w = 1   else w = 0
                if bx < xblocks && block[bx + 1, by] == 1 e = 1   else e = 0            
                if by > 0 && block[bx, by - 1] == 1 n = 1   else n = 0 
                if by < xblocks && block[bx, by + 1] == 1 s = 1   else s = 0
                if by < 12 && bx < 86               //this is the third row of filled huge blocks- up to last column
                    {
                        n = 0;
                        e = 0;
                        s = 0;
                        w = 0;                                                            
                    }
        
        
        if w !=0 || e !=0 || n !=0 || s !=0                             // we have at least one external edge- so time to add blocks inside             
            {
              // first check adjacent squares and change the array value to represent neighbouring squares- empty squares with wee blocks use negative array values
                if n != 0 && e == 0 && s == 0 && w == 0 block [bx, by] = -1     // North only
                if n == 0 && e == 0 && s != 0 && w == 0 block [bx, by] = -2     // South only          
                if n == 0 && e != 0 && s == 0 && w == 0 block [bx, by] = -3     // East only                    
                if n == 0 && e == 0 && s == 0 && w != 0 block [bx, by] = -4     // West only                   
                if n != 0 && e == 0 && s != 0 && w == 0 block [bx, by] = -5     // North and South                    
                if n == 0 && e != 0 && s == 0 && w != 0 block [bx, by] = -6     // East and West                  
                if n != 0 && e == 0 && s == 0 && w != 0 block [bx, by] = -7     // North and West   
                if n != 0 && e != 0 && s == 0 && w == 0 block [bx, by] = -8     // North and East   
                if n == 0 && e == 0 && s != 0 && w != 0 block [bx, by] = -9     // South and West   
                if n == 0 && e != 0 && s != 0 && w == 0 block [bx, by] = -10     // South and East                   
                if n != 0 && e != 0 && s != 0 && w == 0 block [bx, by] = -11     // North, South and East                    
                if n != 0 && e != 0 && s == 0 && w != 0 block [bx, by] = -12     // North, East and West
                if n == 0 && e != 0 && s != 0 && w != 0 block [bx, by] = -13     // South, East and West
                if n != 0 && e == 0 && s != 0 && w != 0 block [bx, by] = -14     // North, South and West             
            
                if block [bx, by] < 0                             // we have at least one external edge- so time to add blocks inside             
                    {                
                        //instance_create( 64 + bx * 32, 64 + by * 32, obj_debug);
                        //show_debug_message("wee block space found- " + string(bx) + " , " + string(by) + "- n:" + string(n) + " e: " + string(e) + " s: " + string(s) + " w: " + string(w) + " , value:" + string(block[bx,by]));
                        
                        script_execute(scr_genWeeBlocksSingle, bx, by, block[bx,by], yoffset);
                
                    }
            }
        }

    }
}

    
    
show_debug_message("Lower half of map wee Blocks done");    


//Add light source for normal maps before adding asteroids

instance_create(0, 0, oLightSource);


//Now add asteroids- iterate through big blocks looking for emptys
if asteroidchance > 0
    {
        for (u = 0; u < gridsize; u +=1)
            {
                for (v = 0; v < 2; v +=1)
                {
            
                    if bigblock[u , v] > 0
                        {
                        script_execute(scr_addAsteroids, u, v)
                      
                        }
              
                }
            }
    }
    
show_debug_message("Asteroids done");        
    


// caculate start and exit points for the map- in centre of each huge empty square (plus border of 64)
global.startx = starthuge * 384 * global.RM  + 182 * global.RM  + 64 * global.RM ;
global.starty = 16 * global.RM ;     // 16 points down from top edge
global.exitx = endhuge * 384 * global.RM  + 182 * global.RM  + 64 * global.RM ;
global.exity = 4 * 384 * global.RM  + 128 * global.RM  - 32 * global.RM ;



global.startx -= 48;    //reposition ship in centre of start trench    
    


// add an exit trigger
instance_create(endhuge * 384 * global.RM  + 64 * global.RM  + 64 * global.RM , 5 * 384 * global.RM  + 64 * global.RM , obj_exittrigger);




                       
                         
                           

#define scr_genMap_B
// set up an array for block types
for(i = 0; i < 42; i+=1)
{
    blocktype[i] = 0;
}

        blocktype[0] = obj_debug;     //0 reserved for empty squares
        blocktype[1] = obj_Solid;
        blocktype[2] = obj_Flat_N;
        blocktype[3] = obj_Flat_S;
        blocktype[4] = obj_Flat_E;
        blocktype[5] = obj_Flat_W;
        blocktype[6] = obj_Diagonal_NE;
        blocktype[7] = obj_Diagonal_NW;
        blocktype[8] = obj_Diagonal_SE;
        blocktype[9] = obj_Diagonal_SW;
        blocktype[10] = obj_Cap_N;
        blocktype[11] = obj_Cap_S;
        blocktype[12] = obj_Cap_E;
        blocktype[13] = obj_Cap_W;
        blocktype[14] = obj_Valley_N;
        blocktype[15] = obj_Valley_S;
        blocktype[16] = obj_Valley_E;
        blocktype[17] = obj_Valley_W;
        blocktype[18] = obj_Trunk_N;
        blocktype[19] = obj_Trunk_S;
        blocktype[20] = obj_Trunk_E;
        blocktype[21] = obj_Trunk_W;        
        blocktype[22] = obj_FallsHalf_N;        
        blocktype[23] = obj_FallsHalf_S;
        blocktype[24] = obj_FallsHalf_E;                       
        blocktype[25] = obj_FallsHalf_W;
        blocktype[26] = obj_Half_N;                 
        blocktype[27] = obj_Half_S;   
        blocktype[28] = obj_Half_E;   
        blocktype[29] = obj_Half_W;                           
        blocktype[30] = obj_HalfRises_N;   
        blocktype[31] = obj_HalfRises_S;  
        blocktype[32] = obj_HalfRises_E;                  
        blocktype[33] = obj_HalfRises_W;          
        blocktype[34] = obj_NarrowCap_N;          
        blocktype[35] = obj_NarrowCap_S; 
        blocktype[36] = obj_NarrowCap_E;         
        blocktype[37] = obj_NarrowCap_W;         
        blocktype[38] = obj_TrunkNarrows_N;          
        blocktype[39] = obj_TrunkNarrows_S; 
        blocktype[40] = obj_TrunkNarrows_E;         
        blocktype[41] = obj_TrunkNarrows_W;                 
                
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
    
// Iterate through the Array deciding whether to remove a block or not

for (u = 0; u < gridsize; u +=1)
    {
        for (v = 0; v < gridsize; v +=1)
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
 
// Now remove any isolated single Big Blocks
for (u = 1; u < gridsize-1; u +=1)
    {
        for (v = 1; v < gridsize-1; v +=1)
        {
            
            if  bigblock [u, v] > 0 && bigblock [u-1, v] == 0 && bigblock [u+1, v] == 0 && bigblock [u, v-1] == 0 && bigblock [u, v+1] == 0
                {
                bigblock [u , v] = 0
                } 
        }      
    }

//now check for isolated blocks on edges    
for (u = 1; u < gridsize-1; u +=1)
    {
        if  bigblock [u, 0] > 0 && bigblock [u-1, 0] == 0 && bigblock [u+1, 0] == 0 && bigblock [u, 1] == 0
            {

            bigblock [u , 0] = 0
            }
            
        if  bigblock [u, gridsize-1] > 0 && bigblock [u-1, gridsize-1] == 0 && bigblock [u+1, gridsize-1] == 0 && bigblock [u, gridsize-2] == 0
            {
            bigblock [u , gridsize-1] = 0
            }       
     }

for (v = 1; v < gridsize-1; v +=1)
    {
        if  bigblock [0, v] > 0 && bigblock [0, v+1] == 0 && bigblock [0, v-1] == 0 && bigblock [1, v] == 0
            {
            bigblock [0 , v] = 0
            }
            
        if  bigblock [gridsize-1, v] > 0 && bigblock [gridsize-1, v+1] == 0 && bigblock [gridsize-1, v-1] == 0 && bigblock [gridsize-2, v] == 0
            {
            bigblock [gridsize-1 , v] = 0
            }       
     }

//check for isolated corners
if  bigblock [0, 0] > 0 && bigblock [1, 0] == 0 && bigblock [0, 1] == 0 bigblock [0, 0] = 0   
if  bigblock [0, gridsize-1] > 0 && bigblock [1, gridsize-1] == 0 && bigblock [0, gridsize-2] == 0 bigblock [0, gridsize-1] = 0       
if  bigblock [gridsize-1, 0] > 0 && bigblock [gridsize-2, 0] == 0 && bigblock [gridsize-1, 1] == 0 bigblock [gridsize-1, 0] = 0       
if  bigblock [gridsize-1, gridsize-1] > 0 && bigblock [gridsize-2, gridsize-1] == 0 && bigblock [gridsize-1, gridsize-2] == 0 bigblock [gridsize-1, gridsize-1] = 0       
       
// Set up a start position free from blocks- random square top & bottom rows

starthuge = irandom(7);
endhuge = irandom(7);

bigblock [starthuge, 0] = 5         // 5 is array value for empty but visited
bigblock [endhuge, 7] = 1

// now we walk through the grid from starthuge to endhuge 
walk_x = starthuge;
walk_y = 0;
exit_x = endhuge;
exit_y = 7;
dir_x = 0;      //this is the direction to go in -ve is left, +ve right, 0 other axis- one of dir_x and dir_y should always be 0
dir_y = 0;
dif_x = 0;
dif_y = 0;
walkloop = 0;
downlast = false;

//show_debug_message("walk x: " + string(walk_x) + " ,walk y: " + string(walk_y) + " ,exit_x: " + string(exit_x) +  " ,exit_y: " + string(exit_y));


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
        if walk_y + 1 < gridsize && bigblock[walk_x, walk_y + 1] != 5  && innerloop != true && downlast == true    //move down if last move was down
            {
                walk_y += 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                totalwalkblocks += 1;
                walkblock[walk_x, walk_y] = totalwalkblocks;                
                //show_debug_message("headed down");
                downlast = false;            
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
        if walk_y + 1 < gridsize && bigblock[walk_x, walk_y + 1] != 5  && innerloop != true && downlast == false    //move down
            {
                walk_y += 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                totalwalkblocks += 1;
                walkblock[walk_x, walk_y] = totalwalkblocks;                
                //show_debug_message("headed down");
                downlast = true;            
            }        
        if walk_y >= exit_y && innerloop != true   //last resort- head for the exit directly as probably stuck in bottom corner
            {
                if walk_x < exit_x      //go right
                {
                    walk_x += 1 
                    innerloop = true;
                    bigblock[walk_x, walk_y] = 5;
                    totalwalkblocks += 1;
                    walkblock[walk_x, walk_y] = totalwalkblocks;                                  
                }
                else if walk_x > exit_x      //go left
                {
                    walk_x -= 1 
                    innerloop = true;
                    bigblock[walk_x, walk_y] = 5;
                    totalwalkblocks += 1;
                    walkblock[walk_x, walk_y] = totalwalkblocks;                
                }           
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
        for (v = 0; v < gridsize; v +=1)
        {
            if random(1) < chitterfxchance instance_create(u * 384 * global.RM +64 * global.RM + random(384), v * 384 * global.RM +64 * global.RM + random(384), obj_chitteremitter);            
    
            if bigblock[u , v] == 0
                {
                    //show_debug_message("Big Block ref" + string(u) + " , " + string(v) + " , array: " + string(bigblock[u,v]) );   
                    script_execute(scr_genHugeBlocks_B, u, v, bigblock[u,v]);
                    
                    blockindex = (bigblock[u, v] * -1) - 1;
                    //tile_add(tileset_hugeblocks, leftx, topy, width, height, u * 384 * global.RM +64 * global.RM , v * 384 * global.RM +64 * global.RM, 10);                                                         
                    show_debug_message("u: " + string(u) + " ,v: "+ string(v) + " ,blockindex = " + string(blockindex));
                                                  
                    inst = instance_create( u * 384 * global.RM +64 * global.RM , v * 384 * global.RM +64 * global.RM , obj_hugeblockB)
                    with (inst)
                        {
                            if random(1) < 2.0          // *********************** Revert to 0.5 or 1 once hugeblock corners created *******************************************************
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
                    // Initialise 144 x 144 Block Array- (0 = no block)
  
                            bu = 0;
                            bv = 0;
                    
                            for (i = 0; i < 97; i +=1)
                                {
                                    repeat(97)
                                    {
                                        block[bu, bv] = 0;
                                        //show_debug_message(string(bu) + " , " + string(bv));
                                        bu += 1;
                                    }
                                    if bu >= 95 block[bu, bv] = 1;
                                    if bv >= 95 block[bu, bv] = 1;
                                    bu = 0;        
                                    bv += 1;
        
                                }

//show_debug_message("Block Array done");                        
                            
for (u = 0; u < gridsize; u +=1)
    {
        for (v = 0; v < gridsize; v +=1)
        {
                //BALLPLANTS
                if walkblock[u, v] > 0 && walkblock[u, v] >= (totalwalkblocks * ballplantstartblock) && walkblock[u, v] <= (totalwalkblocks * ballplantendblock)    
                    {                        
                                                
                        ballplantdensity = ballplantdensitymin + (ballplantdensityrange * ((walkblock[u,v]- totalwalkblocks * ballplantstartblock)/(totalwalkblocks * ballplantendblock - totalwalkblocks * ballplantstartblock)))
                        //if ballplantdensity > 0 show_debug_message("Adding ballplants at Walkblock: " + string(walkblock[u,v]) + " with chance: " + string(ballplantdensity));                        
                    }
                else ballplantdensity = 0;            

                //SPIKERS
                if walkblock[u, v] > 0 && walkblock[u, v] >= (totalwalkblocks * spikerstartblock) && walkblock[u, v] <= (totalwalkblocks * spikerendblock)    
                    {                        
                                                
                        spikerdensity = spikerdensitymin + (spikerdensityrange * ((walkblock[u,v]- totalwalkblocks * spikerstartblock)/(totalwalkblocks * spikerendblock - totalwalkblocks * spikerstartblock)))
                        //if spikerdensity > 0 show_debug_message("Adding spikers at Walkblock: " + string(walkblock[u,v]) + " with chance: " + string(spikerdensity));                        
                    }
                else spikerdensity = 0;
                
                //GRABBERS
                if grabberone == true && walkblock[u, v] > 0 && walkblock[u, v] >= (totalwalkblocks * grabberoneblockmin) && walkblock[u, v] <= (totalwalkblocks * grabberoneblockmax)
                    {
                        grabberadd = true;                    
                    }
                else grabberadd = false;

                if grabbertwo == true && walkblock[u, v] > 0 && walkblock[u, v] >= (totalwalkblocks * grabbertwoblockmin) && walkblock[u, v] <= (totalwalkblocks * grabbertwoblockmax)
                    {
                        grabberadd = true;                    
                    }
                //else grabberadd = false;                
                
                                              
            
            script_execute(scr_genBlockArrayValues, u, v, bigblock[u,v], gridsize, starthuge, endhuge, ballplantdensity, spikerdensity, grabberadd, grabberone, grabbertwo)


             
        }

    }

show_debug_message("All Blocks have a 0 or 1 array value now");    


// Now iterate through all Blocks again and assign blocknear array values for each one
// set up Array for blocknear[] first
bu = 0;
bv = 0;
                    
for (i = 0; i < 96; i +=1)
    {
        repeat(96)
            {
                blocknear[bu, bv] = 0;
                //show_debug_message(string(bu) + " , " + string(bv));
                bu += 1;
            }
            bu = 0;        
            bv += 1;          
    }


//Now run script for each not empty block
for (u = 1; u < 95; u +=1)
{
    for (v = 1; v < 95; v +=1)
        {
            if block[u, v] > 0
            {
                script_execute(scr_genBlockNear_B, u, v, block[u, v]);            
            }
        }
}

//Now iterate through all blocks for a third time and assign blocks based upon the blocknear array values
for (u = 0; u < 96; u +=1)
{
    for (v = 0; v < 96; v +=1)
        {
            if block[u, v] > 0
            {
                script_execute(scr_genBlocks_B, u, v, block[u, v], blocknear[u, v], blocktype[]);            
            }
        }
}

//Now iterate through all blocks for a fourth time and add detail blocks as well as create the instances
for (u = 0; u < 96; u +=1)
{
    for (v = 0; v < 96; v +=1)
        {
            if block[u, v] > 0
            {
                script_execute(scr_BlocksDetail_B, u, v, block[u, v], blocknear[u, v], blocktype[], halfchance, narrowtrunkchance, bigsolidchance);            
            }
        }
}







show_debug_message("Block instances now created");

  
/*     
// Now iterate through each space big block and add wee blocks

for (v = 0; v < gridsize; v +=1)     

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

show_debug_message("Wee Blocks done");    


*/



//Add light source for normal maps before adding asteroids

instance_create(0, 0, oLightSource);


//Now add asteroids- iterate through big blocks looking for emptys
if asteroidchance > 0
    {
        for (u = 0; u < gridsize; u +=1)
            {
                for (v = 0; v < gridsize; v +=1)
                {
            
                    if bigblock[u , v] > 0
                        {
                        script_execute(scr_addAsteroids_B, u, v)
                      
                        }
              
                }
            }
    }
    
show_debug_message("Asteroids done");        
    
//generate outer border

for (u =0; u < bordersize+2; u+=1)
    {
                instance_create(u*64 * global.RM , 0, obj_borderblock_BNS)
                instance_create(u*64 * global.RM , gridsize*384 * global.RM +64 * global.RM , obj_borderblock_BNS)
    }

for (u =0; u < bordersize+2; u+=1)
    {
                instance_create(0, u*64 * global.RM , obj_borderblock_BEW)
                instance_create(gridsize*384 * global.RM +64 * global.RM ,u*64 * global.RM  , obj_borderblock_BEW)
    }


// caculate start and exit points for the map- in centre of each huge empty square (plus border of 64)
global.startx = starthuge * 384 * global.RM  + 182 * global.RM  + 64 * global.RM ;
global.starty = 16 * global.RM ;     // 16 points down from top edge
global.exitx = endhuge * 384 * global.RM  + 182 * global.RM  + 64 * global.RM ;
global.exity = gridsize * 384 * global.RM  + 128 * global.RM  - 32 * global.RM ;

// now remove borderblocks at start and exit
position_destroy(global.startx, global.starty);
position_destroy(global.startx-64 * global.RM , global.starty);
position_destroy(global.startx+64 * global.RM , global.starty);
position_destroy(global.exitx, global.exity);
position_destroy(global.exitx-64 * global.RM , global.exity);
position_destroy(global.exitx+64 * global.RM , global.exity);

global.startx -= 48;    //reposition ship in centre of start trench    
    
//and add four new borderside blocks
instance_create(starthuge * 384 * global.RM  + 64 * global.RM  + 64 * global.RM , 0, obj_borderside_Bleft);
instance_create(starthuge * 384 * global.RM  + 192 * global.RM  + 64 * global.RM , 0, obj_borderside_Bright);
instance_create(endhuge * 384 * global.RM  + 64 * global.RM  + 64 * global.RM , gridsize * 384 * global.RM  + 64 * global.RM , obj_borderside_Bleft);
instance_create(endhuge * 384 * global.RM  + 192 * global.RM  + 64 * global.RM , gridsize * 384 * global.RM + 64 * global.RM , obj_borderside_Bright);

// add an exit trigger
instance_create(endhuge * 384 * global.RM  + 64 * global.RM  + 64 * global.RM , gridsize * 384 * global.RM  + 64 * global.RM , obj_exittrigger);




                       
                         
                           

#define scr_genHugeBlocks_B
      
// Huge block found, now check adjacent squares- four axes n,s,e,w 0 or 1 depending if have an adjacent space
n = 0;
e = 0;
s = 0;
w = 0;

// edge squares- set to 2 as borders do not count as adjacent space
if u == 0 w = 2;
if u == 7 e = 2;
if v == 0 n = 2;
if v == 7 s = 2;                
                           
if  w != 2 && bigblock [u-1, v] > 0 w = 1
if  e != 2 && bigblock [u+1, v] > 0 e = 1
if  n != 2 && bigblock [u, v-1] > 0 n = 1
if  s != 2 && bigblock [u, v+1] > 0 s = 1

                    
// first check adjacent squares and change the array value to represent neighbouring squares- negative numbers for block types
                if n == 1 && e == 1 && s == 1 && w != 1 bigblock [u, v] = -1     // North, East and South
                if n == 1 && e != 1 && s == 1 && w == 1 bigblock [u, v] = -2     // North, South and West        
                if n == 1 && e == 1 && s != 1 && w == 1 bigblock [u, v] = -3     // North, East and West                   
                if n != 1 && e == 1 && s == 1 && w == 1 bigblock [u, v] = -4     // South, East and West                  
                if n == 1 && e != 1 && s == 1 && w != 1 bigblock [u, v] = -5     // North and South                    
                if n != 1 && e == 1 && s != 1 && w == 1 bigblock [u, v] = -6     // East and West                  
                if n == 1 && e == 1 && s != 1 && w != 1 bigblock [u, v] = -7     // North and East  
                if n != 1 && e == 1 && s == 1 && w != 1 bigblock [u, v] = -8     // East and South  
                if n == 1 && e != 1 && s != 1 && w == 1 bigblock [u, v] = -9     // North and West 
                if n != 1 && e != 1 && s == 1 && w == 1 bigblock [u, v] = -10     // West and South                  
                if n == 1 && e != 1 && s != 1 && w != 1 bigblock [u, v] = -11     // North only                  
                if n != 1 && e == 1 && s != 1 && w != 1 bigblock [u, v] = -12     // East Only
                if n != 1 && e != 1 && s == 1 && w != 1 bigblock [u, v] = -13     // South Only
                if n != 1 && e != 1 && s != 1 && w == 1 bigblock [u, v] = -14     // West Only
                if n == 1 && e == 1 && s == 1 && w == 1 bigblock [u, v] = -15     // North, South, East and West
                if n != 1 && e != 1 && s != 1 && w != 1 bigblock [u, v] = -16     // None- no adjacent spaces (fully enclosed)
                
                
                
                
                
               // bigblock [u, v] = -11


             
                
                
                
                
                
                

#define scr_genBlockArrayValues

// Array Block Guide
// 0 = empty
// 1 = block
// 3 = ballplant on south edge
// 4 = ballplant on north edge
// 5 = ballplant on east edge
// 6 = ballplant on west edge
// 7 = spiker on south edge
// 8 = spiker on north edge
// 9 = spiker on east edge
// 10 = spiker on west edge

//temp
bn = 0;
be = 0;
bw =0;
bs =0;

grabberadded = false; 

if bigblock[u , v] > 0
//show_debug_message("Space found square-");
{
    // Empty space block found, now check adjacent squares- four axes n,s,e,w 0 or 1 depending if have an adjacent edge
        n = 0;
        e = 0;
        s = 0;
        w = 0;
        special = 0;

        // edge squares- set to 2 so always add a block here (outer borders of map) unless at start square
        if u == 0 w = 2;
        if u == 7 e = 2;
        if v == 0 n = 2;
        if v == 7 s = 2;                
                           
        if  w != 2 && bigblock [u-1, v] <= 0 w = 1
        if  e != 2 && bigblock [u+1, v] <= 0 e = 1
        if  n != 2 && bigblock [u, v-1] <= 0 n = 1
        if  s != 2 && bigblock [u, v+1] <= 0 s = 1

        if v == 0 && u == starthuge         //special routine to add blocks in start square along north edge
            {
                n = 0;
                special = 1;
                block[0 + u * 12, 0 + v * 12] = 1
                block[1 + u * 12, 0 + v * 12] = 1
                block[0 + u * 12, 1 + v * 12] = 1
                block[1 + u * 12, 1 + v * 12] = 1
                for(i = 3; i < 7; i +=1)
                    {
                        block[i + u * 12, 0 + v * 12] = 98;     //used to prevent any blocks being added in these squares directly in front of player
                    }
                block[8 + u * 12, 0 + v * 12] = 1
                block[9 + u * 12, 0 + v * 12] = 1
                block[10 + u * 12, 0 + v * 12] = 1
                block[11 + u * 12, 0 + v * 12] = 1 
                block[8 + u * 12, 1 + v * 12] = 1
                block[9 + u * 12, 1 + v * 12] = 1
                block[10 + u * 12, 1 + v * 12] = 1
                block[11 + u * 12, 1 + v * 12] = 1                                             
            }
        if v == 7 && u == endhuge                //special routine to add blocks in end square along south edge
        {
                s = 0;
                special = 1;                  
                block[0 + u * 12, 11 + v * 12] = 1
                block[1 + u * 12, 11 + v * 12] = 1
                block[8 + u * 12, 11 + v * 12] = 1
                block[9 + u * 12, 11 + v * 12] = 1
                block[10 + u * 12, 11 + v * 12] = 1
                block[11 + u * 12, 11 + v * 12] = 1
                block[0 + u * 12, 10 + v * 12] = 1
                block[1 + u * 12, 10 + v * 12] = 1
                block[8 + u * 12, 10 + v * 12] = 1
                block[9 + u * 12, 10 + v * 12] = 1
                block[10 + u * 12, 10 + v * 12] = 1
                block[11 + u * 12, 10 + v * 12] = 1                               
        }
        
        // check for unsurrounded huge blocks to add potential wreckages
        if n == 0 && s == 0 && w == 0 && e == 0 && wreckadded == false
        {
            if random(1) <= wreckchance
                {
                    wx = (u * 768) + random_range(200, 568);
                    wy = (v * 768) + random_range(200, 568);
                    instance_create(wx, wy, obj_WreckSpawner);
                    wreckadded = true;     //one per map
                    show_debug_message("Wreck added at : " + string(u) + " , " + string(v));                        
                }                
        }
        if n == 1 && s == 0 && w == 0 && e == 0 && wreckadded == false
        {
            if random(1) <= wreckchance
                {
                    wx = (u * 768) + random_range(200, 568);
                    wy = (v * 768) + random_range(500, 768);
                    instance_create(wx, wy, obj_WreckSpawner);
                    wreckadded = true;     //one per map
                    show_debug_message("Wreck added at : " + string(u) + " , " + string(v));                        
                }                
        }
        if n == 0 && s == 1 && w == 0 && e == 0 && wreckadded == false
        {
            if random(1) <= wreckchance
                {
                    wx = (u * 768) + random_range(200, 568);
                    wy = (v * 768) + random_range(0, 268);
                    instance_create(wx, wy, obj_WreckSpawner);
                    wreckadded = true;     //one per map
                    show_debug_message("Wreck added at : " + string(u) + " , " + string(v));                        
                }                
        }        
        if n == 0 && s == 0 && w == 1 && e == 0 && wreckadded == false
        {
            if random(1) <= wreckchance
                {
                    wx = (u * 768) + random_range(500, 768);
                    wy = (v * 768) + random_range(200, 568);
                    instance_create(wx, wy, obj_WreckSpawner);
                    wreckadded = true;     //one per map
                    show_debug_message("Wreck added at : " + string(u) + " , " + string(v));                        
                }                
        }        
        if n == 0 && s == 0 && w == 0 && e == 1 && wreckadded == false
        {
            if random(1) <= wreckchance
                {
                    wx = (u * 768) + random_range(0, 268);
                    wy = (v * 768) + random_range(200, 568);
                    instance_create(wx, wy, obj_WreckSpawner);
                    wreckadded = true;     //one per map
                    show_debug_message("Wreck added at : " + string(u) + " , " + string(v));                        
                }                
        }                          
                               
        if w !=0 || e !=0 || n !=0 || s !=0 || special == 1                             // we have at least one external edge- so time to add blocks inside             
            {
                    
              
                // first check adjacent squares and change the array value to represent neighbouring squares
                if n != 0 && e == 0 && s == 0 && w == 0 bigblock [u, v] = 1     // North only
                if n == 0 && e == 0 && s != 0 && w == 0 bigblock [u, v] = 2     // South only          
                if n == 0 && e != 0 && s == 0 && w == 0 bigblock [u, v] = 3     // East only                    
                if n == 0 && e == 0 && s == 0 && w != 0 bigblock [u, v] = 4     // West only                   
                if n != 0 && e == 0 && s != 0 && w == 0 bigblock [u, v] = 5     // North and South                    
                if n == 0 && e != 0 && s == 0 && w != 0 bigblock [u, v] = 6     // East and West                  
                if n != 0 && e == 0 && s == 0 && w != 0 bigblock [u, v] = 7     // North and West   
                if n != 0 && e != 0 && s == 0 && w == 0 bigblock [u, v] = 8     // North and East   
                if n == 0 && e == 0 && s != 0 && w != 0 bigblock [u, v] = 9     // South and West   
                if n == 0 && e != 0 && s != 0 && w == 0 bigblock [u, v] = 10     // South and East                   
                if n != 0 && e != 0 && s != 0 && w == 0 bigblock [u, v] = 11     // North, South and East                    
                if n != 0 && e != 0 && s == 0 && w != 0 bigblock [u, v] = 12     // North, East and West
                if n == 0 && e != 0 && s != 0 && w != 0 bigblock [u, v] = 13     // South, East and West
                if n != 0 && e == 0 && s != 0 && w != 0 bigblock [u, v] = 14     // North, South and West
                if n == 0 && e == 0 && s == 0 && w == 0 bigblock [u, v] = 15      // No bordering blocks- set array to unused value (from Walk setting)
                
                //show_debug_message(string(u) + " , " + string(v) + " : " + string(bigblock [u,v]));                 

                //Next go through each of the above options adding blocks with a suitable layout for the square neighbours
                
                if bigblock [u, v] == 1           // North only
                    {
                        count = 1
                        clampmax = maxspike + 2
                        for (column = 0; column < 12; column +=1)           //iterate through each column from north edge down
                            {
                                if column <= 1 || column >= 11 clampmax = maxspike else clampmax = maxspike + 3 
                                count = count + irandom_range(-1, 1);
                                minadd = 0;
                                if v == 0 minadd = 1;
                                count = clamp(count, minspike + minadd, clampmax)
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,c + v * 12] == 0 block[column + u * 12, c + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         enemyspawn = random(1);
                                         if  c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, c + v * 12] = 4     //if last block is empty and random chance add ballplant
                                         if  c == (maxspike + 3) && enemyspawn <= spikerdensity
                                         {
                                            spikerdensity = 0;      //one per huge block
                                            block[column + u * 12, c + v * 12] = 8     //if last block is empty & top and random chance add spiker
                                         }
                                    }                    
                    }                

                if bigblock [u, v] == 2           // South only
                    {
                        count = 1
                        clampmax = maxspike + 2
                        for (column = 0; column < 12; column +=1)           //iterate through each column from south edge up
                            {
                                if column <= 1 || column >= 11 clampmax = maxspike else clampmax = maxspike + 3                               
                                count = count + irandom_range(-1, 1);
                                minadd = 0;
                                if v == 7 minadd = 1;
                                count = clamp(count, minspike + minadd, maxspike+3)
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,(11-c) + v * 12] == 0 block[column + u * 12, (11-c) + v * 12] = 1     //if block is empty add one
                                    }
                                         enemyspawn = random(1);
                                         if  c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, (11-c) + v * 12] = 3     //if last block is empty and random chance add ballplant
                                         if  c == (maxspike + 3) && enemyspawn <= spikerdensity 
                                         {
                                            spikerdensity = 0;      //one per huge block
                                            block[column + u * 12, (11-c) + v * 12] = 7     //if last block is empty and random chance add spiker
                                         }
                            }                    
                    }                  

                if bigblock [u, v] == 3           // East only
                    {
                        count = 1
                        clampmax = maxspike + 2
                        for (row = 0; row < 12; row +=1)           //iterate through each row
                            {
                                if row <= 1 || row >= 11 clampmax = maxspike else clampmax = maxspike + 3    
                                count = count + irandom_range(-1, 1);
                                minadd = 0;
                                if u == 7 minadd = 1;
                                count = clamp(count, minspike + minadd, clampmax)
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[(11-c)+ u * 12,row + v * 12] == 0 block[(11-c) + u * 12, row + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         enemyspawn = random(1);
                                         if  c < 11 && enemyspawn <= ballplantdensity block[(11-c) + u * 12, row + v * 12] = 5     //if last block is empty and random chance add ballplant
                                         if  c == (maxspike + 3) && enemyspawn <= spikerdensity
                                         {
                                            spikerdensity = 0;      //one per huge block
                                            block[(11-c) + u * 12, row + v * 12] = 9     //if last block is empty and random chance add spiker
                                         }
                                    }                    
                    } 

                if bigblock [u, v] == 4           // West only
                    {
                        count = 1
                        clampmax = maxspike + 2
                        for (row = 0; row < 12; row +=1)           //iterate through each row
                            {
                                if row <= 1 || row >= 11 clampmax = maxspike else clampmax = maxspike + 3   
                                count = count + irandom_range(-1, 1);
                                minadd = 0;
                                if u == 0 minadd = 1;
                                count = clamp(count, minspike + minadd, clampmax);
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[c+ u * 12,row + v * 12] == 0 block[c + u * 12, row + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         enemyspawn = random(1);
                                         if  c < 11 && enemyspawn <= ballplantdensity block[c + u * 12, row + v * 12] = 6     //if last block is empty and random chance add ballplant
                                         if  c == (maxspike + 3) && enemyspawn <= spikerdensity
                                         {
                                            spikerdensity = 0;      //one per huge block
                                            block[c + u * 12, row + v * 12] = 10     //if last block is empty and random chance add spiker
                                         }
                                    }                    
                    }                                         

                if bigblock [u, v] == 5           // North and South
                    {
                        count = 1
                        oppositecount = 1
                        clampmax = maxspike 
                        for (column = 0; column < 12; column +=1)           //iterate through each column from north edge down
                            {

                                count = count + irandom_range(-1, 2)
                                if column <= 1 || column >= 10 clampmax = 2
                                minadd = 0;
                                if v == 0 minadd = 1;
                                count = clamp(count, minspike + minadd, clampmax)
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,c + v * 12] == 0 block[column + u * 12, c + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         enemyspawn = random(1);
                                         if enemyspawn <= ballplantdensity block[column + u * 12, c + v * 12] = 4     //if last block is empty and random chance add ballplant
                                         if c == maxspike && enemyspawn <= spikerdensity
                                         {
                                            spikerdensity = 0;      //one per huge block
                                            block[column + u * 12, c + v * 12] = 8     //if last block is empty and random chance add spiker
                                         }
                                         if grabberadd == true
                                         {
                                            block[column + u * 12, c + 1 + v * 12] = 11  //add enemy node
                                            grabberadded = true
                                         }

                                   

                                clampmax = (12 - count - mingap)
                                oppositecount = oppositecount + irandom_range(-1, 2)
                                if column <= 1 || column >= 10 clampmax = 2
                                minadd = 0;
                                if v == 7 minadd = 1;
                                oppositecount = clamp(oppositecount, minspike + minadd, clampmax)
                                for (c = 0; c < oppositecount; c +=1)
                                    {
                                        if block[column + u * 12,(11-c) + v * 12] == 0 block[column + u * 12, (11-c) + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         enemyspawn = random(1);
                                         if  c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, (11-c) + v * 12] = 3     //if last block is empty and random chance add ballplant
                                         if  c == maxspike && enemyspawn <= spikerdensity
                                         {
                                            spikerdensity = 0;      //one per huge block
                                            block[column + u * 12, (11-c) + v * 12] = 7     //if last block is empty and random chance add spiker
                                         }
                                  if grabberadd == true block[column + u * 12, (11-c) + v * 12] = 13  //add enemy node        
                              }                         
                    }                                         

                if bigblock [u, v] == 6           // East and West
                    {
                        count = 1
                        oppositecount = 1
                        clampmax = maxspike
                        for (row = 0; row < 12; row +=1)           //iterate through each row from north edge down
                            {

                                count = count + irandom_range(-1, 2)
                                if row <= 1 || row >= 10 clampmax = 2
                                minadd = 0;
                                if u == 0 minadd = 1;
                                count = clamp(count, minspike, clampmax)
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[c+ u * 12,row + v * 12] == 0 block[c + u * 12, row + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         enemyspawn = random(1);
                                         if enemyspawn <= ballplantdensity block[c + u * 12, row + v * 12] = 6     //if last block is empty and random chance add ballplant
                                         if c == maxspike && enemyspawn <= spikerdensity
                                         {
                                            spikerdensity = 0;      //one per huge block
                                            block[c + u * 12, row + v * 12] = 10     //if last block is empty and random chance add spiker
                                         }
                                    if grabberadd == true
                                    {
                                    block[c + u * 12, row + v * 12] = 14  //add enemy node
                                    grabberadded = true
                                    }    
                            
                                clampmax = (12 - count - mingap)
                                oppositecount = oppositecount + irandom_range(-1, 2)
                                if row <= 1 || row >= 10 clampmax = 2
                                minadd = 0;
                                if u == 7 minadd = 1;
                                oppositecount = clamp(oppositecount, minspike + minadd, clampmax)
                                for (c = 0; c < oppositecount; c +=1)
                                    {
                                        if block[(11-c)+ u * 12,row + v * 12] == 0 block[(11-c) + u * 12, row + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         enemyspawn = random(1);
                                         if  c < 11 && enemyspawn <= ballplantdensity block[(11-c) + u * 12, row + v * 12] = 5     //if last block is empty and random chance add ballplant
                                         if  c == maxspike && enemyspawn <= spikerdensity
                                         {
                                            spikerdensity = 0;      //one per huge block
                                            block[(11-c) + u * 12, row + v * 12] = 9     //if last block is empty and random chance add spiker
                                         } 
                                         if grabberadd == true block[(11-c) + u * 12, row + v * 12] = 12  //add enemy node    
                            }                     
                    }                     

                if bigblock [u, v] == 7           // North and West
                    {
                        count = 1
                        clampmax = 1
                        for (column = 11; column > -1; column -=1)           //iterate through each column from north edge down- reverse, east to west
                            {
                                count = count + irandom_range(0, 2)   //counting up only as corner
                                count = clamp(count, minspike+1, clampmax)
                                clampmax +=1
                                if clampmax >=12 clampmax =11
                                if u == 0 && column == 1 count = 12
                                if column == 0 count = 12                                
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,c + v * 12] == 0 block[column + u * 12, c + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         //enemyspawn = random(1);
                                         //if  c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, c + v * 12] = 4     //if last block is empty and random chance add enemy
                                         
                                    }                    
                    } 
                                        
                if bigblock [u, v] == 8           // North and East
                    {
                        count = 1
                        clampmax = 1
                        for (column = 0; column < 12; column +=1)           //iterate through each column from north edge down
                            {

                                count = count + irandom_range(0, 2)   //counting up only as corner
                                count = clamp(count, minspike +1, clampmax)
                                clampmax +=1
                                if clampmax >=12 clampmax =11
                                if u == 7 && column == 10 count = 12
                                if column = 11 count = 12                                 
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,c + v * 12] == 0 block[column + u * 12, c + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         //enemyspawn = random(1);
                                         //if  c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, c + v * 12] = 4     //if last block is empty and random chance add enemy
                                    }                    
                    } 

                if bigblock [u, v] == 9           // South and West
                    {
                        count = 1
                        clampmax = 1
                        for (column = 11; column > -1; column -=1)           //iterate through each column from south edge up- reverse, west to east
                            {
                                count = count + irandom_range(0, 2)   //counting up only as corner
                                count = clamp(count, minspike +1, clampmax)
                                clampmax +=1
                                if clampmax >=12 clampmax =11
                                if u == 0 && column == 1 count = 12
                                if column == 0 count = 12 
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,(11-c) + v * 12] == 0 block[column + u * 12, (11-c) + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         //enemyspawn = random(1);
                                         //if c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, (11-c) + v * 12] = 3     //if last block is empty and random chance add enemy
                                    }                    
                    }                     

                if bigblock [u, v] == 10           // South and East
                    {
                        count = 1
                        clampmax = 1
                        for (column = 0; column < 12; column +=1)           //iterate through each column from south edge up
                            {

                                count = count + irandom_range(0, 2)   //counting up only as corner
                                count = clamp(count, minspike +1, clampmax)
                                clampmax +=1
                                if clampmax >=12 clampmax =11
                                if u == 7 && column == 10 count = 12
                                if column == 11 count = 12 
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,(11-c) + v * 12] == 0 block[column + u * 12, (11-c) + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         //enemyspawn = random(1);
                                         //if  c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, (11-c) + v * 12] = 3     //if last block is empty and random chance add enemy
                                    }                    
                    }                     
                    
                 if bigblock [u, v] == 11           // North, South and East 
                    {
                        count = 1
                        oldcount = 1
                        clampmax = maxspike + 2
                        for (row = 0; row < 12; row +=1)           //iterate through each row
                            {
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, minspike, clampmax)
                                oldcount = count
                                if row <= 0 || row >= 11 count = 12 else count = oldcount
                                if v == 0 && row == 1 count = 12
                                if v == 7 && row == 10 count = 12   
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[(11-c)+ u * 12,row + v * 12] == 0 block[(11-c) + u * 12, row + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         //enemyspawn = random(1);
                                         //if  c < 11 && enemyspawn <= ballplantdensity block[(11-c) + u * 12, row + v * 12] = 5     //if last block is empty and random chance add enemy
                                    }                    
                    }                    

                if bigblock [u, v] == 12           // North, East and West
                    {
                        count = 1
                        oldcount = 1
                        clampmax = maxspike + 2
                        for (column = 0; column < 12; column +=1)           //iterate through each column from north edge down
                            {
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, minspike, clampmax)
                                oldcount = count
                                if column <= 0 || column >= 11 count = 11 else count = oldcount
                                if u == 0 && column == 1 count = 12
                                if u == 7 && column == 10 count = 12                                    
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,c + v * 12] == 0 block[column + u * 12, c + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         //enemyspawn = random(1);
                                         //if  c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, c + v * 12] = 4     //if last block is empty and random chance add enemy
                                    }                    
                    }  

                if bigblock [u, v] == 13           // South, East and West
                    {
                        count = 1
                        oldcount = 1
                        clampmax = maxspike + 2
                        for (column = 0; column < 12; column +=1)           //iterate through each column from north edge down
                            {
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, minspike, clampmax)
                                oldcount = count
                                if column <= 0 || column >= 11 count = 12 else count = oldcount
                                if u == 0 && column == 1 count = 12
                                if u == 7 && column == 10 count = 12                                    
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[column + u * 12,(11-c) + v * 12] == 0 block[column + u * 12, (11-c) + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         //enemyspawn = random(1);
                                         //if  c < 11 && enemyspawn <= ballplantdensity block[column + u * 12, (11-c) + v * 12] = 4     //if last block is empty and random chance add enemy
                                    }                    
                    }                      
                    
                    
                                        
                 if bigblock [u, v] == 14           // North, South and West 
                    {
                        count = 1
                        oldcount = 1
                        clampmax = maxspike + 2
                        for (row = 0; row < 12; row +=1)           //iterate through each row
                            {
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, minspike, clampmax)
                                oldcount = count
                                if row <= 0 || row >= 11 count = 12 else count = oldcount
                                if v == 0 && row = 1 count = 12
                                if v == 7 && row == 10 count = 12    
                                for (c = 0; c < count; c +=1)
                                    {
                                        if block[c+ u * 12,row + v * 12] == 0 block[c + u * 12, row + v * 12] = 1     //if block is empty add one
                                        
                                    }
                                         //enemyspawn = random(1);
                                         //if  c < 11 && enemyspawn <= ballplantdensity block[c + u * 12, row + v * 12] = 6     //if last block is empty and random chance add enemy
                                    }                    
                    }                     
                                                        
                                                                                                                
// LEGACY BLOCK GENERATION CODE
/*
                            
                //now we have an array for new blocks- draw them
                for (bu = 0; bu < 12; bu +=1)
                    {
                        for (bv = 0; bv < 12; bv +=1)
                            {
                                //if block add a new block
                                if block[bu + u * 12 , bv + v * 12] == 1
                                    {
                                        instance_create( u * 384 * global.RM+64 * global.RM + bu *32 * global.RM, v * 384 * global.RM+64 * global.RM + bv *32 * global.RM, obj_newblock);
                                        //instance_deactivate_object(obj_newblock);
                                        //show_debug_message("block u: " + string(bu + u * 12) + " , v: " + string(bv + v * 12) + " , value:" + string(block[bu + u * 12 , bv + v * 12]));                  
                                        //if random(1) < newblockoverlaychance instance_create(u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM , v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM , obj_newblockoverlay); 
                                    }
                                if block[bu + u * 12, bv + v * 12] == 3      //enemy on south side facing up
                                    {

                                        with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  +32, v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 32, obj_ballplant))
                                                {
                                                    image_angle = 90;
                                                }
                                              
                  
                                    }
                                if block[bu + u * 12, bv + v * 12] == 4      //ballplant on north side facing down
                                        {
                                            with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  + 32, v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 32 , obj_ballplant))
                                                {
                                                    image_angle = 270;
                                                    
                                                }
                                            show_debug_message("Adding Ballplant in square: " + string(u) + " , " + string(v));
                                        }
                                if block[bu + u * 12, bv + v * 12] == 5      //ballplant on west side facing east
                                        {
                                          with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  + 32 , v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 32, obj_ballplant))
                                                {
                                                image_angle = 180;
                                                }
                                            show_debug_message("Adding Ballplant in square: " + string(u) + " , " + string(v));
                                        }
                                if block[bu + u * 12, bv + v * 12] == 6      //ballplant on east side facing west
                                        {
                                          with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  + 32 , v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 32, obj_ballplant))
                                                {
                                                image_angle = 0;
                                                }
                                          show_debug_message("Adding Ballplant in square: " + string(u) + " , " + string(v));
                                         }       
                                                
                                if block[bu + u * 12, bv + v * 12] == 7      //spiker on south side facing up
                                        {

                                            with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  +32, v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 64, obj_spiker))
                                                {
                                                    image_angle = 90;
                                                }
                                            show_debug_message("Adding Spiker in square: " + string(u) + " , " + string(v));                      
                                        }
                                if block[bu + u * 12, bv + v * 12] == 8      //spiker on north side facing down
                                        {
                                            with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  + 32, v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 0 , obj_spiker))
                                                {
                                                    image_angle = 270;
                                                    
                                                }
                                            show_debug_message("Adding Spiker in square: " + string(u) + " , " + string(v)); 
                                        }
                                if block[bu + u * 12, bv + v * 12] == 9      //spiker on west side facing east
                                        {
                                          with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  + 64 , v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 32, obj_spiker))
                                                {
                                                image_angle = 180;
                                                }
                                            show_debug_message("Adding Spiker in square: " + string(u) + " , " + string(v)); 
                                        }
                                if block[bu + u * 12, bv + v * 12] == 10      //spiker on east side facing west
                                        {
                                          with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  + 0 , v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 32, obj_spiker))
                                                {
                                                image_angle = 0;
                                                }                                                
                                            show_debug_message("Adding Spiker in square: " + string(u) + " , " + string(v));                                                
                                        }
                                         
                                if block[bu + u * 12, bv + v * 12] == 11      //enemy node on north side facing up                                        {
                                        {     
                                             inst = instance_create( u * 384 * global.RM+64 * global.RM + bu *32 * global.RM +32, v * 384 * global.RM+64 * global.RM + bv *32 * global.RM - 64, obj_enemynode);
                                                 with(inst)
                                                    {
                                                        image_angle = 90;   //pointing up
                                                    }
                                             block[bu + u * 12 , bv + v * 12] = 0           
                                         }                                        

                                if block[bu + u * 12, bv + v * 12] == 12      //enemy node on west side facing east                                       {
                                        {     
                                             inst = instance_create( u * 384 * global.RM+64 * global.RM + bu *32 * global.RM + 64, v * 384 * global.RM+64 * global.RM + bv *32 * global.RM +32, obj_enemynode);
                                                 with(inst)
                                                    {
                                                        image_angle = 0;   //pointing right
                                                    }
                                             block[bu + u * 12 , bv + v * 12] = 0    
                                         }                                                                                   
                                if block[bu + u * 12, bv + v * 12] == 13      //enemy node on south side facing down                                       {
                                        {     
                                             inst = instance_create( u * 384 * global.RM+64 * global.RM + bu *32 * global.RM + 32, v * 384 * global.RM+32 * global.RM + bv *32 * global.RM + 128, obj_enemynode);
                                                 with(inst)
                                                    {
                                                        image_angle = 270;   //pointing down
                                                    }
                                             block[bu + u * 12 , bv + v * 12] = 0             
                                         }
                                if block[bu + u * 12, bv + v * 12] == 14      //enemy node on east side facing west                                       {
                                        {     
                                             inst = instance_create( u * 384 * global.RM+64 * global.RM + bu *32 * global.RM - 32, v * 384 * global.RM + 32 * global.RM + bv *32 * global.RM +96, obj_enemynode);
                                                 with(inst)
                                                    {
                                                        image_angle = 180;   //pointing left
                                                    }
                                             block[bu + u * 12 , bv + v * 12] = 0    
                                         }                                                                                 
                                if block[bu + u * 12, bv + v * 12] == 99      //debug
                                        {
                                          with(instance_create( u * 384 * global.RM +64 * global.RM  + bu *32 * global.RM  + 16 * global.RM , v * 384 * global.RM +64 * global.RM  + bv *32 * global.RM  + 16 * global.RM , debug_S))
                                                {
                                                image_angle = 0;
                                                }
                                          block[bu + u * 12 , bv + v * 12] = 0
                                        }
                                //instance_deactivate_all(true);          
                                }
                        }

                    if grabberadded == true && grabberone == true
                        {
                            instance_create(u * 768 + 384, v * 768 +384, obj_grabber);
                            grabberone = false;
                            grabberadd = false;
                            grabberadded = false;
                            show_debug_message("Adding Grabber in square: " + string(u) + " , " + string(v));
                        }                         
                    if grabberadded == true && grabbertwo == true
                        {
                            instance_create(u * 768 + 384, v * 768 +384, obj_grabber);
                            grabbertwo = false;
                            grabberadd = false;
                            grabberadd = false;
                            show_debug_message("Adding Grabber in square: " + string(u) + " , " + string(v));
                        }                         

                        
// END OF LEGACY CODE    
*/         
            
    }           
}
else            //fill huge block with solid array values
{
    for(bu = 0; bu < 12; bu +=1)
        {
                for(bv = 0; bv < 12; bv +=1)
                    {
                        block[u * 12 + bu, v * 12 + bv] = 1;                       
                    }
        
        }

}

#define scr_genBlockNear_B
// we have found a square with a block assigned to it so now check its eight neighbours

squareone = 0;
squaretwo = 0;
squarethree = 0;
squarefour = 0;
squarefive = 0;
squaresix = 0;
squareseven = 0;
squareeight = 0;
squarenine = 0;

if block[u-1, v-1] == 1 squareone = 100000000;
if block[u, v-1] == 1 squaretwo = 10000000;
if block[u+1, v-1] == 1 squarethree = 1000000;
if block[u-1, v] == 1 squarefour = 100000;
if block[u, v] == 1 squarefive = 10000;
if block[u+1, v] == 1 squaresix = 1000;
if block[u-1, v+1] == 1 squareseven = 100;
if block[u, v+1] == 1 squareeight = 10;
if block[u+1, v+1] == 1 squarenine = 1;





//assign blocknear array value with a binary style nine digit number- 101010101
blocknear[u, v] = squareone + squaretwo + squarethree + squarefour + squarefive + squaresix + squareseven + squareeight + squarenine;

/*
//border squares- assume neighbours on sides
if u > 95
{
    blocknear[u, v] = 111111111
    instance_create(128 + u *64, 128 + v * 64, obj_debug);    
}
if v > 95
{
    blocknear[u, v] = 111111111
    instance_create(128 + u *64, 128 + v * 64, obj_debug);   
}

*/







#define scr_genBlocks_B
// blocktype[0] = "obj_debug";     //0 reserved for empty squares
// blocktype[1] = "obj_Solid";
// blocktype[2] = obj_Flat_N;
// blocktype[3] = obj_Flat_S;
// blocktype[4] = obj_Flat_E;
// blocktype[5] = obj_Flat_W;
// blocktype[6] = obj_Diagonal_NE;
// blocktype[7] = obj_Diagonal_NW;
// blocktype[8] = obj_Diagonal_SE;
// blocktype[9] = obj_Diagonal_SW;
// blocktype[10] = obj_Cap_N;
// blocktype[11] = obj_Cap_S;
// blocktype[12] = obj_Cap_E;
// blocktype[13] = obj_Cap_W;
// blocktype[14] = obj_Valley_N;
// blocktype[15] = obj_Valley_S;
// blocktype[16] = obj_Valley_E;
// blocktype[17] = obj_Valley_W;
// blocktype[18] = obj_debug;
// blocktype[19] = obj_debug;
// blocktype[20] = obj_debug;
// blocktype[21] = obj_debug;        
// blocktype[22] = obj_debug;        
// blocktype[23] = obj_debug;
// blocktype[24] = obj_debug;                       
// blocktype[25] = obj_debug;
// blocktype[26] = obj_debug;                 
// blocktype[27] = obj_debug;   
// blocktype[28] = obj_debug;   
// blocktype[29] = obj_debug;                           
// blocktype[30] = obj_debug;   
// blocktype[31] = obj_debug;  
// blocktype[32] = obj_debug;                  
// blocktype[33] = obj_debug;          
// blocktype[34] = obj_debug;          
// blocktype[35] = obj_debug; 
// blocktype[36] = obj_debug;         
// blocktype[37] = obj_debug;  

//test blocknear[] values and change block value to above new type unless no change (0= solid)



                var value = blocknear[u, v];
                
                if value == 111111 || value == 100111111 || value == 1111111 || value == 111010 || value == 111110 || value == 100111110 || value == 1111011 block[u,v] = 2;
                else if value == 111111000 || value == 111111100 || value == 111111001 || value == 10111000 || value == 110111000 || value == 110111100 block[u,v] = 3;
                else if value == 110110110 || value == 111110110 || value == 110110111 || value == 10110110 || value == 110110010 || value == 10110111 || value == 111110010 block[u,v] = 4;
                else if value == 11011011 || value == 111011011 || value == 11011111 || value == 10011111 || value == 10011010 || value == 111011010 || value == 10011011 block[u,v] = 5;
                else if value == 100110111 || value == 100110110 || value == 110111 || value == 110110 block[u,v] = 6;
                else if value == 1011111 || value == 1011011 || value == 11111 || value == 11011 block[u,v] = 7;
                else if value == 111110100 || value == 110110000 || value == 111110000 || value == 110110000 || value == 110110100 block[u,v] = 8;
                else if value == 111011001 || value == 111011000 || value == 11011001 || value == 11011000 block[u,v] = 9;
                else if value == 10010 || value == 10111 || value == 10110 || value == 10011 block[u,v] = 10;
                else if value == 111010000 || value == 10010000 || value == 11010000 || value == 10010000 || value == 1001000 || value == 110010000 block[u,v] = 11;
                else if value == 10011000 || value == 110000 || value == 110100 || value == 100110100 || value == 100110000 block[u,v] = 12;
                else if value == 1011001 || value == 11001 || value == 1011000 || value == 1011000 || value == 11000 block[u,v] = 13;
                else if value == 101111111 block[u,v] = 14;
                else if value == 111111101 block[u,v] = 15;
                else if value == 111110111 block[u,v] = 16;
                else if value == 111011111 block[u,v] = 17;
                else if value == 10010111 || value == 10010010 || value == 10010110 || value == 10010011 block[u,v] = 18;
                else if value == 111010010 || value == 11010010 || value == 110010010 || value == 10010010 block[u,v] = 19;
                else if value == 100111100 || value == 111000 || value == 111100 || value == 100111000 block[u,v] = 20;
                else if value == 1111001 || value == 1111000 || value == 111001 block[u,v] = 21;

                














#define scr_BlocksDetail_B
//iterate through block array one more time adjusting tiles to add details & variation


//Half Flats
if block[u, v] == 2 && block[u+1, v] == 2 && random(1) < halfchance       //at least two adjacent facing flats- North
{
    block[u, v] = 22;       //falls to half
    loop = true;
    position = u+1;
    maxrun = irandom_range(2, 7);       //randomise how many half pieces in a row to allow
    count = 2;
    while(loop == true)
    {
            if block[position+1, v] != 2 || count >= maxrun
                {
                    block[position, v] = 30;        //half rises
                    loop = false;                 
                }
            else
                {
                    block[position, v] = 26;        //half half
                    position += 1;
                    count += 1;                   
                }
    }
}

if block[u, v] == 3 && block[u+1, v] == 3 && random(1) < halfchance       //at least two adjacent facing flats- South
{
    block[u, v] = 23;       //falls to half
    loop = true;
    position = u+1;
    maxrun = irandom_range(2, 7);       //randomise how many half pieces in a row to allow
    count = 2;
    while(loop == true)
    {
            if block[position+1, v] != 3 || count >= maxrun
                {
                    block[position, v] = 31;        //half rises
                    loop = false;                 
                }
            else
                {
                    block[position, v] = 27;        //half half
                    position += 1;
                    count += 1;                   
                }
    }
}

if block[u, v] == 4 && block[u, v+1] == 4 && random(1) < halfchance       //at least two adjacent facing flats- East
{
    block[u, v] = 24;       //falls to half 24
    loop = true;
    position = v+1;
    maxrun = irandom_range(2, 7);       //randomise how many half pieces in a row to allow
    count = 2;
    while(loop == true)
    {
            if block[u, position+1] != 4 || count >= maxrun
                {
                    block[u, position] = 32;        //half rises   32
                    loop = false;                 
                }
            else
                {
                    block[u, position] = 28;        //half half
                    position += 1;
                    count += 1;                   
                }
    }
}

if block[u, v] == 5 && block[u, v+1] == 5 && random(1) < halfchance       //at least two adjacent facing flats- West
{
    block[u, v] = 25;       //falls to half
    loop = true;
    position = v+1;
    maxrun = irandom_range(2, 7);       //randomise how many half pieces in a row to allow
    count = 2;
    while(loop == true)
    {
            if block[u, position+1] != 5 || count >= maxrun
                {
                    block[u, position] = 33;        //half rises
                    loop = false;                 
                }
            else
                {
                    block[u, position] = 29;        //half half
                    position += 1;
                    count += 1;                   
                }
    }
}


//Narrowing Trunks
if block[u, v] == 10 && block[u, v+1] == 18 && random(1) < narrowtrunkchance        //narrowing trunk- North
{
    block[u, v] = 34;
    block[u, v+1] = 38;
}

if block[u, v] == 19 && block[u, v+1] == 11 && random(1) < narrowtrunkchance        //narrowing trunk- South
{
    block[u, v] = 39;
    block[u, v+1] = 35;
}

if block[u, v] == 20 && block[u+1, v] == 12 && random(1) < narrowtrunkchance        //narrowing trunk- East
{
    block[u, v] = 40;
    block[u+1, v] = 36;
}

if block[u, v] == 13 && block[u+1, v] == 21 && random(1) < narrowtrunkchance        //narrowing trunk- West
{
    block[u, v] = 37;
    block[u+1, v] = 41;
}



// are we outside of a bigblock square
hu = floor(u / 12);
hv = floor(v / 12);

if bigblock[hu, hv] > 0
{


if random(1) < bigsolidchance       //replace four adjacent solid tiles with one 128 solid
    {                
        if block[u, v] == 1 && block[u+1, v] == 1 && block[u, v+1] == 1 && block[u+1, v+1] == 1
        { 
            hu = floor((u+1) / 12);     //check none of the four blocks are inside a huge block
            hv = floor(v / 12);
            if bigblock[hu, hv] > 0
            {        
                hu = floor(u / 12);
                hv = floor((v+1) / 12);
                if bigblock[hu, hv] > 0
                    {         
                        hu = floor((u+1) / 12);
                        hv = floor((v+1) / 12);
                        if bigblock[hu, hv] > 0
                            {             
                                block[u, v] = 0;
                                block[u+1, v] = 0;    
                                block[u, v+1] = 0;    
                                block[u+1, v+1] = 0;    
                                instance_create(128 + u * 64, 128 + v * 64, obj_Solid128);                                
                            }
                    }
             }
        }
    }

//---------------------------------------------------------------------
                
//Now create the block with correct type unless inside a solid huge block

    var type = block[u,v];
    if type > 0 && type < 45    //98 is used to keep start and end squares free
        {
            var object = blocktype[type];
            //show_debug_message("type = " + string(type) + " , Object: " + string(object));            
            instance_create(128 + u * 64, 128 + v * 64, object);      
        }

        
}

#define script46
// iterate through all the blocks in this big block square and calculate neigbour values for them
goldcount = 0;



for (bu = 0; bu < 12; bu +=1)
    {
        for (bv = 0; bv < 12; bv +=1)
        {
            bx = (u * 12 + bu);
            by = (v * 12 + bv);

            if block[bx, by] == 0
            {
                //show_debug_message("Block " + string(bx) + " , " + string(by));
                //if by > 0 && by < 12
                //{
                //show_debug_message("Block " + string(bx) + " , " + string(by) + " , north value:" + string(block[bx,by-1]));
                //}
                //instance_create( 64 + bx * 32, 64 + by * 32, obj_debug);
                // found an empty square- now check for neighbours
                var n;
                var e;
                var s;
                var w;
                n = 0;
                e = 0;
                s = 0;
                w = 0;
                
                if bx == 0 w = 1
                if bx == 96 e = 1
                if by == 0 n = 1
                if by == 96 s = 1
                
                if bx > 0 && block[bx - 1, by] == 1 w = 1   else w = 0
                if bx < 96 && block[bx + 1, by] == 1 e = 1   else e = 0            
                if by > 0 && block[bx, by - 1] == 1 n = 1   else n = 0 
                if by < 96 && block[bx, by + 1] == 1 s = 1   else s = 0
        
        
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
                        if random(1) < goldchance goldcount = round(random_range(goldspread/5, goldspread))          //set a counter if next few blocks worth of blastblocks are to be gold
                        //show_debug_message("wee block space found- " + string(bx) + " , " + string(by) + "- n:" + string(n) + " e: " + string(e) + " s: " + string(s) + " w: " + string(w) + " , value:" + string(block[bx,by]));
                        script_execute(scr_genWeeblocks, u, v, bx, by, block[bx,by], goldcount, gauntdensity);
                
                    }
            }
        }

    }
}

#define script47



// create a local Array
var weeblock;

wbu = 0;
wbv = 0;

//temp
wbn = 0;
wbs = 0;
wbe = 0;
wbw = 0;
                 
for (i = 0; i < 8; i +=1)
    {
        repeat(8)
        {
            weeblock[wbu, wbv] = 0;
            //show_debug_message(string(wbu) + " , " + string(wbv));
            wbu += 1;
        }
        wbu = 0;        
        wbv += 1;          
    }

blocktest = block [bx, by]    

   
    
// now calculate the weeblocks to add

            if blocktest == -1          // North only
                    {
                        //show_debug_message("block with north side at: " + string(bx) + " , " + string(by));
                        //instance_create( 64 + (bx * 32), 64 + (by * 32), obj_debug);
                        count = 1
                        clampmax = maxweespike
                        localvinechance = vinechance;
                                for (column = 0; column < 8; column +=1)           //iterate through each column from north edge down
                                            {
                                                clampmax = maxweespike + 2 
                                                count = count + irandom_range(-1, 1)
                                                count = clamp(count, minweespike, clampmax)
                                                 blockswitch = 0;        //wee blocks
                                                 vines = 0;         //used to test first vine placed down
                                                 gold = 0;          //used to test first gold placed down
                                                 weeblock[column, 0] = 13        //first block is always an indestructible wee block
                                                 
                                                 for (c = 1; c < count+1; c +=1)
                                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks
                                                      
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold 
                                                            {
                                                                blockswitch = 2       //switch to vines for rest of column
                                                                localvinechance = vinechance *5;
                                                            }
                                                      //blastblock tests
                                                      if weeblock[column, c] == 0 && c < count && blockswitch == 0 weeblock[column, c] = 14
                                                      if weeblock[column, c] == 0 && c == count && blockswitch == 0 weeblock[column, c] = 4
                                                      
                                                      //goldtests
                                                      if weeblock[column, c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {                                                              
                                                              if gold > 0 && c < count weeblock[column, c] = 3
                                                              if gold > 0 && c == count weeblock[column, c] = 33
                                                              if gold == 0 && c < count
                                                                  {
                                                                      weeblock[column, c] = 29
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, c] = 25      // vine
                                                      vines += 1
                                                      }
                                                      if weeblock[column, c] == 0 && c < count && blockswitch == 2 weeblock[column, c] = 8      // vine
                                                      if weeblock[column, c] == 0 && c == count && blockswitch == 2 weeblock[column, c] = 9     //end cap
                                                    }
                                                    
                                if random(1) < gauntdensity
                                    {
                                        var inst
                                        inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + column * 4 * global.RM  + 0, 64 * global.RM  + (by *32 * global.RM ) + ((count+1) *4 * global.RM ) + 10 * global.RM , obj_gaunt);
                                        with (inst)
                                            {
                                                image_angle = 270
                                            }                                                    
                                    }
                                if random(1) < sporedensity
                                    {
                                        var inst
                                                inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + column * 4 * global.RM  + 0, 64 * global.RM  + (by *32 * global.RM ) + ((count+1) *4 * global.RM ), obj_spawn)
                                                script_execute(scr_sporeoffset, sporeoffsetdistance, sporeoffsetangle);                                                             
                                                with(inst)
                                                {
                                                    image_angle = 270
                                                    offsetx = other.offsetx;
                                                    offsety = other.offsety;
                                                }
                                                                   
                                    
                                    }                  
                            }  
                    }
                if blocktest == -2           // South only
                    {
                        count = 1
                        clampmax = maxweespike;
                        localvinechance = vinechance;
                        for (column = 0; column < 8; column +=1)           //iterate through each column from south edge up
                            {
                                clampmax = maxweespike + 2                               
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, minweespike, clampmax)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down                                
                                weeblock[column, 7] = 17                //first block is always an indestructible wee block                            
                                for (c = 1; c < count+1; c +=1)
                                        {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold 
                                                            {
                                                                blockswitch = 2       //switch to vines for rest of column
                                                                localvinechance = vinechance *5;
                                                            }
                                                      
                                                      //weeblock tests
                                                      if weeblock[column, 7-c] == 0 && c < count && blockswitch == 0 weeblock[column, 7-c] = 18
                                                      if weeblock[column, 7-c] == 0 && c == count && blockswitch == 0 weeblock[column, 7-c] = 5
                                                      
                                                      //goldtests
                                                      if weeblock[column, 7-c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count weeblock[column, 7-c] = 3
                                                              if gold > 0 && c == count weeblock[column, 7-c] = 34
                                                              if gold == 0 && c < count
                                                                  {
                                                                      weeblock[column, 7-c] = 30
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, 7-c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, 7-c] = 26
                                                      vines +=1
                                                      }                                                      
                                                      if weeblock[column, 7-c] == 0 && c < count && blockswitch == 2 weeblock[column, 7-c] = 8
                                                      if weeblock[column, 7-c] == 0 && c == count && blockswitch == 2 weeblock[column, 7-c] = 10
                                        }
                                if random(1) < gauntdensity
                                    {
                                        var inst
                                        inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + column * 4 * global.RM  + 0, 64 * global.RM  + (by *32 * global.RM ) + ((7-c) *4 * global.RM ) -10 * global.RM , obj_gaunt);
                                        with (inst)
                                            {
                                                image_angle = 90
                                            }                                                    
                                    }
                                if random(1) < sporedensity
                                    {
                                        var inst
                                            
                                                inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + column * 4 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + ((7-c) *4 * global.RM ), obj_spawn)
                                                script_execute(scr_sporeoffset, sporeoffsetdistance, sporeoffsetangle);                                                  
                                                with(inst)
                                                {
                                                    image_angle = 90

                                                    offsetx = other.offsetx;
                                                    offsety = other.offsety;                                                    
                                                }                                                
                                                  
                                                                                                    
                                    }
                          }  
                    }

                if blocktest == -3           // East only
                    {
                        count = 1
                        clampmax = maxweespike;
                        localvinechance = vinechance;
                        for (row = 0; row < 8; row +=1)           //iterate through each row
                            {
                                clampmax = maxweespike + 2    
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, minweespike, clampmax)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down                                
                                weeblock[7, row] = 21        //first block is always an indestruct wee block
                                                 
                                for (c = 1; c < count+1; c +=1)
                                    {
                                        if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                        if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold 
                                            {
                                                blockswitch = 2       //switch to vines for rest of column
                                                localvinechance = vinechance *5;
                                            }
                                                      
                                            //weeblock tests
                                            if weeblock[7-c, row] == 0 && c < count && blockswitch == 0 weeblock[7-c, row] = 23
                                            if weeblock[7-c, row] == 0 && c == count && blockswitch == 0 weeblock[7-c, row] = 7
                                                      
                                            //goldtests
                                            if weeblock[7-c, row] == 0 && blockswitch == 1 && goldcount > 0
                                                {
                                                    if gold > 0 && c < count weeblock[7-c, row] = 3
                                                    if gold > 0 && c == count weeblock[7-c, row] = 35
                                                    if gold == 0 && c < count
                                                        {
                                                            weeblock[7-c, row] = 31
                                                            gold += 1;
                                                        }
                                                    goldcount -= 1;
                                                }
                                                          
                                            //vine tests
                                            if weeblock[7-c, row] == 0 && vines == 0 && blockswitch == 2
                                            {
                                            weeblock[7-c, row] = 27
                                            vines += 1
                                            }                                            
                                            if weeblock[7-c, row] == 0 && c < count && blockswitch == 2 weeblock[7-c, row] = 8
                                            if weeblock[7-c, row] == 0 && c == count && blockswitch == 2 weeblock[7-c, row] = 12
                                    }
                                    if random(1) < gauntdensity
                                        {
                                            var inst
                                            inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + (7-c) * 4 * global.RM  -10 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + (row *4 * global.RM ) + 0, obj_gaunt);
                                            with (inst)
                                                {
                                                    image_angle = 180
                                                }                                                    
                                        }
                                if random(1) < sporedensity
                                    {
                                        var inst

                                                inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + (7-c) * 4 * global.RM, 64 * global.RM  + (by *32 * global.RM ) + (row *4 * global.RM ), obj_spawn)
                                                script_execute(scr_sporeoffset, sporeoffsetdistance, sporeoffsetangle);                                                      
                                                with(inst)
                                                {
                                                    image_angle = 180
                                                    offsetx = other.offsetx;
                                                    offsety = other.offsety;                                                    
                                                }
                                                                                                
                                    }                                                          
                            }
                    } 

                if blocktest == -4           // West only
                    {
                        count = 1
                        clampmax = maxweespike;
                        localvinechance = vinechance;
                        for (row = 0; row < 8; row +=1)           //iterate through each row
                            {
                                clampmax = maxweespike + 2   
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, minweespike, clampmax)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down 
                                weeblock[0, row] = 22        //first block is always an indestruct wee block
                                                 
                                for (c = 1; c < count+1; c +=1)
                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold 
                                                            {
                                                                blockswitch = 2       //switch to vines for rest of column
                                                                localvinechance = vinechance *5;
                                                            }
                                                      
                                                      //weeblock tests
                                                      if weeblock[c, row] == 0 && c < count && blockswitch == 0 weeblock[c, row] = 24
                                                      if weeblock[c, row] == 0 && c == count && blockswitch == 0 weeblock[c, row] = 6
                                                      
                                                      //goldtests
                                                      if weeblock[c, row] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                                if gold > 0 && c < count weeblock[c, row] = 3
                                                                if gold > 0 && c == count weeblock[c, row] = 36
                                                                if gold == 0 && c < count
                                                                    {
                                                                        weeblock[c, row] = 32
                                                                        gold += 1;
                                                                    }
                                                                goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[c, row] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[c, row] = 28
                                                      vines +=1
                                                      }                                                      
                                                      if weeblock[c, row] == 0 && c < count && blockswitch == 2 weeblock[c, row] = 8
                                                      if weeblock[c, row] == 0 && c == count && blockswitch == 2 weeblock[c, row] = 11
                                    }
                                    if random(1) < gauntdensity
                                        {
                                            var inst
                                            inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + (c) * 4 * global.RM  + 10 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + (row *4 * global.RM ) + 0, obj_gaunt);
                                            with (inst)
                                                {
                                                    image_angle = 0
                                                }                                                    
                                        }
                                if random(1) < sporedensity
                                    {
                                        var inst
                                                inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + (c) * 4 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + (row *4 * global.RM ), obj_spawn)
                                                script_execute(scr_sporeoffset, sporeoffsetdistance, sporeoffsetangle);                                                      
                                                with(inst)
                                                {
                                                    image_angle = 0
                                                    offsetx = other.offsetx;
                                                    offsety = other.offsety;                                                    
                                                }
                                                                                                
                                    }                                                                              
                                }                    
                    }  

                if blocktest == -5           // North and South
                    {
                        count = 1
                        clampmax = maxweespike
                        localvinechance = vinechance; 
                        for (column = 0; column < 8; column +=1)           //iterate through each column from north edge down
                            {

                                count = count + irandom_range(-1, 2)
                                count = clamp(count, minweespike, clampmax)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down 
                                weeblock[column, 0] = 13        //first block is always an indestruct wee block
                                                 
                                for (c = 1; c < count+1; c +=1)
                                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      //weeblock tests
                                                      if weeblock[column, c] == 0 && c < count && blockswitch == 0 weeblock[column, c] = 14
                                                      if weeblock[column, c] == 0 && c == count && blockswitch == 0 weeblock[column, c] = 4
                                                      
                                                      //goldtests
                                                      if weeblock[column, c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count weeblock[column, c] = 3
                                                              if gold > 0 && c == count weeblock[column, c] = 33
                                                              if gold == 0 && c < count
                                                                  {
                                                                      weeblock[column, c] = 29
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, c] = 25      // vine
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[column, c] == 0 && c < count && blockswitch == 2 weeblock[column, c] = 8      // vine
                                                      if weeblock[column, c] == 0 && c == count && blockswitch == 2 weeblock[column, c] = 9     //end cap
                                                    }
                                if random(1) < gauntdensity
                                    {
                                        var inst
                                        inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + column * 4 * global.RM  + 0, 64 * global.RM  + (by *32 * global.RM ) + ((count+1) *4 * global.RM ) + 10 * global.RM , obj_gaunt);
                                        with (inst)
                                            {
                                                image_angle = 270
                                            }                                                    
                                    }
                                if random(1) < sporedensity
                                    {
                                        var inst
                                        inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + column * 4 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + ((count+1) *4 * global.RM ), obj_spawn)
                                                with(inst)
                                                {
                                                    image_angle = 270
                                                    offsetx = other.offsetx;
                                                    offsety = other.offsety;                                                    
                                                }
                                                                                                
                                    }                                                                                         
                            }
                        for (column = 0; column < 8; column +=1)           //now iterate through each column from south edge up
                            {       
                                count = count + irandom_range(-1, 2)
                                count = clamp(count, minweespike, clampmax)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down 
                                weeblock[column, 7] = 17        //first block is always an indestruct wee block                                
                                for (c = 1; c < count+1; c +=1)
                                        {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if weeblock[column, 7-c] == 0 && c < count && blockswitch == 0 weeblock[column, 7-c] = 18
                                                      if weeblock[column, 7-c] == 0 && c == count && blockswitch == 0 weeblock[column, 7-c] = 5
                                                      
                                                      //goldtests
                                                      if weeblock[column, 7-c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count weeblock[column, 7-c] = 3
                                                              if gold > 0 && c == count weeblock[column, 7-c] = 34
                                                              if gold == 0 && c < count
                                                                  {
                                                                      weeblock[column, 7-c] = 30
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, 7-c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, 7-c] = 26
                                                      vines +=1
                                                      }                                                      
                                                      if weeblock[column, 7-c] == 0 && c < count && blockswitch == 2 weeblock[column, 7-c] = 8
                                                      if weeblock[column, 7-c] == 0 && c == count && blockswitch == 2 weeblock[column, 7-c] = 10
                                        }
                                if random(1) < gauntdensity
                                    {
                                        var inst
                                        inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + column * 4 * global.RM  + 0, 64 * global.RM  + (by *32 * global.RM ) + ((7-c) *4 * global.RM ) - 10 * global.RM , obj_gaunt);
                                        with (inst)
                                            {
                                                image_angle = 90
                                            }                                                    
                                    }
                                if random(1) < sporedensity
                                    {
                                        var inst
                                        inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + column * 4 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + ((7-c) *4 * global.RM ), obj_spawn)
                                                script_execute(scr_sporeoffset, sporeoffsetdistance, sporeoffsetangle);                                                      
                                                with(inst)
                                                {
                                                    image_angle = 90
                                                    offsetx = other.offsetx;
                                                    offsety = other.offsety;                                                    
                                                }                                                  
                                                                                                                  
                                            
                                    }                                                      
                            }
                    }               
              
                if blocktest == -6           // East and West
                    {
                        count = 1
                        clampmax = maxweespike;
                        localvinechance = vinechance;
                        for (row = 0; row < 8; row +=1)           //iterate through each row from east side in
                            {

                                count = count + irandom_range(-1, 2)
                                count = clamp(count, minweespike, clampmax)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down 
                                weeblock[7, row] = 21        //first block is always an indestruct wee block
                                                 
                                for (c = 1; c < count+1; c +=1)     //east to west first
                                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if weeblock[7-c, row] == 0 && c < count && blockswitch == 0 weeblock[7-c, row] = 23
                                                      if weeblock[7-c, row] == 0 && c == count && blockswitch == 0 weeblock[7-c, row] = 7
                                                      
                                                      //goldtests
                                                      if weeblock[7-c, row] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                            if gold > 0 && c < count weeblock[7-c, row] = 3
                                                            if gold > 0 && c == count weeblock[7-c, row] = 35
                                                            if gold == 0 && c < count
                                                                {
                                                                    weeblock[7-c, row] = 31
                                                                    gold += 1;
                                                                }
                                                            goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[7-c, row] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[7-c, row] = 27
                                                      vines +=1
                                                      }                                                      
                                                      if weeblock[7-c, row] == 0 && c < count && blockswitch == 2 weeblock[7-c, row] = 8
                                                      if weeblock[7-c, row] == 0 && c == count && blockswitch == 2 weeblock[7-c, row] = 12
                                                    }
                                    if random(1) < gauntdensity
                                        {
                                            var inst
                                            inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + (7-c) * 4 * global.RM  - 10 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + (row *4 * global.RM ) + 0, obj_gaunt);
                                            with (inst)
                                                {
                                                    image_angle = 180
                                                }                                                    
                                        }
                                if random(1) < sporedensity
                                    {
                                        var inst
                                        inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + (7-c) * 4 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + (row *4 * global.RM ), obj_spawn)
                                                script_execute(scr_sporeoffset, sporeoffsetdistance, sporeoffsetangle);                                                
                                                with(inst)
                                                {
                                                    image_angle = 180
                                                    offsetx = other.offsetx;
                                                    offsety = other.offsety;                                                    
                                                }                                                  
                                                                                                                                             
                                    }
                            }
                        localvinechance = vinechance;    
                        for (row = 0; row < 8; row +=1)           //iterate through each column from west side in
                            {
                                clampmax = maxweespike + 3   
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, minweespike, clampmax)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down 
                                weeblock[0, row] = 22        //first block is always an indestruct wee block
                                                 
                                for (c = 1; c < count+1; c +=1)
                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                       if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if weeblock[c, row] == 0 && c < count && blockswitch == 0 weeblock[c, row] = 24
                                                      if weeblock[c, row] == 0 && c == count && blockswitch == 0 weeblock[c, row] = 6
                                                      
                                                      //goldtests
                                                      if weeblock[c, row] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                                if gold > 0 && c < count weeblock[c, row] = 3
                                                                if gold > 0 && c == count weeblock[c, row] = 36
                                                                if gold == 0 && c < count
                                                                    {
                                                                        weeblock[c, row] = 32
                                                                        gold += 1;
                                                                    }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[c, row] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[c, row] = 28
                                                      vines +=1
                                                      }                                                      
                                                      if weeblock[c, row] == 0 && c < count && blockswitch == 2 weeblock[c, row] = 8
                                                      if weeblock[c, row] == 0 && c == count && blockswitch == 2 weeblock[c, row] = 11
                                    }
                                if random(1) < gauntdensity
                                        {
                                            var inst
                                            inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + (c) * 4 * global.RM  + 10 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + (row *4 * global.RM ) + 0, obj_gaunt);
                                            with (inst)
                                                {
                                                    image_angle = 0
                                                }                                                    
                                        }
                                if random(1) < sporedensity
                                    {
                                        var inst
                                        inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + (c) * 4 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + (row *4 * global.RM ), obj_spawn)
                                                script_execute(scr_sporeoffset, sporeoffsetdistance, sporeoffsetangle);                                                      
                                                with(inst)
                                                {
                                                    image_angle = 0
                                                    offsetx = other.offsetx;
                                                    offsety = other.offsety;                                                    
                                                }
                                                                                                
                                    }                                                                                                  
                            }
                }              

                if blocktest == -7           // North and West
                    {
                        count = 1
                        clampmax = 1;
                        localvinechance = vinechance;
                        for (column = 7; column > -1; column -=1)           //iterate through each column from north edge down- reverse, west to east
                            {
                                count = count + irandom_range(0, 2)   //counting up only as corner
                                count = clamp(count, minweespike, clampmax)
                                clampmax += 1
                                if clampmax >=8 clampmax = 8 
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down       
                                for (c = 0; c < count; c +=1)
                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if count > 1 && weeblock[column, c] == 0 && c < count-3 && blockswitch == 0 weeblock[column, c] = 1                                                      
                                                      if count > 1 && weeblock[column, c] == 0 && c == count-3 && blockswitch == 0 weeblock[column, c] = 16
                                                      if count > 1 && weeblock[column, c] == 0 && c == count-2 && blockswitch == 0 weeblock[column, c] = 14                                                      
                                                      if count > 1 && weeblock[column, c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, c] = 4
                                                      if count <= 1 && weeblock[column, c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, c] = 16
                                                                                                            
                                                      //goldtests
                                                      if weeblock[column, c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count weeblock[column, c] = 3
                                                              if gold > 0 && c == count weeblock[column, c] = 33
                                                              if gold == 0 && c < count
                                                                  {
                                                                      weeblock[column, c] = 29
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, c] = 25      // vine
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[column, c] == 0 && c < count-1 && blockswitch == 2 weeblock[column, c] = 8      // vine
                                                      if weeblock[column, c] == 0 && c == count-1 && blockswitch == 2 weeblock[column, c] = 9     //end cap
                                    }                   
                            }
                   }                     

                if blocktest == -8           // North and East
                    {
                        count = 1
                        clampmax = 1;
                        localvinechance = vinechance;
                        for (column = 0; column < 8; column +=1)           //iterate through each column from north edge down
                            {

                                count = count + irandom_range(0, 2)   //counting up only as corner
                                count = clamp(count, minweespike, clampmax)
                                clampmax +=1
                                if clampmax >=8 clampmax =8 
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down                                  
                                for (c = 0; c < count; c +=1)
                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if count > 1 && weeblock[column, c] == 0 && c < count-3 && blockswitch == 0 weeblock[column, c] = 1                                                      
                                                      if count > 1 && weeblock[column, c] == 0 && c == count-3 && blockswitch == 0 weeblock[column, c] = 15
                                                      if count > 1 && weeblock[column, c] == 0 && c == count-2 && blockswitch == 0 weeblock[column, c] = 14                                                      
                                                      if count > 1 && weeblock[column, c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, c] = 4
                                                      if count <= 1 && weeblock[column, c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, c] = 15
                                                                                                            
                                                      //goldtests
                                                      if weeblock[column, c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count-1 weeblock[column, c] = 3
                                                              if gold > 0 && c == count-1 weeblock[column, c] = 33
                                                              if gold == 0 && c < count-1
                                                                  {
                                                                      weeblock[column, c] = 29
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, c] = 25      // vine
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[column, c] == 0 && c < count-1 && blockswitch == 2 weeblock[column, c] = 8      // vine
                                                      if weeblock[column, c] == 0 && c == count-1 && blockswitch == 2 weeblock[column, c] = 9     //end cap
                                    }                    
                            }
                    }                     
                    
                if blocktest == -9           // South and West
                    {
                        count = 1
                        clampmax = 1
                        localvinechance = vinechance;
                        for (column = 7; column > -1; column -=1)           //iterate through each column from south edge up- reverse, west to east
                            {
                                count = count + irandom_range(0, 2)   //counting up only as corner
                                count = clamp(count, minweespike, clampmax)
                                clampmax +=1
                                if clampmax >=8 clampmax =8 
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down 
                                for (c = 0; c < count; c +=1)
                                        {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c < count-3 && blockswitch == 0 weeblock[column, 7-c] = 1                                                      
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count-3 && blockswitch == 0 weeblock[column, 7-c] = 20
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count-2 && blockswitch == 0 weeblock[column, 7-c] = 18                                                      
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, 7-c] = 5
                                                      if count <= 1 && weeblock[column, 7-c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, 7-c] = 20
                                                                                                            
                                                      //goldtests
                                                      if weeblock[column, 7-c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count-1 weeblock[column, 7-c] = 3
                                                              if gold > 0 && c == count-1 weeblock[column, 7-c] = 34
                                                              if gold == 0 && c < count-1
                                                                  {
                                                                      weeblock[column, 7-c] = 30
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, 7-c] == 0 && vines == 0 && blockswitch == 2 
                                                      {
                                                      weeblock[column, 7-c] = 26
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[column, 7-c] == 0 && c < count-1 && blockswitch == 2 weeblock[column, 7-c] = 8
                                                      if weeblock[column, 7-c] == 0 && c == count-1 && blockswitch == 2 weeblock[column, 7-c] = 10
                                        }                     
                            }
                    }                     

                if blocktest == -10           // South and East
                    {
                        count = 1
                        clampmax = 1
                        localvinechance = vinechance;
                        for (column = 0; column < 8; column +=1)           //iterate through each column from south edge up
                            {

                                count = count + irandom_range(0, 2)   //counting up only as corner
                                count = clamp(count, minweespike, clampmax)
                                clampmax +=1
                                if clampmax >=8 clampmax =8 
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down                     
                                for (c = 0; c < count; c +=1)
                                        {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c < count-3 && blockswitch == 0 weeblock[column, 7-c] = 1                                                      
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count-3 && blockswitch == 0 weeblock[column, 7-c] = 19
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count-2 && blockswitch == 0 weeblock[column, 7-c] = 18                                                      
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, 7-c] = 5
                                                      if count <= 1 && weeblock[column, 7-c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, 7-c] = 19
                                                                                                            
                                                      //goldtests
                                                      if weeblock[column, 7-c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count-1 weeblock[column, 7-c] = 3
                                                              if gold > 0 && c == count-1 weeblock[column, 7-c] = 34
                                                              if gold == 0 && c < count-1
                                                                  {
                                                                      weeblock[column, 7-c] = 30
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, 7-c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, 7-c] = 26
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[column, 7-c] == 0 && c < count-1 && blockswitch == 2 weeblock[column, 7-c] = 8
                                                      if weeblock[column, 7-c] == 0 && c == count-1 && blockswitch == 2 weeblock[column, 7-c] = 10
                                        }                     
                            }
                    }                      
                                        
                 if blocktest == -11           // North, South and East 
                    {
                        count = irandom_range(maxweespike, maxweespike + 3)
                        clampmax = maxweespike + 3
                        localvinechance = vinechance;
                        for (row = 0; row < 8; row +=1)           //iterate through each row
                            {
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, 5, 7)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down   
                                for (c = 0; c < count+1; c +=1)
                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if count > 1 && weeblock[7-c, row] == 0 && c < count-2 && blockswitch == 0 weeblock[7-c, row] = 1                                                      
                                                      if count > 1 && weeblock[7-c, row] == 0 && c == count-2 && blockswitch == 0 weeblock[7-c, row] = 21
                                                      if count > 1 && weeblock[7-c, row] == 0 && c == count-1 && blockswitch == 0 weeblock[7-c, row] = 23                                                      
                                                      if count > 1 && weeblock[7-c, row] == 0 && c == count && blockswitch == 0 weeblock[7-c, row] = 7
                                                      if count <= 1 && weeblock[7-c, row] == 0 && c == count && blockswitch == 0 weeblock[7-c, row] = 21
                                                                                                            
                                                      //goldtests
                                                      if weeblock[7-c, row] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                            if gold > 0 && c < count weeblock[7-c, row] = 3
                                                            if gold > 0 && c == count weeblock[7-c, row] = 35
                                                            if gold == 0 && c < count
                                                                {
                                                                    weeblock[7-c, row] = 31
                                                                    gold += 1;
                                                                }
                                                            goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[7-c, row] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[7-c, row] = 27
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[7-c, row] == 0 && c < count && blockswitch == 2 weeblock[7-c, row] = 8
                                                      if weeblock[7-c, row] == 0 && c == count && blockswitch == 2 weeblock[7-c, row] = 12
                                    }                    
                        }
                    } 
                    
                if blocktest == -12           // North, East and West
                    {
                        count = irandom_range(maxweespike, maxweespike + 3)
                        clampmax = maxweespike + 3
                        localvinechance = vinechance;
                        for (column = 0; column < 8; column +=1)           //iterate through each column from north edge down
                            {
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, 5, 7)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down                                   
                                for (c = 0; c < count+1; c +=1)
                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if count > 1 && weeblock[column, c] == 0 && c < count-2 && blockswitch == 0 weeblock[column, c] = 1                                                      
                                                      if count > 1 && weeblock[column, c] == 0 && c == count-2 && blockswitch == 0 weeblock[column, c] = 13
                                                      if count > 1 && weeblock[column, c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, c] = 14                                                      
                                                      if count > 1 && weeblock[column, c] == 0 && c == count && blockswitch == 0 weeblock[column, c] = 4
                                                      if count <= 1 && weeblock[column, c] == 0 && c == count && blockswitch == 0 weeblock[column, c] = 13
                                                                                                            
                                                      //goldtests
                                                      if weeblock[column, c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count weeblock[column, c] = 3
                                                              if gold > 0 && c == count weeblock[column, c] = 33
                                                              if gold == 0 && c < count
                                                                  {
                                                                      weeblock[column, c] = 29
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, c] = 25      // vine
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[column, c] == 0 && c < count && blockswitch == 2 weeblock[column, c] = 8      // vine
                                                      if weeblock[column, c] == 0 && c == count && blockswitch == 2 weeblock[column, c] = 9     //end cap
                                    }                   
                            }
                    }                    

                if blocktest == -13           // South, East and West
                    {
                        count = irandom_range(maxweespike, maxweespike + 3)
                        clampmax = maxweespike + 3
                        localvinechance = vinechance;
                        for (column = 0; column < 8; column +=1)           //iterate through each column from south edge up
                            {
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, 5, 7)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down                                
                                for (c = 0; c < count+1; c +=1)
                                        {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c < count-2 && blockswitch == 0 weeblock[column, 7-c] = 1                                                      
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count-2 && blockswitch == 0 weeblock[column, 7-c] = 17
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count-1 && blockswitch == 0 weeblock[column, 7-c] = 18                                                      
                                                      if count > 1 && weeblock[column, 7-c] == 0 && c == count && blockswitch == 0 weeblock[column, 7-c] = 5
                                                      if count <= 1 && weeblock[column, 7-c] == 0 && c == count && blockswitch == 0 weeblock[column, 7-c] = 17
                                                                                                            
                                                      //goldtests
                                                      if weeblock[column, 7-c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              if gold > 0 && c < count weeblock[column, 7-c] = 3
                                                              if gold > 0 && c == count weeblock[column, 7-c] = 34
                                                              if gold == 0 && c < count
                                                                  {
                                                                      weeblock[column, 7-c] = 30
                                                                      gold += 1;
                                                                  }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[column, 7-c] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[column, 7-c] = 26
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[column, 7-c] == 0 && c < count && blockswitch == 2 weeblock[column, 7-c] = 8
                                                      if weeblock[column, 7-c] == 0 && c == count && blockswitch == 2 weeblock[column, 7-c] = 10
                                        }                    
                            }
                    }                    

                    
            if blocktest == -14           // North, South and West 
                    {
                        count = irandom_range(maxweespike, maxweespike + 3)
                        clampmax = maxweespike + 3
                        localvinechance = vinechance;
                        for (row = 0; row < 8; row +=1)           //iterate through each row
                            {
                                count = count + irandom_range(-1, 1)
                                count = clamp(count, 5, 7)
                                blockswitch = 0;        //wee blocks
                                vines = 0;         //used to test first vine placed down
                                gold = 0;          //used to test first gold placed down                                    
                                for (c = 0; c < count+1; c +=1)
                                    {
                                                      if blockswitch == 0 && goldcount > 0 && c >= count * goldthreshold blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < localvinechance && c >= count * vinethreshold
                                                          {
                                                            blockswitch = 2       //switch to vines for rest of column
                                                            localvinechance = vinechance *2;
                                                          }
                                                      
                                                      //weeblock tests
                                                      if count > 1 && weeblock[c, row] == 0 && c < count-2 && blockswitch == 0 weeblock[c, row] = 1                                                      
                                                      if count > 1 && weeblock[c, row] == 0 && c == count-2 && blockswitch == 0 weeblock[c, row] = 22
                                                      if count > 1 && weeblock[c, row] == 0 && c == count-1 && blockswitch == 0 weeblock[c, row] = 24                                                      
                                                      if count > 1 && weeblock[c, row] == 0 && c == count && blockswitch == 0 weeblock[c, row] = 6
                                                      if count <= 1 && weeblock[c, row] == 0 && c == count && blockswitch == 0 weeblock[c, row] = 22
                                                                                                            
                                                      //goldtests
                                                      if weeblock[c, row] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                                if gold > 0 && c < count weeblock[c, row] = 3
                                                                if gold > 0 && c == count weeblock[c, row] = 36
                                                                if gold == 0 && c < count
                                                                    {
                                                                        weeblock[c, row] = 32
                                                                        gold += 1;
                                                                    }
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //vine tests
                                                      if weeblock[c, row] == 0 && vines == 0 && blockswitch == 2
                                                      {
                                                      weeblock[c, row] = 28
                                                      vines +=1
                                                      }                                                     
                                                      if weeblock[c, row] == 0 && c < count && blockswitch == 2 weeblock[c, row] = 8
                                                      if weeblock[c, row] == 0 && c == count && blockswitch == 2 weeblock[c, row] = 11
                                    }                    
                            }
                    }                    
                    
                    
                    
                                        
//----------------------------------------------------------------------------------------------                          
                                    
                               //now we have an array for new wee blocks- draw them
                               for (wbu = 0; wbu < 8; wbu +=1)
                                {
                                    for (wbv = 0; wbv < 8; wbv +=1)
                                        {
                
                                            if weeblock[wbu , wbv] != 0
                                                {
                                                    type = weeblock[wbu , wbv];
                                                    inst = instance_create( 64 * global.RM  + (bx * 32 * global.RM ) + wbu * 4 * global.RM , 64 * global.RM  + (by *32 * global.RM ) + wbv *4 * global.RM , weeblocktype[type]);
                                                    //show_debug_message("adding weeblock " + string(type));
                                                    instance_deactivate_object(inst);  
                                                }
                                                                                                                          
                                        }
                                }
                  
                  goldcount -=1;
                                   
                                                          
                                        


#define scr_addAsteroids_B

// first check neighbours- true means huge block in that adjacent square
north = false;
south = false;
east = false;
west = false;
totalspawnpoints = 0;


if u> 0 && bigblock[u-1, v] <= 0 west = true;
if u< gridsize-1 && bigblock[u+1, v] <= 0 east = true;
if v> 0 && bigblock[u, v-1] <= 0 north = true;
if v< gridsize-1 && bigblock[u, v+1] <= 0 south = true;
if u == 0 west = true;
if u = gridsize-1 east = true;
if v == 0 north = true;
if v = gridsize-1 south = true;


// DEBUG ONLY
//if north == true instance_create(u *384 + 64 + 192, v * 384, debug_N);
//if south == true instance_create(u *384 + 64 + 192, v * 384+340, debug_S);
//if east == true instance_create(u *384 + 64 + 340, v * 384 + 192, debug_E);
//if west == true instance_create(u *384 + 64, v * 384 + 192, debug_W);

if north == false && south == false && east == false && west == false
    {
    
    // create an array for 36 positions
    i = 1;
    for (s = 1; s < 7; s +=1)
        {
            for (t = 1; t < 7; t +=1)
            {
                spawnpointx[i] = u *384 * global.RM  + 64 * global.RM  + t*48 * global.RM  + 24 * global.RM  + 16 * global.RM  + irandom_range(-8 * global.RM , 8 * global.RM );
                spawnpointy[i] = v *384 * global.RM  + 64 * global.RM  + s*48 * global.RM  + 24 * global.RM  + 16 * global.RM + irandom_range(-8 * global.RM , 8 * global.RM );
                i += 1;
            }
            totalspawnpoints = 36
        }
    }



if north == true && south == true && totalspawnpoints == 0
    {
    
    // create an array with 1 position

                spawnpointx[1] = u *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + 16 * global.RM  + irandom_range(-16 * global.RM , 16 * global.RM );
                spawnpointy[1] = v *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + 16 * global.RM  + irandom_range(-16 * global.RM , 16 * global.RM );

            totalspawnpoints = 1

    }

if east == true && west == true && totalspawnpoints == 0
    {
    
    // create an array with 1 position

                spawnpointx[1] = u *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + 16 * global.RM  + irandom_range(-16 * global.RM , 16 * global.RM );
                spawnpointy[1] = v *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + 16 + irandom_range(-16 * global.RM , 16 * global.RM );

            totalspawnpoints = 1
    }

if north == true && south == false && totalspawnpoints == 0
    {
    
        // create an array with 4 position
        for (t = 0; t <5; t +=1)
            {

                spawnpointx[t] = u *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + 16 * global.RM  + irandom_range(-24 * global.RM , 24 * global.RM );
                spawnpointy[t] = v *384 * global.RM  + 64 * global.RM  + 144 * global.RM  + t*40 * global.RM  + 16 * global.RM ;
            }

            totalspawnpoints = 4

    }    

if north == false && south == true && totalspawnpoints == 0
    {
    
        // create an array with 4 position
        for (t = 0; t <5; t +=1)
            {

                spawnpointx[t] = u *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + 16 * global.RM  + irandom_range(-24 * global.RM , 24 * global.RM );
                spawnpointy[t] = v *384 * global.RM  + 64 * global.RM  + t*40 * global.RM  + 16 * global.RM ;
            }

            totalspawnpoints = 4

    }     

if west == true && east == false && totalspawnpoints == 0
    {
    
        // create an array with 4 position
        for (t = 0; t <5; t +=1)
            {

                spawnpointx[t] = u *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + t*40 * global.RM  + 16 * global.RM;
                spawnpointy[t] = v *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + 16 * global.RM  + irandom_range(-24 * global.RM , 24 * global.RM );
            }

            totalspawnpoints = 4

    }     

if west == false && east == true && totalspawnpoints == 0
    {
    
        // create an array with 4 position
        for (t = 0; t <5; t +=1)
            {

                spawnpointx[t] = u *384 * global.RM  + 64 * global.RM  + t*40 * global.RM  + 16 * global.RM ;
                spawnpointy[t] = v *384 * global.RM  + 64 * global.RM  + 192 * global.RM  + 16 * global.RM  + irandom_range(-24 * global.RM , 24 * global.RM );
            }

            totalspawnpoints = 4

    }    
    
    
    
        
if totalspawnpoints > 0
{   
    var count;
    ///instance_activate_all()   
    for (count = 1; count < totalspawnpoints + 1; count +=1)
        {
            //instance_create(spawnpointx[count], spawnpointy[count], obj_debug);
            check = random(1);
            if totalspawnpoints == 1 check *= 0.25
            if totalspawnpoints > 5 check *= 3
            instance_activate_region(spawnpointx[count]-192 * global.RM , spawnpointy[count]-192 * global.RM , 384 * global.RM , 384 * global.RM , true);
            colcheck = collision_circle(spawnpointx[count], spawnpointy[count], 24 * global.RM , obj_block, false, true)
            if check < goldnuggetchance && colcheck == noone
                {
                    instance_create(spawnpointx[count]+8 * global.RM , spawnpointy[count]-20 * global.RM , oLightSourceAsteroid);
                    instance_create(spawnpointx[count], spawnpointy[count], obj_goldnugget);
                    
                    check = 2;
                }
            if check < glassasteroidchance && colcheck == noone
                {
                    instance_create(spawnpointx[count]+8 * global.RM , spawnpointy[count]-20 * global.RM , oLightSourceAsteroid);
                    instance_create(spawnpointx[count], spawnpointy[count], obj_glassasteroid);
                    
                    check = 2;
                }                
            if check < goldasteroidchance && colcheck == noone
                {
                    instance_create(spawnpointx[count]+8 * global.RM , spawnpointy[count]-20 * global.RM , oLightSourceAsteroid);
                    instance_create(spawnpointx[count], spawnpointy[count], obj_goldasteroid);
                    
                    check = 2;
                }
            if check < asteroidchance && colcheck == noone
                {
                    instance_create(spawnpointx[count]+8 * global.RM , spawnpointy[count]-20 * global.RM , oLightSourceAsteroid);
                    instance_create(spawnpointx[count], spawnpointy[count], obj_asteroid);
                    
                }
            //instance_deactivate_region(spawnpointx[count]-192, spawnpointy[count]-192, 384, 384, true, true);
        
        }
    //instance_deactivate_all(true);                
}



#define script49
offsetx = lengthdir_x(sporeoffsetdistance, sporeoffsetangle);
offsety = lengthdir_y(sporeoffsetdistance, sporeoffsetangle);
sporeoffsetangle +=30
if sporeoffsetangle >= 360     //set a circle of offset points around the leader- incrementing with each one
    {
        sporeoffsetangle = 0;
        sporeoffsetdistance +=24 * global.RM ;
    }
#define scr_genMap_old
                // set up an array for weeblock types
        var i;
         i = 11;
         repeat(12)
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

// Initialise 8 x 8 Array- all set to 0 (place block)

ax = 0;
ay = 0;
 
for (i = 0; i < gridsize; i +=1)
    {
     repeat(gridsize)
        {
        bigblock[ax, ay] = 0;
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
                //show_debug_message("into clear space");
            }
        if walk_y + 1 < gridsize && bigblock[walk_x, walk_y + 1] != 5  && innerloop != true && downlast == true    //move down if last move was down
            {
                walk_y += 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                //show_debug_message("headed down");
                downlast = false;            
            }
        if walk_x + 1 < gridsize && bigblock[walk_x + 1, walk_y] != 5 && innerloop != true    //move right
            {
                walk_x += 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                //show_debug_message("headed right");        
            }
        if walk_x - 1 > 0 && bigblock[walk_x - 1 , walk_y] != 5  && innerloop != true    //move left
            {
                walk_x -= 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                //show_debug_message("headed left");              
            }
        if walk_y + 1 < gridsize && bigblock[walk_x, walk_y + 1] != 5  && innerloop != true && downlast == false    //move down
            {
                walk_y += 1 
                innerloop = true;
                bigblock[walk_x, walk_y] = 5;
                //show_debug_message("headed down");
                downlast = true;            
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
    
            if bigblock[u , v] == 0
                {
                instance_create( u * 384+64, v * 384+64, obj_hugeblock);
              
                }
      
        }
    }
    

//Now iterate through each space big block & add normal blocks based upon adjacent big blocks
    
for (u = 0; u < gridsize; u +=1)
    {
        for (v = 0; v < gridsize; v +=1)
        {
            script_execute(scr_genBlocks_new, u, v, bigblock[u,v], gridsize, starthuge, endhuge)
            //show_debug_message("Big Block Done " + string(u) + " , " + string(v)); 
             
        }

    }    


// Now do an additional pass of adding wee blocks based upon whether there is a neighbouring block along a border edge
for (u = 0; u < gridsize; u +=1)
    {
        for (v = 0; v < gridsize; v +=1)
        {
            //if random(1) < goldchance goldcount = round(random_range(1, goldspread))          //set a counter if next few blocks worth of weeblocks are to be gold        
            script_execute(scr_addEdgeblocks_new, u, v, bigblock[u,v]);
            //script_execute(oldedgeblock, u, v, bigblock[u,v]);
            }
    }

//Now add asteroids- iterate through big blocks looking for emptys
for (u = 0; u < gridsize; u +=1)
    {
        for (v = 0; v < gridsize; v +=1)
        {
    
            if bigblock[u , v] != 0
                {
                script_execute(scr_addAsteroids, u, v)
              
                }
      
        }
    }
    
    
//generate outer border

for (u =0; u < bordersize+2; u+=1)
    {
                instance_create(u*64, 0, obj_borderblock)
                instance_create(u*64, gridsize*384+64, obj_borderblock)
    }

for (u =0 u < bordersize+2; u+=1)
    {
                instance_create(0, u*64, obj_borderblock)
                instance_create(gridsize*384+64,u*64 , obj_borderblock)
    }


// caculate start and exit points for the map- in centre of each huge empty square (plus border of 64)
global.startx = starthuge * 384 + 182 + 64;
global.starty = 16;
global.exitx = endhuge * 384 + 182 + 64;
global.exity = gridsize * 384 + 128 - 32;

// now remove borderblocks at start and exit
position_destroy(global.startx, global.starty);
position_destroy(global.startx-64, global.starty);
position_destroy(global.startx+64, global.starty);
position_destroy(global.exitx, global.exity);
position_destroy(global.exitx-64, global.exity);
position_destroy(global.exitx+64, global.exity);    
    
    
 
// now iterate through enemies and remove any that are surrounded on four sides with blocks, replacing them with solid block
with (obj_fixedgunbase)
    {
    en = 0;
    es = 0;
    ee = 0;
    ew = 0;
    enemyblocked = false;
    
    
    if position_meeting(x, y-48, obj_newblock) || position_meeting(x, y-48, obj_hugeblock) || position_meeting(x, y-48, obj_borderblock) || position_meeting(x, y-48, obj_fixedgunbase) en =1;
    if position_meeting(x, y+48, obj_newblock) || position_meeting(x, y+48, obj_hugeblock) || position_meeting(x, y+48, obj_borderblock) || position_meeting(x, y+48, obj_fixedgunbase) es =1;
    if position_meeting(x+48, y, obj_newblock) || position_meeting(x+48, y, obj_hugeblock) || position_meeting(x+48, y, obj_borderblock) || position_meeting(x+48, y, obj_fixedgunbase) ee =1;    
    if position_meeting(x-48, y, obj_newblock) || position_meeting(x+48, y, obj_hugeblock) || position_meeting(x+48, y, obj_borderblock) || position_meeting(x+48, y, obj_fixedgunbase) ew =1;

    

//        instance_create(x, y-48, obj_debug);
//        instance_create(x, y+48, obj_debug);
//        instance_create(x+48, y, obj_debug);
//        instance_create(x-48, y, obj_debug);
//        show_debug_message(string(en) + string(es) + string(ee) + string(ew));

if position_meeting(x+ lengthdir_x(48, image_angle), y+ lengthdir_y(48, image_angle), obj_newblock) enemyblocked = true;


    
    if en == 1 && es == 1 && ee == 1 && ew == 1 enemyblocked = true
    
    if enemyblocked == true
        {
            nx = (floor((x-64)/48))*48 + 64;
            ny = (floor((y-64)/48))*48 + 64;
            show_debug_message("nx: " + string(nx) + " ,ny: " + string(ny));
            //image_speed = 1;
            instance_destroy();
            instance_create(nx, ny, obj_newblock);       
        }
     
         
        
        
              
    }






                       
                         
                           

#define scr_genBlocks_new

// Array Block Guide
// 0 = empty
// 1 = block
// 3 = enemy on south edge
// 4 = enemy on north edge
// 5 = enemy on east edge
// 6 = enemy on west edge


if bigblock[u , v] != 0
            //show_debug_message("Space found square-");
            {
                // Empty space block found, now check adjacent squares- four axes n,s,e,w 0 or 1 depending if have an adjacent edge
                bn = 0;
                be = 0;
                bs = 0;
                bw = 0;

            // edge squares- set to 2 so always add a block here (outer borders of map) unless at start sqaure
                if u == 0 bw = 2;
                if u == gridsize-1 be = 2;
                if v == 0 bn = 2;
                if v == gridsize-1 bs = 2;                
                           
                if  bw != 2 && bigblock [u-1, v] == 0 bw = 1
                if  be != 2 && bigblock [u+1, v] == 0 be = 1
                if  bn != 2 && bigblock [u, v-1] == 0 bn = 1
                if  bs != 2 && bigblock [u, v+1] == 0 bs = 1

                if v == 0 && u == starthuge bn = 0;
                if v == gridsize-1 && u == endhuge bs = 0;  
                  
                               
                if bw !=0 || be !=0 || bn !=0 || bs !=0                             // we have at least one external edge- so time to add blocks inside             
                    {
                    
                    //show_debug_message("Space found square-" + string(bigblock[u,v]) + " North:" + string(bn) + " South:" + string(bs) + " East:" + string(be) + " West:" + string(bw));   
                    
                    // Initialise 8 x 8 Block Array- (0 = no block)
    
                    bu = 0;
                    bv = 0;
         
                    for (i = 0; i < 8; i +=1)
                        {
                            repeat(8)
                            {
                                block[bu, bv] = 0;
                                //show_debug_message(string(bu) + " , " + string(bv));
                                bu += 1;
                            }
                            bu = 0;        
                            bv += 1;          
                        }
                        if bn == 2
                            {
                            for (column = 0; column < 8; column +=1)           //iterate through each column and add one block- map border
                                    {
                                        if block[column, 0] == 0 block[column, 0] = 1     //if block is empty add one
                                    }
                            
                            }
                        if bn != 0
                            {
                                count = spikyness;

                                
                                for (column = 0; column < 8; column +=1)           //iterate through each column from north edge down
                                    {
                                         count = count + round(random_range(-1, 1))
                                         count = clamp(count, minspike, maxspike)
                                         for (c = 0; c < count; c +=1)
                                            {
                                              if block[column, c] == 0 block[column, c] = 1     //if block is empty add one
                                            }
                                         enemyspawn = random(1);
                                         if enemyspawn <= enemychance block[column, c] = 4     //if last block is empty and random chance add enemy
                                    }

                            }

                        if bs == 2
                            {
                            for (column = 0; column < 8; column +=1)           //iterate through each column and add one block- map border
                                    {
                                        if block[column, 7] == 0 block[column, 7] = 1     //if block is empty add one
                                    }
                            
                            }                            
                                                    
                        if bs != 0
                            {
                                count = spikyness;

                                for (column = 0; column < 8; column +=1)           //iterate through each column from south edge up
                                    {
                                         count = count + round(random_range(-2, 2))
                                         count = clamp(count, minspike, maxspike)
                                         for (c = 0; c < count; c +=1)
                                            {

                                                if block[column, 7-c] == 0 block[column, 7-c] = 1     //if block is empty add one

                                            }
                                        enemyspawn = random(1);
                                        if enemyspawn <= enemychance block[column, 7-c] = 3     //if last block is empty and random chance add enemy
                                    }
                            }
                            
                        if bw == 2
                            {
                            for (row = 0; row < 8; row +=1)           //iterate through each column and add one block- map border
                                    {
                                        if block[0, row] == 0 block[0, row] = 1     //if block is empty add one
                                    }
                            
                            }
                                                                    
                        if bw != 0
                            {
                                count = spikyness;
                                
                                for (row = 0; row < 8; row +=1)           //iterate through each row from west edge left
                                    {
                                         count = count + round(random_range(-1, 1))
                                         count = clamp(count, minspike, maxspike)
                                         for (c = 0; c < count; c +=1)
                                            {
                                              if block[c, row] == 0 block[c, row] = 1     //if block is empty add one
                                            }
                                        enemyspawn = random(1);
                                        if enemyspawn <= enemychance block[c, row] = 6     //if last block is empty and random chance add enemy
                                    }
                            }
                            
                        if be == 2
                            {
                            for (row = 0; row < 8; row +=1)           //iterate through each column and add one block- map border
                                    {
                                        if block[7, row] == 0 block[7, row] = 1     //if block is empty add one
                                    }
                            
                            }                            
                                                                        
                        if be != 0
                            {
                                count = spikyness;
                                
                                for (row = 0; row < 8; row +=1)           //iterate through each row from east edge right
                                    {
                                         count = count + round(random_range(-1, 1))
                                         count = clamp(count, minspike, maxspike)
                                         for (c = 0; c < count; c +=1)
                                            {
                                              if block[7-c, row] == 0 block[7-c, row] = 1     //if block is empty add one
                                            }
                                        enemyspawn = random(1);
                                        if enemyspawn <= enemychance block[7-c, row] = 5     //if last block is empty and random chance add enemy
                                    }
                            }                
                    
                            
                       //now we have an array for new blocks- draw them
                       for (bu = 0; bu < 8; bu +=1)
                        {
                            for (bv = 0; bv < 8; bv +=1)
                                {
        
                                    if block[bu , bv] == 1
                                        {
                                            instance_create( u * 384+64 + bu *48, v * 384+64 + bv *48, obj_newblock);
                  
                                        }
                                    if block[bu , bv] == 3      //enemy on south side facing up
                                        {

                                            with(instance_create( u * 384+64 + bu *48 +24, v * 384+64 + bv *48 +32, obj_fixedgunbase))
                                                {
                                                    image_angle = 90;
                                                }
                                              
                  
                                        }
                                    if block[bu , bv] == 4      //enemy on north side facing down
                                        {
                                            with(instance_create( u * 384+64 + bu *48 + 24, v * 384+64 + bv *48 + 16, obj_fixedgunbase))
                                                {
                                                    image_angle = 270;
                                                    
                                                }

                                        }
                                    if block[bu , bv] == 5      //enemy on west side facing east
                                        {
                                          with(instance_create( u * 384+64 + bu *48 + 32, v * 384+64 + bv *48 + 24, obj_fixedgunbase))
                                                {
                                                image_angle = 180;
                                                }

                                        }
                                    if block[bu , bv] == 6      //enemy on east side facing west
                                        {
                                          with(instance_create( u * 384+64 + bu *48 + 16, v * 384+64 + bv *48 + 24, obj_fixedgunbase))
                                                {
                                                image_angle = 0;
                                                }

                                        }
          
                                }
                        }
                              // end of loop for one space filled with new blocks
                              
                                                


        //Now iterate through each space block & add WEE blocks based upon adjacent blocks


        
               
        goldcount = 0;
                    
        for (s = 0; s < 8; s +=1)
            {
                for (t = 0; t < 8; t +=1)
                    {
                                if random(1) < goldchance goldcount = round(random_range(1, goldspread))          //set a counter if next few blocks worth of blastblocks are to be gold
                                script_execute(scr_genWeeblocks_new, s, t, block[s,t], goldcount,weeblocktype[]);   
                                                   
                    }
            }
    }
}

#define scr_genWeeblocks_new
if block[s , t] == 0
//show_debug_message("Space found big square-" + string(u) + ", "+ string(v));
{


//show_debug_message("Space found big square-" + string(u) + ", "+ string(v));

                    // Empty space block found, now check adjacent squares- four axes n,s,e,w 0 or 1 depending if have an adjacent edge
                        wbn = 0;
                        wbe = 0;
                        wbs = 0;
                        wbw = 0;
                                               
                        grid = gridsize-1                        
                        // edge squares with bordering big blocks
                        if s == 0 && u != 0 && bigblock[u-1, v] == 0 wbw = 1;
                        if s == 7 && u != grid && bigblock[u+1, v] == 0 wbe = 1;
                        if t == 0 && v != 0 && bigblock[u, v-1] == 0 wbn = 1;                        
                        if t == 7 && v != grid && bigblock[u, v+1] == 0 wbs = 1;                                        
                     
                                                                                                           
                        if  s != 0 && block [s-1, t] == 1 wbw = 1
                        if  s != 7 && block [s+1, t] == 1 wbe = 1
                        if  t != 0 && block [s, t-1] == 1 wbn = 1
                        if  t != 7 && block [s, t+1] == 1 wbs = 1
                        
                        if wbw == 1 || wbe == 1 || wbn == 1 || wbs == 1                             // we have at least one external edge- so time to add blocks inside             
                            {
                            
                            //show_debug_message("Space found square-" + string(s) + " , " + string(t) + " North:" + string(bn) + " South:" + string(bs) + " East:" + string(be) + " West:" + string(bw));   
                            
                            // Initialise 12 x 12 Block Array- (0 = no block)
            
                            wbu = 0;
                            wbv = 0;
                 
                            for (i = 0; i < 12; i +=1)
                                {
                                    repeat(12)
                                    {
                                        weeblock[wbu, wbv] = 0;
                                        //show_debug_message(string(wbu) + " , " + string(wbv));
                                        wbu += 1;
                                    }
                                    wbu = 0;        
                                    wbv += 1;          
                                }
                                
                                count = spikyness;
                                
                            
                                if wbn == 1
                                    {

                                        
                                        for (column = 0; column < 12; column +=1)           //iterate through each column from north edge down
                                            {
                                                 
                                                 count = count + round(random_range(-1, 1))
                                                 count = clamp(count, 1, maxweespike)
                                                 blockswitch = 0;        //wee blocks
                                                 weeblock[column, 0] = 1        //first block is always a wee block
                                                 
                                                 for (c = 1; c < count+1; c +=1)
                                                    {
                                                      if blockswitch == 0 && goldcount > 0 blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < vinechance blockswitch = 2       //switch to vines for rest of column
                                                      
                                                      //weeblock tests
                                                      if weeblock[column, c] == 0 && c < count && blockswitch == 0 weeblock[column, c] = 1
                                                      if weeblock[column, c] == 0 && c == count && blockswitch == 0 weeblock[column, c] = 4
                                                      
                                                      //goldtests
                                                      if weeblock[column, c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              weeblock[column, c] = 3
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //blastblock tests
                                                      if weeblock[column, c] == 0 && c < count && blockswitch == 2 weeblock[column, c] = 8      // vine
                                                      if weeblock[column, c] == 0 && c == count && blockswitch == 2 weeblock[column, c] = 9     //end cap
                                                    }
                                            }

                                    }
                        
                                if wbs == 1
                                    {
                                        //count = spikyness;
                                        
                                        for (column = 0; column < 12; column +=1)           //iterate through each column from south edge up
                                            {
                                                 count = count + round(random_range(-1, 1))
                                                 count = clamp(count, 1, maxweespike)
                                                 blockswitch = 0;        //wee blocks
                                                 weeblock[column, 11] = 1        //first block is always a wee block
                                                 
                                                 for (c = 1; c < count+1; c +=1)
                                                    {
                                                      if blockswitch == 0 && goldcount > 0 blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < vinechance blockswitch = 2       //switch to blast blocks for rest of column
                                                      
                                                      //weeblock tests
                                                      if weeblock[column, 11-c] == 0 && c < count && blockswitch == 0 weeblock[column, 11-c] = 1
                                                      if weeblock[column, 11-c] == 0 && c == count && blockswitch == 0 weeblock[column, 11-c] = 5
                                                      
                                                      //goldtests
                                                      if weeblock[column, 11-c] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              weeblock[column, 11-c] = 3
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //blastblock tests
                                                      if weeblock[column, 11-c] == 0 && c < count && blockswitch == 2 weeblock[column, 11-c] = 8
                                                      if weeblock[column, 11-c] == 0 && c == count && blockswitch == 2 weeblock[column, 11-c] = 10
                                                    }
                                            }
                                    }                
                                if wbw == 1
                                    {
                                        //count = spikyness;
                                        
                                        for (row = 0; row < 12; row +=1)           //iterate through each row from west edge left
                                            {
                                                count = count + round(random_range(-1, 1))
                                                 count = clamp(count, 1, maxweespike)
                                                 blockswitch = 0;        //wee blocks
                                                 weeblock[0, row] = 1        //first block is always a wee block
                                                 
                                                 for (c = 1; c < count+1; c +=1)
                                                    {
                                                      if blockswitch == 0 && goldcount > 0 blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < vinechance blockswitch = 2       //switch to blast blocks for rest of column
                                                      
                                                      //weeblock tests
                                                      if weeblock[c, row] == 0 && c < count && blockswitch == 0 weeblock[c, row] = 1
                                                      if weeblock[c, row] == 0 && c == count && blockswitch == 0 weeblock[c, row] = 6
                                                      
                                                      //goldtests
                                                      if weeblock[c, row] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              weeblock[c, row] = 3
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //blastblock tests
                                                      if weeblock[c, row] == 0 && c < count && blockswitch == 2 weeblock[c, row] = 8
                                                      if weeblock[c, row] == 0 && c == count && blockswitch == 2 weeblock[c, row] = 11
                                                    }
                                            }
                                    }                
                                if wbe == 1
                                    {
                                        //count = spikyness;
                                        
                                        for (row = 0; row < 12; row +=1)           //iterate through each row from east edge right
                                            {
                                                count = count + round(random_range(-1, 1))
                                                 count = clamp(count, 1, maxweespike)
                                                 blockswitch = 0;        //wee blocks
                                                 weeblock[11, row] = 1        //first block is always a wee block
                                                 
                                                 for (c = 1; c < count+1; c +=1)
                                                    {
                                                      if blockswitch == 0 && goldcount > 0 blockswitch = 1    //switch to gold blocks for rest of column
                                                      if blockswitch == 0 && random (1) < vinechance blockswitch = 2       //switch to blast blocks for rest of column
                                                      
                                                      //weeblock tests
                                                      if weeblock[11-c, row] == 0 && c < count && blockswitch == 0 weeblock[11-c, row] = 1
                                                      if weeblock[11-c, row] == 0 && c == count && blockswitch == 0 weeblock[11-c, row] = 7
                                                      
                                                      //goldtests
                                                      if weeblock[11-c, row] == 0 && blockswitch == 1 && goldcount > 0
                                                          {
                                                              weeblock[11-c, row] = 3
                                                              goldcount -= 1;
                                                          }
                                                          
                                                      //blastblock tests
                                                      if weeblock[11-c, row] == 0 && c < count && blockswitch == 2 weeblock[11-c, row] = 8
                                                      if weeblock[11-c, row] == 0 && c == count && blockswitch == 2 weeblock[11-c, row] = 12
                                                    }
                                            }
                                    }                
                            
                                    
                               //now we have an array for new wee blocks- draw them
                               for (wbu = 0; wbu < 12; wbu +=1)
                                {
                                    for (wbv = 0; wbv < 12; wbv +=1)
                                        {
                
                                            if weeblock[wbu , wbv] != 0
                                                {
                                                    type = weeblock[wbu , wbv];
                                                    instance_create( u * 384+64 + s *48 + wbu * 4, v * 384+64 + t *48 + wbv *4, weeblocktype[type]);
                                                    
                          
                                                }
                                                                                                                          
                                        }
                                }
                  
                  goldcount -=1;
                                   
                }      
}                                                            
                                        


#define scr_addEdgeblocks_new
if bigblock[u, v] != 0
    {
                for (bu = 0; bu < 8; bu +=1)            //north edge
                    {
                                        
                       northblockcheck = instance_position(u * 384+64 + bu *48, v * 384+64 -16, obj_newblock);
                       //northweeblock   = instance_position(u * 256+64 + bu *32, v * 256+64 -16, obj_weeblock);
                       if northblockcheck != noone
                        {
                                count = spikyness;
                                for (column = 0; column < 12; column +=1)           //iterate through each column from north edge down
                                    {
                                        count = count + round(random_range(-1, 1))
                                        count = clamp(count, 1, maxweespike)
                                        blockswitch = 0;        //wee blocks
                                        instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64, obj_weeblock);        //first block is always a wee block
                                                 
                                        for (c = 1; c < count+1; c +=1)
                                            {
                                                if blockswitch == 0 && goldcount > 0 blockswitch = 1    //switch to gold blocks for rest of column
                                                if blockswitch == 0 && random (1) < vinechance blockswitch = 2       //switch to vines for rest of column
                                                      
                                                //weeblock tests
                                                if c < count && blockswitch == 0 instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 + c *4, obj_weeblock);
                                                if c == count && blockswitch == 0 instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 + c *4, obj_weeblockendNcap);
                                                      
                                                //goldtests
                                                if blockswitch == 1 && goldcount > 0
                                                          {
                                                              instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 + c *4, obj_gold);
                                                              goldcount -= 1;
                                                          }
                                                          
                                                //blastblock tests
                                                if c < count && blockswitch == 2 instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 + c *4, obj_vine);
                                                if c == count && blockswitch == 2 instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 + c *4, obj_vineNcap);
                                            } 

                                            
                                    }                        
                        
                        }

                       southblockcheck = instance_position(u * 384+64 + bu *48, v * 384+64 +384+16, obj_newblock);
                       //southweeblock =  instance_position(u * 256+64 + bu *32, v * 256+64 +256+16, obj_weeblock);
                       if southblockcheck != noone
                       {
                                count = spikyness;
                                for (column = 0; column < 12; column +=1)           //iterate through each column from south edge up
                                    {
                                        count = count + round(random_range(-1, 1))
                                        count = clamp(count, 1, maxweespike)
                                        blockswitch = 0;        //wee blocks
                                        instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 +384, obj_weeblock);        //first block is always a wee block
                                                 
                                        for (c = 1; c < count+1; c +=1)
                                            {
                                                if blockswitch == 0 && goldcount > 0 blockswitch = 1    //switch to gold blocks for rest of column
                                                if blockswitch == 0 && random (1) < vinechance blockswitch = 2       //switch to blast blocks for rest of column
                                                      
                                                //weeblock tests
                                                if c < count && blockswitch == 0 instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 +384 - c *4, obj_weeblock);
                                                if c == count && blockswitch == 0 instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 +384 - c *4, obj_weeblockendScap);
                                                      
                                                //goldtests
                                                if blockswitch == 1 && goldcount > 0
                                                    {
                                                        instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 +384 - c *4, obj_gold)
                                                        goldcount -= 1;
                                                    }
                                                          
                                                //blastblock tests
                                                if c < count && blockswitch == 2 instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 +384 - c *4, obj_vine)
                                                if c == count && blockswitch == 2 instance_create( u * 384+64 + bu *48 + column * 4, v * 384+64 +384 - c *4, obj_vineScap)
                                            }                                    

                                    }                       
                       
                       }

                       westblockcheck = instance_position(u * 384+64 -16, v * 384+64 + bu *48, obj_newblock);
                      // westweeblock =  instance_position(u * 256+64 -16, v * 256+64 + bu *32, obj_weeblock);
                       if westblockcheck != noone
                       {
                                count = spikyness;
                                for (column = 0; column < 12; column +=1)           //iterate through each column from west edge right
                                    {
                                        count = count + round(random_range(-1, 1))
                                        count = clamp(count, 1, maxweespike)
                                        blockswitch = 0;        //wee blocks
                                        instance_create( u * 384+64, v * 384+64 + bu * 48 + column * 4, obj_weeblock);        //first block is always a wee block
                                                 
                                        for (c = 1; c < count+1; c +=1)
                                            {
                                                if goldcount > 0 blockswitch = 1    //switch to gold blocks for rest of column
                                                if random (1) < vinechance blockswitch = 2       //switch to blast blocks for rest of column
                                                      
                                                //weeblock tests
                                                if c < count && blockswitch == 0 instance_create( u * 384+64 + c *4, v * 384+64 + bu * 48 + column * 4, obj_weeblock);
                                                if c == count && blockswitch == 0 instance_create( u * 384+64 + c *4, v * 384+64 + bu * 48 + column * 4, obj_weeblockendWcap);
                                                      
                                                //goldtests
                                                if blockswitch == 1 && goldcount > 0
                                                    {
                                                        instance_create( u * 384+64 + c *4, v * 384+64 + bu * 48 + column * 4, obj_gold);
                                                        goldcount -= 1;
                                                    }
                                                          
                                                //blastblock tests
                                                if c < count && blockswitch == 2 instance_create( u * 384+64 + c *4, v * 384+64 + bu * 48 + column * 4, obj_vine);
                                                if c == count && blockswitch == 2 instance_create( u * 384+64 + c *4, v * 384+64 + bu * 48 + column * 4, obj_vineWcap); 
                                            }
                                    }                       
                       
                       }
                       

                       eastblockcheck = instance_position(u * 384+64 + 384 +16, v * 384+64 + bu *48, obj_newblock);
                       //eastweeblock = instance_position(u * 256+64 + 256 +16, v * 256+64 + bu *32, obj_weeblock);
                       if eastblockcheck != noone
                       {
                                count = spikyness;
                                for (column = 0; column < 12; column +=1)           //iterate through each column from east edge left
                                    {
                                        count = count + round(random_range(-1, 1))
                                        count = clamp(count, 1, maxweespike)
                                        blockswitch = 0;        //wee blocks
                                        instance_create( u * 384+64 + 384, v * 384+64 + bu * 48 + column * 4, obj_weeblock);        //first block is always a wee block
                                                 
                                        for (c = 1; c < count+1; c +=1)
                                            {
                                                if blockswitch == 0 && goldcount > 0 blockswitch = 1    //switch to gold blocks for rest of column
                                                if blockswitch == 0 && random (1) < vinechance blockswitch = 2       //switch to blast blocks for rest of column
                                                      
                                                //weeblock tests
                                                if c < count && blockswitch == 0 instance_create( u * 384+64 + 384 - c *4, v * 384+64 + bu * 48 + column * 4, obj_weeblock);
                                                if c == count && blockswitch == 0 instance_create( u * 384+64 + 384 - c *4, v * 384+64 + bu * 48 + column * 4, obj_weeblockendEcap);
                                                      
                                                //goldtests
                                                if blockswitch == 1 && goldcount > 0
                                                    {
                                                        instance_create( u * 384+64 + 384 - c *4, v * 384+64 + bu * 48 + column * 4, obj_gold);
                                                        goldcount -= 1;
                                                    }
                                                          
                                                //blastblock tests
                                                if c < count && blockswitch == 2 instance_create( u * 384+64 + 384 - c *4, v * 384+64 + bu * 48 + column * 4, obj_vine);
                                                if c == count && blockswitch == 2 instance_create( u * 384+64 + 384 - c *4, v * 384+64 + bu * 48 + column * 4, obj_vineEcap);
                                            }                                       

                                    }                       
                       
                       }

                    }
 }
#define scr_addAsteroids_old

// first check neighbours- true means huge block in that adjacent square
north = false;
south = false;
east = false;
west = false;
totalspawnpoints = 0;


if u> 0 && bigblock[u-1, v] == 0 west = true;
if u< gridsize-1 && bigblock[u+1, v] == 0 east = true;
if v> 0 && bigblock[u, v-1] == 0 north = true;
if v< gridsize-1 && bigblock[u, v+1] == 0 south = true;
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
                spawnpointx[i] = u *384 + 64 + t*48 + 24 + 16 + irandom_range(-8, 8);
                spawnpointy[i] = v *384 + 64 + s*48 + 24 + 16 + irandom_range(-8, 8);
                i += 1;
            }
            totalspawnpoints = 36
        }
    }



if north == true && south == true && totalspawnpoints == 0
    {
    
    // create an array with 1 position

                spawnpointx[1] = u *384 + 64 + 192 + 16 + irandom_range(-16, 16);
                spawnpointy[1] = v *384 + 64 + 192 + 16 + irandom_range(-16, 16);

            totalspawnpoints = 1

    }

if east == true && west == true && totalspawnpoints == 0
    {
    
    // create an array with 1 position

                spawnpointx[1] = u *384 + 64 + 192 + 16 + irandom_range(-16, 16);
                spawnpointy[1] = v *384 + 64 + 192 + 16 + irandom_range(-16, 16);

            totalspawnpoints = 1
    }

if north == true && south == false && totalspawnpoints == 0
    {
    
        // create an array with 4 position
        for (t = 0; t <5; t +=1)
            {

                spawnpointx[t] = u *384 + 64 + 192 + 16 + irandom_range(-24, 24);
                spawnpointy[t] = v *384 + 64 + 144 + t*40 + 16;
            }

            totalspawnpoints = 4

    }    

if north == false && south == true && totalspawnpoints == 0
    {
    
        // create an array with 4 position
        for (t = 0; t <5; t +=1)
            {

                spawnpointx[t] = u *384 + 64 + 192 + 16 + irandom_range(-24, 24);
                spawnpointy[t] = v *384 + 64 + t*40 + 16;
            }

            totalspawnpoints = 4

    }     

if west == true && east == false && totalspawnpoints == 0
    {
    
        // create an array with 4 position
        for (t = 0; t <5; t +=1)
            {

                spawnpointx[t] = u *384 + 64 + 192 + t*40 + 16 ;
                spawnpointy[t] = v *384 + 64 + 192 + 16 + irandom_range(-24, 24);
            }

            totalspawnpoints = 4

    }     

if west == false && east == true && totalspawnpoints == 0
    {
    
        // create an array with 4 position
        for (t = 0; t <5; t +=1)
            {

                spawnpointx[t] = u *384 + 64 + t*40 + 16;
                spawnpointy[t] = v *384 + 64 + 192 + 16 + irandom_range(-24, 24);
            }

            totalspawnpoints = 4

    }    
    
    
    
        
if totalspawnpoints > 0
{   
    var count;    
    for (count = 1; count < totalspawnpoints + 1; count +=1)
        {
            //instance_create(spawnpointx[count], spawnpointy[count], obj_debug);
            check = random(1);
            if totalspawnpoints == 1 check *= 0.25
            if totalspawnpoints > 5 check *= 3
            if check < goldasteroidchance 
                {
                    instance_create(spawnpointx[count], spawnpointy[count], obj_goldasteroid);
                    check = 2;
                }
            if check < asteroidchance instance_create(spawnpointx[count], spawnpointy[count], obj_asteroid);
        
        }
}
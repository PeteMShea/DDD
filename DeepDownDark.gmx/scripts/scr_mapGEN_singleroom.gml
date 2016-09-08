#define scr_mapGEN_singleroom
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
        

// Build an array for the normal blocks

// Initialise 31 x 18 Block Array- (0 = no block) 
bu = 0;
bv = 0;
for (i = 0; i < 18; i +=1)
    {
        repeat(31)
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
for (bx = 0; bx < 30; bx +=1)
    {
        for (by = 0; by < 17; by +=1)
        {
                inst = instance_position(bx * 64 + 8, by * 64 + 8, obj_newblock);
                if inst != noone
                    {
                        block[bx,by] = 1;

                    if random(1) < newblockoverlaychance
                        {                    
                            overinst = instance_create(bx * 64, by * 64, obj_newblockoverlay); 
                 
                        }                             
                    }
                if instance_position(bx * 64 + 8, by * 64 + 8, obj_borderblock) != noone
                {                
                    block[bx,by] = 1;
                  
                }
                show_debug_message("Block " + string(bx) + " , " + string(by) + " : " + string(block[bx,by]));                        
            }       
    }

      
            
show_debug_message("New Blocks done");
           
//now  generate weeblocks
 
// iterate through all the blocks in this big block square and calculate neigbour values for them
goldcount = 0;

bx = 1;
by = 1;

for (bx = 1; bx < 30; bx +=1)
    {
        for (by = 0; by < 17; by +=1)
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
                if bx < 30 && block[bx + 1, by] == 1 e = 1   else e = 0            
                if by > 0 && block[bx, by - 1] == 1 n = 1   else n = 0 
                if by < 17 && block[bx, by + 1] == 1 s = 1   else s = 0
        
        
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
                        if bx >= 17 && bx <=20 && by >= 12 && by <=16 goldcount = round(random_range(goldspread/5, goldspread)) else goldcount = 0
                        script_execute(scr_genWeeBlocksSingle, bx, by, block[bx,by]);
                
                    }
            }
        }

    }
}

show_debug_message("Wee Blocks done");        
        
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

#define scr_genWeeBlocksSingle
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
                                                    inst = instance_create( 64 * bx + wbu * 8 , 64 * by + wbv * 8 , weeblocktype[type]);
                                                        
                                                    //show_debug_message("adding weeblock " + string(type));
                                                    //instance_deactivate_object(inst);  
                                                }
                                                                                                                          
                                        }
                                }
                  
                  goldcount -=1;
                                   
                                                          
                                        

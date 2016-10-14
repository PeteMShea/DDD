// calculate which visual damage to use based upon angle from ship to collision point relative to the ships angle
debug = false;

if debug == true instance_create(loc_x, loc_y, obj_debug);

minvisualdamage = obj_player.minvisualdamage;

if damage > minvisualdamage
    {
        bx = loc_x;
        by = loc_y;
        script_execute(scr_blockburstvfx, by, by);
    
        test_angle = point_direction(obj_player.x, obj_player.y, loc_x, loc_y);
        
        if debug == 100
            {
                inst = instance_create(x, y, debug_line)
                with (inst)
                {
                 image_angle = other.test_angle
                }
           }
        
        loc_angle = test_angle - obj_player.image_angle;
        if loc_angle < 0 loc_angle += 360;
        loc_distance = point_distance(obj_player.x, obj_player.y, loc_x, loc_y)
        disttest = (obj_player.shipscale * global.RM) + 8;      //added 8 here as central damage was triggering too often

        
        if damage >= obj_player.minvisualdamage * 20 damagemodifier = 3 
        else if damage >= obj_player.minvisualdamage * 10 damagemodifier = 2 
        else damagemodifier = 1
 
 // DEBUG --------------------------      
if debug == true show_debug_message("test angle:" + string(test_angle) + "image angle:" + string(image_angle) + " , loc_angle: " + string(loc_angle));
       // global.pause = true;        

        if debug == true
            {
                inst = instance_create(x, y, debug_line)
                with (inst)
                    {
                     image_angle = other.loc_angle
                    }
           }
// ------------------------------------
           

// Now test the local angle and determine which part of ship to damage, then raise its visual damage index

        if loc_distance <= disttest && global.locdamage_CC < 4
        {
                global.locdamage_CC += damagemodifier;
                if global.locdamage_CC > 4 global.locdamage_CC = 4
                if global.locdamage_CC > 1 script_execute(scr_shipdebrisvfx, loc_x, loc_y);
                show_debug_message("CC hit");                
        } 

        if loc_distance <= disttest && global.locdamage_CC == 5
        {
                global.locdamage_CC = 3;
                script_execute(scr_shipdebrisvfx, loc_x, loc_y);
        }
                   
        if loc_angle >= 0 && loc_angle < 30 && global.locdamage_CL < 4
            {
                global.locdamage_CL += damagemodifier;
                if global.locdamage_CL > 4 global.locdamage_CL = 4
                if global.locdamage_CL > 1 script_execute(scr_shipdebrisvfx, loc_x, loc_y);
                show_debug_message("CL hit"); 
            }

        if loc_angle >= 0 && loc_angle < 30 && global.locdamage_CL == 5 
            {
                global.locdamage_CL = 3;
                script_execute(scr_shipdebrisvfx, loc_x, loc_y);
            }
        
                           
        if loc_angle >= 30 && loc_angle < 60 && global.locdamage_ML < 4
            {
                global.locdamage_ML += damagemodifier;
                if global.locdamage_ML > 4 global.locdamage_ML = 4
                if global.locdamage_ML > 1 script_execute(scr_shipdebrisvfx, loc_x, loc_y);
                show_debug_message("ML hit"); 
            }

        if loc_angle >= 30 && loc_angle < 60 && global.locdamage_ML == 5            
            {
                global.locdamage_ML = 3;
                script_execute(scr_shipdebrisvfx, loc_x, loc_y);                
            }
                               
        if loc_angle >= 60 && loc_angle < 130 && global.locdamage_BL < 4
            {
                global.locdamage_BL += damagemodifier;
                if global.locdamage_BL > 4 global.locdamage_BL = 4
                if global.locdamage_BL > 1 script_execute(scr_shipdebrisvfx, loc_x, loc_y);
                show_debug_message("BL hit"); 
            }

        if loc_angle >= 60 && loc_angle < 130 && global.locdamage_BL == 5 
            {
                global.locdamage_BL = 3;
                script_execute(scr_shipdebrisvfx, loc_x, loc_y);
            }        
                        
        if loc_angle >= 330 && loc_angle < 360 && global.locdamage_CR < 4
            {
                global.locdamage_CR += damagemodifier;
                if global.locdamage_CR > 4 global.locdamage_CR = 4
                if global.locdamage_CR > 1 script_execute(scr_shipdebrisvfx, loc_x, loc_y);
                show_debug_message("CR hit"); 
            }                  

        if loc_angle >= 330 && loc_angle < 360 && global.locdamage_CR == 5  
            {
                global.locdamage_CR = 3 ;
                script_execute(scr_shipdebrisvfx, loc_x, loc_y);
            } 
                           
        if loc_angle >= 300 && loc_angle < 330 && global.locdamage_MR < 4
            {
                global.locdamage_MR += damagemodifier;
                if global.locdamage_MR > 4 global.locdamage_MR = 4
                if global.locdamage_MR > 1 script_execute(scr_shipdebrisvfx, loc_x, loc_y);
                show_debug_message("MR hit"); 
            }
                          
        if loc_angle >= 300 && loc_angle < 330 && global.locdamage_MR == 5 
            {
                global.locdamage_MR = 3 ;
                script_execute(scr_shipdebrisvfx, loc_x, loc_y);
            }
                                                                   
        if loc_angle >= 230 && loc_angle < 300 && global.locdamage_BR < 4
            {
                global.locdamage_BR += damagemodifier;
                if global.locdamage_BR > 4 global.locdamage_BR = 4
                if global.locdamage_BR > 1 script_execute(scr_shipdebrisvfx, loc_x, loc_y);
                show_debug_message("BR hit"); 
            }      

        if loc_angle >= 230 && loc_angle < 300 && global.locdamage_BR == 5            
            {
                global.locdamage_BR = 3  ;
                script_execute(scr_shipdebrisvfx, loc_x, loc_y);
            } 
    
        
    }




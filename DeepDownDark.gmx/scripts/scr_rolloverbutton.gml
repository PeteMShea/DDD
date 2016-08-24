// check for rollover and press of a button

    // check for mouse contact
    
    rollover = false;
    
    if mouse_x >= x && mouse_x <= x2 && mouse_y >= y && mouse_y <= y2 && pressed == false
    {
        rollover = true;
        //show_debug_message("Repair Rollover, TargetAlpha = " + string(image_alpha));
    }
    
    if pressed == false && rollover == true
    {
        targetalpha = rolloveralpha;
    
    }

    if pressed == false && rollover == false
    {
        targetalpha = readyalpha;
    
    }    
    
    if image_alpha < targetalpha image_alpha += alphafade
    if image_alpha > targetalpha image_alpha -= alphafade
    
    
    if rollover == true && pressed == false 
    {
        if mouse_check_button_pressed(mb_left)
        {
            targetalpha = pressedalpha;
            pressed = true;
            show_debug_message("Repair Pressed");
        }
    }
    
    if image_alpha >= pressedalpha targetalpha = rolloveralpha
    

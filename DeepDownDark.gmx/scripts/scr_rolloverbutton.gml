// check for rollover and press of a button

    // check for mouse contact
    
    rollover = false;
    
    if mouse_x >= x && mouse_x <= x2 && mouse_y >= y && mouse_y <= y2 && locked == false && pressed == false
    {
        rollover = true;
        //show_debug_message("Repair Rollover, TargetAlpha = " + string(image_alpha));
    }
    
    if pressed == false && rollover == true && locked == false
    {
        targetalpha = rolloveralpha;
    
    }

    if pressed == false && rollover == false
    {
        if locked == false targetalpha = readyalpha else targetalpha = lockedalpha
    
    }    
    
    if image_alpha < targetalpha image_alpha += alphafade
    if image_alpha > targetalpha image_alpha -= alphafade
    
    
    if rollover == true
    {
        if mouse_check_button_pressed(mb_left)
        {
            targetalpha = pressedalpha;
            pressed = true;
            show_debug_message("Button Pressed");
        }
        else pressed = false;
    }
    
    if image_alpha >= pressedalpha targetalpha = rolloveralpha
    

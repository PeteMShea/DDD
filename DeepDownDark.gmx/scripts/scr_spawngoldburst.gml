// create a burst of goldpickups


    for (i = 0; i < 5; i += 1)
        {
            with (instance_create (bx, by, obj_goldpickup))
                {
                direction = random_range(0, 360);
                speed = 0.2 * 60 * delta_time/1000000;
                }
            bx += 1

        }

    

// fade in

if fadein = true
{
    if image_alpha < finalalpha image_alpha += alphafade
    if image_alpha >= finalalpha fadein = false;
}

// fade out
if fadeout = true
{
    if image_alpha > 0 image_alpha -= alphafade
    if image_alpha <= 0 fadeout = false;
}


// placeholder for now

obj_loadingscreen.visible = true;
if global.nextroom = 1 global.nextroom = 2;     //skip past splash screen when leaving A0
global.nextroom += 1;
room_goto(global.nextroom);       // 1 for splash, 2 for A0, 3, for A1, 4, for A2);
    

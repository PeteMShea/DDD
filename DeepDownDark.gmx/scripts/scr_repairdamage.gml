


while (newhealth > global.playerHealth)
{
    global.playerHealth += 1;
}

repaircount = ceil(damage/14);
area[0] = global.locdamage_CR;
area[1] = global.locdamage_CL;
area[2] = global.locdamage_MR;
area[3] = global.locdamage_ML;
area[4] = global.locdamage_BR;
area[5] = global.locdamage_BL;
area[6] = global.locdamage_CC;

fixarea = 0;


while (repaircount > 0)
    {
        if fixarea == 7 repaircount = 0
        if fixarea < 7
            {
                if area[fixarea] == 0
                    {
                        fixarea += 1
                    }         
                if fixarea < 7 && area[fixarea] == 1
                    {
                        area[fixarea] = 0 
                        repaircount -=1;
                        fixarea +=1
                    }
                if fixarea < 7 && area[fixarea] > 1
                    {
                        area[fixarea] = 5 
                        repaircount -=1;
                        fixarea +=1
                    }
            }   
    }

global.locdamage_CR = area[0];
global.locdamage_CL = area[1];
global.locdamage_MR = area[2];
global.locdamage_ML = area[3];
global.locdamage_BR = area[4];
global.locdamage_BL = area[5];
global.locdamage_CC = area[6];



global.dirtalpha = 0;


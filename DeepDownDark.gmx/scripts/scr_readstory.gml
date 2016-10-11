
// load the current category strings and then choose the current line and add to string
index = global.nextcategory;
count = global.categorycount[index];
filename = "\" + global.categoryfilename[index] + ".txt";

story = file_text_open_read(working_directory + filename);

// skip through lines until we get to the current one in count
for (i = 1; i < count; i +=1)
    {
        file_text_readln(story);
    }

global.displaystring = file_text_readln(story);
show_debug_message(string(global.displaystring));

//now increment current category unless we have reached the cap- in which case loop
global.categorycount[index] += 1
if global.categorycount[index] > global.categorycap[index] global.categorycount[index] = 1;

//now move on to next category
global.nextcategory +=1;
if global.nextcategory > 3 global.nextcategory = 1;
index = global.nextcategory;

if global.categorycap[index] == 0 global.nextcategory = 1; //nothign here, revert to backstory

script_execute(scr_savegame);

 

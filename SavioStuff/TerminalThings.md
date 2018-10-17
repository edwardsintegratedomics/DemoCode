If you're using Savio, you'll have to do things via the command line - that's the best way to handle files, submit jobs, and run code.

There are rather a lot of commands that are used in the command line, so here's a collection of the most common ones along with some definitions/options that each one can take.

### General terminal commands:

| Command | What's it do? | Options | Notes | Example |
|---|---|---|---|---|
|pwd| **P**rints **w**orking **d**irectory | None | | >pwd |
|ls|**L**i**s**t files in working directory| -l "long format" | | >ls -l |
| | | -a "all files" | | >ls -a |
|cd|**C**hange **d**irectory - moves between folders| None | Can use "cd .." to go up one directory| >cd ~/Desktop |
|mkdir|**M**a**k**e **dir**ectory - creates a folder| None | | >mkdir "Folder1" |
|rmdir|**R**e**m**ove a **dir**ectory - delete a folder| None | Only works on empty folders | >rmdir "Folder1" |
|touch|Creates an empty file| None | Remember to specify file ending (.txt, .sh) | >touch "File1.txt" |
|rm|**R**e**m**oves a file| -r "recursive" | Be careful with this! There's no "undo". Use the -r flag to delete a directory with things in it | > rm -r "FullFolder"
| | | | | rm "File1.txt" |
| less | Read the lines of a file, using arrow keys to navigate | None | No editing power in this mode, use nano to make changes | less "File1.txt" |
| nano | Edit a file from command line | None | Use Ctrl-O to save, Ctrl-X to exit. On Mac, Cmd-O and Cmd-X, respectively| nano "File1.txt" |


### Savio specific stuff:

| Command | What's it do? | Options | Notes | Example |
| ssh | Access a "**s**ecure **sh**ell" - a terminal - on another computer | None | Use [username]\@hpc.brc.berkeley.edu to submit jobs and look around, and [username]\@dtn.brc.berkeley.edu to move files. Be ready with password! | ssh wkumler\@hpc.brc.berkeley.edu

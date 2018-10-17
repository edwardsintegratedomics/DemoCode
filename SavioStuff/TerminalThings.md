If you're using Savio, you'll have to do things via the command line - that's the best way to handle files, submit jobs, and run code.

There are rather a lot of commands that are used in the command line, so here's a collection of the most common ones along with some definitions/options that each one can take.

### General terminal commands:

| Command | What's it do? | Options | Notes | Example |
|---|---|---|---|---|
|pwd| **P**rints **w**orking **d**irectory | None | | >pwd |
|ls|**L**i**s**t files in working directory| -l "long format" | >ls -l |
| | | -a "all files" | | >ls -a |
|cd|**C**hange **d**irectory - moves between folders| None | Can use "cd .." to go up one directory| >cd ~/Desktop |
|mkdir|**M**a**k**e **dir**ectory - creates a folder| None | | >mkdir "Folder1" |
|rmdir|**R**e**m**ove a directory - delete a folder| None | Only works on empty folders | >rmdir "Folder1" |
|touch|Creates an empty file| None | Remember to specify file ending (.txt, .sh) | >touch "File1.txt" |
|rm|**R**e**m**oves a file| -r "recursive" | Be careful with this! There's no "undo". Use the -r flag to delete a directory with things in it | > rm "File1.txt"

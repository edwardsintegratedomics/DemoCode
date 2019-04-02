If you're using Savio, you'll have to do things via the command line - that's the best way to handle files, submit jobs, and run code.

There are rather a lot of commands that are used in the command line, so here's a collection of the most common ones along with some definitions/options that each one can take.

### General terminal commands:

| Command | What's it do? | Options | Notes | Example |
|---|---|---|---|---|
|pwd| **P**rints **w**orking **d**irectory | None | | >pwd |
|ls|**L**i**s**t files in working directory| -l "long format" | | >ls -l |
| | | -a "all files" | Will show hidden and system files| >ls -a |
|cd|**C**hange **d**irectory - moves between folders| None | Can use "cd .." to go up one directory| >cd ~/Desktop |
|mkdir|**M**a**k**e **dir**ectory - creates a folder| None | | >mkdir "Folder1" |
|rmdir|**R**e**m**ove a **dir**ectory - delete a folder| None | Only works on empty folders | >rmdir "Folder1" |
|touch|Creates an empty file| None | Remember to specify file ending (.txt, .sh) | >touch "File1.txt" |
|rm|**R**e**m**oves a file| -r "recursive" | Be careful with this! There's no "undo". Use the -r flag to delete a directory with things in it | > rm -r "FullFolder"
| | | | | >rm "File1.txt" |
| less | Read the lines of a file, using arrow keys to navigate | None | No editing power in this mode, use nano to make changes | >less "File1.txt" |
| nano | Edit a file from command line | None | Use Ctrl-O to save, Ctrl-X to exit. On Mac, Cmd-O and Cmd-X, respectively| >nano "File1.txt" |


### Savio specific stuff:

| Command | What's it do? | Options | Notes | Example |
|---|---|---|---|---|
| ssh | Access a "**s**ecure **sh**ell" - a terminal - on another computer | None | Use [username]\@hpc.brc.berkeley.edu to submit jobs and look around, and [username]\@dtn.brc.berkeley.edu to move files. Be ready with password! | ssh wkumler\@hpc.brc.berkeley.edu
| scp | Transfers data between your laptop and Savio | -r "recursive" | Specify where the file is, then where you want it to go. Use dtn.brc.berkeley.edu, not hpc. Copies files, doesn't move them. Remember to include file names on both ends. Be ready with password!|scp "\~/Documents/File1.txt" "wkumler\@dtn.brc.berkeley.edu:\~/Documents/File1.txt"
| sbatch | **S**ubmit a **batch** job to the scheduler | None | This should be a .sh script with sbatch info in it, not a .R script| sbatch "Run_My_R_Script.sh" |
| squeue | Checks the scheduler's queue | -u "user" | If used without -u argument, will find all jobs for all people currently scheduled. Good way to check if your job is still running | >squeue -u wkumler|
| wwall | Checks current CPU usage for a job | --job-id=[] | Use the job ID obtained from squeue. Only works while a job is actually running| >wwall --job-id=3424217 |
| srun | Starts an interactive environment on a node | --pty, --job-id=[] | Ends with the program you want to start on the node - /bin/bash for a terminal, R for R, etc. Use the job ID obtained from squeue| >srun --job-id=3424217 --pty /bin/bash |
| top | Lists the top memory-using programs running | None | Generally used only within a bash shell in a compute node to check parallelization. Use "q" to quit | >top |
| scancel | Cancels a batch job | None | Use the job ID obtained from squeue | >scancel 3424217

### Loading modules and other code

Savio doesn't come loaded with everything already - after all, if we're trying to use R we don't want a bunch of Python commands getting in the way. Savio loads modules instead, which are just like R packages. R is one of these packages, as is nano. These modules have to be loaded every time you start a new ssh login.

| Command | What's it do? | Options | Notes | Example |
|---|---|---|---|---|
| module list | Lists all loaded modules | None | | >module list
| module load | Loads a module | None | Use the names provided by "module list" | >module load r/3.5.1
| module avail | Checks which modules are available to be loaded | None | Changes depending on the modules already loaded - r-packages/default isn't available until after R is loaded | >module avail

However, we're also running our own, personally installed packages on Savio (mostly Bioconductor), so we also need to tell Savio where to find those. To do this, we modify our environmental paths. Again, these have to be modified every time you start a new ssh login

> export MODULEPATH=$MODULEPATH:/global/home/groups/fc_surfwill/modfiles

> export R_LIBS_USER=$R_LIBS_USER:/global/home/groups/fc_surfwill/modfiles


The first of these lines adds the "modfiles" folder, where I've installed the new modules, to the module path. The next one does the same for the R packages (aka libraries).

### Editing your .bashrc file

So, it's annoying to have to run all that code every time we log in to Savio. Fortunately, there's a way to make it happen automatically. There's a hidden file in your home directory (use ls -a to see it) called ".bashrc". This file contains the code that's run every time you start a new Savio session, so it's a perfect place to let Savio automate the module loading and environmental path modifications. To do this, use nano to edit the .bashrc file. (From your home directory, >nano .bashrc).

Then, add the following lines to the end of the document

>module load nano

>module load r/3.5.1

>module load r-packages/default

>export MODULEPATH=$MODULEPATH:/global/home/groups/fc_surfwill/modfiles

>export R_LIBS_USER=$R_LIBS_USER:/global/home/groups/fc_surfwill/modfiles

And Ctrl-O to save and Ctrl-X to exit.

Fair warning though - doing this will also try to load these modules when you login to the dtn nodes, and won't be able to because the dtn nodes don't let you load modules. (They're optimized for data transfer, not programming.) However, if you're confident you've edited your .bashrc file correctly, you can ignore the "module not found error" that pops up when you transfer files.

Et voila!

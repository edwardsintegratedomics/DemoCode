#Summarizes the process for creating and writing batch scripts to submit to the cluster


### So you've got some R code, now what?

Once you've got your R code uploaded to the cluster, you need to figure out how to run it. 
Basically, what we need to do is to tell Savio that we've got a file, it's written in R,
and that we've got some settings for how we'd like to run it.

A sample batch script is written below:

>\#!/bin/bash

>\# Job name

>\#SBATCH --job-name=test

>\# Account

>\#SBATCH --account=co_stat

>\# Partition

>\#SBATCH --partition=savio2

>\# Wall clock time

>\#SBATCH --time=00:00:30

> R CMD BATCH My_R_Script.R

Although many of the lines begin with a hashtag (#), that doesn't mean they're all comments.
Rather, Savio will interpret anything that doesn't have a space following the #. So Savio is
reading the #!/bin/bash line and the #SBATCH lines, but not the # Job name: or # Account etc.

The first line is called the "shebang" and it tells Savio that the next commands need to be
run in a terminal via bash (bash, short for Bourne Again SHell, is the Unix terminal handler.
Basically, we're telling it that this is command line code.) 

The next line (#SBATCH --job-name=[]) tells Savio what we want our job to be named. This can 
be clever, but it's often more helpful to be informative. Here, the job name will be "test".
Very apt.

The next line is letting Savio know whose account to charge this to. We've been given an allowance
of computing time, just like an allowance of money, and we spend some of that each time we 
use the supercomputer. Your account will probably be "EPS280_Edwards", and currently has 200k
hours on it.

The next line tells Savio which partition to use. Savio is made up of many different computers,
each of which has a different use case. Some are really fast, some have big memories, some are
desgined to be used for a long time. In our case, we'll be sticking mostly to savio and savio2
because we don't need anything especially intensive right now.

The next line tells Savio how long, according to a literal clock, we want to let the job run
before we decide something is broken and want to cancel it. Here, it's set for 30 seconds, but
most of our jobs take half an hour to an hour (0:30:00, 1:00:00). 

Finally, the last line tells Savio to run **R** in **CMD** mode and to schedule it using **BATCH**
and to run the specific R script My_R_Script.R. This last bit is what you'll be changing most frequently -
every time you create a new project or R script, make sure you point the batch script to it
by updating this last line with its name and location.

### Parallel stuff

A lot of the R code I used over the summer is parallelized - that means it can run in many
different places at once, or "in parallel". Rather than a single computer crunching through 10
tasks one at a time, if I have 10 computers I'll be done much faster because I can give each 
computer one of the tasks. Similarly, Savio is made of many computers, and things go faster
(and are cheaper!) if we use more computers.

To let Savio know that we'll be using multiple computers, we can add the lines below:

>#SBATCH --nodes=1

>#SBATCH --ntasks-per-node=20

>#SBATCH --cpus-per-task=1

You're welcome to fiddle with these numbers, but they're one of the few setups I've found that
works without crashing. Basically, R has multiple ways of parallelizing things and they don't
all agree with how Savio wants to parallelize them...

### Submitting a job

So you've got your R script in hand (My_R_Script.R), and you've finished writing a batch script
(Run_My_R_Script.sh) with all the information Savio needs. To submit a job, all that you need to
do now is to run the following command:

>sbatch Run_My_R_Script.sh

### Watching jobs run

Once you've submitted a job, it's often a good idea to keep track of it. There are a few ways of doing this.

#### Tracking .Rout changes

Once the job starts running, it'll produce an output file with the same name as your R script file, but will have an .Rout file name instead of .R. If we access this file using `less`, we can follow along as it's created. This simulates the output we'd get if we were running the scripts interactively. Use the "End" button to request an updated output file.

#### Using srun and top

If we want information about how the core itself is handling the job, we can log into the node using srun and th job id:

>srun --jobid=(JOB ID NUMBER HERE) --pty /bin/bash

This logs us into the node on which our job is running, and we can run our own instances of R or run other things in the background. A useful command is `top` which shows us the most memory intensive processes (hopefully R). It also lets us check how many instances of R are running - a proxy for the degree of parallelization.

### Running an interactive job

Rather than starting a batch job, we can also just ask for server time directly. This is great for debugging and handling errors, but does tend to use up computer time quite quickly becuase you're billed for all the time you're sitting on a node, regardless of whether you're running anything on it.

>srun -A fc_surfwill -p savio --nodes=1 -t 30:0 --pty bash

Here, we start up a single node on the Savio partition and request it for half an hour, billing it to the fc_surfwill account. Not sure what --pty does, but adding "bash" at the end launches us into a bash shell. We *could* launch direcly into R, but it's often a good idea to run bash first and quick to launch R from within bash.



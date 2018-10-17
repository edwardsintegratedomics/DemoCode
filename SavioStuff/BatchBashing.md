#Summarizes the process for creating and writing batch scripts to submit to the cluster


### So you've got some R code, now what?

Once you've got your R code uploaded to the cluster, you need to figure out how to run it. 
Basically, what we need to do is to tell Savio that we've got a file, it's written in R,
and that we've got some settings for how we'd like to run it.

A sample batch script is written below:

>\#!/bin/bash
>\# Job name:
>\#SBATCH --job-name=test
>\#
>\# Account:
>\#SBATCH --account=co_stat
>\#
>\# Partition:
>\#SBATCH --partition=savio2
>\#
>\# Wall clock limit (30 seconds here):
>\#SBATCH --time=00:00:30
>\#
>\## Command(s) to run:
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

Et voila!

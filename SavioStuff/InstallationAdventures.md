Sometimes, Savio doesn't have everything that we need on it. 
That's why it allows us to install our own software, as long as it obeys a few obligations.

However, before you start, make sure it's not already installed somewhere:

### Savio Modules

"Modules" are Savio's way of not having every single program loaded at once. Rather, it's possible to 
load only the programs and processes that you need within a given session, keeping the others out
of the way but still accessible if need be. These modules handle the vast majority of all the programs
that need ot be run on the cluster, whether they're editors/IDEs, version control software, programming
languages, or something else. Check out my documentation on modules within the [TerminalThings doc](https://github.com/edwardsintegratedomics/DemoCode/blob/master/SavioStuff/TerminalThings.md) for 
more info. 

If you think you need to install software, check the modules. No, seriously, check the modules.
Then do it again. I've spent hours trying to install a triky bit of code only to realize later that someone
already did the hard work and my efforts were unnecessary. Let me repeat that - **check the modules before
installing new code**

## Installing new code

If you're really sure that Savio doesn't have the code you want, then it'll have to be installed. The best
place for code that everyone needs will be in the `/global/home/groups` folder - ours is currently named `fc_surfwill`, and
I've stored all the extra R packages and additional software in the `modfiles` folder within that. If you just want
a program for yourself, or it takes up a ton of space, install it in your `users` directory or your `scratch`
directory, respectively, instead.

### Installing new R packages

This is the most likely circumstance that will come up. There are loads of R packages, and especially in 
biology we tend to work with a unique subset of them. First, make sure that the `r-packages/default` module
is loaded - it's quite possible that someone has already installed your package elsewhere and it doesn't
actually need to be hosted by us as well. Loading `r-packages/default` also ensure that any dependencies
aren't duplicated.

#### Installing normal packages

This install process is normally painless. R already comes with a package manager that operates from the
command line with the function `install.packages()`, and sometimes it's quite similar to installing software
on your personal computer. Sometimes, getting a new R package can be as simple as

>install.packages("[PACKAGE NAME]")

For example:

>install.packages("dplyr")

#### Installing to a nonstandard location

However, some additional steps are often necessary. These can be added as arguments to the `install.packages()`
function, separated by a comma. For example, often we'll want to install an R package so that the entire
lab can use it. To install a package into a non-standard location, use the `lib=` argument with the path
to the group directory, like so:

>install.packages("[PACKAGE NAME]", lib="[PATH/TO/GROUP")

For example,

>install.packages("dplyr", lib="/global/home/groups/fc_surfwill/modfiles")

This puts the package information in our group directory so that everyone can access it. If you haven't already
modified your $MODULEPATH and $R_LIBS_USER variables to refer to this directory, head over to my [TerminalThings
doc](https://github.com/edwardsintegratedomics/DemoCode/blob/master/SavioStuff/TerminalThings.md) and do that now, or R won't know to look there for your new packages when you ask to load them.

#### Installing from a nonstandard location

Other times, we'll want to install new packages *from* a non-standard location, such as Bioconductor.
Bioconductor is a little funny - it wants you to us biocLite() for everything, but we actually can't do 
that with the cluster because it's not secure to run arbitrary lines of external code. Rather, we'll install
from source by referencing the Bioconductor package name along with the `repos` (repository) argument, like so:

>install.packages("[PACKAGE NAME]", repos="[LINK TO PACKAGE REPOSITORY]")

For example:

>install.packages("LOBSTAHS", repos="http://bioconductor.org/packages/3.8/bioc/")

The above code tells the R installer to look at the Bioconductor website for the package, instead of the 
normal CRAN mirrors. This is only necessary for packages coming from Bioconductor, however - it's usually
worth trying to skip this argument and only using it once R tells you something like `[PACKAGE NAME] is
unavailable (for R version x.xx.xx)`

#### Installing with additional configure flags

Finally, you may need to specify additional configuration arguments to the package installer. These are called *flags*,
and they're usually letting the installer know where additional files can be found, such as headers or
libraries. For those of you familiar with Unix, these arguments are normally passed to ./configure during the 
installation but can't be, for whatever reason (usually because it's not your installation!)

The additional arguments can be passed to R just like the above, using the `configure.args` parameter. However,
this argument only accepts a named character vector keyed by the package name, like so:

>install.packages("[PACKAGE NAME]", configure.args=c([PACKAGE NAME] = "--with-[whatever-your-flag-is]"))

For example,

>install.packages("Rmpfr", configure.args = c(Rmpfr = "--with-mpfr-include=/global/home/groups/fc_surfwill/modfiles/mpfr-etc"))

>install.packages("ncdf4", configure.args = c(ncdf4 = "--with-nc-config=/global/home/groups/fc_surfwill/modfiles/netcdf-base/netcdf-4.6.3/nc-config --with-ncdf4-enabled --with-dap"))

Note that while the above code shows up on multiple lines in Github, it's actually all in the same line in the terminal. Usually safest to write it in your favorite plaintext editor then copy/paste it over (use right click if Ctrl-C doesn't work)

#### Installing with multiple options

Of course, the above arguments often need to be combined if the package is being installed *from*
a nonstandard place *to* a nonstandard place, with or without additional flags, and the arguments 
can be chained normally via commas:

>install.packages("LOBSTAHS", repos="http://bioconductor.org/packages/3.8/bioc/", lib="/global/home/groups/fc_surfwill/modfiles", configure.args = c(Rmpfr = "--with-utility-writing=/global/home/groups/fc_surfwill/modfiles/write-script"))

### Installing your very own software

Okay, so you're not looking to install anything as simple as an R package. Well, Savio can handle additional software but there are a few restrictions due to the working environment. They're listed in more detail [here](https://research-it.berkeley.edu/services/high-performance-computing/accessing-and-installing-software), which you should read through anyway if considering adding new software to the cluster, but I'll summarize below:

1. Be executable on Linux

    The cluster runs Scientific Linux 7, a distribution of Unix. If you're familiar with Unix computers already, this part gets a lot easier for you.
    
2. Run in command line mode

    Perhaps obviously, the cluster doesn't have a graphical user interface. No point-and-click or dragging things around - everything needs to go in and out via command line.
    
3. Install without root/sudo/su privileges

    Root users are the gods of the cluster, with absolute power. They're kinda like operating in "admin" mode on Windows computers, which means that you can do a lot of damage even accidentally. In theory, you could delete the entire cluster. Don't email the Savio people and ask for root privileges, or ask why you can't be a superuser even for a little bit. They're going to turn you down. As Einstein once said, "Superusers don't play dice". Or something like that.
    
    Often, StackOverflow will recommend that you just hop into superuser mode - that's not an option here, but I'll detail a few workarounds below.
    
4. Fit onto your storage space

    Again, perhaps obvious, but each user only has 10GB of space on the cluster, and groups only a bit more. That might sound like a lot, but wouldn't you rather be able to store data in that space?
    
5. Be complied by a normal compiler, like GCC or Intel

    Shouldn't be a problem - most software comes with these compilers or at least the option to use them instead of the more esoteric versions.

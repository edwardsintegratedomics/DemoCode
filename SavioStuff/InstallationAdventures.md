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

#### Step 1: Get the (packaged) software onto the cluster

The first challenge with the cluster is that you can't just open a Chrome browser and download a file like you'd do with your personal computer.  Instead, we'll either have to download the file directly from the http or ftp server, or download it onto our own machine and beam it over via scp link.

The files we're looking for are called tarballs, because they're compressed using the `tar` command. These tarballs are dense, compressed versions of the code that minimize the amount of data that needs to be sent. you know it's a tarball when its file ending is `.tar.gz`. Usually, they're downloadable alongside the more familiar Windows `.exe` files. Look for the x86_64 version if possible.

To download the tarball directly onto the cluster, the best command to use is wget. This grabs an http or ftp file from the internet and drops it directly into the current working directory, like so:

>wget http://example.com/scaryfilename.version.tar.gz

For example,

>wget http://micro.com/jdk-7u45-linux-x64.tar.gz

>wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/zlib-1.2.8.tar.gz

The other way to get the tarball onto the cluster is to download it onto your personal computer, then send it over via scp link. If you're unfamiliar with scp, check out my [TerminalThings doc](https://github.com/edwardsintegratedomics/DemoCode/blob/master/SavioStuff/TerminalThings.md).

After downloading it to your personal computer, send it via scp while logged into a terminal on your personal computer like so:

>scp ~/Downloads/scaryfilename.version.tar.gz dtn.brc.berkeley.edu:/path/to/cluster/folder/

Either way, a new file should appear in your working directory with the .tar.gz ending.

#### Step 2: Extract the packaged file

We've got a tarball, but we want a useful folder. Fortunately, the `tar` command both compresses and uncompresses files, and we can use it on the cluster because it's a command-line tool, like so:

>tar -xzvf scaryfilename.version.tar.gz

The `-xzvf` is really just a collection of flags that tell `tar` exactly how to unzip it. The "x" means e**x**tract, the "z" means to use the g**z**ip option for decompression, the "v" tells it to be **v**erbose when extracting (to watch for errors), and the "f" tells it to operate on the specific **f**ile we specify. You can usually get away with just `xf` if you want to.

For example:

>tar -xzvf zlib-1.2.8.tar.gz

This command unpackages the tarball and expands it into a folder, which should appear in your working directory next to the tarball.

#### Step 3: Move into the new folder

Use the cd command to move into the newly extracted folder, like so:

>cd zlib-1.2.8

All the following steps through `make install` will happen inside this folder.

#### Step 4: Configure the software in preparation for compilation and installation

The tarball is now a source file, but it's not executable because it hasn't really been installed yet. It first needs to be compiled (usually by C, sometimes Fortran) into machine-readable code, then it can be properly installed. In order for those steps to happen, we need to run the configure script that came in the newly unpackaged folder, along with any necessary flags. Like so:

>./configure --flag-one --flag-two

These "flags" are just additional bits of information that we'd like to include in the configuration to customize it in some way. We might want to install extra stuff, or only the basics, or tell it where to find another file, etc. One important flag for us is the `--prefix` flag, which will tell the installer *where* we'd like the final version to be installed.

>./configure --enable-netcdf-4 --enable-shared --enable-dap --prefix=/global/home/groups/fc_surfwill/modfiles

The syntax here is actually a little subtle. Using the ./ usually means "run this code", and that's exactly what it does here. "configure" is really an executable file that was unpackaged in the directory that contains instructions for installation, so we're actually *running* that program to create a Makefile with all the customized information.

Once ./configure runs, there should be several more files in your working directory. If you mess something up or don't like how the configuration went (check config-log to see the information), you can use `make distclean` to remove these new files and reset the installation to where it was before running ./configure.

#### Step 5: Compile the configured software

Compilation is a weird step for anyone other than computer geeks. It's where the code is conveted from human-readable into machine-readable code in preparation for installation.

Here, we can just run `make` and the whole compilation process is taken care of for us, using the settings provided in the ./configure step.

>make

Following `make`, it's often a good idea to run `make check` as well to ensure that things have gone smoothly. This will run a bunch of tests on the compiled software to ensure it's all intact.

>make check

#### Step 6: Install

Finally, we're ready to install the configured and compiled software. We use `make install` to do this, and it'll run for a while and produce a new folder in the --prefix location we specified with ./configure. That new folder usually contains several other folders, like `bin`, `lib`, and `include`. If you aren't seeing those directories in the new folder, something probably went wrong with the install.

>make install

#### Step 7: Cleanup

Now that we're done with the install, we should clean up a bit. The two main things we can get rid of are the tarball file and the pre-compiled folder. Both of those are simply installation files, and now that the software is installed we can throw them out using `rm -r` and `rm`. Check out [TerminalThings](https://github.com/edwardsintegratedomics/DemoCode/blob/master/SavioStuff/TerminalThings.md) if you're not familiar with that.

### TrOuBlEsHooTiNg

There will always be errors that show up when working with computers, and no way I can get to all of them, so I'll just document a few that I ran into while installing NetCDF and HDF5 on the cluster. StackOverflow is your friend here, people.

#### Can't extract - sudo privileges needed!

To keep the cluster safe, we aren't allowed to run any code that's outside of our own directories. However, oftentimes installing your own software means downloading executable files to be run. The workaround here is to install them into a temp folder that isn't the default one. We're going to set the environmental variable `TMPDIR` to something other than the global, shared /tmp folder like so:

>export TMPDIR="~/tmp"

This code assumes that you've got a temp folder named **tmp** in your personal folder (~). I usually keep one of these around simply because it's easy to type and keep track of.

To check whether the environment variable has been correctly set, we can ask for it directly from the shell

>echo $TMPDIR

which hopefully returns the full path to your home directory.

We can also check the list of environmental variables to make sure it's showing up there:

>env

`env` returns all the environmental variables currently declared. We can pipe that output into grep to search for something particular:

>env | grep TMPDIR

which again hopefully returns the full path to your home directory.

#### Can't find a file!

Sometimes, during an installation, when the installer or compiler complains that it can't find a file, it's not looking in the right spot. There are two main causes to this, depending on the code that's throwing the error.

In the first case, additional flags need to be passed to the ./configure argument. These often have the form of --with-[whatever] and are designed to specify the locations present. In my case, I needed to tell the HDF5 config file where to find the zlib library, so I called configure like so:

>./configure --with-zlib=/home/learjet/doel_bi/local/netcdfWithHdf5/zlib-1.2.5 --prefix=/global/home/groups/fc_surfwill/modfiles

You can see this happening [here](https://www.unidata.ucar.edu/support/help/MailArchives/netcdf/msg10741.html)

Some packages don't like the use of --with flags. Instead, they use environment variables to tell config files where to find libraries and include requests. For example, this was how netCDF wanted to be told where the HDF5 and zlib libraries were found. I had to define the environmental variables "LDFLAGS" and "CPPFLAGS" to contain the necessary, like so:

>CPPFLAGS=-I/global/home/groups/fc_surfwill/modfiles/hdf5-1.10.5/include 

>LDFLAGS=-L/global/home/groups/fc_surfwill/modfiles/hdf5-1.10.5/lib 

>./configure --enable-netcdf-4 --prefix=/global/home/groups/fc_surfwill/modfiles

Note that I didn't need to pass any --with flags to ./configure, because configure already knows to look for those environmental variables when configuring.

The final option, when an installation can't find a file, is modifying the environmental PATHs. There are several of these that we'll talk about here. These PATHs tell the cluster where to look for code that it can't find in the normal places. Since we're installing a lot outside of the normal places, this is a common thing.

The first PATH that we'll talk about is R_LIBS_USER. This is specific to R, and tells it where to look when we try to load a library(). The important one to add is /global/home/groups/fc_surfwill/modfiles, because Edwards Lab already has a bunch of new packages installed there. Add a new directory to your R_LIBS_USER path like so:

>export R_LIBS_USER=$R_LIBS_USER:/path/to/directory

For example,

>export R_LIBS_USER=$R_LIBS_USER:/global/home/groups/fc_surfwill/modfiles

Which makes R look in modfiles for additional R libraries.

The next PATH that we'll talk about is LD_LIBRARY_PATH. This is like the path that programs traverse when looking for other programs, so it's often a cause of problems if misconfigured. Same kind of addition as above:

>export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/directory

For example,

>export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/global/home/groups/fc_surfwill/modfiles/netcdf-base/netcdf-4.6.3

Which tells programs where to find NetCDF version 4.6.3.

Finally, we can edit the global PATH variable in a similar way. This has always been kind of a last-resort for me, but will occasionally work when nothing else does.

>export PATH=$PATH:/path/to/something/new

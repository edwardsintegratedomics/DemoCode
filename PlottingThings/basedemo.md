baseplotdemo
================

Making plots in R
-----------------

R is designed to make plots and visualize your data. That's one of the reasons I personally love it - you can always get something tangible out of your code.

### Let's start simple.

The most basic command in R is simply plot(). It takes two arguments, *x* and *y*, and draws a scatterplot with them:

``` r
x <- 1:10
y <- 1:10
plot(x, y)
```

![](basedemo_files/figure-markdown_github/baseplot-1.png)

Simple, but boring. Scatterplots are often a good place to start, but data comes in many shapes and there are different visualization methods for all of them.

### Barplot

Rather than handling both x and y coordinates, all that barplot() needs is a *y* coordinate. It assumes that your *x* values will be 1:length(y) - basically assuming that each observation is "how many" of each category you observed.

``` r
y <- c(3,1,7,4,8,9,3,7,1)
barplot(y)
```

![](basedemo_files/figure-markdown_github/barplot-1.png)

Note that histograms are **not** the same as boxplots. Histograms accept the raw data - no counting necessary - and plots the *frequency* of each datum. If you're unsure, use a barplot.

### Boxplot

Boxplots are another very common type of plot and are often close to publication quality immediately after creation. They accept a *matrix*, where the different columns are different treatments, each with several individual samples. The boxplot then provides the median and quartiles, giving a good idea of how the data is spread out.

``` r
nums <- rep(1:3, each=10)+rnorm(30, mean = 0, sd = 0.2)
print(nums)
```

    ##  [1] 1.1492750 0.9414529 0.9877243 1.0244941 1.2721030 0.8283138 1.4348435
    ##  [8] 0.9984449 1.4081218 0.8827610 2.1260755 1.8727022 2.1721201 2.1795429
    ## [15] 1.8753285 2.2558138 1.9184806 2.2713525 1.9140470 2.2457386 3.1454655
    ## [22] 3.0502390 3.0011547 2.5014126 2.9795562 2.9926861 3.1269476 3.0201081
    ## [29] 2.8292824 3.0559283

``` r
mat <- matrix(nums, ncol = 3, byrow = F)
print(mat)
```

    ##            [,1]     [,2]     [,3]
    ##  [1,] 1.1492750 2.126076 3.145465
    ##  [2,] 0.9414529 1.872702 3.050239
    ##  [3,] 0.9877243 2.172120 3.001155
    ##  [4,] 1.0244941 2.179543 2.501413
    ##  [5,] 1.2721030 1.875328 2.979556
    ##  [6,] 0.8283138 2.255814 2.992686
    ##  [7,] 1.4348435 1.918481 3.126948
    ##  [8,] 0.9984449 2.271352 3.020108
    ##  [9,] 1.4081218 1.914047 2.829282
    ## [10,] 0.8827610 2.245739 3.055928

``` r
boxplot(mat)
```

![](basedemo_files/figure-markdown_github/boxplot-1.png)

Prettifying plots
-----------------

R makes plots quickly, but also has a lot of options that let you make your plots beautiful and ready for actual publications. I'm going to step through some of the steps I usually use to make my plots look better, adding one layer at a time.

### Plotting things

I'm going to start with a scatterplot and build up from there.

``` r
plot(x = 1:20, y=rnorm(n = 20, mean = 5, sd = 2))
```

![](basedemo_files/figure-markdown_github/prettybase-1.png)

Note that R automatically assumes what you want the axes to be named based on the names of the variables you passed to the x and y arguments - here, it names the x axis "1:10" and the y axis "rnorm(n = 20, mean = 5, sd = 2)". Not very helpful, so let's change that around. We'll use the *ylab=* and *xlab=* arguments to change the axes.

``` r
plot(x = 1:20, y=rnorm(n = 20, mean = 5, sd = 2),
     xlab = "This is the x axis", ylab = "This is the y axis")
```

![](basedemo_files/figure-markdown_github/prettyaxes-1.png)

Better! At least now we know what we're talking about. Let's add a title and orient the axes more helpfully.

``` r
plot(x = 1:20, y=rnorm(n = 20, mean = 5, sd = 2),
     xlab = "This is the x axis", ylab = "This is the y axis",
     main = "This is the title", las=1) #las can be 1, 2, 3, or 4 - experiment!
```

![](basedemo_files/figure-markdown_github/prettytitle-1.png)

Looking good. Let's add some character to the plot, in the form of <sub>colors</sub> and <sub>shapes</sub> and <sub>sizes</sub>.

``` r
pointcolors <- rep(c("red", "blue"), each=10)
pointcolors
```

    ##  [1] "red"  "red"  "red"  "red"  "red"  "red"  "red"  "red"  "red"  "red" 
    ## [11] "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue"

``` r
pointshapes <- rep(0:3, length.out=20)
pointshapes
```

    ##  [1] 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3

``` r
pointsizes <- sample(c(1:4), 20, replace = T)
pointsizes
```

    ##  [1] 4 1 4 4 1 4 1 1 2 4 2 4 4 3 3 4 2 1 4 4

``` r
plot(x = 1:20, y=rnorm(n = 20, mean = 5, sd = 2),
     xlab = "This is the x axis", ylab = "This is the y axis",
     main = "This is the title", las=1, #las can be 1, 2, 3, or 4 - experiment!
     col = pointcolors, pch=pointshapes, cex = pointsizes)
```

![](basedemo_files/figure-markdown_github/prettycolors-1.png)

Okay, that's a little too crazy. Let's switch back to the base plot and instead add some new layers. Just remeber to experiment with shapes, colors, and sizes with all of the upcoming stuff as well.

Rather than plotting points only, we can also connect them if we want to show trends and variations in the data. There are two ways to do this - one, by building it into the base plot, and two - by adding a layer on top.

``` r
par(mfrow=c(1,3)) #Lets us display 3 graphs at the same time

plot(1:20, c(1:10, 10:1), main = "Simple plot")
plot(1:20, c(1:10, 10:1), main = "Built-in",
     type = "o") #type = "overlay" lines and points
plot(1:20, c(1:10, 10:1), main = "Extra layer")
lines(1:20, c(1:10, 10:1))
```

![](basedemo_files/figure-markdown_github/prettylines-1.png)

``` r
par(mfrow=c(1,1))
```

That "extra layer" is a pretty neat tool. It lets us add points and lines to our graphs wherever we want. "points" adds points, and each point needs an x and y, and you can add color and shape and size etc. "lines" adds lines, and needs a "start" x and y coordinate as well as an "end" x and y coordinate.

``` r
par(mfrow=c(1,2))

plot(x = 1:10, y = 1:10)

plot(x = 1:10, y = 1:10)
points(x = 1, y = 10) #Add a point at 1, 10
lines(c(10, 10)) #Draw a line from 1,10 to 2,10
```

![](basedemo_files/figure-markdown_github/extralayers-1.png)

``` r
par(mfrow=c(1,1))
```

### Cheatsheet so far:

![](basedemo_files/figure-markdown_github/cheatsheet-1.png)

### Axes options

The axes are also an important part of the graph, but they've got their own settings so that you can manipulate them freely. I'll just list a bunch of options and you can experiment with them.

``` r
par(mfrow=c(2,3))

plot(1:10)
plot(1:10, axes = F, main = "No axes")
plot(1:10, xaxt="n", main = "No x axis") 
plot(1:10, main = "Standard, but created \nvia separate layer")
axis(side = 1, at = 1:10, labels = 1:10, tick = T, line = 0)

plot(1:10, main = "Colors and shapes", axes = F)
axis(side = 1, font = 2, col = "blue", cex.axis=4)
axis(side = 2, font = 3, col = "red")

plot(1:10, bty="7", main = "Box types")
```

![](basedemo_files/figure-markdown_github/axes-1.png)

Working with some data!
-----------------------

Let's see what we can do with the LOBSTAHS data with this new plotting information.

``` r
LOBdata <- read.csv("LOBsetPos.csv")

#Which columns are the data in?
datacols <- 12:29
compoundcol <- 43
speciescol <- 37
classcol <- 36
rtcol <- 5
mzcol <- 2

simpleLOBdata <- LOBdata[,c(36, 37, 43, 5, 2, 12:29)]
names(simpleLOBdata) <- c("Lipid_Class", "Lipid_Species", "Lipid_Compound", "Retention_time", "M/Z ratio",
                          paste("Sample", 1:18))

justSamples <- simpleLOBdata[,6:23]
```

We can check if any of the samples are outliers or unusual using a boxplot:

``` r
par(mar=c(5.1, 10.1, 2.1, 2.1))
tJustSamples <- log10(t(head(justSamples, 100)))
colnames(tJustSamples) <- simpleLOBdata$Lipid_Compound[1:100]
boxplot(tJustSamples, main = "What do the first 100 rows look like?",
        xlab = "Log base 10 of the intensity values", ylab="",
        horizontal=T, xlim=c(100,0), las=1, outcol="red", col="grey90")
```

![](basedemo_files/figure-markdown_github/LOBboxplot-1.png)


<!-- README.md is generated from README.Rmd. Please edit that file -->

# prepPS

This package sole purpose is to provide a convenience function for
taking peerScholar grades and preparing them for Quercus (U of T’s
version of Canvas).

## Mise en place (i.e. what you want to have ready)

  - The csv exported from peerScholar.
  - The csv exported from your Canvas gradebook. Must have the
    assessment you want to process as a column.
  - The class roster, exported from the UT Advanced Group tool. Could be
    any csv with the columns `Student Number` and `Email` to allow you
    to match as peerScholar uses email as the only uniique ID and the
    Canvas gradebook doesn’t include emails, so I use student ID.

## Installation

You can install this package from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("elb0/prepPS")
```

You’ll also want the tidyverse on your side.

``` r
# install.packages("tidyverse")
library(tidyverse)
```

## Read in your files

It doesn’t matter what these csv are called, in the below I am just
trying to mimic their automatic naming upon export to help make it
easier for you to remember which is which.

``` r
# this is the file from peerScholar
ps_export <- read_csv("Activity-name_Grades_date.csv") 

# this is the file you exported from the gradebook
gradebook_export <- read_csv("datecode_Grades-course-section.csv") 

# this is the file export from the U of T Advanced Group tool, but could be any file with the colums "Student Number" and "Email"
roster_from_grouper <- 
read_csv("Roster-course-section_course-name.csv") 
```

## Other parameters

Get the name of the activity you want, as Quercus/Canvas has named it
(i.e. with a numeric code as well as the name). It will be your
`activity_name` parameter.

``` r
# find and copy name from here (or however you find easiest)
names(gradebook_export)
activity_name = "Cool learing activity (123567)"
```

If you want the grade to be out of a certain number of points, set
`total_points`, otherwise if will give you a proportion, i.e. value
\(\in\) \[0,1\].

If you wanted it as a percentage, `total_points = 100`.

## Putting it all together

prep\_peer, prepare, geddit?

Running this (with all the above run, too) will then write a csv file
named through `paste0("import_", activity_name, "_", Sys.Date(),
".csv")` to your working directory. This should be ready for upload to
Quercus/Canvas.

``` r
prep_peer(ps_export, gradebook_export, roster_from_grouper,
                     activity_name)
```
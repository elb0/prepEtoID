
<!-- README.md is generated from README.Rmd. Please edit that file -->

# prepEtoID

This package sole purpose is to provide a convenience function for
taking student information/grades linked to their emails (no UTORID or
student ID) and preparing it for Quercus (U of T’s version of Canvas).

## Mise en place (i.e. what you want to have ready)

  - The csv with student email and anything else needed to calculate or
    indicate the grade. It will need to have, or be renamed to have the
    columns `Email` and `Grade`. (Can have other columns, these will be
    dropped in the final csv with no issues.)
  - The csv exported from your Canvas gradebook. Must have the
    assessment you want to process as a column.
  - The class roster, exported from the UT Advanced Group tool. Could be
    any csv with the columns `Student Number` and `Email` to allow you
    to match students in the two databased.

## Installation

You can install this package from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("elb0/prepEtoID")
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
# this is the file from your source, e.g. MS Forms
source_export <- read_excel("Activity-name_Grades_date.xlsx") 

# this is the file you exported from the gradebook
gradebook_export <- read_csv("datecode_Grades-course-section.csv") 

# this is the file export from the UT Advanced Group tool, but could be any file with the colums "Student Number" and "Email"
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

## Putting it all together

Running this (with all the above run, too) will then write a csv file
named through `paste0("import_", activity_name, "_", Sys.Date(),
".csv")` to your working directory. This should be ready for upload to
Quercus/Canvas.

``` r
prepEtoID(source_export, gradebook_export, roster_from_grouper,
                     activity_name)
```

## Complete workflow

The code below won’t run for you because you don’t have my student data,
but I wanted to give a complete example of the workflow.

1.  Export grades from MS Forms.
2.  Export gradebook from Quercus/Canvas.
3.  Export roster from the UT Advanced Group Tool (need to activate in
    Navigation if you can’t see it).
4.  Move all files to the directory I want them to be in.
5.  Run the below code.
6.  Import the resulting csv to Quercus/Canvas.

<!-- end list -->

``` r
devtools::install_github("elb0/prepEtoID")
library(tidyverse)

# read in all the files I need
source_export = read_xlsx("W10 Littering case study_Grades_2021_01_10.xlsx")
gradebook_export = read_csv("2021-01-10T1302_Grades-STA490Y1_Y_LEC0101.csv")
roster_from_grouper =
 read_csv("Roster-STA490Y1 Y LEC0101 20209_Statistical Consultation, Communication, and Collaboration (formerly STA490H1).csv")

# to find the name of the activity for the next line of code
names(gradebook_export)

activity_name = "W10 Littering case study (479284)"

prepEtoID::prepEtoID(source_export, gradebook_export, roster_from_grouper, activity_name)
```

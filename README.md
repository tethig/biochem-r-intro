# biochem-r-intro
Introduction to Analysis with R - our biochemistry learning session!

## Outline Structure
These sessions are structured as follows:
- Introduction to RStudio
- Part 1: Analysis of Penguin data
- Part 2: Analysis of COVID data
- Part 3: Analysis of sleep data

## Detailed Structure and Links
Please follow the links in this table to view content online:

| Level  | Skills                    | Location                | Link                                                                                   |
|--------|---------------------------|-------------------------|----------------------------------------------------------------------------------------|
| Intro  | what is R?                | what-is-r/              | [Quarto Presentation](https://bendickins.net/what-is-r/)                               |
| Intro  | simple codes              | the-fourth-r-main/docs/ | [Quarto Presentation](https://bendickins.net/the-fourth-r/simple-codes.html)           |
| Intro  | object types              | the-fourth-r-main/docs/ | [Quarto Presentation](https://bendickins.net/the-fourth-r/object-types.html)           |
| Intro  | reading data              | the-fourth-r-main/docs/ | [Quarto Presentation](myfolder/reading-data.html)                                      |
| Part 1 | the "grammar of graphics" with penguins! | biochem-r-intro | [Presentation (R Markdown)](part1.html)                                         |
| Part 2 | data prep and contingency tables with COVID data | biochem-r-intro | [Presentation (R Markdown)](part2.html)                                 |
| Part 3 | linear modelling with sleep data | biochem-r-intro | [Presentation (R Markdown)](part3.html)                                                 |

Parts 1 and 2 will also concern a statistical concern called "Simpson's Paradox" which you can read about [on Wikipedia](https://en.wikipedia.org/wiki/Simpson's_paradox).

## Before we Begin
For this tutorial we will assume that you may not have admin access to your computer and therefore we will use the cloud version of Posit hosted at [posit.cloud](https://posit.cloud). (Some details on installing R on a computer can be found below). Please sign up for a free account with Posit Cloud.

Before we begin, there will be a manual step here that we will talk you through. For this step you will need to copy and paste this text:

`https://github.com/tethig/biochem-r-intro.git`

into Posit Cloud. This will give you access to the data files you need.
## Installing R
If you have your own computer, **and you have admin access**, it is easy to install R. You can do so via the Comprehensive R Archive Network (CRAN). To do this you can use your search engine to find "R" and from the R homepage choose a local mirror site ([direct link here](https://cran.r-project.org/mirrors.html)). This works for all major operating systems. Mac users may, however, also find nightly builds on [this bleeding-edge repository](https://mac.r-project.org). While R is all you need, I strongly recommend using an "Integrated Development Environment" (IDE) while you learn. This is a piece of software that allows you to see extra information (such as what's in the computer memory, help pages and plots) in an organised layout on your screen. Probably the most popular IDE, and the one I recommend, is the [RStudio Open Source Edition](https://posit.co/products/open-source/rstudio/). This is now in the process of being rebranded as Posit. (In outline I understand the intention to be to make it a multilingual IDE: for python as well).

## Recommended Reading
I recommend the following resources for further study of R:
- [Tidyverse Homepage](https://www.tidyverse.org): a useful reference point for working with these libraries.
- [R for Data Science](https://r4ds.had.co.nz): a comprehensive book which teaches many aspects of R (from data organisation through plotting to R markdown) with an emphasis on the tidyverse.
- [R Graphics Cookbook](https://r-graphics.org): the second edition of this reference guide for plotting is most helpful.
- [R Graph Gallery](https://www.r-graph-gallery.com): a great place to go for plotting ideas and for coded examples of many common and rare plots.
- [Quick R](https://www.statmethods.net/): a useful reference site for basic statistical analyses in R - read before trying an ANOVA or your results will differ from SPSS!

Thanks!
Ben and Callum...
# helper function to install packages if not already installed
usePackage <- function(p) {
    if (!is.element(p, installed.packages()[,1]))
        install.packages(p, dep = TRUE)
    require(p, character.only = TRUE)
}

usePackage("knitr")
usePackage("markdown")


#YOU MUST SET WORKING DIRECTORY FOR SCRIPT TO WORK
setwd("/path/to/working/directory")

#check to make sure run_analysis.Rmd exsists
stopifnot(file.exists('run_analysis.Rmd'))

#run script and output new CodeBook
knit(input="run_analysis.Rmd", output="CodeBook.md")
library(knitr)
library(markdown)
#set working directory as current directory
setwd("./")
knit("run_analysis.Rmd", encoding="ISO8859-1")
markdownToHTML("run_analysis.md", "run_analysis.html")
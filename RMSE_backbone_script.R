#' Calculate all of the relevant RMSEs across depths and GLM variables
#' Not close to done yet 
#' Written by Arianna Krinos, last edits on 30 August 2017

library(GLMr)
library(glmtools)
library(rLakeAnalyzer)

compare_to_field(SimFile, tempTemp, metric = 'water.temperature', as_value = FALSE, 
                 na.rm = TRUE, precision = 'days', method = 'interp')

# Make sure the working directory is the directory in which this
# script is contained, or it has all of the relevant observational data you
# would like to pull contained within it. 
# It also makes it easiest to put your GLM files in there. 
setwd(file.path(getwd(), "RMSE", fsep = .Platform$file.sep))


nameExperiment = "FCR1416"
simFolder = file.path(getwd(), nameExperiment, fsep = .Platform$file.sep)
run_glm(simFolder, verbose = TRUE) # of course, if this command works for you 
file = file.path(getwd(), nameExperiment, 'output.nc', fsep = .Platform$file.sep)

# If your run_glm doesn't work, just run GLM manually and the same should work. 

filesPresent = list.files(getwd())
glmVars = sim_vars(file)
if (length(grep("CTD", filesPresent)) != 0 ) {
   realdata = read.csv("FCR_CTD_wide_Dec14_Dec16.csv", header = TRUE)# for now, I can't think of anything but to hard-code this
   depths = colnames(realdata[2:ncol(realdata)])
   depths = unlist(strsplit(depths, split = "_")); depths = depths[!duplicated(depths)]; depths = as.numeric(depths[2:length(depths)])
}


if (length(grep("temp", glmVars$name)) != 0) {
  glmTemps = get_var(file, 'temp', z_out = c(depths))
  startDate = glmTemps$DateTime[1]; endDate = glmTemps$DateTime[nrow(glmTemps)]
}

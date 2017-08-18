# Basic script to run GLM for FCR

# Load packages, set sim folder, load nml file ####
library(GLMr)
library(glmtools)

sim_folder <- getwd() ##!! Edit this line of code (maybe-- if wd is not via GitHub repo) to redefine your sim_folder

nml_file <- paste0(sim_folder,"/glm2.nml") 
nml <- read_nml(nml_file) 

# Run GLM ####
run_glm(sim_folder, verbose=TRUE)
nc_file <- file.path(sim_folder, 'output.nc') #defines the output.nc file 

# get names of variables from output file
var_names <- sim_vars(nc_file)

# Proof of sim success plots ####
field_stage = file.path(sim_folder, 'FCR_stage_observed_022317.csv')
plot_compare_stage(nc_file,field_stage, main="dots = observed") # observed vs. sim lake stage

field_file <- file.path(sim_folder, 'FCR_2015_CTD_wtr.csv') # Define the observed field data
plot_temp_compare(nc_file, field_file) # Plot your GLM simulated data vs. the observed data 

# OPTIONAL PART 2: Nicole's unit conversion script ####
## Note that not all Sunapee output vars are included in current FCR runs ##
## Those variables are currently hashed out ##

# Switches
ConvertVariables = TRUE
RunSim = FALSE
PlotDetails = TRUE

SimFile <- nc_file

# Create new variables with units we understand
if (ConvertVariables){
  convert_sim_var(SimFile, DO = OXY_oxy * 32/1000, unit = 'mg/L',overwrite = T)
  #convert_sim_var(SimFile, TotP2 = TOT_tp * 30.97/1000, unit = 'mg/L',overwrite = T)
  convert_sim_var(SimFile, DOC = OGM_doc * 12/1000, unit = 'mg/L',overwrite = T)
  #convert_sim_var(SimFile, TOTC = TOT_toc * 12/1000, unit = 'mg/L',overwrite = T)
  #convert_sim_var(SimFile, TotN2 = TOT_tn * 14/1000, unit = 'mg/L',overwrite = T)
  convert_sim_var(SimFile, POP = OGM_pop * 30.97/1000, unit = 'mg/L',overwrite = T)
  convert_sim_var(SimFile, DOP = OGM_dop * 30.97/1000, unit = 'mg/L',overwrite = T)
  convert_sim_var(SimFile, FRP = PHS_frp * 30.97/1000, unit = 'mg/L',overwrite = T)
  convert_sim_var(SimFile, AmmN = NIT_amm * 14/1000, unit = 'mg/L',overwrite = T)#! nkw: not sure. is this NH4-N or NH4?
  convert_sim_var(SimFile, NitN = NIT_nit * 14/1000, unit = 'mg/L',overwrite = T)#!
}

# Plot heatmaps of variables with intuitive units ####

# Basic syntax for any variable from var_names
# plot_var(SimFile, "var_name")

# Temp
plot_temp(SimFile)

# DO
plot_var(SimFile,'DO')
DO <- get_var(SimFile,'DO', z_out = c(1, 5, 10, 20), reference = 'surface') # pull DO from 1m below surface
DO_long <- melt(DO, id.vars=c("DateTime"))

ggplot(DO_long, aes(y=value, x=DateTime, colour=variable)) + 
  geom_line(lwd=1.05) + mytheme +
  scale_y_continuous("Dissolved Oxygen (mg/L)")

# Nutrients
plot_var(SimFile,var_name = 'OGM_don',col_lim = c(0,50))
#plot_var(SimFile,var_name = 'TotP2')
plot_var(SimFile,var_name = 'DOC')
#plot_var(SimFile,var_name = 'TotN2')
plot_var(SimFile,var_name = 'NitN')
plot_var(SimFile,var_name = 'NIT_denit',col_lim=c(0,0.0000001))

plot_var(SimFile,var_name = 'PHY_NUP')
plot_var(SimFile,var_name = 'PHY_TPHYS')
plot_var(SimFile,var_name = 'PHY_TCHLA')

# Plot 'total' variables and their contributing components ####
#totn <- get_var(SimFile,var_name = 'TOT_tn',z_out = 1,reference = 'surface')
#plot(totn,type='l',ylim=c(0,50),col='black',lwd=3)
#lines(get_var(SimFile,var_name = 'OGM_pon',z_out = 1,reference = 'surface'),col='green',lwd=3)
#lines(get_var(SimFile,var_name = 'OGM_don',z_out = 1,reference = 'surface'),col='blue',lwd=3)
#lines(get_var(SimFile,var_name = 'NIT_amm',z_out = 1,reference = 'surface'),col='red')
#lines(get_var(SimFile,var_name = 'NIT_nit',z_out = 1,reference = 'surface'),col='grey')
#lines(get_var(SimFile,var_name = 'PHY_CYANOPCH1_IN',z_out = 1,reference = 'surface'),col='darkblue')
#lines(get_var(SimFile,var_name = 'PHY_CYANONPCH2_IN',z_out = 1,reference = 'surface'),col='darkgreen')
#lines(get_var(SimFile,var_name = 'PHY_CHLOROPCH3_IN',z_out = 1,reference = 'surface'),col='cyan')
#lines(get_var(SimFile,var_name = 'PHY_DIATOMPCH4_IN',z_out = 1,reference = 'surface'),col='lightblue')

temp<-get_var(SimFile,var_name = 'temp',z_out = 5,reference = 'surface')
plot(temp,type='l')

#totc<-get_var(SimFile,var_name = 'TOT_toc',z_out = 5,reference = 'surface')
#plot(totc,type='l',col='black',ylim=c(0,200),lwd=3)
#lines(get_var(SimFile,var_name = 'OGM_poc',z_out = 5,reference = 'surface'),col='green',lwd=3)
#lines(get_var(SimFile,var_name = 'OGM_doc',z_out = 5,reference = 'surface'),col='blue',lwd=3)
#lines(get_var(SimFile,var_name = 'CAR_dic',z_out = 5,reference = 'surface'),col='red')

#totp<-get_var(SimFile,var_name = 'TOT_tp',z_out = 10,reference = 'surface')
#plot(totp,type='l',col='black',ylim=c(0,0.3),lwd=3)
#lines(get_var(SimFile,var_name = 'PHS_frp',z_out = 10,reference = 'surface'),col='green',lwd=3)
#lines(get_var(SimFile,var_name = 'PHS_frp_ads',z_out = 10,reference = 'surface'),col='blue',lwd=3)
#lines(get_var(SimFile,var_name = 'PHS_sed_frp',z_out = 10,reference = 'surface'),col='red')
#lines(get_var(SimFile,var_name = 'OGM_pop',z_out = 10,reference = 'surface'),col='darkblue')
#lines(get_var(SimFile,var_name = 'OGM_dop',z_out = 10,reference = 'surface'),col='cyan',lwd=3)

# Extract key variables and write csv files of output ####
chla <- get_var(SimFile,var_name = 'PHY_TCHLA',z_out = 1,reference = 'surface')
write.csv(chla,"./model_output/chla_output_surface_2015.csv",row.names = FALSE,quote = FALSE)

lec <- get_var(SimFile,var_name = 'extc_coef',z_out=1,reference = 'surface')
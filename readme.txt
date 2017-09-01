FCR-GLM sim MEL 082517

Changes made to nml file relative to default values developed at GLM workshop in Madison, WI Jan. 2017

1. Run start and stop datetimes adjusted to reflect input field data added from fall 2015

2. Inflow and outflow filenames, vars, etc. adjusted to reflect data additions and corrections to those files

3. Kw changed from 0.85 to 0.87 based on calculated light attenuation from 2015 FCR field data

4. These changes all improved the shape of the epilimnion relative to field data:

coef_mix_shear changed from 0.3 to 0.2
sw_factor changed from 1 to 0.6
wind_factor changed from 1 to 0.7

5. Depth of SSS outflow changed from 498 to 506.9 (basically made it a normal surface outflow)

After having tried this outflow at several depths, I don't see substantial changes once you move the outflow out of the hypolimnion in terms of
thermocline depth. Personally, if we are going to make the SSS outflow depth a kludge, I support just making it a normal surface outflow for now
because I think a submerged outflow could cause further challenges in other variables later as well. 

READme for Ryan's Updates to MEL's OG .nml file_083117

1. coef_mix_KH = 0.2      Went from 0.3 to 0.2
2. coef_mix_hyp = 0.4     Went from 0.5 to 0.4

   3. wind_factor = 0.61   originally set to 0.7
   4. sw_factor = 0.5      originally set to 0.6
   5. lw_factor = 1.01     originally set to 1.0
   
   Apart from this I have not done ANYTHING ELSE TO THE .nml file. 
   
   The current RMSE output for the thermocline depth is 0.88, a small improvement from 1.2
   

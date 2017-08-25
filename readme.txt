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


*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



if(m_year(t) <= sm_fix_SSP2,
 i15_dem_intercept(iso,regr15)   = f15_demand_paras(regr15,"SSP2","intercept");
 i15_dem_saturation(iso,regr15)  = f15_demand_paras(regr15,"SSP2","saturation");
 i15_dem_halfsat(iso,regr15)     = f15_demand_paras(regr15,"SSP2","halfsaturation");
 i15_dem_nonsat(iso,regr15)      = f15_demand_paras(regr15,"SSP2","non_saturation");
else
 i15_dem_intercept(iso,regr15)   = f15_demand_paras(regr15,"%c15_food_scenario%","intercept")*p15_country_dummy(iso)
                                 + f15_demand_paras(regr15,"%c15_food_scenario_noselect%","intercept")*(1-p15_country_dummy(iso));
 i15_dem_saturation(iso,regr15)  = f15_demand_paras(regr15,"%c15_food_scenario%","saturation")*p15_country_dummy(iso)
                                 + f15_demand_paras(regr15,"%c15_food_scenario_noselect%","saturation")*(1-p15_country_dummy(iso));
 i15_dem_halfsat(iso,regr15)     = f15_demand_paras(regr15,"%c15_food_scenario%","halfsaturation")*p15_country_dummy(iso)
                                 + f15_demand_paras(regr15,"%c15_food_scenario_noselect%","halfsaturation")*(1-p15_country_dummy(iso));
 i15_dem_nonsat(iso,regr15)      = f15_demand_paras(regr15,"%c15_food_scenario%","non_saturation")*p15_country_dummy(iso)
                                 + f15_demand_paras(regr15,"%c15_food_scenario_noselect%","non_saturation")*(1-p15_country_dummy(iso));
);

option nlp = conopt4


*' @code
*' Within the major food groups determined by the regressions
*' (animal calories, empty calories, fruits, vegetable and nut calories as well as staple calories),
*' the relative share of individual products (e.g. eggs within animal calories)
*' is assumed to be constant. An exception is the demand for ruminant meat,
*' which declines in the course of the century at the cost of chicken meat.
*' @stop

if (sum(sameas(t_past,t),1) = 1,

*** Calculate the share of individual food products within major food groups, and replace zero shares with regional averages
* First set it to equal shares, just in case there is no population


     i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap) =
                                 sum(iso2, f15_kcal_pc_iso(t,iso2,kfo_ap)*im_pop_iso(t,iso2))/
                                 (
                                   sum((kfo_ap2,iso2),(f15_kcal_pc_iso(t,iso2,kfo_ap2)*im_pop_iso(t,iso2)))
                                   +10**(-5)
                                 );

     i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap)$sum(kfo_ap2,f15_kcal_pc_iso(t,iso,kfo_ap2)>0)=
                                 f15_kcal_pc_iso(t,iso,kfo_ap) /
                                 sum(kfo_ap2,f15_kcal_pc_iso(t,iso,kfo_ap2)
*                                10**(-5) required to avoid unlogical division by zero error.
                                 );

     i15_livestock_kcal_structure_iso(t,iso,kfo_ap) = i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap);

     i15_processed_kcal_structure_iso(t,iso,kfo_pf) =
                               sum(iso2, f15_kcal_pc_iso(t,iso2,kfo_pf)*im_pop_iso(t,iso2)) /
                               (
                                 sum((kfo_pf2,iso2),f15_kcal_pc_iso(t,iso2,kfo_pf2)*im_pop_iso(t,iso2))
                                 +10**(-5)
*                                10**(-5) required to avoid unlogical division by zero error. Ask Jan P
                               );

     i15_processed_kcal_structure_iso(t,iso,kfo_pf)$(sum(kfo_pf2,f15_kcal_pc_iso(t,iso,kfo_pf2))>0) =
                               f15_kcal_pc_iso(t,iso,kfo_pf)
                               /sum(kfo_pf2,f15_kcal_pc_iso(t,iso,kfo_pf2)
                               );

     i15_staples_kcal_structure_iso(t,iso,kfo_st) =
                               sum(iso2, f15_kcal_pc_iso(t,iso2,kfo_st)*im_pop_iso(t,iso2)) /
                               (
                                 sum((kfo_st2,iso2),f15_kcal_pc_iso(t,iso2,kfo_st2)*im_pop_iso(t,iso2))
                                 +10**(-5)
*                                10**(-5) required to avoid unlogical division by zero error. Ask Jan P
                               );

     i15_staples_kcal_structure_iso(t,iso,kfo_st)$(sum(kfo_st2,f15_kcal_pc_iso(t,iso,kfo_st2))>0) =
                               f15_kcal_pc_iso(t,iso,kfo_st)
                               /sum(kfo_st2,f15_kcal_pc_iso(t,iso,kfo_st2)
                               );


 else
* Assumptions on future calorie structure within food groups for future projections:
     i15_staples_kcal_structure_iso(t,iso,kfo_st) =i15_staples_kcal_structure_iso(t-1,iso,kfo_st);
     i15_processed_kcal_structure_iso(t,iso,kfo_pf) =i15_processed_kcal_structure_iso(t-1,iso,kfo_pf);
     i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap) = i15_livestock_kcal_structure_iso_raw(t-1,iso,kfo_ap);
     i15_livestock_kcal_structure_iso(t,iso,kfo_ap)     = i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap);
     i15_livestock_kcal_structure_iso(t,iso,"livst_chick") =
                                 i15_livestock_kcal_structure_iso_raw(t,iso,"livst_chick")
                                 + i15_livestock_kcal_structure_iso_raw(t,iso,"livst_rum") * (1-i15_rum_share_fadeout(t,iso));
    i15_livestock_kcal_structure_iso(t,iso,"livst_rum") =
                                 i15_livestock_kcal_structure_iso_raw(t,iso,"livst_rum") * i15_rum_share_fadeout(t,iso);

* Substitute milk demand in India with chicken, egg and fish (equally distributed) because milk demand in India shows an implausible increase
    	i15_livestock_kcal_structure_iso(t,"IND","livst_milk") =
                                 i15_livestock_kcal_structure_iso_raw(t,"IND","livst_milk") * i15_milk_share_fadeout_india(t);
    	i15_livestock_kcal_structure_iso(t,"IND","livst_chick") =
     							i15_livestock_kcal_structure_iso(t,"IND","livst_chick")
     							+ i15_livestock_kcal_structure_iso_raw(t,"IND","livst_milk") * (1-i15_milk_share_fadeout_india(t)) * 1/3;
    	i15_livestock_kcal_structure_iso(t,"IND","livst_egg") =
     							i15_livestock_kcal_structure_iso(t,"IND","livst_egg")
     							+ i15_livestock_kcal_structure_iso_raw(t,"IND","livst_milk") * (1-i15_milk_share_fadeout_india(t)) * 1/3;
    	i15_livestock_kcal_structure_iso(t,"IND","fish") =
     							i15_livestock_kcal_structure_iso(t,"IND","fish")
     							+ i15_livestock_kcal_structure_iso_raw(t,"IND","livst_milk") * (1-i15_milk_share_fadeout_india(t)) * 1/3;
 );


*' @code
*' The calculations are executed in the following order:
*'
*' In the beginning of each time step, the body height is estimated based on the diets
*' of the previous 15 years. In case that the time step length exceeds 5 years,
*' the consumption is extrapolated using the last two time steps.
*' Body height is estimated using the consumption of proteins and fats, in our case
*' the foodgroups animal products, pulses and oils.
*' To estimate the body size of underaged (0-14 years), we scale the WHO body height
*' recommendations for underaged with the divergence of the 15-19 year old.
*' The body height estimates are repeated again at the end of the time step to improve
*' the results of the extrapolation for cases where the time step length exceeds 5 years.
*' @stop

* ###### ANTHROPOMETRIC ESTIMATES
* ### Preliminary calculation of body height and weight based on food availability of last 3 timesteps.
* ### This may diverge from final calculation in the case where timestep length exceeds 5 years
* ### as then the demand depends on the result of MAgPIE.
* ### Calculations are therefore repeated after optimization.

* Calculations are only made after historical period. Before, we use historical values.

if (sum(sameas(t_past,t),1) = 1,

   p15_bodyheight(t,iso,sex,age,estimates15) = f15_bodyheight(t,iso,sex,age);


else

    p15_bodyheight(t,iso,sex,age,"preliminary") = p15_bodyheight(t-1,iso,sex,age,"final");
    p15_kcal_growth_food(t,iso,underaged15) = p15_kcal_growth_food(t-1,iso,underaged15);




    s15_yeardiff = m_yeardiff(t)/5;
* avoid fake 1yr timestep in 1995
    if(s15_yeardiff<1,s15_yeardiff=1);

    For (s15_count = 1 to s15_yeardiff,


* circular move of age by 5 years
* to find out about ++1 search for help on Circular Lag and Lead Operators in Assignments
          p15_bodyheight(t,iso,sex,age++1,"preliminary") = p15_bodyheight(t,iso,sex,age,"preliminary");

* replace age groups of 18 year old
          p15_bodyheight(t,iso,sex,"15--19","preliminary") =
                 f15_bodyheight_regr_paras(sex,"slope")*
                 (sum(underaged15,
                   p15_kcal_growth_food(t,iso,underaged15)
                 )/3)**f15_bodyheight_regr_paras(sex,"exponent")
                 ;

     );
*adjust body height of kids proportional to over18 population
     p15_bodyheight(t,iso,"M","0--4","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*92;
     p15_bodyheight(t,iso,"M","5--9","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*125;
     p15_bodyheight(t,iso,"M","10--14","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*152;

     p15_bodyheight(t,iso,"F","0--4","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*91;
     p15_bodyheight(t,iso,"F","5--9","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*124;
     p15_bodyheight(t,iso,"F","10--14","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*154;

);


*' @code



*### Estimate standardized food requirements
p15_bodyweight(t,iso,sex,age,bmi_group15)= f15_bmi(sex,age,bmi_group15) * (p15_bodyheight(t,iso,sex,age,"preliminary")/100)**2;

*' Physical activity levels (PAL) relative to the basic metabolic rate (BMR) are
*' estimated based on physical inactivity levels, assuming PALs for sedentary
*' and medium-active populations of 1.53 and 1.76 respectively:
p15_physical_activity_level(t,iso,sex,age)=
                            im_physical_inactivity(t,iso,sex,age) * 1.53
                            +(1-im_physical_inactivity(t,iso,sex,age)) * 1.76
                            ;

p15_intake(t,iso,sex,age,bmi_group15)=
                        (f15_schofield(sex,age, "intercept")
                        + f15_schofield(sex,age, "slope")*p15_bodyweight(t,iso,sex,age,bmi_group15))
                        * p15_physical_activity_level(t,iso,sex,age);


*' Pregnancy and lactation require additional food intake. To account for this,
*' newborns are distributed among reproductive women in a population. This number
*' is then multiplied with the extra energy requirements:
i15_kcal_pregnancy(t,iso)=sum(sex,im_demography(t,iso,sex,"0--4")/5) * ((40/66)*845 + (26/66)*675);

*' @stop



*###### Estimation of food demand using a first run of the food demand model with unshocked prices.

*' @code
*' Before MAgPIE is executed, the food demand model is executed, at first
*' without price shocks.
*' @stop

* demand for non-food products "knf" is set to 0;
vm_dem_food.fx(i,knf)=0;

*** Food demand model is calculated the first time for the current time step, using standard prices

p15_iteration_counter(t)    =0;

display "starting demand model for initialisation run....";


* helping the solver by starting from reasonable values
* by setting real income per capita on exogenous gdp per capita
v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.fx(iso)=im_gdp_pc_ppp_iso(t,iso);

solve m15_food_demand USING nlp MAXIMIZING v15_objective ;
p15_modelstat(t) = m15_food_demand.modelstat;

display "Food Demand Model Initialisation run finished with modelstat ";
display p15_modelstat;
if(( p15_modelstat(t)) > 2 and (p15_modelstat(t) ne 7 ),
  m15_food_demand.solprint = 1
  Execute_Unload "fulldata.gdx";
  abort "Food Demand Model became infeasible already during initialisation run. Stop run.";
);

* releasing real income per capita binding for later runs that include shocks
v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.up(iso)=Inf;

* saving regression outcome for per capita food demand for different foods
p15_kcal_regr(t, iso, kfo)=v15_kcal_regr.l(iso, kfo);

* saving regression outcome for BMI shares
p15_bmi_shr_regr(t,iso,sex,age,bmi_group15)=v15_bmi_shr_regr.l(iso,sex,age,bmi_group15);

* deriving calibration values

*' @code
*' Per capita food demand and BMI shares are calibrated so that historical data
*' are met. For this purpose, the residual between the regression fit and the
*' observation is calculated for the historical period. When the historical period
*' ends, the calibration factor is fixed at the value of the last historical time
*' step. Additionally, a second calibration is required to meet the world totals
*' of FAOSTAT food demand for different foods. While the food demand model estimates
*' the demand for all countries of the world, FAOSTAT only covers a subset of
*' countries. To match FAOSTAT totals, the food demand of countries not included
*' in FAOSTAT is calibrated to zero. As this calibration is done ex-post, food
*' demand estimates can still be used for all countries, but MAgPIE only considers
*' demand from FAOSTAT countries.

if (sum(sameas(t_past,t),1) = 1,
    p15_kcal_calib(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))=0) = 0;
    p15_balanceflow_kcal_iso(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))>0) = 0;
    p15_kcal_calib(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))>0) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regr.l(iso, kfo);
    p15_balanceflow_kcal_iso(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))=0) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regr.l(iso, kfo);

    p15_kcal_calib_lastcalibyear(iso,kfo) = p15_kcal_calib(t,iso,kfo);
    p15_balanceflow_kcal_lastcalibyear(iso,kfo) = p15_balanceflow_kcal_iso(t,iso,kfo);

    i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
                      f15_bmi_shr_past(t,iso,age,sex,bmi_group15) -
                      v15_bmi_shr_regr.l(iso,sex,age,bmi_group15);
    i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15)=
                      i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

else
*' Depending on the scenario switch c15_calibscen, the divergence of the demand from the
*' historical data is kept constant or faded out.
    p15_kcal_calib(t,iso,kfo) = p15_kcal_calib_lastcalibyear(iso,kfo) * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
*' The divergence of the kcal of countries with no FAOSTAT data is kept constant
*' over time.
    p15_balanceflow_kcal_iso(t,iso,kfo) = p15_balanceflow_kcal_lastcalibyear(iso,kfo);

*' Depending on the scenario switch c15_calibscen, the divergence of the BMI shares from the
*' historical data is kept constant over time or faded out.
   i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
                     i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15)
                     * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
);

*' The calibration factor is added to the regression value.
   p15_kcal_pc_iso(t,iso,kfo) =
          v15_kcal_regr.l(iso,kfo) + p15_kcal_calib(t,iso,kfo) * s15_calibrate;
*' Negative values that can possibly occur due to calibration are set to zero.
   p15_kcal_pc_iso(t,iso,kfo)$(p15_kcal_pc_iso(t,iso,kfo)<0) = 0;

*' The country-level parameter p15_kcal_pc_iso is aggregated to the
*' regional level. After removing estimates from countries that are not included
*' in FAOSTAT, the resulting parameter p15_kcal_pc_calibrated is provided to
*' constraint q15_food_demand in the MAgPIE model, which defines the demand for food.
*' @stop

* aggregate to regions
 p15_kcal_pc(t,i,kfo)$(
    sum(i_to_iso(i,iso),
       im_pop_iso(t,iso)
    ) >0 ) =
             sum(i_to_iso(i,iso),
               p15_kcal_pc_iso(t,iso,kfo)
               * im_pop_iso(t,iso)
             ) / sum(i_to_iso(i,iso),
                 im_pop_iso(t,iso)
             );

 p15_balanceflow_kcal(t,i,kfo)$(
    sum(i_to_iso(i,iso),
       im_pop_iso(t,iso)
    ) >0 ) =
             sum(i_to_iso(i,iso),
               p15_balanceflow_kcal_iso(t,iso,kfo)
               * im_pop_iso(t,iso)
             ) / sum(i_to_iso(i,iso),
                 im_pop_iso(t,iso)
             );


 p15_kcal_pc_initial_iso(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
 pm_kcal_pc_initial(t,i,kfo) =  p15_kcal_pc(t,i,kfo);

 o15_kcal_regr_initial(t,iso,kfo)=v15_kcal_regr.l(iso,kfo);

* Finally, we calibrate countries with zero food demand according to FAOSTAT
* down to zero to match FAO world totals.
* Values are rounded to avoid path dependencies of MAgPIE solver.
 p15_kcal_pc_calibrated(t,i,kfo)=p15_kcal_pc(t,i,kfo)+p15_balanceflow_kcal(t,i,kfo);
 p15_kcal_pc_calibrated(t,i,kfo)=round(p15_kcal_pc_calibrated(t,i,kfo),2);
 p15_kcal_pc_calibrated(t,i,kfo)$(p15_kcal_pc_calibrated(t,i,kfo)<0)=0;




*###############################################################################
* ###### Exogenous food substitution scenarios


*' Substitution of ruminant beef with poultry:
p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,"livst_rum") =
               p15_kcal_pc_calibrated_orig(t,i,"livst_rum") * i15_ruminant_fadeout(t);
p15_kcal_pc_calibrated(t,i,"livst_chick") = p15_kcal_pc_calibrated_orig(t,i,"livst_chick")
             + p15_kcal_pc_calibrated_orig(t,i,"livst_rum") * (1-i15_ruminant_fadeout(t));

*' Substitution of fish with poultry:
p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,"fish") =
               p15_kcal_pc_calibrated_orig(t,i,"fish") * i15_fish_fadeout(t);
p15_kcal_pc_calibrated(t,i,"livst_chick") = p15_kcal_pc_calibrated_orig(t,i,"livst_chick")
             + p15_kcal_pc_calibrated_orig(t,i,"fish") * (1-i15_fish_fadeout(t));

*' Fade-out of alcohol consumption without substitution:
p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,"alcohol") =
               p15_kcal_pc_calibrated_orig(t,i,"alcohol") * i15_alcohol_fadeout(t);

*' Substitution of livestock products (without fish) with plant-based food commodities:
p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated_livestock_orig(t,i) = sum(kfo_lp,p15_kcal_pc_calibrated(t,i,kfo_lp));
p15_kcal_pc_calibrated_plant_orig(t,i) = sum(kfo_pp,p15_kcal_pc_calibrated(t,i,kfo_pp));

p15_livestock_kcal_structure_orig(t,i,kfo_lp)$(p15_kcal_pc_calibrated_livestock_orig(t,i)>0) =
                               p15_kcal_pc_calibrated(t,i,kfo_lp)
                               /p15_kcal_pc_calibrated_livestock_orig(t,i);

p15_plant_kcal_structure_orig(t,i,kfo_pp)$(p15_kcal_pc_calibrated_plant_orig(t,i)>0) =
                               p15_kcal_pc_calibrated(t,i,kfo_pp)
                               /p15_kcal_pc_calibrated_plant_orig(t,i);

p15_kcal_pc_calibrated(t,i,kfo_lp) = p15_livestock_kcal_structure_orig(t,i,kfo_lp)
               *p15_kcal_pc_calibrated_livestock_orig(t,i)*i15_livestock_fadeout(t);
p15_kcal_pc_calibrated(t,i,kfo_pp) = p15_plant_kcal_structure_orig(t,i,kfo_pp)
               *(p15_kcal_pc_calibrated_plant_orig(t,i)
               + p15_kcal_pc_calibrated_livestock_orig(t,i) * (1-i15_livestock_fadeout(t)));




*###############################################################################
* ######  WASTE CALCULATIONS (required for exogenous food waste or diet scenarios)

* The ratio of food demand at household level to food intake is determined
* by the amount of food that is wasted. This ratio is one of the drivers of
* future food demand trajetories.
* For the calculation of the ratio between food demand and intake, total food
* calorie intake based on CALIBRATED parameters needs to be calculated:

p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15) =
           p15_bmi_shr_regr(t,iso,sex,age,bmi_group15)+
           i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

* The BMI shares are not allowed to exceed the bounds 0 and 1. Values are corrected to the bounds.
p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)$(p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)<0) = 0;
p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)$(p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)>1) = 1;
* The mismatch is balanced by moving the exceeding quantities into the middle BMI group.
p15_bmi_shr_calibrated(t,iso,sex,age,"medium")=
      1 - (sum(bmi_group15, p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15))
      - p15_bmi_shr_calibrated(t,iso,sex,age,"medium"));

p15_intake_total_iso_calibrated(t,iso) =
       sum((sex, age, bmi_group15), p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)*
       im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,bmi_group15) )
       + i15_kcal_pregnancy(t,iso);

p15_intake_total_calibrated(t,i)$(sum(i_to_iso(i,iso),sum((sex,age), im_demography(t,iso,sex,age)) ) >0 )
          = sum(i_to_iso(i,iso),p15_intake_total_iso_calibrated(t,iso)
            ) / sum(i_to_iso(i,iso),
                sum((sex,age), im_demography(t,iso,sex,age))
            );

p15_demand2intake_ratio(t,i)$(p15_intake_total_calibrated(t,i) >0 ) =
         sum(kfo,p15_kcal_pc_calibrated(t,i,kfo)) /
         p15_intake_total_calibrated(t,i);

* In case, no exogenous waste scenario is selceted, the original regression-
* based estimates for food calorie oversupply are used as waste scenario.
* This information is needed in case that an exogenous diet scenario should be
* constructed from food calorie intake.
p15_demand2intake_ratio_scen(t,i) =p15_demand2intake_ratio(t,i);




*###############################################################################
* ###### Exogenous food waste scenario

if (s15_exo_waste = 1,

* "Downwards convergence" of regional calorie oversupply due to food waste to the
* waste reduction target, i.e. only for values that are higher than the target:

p15_demand2intake_ratio_scen(t,i)$(p15_demand2intake_ratio(t,i) > s15_waste_scen )
                    = p15_demand2intake_ratio(t,i)*(1-i15_exo_foodscen_fader(t,i))
                      + s15_waste_scen*i15_exo_foodscen_fader(t,i);

p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,kfo)$(p15_demand2intake_ratio(t,i) >0 ) = p15_kcal_pc_calibrated_orig(t,i,kfo)*(
                      p15_demand2intake_ratio_scen(t,i)/p15_demand2intake_ratio(t,i) );

);


* Now, a second waste parameter can be calculated, which is needed for the construction  
* of exogenous diet scenarios on the basis of calorie intake. This parameter describes 
* the development of food waste over time and reflects either the exogenous food waste 
* scenario or the original regression-based estimates for food calorie oversupply:

p15_foodwaste_growth(t,i) = ( 1$(p15_demand2intake_ratio_ref(i) = 0)
            + (p15_demand2intake_ratio_scen(t,i)/p15_demand2intake_ratio_ref(i))$(
              p15_demand2intake_ratio_ref(i) > 0)
              );




*###############################################################################
* ###### Exogenous EAT Lancet diet scenarios

*' @code
*' Transition to exogenous EAT Lancet diet scenarios:
*' It is possible to define exogenous diet scenarios that replace the regression-based
*' calculation of food intake and demand according to a predefined speed of
*' convergence from `p15_kcal_pc_calibrated(t,i,kfo)` to the scenario-dependent target
*' `i15_kcal_pc_scen_target(t,i,kfo)` by setting the switch `s15_exo_diet` to 1
*' (exogenous diets parametrized to a food-specific data set published by the 
*' EAT-Lancet Commission (Willett et al., 2019)) or 2 (MAgPIE-specific realization 
*' of the EAT Lancet diet, where model-internal diet projections are constraint by 
*' ranges for intake of food groups).



if (s15_exo_diet > 0,




*' 1.) In a first step, the exogenous scenario diets are defined by selecting a
*' scenario target for total daily per capita food intake and by choosing
*' a variant of healthy and sustainable dietary patterns:

$ifthen "%c15_kcal_scen%" == "healthy_BMI"
  i15_intake_scen_target(t,i) = sum(i_to_iso(i,iso),
        sum((sex, age), im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,"medium") )
        + i15_kcal_pregnancy(t,iso)
        ) / sum(i_to_iso(i,iso),
            sum((sex,age), im_demography(t,iso,sex,age))
        );
  i15_intake_EATLancet(i,kfo) =
        f15_intake_EATLancet("%c15_exo_scen_targetyear%",i,"2100kcal","%c15_EAT_scen%",kfo);
$else
  i15_intake_EATLancet(i,kfo) =
        f15_intake_EATLancet("%c15_exo_scen_targetyear%",i,"%c15_kcal_scen%","%c15_EAT_scen%",kfo);
  i15_intake_scen_target(t,i) = sum(kfo,i15_intake_EATLancet(i,kfo));
$endif




*' 2.) The second step defines the daily per capita intake of different food commodities. 

*----------------------------------------------------------------------------------------
if (s15_exo_diet = 1,
*' In case of diet scenarios that are parametrized to a food-specific data set published   
*' by the EAT-Lancet Commission (`s15_exo_diet=1`), this calculation step consists of
*' filling up the scenario target for total daily per capita food intake according
*' to the food-specific calorie intake of non-staple crops of this data set. In case 
*' that the in step 1.) selected total calorie intake is not equal to total intake
*' of the data set, only the calories for staple crops are modified and calories for  
*' non-staple food commodities are preserved.

if ( sum(i,(i15_intake_scen_target(t,i) - sum(kfo,i15_intake_EATLancet(i,kfo))**2 ) )  = 0,
    i15_intake_detailed_scen_target(t,i,kfo) = i15_intake_EATLancet(i,kfo);
else
    i15_intake_detailed_scen_target(t,i,EAT_nonstaples) = i15_intake_EATLancet(i,EAT_nonstaples);
    i15_intake_detailed_scen_target(t,i,EAT_staples) = (
            i15_intake_scen_target(t,i) - sum(EAT_nonstaples,i15_intake_EATLancet(i,EAT_nonstaples)) )*(
            i15_intake_EATLancet(i,EAT_staples)/sum(EAT_staples2,i15_intake_EATLancet(i,EAT_staples2)) );
);

*----------------------------------------------------------------------------------------

elseif s15_exo_diet = 2,
*' In case of a MAgPIE-specific realization of the EAT Lancet diet (`s15_exo_diet=2`),    
*' model-internal diet projections are constraint by recommended ranges for intake 
*' (`i15_rec_EATLancet`) of different food groups to ensure healthy and sustainable 
*' diets according to the EAT-Lancet Commission. After all calorie recommendations
*' for non-staple food groups are satisfied, intake of staple crops is modified such 
*' that the in step 1.) selected total calorie intake is met.


* Set maximum for foods that are not restricted by EAT-Lancet recommendations to total scenario food intake:
i15_rec_EATLancet(i,EAT_targets15,"max")$(i15_rec_EATLancet(i,EAT_targets15,"max")=0) = i15_intake_scen_target(t,i);
* Switch off maximum target for roots, since they will, as staples, later be treated as balancing post
* to meet total calorie intake:
i15_rec_EATLancet(i,"t_roots","max") = i15_intake_scen_target(t,i);
 

* ### Food-specific calorie intake
* For calculating model-internal diet projections, food-specific calorie intake is 
* estimated from daily per capita food calorie demand, using food-specific ratios
* between food calorie supply and food intake:
p15_intake_detailed_regr(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo)
	 	/(i15_calib_fsupply(i)*i15_demand2intake_detailed_ref(i,kfo)*p15_foodwaste_growth(t,i));
i15_intake_detailed_scen_target(t,i,kfo) = p15_intake_detailed_regr(t,i,kfo); 
* Note: brans are the only food commodity that will not be affected by the following calculations.


* ###Minimum recommendations:
* If projected food intake is below minimum, increase it to recommendations:
i15_intake_detailed_scen_target(t,i,kfo)$(sum(EATtar_kfo15(EAT_mtargets15_2,kfo),sum(EATtar_kfo15_2(EAT_mtargets15_2,kfo2),p15_intake_detailed_regr(t,i,kfo2)))
	< sum(EATtar_kfo15(EAT_mtargets15,kfo),i15_rec_EATLancet(i,EAT_mtargets15,"min")))
	= (p15_intake_detailed_regr(t,i,kfo)/sum(EATtar_kfo15(EAT_mtargets15_2,kfo),sum(EATtar_kfo15_2(EAT_mtargets15_2,kfo2),p15_intake_detailed_regr(t,i,kfo2))))
	* sum(EATtar_kfo15(EAT_mtargets15,kfo),i15_rec_EATLancet(i,EAT_mtargets15,"min"));

display p15_intake_detailed_regr;
display i15_intake_detailed_scen_target;


* ###Maximum recommendations:
* If projected food intake is above maximum, decrease it to recommendations:
i15_intake_detailed_scen_target(t,i,kfo)$(sum(EATtar_kfo15(EAT_mtargets15_2,kfo),sum(EATtar_kfo15_2(EAT_mtargets15_2,kfo2),p15_intake_detailed_regr(t,i,kfo2)))
	> sum(EATtar_kfo15(EAT_mtargets15,kfo),i15_rec_EATLancet(i,EAT_mtargets15,"max")))
	= (p15_intake_detailed_regr(t,i,kfo)/sum(EATtar_kfo15(EAT_mtargets15_2,kfo),sum(EATtar_kfo15_2(EAT_mtargets15_2,kfo2),p15_intake_detailed_regr(t,i,kfo2))))
	* sum(EATtar_kfo15(EAT_mtargets15,kfo),i15_rec_EATLancet(i,EAT_mtargets15,"max"));

display p15_intake_detailed_regr;
display i15_intake_detailed_scen_target;


* ### Minimum recommendations for fruits, vegetables, nuts and seeds (targets available for "t_nutseeds" and "t_fruitveg"):
if (sum(sameas(t_past,t),1) = 1,
   i15_fruitveg2others_kcal_ratio(t,i) = f15_fruitveg2others_kcal_ratio(t,i);
else
   i15_fruitveg2others_kcal_ratio(t,i) = f15_fruitveg2others_kcal_ratio(t-1,i);
);

* Split "others" into fruits plus vegetables, and those nuts and seeds that are not included in "rapeseed", "groundnut", and "sunflower": 
p15_intake_detailed_regr_fruitveg(t,i) = i15_fruitveg2others_kcal_ratio(t,i)*p15_intake_detailed_regr(t,i,"others");
p15_intake_detailed_regr_nsothers(t,i) = (1-i15_fruitveg2others_kcal_ratio(t,i))*p15_intake_detailed_regr(t,i,"others");
i15_intake_detailed_scen_fruitveg(t,i) = p15_intake_detailed_regr_fruitveg(t,i);
i15_intake_detailed_scen_nsothers(t,i) = p15_intake_detailed_regr_nsothers(t,i);

* Minimum recommendation for fruits and vegetables:
i15_intake_detailed_scen_fruitveg(t,i)$(p15_intake_detailed_regr_fruitveg(t,i) < i15_rec_EATLancet(i,"t_fruitveg","min"))
	= i15_rec_EATLancet(i,"t_fruitveg","min");

* Minimum recommendation for nuts and seeds included in "others"
i15_intake_detailed_scen_nsothers(t,i)$( (sum(kfo_ns,p15_intake_detailed_regr(t,i,kfo_ns)) + p15_intake_detailed_regr_nsothers(t,i) )
	< i15_rec_EATLancet(i,"t_nutseeds","min") )
	= (p15_intake_detailed_regr_nsothers(t,i)
	/(sum(kfo_ns,p15_intake_detailed_regr(t,i,kfo_ns)) + p15_intake_detailed_regr_nsothers(t,i)) )
	* i15_rec_EATLancet(i,"t_nutseeds","min");

* Minimum recommendation for rapeseed,groundnut,sunflower:
i15_intake_detailed_scen_target(t,i,kfo_ns)$( (sum(kfo_ns2,p15_intake_detailed_regr(t,i,kfo_ns2)) + p15_intake_detailed_regr_nsothers(t,i) )
	< i15_rec_EATLancet(i,"t_nutseeds","min") )
	= (p15_intake_detailed_regr(t,i,kfo_ns)
	/(sum(kfo_ns2,p15_intake_detailed_regr(t,i,kfo_ns2)) + p15_intake_detailed_regr_nsothers(t,i)) )
	* i15_rec_EATLancet(i,"t_nutseeds","min");

* Calculate resulting intake of "others":
i15_intake_detailed_scen_target(t,i,"others") = i15_intake_detailed_scen_fruitveg(t,i) + i15_intake_detailed_scen_nsothers(t,i);

* Update of the ratio of fruits and vegetables within the "others" category:
i15_fruitveg2others_kcal_ratio_scen(t,i)$(i15_intake_detailed_scen_target(t,i,"others")>0) 
	= i15_intake_detailed_scen_fruitveg(t,i)/i15_intake_detailed_scen_target(t,i,"others");

display p15_intake_detailed_regr;
display i15_intake_detailed_scen_target;


* ### Food commodities that are not included in diet recommendations are set to Zero: 
i15_intake_detailed_scen_target(t,i,kfo_norec) = 0;


* ### Alcohol:
* The EAT-Lancet diet only allows for added sugars, but does not include processed food or alcohol.
* Via 's15_alc_scen' a maximum target for alcohol consumption can be defined, e.g. according to Lassen et al., (2020).
if(s15_alc_scen>0,
*first, reduce projected alcohol consumption by a quarter:
i15_intake_detailed_scen_target(t,i,"alcohol") = p15_intake_detailed_regr(t,i,"alcohol")*3/4;
*if still above target, set to maximum:
i15_intake_detailed_scen_target(t,i,"alcohol")$(i15_intake_detailed_scen_target(t,i,"alcohol") > s15_alc_scen*i15_intake_scen_target(t,i))
	= s15_alc_scen*i15_intake_scen_target(t,i);
);


* ### Staple crops:
* After all calorie recommendations for non-staple food groups are satisfied, intake of staple crops is 
* now modified such that the in step 1.) selected total calorie intake is met:
i15_intake_detailed_scen_target(t,i,EAT_staples) = (
            i15_intake_scen_target(t,i) - sum(EAT_nonstaples,i15_intake_detailed_scen_target(t,i,EAT_nonstaples)) )*(
            p15_intake_detailed_regr(t,i,EAT_staples)/sum(EAT_staples2,p15_intake_detailed_regr(t,i,EAT_staples2)) );
);

display p15_intake_detailed_regr;
display i15_intake_detailed_scen_target;

*----------------------------------------------------------------------------------------




*' 3.) The third step estimates the calorie availability at household level by multiplying
*' daily per capita calorie intake with a food-specific ratio  of calorie availability 
*' to intake (`i15_demand2intake_detailed_ref(i,kfo)`), based on FAO estimates on 
*' historical food waste at consumption level, and with a calibration factor 
*' `i15_calib_fsupply(i)`. This factor ensures that the resulting estimated food
*' supply (based on MAgPIE calorie intake and food waste assumptions) is calibrated to 
*' FAO food supply for available historical time steps. A multiplicative factor 
*' (`p15_foodwaste_growth(t,i)`) accounts for increases in food waste over time.

i15_kcal_pc_scen_target(t,i,kfo) = (i15_calib_fsupply(i)*i15_demand2intake_detailed_ref(i,kfo)
                                    *i15_intake_detailed_scen_target(t,i,kfo))
                                    *p15_foodwaste_growth(t,i);




*' 4.) In the last step, the regression-based calculation of daily per capita food demand
*' is faded into the exogenous diet scenario according to a predefined speed of
*' convergence (note that fading should start after the historical time slice of
*' the EAT Lancet diet scenarios (y2010) as defined in `i15_exo_foodscen_fader(t,i)`):

p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,kfo) = p15_kcal_pc_calibrated_orig(t,i,kfo) * (1-i15_exo_foodscen_fader(t,i))
                        + i15_kcal_pc_scen_target(t,i,kfo) * i15_exo_foodscen_fader(t,i);



);


*' @stop

*###############################################################################




*' @code
*' Now, MAgPIE is executed.
*' @stop

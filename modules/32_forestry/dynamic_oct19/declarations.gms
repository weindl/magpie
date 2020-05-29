*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s32_shift                               Number of 5-year age-classes corresponding to current time step length (1)
 p32_max_aff_area                        Maximum global afforestation area that is greater or equal the exogenous policy target (mio. ha)
;

parameters
 p32_land(t,j,type32,ac)                 Forestry land for each cell wood type and age class before and after optimization (mio. ha)
 pc32_land(j,type32,ac)                  Forestry land per forestry land type initialization of the optimization (mio. ha)
 p32_aff_pot(t,j)                        Potential afforestation area on cropland and pasture land (mio. ha)
 p32_aff_pol(t,j)			             Exogenous afforestation target as stock (mio. ha)
 p32_aff_pol_timestep(t,j)			     Exogenous afforestation target as flow per time step (mio. ha per timestep)
 p32_aff_togo(t)              		     Remaining exogenous afforestation wrt to the maximum exogenous target over time (mio. ha)
 p32_cdr_ac(t,j,ac)						 Non-cumulative CDR from afforestation for each age-class depending on planning horizon (tC per ha)
 p32_carbon_density_ac(t,j,type32,ac,ag_pools)      Carbon density for ac and ag_pools (tC per ha)
;

positive variables
 vm_cost_fore(i)                         Afforestation costs (mio. USD04MER per yr)
 vm_land_fore(j,type32,ac)                    Forestry land pools (mio. ha)
 vm_landdiff_forestry                   Aggregated difference in forestry land compared to previous timestep (mio. ha)
 v32_land_expansion(j,type32,ac) 		 Forestry land expansion compared to previous timestep (mio. ha)
 v32_land_reduction(j,type32,ac) 		 Forestry land reduction compared to previous timestep (mio. ha)
 vm_cdr_aff(j,ac) 						 Expected CDR from afforestation depending on planning horizon (mio. tC)
;

equations
 q32_cost_fore_ac(i)                      Total forestry costs constraint (mio. USD04MER)
 q32_land(j)                              Land constraint (mio. ha)
 q32_cdr_aff(j,ac)  			  		  Calculation of CDR from afforestation in terms of CO2-C (mio. tC)
 q32_carbon(j,ag_pools)                   Forestry carbon stock calculation C (mio. tC)
 q32_land_diff                            Aggregated difference in forestry land compared to previous timestep (mio. ha)
 q32_land_expansion(j,type32,ac)	   	  Forestry land expansion (mio. ha)
 q32_land_reduction(j,type32,ac)	   	  Forestry land reduction (mio. ha)
 q32_max_aff					          Maximum total global afforestation (mio. ha)
 q32_aff_pol(j)					          Afforestation policy constraint (mio. ha)
 q32_aff_ac0(j)							  Afforestation constraint for ac0 (mio. ha)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)                  Afforestation costs (mio. USD04MER per yr)
 ov_land_fore(t,j,type32,ac,type)        Forestry land pools (mio. ha)
 ov_landdiff_forestry(t,type)            Aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov32_land_expansion(t,j,type32,ac,type) Forestry land expansion compared to previous timestep (mio. ha)
 ov32_land_reduction(t,j,type32,ac,type) Forestry land reduction compared to previous timestep (mio. ha)
 ov_cdr_aff(t,j,ac,type)                 Expected CDR from afforestation depending on planning horizon (mio. tC)
 oq32_cost_fore_ac(t,i,type)             Total forestry costs constraint (mio. USD04MER)
 oq32_land(t,j,type)                     Land constraint (mio. ha)
 oq32_cdr_aff(t,j,ac,type)               Calculation of CDR from afforestation in terms of CO2-C (mio. tC)
 oq32_carbon(t,j,ag_pools,type)          Forestry carbon stock calculation C (mio. tC)
 oq32_land_diff(t,type)                  Aggregated difference in forestry land compared to previous timestep (mio. ha)
 oq32_land_expansion(t,j,type32,ac,type) Forestry land expansion (mio. ha)
 oq32_land_reduction(t,j,type32,ac,type) Forestry land reduction (mio. ha)
 oq32_max_aff(t,type)                    Maximum total global afforestation (mio. ha)
 oq32_aff_pol(t,j,type)                  Afforestation policy constraint (mio. ha)
 oq32_aff_ac0(t,j,type)                  Afforestation constraint for ac0 (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

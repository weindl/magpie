*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


parameters
 i60_bioenergy_dem(t,i)                           Regional bioenergy demand per year (mio. GJ per yr)
 im_res_2ndgenBE_dem(t,i)                         Regional residue demand for 2nd generation bioenergy per year (mio. GJ per yr)
 i60_1stgen_bioenergy_dem(t,i,kall)               Regional 1st generation bioenergy demand (mio. GJ per yr)
 i60_1stgen_bioenergy_subsidy_tdm(t)              Global 1st generation bioenergy subsidy per tDM (USD17MER per tDM)
 i60_1stgen_bioenergy_subsidy_gj(t)               Global 1st generation bioenergy subsidy per GJ (USD17MER per GJ)
 i60_2ndgen_bioenergy_subsidy(t)                  Global 2nd generation bioenergy subsidy (USD17MER per GHJ)
 p60_region_BE_shr(t_all,i)                       Bioenergy demand share of the region (1)
 p60_country_switch(iso)                          Switch indicating whether country is affected by selected bioenergy demand scenario (1)
;

positive variables
 vm_dem_bioen(i,kall)                       Regional feedstock demand for energy from biomass  (mio. tDM per yr)
 v60_2ndgen_bioenergy_dem_dedicated(i,kall) Regional demand for energy from dedicated 2nd generation bioenergy crops (mio. GJ per yr)
 v60_2ndgen_bioenergy_dem_residues(i,kall)  Regional demand for energy from residues (mio. GJ per yr)
 v60_res_substitution_bioen(i)              Regional substitution of residues by dedicated bioenergy crops for bioenergy (mio. GJ per yr)
;

variables
  vm_bioenergy_utility(i)                   Utility as negative costs for producing bioenergy (USD17MER per yr)
;

equations
 q60_bioenergy(i,kall)                     Regional demand for energy from biomass (mio. GJ per yr)
 q60_bioenergy_glo                         Global energy demand from dedicated 2nd generation bioenergy crops (mio. GJ per yr)
 q60_bioenergy_reg(i)                      Regional energy demand from dedicated 2nd generation bioenergy crops (mio. GJ per yr)
 q60_res_to_BEcrops_subs_bioen(i)          Regional substitution of residues with bioenergy crops to produce bioenergy (mio. GJ per yr)
 q60_res_2ndgenBE(i)                       Regional residue availability as 2nd generation biomass feedstock (mio. GJ per yr)
 q60_bioenergy_incentive(i)                Incentive to produce bioenergy (mio. USD17MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_bioen(t,i,kall,type)                        Regional feedstock demand for energy from biomass  (mio. tDM per yr)
 ov60_2ndgen_bioenergy_dem_dedicated(t,i,kall,type) Regional demand for energy from dedicated 2nd generation bioenergy crops (mio. GJ per yr)
 ov60_2ndgen_bioenergy_dem_residues(t,i,kall,type)  Regional demand for energy from residues (mio. GJ per yr)
 ov60_res_substitution_bioen(t,i,type)              Regional substitution of residues by dedicated bioenergy crops for bioenergy (mio. GJ per yr)
 ov_bioenergy_utility(t,i,type)                     Utility as negative costs for producing bioenergy (USD17MER per yr)
 oq60_bioenergy(t,i,kall,type)                      Regional demand for energy from biomass (mio. GJ per yr)
 oq60_bioenergy_glo(t,type)                         Global energy demand from dedicated 2nd generation bioenergy crops (mio. GJ per yr)
 oq60_bioenergy_reg(t,i,type)                       Regional energy demand from dedicated 2nd generation bioenergy crops (mio. GJ per yr)
 oq60_res_to_BEcrops_subs_bioen(t,i,type)           Regional substitution of residues with bioenergy crops to produce bioenergy (mio. GJ per yr)
 oq60_res_2ndgenBE(t,i,type)                        Regional residue availability as 2nd generation biomass feedstock (mio. GJ per yr)
 oq60_bioenergy_incentive(t,i,type)                 Incentive to produce bioenergy (mio. USD17MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


parameters
 i63_biochar_dem(t,i)                           Regional biochar demand from dedicated crops per year (mio. GJ per yr)
 i63_res_2ndgenBC_dem(t,i)                      Regional biochar demand from residues per year (mio. GJ per yr)
 p63_region_BC_shr(t_all,i)                     Biochar demand share of the region derived from country selection (1)
 p63_country_dummy(iso)                         Dummy parameter indicating whether country is selected for biochar demand scenario (1)
;

positive variables
 vm_dem_biochar(i,kall)                         Regional biochar feedstock demand specified for all biomass types (mio. tDM per yr)
 v63_2ndgen_biochar_dem_dedicated(i,kall)       Regional biochar demand specified for different dedicated crops (mio. GJ per yr)
 v63_2ndgen_biochar_dem_residues(i,kall)        Regional biochar demand specified for different residue types (mio. GJ per yr)
;

equations
 q63_biochar(i,kall)                            Global total biochar demand (mio. GJ per yr)
 q63_biochar_glo                                Global biochar demand from dedicated crops (mio. GJ per yr)
 q63_biochar_reg(i)                             Regional biochar demand from dedicated crops (mio. GJ per yr)
 q63_res_2ndgenBC(i)                            Regional biochar demand from residues (mio. GJ per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_biochar(t,i,kall,type)                    Regional biochar feedstock demand specified for all biomass types (mio. tDM per yr)
 ov63_2ndgen_biochar_dem_dedicated(t,i,kall,type) Regional biochar demand specified for different dedicated crops (mio. GJ per yr)
 ov63_2ndgen_biochar_dem_residues(t,i,kall,type)  Regional biochar demand specified for different residue types (mio. GJ per yr)
 oq63_biochar(t,i,kall,type)                      Global total biochar demand (mio. GJ per yr)
 oq63_biochar_glo(t,type)                         Global biochar demand from dedicated crops (mio. GJ per yr)
 oq63_biochar_reg(t,i,type)                       Regional biochar demand from dedicated crops (mio. GJ per yr)
 oq63_res_2ndgenBC(t,i,type)                      Regional biochar demand from residues (mio. GJ per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

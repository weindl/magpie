*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


parameters
 i63_biochar_prod(t,i,biopyr_all63)               Regional biochar production per biochar production systems (mio. GJ per yr)
 p63_region_BC_shr(t_all,i)                       Biochar demand share of the region derived from country selection (1)
 p63_country_dummy(iso)                           Dummy parameter indicating whether country is selected for biochar demand scenario (1)

 i63_max_app_rate_area(j,land)                    Maximum annual biochar application rate per area on cluster level (tDM per ha per yr)
 i63_max_biochar_stock_area(j,land)               Maximum cumulative biochar soil stock per area on cluster level (tDM per ha)
 p63_biochar_stock_decay_step(t_all)              Persistence factor of biochar soil stock over one model time step (1)
 pc63_biochar_stock_area(j,land)                  Cumulative biochar soil stock per area of the previous time step (tDM per ha)
 i63_yield_response_max(j)                        Maximum relative yield increase from biochar at saturation (1)
 i63_yield_response_k(j)                          Half-saturation biochar soil stock for yield response (tDM per ha)
;

positive variables
 v63_biochar_prod(i,bc_sys63,feedstock63)         Regional biochar production per biochar production system and feedstock (mio. GJ per yr)

 v63_biochar_app_rate_area(j,land)                Annual biochar application rate per area on cluster level (tDM per ha per yr)
;

variables
 v63_c_stable_biochar(i)                          Annual stable C in soil from biochar after 100 years derived from recalcitrant fraction (mio. tC per yr)
 v63_biochar_feedstock_mag(i,feedstock63)         Regional biomass feedstock demand for biochar per feedstock type (mio. GJ per yr)
 vm_biochar_feedstock_mag(i,feedstock63)          Additional feedstock demand for biochar per feedstock type (mio. GJ per yr)

 v63_biochar_stock_area(j,land)                   Cumulative biochar soil stock per area on cluster level for different land types (tDM per ha)
 v63_biochar_stock_effective(j)                   Effective cumulative biochar soil stock per area on cropland determining agronomic benefits (tDM per ha)
 vm_yld_response_biochar(j)                       Yield response multiplier from biochar soil stock (1)
;

equations
 q63_biochar_feedstock_conversion(i,feedstock63)  Conversion of biomass feedstock to biochar (mio. GJ per yr)
 q63_biochar_production(i,bc_sys63)               Regional biochar production per system (mio. GJ per yr)
 q63_feedstock_availability_residues(i)           Residue availability for biochar production (mio. GJ per yr)
 q63_biochar_simulation_mode(i,feedstock63)       Activation of biochar feedstock demand interface depending on simulation mode (mio. GJ per yr)
 q63_c_sequestration_biochar(i)                   Carbon removed annually from the atmosphere via stable biochar C (mio. tC per yr)

 q63_biochar_application_land(i)                  Regional application of produced biochar on land (tDM per yr)
 q63_biochar_app_rate_limit(j,land)               Annual limit for the biochar application rate on land on cluster level (tDM per ha per yr)
 q63_biochar_stock_limit(j,land)                  Cumulative limit for biochar soil stock per area on cluster level (tDM per ha)
 q63_biochar_stock_area(j,land)                   Biochar soil stock per area at cluster level (tDM per ha)
 q63_biochar_stock_effective(j)                   Effective biochar soil stock for agronomic benefits at cluster level (tDM per ha)
 q63_yld_response_biochar(j)                      Yield response determined from effective biochar stock (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,type)        Regional biochar production per biochar production system and feedstock (mio. GJ per yr)
 ov63_biochar_feedstock_mag(t,i,feedstock63,type)        Regional biomass feedstock demand for biochar per feedstock type (mio. GJ per yr)
 ov_biochar_feedstock_mag(t,i,feedstock63,type)          Additional feedstock demand for biochar per feedstock type (mio. GJ per yr)
 ov63_c_stable_biochar(t,i,type)                         Stable C in soil from biochar after 100 years derived from recalcitrant fraction (mio. tC per yr)
 oq63_biochar_feedstock_conversion(t,i,feedstock63,type) Conversion of biomass feedstock to biochar (mio. GJ per yr)
 oq63_biochar_production(t,i,bc_sys63,type)              Regional biochar production per system (mio. GJ per yr)
 oq63_feedstock_availability_residues(t,i,type)          Residue availability for biochar production (mio. GJ per yr)
 oq63_biochar_simulation_mode(t,i,feedstock63,type)      Activation of biochar feedstock demand interface depending on simulation mode (mio. GJ per yr)
 oq63_c_sequestration_biochar(t,i,type)                  Carbon removed from the atmosphere via stable biochar C (mio. tC per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

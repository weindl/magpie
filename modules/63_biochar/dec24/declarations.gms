*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s63_fixed_year                                  Flag characterizing the current year as part of the harmonization period (1)
;

parameters
 i63_biochar_prod(t,i,biopyr_all63)               Regional biochar production per biochar production systems (mio. GJ per yr)
 p63_country_dummy(iso)                           Dummy parameter indicating whether country is selected for biochar production scenario (1)
 p63_region_BC_shr(t_all,i)                       Regional biochar production share derived from country selection weighted by population size (1)
 p63_region_BC_avl_land_shr(i)                    Regional biochar production share derived from country selection weighted by available cropland area (1)
 p63_effective_land_share(i)                      Effective share of global target based on cropland area in 1995 and country selection (1)
 i63_bcScen_stylized_fader(t_all)                 Biochar stylized production fader (1)

 i63_max_app_rate_area(j,land)                    Maximum annual biochar application rate per area on cluster level (tDM per ha per yr)
 i63_max_biochar_stock_area(j,land)               Maximum cumulative biochar soil stock per area on cluster level (tDM per ha)
 p63_biochar_stock_decay_step(t_all)              Persistence factor of biochar soil stock over one model time step (1)
 pc63_biochar_stock_area(j,land)                  Cumulative biochar soil stock per area of the previous time step (tDM per ha)
 i63_yield_response_max(j)                        Maximum relative yield increase from biochar at saturation (1)
 i63_yield_response_k(j)                          Half-saturation biochar soil stock for yield response (tDM per ha)

 i63_price_biochar_gate(t_all,i,bc_sys63)         Biochar gate price (levelized unit cost excluding feedstock cost) (USD17MER per GJ)
 i63_cost_transport(i)                            Biochar transport and logistics cost (USD17MER per tDM)
 i63_cost_application(i,land)                     Biochar application cost for different land types (USD17MER per tDM)
;

positive variables
 v63_biochar_prod(i,bc_sys63,feedstock63)         Regional biochar production per biochar production system and feedstock (mio. GJ per yr)
 v63_biochar_notapplied(i)                        Regional biochar balance term for produced and not applied biochar (mio. GJ per yr)

 v63_biochar_app_rate_area(j,land)                Annual biochar application rate per area on cluster level (tDM per ha per yr)

 vm_cost_biochar(i)                               Biochar supply chain costs per region (mio. USD17MER per yr)
;

variables
 v63_biochar_prod_total(i)                        Total regional biochar production (mio. GJ per yr)
 v63_biochar_feedstock_mag(i,feedstock63)         Regional biomass feedstock demand for biochar per feedstock type (mio. GJ per yr)
 vm_biochar_feedstock_mag(i,feedstock63)          Additional feedstock demand for biochar per feedstock type (mio. GJ per yr)
 v63_c_stable_biochar(i)                          Annual stable C in soil from biochar after 100 years derived from recalcitrant fraction (mio. tC per yr)

 v63_biochar_stock_area(j,land)                   Cumulative biochar soil stock per area on cluster level for different land types (tDM per ha)
 v63_biochar_stock_effective(j)                   Effective cumulative biochar soil stock per area on cropland determining agronomic benefits (tDM per ha)
 vm_yld_response_biochar(j)                       Yield response multiplier from biochar soil stock (1)
;

equations
 q63_biochar_feedstock_conversion(i,feedstock63)  Conversion of biomass feedstock to biochar (mio. GJ per yr)
 q63_biochar_production(i,bc_sys63)               Regional biochar production per system (mio. GJ per yr)
 q63_biochar_production_total(i)                  Total regional biochar production across systems and feedstocks (mio. GJ per yr)
 q63_feedstock_availability_residues(i)           Residue availability for biochar production (mio. GJ per yr)
 q63_biochar_simulation_mode(i,feedstock63)       Activation of biochar feedstock demand interface depending on simulation mode (mio. GJ per yr)
 q63_c_sequestration_biochar(i)                   Carbon removed annually from the atmosphere via stable biochar C (mio. tC per yr)

 q63_biochar_application_land(i)                  Regional application of produced biochar on land (tDM per yr)
 q63_biochar_app_rate_limit(j,land)               Annual limit for the biochar application rate on land on cluster level (tDM per ha per yr)
 q63_biochar_stock_limit(j,land)                  Cumulative limit for biochar soil stock per area on cluster level (tDM per ha)
 q63_biochar_stock_area(j,land)                   Biochar soil stock per area at cluster level (tDM per ha)
 q63_biochar_stock_effective(j)                   Effective biochar soil stock for agronomic benefits at cluster level (tDM per ha)
 q63_yld_response_biochar(j)                      Yield response determined from effective biochar stock (1)

 q63_cost_biochar(i)                              Regional biochar cost accounting
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,type)        Regional biochar production per biochar production system and feedstock (mio. GJ per yr)
 ov63_biochar_notapplied(t,i,type)                       Regional biochar balance term for produced and not applied biochar (mio. GJ per yr)
 ov63_biochar_app_rate_area(t,j,land,type)               Annual biochar application rate per area on cluster level (tDM per ha per yr)
 ov_cost_biochar(t,i,type)                               Biochar supply chain costs per region (mio. USD17MER per yr)
 ov63_biochar_prod_total(t,i,type)                       Total regional biochar production (mio. GJ per yr)
 ov63_biochar_feedstock_mag(t,i,feedstock63,type)        Regional biomass feedstock demand for biochar per feedstock type (mio. GJ per yr)
 ov_biochar_feedstock_mag(t,i,feedstock63,type)          Additional feedstock demand for biochar per feedstock type (mio. GJ per yr)
 ov63_c_stable_biochar(t,i,type)                         Annual stable C in soil from biochar after 100 years derived from recalcitrant fraction (mio. tC per yr)
 ov63_biochar_stock_area(t,j,land,type)                  Cumulative biochar soil stock per area on cluster level for different land types (tDM per ha)
 ov63_biochar_stock_effective(t,j,type)                  Effective cumulative biochar soil stock per area on cropland determining agronomic benefits (tDM per ha)
 ov_yld_response_biochar(t,j,type)                       Yield response multiplier from biochar soil stock (1)
 oq63_biochar_feedstock_conversion(t,i,feedstock63,type) Conversion of biomass feedstock to biochar (mio. GJ per yr)
 oq63_biochar_production(t,i,bc_sys63,type)              Regional biochar production per system (mio. GJ per yr)
 oq63_biochar_production_total(t,i,type)                 Total regional biochar production across systems and feedstocks (mio. GJ per yr)
 oq63_feedstock_availability_residues(t,i,type)          Residue availability for biochar production (mio. GJ per yr)
 oq63_biochar_simulation_mode(t,i,feedstock63,type)      Activation of biochar feedstock demand interface depending on simulation mode (mio. GJ per yr)
 oq63_c_sequestration_biochar(t,i,type)                  Carbon removed annually from the atmosphere via stable biochar C (mio. tC per yr)
 oq63_biochar_application_land(t,i,type)                 Regional application of produced biochar on land (tDM per yr)
 oq63_biochar_app_rate_limit(t,j,land,type)              Annual limit for the biochar application rate on land on cluster level (tDM per ha per yr)
 oq63_biochar_stock_limit(t,j,land,type)                 Cumulative limit for biochar soil stock per area on cluster level (tDM per ha)
 oq63_biochar_stock_area(t,j,land,type)                  Biochar soil stock per area at cluster level (tDM per ha)
 oq63_biochar_stock_effective(t,j,type)                  Effective biochar soil stock for agronomic benefits at cluster level (tDM per ha)
 oq63_yld_response_biochar(t,j,type)                     Yield response determined from effective biochar stock (1)
 oq63_cost_biochar(t,i,type)                             Regional biochar cost accounting
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

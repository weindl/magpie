*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


parameters
 i63_biochar_prod(t,i,biopyr_all63)                   Regional biochar production per biochar production systems (mio. GJ per yr)
 p63_region_BC_shr(t_all,i)                       Biochar demand share of the region derived from country selection (1)
 p63_country_dummy(iso)                           Dummy parameter indicating whether country is selected for biochar demand scenario (1)
;

positive variables
 v63_biochar_prod(i,bc_sys63,feedstock63)         Regional biochar production per biochar production system and feedstock (mio. GJ per yr)
 v63_biochar_feedstock_mag(i,feedstock63)         Regional biomass feedstock demand for biochar per feedstock type (mio. GJ per yr)
 vm_biochar_feedstock_mag(i,feedstock63)          Additional feedstock demand for biochar per feedstock type (mio. GJ per yr)
;

equations
 q63_biochar_feedstock_conversion(i,feedstock63)  Conversion of biomass feedstock to biochar (mio. GJ per yr)
 q63_biochar_production(i,bc_sys63)               Regional biochar production per system (mio. GJ per yr)
 q63_feedstock_availability_residues(i)           Residue availability for biochar production (mio. GJ per yr)
 q63_biochar_simulation_mode(i,feedstock63)       Activation of biochar feedstock demand interface depending on simulation mode (mio. GJ per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,type)        Regional biochar production per biochar production system and feedstock (mio. GJ per yr)
 ov63_biochar_feedstock_mag(t,i,feedstock63,type)        Regional biomass feedstock demand for biochar per feedstock type (mio. GJ per yr)
 ov_biochar_feedstock_mag(t,i,feedstock63,type)          Additional feedstock demand for biochar per feedstock type (mio. GJ per yr)
 oq63_biochar_feedstock_conversion(t,i,feedstock63,type) Conversion of biomass feedstock to biochar (mio. GJ per yr)
 oq63_biochar_production(t,i,bc_sys63,type)              Regional biochar production per system (mio. GJ per yr)
 oq63_feedstock_availability_residues(t,i,type)          Residue availability for biochar production (mio. GJ per yr)
 oq63_biochar_simulation_mode(t,i,feedstock63,type)      Activation of biochar feedstock demand interface depending on simulation mode (mio. GJ per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

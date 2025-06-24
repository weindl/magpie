*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,"marginal")        = v63_biochar_prod.m(i,bc_sys63,feedstock63);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"marginal")        = v63_biochar_feedstock_mag.m(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"marginal")          = vm_biochar_feedstock_mag.m(i,feedstock63);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"marginal") = q63_biochar_feedstock_conversion.m(i,feedstock63);
 oq63_biochar_production(t,i,bc_sys63,"marginal")              = q63_biochar_production.m(i,bc_sys63);
 oq63_feedstock_availability_residues(t,i,"marginal")          = q63_feedstock_availability_residues.m(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"marginal")      = q63_biochar_simulation_mode.m(i,feedstock63);
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,"level")           = v63_biochar_prod.l(i,bc_sys63,feedstock63);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"level")           = v63_biochar_feedstock_mag.l(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"level")             = vm_biochar_feedstock_mag.l(i,feedstock63);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"level")    = q63_biochar_feedstock_conversion.l(i,feedstock63);
 oq63_biochar_production(t,i,bc_sys63,"level")                 = q63_biochar_production.l(i,bc_sys63);
 oq63_feedstock_availability_residues(t,i,"level")             = q63_feedstock_availability_residues.l(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"level")         = q63_biochar_simulation_mode.l(i,feedstock63);
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,"upper")           = v63_biochar_prod.up(i,bc_sys63,feedstock63);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"upper")           = v63_biochar_feedstock_mag.up(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"upper")             = vm_biochar_feedstock_mag.up(i,feedstock63);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"upper")    = q63_biochar_feedstock_conversion.up(i,feedstock63);
 oq63_biochar_production(t,i,bc_sys63,"upper")                 = q63_biochar_production.up(i,bc_sys63);
 oq63_feedstock_availability_residues(t,i,"upper")             = q63_feedstock_availability_residues.up(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"upper")         = q63_biochar_simulation_mode.up(i,feedstock63);
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,"lower")           = v63_biochar_prod.lo(i,bc_sys63,feedstock63);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"lower")           = v63_biochar_feedstock_mag.lo(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"lower")             = vm_biochar_feedstock_mag.lo(i,feedstock63);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"lower")    = q63_biochar_feedstock_conversion.lo(i,feedstock63);
 oq63_biochar_production(t,i,bc_sys63,"lower")                 = q63_biochar_production.lo(i,bc_sys63);
 oq63_feedstock_availability_residues(t,i,"lower")             = q63_feedstock_availability_residues.lo(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"lower")         = q63_biochar_simulation_mode.lo(i,feedstock63);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

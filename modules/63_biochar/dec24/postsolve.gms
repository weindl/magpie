*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Biochar soil stocks per area are transferred to the next timestep as
* boundary stocks. All biochar present at the end of the current timestep
* is assumed to decay over the elapsed period between timesteps. The
* resulting post-decay stock is used as the initial stock in the next
* timestep.
pc63_biochar_stock_area(j,land) = v63_biochar_stock_area.l(j,land) * p63_biochar_stock_decay_step(t);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,"marginal")        = v63_biochar_prod.m(i,bc_sys63,feedstock63);
 ov63_biochar_app_rate_area(t,j,land,"marginal")               = v63_biochar_app_rate_area.m(j,land);
 ov63_c_stable_biochar(t,i,"marginal")                         = v63_c_stable_biochar.m(i);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"marginal")        = v63_biochar_feedstock_mag.m(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"marginal")          = vm_biochar_feedstock_mag.m(i,feedstock63);
 ov63_biochar_stock_area(t,j,land,"marginal")                  = v63_biochar_stock_area.m(j,land);
 ov63_biochar_stock_effective(t,j,"marginal")                  = v63_biochar_stock_effective.m(j);
 ov_yld_response_biochar(t,j,"marginal")                       = vm_yld_response_biochar.m(j);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"marginal") = q63_biochar_feedstock_conversion.m(i,feedstock63);
 oq63_biochar_production(t,i,bc_sys63,"marginal")              = q63_biochar_production.m(i,bc_sys63);
 oq63_feedstock_availability_residues(t,i,"marginal")          = q63_feedstock_availability_residues.m(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"marginal")      = q63_biochar_simulation_mode.m(i,feedstock63);
 oq63_c_sequestration_biochar(t,i,"marginal")                  = q63_c_sequestration_biochar.m(i);
 oq63_biochar_application_land(t,i,"marginal")                 = q63_biochar_application_land.m(i);
 oq63_biochar_app_rate_limit(t,j,land,"marginal")              = q63_biochar_app_rate_limit.m(j,land);
 oq63_biochar_stock_limit(t,j,land,"marginal")                 = q63_biochar_stock_limit.m(j,land);
 oq63_biochar_stock_area(t,j,land,"marginal")                  = q63_biochar_stock_area.m(j,land);
 oq63_biochar_stock_effective(t,j,"marginal")                  = q63_biochar_stock_effective.m(j);
 oq63_yld_response_biochar(t,j,"marginal")                     = q63_yld_response_biochar.m(j);
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,"level")           = v63_biochar_prod.l(i,bc_sys63,feedstock63);
 ov63_biochar_app_rate_area(t,j,land,"level")                  = v63_biochar_app_rate_area.l(j,land);
 ov63_c_stable_biochar(t,i,"level")                            = v63_c_stable_biochar.l(i);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"level")           = v63_biochar_feedstock_mag.l(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"level")             = vm_biochar_feedstock_mag.l(i,feedstock63);
 ov63_biochar_stock_area(t,j,land,"level")                     = v63_biochar_stock_area.l(j,land);
 ov63_biochar_stock_effective(t,j,"level")                     = v63_biochar_stock_effective.l(j);
 ov_yld_response_biochar(t,j,"level")                          = vm_yld_response_biochar.l(j);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"level")    = q63_biochar_feedstock_conversion.l(i,feedstock63);
 oq63_biochar_production(t,i,bc_sys63,"level")                 = q63_biochar_production.l(i,bc_sys63);
 oq63_feedstock_availability_residues(t,i,"level")             = q63_feedstock_availability_residues.l(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"level")         = q63_biochar_simulation_mode.l(i,feedstock63);
 oq63_c_sequestration_biochar(t,i,"level")                     = q63_c_sequestration_biochar.l(i);
 oq63_biochar_application_land(t,i,"level")                    = q63_biochar_application_land.l(i);
 oq63_biochar_app_rate_limit(t,j,land,"level")                 = q63_biochar_app_rate_limit.l(j,land);
 oq63_biochar_stock_limit(t,j,land,"level")                    = q63_biochar_stock_limit.l(j,land);
 oq63_biochar_stock_area(t,j,land,"level")                     = q63_biochar_stock_area.l(j,land);
 oq63_biochar_stock_effective(t,j,"level")                     = q63_biochar_stock_effective.l(j);
 oq63_yld_response_biochar(t,j,"level")                        = q63_yld_response_biochar.l(j);
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,"upper")           = v63_biochar_prod.up(i,bc_sys63,feedstock63);
 ov63_biochar_app_rate_area(t,j,land,"upper")                  = v63_biochar_app_rate_area.up(j,land);
 ov63_c_stable_biochar(t,i,"upper")                            = v63_c_stable_biochar.up(i);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"upper")           = v63_biochar_feedstock_mag.up(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"upper")             = vm_biochar_feedstock_mag.up(i,feedstock63);
 ov63_biochar_stock_area(t,j,land,"upper")                     = v63_biochar_stock_area.up(j,land);
 ov63_biochar_stock_effective(t,j,"upper")                     = v63_biochar_stock_effective.up(j);
 ov_yld_response_biochar(t,j,"upper")                          = vm_yld_response_biochar.up(j);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"upper")    = q63_biochar_feedstock_conversion.up(i,feedstock63);
 oq63_biochar_production(t,i,bc_sys63,"upper")                 = q63_biochar_production.up(i,bc_sys63);
 oq63_feedstock_availability_residues(t,i,"upper")             = q63_feedstock_availability_residues.up(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"upper")         = q63_biochar_simulation_mode.up(i,feedstock63);
 oq63_c_sequestration_biochar(t,i,"upper")                     = q63_c_sequestration_biochar.up(i);
 oq63_biochar_application_land(t,i,"upper")                    = q63_biochar_application_land.up(i);
 oq63_biochar_app_rate_limit(t,j,land,"upper")                 = q63_biochar_app_rate_limit.up(j,land);
 oq63_biochar_stock_limit(t,j,land,"upper")                    = q63_biochar_stock_limit.up(j,land);
 oq63_biochar_stock_area(t,j,land,"upper")                     = q63_biochar_stock_area.up(j,land);
 oq63_biochar_stock_effective(t,j,"upper")                     = q63_biochar_stock_effective.up(j);
 oq63_yld_response_biochar(t,j,"upper")                        = q63_yld_response_biochar.up(j);
 ov63_biochar_prod(t,i,bc_sys63,feedstock63,"lower")           = v63_biochar_prod.lo(i,bc_sys63,feedstock63);
 ov63_biochar_app_rate_area(t,j,land,"lower")                  = v63_biochar_app_rate_area.lo(j,land);
 ov63_c_stable_biochar(t,i,"lower")                            = v63_c_stable_biochar.lo(i);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"lower")           = v63_biochar_feedstock_mag.lo(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"lower")             = vm_biochar_feedstock_mag.lo(i,feedstock63);
 ov63_biochar_stock_area(t,j,land,"lower")                     = v63_biochar_stock_area.lo(j,land);
 ov63_biochar_stock_effective(t,j,"lower")                     = v63_biochar_stock_effective.lo(j);
 ov_yld_response_biochar(t,j,"lower")                          = vm_yld_response_biochar.lo(j);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"lower")    = q63_biochar_feedstock_conversion.lo(i,feedstock63);
 oq63_biochar_production(t,i,bc_sys63,"lower")                 = q63_biochar_production.lo(i,bc_sys63);
 oq63_feedstock_availability_residues(t,i,"lower")             = q63_feedstock_availability_residues.lo(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"lower")         = q63_biochar_simulation_mode.lo(i,feedstock63);
 oq63_c_sequestration_biochar(t,i,"lower")                     = q63_c_sequestration_biochar.lo(i);
 oq63_biochar_application_land(t,i,"lower")                    = q63_biochar_application_land.lo(i);
 oq63_biochar_app_rate_limit(t,j,land,"lower")                 = q63_biochar_app_rate_limit.lo(j,land);
 oq63_biochar_stock_limit(t,j,land,"lower")                    = q63_biochar_stock_limit.lo(j,land);
 oq63_biochar_stock_area(t,j,land,"lower")                     = q63_biochar_stock_area.lo(j,land);
 oq63_biochar_stock_effective(t,j,"lower")                     = q63_biochar_stock_effective.lo(j);
 oq63_yld_response_biochar(t,j,"lower")                        = q63_yld_response_biochar.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

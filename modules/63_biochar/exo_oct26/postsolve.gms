*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
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
pc63_biochar_stock_area(j,bcland63) = v63_biochar_stock_area.l(j,bcland63) * p63_biochar_stock_decay_step(t);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov63_biochar_prod(t,i,bc_tech63,feedstock63,"marginal")                       = v63_biochar_prod.m(i,bc_tech63,feedstock63);
 ov63_biochar_applied_sys_fs(t,i,bc_tech63,feedstock63,"marginal")             = v63_biochar_applied_sys_fs.m(i,bc_tech63,feedstock63);
 ov63_biochar_notapplied_sys_fs(t,i,bc_tech63,feedstock63,"marginal")          = v63_biochar_notapplied_sys_fs.m(i,bc_tech63,feedstock63);
 ov63_biochar_app_rate_area(t,j,bcland63,"marginal")                              = v63_biochar_app_rate_area.m(j,bcland63);
 ov_cost_biochar(t,i,"marginal")                                              = vm_cost_biochar.m(i);
 ov63_biochar_prod_total(t,i,att_bc,"marginal")                               = v63_biochar_prod_total.m(i,att_bc);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"marginal")                       = v63_biochar_feedstock_mag.m(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"marginal")                         = vm_biochar_feedstock_mag.m(i,feedstock63);
 ov63_biochar_applied(t,i,bcland63,"marginal")                                    = v63_biochar_applied.m(i,bcland63);
 ov63_c_stable_biochar(t,i,"marginal")                                        = v63_c_stable_biochar.m(i);
 ov63_c_stable_biochar_fs(t,i,feedstock63,"marginal")                         = v63_c_stable_biochar_fs.m(i,feedstock63);
 ov_cdr_bc_fs(t,i,feedstock63,"marginal")                                     = vm_cdr_bc_fs.m(i,feedstock63);
 ov63_biochar_stock_area(t,j,bcland63,"marginal")                                 = v63_biochar_stock_area.m(j,bcland63);
 ov_yld_response_biochar(t,j,"marginal")                                      = vm_yld_response_biochar.m(j);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"marginal")                = q63_biochar_feedstock_conversion.m(i,feedstock63);
 oq63_biochar_production(t,i,bc_tech63,"marginal")                             = q63_biochar_production.m(i,bc_tech63);
 oq63_biochar_production_total(t,i,att_bc,"marginal")                         = q63_biochar_production_total.m(i,att_bc);
 oq63_feedstock_availability_residues(t,i,"marginal")                         = q63_feedstock_availability_residues.m(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"marginal")                     = q63_biochar_simulation_mode.m(i,feedstock63);
 oq63_c_sequestration_biochar_fs(t,i,feedstock63,"marginal")                  = q63_c_sequestration_biochar_fs.m(i,feedstock63);
 oq63_c_sequestration_biochar_total(t,i,"marginal")                           = q63_c_sequestration_biochar_total.m(i);
 oq63_cdr_biochar_fs(t,i,feedstock63,"marginal")                              = q63_cdr_biochar_fs.m(i,feedstock63);
 oq63_biochar_application_land(t,i,bcland63,"marginal")                           = q63_biochar_application_land.m(i,bcland63);
 oq63_biochar_application_total(t,i,"marginal")                               = q63_biochar_application_total.m(i);
 oq63_biochar_application_balance_sys_fs(t,i,bc_tech63,feedstock63,"marginal") = q63_biochar_application_balance_sys_fs.m(i,bc_tech63,feedstock63);
 oq63_biochar_app_rate_limit(t,j,bcland63,"marginal")                             = q63_biochar_app_rate_limit.m(j,bcland63);
 oq63_biochar_stock_limit(t,j,bcland63,"marginal")                                = q63_biochar_stock_limit.m(j,bcland63);
 oq63_biochar_stock_area(t,j,bcland63,"marginal")                                 = q63_biochar_stock_area.m(j,bcland63);
 oq63_yld_response_biochar(t,j,"marginal")                                    = q63_yld_response_biochar.m(j);
 oq63_cost_biochar(t,i,"marginal")                                            = q63_cost_biochar.m(i);
 ov63_biochar_prod(t,i,bc_tech63,feedstock63,"level")                          = v63_biochar_prod.l(i,bc_tech63,feedstock63);
 ov63_biochar_applied_sys_fs(t,i,bc_tech63,feedstock63,"level")                = v63_biochar_applied_sys_fs.l(i,bc_tech63,feedstock63);
 ov63_biochar_notapplied_sys_fs(t,i,bc_tech63,feedstock63,"level")             = v63_biochar_notapplied_sys_fs.l(i,bc_tech63,feedstock63);
 ov63_biochar_app_rate_area(t,j,bcland63,"level")                                 = v63_biochar_app_rate_area.l(j,bcland63);
 ov_cost_biochar(t,i,"level")                                                 = vm_cost_biochar.l(i);
 ov63_biochar_prod_total(t,i,att_bc,"level")                                  = v63_biochar_prod_total.l(i,att_bc);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"level")                          = v63_biochar_feedstock_mag.l(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"level")                            = vm_biochar_feedstock_mag.l(i,feedstock63);
 ov63_biochar_applied(t,i,bcland63,"level")                                       = v63_biochar_applied.l(i,bcland63);
 ov63_c_stable_biochar(t,i,"level")                                           = v63_c_stable_biochar.l(i);
 ov63_c_stable_biochar_fs(t,i,feedstock63,"level")                            = v63_c_stable_biochar_fs.l(i,feedstock63);
 ov_cdr_bc_fs(t,i,feedstock63,"level")                                        = vm_cdr_bc_fs.l(i,feedstock63);
 ov63_biochar_stock_area(t,j,bcland63,"level")                                    = v63_biochar_stock_area.l(j,bcland63);
 ov_yld_response_biochar(t,j,"level")                                         = vm_yld_response_biochar.l(j);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"level")                   = q63_biochar_feedstock_conversion.l(i,feedstock63);
 oq63_biochar_production(t,i,bc_tech63,"level")                                = q63_biochar_production.l(i,bc_tech63);
 oq63_biochar_production_total(t,i,att_bc,"level")                            = q63_biochar_production_total.l(i,att_bc);
 oq63_feedstock_availability_residues(t,i,"level")                            = q63_feedstock_availability_residues.l(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"level")                        = q63_biochar_simulation_mode.l(i,feedstock63);
 oq63_c_sequestration_biochar_fs(t,i,feedstock63,"level")                     = q63_c_sequestration_biochar_fs.l(i,feedstock63);
 oq63_c_sequestration_biochar_total(t,i,"level")                              = q63_c_sequestration_biochar_total.l(i);
 oq63_cdr_biochar_fs(t,i,feedstock63,"level")                                 = q63_cdr_biochar_fs.l(i,feedstock63);
 oq63_biochar_application_land(t,i,bcland63,"level")                              = q63_biochar_application_land.l(i,bcland63);
 oq63_biochar_application_total(t,i,"level")                                  = q63_biochar_application_total.l(i);
 oq63_biochar_application_balance_sys_fs(t,i,bc_tech63,feedstock63,"level")    = q63_biochar_application_balance_sys_fs.l(i,bc_tech63,feedstock63);
 oq63_biochar_app_rate_limit(t,j,bcland63,"level")                                = q63_biochar_app_rate_limit.l(j,bcland63);
 oq63_biochar_stock_limit(t,j,bcland63,"level")                                   = q63_biochar_stock_limit.l(j,bcland63);
 oq63_biochar_stock_area(t,j,bcland63,"level")                                    = q63_biochar_stock_area.l(j,bcland63);
 oq63_yld_response_biochar(t,j,"level")                                       = q63_yld_response_biochar.l(j);
 oq63_cost_biochar(t,i,"level")                                               = q63_cost_biochar.l(i);
 ov63_biochar_prod(t,i,bc_tech63,feedstock63,"upper")                          = v63_biochar_prod.up(i,bc_tech63,feedstock63);
 ov63_biochar_applied_sys_fs(t,i,bc_tech63,feedstock63,"upper")                = v63_biochar_applied_sys_fs.up(i,bc_tech63,feedstock63);
 ov63_biochar_notapplied_sys_fs(t,i,bc_tech63,feedstock63,"upper")             = v63_biochar_notapplied_sys_fs.up(i,bc_tech63,feedstock63);
 ov63_biochar_app_rate_area(t,j,bcland63,"upper")                                 = v63_biochar_app_rate_area.up(j,bcland63);
 ov_cost_biochar(t,i,"upper")                                                 = vm_cost_biochar.up(i);
 ov63_biochar_prod_total(t,i,att_bc,"upper")                                  = v63_biochar_prod_total.up(i,att_bc);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"upper")                          = v63_biochar_feedstock_mag.up(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"upper")                            = vm_biochar_feedstock_mag.up(i,feedstock63);
 ov63_biochar_applied(t,i,bcland63,"upper")                                       = v63_biochar_applied.up(i,bcland63);
 ov63_c_stable_biochar(t,i,"upper")                                           = v63_c_stable_biochar.up(i);
 ov63_c_stable_biochar_fs(t,i,feedstock63,"upper")                            = v63_c_stable_biochar_fs.up(i,feedstock63);
 ov_cdr_bc_fs(t,i,feedstock63,"upper")                                        = vm_cdr_bc_fs.up(i,feedstock63);
 ov63_biochar_stock_area(t,j,bcland63,"upper")                                    = v63_biochar_stock_area.up(j,bcland63);
 ov_yld_response_biochar(t,j,"upper")                                         = vm_yld_response_biochar.up(j);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"upper")                   = q63_biochar_feedstock_conversion.up(i,feedstock63);
 oq63_biochar_production(t,i,bc_tech63,"upper")                                = q63_biochar_production.up(i,bc_tech63);
 oq63_biochar_production_total(t,i,att_bc,"upper")                            = q63_biochar_production_total.up(i,att_bc);
 oq63_feedstock_availability_residues(t,i,"upper")                            = q63_feedstock_availability_residues.up(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"upper")                        = q63_biochar_simulation_mode.up(i,feedstock63);
 oq63_c_sequestration_biochar_fs(t,i,feedstock63,"upper")                     = q63_c_sequestration_biochar_fs.up(i,feedstock63);
 oq63_c_sequestration_biochar_total(t,i,"upper")                              = q63_c_sequestration_biochar_total.up(i);
 oq63_cdr_biochar_fs(t,i,feedstock63,"upper")                                 = q63_cdr_biochar_fs.up(i,feedstock63);
 oq63_biochar_application_land(t,i,bcland63,"upper")                              = q63_biochar_application_land.up(i,bcland63);
 oq63_biochar_application_total(t,i,"upper")                                  = q63_biochar_application_total.up(i);
 oq63_biochar_application_balance_sys_fs(t,i,bc_tech63,feedstock63,"upper")    = q63_biochar_application_balance_sys_fs.up(i,bc_tech63,feedstock63);
 oq63_biochar_app_rate_limit(t,j,bcland63,"upper")                                = q63_biochar_app_rate_limit.up(j,bcland63);
 oq63_biochar_stock_limit(t,j,bcland63,"upper")                                   = q63_biochar_stock_limit.up(j,bcland63);
 oq63_biochar_stock_area(t,j,bcland63,"upper")                                    = q63_biochar_stock_area.up(j,bcland63);
 oq63_yld_response_biochar(t,j,"upper")                                       = q63_yld_response_biochar.up(j);
 oq63_cost_biochar(t,i,"upper")                                               = q63_cost_biochar.up(i);
 ov63_biochar_prod(t,i,bc_tech63,feedstock63,"lower")                          = v63_biochar_prod.lo(i,bc_tech63,feedstock63);
 ov63_biochar_applied_sys_fs(t,i,bc_tech63,feedstock63,"lower")                = v63_biochar_applied_sys_fs.lo(i,bc_tech63,feedstock63);
 ov63_biochar_notapplied_sys_fs(t,i,bc_tech63,feedstock63,"lower")             = v63_biochar_notapplied_sys_fs.lo(i,bc_tech63,feedstock63);
 ov63_biochar_app_rate_area(t,j,bcland63,"lower")                                 = v63_biochar_app_rate_area.lo(j,bcland63);
 ov_cost_biochar(t,i,"lower")                                                 = vm_cost_biochar.lo(i);
 ov63_biochar_prod_total(t,i,att_bc,"lower")                                  = v63_biochar_prod_total.lo(i,att_bc);
 ov63_biochar_feedstock_mag(t,i,feedstock63,"lower")                          = v63_biochar_feedstock_mag.lo(i,feedstock63);
 ov_biochar_feedstock_mag(t,i,feedstock63,"lower")                            = vm_biochar_feedstock_mag.lo(i,feedstock63);
 ov63_biochar_applied(t,i,bcland63,"lower")                                       = v63_biochar_applied.lo(i,bcland63);
 ov63_c_stable_biochar(t,i,"lower")                                           = v63_c_stable_biochar.lo(i);
 ov63_c_stable_biochar_fs(t,i,feedstock63,"lower")                            = v63_c_stable_biochar_fs.lo(i,feedstock63);
 ov_cdr_bc_fs(t,i,feedstock63,"lower")                                        = vm_cdr_bc_fs.lo(i,feedstock63);
 ov63_biochar_stock_area(t,j,bcland63,"lower")                                    = v63_biochar_stock_area.lo(j,bcland63);
 ov_yld_response_biochar(t,j,"lower")                                         = vm_yld_response_biochar.lo(j);
 oq63_biochar_feedstock_conversion(t,i,feedstock63,"lower")                   = q63_biochar_feedstock_conversion.lo(i,feedstock63);
 oq63_biochar_production(t,i,bc_tech63,"lower")                                = q63_biochar_production.lo(i,bc_tech63);
 oq63_biochar_production_total(t,i,att_bc,"lower")                            = q63_biochar_production_total.lo(i,att_bc);
 oq63_feedstock_availability_residues(t,i,"lower")                            = q63_feedstock_availability_residues.lo(i);
 oq63_biochar_simulation_mode(t,i,feedstock63,"lower")                        = q63_biochar_simulation_mode.lo(i,feedstock63);
 oq63_c_sequestration_biochar_fs(t,i,feedstock63,"lower")                     = q63_c_sequestration_biochar_fs.lo(i,feedstock63);
 oq63_c_sequestration_biochar_total(t,i,"lower")                              = q63_c_sequestration_biochar_total.lo(i);
 oq63_cdr_biochar_fs(t,i,feedstock63,"lower")                                 = q63_cdr_biochar_fs.lo(i,feedstock63);
 oq63_biochar_application_land(t,i,bcland63,"lower")                              = q63_biochar_application_land.lo(i,bcland63);
 oq63_biochar_application_total(t,i,"lower")                                  = q63_biochar_application_total.lo(i);
 oq63_biochar_application_balance_sys_fs(t,i,bc_tech63,feedstock63,"lower")    = q63_biochar_application_balance_sys_fs.lo(i,bc_tech63,feedstock63);
 oq63_biochar_app_rate_limit(t,j,bcland63,"lower")                                = q63_biochar_app_rate_limit.lo(j,bcland63);
 oq63_biochar_stock_limit(t,j,bcland63,"lower")                                   = q63_biochar_stock_limit.lo(j,bcland63);
 oq63_biochar_stock_area(t,j,bcland63,"lower")                                    = q63_biochar_stock_area.lo(j,bcland63);
 oq63_yld_response_biochar(t,j,"lower")                                       = q63_yld_response_biochar.lo(j);
 oq63_cost_biochar(t,i,"lower")                                               = q63_cost_biochar.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

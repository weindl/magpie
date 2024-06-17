*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_biochar(t,i,kall,"marginal")                    = vm_dem_biochar.m(i,kall);
 ov63_2ndgen_biochar_dem_dedicated(t,i,kall,"marginal") = v63_2ndgen_biochar_dem_dedicated.m(i,kall);
 ov63_2ndgen_biochar_dem_residues(t,i,kall,"marginal")  = v63_2ndgen_biochar_dem_residues.m(i,kall);
 oq63_biochar(t,i,kall,"marginal")                      = q63_biochar.m(i,kall);
 oq63_biochar_glo(t,"marginal")                         = q63_biochar_glo.m;
 oq63_biochar_reg(t,i,"marginal")                       = q63_biochar_reg.m(i);
 oq63_res_2ndgenBC(t,i,"marginal")                      = q63_res_2ndgenBC.m(i);
 ov_dem_biochar(t,i,kall,"level")                       = vm_dem_biochar.l(i,kall);
 ov63_2ndgen_biochar_dem_dedicated(t,i,kall,"level")    = v63_2ndgen_biochar_dem_dedicated.l(i,kall);
 ov63_2ndgen_biochar_dem_residues(t,i,kall,"level")     = v63_2ndgen_biochar_dem_residues.l(i,kall);
 oq63_biochar(t,i,kall,"level")                         = q63_biochar.l(i,kall);
 oq63_biochar_glo(t,"level")                            = q63_biochar_glo.l;
 oq63_biochar_reg(t,i,"level")                          = q63_biochar_reg.l(i);
 oq63_res_2ndgenBC(t,i,"level")                         = q63_res_2ndgenBC.l(i);
 ov_dem_biochar(t,i,kall,"upper")                       = vm_dem_biochar.up(i,kall);
 ov63_2ndgen_biochar_dem_dedicated(t,i,kall,"upper")    = v63_2ndgen_biochar_dem_dedicated.up(i,kall);
 ov63_2ndgen_biochar_dem_residues(t,i,kall,"upper")     = v63_2ndgen_biochar_dem_residues.up(i,kall);
 oq63_biochar(t,i,kall,"upper")                         = q63_biochar.up(i,kall);
 oq63_biochar_glo(t,"upper")                            = q63_biochar_glo.up;
 oq63_biochar_reg(t,i,"upper")                          = q63_biochar_reg.up(i);
 oq63_res_2ndgenBC(t,i,"upper")                         = q63_res_2ndgenBC.up(i);
 ov_dem_biochar(t,i,kall,"lower")                       = vm_dem_biochar.lo(i,kall);
 ov63_2ndgen_biochar_dem_dedicated(t,i,kall,"lower")    = v63_2ndgen_biochar_dem_dedicated.lo(i,kall);
 ov63_2ndgen_biochar_dem_residues(t,i,kall,"lower")     = v63_2ndgen_biochar_dem_residues.lo(i,kall);
 oq63_biochar(t,i,kall,"lower")                         = q63_biochar.lo(i,kall);
 oq63_biochar_glo(t,"lower")                            = q63_biochar_glo.lo;
 oq63_biochar_reg(t,i,"lower")                          = q63_biochar_reg.lo(i);
 oq63_res_2ndgenBC(t,i,"lower")                         = q63_res_2ndgenBC.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

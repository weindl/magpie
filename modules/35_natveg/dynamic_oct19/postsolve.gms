*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*secdforest age class calculation
p35_secdforest(t,j,ac) = vm_natveg_secdforest.l(j,ac);

*other land age class calculation
p35_other(t,j,ac) = vm_natveg_other.l(j,ac);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_natveg_secdforest(t,j,ac,"marginal")         = vm_natveg_secdforest.m(j,ac);
 ov_natveg_other(t,j,ac,"marginal")              = vm_natveg_other.m(j,ac);
 ov_landdiff_natveg(t,"marginal")                = vm_landdiff_natveg.m;
 ov35_other_expansion(t,j,ac,"marginal")         = v35_other_expansion.m(j,ac);
 ov35_other_reduction(t,j,ac,"marginal")         = v35_other_reduction.m(j,ac);
 ov35_secdforest_reduction(t,j,ac,"marginal")    = v35_secdforest_reduction.m(j,ac);
 ov35_primforest_reduction(t,j,"marginal")       = v35_primforest_reduction.m(j);
 oq35_land_secdforest(t,j,"marginal")            = q35_land_secdforest.m(j);
 oq35_land_other(t,j,"marginal")                 = q35_land_other.m(j);
 oq35_carbon_primforest(t,j,ag_pools,"marginal") = q35_carbon_primforest.m(j,ag_pools);
 oq35_carbon_secdforest(t,j,ag_pools,"marginal") = q35_carbon_secdforest.m(j,ag_pools);
 oq35_carbon_other(t,j,ag_pools,"marginal")      = q35_carbon_other.m(j,ag_pools);
 oq35_landdiff(t,"marginal")                     = q35_landdiff.m;
 oq35_other_expansion(t,j,ac,"marginal")         = q35_other_expansion.m(j,ac);
 oq35_other_reduction(t,j,ac,"marginal")         = q35_other_reduction.m(j,ac);
 oq35_secdforest_reduction(t,j,ac,"marginal")    = q35_secdforest_reduction.m(j,ac);
 oq35_primforest_reduction(t,j,"marginal")       = q35_primforest_reduction.m(j);
 oq35_min_forest(t,j,"marginal")                 = q35_min_forest.m(j);
 oq35_min_other(t,j,"marginal")                  = q35_min_other.m(j);
 ov_natveg_secdforest(t,j,ac,"level")            = vm_natveg_secdforest.l(j,ac);
 ov_natveg_other(t,j,ac,"level")                 = vm_natveg_other.l(j,ac);
 ov_landdiff_natveg(t,"level")                   = vm_landdiff_natveg.l;
 ov35_other_expansion(t,j,ac,"level")            = v35_other_expansion.l(j,ac);
 ov35_other_reduction(t,j,ac,"level")            = v35_other_reduction.l(j,ac);
 ov35_secdforest_reduction(t,j,ac,"level")       = v35_secdforest_reduction.l(j,ac);
 ov35_primforest_reduction(t,j,"level")          = v35_primforest_reduction.l(j);
 oq35_land_secdforest(t,j,"level")               = q35_land_secdforest.l(j);
 oq35_land_other(t,j,"level")                    = q35_land_other.l(j);
 oq35_carbon_primforest(t,j,ag_pools,"level")    = q35_carbon_primforest.l(j,ag_pools);
 oq35_carbon_secdforest(t,j,ag_pools,"level")    = q35_carbon_secdforest.l(j,ag_pools);
 oq35_carbon_other(t,j,ag_pools,"level")         = q35_carbon_other.l(j,ag_pools);
 oq35_landdiff(t,"level")                        = q35_landdiff.l;
 oq35_other_expansion(t,j,ac,"level")            = q35_other_expansion.l(j,ac);
 oq35_other_reduction(t,j,ac,"level")            = q35_other_reduction.l(j,ac);
 oq35_secdforest_reduction(t,j,ac,"level")       = q35_secdforest_reduction.l(j,ac);
 oq35_primforest_reduction(t,j,"level")          = q35_primforest_reduction.l(j);
 oq35_min_forest(t,j,"level")                    = q35_min_forest.l(j);
 oq35_min_other(t,j,"level")                     = q35_min_other.l(j);
 ov_natveg_secdforest(t,j,ac,"upper")            = vm_natveg_secdforest.up(j,ac);
 ov_natveg_other(t,j,ac,"upper")                 = vm_natveg_other.up(j,ac);
 ov_landdiff_natveg(t,"upper")                   = vm_landdiff_natveg.up;
 ov35_other_expansion(t,j,ac,"upper")            = v35_other_expansion.up(j,ac);
 ov35_other_reduction(t,j,ac,"upper")            = v35_other_reduction.up(j,ac);
 ov35_secdforest_reduction(t,j,ac,"upper")       = v35_secdforest_reduction.up(j,ac);
 ov35_primforest_reduction(t,j,"upper")          = v35_primforest_reduction.up(j);
 oq35_land_secdforest(t,j,"upper")               = q35_land_secdforest.up(j);
 oq35_land_other(t,j,"upper")                    = q35_land_other.up(j);
 oq35_carbon_primforest(t,j,ag_pools,"upper")    = q35_carbon_primforest.up(j,ag_pools);
 oq35_carbon_secdforest(t,j,ag_pools,"upper")    = q35_carbon_secdforest.up(j,ag_pools);
 oq35_carbon_other(t,j,ag_pools,"upper")         = q35_carbon_other.up(j,ag_pools);
 oq35_landdiff(t,"upper")                        = q35_landdiff.up;
 oq35_other_expansion(t,j,ac,"upper")            = q35_other_expansion.up(j,ac);
 oq35_other_reduction(t,j,ac,"upper")            = q35_other_reduction.up(j,ac);
 oq35_secdforest_reduction(t,j,ac,"upper")       = q35_secdforest_reduction.up(j,ac);
 oq35_primforest_reduction(t,j,"upper")          = q35_primforest_reduction.up(j);
 oq35_min_forest(t,j,"upper")                    = q35_min_forest.up(j);
 oq35_min_other(t,j,"upper")                     = q35_min_other.up(j);
 ov_natveg_secdforest(t,j,ac,"lower")            = vm_natveg_secdforest.lo(j,ac);
 ov_natveg_other(t,j,ac,"lower")                 = vm_natveg_other.lo(j,ac);
 ov_landdiff_natveg(t,"lower")                   = vm_landdiff_natveg.lo;
 ov35_other_expansion(t,j,ac,"lower")            = v35_other_expansion.lo(j,ac);
 ov35_other_reduction(t,j,ac,"lower")            = v35_other_reduction.lo(j,ac);
 ov35_secdforest_reduction(t,j,ac,"lower")       = v35_secdforest_reduction.lo(j,ac);
 ov35_primforest_reduction(t,j,"lower")          = v35_primforest_reduction.lo(j);
 oq35_land_secdforest(t,j,"lower")               = q35_land_secdforest.lo(j);
 oq35_land_other(t,j,"lower")                    = q35_land_other.lo(j);
 oq35_carbon_primforest(t,j,ag_pools,"lower")    = q35_carbon_primforest.lo(j,ag_pools);
 oq35_carbon_secdforest(t,j,ag_pools,"lower")    = q35_carbon_secdforest.lo(j,ag_pools);
 oq35_carbon_other(t,j,ag_pools,"lower")         = q35_carbon_other.lo(j,ag_pools);
 oq35_landdiff(t,"lower")                        = q35_landdiff.lo;
 oq35_other_expansion(t,j,ac,"lower")            = q35_other_expansion.lo(j,ac);
 oq35_other_reduction(t,j,ac,"lower")            = q35_other_reduction.lo(j,ac);
 oq35_secdforest_reduction(t,j,ac,"lower")       = q35_secdforest_reduction.lo(j,ac);
 oq35_primforest_reduction(t,j,"lower")          = q35_primforest_reduction.lo(j);
 oq35_min_forest(t,j,"lower")                    = q35_min_forest.lo(j);
 oq35_min_other(t,j,"lower")                     = q35_min_other.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

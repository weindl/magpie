*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_natveg_secdforest(t,j,ac,"marginal") = vm_natveg_secdforest.m(j,ac);
 ov_natveg_other(t,j,ac,"marginal")      = vm_natveg_other.m(j,ac);
 ov_landdiff_natveg(t,"marginal")        = vm_landdiff_natveg.m;
 ov_natveg_secdforest(t,j,ac,"level")    = vm_natveg_secdforest.l(j,ac);
 ov_natveg_other(t,j,ac,"level")         = vm_natveg_other.l(j,ac);
 ov_landdiff_natveg(t,"level")           = vm_landdiff_natveg.l;
 ov_natveg_secdforest(t,j,ac,"upper")    = vm_natveg_secdforest.up(j,ac);
 ov_natveg_other(t,j,ac,"upper")         = vm_natveg_other.up(j,ac);
 ov_landdiff_natveg(t,"upper")           = vm_landdiff_natveg.up;
 ov_natveg_secdforest(t,j,ac,"lower")    = vm_natveg_secdforest.lo(j,ac);
 ov_natveg_other(t,j,ac,"lower")         = vm_natveg_other.lo(j,ac);
 ov_landdiff_natveg(t,"lower")           = vm_landdiff_natveg.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################


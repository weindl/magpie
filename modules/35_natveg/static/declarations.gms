*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
  vm_natveg_secdforest(j,ac) 		Detailed stock of secdforest (mio. ha)
  vm_natveg_other(j,ac)      		Detailed stock of other land (mio. ha)
  vm_landdiff_natveg        Aggregated difference in other land compared to previous timestep (mio. ha)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_natveg_secdforest(t,j,ac,type) Detailed stock of secdforest (mio. ha)
 ov_natveg_other(t,j,ac,type)      Detailed stock of other land (mio. ha)
 ov_landdiff_natveg(t,type)        Aggregated difference in other land compared to previous timestep (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################


*** |  (C) 2008-2026 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_cost_biochar(i)                               Biochar supply chain costs per region (mio. USD17MER per yr)
;

variables
 vm_biochar_feedstock_mag(i,feedstock63)          Additional feedstock demand for biochar per feedstock type (mio. GJ per yr)
 vm_yld_response_biochar(j)                       Yield response multiplier from biochar soil stock (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_biochar(t,i,type)                      Biochar supply chain costs per region (mio. USD17MER per yr)
 ov_biochar_feedstock_mag(t,i,feedstock63,type) Additional feedstock demand for biochar per feedstock type (mio. GJ per yr)
 ov_yld_response_biochar(t,j,type)              Yield response multiplier from biochar soil stock (1)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################


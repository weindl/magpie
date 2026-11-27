*** |  (C) 2008-2026 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* No biochar is produced in this realization. All interfaces of the 63_biochar
* module are fixed to values that leave the rest of the model unchanged:
* - no additional feedstock demand towards 60_bioenergy
* - no biochar costs towards 11_costs
* - yield response multiplier of 1 towards 14_yields (no yield effect)
vm_cost_biochar.fx(i) = 0;
vm_biochar_feedstock_mag.fx(i,feedstock63) = 0;
vm_yld_response_biochar.fx(j) = 1;

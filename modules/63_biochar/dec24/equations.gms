*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' The efficiency of converting biomass feedstock to biochar (here expressed
*' in terms of energy) depends on the biochar production systems, which differ
*' e.g. with respect to slow and fast pyrolysis and the pyrolysis temperature.
*' Residues or dedicated bioenergy crops serve as feedstock for biochar and
*' are assumed to be fully substitutable based on their energy content.

q63_biochar_feedstock_conversion(i2,feedstock63) ..
      v63_biochar_feedstock_mag(i2,feedstock63) =e=
          sum(bc_sys63, v63_biochar_prod(i2,bc_sys63,feedstock63)
          / f63_biochar_efficiency("en_yield",bc_sys63))
          ;

*' The regional level of biochar production is specified for the different
*' biochar production systems, but does not distinguish between the types of
*' biomass feedstock.

q63_biochar_production(i2,bc_sys63) ..
      sum(feedstock63, v63_biochar_prod(i2,bc_sys63,feedstock63)) =e=
          sum((ct, sys_pyr(bc_sys63, biopyr63)), i63_biochar_prod(ct,i2,biopyr63))
          ;

*' Using residues as feedstock to produce biochar is limited by the availability
*' of residues, which is exogenously provided and calculated based on the
*' assumption that roughly 33% of agricultural residues recycled on cropland can
*' be used for other purposes like 2nd generation bioenergy and biochar production.

q63_feedstock_availability_residues(i2) ..
      v63_biochar_feedstock_mag(i2,"residues") =l=
          sum(ct, im_res_2ndgenBE_dem(ct,i2))
          ;

*' The following equation ensures that in MAgPIE-standalone mode (`mag`), where
*' `s63_simulation_mode_mag` is set to 1, the calculated feedstock demand for biochar
*' is passed to the `60_bioenergy` module via the interface `vm_biochar_feedstock_mag`.
*' If biochar is simulated within the REMIND-MAgPIE framework (`rem-mag`), where
*' `s63_simulation_mode_mag` is set to 0, the interface remains inactive (set to zero),
*' since in this case the feedstock demand for biochar has already been accounted
*' for by REMIND and directly enters the `60_bioenergy` module.

q63_biochar_simulation_mode(i2,feedstock63) ..
      vm_biochar_feedstock_mag(i2,feedstock63) =e=
          s63_simulation_mode_mag*v63_biochar_feedstock_mag(i2,feedstock63)
          ;

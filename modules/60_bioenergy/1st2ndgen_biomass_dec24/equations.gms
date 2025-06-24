*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Total demand for energy from biomass comes from different sources.
*' Demand for 1st generation bioenergy crops is based on a fixed trajectory of
*' regional minimum 1st generation bioenergy requirements based on currently
*' established and planned bioenergy policies. Demand for 2nd generation
*' biomass splits into an energy demand from dedicated bioenergy crops, which are
*' fully substitutable based on their energy content, and an energy demand from
*' residues which are also fully substitutable based on their energy content.

q60_bioenergy(i2,kall)..
      vm_dem_bioen(i2,kall) * fm_attributes("ge",kall) =g=
      sum(ct, i60_1stgen_bioenergy_dem(ct,i2,kall)) +
      v60_2ndgen_bioenergy_dem_dedicated(i2,kall) +
      v60_2ndgen_bioenergy_dem_residues(i2,kall)
      ;


*' The calculation of energy demand from dedicated bioenergy crops is based on
*' the following two equations, where only one is active at a time, depending on
*' whether the demand is defined at the regional or global level:
*' If switch `c60_biodem_level` = 1 (regional), the right-hand side of the first
*' equation is set to 0.
*' If switch `c60_biodem_level` = 0 (global), the right-hand side of the second
*' equation is set to 0.

q60_bioenergy_glo.. sum((kbe60,i2), v60_2ndgen_bioenergy_dem_dedicated(i2,kbe60))
                    =g=
                    (sum((ct,i2),i60_bioenergy_dem(ct,i2))
                    + sum(i2,vm_biochar_feedstock_mag(i2,"dedicated"))
                    + sum(i2,v60_res_substitution_bioen(i2)))
                    *(1-c60_biodem_level);

q60_bioenergy_reg(i2).. sum(kbe60, v60_2ndgen_bioenergy_dem_dedicated(i2,kbe60))
                    =g=
                    (sum(ct,i60_bioenergy_dem(ct,i2))
                    + vm_biochar_feedstock_mag(i2,"dedicated")
                    + v60_res_substitution_bioen(i2))
                    *c60_biodem_level;

*' Apart from the summation to a global demand in the first equation, both
*' equations function identically:
*' - They ensure that the total energy demand from dedicated bioenergy crops
*'   is greater than or equal to the aggregated demand, which consists of
*'   `i60_bioenergy_dem` (defined by input data), `vm_biochar_feedstock_mag`
*'   and `v60_res_substitution_bioen`.
*' - The interface `vm_biochar_feedstock_mag` represents additional demand for
*'   dedicated bioenergy crops to produce biochar, and `v60_res_substitution_bioen`
*'   represents additional demand due to residues being substituted by dedicated
*'   bioenergy crops in bioenergy production. Both variables only take effects (`>0`)
*'   in the `mag` simulation mode (`c63_biochar_simulation_mode = "mag"`).
*'   When `c63_biochar_simulation_mode` is set to `rem-mag`, these variables are
*'   set to zero. In this case the feedstock demand for biochar is already
*'   accounted for by REMIND and included in `i60_bioenergy_dem`.
*' - Dedicated bioenergy crops (`kbe60` = bioenergy grasses and bioenergy trees)
*'   are assumed to be fully substitutable based on their energy content.


*' If `mag` simulation mode (`c63_biochar_simulation_mode = "mag"`) is selected
*' in the `63_biochar` module, residues already used for biochar cannot be
*' used to produce bioenergy. They have to be substituted by dedicated
*' bioenergy crops (on energy basis), or result in lower bioenergy production
*' if only partly replaced ('s60_res_substitution_factor <1').

q60_res_to_BEcrops_subs_bioen(i2).. v60_res_substitution_bioen(i2)
                       =g=
                       s60_res_substitution_factor
                       * vm_biochar_feedstock_mag(i2,"residues");


*' The residue potential `i60_res_2ndgenBE_dem` as 2nd generation biomass feedstock
*' is provided exogenously, based on the assumption that approximately 33% of
*' available residues for recycling on cropland can be used for other purposes.
*' The availability of residues depends on the SSP scenario, since residue stock
*' and use is mainly driven by population and GDP.

q60_res_2ndgenBE(i2).. sum(kres, v60_2ndgen_bioenergy_dem_residues(i2,kres))
                       =e=
                       sum(ct,im_res_2ndgenBE_dem(ct,i2));


*' Finally, an incentive is provided for the production of 1st and 2nd generation
*' bioenergy beyond the exogeneous minimum demand. 1st generation bioenergy can be incentivized
*' mass- or energy-based.  For comparability, the former is in line with other realizations and constant over time.
*' The energy-based incentive can take different forms and is applied to both 1st and 2nd generation.
*' Combined with low or fade-out exogenous demands, this is useful to assess bioenergy production potentials, however
*' the endogenous technological change in [13_tc] may react very strongly and create a positive feedback loop.

q60_bioenergy_incentive(i2).. vm_bioenergy_utility(i2)
  =e= sum((ct,k1st60), vm_dem_bioen(i2,k1st60) * (-i60_1stgen_bioenergy_subsidy_tdm(ct)))
  + sum((ct,k1st60), vm_dem_bioen(i2,k1st60) * fm_attributes("ge",k1st60) * (-i60_1stgen_bioenergy_subsidy_gj(ct)))
  + sum((ct,kbe60), vm_dem_bioen(i2,kbe60) * fm_attributes("ge",kbe60) * (-i60_2ndgen_bioenergy_subsidy(ct)));

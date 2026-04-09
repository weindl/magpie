*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
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

*' If exogenous biochar production mode is selected (`s63_biochar_prod_endo` is
*' set to 0) the regional level of biochar production is exogenously specified for
*' the different biochar production systems, but does not distinguish between the
*' types of biomass feedstock. If `s63_biochar_prod_endo` is set to 1, the constraint
*' is not active for years after `sm_fix_SSP2` and MAgPIE can endogenously optimize
*' biochar production based on costs and benefits.

q63_biochar_production(i2,bc_sys63)$((s63_biochar_prod_endo = 0) or (s63_fixed_year = 1)) ..
      sum(feedstock63, v63_biochar_prod(i2,bc_sys63,feedstock63)) =e=
          sum((ct, sys_pyr(bc_sys63, biopyr63)), i63_biochar_prod(ct,i2,biopyr63))
          ;

*' Total regional biochar production equals sum across biochar production systems and feedstocks.
q63_biochar_production_total(i2,att_bc) ..
      v63_biochar_prod_total(i2,att_bc) =e=
          sum((bc_sys63,feedstock63),
          f63_biochar_attributes(att_bc,bc_sys63)
          * v63_biochar_prod(i2,bc_sys63,feedstock63)
          / f63_biochar_attributes("ge",bc_sys63))
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
          s63_simulation_mode_mag * v63_biochar_feedstock_mag(i2,feedstock63)
          ;


*' Only a fraction of the carbon in applied biochar is counted as sequestered
*' carbon and contributes to negative emissions. This is the durable (or
*' recalcitrant) fraction that remains in the soil after 100 years.
*' Recalcitrance refers to biochar's resistance to microbial decomposition
*' in soils. The equation below calculates regional stable carbon sequestration
*' from system-specific applied biochar in dry matter terms, multiplied by the
*' corresponding carbon content and the 100-year stability factor `s63_BC100`.

q63_c_sequestration_biochar_fs(i2,feedstock63) ..
      v63_c_stable_biochar_fs(i2,feedstock63) =e=
          s63_BC100
          * sum(bc_sys63,
          f63_biochar_attributes("c",bc_sys63)
          * v63_biochar_applied_sys_fs(i2,bc_sys63,feedstock63))
          ;

*' Total regional stable carbon sequestration is calculated by aggregating over feedstock.
q63_c_sequestration_biochar_total(i2) ..
      v63_c_stable_biochar(i2) =e=
          sum(feedstock63, v63_c_stable_biochar_fs(i2,feedstock63));


*' Information about biochar carbon removal is only passed to the `56_ghg_policy`
*' module when the standalone mode (`mag`) is active (`s63_simulation_mode_mag`
*' is set to 1). This is done via the interface `vm_cdr_bc_fs`.
*' In coupled REMIND–MAgPIE mode (`rem-mag`), biochar-related carbon dioxide
*' removal is accounted for and rewarded within REMIND, and the interface
*' `vm_cdr_bc_fs` remains zero to prevent double counting of CDR revenues.

q63_cdr_biochar_fs(i2,feedstock63) ..
      vm_cdr_bc_fs(i2,feedstock63) =e=
          s63_simulation_mode_mag * v63_c_stable_biochar_fs(i2,feedstock63)
          ;


*' Regional biochar application on each land type is calculated from annual
*' biochar application rates per area and the corresponding land area.
q63_biochar_application_land(i2,land) ..
      v63_biochar_applied(i2,land) =e=
          sum(cell(i2,j2), v63_biochar_app_rate_area(j2,land) * vm_land(j2,land))
          ;


*' Aggregation over land types or over biochar production systems and feedstocks
*' yields the same total regional biochar application.
q63_biochar_application_total(i2) ..
      sum(land, v63_biochar_applied(i2,land)) =e=
          sum((bc_sys63,feedstock63), v63_biochar_applied_sys_fs(i2,bc_sys63,feedstock63))
          ;


*' Mass balance ensures that produced biochar in dry matter terms is either
*' applied to land or remains not applied.
q63_biochar_application_balance_sys_fs(i2,bc_sys63,feedstock63) ..
      v63_biochar_applied_sys_fs(i2,bc_sys63,feedstock63)
      + v63_biochar_notapplied_sys_fs(i2,bc_sys63,feedstock63)
      =e=
          v63_biochar_prod(i2,bc_sys63,feedstock63)
          / f63_biochar_attributes("ge",bc_sys63)
          ;


*' Annual biochar application per area is capped by a maximum rate.
q63_biochar_app_rate_limit(j2,land) ..
      v63_biochar_app_rate_area(j2,land) =l=
      i63_max_app_rate_area(j2,land)
          ;


*' Cumulate biochar application per area is capped by a maximum biochar soil stock.
q63_biochar_stock_limit(j2,land) ..
      v63_biochar_stock_area(j2,land) =l=
          i63_max_biochar_stock_area(j2,land)
          ;


*' Biochar soil stock depends on the build-up from biochar application of
*' previous time steps and the annual biochar application rate over the lenght
*' of the current time step.
q63_biochar_stock_area(j2,land) ..
      v63_biochar_stock_area(j2,land) =e=
          pc63_biochar_stock_area(j2,land)
          + v63_biochar_app_rate_area(j2,land) * m_timestep_length
          ;


*' Effective biochar soil stock that determines agronomic benefits of biochar
*' application is derived as weighted aggregation over the time step lenght,
*' using the scalar `s63_BC_app_timestep_weight` as temporal aggregation weight.
q63_biochar_stock_effective(j2) ..
      v63_biochar_stock_effective(j2) =e=
          pc63_biochar_stock_area(j2,"crop")
          + s63_BC_app_timestep_weight * m_timestep_length
          * v63_biochar_app_rate_area(j2,"crop")
          ;


*' The yield response to the effective biochar soil stock is represented by a
*' Michaelis–Menten (rectangular hyperbolic) saturation function:
*' `y_response = 1 + y_max * BC_stock_eff / (BC_stock_eff + y_k)`,
*' where `y_max` is the maximum achievable relative yield gain (`i63_yield_response_max`)
*' and `y_k` is the biochar stock level at which half the maximum gain is realized
*' (`i63_yield_response_k`).
q63_yld_response_biochar(j2) ..
      (vm_yld_response_biochar(j2) - 1)
      * (v63_biochar_stock_effective(j2) + i63_yield_response_k(j2)) =e=
          i63_yield_response_max(j2) * v63_biochar_stock_effective(j2)
          ;


*' Regional biochar supply chain costs are accounted for as the sum of
*' (i) biochar gate prices at the production facility (USD17MER per GJ produced),
*' (ii) transport and logistics costs (USD17MER per tDM biochar applied) and
*' (iii) field application costs on land (USD17MER per tDM biochar applied).
*' Gate prices are only considered in MAgPIE-standalone mode (`mag`)
*' (`s63_simulation_mode_mag` = 1) to avoid double counting of conversion costs
*' in the coupled `rem-mag` mode (`s63_simulation_mode_mag` = 0).
q63_cost_biochar(i2) ..
      vm_cost_biochar(i2) =e=
          s63_simulation_mode_mag
          * sum((bc_sys63,feedstock63),
          v63_biochar_prod(i2,bc_sys63,feedstock63)
          * sum(ct,i63_price_biochar_gate(ct,i2,bc_sys63))
          )
          + sum(land, v63_biochar_applied(i2,land)
          * i63_cost_transport(i2)
          )
          + sum(land, v63_biochar_applied(i2,land)
          * i63_cost_application(i2,land)
          )
          ;

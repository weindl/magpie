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
          sum(bc_tech63, v63_biochar_prod(i2,bc_tech63,feedstock63)
          / f63_biochar_efficiency("en_yield",bc_tech63))
          ;

*' The regional level of biochar production is exogenously specified for the
*' different biochar production systems, but does not distinguish between the
*' types of biomass feedstock. In both `mag-exo` and `rem-mag` mode, production is
*' exogenously specified in all years, and the model only decides about the
*' feedstock split and about where the produced biochar is applied.
*' Production is imposed either at the regional or at the global level, where
*' only one of the following two equations is active at a time, depending on
*' the switch `s63_biochar_prod_level`:
*' If switch `s63_biochar_prod_level` = 1 (regional), `q63_biochar_production`
*' constrains biochar production in each region.
*' If switch `s63_biochar_prod_level` = 0 (global), `q63_biochar_production_glo`
*' constrains the global production total and the model chooses the regions
*' where biochar is produced, approximating the biomass trade that takes place
*' in REMIND.

q63_biochar_production(i2,bc_tech63) ..
      sum(feedstock63, v63_biochar_prod(i2,bc_tech63,feedstock63)) =e=
          sum((ct, plant_tech63(bc_tech63, bc_plant63)),
              s63_biochar_prod_level * i63_biochar_prod(ct,i2,bc_plant63))
          + sum(feedstock63, (1 - s63_biochar_prod_level)
              * v63_biochar_prod(i2,bc_tech63,feedstock63))
          ;

q63_biochar_production_glo(bc_tech63) ..
      sum((i2,feedstock63), v63_biochar_prod(i2,bc_tech63,feedstock63)) =e=
          sum((ct, plant_tech63(bc_tech63, bc_plant63)),
              (1 - s63_biochar_prod_level) * p63_biochar_prod_glo(ct,bc_plant63))
          + sum((i2,feedstock63), s63_biochar_prod_level
              * v63_biochar_prod(i2,bc_tech63,feedstock63))
          ;

*' Total regional biochar production equals sum across biochar production systems and feedstocks.
q63_biochar_production_total(i2,att_bc) ..
      v63_biochar_prod_total(i2,att_bc) =e=
          sum((bc_tech63,feedstock63),
          f63_biochar_attributes(att_bc,bc_tech63)
          * v63_biochar_prod(i2,bc_tech63,feedstock63)
          / f63_biochar_attributes("ge",bc_tech63))
          ;

*' Using residues as feedstock to produce biochar is limited by the availability
*' of residues, which is exogenously provided and calculated based on the
*' assumption that roughly 33% of agricultural residues recycled on cropland can
*' be used for other purposes like 2nd generation bioenergy and biochar production.

q63_feedstock_availability_residues(i2) ..
      v63_biochar_feedstock_mag(i2,"residues") =l=
          sum(ct, im_res_2ndgenBE_dem(ct,i2))
          ;

*' The following equation ensures that in the MAgPIE-standalone mode (`mag-exo`),
*' where `s63_simulation_mode_mag` is set to 1, the calculated
*' feedstock demand for biochar is passed to the `60_bioenergy` module via the
*' interface `vm_biochar_feedstock_mag`. If biochar is simulated within the
*' REMIND-MAgPIE framework (`rem-mag` mode), where `s63_simulation_mode_mag`
*' is set to 0, the interface remains inactive (set to zero), since in this
*' case the feedstock demand for biochar has already been accounted for by
*' REMIND and directly enters the `60_bioenergy` module.

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
          * sum(bc_tech63,
          f63_biochar_attributes("c",bc_tech63)
          * v63_biochar_applied_sys_fs(i2,bc_tech63,feedstock63))
           ;


*' Regional biochar application on each land type is calculated from annual
*' biochar application rates per area and the corresponding land area.
q63_biochar_application_land(i2,bcland63) ..
      v63_biochar_applied(i2,bcland63) =e=
          sum(cell(i2,j2), v63_biochar_app_rate_area(j2,bcland63) * vm_land(j2,bcland63))
          ;


*' Aggregation over land types or over biochar production systems and feedstocks
*' yields the same total regional biochar application.
q63_biochar_application_total(i2) ..
      sum(bcland63, v63_biochar_applied(i2,bcland63)) =e=
          sum((bc_tech63,feedstock63), v63_biochar_applied_sys_fs(i2,bc_tech63,feedstock63))
          ;


*' Biochar production is exogenous in both `mag-exo` and `rem-mag` mode, but the
*' application of biochar is a model decision. To prevent produced biochar from
*' being fully diverted to non-agricultural use, a minimum share of production
*' (`s63_bc_min_app_share`, default 100%) must be applied to agricultural land.
q63_biochar_application_min(i2) ..
      sum(bcland63, v63_biochar_applied(i2,bcland63)) =g=
          s63_bc_min_app_share * v63_biochar_prod_total(i2,"dm")
          ;


*' Mass balance ensures that produced biochar in dry matter terms is either
*' applied to land or remains not applied.
q63_biochar_application_balance_sys_fs(i2,bc_tech63,feedstock63) ..
      v63_biochar_applied_sys_fs(i2,bc_tech63,feedstock63)
      + v63_biochar_notapplied_sys_fs(i2,bc_tech63,feedstock63)
      =e=
          v63_biochar_prod(i2,bc_tech63,feedstock63)
          / f63_biochar_attributes("ge",bc_tech63)
          ;


*' Annual biochar application per area is capped by a maximum rate.
q63_biochar_app_rate_limit(j2,bcland63) ..
      v63_biochar_app_rate_area(j2,bcland63) =l=
      i63_max_app_rate_area(j2,bcland63)
          ;


*' Cumulate biochar application per area is capped by a maximum biochar soil stock.
q63_biochar_stock_limit(j2,bcland63) ..
      v63_biochar_stock_area(j2,bcland63) =l=
          i63_max_biochar_stock_area(j2,bcland63)
          ;


*' Biochar soil stock depends on the build-up from biochar application of
*' previous time steps and the annual biochar application rate over the lenght
*' of the current time step.
q63_biochar_stock_area(j2,bcland63) ..
      v63_biochar_stock_area(j2,bcland63) =e=
          pc63_biochar_stock_area(j2,bcland63)
          + v63_biochar_app_rate_area(j2,bcland63) * m_timestep_length
          ;


*' The yield response to the biochar soil stock is represented by a
*' Michaelis–Menten (rectangular hyperbolic) saturation function:
*' `y_response = 1 + y_max * BC_stock / (BC_stock + y_k)`,
*' where `y_max` is the maximum achievable relative yield gain (`i63_yield_response_max`)
*' and `y_k` is the biochar stock level at which half the maximum gain is realized
*' (`i63_yield_response_k`).
q63_yld_response_biochar(j2) ..
      (vm_yld_response_biochar(j2) - 1)
      * (v63_biochar_stock_area(j2,"crop") + i63_yield_response_k(j2)) =e=
          i63_yield_response_max(j2) * v63_biochar_stock_area(j2,"crop")
          ;


*' Regional biochar supply chain costs are accounted for as the sum of
*' (i) biochar gate prices at the production facility (USD17MER per GJ produced),
*' (ii) transport and logistics costs (USD17MER per tDM biochar applied) and
*' (iii) field application costs on land (USD17MER per tDM biochar applied).
*' Gate prices are only considered in the MAgPIE-standalone mode (`mag-exo`)
*' (`s63_simulation_mode_mag` = 1) to avoid double counting of
*' conversion costs in the coupled `rem-mag` mode (`s63_simulation_mode_mag` = 0).
q63_cost_biochar(i2) ..
      vm_cost_biochar(i2) =e=
          s63_simulation_mode_mag
          * sum((bc_tech63,feedstock63),
          v63_biochar_prod(i2,bc_tech63,feedstock63)
          * sum(ct,i63_price_biochar_gate(ct,i2,bc_tech63))
          )
          + sum(bcland63, v63_biochar_applied(i2,bcland63)
          * s63_bc_cost_transport
          )
          + sum(bcland63, v63_biochar_applied(i2,bcland63)
          * s63_bc_cost_application
          )
          ;

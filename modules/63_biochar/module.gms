*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Biochar
*'
*' @description The module 63_biochar provides a regional and biomass-specific
*' biochar feedstock demand (interface $vm\_biochar\_feedstock\_mag$) to the model,
*' which is further used in the [60_bioenergy] module. For this calculation it
*' requires information on conversion factors from biomass into biochar, provided
*' by the module inputs f63\_biochar\_efficiency and f63\_biochar\_attributes.
*' Expected carbon dioxide removal from stable biochar carbon is calculated
*' ($v63\_c\_stable\_biochar\_fs$) and reported, but not credited to the MAgPIE
*' model; in `rem-mag` mode it is accounted for within REMIND.
*'
*' In addition to calculating biochar feedstock quantities, the costs associated
*' with the biochar supply chain (interface $vm\_cost\_biochar$) are provided to
*' the objective function by the [11_costs] module, and the yield response to
*' biochar soil stocks (interface $vm\_yld\_response\_biochar$) to the [14_yields]
*' module.
*'
*' @authors Isabelle Weindl, Kristine Karstens


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%biochar%" == "exo_oct26" $include "./modules/63_biochar/exo_oct26/realization.gms"
$Ifi "%biochar%" == "off" $include "./modules/63_biochar/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################

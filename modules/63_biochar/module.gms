*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Biochar
*'
*' @description The module 63_biochar provides a regional and biomass-specific
*' biochar feedstock demand $vm\_dem\_biochar$ to the model, which is further
*' used in the [16_demand] module. For this calculation it requires
*' information on conversion factors from biomass into biochar (provided by
*' [16_demand] module).
*'
*' In addition to calculating biochar feedstock quantities, the costs associated
*' with the biochar feedstock production are provided to the objective function
*' by the [11_costs] module.
*'
*' @authors Isabelle Weindl


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%biochar%" == "dec24" $include "./modules/63_biochar/dec24/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################

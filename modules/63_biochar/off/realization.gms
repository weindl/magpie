*** |  (C) 2008-2026 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The off realization switches off biochar production.
*' All interfaces of the 63_biochar module are provided but fixed to neutral
*' values (no feedstock demand, no CDR, no costs, yield response multiplier
*' of 1), so that modules 14_yields, 11_costs and 60_bioenergy run
*' unaffected.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/63_biochar/off/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/63_biochar/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/63_biochar/off/preloop.gms"
*######################## R SECTION END (PHASES) ###############################

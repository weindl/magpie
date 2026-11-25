*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The exo_oct26 realization of the biochar module represents
*' Pyrogenic Carbon Capture and Storage (PyCCS) by one uniform biochar product,
*' which is applied to cropland to sequester carbon in agricultural soils.
*' Biochar production drives feedstock demand, which can be fulfilled by
*' dedicated cultivation of fast-growing biomass as well as by residues.
*' Depending on the simulation mode switch `c63_biochar_mode`, biochar production
*' is set as follows:
*' - `mag-exo`: biochar production is exogenously specified for all years via the
*'   scenario switches (`c63_biochar_prod`, `c63_biochar_prod_noselect`), while
*'   the model only decides about the feedstock split and about where the biochar
*'   is applied. Biochar CDR is not credited to the model, so no CDR reward is
*'   paid and carbon pricing cannot act back on the model optimization; the
*'   expected CDR is still calculated internally
*'   (`v63_c_stable_biochar_fs`) and reported.
*' - `rem-mag`: biochar production is prescribed by REMIND, either from the
*'   coupling file in a coupled REMIND-MAgPIE run or from a static REMIND scenario
*'   in `f63_biochar_prod`. Feedstock demand and CDR accounting are handled by
*'   REMIND, and the model-internal feedstock interface
*'   `vm_biochar_feedstock_mag` remains inactive to avoid double counting.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/63_biochar/exo_oct26/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/63_biochar/exo_oct26/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/63_biochar/exo_oct26/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/63_biochar/exo_oct26/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/63_biochar/exo_oct26/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/63_biochar/exo_oct26/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/63_biochar/exo_oct26/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/63_biochar/exo_oct26/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################

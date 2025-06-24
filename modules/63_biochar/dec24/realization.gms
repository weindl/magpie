*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The dec24 realization of the biochar module represents
*' Pyrogenic Carbon Capture and Storage (PyCCS) by one uniform biochar product,
*' which is applied to cropland to sequester carbon in agricultural soils.
*' Biochar production drives feedstock demand, which can be fulfilled by
*' dedicated cultivation of fast-growing biomass as well as by residues.
*'

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/63_biochar/dec24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/63_biochar/dec24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/63_biochar/dec24/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/63_biochar/dec24/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/63_biochar/dec24/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/63_biochar/dec24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/63_biochar/dec24/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/63_biochar/dec24/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################

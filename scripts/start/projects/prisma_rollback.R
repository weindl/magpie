# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------------------------
# description: PRISMA T6.4 "Asymmetric Roll-back" afforestation scenario
# ----------------------------------------------------------------------------
# Runs the ndcdelay afforestation policy: ndc afforestation targets with future
# milestone target-years (>=2030) delayed by country cluster
# (Transition leaders +10y, Diversifying +20y, Fossil-dependent +30y).
# The ndcdelay slice is derived in calc_NPI_NDC (scripts/npi_ndc/start_npi_ndc.R)
# from the ndc rows using an embedded cluster table. The afforestation policy is
# selected via the master config/scenario_config.csv columns "NDC" / "NDC-delay"
# (which set gms$c32_aff_policy to ndc / ndcdelay). For comparison, NDC runs alongside.

library(lucode2)
library(magclass)
library(gms)

source("scripts/start_functions.R")

for (pol_scen in c("NDC", "NDC-delay")) {

  source("config/default.cfg")

  cfg <- setScenario(cfg, c("SSP2", pol_scen))

  # Data already downloaded — skip download and recalibration
  cfg$force_download <- FALSE
  cfg$recalibrate    <- FALSE
  # regenerates npi_ndc_aff_pol.cs3 if the ndcdelay column is missing
  cfg$recalc_npi_ndc <- "ifneeded"

  cfg$title          <- paste0("PRISMA_rollback_", pol_scen)
  cfg$results_folder <- "output/:title:"

  start_run(cfg, codeCheck = FALSE)
}

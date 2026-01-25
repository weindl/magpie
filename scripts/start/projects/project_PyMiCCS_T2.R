# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: PyMiCCS Project runs (Tier 2 sensitivities, subset)
# position: 6
# ----------------------------------------------------------


# Biochar assessment Tier 2 (subset sensitivities) ###########################
# Subset worlds: SSP1-PkBudg650, SSP2-PkBudg1000, SSP3-PkBudg1000
# BC cases: BCoff vs BCon
# Sensitivities:
#        - gate price (low/central/high)
#        - BC100 (0.7/0.8/0.9)
#        - yield response (0/0.10/0.15)


# General set-up =============================================================

library(lucode2)
library(gms)

source("scripts/start_functions.R")
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
#cfg$results_folder <- "output/:title::date:"
cfg$force_replace <- TRUE

cfg$info$flag <- "PT2"
cfg$qos <- "standby"

.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))




# MAgPIE model switches for all scenario runs ================================

### bioenergy settings
cfg$gms$bioenergy <- "1st2ndgen_biomass_dec24"
cfg$gms$s60_res_substitution_factor  <- 1


### biochar settings
cfg$gms$biochar <- "dec24"
cfg$gms$c63_biochar_simulation_mode <- "mag"

cfg$gms$s63_BC100 <- 0.8
cfg$gms$s63_bc_max_app_rate_crop <- 5
cfg$gms$s63_bc_max_stock_crop <- 50

cfg$gms$s63_bc_yield_response_max <- 0.10
cfg$gms$s63_bc_yield_response_k <- 10

cfg$gms$c63_BCcost_scen <- "central"
cfg$gms$s63_bc_cost_transport <- 80
cfg$gms$s63_bc_cost_application <- 10



### other settings
cfg <- setScenario(cfg, "nocc_hist")


cfg0 <- cfg



# Tier 2 scenario definition =================================================

# Representative subset of worlds
worlds <- list(
  list(ssp = "SSP2", miti = "PkBudg650")
)
#worlds <- list(
#  list(ssp = "SSP1", miti = "PkBudg650"),
#  list(ssp = "SSP2", miti = "PkBudg1000"),
#  list(ssp = "SSP3", miti = "PkBudg1000")
#)

bcScen    <- c(bcZero = "none",
               bcMain = "R34BC-SSP2-PkBudg650-BCdef-CTS01-BM70")
# bcScen    <- c(bcZero = "none",
#                          bcDef = "R34BC-SSP2-PkBudg650-BCdef",
#                          bcDef_CTS01 = "R34BC-SSP2-PkBudg650-BCdef-CTS01",
#                          bcDef_CTS01_BM70 = "R34BC-SSP2-PkBudg650-BCdef-CTS01-BM70",
#                          bcPess_CTS01_BM70 = "R34BC-SSP2-PkBudg650-BCpess-CTS01-BM70")


# Sensitivities around central settings
central_gate  <- "central"
central_BC100 <- 0.8
central_ymax  <- 0.10

gateScen <- c("low", "central", "high")
BC100set <- c(0.7, 0.8, 0.9)
yMaxSet  <- c(0.0, 0.10, 0.15)



# helper: apply SSP/mitigation combination ===================================

.apply_policy_inputs <- function(cfg, ssp, miti) {

  if (miti == "NPi2025") {
    cfg <- setScenario(cfg, c(ssp, "NPI"))
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-NPi2025")

  } else if (miti == "PkBudg1000") {
    cfg <- setScenario(cfg, c(ssp, "NDC"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-PkBudg1000")

  } else if (miti == "PkBudg650") {
    if (ssp == "SSP3") return(NULL)  # not available
    cfg <- setScenario(cfg, c(ssp, "NDC"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-PkBudg650")

  } else stop("wrong miti setup")

  return(cfg)
}


# Scenario runs ==============================================================

for (w in worlds) {

  ssp  <- w$ssp
  miti <- w$miti

  for (bc in names(bcScen)) {

    # ============================
    # (0) Central run
    # ============================
    cfg <- cfg0
    cfg <- .apply_policy_inputs(cfg, ssp, miti)
    if (is.null(cfg)) next
    cfg$gms$c63_biochar_prod <- bcScen[bc]

    cfg$gms$c63_BCcost_scen <- central_gate
    cfg$gms$s63_BC100 <- central_BC100
    cfg$gms$s63_bc_yield_response_max <- central_ymax

    cfg$title <- .title(cfg, paste(ssp, miti, bc, sep = "_"),
                        paste0("gate", central_gate),
                        paste0("perm", central_BC100),
                        paste0("ymax", central_ymax))

    start_run(cfg, codeCheck = FALSE)


    # ============================
    # (A) Gate price sensitivity
    # ============================
    for (gate in gateScen) {

      # skip re-running central
      if (gate == central_gate) next

      cfg <- cfg0
      cfg <- .apply_policy_inputs(cfg, ssp, miti)
      if (is.null(cfg)) next
      cfg$gms$c63_biochar_prod <- bcScen[bc]

      cfg$gms$c63_BCcost_scen <- gate
      cfg$gms$s63_BC100 <- central_BC100
      cfg$gms$s63_bc_yield_response_max <- central_ymax

      cfg$title <- .title(cfg, paste(ssp, miti, bc, sep = "_"),
                          paste0("gate", gate))

      start_run(cfg, codeCheck = FALSE)
    }


    # ============================
    # (B) Permanence (BC100) sensitivity
    # ============================
    for (BC100 in BC100set) {

      if (BC100 == central_BC100) next

      cfg <- cfg0
      cfg <- .apply_policy_inputs(cfg, ssp, miti)
      if (is.null(cfg)) next
      cfg$gms$c63_biochar_prod <- bcScen[bc]

      cfg$gms$c63_BCcost_scen <- central_gate
      cfg$gms$s63_BC100 <- BC100
      cfg$gms$s63_bc_yield_response_max <- central_ymax

      cfg$title <- .title(cfg, paste(ssp, miti, bc, sep = "_"),
                          paste0("perm", BC100))

      start_run(cfg, codeCheck = FALSE)
    }


    # ============================
    # (C) Yield response sensitivity
    # ============================
    for (ymax in yMaxSet) {

      if (ymax == central_ymax) next

      cfg <- cfg0
      cfg <- .apply_policy_inputs(cfg, ssp, miti)
      if (is.null(cfg)) next
      cfg$gms$c63_biochar_prod <- bcScen[bc]

      cfg$gms$c63_BCcost_scen <- central_gate
      cfg$gms$s63_BC100 <- central_BC100
      cfg$gms$s63_bc_yield_response_max <- ymax

      cfg$title <- .title(cfg, paste(ssp, miti, bc, sep = "_"),
                          paste0("ymax", ymax))

      start_run(cfg, codeCheck = FALSE)
    }

  }
}

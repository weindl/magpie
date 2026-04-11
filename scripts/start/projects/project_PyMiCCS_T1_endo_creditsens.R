# ----------------------------------------------------------
# description: PyMiCCS Project runs (Tier 1) - logistic credit
# ----------------------------------------------------------

library(lucode2)
library(gms)

source("scripts/start_functions.R")
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

cfg$info$flag <- "PT1endo_rewC_logis"
cfg$qos <- "standby"

.title <- function(cfg, ...) return(paste(cfg$info$flag, sep = "_", ...))


# ================================
# Base configuration
# ================================

### bioenergy
cfg$gms$bioenergy <- "1st2ndgen_biomass_dec24"
cfg$gms$s60_res_substitution_factor <- 0

### biochar
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

cfg$gms$c63_biochar_prod <- "none"
cfg$gms$c63_biochar_prod_noselect <- "none"

### default ghg settings
cfg$gms$s56_bc_luc_credit_steepness <- 100
cfg$gms$s56_bc_luc_credit_threshold <- 0.05

cfg <- setScenario(cfg, "nocc_hist")
cfg0 <- cfg


# ================================
# Scenario definitions
# ================================

ssps <- c("SSP2")
mitiScen <- c("PkBudg650")
#mitiScen <- c("NPi2025", "PkBudg650")
bcScen <- c("BCon")

# ================================
# Sensitivity design
# ================================

bc_app_rate <- c(5)

bc_credit_steepness <- c(1,5,10,15,20)
#bc_credit_steepness <- c(20, 50, 100, 200)
bc_credit_threshold <- c(0.0005,0.001,0.002)
#bc_credit_threshold <- c(0.005, 0.01, 0.02, 0.05)


format_num <- function(x) {
  gsub("\\.", "p", as.character(x))
}


# ================================
# Scenario loop
# ================================

for (ssp in ssps) {
  for (miti in mitiScen) {
    for (bc in bcScen) {
      for (app in bc_app_rate) {
        for (steep in bc_credit_steepness) {
          for (thresh in bc_credit_threshold) {

            cfg <- cfg0

            # ----------------------------
            # Mitigation settings
            # ----------------------------
            if (miti == "NPi2025") {

              cfg <- setScenario(cfg, c(ssp, "NPI"))
              cfg$gms$c56_mute_ghgprices_until <- "y2150"
              cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-NPi2025")
              cfg$gms$c60_2ndgen_biodem <- paste0("R34M410-", ssp, "-NPi2025")

            } else if (miti == "PkBudg650") {

              cfg <- setScenario(cfg, c(ssp, "NDC"))
              cfg$gms$c56_mute_ghgprices_until <- "y2030"
              cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-PkBudg650")
              cfg$gms$c60_2ndgen_biodem <- paste0("R34M410-", ssp, "-PkBudg650")

            } else {
              stop("wrong mitiScen setup")
            }

            # ----------------------------
            # Biochar mode
            # ----------------------------
            if (bc == "BCon") {
              cfg$gms$c63_biochar_prod_mode <- "endo"
            } else {
              stop("unexpected bcScen")
            }

            # ----------------------------
            # Sensitivity assignment
            # ----------------------------
            cfg$gms$s63_bc_max_app_rate_crop <- app
            cfg$gms$s56_bc_luc_credit_steepness <- steep
            cfg$gms$s56_bc_luc_credit_threshold <- thresh

            # ----------------------------
            # Naming
            # ----------------------------
            app_lab <- paste0("app", format_num(app))
            steep_lab <- paste0("st", format_num(steep))
            thr_lab <- paste0("th", format_num(thresh))

            cfg$title <- .title(cfg, paste(ssp, miti, bc, app_lab, steep_lab, thr_lab, sep = "_"))

            start_run(cfg, codeCheck = FALSE)
          }
        }
      }
    }
  }
}
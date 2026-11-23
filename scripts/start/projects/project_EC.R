# |  (C) 2008-2026 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Earth Commission stand-alone runs
# position: 3
# ----------------------------------------------------------


# ====================
# General setup
# ====================

# Load packages required for setScenario()
library(lucode2)
library(gms)

# Load start_run()
source("scripts/start_functions.R")


# ====================
# Project settings
# ====================

# Label for the version of EC scenario implementation
run_flag <- "v03_oct26"

# Project-specific MAgPIE scenario configuration
scenario_config_ec <- "config/projects/scenario_config_ec.csv"


# ====================
# REMIND forcing files
# ====================

# Stand-alone MAgPIE runs use GHG-price and 2nd-generation bioenergy-demand
# trajectories from existing REMIND-MAgPIE runs.
#
# For LM there is no coupled REMIND-MAgPIE scenario in the EC setup. The LM diagnostic
# runs therefore deliberately use the corresponding OC REMIND forcing:
#   - LM NPi    <- OC NPi forcing
#   - LM policy <- OC climate-policy forcing
#
# This is a common-forcing diagnostic: it isolates MAgPIE-side differences
# between OC and LM under identical external energy-system forcing.
# The LM runs are therefore not final coupled results.

remind_base <- "/p/projects/magpie/users/weindl/2_EarthCommission/EC_remmag/EC_runs_v03_oct26/remind/output"

remind_report_paths <- c(
  UF_NPi = file.path(
    remind_base,
    "C_EC_SSP2_UF_2026-10-01_14.38.59/REMIND_generic_C_EC_SSP2_UF.mif"
  ),
  UF_policy = file.path(
    remind_base,
    "C_EC_SSP2_UF_PkBudg750_2026-10-01_23.03.22/REMIND_generic_C_EC_SSP2_UF_PkBudg750.mif"
  ),
  OC_NPi = file.path(
    remind_base,
    "C_EC_SSP1_OC_NPi_2026-10-01_23.07.12/REMIND_generic_C_EC_SSP1_OC_NPi.mif"
  ),
  OC_policy = file.path(
    remind_base,
    "C_EC_SSP1_OC_2026-10-01_23.11.00/REMIND_generic_C_EC_SSP1_OC.mif"
  )
)


# ====================
# Scenarios
# ====================

scenarios <- c(
  "EC_SSP2_UF",
  "EC_SSP2_UF_PkBudg750",
  "EC_SSP1_OC_NPi",
  "EC_SSP1_OC",
  "EC_SSP1_LM_NPi",
  "EC_SSP1_LM"
)


# ====================
# Scenario runs
# ====================

for (i in seq_along(scenarios)) {

  scenario <- scenarios[i]

  # Start each run from default configuration.
  source("config/default.cfg")


  # ------------------------------------
  # Run identification and technical setup
  # ------------------------------------

  cfg$info$flag <- run_flag

  cfg$qos <- "short_highMem"

  cfg$results_folder <- "output/:title::date:"
  cfg$force_replace <- FALSE


  # ------------------------------------
  # Identify pathway and policy variant
  # ------------------------------------

  is_uf <- grepl("EC_SSP2_UF", scenario)
  is_oc <- grepl("EC_SSP1_OC", scenario)
  is_lm <- grepl("EC_SSP1_LM", scenario)

  is_npi <- scenario %in% c(
    "EC_SSP2_UF",
    "EC_SSP1_OC_NPi",
    "EC_SSP1_LM_NPi"
  )


  # ------------------------------------
  # Standard scenario settings
  # ------------------------------------

  if (is_uf) {
    ssp <- "SSP2"
  } else {
    ssp <- "SSP1"
  }

  if (is_npi) {
    cfg <- setScenario(
      cfg,
      c(ssp, "NPI", "AR-natveg", "nocc_hist", "rcp4p5")
    )
    cfg$gms$c56_mute_ghgprices_until <- "y2150"

  } else {
    cfg <- setScenario(
      cfg,
      c(ssp, "NDC", "AR-natveg", "nocc_hist", "rcp1p9")
    )
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
  }


  # ------------------------------------
  # Earth Commission pathway settings
  # ------------------------------------

  if (is_uf) {
    cfg <- setScenario(cfg, "EC-UF", scenario_config = scenario_config_ec)
  }

  if (is_oc) {
    cfg <- setScenario(cfg, "EC-OC", scenario_config = scenario_config_ec)
  }

  if (is_lm) {
    cfg <- setScenario(cfg, "EC-LM", scenario_config = scenario_config_ec)
  }


  # ------------------------------------
  # Settings from current EC coupling setup
  # ------------------------------------
  
  cfg$gms$s15_elastic_demand <- 1
  cfg$gms$c60_1stgen_biodem <- "const2030"
  cfg$gms$s56_limit_ch4_n2o_price <- 734

 
  # ------------------------------------
  # REMIND forcing
  # ------------------------------------

  if (is_uf && is_npi) {
    path_to_coupled_output <- remind_report_paths[["UF_NPi"]]
  } else if (is_uf) {
    path_to_coupled_output <- remind_report_paths[["UF_policy"]]
  } else if (is_npi) {
    # OC forcing is also used for the corresponding LM diagnostic run.
    path_to_coupled_output <- remind_report_paths[["OC_NPi"]]
  } else {
    # OC forcing is also used for the corresponding LM diagnostic run.
    path_to_coupled_output <- remind_report_paths[["OC_policy"]]
  }

  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c60_2ndgen_biodem <- "coupling"
  cfg$path_to_report_ghgprices <- path_to_coupled_output
  cfg$path_to_report_bioenergy <- path_to_coupled_output


  # ------------------------------------
  # Start run
  # ------------------------------------

  cfg$title <- paste(run_flag, scenario, sep = "_")

  start_run(
    cfg = cfg,
    codeCheck = (i == 1)
  )
}

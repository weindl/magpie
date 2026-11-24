# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: biochar test runs comparing module off, no
#              biochar, standard REMIND-MAgPIE production
#              (R34M410, mag-exo and rem-mag), Dorndorf et
#              al. 2026 production with and without yield
#              response, and stylized production, for BAU
#              (NPi2025) and mitigation (PkBudg650) settings
# --------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

# use local test input builds containing f63_biochar_prod.cs3 (built by
# mrland calcBiocharProd, rev >= 4.138). Files must be present in input/
# or reachable via the repositories in cfg$repositories.
cfg$input["regional"] <- "rev4.138+testBiochar_h12_magpie.tgz"
cfg$input["cellular"] <- "rev4.138+testBiochar_h12_1b5c3817_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz"
cfg$input["validation"] <- "rev4.138+testBiochar_h12_92e02314_validation.tgz"

# force input download for all runs
cfg$force_download <- TRUE 

# create additional information to describe the runs
cfg$info$flag <- "BC_PR63"

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))

# Note: all runs except bcOff and bcNone require input data containing
# f63_biochar_prod.cs3 (built by mrland calcBiocharProd, rev >= 4.138)

# policy settings, following scripts/start/test_runs.R:
# NPi2025: continuation of current climate policies, carbon prices muted
#          beyond the model horizon (y2150 means "never")
# PkBudg650: NDC policies switched on in 2030 with prices from a
#            well-below 1.5 degrees scenario
mitis <- list(
  NPi2025 = list(scen = c("SSP2", "NPI"), mute = "y2150",
                 ref = "R34M410-SSP2-NPi2025"),
  PkBudg650 = list(scen = c("SSP2", "NDC"), mute = "y2030",
                   ref = "R34M410-SSP2-PkBudg650")
)

# Dorndorf et al. 2026 (https://doi.org/10.1016/j.erss.2026.104882),
# pessimistic techno-economic assumptions, only available in mag-exo mode.
# Note: regional biochar production in these REMIND standalone runs assumes
# tradable biomass, e.g. production in JPN far exceeds regional feedstock
# supply and application potential. Imposing production at the global level
# (s63_biochar_prod_level = 0) lets MAgPIE choose production regions,
# approximating REMIND's biomass trade and avoiding infeasibilities (y2070).
bcDorndorf <- "PB650-BCpess-CTS01-noFuel-CHP17-EJ100"

runs <- list(
  # module switched off, no biochar code in the model
  bcOff       = list(biochar = "off"),
  # module on, but no biochar production
  bcNone      = list(mode = "mag-exo", bc = "none"),
  # mag-exo: biochar production from REMIND scenario, feedstock demand
  # calculated within MAgPIE and added to 60_bioenergy
  # bcM410: production column of the standard REMIND-MAgPIE run used for
  # prices and demand (R34M410-...). Biochar is available as a technique
  # in those runs but usually not cost-optimal, so values are expected to
  # be zero or close to zero. Still a valid end-to-end test of the input.
  bcM410      = list(mode = "mag-exo", bc = "mitiref"),
  # rem-mag: replay of the standard REMIND-MAgPIE run (mode switch test,
  # biochar was not chosen in REMIND, so production is expected ~ zero)
  bcRemmag    = list(mode = "rem-mag", bc = "mitiref"),
  bcDorndorf  = list(mode = "mag-exo", bc = bcDorndorf, bc_level = 0),
  # same, but with biochar yield response (central literature assumption)
  bcDorndorfYld = list(mode = "mag-exo", bc = bcDorndorf, yield_max = 0.1, bc_level = 0),
  # mag-exo: stylized ramp-up to 10000 (input units, about 10 EJ per yr)
  bcStyl      = list(mode = "mag-exo", bc = "stylized")
)

for (miti in names(mitis)) {

  for (run in names(runs)) {

    run_cfg <- runs[[run]]

    if (!is.null(run_cfg$miti) && run_cfg$miti != miti) next

    cfg <- setScenario(cfg, mitis[[miti]]$scen)
    cfg$gms$c56_mute_ghgprices_until <- mitis[[miti]]$mute

    if (is.null(run_cfg$biochar)) {
      cfg$gms$biochar <- "exo_oct26"
      cfg$gms$c63_biochar_mode <- run_cfg$mode
      if (identical(run_cfg$bc, "mitiref")) {
        cfg$gms$c63_biochar_prod <- mitis[[miti]]$ref
      } else {
        cfg$gms$c63_biochar_prod <- run_cfg$bc
      }
    } else {
      cfg$gms$biochar <- run_cfg$biochar
    }

    # impose biochar production globally for scenarios from REMIND standalone
    # runs (tradable biomass in REMIND), regionally otherwise (default)
    if (!is.null(run_cfg$bc_level)) {
      cfg$gms$s63_biochar_prod_level <- run_cfg$bc_level
    }

    cfg$gms$c56_pollutant_prices <- mitis[[miti]]$ref
    cfg$gms$c60_2ndgen_biodem    <- mitis[[miti]]$ref

    # yield response (default 0, only runs with yield_max set use it)
    cfg$gms$s63_bc_yield_response_max <- if (is.null(run_cfg$yield_max)) 0 else run_cfg$yield_max
    cfg$gms$s63_bc_yield_response_k <- 10

    # settings for the stylized biochar production scenario (bcStyl)
    cfg$gms$s63_bcScen_stylized_startyear <- 2025
    cfg$gms$s63_bcScen_stylized_targetyear <- 2050
    cfg$gms$s63_bcScen_stylized_target <- 10000
    cfg$gms$s63_bcScen_stylized_functional_form <- 1

    cfg$title <- .title(cfg, paste(miti, run, sep = "_"))
    start_run(cfg, codeCheck = FALSE)
  }
}

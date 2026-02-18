*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Regional adoption of biochar scenario, derived from country selection
* Country switch to determine countries for which scenario shall be applied.
* In the default case, the selected scenario (c63_biochar_prod) affects
* all countries.
p63_country_dummy(iso) = 0;
p63_country_dummy(scen_countries63) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.

* To derive regional scenario parametrization from country selection, two
* weighting options are available:

* Option 1: countries are weighted by their population size.
* This option is used to scale regional biochar production trajectories according
* to the relative regional population that adopt this scenario.
p63_region_BC_shr(t_all,i) = sum(i_to_iso(i,iso), p63_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

* Option 2: countries are weighted by available cropland area `pm_avl_cropland_iso`
* This option is used only for the stylized allocation of a global biochar target
* to regions according to area-based weighting.
p63_region_BC_avl_land_shr(i) =  sum(i_to_iso(i,iso), p63_country_dummy(iso) *
  pm_avl_cropland_iso(iso)) / sum(i_to_iso(i,iso), pm_avl_cropland_iso(iso));
p63_effective_land_share(i) = p63_region_BC_avl_land_shr(i) * sum(cell(i,j), pm_land_start(j,"crop"));
p63_effective_land_share(i) = p63_effective_land_share(i) / sum(i2, p63_effective_land_share(i2));


****** Trajectory for stylized biochar scenarios
* linear or sigmoidal interpolation between start year and target year
if (s63_bcScen_stylized_functional_form = 1,
  m_linear_time_interpol(i63_bcScen_stylized_fader,s63_bcScen_stylized_startyear,s63_bcScen_stylized_targetyear,0,1);
elseif s63_bcScen_stylized_functional_form = 2,
  m_sigmoid_time_interpol(i63_bcScen_stylized_fader,s63_bcScen_stylized_startyear,s63_bcScen_stylized_targetyear,0,1);
);


****** Selection of biochar scenario
$ifthen "%c63_biochar_prod%" == "coupling"
  i63_biochar_prod(t,i,biopyr_all63) = f63_biochar_prod_coupling(t,i,biopyr_all63);

$elseif "%c63_biochar_prod%" == "stylized"
  i63_biochar_prod(t,i,biopyr_all63) = 0;
  i63_biochar_prod(t,i,"biopyrCHP") = i63_bcScen_stylized_fader(t) *
      p63_effective_land_share(i) * s63_bcScen_stylized_target;

$else
$ifthen "%c63_biochar_prod%" == "none"
  i63_biochar_prod(t,i,biopyr_all63) = 0;

$elseif "%c63_biochar_prod_noselect%" == "none"
  i63_biochar_prod(t,i,biopyr_all63) = f63_biochar_prod(t,i,biopyr_all63,"%c63_biochar_prod%")
                                     * p63_region_BC_shr(t,i);

$else
  i63_biochar_prod(t,i,biopyr_all63) = f63_biochar_prod(t,i,biopyr_all63,"%c63_biochar_prod%")
                                     * p63_region_BC_shr(t,i)
                                     + f63_biochar_prod(t,i,biopyr_all63,"%c63_biochar_prod_noselect%")
                                     * (1 - p63_region_BC_shr(t,i));
$endif

** Harmonize until predefined time step if not applied in coupled or stylized set-up
  loop(t$(m_year(t) <= sm_fix_SSP2),
    i63_biochar_prod(t,i,biopyr_all63) = f63_biochar_prod(t,i,biopyr_all63,"R2M41-SSP2-NPi");
  );
$endif


****** Additional configurations
* Set simulation mode flag, reflecting if biochar is simulated within the
* REMIND-MAgPIE framework or in a MAgPIE-standalone mode:
$ifthen "%c63_biochar_simulation_mode%" == "mag"
  s63_simulation_mode_mag = 1;
$elseif "%c63_biochar_simulation_mode%" == "rem-mag"
  s63_simulation_mode_mag = 0;
$endif


* Set decision mode flag, reflecting if biochar production is determined
* exogenously or endogenously:
s63_biochar_prod_endo = 0;
$ifthen "%c63_biochar_prod_mode%" == "endo"
  s63_biochar_prod_endo = 1;
$endif
* The endogenous mode is only supported in the MAgPIE-standalone mode:
$ifthen "%c63_biochar_simulation_mode%" == "rem-mag"
  s63_biochar_prod_endo = 0;
$endif


* Biochar soil stock per area is initialized, assuming that no biochar was applied
* before the start of the simulation period.
pc63_biochar_stock_area(j,land) = 0;


* Set biochar application limits according to configuration:
i63_max_app_rate_area(j,land) = 0;
i63_max_app_rate_area(j,"crop") = s63_bc_max_app_rate_crop;

i63_max_biochar_stock_area(j,land) = 0;
i63_max_biochar_stock_area(j,"crop") = s63_bc_max_stock_crop;


* Set agronomic yield response parameters according to configuration:
i63_yield_response_max(j) = s63_bc_yield_response_max;
i63_yield_response_k(j) = s63_bc_yield_response_k;


* Set biochar-related prices and costs according to configuration:
i63_cost_transport(i) = s63_bc_cost_transport;
i63_cost_application(i,land) = s63_bc_cost_application;

$ifthen "%c63_BCcost_scen%" == "none"
  i63_price_biochar_gate(t,i,bc_sys63) = 0;
$else
loop(t,
 if(m_year(t) <= sm_fix_SSP2,
  i63_price_biochar_gate(t,i,bc_sys63) = f63_biochar_gate_price(t,bc_sys63,"central");
 else
  i63_price_biochar_gate(t,i,bc_sys63) = f63_biochar_gate_price(t,bc_sys63,"%c63_BCcost_scen%");
 );
);
$endif

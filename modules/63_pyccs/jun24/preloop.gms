*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Regional adoption of biochar scenario, derived from country selection:
* Country switch to determine countries for which scenario shall be applied.
* In the default case, the selected scenario (c63_2ndgen_biochardem) affects
* all countries.
p63_country_dummy(iso) = 0;
p63_country_dummy(scen_countries63) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p63_region_BC_shr(t_all,i) = sum(i_to_iso(i,iso), p63_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

$ifthen "%c63_2ndgen_biochardem%" == "coupling"
  i63_biochar_dem(t,i) = f63_biochar_dem_coupling(t,i);
$elseif "%c63_2ndgen_biochardem%" == "emulator"
  i63_biochar_dem(t,i) = f63_biochar_dem_emulator(t)/card(i);
$elseif "%c63_2ndgen_biochardem%" == "none"
  i63_biochar_dem(t,i) = 0;
$else
  i63_biochar_dem(t,i) = f63_biochar_dem(t,i,"%c63_2ndgen_biochardem%") * p63_region_BC_shr(t,i)
                         + f63_biochar_dem(t,i,"%c63_2ndgen_biochardem_noselect%") * (1-p63_region_BC_shr(t,i));
** Harmonize until predefined time step if not applied in coupled or emulator set-up
loop(t$(m_year(t) <= sm_fix_SSP2),
  i63_biochar_dem(t,i) = f63_biochar_dem(t,i,"R32M46-SSP2EU-NPi");
);
$endif

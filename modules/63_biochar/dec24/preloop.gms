*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Regional adoption of biochar scenario, derived from country selection:
* Country switch to determine countries for which scenario shall be applied.
* In the default case, the selected scenario (c63_biochar_prod) affects
* all countries.
p63_country_dummy(iso) = 0;
p63_country_dummy(scen_countries63) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p63_region_BC_shr(t_all,i) = sum(i_to_iso(i,iso), p63_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));


$ifthen "%c63_biochar_prod%" == "coupling"
  i63_biochar_prod(t,i,biopyr_all63) = f63_biochar_prod_coupling(t,i,biopyr_all63);
$elseif "%c63_biochar_prod%" == "emulator"
  i63_biochar_prod(t,i,biopyr_all63) = f63_biochar_prod_emulator(t,biopyr_all63)/card(i);
$elseif "%c63_biochar_prod%" == "none"
  i63_biochar_prod(t,i,biopyr_all63) = 0;
$else
  i63_biochar_prod(t,i,biopyr_all63) = f63_biochar_prod(t,i,biopyr_all63,"%c63_biochar_prod%") * p63_region_BC_shr(t,i)
                         + f63_biochar_prod(t,i,biopyr_all63,"%c63_biochar_prod_noselect%") * (1-p63_region_BC_shr(t,i));
** Harmonize until predefined time step if not applied in coupled or emulator set-up
loop(t$(m_year(t) <= sm_fix_SSP2),
  i63_biochar_prod(t,i,biopyr_all63) = f63_biochar_prod(t,i,biopyr_all63,"BC-SSP2-NPi-REMIND");
);
$endif


* Set simulation mode flag, reflecting if biochar is simulated within the
* REMIND-MAgPIE framework or in a MAgPIE-standalone mode:
$ifthen "%c63_biochar_simulation_mode%" == "mag"
  s63_simulation_mode_mag = 1;
$elseif "%c63_biochar_simulation_mode%" == "rem-mag"
  s63_simulation_mode_mag = 0;
$endif

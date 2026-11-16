*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


* Calculate decay of biochar soil stocks over time, depending on the time-step m_timestep_length
p63_biochar_stock_decay_step(t) = s63_biochar_stock_decay_yr**m_timestep_length;


** Determine years with exogenously fixed biochar production
* The scalar `s63_fixed_year` flags the years where the equation setting biochar
* production to exogenous levels is active. In `endo` mode, it is only active
* until `sm_fix_SSP2` (harmonization period), after which biochar production is
* determined endogenously. In `exo` and `rem-mag` mode, production follows the
* exogenous scenario selection in all years.
* Harmonization of the exogenous production levels is done in the preloop file.
$ifthen "%c63_biochar_mode%" == "endo"
  if(m_year(t) <= sm_fix_SSP2,
    s63_fixed_year = 1;
  else
    s63_fixed_year = 0;
  );
$else
  s63_fixed_year = 1;
$endif




$ifthen "%c63_biochar_mode%" == "endo"
** Add minimal biochar production in case of zero demand or very small demand to avoid zero prices
i63_biochar_prod(t,i,bc_plant63)$(i63_biochar_prod(t,i,bc_plant63) < s63_biochar_min) = s63_biochar_min;
* Minimal biochar production is ensured via lower bounds
if(m_year(t) > sm_fix_SSP2,
  v63_biochar_prod_total.lo(i,"ge") = s63_biochar_min * card(bc_plant63);
);
$endif

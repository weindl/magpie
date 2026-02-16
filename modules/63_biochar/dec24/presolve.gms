*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


* Calculate decay of biochar soil stocks over time, depending on the time-step m_timestep_length
p63_biochar_stock_decay_step(t) = s63_biochar_stock_decay_yr**m_timestep_length;


** Harmonize endogenously determined biochar production until sm_fix_SSP2
* The scalar `s63_fixed_year` flags the years where the equation setting biochar production to 
* harmonized levels should be active. For years after `sm_fix_SSP2`, the equation is not active
* in the endogenous biochar production mode.
* Harmonization of exogenous biochar production scenarios in done in the related preloop-file.
if(m_year(t) <= sm_fix_SSP2,
  s63_fixed_year = 1;
else
  s63_fixed_year = 0;
);




** Add minimal biochar production in case of zero demand or very small demand to avoid zero prices
i63_biochar_prod(t,i,biopyr63)$(i63_biochar_prod(t,i,biopyr63) < s63_biochar_min) = s63_biochar_min;
* If the endogenous biochar production mode is selected, minimal biochar production is ensured via lower bounds
if(m_year(t) > sm_fix_SSP2,
  if(s63_biochar_prod_endo = 1,
    v63_biochar_prod_total.lo(i) = s63_biochar_min * card(biopyr63);
  );
);

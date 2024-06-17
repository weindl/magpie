*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_dem_biochar.fx(i,kap) = 0;
v63_2ndgen_biochar_dem_dedicated.fx(i,kall) = 0;
v63_2ndgen_biochar_dem_dedicated.up(i,kbe63) = Inf;
v63_2ndgen_biochar_dem_residues.fx(i,kall) = 0;
v63_2ndgen_biochar_dem_residues.up(i,kres) = Inf;

if(m_year(t) <= sm_fix_SSP2,
 i63_res_2ndgenBC_dem(t,i) =
             f63_res_2ndgenBC_dem(t,i,"ssp2");
else
 i63_res_2ndgenBC_dem(t,i) =
             f63_res_2ndgenBC_dem(t,i,"%c63_res_2ndgenBC_dem%");
);

* Add minimal biochar demand in case of zero demand or very small demand to avoid zero prices
i63_biochar_dem(t,i)$(i63_biochar_dem(t,i) < s63_2ndgen_biochar_dem_min) = s63_2ndgen_biochar_dem_min;

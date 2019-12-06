*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



****select discount_factor
$ifthen "%c56_discount_factor%" == "ghg_price_growth_rate" pc56_discount_factor(i,pollutants) = p56_ghg_price_growth_rate(t,i,pollutants);
$elseif "%c56_discount_factor%" == "interest_rate" pc56_discount_factor(i,pollutants) = pm_interest(i);
$endif

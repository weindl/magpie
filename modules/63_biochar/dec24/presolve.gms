*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Add minimal biochar production in case of zero demand or very small demand to avoid zero prices
i63_biochar_prod(t,i,biopyr_all63)$(i63_biochar_prod(t,i,biopyr_all63) < s63_biochar_min) = s63_biochar_min;

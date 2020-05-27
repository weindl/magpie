*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*fix primforest
vm_land.fx(j,"primforest") = pcm_land(j,"primforest");

*fix secdforest
vm_natveg_secdforest.fx(j,ac) = 0;
vm_natveg_secdforest.fx(j,"acx") = pcm_land(j,"secdforest");
vm_land.fx(j,"secdforest") = sum(ac, v35_secdforest.l(j,ac));

*fix other land
vm_natveg_other.fx(j,ac) = 0;
vm_natveg_other.fx(j,"acx") = pcm_land(j,"other");
vm_land.fx(j,"other") = sum(ac, v35_other.l(j,ac));

vm_landdiff_natveg.fx = 0;


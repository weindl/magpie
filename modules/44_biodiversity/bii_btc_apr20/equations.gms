*** (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


 q44_cost_biodiv_loss(j2) .. vm_cost_biodiv_loss(j2)
 					=e=
 					sum(bii44, v44_biodiv_loss(j2,bii44)) * pc44_price_biodiv_loss;

 q44_biodiv_loss(j2,bii44) .. v44_biodiv_loss(j2,bii44)
 					=e=
 					pc44_biodiv(j2,bii44) - v44_biodiv(j2,bii44);

 q44_biodiv(j2,bii44) .. v44_biodiv(j2,bii44)
 					=e=
 					f44_rr_layer(j2) * sum(potforest44, v44_bii(j2,bii44,potforest44));

 q44_crop_ann(j2,potforest44) .. v44_bii(j2,"crop_ann",potforest44)
 					=e=
 					sum((crop_ann44,w), vm_area(j2,crop_ann44,w)) * f44_bii_coeff("crop_ann",potforest44) * f44_luh2_side_layers(j2,potforest44);

 q44_crop_per(j2,potforest44) .. v44_bii(j2,"crop_per",potforest44)
 					=e=
 					sum((crop_per44,w), vm_area(j2,crop_per44,w)) * f44_bii_coeff("crop_per",potforest44) * f44_luh2_side_layers(j2,potforest44);

 q44_manpast(j2,potforest44) .. v44_bii(j2,"manpast",potforest44)
 					=e=
 					vm_land(j2,"past") * f44_luh2_side_layers(j2,"manpast") * f44_bii_coeff("manpast",potforest44) * f44_luh2_side_layers(j2,potforest44);

 q44_rangeland(j2,potforest44) .. v44_bii(j2,"rangeland",potforest44)
 					=e=
 					vm_land(j2,"past") * f44_luh2_side_layers(j2,"rangeland") * f44_bii_coeff("rangeland",potforest44) * f44_luh2_side_layers(j2,potforest44);

 q44_urban(j2,potforest44) .. v44_bii(j2,"urban",potforest44)
 					=e=
 					vm_land(j2,"urban") * f44_bii_coeff("urban",potforest44) * f44_luh2_side_layers(j2,potforest44);

 q44_primary(j2,potforest44) .. v44_bii(j2,"primary",potforest44)
 					=e=
 					vm_land(j2,"primforest") * f44_bii_coeff("primary",potforest44) * f44_luh2_side_layers(j2,potforest44);

* The following equations also include different types of forestry (aff, ndc, plant), as defined in the forestry module. Since bii values of "aff" and "ndc" afforestation correspond to those of secondary vegetation in the Bending the Curve initiative and timber plantations ("plant") are noy yet included, forestry is mapped together with secondary vegetation in the present realisation.

 q44_secd_mature(j2,potforest44) .. v44_bii(j2,"secd_mature",potforest44)
 					=e=
                    sum(ac_mature, vm_natveg_secdforest(j2,ac_mature) + vm_natveg_other(j2,ac_mature) + vm_land_fore(j2,"aff",ac_mature) + vm_land_fore(j2,"ndc",ac_mature)) * f44_bii_coeff("secd_mature",potforest44) * f44_luh2_side_layers(j2,potforest44);

 q44_secd_young(j2,potforest44) .. v44_bii(j2,"secd_young",potforest44)
 					=e=
 					sum(ac_young, vm_natveg_secdforest(j2,ac_young) + vm_natveg_other(j2,ac_young) +  vm_land_fore(j2,"aff",ac_young) +  vm_land_fore(j2,"ndc",ac_young))*f44_bii_coeff("secd_young",potforest44) * f44_luh2_side_layers(j2,potforest44);

*** EOF constraints.gms ***

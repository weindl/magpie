*** (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

pc44_biodiv(j,bii44) = v44_biodiv.l(j,bii44);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov44_biodiv_loss(t,j,bii44,"marginal")       = v44_biodiv_loss.m(j,bii44);
 ov_cost_biodiv_loss(t,j,"marginal")          = vm_cost_biodiv_loss.m(j);
 ov44_bii(t,j,bii44,potforest44,"marginal")   = v44_bii.m(j,bii44,potforest44);
 ov44_biodiv(t,j,bii44,"marginal")            = v44_biodiv.m(j,bii44);
 oq44_crop_ann(t,j,potforest44,"marginal")    = q44_crop_ann.m(j,potforest44);
 oq44_crop_per(t,j,potforest44,"marginal")    = q44_crop_per.m(j,potforest44);
 oq44_manpast(t,j,potforest44,"marginal")     = q44_manpast.m(j,potforest44);
 oq44_rangeland(t,j,potforest44,"marginal")   = q44_rangeland.m(j,potforest44);
 oq44_urban(t,j,potforest44,"marginal")       = q44_urban.m(j,potforest44);
 oq44_primary(t,j,potforest44,"marginal")     = q44_primary.m(j,potforest44);
 oq44_secd_mature(t,j,potforest44,"marginal") = q44_secd_mature.m(j,potforest44);
 oq44_secd_young(t,j,potforest44,"marginal")  = q44_secd_young.m(j,potforest44);
 oq44_biodiv_loss(t,j,bii44,"marginal")       = q44_biodiv_loss.m(j,bii44);
 oq44_biodiv(t,j,bii44,"marginal")            = q44_biodiv.m(j,bii44);
 oq44_cost_biodiv_loss(t,j,"marginal")        = q44_cost_biodiv_loss.m(j);
 ov44_biodiv_loss(t,j,bii44,"level")          = v44_biodiv_loss.l(j,bii44);
 ov_cost_biodiv_loss(t,j,"level")             = vm_cost_biodiv_loss.l(j);
 ov44_bii(t,j,bii44,potforest44,"level")      = v44_bii.l(j,bii44,potforest44);
 ov44_biodiv(t,j,bii44,"level")               = v44_biodiv.l(j,bii44);
 oq44_crop_ann(t,j,potforest44,"level")       = q44_crop_ann.l(j,potforest44);
 oq44_crop_per(t,j,potforest44,"level")       = q44_crop_per.l(j,potforest44);
 oq44_manpast(t,j,potforest44,"level")        = q44_manpast.l(j,potforest44);
 oq44_rangeland(t,j,potforest44,"level")      = q44_rangeland.l(j,potforest44);
 oq44_urban(t,j,potforest44,"level")          = q44_urban.l(j,potforest44);
 oq44_primary(t,j,potforest44,"level")        = q44_primary.l(j,potforest44);
 oq44_secd_mature(t,j,potforest44,"level")    = q44_secd_mature.l(j,potforest44);
 oq44_secd_young(t,j,potforest44,"level")     = q44_secd_young.l(j,potforest44);
 oq44_biodiv_loss(t,j,bii44,"level")          = q44_biodiv_loss.l(j,bii44);
 oq44_biodiv(t,j,bii44,"level")               = q44_biodiv.l(j,bii44);
 oq44_cost_biodiv_loss(t,j,"level")           = q44_cost_biodiv_loss.l(j);
 ov44_biodiv_loss(t,j,bii44,"upper")          = v44_biodiv_loss.up(j,bii44);
 ov_cost_biodiv_loss(t,j,"upper")             = vm_cost_biodiv_loss.up(j);
 ov44_bii(t,j,bii44,potforest44,"upper")      = v44_bii.up(j,bii44,potforest44);
 ov44_biodiv(t,j,bii44,"upper")               = v44_biodiv.up(j,bii44);
 oq44_crop_ann(t,j,potforest44,"upper")       = q44_crop_ann.up(j,potforest44);
 oq44_crop_per(t,j,potforest44,"upper")       = q44_crop_per.up(j,potforest44);
 oq44_manpast(t,j,potforest44,"upper")        = q44_manpast.up(j,potforest44);
 oq44_rangeland(t,j,potforest44,"upper")      = q44_rangeland.up(j,potforest44);
 oq44_urban(t,j,potforest44,"upper")          = q44_urban.up(j,potforest44);
 oq44_primary(t,j,potforest44,"upper")        = q44_primary.up(j,potforest44);
 oq44_secd_mature(t,j,potforest44,"upper")    = q44_secd_mature.up(j,potforest44);
 oq44_secd_young(t,j,potforest44,"upper")     = q44_secd_young.up(j,potforest44);
 oq44_biodiv_loss(t,j,bii44,"upper")          = q44_biodiv_loss.up(j,bii44);
 oq44_biodiv(t,j,bii44,"upper")               = q44_biodiv.up(j,bii44);
 oq44_cost_biodiv_loss(t,j,"upper")           = q44_cost_biodiv_loss.up(j);
 ov44_biodiv_loss(t,j,bii44,"lower")          = v44_biodiv_loss.lo(j,bii44);
 ov_cost_biodiv_loss(t,j,"lower")             = vm_cost_biodiv_loss.lo(j);
 ov44_bii(t,j,bii44,potforest44,"lower")      = v44_bii.lo(j,bii44,potforest44);
 ov44_biodiv(t,j,bii44,"lower")               = v44_biodiv.lo(j,bii44);
 oq44_crop_ann(t,j,potforest44,"lower")       = q44_crop_ann.lo(j,potforest44);
 oq44_crop_per(t,j,potforest44,"lower")       = q44_crop_per.lo(j,potforest44);
 oq44_manpast(t,j,potforest44,"lower")        = q44_manpast.lo(j,potforest44);
 oq44_rangeland(t,j,potforest44,"lower")      = q44_rangeland.lo(j,potforest44);
 oq44_urban(t,j,potforest44,"lower")          = q44_urban.lo(j,potforest44);
 oq44_primary(t,j,potforest44,"lower")        = q44_primary.lo(j,potforest44);
 oq44_secd_mature(t,j,potforest44,"lower")    = q44_secd_mature.lo(j,potforest44);
 oq44_secd_young(t,j,potforest44,"lower")     = q44_secd_young.lo(j,potforest44);
 oq44_biodiv_loss(t,j,bii44,"lower")          = q44_biodiv_loss.lo(j,bii44);
 oq44_biodiv(t,j,bii44,"lower")               = q44_biodiv.lo(j,bii44);
 oq44_cost_biodiv_loss(t,j,"lower")           = q44_cost_biodiv_loss.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################


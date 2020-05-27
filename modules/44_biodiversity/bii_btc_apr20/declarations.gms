*** (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
 pc44_biodiv(j,bii44)				current biodiv stock (Mha)
 p44_price_biodiv_loss(t)			biodiv loss price factor (US$ per ha of biodiv loss)
 pc44_price_biodiv_loss			    biodiv loss price factor (US$ per ha of biodiv loss)
;

variables
 v44_biodiv_loss(j,bii44)	 		    biodiv loss (Mha per time step)
 vm_cost_biodiv_loss(j)					biodiv loss cost (mio US$)
;

positive variables
 v44_bii(j,bii44,potforest44)		  bii (Mha)
 v44_biodiv(j,bii44) 			 	  biodiv value (Mha)
;

equations
 q44_crop_ann(j,potforest44)		   cropland bii constraint
 q44_crop_per(j,potforest44)		   cropland bii constraint
 q44_manpast(j,potforest44)				   	   manpast bii constraint
 q44_rangeland(j,potforest44)				   rangeland bii constraint
 q44_urban(j,potforest44)					   urban bii constraint
 q44_primary(j,potforest44)					   primveg bii constraint
 q44_secd_mature(j,potforest44)				   secdveg mature bii constraint
 q44_secd_young(j,potforest44)				   secdveg yound bii constraint
 q44_biodiv_loss(j,bii44)			    biodiv loss constraint
 q44_biodiv(j,bii44)				    biodiv stock constraint
 q44_cost_biodiv_loss(j)			    biodiv loss cost constraint
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov44_biodiv_loss(t,j,bii44,type)       biodiv loss (Mha per time step)
 ov_cost_biodiv_loss(t,j,type)          biodiv loss cost (mio US$)
 ov44_bii(t,j,bii44,potforest44,type)   bii (Mha)
 ov44_biodiv(t,j,bii44,type)            biodiv value (Mha)
 oq44_crop_ann(t,j,potforest44,type)    cropland bii constraint
 oq44_crop_per(t,j,potforest44,type)    cropland bii constraint
 oq44_manpast(t,j,potforest44,type)     manpast bii constraint
 oq44_rangeland(t,j,potforest44,type)   rangeland bii constraint
 oq44_urban(t,j,potforest44,type)       urban bii constraint
 oq44_primary(t,j,potforest44,type)     primveg bii constraint
 oq44_secd_mature(t,j,potforest44,type) secdveg mature bii constraint
 oq44_secd_young(t,j,potforest44,type)  secdveg yound bii constraint
 oq44_biodiv_loss(t,j,bii44,type)       biodiv loss constraint
 oq44_biodiv(t,j,bii44,type)            biodiv stock constraint
 oq44_cost_biodiv_loss(t,j,type)        biodiv loss cost constraint
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################


*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** BEGIN INDC **

* Limit demand for prescribed NPI/NDC afforestation in `p32_aff_pol` if not enough suitable area (`p32_aff_pot`) for afforestation is available.
   p32_aff_pot(t,j) = (vm_land.l(j,"crop") - vm_land.lo(j,"crop")) + (vm_land.l(j,"past") - vm_land.lo(j,"past"));
*correct indc forest stock based on p32_aff_pot
  if((ord(t) > 1),
      p32_aff_pol(t,j)$(p32_aff_pol(t,j) - p32_aff_pol(t-1,j) > p32_aff_pot(t,j)) = p32_aff_pol(t-1,j) + p32_aff_pot(t,j);
    );
*calc indc afforestation per time step based on forest stock changes
  p32_aff_pol_timestep("y1995",j) = 0;
  p32_aff_pol_timestep(t,j)$(ord(t)>1) = p32_aff_pol(t,j) - p32_aff_pol(t-1,j);

if(m_year(t) <= sm_fix_SSP2,
 p32_max_aff_area = Inf;
else
 p32_max_aff_area = s32_max_aff_area;
);

** END INDC **

*' @code
*' Wood demand is set to zero because forestry is not modeled in this realization.
vm_supply.fx(i2,kforestry) = 0;

*' Certain areas (e.g. the boreal zone) are excluded from endogenous afforestation.
if(m_year(t) <= sm_fix_SSP2,
	vm_land_fore.fx(j,"aff","ac0") = 0;
else
	vm_land_fore.lo(j,"aff","ac0") = 0;
	vm_land_fore.up(j,"aff","ac0") = f32_aff_mask(j) * sum(land, pcm_land(j,land));
);
*' Endogenous afforestation is limited to cells with vegetation carbon density above 20 tC/ha.
vm_land_fore.fx(j,"aff","ac0")$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;

if(s32_aff_plantation = 0,
 p32_carbon_density_ac(t,j,"aff",ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
elseif s32_aff_plantation = 1,
 p32_carbon_density_ac(t,j,"aff",ac,ag_pools) = pm_carbon_density_ac_forestry(t,j,ac,ag_pools);
);
p32_carbon_density_ac(t,j,"ndc",ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
p32_carbon_density_ac(t,j,"plant",ac,ag_pools) = pm_carbon_density_ac_forestry(t,j,ac,ag_pools);

*' CDR from afforestation for each age-class, depending on planning horizon.
p32_cdr_ac(t,j,ac)$(ord(ac) > 1 AND (ord(ac)-1) <= s32_planing_horizon/5)
= p32_carbon_density_ac(t,j,"aff",ac,"vegc") - p32_carbon_density_ac(t,j,"aff",ac-1,"vegc");
*' @stop

* Regrowth of natural vegetation (natural succession) is modelled by shifting age-classes according to time step length.
s32_shift = (5/5)$(ord(t)=1);
s32_shift = (m_timestep_length/5)$(ord(t)>1);

if((ord(t)>1),
*example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s32_shift = 1)
p32_land(t,j,type32,ac)$(ord(ac) > s32_shift) = p32_land(t-1,j,type32,ac-s32_shift);
*account for cases at the end of the age class set (s32_shift > 1) which are not shifted by the above calculation
p32_land(t,j,type32,"acx") = p32_land(t,j,type32,"acx") + sum(ac$(ord(ac) > card(ac)-s32_shift), p32_land(t-1,j,type32,ac));
);
*should not be necessary. Just to be on the save side
p32_land(t,j,type32,"ac0") = 0;

*calculate vm_land_fore.l
vm_land_fore.l(j,type32,ac) = p32_land(t,j,type32,ac);
pc32_land(j,type32,ac) = p32_land(t,j,type32,ac);
vm_land.l(j,"forestry") = sum((type32,ac), p32_land(t,j,type32,ac));
pcm_land(j,"forestry") = sum((type32,ac), p32_land(t,j,type32,ac));

** fix ndc afforestation forever, all age-classes are fixed except ac0
vm_land_fore.fx(j,"ndc",ac_sub) = pc32_land(j,"ndc",ac_sub);
** fix c price induced afforestation based on s32_planing_horizon, fixed only until end of s32_planing_horizon, ac0 is free
vm_land_fore.fx(j,"aff",ac_sub)$(ord(ac_sub) <= s32_planing_horizon/5) = pc32_land(j,"aff",ac_sub);
vm_land_fore.up(j,"aff",ac_sub)$(ord(ac_sub) > s32_planing_horizon/5) = pc32_land(j,"aff",ac_sub);
** fix forestry plantations for all age-classes (no forestry modelled)
vm_land_fore.fx(j,"plant",ac) = pc32_land(j,"plant",ac);

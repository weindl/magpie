
*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_biochar(t,i,"marginal")                      = vm_cost_biochar.m(i);
 ov_biochar_feedstock_mag(t,i,feedstock63,"marginal") = vm_biochar_feedstock_mag.m(i,feedstock63);
 ov_yld_response_biochar(t,j,"marginal")              = vm_yld_response_biochar.m(j);
 ov_cost_biochar(t,i,"level")                         = vm_cost_biochar.l(i);
 ov_biochar_feedstock_mag(t,i,feedstock63,"level")    = vm_biochar_feedstock_mag.l(i,feedstock63);
 ov_yld_response_biochar(t,j,"level")                 = vm_yld_response_biochar.l(j);
 ov_cost_biochar(t,i,"upper")                         = vm_cost_biochar.up(i);
 ov_biochar_feedstock_mag(t,i,feedstock63,"upper")    = vm_biochar_feedstock_mag.up(i,feedstock63);
 ov_yld_response_biochar(t,j,"upper")                 = vm_yld_response_biochar.up(j);
 ov_cost_biochar(t,i,"lower")                         = vm_cost_biochar.lo(i);
 ov_biochar_feedstock_mag(t,i,feedstock63,"lower")    = vm_biochar_feedstock_mag.lo(i,feedstock63);
 ov_yld_response_biochar(t,j,"lower")                 = vm_yld_response_biochar.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################


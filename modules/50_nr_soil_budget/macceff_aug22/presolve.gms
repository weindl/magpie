*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' We first need to transform the MACC curves from a format where they are a function
*' of inputs to a function of losses. The two approaches are
*' (1) E_1 = I_1 * EF * (1-MACCs1)
*' (2) E_2 = I_2 * (1-NUE2) / (1-NUE_ef) * EF
*' with the further condition:
*' (3) H=I_i*NUE_i
*' E: emissions, I: nutrient inputs, EF: emission factor,
*' NUE: nitrogen use efficiency, H: harvested N
*' NUE_ef: the nitrogen use efficiency for which the EF is made
*
*' Both appraoches should lead to the same result, we can simplify E1=E2 to
*' (4) NUE_2 = 1-1/(1+(1-NUE_ef)(1-MACCs)/(NUE_1)))
*' Next, we build a model in which the loss share of nutrients (1-NUE_2) is
*' equivalent to the baselines loss share (1-NUE_base2) and a transformed MACC
*' curve MACC_2, so that
*' (5) (1-NUE_2) = (1-NUE_base2) * (1-MACC_2)
*' combining (4) and (5)
*' MACC_2 = 1-(1-1/(1+(1-NUE_ef)*(1-MACCs)/(NUE_1))) / (1-NUE_base2)

*' NUE_1 is the NUE implicit to the model that was used for estimating MACCs,
*' while NUE_bau2 is the one implicit to MAgPIE. For simplicity or in absence
*' of data, they can be equalized for the baseyear such that
*' NUE_1 <- NUE_base2[baseyear].
*' If the MACCs are assumed universal in the sense of consistent with the
*' IPCC guidelines, an alternative assumption would be NUE1 <- NUE_ef.
*' The year of NUE_base2 should be fixed to the baseyear efficiency, as
*' alternative "baseline" improvements would otherwise not have an effect on the
*' emissions.
*' The name of the MACC category "inorg_fert_n2o" actually includes all types
*' of soil N2O emissions. Most of these measures also reduce general Nr surpluses.
*' We therefor apply it here to Nr soil efficiency more generally.

i50_maccs_mitigation_transf(t,i) =
  1-(1-1/(1+(1-sm_snupe_base)*(1-im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct"))/(i50_nr_eff_bau("y2010",i)))) / (1-i50_nr_eff_bau("y2010",i));

i50_maccs_mitigation_pasture_transf(t,i) =
  1-(1-1/(1+(1-sm_nue_pasture_base)*(1-im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct"))/(i50_nr_eff_pasture_bau("y2010",i)))) / (1-i50_nr_eff_pasture_bau("y2010",i));

*' After transformation of the MACCs, we can calculate NUE_2 (vm_nr_eff) as the
*' result of a baseline NUE improvement and an MACC-driven further increase of NUE.
*' The nitrogen use efficiency is the inverse of the nitrogen loss share.
*' The loss share is estimated as a baseline loss share that describes the
*' baseline technological improvement of NUE, and a reduction of this loss
*' share by technical mitigation.
*' We assume that the MACCs reduce the remaining losses proportional, so that
*' emissions cannot become negative, and the baseline improvement reduces the
*' mitigation potential of the MACCs.

 vm_nr_eff.fx(i) = 1 - (1-i50_nr_eff_bau(t,i)) * (1 - i50_maccs_mitigation_transf(t,i));
 vm_nr_eff_pasture.fx(i)= 1 - (1-i50_nr_eff_pasture_bau(t,i)) * (1 - i50_maccs_mitigation_pasture_transf(t,i));

*' @stop

*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*###############################################################################
*######################## R SECTION START (SETS) ###############################
* THIS CODE IS CREATED AUTOMATICALLY, DO NOT MODIFY THESE LINES DIRECTLY
* ANY DIRECT MODIFICATION WILL BE LOST AFTER NEXT AUTOMATIC UPDATE!

sets

  scenBC63 biochar scenarios
    / R21M42-SDP-NDC,
      R21M42-SDP-NPi,
      R21M42-SDP-PkBudg1000,
      R21M42-SDP-PkBudg1100,
      R21M42-SDP-PkBudg900,
      R21M42-SSP1-NDC,
      R21M42-SSP1-NPi,
      R21M42-SSP1-PkBudg1100,
      R21M42-SSP1-PkBudg1300,
      R21M42-SSP1-PkBudg900,
      R21M42-SSP2-NDC,
      R21M42-SSP2-NPi,
      R21M42-SSP2-PkBudg1100,
      R21M42-SSP2-PkBudg1300,
      R21M42-SSP2-PkBudg900,
      R21M42-SSP5-NDC,
      R21M42-SSP5-NPi,
      R21M42-SSP5-PkBudg1100,
      R21M42-SSP5-PkBudg1300,
      R21M42-SSP5-PkBudg900,
      R2M41-SSP2-Budg1300,
      R2M41-SSP2-Budg600,
      R2M41-SSP2-Budg950,
      R2M41-SSP2-NDC,
      R2M41-SSP2-NPi,
      R32M46-SDP_MC-NDC,
      R32M46-SDP_MC-NPi,
      R32M46-SDP_MC-PkBudg650,
      R32M46-SSP1-NDC,
      R32M46-SSP1-NPi,
      R32M46-SSP1-PkBudg1050,
      R32M46-SSP1-PkBudg650,
      R32M46-SSP2EU-NDC,
      R32M46-SSP2EU-NPi,
      R32M46-SSP2EU-PkBudg1050,
      R32M46-SSP2EU-PkBudg650,
      R32M46-SSP5-NDC,
      R32M46-SSP5-NPi,
      R32M46-SSP5-PkBudg1050,
      R32M46-SSP5-PkBudg650,
      R34BC-SSP2-PkBudg650-BCdef,
      R34BC-SSP2-PkBudg650-BCdef-CTS01,
      R34BC-SSP2-PkBudg650-BCdef-CTS01-BM70,
      R34BC-SSP2-PkBudg650-BCpess-CTS01-BM70,
      R34M410-SSP1-NPi2025,
      R34M410-SSP1-PkBudg1000,
      R34M410-SSP1-PkBudg650,
      R34M410-SSP2_lowEn-NPi2025,
      R34M410-SSP2_lowEn-PkBudg1000,
      R34M410-SSP2_lowEn-PkBudg650,
      R34M410-SSP2-NPi2025,
      R34M410-SSP2-PkBudg1000,
      R34M410-SSP2-PkBudg650,
      R34M410-SSP3-NPi2025,
      R34M410-SSP3-PkBudg1000,
      R34M410-SSP3-rollBack,
      R34M410-SSP5-NPi2025,
      R34M410-SSP5-PkBudg1000,
      R34M410-SSP5-PkBudg650 /

;
*######################### R SECTION END (SETS) ################################
*###############################################################################

sets

   feedstock63 Available types of feedstock to produce biochar
       / residues,
         dedicated /

   type63 Types of biochar characterisation and efficincy of biomass-to-biochar conversion
       / dm_yield,
         en_yield,
         c_yield /

   biopyr_all63 Available pyrolysis plant set-ups including different co-products
       / kontiki,
         biopyrchp,
         biopyrelec,
         biopyrhe,
         biopyrliq,
         biopyronly,
         biopyronly400,
         biopyronly650,
         biopyronly800,
         biopyrfast500 /

   biopyr63(biopyr_all63) Selected pyrolysis plant set-ups including different co-products
       / kontiki,
         biopyrchp,
         biopyrelec,
         biopyrhe,
         biopyrliq,
         biopyronly /

   bc_sys63 Biochar production systems
      / SP-400, SP-500, SP-650, SP-800, FP-500, P-Woolf, P-KonTiki /

   sys_pyr(bc_sys63, biopyr_all63) Mapping of pyrolysis plant set-ups to biochar systems
       / SP-400        . (biopyronly400)
         SP-500        . (biopyrchp, biopyrelec, biopyrhe, biopyronly)
         SP-650        . (biopyronly650)
         SP-800        . (biopyronly800)
         FP-500        . (biopyrfast500)
         P-Woolf       . (biopyrliq)
         P-KonTiki     . (kontiki)
       /

   scenCost63 Variants to capture uncertainty range of biochar cost assumptions
       / low,
         central,
         high /
;

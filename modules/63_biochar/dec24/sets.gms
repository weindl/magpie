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
    / R2M41-SSP2-Budg600,R2M41-SSP2-Budg950,R2M41-SSP2-Budg1300,R2M41-SSP2-NDC,R2M41-SSP2-NPi,
      R32BC-SSP2-PB650-inclFuelWoolf,R32BC-SSP2-PB650-noFuel-CHP17
    /

* !!!!TODO: Ideas for biochar scenarios (for later)
*    / BC-SSP2-NPi-REMIND
*      BC-SSP2-26-REMIND,
*      BC-SSP2-19-REMIND
*    /

;
*######################### R SECTION END (SETS) ################################
*###############################################################################

sets

   feedstock63 Available types of feedstock to produce biochar
       / residues,
         dedicated /

   type63 Types of biochar characterisation and efficincy of biomass-to-biochar conversion
       / HC_ratio,
         dm_yield,
         en_yield,
         c_yield /

   biopyr_all63 Available pyrolysis plant set-ups including different co-products
       / KonTiki,
         biopyrCHP,
         biopyrElec,
         biopyrHeat,
         biopyrCHP850,
         biopyrBC400,
         biopyrBC500,
         biopyrFAST500,
         biopyrCofuelExp /

   biopyr63(biopyr_all63) Selected pyrolysis plant set-ups including different co-products
       / KonTiki,
         biopyrCHP,
         biopyrElec,
         biopyrHeat,
         biopyrCHP850 /

   bc_sys63 Biochar production systems
       / P_Kontiki, SP_400, SP_500, SP_650, SP_800, FP_500, Co_fuel /

   sys_pyr(bc_sys63, biopyr_all63) Mapping of pyrolysis plant set-ups to biochar systems
       / P_Kontiki   . (KonTiki)
         SP_400      . (biopyrBC400)
         SP_500      . (biopyrBC500)
         SP_650      . (biopyrCHP, biopyrElec, biopyrHeat)
         SP_800      . (biopyrCHP850)
         FP_500      . (biopyrFAST500)
         Co_fuel     . (biopyrCofuelExp)
       /

;

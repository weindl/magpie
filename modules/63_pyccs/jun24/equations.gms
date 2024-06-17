*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations


*' @code
*' Total biochar feedstock demand can be fulfilled by different types of biomass.
*' Biochar demand is differentiated regarding two broad categories of feedstock:
*' residues or dedicated bioenergy crops. Within those broad categories,
*' feedstock is assumed to be fully substitutable based on its energy content.

q63_biochar(i2,kall) ..
      vm_dem_biochar(i2,kall) * fm_attributes("ge",kall) =g=
      v63_2ndgen_biochar_dem_dedicated(i2,kall) +
      v63_2ndgen_biochar_dem_residues(i2,kall)
      ;

*' For biochar demand from dedicated bioenergy crops (`kbe63` = bioenergy
*' grasses and bioenergy trees), input is given either on regional or global
*' level (defined via switch $c63\_biochardem\_level$). This is reflected by
*' the following two equations from which always only one is active:
*' If $c63\_biochardem\_level$ is 1 (regional) the right hand side of the first equation
*' is set to 0, if it is 0 (global) the right hand side of the second equation
*' is set to 0.

q63_biochar_glo.. sum((kbe63,i2), v63_2ndgen_biochar_dem_dedicated(i2,kbe63))
                    =g= sum((ct,i2),i63_biochar_dem(ct,i2))*(1-c63_biochardem_level);

q63_biochar_reg(i2).. sum(kbe63, v63_2ndgen_biochar_dem_dedicated(i2,kbe63))
                    =g= sum(ct,i63_biochar_dem(ct,i2))*c63_biochardem_level;

*' Except the fact that in the first equation the biochar demand is summed up to
*' a global demand, both equations act the same way. They ensure that the sum of
*' biochar generated from different second generation bioenergy crops is greater
*' or equal to the demand actually given by the input file $i63\_biochar\_dem$.

*' In addition, there is demand for biochar $i63\_res\_2ndgenBC\_dem$ using
*' residues as feedstock, which is exogenously provided and calculated based on
*' assumptions on residue availability for biochar production: roughly 33% of
*' agricultural residues recycled on cropland can be used for other purposes
*' such as 2nd generation bioenergy and biochar production. The estimated
*' residue availability for such purposes depends on the SSP scenario, since
*' generation and use of residues is mainly driven by population and GDP.

q63_res_2ndgenBC(i2).. sum(kres, v63_2ndgen_biochar_dem_residues(i2,kres))
                    =g= sum(ct,i63_res_2ndgenBC_dem(ct,i2));

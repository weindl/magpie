*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  scen_countries63(iso) countries to be affected by biochar demand scenario
                    / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
                      ASM,ATA,ATF,ATG,AUS,AUT,AZE,BDI,BEL,BEN,
                      BES,BFA,BGD,BGR,BHR,BHS,BIH,BLM,BLR,BLZ,
                      BMU,BOL,BRA,BRB,BRN,BTN,BVT,BWA,CAF,CAN,
                      CCK,CHN,CHE,CHL,CIV,CMR,COD,COG,COK,COL,
                      COM,CPV,CRI,CUB,CUW,CXR,CYM,CYP,CZE,DEU,
                      DJI,DMA,DNK,DOM,DZA,ECU,EGY,ERI,ESH,ESP,
                      EST,ETH,FIN,FJI,FLK,FRA,FRO,FSM,GAB,GBR,
                      GEO,GGY,GHA,GIB,GIN,GLP,GMB,GNB,GNQ,GRC,
                      GRD,GRL,GTM,GUF,GUM,GUY,HKG,HMD,HND,HRV,
                      HTI,HUN,IDN,IMN,IND,IOT,IRL,IRN,IRQ,ISL,
                      ISR,ITA,JAM,JEY,JOR,JPN,KAZ,KEN,KGZ,KHM,
                      KIR,KNA,KOR,KWT,LAO,LBN,LBR,LBY,LCA,LIE,
                      LKA,LSO,LTU,LUX,LVA,MAC,MAF,MAR,MCO,MDA,
                      MDG,MDV,MEX,MHL,MKD,MLI,MLT,MMR,MNE,MNG,
                      MNP,MOZ,MRT,MSR,MTQ,MUS,MWI,MYS,MYT,NAM,
                      NCL,NER,NFK,NGA,NIC,NIU,NLD,NOR,NPL,NRU,
                      NZL,OMN,PAK,PAN,PCN,PER,PHL,PLW,PNG,POL,
                      PRI,PRK,PRT,PRY,PSE,PYF,QAT,REU,ROU,RUS,
                      RWA,SAU,SDN,SEN,SGP,SGS,SHN,SJM,SLB,SLE,
                      SLV,SMR,SOM,SPM,SRB,SSD,STP,SUR,SVK,SVN,
                      SWE,SWZ,SXM,SYC,SYR,TCA,TCD,TGO,THA,TJK,
                      TKL,TKM,TLS,TON,TTO,TUN,TUR,TUV,TWN,TZA,
                      UGA,UKR,UMI,URY,USA,UZB,VAT,VCT,VEN,VGB,
                      VIR,VNM,VUT,WLF,WSM,YEM,ZAF,ZMB,ZWE /
;

scalars
  c63_biochardem_level  Biochar demand level indicator 1 for regional and 0 for global demand   (1)   / 1 /
  s63_2ndgen_biochar_dem_min  Assumed minimum regional biochar demand from dedicated 2ndgen. bioenergy crops (mio. GJ per yr) / 1 /
;

$setglobal c63_2ndgen_biochardem  R32M46-SSP2EU-NPi
$setglobal c63_2ndgen_biochardem_noselect  R32M46-SSP2EU-NPi


$if "%c63_2ndgen_biochardem%" == "coupling" table f63_biochar_dem_coupling(t_all,i) Biochar demand from dedicated crops (regional) (mio. GJ per yr)
$if "%c63_2ndgen_biochardem%" == "coupling" $ondelim
$if "%c63_2ndgen_biochardem%" == "coupling" $include "./modules/63_pyccs/input/reg.2ndgen_biochar_demand.csv"
$if "%c63_2ndgen_biochardem%" == "coupling" $offdelim
$if "%c63_2ndgen_biochardem%" == "coupling" ;

$if "%c63_2ndgen_biochardem%" == "emulator" parameter f63_biochar_dem_emulator(t_all) Biochar demand from dedicated crops (global) (mio. GJ per yr)
$if "%c63_2ndgen_biochardem%" == "emulator" /
$if "%c63_2ndgen_biochardem%" == "emulator" $ondelim
$if "%c63_2ndgen_biochardem%" == "emulator" $include "./modules/63_pyccs/input/glo.2ndgen_biochar_demand.csv"
$if "%c63_2ndgen_biochardem%" == "emulator" $offdelim
$if "%c63_2ndgen_biochardem%" == "emulator" /
$if "%c63_2ndgen_biochardem%" == "emulator" ;

table f63_biochar_dem(t_all,i,scen2nd63) Annual biochar demand from dedicated crops (regional) (mio. GJ per yr)
$ondelim
$include "./modules/63_pyccs/input/f63_biochar_dem.cs3"
$offdelim
;

$setglobal c63_res_2ndgenBC_dem  ssp2
*   options:    ssp1,ssp2,ssp3,ssp4,ssp5,off

table f63_res_2ndgenBC_dem(t_all,i,scen2ndres63) Annual residue demand for biochar production (regional) (mio. GJ per yr)
$ondelim
$include "./modules/63_pyccs/input/f63_2ndgenBC_residue_dem.cs3"
$offdelim
;

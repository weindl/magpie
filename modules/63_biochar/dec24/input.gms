*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  scen_countries63(iso) countries to be affected by biochar production scenario
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
  s63_BC100  Fraction of biochar carbon remaining in the soil after 100 years   (1)   / 0.8 /
  s63_simulation_mode_mag  Biochar simulation mode (1 for "mag" and 0 for "rem-mag" simulation mode) / 0 /
  s63_biochar_min  Minimum biochar demand assumed in each region (mio. GJ per yr) / 0 /
;

$setglobal c63_biochar_simulation_mode  rem-mag
$setglobal c63_biochar_prod  none
$setglobal c63_biochar_prod_noselect  none

$if "%c63_biochar_prod%" == "coupling" table f63_biochar_prod_coupling(t_all,i,biopyr_all63) Annual biochar production (regional) (mio. GJ per yr)
$if "%c63_biochar_prod%" == "coupling" $ondelim
$if "%c63_biochar_prod%" == "coupling" $include "./modules/63_biochar/input/reg.biochar_production.csv"
$if "%c63_biochar_prod%" == "coupling" $offdelim
$if "%c63_biochar_prod%" == "coupling" ;

$if "%c63_biochar_prod%" == "emulator" parameter f63_biochar_prod_emulator(t_all,biopyr_all63) Annual biochar production (global) (mio. GJ per yr)
$if "%c63_biochar_prod%" == "emulator" /
$if "%c63_biochar_prod%" == "emulator" $ondelim
$if "%c63_biochar_prod%" == "emulator" $include "./modules/63_biochar/input/glo.biochar_production.csv"
$if "%c63_biochar_prod%" == "emulator" $offdelim
$if "%c63_biochar_prod%" == "emulator" /
$if "%c63_biochar_prod%" == "emulator" ;

table f63_biochar_prod(t_all,i,biopyr_all63,scenBC63) Annual biochar production on energy basis (regional) (mio. GJ per yr)
$ondelim
$include "./modules/63_biochar/input/f63_biochar_prod.cs3"
$offdelim
;

table f63_biochar_efficiency(type63,bc_sys63) HC_ratio and biochar yields expressed in terms of energy or mass or carbon (1)
$ondelim
$include "./modules/63_biochar/input/f63_biochar_efficiency.cs3"
$offdelim
;

table f63_biochar_attributes(attributes,bc_sys63) Conversion factors where X is Mt C or Mt DM or PJ lcv (X per Mt DM)
$ondelim
$include "./modules/63_biochar/input/f63_biochar_attributes.cs3"
$offdelim
;

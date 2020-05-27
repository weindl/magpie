
library(gdx)
library(magclass)
library(magpie)
library(lucode)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  title       <- "RCP1p9_SSP2_BIOD"
  outputdir       <- "output/n600/p10_p100/RCP1p9_SSP2_BIOD/"

  ###Define arguments that can be read from command line
  readArgs("sum_spam_file","outputdir","title")
}
gdx<-path(outputdir,"fulldata.gdx")

print("---")
print(paste0("Starting biodiv_report for ",title))
###############################################################################

load(path(outputdir,"config.Rdata"))

# BII = sum( (pixels p, land cover/use classes LU), area(LU,p) * BII(LU,p) * rr(LU,p) )
# / sum( (pixels p, land cover/use classes LU), area(LU,p) * rr(LU,p) )
# NB: after check there is little difference of including or not rr in the weighting
# BV = sum( (pixels p, land cover/use classes LU), area(LU,p) * BII(LU,p) * rr(LU,p) )
# / sum( (pixels p, land cover/use classes LU), area(LU,p) )

bv_stock <- function(gdx) {
  a <- readGDX(gdx,"ov44_biodiv",select = list(type="level"))#includes rr
  reg <- superAggregate(a,level="reg",aggr_type = "sum")
  glo <- superAggregate(a,level="glo",aggr_type = "sum")
  bv_stock <- mbind(reg,glo)
  getNames(bv_stock) <- paste0("Biodiversity|BVS|",getNames(bv_stock)," (million ha)")
  total <- dimSums(bv_stock,dim=3)
  getNames(total) <- "Biodiversity|BVS|Total (million ha)"
  bv_stock <- mbind(total,bv_stock)
  return(bv_stock)
}


bii <- function(gdx) {
  a <- readGDX(gdx,"ov44_biodiv",select = list(type="level"))#includes rr
  a <- dimSums(a,dim=3)
  rr <- readGDX(gdx,"f44_rr_layer")
  area <- land(gdx,level="cell",sum = TRUE)
  reg <- superAggregate(a,level="reg",aggr_type = "sum")/superAggregate(area*rr,level="reg",aggr_type = "sum")
  glo <- superAggregate(a,level="glo",aggr_type = "sum")/superAggregate(area*rr,level="glo",aggr_type = "sum")
  bii <- mbind(reg,glo)
  getNames(bii) <- "Biodiversity|BII (unitless)"
  return(bii)
}

bv <- function(gdx) {
  a <- readGDX(gdx,"ov44_biodiv",select = list(type="level"))#includes rr
  a <- dimSums(a,dim=3)
  reg <- superAggregate(a,level="reg",aggr_type = "sum")/land(gdx,level="reg",sum = TRUE)
  glo <- superAggregate(a,level="glo",aggr_type = "sum")/land(gdx,level="glo",sum = TRUE)
  bv <- mbind(reg,glo)
  getNames(bv) <- "Biodiversity|BV (unitless)"
  return(bv)
}

a <- NULL

#BII
print("BII")
b <- bii(gdx)
a <- mbind(a,b)

#BV
print("BV")
b <- bv(gdx)
a <- mbind(a,b)

#BVs
print("BVS")
b <- bv_stock(gdx)
a <- mbind(a,b)

write.report(a,file = path(outputdir,"report_biodiv.csv"),model = "MAgPIE",scen=title,ndigit = 4,skipempty = FALSE)

cat(paste0("\nFinished biodiv_report for ",title))
print("---")

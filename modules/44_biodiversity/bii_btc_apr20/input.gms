*** (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c44_price_biodiv_loss  p1_p1000

table f44_luh2_side_layers(j,luh2_side_layers44) bii side layers (grid cell share)
$ondelim
$include "./modules/44_biodiversity/bii_btc_apr20/input/luh2_side_layers.cs3"
$offdelim
;

table f44_bii_coeff(bii44,potforest44) bii coeff
$ondelim
$include "./modules/44_biodiversity/bii_btc_apr20/input/f44_bii_coeff.cs3"
$offdelim
;

table f44_price_biodiv_loss(t_all,price_biodiv44) price biodiv loss
$ondelim
$include "./modules/44_biodiversity/bii_btc_apr20/input/f44_price_biodiv_loss.csv"
$offdelim
;

parameters
f44_rr_layer(j) range rarity layer
/
$ondelim
$include "./modules/44_biodiversity/bii_btc_apr20/input/rr_layer.cs2"
$offdelim
/

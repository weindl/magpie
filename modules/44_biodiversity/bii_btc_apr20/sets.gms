*** (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

sets
	bii44 bii land cover types
	/ crop_ann, crop_per, manpast, rangeland, urban, primary, secd_mature, secd_young /

	luh2_side_layers44 side layers from LUH2
	/ manpast, rangeland, primveg, secdveg, forested, nonforested /

	potforest44(luh2_side_layers44) potentially forested biomes
	/ forested, nonforested /

	price_biodiv44	price paths biodiv loss
	/ p0,p1,p1_p10,p10,p10_p100,p1_p1000,p10_p10000 /

    crop_ann44(kcr) annual crops
    / tece, maiz, trce, rice_pro, rapeseed, sunflower, potato, cassav_sp, sugr_beet, others, cottn_pro, foddr, soybean, groundnut, puls_pro /

    crop_per44(kcr) perennial crops
    / oilpalm, begr, sugr_cane, betr /
;

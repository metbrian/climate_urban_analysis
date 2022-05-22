begin

nucurrent = addfile("nucurrentfallalld2avg.nc","r")
urbcurrent = addfile("urbancurrentfallalld2avg.nc","r")
nueoc = addfile("nueocfallalld2avg.nc","r")
urbeoc = addfile("urbaneocfallalld2avg.nc","r")

lat2d = nucurrent->lat
lon2d = nucurrent->lon

nucurrent_speed120 = nucurrent->avg_wspd120
nucurrent_speed10 = nucurrent->avg_wspd10
nucurrent_temp = nucurrent->avg_t2
nucurrent_temp = nucurrent_temp - 273.15
nucurrent_dewp = nucurrent->avg_td2
nucurrent_slp = nucurrent->avg_slp
nucurrent_pblh = nucurrent->avg_pblh

urbcurrent_speed120 = urbcurrent->avg_wspd120
urbcurrent_speed10 = urbcurrent->avg_wspd10
urbcurrent_temp = urbcurrent->avg_t2
urbcurrent_temp = urbcurrent_temp - 273.15
urbcurrent_dewp = urbcurrent->avg_td2
urbcurrent_slp = urbcurrent->avg_slp
urbcurrent_pblh = urbcurrent->avg_pblh

nueoc_speed120 = nueoc->avg_wspd120
nueoc_speed10 = nueoc->avg_wspd10
nueoc_temp = nueoc->avg_t2
nueoc_temp = nueoc_temp - 273.15
nueoc_dewp = nueoc->avg_td2
nueoc_slp = nueoc->avg_slp
nueoc_pblh = nueoc->avg_pblh

urbeoc_speed120 = urbeoc->avg_wspd120
urbeoc_speed10 = urbeoc->avg_wspd10
urbeoc_temp = urbeoc->avg_t2
urbeoc_temp = urbeoc_temp - 273.15
urbeoc_dewp = urbeoc->avg_td2
urbeoc_slp = urbeoc->avg_slp
urbeoc_pblh = urbeoc->avg_pblh


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  URBAN IMPACTS


speed120_diff = urbcurrent_speed120 - nucurrent_speed120
speed10_diff = urbcurrent_speed10 - nucurrent_speed10
temp_diff = urbcurrent_temp - nucurrent_temp
dewp_diff = urbcurrent_dewp - nucurrent_dewp
slp_diff = urbcurrent_slp - nucurrent_slp
pblh_diff = urbcurrent_pblh - nucurrent_pblh


wks = gsn_open_wks("png","fall_urb_wind_diff120")

;---Set some resources
  res                       = True
  res@tiMainString          = "Urban Impact on Fall 120-m Wind Speed"
  res@gsnLeftString         = "SSP5_HIST - HIST_HIST"
  res@gsnLeftStringFontHeightF = 0.02
  res@lbTitleOn             = True
  res@lbTitleString         = "Difference (m/s)"
  res@lbTitleFontHeightF    = .015
  res@pmLabelBarOrthogonalPosF = .12
  res@gsnMaximize           = True     ; maximize plot in frame

  res@cnFillOn              = True     ; turn on contour filli
  res@cnFillPalette         = "MPL_bwr"    ;set color options
  res@cnLinesOn             = False    ; turn off contour lines
  res@cnLineLabelsOn        = False    ; turn off contour line labels
  res@gsnAddCyclic          = False    ; don't add longitude cyclic point

  res@sfYArray              = lat2d    ; this will help NCL plot data
  res@sfXArray              = lon2d    ; correctly over the map

  res@mpMinLatF             = min(lat2d)   ; zoom in on lat/lon area
  res@mpMaxLatF             = max(lat2d)
  res@mpMinLonF             = min(lon2d)
  res@mpMaxLonF             = max(lon2d)
  res@mpCenterLonF          = (res@mpMinLonF + res@mpMaxLonF) / 2.

  res@cnLevelSelectionMode = "ManualLevels"        ; set manual contour levels
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.2                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
  res@mpDataBaseVersion     = "HighRes"    ; better map resolution
  res@mpOutlineBoundarySets = "USStates"
  res@pmTickMarkDisplayMode = "Always"       ; better looking tickmarks

plot = gsn_csm_contour_map(wks,speed120_diff,res)

wks = gsn_open_wks("png","fall_urb_wind_diff10")
  res                       = True
  res@tiMainString          = "Urban Impact on Fall 10-m Wind Speed"
  res@gsnLeftString         = "SSP5_HIST - HIST_HIST"
  res@lbTitleString         = "Difference (m/s)"
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.2                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed10_diff,res)


wks = gsn_open_wks("png","fall_urb_temp_diff")
  res                       = True
  res@tiMainString          = "Urban Impact on Fall 2-m Temperature"
  res@gsnLeftString         = "SSP5_HIST - HIST_HIST"
  res@lbTitleString         = "Difference (deg C)"
  res@cnMinLevelValF       =  -3.0                  ; set min contour level
  res@cnMaxLevelValF       =   3.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.5                  ; set contour spacing
  res@lbLabelStride         = 2                 ; show every 4th label
plot = gsn_csm_contour_map(wks,temp_diff,res)


wks = gsn_open_wks("png","fall_urb_slp_diff")
  res                       = True
  res@tiMainString          = "Urban Impact on Fall SLP"
  res@gsnLeftString         = "SSP5_HIST - HIST_HIST"
  res@lbTitleString         = "Difference (hPa)"
  res@cnMinLevelValF       =   -1.0                  ; set min contour level
  res@cnMaxLevelValF       =   1.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.1                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,slp_diff,res)

wks = gsn_open_wks("png","fall_urb_pblh_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "Urban Impact on Fall PBLH"
  res@gsnLeftString         = "SSP5_HIST - HIST_HIST"
  res@lbTitleString         = "Difference (m)"
  res@cnMinLevelValF       =   -400                  ; set min contour level
  res@cnMaxLevelValF       =   400                  ; set max contour level
  res@cnLevelSpacingF      =   50.0                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,pblh_diff,res)


wks = gsn_open_wks("png","fall_urb_dewp_diff")
;---Set some resources
  res                       = True
   res@cnFillPalette         = "MPL_BrBG"    ;set color options
  res@tiMainString          = "Urban Impact on Fall Dew Point"
  res@gsnLeftString         = "SSP5_HIST - HIST_HIST"
  res@lbTitleString         = "Difference (deg C)"
  res@cnMinLevelValF       =   -3.0                  ; set min contour level
  res@cnMaxLevelValF       =   3.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.5                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,dewp_diff,res)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CLIMATE IMPACTS


speed120_diff = nueoc_speed120 - nucurrent_speed120
speed10_diff = nueoc_speed10 - nucurrent_speed10
temp_diff = nueoc_temp - nucurrent_temp
dewp_diff = nueoc_dewp - nucurrent_dewp
slp_diff = nueoc_slp - nucurrent_slp
pblh_diff = nueoc_pblh - nucurrent_pblh


wks = gsn_open_wks("png","fall_clim_wind_diff120")

;---Set some resources
  res                       = True
  res@tiMainString          = "Climate Impacts on Fall 120-m Wind Speed"
  res@gsnLeftString         = "HIST_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (m/s)"
  res@cnFillPalette         = "MPL_bwr"    ;set color options
  res@cnLevelSelectionMode = "ManualLevels"        ; set manual contour levels
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.2                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed120_diff,res)


wks = gsn_open_wks("png","fall_clim_wind_diff10")
;---Set some resources
  res                       = True
  res@tiMainString          = "Climate Impact on Fall 10-m Wind Speed"
  res@gsnLeftString         = "HIST_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (m/s)"
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                 ; set max contour level
  res@cnLevelSpacingF      =   0.2                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed10_diff,res)


wks = gsn_open_wks("png","fall_clim_slp_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "Climate Impact on Fall SLP"
  res@gsnLeftString         = "HIST_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (hPa)"
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.1                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,slp_diff,res)

wks = gsn_open_wks("png","fall_clim_pblh_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "Climate Impact on Fall PBLH"
  res@gsnLeftString         = "HIST_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (m)"
  res@cnMinLevelValF       =   -400                  ; set min contour level
  res@cnMaxLevelValF       =   400                  ; set max contour level
  res@cnLevelSpacingF      =   50.0                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,pblh_diff,res)

wks = gsn_open_wks("png","fall_clim_dewp_diff")
;---Set some resources
  res                       = True
   res@cnFillPalette         = "MPL_YlGn"    ;set color options
  res@tiMainString          = "Climate Impact on Fall Dew Point"
  res@gsnLeftString         = "HIST_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (deg C)"
  res@cnMinLevelValF       =   2.0                  ; set min contour level
  res@cnMaxLevelValF       =   6.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.5                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,dewp_diff,res)

wks = gsn_open_wks("png","fall_clim_temp_diff")
;---Set some resources     
  res                       = True 
  res@cnFillPalette         = "MPL_Reds"    ;set color options                
  res@tiMainString          = "Climate Impact on Fall 2-m Temperature"
  res@gsnLeftString         = "HIST_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (deg C)"
  res@cnMinLevelValF       =   4.0                  ; set min contour level
  res@cnMaxLevelValF       =   8.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.5                  ; set contour spacing
  res@lbLabelStride         = 2                ; don't skip every other label
plot = gsn_csm_contour_map(wks,temp_diff,res)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    COMBINED IMPACTS

speed120_diff = urbeoc_speed120 - nucurrent_speed120
speed10_diff = urbeoc_speed10 - nucurrent_speed10
temp_diff = urbeoc_temp - nucurrent_temp
dewp_diff = urbeoc_dewp - nucurrent_dewp
slp_diff = urbeoc_slp - nucurrent_slp
pblh_diff = urbeoc_pblh - nucurrent_pblh
;u10_diff = urbeoc_u10 - nucurrent_u10

wks = gsn_open_wks("png","fall_both_wind_diff120")

;---Set some resources
  res                       = True
  res@tiMainString          = "Combined Impacts on Fall 120-m Wind Speed"
  res@gsnLeftString         = "SSP5_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (m/s)"
  res@cnFillPalette         = "MPL_bwr"    ;set color options
  res@cnLevelSelectionMode = "ManualLevels"        ; set manual contour levels
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.2                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed120_diff,res)


wks = gsn_open_wks("png","fall_both_wind_diff10")
;---Set some resources
  res                       = True
  res@tiMainString          = "Combined Impact on Fall 10-m Wind Speed"
  res@gsnLeftString         = "SSP5_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (m/s)"
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                 ; set max contour level
  res@cnLevelSpacingF      =   0.2                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed10_diff,res)


wks = gsn_open_wks("png","fall_both_slp_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "Combined Impact on Fall SLP"
  res@gsnLeftString         = "SSP5_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (hPa)"
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.1                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,slp_diff,res)

wks = gsn_open_wks("png","fall_both_pblh_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "Combined Impact on Fall PBLH"
  res@gsnLeftString         = "SSP5_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (m)"
  res@cnMinLevelValF       =   -400                  ; set min contour level
  res@cnMaxLevelValF       =   400                  ; set max contour level
  res@cnLevelSpacingF      =   50.0                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,pblh_diff,res)


wks = gsn_open_wks("png","fall_both_dewp_diff")
;---Set some resources
  res                       = True
   res@cnFillPalette         = "MPL_YlGn"    ;set color options
  res@tiMainString          = "Combined Impact on Fall Dew Point"
  res@gsnLeftString         = "SSP5_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (deg C)"
  res@cnMinLevelValF       =   2.0                  ; set min contour level
  res@cnMaxLevelValF       =   6.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.5                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,dewp_diff,res)

wks = gsn_open_wks("png","fall_both_temp_diff")
;---Set some resources
  res                       = True
  res@cnFillPalette         = "MPL_Reds"    ;set color options
  res@tiMainString          = "Combined Impact on Fall 2-m Temperature"
  res@gsnLeftString         = "SSP5_RCP8.5 - HIST_HIST"
  res@lbTitleString         = "Difference (deg C)"
  res@cnMinLevelValF       =   4.0                  ; set min contour level
  res@cnMaxLevelValF       =   8.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.5                  ; set contour spacing
  res@lbLabelStride         = 2                ; don't skip every other label
plot = gsn_csm_contour_map(wks,temp_diff,res)  



;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SSP5_RCP8.5 - HIST_RCP8.5

speed120_diff = (urbeoc_speed120 - nueoc_speed120) - (urbcurrent_speed120 - nucurrent_speed120)
speed10_diff = (urbeoc_speed10 - nueoc_speed10) - (urbcurrent_speed10 - nucurrent_speed10)
temp_diff = (urbeoc_temp - nueoc_temp) - (urbcurrent_temp - nucurrent_temp)
dewp_diff = (urbeoc_dewp - nueoc_dewp) - (urbcurrent_dewp - nucurrent_dewp)
slp_diff = (urbeoc_slp - nueoc_slp) - (urbcurrent_slp - nucurrent_slp)
pblh_diff = (urbeoc_pblh - nueoc_pblh) - (urbcurrent_pblh - nucurrent_pblh)
;u10_diff = (urbeoc_u10 - nueoc_u10) - (urbcurrent_u10 - nucurrent_u10)

wks = gsn_open_wks("png","fall_ind_wind_diff120")

;---Set some resources
  res                       = True
  res@tiMainString          = "Fall 120-m Wind Speed"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Difference (m/s)"
  res@cnFillPalette         = "MPL_bwr"    ;set color options
  res@cnLevelSelectionMode = "ManualLevels"        ; set manual contour levels
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                  ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed120_diff,res)


wks = gsn_open_wks("png","fall_ind_wind_diff10")
;---Set some resources
  res                       = True
  res@tiMainString          = "Fall 10-m Wind Speed"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Difference (m/s)"
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                 ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed10_diff,res)


wks = gsn_open_wks("png","fall_ind_slp_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "Fall Sea Level Pressure"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Difference (hPa)"
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                  ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,slp_diff,res)

wks = gsn_open_wks("png","fall_ind_pblh_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "Fall PBL Height"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Difference (m)"
  res@cnMinLevelValF       =   -200                  ; set min contour level
  res@cnMaxLevelValF       =   200                  ; set max contour level
  res@cnLevelSpacingF      =   25.0                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,pblh_diff,res)


wks = gsn_open_wks("png","fall_ind_dewp_diff")
;---Set some resources
  res                       = True
  ;res@cnFillPalette         = "MPL_YlGn"    ;set color options
  res@tiMainString          = "Fall Dew Point Temperature"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Difference (deg C)"
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.2                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,dewp_diff,res)

wks = gsn_open_wks("png","fall_ind_temp_diff")
;---Set some resources
  res                       = True
  ;res@cnFillPalette         = "MPL_Reds"    ;set color options
  res@tiMainString          = "Fall 2-m Temperature"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Difference (deg C)"
  res@cnMinLevelValF       =   -2.0                  ; set min contour level
  res@cnMaxLevelValF       =   2.0                  ; set max contour level
  res@cnLevelSpacingF      =   0.2                  ; set contour spacing
  res@lbLabelStride         = 2                ; don't skip every other label
plot = gsn_csm_contour_map(wks,temp_diff,res)



/;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; (Above difference / (SSP5_HIST - HIST_HIST)


speed120_diff = ((urbeoc_speed120 - nueoc_speed120) - (urbcurrent_speed120 - nucurrent_speed120)) / (urbcurrent_speed120 - nucurrent_speed120)
speed10_diff = ((urbeoc_speed10 - nueoc_speed10) - (urbcurrent_speed10 - nucurrent_speed10)) / (urbcurrent_speed10 - nucurrent_speed10)
temp_diff = ((urbeoc_temp - nueoc_temp) - (urbcurrent_temp - nucurrent_temp)) / (urbcurrent_temp - nucurrent_temp)
dewp_diff = ((urbeoc_dewp - nueoc_dewp) - (urbcurrent_dewp - nucurrent_dewp)) / (urbcurrent_dewp - nucurrent_dewp)
slp_diff = ((urbeoc_slp - nueoc_slp) - (urbcurrent_slp - nucurrent_slp)) / (urbcurrent_slp - nucurrent_slp)
pblh_diff = ((urbeoc_pblh - nueoc_pblh) - (urbcurrent_pblh - nucurrent_pblh)) / (urbcurrent_pblh - nucurrent_pblh)
;u10_diff = ((urbeoc_u10 - nueoc_u10) - (urbcurrent_u10 - nucurrent_u10)) / (urbcurrent_u10 - nucurrent_u10)


wks = gsn_open_wks("png","ratind_wind_diff120")

;---Set some resources
  res                       = True
  res@tiMainString          = "120-m Wind Speed"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST) / (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Ratio"
  res@cnFillPalette         = "MPL_bwr"    ;set color options
  res@cnLevelSelectionMode = "ManualLevels"        ; set manual contour levels
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                  ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed120_diff,res)


wks = gsn_open_wks("png","ratind_wind_diff10")
;---Set some resources
  res                       = True
  res@tiMainString          = "10-m Wind Speed"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST) / (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Ratio"
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                 ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,speed10_diff,res)


wks = gsn_open_wks("png","ratind_slp_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "Sea Level Pressure"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST) / (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Ratio"
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                  ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,slp_diff,res)

wks = gsn_open_wks("png","ratind_pblh_diff")
;---Set some resources
  res                       = True
  res@tiMainString          = "PBL Height"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST) / (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Ratio"
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                  ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,pblh_diff,res)


wks = gsn_open_wks("png","ratind_dewp_diff")
;---Set some resources
  res                       = True
  ;res@cnFillPalette         = "MPL_YlGn"    ;set color options
  res@tiMainString          = "Dew Point Temperature"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST) / (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Ratio"
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                  ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                 ; don't skip every other label
plot = gsn_csm_contour_map(wks,dewp_diff,res)

wks = gsn_open_wks("png","ratind_temp_diff")
;---Set some resources
  res                       = True
  ;res@cnFillPalette         = "MPL_Reds"    ;set color options
  res@tiMainString          = "2-m Temperature"
  res@gsnLeftString         = "(SSP5_RCP8.5 - HIST_RCP8.5) - (SSP5_HIST - HIST_HIST) / (SSP5_HIST - HIST_HIST)"
  res@lbTitleString         = "Ratio"
  res@cnMinLevelValF       =   -0.5                  ; set min contour level
  res@cnMaxLevelValF       =   0.5                  ; set max contour level
  res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 2                ; don't skip every other label
plot = gsn_csm_contour_map(wks,temp_diff,res)

;/

end

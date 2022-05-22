begin

type = "nu"
base1 = "geo_em.d02.nc"
list1 = (/type,base1/)

file_d1 = str_join(list1,"_")

a1 = addfile(file_d1,"r")
lat1 = a1->XLAT_C(0,:,:)
lon1 = a1->XLONG_C(0,:,:)

nu1_frac = a1->LANDUSEF(0,12,:,:)
nu1 = nu1_frac*100
nu1@description = ""

wks = gsn_open_wks("png","nu_urbfrac2")

;---Set some resources
  res                       = True
  res@tiMainString          = "MODIS 2001-2005 Urban Fraction"
  res@gsnMaximize           = True     ; maximize plot in frame
  res@FieldTitle           = ""
  res@cnFillOn              = True     ; turn on contour filli
  res@cnFillPalette         = "WhiteBlue"    ;set color options
  res@cnLinesOn             = False    ; turn off contour lines
  res@cnLineLabelsOn        = False    ; turn off contour line labels
  res@gsnAddCyclic          = False    ; don't add longitude cyclic point

  res@sfYArray              = lat1    ; this will help NCL plot data
  res@sfXArray              = lon1    ; correctly over the map

  res@mpMinLatF             = min(lat1)   ; zoom in on lat/lon area
  res@mpMaxLatF             = max(lat1)
  res@mpMinLonF             = min(lon1)
  res@mpMaxLonF             = max(lon1)
  res@mpCenterLonF          = (res@mpMinLonF + res@mpMaxLonF) / 2.

  res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
  res@cnLevels            = (/0, 20, 50, 80, 100/)
  ;res@cnLevelSelectionMode = "ManualLevels"        ; set manual contour levels
  ;res@cnMinLevelValF       =   0                  ; set min contour level
  ;res@cnMaxLevelValF       =   1                  ; set max contour level
  ;res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 1                ; don't skip every other label
  res@mpDataBaseVersion     = "HighRes"    ; better map resolution
  res@mpOutlineBoundarySets = "USStates"
  res@pmTickMarkDisplayMode = "Always"       ; better looking tickmarks

plot = gsn_csm_contour_map(wks,nu1,res)



type = "urban"
base1 = "geo_em.d02.nc"
list1 = (/type,base1/)

file_d1 = str_join(list1,"_")

a1 = addfile(file_d1,"r")
lat1 = a1->XLAT_C(0,:,:)
lon1 = a1->XLONG_C(0,:,:)

urb1_frac = a1->LANDUSEF(0,12,:,:)
urb1 = urb1_frac*100
urb1@description = ""

wks = gsn_open_wks("png","urban_urbfrac2")

;---Set some resources
  res                       = True
  res@tiMainString          = "SSP5 2100 Urban Fraction"
  res@gsnMaximize           = True     ; maximize plot in frame
  res@FieldTitle           = ""
  res@cnFillOn              = True     ; turn on contour filli
  res@cnFillPalette         = "WhiteBlue"    ;set color options
  res@cnLinesOn             = False    ; turn off contour lines
  res@cnLineLabelsOn        = False    ; turn off contour line labels
  res@gsnAddCyclic          = False    ; don't add longitude cyclic point

  res@sfYArray              = lat1    ; this will help NCL plot data
  res@sfXArray              = lon1    ; correctly over the map

  res@mpMinLatF             = min(lat1)   ; zoom in on lat/lon area
  res@mpMaxLatF             = max(lat1)
  res@mpMinLonF             = min(lon1)
  res@mpMaxLonF             = max(lon1)
  res@mpCenterLonF          = (res@mpMinLonF + res@mpMaxLonF) / 2.
  res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
  res@cnLevels            = (/0, 20, 50, 80, 100/)

 ; res@cnLevelSelectionMode = "ManualLevels"        ; set manual contour levels
 ; res@cnMinLevelValF       =   0                  ; set min contour level
  ;res@cnMaxLevelValF       =   1                  ; set max contour level
  ;res@cnLevelSpacingF      =   0.05                  ; set contour spacing
  res@lbLabelStride         = 1                 ; don't skip every other label
res@mpDataBaseVersion     = "HighRes"    ; better map resolution
  res@mpOutlineBoundarySets = "USStates"
  res@pmTickMarkDisplayMode = "Always"       ; better looking tickmarks

plot = gsn_csm_contour_map(wks,urb1,res)


diff = (urb1 - nu1)

wks = gsn_open_wks("png","urb_diff2")
;---Set some resources
  res                       = True
  res@tiMainString          = ""
  res@gsnMaximize           = True     ; maximize plot in frame

  res@cnFillOn              = True     ; turn on contour filli
  res@cnFillPalette         = "cmocean_matter"    ;set color options
  res@cnLinesOn             = False    ; turn off contour lines
  res@cnLineLabelsOn        = False    ; turn off contour line labels
  res@gsnAddCyclic          = False    ; don't add longitude cyclic point

  res@sfYArray              = lat1    ; this will help NCL plot data
  res@sfXArray              = lon1    ; correctly over the map

  res@mpMinLatF             = min(lat1)   ; zoom in on lat/lon area
  res@mpMaxLatF             = max(lat1)
  res@mpMinLonF             = min(lon1)
  res@mpMaxLonF             = max(lon1)
  res@mpCenterLonF          = (res@mpMinLonF + res@mpMaxLonF) / 2.

  res@cnLevelSelectionMode = "ManualLevels"        ; set manual contour levels
  ;res@cnMinLevelValF       =   0                  ; set min contour level
  ;res@cnMaxLevelValF       =   1                  ; set max contour level
  ;res@cnLevelSpacingF      =   0.2
                                                  
  res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
  res@cnLevels            = (/0, 20, 50, 80, 100/)


  res@lbLabelStride         = 1                 ; don't skip every other label
  res@mpDataBaseVersion     = "HighRes"    ; better map resolution
  res@mpOutlineBoundarySets = "USStates"
  res@pmTickMarkDisplayMode = "Always"       ; better looking tickmarks

plot = gsn_csm_contour_map(wks,diff,res)


end


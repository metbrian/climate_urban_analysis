begin

;define data location
base = "/glade/scratch/bfrei/runs/"
type = "urban"
time = "current"
domain = "2"
year = "2005"

;use this one to run a year at a time:
l = (/base, type, "/", time, "/wrf/output_files/", "wrfout_d0", domain, "_", year,"-*"/)
;use this one for testing:
;l = (/base, type, "/", time, "/wrf/output_files/", "wrfout_d0", domain, "_", year,"-01-01_*"/)

join = str_concat(l)

fili = systemfunc("ls " + join)
nfili = dimsizes(fili)



type1 = "nu"
base1 = "geo_em.d02.nc"
list1 = (/type1,base1/)
file_d1 = str_join(list1,"_")
a1 = addfile(file_d1,"r")
nu1 = a1->LANDUSEF(0,12,:,:)

type1 = "urban"
base1 = "geo_em.d02.nc"
list1 = (/type1,base1/)
file_d1 = str_join(list1,"_")
a1 = addfile(file_d1,"r")
urb1 = a1->LANDUSEF(0,12,:,:)

diff = urb1 - nu1

spd10_02 = new((/dimsizes(fili),110,130/),float)
spd10_25 = new((/dimsizes(fili),110,130/),float)
spd10_58 = new((/dimsizes(fili),110,130/),float)
spd10_810 = new((/dimsizes(fili),110,130/),float)

t2_02 =  new((/dimsizes(fili),110,130/),float)
t2_25 =  new((/dimsizes(fili),110,130/),float)
t2_58 =  new((/dimsizes(fili),110,130/),float)
t2_810 =  new((/dimsizes(fili),110,130/),float)

do nf=0,nfili-1

a = addfile(fili(nf),"r")

it = 0
u10 = a->U10
v10 = a->V10
spd10 = wind_speed(u10, v10)
t2 = a->T2

both = new((/3,110,130/),float)

both(0,:,:) = diff
both(1,:,:) = spd10
both(2,:,:) = t2

s02 = where(both(0,:,:) .le. 0.2 .and. both(0,:,:) .gt. 0.0, both(1,:,:), both@_FillValue)
s25 = where(both(0,:,:) .le. 0.5 .and. both(0,:,:) .gt. 0.2, both(1,:,:), both@_FillValue)
s58 = where(both(0,:,:) .le. 0.8 .and. both(0,:,:) .gt. 0.5, both(1,:,:), both@_FillValue)
s810 =  where(both(0,:,:) .le. 1.0 .and. both(0,:,:) .gt. 0.8, both(1,:,:), both@_FillValue)

t02 = where(both(0,:,:) .le. 0.2 .and. both(0,:,:) .gt. 0.0, both(2,:,:), both@_FillValue)
t25 = where(both(0,:,:) .le. 0.5 .and. both(0,:,:) .gt. 0.2, both(2,:,:), both@_FillValue)
t58 = where(both(0,:,:) .le. 0.8 .and. both(0,:,:) .gt. 0.5, both(2,:,:), both@_FillValue)
t810 = where(both(0,:,:) .le. 1.0 .and. both(0,:,:) .gt. 0.8, both(2,:,:), both@_FillValue)

spd10_02(nf,:,:) = s02
spd10_25(nf,:,:) = s25
spd10_58(nf,:,:) = s58
spd10_810(nf,:,:) = s810

t2_02(nf,:,:) = t02
t2_25(nf,:,:) = t25
t2_58(nf,:,:) = t58
t2_810(nf,:,:) = t810

end do

;average each grid cell:
gridav_spd10_02 = dim_avg_n(spd10_02,0)
gridav_spd10_25 = dim_avg_n(spd10_25,0)
gridav_spd10_58 = dim_avg_n(spd10_58,0)
gridav_spd10_810 = dim_avg_n(spd10_810,0)

gridav_t2_02 = dim_avg_n(t2_02,0)
gridav_t2_25 = dim_avg_n(t2_25,0)
gridav_t2_58 = dim_avg_n(t2_58,0)
gridav_t2_810 = dim_avg_n(t2_810,0)


;;;;;;Write out netcdf file with gridded averages:
setfileoption("nc","Format","NetCDF4Classic")
l2 = (/type, year, "d", domain, "slice.nc"/)
name = str_concat(l2)
system("rm -rf " + name)
output = addfile(name,"c")

lat = a->XLAT(0,:,:)
lon = a->XLONG(0,:,:)

output->lat = lat
output->lon = lon
output->avg_spd10_02 = gridav_spd10_02
output->avg_spd10_25 = gridav_spd10_25
output->avg_spd10_58 = gridav_spd10_58
output->avg_spd10_810 = gridav_spd10_810
output->avg_t2_02 = gridav_t2_02
output->avg_t2_25 = gridav_t2_25
output->avg_t2_58 = gridav_t2_58
output->avg_t2_810 = gridav_t2_810

;;;;;;;;;;Calculate and write out total averages to .txt file:
totalav_spd10_02 = avg(gridav_spd10_02)
totalav_spd10_25 = avg(gridav_spd10_25)
totalav_spd10_58 = avg(gridav_spd10_58)
totalav_spd10_810 = avg(gridav_spd10_810)

totalav_t2_02 = avg(gridav_t2_02)
totalav_t2_25 = avg(gridav_t2_25)
totalav_t2_58 = avg(gridav_t2_58)
totalav_t2_810 = avg(gridav_t2_810)

l3 = (/type, year, "d", domain, "spd10slicetotalav.txt"/)
name = str_concat(l3)
system("rm -rf " + name)

titles = (/"0-0.2 ","0.2-0.5 ","0.5-0.8 ","0.8-1.0 "/)
titles@attr = "string array"
spd_averages = (/totalav_spd10_02,totalav_spd10_25,totalav_spd10_58,totalav_spd10_810/)
spd_averages@attr = "float array"

combined = [/titles+spd_averages/]

write_table(name,"w",combined,"%s")

l4 = (/type, year, "d", domain, "t2slicetotalav.txt"/)
name = str_concat(l4)
system("rm -rf " + name)

titles = (/"0-0.2 ","0.2-0.5 ","0.5-0.8 ","0.8-1.0 "/)
titles@attr = "string array"
t2_averages = (/totalav_t2_02,totalav_t2_25,totalav_t2_58,totalav_t2_810/)
t2_averages@attr = "float array"

combined = [/titles+t2_averages/]

write_table(name,"w",combined,"%s")


end


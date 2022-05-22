begin


;define data location
base = "/glade/scratch/bfrei/runs/"
type = "nu"
time = "current"
season = "fall"
domain = "2"
period = "all"

;;;;;;Load in csv file with filenames created by  sl2.py and use for fili
list1 = (/"../../", type, time, season, period, domain, "list.csv"/)
listcat = str_concat(list1)

fili = asciiread(listcat, -1, "string")

nfili = dimsizes(fili)



if (domain .eq. "2")
  temp = new((/dimsizes(fili),110,130/),float)
  speed = new((/dimsizes(fili),110,130/),float)
  speed_10 = new((/dimsizes(fili),110,130/),float)
  dewp  = new((/dimsizes(fili),110,130/),float)
  pres = new((/dimsizes(fili),110,130/),float)
  pbl_height = new((/dimsizes(fili),110,130/),float)
  u_10 = new((/dimsizes(fili),110,130/),float)
elseif (domain .eq. "1")
  temp = new((/dimsizes(fili),100,100/),float)
  speed = new((/dimsizes(fili),100,100/),float)
  speed_10 = new((/dimsizes(fili),100,100/),float)
  dewp  = new((/dimsizes(fili),100,100/),float)
  pres = new((/dimsizes(fili),100,100/),float)
  pbl_height = new((/dimsizes(fili),100,100/),float)
  u_10 = new((/dimsizes(fili),100,100/),float)  
else
  print("you messed up bud")	
end if


x = new(dimsizes(fili),integer)
; Main do loop that cycles through each of the files of the directory you are running in

do nf=0,nfili-1
a = addfile(fili(nf),"r")

it = 0
t2 = a->T2(0,:,:)                                ; 2-meter temp
td2 = wrf_user_getvar(a,"td2",it)                ; 2-meter dew point temp
spd_dir = wrf_user_getvar(a,"wspd_wdir",it)      ; grid-relative wind speed
;spd_dir_10 = wrf_user_getvar(a,"wspd_wdir10",it) ; " " 10-m wind speed
u10 = a->U10
v10 = a->V10
spd10 = wind_speed(u10, v10)
slp = wrf_user_getvar(a,"slp",it)                ; slp (mb)
z = wrf_user_getvar(a,"height_agl",it)
pblh = a->PBLH

;need extra dimension in spd because the it's wspd_wdir and the 0th dimension is speed
  spd = spd_dir(0,:,:,:)
 ; spd10 = spd_dir_10(0,:,:)

  ;interpolate wind speed to 120-m:
  spd1 = wrf_user_intrp3d(spd,z,"h",120.,0.,False)

;---Change the metadata
  ;t2@description = "Surface Temperature"

temp(nf,:,:) = t2
speed(nf,:,:) = spd1
speed_10(nf,:,:) = spd10
dewp(nf,:,:) = td2
pres(nf,:,:) = slp
pbl_height(nf,:,:) = pblh
u_10(nf,:,:) = u10

end do

temp_over = where(temp .gt. 308.15, 1, 0)
wind_over = where(speed .gt. 10.59, 1, 0) 
frac_temp_over = dim_avg_n(temp_over,0)
frac_wind_over = dim_avg_n(wind_over,0)

;average temp and speed over the time dimension
avg_temp = dim_avg_n(temp,0)
avg_speed = dim_avg_n(speed,0)
avg_dewp = dim_avg_n(dewp,0)
avg_pres = dim_avg_n(pres,0)
avg_speed_10 = dim_avg_n(speed_10,0)
avg_pblh = dim_avg_n(pbl_height,0)
avg_u10 = dim_avg_n(u_10,0)

setfileoption("nc","Format","NetCDF4Classic")
l2 = (/type, time, season, period, "d", domain, "avg.nc"/)
name = str_concat(l2)
system("rm -rf " + name)
output = addfile(name,"c")

lat = a->XLAT(0,:,:)
lon = a->XLONG(0,:,:)

output->lat = lat
output->lon = lon
output->avg_wspd120 = avg_speed
output->avg_t2 = avg_temp
output->avg_td2 = avg_dewp
output->avg_slp = avg_pres
output->avg_wspd10 = avg_speed_10
output->avg_pblh = avg_pblh
output->avg_u10 = avg_u10
output->frac_temp_over = frac_temp_over
output->frac_wind_over = frac_wind_over

end

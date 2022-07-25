begin


;define data location
base = "/glade/scratch/bfrei/runs/"
type = "urban"
time = "current"
domain = "2"
year = "2005"
l = (/base, type, "/", time, "/wrf/output_files/", "/wrfout_d0", domain, "_", year,"-*"/)
join = str_concat(l)

fili = systemfunc("ls " + join)
nfili = dimsizes(fili)



if (domain .eq. "2")
  temp = new((/dimsizes(fili),110,130/),float)
  speed = new((/dimsizes(fili),110,130/),float)
  speed_10 = new((/dimsizes(fili),110,130/),float)
  dewp  = new((/dimsizes(fili),110,130/),float)
  pres = new((/dimsizes(fili),110,130/),float)
  pbl_height = new((/dimsizes(fili),110,130/),float)
elseif (domain .eq. "1")
  temp = new((/dimsizes(fili),100,100/),float)
  speed = new((/dimsizes(fili),100,100/),float)
  speed_10 = new((/dimsizes(fili),100,100/),float)
  dewp  = new((/dimsizes(fili),100,100/),float)
  pres = new((/dimsizes(fili),100,100/),float)
  pbl_height = new((/dimsizes(fili),100,100/),float)  
else
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
end do


;average temp and speed over the time dimension
avg_temp = dim_avg_n(temp,0)
avg_speed = dim_avg_n(speed,0)
avg_dewp = dim_avg_n(dewp,0)
avg_pres = dim_avg_n(pres,0)
avg_speed_10 = dim_avg_n(speed_10,0)
avg_pblh = dim_avg_n(pbl_height,0)

setfileoption("nc","Format","NetCDF4Classic")
l2 = (/type, year, "d", domain, "avg.nc"/)
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

end

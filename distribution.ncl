begin

;define data location
base = "/glade/scratch/bfrei/runs/"
type = "urban"
time = "current"
domain = "2"
year = "2005"
l = (/base, type, "/", time, "/wrf/output_files/", "/wrfout_d0", domain, "_", year,"-*"/)  ;use this when done editing

;l = (/base, type, "/", time, "/wrf/output_files/", "/wrfout_d0", domain, "_*"/) 
;l = (/base, type, "/", time, "/wrf/output_files/", "/wrfout_d0", domain, "_", year,"-01-*"/)
join = str_concat(l)

fili = systemfunc("ls " + join)
nfili = dimsizes(fili)

ocean = new((/dimsizes(fili)/),float)
land = new((/dimsizes(fili)/),float)
everything = new((/dimsizes(fili)/),float)


b1 = 0
b2 = 0
b3 = 0
b4 = 0
b5 = 0
b6 = 0
b7 = 0
b8 = 0
b9 = 0
b10 = 0
b11 = 0
b12 = 0
b13 = 0
b14 = 0
b15 = 0
b16 = 0
b17 = 0
b18 = 0
b19 = 0
b20 = 0
b21 = 0
b22 = 0
b23 = 0
b24 = 0
b25 = 0

do nf=0,nfili-1
a = addfile(fili(nf),"r")

both = new((/2,110,130/),float)
it = 0
spd_dir = wrf_user_getvar(a,"wspd_wdir",it)
z = wrf_user_getvar(a,"height_agl",it)
landmask_0 = a->LANDMASK
landmask = landmask_0(0,:,:)  ; get landmask into same shape as spd1
;need extra dimension in spd because the it's wspd_wdir and the 0th dimension is speed
spd = spd_dir(0,:,:,:)
spd1 = wrf_user_intrp3d(spd,z,"h",120.,0.,False)

both = new((/2,110,130/),float)
both(0,:,:) = landmask
both(1,:,:) = spd1

total_oceanspd120 = where(both(0,:,:) .eq. 0, both(1,:,:),both@_FillValue)
total_landspd120 = where(both(0,:,:) .eq. 1, both(1,:,:),both@_FillValue)


b1 = b1 + num(total_oceanspd120(:,:) .lt. 1.0 .and. total_oceanspd120(:,:) .ge.0.0)
b2 = b2 + num(total_oceanspd120(:,:) .lt. 2.0 .and. total_oceanspd120(:,:) .ge. 1.0)
b3 = b3 + num(total_oceanspd120(:,:) .lt. 3.0 .and. total_oceanspd120(:,:) .ge. 2.0)
b4 = b4 + num(total_oceanspd120(:,:) .lt. 4.0 .and. total_oceanspd120(:,:) .ge. 3.0)
b5 = b5 + num(total_oceanspd120(:,:) .lt. 5.0 .and. total_oceanspd120(:,:) .ge. 4.0)
b6 = b6 + num(total_oceanspd120(:,:) .lt. 6.0 .and. total_oceanspd120(:,:) .ge. 5.0)
b7 = b7 + num(total_oceanspd120(:,:) .lt. 7.0 .and. total_oceanspd120(:,:) .ge. 6.0)
b8 = b8 + num(total_oceanspd120(:,:) .lt. 8.0 .and. total_oceanspd120(:,:) .ge. 7.0)
b9 = b9 + num(total_oceanspd120(:,:) .lt. 9.0 .and. total_oceanspd120(:,:) .ge. 8.0)
b10 = b10 + num(total_oceanspd120(:,:) .lt. 10.0 .and. total_oceanspd120(:,:) .ge. 9.0)
b11 = b11 + num(total_oceanspd120(:,:) .lt. 11.0 .and. total_oceanspd120(:,:) .ge. 10.0)
b12 = b12 + num(total_oceanspd120(:,:) .lt. 12.0 .and. total_oceanspd120(:,:) .ge. 11.0)
b13 = b13 + num(total_oceanspd120(:,:) .lt. 13.0 .and. total_oceanspd120(:,:) .ge. 12.0)
b14 = b14 + num(total_oceanspd120(:,:) .lt. 14.0 .and. total_oceanspd120(:,:) .ge. 13.0)
b15 = b15 + num(total_oceanspd120(:,:) .lt. 15.0 .and. total_oceanspd120(:,:) .ge. 14.0)
b16 = b16 + num(total_oceanspd120(:,:) .lt. 16.0 .and. total_oceanspd120(:,:) .ge. 15.0)
b17 = b17 + num(total_oceanspd120(:,:) .lt. 17.0 .and. total_oceanspd120(:,:) .ge. 16.0)
b18 = b18 + num(total_oceanspd120(:,:) .lt. 18.0 .and. total_oceanspd120(:,:) .ge. 17.0)
b19 = b19 + num(total_oceanspd120(:,:) .lt. 19.0 .and. total_oceanspd120(:,:) .ge. 18.0)
b20 = b20 + num(total_oceanspd120(:,:) .lt. 20.0 .and. total_oceanspd120(:,:) .ge. 19.0)
b21 = b21 + num(total_oceanspd120(:,:) .lt. 21.0 .and. total_oceanspd120(:,:) .ge. 20.0)
b22 = b22 + num(total_oceanspd120(:,:) .lt. 22.0 .and. total_oceanspd120(:,:) .ge. 21.0)
b23 = b23 + num(total_oceanspd120(:,:) .lt. 23.0 .and. total_oceanspd120(:,:) .ge. 22.0)
b24 = b24 + num(total_oceanspd120(:,:) .lt. 24.0 .and. total_oceanspd120(:,:) .ge. 23.0)
b25 = b25 + num(total_oceanspd120(:,:) .lt. 25.0 .and. total_oceanspd120(:,:) .ge. 24.0)

ocean(nf) = avg(total_oceanspd120)
land(nf) = avg(total_landspd120)
everything(nf) = avg(both(1,:,:))

end do

total = tofloat(b1+b2+b3+b4+b5+b6+b7+b8+b9+b10+b11+b12+b13+b14+b15+b16+b17+b18+b19+b20+b21+b22+b23+b24+b25)
dist_int = (/b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25/)
dist_float = tofloat(dist_int)
dist = dist_float / total

l2 = (/type, year, "d", domain, "dist.txt"/)
;l2 = (/type, "d", domain, "dist.txt"/)

name2 = str_concat(l2)
system("rm -rf " + name2)

bins = [/0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24/]
dist_list = [/dist/]

write_table(name2,"w",dist_list,"%f")

avg_landspd120 = avg(land)
avg_oceanspd120 = avg(ocean)
avg_spd120 = avg(everything)

titles = (/"land  ","ocean  ","all  "/)
titles@attr = "string array"
values = (/avg_landspd120,avg_oceanspd120,avg_spd120/)
values@attr = "float array"

averages_2 = [/titles+values/]

;l3 = (/type, "d", domain, "averages.txt"/)

l3 = (/type, year, "d", domain, "averages.txt"/)
name3 = str_concat(l3)
system("rm -rf " + name3)

write_table(name3,"w",averages_2,"%s")

end


begin

;;;;;;File to take the average files for each year of simulations and average them together

type = "nu"
domain = "2"

l1 = (/type, "2005d", domain, "avg.nc"/)
l2 = (/type, "2006d", domain, "avg.nc"/)
l3 = (/type, "2007d", domain, "avg.nc"/)
l4 = (/type, "2008d", domain, "avg.nc"/)
l5 = (/type, "2009d", domain, "avg.nc"/)
l6 = (/type, "2010d", domain, "avg.nc"/)
l7 = (/type, "2011d", domain, "avg.nc"/)
l8 = (/type, "2012d", domain, "avg.nc"/)
l9 = (/type, "2013d", domain, "avg.nc"/)
l10 = (/type, "2014d", domain, "avg.nc"/)

f1 = str_concat(l1)
f2 = str_concat(l2)
f3 = str_concat(l3)
f4 = str_concat(l4)
f5 = str_concat(l5)
f6 = str_concat(l6)
f7 = str_concat(l7)
f8 = str_concat(l8)
f9 = str_concat(l9)
f10 = str_concat(l10)

f2005 = addfile(f1,"r")
f2006 = addfile(f2,"r")
f2007 = addfile(f3,"r")
f2008 = addfile(f4,"r")
f2009 = addfile(f5,"r")
f2010 = addfile(f6,"r")
f2011 = addfile(f7,"r")
f2012 = addfile(f8,"r")
f2013 = addfile(f9,"r")
f2014 = addfile(f10,"r")



/;
f2005 = addfile("nu2005d2avg.nc","r")
f2006 = addfile("nu2006d2avg.nc","r")
f2007 = addfile("nu2007d2avg.nc","r")
f2008 = addfile("nu2008d2avg.nc","r")
f2009 = addfile("nu2009d2avg.nc","r")
f2010 = addfile("nu2010d2avg.nc","r")
f2011 = addfile("nu2011d2avg.nc","r")
f2012 = addfile("nu2012d2avg.nc","r")
f2013 = addfile("nu2013d2avg.nc","r")
f2014 = addfile("nu2014d2avg.nc","r")
;/

lat = f2005->lat
lon = f2005->lon

spd10_2005 = f2005->avg_wspd10
spd120_2005 = f2005->avg_wspd120
t2_2005 = f2005->avg_t2
td2_2005 = f2005->avg_td2
slp_2005 = f2005->avg_slp
pblh_2005 = f2005->avg_pblh

spd10_2006 = f2006->avg_wspd10
spd120_2006 = f2006->avg_wspd120
t2_2006 = f2006->avg_t2
td2_2006 = f2006->avg_td2
slp_2006 = f2006->avg_slp
pblh_2006 = f2006->avg_pblh

spd10_2007 = f2007->avg_wspd10
spd120_2007 = f2007->avg_wspd120
t2_2007 = f2007->avg_t2
td2_2007 = f2007->avg_td2
slp_2007 = f2007->avg_slp
pblh_2007 = f2007->avg_pblh

spd10_2008 = f2008->avg_wspd10
spd120_2008 = f2008->avg_wspd120
t2_2008 = f2008->avg_t2
td2_2008 = f2008->avg_td2
slp_2008 = f2008->avg_slp
pblh_2008 = f2008->avg_pblh

spd10_2009 = f2009->avg_wspd10
spd120_2009 = f2009->avg_wspd120
t2_2009 = f2009->avg_t2
td2_2009 = f2009->avg_td2
slp_2009 = f2009->avg_slp
pblh_2009 = f2009->avg_pblh

spd10_2010 = f2010->avg_wspd10
spd120_2010 = f2010->avg_wspd120
t2_2010 = f2010->avg_t2
td2_2010 = f2010->avg_td2
slp_2010 = f2010->avg_slp
pblh_2010 = f2010->avg_pblh

spd10_2011 = f2011->avg_wspd10
spd120_2011 = f2011->avg_wspd120
t2_2011 = f2011->avg_t2
td2_2011 = f2011->avg_td2
slp_2011 = f2011->avg_slp
pblh_2011 = f2011->avg_pblh

spd10_2012 = f2012->avg_wspd10
spd120_2012 = f2012->avg_wspd120
t2_2012 = f2012->avg_t2
td2_2012 = f2012->avg_td2
slp_2012 = f2012->avg_slp
pblh_2012 = f2012->avg_pblh

spd10_2013 = f2013->avg_wspd10
spd120_2013 = f2013->avg_wspd120
t2_2013 = f2013->avg_t2
td2_2013 = f2013->avg_td2
slp_2013 = f2013->avg_slp
pblh_2013 = f2013->avg_pblh

spd10_2014 = f2014->avg_wspd10
spd120_2014 = f2014->avg_wspd120
t2_2014 = f2014->avg_t2
td2_2014 = f2014->avg_td2
slp_2014 = f2014->avg_slp
pblh_2014 = f2014->avg_pblh


spd10 = (spd10_2005 + spd10_2006 + spd10_2007 + spd10_2008 + spd10_2009 + spd10_2010 + spd10_2011 + spd10_2012 + spd10_2013 + spd10_2014) / 10.0
spd120 = (spd120_2005 + spd120_2006 + spd120_2007 + spd120_2008 + spd120_2009 + spd120_2010 + spd120_2011 + spd120_2012 + spd120_2013 + spd120_2014) / 10.0
t2 = (t2_2005 + t2_2006 + t2_2007 + t2_2008 + t2_2009 + t2_2010 + t2_2011 + t2_2012 + t2_2013 + t2_2014) / 10.0
td2 = (td2_2005 + td2_2006 + td2_2007 + td2_2008 + td2_2009 + td2_2010 + td2_2011 + td2_2012 + td2_2013 + td2_2014) / 10.0
slp = (slp_2005 + slp_2006 + slp_2007 + slp_2008 + slp_2009 + slp_2010 + slp_2011 + slp_2012 + slp_2013 + slp_2014) / 10.0
pblh = (pblh_2005 + pblh_2006 + pblh_2007 + pblh_2008 + pblh_2009 + pblh_2010 + pblh_2011 + pblh_2012 + pblh_2013 + pblh_2014) / 10.0

setfileoption("nc","Format","NetCDF4Classic")
l1 = (/type, "currentd", domain, "avg.nc"/)
name = str_concat(l1)
system("rm -rf " + name)

output = addfile(name,"c")

output->lat = lat
output->lon = lon
output->avg_wspd10 = spd10
output->avg_wspd120 = spd120
output->avg_t2 = t2
output->avg_td2 = td2
output->avg_slp = slp
output->avg_pblh = pblh

end

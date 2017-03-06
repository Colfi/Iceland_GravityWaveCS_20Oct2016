load "/usr/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/lib/ncarg/nclscripts/csm/contributed.ncl"
load "/usr/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
nshort = ("core_faam_20161020_v004_r0_b988.nc")
path =("/panfs/jasmin-north/earic/nobackup/wrf/data_flights/b988-oct-20/")
data=addfile(path+nshort,"r")
tempobs=data->LWC_JW_U
pobs=data->P9_STAT
;run start, end and altitude for Oct 20th b988 
;09:14:12 to 09:23:45 @ 9.6 kft
;09:28:04 to 09:42:04 @ 14 kft
;09:50:12 to 09:52:56 @ 2.7 kft
;09:58:52 to 10:13:58 @ 15.1 kft
;10:17:59 to 10:24:31 @ 6.5 kft
;10:33:42 to 10:39:01 @ 5.3 kft
;10:41:35 to 10:43:52 @ 2.3 kft
;10:48:30 to 11:00:37 @ 12.1 kft
;*****************************************************
; Create vectors with run starts and ends 
;*****************************************************
ths=(/9,9,9,9,10,10,10,10/)
the=(/9,9,9,10,10,10,10,11/)
mins=(/14,28,50,58,17,33,41,48/)
mine=(/23,42,52,13,24,39,43,0/)
secondss=(/12,04,12,52,59,42,35,30/)
secondse=(/45,4,56,58,31,1,52,37/)
nrsec=60
nrmin=60
rs=ths*nrsec*nrmin+mins*nrsec+secondss
re=the*nrsec*nrmin+mine*nrsec+secondse
duration = re-rs
time = data->Time 
lat  = data->LAT_GIN
time@units = "seconds since 2016-10-20 00:00:00 +0000"
hz = 0 
;*******************************************************
; extract data for each run using the time vectors above 
;*******************************************************
; for temperature 
run1=tempobs({rs(0)-1:re(0)-1},hz)
run2=tempobs({rs(1)-1:re(1)-1},hz)
run3=tempobs({rs(2)-1:re(2)-1},hz)
run4=tempobs({rs(3)-1:re(3)-1},hz)
run5=tempobs({rs(4)-1:re(4)-1},hz)
run6=tempobs({rs(5)-1:re(5)-1},hz)
run7=tempobs({rs(6)-1:re(6)-1},hz)
run8=tempobs({rs(7)-1:re(7)-1},hz)
;for pressure 
run1p=pobs({rs(0)-1:re(0)-1},hz)
run2p=pobs({rs(1)-1:re(1)-1},hz)
run3p=pobs({rs(2)-1:re(2)-1},hz)
run4p=pobs({rs(3)-1:re(3)-1},hz)
run5p=pobs({rs(4)-1:re(4)-1},hz)
run6p=pobs({rs(5)-1:re(5)-1},hz)
run7p=pobs({rs(6)-1:re(6)-1},hz)
run8p=pobs({rs(7)-1:re(7)-1},hz)
;******************************************************
; calculate potential temperature *********************
;******************************************************
p0=1000
theta1 = run1*((p0/run1p)^(0.286))
theta2 = run2*((p0/run2p)^(0.286))
theta3 = run3*((p0/run3p)^(0.286))  
theta4 = run4*((p0/run4p)^(0.286))
theta5 = run5*((p0/run5p)^(0.286))
theta6 = run6*((p0/run6p)^(0.286))
theta7 = run7*((p0/run7p)^(0.286))
theta8 = run8*((p0/run8p)^(0.286))
;*******************************************************
; extract associated latitudes for each run 
;*******************************************************
lat1=lat({rs(0)-1:re(0)-1},hz)
lat2=lat({rs(1)-1:re(1)-1},hz)
lat3=lat({rs(2)-1:re(2)-1},hz)
lat4=lat({rs(3)-1:re(3)-1},hz)
lat5=lat({rs(4)-1:re(4)-1},hz)
lat6=lat({rs(5)-1:re(5)-1},hz)
lat7=lat({rs(6)-1:re(6)-1},hz)
lat8=lat({rs(7)-1:re(7)-1},hz)


  wks   = gsn_open_wks ("x11","potential_temperature_b988")               ; send graphics to PNG file
  res                  = True                     ; plot mods desired
  res@gsnDraw     = False      ; Will draw later, after overlaying
  res@gsnFrame    = False      ; all plots
  res@vpHeightF = 0.20        ; Changes the aspect ratio
  res@vpWidthF  = 0.60
  res@trXMinF       = 64.70          ; Control limits of X
  res@trXMaxF       = 65.70     ; and Y axes.
  res@trYMinF       = -0.08         ; Control limits of X
  res@trYMaxF       = 1 
  res@tmXBMode        = "Manual"
  res@tmXBTickStartF  = res@trXMinF 
  res@xyLineThicknessF = 2.0       ; double the thickness of the line
  res@gsnMaximize = True
  res@gsnPaperOrientation = "landscape" 
  res@tiYAxisString = "Potential Temperature (K) " 
;*;*******
  res@xyLineColor = "Blue"         ; color the line blue
  plot1 = gsn_csm_xy(wks,lat1,theta1,res)
  res@xyLineColor = "Red"         ; color the line blue
  plot2 = gsn_csm_xy(wks,lat2,theta2,res)
  res@xyLineColor = "Orange"    
  plot3 = gsn_csm_xy(wks,lat3,theta3,res)
  res@xyLineColor = "Green"
  plot4 = gsn_csm_xy(wks,lat4,theta4,res)
  res@xyLineColor = "Pink"
  plot5 = gsn_csm_xy(wks,lat5,theta5,res)
  res@xyLineColor = "Dodgerblue"
  plot6 = gsn_csm_xy(wks,lat6,theta6,res)
  res@xyLineColor = "Forestgreen"
  plot7 = gsn_csm_xy(wks,lat7,theta7,res)
  res@xyLineColor = "Yellow"
  plot8 = gsn_csm_xy(wks,lat8,theta8,res)
  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)
  overlay(plot1,plot8)
;;******* create legend *******************************
;;******************************************************
  lgres                    = True
  lgres@lgLineColors     =  (/"blue","red","orange","green","pink","dodgerblue","forestgreen","yellow"/) 
  lgres@lgLineThicknessF   = (/2,2,2,2,2,2,2,2/)  ; legend line thickness = contour line thickness
  lgres@xyMarkLineModes        = (/"Lines"/)    
  lgres@lgLabelFontHeightF = .06            ; set the legend label font thickness
  lgres@vpWidthF           = 0.10          ; width of legend (NDC)
  lgres@vpHeightF          = 0.085            ; height of legend (NDC)
  lgres@lgPerimOn              = False      
  lgres@lgMonoDashIndex = True
  lgres@lgOrientation          = "horizontal"
  lbid = gsn_create_legend(wks,8,(/"1","2","3","4","5","6","7","8"/),lgres)         ; create legend

  amres = True
  amres@amParallelPosF   = 0.30		    ; move legend to the right
  amres@amOrthogonalPosF = -0.25             ; move the legend down
  annoid1 = gsn_add_annotation(plot1,lbid,amres)   ; add legend to plot

  draw(plot1)
  frame(wks)

end 

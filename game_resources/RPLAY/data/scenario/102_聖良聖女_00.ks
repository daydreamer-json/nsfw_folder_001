; 
; 
*p0|
@bg storage=bg_01a
@eff obj=0 storage=bg_01a_l path=(1152,360,255)(640,560,255)(+0.0,720,255) size=(0.9,1) time=60000 accel=-2 spline=true offsettime=2000 offsetpath=(0,0,0)(0,0,255)
@bgm storage=bgm_02
@show
*p1|
朝――それは誰にでも訪れる日常。[np]
*p2|
多くの人にとってそれは一日の始まり。[np]
*p3|
だからこそ癒やしを求めずにはいられない。[r]
歳を取れば取るほど、人は朝から癒やされたいのだ。[np]
*p4|
だからこそ――[np]
@fobgm time=3000
@hide
@eff_all_delete
@white time=2000
@wbgm
@wait time=1000
@jump storage="102_聖良聖女_01_h.ks"

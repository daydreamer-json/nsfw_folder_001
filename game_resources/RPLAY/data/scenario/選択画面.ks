; 
; 
@shide
@macro name="jumpexp"
@eval exp="f.readList.add(mp.storage)" cond="mp.storage !== void"
@jump storage=%storage target=%target
@endmacro
@jumpexp storage="trial_end.ks" cond="f.readCount == 4  && f.readList.find('trial_end.ks') == -1 && tf.trialFlag"
@jumpexp storage="000_共通_06.ks" cond="f.readCount == 4  && f.readList.find('000_共通_06.ks') == -1"
@jumpexp storage="000_共通_07.ks" cond="f.readCount == 8  && f.readList.find('000_共通_07.ks') == -1"
@jumpexp storage="000_共通_08.ks" cond="f.readCount == 12 && f.readList.find('000_共通_08.ks') == -1"
@jumpexp storage="000_共通_09.ks" cond="f.readCount == 16 && f.readList.find('000_共通_09.ks') == -1"
@jumpexp storage="000_共通_10.ks" cond="f.readCount == 20 && f.readList.find('000_共通_10.ks') == -1"
@jumpexp storage="000_共通_11.ks" cond="f.readCount == 24 && f.readList.find('000_共通_11.ks') == -1"
@jumpexp storage="000_共通_12.ks" cond="f.readCount == 28 && f.readList.find('000_共通_12.ks') == -1"
*common_return
@iscript
/* @eval exp="setReadFlag()" @jump storage="選択画面.ks" main/100_聖良初体験_01_h.ks	// 0
main/200_莉瑠初体験_01_h.ks	// 1
101_聖良聖女_01_h.ks	// 2
101_聖良バニー_01_h.ks	// 3
main/101_聖良サキュ_01_h.ks	// 4
main/101_聖良巫女_01_h.ks	// 5
main/201_莉瑠聖女_01_h.ks	// 6
main/201_莉瑠メイド_01_h.ks	// 7
201_莉瑠黒魔_01_h.ks	// 8
201_莉瑠騎士_01_h.ks	// 9
main/102_聖良聖女_02_h.ks	// 10
main/102_聖良バニー_02_h.ks	// 11
102_聖良サキュ_02_h.ks	// 12
main/102_聖良巫女_02_h.ks	// 13
main/202_莉瑠聖女_01_h.ks	// 14
main/202_莉瑠メイド_01_h.ks	// 15
main/202_莉瑠黒魔_02_h.ks	// 16
main/202_莉瑠騎士_01_h.ks	// 17
main/103_聖良聖女_01_h.ks	// 18
main/103_聖良バニー_01_h.ks	// 19
main/103_聖良サキュ_01_h.ks	// 20
main/103_聖良巫女_01_h.ks	// 21
main/203_莉瑠聖女_01_h.ks	// 22
main/203_莉瑠メイド_02_h.ks	// 23
main/203_莉瑠黒魔_01_h.ks	// 24
main/203_莉瑠騎士_02_h.ks	// 25
main/104_聖良聖女_01_h.ks	// 26
main/104_聖良バニー_01_h.ks	// 27
main/104_聖良サキュ_01_h.ks	// 28
main/104_聖良巫女_01_h.ks	// 29
main/204_莉瑠聖女_02_h.ks	// 30
main/204_莉瑠メイド_01_h.ks	// 31
main/204_莉瑠黒魔_01_h.ks	// 32
main/204_莉瑠騎士_01_h.ks	// 33
main/105_聖良デート_01_h.ks	// 34
main/205_莉瑠デート_01_h.ks	// 35
main/301_3p聖女聖女_00_h.ks	// 36
main/301_3pバニーメイド_00_h.ks	// 37
main/301_3pサキュ魔女_00_h.ks	// 38
main/301_3p巫女騎士_00_h.ks	// 39
main/106_聖良エピローグ_01_h.ks	// 40
main/206_莉瑠エピローグ_01_h.ks	// 41
*/
@endscript
@if exp="f.readList === void"
@call storage=gameinit.ks
@endif
@delay_script_skip
@eval exp="kag.skipToPage();"
@cm
@aseff
@eff_all_delete
@clearlayers
@clearmessages
@eval exp="reorderBackLayers()"
@extrans time=250
@eval exp="reorderBackLayers()"
*flowchartstore|
@iscript
kag.rightClickHook.clear(); kag.keyDownHook.clear(); tf.trialFlag = false;
@endscript
@iscript
if(tf.flowCurPage === void)tf.flowCurPage = 0; tf.flowLock = [ [ "f.readCount >= 4 && ((getReadFlag(2)+getReadFlag(3)+getReadFlag(4)+getReadFlag(5)) >= 1 && (getReadFlag(6)+getReadFlag(7)+getReadFlag(8)+getReadFlag(9)) >= 1)",
"f.readCount >= 4 && ((getReadFlag(6)+getReadFlag(7)+getReadFlag(8)+getReadFlag(9)) >= 1 && (getReadFlag(2)+getReadFlag(3)+getReadFlag(4)+getReadFlag(5)) >= 1)"	// 初H条件
], ["getReadFlag(0) && getReadFlag(1) && getReadFlag(2)","getReadFlag(0) && getReadFlag(1) && getReadFlag(6)"], ["getReadFlag(0) && getReadFlag(1) && getReadFlag(3)","getReadFlag(0) && getReadFlag(1) && getReadFlag(7)"],
["getReadFlag(0) && getReadFlag(1) && getReadFlag(4)","getReadFlag(0) && getReadFlag(1) && getReadFlag(8)"], ["getReadFlag(0) && getReadFlag(1) && getReadFlag(5)","getReadFlag(0) && getReadFlag(1) && getReadFlag(9)"],
["getReadFlag(10)","getReadFlag(14)"], ["getReadFlag(11)","getReadFlag(15)"], ["getReadFlag(12)","getReadFlag(16)"], ["getReadFlag(13)","getReadFlag(17)"],
["getReadFlag(18)","getReadFlag(22)"], ["getReadFlag(19)","getReadFlag(23)"], ["getReadFlag(20)","getReadFlag(24)"], ["getReadFlag(21)","getReadFlag(25)"],
[ "(getReadFlag(26) + getReadFlag(27) + getReadFlag(28) + getReadFlag(29)) >= 2", "(getReadFlag(30) + getReadFlag(31) + getReadFlag(32) + getReadFlag(33)) >= 2"
 ], "(getReadFlag(26) && getReadFlag(30)) || "+ "(getReadFlag(27) && getReadFlag(31)) || "+ "(getReadFlag(28) && getReadFlag(32)) || "+ "(getReadFlag(29) && getReadFlag(33))",
["getReadFlag(26) && getReadFlag(27) && getReadFlag(28) && getReadFlag(29) && getReadFlag(34)",  "getReadFlag(30) && getReadFlag(31) && getReadFlag(32) && getReadFlag(33) && getReadFlag(35)"
], "(getReadFlag(26) && getReadFlag(30))", "(getReadFlag(27) && getReadFlag(31))", "(getReadFlag(28) && getReadFlag(32))", "(getReadFlag(29) && getReadFlag(33))"
]; function checkFlowOpen(no){ var re = false; if(no == 14 || no >= 16){ re = tf.flowLock[no]!; }else{ re = tf.flowLock[no][tf.flowCurPage]!; } return re;
} function flowchartCharSlide(no){ var chr = [ ["st01abb01",-300,-70,"st02abb01",-300,-70,"私服", 0xad2a94], ["st01abc01",-300,-70,"st02abc01",-300,-70,"セレスティア", 0xad5c2a],
["st01abe01",-300,-70,"st02abe01",-300,-70,"チャーミング", 0xad2a41], ["st01abg01",-300,-70,"st02abh01",-300,-70,"ダークネス", 0x3b2aad], ["st01abf01",-300,-70,"st02abf01",-300,-70,"ヴァリアント", 0x2aada0]
]; var target = chr[no >= 5 ? (no-4) : no]; kag.fore.layers[3].stopMove(); kag.fore.layers[3].loadImages(%[storage:"fc_bg_"+target[6], left:-20, opacity:0, visible:true]);
kag.fore.layers[3].beginMove(%[path:"0,0,255", time:200, accel:-2]); var storage = target[tf.flowCurPage == 1 ? 3 : 0]; storage = storage.substr(0, storage.length-2) + "%02d".sprintf(intrandom(1,18));	// 顔ランダム化
var x = target[tf.flowCurPage == 1 ? 4 : 1]; var y = target[tf.flowCurPage == 1 ? 5 : 2]; if(tf.flowCurPage == 2)x -= 75; with(kag.fore.layers[4]){ .eyeAnmCancel = true;
.stopMove(); .loadImages(%[storage:storage, left:x+20, top:y, opacity:0, visible:true]); var ha = .holdAlpha; var fc = .face; .holdAlpha = true; .face = dfOpaque;
.fillRect(0,0,.width,.height,target[7]); .beginMove(%[path:(x-15)+","+y+",255", time:200, accel:-2]); .eyeAnmCancel = false; .holdAlpha = ha; .face = fc;
} with(kag.fore.layers[6]){ .stopMove(); .loadImages(%[storage:storage, left:x+20, top:y, opacity:0, visible:true]); .beginMove(%[path:x+","+y+",255", time:200, accel:-2]);
} if(no >= 5){ storage = target[3]; storage = storage.substr(0, storage.length-2) + "%02d".sprintf(intrandom(1,18));	// 顔ランダム化
x = target[4] + 225; y = target[5]; with(kag.fore.layers[5]){ .eyeAnmCancel = true; .stopMove(); .loadImages(%[storage:storage, left:x-20, top:y, opacity:0, visible:true]);
var ha = .holdAlpha; var fc = .face; .holdAlpha = true; .face = dfOpaque; .fillRect(0,0,.width,.height,target[7]); .beginMove(%[path:(x+15)+","+y+",255", time:200, accel:-2]);
.eyeAnmCancel = false; .holdAlpha = ha; .face = fc; } with(kag.fore.layers[7]){ .stopMove(); .loadImages(%[storage:storage, left:x-20, top:y, opacity:0, visible:true]);
.absolute = ((no == 7 || no == 5) ? 6999 : 8000); .beginMove(%[path:x+","+y+",255", time:200, accel:-2]); } } }
@endscript
*redraw
@position frame="" layer=message0 page=back left=0 top=0 width=1280 height=720 opacity=0 visible=true
@eval exp="kag.back.messages[0].opacity = 255"
@current layer=message0 page=back
@er
@simg storage=fc_bg page=back
@simg storage=fc_head layer=11 page=back left=6 top=13
@if exp="tf.flowCurPage != 2"
@simg storage=fc_frame layer=12 page=back left=382 top=83
@else
@simg storage=fc_frame_3p layer=12 page=back left=590 top=83
@endif
@freeimage layer=8 page=back
@iscript
with(kag.back.layers[8]){ .absolute = kag.back.messages[0].absolute + 1; .setPos(0,0); .setImageSize(1280, 720); .setSizeToImageSize(); .type = ltAlpha;
.face = dfAlpha; .fillRect(0, 0, 1280, 720, 0x0); .opacity = 255; .visible = true; }
@endscript
@nowait
@btt4 x=396 y=41 graphic=fc_tab_seira target=*redraw exp="tf.flowCurPage = 0" focus="&tf.flowCurPage == 0 ? 'true' : 'false'"
@btt4 x=821 y=41 graphic=fc_tab_riru  target=*redraw exp="tf.flowCurPage = 1" focus="&tf.flowCurPage == 1 ? 'true' : 'false'"
@btt x=807 y=660 graphic=fc_save exp="if(kag.inStable)kag.callExtraConductor('saveload.ks','*save')"
@btt x=917 y=660 graphic=fc_load exp="if(kag.inStable)kag.callExtraConductor('saveload.ks','*load')"
@btt x=1029 y=660 graphic=fc_title exp="if(aynBackTitle())kag.process('','*title')"
@btt x=1140 y=660 graphic=fc_exit exp="if(aynExitGame())kag.process('','*exit')"
@if exp="tf.flowCurPage == 0 || tf.flowCurPage == 1"
@if exp="tf.flowCurPage == 0"
@btt x=412  y=110 graphic="fc_btn_聖女1" 		 exp="tf.okayuSnr='101_聖良聖女_00.ks'"   target="*start"	onenter="flowchartCharSlide(1)"
@btt x=621  y=110 graphic="fc_btn_ビキニバニー1" exp="tf.okayuSnr='101_聖良バニー_00.ks'" target="*start"	onenter="flowchartCharSlide(2)"
@btt x=830  y=110 graphic="fc_btn_サキュバス1" 	 exp="tf.okayuSnr='101_聖良サキュ_00.ks'" target="*start"	onenter="flowchartCharSlide(3)" off4="&tf.trialFlag"
@btt x=1039 y=110 graphic="fc_btn_戦巫女1" 		 exp="tf.okayuSnr='101_聖良巫女_00.ks'"   target="*start"	onenter="flowchartCharSlide(4)" off4="&tf.trialFlag"
@btt x=621 y=187 graphic=fc_btn_初体験  		 exp="f.seiraFirstSnr === void ? (tf.okayuSnr=(getReadFlag(0) || getReadFlag(1)) ? '100_聖良初体験_00非童貞ver.ks' : '100_聖良初体験_00童貞ver.ks', f.seiraFirstSnr = tf.okayuSnr) : (tf.okayuSnr = f.seiraFirstSnr)" target="*start"	onenter="flowchartCharSlide(0)" off4="&!checkFlowOpen(0)"
@btt x=412  y=264 graphic="fc_btn_聖女2" 		 exp="tf.okayuSnr='102_聖良聖女_00.ks'"   target="*start"	onenter="flowchartCharSlide(1)" off4="&!checkFlowOpen(1)"
@btt x=621  y=264 graphic="fc_btn_ビキニバニー2" exp="tf.okayuSnr='102_聖良バニー_00.ks'" target="*start"	onenter="flowchartCharSlide(2)" off4="&!checkFlowOpen(2)"
@btt x=830  y=264 graphic="fc_btn_サキュバス2" 	 exp="tf.okayuSnr='102_聖良サキュ_00.ks'" target="*start"	onenter="flowchartCharSlide(3)" off4="&!checkFlowOpen(3)"
@btt x=1039 y=264 graphic="fc_btn_戦巫女2" 		 exp="tf.okayuSnr='102_聖良巫女_00.ks'"   target="*start"	onenter="flowchartCharSlide(4)" off4="&!checkFlowOpen(4)"
@btt x=412  y=341 graphic="fc_btn_聖女3" 		 exp="tf.okayuSnr='103_聖良聖女_00.ks'"   target="*start"	onenter="flowchartCharSlide(1)" off4="&!checkFlowOpen(5)"
@btt x=621  y=341 graphic="fc_btn_ビキニバニー3" exp="tf.okayuSnr='103_聖良バニー_00.ks'" target="*start"	onenter="flowchartCharSlide(2)" off4="&!checkFlowOpen(6)"
@btt x=830  y=341 graphic="fc_btn_サキュバス3" 	 exp="tf.okayuSnr='103_聖良サキュ_00.ks'" target="*start"	onenter="flowchartCharSlide(3)" off4="&!checkFlowOpen(7)"
@btt x=1039 y=341 graphic="fc_btn_戦巫女3" 		 exp="tf.okayuSnr='103_聖良巫女_00.ks'"   target="*start"	onenter="flowchartCharSlide(4)" off4="&!checkFlowOpen(8)"
@btt x=412  y=418 graphic="fc_btn_聖女4" 		 exp="tf.okayuSnr='104_聖良聖女_00.ks'"   target="*start"	onenter="flowchartCharSlide(1)" off4="&!checkFlowOpen(9)"
@btt x=621  y=418 graphic="fc_btn_ビキニバニー4" exp="tf.okayuSnr='104_聖良バニー_00.ks'" target="*start"	onenter="flowchartCharSlide(2)" off4="&!checkFlowOpen(10)"
@btt x=830  y=418 graphic="fc_btn_サキュバス4" 	 exp="tf.okayuSnr='104_聖良サキュ_00.ks'" target="*start"	onenter="flowchartCharSlide(3)" off4="&!checkFlowOpen(11)"
@btt x=1039 y=418 graphic="fc_btn_戦巫女4" 		 exp="tf.okayuSnr='104_聖良巫女_00.ks'"   target="*start"	onenter="flowchartCharSlide(4)" off4="&!checkFlowOpen(12)"
@else
@btt x=412  y=110 graphic="fc_btn_聖女1" 		 exp="tf.okayuSnr='201_莉瑠聖女_00.ks'" 	target="*start"	onenter="flowchartCharSlide(1)" off4="&tf.trialFlag"
@btt x=621  y=110 graphic="fc_btn_ビキニメイド1" exp="tf.okayuSnr='201_莉瑠メイド_00.ks'" 	target="*start"	onenter="flowchartCharSlide(2)" off4="&tf.trialFlag"
@btt x=830  y=110 graphic="fc_btn_黒魔法使い1" 	 exp="tf.okayuSnr='201_莉瑠黒魔_00.ks'" 	target="*start"	onenter="flowchartCharSlide(3)"
@btt x=1039 y=110 graphic="fc_btn_騎士1" 		 exp="tf.okayuSnr='201_莉瑠騎士_00.ks'" 	target="*start"	onenter="flowchartCharSlide(4)"
@btt x=621 y=187 graphic=fc_btn_初体験  		 exp="f.riruFirstSnr === void ? (tf.okayuSnr=getReadFlag(0) || getReadFlag(1) ? '200_莉瑠初体験_00非童貞ver.ks' : '200_莉瑠初体験_00童貞ver.ks', f.riruFirstSnr = tf.okayuSnr) : (tf.okayuSnr = f.riruFirstSnr)" target="*start"	onenter="flowchartCharSlide(0)" off4="&!checkFlowOpen(0)"
@btt x=412  y=264 graphic="fc_btn_聖女2" 		 exp="tf.okayuSnr='202_莉瑠聖女_00.ks'" 	target="*start"	onenter="flowchartCharSlide(1)" off4="&!checkFlowOpen(1)"
@btt x=621  y=264 graphic="fc_btn_ビキニメイド2" exp="tf.okayuSnr='202_莉瑠メイド_00.ks'" 	target="*start"	onenter="flowchartCharSlide(2)" off4="&!checkFlowOpen(2)"
@btt x=830  y=264 graphic="fc_btn_黒魔法使い2"	 exp="tf.okayuSnr='202_莉瑠黒魔_00.ks'" 	target="*start"	onenter="flowchartCharSlide(3)" off4="&!checkFlowOpen(3)"
@btt x=1039 y=264 graphic="fc_btn_騎士2"		 exp="tf.okayuSnr='202_莉瑠騎士_00.ks'" 	target="*start"	onenter="flowchartCharSlide(4)" off4="&!checkFlowOpen(4)"
@btt x=412  y=341 graphic="fc_btn_聖女3" 		 exp="tf.okayuSnr='203_莉瑠聖女_00.ks'" 	target="*start"	onenter="flowchartCharSlide(1)" off4="&!checkFlowOpen(5)"
@btt x=621  y=341 graphic="fc_btn_ビキニメイド3" exp="tf.okayuSnr='203_莉瑠メイド_00.ks'" 	target="*start"	onenter="flowchartCharSlide(2)" off4="&!checkFlowOpen(6)"
@btt x=830  y=341 graphic="fc_btn_黒魔法使い3"	 exp="tf.okayuSnr='203_莉瑠黒魔_00.ks'" 	target="*start"	onenter="flowchartCharSlide(3)" off4="&!checkFlowOpen(7)"
@btt x=1039 y=341 graphic="fc_btn_騎士3"		 exp="tf.okayuSnr='203_莉瑠騎士_00.ks'" 	target="*start"	onenter="flowchartCharSlide(4)" off4="&!checkFlowOpen(8)"
@btt x=412  y=418 graphic="fc_btn_聖女4" 		 exp="tf.okayuSnr='204_莉瑠聖女_00.ks'" 	target="*start"	onenter="flowchartCharSlide(1)" off4="&!checkFlowOpen(9)"
@btt x=621  y=418 graphic="fc_btn_ビキニメイド4" exp="tf.okayuSnr='204_莉瑠メイド_00.ks'" 	target="*start"	onenter="flowchartCharSlide(2)" off4="&!checkFlowOpen(10)"
@btt x=830  y=418 graphic="fc_btn_黒魔法使い4"	 exp="tf.okayuSnr='204_莉瑠黒魔_00.ks'" 	target="*start"	onenter="flowchartCharSlide(3)" off4="&!checkFlowOpen(11)"
@btt x=1039 y=418 graphic="fc_btn_騎士4"		 exp="tf.okayuSnr='204_莉瑠騎士_00.ks'" 	target="*start"	onenter="flowchartCharSlide(4)" off4="&!checkFlowOpen(12)"
@endif
@btt x=412 y=495 graphic=fc_btn_デート exp="tf.okayuSnr=tf.flowCurPage == 0 ? '105_聖良デート_00.ks' : '205_莉瑠デート_00.ks'" target=*start onenter="flowchartCharSlide(0)" off4="&!checkFlowOpen(13)"
@btt x=830 y=495 graphic=fc_btn_3p onenter="flowchartCharSlide(0)" target=*redraw exp="tf.flowCurPage = 2" off4="&!checkFlowOpen(14)"
@btt x=621 y=572 graphic=fc_btn_エンディング exp="tf.okayuSnr=tf.flowCurPage == 0 ? '106_聖良エピローグ_00.ks' : '206_莉瑠エピローグ_00.ks'" target=*start onenter="flowchartCharSlide(0)" off4="&!checkFlowOpen(15)"
@btt x=312 y=319 graphic=fc_ex_bt_next target=*redraw exp="if(++tf.flowCurPage > 1)tf.flowCurPage = 0" cond="tf.flowCurPage != 2"
@iscript
with(kag.back.layers[8]){ var pfunc = function(x, y, size="s"){ with(kag.back.layers[8]){ .loadPartialImage(%[dx:x, dy:y, opacity:125, storage:"fc_ボタン押せない時用_" + size]);
.loadPartialImage(%[dx:x+1, dy:y-10, opacity:255, storage:"fc_lock"]); } }; if(tf.trialFlag){ if(tf.flowCurPage == 0){ pfunc(830 , 110); pfunc(1039, 110);
}else if(tf.flowCurPage == 1){ pfunc(412 , 110); pfunc(621 , 110); } } if(!checkFlowOpen(0))pfunc(621,  187, "l");	// 初
if(!checkFlowOpen(1))pfunc(412 , 264);	// 2
if(!checkFlowOpen(2))pfunc(621 , 264); if(!checkFlowOpen(3))pfunc(830 , 264); if(!checkFlowOpen(4))pfunc(1039, 264); if(!checkFlowOpen(5))pfunc(412 , 341);	// 3
if(!checkFlowOpen(6))pfunc(621 , 341); if(!checkFlowOpen(7))pfunc(830 , 341); if(!checkFlowOpen(8))pfunc(1039, 341); if(!checkFlowOpen(9))pfunc(412 , 418);	// 4
if(!checkFlowOpen(10))pfunc(621 , 418); if(!checkFlowOpen(11))pfunc(830 , 418); if(!checkFlowOpen(12))pfunc(1039, 418); if(!checkFlowOpen(13))pfunc(412,  495, "l");	// デート
if(!checkFlowOpen(14))pfunc(830,  495, "l");	// 3p
if(!checkFlowOpen(15))pfunc(621,  572, "l");	// エンディング
pfunc = function(x, y){ kag.back.layers[8].loadPartialImage(%[dx:x-8, dy:y-7, opacity:255, storage:"fc_new"]); }; if(tf.trialFlag){ if(tf.flowCurPage == 0){
if(!getReadFlag(2))pfunc(412  ,110); if(!getReadFlag(3))pfunc(621  ,110); }else if(tf.flowCurPage == 1){ if(!getReadFlag(8))pfunc(830  ,110); if(!getReadFlag(9))pfunc(1039 ,110);
} }else{ if(!getReadFlag(tf.flowCurPage==0?2:6))pfunc(412  ,110); if(!getReadFlag(tf.flowCurPage==0?3:7))pfunc(621  ,110); if(!getReadFlag(tf.flowCurPage==0?4:8))pfunc(830  ,110);
if(!getReadFlag(tf.flowCurPage==0?5:9))pfunc(1039 ,110); } if(checkFlowOpen(0) && !getReadFlag(tf.flowCurPage==0?0:1))pfunc(621  ,187);	// 初
if(checkFlowOpen(1) && !getReadFlag(tf.flowCurPage==0?10:14))pfunc(412  ,264);	// 2
if(checkFlowOpen(2) && !getReadFlag(tf.flowCurPage==0?11:15))pfunc(621  ,264); if(checkFlowOpen(3) && !getReadFlag(tf.flowCurPage==0?12:16))pfunc(830  ,264);
if(checkFlowOpen(4) && !getReadFlag(tf.flowCurPage==0?13:17))pfunc(1039 ,264); if(checkFlowOpen(5) && !getReadFlag(tf.flowCurPage==0?18:22))pfunc(412  ,341);	// 3
if(checkFlowOpen(6) && !getReadFlag(tf.flowCurPage==0?19:23))pfunc(621  ,341); if(checkFlowOpen(7) && !getReadFlag(tf.flowCurPage==0?20:24))pfunc(830  ,341);
if(checkFlowOpen(8) && !getReadFlag(tf.flowCurPage==0?21:25))pfunc(1039 ,341); if(checkFlowOpen(9) && !getReadFlag(tf.flowCurPage==0?26:30))pfunc(412  ,418);	// 4
if(checkFlowOpen(10) && !getReadFlag(tf.flowCurPage==0?27:31))pfunc(621  ,418); if(checkFlowOpen(11) && !getReadFlag(tf.flowCurPage==0?28:32))pfunc(830  ,418);
if(checkFlowOpen(12) && !getReadFlag(tf.flowCurPage==0?29:33))pfunc(1039 ,418); if(checkFlowOpen(13) && !getReadFlag(tf.flowCurPage==0?34:35))pfunc(412  ,495);	// デート
if(checkFlowOpen(14) && ((checkFlowOpen(16) && !getReadFlag(36)) || (checkFlowOpen(17) && !getReadFlag(37)) || (checkFlowOpen(18) && !getReadFlag(38)) || (checkFlowOpen(19) && !getReadFlag(39))))pfunc(830  ,495);	// 3p
if(checkFlowOpen(15) && !getReadFlag(tf.flowCurPage==0?40:41))pfunc(621  ,572);	// エンディング
}
@endscript
@else
@btt x=621 y=111 graphic=fc_btn_セレスティアスタイル exp="tf.okayuSnr='301_3p聖女聖女_00_h.ks'" 	target=*start onenter="flowchartCharSlide(5)" off2="&!checkFlowOpen(16)"
@btt x=621 y=246 graphic=fc_btn_チャーミング		 exp="tf.okayuSnr='301_3pバニーメイド_00_h.ks'" target=*start onenter="flowchartCharSlide(6)" off2="&!checkFlowOpen(17)"
@btt x=621 y=381 graphic=fc_btn_ダークネス 			 exp="tf.okayuSnr='301_3pサキュ魔女_00_h.ks'" 	target=*start onenter="flowchartCharSlide(7)" off2="&!checkFlowOpen(18)"
@btt x=621 y=516 graphic=fc_btn_ヴァリアント 		 exp="tf.okayuSnr='301_3p巫女騎士_00_h.ks'" 	target=*start onenter="flowchartCharSlide(8)" off2="&!checkFlowOpen(19)"
@btt x=1074 y=530 graphic=fc_btn_3p_back target=*redraw exp="tf.flowCurPage = 0"
@iscript
{ var pfunc = function(x, y){ kag.back.layers[8].loadPartialImage(%[dx:x+1, dy:y-11, opacity:255, storage:"fc_new"]); }; if(checkFlowOpen(16) && !getReadFlag(36))pfunc(621 ,111);
if(checkFlowOpen(17) && !getReadFlag(37))pfunc(621 ,246); if(checkFlowOpen(18) && !getReadFlag(38))pfunc(621 ,381); if(checkFlowOpen(19) && !getReadFlag(39))pfunc(621 ,516);
}
@endscript
@endif
@pimage storage="&tf.flowCurPage == 0 ? 'trial_seira' : 'trial_riru'" layer=8 page=back dx=403 dy=99 cond="tf.trialFlag"
@endnowait
@locklink
@extrans time=150
@auto_save cond="!tf.isEvMode && glDoAutoSave"
*stop
@bgm storage=bgm_01 notitle=true
*restart
@unlocklink
@iscript
try{ kag.fore.messages[0].links[6].object.onMouseEnter(); kag.fore.messages[0].links[6].object.onMouseLeave(); }catch(e){ }
@endscript
@s
*start
@eval exp="kag.cancelSkip()"
@clearlayers
@clearmessages
@fobgm time=1500
@extrans
@black time=1
@setframe
@iscript
kag.rightClickHook.clear(); kag.keyDownHook.clear(); kag.rightClickHook.add(gameRClickFunc); kag.keyDownHook.add(gameKeyFunc); if(f.readList.find(tf.okayuSnr) == -1){
f.readList.add(tf.okayuSnr); f.readCount += 1; }
@endscript
@wbgm
@eval exp="kag.cancelSkip()"
@jump storage="&tf.okayuSnr"
*title
@jump storage="title.ks" target="*title_init"
*exit
@eval exp="kag.closeByScript(%[ask:false])"

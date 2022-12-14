
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; 体験版Ｈ
*extra
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; 一つ前に戻るクリア
@eval exp="backPageArray.clear()"


@bgm storage=bgm_01 cond="kag.bgm.currentBuffer.status != 'play'"

@clearmessages
@clearlayers
@eff_delete

@position layer=message0 page=back frame="" left=0 top=0 width="&kag.scWidth" height="&kag.scHeight" visible=true opacity=0 marginl=0 marginr=0 margint=0 marginb=0
@eval exp="kag.fore.messages[0].opacity=kag.back.messages[0].opacity=255"
@current layer=message0 page=back
@er

@simg storage=trial_extra_bg page=back
@btt x=105  y=131 graphic=trial_extra_btn0 target="*go_scenario" onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=483  y=131 graphic=trial_extra_btn1 target="*go_scene"    onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok'), tf.trialPage='*h_scene_', tf.trialh='yuk_051_00_h.ks'"
@btt x=714  y=131 graphic=trial_extra_btn2 target="*go_scene"    onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok'), tf.trialPage='*h_scene_', tf.trialh='hai_009_00_h.ks'"
@btt x=945  y=131 graphic=trial_extra_btn3 target="*go_scene"    onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok'), tf.trialPage='*h_scene_', tf.trialh='him_015_00_h.ks'"
@btt x=605  y=362 graphic=trial_extra_btn4 target="*go_scene"    onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok'), tf.trialPage='*h_scene_', tf.trialh='ari_006_00_h.ks'"
@btt x=836  y=362 graphic=trial_extra_btn5 target="*go_scene"    onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok'), tf.trialPage='*h_scene_', tf.trialh='kor_006_01_h.ks'"


@btt x=1018 y=648 graphic=com_bt_title target="*back_title"   onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=1136 y=648 graphic=com_bt_exit  target="*close_window" onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"

;@eval exp="numberImgDraw(kag.back.layers[0], appVer, 90, 698, 't_num_ver', 11, 0)"

@extrans
@eff_all_delete
@iscript
kag.rightClickHook.clear();
kag.rightClickHook.add(function(){if(kag.inStable)kag.process("", "*back_title"); return true;});
@endscript

*restart
@unlocklink
@s

;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
;体験版本編スタート
*go_scenario
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@jump storage="title.ks" target="*start_game"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
;Ｈシーンスタート
*go_scene
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@stop_grain
@fobgm time=500
@eff_all_delete
@clearlayers
@clearmessages
@allstopsound time=300
@extrans time=1000
@wbgm
@backlay
@wvo
@history output=true enabled=true

@iscript
kag.rightClickHook.clear();
kag.rightClickHook.add(function(){kag.cancelAutoMode(); if(kag.inStable)if(askYesNo("エクストラ画面に戻ります。￥ｎよろしいですか？",,%[check:"sysDialogReplayReturn"]))kag.process("title_trial.ks", "*extra_return"); return true;});
kag.keyDownHook.clear();
kag.keyDownHook.add(gameKeyFunc);
// 前に戻る用変数の初期化
backPageArray.clear();
backPageNoSave = false;
@endscript

@setframe
@eval exp="kag.cancelSkip()"
@eval exp="tf.isEvMode = true"
@white time=800
@wait time=1000
@jump storage="&tf.trialh" target="&tf.trialPage"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; 体験版Ｈシーンからの戻り処理
*extra_return
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@iscript
kag.rightClickHook.clear();
kag.keyDownHook.clear();
kag.messageLayer.clear(), kag.nameLayer.clear();
f.nowBgTime = 0;
exlink_object.endLink();
backPageArray.clear(); // 一つ前に戻るクリア
global.delayscript.clearEvent(); // delayスクリプトクリア
@endscript

@shide
@sleff_back
@eff_all_delete
@bgv_all_stop
@stop_grain
@allstopsound
@stopquake
@info_stop
@fobgm time=250
@hide_miniface
@clearlayers
@clearmessages
@extrans time=250
@wbgm

@history output=false enabled=false
@setframe

@eval exp="kag.cancelSkip()"
@eval exp="tf.isEvMode = false"
@jump target="*extra"

;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
;タイトルへの戻り
*back_title
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@clearmessages
@end_nowait_exlink
@jump storage="title.ks" target="*extra_back"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; ゲーム終了
*close_window
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@close
@jump target="*restart"
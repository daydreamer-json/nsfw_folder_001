
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; アフターストーリーＨ
*extra
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; 一つ前に戻るクリア
@eval exp="backPageArray.clear()"


@bgm storage=bgm01 cond="kag.bgm.currentBuffer.status != 'play'"

@clearlayers
@eff_delete

@eff page=back show=true obj=0 storage=t_bg path=(640,360,255) time=0 bblur=true bbx=10 bby=10 absolute=1500 bblur_sq=true
@simg storage=t_bg page=back
;;;@simg layer=1 storage=black page=back opacity=100
@simg layer=2 storage=after page=back left=48 top=55
@position layer=message0 page=back frame="" left=0 top=0 width="&kag.scWidth" height="&kag.scHeight" visible=true opacity=0 marginl=0 marginr=0 margint=0 marginb=0
@eval exp="kag.fore.messages[0].opacity=kag.back.messages[0].opacity=255"
@current layer=message0 page=back
@er

@btt x=55  y=142 graphic=after_サリア   target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_01サリア_00.ks'"
@btt x=290 y=142 graphic=after_リーゼ   target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_02リーゼ_00.ks'"
@btt x=525 y=142 graphic=after_メア     target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_03メア_00.ks'"
@btt x=760 y=142 graphic=after_アレーナ target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_04アレーナ_00.ks'"
@btt x=995 y=142 graphic=after_ハーレム target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_05ハーレム_00.ks'"

@btt x=998  y=647 graphic=com_bt_back target="*back_title"   onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=1112 y=647 graphic=com_bt_exit target="*close_window" onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"

@eval exp="numberImgDraw(kag.back.layers[0], appVer, 90, 698, 't_num_ver', 11, 0)"

@extrans
@eff_all_delete
@iscript
kag.rightClickHook.clear();
kag.rightClickHook.add(function(){if(kag.inStable)kag.process("", "*back_title"); return true;});
@endscript

;;;@exlink txt="サリア"   target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_01サリア_00.ks'"
;;;@exlink txt="リーゼ"   target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_02リーゼ_00.ks'"
;;;@exlink txt="メア"     target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_03メア_00.ks'"
;;;@exlink txt="アレーナ" target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_04アレーナ_00.ks'"
;;;@exlink txt="みんな"   target="*go_scene" onenter="playSystemSound('sys_se_on')" exp="systemSE(18), tf.afterh='after_05ハーレム_00.ks'"
;;;@showexlink nosave=true

*restart
@unlocklink
@s


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
kag.rightClickHook.add(function(){kag.cancelAutoMode(); if(kag.inStable)if(askYesNo("アフターシーン画面に戻ります。￥ｎよろしいですか？",,%[check:"sysDialogReplayReturn"]))kag.process("title_after.ks", "*extra_return"); return true;});
kag.keyDownHook.clear();
kag.keyDownHook.add(gameKeyFunc);
// 前に戻る用変数の初期化
backPageArray.clear();
backPageNoSave = false;
@endscript

@setframe
@eval exp="kag.cancelSkip()"
@eval exp="tf.isEvMode = true"
@eval exp="tf.isAfterMode = true"
@jump storage="&tf.afterh"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; アフターストーリーＨシーンからの戻り処理
*extra_return
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@iscript
kag.rightClickHook.clear();
kag.keyDownHook.clear();
kag.messageLayer.clear(), kag.nameLayer.clear();
f.nowBgTime = 0;
exlink_object.endLink();
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
@eval exp="global.delayscript.clearEvent()"
@eval exp="kag.cancelSkip()"
@eval exp="tf.isEvMode = false"
@eval exp="tf.isAfterMode = false"
@jump target="*extra"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
;タイトルへの戻り
*back_title
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@locklink
@clearmessages
@unlocklink
@jump storage="title.ks" target="*extra_back"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; ゲーム終了
*close_window
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@close
@jump target="*restart"
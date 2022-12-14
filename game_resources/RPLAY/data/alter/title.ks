;デバッグフラグがＯＮなのを忘れないように設置。「tf.debugFlag」は「debugmode.tjs」に記述
@eval exp="global.info_object.start('デバッグフラグＯＮで起動しています', void, true)" cond=tf.debugFlag

;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; データの存在確認
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@iscript
//tf.hPatchExistence = Storages.isExistentStorage(System.exePath + "arc/sp_patch.xp3");
//if(tf.debugFlag)tf.hPatchExistence = true;
//if(!tf.hPatchExistence)sf.changeHDress = false;
@endscript


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; 「title.ks」で使用する関数の宣言
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@iscript
// システムテーマによるタイトル画面の背景設定
function titleBgChange(no=void){
	var file = "t_bg";

	if(no !== void){
		sysDesign = no;
		if(sysDesign == 1)tf.sysDesingRandom = intrandom(1,5);
	}
//	if(sysDesign == 0 || (sysDesign==1 && tf.sysDesingRandom==1))file = "t_bg";
//	if(sysDesign == 2 || (sysDesign==1 && tf.sysDesingRandom==2))file = "t_bg_舞";
//	if(sysDesign == 3 || (sysDesign==1 && tf.sysDesingRandom==3))file = "t_bg_澄怜";
//	if(sysDesign == 4 || (sysDesign==1 && tf.sysDesingRandom==4))file = "t_bg_洸";
//	if(sysDesign == 5 || (sysDesign==1 && tf.sysDesingRandom==5))file = "t_bg_透華";

	if(kag.mainConductor.curStorage == "title.ks"){
		var isFore = (no!==void);
		if(isFore){
			// コンフィグにて数値変更された場合の動作
			kag.fore.layers[0].loadImages(%[storage:file, visible:true, opacity:255, left:0, top:0]);
			kag.back.layers[0].assignComp();
			if(sysDesign == 0 || (sysDesign==1 && tf.sysDesingRandom==1)){
				kag.fore.layers[2].loadImages(%[storage:"t_logo", visible:true, opacity:255, left:55, top:468]);
				kag.back.layers[2].loadImages(%[storage:"t_logo", visible:true, opacity:255, left:55, top:468]);
			}else{
				kag.fore.layers[2].freeImage();
				kag.back.layers[2].freeImage();
			}
		}else{
			// タイトルにて普通に呼ばれた時の動作
			kag.back.layers[0].loadImages(%[storage:file, visible:true, opacity:255, left:0, top:0]);
			if(sysDesign == 0 || (sysDesign==1 && tf.sysDesingRandom==1))kag.back.layers[2].loadImages(%[storage:"t_logo", visible:true, opacity:255, left:42, top:489]);
			else kag.back.layers[2].freeImage();
		}
	}
}



// ボタンを動かす用のコード
function titleImgMover(start=3, end=7, move=10, time=300, delay=50){
	var target = kag.back.messages[0].links;

	for(var i=0; i<target.count; i++){
		if(typeof target[i].object != "undefined"){
			var obj = target[i].object;
			var opa = obj.opacity;
			obj.left -= move;
			obj.opacity = 0;
			obj.beginMove(%[path:obj.left+move+","+obj.top+","+opa, time:time, delay:(delay*i)]);
		}
	}
}
@endscript

;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; ムービー
;*title_movie
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
;@play_movie storage="op_movie.mpg" cond="sf.op_movie"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; オートコンティニュー
*title_auto_continue
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@jump target="*continue_load" cond="sf.autoContinue && Storages.isExistentStorage(getContinueBookMarkName())"

; 履歴の削除
@eval exp="clear_history()"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; ※起動時演出
*title_startup_production
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@bgm storage=bgm_01 cond="kag.bgm.currentBuffer.status != 'play'"

@jump target="*fstart"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; タイトル画面に戻ってきたときの初期化処理
*title_save|
*title_init
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

; 一つ前に戻るクリア
@eval exp="backPageArray.clear()"

; カレンダー辞書をクリア
;@eval exp="(Dictionary.clear incontextof calendarDataDic)()"
; ゲームクリアなどで戻ってきた際にコンティニュー用に保存→これはダメっぽい？タイトルに戻るボタンで来た時に二重に実行されてログが死ぬっぽい雰囲気
;@eval exp="saveBookMarkToFileNoThumbs(,true)"
[eval exp="global.delayscript.clearEvent()"]

; 立ち絵の色補正強度の変更をリセット
@clear_intensity
@bgv_all_stop
@mvse_stop
@backlay
@hide_miniface
@clear_face
;@rsmist
@lensflare_delete
@stopquake
@locklink
@gamebutton forevisible=false backvisible=false
;@gamebuttonmap backvisible=false
@info_stop

@iscript
// オートモード・スキップモードをオフに
kag.cancelSkip();
kag.cancelAutoMode();

// 文字レイヤーを隠す
kag.messageLayer.clear(), kag.nameLayer.clear();
kag.rightClickHook.clear();
kag.keyDownHook.clear();
exlink_object.endLink();

// イベントモード解除
tf.isEvMode = false;
f.isHScene  = 0;

//※立ち絵の色調補正フラグを強制的に『昼』に変更する
f.nowBgTime = 0;

// 立ち絵・EVCG強制変更モード解除
f.relpaceDressTarget = void;
f.addEvcgAlphabet    = void;
@endscript

;//↓プラグイン系の処理の削除 now=trueで即消し
@plugin_call name=onClearScreenChange
@stop_grain
@fobgm
@allstopsound

@clearmessages
@clearlayers
@locklink
@stoptrans

;@trans method=crossfade time=500
@ev_movie_stop time=500
@wt
;@title_swtalk

;BGM音量の一応の正規化
@sbgm
@eval exp="kag.bgm.setOptions(%[volume:100,gvolume:sysBgmVolume]);"

;// レイヤーの順番を元に戻す
@eval exp="kag.reorderLayers()"
@backlay

*fstart
; 履歴を禁止する
@history output=false enabled=false
@locklink
@clearlayers

@if exp="sysDesign == 1"
@eval exp="tf.sysDesingRandom = intrandom(1,5)"
@endif


@if exp=false
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; エクストラメニューからの戻り専用処理
*extra_back
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@eval exp="kag.rightClickHook.clear();"
@clearmessages
@clearlayers
@locklink
@endif


@if exp="tf.クリア"
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; ゲームクリア時の演出
*title_game_clear_production
@eval exp="tf.クリア = false"
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@endif


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; タイトル画面
*title_game_clear_production_skip
*title
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; BGM
@bgm storage=bgm_01 cond="kag.bgm.currentBuffer.status != 'play'"

@eval exp="kag.leftClickHook.clear();"
@ch_clear
@eff_all_delete

; 背景
;@eval exp="titleBgChange()"
@simg layer=0 page=back storage=t_bg index=1000
@simg layer=1 page=back storage=mv_chara1 index=1100 left=-149 top=0
@simg layer=2 page=back storage=mv_chara2 index=1200 left=370 top=0

;========================================
; タイトル演出
;----------------------------------------
@move page=back layer=1 path=(0,0,255) time=1000 accel=-2
@move page=back layer=2 path=(220,0,255) time=1000 accel=-2
@trans method=crossfade time=500
@wm
@stopmove
@stoptrans
; ロゴ
@eff obj=0 page=back show=true storage=t_logo1 path=(55,418,0)(55,468,255) time=1000 accel=-2 lu_corner=true absolute=(8000)
@eff obj=1 page=back show=true storage=t_logo2 path=(126,622,0)(126,572,255) time=1000 accel=-2 lu_corner=true absolute=(8100)
; 体験版ロゴ
;//@eff obj=2 page=back show=true storage=t_logo_trial path=(175,365,0)(175,415,255) time=1000 accel=-2 lu_corner=true absolute=(8200)
; バージョン情報
@simg layer=5 page=back storage=t_version index=7000 left=0 top=646 opacity=0
@eval exp="numberImgDraw(kag.back.layers[5], appVer, 125, 133, 't_num_ver', 11, 0)"
@move layer=5 page=back path=(0,546,255) time=1000 accel=-2
;========================================

;==========================================================================
@position layer=message0 page=back frame="" left=0 top=0 width="&kag.scWidth" height="&kag.scHeight" visible=true opacity=0 marginl=0 marginr=0 margint=0 marginb=0
@eval exp="kag.fore.messages[0].opacity=kag.back.messages[0].opacity=255"
@current layer=message0 page=back
@er
@nowait

;//出現するボタンによってパターン分け
@eval exp="tf.showExtra = 1"
@eval exp="tf.showQuick = (kag.bookMarkDates[defQuickSaveNum] != '' && kag.bookMarkDates[defQuickSaveNum] !== void)"
@eval exp="tf.showContinue = Storages.isExistentStorage( getContinueBookMarkName() )"

@btt x=528  y=561 graphic=t_continue target="*continue_load" onenter="playSystemSound('sys_se_on')" cond="tf.showContinue"
@btt x=724  y=561 graphic=t_start    target="*start_game"    onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=882  y=561 graphic=t_load                             onenter="playSystemSound('sys_se_on')" exp="if(kag.inStable)kag.callExtraConductor('saveload.ks','*loadbytitle')"
@btt x=751  y=627 graphic=t_config                           onenter="playSystemSound('sys_se_on')" exp="if(kag.inStable)kag.callExtraConductor('config.ks','*showTitleConfig')" 
@btt x=884 y=627 graphic=t_extra    target="*extra"         onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')" off="!tf.showExtra"
@btt x=1020 y=627 graphic=t_exit     target="*close_window"  onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=1030 y=557 graphic=t_qload    target="*qload"         onenter="playSystemSound('sys_se_on')" cond="tf.showQuick"

;//体験版Hシーン
;///@btt x=1066 y=237 graphic=trial_btn1     target="*start_game_ex"  onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok'), tf.extraFile='102_聖良サキュ_02_h.ks' , tf.extraTarget='*h_scene_111'"
;///@btt x=1066 y=396 graphic=trial_btn2     target="*start_game_ex"  onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok'), tf.extraFile='203_莉瑠メイド_02_h.ks' , tf.extraTarget='*h_scene_208'"

; デバッグモードのみで動く言語切り替えのサンプル
@call storage="title_lang.ks" cond="tf.debugFlag"

@eval exp="titleImgMover(0, kag.back.messages[0].links.count, 40,, 80)"
@endnowait
@locklink

; タイトルコール
@eval exp="try{ systemSE(defTitleCall); }catch(e){ dm(e.message); }"
@freeimage layer=1 page=back
@freeimage layer=2 page=back
; キャラ画像をeffから通常レイヤーに移行
@simg layer=0 page=back storage=t_mbg time=1000
@trans method=crossfade time=500
@weff obj=0
@aseff
@stopmove
@stoptrans

@iscript
{
	var target = kag.fore.messages[0].links;
	for(var i=0; i<target.count; i++){
		if(typeof target[i].object != "undefined")target[i].object.stopMove();
	}
}
@endscript

@backlay
;@simg layer=6 page=back storage=t_logo3 index=8200 left=97 top=542
@eff_all_delete
; ロゴ正式設置
;//@simg layer=6 page=back storage=t_logo_trial left=175 top=415 index=8200
@simg layer=7 page=back storage=t_logo left=55 top=468 index=8000
@extrans rule=rule_00_l_r
*restart
@unlocklink
@s
@jump storage="title.ks" target="*restart"




;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; ゲームスタート
*start_game
@eval exp="tf.extraFile = void"
@eval exp="tf.extraTarget = void"
*start_game_ex
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@stop_grain
@eff_all_delete
@clearlayers
@clearmessages
@extrans

@wvo

; ラブリーコール・難易度などを設定
;@jump storage="menu_startup.ks"
;*title_init_return

; 初期化
@call storage="gameinit.ks"


;==============================
;初回時処理
;------------------------------
@if exp="!sf.firstTitle"
@iscript
sf.firstTitle = true;
@endscript
@endif
;==============================


@fobgm time=1000
@eff_all_delete
@clearlayers
@clearmessages
@simg storage=black page=back
@enable_face
@extrans time=1000
@wbgm

@history output=true enabled=true

@setframe
@eval exp="kag.cancelSkip()"
;↓今回は使用しない(purelly x cation用)
;@eval exp="sf.initPlayerStatus = true"
@if exp="tf.extraFile !== void"
@iscript
tf.isEvMode = true;
kag.rightClickHook.clear();
kag.rightClickHook.add(
	function(){
		kag.cancelAutoMode();
		if(kag.inStable){
			if(!sysDialogReplayReturn || askYesNo(LoadString("dlgBackTitle"),,%[check:"sysDialogBackTitle"])){
				kag.process("title.ks", "*title_init");
			}
		}
		return true;
	}
);
@endscript
@endif
;//体験版用Hシーンジャンプ
@jump storage="&tf.extraFile" target="&tf.extraTarget" cond="tf.extraFile !== void"
@jump storage="000_共通_00.ks"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
;クイックロード
*qload
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@load ask=false place="&defQuickSaveNum"
@s


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; 最新のセーブデータをロード
*newest_load
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@load ask=false place="&sf.newest_save"
@s


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; 前回ゲームを終了した時のセーブデータをロード
*continue_load
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@restartgame
@s


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; 体験版エクストラ
*extra_trial
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@jump storage="title_trial.ks"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; エクストラ画面
*extra
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@eff_all_delete
; システムコール
@eval exp="try{ systemSE(defCallExtra); }catch(e){ dm(e.message); }"

;シーンリプレイ直前にシナリオ本編のバックログを削除しておく
@eval exp="clear_history()"

; 背景/背景2/キャラ
@simg layer=0 page=back storage=t_mbg visible=true opacity=255 index=5000
; バージョン情報
@simg layer=5 page=back storage=t_version left=0 top=546 index=7000
@eval exp="numberImgDraw(kag.back.layers[5], appVer, 125, 133, 't_num_ver', 11, 0)"
; ロゴ
@simg layer=7 page=back storage=t_logo left=55 top=468 index=8000
;//@simg layer=6 page=back storage=t_logo_trial left=175 top=415 index=8200

@position layer=message0 page=back frame="" left=0 top=0 width="&kag.scWidth" height="&kag.scHeight" visible=true opacity=0 marginl=0 marginr=0 margint=0 marginb=0
@eval exp="kag.fore.messages[0].opacity=kag.back.messages[0].opacity=255"
@current layer=message0 page=back
@er
@nowait


@btt x=519  y=561 graphic=t_ex_cg      storage="ex_cg.ks"     onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=660  y=561 graphic=t_ex_replay  storage="ex_replay.ks" onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=816  y=561 graphic=t_ex_anime   storage="ex_anime.ks"  onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=1001 y=561 graphic=t_ex_sound   storage="ex_sound.ks"  onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=651  y=627 graphic=t_ex_stand   storage="ex_stand.ks"  onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=823  y=627 graphic=t_ex_onasapo storage="ex_onasup.ks" onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"
@btt x=1007 y=627 graphic=t_ex_back    target="*extra_back"   onenter="playSystemSound('sys_se_on')" exp="playSystemSound('sys_se_ok')"

@endnowait
@locklink
@extrans
@unlocklink
@iscript
kag.rightClickHook.clear();
kag.rightClickHook.add(function(){kag.process("","*extra_back");});
@endscript
@s
@jump target="*extra"

;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; アフターストーリー
*extra_after
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@jump storage="title_after.ks"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; ムービー再生テスト
*extra_movie
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@fobgm time=1000
@clearlayers
@clearmessages
@extrans
@play_movie storage="op_movie.mpg"
@jump target="*extra"


;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; ゲーム終了
*close_window
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@close
@jump target="*restart"


*close_noask
@iscript
kag.leftClickHook.clear();
kag.rightClickHook.clear();
kag.keyDownHook.clear();
try{
	// ゲーム画面以外を全部消す
	var cld = kag.primaryLayer.children;
	for(var i=0; i<cld.count; i++){
		var tar = cld[i];
		if(tar != kag.fore.base &&
			tar != kag.back.base &&
			tar != kag.primaryLayer2){
				tar.visible = false;
		}
	}
}catch(e){
	dm("各種ウィンドウクローズ失敗");
}

{
	// tryで全部くるむと途中でエラー吐いたらその先実行されないから停止関数準備
	var stopFunc = function(func){ try{ func!; }catch(e){ dm("プラグインの停止に失敗："+func); } };
	stopFunc("global.grain_object.stopGrain();");	// パーティクル
	stopFunc("global.gameButton_object.setOptions(%[backvisible:false]);");	// ゲーム中のボタン
	//stopFunc("global.gameButtonMap_object.setOptions(%[backvisible:false]);");	// ゲーム中のボタン
	//stopFunc("global.light_eff_object.readyStop();");	// leff
	stopFunc("global.effAllDeleteFunction();");			// eff
	stopFunc("global.delayscript.clearEvent();");		// ディレイスクリプト
	stopFunc("global.lensfalre_object.Unvisible();");	// レンズフレア
	stopFunc("exlink_object.endLink();");		// 選択肢
	stopFunc("global.bgv_object.allStop();");	// BGM

	stopFunc("global.miniface_object.hideMainFace()"); // miniFace
}

tf.noCtrlSkip = true;	// スキップ禁止
kag.cancelSkip();
// 文字レイヤーを隠す
kag.messageLayer.clear(), kag.nameLayer.clear();
kag.rightClickHook.clear();
kag.keyDownHook.clear();
// イベントモード解除
tf.isEvMode = false;
@endscript
@stopquake
@locklink
@allstopsound
;//↓プラグイン系の処理の削除 now=trueで即消し
@plugin_call name=onClearScreenChange
;e-mote生成されてなかったらマクロもない(clearlayersで呼ばれる)
@if exp="typeof global.emote_player_object == 'undefined'"
[macro name="emotestop"][endmacro]
@endif
@clearmessages
@clearlayers
;@hide_miniface
@clear_face
@stoptrans
; 終了コール
@eval exp="try{ systemSE(defExitCall); }catch(e){ dm(e.message); }"
@trans method=crossfade time=500
@wt
@wvo
@wse buf="&kag.se.count-2"
; 動画の終了
@if exp="kag.mainConductor.macros['ev_movie_stop'] !== void"
@ev_movie_stop time=1
@endif
;即終了に変更
@close ask=false
@s

@jump target="*restart"
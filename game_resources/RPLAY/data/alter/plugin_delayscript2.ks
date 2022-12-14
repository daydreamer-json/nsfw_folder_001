
@if exp="typeof(global.delayscript) == 'undefined'"
@iscript

// イベント一つ分のクラス
// 基本はタイマー来たら登録された関数発行するだけ
class DelayEvent
{
	var timer;
	var param = %[];
	var doFunc;
	var setFile = "";
	var scriptName = "";	// スクリプト名の記録

	function DelayEvent(elm, func, delay)
	{
		if(delay == 0)delay = 1000;		// 時間0だとタイマーは動かない
		doFunc = func;
		setFile = kag.conductor.curStorage;	// セットされた時のファイルを覚えておく
		timer = new Timer(onTimer, "");
		timer.interval = delay;
		timer.enabled = true;
		(Dictionary.assign incontextof param)(elm);
	}

	function finalize()
	{
		timer.enabled = false;
		invalidate timer;
	}

	function onTimer()
	{
		timer.enabled = false;
		// セットされた時と実行時のファイルが違ったら破棄
		//if(setFile != kag.conductor.curStorage)return false;
		// タイトルだったら破棄に変更・コンフィグ開いてる時に動かない
//		if(setFile == "title.ks")return false;
		var re = doFunc(param);
		// 0以上の時間が帰ってきたらセットしなおしてもっかい実行
		if(re > 0){
			timer.interval = re;
			timer.enabled = true;
		}
	}
}

// 遅延スクリプトメインのクラス
class DelayScriptPlugin extends KAGPlugin
{
	var eventArray = [];
	var storeArray = [];
	var addTime = 0;	// スクリプトが登録される際に強制付加される時間

	function DelayScriptPlugin()
	{
		super.KAGPlugin();
		eventArray.clear();
	}

	function finalize()
	{
		clearEvent();
		super.finalize();
	}

	// イベントの追加
	function addEvent(elm, func)
	{
		if(elm.delay === void || elm.delay == "0")elm.delay = 1000;
		if(addTime != 0)elm.delay = (+elm.delay) + addTime;
		eventArray.add(new DelayEvent(elm, func!, +elm.delay));
		eventArray[-1].scriptName = func;

		elm["func"] = func;
		var index = storeArray.add(%[]);
		(Dictionary.assign incontextof storeArray[index])(elm);
		return true;
	}

	// 全イベントの破棄
	function clearEvent()
	{
		for(var i=0; i<eventArray.count; i++){
			invalidate eventArray[i];
		}
		eventArray.clear();
		storeArray.clear();
	}

	// イベントのスキップ、すでに発行されたものも含めてキャラ設置マクロのみ連続実行
	// →すでに発行されたものはスキップしないように調整してみた。様子見
	function skipEvent()
	{
		addTime = 0;		// 強制付加する時間をクリア
		var skiped = false;
		var backlayOnce = false;
		for(var i=0; i<eventArray.count; i++){
			var tar = eventArray[i];
			if(tar.timer.enabled){		// 動いているもののみがスキップ対象
				if(!backlayOnce){
					// イベントのスキップが発生する際、一度だけ全レイヤーの裏へのコピーを行う
					backlayOnce = true;
					kag.tagHandlers.backlay(%[]);
				}
				if(tar.scriptName == "macro_chr"){
					skiped = true;
					mpExpansion(tar.param);
					setCharacter(tar.param);
					tar.timer.enabled = false;
					// ミニ表情の変更
					if(f.speaker!=void && f.speaker!='' && sysFaceVisible && f.frameType != 'novel'){
						tar.param.storage = f[f.speaker];
						miniface_object.showMainFace(tar.param);
					}
				}else if(tar.scriptName == "macro_chr_del"){
					skiped = true;
					characterDelete(tar.param.name,,tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_chr_del_walk"){
					skiped = true;
					macro_chr_del_walk(tar.param);
					kag.stopAllMoves();
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_chr_del_dash"){
					skiped = true;
					macro_chr_del_dash(tar.param);
					kag.stopAllMoves();
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_chr_del_jump"){
					skiped = true;
					macro_chr_del_jump(tar.param);
					kag.stopAllMoves();
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_chr_del_down"){
					skiped = true;
					macro_chr_del_down(tar.param);
					kag.stopAllMoves();
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_chr_poschange"){
					skiped = true;
					macro_chr_poschange(tar.param);
					kag.stopAllMoves();
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_face"){
					skiped = true;
					macro_face(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_simg"){
					skiped = true;
					macro_simg(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_freeimage"){
					skiped = true;
					macro_freeimage(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_ev"){
					skiped = true;
					macro_ev(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_bgm"){
					skiped = true;
					macro_bgm(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_fibgm"){
					skiped = true;
					macro_fibgm(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_xbgm"){
					skiped = true;
					macro_xbgm(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_sbgm"){
					skiped = true;
					macro_sbgm(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_fobgm"){
					skiped = true;
					macro_fobgm(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_change_eff"){
					skiped = true;
					macro_change_eff(tar.param);
					tar.timer.enabled = false;
				}else if(tar.scriptName == "macro_echr"){
					skiped = true;
					macro_echr(tar.param, true);
					tar.timer.enabled = false;
				}
			}
		}
		return skiped;
	}

	// ================================================
	// イベントから呼ばれる関数
	// ================================================
	function macro_chr(elm)
	{
		// キャラの変更は座標移動を伴うので移動中に呼ばれてはならない
		if(kag.moveCount != 0){
			var _time = 0;
			for(var i=0; i<kag.fore.layers.count; i++){
				if(kag.fore.layers[i].moveObject !== void){
					var tar = kag.fore.layers[i].moveObject;
					var tmp_time;
					// 1回も動いてなかったらstartTickは空なので全体時間そのままを待つ
					// そうでなければ残り時間の分だけ再度待つ
					if(tar.startTick === void)tmp_time = kag.fore.layers[i].moveObject.totalTime;
					else tmp_time = kag.fore.layers[i].moveObject.totalTime - (System.getTickCount()-kag.fore.layers[i].moveObject.startTick);
					if(tmp_time > _time){
						_time = tmp_time;
					}
				}
			}
			if(_time == 0)_time = 50;
			return _time;
		}

		if(elm.time === void)elm.time = 250;
		elm.method = "crossfade";
		kag.fore.base.stopTransition();
		kag.tagHandlers.backlay(%[]);
		mpExpansion(elm);
		setCharacter(elm);
		kag.fore.base.beginTransition(elm);
		// ミニ表情の変更
		if(f.speaker!=void && f.speaker!='' && f.speaking && sysFaceVisible && f.frameType != 'novel'){
			for(var i=0; i<tf.fp.count; i++){
				if(ies(tf.fp[i])){
					if(tf.fp[i].length >= 4){
						var name = characterNumToName[getChrNo(tf.fp[i])];// ロード対象ファイル名
						if(f.speaker == name){
							elm.storage = tf.fp[i];
							dm(elm.storage);
							miniface_object.showMainFace(elm);
						}
					}
				}
			}
		}
	}
	function macro_echr(elm, skipped=false)
	{
		var isBack = loadEmote(elm.tar, elm);
		if(elm.time === void)elm.time = 300;
		if(kag.se[kag.se.count-2].status == "play" && elm.talk !== void && !elm.talk_force)delete elm.talk;

		if(skipped){
			// スキップの時は裏画面に調整を入れて帰るだけ
			elm.time = 0;
			elm.skip = true;
			readyEmote(elm, true);
		}else{
			// アニメーションがOFFの時は強制裏
			if(!sysEmoteAnim){
				isBack = true;
				elm.time = 0;
			}
			if(isBack)kag.fore.base.stopTransition();
			readyEmote(elm, isBack);
			if(isBack)kag.fore.base.beginTransition(%[method:"crossfade", time:elm.ttime === void ? 400 : +elm.ttime]);
		}
	}
	function macro_chr_jump(elm)
	{
		characterJump(elm.name, elm.time);
	}
	function macro_chr_quake(elm)
	{
		elm.pos = characterToLayer(elm.name);
		kag.doQuake(elm);
	}
	function macro_chr_shake(elm)
	{
		elm.pos = characterToLayer(elm.name);
		elm.x = 3;
		elm.y = 2;
		elm.loop = "true";
		kag.doQuake(elm);
	}
	function macro_chr_bow(elm)
	{
		if(elm.time === void)elm.time = 700;
		elm.sx = 0;
		elm.xcnt = 0;
		if(elm.sy === void)elm.sy = 10;
		elm.ycnt = 1;
		macro_chr_quake(elm);
	}

	function macro_characterJump(elm)
	{
		for(var i=1, j=0; i<=elm.name.length; i++){
			if(characterNameToNum[elm.name.substr(j,i-j)]!==void){
				var index = findCharacter(characterNameToNum[elm.name.substr(j,i-j)]);
				if(index == -1)return;	// その立ち絵は存在していない
				var target=kag.fore.layers[f.showingLayer[index]];
				var path = '('+target.left+','+(target.top-30)+',255)('+target.left+','+target.top+',255)';
				target.beginMove(%[time:elm.time === void ? 100 : (+elm.time), path:path]);
				j = i;
			}
		}
	}

	function macro_chr_del(elm)
	{
		kag.fore.base.stopTransition();
		kag.tagHandlers.backlay(%[]);
		characterDelete(elm.name,,elm);
		if(elm.time === void)elm.time = 250;
		elm.method = "crossfade";
		kag.fore.base.beginTransition(elm);
	}
	function macro_chr_del_walk(elm){characterDelete(elm.name, "walk", elm);}
	function macro_chr_del_dash(elm){characterDelete(elm.name, "dash", elm);}
	function macro_chr_del_jump(elm){elm.way="u", characterDelete(elm.name, "", elm);}
	function macro_chr_del_down(elm){elm.way="d", characterDelete(elm.name, "", elm);}
	function macro_chr_poschange(elm)
	{
		mpExpansion(elm);
		dcharacterPosChange(elm);
	}

	function macro_deevcg(elm)
	{
		if(elm.time === void)elm.time = 500;
		var needTrans = evcgEmote(elm);
		emoteEvctTimeline(elm.style, needTrans ? 'back' : 'fore', elm.ttime !== void ? (+elm.ttime) : 1500);
		if(needTrans){
			kag.fore.base.stopTransition();
			kag.fore.base.beginTransition(elm);
		}
	}
	
	//∇赤嶺記述
	function macro_simg(elm){
		//dm("delay:"+elm.delay);
		kag.getLayerFromElm(elm).loadImages(elm);
		kag.getLayerFromElm(elm).visible = true;
	}

	function macro_freeimage(elm){
		//dm("ddelay:"+elm.delay);
		kag.getLayerFromElm(elm).visible = false;
		kag.getLayerFromElm(elm).freeImage(elm);
	}

	function macro_ev(elm){
		kag.fore.base.stopTransition();
		elm.page="back";
		elm.layer="0";
		if(elm.sepia == "true"){
			elm.grayscale=true;
			elm.rgamma=1.3;
			elm.ggamma=1.1;
			elm.bgamma=1.0;
		}
		kag.tagHandlers.backlay(%[]);
		for(var i=0; i<kag.back.layers.count; i++)kag.back.layers[i].freeImage();
		//emoteFullClear();
		f.emoteEvcg = void;
		clearFace();
		f.cameraAngle = [0, 0];
		characterInfoClear();
		reorderBackLayers();
		if(!sysDoCgFade)elm.time = 1;
		
		//reorderBackLayers();		// ディレイではリオーダーしない
		kag.getLayerFromElm(elm).loadImages(elm);
		kag.getLayerFromElm(elm).visible = true;
		setCgVer(elm.storage);		// evcgのシステムフラグを立てる
		if(elm.time === void)elm.time = 500;
		if(elm.rule === void){
			elm.method = "crossfade";
		}else{
			elm.method = "universal";
		}
		kag.fore.base.beginTransition(elm);
	}

	function macro_bgm(elm){
		f.pausedStorage = void;
		f.pausedTime = 0;
		if(kag.bgm.playingStorage != elm.storage){
			if(elm.loop === void){ elm.loop = true;}
			kag.bgm.play(elm);
    	    kag.clearBgmStop();
       	 	kag.clearBgmLabel();
		}
		
		if(elm.storage !== void && elm.storage !='' && sysShowBgmTitle){
			if(elm.notitle === void){
				global.info_object.setOption(elm);
				showBgmTitle(elm);
			}
		}
	}
	
	function macro_fibgm(elm){
		f.pausedStorage = void;
		f.pausedTime = 0;
		if(elm.time === void) elm.time = 2000;
		kag.bgm.fadeIn(elm);
		if(elm.storage == '') elm.storage = void;
		if(elm.storage !== void && elm.storage != '' && sysShowBgmTitle){
			var bgmtitle = bgmTitleList[elm.storage];
			if(bgmtitle !== void){
				global.info_object.setOption(%[title:bgmtitle]);
				global.info_object.start(%[title:bgmtitle]);
			}
		}
	}

	function macro_xbgm(elm){
		
		f.pausedStorage = void;
		f.pausedTime = 0;
		
		kag.waitBGMFade();
		
		if(elm.time === void) elm.time = "2000";
		if(elm.overlap === void) elm.overlap = "2000";
		
		kag.bgm.exchange(elm);
        kag.clearBgmStop();
        kag.clearBgmLabel();
		
		if(elm.storage == '') elm.storage = void;
		
		if(elm.storage !== void && elm.storage != '' && sysShowBgmTitle){
			var bgmtitle = bgmTitleList[elm.storage];
			if(bgmtitle !== void){
				global.info_object.setOption(%[title:bgmtitle]);
				global.info_object.start(%[title:bgmtitle]);
			}
		}
	}

	function macro_sbgm(elm){ kag.bgm.stop();}
	
	function macro_fobgm(elm){ kag.bgm.fadeOut(elm);}
	
	//∇ここまで
	
	function macro_se(elm)
	{
		if(Storages.isExistentStorage(elm.storage+'.wav.sli') || Storages.isExistentStorage(elm.storage+'.ogg.sli'))
			elm.loop = 'true';
		if(Storages.isExistentStorage(elm.storage+'.wav') || Storages.isExistentStorage(elm.storage+'.ogg'))
			kag.se[+elm.buf].play(elm);
	}
	function macro_fise(elm)
	{
		if(elm.time === void)elm.time = 500;
		if(Storages.isExistentStorage(elm.storage+'.wav.sli') || Storages.isExistentStorage(elm.storage+'.ogg.sli'))
			elm.loop = 'true';
		if(Storages.isExistentStorage(elm.storage+'.wav') || Storages.isExistentStorage(elm.storage+'.ogg'))
			kag.se[+elm.buf].fadeIn(elm);
	}
	function macro_face(elm)
	{
		// ミニ表情の変更
		if(/*f.speaker!=void && f.speaker!='' && */sysFaceVisible && f.frameType != 'novel'){
			if(elm.s !== void) elm.storage = elm.s;
			
			if(elm.storage !== void){
				saveFace(elm.storage);
				miniface_object.showMainFace(elm);
			}
		}
	}

	function macro_begin_Transition(elm){
		if(elm.time === void)elm.time = 250;
		if(elm.rule !== void){elm.method = "universal";
		}else if(elm.method === void){elm.method = "crossfade";}
		kag.fore.base.stopTransition();
		kag.fore.base.beginTransition(elm);
	}
	
	function macro_quake(elm){	kag.doQuake(elm);	}
	// プリセット付きクエイクマクロ用の統合関数・非スムーズ版
	function macro_preMacroQuake(elm, x, y, t, msg=false){
		elm.x = x;
		elm.y = y;
		if(elm.time === void)elm.time = t;
		if(msg)elm.msg="true";
		kag.doQuake(elm);
	}
	// プリセット付きクエイクマクロ用の統合関数・スムーズ版
	function macro_preMacroSQuake(elm, sx, sy, xcnt, ycnt, t, msg=false){
		elm.sx = sx;
		elm.sy = sy;
		elm.xcnt = xcnt;
		elm.ycnt = ycnt;
		if(elm.time === void)elm.time = t;
		if(msg)elm.msg="true";
		kag.doQuake(elm);
	}
	// プリセット付きクエイク
	function macro_q_big(elm){		macro_preMacroQuake(elm, 50, 50, 350);}
	function macro_q_normal(elm){	macro_preMacroQuake(elm, 15, 15, 350);}
	function macro_q_small(elm){	macro_preMacroQuake(elm, 5, 5, 350);}
	function macro_mq_big(elm){		macro_preMacroQuake(elm, 50, 50, 300, true);}
	function macro_mq_normal(elm){	macro_preMacroQuake(elm, 20, 20, 300, true);}
	function macro_mq_small(elm){	macro_preMacroSQuake(elm, 5, 5, 9, 3, 300, true);}
	function macro_sqlr_big(elm){	macro_preMacroSQuake(elm, 50, 0, 4, 0, 1000);}
	function macro_sqlr_normal(elm){macro_preMacroSQuake(elm, 30, 0, 4, 0, 1000);}
	function macro_sqlr_small(elm){	macro_preMacroSQuake(elm, 10, 0, 4, 0, 1000);}
	function macro_squd_big(elm){	macro_preMacroSQuake(elm, 0, 50, 0, 4, 1000);}
	function macro_squd_normal(elm){macro_preMacroSQuake(elm, 0, 30, 0, 4, 1000);}
	function macro_squd_small(elm){	macro_preMacroSQuake(elm, 0, 10, 0, 4, 1000);}
	// ================================================
	// イベントから呼ばれる関数ここまで
	// ================================================

	// トランジションが終わった時についでに動作し終わっているものを破棄する
	function onExchangeForeBack(){
		for(var i=eventArray.count-1; i>=0; i--){
			if(!eventArray[i].timer.enabled){
				invalidate eventArray[i];
				eventArray.erase(i);
			}
		}
	}

	function onStore(f, elm)
	{
		if(storeArray.count != 0){
			if(f["dscript"] === void)f["dscript"] = [];
			f["dscript"].clear();
			var dic = f["dscript"];
			dic.assignStruct(storeArray);
		}
	}

	function onRestore(f, clear, elm)
	{
		// ロード時は全破棄
		addTime = 0;
		clearEvent();
		if(f["dscript"]){
			var dic = f["dscript"];
			for(var i=0; i<dic.count; i++){
				addEvent(dic[i], dic[i]["func"]);
			}
		}
	}
}

kag.addPlugin(global.delayscript = new DelayScriptPlugin());

@endscript
@endif

[macro name="dchr"]			[eval exp="global.delayscript.addEvent(mp, 'macro_chr')"][endmacro]
[macro name="dchr_del"]		[eval exp="global.delayscript.addEvent(mp, 'macro_chr_del')"][endmacro]
; ※このスクリプトを使った直後に新規立ち絵の命令(dchr)を使用するのは現状では禁止。
[macro name="dchr_del_walk"][eval exp="global.delayscript.addEvent(mp, 'macro_chr_del_walk')"][endmacro]
[macro name="dchr_del_dash"][eval exp="global.delayscript.addEvent(mp, 'macro_chr_del_dash')"][endmacro]
[macro name="dchr_del_jump"][eval exp="global.delayscript.addEvent(mp, 'macro_chr_del_jump')"][endmacro]
[macro name="dchr_del_down"][eval exp="global.delayscript.addEvent(mp, 'macro_chr_del_down')"][endmacro]
; ※ここまで
[macro name="dchr_quake"]	[eval exp="global.delayscript.addEvent(mp, 'macro_chr_quake')"][endmacro]
[macro name="dchr_shake"]	[eval exp="global.delayscript.addEvent(mp, 'macro_chr_shake')"][endmacro]
[macro name="dchr_bow"]		[eval exp="global.delayscript.addEvent(mp, 'macro_chr_bow')"][endmacro]
[macro name="dchr_poschange"][eval exp="global.delayscript.addEvent(mp, 'macro_chr_poschange')"][endmacro]
[macro name="dse"]			[eval exp="global.delayscript.addEvent(mp, 'macro_se')"][endmacro]
[macro name="dfise"]		[eval exp="global.delayscript.addEvent(mp, 'macro_fise')"][endmacro]
[macro name="dchr_jump"]	[eval exp="global.delayscript.addEvent(mp, 'macro_characterJump')"][endmacro]

[macro name="dface"]		[eval exp="global.delayscript.addEvent(mp, 'macro_face')"][endmacro]
[macro name="dquake"]		[eval exp="global.delayscript.addEvent(mp, 'macro_quake')"][endmacro]
[macro name="dq_big"]		[eval exp="global.delayscript.addEvent(mp, 'macro_q_big')"][endmacro]
[macro name="dq_normal"]	[eval exp="global.delayscript.addEvent(mp, 'macro_q_normal')"][endmacro]
[macro name="dq_small"]		[eval exp="global.delayscript.addEvent(mp, 'macro_q_small')"][endmacro]
[macro name="dmq_big"]		[eval exp="global.delayscript.addEvent(mp, 'macro_mq_big')"][endmacro]
[macro name="dmq_normal"]	[eval exp="global.delayscript.addEvent(mp, 'macro_mq_normal')"][endmacro]
[macro name="dmq_small"]	[eval exp="global.delayscript.addEvent(mp, 'macro_mq_small')"][endmacro]
[macro name="dsqlr_big"]	[eval exp="global.delayscript.addEvent(mp, 'macro_sqlr_big')"][endmacro]
[macro name="dsqlr_normal"]	[eval exp="global.delayscript.addEvent(mp, 'macro_sqlr_normal')"][endmacro]
[macro name="dsqlr_small"]	[eval exp="global.delayscript.addEvent(mp, 'macro_sqlr_small')"][endmacro]
[macro name="dsqud_big"]	[eval exp="global.delayscript.addEvent(mp, 'macro_squd_big')"][endmacro]
[macro name="dsqud_normal"]	[eval exp="global.delayscript.addEvent(mp, 'macro_squd_normal')"][endmacro]
[macro name="dsqud_small"]	[eval exp="global.delayscript.addEvent(mp, 'macro_squd_small')"][endmacro]

[macro name="dextrans"]		[eval exp="global.delayscript.addEvent(mp, 'macro_begin_Transition')"][endmacro]
[macro name="dclear"]		[eval exp="global.delayscript.clearEvent()"][endmacro]

[macro name="dsimg"]		[eval exp="global.delayscript.addEvent(mp, 'macro_simg')"][endmacro]
[macro name="dfreeimage"]	[eval exp="global.delayscript.addEvent(mp, 'macro_freeimage')"][endmacro]
[macro name="dev"]			[eval exp="global.delayscript.addEvent(mp, 'macro_ev')"][endmacro]

; bgmのディレイスクリプト
[macro name="dbgm"]		[eval exp="global.delayscript.addEvent(mp, 'macro_bgm')"][endmacro]
[macro name="dfibgm"]	[eval exp="global.delayscript.addEvent(mp, 'macro_fibgm')"][endmacro]
[macro name="dxbgm"]	[eval exp="global.delayscript.addEvent(mp, 'macro_xbgm')"][endmacro]
[macro name="dsbgm"]	[eval exp="global.delayscript.addEvent(mp, 'macro_sbgm')"][endmacro]
[macro name="dfobgm"]	[eval exp="global.delayscript.addEvent(mp, 'macro_fobgm')"][endmacro]

; EVCG_E-moteのディレイ
;[macro name="deevcg"]	[eval exp="global.delayscript.addEvent(mp, 'macro_deevcg')"][endmacro]

; e-moteのディレイスクリプト
[macro name="dechr"]		[eval exp="global.delayscript.addEvent(mp, 'macro_echr')"][endmacro]
; delayにスキップマクロを通過するまでラブリーコール分の時間を付加するマクロ
@iscript
function addLovelyCallTimeForDelayScript(_elm = %[]){
	var elm = %[];
	(Dictionary.assign incontextof elm)(_elm);
	var ies = Storages.isExistentStorage;
	if(elm.type === void)elm.type = "日常";
	if(elm.name === void)elm.name = characterList[0];
	if(elm.wait === void)elm.wait = 0;
	try{
		var lc = getNickNameVoice(elm.type, elm.name);
		var buf = kag.se[kag.se.count-3];
		buf.setOptions(%[volume:0]);
		buf.play(%[storage:lc]);	// 再生しないと総時間は取れない
		buf.stop();
		buf.setOptions(%[volume:100]);
		var tt = buf.totalTime + (+elm.wait);
		global.delayscript.addTime = tt;
	}catch(e){
		if(typeof global.delayscript != "undefined")global.delayscript.addTime = 0;
		dm("DelayScriptの待ち時間にLC時間を加算できませんでした");
	}
}
@endscript
[macro name="add_lctime"][eval exp="addLovelyCallTimeForDelayScript(mp)"][endmacro]

@macro name="delay_script_skip"
@stoptrans
@trans method=crossfade time=1 cond="global.delayscript.skipEvent()"
;@eval exp="global.delayscript.skipEvent()"
[eval exp="global.delayscript.clearEvent()"]
@stoptrans
@stopmove
@endmacro

@return

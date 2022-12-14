@if exp="typeof(global.config_object) == 'undefined'"
@iscript

Scripts.execStorage("config_setting.tjs");

// ボイステスト及び個別ボイスのテスト用関数
function _playVoiceForConfig(chr = void)
{
	_stopTestVoice();	// 他のテスト音を停止
	kag.cancelSkip();	// スキップ停止

	var list = [];
	list.assign(configTestVoiceList);
	var index = (chr === void ? -1 : list.find(chr));

	if(index != -1)		// キャラ指定で再生
		playVoice(list[index + 1], void, kag.numSEBuffers-4 );
	else				// ランダムで再生(ボイス全体の音量)
		playVoice(list[intrandom(0, (list.count\2-1)) * 2 + 1], void, kag.numSEBuffers-2, 100);
}

// SEテスト
function _playSoundForConfig()
{
	_stopTestVoice();	// 他のテスト音を停止
	kag.cancelSkip();	// スキップ停止
	playSound(configTestSeList[intrandom(0,configTestSeList.count-1)]);
}

// HSEテスト
function _playHSoundForConfig()
{
	_stopTestVoice();	// 他のテスト音を停止
	kag.cancelSkip();	// スキップ停止
	playHSound(configTestHSeList[intrandom(0,configTestHSeList.count-1)]);
}


// BGVテスト
function _playBgvForConfig( chr = void )
{
	_stopTestVoice();	// 他のテスト音を停止
	kag.cancelSkip();	// スキップ停止

	var list = [];
	list.assign(configTestBgvList);
	var index = (chr === void ? -1 : list.find(chr));
	// キャラ指定が無い、対象キャラが見つからない場合はランダムに選出
	//if(index == -1)index = list[intrandom(0, (list.count\2-1)) * 2];
	if(index == -1)index = intrandom(0, (list.count\2-1)) * 2;

	with(kag.se[kag.numSEBuffers-3]){
		.setOptions(%[volume:100, gvolume:(int)(sysBGVVolume * getVoiceVolume(list[index+1]) * getBgvVolume(list[index+1]))]);
		.play(%[storage:list[index+1]]);
	}
}


// システムボイステスト
function _playSysVoiceForConfig( chr = void )
{
	_stopTestVoice();	// 他のテスト音を停止
	kag.cancelSkip();	// スキップ停止

	if(chr === void){
		var nameList = getDicKey(sysCharacterVoiceList);	// 名前リスト取り出し
		var targetList = [];

		for(var i=0; i<nameList.count; i++){
			if(sf["sysVoiceEnabled"+nameList[i]])targetList.add(nameList[i]);
		}

		if(targetList.count == 0)return;	// 全キャラ非再生になっていたら帰る

		chr = nameList[intrandom(0, nameList.count-1)];		// 再生可能な名前リストからランダムにキャラを抽出
	}else{
		if(!sf["sysVoiceEnabled"+chr])return;	// 指定キャラが非再生になっていたら帰る
	}

	// 再生システムボイスリストの先頭の音声を鳴らす
	playSysVoice(sysCharacterVoiceList[ chr ][0], void, kag.numSEBuffers-5);
}

// 裏の声テスト
function _playSecondAudioForConfig( chr = void )
{
	_stopTestVoice();	// 他のテスト音を停止
	kag.cancelSkip();	// スキップ停止

	var list = [];
	list.assign(configTestSaList);
	var index = (chr === void ? -1 : list.find(chr));
	// キャラ指定が無い、対象キャラが見つからない場合はランダムに選出
	if(index == -1)index = list[intrandom(0, (list.count\2-1)) * 2];

	playVoice(list[index + 1], , , ,true);
}

// 他のテスト音を停止
function _stopTestVoice()
{
	for(var i = 2; i < 5; i++) kag.se[kag.numSEBuffers-i].stop();
}
//-------------------------------------------------------------
// ボタン裏の背景が合ってマウスの動きを監視するかどうか
//-------------------------------------------------------------
var monitorMouseMove = false;
if(bgRectArray.count > 0)monitorMouseMove = true;

// マウスカーソル監視用関数
function configMouseMoveMonitorFunc(x, y, shift){
	if(global.config_object.showing){
		if(kag.primaryLayer !== void){
			x = kag.primaryLayer.cursorX;
			y = kag.primaryLayer.cursorY;
		}
		var tar = global.config_object.config[global.config_object.showingPage];
		for(var i=0; i<tar.bgChild.count; i++){
			var lay = tar.bgChild[i];
			if(x > lay.left && y > lay.top && x < lay.left+lay.width && y < lay.top+lay.height){
				lay.on();
			}else lay.off();
		}
	}
}

// mouseMoveMonitorに関数が入っている時のみ実行
kag.mouseMoveMonitor = void;
if(monitorMouseMove){
	kag.configHook_onMouseMove = kag.onMouseMove;
	kag.onMouseMove = function(x, y, shift){
		if(mouseMoveMonitor !== void)mouseMoveMonitor(x, y, shift);
		return configHook_onMouseMove(...);
	}incontextof kag;
}

//-------------------------------------------------------------
// コンフィグのページレイヤー
//-------------------------------------------------------------
class ConfigLayer extends fadeLayer
{
	var ConfigButtons = [];	// コンフィグレイヤーに乗るオブジェクト全部
	var ConfigButtonsType = [];	// クラスタイプ配列
	var ConfigButtonsValue = [];// 初期化変数の記録
	var owner;					// プラグインへの参照
	var bgCopy = true;			// 背景はゲーム画面のコピーじゃよ
	var bgBase = "cfg_blank";	// コンフィグのベース画像
	var bgLayer;

	var sampleChLayer;
	var sampleChTimer;
	var sampleChCounter=0;
	var sampleChWait = false;
	var sampleChStr = System.title;

	var shortcutObj;

	// クラスではないけれど。もし設定されていたら閉じる命令の変わりに
	// ページ変更を掛ける。
	var overlap;
	var backpage;

	// キャラクターの名前を文字色つきで書き出すためのレイヤー郡
	var chrNameLayers = [];
	var chrNameLayersTemp;

	var bgChild = [];
	var pageNo = -1;

	function ConfigLayer(win, par, owner, bgImg, settingFile, page)
	{

		super.fadeLayer(win, par);
		this.owner = owner;
		pageNo = page;

		if(bgBase != ""){
			loadImages(bgBase);
			bgLayer = new global.Layer(win, this);
			bgLayer.loadImages(bgImg);
			bgLayer.setSizeToImageSize();
			bgLayer.hitType = htMask;
			bgLayer.hitThreshold = 256;
			bgLayer.visible = true;
		}else loadImages(bgImg);

		if(page < bgRectArray.count){
			for(var i=0; i<bgRectArray[page].count; i++){
				var ar = bgRectArray[page][i];
				var obj = new TwoImgLayer(win, this);
				obj.setPos(ar[0],ar[1]);
				obj.loadImages(ar[2]);
				obj.hitType = htMask;
				obj.hitThreshold = 256;
				bgChild.add(obj);
			}
		}

		setSizeToImageSize();
		setPos(0, 0);
		hitType = htMask;
		hitThreshold = 0; //全域不透過(当たり判定ばりばり)
		focusable=false;
		absolute = 10;
		visible=false;

		makeMainMenu(settingFile);
	}

	function finalize()
	{
		for(var i = 0; i < bgChild.count; i++)invalidate bgChild[i];
		for(var i = 0; i < chrNameLayers.count; i++)invalidate chrNameLayers[i];
		chrNameLayers.clear();
		invalidate chrNameLayersTemp if chrNameLayersTemp !== void;
		invalidate sampleChTimer if sampleChTimer !== void;
		// 特殊処理
		if(bgBase != "")invalidate bgLayer;
		for(var i = 0; i < ConfigButtons.count; i++)invalidate ConfigButtons[i];

		super.finalize(...);
	}

	// サンプル文字を描画するタイマーの有効化関数
	function sampleChTimerEnabled()
	{
		if(sampleChLayer === void)return;
		try{ setFontColor(""); } catch(e){ dm("サンプル文字列の色のクリアに失敗"); }
		// サンプル文字列表示用タイマーを作成
		if(sampleChTimer === void)sampleChTimer = new Timer(sampleChFunc, "");
		sampleChTimer.enabled = false;
		var ch = sampleChLayer.sampleCh;
		sampleChCounter=0;
		sampleChLayer.clear();
		sampleChWait = false;
		if(sysNotYetReadSpeed==60){
			for(var i=0; i<ch.length; i++)
				sampleChLayer.processCh(ch.charAt(i));
			sampleChTimer.interval = 50;
			sampleChTimer.enabled = true;
		}else{
			sampleChLayer.processCh(ch.charAt(0));
			sampleChTimer.interval = (70-sysNotYetReadSpeed);
			sampleChTimer.enabled = true;
		}
	}

	// サンプル文字を描画するタイマーの無効化関数
	function sampleChTimerDisabled()
	{
		if(sampleChLayer === void)return;
		sampleChLayer.clear();
		sampleChWait = false;
		sampleChTimer.enabled = false;
	}

	function sampleChFunc()
	{
		var ch = sampleChLayer.sampleCh;

		if(sysNotYetReadSpeed==60){
			sampleChLayer.clear();
			for(var i=0; i<ch.length; i++)
				sampleChLayer.processCh(ch.charAt(i));
			return;
		}

		if(sampleChWait){
			sampleChWait = false;
			sampleChCounter=0;
			sampleChLayer.clear();
			sampleChTimer.interval = 70-sysNotYetReadSpeed;
		}else if(++sampleChCounter >= ch.length){
			sampleChWait = true;
			sampleChTimer.interval = sysAutoSpeed;
			return;
		}
		sampleChLayer.processCh(ch.charAt(sampleChCounter));
	}

	// フェードレイヤーの関数を横取り
	function hide()
	{
		sampleChTimerDisabled();
		super.hide();
	}
	function show()
	{
		// ボカシ埋め込み
		if(bgCopy){
			piledCopy(0,0,kag.fore.base,0,0,kag.scWidth,kag.scHeight);
			doGrayScale();
			doBoxBlur(10,10);
			doBoxBlur(10,10);
		}
		// チェックの状態を正しく調整・スライダーにもcheckというメンバに突っ込まれるけど気にしないでおこう
		// true, false強制固定は状態再現しない、現状維持
		for(var i=0; i<ConfigButtons.count; i++){
			var target = ConfigButtons[i];
			if(target.flag_store != "" && target.flag_store != "true" && target.flag_store != "false" ){
				target.check = Scripts.eval(target.flag_store);
			}
		}
		// チェックの状態を再現後、エディットボックス等の選択中のキャラに依存するものの調整
		owner.changeVoiceVolumeTarget();
		sampleChTimerEnabled();
		super.show();
		
		// LC設定メニュー用にホイールのフック
		if( owner.showingPage == owner.lovelyCallPage ) kag.wheelSpinHook.unshift(owner.onMouseWheel);
		else kag.wheelSpinHook.remove(owner.onMouseWheel);
	}

	// cvs読み込み済み＆分割済み配列を返す関数
	function cvsReader(file)
	{
		var _file = [].load(file);
		var result = [];
		for(var i=0; i < _file.count; i++){
			var line = _file[i];
			if(line == "" || line.substr(0,2) == "//")continue;
			else{
				result.add(line.split(/\t/,,false));
			}
		}
		return result;
	}

	// コンフィグのボタンをまとめて作成
	function makeMainMenu(file)
	{
		var obj;
		var settingArray = cvsReader(file);
		var oderUpList = [];
		var voFirst = true;	// 最初のボイスボタン作成か？

		for(var i=0; i<settingArray.count; i++){
			var target = settingArray[i];
			var _class = (string)target[0];
			var _left  = (int)target[1];
			var _top   = (int)target[2];
			var _link  = (int)target[3];
			var _flag  = Scripts.eval(target[4]);
			var _hint  = (string)target[5];
			// 後置演算子！はScript.evalの実行コンテキストがthisのもの
			var _init  = target[6]!;

			ConfigButtonsType.add(_class);
			ConfigButtonsValue.add(target[4]);

			switch(_class){
				case "message":ConfigButtons.add(obj = new MessageLayer(window, this, "文字サンプルレイヤー",,true));
					if(_init["h"] === true)owner.hMsgSampleObj = obj;
					else owner.msgSampleObj = obj;
					obj.setPosition(_init);
					obj.lineLayer.type = obj.type=ltAlpha;
					//obj.setDefaultFont(%[size:(_init.fontsize === void ? 22 : (+_init.fontsize))]);
					obj.setDefaultFont(%[size:globalDefFontSize, face:kag.chDefaultFace, bold:false]);
					obj.resetFont();
					//if(Storages.isExistentStorage("vlg22.tft")){
					//	obj.setPosition(%[vertical:false]);
					//	obj.setDefaultFont(%[size:22, bold:false, face:"VLG22"]);
					//	obj.resetFont();
					//	obj.lineLayer.font.mapPrerenderedFont("vlg22.tft");
					//}
					obj.visible=true;
					if(_init["sample_ch"] === void)obj.sampleCh = sampleChStr;
					else obj.sampleCh = _init["sample_ch"];
					sampleChLayer = obj;
					obj.forceColor = true;
					obj.autoFormat = false;
					break;
				case "4_button":ConfigButtons.add(obj = new Button_4img(window, this, _init)); break;
				case "focusLayer":ConfigButtons.add(obj = new FocusedLayer(window, this, _init)); break;
				case "check_4imgx4img":ConfigButtons.add(obj = new CheckBox_4imgx4img(window, this, _init)); obj.check=_flag; break;
				case "check_4imgEx":
					ConfigButtons.add(obj = new CheckBox_4imgEx(window, this, _init)); obj.check=_flag;
					break;
				case "check_4img":
					ConfigButtons.add(obj = new CheckBox_4img(window, this, _init)); obj.check=_flag;
					if(_init.mute_onoff)owner.voMuteObj = obj;
					if(_init["gena"] !== void)owner.genCallObja = obj;
					if(_init["genb"] !== void)owner.genCallObjb = obj;
					if(_init["genc"] !== void)owner.genCallObjc = obj;
					if(_init["gend"] !== void)owner.genCallObjd = obj;
					break;
				case "3_button":ConfigButtons.add(obj = new ThreeButtonLayer(window, this, _init));
					if(_init.txt_change)owner.txtChangeTargetLayer = obj;	// 「変更する」ボタンのみ登録（ヒロインとその他で使用するかの有無があるため）
					break;
				case "check_3img":
					ConfigButtons.add(obj = new CheckBox_3img(window, this, _init)); obj.check=_flag;
					if(_init.mute_onoff)owner.voMuteObj = obj;
					break;
				case "3_check":ConfigButtons.add(obj = new ThreeButtonCheckBox(window, this, _init)); obj.check=_flag; break;
				case "button_2img":ConfigButtons.add(obj = new Button_2img(window, this, _init)); break;
				case "2_check":
					ConfigButtons.add(obj = new TwoImgCheck(window, this, _init));
					obj.check=_flag;
					if(_init.mute_bgv)   owner.bgvMuteObj   = obj;
					if(_init.mute_sysvo) owner.sysVoMuteObj = obj;
					break;
				case "2_check_only":ConfigButtons.add(obj = new TwoImgCheckCheckOnly(window, this, _init));
					owner.systemVoiceCheckObj = obj;
					obj.check=_flag;
					break;
				case "check_2imgx2img":ConfigButtons.add(obj = new CheckBox_2imgx2img(window, this, _init)); obj.check=_flag; break;
				case "check_2imgEx":
					ConfigButtons.add(obj = new CheckBox_2imgEx(window, this, _init)); obj.check=_flag;
					break;
				case "slider":
					ConfigButtons.add(obj = new SliderLayer(window, this, _init));
					obj.position=_flag;
					if(_init.pvoice)   owner.personalVoiceSliderObj    = obj;
					if(_init.pbgv)     owner.personalBgvSliderObj      = obj;
					if(_init.psysvoice)owner.personalSysVoiceSliderObj = obj;
					if(_init.sample_r) owner.chColorSliderRObj = obj;
					if(_init.sample_g) owner.chColorSliderGObj = obj;
					if(_init.sample_b) owner.chColorSliderBObj = obj;
					if(_init.bgmslider)owner.bgmSliderObj = obj;
					if(_init.already_r)owner.alreadyReadColorSliderRObj = obj;
					if(_init.already_g)owner.alreadyReadColorSliderGObj = obj;
					if(_init.already_b)owner.alreadyReadColorSliderBObj = obj;
					if(_init.showvalue) {
						obj.dispColor = 0x695a5d;	// スライダーの文字色を変更
						obj.showValue = true;		// スライダー数値を有効化
						obj.shiftValuePos(-190, 25);	// 数値をデフォ値から移動。相対座標だよ。
						if(_init.svType) obj.svType = _init.svType;	// 表示タイプ変更
					}

					break;
				case "button_1img":ConfigButtons.add(obj = new OneImageButton(window, this, _init)); break;
				case "customcheck":ConfigButtons.add(obj = new CustomCheckBox(window, this, _init)); break;
				case "layer":ConfigButtons.add(obj = new HintLayer(window, this));
					if(_init.storage!==void)obj.loadImages(_init.storage);
					else obj.setImageSize(_init.width, _init.height);
					if(_init.emote_test)owner.EmoteTestLayer = obj;
					if(_init.lc_test)owner.LovelyCallTestLayer = obj;
					if(_init.bg_change)owner.bgChangeTargetLayer = obj;
					if(_init.bg_change_h)owner.bgChangeHTargetLayer = obj;
					if(_init.voice_name)owner.voiceNameTargetLayer = obj;
					if(_init.color_name)owner.colorNameTargetLayer = obj;
					if(_init.genital_name)owner.genitalNameTargetLayer = obj;
					obj.setSizeToImageSize();
					obj.type=ltAlpha;
					obj.face=dfAlpha;
					obj.hitType = htMask;
					obj.hitThreshold = 256;
					obj.visible=true;
					// もしメッセージ不透明度設定用の場合登録
					if(_init.opasample){
						owner.msgOpacitySliderObj = obj;
						obj.opacity = _flag;
					}
					if(_init.opahsample){
						owner.hmsgOpacitySliderObj = obj;
						obj.opacity = _flag;
					}
					if(_init.chcolorsample)owner.characterMsgSampleObj = obj;
					break;
				case "fontsample":ConfigButtons.add(obj = new global.Layer(window, this));
					obj.setImageSize(_init.width, _init.height);
					obj.setSizeToImageSize();
					obj.type=ltAlpha;
					obj.face=dfAlpha;
					obj.fillRect(0,0,_init.width,_init.height,0xaa000000);
					obj.font.height = 16;
					owner.drawFontSample(obj);
					obj.visible=true;
					break;
				case "pulldown":ConfigButtons.add(obj = new PullDownMenu(window, this, _init));
					owner.spaceKeySettingObj = obj;
					break;
				case "vo_button":
					// 文字描画用の一時レイヤー作成
					if(chrNameLayersTemp === void){
						chrNameLayersTemp = new global.Layer(window, this);
						with(chrNameLayersTemp){
							.setImageSize(350, 40);
							.setSizeToImageSize();
							.type = ltAlpha;
							.face = dfAlpha;
							.font.bold = false;
							.font.height = 24;
							if(Storages.isExistentStorage("vlg24.tft")){
								.font.face = "VLG24";
								.font.mapPrerenderedFont("vlg24.tft");
							}
							.fillRect(0,0,.width,.height,0x0);
							.visible = false;
						}
					}
					ConfigButtons.add(obj = new VoiceCheckBox(window, this, _init));
					obj.check = voFirst;
					obj.func = _init["func"];
					obj.chrName = _init["str"];
					obj.fakeName = "";
					if(voFirst){
						owner.volChr = _init["str"];
						owner.chChr = _init["str"];
						owner.genChr = _init["str"];
					}
					voFirst = false;

					if(_init["split"] != void)	obj.split = _init["split"];

					// 実際のキャラ名描画用のレイヤー
					{
						var index = chrNameLayers.add(new global.Layer(window, this));
						with(chrNameLayers[index]){
							.hitType = htMask;
							.hitThreshold = 256;
							.setImageSize(obj.width, obj.height);
							.setSizeToImageSize();
							.type = ltAlpha;
							.face = dfAlpha;
							.fillRect(0,0,.width,.height,0x0);
							.setPos(_left, _top);
							.visible = true;
							.chrName = _init["str"];
						}
					}
					break;
				case "shortcut":
					ConfigButtons.add(obj = new shortCutSettingLayer(window, this, _init));
					obj.draw();
					shortcutObj = obj;
					break;
				case "overlap":
					overlap = (int)_init["page"];
					continue;
					break;
				case "backpage":
					backpage = (int)_init["page"];
					continue;
					break;
				case "editbox":
					ConfigButtons.add(obj = new CustomEditLayer(window, this, false));
					if(_init["mnemonic"] !== void)owner.mnemonicNameObj = obj;
					if(_init["tin"] !== void)owner.tinNameObj = obj;
					if(_init["man"] !== void)owner.manNameObj = obj;
					if(_init["l_name"] !== void)owner.lastNameObj = obj;
					if(_init["f_name"] !== void)owner.firstNameObj = obj;
					if(_init.txtcolor !== void)obj.textColor = +_init.txtcolor;

					with(obj){
						.width = _init["length"] === void ? 200: +_init["length"];
						.text = Scripts.eval(_init["name"]);
						.maxChars = 10;
						.exp = _init["name"];
						.height = _init["height"] === void ? 30: +_init["height"];
						.font.height = .height - 5;
						.enabled = (_init.enabled === void ? true:_init.enabled);
						.visible = true;
					}
					break;
				case "spin":
					ConfigButtons.add(obj = new SpinLayer(window, this));
					obj.loadImages(_init.storage);
					obj.visible = true;
					obj.start();
					break;
				case "invisible":
					ConfigButtons.add( obj = new InvisibleLayer( window, this ) );

					if( _init.lc ){
						owner.lovelyCallPage = pageNo;
						owner.nameEntryButtons = obj;
					}

					obj.visible = true;
					break;
				case "scrollbar":
					ConfigButtons.add( obj = new ScrollBarLayerFree( window, this ) );
					obj.setPos(_left, _top);
					obj.height = _init.scrollH === void ? 0 : _init.scrollH;
					obj.setClipPos( ( _init.clipX === void ? 0 : _init.clipX ) , ( _init.clipY === void ? 0 : _init.clipY ) );
                	obj.setClipSize( ( _init.clipW === void ? 0 : _init.clipW ) , ( _init.clipH === void ? 0 : _init.clipH ) );

					if( _init.lc ){
						obj.setTarget(owner.nameEntryButtons);
						obj.initScrollBar();
						owner.nameEntryScroll = obj;
					}

					obj.visible = true;
					break;
				default:System.inform("存在しないクラスが指定されました。\n("+(typeof _class)+")："+_class); continue;
			}
			// フラグ判定の記録
			if(target[4] != "" && _class != "2_check_only")obj.flag_store = target[4];
			else obj.flag_store = "";

			// 座標設定
			obj.setPos(_left, _top);
			// 前のオブジェクトとリンクするか？
			if(_link){
				ConfigButtons[i-1].linkObj = obj;
				obj.linkObj = ConfigButtons[i-1];
			}
			// チップヒントの設定
			obj.hint = _hint;
			obj.hintSp = false;

			// システムＳＥを消す処理
			if(_init["pressSysSe"] === false){
				obj.pressSound = "";
			}

			// 前後関係調整
			if(_init.order !== void)obj.order = +_init.order;

			// 空色の特殊処理
			// フォーカスを受けるとカーソルのセンタリングをかける(ページボタン以外)
			if(i > 3)obj.cursorCentering = true;

			// プルダウンメニューのオーダーを最上位に上げるために登録
			if(_class=="pulldown")oderUpList.add(obj);

			// フルスクリーン・ウィンドウ切り替えのボタンがあったら記録
			if(_init.scwin)owner.screenChangeWindowObj = obj;
			if(_init.scfull)owner.screenChangeFullObj = obj;

			// idの付与
			if(_init.id !== void)obj.unique_id = _init.id;
			else obj.unique_id = "";

			// 体験版無効処理追加
			if(+_init.trial){
				//obj.doGrayScale();
				//obj.pressFunction = function(){System.inform('体験版ではご利用できません');};
				obj.adjustGamma(1.0, 0, 200, 1.0, 0, 200, 1.0, 0, 200);
				obj.enabled = false;
			}
			
			// 無効化フラグが立っていたら無効化
			if(_init.enabled === false){
				obj.enabled = false;
			}
		}

		// プルダウンメニューがあったらオーダーを最後のオブジェクトより上に
		if(oderUpList.count>=0){
			for(var i=0; i<oderUpList.count; i++){
				for(var j=0; j<oderUpList[i].pulldownArray.count; j++){
					oderUpList[i].pulldownArray[j].order = ConfigButtons[ConfigButtons.count-1].order+1;
				}
			}
		}

	}

	function onKeyDown(key)
	{
		super.onKeyDown(...);
		if(overlap !== void){
			hide();
			owner.isOverlap = -1;
			return;
		}else if(backpage){
			owner.changePage(backpage);
			return;
		}
		// ESC キーが押されたらレイヤを隠す
		if(key == VK_ESCAPE)owner.onConfigClose();
	}

	function onMouseDown(x, y, button, shift)
	{
		super.onMouseDown(...);
		if(button == mbRight){
			if(overlap !== void){
				hide();
				owner.isOverlap = -1;
				return;
			}else if(backpage !== void){
				owner.changePage(backpage);
				return;
			}else owner.onConfigClose();
		}
		return;
	}

	function onShow()
	{
		// コンフィグが開いたときにsetMode()にてフォーカスが乗ってしまうので
		// 外すために
		window.focusedLayer=null;
	}
}

class ConfigPlugin extends KAGPlugin // 「右クリック設定」プラグインクラス
{
	var window;			// ウィンドウへの参照
	var config = [];	// 設定レイヤ
	var callByTitle = false;
	var showingPage = 0;

	// 下記は特殊な処理が必要なものの参照が入る
	var bgmSliderObj;			// BGMスライダーの参照

	var personalVoiceSliderObj;		// 個別ボイス音量のスライダーの参照
	var personalBgvSliderObj;		// 個別ＢＧＶ音量のスライダーの参照
	var personalSysVoiceSliderObj;	// 個別システムボイス音量のスライダーの参照

	var msgOpacitySliderObj;	// 不透明度スライダーの参照
	var hmsgOpacitySliderObj;	// Hシーン用不透明度スライダーの参照
	var spaceKeySettingObj;		// スペースキー設定の参照
	var characterMsgSampleObj;	// 文字色サンプルの参照
	var chColorSliderRObj;		// 赤の文字色設定用スライダーの参照
	var chColorSliderGObj;		// 緑の文字色設定用スライダーの参照
	var chColorSliderBObj;		// 青の文字色設定用スライダーの参照
	var alreadyReadColorSliderRObj;
	var alreadyReadColorSliderGObj;
	var alreadyReadColorSliderBObj;
	var EmoteTestLayer;
	var LovelyCallTestLayer;
	var bgChangeTargetLayer;
	var bgChangeHTargetLayer;
	var voiceNameTargetLayer;	// 個別音量調整で名前変更（画像）がある場合のレイヤー
	var colorNameTargetLayer;	// 個別文字色変更で名前変更（画像）がある場合のレイヤー
	var genitalNameTargetLayer;	// 個別性器呼称で名前変更（画像）がある場合のレイヤー
	var txtChangeTargetLayer;	// 「変更する」のボタンがある場合のレイヤー（ヒロイン以外でボタンを隠すため）
	var systemVoiceCheckObj;	// システムキャラのチェックボックス
	var msgSampleObj;			// メッセージサンプルのオブジェクト
	var hMsgSampleObj;
	var screenChangeWindowObj;	// ウィンドウへの切り替えオブジェクト
	var screenChangeFullObj;	// フルスクリーンへの切り替えオブジェクト

	var voMuteObj;		// 音声ミュートの状態を表すチェック
	var bgvMuteObj;		// ＢＧＶミュートの状態を表すチェック
	var sysVoMuteObj;	// システムボイスミュートの状態を表すチェック

	var isHSceneWndSelected = sf.cfgPreviewWinNow;	// 現在のメッセージウィンドウの操作対象がHシーン用ウィンドウかどうか
	var mnemonicNameObj;	// ヒロイン呼び名のエディットボックス参照
	var tinNameObj;	// 主人公の性器呼称のエディットボックス参照
	var manNameObj;	// 主人公の性器呼称のエディットボックス参照
	var lastNameObj;	// 主人公の苗字のエディットボックス参照
	var firstNameObj;	// 主人公の名前のエディットボックス参照
	var genCallObja;
	var genCallObjb;
	var genCallObjc;
	var genCallObjd;

	var volChr = "";	// 現在のボリューム操作対象
	var chChr = "";
	var genChr = "";

	var isOverlap = -1;

	var showing = false;

	var lovelyCallPage = -1;			// ラブリーコール設定があるページの記録、invisibleレイヤーで「lc:true」されたページを記録する
	var nameEntryButtons;
	var nameEntryScroll;
	var isSpCallSelect = false;
	// この値はconfigが開かれるときに参照されるのでglobal.lovelycall_objectから参照。コンフィグにラブリーコールページがあるということはセッティングプラグインもあるはず。
	//var nickBtX      = 0;		// ニックネームボタンのクリップ内での配置x
	//var nickBtY      = 0;		// ニックネームボタンのクリップ内での配置y
	//var nickBtAddX   = 0;		// ニックネームボタンのクリップ内での移動幅x
	//var nickBtAddY   = 47;	// ニックネームボタンのクリップ内での移動幅y
	//var nickBtReline = 1;		// ニックネームボタンのクリップ内での改行個数

	var callTypeChange = true;	// サンプル再生のLCのタイプを下記フラグによって変更し続ける
	var callTypeFlag = true;	// 真：1, 偽：2


	function ConfigPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;

		// 個別のボイス設定をキャラクター切り替え無しで呼び出すときの関数宣言
		// function changeVoiceVolume理歩()
		// のような関数が宣言される
		for(var i=0; i<characterList.count; i++){
			this["changeVoiceVolume" + characterList[i]] = ("function(obj){volChr = \"" + characterList[i] + "\"; changeVoiceVolume(obj); }incontextof this;")!;
			this["onVoiceTestPersonal" + characterList[i]] = ("function(obj){volChr = \"" + characterList[i] + "\"; onVoiceTestPersonal(obj); }incontextof this")!;
		}

		//プラグイン登録時にさくっとコンフィングレイヤー作成
		// csvファイルがあるしこ調査
		var i=0;
		while(1){
			if(Storages.isExistentStorage("config_sys_p"+(i+1)+".csv")){
				if(Storages.isExistentStorage("sp_patch.tjs")){//はるとゆき、特典フラグ背景画像調整
					config.add(new ConfigLayer(window, kag.primaryLayer, this, "cfg_bg_p"+(i+1), "config_sys_p"+(i+1)+".csv", i));
				}else{
					config.add(new ConfigLayer(window, kag.primaryLayer, this, "cfg_bg_p"+(i+1), "config_sys_p"+(i+1)+".csv", i));
				}
				//config.add(new ConfigLayer(window, kag.primaryLayer, this, "cfg_bg_p"+(i+1), "config_sys_p"+(i+1)+".csv", i));
			}else break;
			i++;
		}
	}

	function finalize()
	{
		kag.mouseMoveMonitor = void;
		for(var i=0; i<config.count; i++)invalidate config[i] if config[i] !== void;
		super.finalize(...);
	}

	function _show(page)
	{
		callByTitle = false;
		show(page);
	}

	function show(page)
	{
		if(monitorMouseMove)kag.mouseMoveMonitor = configMouseMoveMonitorFunc;
		showingPage = page;

		// 親を再設定する(トランジションによって表背景レイヤは変わるため)
		// 重ね合わせもきちんと。
// 独立メッセージレイヤー用設定
//		config[page].parent = window.fore.base;
//		config[page].absolute = 2000000-10;

		// 文字色のサンプルレイヤーを塗りなおす→個別ページのshow関数に移動
		//changeVoiceVolumeTarget();

		// 既読文字色のサンプルスライダーを調整する
		changeAlreadyReadColorSlider();

		// 作品固有の表示/非表示切り替え
		(configUniqueSetting incontextof this)();
		//メッセージウィンドウ不透明度のレイヤーを調整
		onSampleWindowChanged();

		config[page].show();
		showing = true;
		window.configShowing = true;
	}

	// ボタンに設定されたIDからボタンを探す
	function getButtonById(id = void){
		for(var i=0; i<config.count; i++){
			var btns = config[i].ConfigButtons;
			for(var j=0; j<btns.count; j++){
				if(btns[j].unique_id == id)return btns[j];
			}
		}
		return void;
	}

	function showByTitle(page)
	{
		show(page);
		callByTitle = true;
	}

	// 呼び名チェック
	function commitCallName()
	{
		try{
			if(mnemonicNameObj !== void){
				if(checkNG(mnemonicNameObj.text)){
					askYes("不適切な呼び名が設定されました。￥ｎ再入力を行ってください");
					mnemonicNameObj.text = sf[chChr+"呼び名"];
					return false;
				}else if(mnemonicNameObj.text.length > 10){
					askYes("呼び名が１０文字を超えています。￥ｎ再入力を行ってください");
					mnemonicNameObj.text = sf[chChr+"呼び名"];
					return false;
				}else sf[chChr+"呼び名"] = mnemonicNameObj.text;
				// 空白名はデフォルトを適用
				if(mnemonicNameObj.visible && mnemonicNameObj.text == "")mnemonicNameObj.text = sf[chChr+"呼び名"];
			}
		}catch(e){
			dm(e.message);
		}
		return true;
	}

	// ページの変更
	function changePage(page)
	{
		// 呼び名チェック
		if(showingPage == 0 && !commitCallName())return;
		// 性器呼称適用
		if(showingPage == 3){
			if(tinNameObj !== void)sf[genChr+"ルート男性器呼び名"] = tinNameObj.text;
			if(manNameObj !== void)sf[genChr+"ルート女性器呼び名"] = manNameObj.text;
			//if(tinNameObj !== void)sf["主人公男性器呼称"] = tinNameObj.text;
			//if(manNameObj !== void)sf["主人公女性器呼称"] = manNameObj.text;
		}

		if( page == lovelyCallPage ){
			// 各種初期化
			tf.nameSelectedId=0;
			tf.nameSelectedChr=heroineList[0];
			tf.nameSelectedNick = 0;

			// 入力済みがあったらそこをフォーカス
			if(sf.nameSelectedId === void)tf.nameSelectedId = global.lovelycall_object.defCategoryID;
			else tf.nameSelectedId = (int)sf.nameSelectedId;
			if(sf.nameSelectedNick === void)tf.nameSelectedNick = global.lovelycall_object.defNickNameID;
			else tf.nameSelectedNick = (int)sf.nameSelectedNick;

			if(sf.呼び名 === void)tf.nickName = global.lovelycall_object.defNickName;
			else tf.nickName = sf.呼び名;
			if(sf.苗字 === void)sf.苗字 = tf.苗字 = global.lovelycall_object.defLastName;
			else tf.苗字 = sf.苗字;
			if(sf.名前 === void)sf.名前 = tf.名前 = global.lovelycall_object.defFirstName;
			else tf.名前 = sf.名前;
			
			if( lastNameObj  !== void ) lastNameObj.text  = tf.苗字;
			if( firstNameObj !== void ) firstNameObj.text = tf.名前;

			setNickName();
		}

		config[showingPage].hide();
		config[showingPage].fadeFinish();		// ページ間移動はフェードしないように調整
		show(page);
		config[showingPage].fadeFinish();		// ページ間移動はフェードしないように調整
	}

	// ページ重複呼び出し(ショートカット及びダイアログ設定用)
	function overlapPage(page)
	{
		isOverlap = page;
		config[page].show();
	}

	function onConfigClose()
	{
		// 設定レイヤが閉じるとき
		closeConfig();
		showingPage = 0;
		window.trigger('config'); //configトリガ発動
	}
	
	function selectFont(){
		kag.selectFont();
		if(msgSampleObj !== void){
			// サンプルレイヤーのフォント更新
			msgSampleObj.setDefaultFont(%[size:globalDefFontSize, face:kag.chDefaultFace, bold:false]);
			msgSampleObj.resetFont();
			config[showingPage].sampleChTimerEnabled();
		}
		if(hMsgSampleObj !== void){
			// サンプルレイヤーのフォント更新
			hMsgSampleObj.setDefaultFont(%[size:globalDefFontSize, face:kag.chDefaultFace, bold:false]);
			hMsgSampleObj.resetFont();
			config[showingPage].sampleChTimerEnabled();
		}
		setMessageLayerBold();	// 太字設定調整
	}

	/*---------------------------------------------------------
		￡：ヒロインの名称変更
		変更ボタンを押されたら入力ダイアログを出すよ
	---------------------------------------------------------*/
	function changeWifeName()
	{
		if(chChr != "その他男" && chChr != "その他女" && chChr != "主人公" && mnemonicNameObj){
			var txt = System.inputString("呼び名設定","呼び方を１０文字以内で指定してください", sf[chChr+'呼び名']);
			// キャンセルor空白
			if(txt === void || txt == ""){
				mnemonicNameObj.text = sf[chChr+"呼び名"];
				return;		// 変更無し
			}
			// NGチェック
			if(checkNGWord(txt)){
				mnemonicNameObj.text = sf[chChr+"呼び名"];
				askYes("不適切な呼び名が設定されました。￥ｎ再入力を行ってください");
				return;
			}
			// 10文字チェック
			if(txt.length > 10)txt = txt.substr(0,10);
			// 正式適用
			mnemonicNameObj.text = sf[chChr+"呼び名"] = txt;
		}
	}

	/*---------------------------------------------------------
		￡：男性器呼称変更
		変更ボタンを押されたら入力ダイアログを出すよ
	---------------------------------------------------------*/
	function changeGenitalMan()
	{
		if(genChr != "その他男" && genChr != "その他女" && genChr != "主人公"){
			var txt = System.inputString("男性器呼称設定","呼び方を１０文字以内で指定してください", sf[genChr+"ルート男性器呼び名"]);
			// キャンセルor空白
			if(txt === void || txt == ""){
				tinNameObj.text = sf[genChr+"ルート男性器呼び名"];
				return;		// 変更無し
			}
			// 10文字チェック
			if(txt.length > 10)txt = txt.substr(0,10);
			// 正式適用
			tinNameObj.text = sf[genChr+"ルート男性器呼び名"] = txt;
		}
	}

	/*---------------------------------------------------------
		￡：女性器呼称変更
		変更ボタンを押されたら入力ダイアログを出すよ
	---------------------------------------------------------*/
	function changeGenitalWoman()
	{
		if(genChr != "その他男" && genChr != "その他女" && genChr != "主人公"){
			var txt = System.inputString("女性器呼称設定","呼び方を１０文字以内で指定してください", sf[genChr+"ルート女性器呼び名"]);
			// キャンセルor空白
			if(txt === void || txt == ""){
				manNameObj.text = sf[genChr+"ルート女性器呼び名"];
				return;		// 変更無し
			}
			// 10文字チェック
			if(txt.length > 10)txt = txt.substr(0,10);
			// 正式適用
			manNameObj.text = sf[genChr+"ルート女性器呼び名"] = txt;
		}
	}

	/*---------------------------------------------------------
		￡：女性器呼称変更
		変更ボタンを押されたら入力ダイアログを出すよ
	---------------------------------------------------------*/
	function changeGenitalWoman()
	{
		if(genChr != "その他男" && genChr != "その他女" && genChr != "主人公"){
			var txt = System.inputString("女性器呼称設定","呼び方を１０文字以内で指定してください", sf[genChr+"ルート女性器呼び名"]);
			// キャンセルor空白
			if(txt === void || txt == ""){
				manNameObj.text = sf[genChr+"ルート女性器呼び名"];
				return;		// 変更無し
			}
			// 10文字チェック
			if(txt.length > 10)txt = txt.substr(0,10);
			// 正式適用
			manNameObj.text = sf[genChr+"ルート女性器呼び名"] = txt;
		}
	}

	/*---------------------------------------------------------
		￡：苗字変更
		変更ボタンを押されたら入力ダイアログを出すよ
	---------------------------------------------------------*/
	function changeLastName()
	{
		while( 1 ){
			lastNameObj.text = System.inputString("苗字設定","苗字を４文字以内で指定してください", sf["苗字"]);
			if( commitLastName() )	break;
		}
	}
	/*---------------------------------------------------------
		￡：名前変更
		変更ボタンを押されたら入力ダイアログを出すよ
	---------------------------------------------------------*/
	function changeFirstName()
	{
		while( 1 ){
			firstNameObj.text = System.inputString("名前設定","名前を６文字以内で指定してください", sf["名前"]);
			if( commitFirstName() )	break;
		}
	}

	// 苗字チェック
	function commitLastName(){
		try{
			if(lastNameObj !== void){
				lastNameObj.text = lastNameObj.text.substr(0,4);
				// 空白名は現在のものを適用
				if(lastNameObj.visible && lastNameObj.text == "") lastNameObj.text = sf["苗字"];
				sf["苗字"] = lastNameObj.text;
			}
		}catch(e){
			dm(e.message);
		}
		return true;
	}

	// 名前チェック
	function commitFirstName(){
		try{
			if(firstNameObj !== void){
				firstNameObj.text = firstNameObj.text.substr(0,6);
				// 空白名は現在のものを適用
				if(firstNameObj.visible && firstNameObj.text == "") firstNameObj.text = sf["名前"];
				sf["名前"] = firstNameObj.text;
			}
		}catch(e){
			dm(e.message);
		}
		return true;
	}

	/*---------------------------------------------------------
		ラブリーコールカテゴリ変更
		変更ボタンを押されたら入力ダイアログを出すよ
	---------------------------------------------------------*/
	function onLCCategory1() { tf.nameSelectedId =  0; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory2() { tf.nameSelectedId =  1; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory3() { tf.nameSelectedId =  2; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory4() { tf.nameSelectedId =  3; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory5() { tf.nameSelectedId =  4; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory6() { tf.nameSelectedId =  5; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory7() { tf.nameSelectedId =  6; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory8() { tf.nameSelectedId =  7; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory9() { tf.nameSelectedId =  8; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory10(){ tf.nameSelectedId =  9; tf.nameSelectedNick = 0; changeLCCategory(); };
	function onLCCategory11(){ tf.nameSelectedId = 10; tf.nameSelectedNick = 0; changeLCCategory(); };

	function changeLCCategory()
	{
		setNickName();
	}

	function setNickName(){
		var nickBtX      = global.lovelycall_object.nickBtX;
		var nickBtY      = global.lovelycall_object.nickBtY;
		var nickBtAddX   = global.lovelycall_object.nickBtAddX;
		var nickBtAddY   = global.lovelycall_object.nickBtAddY;
		var nickBtReline = global.lovelycall_object.nickBtReline;
		var clipW        = global.lovelycall_object.clipW;

		with(nameEntryButtons){
			.clear();
			for(var i=0; i<nicknameList[tf.nameSelectedId].count;i++){
				var storage = getLCImgName(i);

				// LC+の場合はファイル名変更
				if( nicknameList[tf.nameSelectedId][i][1].length >= 6 )
				{
					storage = "lc+"+storage;
				}

				storage = "nick_"+storage;
				var file = getLCV(,,i);
				var btn = .add4Button(storage, "config_object.nameSetAndCall("+i+"), config_object.reForcusNickName();");
				btn.focusedHit = true;
				btn.setPos(nickBtX + nickBtAddX*(i%nickBtReline), nickBtY + nickBtAddY*(i\nickBtReline));
				btn.isFocus = tf.nameSelectedNick==i;
			}
			// スクロールされるレイヤーのサイズをボタンの量に応じて再設定
			.setSize(clipW, nickBtY+nickBtAddY*Math.ceil(nicknameList[tf.nameSelectedId].count/nickBtReline));
			// スクロールバーの初期化
			nameEntryScroll.initScrollBar();
		}
	}

	function getLCImgName(index){
		var result = "";
		//var charIndex = %[
		//				"hrk"=>0,
		//				"yzk"=>2
		//				][tf.nameSelectedChr];
		// 
		if(tf.nameSelectedChr === void)tf.nameSelectedChr = heroineList[0];
		var charIndex = global.lovelycall_object.nicknameFileIndexList[tf.nameSelectedChr][1]-1;
		return nicknameList[tf.nameSelectedId][index][charIndex];
	}

	function nameCall(){
		var file = getLCV();
		try{
			kag.se[kag.se.count-2].play(%[storage:file]);
			if(typeof emote_player_object !== "undefined"){
				doEmoteSys(EmoteSampleList[intrandom(0,EmoteSampleList.count-1)]);
				emote_player_object.variable(%[seg:7, page:"fore", name:"face_talk", buf:kag.se.count-2]);
			}
		}catch(e){
			dm(e);
		}
	}

	function getLCV(name = void, alphabetIndex = void, nameIndex = void){
		if(name === void)name = tf.nameSelectedChr;
		var result = "";
		var target = global.lovelycall_object.nicknameFileIndexList[name];
		if(target === void){
			System.inform("ファイル名呼び出し失敗");
		}else{
			var head = target[0];
			var charIndex = target[1];
			if(alphabetIndex === void)	alphabetIndex = tf.nameSelectedId;
			if(nameIndex === void)		nameIndex     = tf.nameSelectedNick;

			var lc = nicknameList[alphabetIndex][nameIndex][charIndex];
			if(lc == "-")	lc = "han01";
			var ct = "1";
			if(callTypeChange){
				ct = callTypeFlag ? "1" : "2";
				callTypeFlag = !callTypeFlag;
			}
			result = head + "_" + lc + "_" + ct;
		}
		return result;
	}

	function nameSetAndCall(index){
		tf.nameSelectedNick = index;
		tf.nickName			= getNickNameFull(tf.nameSelectedId,tf.nameSelectedNick);
		nameCall();
	}

	function callFix(){
		sf.nameSelectedId   = tf.nameSelectedId;
		sf.nameSelectedNick = tf.nameSelectedNick;
	}

	function reForcusNickName()
	{
		var target = nameEntryButtons.buttons;
		for(var i=0; i<target.count; i++){
			target[i].isFocus = tf.nameSelectedNick==i;
		}
	}

	function onMouseWheel(shift, delta, x, y)
	{
		try{
			if(delta > 0)nameEntryScroll.prev((delta/120));
			else nameEntryScroll.next(Math.abs(delta/120));
		}catch(e){
			dm(e.message);
		}
		return true;
	}

	function closeConfig()
	{
		kag.mouseMoveMonitor = void;
		// キャラクターの呼び名を適用
		commitCallName();
		if(tinNameObj !== void)sf[genChr+"ルート男性器呼び名"] = tinNameObj.text;
		if(manNameObj !== void)sf[genChr+"ルート女性器呼び名"] = manNameObj.text;
		//if(tinNameObj !== void)sf["主人公男性器呼称"] = tinNameObj.text;
		//if(manNameObj !== void)sf["主人公女性器呼称"] = manNameObj.text;

		// lovelyCallPageが-1で無いということは設定ページが存在するということ
		if(lovelyCallPage != -1){
			tf.nameSelectedId   = sf.nameSelectedId;
			tf.nameSelectedNick = sf.nameSelectedNick;
			reForcusNickName();

			if( nameEntryScroll !== void ) kag.wheelSpinHook.remove(onMouseWheel);
			// E-moteあったら止めとく
			//if(typeof emote_player_object !== "undefined")emote_player_object.stop(%[seg:7]);
		}

		//設定レイヤを閉じる
		if(config[showingPage].visible)config[showingPage].hide();
		showing = false;
		window.configShowing = false;
	}

//////////////////////////////////////////////////////////////////////

	// ウォーキングトーク用
	//function doWTButton(obj){
	//	sysWalkingTalk = obj.check;
	//	resetWT();
	//}
	//function cancelWTButton(obj){
	//	sysWalkingTalk = !obj.check;
	//	resetWT();
	//}
	//function resetWT(obj){
	//	if(sysWalkingTalk)doWalkingTalk();
	//	else cancelWalkingTalk();
	//}

	//エモート用
	//function doEmoteSetting(obj){
	//	sysEmoteAnim = obj.check;
	//	if(sysEmoteAnim && sysDoBreathEmote)
	//		emote_player_object.playtimeline(%[seg:0, page:"fore", name:"差分用_waiting_loop"]);
	//	else
	//		emote_player_object.stoptimeline(%[seg:0, page:"fore"]);
	//}
	//function cancelEmoteSetting(obj){
	//	sysEmoteAnim = !obj.check;
	//	if(sysEmoteAnim && sysDoBreathEmote)
	//		emote_player_object.playtimeline(%[seg:0, page:"fore", name:"差分用_waiting_loop"]);
	//	else
	//		emote_player_object.stoptimeline(%[seg:0, page:"fore"]);
	//}
	function changeMsgDesign0(obj){
		sysHMsgDesign = 0;
		resetMsgDesign();
	}
	function changeMsgDesign1(obj){
		sysHMsgDesign = 1;
		resetMsgDesign();
	}
	function changeMsgDesign2(obj){
		sysHMsgDesign = 2;
		resetMsgDesign();
	}
	function resetMsgDesign(){
		if(kag.mainConductor.curStorage == "title.ks")return;	// タイトル画面では無視
		// メッセージウィンドウも変更
		try{
			if(f.isHScene){
				if(sysHMsgDesign === 2){
					kag.fore.messages[0].setPosition(%[frame:'LineBreak']);
					kag.back.messages[0].setPosition(%[frame:'LineBreak']);
				}else if(sysHMsgDesign === 1){
					kag.fore.messages[0].setPosition(%[frame:'g_frame_h']);
					kag.back.messages[0].setPosition(%[frame:'g_frame_h']);
					kag.fore.messages[0].opacity = kag.fore.messages[1].opacity = sysHMsgOpacity;
					kag.back.messages[0].opacity = kag.back.messages[1].opacity = sysHMsgOpacity;
				}else{// 0
					kag.fore.messages[0].setPosition(%[frame:'g_frame']);
					kag.back.messages[0].setPosition(%[frame:'g_frame']);
					kag.fore.messages[0].opacity = kag.fore.messages[1].opacity = sysMsgOpacity;
					kag.back.messages[0].opacity = kag.back.messages[1].opacity = sysMsgOpacity;
					kag.fore.messages[0].visible = kag.fore.messages[1].visible = true;
					kag.back.messages[0].visible = kag.back.messages[1].visible = true;
				}
			}
		}catch(e){
			dm("メッセージウィンドウのデザイン変更に失敗しました");
			dm(e.message);
		}
	}

	function changeColorAll(){
		for(var i=0; i<config.count; i++){
			config[i].changeColor();
		}
		design = getSysDesignChar();
		sysBgLayer.changeDesign(showingPage);
		resetMsgDesign();
	}
	function onSysDesignChange0(obj){sysDesign = 0; changeColorAll();}
	function onSysDesignChange1(obj){sysDesign = 1; changeColorAll();}
	function onSysDesignChange2(obj){sysDesign = 2; changeColorAll();}
	function onSysDesignChange3(obj){sysDesign = 3; changeColorAll();}
	function onSysDesignChange4(obj){sysDesign = 4; changeColorAll();}
	function onSysDesignChange5(obj){sysDesign = 5; changeColorAll();}

	function setCustomKey0(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[0][0] ]);}
	function setCustomKey1(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[1][0] ]);}
	function setCustomKey2(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[2][0] ]);}
	function setCustomKey3(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[3][0] ]);}
	function setCustomKey4(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[4][0] ]);}
	function setCustomKey5(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[5][0] ]);}
	function setCustomKey6(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[6][0] ]);}
	function setCustomKey7(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[7][0] ]);}
	function setCustomKey8(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[8][0] ]);}
	function setCustomKey9(obj){setCustomKeyFunction(obj,  global[ glShortcutKeyOrder[9][0] ]);}
	function setCustomKey10(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[10][0] ]);}
	function setCustomKey11(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[11][0] ]);}
	function setCustomKey12(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[12][0] ]);}
	function setCustomKey13(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[13][0] ]);}
	function setCustomKey14(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[14][0] ]);}
	function setCustomKey15(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[15][0] ]);}
	function setCustomKey16(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[16][0] ]);}
	function setCustomKey17(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[17][0] ]);}
	function setCustomKey18(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[18][0] ]);}
	function setCustomKey19(obj){setCustomKeyFunction(obj, global[ glShortcutKeyOrder[19][0] ]);}

	function setCustomKeyFunction(obj, no){
		if( (isOverlap != -1 && config[isOverlap].shortcutObj!==void)){
			config[isOverlap].shortcutObj.input(obj, no);
		}else if(isOverlap == -1 && config[showingPage].shortcutObj!==void){
			config[showingPage].shortcutObj.input(obj, no);
		}
	}

	// フルスクリーン・ウィンドウ切り替え
	function changeScreenMode()
	{
		if(kag.fullScreened){
			kag.onWindowedMenuItemClick();
		}else{
			kag.onFullScreenMenuItemClick();
		}
	}

	function setNewFont()
	{
		kag.selectFont();
		kag.saveSystemVariables();
		drawFontSample(config[showingPage].ConfigButtons[17]);
	}

	function drawFontSample(obj)
	{
		obj.fillRect(0,0,obj.width,obj.height,0x0);
		obj.font.face = kag.chDefaultFace;
		obj.drawText(0, 0, obj.sampleCh, 0xffffff, 255, false);
	}

	function changeGenitalCall_a(obj){ sf[genChr+"男性器呼称"] = obj.check; }
	function changeGenitalCall_b(obj){ sf[genChr+"男性器呼称"] = !obj.check; }
	function changeGenitalCall_c(obj){ sf[genChr+"女性器呼称"] = obj.check; }
	function changeGenitalCall_d(obj){ sf[genChr+"女性器呼称"] = !obj.check; }

	// 操作対象のキャラクターを再設定
	function changeVoiceVolumeTarget(obj = void)
	{
		if(obj !== void)volChr = obj.chrName;

		// volchrに従って各種項目を調整
		resetEditTarget();
	}
	function changeGenitalCallTarget(obj = void)
	{
		// 変更前に前のキャラクターの呼び方を適用
		if(tinNameObj !== void)sf[genChr+"ルート男性器呼び名"] = tinNameObj.text;
		if(manNameObj !== void)sf[genChr+"ルート女性器呼び名"] = manNameObj.text;
		//if(tinNameObj !== void)sf["主人公男性器呼称"] = tinNameObj.text;
		//if(manNameObj !== void)sf["主人公女性器呼称"] = manNameObj.text;
		if(obj !== void)genChr = obj.chrName;
		resetEditTarget();
	}
	function changeChColorTarget(obj = void)
	{
		// ここでは戻らず、警告を出すのみ。mnemonicobjの中はもとに戻ってるはず。
		commitCallName();
		if(obj !== void)chChr = obj.chrName;
		resetEditTarget();
	}

	function resetEditTarget(obj = void){
		if(bgChangeTargetLayer !== void){
			try{
				if(obj !== void && obj.fakeName != ""){
					bgChangeTargetLayer.loadImages("cfg_vobg_"+obj.fakeName);
				}else{
					bgChangeTargetLayer.loadImages("cfg_vobg_"+volChr);
				}
				if(!sf.美麗名前フラグ && volChr == "美麗"){
					bgChangeTargetLayer.loadImages("cfg_vobg_美麗2");
				}
			}catch(e){
				//bgChangeTargetLayer.loadImages("cfg_vobg_"+volChr);
				dm("ボイス変更背景差し替え失敗");
			}
		}
		if(bgChangeHTargetLayer !== void){
			try{
				if(obj !== void && obj.fakeName != ""){
					bgChangeHTargetLayer.loadImages("cfg_vobg_"+obj.fakeName);
				}else{
					bgChangeHTargetLayer.loadImages("cfg_vobg_"+genChr);
				}
			}catch(e){
				//bgChangeHTargetLayer.loadImages("cfg_vobg_"+genChr);
				dm("性器呼称変更背景差し替え失敗");
			}
		}
		//￡:個別音量を選択されているキャラの名前画像の表示
		if(voiceNameTargetLayer !== void){
			try{
				if(obj !== void && obj.fakeName != ""){
					voiceNameTargetLayer.loadImages("cfg_chr_"+obj.fakeName);
				}else{
					voiceNameTargetLayer.loadImages("cfg_chr_"+volChr);
				}
				if(!sf.美麗名前フラグ && volChr == "美麗"){
					voiceNameTargetLayer.loadImages("cfg_chr_美麗2");
				}
			}catch(e){
				dm("ボイスキャラ名差し替え失敗");
			}
		}
		//￡:キャラ別文字色を選択されているキャラの名前画像の表示
		if(colorNameTargetLayer !== void){
			try{
				if(obj !== void && obj.fakeName != ""){
					colorNameTargetLayer.loadImages("cfg_chr_"+obj.fakeName);
				}else{
					colorNameTargetLayer.loadImages("cfg_chr_"+chChr);
				}
			}catch(e){
				dm("文字色キャラ名差し替え失敗");
			}
		}
		//￡:キャラ別性器呼称を選択されているキャラの名前画像の表示
		if(genitalNameTargetLayer !== void){
			try{
				if(obj !== void && obj.fakeName != ""){
					genitalNameTargetLayer.loadImages("cfg_chr_"+obj.fakeName);
				}else{
					genitalNameTargetLayer.loadImages("cfg_chr_"+genChr);
				}
			}catch(e){
				dm("性器呼称キャラ名差し替え失敗");
			}
		}
		//￡:ヒロイン以外が選択されたら「変更する」ボタンを隠す
		if(txtChangeTargetLayer !== void){
			if(chChr == "その他男" || chChr == "その他女" || chChr == "主人公"){
				txtChangeTargetLayer.visible = false;
			}else{
				txtChangeTargetLayer.visible = true;
			}
		}

		// キャラクターの呼び方エディットボックスを正規化
		if(tinNameObj !== void)tinNameObj.text = sf[genChr+"ルート男性器呼び名"];
		if(manNameObj !== void)manNameObj.text = sf[genChr+"ルート女性器呼び名"];
		//if(tinNameObj !== void)tinNameObj.text = sf["主人公男性器呼称"];
		//if(manNameObj !== void)manNameObj.text = sf["主人公女性器呼称"];

		// ヒロインの性器呼称のボタンの正規化
		if(genCallObja !== void)genCallObja.check =  sf[genChr+"男性器呼称"];
		if(genCallObjb !== void)genCallObjb.check = !sf[genChr+"男性器呼称"];
		if(genCallObjc !== void)genCallObjc.check =  sf[genChr+"女性器呼称"];
		if(genCallObjd !== void)genCallObjd.check = !sf[genChr+"女性器呼称"];

		if(personalVoiceSliderObj !== void){
			personalVoiceSliderObj.position = sf["vol"+volChr];
			personalVoiceSliderObj.ShowValueLayerUpdate();
		}

		if(personalBgvSliderObj !== void){
			personalBgvSliderObj.position = sf["bgv"+volChr];
			personalBgvSliderObj.ShowValueLayerUpdate();
		}

		if(personalSysVoiceSliderObj !== void){
			personalSysVoiceSliderObj.position = sf["sys"+volChr];
			personalSysVoiceSliderObj.ShowValueLayerUpdate();
		}

		if(chColorSliderRObj !== void){
			chColorSliderRObj.position = (sf["fcp"+chChr]&0xff0000)>>16;
			chColorSliderRObj.ShowValueLayerUpdate();
		}
		if(chColorSliderGObj !== void){
			chColorSliderGObj.position = (sf["fcp"+chChr]&0x00ff00)>>8;
			chColorSliderGObj.ShowValueLayerUpdate();
		}
		if(chColorSliderBObj !== void){
			chColorSliderBObj.position = (sf["fcp"+chChr]&0x0000ff);
			chColorSliderBObj.ShowValueLayerUpdate();
		}
		if(voMuteObj !== void){
			voMuteObj.check = sf["vom"+volChr];
			voMuteObj.linkObj.check = !sf["vom"+volChr];
		}

		if( bgvMuteObj !== void )
		{
			bgvMuteObj.check         = !sf["bgm"+volChr];
			//bgvMuteObj.linkObj.check = !sf["bgm"+volChr];
		}

		if( sysVoMuteObj !== void )
		{
			sysVoMuteObj.check         = !sf["sym"+volChr];
			//sysVoMuteObj.linkObj.check = !sf["sym"+volChr];
		}

		characterMsgSampleFillRect();

		// システムキャラのチェックボックスの状態を変更
		if(systemVoiceCheckObj !== void){
			systemVoiceCheckObj.check = (sysSystemVoiceChr == volChr);
			systemVoiceCheckObj.visible = (sysCharacterVoiceList[volChr] !== void);
		}

		// エディットボックスを隠す処理
		if(mnemonicNameObj !== void){
			if(chChr!="その他男" && chChr!="その他女" && chChr!="主人公"){
				mnemonicNameObj.text = sf[chChr+"呼び名"];
				mnemonicNameObj.visible = true;
			}else mnemonicNameObj.visible = false;
		}
	}

	// システムボイスの変更
	function changeSystemVoiceCharacter(obj)
	{
		if(obj.check)sysSystemVoiceChr = volChr;
	}

	// ※システムボイスを個別にOnOffする機能がある場合の追加関数
	// 萌桃香のシステムボイスのONOFF
//	function onSystemVoiceMomoka(obj){
//		sysSystemVoiceMomoka = obj.check = !sysSystemVoiceMomoka;
//	}
	// ショコラのシステムボイスのONOFF
//	function onSystemVoiceSyokora(obj){
//		sysSystemVoiceSyokora = obj.check = !sysSystemVoiceSyokora;
//	}

	function changeSystemVoiceVolume(obj)
	{
		sysSystemVoiceVolume = obj.position;

		// リアルタイムにボイスボリュームを変更
		if(obj.position == 0)
			kag.se[kag.numSEBuffers-5].setOptions(%[volume:100,gvolume:0]);
		else
			kag.se[kag.numSEBuffers-5].setOptions(%[volume:100,gvolume:(sysSystemVoiceVolume*obj.position)]);
	}

	// 既読文字色の色変更ON/OFF関数(サンプル文字列用タイマー呼び出し用にここに書いた)
	function changeAlreadyReadColorOnOff(obj)
	{
		sysNotYetReadColor = obj.check;
		alreadyReadSetFontColor();
	}

	// 既読文字色の色変更ON関数
	function changeAlreadyReadColorOn()
	{
		sysNotYetReadColor = true;
		alreadyReadSetFontColor();
	}

	// 既読文字色の色変更OFF関数
	function changeAlreadyReadColorOff()
	{
		sysNotYetReadColor = false;
		alreadyReadSetFontColor();
	}

	// 既読文字色再設定
	function changeAlreadyReadColorSlider(obj = void)
	{
		if(alreadyReadColorSliderRObj !== void){
			alreadyReadColorSliderRObj.position = (sysAlreadyReadColor&0xff0000)>>16;
			alreadyReadColorSliderRObj.ShowValueLayerUpdate();
		}
		if(alreadyReadColorSliderGObj !== void){
			alreadyReadColorSliderGObj.position = (sysAlreadyReadColor&0x00ff00)>>8;
			alreadyReadColorSliderGObj.ShowValueLayerUpdate();
		}
		if(alreadyReadColorSliderBObj !== void){
			alreadyReadColorSliderBObj.position = (sysAlreadyReadColor&0x0000ff);
			alreadyReadColorSliderBObj.ShowValueLayerUpdate();
		}
	}

	function resetAlreadyReadColorSlider( obj = void )
	{
		sysAlreadyReadColor = 0xcccccc;
		changeAlreadyReadColorSlider();
		alreadyReadSetFontColor();
	}

	function alreadyReadSetFontColor()
	{
		setFontColor();
		config[showingPage].sampleChTimerEnabled();
	}

	// キャラクターの音量を調整
	function changeVoiceVolume(obj)
	{
		sf["vol"+volChr] = obj.position;
		// リアルタイムにボイスボリュームを変更
		if(obj.position == 0 || sf["vom"+volChr] ) kag.se[kag.numSEBuffers-4].setOptions(%[volume:100,gvolume:0]);
		else							   		   kag.se[kag.numSEBuffers-4].setOptions(%[volume:100,gvolume:(sysVoiceVolume*obj.position)]);
	}

	// キャラクターのミュート状態を変更
	function changeVoiceMute(obj)
	{
		if(voMuteObj !== void)
		{
			sf["vom"+volChr] = !voMuteObj.check;
		}
	}

	function changeBgvVolume( obj )
	{
		sf["bgv"+volChr] = obj.position;
		// リアルタイムにボイスボリュームを変更
		if(obj.position == 0 || sf["bgm"+volChr] )	kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:0]);
		else										kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:(sysBGVVolume*obj.position)]);
	}

	function changeBgvMute( obj )
	{
		if( bgvMuteObj !== void )
		{
			sf["bgm"+volChr] = !bgvMuteObj.check;
		}
	}

	function changeSysVoiceVolume( obj )
	{
		sf["sys"+volChr] = obj.position;
		// リアルタイムにボイスボリュームを変更
		if(obj.position == 0 || sf["sym"+volChr]) kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:0]);
		else									  kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:(sysSystemVoiceVolume*obj.position)]);
	}

	function changeSysVoiceMute( obj )
	{
		if( sysVoMuteObj !== void )
		{
			sf["sym"+volChr] = !sysVoMuteObj.check;
		}
	}

	// キャラクターごとの文字色サンプル塗りつぶし
	function characterMsgSampleFillRect()
	{
		if(characterMsgSampleObj !== void){
			characterMsgSampleObj.face = dfMain;
			characterMsgSampleObj.holdAlpha = true;
			characterMsgSampleObj.fillRect(0,0,characterMsgSampleObj.width,characterMsgSampleObj.height, sf["fcp"+chChr]);
		}

		if(config[showingPage].chrNameLayers.count == 0)return;

		if(showingPage == 0){
			with(config[showingPage]){
				for(var i=0; i<.chrNameLayers.count; i++){
					var name = .chrNameLayers[i].chrName;
					setFontColor(name);
					var ar = fullnameForChChrColor();
					var str = ar[name];
					var fw = 0;
					if(str === void){
						System.inform("キャラクター毎の文字色変更で本名の特定に失敗");
						return;
					}
					for(var i=0; i<str.length; i++)fw += .chrNameLayersTemp.font.getTextWidth(str.charAt(i));
					var fh = .chrNameLayersTemp.font.getTextHeight(str);
					if(fw >= .chrNameLayersTemp.imageWidth)fw = .chrNameLayersTemp.imageWidth;
					.font.size = 20;
					.font.face = "VLG20";
					.chrNameLayersTemp.fillRect(0,0,.chrNameLayersTemp.imageWidth,.chrNameLayersTemp.imageHeight,0x0);
					.chrNameLayersTemp.drawText(0,0,str,0xffffff);
					for(var j=0; j<.chrNameLayersTemp.imageWidth; j++){
						.chrNameLayersTemp.operateRect(my_ll.width*j,0,my_ll,0,0,my_ll.width,my_ll.height,omPsMultiplicative,255);
					}
					.chrNameLayers[i].fillRect(0,0,.chrNameLayers[i].imageWidth, .chrNameLayers[i].imageHeight, 0x0);
					// フォントサイズから縮小率を出す
					var lw = fw;
					if(lw > .chrNameLayers[i].imageWidth-20){
						// 長すぎる場合調整
						lw = .chrNameLayers[i].imageWidth-20;
						.chrNameLayers[i].stretchCopy(8,(.chrNameLayers[i].imageHeight>>1)-(fh>>1),lw,fh,.chrNameLayersTemp,0,0,fw,fh, stFastLinear);
					}else{
						.chrNameLayers[i].stretchCopy((.chrNameLayers[i].imageWidth>>1)-(fw>>1),(.chrNameLayers[i].imageHeight>>1)-(fh>>1),lw,fh,.chrNameLayersTemp,0,0,fw,fh, stFastLinear);
					}
				}
			}
		}
		setFontColor(chChr);
	}

	function alreadyMsgSampleFillRect()
	{
		//if(alreadyMsgSampleObj === void)return;
		//sysAlreadyReadColor
	}

	// 既読文字色決定スライダー
	function onAlreadyChColorChangeR(obj){onAlreadyChColorChange(obj, 2);}
	function onAlreadyChColorChangeG(obj){onAlreadyChColorChange(obj, 1);}
	function onAlreadyChColorChangeB(obj){onAlreadyChColorChange(obj, 0);}
	function onAlreadyChColorChange(obj, index){
		var colorAr = [(sysAlreadyReadColor&0x0000ff), (sysAlreadyReadColor&0x00ff00), (sysAlreadyReadColor&0xff0000)];
		var color = 0;
		for(var i=0; i<colorAr.count; i++){
			if(index == i)color += ((int)obj.position << (i*8));
			else color += colorAr[i];
		}
		sysAlreadyReadColor = color;
		setFontColor();
		alreadyMsgSampleFillRect();
		config[showingPage].sampleChTimerEnabled();
	}

	// 文字色決定スライダー用関数群
	function onCharacterChColorChangeR(obj){onCharacterChColorChange(obj, 2);}
	function onCharacterChColorChangeG(obj){onCharacterChColorChange(obj, 1);}
	function onCharacterChColorChangeB(obj){onCharacterChColorChange(obj, 0);}
	function onCharacterChColorChange(obj, index){
		var colorAr = [(sf["fcp"+chChr]&0x0000ff), (sf["fcp"+chChr]&0x00ff00), (sf["fcp"+chChr]&0xff0000)];
		var color = 0;
		for(var i=0; i<colorAr.count; i++){
			if(index == i)color += ((int)obj.position << (i*8));
			else color += colorAr[i];
		}
		sf["fcp"+chChr] = color;
		characterMsgSampleFillRect();
	}

	function onSetSliderMin(obj)
	{
		var target = config[showingPage].ConfigButtons;
		var index = target.find(obj);
		if(index >= target.count-1)return false;

		target[index+1].minimum();
	}

	function onSetSliderMax(obj)
	{
		var target = config[showingPage].ConfigButtons;
		var index = target.find(obj);
		if(index <= 0)return false;

		target[index-1].maxmum();
	}

	function onSampleWindowChangeNormal(obj)
	{
		isHSceneWndSelected = !obj.check;
		onSampleWindowChanged();
	}

	function onSampleWindowChangeHScene(obj)
	{
		isHSceneWndSelected = obj.check;
		onSampleWindowChanged();
	}
	function onSampleWindowChanged(){
		sf.cfgPreviewWinNow = isHSceneWndSelected;
		if(msgOpacitySliderObj!==void){
			if(isHSceneWndSelected){
				msgOpacitySliderObj.loadImages("cfg_sample_h");
				msgOpacitySliderObj.opacity = sysHMsgOpacity;
			}else{
				msgOpacitySliderObj.loadImages("cfg_sample");
				msgOpacitySliderObj.opacity = sysMsgOpacity;
			}
		}
	}

	function onOpacitySlider(obj)
	{
		sysMsgOpacity = obj.position;
		// 登録された不透明度変更対象があれば不透明度変更
		if(msgOpacitySliderObj!==void && !isHSceneWndSelected)msgOpacitySliderObj.opacity = sysMsgOpacity;
    
		try{
			if(kag.fore.messages[0].frameGraphic != "g_frame_h")
				global._setMsgOpacity(sysMsgOpacity);
		}catch(e){
			global._setMsgOpacity(sysMsgOpacity);
		}
	}


	function onHOpacitySlider(obj)
	{
		sysHMsgOpacity = obj.position;
		// 登録された不透明度変更対象があれば不透明度変更
		if(hmsgOpacitySliderObj!==void)hmsgOpacitySliderObj.opacity = sysHMsgOpacity;
		if(f.isHScene && sysHMsgDesign === 1)global._setMsgOpacity(sysHMsgOpacity);

		// プレビュー用のレイヤーが通常/H共用だった場合の動作
		if(msgOpacitySliderObj!==void && sf.cfgPreviewWinNow)msgOpacitySliderObj.opacity = sysHMsgOpacity;
	}

	function onHSceneOpacitySlider(obj)
	{
		sysHMsgOpacity = obj.position;
		// 登録された不透明度変更対象があれば不透明度変更
		if(msgOpacitySliderObj!==void && isHSceneWndSelected)msgOpacitySliderObj.opacity = sysHMsgOpacity;

		try{
			if(kag.fore.messages[0].frameGraphic == "g_frame_h")
				global._setMsgOpacity(sysHMsgOpacity);
		}catch(e){
			global._setMsgOpacity(sysHMsgOpacity);
		}
	}
/*
	function onReadSpeed(obj)
	{
		if(obj.position == 60){
			kag.userChSpeed = -4;
			kag.setUserSpeed();
		}else{
			kag.userChSpeed = (70 - obj.position);
			kag.setUserSpeed();
		}
		sysNotYetReadSpeed = obj.position;
		config[showingPage].sampleChTimerEnabled();
	}
*/
	function onReadSpeed(obj)
	{
		if(obj.position == 60){
			kag.userChSpeed = 0;
			kag.setUserSpeed();
			kag.userCh2ndSpeed = 0;
			kag.setUserSpeed();
		}else{
			kag.userChSpeed = (70 - obj.position);
			kag.setUserSpeed();
			kag.userCh2ndSpeed = (70 - obj.position);
			kag.setUserSpeed();
		}
		sysNotYetReadSpeed = obj.position;
		config[showingPage].sampleChTimerEnabled();
	}

	function onAlreadyReadSpeed(obj)
	{
		if(obj.position == 60){
			kag.userCh2ndSpeed = 0;
			kag.setUserSpeed();
		}else{
			kag.userCh2ndSpeed = (70 - obj.position);
			kag.setUserSpeed();
		}
		sysAlreadyReadSpeed = obj.position;
		config[showingPage].sampleChTimerEnabled();
	}

	function onAutoSpeed(obj)
	{
		var pos = obj.position;
		//pos = 3900 - pos;
		kag.autoModePageWait = pos;
		kag.autoModeLineWait = int(pos / 3);
		sysAutoSpeed = obj.position;
	}

	// ミュート設定
	function onGlobalVolMute(obj){sysGlobalVolumeMute = obj.check, WaveSoundBuffer.globalVolume = sysGlobalVolume;}
	function onBgmVolMute(obj){sysBgmVolumeMute = obj.check, kag.bgm.setOptions(%[volume:100,gvolume:sysBgmVolume]);}
	function onSeVolMute(obj){
		sysSeVolumeMute = obj.check;
		if(f.isHScene)return;
		for(var i = 0; i < kag.numSEBuffers-4; i++)
				kag.se[i].setOptions(%[/*volume:100*/,gvolume:sysSeVolume]);
	}
	function onHSeVolMute(obj){
		sysHSeVolumeMute = obj.check;
		if(!f.isHScene)return;
		for(var i = 0; i < kag.numSEBuffers-4; i++)
			kag.se[i].setOptions(%[/*volume:100*/,gvolume:sysHSeVolume]);
	}
	function onVoiceVolMute(obj){sysVoiceVolumeMute = obj.check, kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:sysVoiceVolume]);}
	function onSystemVolMute(obj){sysSystemVolumeMute = obj.check, kag.se[kag.numSEBuffers-1].setOptions(%[volume:100,gvolume:sysSystemVolumeR]);}
	function onBGVVolMute(obj){sysBGVVolumeMute = obj.check; global.bgv_object.allChangeVolume();}
	//function onBGVVolMute(obj){sysBGVVolumeMute = obj.check; if(global.bgv_object.bgvPlaying)global.bgv_object.bgv.setOptions(%[volume:sysBGVVolume]);}
	function onSecondAudioMute(obj){ sysSecondAudioVolumeMute = obj.check; }

	function onGlobalVol(obj)
	{
		sysGlobalVolume = obj.position;
		WaveSoundBuffer.globalVolume = sysGlobalVolume;
	}

	function onBgmVol(obj)
	{
		sysBgmVolume = obj.position;
		if(obj.position == 0)
			kag.bgm.setOptions(%[volume:100,gvolume:0]);
		else
			kag.bgm.setOptions(%[volume:100,gvolume:sysBgmVolume]);
	}

	function onSeVol(obj)
	{
		// SEボリュームのスクリプトからの変更を可能にするためにここでのボリュームは調整しない
		sysSeVolume = obj.position;
		if(f.isHScene)return;
		if(obj.position == 0){
			for(var i = 0; i < kag.numSEBuffers-4; i++)
				kag.se[i].setOptions(%[/*volume:100*/,gvolume:0]);
		}else{
			for(var i = 0; i < kag.numSEBuffers-4; i++)
				kag.se[i].setOptions(%[/*volume:100*/,gvolume:sysSeVolume]);
		}
	}

	function onHSeVol(obj)
	{
		sysHSeVolume = obj.position;
		if(!f.isHScene)return;
		if(obj.position == 0){
			for(var i = 0; i < kag.numSEBuffers-4; i++)
				kag.se[i].setOptions(%[/*volume:100*/,gvolume:0]);
		}else{
			for(var i = 0; i < kag.numSEBuffers-4; i++)
				kag.se[i].setOptions(%[/*volume:100*/,gvolume:sysHSeVolume]);
		}
	}

	function onVoiceVol(obj)
	{
		sysVoiceVolume = obj.position;
		if(obj.position == 0)
			kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:0]);
		else
			kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:sysVoiceVolume]);
	}

	function onSystemVol(obj)
	{
		sysSystemVolume = obj.position;
		if(obj.position == 0)
			kag.se[kag.numSEBuffers-1].setOptions(%[volume:100,gvolume:0]);
		else
			kag.se[kag.numSEBuffers-1].setOptions(%[volume:100,gvolume:sysSystemVolume]);
	}

	function onBgmDownVol(obj)
	{
		sysBgmDownVolume = obj.position;
	}

	function onBGVVol(obj)
	{
		sysBGVVolume = obj.position;
		if(obj.position == 0)
			kag.se[kag.numSEBuffers-3].setOptions(%[volume:100,gvolume:0]);
		else
			kag.se[kag.numSEBuffers-3].setOptions(%[volume:100,gvolume:sysBGVVolume]);
	}

	function onSecondAudioVol( obj )
	{
		sysSecondAudioVolume = obj.position;
		if(obj.position == 0)
			kag.se[kag.numSEBuffers-3].setOptions(%[volume:100,gvolume:0]);
		else
			kag.se[kag.numSEBuffers-3].setOptions(%[volume:100,gvolume:sysSecondAudioVolume]);
	}

	function onSeTest(){ _playSoundForConfig(); }
	function onHSeTest(){ _playHSoundForConfig(); }
	function onVoiceTest(){ _playVoiceForConfig(); }
	function onVoiceTestPersonal(){ _playVoiceForConfig(volChr); }
	function onBGVTest(){ _playBgvForConfig(); }
	function onBGVTestPersonal(){ _playBgvForConfig( volChr ); }
	function onSecondAudioTest(){ _playSecondAudioForConfig(); }
	function onSysVoiceTest(){ _playSysVoiceForConfig(); }
	function onSysVoiceTestPersonal(){ _playSysVoiceForConfig( volChr ); }

	function onSystemTest()
	{
		playSystemSound(
			["sys_se_on",
			"sys_se_ok",
			"sys_se_cancel"
			][intrandom(0,2)]);
	}

	function onFadeBgmTest(obj)
	{
		if(sysBgmTempFade){
			onVoiceTest();
			kag.bgm.fade(%[volume:(int)sysBgmDownVolume, time:300]);
			tf.bgmTempFadeFlag=true;
		}
	}

	function onBgmTitleShow(){ sysShowBgmTitle=true; }
	function onBgmTitleNoShow(){ sysShowBgmTitle=false; }

	function onVoiceNoStop(){sysVoiceCancel=false;}
	function onVoiceStop(){sysVoiceCancel=true;}

	// 副音声モード切替関数
	function onChangeSecondAudioCgOn()   {sysRealIntentionCG = true; onChangeSecondAudioCgChange();}
	function onChangeSecondAudioCgOff()  {sysRealIntentionCG = false; onChangeSecondAudioCgChange();}
	function onChangeSecondAudioTextOn() {sysRealIntentionText = true; onChangeSecondAudioTextChange();}
	function onChangeSecondAudioTextOff(){sysRealIntentionText = false; onChangeSecondAudioTextChange();}
	// 副音声用文字置換：tf.****Textがある間、メッセージの置換が行われる
	// タイトル・ロード時・改ページ時にクリアされる
	function onChangeSecondAudioTextChange(){
		if(tf.frontText !== void && tf.frontText != "" && tf.backText != ""){
			var str = tf.frontText;
			if(sysRealIntentionText)str = tf.backText;
			kag.messageLayer.clear();
			for(var i=0; i<str.length; i++)kag.messageLayer.processCh(str.charAt(i));
		}
	}
	// 副音声用CG切り替え
	function onChangeSecondAudioCgChange(){
		try{
			if(kag.fore.layers[0].Anim_loadParams!==void){
				var storage = Storages.chopStorageExt(kag.fore.layers[0].Anim_loadParams["storage"]);
				if(storage != "" && storage !== void && storage.substr(0,2) == "ev"){
					var ies = Storages.isExistentStorage;
					if(!sysRealIntentionCG){
						// 裏CG
						if(storage.charAt(storage.length-1) != "2"){
							if(ies(storage+"2.png") || ies(storage+"2.tlg") || ies(storage+"2.jpg")){
								kag.fore.layers[0].loadImages(%[storage:storage+"2"]);
								kag.back.layers[0].loadImages(%[storage:storage+"2"]);
							}
							dm("表→裏への切り替え成功");
						}
					}else{
						// 表CG
						if(storage.charAt(storage.length-1) == "2"){
							var s = storage.substr(0,storage.length-1);
							if(ies(s+".png") || ies(s+".tlg") || ies(s+".jpg")){
								kag.fore.layers[0].loadImages(%[storage:s]);
								kag.back.layers[0].loadImages(%[storage:s]);
							}
							dm("裏→表への切り替え成功");
						}
					}
				}
			}
		}catch(e){
			dm("画像のリアルタイム入れ替えに失敗");
		}
	}

	// グロ表現 アリ=デフォルト=フラグtrue=2付かない
	function onChangeGoreCgOn()   {sysGoreCG = true;  onChangeGoreCgChange();}
	function onChangeGoreCgOff()  {sysGoreCG = false; onChangeGoreCgChange();}

	function onChangeGoreCgChange(){
		try{
			if(kag.fore.layers[0].Anim_loadParams!==void){
				var storage = Storages.chopStorageExt(kag.fore.layers[0].Anim_loadParams["storage"]);
				if(storage != "" && storage !== void && storage.substr(0,2) == "ev"){
					var ies = Storages.isExistentStorage;
					if(!sysGoreCG){
						// グロ表現ナシ
						//if(storage.charAt(storage.length-1) != "2"){
						if(storage.substring(storage.length-5,5) != "_gore"){
							if(ies(storage+"_gore.png") || ies(storage+"_gore.tlg") || ies(storage+"_gore.jpg")){
								kag.fore.layers[0].loadImages(%[storage:storage+"_gore"]);
								kag.back.layers[0].loadImages(%[storage:storage+"_gore"]);
							}
							dm("表→裏への切り替え成功");
						}
					}else{
						// グロ表現アリ
						if(storage.substring(storage.length-5,5) == "_gore"){
							var s = storage.substr(0,storage.length-5);
							if(ies(s+".png") || ies(s+".tlg") || ies(s+".jpg")){
								kag.fore.layers[0].loadImages(%[storage:s]);
								kag.back.layers[0].loadImages(%[storage:s]);
							}
							dm("裏→表への切り替え成功");
						}
					}
				}
			}
		}catch(e){
			dm("画像のリアルタイム入れ替えに失敗");
		}
	}

	function onLoadDefault(){
		if(aynLoadDefault()){
			this.onLoadDefault_sub();
		}
	}

	function onLoadDefault_sub(){
		loadDefaultValue();
		if(msgSampleObj !== void){
			msgSampleObj.setDefaultFont(%[size:globalDefFontSize, face:kag.chDefaultFace, bold:false]);
			msgSampleObj.resetFont();
			config[showingPage].sampleChTimerEnabled();
		}
		if(hMsgSampleObj !== void){
			hMsgSampleObj.setDefaultFont(%[size:globalDefFontSize, face:kag.chDefaultFace, bold:false]);
			hMsgSampleObj.resetFont();
			config[showingPage].sampleChTimerEnabled();
		}
		try{
			global.gameButton_object.setLockImage();
		}catch(e){
			dm(e.message);
		}
		// 射精カウンターの位置・表示状態調整
		try{global.counterObj.visibleChange();}catch(e){dm(e.message);}
		try{global.counterObj.adjustPosition();}catch(e){dm(e.message);}

		setSystemSettings();
		for(var i=0; i<config.count; i++){
			for(var j=0; j<config[i].ConfigButtons.count; j++){
				var _class = config[i].ConfigButtonsType[j];
				if(_class == "check_4imgx4img" || _class == "check_4img" || _class == "check_4imgEx" || _class == "3_check" || _class == "2_check" || _class == "check_2imgEx")config[i].ConfigButtons[j].check=Scripts.eval(config[i].ConfigButtonsValue[j]);
				else if(_class == "slider"){
					config[i].ConfigButtons[j].position=Scripts.eval(config[i].ConfigButtonsValue[j]);
					config[i].ConfigButtons[j].ShowValueLayerUpdate();
				}
			}
		}
		//changeVoiceVolumeTarget();
		changeAlreadyReadColorSlider();
		// 不透明度のレイヤーを調整
		if(msgOpacitySliderObj!==void){
			msgOpacitySliderObj.opacity = sysMsgOpacity;
			global._setMsgOpacity(sysMsgOpacity);
		}
		// Hシーン用不透明度のレイヤーを調整
		if(hmsgOpacitySliderObj!==void){
			hmsgOpacitySliderObj.opacity = sysHMsgOpacity;
			if(f.isHScene && sysHMsgDesign === 1)global._setMsgOpacity(sysHMsgOpacity);
		}
		// ショートカットの再描画
		for(var i=0; i<config.count; i++){
			if(config[i].shortcutObj !== void)config[i].shortcutObj.draw();
		}
		// ラブリーコール画面再描画
		if( lastNameObj  !== void ) lastNameObj.text  = sf["苗字"];
		if( firstNameObj !== void ) firstNameObj.text = sf["名前"];
		//
		resetEditTarget();
	}

	function onPage1(){tf.config_show_page=0; systemSE(defConfigP1); changePage(0);}
	function onPage2(){tf.config_show_page=1; systemSE(defConfigP2); changePage(1);}
	function onPage3(){tf.config_show_page=2; systemSE(defConfigP3); changePage(2);}
	function onPage4(){tf.config_show_page=3; systemSE(defConfigP4); changePage(3);}
	function onPage5(){tf.config_show_page=4; systemSE(defConfigP5); changePage(4);}
	function onPage6(){changePage(5);}

	function onOverlapPage1(){overlapPage(0);}
	function onOverlapPage2(){overlapPage(1);}
	function onOverlapPage3(){overlapPage(2);}
	function onOverlapPage4(){overlapPage(3);}
	function onOverlapPage5(){overlapPage(4);}

	function onTitleBackButton(obj){
		// タイトルからの呼び出しだった場合、何も聞かずに閉じる

		if(callByTitle)onBackButton();

		else if(aynBackTitle()){
			kag.process("config.ks", "*back_title");
			onBackButton();
		}
	}

	function onExitButton(obj){
		var result = aynExitGame();
		return result ? kag.closeByScript(%[ask:false]) : false;
//		return kag.closeByScript(%[ask:false]);
	}

	function onBackButton()
	{
		if(isOverlap != -1){
			config[isOverlap].hide();
			isOverlap = -1;
		}else onConfigClose();
	}

//////////////////////////////////////////////////////////////////////

	// 以下、KAGPlugin のメソッドのオーバーライド

	function onRestore(f, clear, elm)
	{
		super.onRestore(...);
		closeConfig();
	}

	function onStore(f, elm){}
	function onStableStateChanged(stable){}
	function onMessageHiddenStateChanged(hidden){}
	function onCopyLayer(toback){}
	function onExchangeForeBack(){}
	function onSaveSystemVariables(){}
}
kag.addPlugin(global.config_object = new ConfigPlugin(kag));
@endscript
@endif
@return

; タイトルからコンフィグが呼ばれた場合
*showTitleConfig
@fovo
; コンフィグオープンボイス
@eval exp="try{ systemSE(defCallConfig); }catch(e){ dm(e.message); }"
@eval exp="if( tf.config_show_page === void ) tf.config_show_page = 0"
@eval exp="config_object.showByTitle(tf.config_show_page);"
@jump target="*bytitle"

; ゲーム中に呼ばれた場合
*showconfig
@fovo
; コンフィグオープンボイス
@eval exp="try{ systemSE(defCallConfig); }catch(e){ dm(e.message); }"
@eval exp="if( tf.config_show_page === void ) tf.config_show_page = 0"
@eval exp="config_object._show(tf.config_show_page);"
*bytitle
@locklink


;//**いらない感じが
;//**	*change_page
@eval exp="tf.slc_showing=true;"
@waittrig name="configFadeEnd"
*lovelycall_return
@waittrig name="config"
@waittrig name="configFadeEnd"
@eval exp="tf.slc_showing=false"
@unlocklink
@svo
@return

*back_title
@svo
@return storage="title.ks" target="*title_init"

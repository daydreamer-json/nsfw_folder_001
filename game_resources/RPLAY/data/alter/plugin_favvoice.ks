@iscript

class FavBlock extends Layer
{
	var logVoiceImg = "log_voice";
	var logVoiceX = 68;
	var logVoiceY = 20;
	var tjs, tjs2;

	var fvoiceDelImg = "favoritevoice_delete";
	var fvoiceDelX = 10;
	var fvoiceDelY = 20;
	var storage = "";
	var label = "";

	var voiceBt;
	var delBt;

	var favIndex = -1;

	function FavBlock(win, par){
		super.Layer(...);
		voiceBt = new FunctionButtonLayerEx(win, this, onVoice);
		voiceBt.loadImages( logVoiceImg );
		voiceBt.setPos(logVoiceX, logVoiceY);
		voiceBt.disableSystemSound();	// システムSE無効化
		voiceBt.visible = false;

		delBt = new FunctionButtonLayerEx(win, this, onDelete);
		delBt.loadImages( fvoiceDelImg );
		delBt.setPos(fvoiceDelX, fvoiceDelY);
		delBt.disableSystemSound();	// システムSE無効化
		delBt.visible = true;

//		if(typeof global.createCount == "undefined")global.createCount = 0;
//		em("create:"+(++global.createCount));
	}

	function finalize(){
		invalidate delBt if delBt !== void;
		invalidate voiceBt  if voiceBt  !== void;
		super.finalize(...);

//		if(typeof global.deleteCount == "undefined")global.deleteCount = 0;
//		em("delete:"+(++global.deleteCount));
	}

	function centeringBtTop(){
		voiceBt.top  = (height>>1)-(voiceBt.height>>1);
		delBt.top = (height>>1)-(delBt.height>>1);
	}

	function setHact(h = void){
		tjs = h;
		if( voiceBt !== void ) voiceBt.visible = (tjs !== void && tjs != "");
	}

	function setHact2(h = void){
		tjs2 = h;
	}

	function onVoice(){
		if(tjs !== void && tjs != ""){
			kag.cancelSkip();
			tjs!;
		}
	}

	function onDelete(){
		if(askYesNo("お気に入りボイスを削除します。\\nよろしいですか？")){
			sf.favoriteVoiceList.erase(favIndex);
			idleCall(kag.favLayer.reCreate);
		}
	}
}

class FavSmartScrollLayer extends Layer
{
	var drag = false;
	var dx,dy;
	var moveingStartTick = -1;
	var moveingStartY = 0;
	var timer;
	var moveHeight = 0;
	var movePer = 1.0;
	var owner;

	var virtualTop = 0;
	var virtualHeight = 400;
	var items = [];

	//	禁則文字
	var wwFollowing = "%),:;]}｡｣ﾞﾟ。，、．：；゛゜ヽヾゝゞ々’”）〕］｝〉》」』】°′″℃￠％‰"; 	// 行頭禁則文字
	var wwFollowingWeak="!.?､･ｧｨｩｪｫｬｭｮｯｰ・？！ーぁぃぅぇぉっゃゅょゎァィゥェォッャュョヮヵヶ"; 		// 行頭(弱)禁則文字
	var wwLeading="\\$([{｢‘“（〔［｛〈《「『【￥＄￡"; // 行末禁則文字
	wwFollowing += wwFollowingWeak;

	// テキストマージン
	var marginL = 130;
	var marginR = 40;
	var lineSpacing = 4;
	var fillBlock = true;		// ブロックの色付けを行うか
	
	var objs = [];

	function FavSmartScrollLayer(win, par){
		super.Layer(...);
		hitType = htMask;
		hitThreshold = 0;
		cursor = crHandPoint;
		timer = new Timer(onTimer,"");
		timer.interval = 20;
	}
	function finalize(){
		//items.clear();
		clearItem();
		super.finalize(...);
	}
	function onMouseDown(x, y, button, shift){
		if(button == mbRight){
			owner.visible = false;;
			return;
		}
		timer.enabled = false;
		drag = true;
		dx = x;
		dy = y;
	}
	function onMouseUp(x, y, button, shift){
		drag = false;

		var tick = System.getTickCount();
		// 移動して0.5秒以上たってない場合
		if((tick-moveingStartTick) < 500){
//			dm(top + moveingStartY);
			moveHeight = (top - moveingStartY)\8;
			movePer = 1.0;
			timer.enabled = true;
		}
	}
	function onMouseMove(x, y, shift){
		if(drag){
			checkTop();
			if(owner !== void){
				owner.slide(y-dy);
				dy = y;
			}
		}
	}
	// 動き出しの座標/時間を覚えて、0.5秒以上動きが無ければ忘れる。
	function checkTop()
	{
		var tick = System.getTickCount();
		if(moveingStartTick == -1 || (tick-moveingStartTick) > 500){
			moveingStartTick = tick;
			moveingStartY = top;
		}
	}
	function onTimer()
	{
		movePer -= 0.025;
		if(movePer < 0){
			timer.enabled = false;
			return;
		}
		//dm(moveHeight*movePer);
		if(owner !== void){
			owner.slide((int)moveHeight*movePer);
		}
	}
	function addItem(itop, ibottom, txt, tjs, tjs2, iHeight, itemIndex)
	{
		var index = items.add([itop, ibottom, txt, tjs, tjs2, void, iHeight, itemIndex]);	// 子をすべて受け取り設定
	}
	function getFreeObj(){
		for(var i=0; i<objs.count; i++){
			if(!objs[i].alive){
				objs[i].alive = true;
				objs[i].visible = true;
				return objs[i];
			}
		}
		var obj = new FavBlock(window, this);
		obj.alive = true;
		objs.add(obj);
		return obj;
	}
	function itemCheck()
	{
		// 画面外のオブジェクトは生存フラグを倒す
		var h = super.height;
		var objCount = 0;

		for(var i=0; i<items.count; i++){
			var item    = items[i];
			var itop    = item[0];
			var ibottom = item[1];
			var obj     = item[5];
			var iHeight = item[6];

			if(obj !== void){
				if((top+itop)> h || (top+ibottom)<0){
					item[5] = void;
					obj.visible = false;
					obj.alive = false;
				}
			}
		}

		for(var i=0; i<items.count; i++){
			var item = items[i];
			var itop = item[0];
			var ibottom = item[1];
			var txt = item[2];
			var tjs = item[3];
			var tjs2 = item[4];
			var obj = item[5];
			var iHeight = item[6];
			var itemIndex = item[7];

			if(obj !== void)objCount += 1;

			if((top+itop)<super.height && (top+ibottom)>0){
				// 画面内
				if(obj === void){
					// アイテム生成
					obj = item[5] = getFreeObj();
					//obj.setImageSize(owner.blockWidth, owner.blockHeight);
					obj.setImageSize(owner.blockWidth, iHeight);		// 履歴ブロックのサイズ確定
					obj.setSizeToImageSize();
					obj.centeringBtTop();		// ボイスボタン中央揃え
					createItem(obj, txt, tjs, tjs2);
					obj.top = (top+itop);
					obj.hitType = htMask;
					obj.hitThreshold = 256;
					obj.favIndex = itemIndex;
					obj.visible = true;
				}else{
					obj.top = (top+itop);
				}
			}else{
				// 画面外
				if(obj !== void){
					item[5] = void;
					obj.visible = false;
					obj.alive = false;
				}
			}
		}
		//dm("履歴ブロック数：" + objCount);
	}
	function clearItem(){
		items.clear();
		for(var i=0; i<objs.count; i++){
			invalidate objs[i];
		}
		objs.clear();
	}
	function createItem(obj, txt, tjs, tjs2){
		obj.setHact(tjs);
		obj.setHact2(tjs2);
		//obj.setJump(storage, label);
		// メッセージ描画
		drawMessage(obj, txt, (tjs!==void || tjs2!==void));
	}

	function drawMessage(obj, txt, hactEnable)
	{
		var fh;
		var ar        = [];
		var lineCount = 0;
		var lastch    = "";
		var len       = 0;
		var limitPos  = obj.width;
		var relinePos = obj.width - marginL - marginR;
		var lines     = txt.split("\n",,true);		// \nを改行として配列分割

		var indent     = true;
		var indentSize = obj.font.getTextWidth("「");

		obj.type = ltAlpha;
		obj.face = dfAlpha;
		// 履歴ブロック色付け
		if(fillBlock){
			obj.fillRect(0,0,obj.width,obj.height,0x08ffffff);
		}else{
			obj.fillRect(0,0,obj.width,obj.height,0x0);
		}
		obj.left = 0;

		fh = obj.font.height = 20;
		if(Storages.isExistentStorage("vlg20.tft")){
			obj.font.face = "VLG20";
			obj.font.mapPrerenderedFont("vlg20.tft");
		}

		for(var j=0; j<lines.count; j++){
			var _txt = lines[j];
			if(_txt.charAt(0) == "!")_txt = _txt.substr(1)!;	// 文字列が式だった場合は評価する

			// 各配列でさらに自動改行が必要なら分割する
			for(var i=0; i<_txt.length; i++){
				var ch = _txt.charAt(i);
				if(indent && len == indentSize && ch == "　")continue;

				len += obj.font.getTextWidth(ch);
				if(len > relinePos){
					if(((lastch=='' || wwLeading.indexOf(lastch)==-1) && wwFollowing.indexOf(ch)==-1) ||
						(lastch!='' && wwFollowingWeak.indexOf(lastch)!=-1 && wwFollowingWeak.indexOf(ch)!=-1) || len > limitPos){
						// 最後に描画したのが行末禁則文字でなく、これから描画するのが行頭禁則文字でない場合
						// または弱禁則文字が連続していない場合
						// はたまたこれから描画するのが強禁則文字ではなくて、確実に右端を越える場合(余白は考えない)
						ar[++lineCount] += ch;
						len = 0;
						if(indent)len += indentSize;
					}else ar[lineCount] += ch;
				}else ar[lineCount] += ch;
				lastch = ch;
			}
			++lineCount;
			len = 0;
			if(indent)len += indentSize;
		}

		// 最終描画
		for(var i=0; i<ar.count; i++){
			var indentPos = 0;
			var topCh     = ar[i].charAt(0);
			var _txt      = ar[i];

			// お気に入り一覧はインデントしない
			//if(indent && !(_txt.charAt(0)=="「" || _txt.charAt(0)=="『"))indentPos = indentSize;

			// ＠→ハート文字への置換コード
			// 対象の文字列で分割して、分割された配列の間(配列の最後以外)にハート等付けていく。
			if( sysHeartMark && ( /~[0-9]＠/g.test(_txt) )){
				var temp = new global.Layer(window, this);
				temp.loadImages("ch_heart0_20");
				temp.face = dfMain;
				temp.holdAlpha = true;
				temp.fillRect(0,0,temp.imageWidth,temp.imageHeight, (hactEnable ? owner.historyLinkColor : owner.historyColor));	// 文字色に合わせて塗りつぶし
				var txtar = _txt.split(/~[0-9]＠/g,,false);
				var x = marginL+indentPos;

				for(var j=0; j<txtar.count; j++){
					var part = txtar[j];
					if(part != ""){
						obj.drawText(x,(obj.height>>1)-(fh/2)-((ar.count-1)*((fh+lineSpacing)\2))+((fh+lineSpacing)*i),part,(hactEnable ? owner.historyLinkColor : owner.historyColor),255,true);
						if(j < txtar.count-1){
							for(var k=0; k<part.length; k++)x += obj.font.getTextWidth(part.charAt(k));
							obj.operateRect(x, (obj.height>>1)-(fh/2)-((ar.count-1)*((fh+lineSpacing)\2))+((fh+lineSpacing)*i), temp, 0, 0, temp.imageWidth, temp.imageHeight);
							x += temp.imageWidth;
						}
					}
				}
				invalidate temp;
			}else{
				obj.drawText(marginL+indentPos,(obj.height>>1)-(fh/2)-((ar.count-1)*((fh+lineSpacing)\2))+((fh+lineSpacing)*i),_txt,(hactEnable ? owner.historyLinkColor : owner.historyColor),255,true);
			}
		}

	}
	function org_setImageSize(w, h){ super.setImageSize(w, h); }
	function setImageSize(w, h)
	{
		imageWidth = w;
		virtualHeight = h;
	}
	property parent{
		setter(par){
			super.parent = par;
			super.setImageSize(par.imageWidth, par.imageHeight);
			super.setSizeToImageSize();
		}
		getter{
			return super.parent;
		}
	}
	property top{
		setter(x){
			virtualTop = (int)x;
			itemCheck();
		}
		getter{
			return virtualTop;
		}
	}
	property height{
		setter(h){
			virtualHeight = h;
		}
		getter{
			return virtualHeight;
		}
	}
}

class FavLayer
{
	var bg, clip, scroll;
	var prev;
	var next;
	var exit;
	var marginT = 107;
	var marginB = 106;
	var marginL = 247;
	var dat = [];
	var voiceHact = %[];
	var voice2Hact = %[];
	var showing = false;

	var blockWidth   = 750;	// 履歴一つ分の幅
	var blockHeight  = 100;	// 履歴一つ分の高さ
	var blockSpacing = 10;	// 履歴同士の間隔
	
	var historyColor = 0xffffff;	// テキストの文字色の設定
	var historyLinkColor = 0xffffff;	// リンク文字の色設定
	var maxLines = 1000; // 最大保持行数
	var currentLine = 0;	// 表示開始index

	// 各種座標
	var _homeBtX = 1198;	// 最初に戻るx
	var _homeBtY = 212;		// 最初に戻るy
	var _backLineBtX = 1014;		// 一行戻るボタンx座標
	var _backLineBtY = 110;		// 一行戻るボタンy座標
	var _nextLineBtX = 1014;		// 一行進むボタンx座標
	var _nextLineBtY = 585;		// 一行進むボタンy座標
	var _endBtX = 1198;		// 最後に進むx
	var _endBtY = 455;		// 最後に進むy
	var _hideBtX = 1036;			// 閉じるボタンx座標
	var _hideBtY = 84;			// 閉じるボタンy座標

	// ファイルネーム
	var _homeButtonName = "";		// 最初に戻るボタン（空白で作成しない）
	var _backButtonName = "";		// 一行戻るボタン（空白で作成しない）
	var _nextButtonName = "";	// 一行進むボタン（空白で作成しない）
	var _endButtonName = "";	// 最後に進むボタン（空白で作成しない）
	var _hideButtonName = "favoritevoice_hide";		// 閉じるボタン

	var _scrollX = 1022;	// スクロールバーのx座標
	var _scrollY = 138;	// スクロールバーのy座標
	var _scrollH = 444;	// スクロールバーの高さ

	var window;

	// 互換性維持用のメンバ
	var fontHeight = 24;	// フォントのサイズ
	var lineHeight = fontHeight + 2;	// ラインの高さ
	var marginR;
	var _tabIsButton;
	// 通常テキストの影設定
	var _tShadowLevel = 0;
	var _tShadowColor = 0x000000;
	var _tShadowSize = 1;
	var _tShadowXPos = 0;
	var _tShadowYPos = 0;
	// リンクの文字の影設定
	var _lShadowLevel = 128;
	var _lShadowColor = 0x000000;
	var _lShadowSize = 1;
	var _lShadowXPos = 2;
	var _lShadowYPos = 2;
	// レンダリング済フォント設定(空白で何もしない)
	var mapFont = "vlg24.tft";
	// 履歴を保存するか？
	var storeState = false;

	function FavLayer(win, par)
	{
		window = win;

		with(bg = new fadeLayer(win, par)){
			.loadImages("favoritevoice_bg");
			.setSizeToImageSize();
			//.absolute = 10;
			.fadeTotalTime = 100;
			.hitType = htMask;
			.hitThreshold = 256;
			.noSetMode = true;
			.focusable = true;
			.owner = this;
			.onMouseDown = function(x, y, button, shift){
				if(button == mbRight)owner.visible = false;
			}incontextof bg;
		}
		with(clip = new FavSmartScrollLayer(win, bg)){
			.owner = this;
			.type = ltAlpha;
			.face = dfAlpha;
			.setImageSize(blockWidth, win.scHeight-marginT-marginB);
			.setSizeToImageSize();
			.font.height = 20;
			if(Storages.isExistentStorage("vlg20.tft")){
				.font.face = "VLG20";
				.font.mapPrerenderedFont("vlg20.tft");
			}
			.visible = true;
		}
		with(scroll = new ScrollBarLayerFree(win, bg, %[top:"log_top",center:"log_center",under:"log_under"])){
			.setClipPos(marginL, marginT);
			var cliph = win.scHeight-marginT-marginB;
			if(cliph < 0)cliph = 10;
			.setClipSize(blockWidth, cliph);
			.setPos(_scrollX, _scrollY);
			.height = _scrollH;
			.setTarget(clip);
			.initScrollBar();
			.visible = true;
		}
		if(_backButtonName != "")buttonSet("prev", _backButtonName, _backLineBtX, _backLineBtY, "prevFunc", "一行前に戻ります");
		if(_nextButtonName != "")buttonSet("next", _nextButtonName, _nextLineBtX, _nextLineBtY, "nextFunc", "次の行を表示します");
		buttonSet("exit", _hideButtonName, _hideBtX, _hideBtY, "exitFunc", "お気に入りボイス画面を閉じる");
	}
	function buttonSet(name, storage, x, y, func, hint){
		with((name + " = new FunctionButtonLayerEx(window, bg, " + func + ");")!){
			.loadImages(storage);
			.setPos(x, y);
			.visible = true;
			.hint    = hint;
		}
	}

	//function prevFunc(){scroll.prev();}
	//function nextFunc(){scroll.next();}
	function prevFunc(){scroll.shift2(50);}
	function nextFunc(){scroll.shift2(-50);}
	function exitFunc(){visible = false;}

	function finalize()
	{
		invalidate exit;
		invalidate next;
		invalidate prev;
		invalidate clip;
		invalidate scroll;
		invalidate bg;
	}

	// 子から呼ばれる関数
	function slide(y)
	{
		scroll.shift2(y);
	}

	// ログの生成
	function createLog()
	{
		clip.clearItem();

		// dat = backLogJumpObject.getLog();
		dat = sf.favoriteVoiceList;

		if(dat === void)return;

		var bottom = 0;		// 必要な高さの計算
		for(var i=0; i<dat.count; i++){
			var tar        = dat[i];
			var top        = bottom;
			var text       = tar[0];
			//var storage    = tar[1];
			//var label      = tar[2];
			//var tjs1       = voiceHact[storage] !== void ? voiceHact[storage][label] : void;
			//var tjs2       = voice2Hact[storage] !== void ? voice2Hact[storage][label] : void;
			var tjs1 = "playVoiceMacro(%[s:\'" + tar[1] + "\']);";
			var tjs2 = "";
			var lines      = text.split("\n",,true);
			var _relinePos = blockWidth - clip.marginL - clip.marginR;
			var needLines  = 0;
			var _textHeight;

			for(var j=0; j<lines.count; j++){
				var tw = 0;
				for(var k=0; k<lines[j].length; k++)tw += clip.font.getTextWidth(lines[j][k]);
				needLines += Math.ceil(tw/_relinePos);
			}
			_textHeight = (clip.font.height+clip.lineSpacing) * needLines + lineHeight;//2018年5月11日
			if(_textHeight <= 0)_textHeight = 1;
			bottom += (_textHeight+blockSpacing);
			//clip.addItem(top, bottom, tar[0], tar[1], tar[2], _textHeight);
			var addObj = clip.addItem(top, bottom, tar[0], tjs1, tjs2, _textHeight, i);
		}
		clip.height = bottom;
		clip.fillRect(0,0,clip.imageWidth, clip.imageHeight, 0x0);
		scroll.initScrollBar();
	}

	function reCreate()
	{
		var tmp = clip.top;
		createLog();
		clip.top = tmp;
	}

	function setMax()
	{
		scroll.max();
	}

	// show, hideはvisibleプロパティから呼ぶ前提で直接使わない。
	function show()
	{
		createLog();
		scroll.max();
		if(!showing){
			bg.parent = kag.primaryLayer;
			bg.setPos(0, 0);
			//bg.absolute = 1000000-1;
			//bg.absolute = 10;
			bg.absolute = 50;
			bg.show();
			bg.hitThreshold = 0;
			clip.hitThreshold = 0;
			showing = true;
			if(window !== void){
				window.keyDownHook.unshift(favKeyDownFunc);
			}
			bg.focus();
		}
	}

	function hide()
	{
		if(showing){
			clip.clearItem();
			bg.hide();
			showing = false;
			if(window !== void){
				window.keyDownHook.remove(favKeyDownFunc);
				//window.hideHistory();
			}
		}
	}

	// リングバッファを考慮して実際の配列indexを返す関数
	function getIndex(i){
		var result;
		if(dat.count < maxLines)result = i;
		else{
			result = (currentLine+1+i)%maxLines;
		}
		return result;
	}

	// オリジナルのHistoryLayer互換関数-----------------------------------------------
	var everypage = 0;
	var parent;
	function store(ch){}
	function store2(ch){store(ch);}
	function reline(){}
	function save(){ return onStore(); }
	function load(dic){ onRestore(dic); }
	function repage(){ reline();}
	function dispInit(){ visible = true; }
	function dispUninit(){ visible = false; }
	function setOptions(elm){}

	var lastWheelTick;
	function windowMouseWheel(shift, delta, x, y){
		var currenttick = System.getTickCount();
		if(delta < 0  && currenttick - lastWheelTick > 300 && scroll.ty == (scroll.height-scroll.th)){
			hide();
		}else{
			if(dat !== void && dat.count > 0)scroll.shift2( delta * 0.2 );
		}
		lastWheelTick = currenttick;
		return true;
	}

	function beginIndent(){}
	function endIndent(){}
	function setNewAction(act){
		var curFile = kag.mainConductor.curStorage;
		var curLabel = kag.mainConductor.curLabel;
		if(voiceHact[curFile] === void)voiceHact[curFile] = %[];
		voiceHact[curFile][curLabel] = act;
	}
	function setNewAction2(act){
		var curFile = kag.mainConductor.curStorage;
		var curLabel = kag.mainConductor.curLabel;
		if(voice2Hact[curFile] === void)voice2Hact[curFile] = %[];
		voice2Hact[curFile][curLabel] = act;
	}
	function clearAction(){
	}
	function onStore(){
		var dic = %[];
		dic.voiceHact = %[];
		dic.voice2Hact = %[];
		(Dictionary.assignStruct incontextof dic.voiceHact)(voiceHact);
		(Dictionary.assignStruct incontextof dic.voice2Hact)(voice2Hact);
		return dic;
	}
	function onRestore(dic){
		logClear();
		if(dic !== void){
			if(dic.voiceHact !== void){
				(Dictionary.assignStruct incontextof voiceHact)(dic.voiceHact);
			}
			if(dic.voice2Hact !== void)(Dictionary.assignStruct incontextof voice2Hact)(dic.voice2Hact);
		}
		visible = false;
	}

	function logClear()
	{
		(Dictionary.clear incontextof voiceHact)();
		(Dictionary.clear incontextof voice2Hact)();
	}

	// メッセージウィンドウを自動で隠す処理
	property visible{
		setter(x){
			if(x){
				//kag.hideMessageLayerByUser();
				show();
			}else{
				//kag.showMessageLayerByUser();
				hide();
			}
		}
		getter{
			return showing;
		}
	}
}

// ログ画面でのキーフック
function favKeyDownFunc(key, shift){
	var obj = kag.favLayer.scroll;
	switch(key){
		case VK_PRIOR:	obj.shift2(600); break;	// PAGEUP
		case VK_NEXT:	obj.shift2(-600); break;	// PAGEDOWN
		case VK_HOME:	obj.min(); break;	// HOME
		case VK_END:	obj.max(); break;	// END
		case VK_UP:		obj.shift2(100); break;// ↑
		case VK_DOWN:	obj.shift2(-100); break;// ↓
		default:break;
	}
	return true;
}

@endscript
@return
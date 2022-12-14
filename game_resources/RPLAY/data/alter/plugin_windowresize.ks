
;※ウィンドウリサイズ用プラグイン、要override.tjsでの改造

@if exp="typeof(global.alphamovie_object) == 'undefined'"
@iscript

class WindowResizeInfoLayer extends Layer{
	var timer;
	var showStartTick = 0;
	var showingTime = 4000;
	var fadeInterval = 20;
	var pbts = [];
	var sbts = [];
	var textLayer;
	var tempLayer;
	var pluginObj;
	var aspectCheck;
	var fixCheck;
	var hideButton;
	var timeGaugeBase;
	var timeGauge;

	function WindowResizeInfoLayer(win, par, pobj){
		pluginObj = pobj;
		super.Layer(...);
		timer = new Timer(onTimer, "");
		timer.interval = fadeInterval;
		font.height = 22;
		font.face = "wril_vlg22";
		font.mapPrerenderedFont("vlg22.tft");
		hitType = htMask;
		hitThreshold = 0;
		absolute = 100;

		tempLayer = new global.Layer(window, this);
		textLayer = new global.Layer(window, this);

		loadImages("wr_bg");
		setSizeToImageSize();
		var w = (typeof window.scWidth == "undefined") ? 1280 : window.scWidth;		// windowオブジェクトがscWidth持ってる前提の動作
		setPos(w-imageWidth, 0);

		textLayer.setImageSize(imageWidth, imageHeight);
		textLayer.setSizeToImageSize();
		textLayer.type = ltAlpha;
		textLayer.face = dfAlpha;
		textLayer.fillRect(0, 0, imageWidth, imageHeight, 0x0);
		textLayer.visible = true;

		var lines = ["┌","↑", "┐", "←", "┼", "→", "└", "↓", "┘"];
		for(var i=0; i<9; i++){
			var index = pbts.add(new TextButton(window, this));
			with(pbts[index]){
				._width = 30;
				.text = lines[i];
				.setPos(0 + 35*(i%3), height-150 + 35*(i\3));
				.owner = this;
				.pressTjs = "owner.posAdjust("+i+");";
				.disableSystemSound();
				.visible = false;
			}
		}
		// サイズ変更ボタン
		for(var i=0; i<7; i++){
			var size = 70+(10*i);
			var index = sbts.add(new FourButton(window, this));
			with(sbts[index]){
				.loadImages("wr_btn_"+(size));
				.setPos(97, 263+(45*i));
				.owner = this;
				.pressTjs = "owner.sizeAdjust("+size+");";
				.disableSystemSound();
				.size = size;
				.visible = true;
			}
		}
		// チェックボックス
		aspectCheck = new CheckBox_4img(window, this, %[storage:"wr_checkbox"]);
		aspectCheck.setPos(91, 589);
		aspectCheck.mBttMouseOrder.offBttIn = 1;
		fixCheck = new CheckBox_4img(window, this, %[storage:"wr_checkbox"]);
		fixCheck.setPos(91, 632);
		fixCheck.mBttMouseOrder.offBttIn = 1;
		aspectCheck.check = sf.winResizeAspect;
		fixCheck.check = sf.winResizeFix;

		// 残り時間ゲージ
		timeGaugeBase = new global.Layer(window, this);
		timeGaugeBase.loadImages("wr_time_base");
		timeGaugeBase.setSizeToImageSize();
		timeGaugeBase.setPos(99, 687);
		timeGaugeBase.visible = false;
		timeGauge = new global.Layer(window, timeGaugeBase);
		timeGauge.loadImages("wr_time_gauge");
		timeGauge.setSizeToImageSize();
		timeGauge.setPos(2, 2);
		timeGauge.visible = true;

		// 非表示ボタン
		hideButton = new ThreeButtonLayer(window, this, %[storage:"wr_close"]);
		hideButton.setPos(256, 54);
		hideButton.owner = this;
		hideButton.pressTjs = "owner.hide();";
		hideButton.visible = true;
	}
	function finalize(){
		invalidate timeGauge;
		invalidate timeGaugeBase;
		invalidate hideButton;
		timer.enabled = false;
		invalidate aspectCheck;
		invalidate fixCheck;
		invalidate timer;
		invalidate tempLayer;
		invalidate textLayer;
		for(var i=0; i<pbts.count; i++)invalidate pbts[i];
		pbts.clear();
		for(var i=0; i<sbts.count; i++)invalidate sbts[i];
		sbts.clear();
		super.finalize(...);
	}
	// サイズ調整+ボタンフォーカス調整
	function sizeAdjust(per){
		var w = (typeof window.scWidth == "undefined") ? 1280 : window.scWidth;		// windowオブジェクトがscWidth持ってる前提の動作
		var h = (typeof window.scHeight == "undefined") ? 720 : window.scHeight;
		w = Math.ceil(w*(per/100));
		h = Math.ceil(h*(per/100));
		window.setInnerSize(w, h);
		kag.sflags.storeWindowWidth = window.width;
		kag.sflags.storeWindowHeight = window.height;
	}
	// 位置調整
	function posAdjust(no){
		var dic = 	System.getMonitorInfo(true, window);
		if(dic !== void){
			var x = dic.work.x;
			var y = dic.work.y;
			var w = dic.work.w;
			var h = dic.work.h;
			switch(no%3){
				case 0:window.left = x; break;
				case 1:window.left = x + (w-window.width)\2; break;
				case 2:window.left = x + w-window.width; break;
			}
			switch(no\3){
				case 0:window.top = y; break;
				case 1:window.top = y + (h-window.height)\2; break;
				case 2:window.top = y + h-window.height; break;
			}
		}
		show();		// 位置替え後は表示時間リセット
	}
	// 数値描画、本体に入れてるがプラグインの独立性を保つためにここにも置いている
	// function (描画対象, 描画したい数値, X, Y, 数値画像名or数値画像オブジェクト, 画像分割数, 文字揃え(0=左,1=真ん中,2=右))
	function numDraw(str, x, y, img, splitCount=10, align=0){
		if(str == "" || str === void)return;
		tempLayer.loadImages(img);
		var w = tempLayer.imageWidth\splitCount;
		var h = tempLayer.imageHeight;
		str = (string)str;
		var len = str.length*w;
		var start = 0;
		switch(align){
			case 0:start = x; break;
			case 1:start = x-(len>>1); break;
			case 2:start = x-len; break;
			default:start = x; break;
		}
		for(var i=0; i<str.length; i++){
			var num = str.charAt(i);
			switch(num){
				case ".": num = 10; break;
				case "/": num = 10; break;
				case ":": num = 11; break;
				case "-": num = 12; break;
				default : num = (int)num; break;
			}
			textLayer.operateRect(start+(i*w), y, tempLayer, w*num, 0, w, h, omAlpha, 255);
		}
	}
	function imgRect(x, y, img){
		tempLayer.loadImages(img);
		textLayer.operateRect(x, y, tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, omAlpha, 255);
	}
	function show(){
		if(window.fullScreen || window.maximized)return;
		// 描画
		//setImageSize(window.primaryLayer.imageWidth, window.primaryLayer.imageHeight);
		//setSizeToImageSize(); 
		//fillRect(0, 0, width, height, 0xcc000000);
		textLayer.fillRect(0, 0, imageWidth, imageHeight, 0x0);

		// ゲーム画面サイズ
		numDraw(Math.round(window.scWidth * (window.zoomNumer/window.zoomDenom)),  149+12, 142, "wr_gamesize_num.png", 10, 2);
		imgRect(167, 146, "wr_gamesize_cross.png");
		numDraw(Math.round(window.scHeight * (window.zoomNumer/window.zoomDenom)), 183, 142, "wr_gamesize_num.png", 10, 0);

		// ゲーム画面サイズ％
		numDraw(Math.round(window.zoomNumer/window.zoomDenom*100),  277+8, 145, "wr_per.png", 10, 2);

		// ウィンドウサイズ
		numDraw(window.width,  237+8, 189, "wr_winsize_num.png", 10, 2);
		imgRect(249, 190, "wr_winsize_cross.png");
		numDraw(window.height, 260, 189, "wr_winsize_num.png", 10, 0);

		//drawText(250, 360, "※Shiftキーを押しながらドラッグするとウィンドウとゲーム画面のサイズを一致させます", 0xffffff, 255, true);

		opacity = 255;
		visible = true;
		showStartTick = System.getTickCount();
		timer.enabled = true;
	}
	function reShow(){
		showStartTick = System.getTickCount();
		opacity = 255;
	}
	function hide(){
		timer.enabled = false;
		visible = false;
		opacity = 255;
	}
	function onTimer(){
		if(window.fullScreen){
			hide();
			return;
		}

		// サイズボタンフォーカス処理
		for(var i=0; i<sbts.count; i++){
			var obj = sbts[i];
			var w = Math.ceil(window.scWidth * (obj.size/100));
			var h = Math.ceil(window.scHeight * (obj.size/100));
			if(w == window.innerWidth && h == window.innerHeight)obj.isFocus = true;
			else obj.isFocus = false;
		}

		var curx = this.cursorX;
		var cury = this.cursorY;
		if(curx >= 0 && curx <= width && cury >= 0 && cury <= height){
			showStartTick = System.getTickCount();
			if(opacity < 255)opacity = 255;
		}
		var tick = System.getTickCount();
		if((tick - showStartTick) >= showingTime){
			var o = opacity - 10;
			if(o <= 0){
				hide();
			}else opacity = o;
		}
		// 残り時間表示
		var time = (showingTime - (tick - showStartTick));
		if(time <= 0)time = 0;
		// var w = 30;
		// textLayer.font.height = 14;
		// textLayer.fillRect(textLayer.width-w, textLayer.height-textLayer.font.height, w, textLayer.font.height, 0x0);
		// else time /= 1000;
		// textLayer.drawText(textLayer.width-w, textLayer.height-textLayer.font.height,  "%2.1f".sprintf(time) + "s", 0xffffff, 255, false);

		// 残りゲージ
		if(time <= 3000 && time > 0){
			timeGaugeBase.visible = true;
			timeGauge.width = timeGauge.imageWidth * (time/3000);
		}else timeGaugeBase.visible = false;

	}
//	function onMouseMove(x, y, shift){
//		reShow();
//	}
}

class WindowResizePlugin extends KAGPlugin
{
	var window;
	var windowDefSize = %[];
	
	var minWidth = 896;
	var minHeight = 504;

	var infoLay;
	var firstTime;		// 最初のウィンドウリサイズ避け

	function WindowResizePlugin(win){
		super.KAGPlugin(...);
		window = win;

		//window.borderStyle = bsSizeable;		// MainWindow.tjsじゃないと無理っぽい
		window.onResizing = onResizing;
		window.onResize = onResize;
		window.registerExEvent();

		// 初期サイズを覚える
		windowDefSize = %[
			//inw : window.innerWidth,
			//inh : window.innerHeight,
			inw : window.scWidth,
			inh : window.scHeight,
			// global.borderWidthはoverride.tjsのcreatePadKeyMapでウィンドウ生成直後に調べてる
			sysWidth  : (typeof global.borderWidth == "undefined") ? (window.width - window.innerWidth) : global.borderWidth,
			sysHeight : (typeof global.borderHeight == "undefined") ? (window.height - window.innerHeight) : global.borderHeight
		];

		// 情報レイヤー
		infoLay = new WindowResizeInfoLayer(win, win.primaryLayer, this);
	}

	function finalize(){
		invalidate infoLay;
		super.finalize(...);
	}

	// rect.typeの値
	// 4 3 5
	// 1   2
	// 7 6 8
	// 16:9計算
	// 1920 * (9/16) = 1080;
	// 1080 * (16/9) = 1920;
	
	function onResizing(rect){
		if(infoLay.fixCheck.check){
			with(rect){
				if(firstTime)infoLay.show();		// 表示更新
				var w = window.width;
				var h = window.height;
				var x = (.type   % 3 == 1) ? (.x+.w) - w : .x;
				var y = (.type\3 % 3 == 1) ? (.y+.h) - h : .y;
				if (.x == x && .y == y && .w == w && .h == h) return false;
				.x = x;
				.y = y;
				.w = w;
				.h = h;
				kag.sflags.storeWindowWidth = w;
				kag.sflags.storeWindowHeight = h;
			}
			return true;
		}

		// Shiftの場合比率固定
		if(System.getKeyState(VK_SHIFT) || infoLay.aspectCheck.check){
			var curPos = System.getCursorPos();
			var t = rect.type;
			var w = rect.w - windowDefSize.sysWidth;
			var h = rect.h - windowDefSize.sysHeight;
			var defw = windowDefSize.inw;
			var defh = windowDefSize.inh;
			var iswbase = w > (h * defw / defh);	// 横基準の方が大きくなるかどうか判定

			// それぞれ2行目は逆の計算を行って比率を極力合わせるため。1pxのずれはしょうがない
			if(t == 2 || t == 1 || (iswbase && (t == 4  || t == 5 || t == 7  || t == 8))){
				h = Math.round(w * defh / defw);
				w = Math.round(h * defw / defh);
			}else if(t == 6 || t == 8){		// (t == 8 && !iswbase)
				w = Math.round((curPos.y-rect.y-windowDefSize.sysHeight) * defw / defh);
				h = Math.round(w * defh / defw);
			}else{		// if(t == 3 || (!iswbase && (t == 4 || t == 5 || t == 7)))
				w = Math.round(h * defw / defh);
				h = Math.round(w * defh / defw);
			}
			rect.w = w + windowDefSize.sysWidth;
			rect.h = h + windowDefSize.sysHeight;

			// 座標調整
			if(t == 4 || t == 3 || t == 5)	rect.y = Math.round(window.top + window.height - rect.h);
			if(t == 4 || t == 1 || t == 7)	rect.x = Math.round(window.left + window.width - rect.w);

		}

		// 最低サイズ設定
		var w, h;
		if(rect.w < minWidth + windowDefSize.sysWidth)w = minWidth + windowDefSize.sysWidth;
		if(rect.h < minHeight + windowDefSize.sysHeight)h = minHeight + windowDefSize.sysHeight;

		with (rect) {
			w = .w if (w === void);
			h = .h if (h === void);
			var x = (.type   % 3 == 1) ? (.x+.w) - w : .x;
			var y = (.type\3 % 3 == 1) ? (.y+.h) - h : .y;
			//if (.x == x && .y == y && .w == w && .h == h) return false;
			.x = x;
			.y = y;
			.w = w;
			.h = h;
			kag.sflags.storeWindowWidth = w;
			kag.sflags.storeWindowHeight = h;
		}
		return true;
	}

	function onResize(){
		var inw = window.innerWidth;	// 今のウィンドウ幅
		var inh = window.innerHeight;
		var defw = window.scWidth;		// 初期ウィンドウ幅
		var defh = window.scHeight;
		var iswbase = inw < (inh * defw / defh);	// 狭いほう基準
		var adj_x = 0;
		var adj_y = 0;

		// フルスクリーンからの復帰時、ウィンドウの縁がないかも？
		if(!window.fullScreen){
			if(inw == window.width)inw -= windowDefSize.sysWidth;
			if(inh == window.height)inh -= windowDefSize.sysHeight;
		}

		if(iswbase){
			window.setZoom(inw, defw);
			adj_y = Math.round(((inh - (defh * inw / defw)) / 2) * (defw / inw));
			window.primaryLayer.setImageSize(Math.round(inw * defw / inw), Math.round(inh * defw / inw));
		}else{
			window.setZoom(inh, defh);
			adj_x = Math.round(((inw - (defw * inh / defh)) / 2) * (defh / inh));
			window.primaryLayer.setImageSize(Math.round(inw * defh / inh), Math.round(inh * defh / inh));
		}
		//dm("------------------------------------------------");
		//dm("fullscreen：" + window.fullScreen);
		//dm("border：" + window.borderStyle);
		//dm(window.innerWidth + " / " + window.width);
		//dm("★" + inw + "：" + inh + " / " + defw + "：" + defh + " / top：" + adj_y);
		//dm("------------------------------------------------");
		window.primaryLayer.setSizeToImageSize();
		window.primaryLayer.fillRect(0,0,window.primaryLayer.width, window.primaryLayer.height, 0x000000);
		global.winResizeOfsLeft = adj_x;
		global.winResizeOfsTop = adj_y;
		for(var i=0; i<window.primaryLayer.children.count; i++){
			//window.primaryLayer.children[i].setPos(adj_x, adj_y);
			//window.primaryLayer.children[i].enableWinResizeOfs = true;
			window.primaryLayer.children[i].winResizeReSetPos();
		}
		if(firstTime)infoLay.show();
		firstTime = true;
	}

	function onSaveSystemVariables(){
		sf.winResizeFix = infoLay.fixCheck.check;
		sf.winResizeAspect = infoLay.aspectCheck.check;
	}
	function onStore(f, elm){
	}
	function onRestore(f, clear, elm){
	}
}

kag.addPlugin(global.winresizeObject = new WindowResizePlugin(kag));

@endscript
@return

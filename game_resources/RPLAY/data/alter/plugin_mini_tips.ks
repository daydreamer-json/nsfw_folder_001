@if exp="typeof(global.mini_tips_object) == 'undefined'"
@iscript


class ScrollBarLayerForMiniTips extends Layer
{
	var ty=0;
	var th=107;
	var dragging=false;
	var mousedownpos;
	var owner;
	var diff;
	var tab;
	var scrollTimer;
	var drawState = 0;

	function ScrollBarLayerForMiniTips(window, parent)
	{
		super.Layer(window, parent);

		focusable = false;
		hitType = htMask;
		hitThreshold = 0;

		tab = new global.ButtonLayer(window, this);
		tab.loadImages("tips_tab");
		tab.visible=true;
		tab.org_onMouseMove = tab.onMouseMove;
		tab.onMouseMove = function(x, y, shift){
			parent.onMouseMove(x+left, y+top, shift);
		}incontextof tab;
		tab.org_onMouseDown = tab.onMouseDown;
		tab.onMouseDown = function(x, y, button, shift){
			parent.onMouseDown(x+left, y+top, button, shift);
		}incontextof tab;
		tab.org_onMouseUp = tab.onMouseUp;
		tab.onMouseUp = function(x, y, button, shift){
			parent.onMouseUp(x+left, y+top, button, shift);
		}incontextof tab;

		width=tab.width;
		height=251;
		setPos(573,0);
		visible=true;

		owner = parent;

		scrollTimer = new global.Timer(scrollPage,"");
		scrollTimer.interval=500;
		scrollTimer.enabled=false;

	}

	function draw()
	{
		var y = (int)ty;

		tab.setPos(0, y);
/*
		// ベース
		fillRect(0,0,width,height,0x00000000);
		// タブ中で埋め尽くす
		for(var i=y+tabt.height; i <= y+th-tabb.height; i+=tabc.height)
		copyRect(0, i, tabc, 0, 0, tabc.width, tabc.height);
		// タブ上をつける
		copyRect(0, y, tabt, 0, 0, tabt.width, tabt.height);
		// タブ下をつける
		copyRect(0, y+th-tabb.height, tabb, 0, 0, tabb.width, tabb.height);
*/
	}

	function initScrollBar()
	{
		th = 45;
		ty = height - th;
		draw(ty);
	}

	function finalize()
	{
		invalidate tab;
		invalidate scrollTimer;
		super.finalize(...);
	}

	function onMouseUp(x, y, button, shift)
	{
		scrollTimer.enabled=false;
		dragging=false;
		if(y<ty || y>(ty+th))drawState=0;
		else drawState=2;
		draw();
		super.onMouseUp(...);
	}

	function onMouseDown(x, y, button, shift)
	{
		if(y<ty){
			scrollTimer.interval=500;
			scrollTimer.enabled=true;
			owner.prevPage();
		}else if(y>(ty+th)){
			scrollTimer.interval=500;
			scrollTimer.enabled=true;
			owner.nextPage();
		}else{
			scrollTimer.enabled=false;
			dragging = true;
			mousedownpos = y;
			diff = y-ty;
			drawState = 1;
			draw();
		}
		super.onMouseDown(...);
	}

	function scrollPage(){
		if(scrollTimer.interval==500)scrollTimer.interval=100;
		var y=cursorY;
		if(y<ty){
			owner.prevPage();
		}else if(y>(ty+th)){
			owner.nextPage();
		}else{
			scrollTimer.enabled=false;
		}
	}

	function onMouseLeave(){
		scrollTimer.enabled=false;
		drawState=0;
		draw();
	}

	function onMouseMove(x, y, button, shift)
	{
		if(dragging){
			ty=y-diff;
			if(ty<0)ty=0;
			if(ty>height-th)ty=height-th;
			drawState=1;
			draw();
			parent.showByScrollBar(ty/(height-th));
		}else{
			if(y<ty || y>(ty+th))drawState=0;
			else drawState=2;
			draw();
		}
		super.onMouseMove(...);
	}
}


class ScrollLayerForMiniTips extends Layer
{
	var targetLayer;
	var scrollbar;

	var canScroll = false;	// スクロール可能かどうか

	function ScrollLayerForMiniTips(win, par, target)
	{
		super.Layer(...);
		// このレイヤー自身は表示範囲で画像を持つ必要がない
		hasImage = false;
		hitType = htMask;
		hitThreshold = 256;
		focusable = false;
		visible = true;

		// スクロール対象のレイヤー
		if(target===void)targetLayer = new MessageLayer(win, this, "minitips用レイヤー", 9997, true);
		else targetLayer = target;
		// 確定で自分の子レイヤーに
		targetLayer.parent = this;
		targetLayer.hitType = htMask;
		targetLayer.hitThreshold = 256;
		focusable = false;
		targetLayer.visible = true;

		scrollbar = new ScrollBarLayerForMiniTips(window, this);

	}

	function finalize()
	{
		invalidate targetLayer;
		invalidate scrollbar;
		super.finalize(...);
	}

	function onMouseWheel(shift, delta, x, y)
	{
		imageMove(delta);
	}

	function imageMove(delta){
		if(delta<0){	// 手前
			if(targetLayer.top+delta\5<-targetLayer.height+this.height)
				targetLayer.top = -targetLayer.height+this.height;
			else targetLayer.top+=delta\5;
			
		}else{	// 奥
			if(targetLayer.top+delta\5>0)targetLayer.top=0;
			else targetLayer.top += delta\5;
		}
		scrollbar.ty = (scrollbar.height-scrollbar.th)*(Math.abs(targetLayer.top)/(targetLayer.height-height));
		scrollbar.draw();
	}

	function prevPage(){if(canScroll)imageMove(460);}
	function nextPage(){if(canScroll)imageMove(-460);}
	function prevLine(){if(canScroll)imageMove(90);}
	function nextLine(){if(canScroll)imageMove(-90);}

	function showByScrollBar(per){
		targetLayer.top = -((targetLayer.height-height)*per);
	}

	// 表示画像を対象レイヤーに読み込み
	function load(str)
	{
		scrollbar.ty=0;
		scrollbar.draw();
		targetLayer.top=0;

		var txt = [].load("tips_txt_"+str+".txt");

		// 縦サイズのおおよその計算
		var _h = (17*txt.count) + 50;
		for(var i=0; i<txt.count; i++){
			_h += Math.ceil(txt.length / 35) * 17;
		}

		with(targetLayer){
			.setPosition(%[left:0, top:0, width:580, height:_h, opacity:0, frame:"", visible:true, marginl:0, margint:5, marginb:0, marginr:0] );
			.type = ltAlpha;
			.lineLayer.type = ltAlpha;
			.defaultFontSize = 14;
			.fontFace = .userFace = "ＭＳ ゴシック";
			.defaultBold = .bold = false;
			.resetFont();
			.resetStyle();

			for(var i=0; i<txt.count; i++){
				var str = txt[i];
				if(str != ""){
					if(str.charAt(0) == "/" && str.charAt(1) == "/")continue;// コメント行は無視
					// すべてクリアしていない場合はネタバレ部分はカット
					if((!sf.clearMiku || !sf.clearRisa || !sf.clearRyoko) && str.charAt(0) == "■")break;
					for(var j=0; j<str.length; j++){
						var t = (str.charAt(j)=="　") ? "  " : str.charAt(j);
						.processCh(t);
						if(j==0 && str.charAt(j) == "・").setIndent();
					}
				}
				.resetIndent();
				if(i != txt.count-1).reline();
			}
		}

		canScroll = (height < targetLayer.imageHeight);
		if(!canScroll)scrollbar.visible = false;
		else scrollbar.visible = true;
	}

	// スクロール対象レイヤーに画像を読み込み
	function rectImages(ar)
	{
		scrollbar.ty=0;
		scrollbar.draw();
		targetLayer.top=0;
		targetLayer.setImageSize(32,32);
		targetLayer.fillRect(0,0,32,32,0x0);
		var tempLayer = new global.Layer(window, this);
		var h = 0;
		for(var i=0; i<ar.count; i++){
			tempLayer.loadImages(ar[i]);
			h += tempLayer.imageHeight;
			targetLayer.setImageSize(800, h);
			targetLayer.copyRect(0,h-tempLayer.imageHeight,tempLayer,0,0,tempLayer.imageWidth,tempLayer.imageHeight);
		}
		targetLayer.setSizeToImageSize();
		invalidate tempLayer;
	}
}

class MiniTipsPlugin extends KAGPlugin
{
	var bgName = "tips_bg2";

	var window;
	var parent;

	var bgLayer;
	var backBtn;
	var upBtn;
	var downBtn;

	var imgLayer;

	var visible = false;

	function MiniTipsPlugin(win, par)
	{
		super.KAGPlugin(...);
		window = win;
		parent = par;
	}

	function finalize()
	{
		hideTips();
		super.finalize();
	}

	function showTips(str)
	{
		// 背景レイヤーの作成
		bgLayer = new fadeLayer(window, kag.fore.base);
		bgLayer.loadImages(bgName);
		bgLayer.setSizeToImageSize();
		bgLayer.setPos(0,0);
		bgLayer.hitType = htMask;
		bgLayer.hitThreshold=0;
		bgLayer.owner = this;
		bgLayer.focusable=true;
		bgLayer.visible = false;
		bgLayer.onMouseDown = function(x, y, button, shift){
//			if(button == mbRight){
				window.trigger('mini_tips_end');
				hide();
//			}else global.fadeLayer.onMouseDown(...);
		}incontextof bgLayer;
		bgLayer.onKeyDown = function(key, shift){
//			if(key == VK_ESCAPE){
				window.trigger('mini_tips_end');
				hide();
//			}else global.fadeLayer.onKeyDown(...);
		}incontextof bgLayer;

		imgLayer = new ScrollLayerForMiniTips(window, bgLayer);
		imgLayer.setSize(634,255);
		imgLayer.setPos(345,197);
		imgLayer.visible=true;
		//imgLayer.rectImages(global.TipsList[0]);
		imgLayer.load(str);
		// 表示した時点でウィンドウのメッセージ横取り体制
		if(typeof kag.org_tips_onMouseWheel == "undefined")kag.org_tips_onMouseWheel = kag.onMouseWheel;
		kag.onMouseWheel = imgLayer.onMouseWheel;

//		upBtn = new ThreeButtonLayer(window, bgLayer, %[func:imgLayer.prevLine]);
//		upBtn.loadImages("log_up");
//		upBtn.setPos(809,257);
//
//		downBtn = new ThreeButtonLayer(window, bgLayer, %[func:imgLayer.nextLine]);
//		downBtn.loadImages("log_down");
//		downBtn.setPos(809,443);

		// そのほかボタン
		//(バックボタン)
		backBtn = new ThreeButtonLayer(window, bgLayer, %[func:hide]);
		backBtn.setPos(897, 146);
		backBtn.loadImages("g_hide");
//		backBtn.hint="前の画面に戻ります";

		bgLayer.show();
		visible=true;
	}

	function hide()
	{
		window.trigger('mini_tips_end');
		bgLayer.hide();
	}

	function hideTips()
	{
		// 消える際に奪ったものを返す
		if(typeof kag.org_tips_onMouseWheel != "undefined")
			kag.onMouseWheel = kag.org_tips_onMouseWheel;

		invalidate bgLayer if bgLayer !== void;
		bgLayer = void;
		invalidate imgLayer if imgLayer !== void;
		imgLayer = void;
		invalidate backBtn if backBtn !== void;
		backBtn = void;
		visible=false;
//		invalidate upBtn if upBtn !== void;
//		upBtn = void;
//		invalidate downBtn if downBtn !== void;
//		downBtn = void;
	}

	function makeList(sender)
	{
		imgLayer.rectImages(global.TipsList[currentPage]);
	}

}

kag.addPlugin(global.mini_tips_object = new MiniTipsPlugin(kag, kag.fore.base));

@endscript
@endif

; ミニチップス
@macro name="tips"
@eval exp="mp.t = '行政庁長官'" cond="mp.t === void"
;@eval exp="sf.tipsFlagDic[mp.t]=true"
;@eval exp="sf[mp.t]=true"
@link exp="&'if(kag.inStable)kag.callExtraConductor(\'mini_tips_mode.ks\',\'*-tips\');tf.inChTerm=\''+mp.t+'\''" color=0xffffff
@font color=0xff9999
@endmacro

; ミニチップス終わり
@macro name="et"
@endlink
@resetfont
@endmacro

@return

*-tips
@locklink
@eval exp="mini_tips_object.showTips(tf.inChTerm)"
@waittrig name="configFadeEnd"
@waittrig name="mini_tips_end"
@waittrig name="configFadeEnd"
@eval exp="mini_tips_object.hideTips()"
@unlocklink
@return
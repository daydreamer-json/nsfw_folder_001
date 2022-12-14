@if exp="typeof(global.miniface_object) == 'undefined'"
@iscript

// 最近の表示方法と見た目を変えないために４枚つかったミニ表情プラグイン
// 重かったら却下……

class MiniFacePlugin extends KAGPlugin
{
	var win = void;			// 親ウィンドウ
	var fore1, fore2;
	var back1, back2;
	var fadeTimer = void;
	var mainVisibleState = false;
	var subVisibleState = false;
	var useFlag = true;

	var absoluteBase = 1000000 + 1000;	// messages[0].absolute + 2000;(画面下部のボタンは+2100)

	function MiniFacePlugin(window, fore, back)
	{
		fore1 = new KAGLayer(kag, kag.fore.base);
		fore2 = new KAGLayer(kag, kag.fore.base);
		back1 = new KAGLayer(kag, kag.back.base);
		back2 = new KAGLayer(kag, kag.back.base);
		// 当たり判定無しに
		fore1.hitType = fore2.hitType = back1.hitType = back2.hitType = htMask;
		fore1.hitThreshold = fore2.hitThreshold = back1.hitThreshold = back2.hitThreshold = 256;

		// レイヤーの順序を正規化
		fore1.absolute = fore2.absolute = back1.absolute = back2.absolute = absoluteBase;

		fadeTimer = new Timer(onTimer,"");
		fadeTimer.interval = 20;
		fadeTimer.enabled = false;

		super.KAGPlugin();
	}

	function finalize()
	{
		invalidate fore1 if fore1 != void;
		invalidate fore2 if fore2 != void;
		invalidate back1 if back1 != void;
		invalidate back2 if back2 != void;

		invalidate fadeTimer if fadeTimer != void;
		
		super.finalize(...);
	}

	function showMainFace(elm)
	{
		var file = elm.storage;
		// 顔取得なければreturn
		if(file===void || file=="" || !sysFaceVisible)return;

		var face, faceb;	// 現在捜査対象オブジェクトを入れる変数
		
		if(useFlag){
			face = fore1;
			faceb = back1;
			mainVisibleState = true;
		}else{
			face = fore2;
			faceb = back2;
			subVisibleState = true;
		}

//		var fname = "mf" + file.substr(2,4) + file.substr(7,file.length-2);
		// 仮立ち絵専用処理----------------------------------------
		var fname = file.substr(0,6) + "c" + file.substr(7);
		//---------------------------------------------------------

		face.visible = faceb.visible = false;
		face.loadImages(fname);
		face.setSizeToImageSize();
		faceb.assignImages(face);
		faceb.setSizeToImageSize();

//		face.setPos(0, kag.scHeight-face.imageHeight);
//		faceb.setPos(0, kag.scHeight-face.imageHeight);
		// 仮立ち絵専用処理----------------------------------------
		var tmpl = -50;
		var tmpt = kag.scHeight-200;
		var np = file.substr(2,2) + file.charAt(4);
		if(np == "01a")tmpl -= 20;
		if(np == "02a")tmpl += 50;
		if(np == "02b")tmpl -= 70;
		if(np == "03a")tmpl += 50;
		if(np == "03b")tmpl -= 10;
		if(np == "04a")tmpl += 30;
		if(np == "04b")tmpl += 30,tmpt += 20;
		if(np == "05a")tmpl -= 20;
		if(np == "05b")tmpl -= 120;
		if(np == "06a")tmpl -= 70;
		if(np == "06b")tmpl -= 110;
		if(np == "07a")tmpl -= 90;
		face.setPos(tmpl, tmpt);
		faceb.setPos(tmpl, tmpt);
		//---------------------------------------------------------
		face.opacity = faceb.opacity = 255;
		face.visible = faceb.visible = true;

		// 背景に補正がかかっているなら自動でかかるように調整してみる
		// ただし、任意で拒否された場合は行わない。
		if(kag.fore.layers[0].Anim_loadParams !== void){
			var t = kag.fore.layers[0].Anim_loadParams;
			if(((t["grayscale"]=="true" || t["sepia"]=="true") && (elm.grayscale!="false" && elm.sepia!="false")) ||
				(elm.sepia=="true" || elm.grayscale=="true")){
				face.doGrayScale();
				faceb.doGrayScale();
				try{
					face.anmLayer.doGrayScale();
					faceb.anmLayer.doGrayScale();
				}catch(e){
					dm(e.message);
				}
			}
			if((t["sepia"]=="true" && elm.sepia!="false") || (elm.sepia=="true")){
				face.adjustGamma(1.3,,,1.1,,,1.0);
				faceb.adjustGamma(1.3,,,1.1,,,1.0);
				try{
					face.anmLayer.adjustGamma(1.3,,,1.1,,,1.0);
					faceb.anmLayer.adjustGamma(1.3,,,1.1,,,1.0);
				}catch(e){
					dm(e.message);
				}
			}
		}
		//if(elm.grayscale!=void || elm.sepia=="true")face.doGrayScale();
		//if(elm.sepia == "true")face.adjustGamma(1.3,,,1.1,,,1.0);
	}

	function onTimer()
	{
		var mo, so;
		var def = 40;
		if(!mainVisibleState){
			mo = fore1.opacity - def;
			if(mo <= 0)mo = 0;
			fore1.opacity = back1.opacity = mo;
		}

		if(!subVisibleState){
			so = fore2.opacity - def;
			if(so <= 0)so = 0;
			fore2.opacity = back2.opacity = so;
		}

		if( (mainVisibleState || (!mainVisibleState && mo == 0)) &&
			(subVisibleState || (!subVisibleState && so == 0)) )
				fadeTimer.enabled=false;
	}

	function hideMainFace()
	{
		if(useFlag){
			mainVisibleState = false;
			fore1.absolute = back1.absolute = absoluteBase + 1;
			fore2.absolute = back2.absolute = absoluteBase;
		}else{
			subVisibleState = false;
			fore1.absolute = back1.absolute = absoluteBase;
			fore2.absolute = back2.absolute = absoluteBase + 1;
		}
		fadeTimer.enabled = true;
		useFlag = !useFlag;
	}

	// 以下、KAGPlugin のメソッドのオーバーライド
	function onRestore(f, clear, elm){hideMainFace();}
	function onStore(f, elm){}
	function onStableStateChanged(stable){}
	function onMessageHiddenStateChanged(hidden){
		if(fore1!==void){
			if(hidden){
				fore1.visible = back1.visible = false;
				fore2.visible = back2.visible = false;
			}else{
				fore1.visible = back1.visible = mainVisibleState;
				fore2.visible = back2.visible = subVisibleState;
			}
		}
	}
	function onCopyLayer(toback){}
	function onExchangeForeBack(){}
	function onSaveSystemVariables(){}
}
kag.addPlugin(global.miniface_object = new MiniFacePlugin(kag, kag.fore.base, kag.back.base));

@endscript
@endif

;*******************************************************************************
;　ミニ表情表示のマクロ
;*******************************************************************************
@macro name="show_miniface"
@eval exp="miniface_object.showMainFace(mp)"
@endmacro

@macro name="hide_miniface"
@eval exp="miniface_object.hideMainFace()"
@endmacro

@return


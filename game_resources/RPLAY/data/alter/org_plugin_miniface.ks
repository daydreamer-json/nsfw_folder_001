@if exp="typeof(global.miniface_object) == 'undefined'"
@iscript

var miniPosList = %[];

class MiniFacePlugin extends KAGPlugin
{
	var win       = void;		// 親ウィンドウ
	var useFlag   = true;		// 
	var useMFFlag = false;		// ミニフェイス用の画像を使用するかのフラグ（falseなら立ち絵cサイズを流用）

	var mainFace  = void;
	var subFace   = void;
	var fadeTimer = void;

	var mainVisibleState = false;
	var subVisibleState  = false;

	function MiniFacePlugin(window, fore, back)
	{
		mainFace = new CharacterLayer(kag, kag.primaryLayer2);
		subFace = new CharacterLayer(kag, kag.primaryLayer2);
		mainFace.hitType = htMask;
		mainFace.hitThreshold = 256;
		subFace.hitType = htMask;
		subFace.hitThreshold = 256;
		mainFace.eyeAnmCancel = true;
		subFace.eyeAnmCancel = true;

		// レイヤーの順序を正規化
		subFace.absolute = mainFace.absolute = 2;

		fadeTimer = new Timer(onTimer,"");
		fadeTimer.interval = 20;
		fadeTimer.enabled = false;

		super.KAGPlugin();
	}

	function finalize()
	{
		invalidate mainFace if mainFace != void;
		invalidate subFace if subFace != void;

		invalidate fadeTimer if fadeTimer != void;
		
		super.finalize(...);
	}

	function showMainFace(elm)
	{
		if(elm.storage !== void)elm.s = elm.storage;
		var file = elm.s;

		//dm("MiniFace:"+file);
		
		// 顔取得なければreturn
		if(file===void || file=="" || !sysFaceVisible || !f.permission_face)return;
		
//		useFlag = !useFlag;
		var face;
		if(useFlag){
			face = mainFace;
			mainVisibleState = true;
		}else{
			face = subFace;
			subVisibleState = true;
		}

		// 仮立ち絵専用処理----------------------------------------
		//var fname = file;
		var fname;

		if( useMFFlag ) fname = file;
		else            fname = "st" + file.substr(2,3) + "c" + file.substr( /^st/gi.test( file.substr(0,2) ) ? 6 : 5 );

		//---------------------------------------------------------
		//  きゃらぶれ：有珠の特殊処理 ポーズBの腕差分aをb差分に変更
		//-------------------------------------------------------------------------------------------------------------------------
		if(fname.substr(2,3) == "05b" && fname.substr(7,1) == "a") fname = "st05bc" + fname.substr(6,1) + "b" + fname.substr(8,2);
		//-------------------------------------------------------------------------------------------------------------------------


		face.loadImages(%[storage:fname, opacity:255, visible:false]);

		// 立ち絵座標設定----------------------------------------
//		var ar = getCharPosArray(fname);
		var ar = tf.charPosDic["mf"+file.substr(2,3)];
//		var tmpl = 100 + ar[0];
//		var tmpt = kag.scHeight-220;
//		var np = file.substr(2,2) + file.charAt(4);

		//face.setPos(0, kag.scHeight-face.imageHeight);
		face.setPos(ar[0], ar[1]);
		//---------------------------------------------------------


		// ユーザーによるメッセージ消去状態の時にここに来てしまった場合は表示を行わない。
		// VisibleStateによる表示状態の管理は行われているはずなので大丈夫……なはず
		if(!kag.messageLayerHiding)face.visible = true;
//		face.setPos(0, kag.scHeight-face.imageHeight);

		if(elm.grayscale !== void && elm.grayscale=="true"){
			face.doGrayScale();
			try{
				face.anmLayer.doGrayScale();
			}catch(e){
				dm(e.message);
			}
		}else if(elm.sepia !== void && elm.sepia == "true"){
			face.doGrayScale();
			face.adjustGamma(1.3,,,1.1,,,1.0);
			try{
				face.anmLayer.doGrayScale();
				face.anmLayer.adjustGamma(1.3,,,1.1,,,1.0);
			}catch(e){
				dm(e.message);
			}
		}else{

			// 背景に補正がかかっているなら自動でかかるように調整してみる
			// ただし、任意で拒否された場合は行わない。
			if(kag.fore.layers[0].Anim_loadParams !== void){
				var t = kag.fore.layers[0].Anim_loadParams;
				if(((t["grayscale"]=="true" || t["sepia"]=="true") && (elm.grayscale!="false" && elm.sepia!="false")) ||
					(elm.sepia=="true" || elm.grayscale=="true")){
					face.doGrayScale();
					//faceb.doGrayScale();
					try{
						face.anmLayer.doGrayScale();
					}catch(e){
						dm(e.message);
					}
				}
				if((t["sepia"]=="true" && elm.sepia!="false") || (elm.sepia=="true")){
					face.adjustGamma(1.3,,,1.1,,,1.0);
					//faceb.adjustGamma(1.3,,,1.1,,,1.0);
					try{
						face.anmLayer.adjustGamma(1.3,,,1.1,,,1.0);
					}catch(e){
						dm(e.message);
					}
				}
			}
		}
	}

	function onTimer()
	{
		var mo, so;
		var def = 40;
		if(!mainVisibleState){
			mo = mainFace.opacity - def;
			if(mo <= 0)mo = 0;
			mainFace.opacity = mo;
		}

		if(!subVisibleState){
			so = subFace.opacity - def;
			if(so <= 0)so = 0;
			subFace.opacity = so;
		}

		if( (mainVisibleState || (!mainVisibleState && mo == 0)) &&
			(subVisibleState || (!subVisibleState && so == 0)) )
				fadeTimer.enabled=false;
	}

	function hideMainFace()
	{
		//subFace.visible = mainFace.visible=false;
		if(useFlag){
			mainVisibleState = false;
			mainFace.absolute = 3;
			subFace.absolute = 2;
		}else{
			subVisibleState = false;
			mainFace.absolute = 2;
			subFace.absolute = 3;
		}
		fadeTimer.enabled = true;
		useFlag = !useFlag;
	}

	// 以下、KAGPlugin のメソッドのオーバーライド
	function onRestore(f, clear, elm)
	{
		if( f.miniFaceUseFlag )	showMainFace( %[storage:f.miniFaceFile] );
		else					hideMainFace();
	}

	function onStore(f, elm)
	{
		if( mainVisibleState || subVisibleState )
		{
			f.miniFaceUseFlag	= true;
			f.miniFaceFile		= ( mainVisibleState ? mainFace : subFace ).Anim_loadParams.storage;
		}
		else
		{
			f.miniFaceUseFlag	= false;
		}
	}


	function onStableStateChanged(stable){}
	function onMessageHiddenStateChanged(hidden){
		if(mainFace!==void){
			if(hidden){
				mainFace.visible=false;
				subFace.visible=false;
			}else{
				mainFace.visible = mainVisibleState;
				subFace.visible = subVisibleState;
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


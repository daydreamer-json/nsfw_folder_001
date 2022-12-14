@if exp="typeof(global.multiwindow_object) == 'undefined'"
@iscript

// 1行連続発言用クラス
class MultiWindowLayerMini extends Layer
{
	var frame;
	var msg;
	var timer;

	var stick;
	var fadeInTime = 250;
	var stayTime = 3000;
	var fadeOutTime = 250;

	function MultiWindowLayerMini(win, par, elm)
	{
		super.Layer(...);
		hitType = htMask;
		hitThreshold = 256;
		absolute = 2;
		opacity = 0;
		visible = true;

		frame = new global.Layer(win, this);
		frame.loadImages("g_frame_multi_01");
		frame.setSizeToImageSize();
		setSize(frame.width, frame.height);
		setSizeToImageSize();
		frame.opacity = sysMsgOpacity;
		frame.hitType = htMask;
		frame.hitThreshold = 256;
		frame.visible = true;
		frame.setPos(0, 0);

		msg = new MultiWindowMessageLayer(win, this, "マルチウィンドウ", 777, true);
		msg.type = msg.lineLayer.type = ltAlpha;
		msg.setPosition(%[frame:"", width:frame.width, height:frame.height, visible:true, opacity:0, marginl:10, margint:3, marginb:10]);
		//msg.setGlyph(%[fix:true, left:frame.width-35, top:frame.height-30]);
		msg.setPos(0, 0);
		msg.processCh(elm.t);

		if(elm.width !== void)width = +elm.width;

		// 座標決定・あとで変更
		setPos((kag.scWidth-width)*Math.random(), (kag.scHeight-200)*Math.random());

		stick = System.getTickCount();

		timer = new Timer(onTimer, "");
		timer.interval = 20;
		timer.enabled = true;
	}

	function finalize()
	{
		invalidate frame;
		invalidate msg;
		invalidate timer if timer !== void;
		super.finalize(...);
	}

	function onTimer()
	{
		var tick = System.getTickCount() - stick;
		if(tick < fadeInTime){
			opacity = (int)(255*tick/fadeInTime);
		}else if(tick < (fadeInTime+stayTime)){
			opacity = 255;
		}else if(tick < (fadeInTime+stayTime+fadeOutTime)){
			opacity = 255 - 255*(tick-(fadeInTime+stayTime))/fadeOutTime;
		}else{
			opacity = 0;
			timer.enabled = false;
		}
	}

	property width
	{
		setter(w){
			if(frame !== void){
				frame.copyRect(w-5,0,frame,frame.width-5,0,5,frame.height);
				frame.width = w;
			}
			if(msg !== void){
				//msg.setPosition(%[width:frame.width, height:frame.height]);
			}
		}
		getter{
			if(frame !== void)return frame.width;
			else return -1;
		}
	}
}

// PDA付きミニ表情
class MultiWindowMiniFaceWithPDA extends Layer
{
	var pdabg;
	var char;

	var _show = false;
	var inc = 80;
	var dec = 20;

	function MultiWindowMiniFaceWithPDA(win, par)
	{
		super.Layer(...);
		loadImages("g_multi_pda");
		setSizeToImageSize();
		opacity = 0;
		hitType = htMask;
		hitThreshold = 256;
		visible = true;

		pdabg = new global.Layer(win, this);
		pdabg.loadImages("g_multi_pda2");
		pdabg.setSizeToImageSize();
		pdabg.hitType = htMask;
		pdabg.hitThreshold = 256;
		pdabg.setPos(8, 26);
		pdabg.visible = true;

		char = new MultiWindowMiniFace(win, pdabg);
		char.opacity = 255;
	}

	function finalize()
	{
		invalidate pdabg;
		invalidate char;
		super.finalize(...);
	}

	function show(){_show = true;}
	function hide(){_show = false;}

	function changeView()
	{
		var re;
		if(_show){
			if(opacity+inc > 255){
				opacity = 255;
				re = true;
			}else{
				opacity += inc;
				re = false;
			}
		}else{
			if(opacity-dec < 0){
				opacity = 0;
				re = true;
			}else{
				opacity -= dec;
				re = false;
			}
		}
		return re;
	}
}

class MultiWindowMiniFace extends CharacterLayer
{
	var _show = false;
	var inc = 80;
	var dec = 20;

	function MultiWindowMiniFace(win, par)
	{
		super.CharacterLayer(...);
		opacity = 0;
		hitType = htMask;
		hitThreshold = 256;
		visible = true;
	}

	function finalize()
	{
		super.finalize(...);
	}

	function show(){_show = true;}
	function hide(){_show = false;}

	function changeView()
	{
		var re;
		if(_show){
			if(opacity+inc > 255){
				opacity = 255;
				re = true;
			}else{
				opacity += inc;
				re = false;
			}
		}else{
			if(opacity-dec < 0){
				opacity = 0;
				re = true;
			}else{
				opacity -= dec;
				re = false;
			}
		}
		return re;
	}
}

class MultiWindowMessageLayer extends MessageLayer
{
	function MultiWindowMessageLayer(owner, parent, name, id, do_config)
	{
		super.MessageLayer(...);
		// bmpフォント適用
		var fontSize = 24;
		for(var x=0; x<includeFontList.count; x++){
			setDefaultFont(%[face:includeFontList[x][0], size:fontSize, bold:false]);
			resetFont();
			decideSizeChange();
			lineLayer.font.mapPrerenderedFont(includeFontList[x][1]);
		}
		setDefaultFont(%[size:24]);
		resetFont();
		userFace = kag.chDefaultFace;
		setDefaultFont(%[face:"user"]);
		resetFont();
	}

	function finalize()
	{
		super.finalize(...);
	}

	function processCh(ch)
	{
		return super.processCh(ch);
	}

	function reline()
	{
		return super.reline();
	}
}

class MultiWindowLayer extends Layer
{
	var frame;
	var msg;
	var face;
	var face1;
	var face2;
	var timer;

	var withPDA = true;

	function MultiWindowLayer(win, par, elm)
	{
		super.Layer(...);

		//setSize(kag.scWidth, kag.scHeight);
		loadImages("g_multi_base");
		setSizeToImageSize();
		hitType = htMask;
		hitThreshold = 256;
		absolute = 2;
		opacity = 0;
		visible = true;

		frame = new global.Layer(win, this);
		frame.loadImages("g_frame_multi");
		frame.setSizeToImageSize();
		frame.opacity = sysMsgOpacity;
		frame.hitType = htMask;
		frame.hitThreshold = 256;
		frame.visible = true;
		frame.setPos(320, 310);

		msg = new MultiWindowMessageLayer(win, this, "マルチウィンドウ", 777, true);
		msg.type = msg.lineLayer.type = ltAlpha;
		msg.setPosition(%[frame:"", width:frame.width, height:frame.height, visible:true, opacity:0, marginl:200, margint:-2, marginb:10]);
		msg.setGlyph(%[fix:true, left:frame.width-35, top:frame.height-30]);
		msg.setPos(frame.left, frame.top);

		if(elm.pda != "false"){
			withPDA = true;
			face1 = new MultiWindowMiniFaceWithPDA(win, this);
			face2 = new MultiWindowMiniFaceWithPDA(win, this);
		}else{
			withPDA = false;
			face1 = new MultiWindowMiniFace(win, this);
			face2 = new MultiWindowMiniFace(win, this);
		}
		face = face1;
		face._show = true;
		face.opacity = 255;
		timer = new Timer(onTimer, "");
		timer.interval = 20;

		var file = elm.storage;
		if(file!==void && file!="" && sysFaceVisible)loadFace(file);
		else{
			face.visible = false;
			msg.setPosition(%[marginl:10]);
		}
	}

	function loadFace(file)
	{
		// 仮立ち絵専用処理----------------------------------------
		var fname = file.substr(0,5) + "c" + file.substr(6);
		//	立ち絵が「ソラリス」だったときの処理
		if(fname.substr( 2, 2 ) == 16)fname = file.substr(0,5) + "b" + file.substr(6);
		//---------------------------------------------------------
		if(withPDA)face.char.loadImages(%[storage:fname]);
		else face.loadImages(%[storage:fname]);
		// 立ち絵座標設定----------------------------------------
		var ar = getCharPosArray(fname);
		var tmpl = ar[0];
		var tmph = 220;
		var np = file.substr(2,2) + file.charAt(4);
		if( np == "01c" )	tmpl += 20;
		if( np == "02a" )	tmph += 10;
		if( np == "02b" )	tmph += 10;
		if( np == "02c" )	tmph -= 40;
		if( np == "03b" )	tmpl += 30;
		if( np == "04a" )	tmph -= 20;
		if( np == "04b" )	tmph -= 20;
		if( np == "04c" )	tmph -= 20;
		if( np == "07a" )	tmph -= 30;
		if( np == "07b" )	tmpl += 30;
		if( np == "08a" )	tmpl += 20;
		if( np == "09a" ){
			tmph -= 30;
			tmpl += 10;
		}
		if( np == "10a" )	tmph -= 20;
		if( np == "12a" )	tmpl -= 20;
		if( np == "15a" )	tmph -= 20;
		if( np == "16a" )	tmph += 30;
		//---------------------------------------------------------
		if(withPDA){
			face.char.top = face.pdabg.height - tmph;
			face.char.left = face.pdabg.width\2 + tmpl;
			face.setPos(frame.left+20, frame.top+frame.height\2-face.height\2);
		}else{
			face.imageHeight = face.height = tmph;
			face.top = (frame.top+frame.height) - tmph;
			face.left = (frame.left+100) + tmpl;
		}
	}

	function changeFace(storage)
	{
		face.hide();
		if(face == face1)face = face2;
		else face = face1;
		loadFace(storage);
		face.show();
		timer.enabled = true;
	}

	function finalize()
	{
		invalidate frame;
		invalidate msg;
		invalidate timer if timer !== void;
		invalidate face1 if face1 !== void;
		invalidate face2 if face2 !== void;
		super.finalize(...);
	}

	function onTimer()
	{
		var fin = true;
		if(!face1.changeView())fin = false;
		if(!face2.changeView())fin = false;
		if(fin)timer.enabled = false;
	}

	function setPos(x, y)
	{
		if(frame !== void)frame.setPos(x, y);
		if(msg !== void)msg.setPos(x, y);
	}

	property width
	{
		setter(w){
			if(frame !== void){
				frame.copyRect(w-5,0,frame,frame.width-5,0,5,frame.height);
				frame.width = w;
			}
			if(msg !== void){
				msg.setPosition(%[width:frame.width, height:frame.height]);
				msg.fillRect(0,0,msg.width,msg.height,0x0);
			}
		}
		getter{
			if(frame !== void)return frame.width;
			else return -1;
		}
	}
}

class MultiWindowPlugin extends KAGPlugin
{
	var winArray = [];
	var timer;

	var _show = false;
	var inc = 40;
	var dec = 40;

	function MultiWindowPlugin(window, fore, back, num)
	{
		super.KAGPlugin();
		timer = new Timer(onTimer, "");
		timer.interval = 20;
		timer.enabled = false;
	}

	function finalize()
	{
		clearMultiWindow();
		timer.enabled = false;
		invalidate timer;
		super.finalize(...);
	}

	function addMultiWindow(elm)
	{
		if(winArray.count != 0)return;
		var obj;
		winArray.add(obj = new MultiWindowLayer(kag, kag.primaryLayer, elm));
		kag.current = obj.msg;

		_show = true;
		timer.enabled = true;
	}

	function addMultiWindow2(elm)
	{
		var obj;
		winArray.add(obj = new MultiWindowLayerMini(kag, kag.primaryLayer, elm));
	}

	function clearMultiWindow()
	{
		for(var i=0; i<winArray.count; i++){
			invalidate winArray[i];
		}
		winArray.clear();
	}

	function hideMultiWindow(){ _show = false; timer.enabled = true;}

	function changeFace(storage)
	{
		if(winArray.count != 0)winArray[0].changeFace(storage);
	}

	function onTimer()
	{
		if(winArray.count == 0){
			timer.enabled = false;
			return;
		}
		var tar = winArray[0];
		if(_show){
			if(tar.opacity+inc > 255){
				tar.opacity = 255;
				timer.enabled = false;
				kag.trigger("multi_show");
			}else{
				tar.opacity += inc;
			}
		}else{
			if(tar.opacity-dec < 0){
				tar.opacity = 0;
				timer.enabled = false;
				kag.trigger("multi_hide");
			}else{
				tar.opacity -= dec;
			}
		}
	}

	// 以下、KAGPlugin のメソッドのオーバーライド
	function onRestore(f, clear, elm){
		clearMultiWindow();
	}
	function onStore(f, elm){}
	function onStableStateChanged(stable){}
	function onMessageHiddenStateChanged(hidden){
		if(winArray.count != 0)winArray[0].visible = !hidden;
	}
	function onCopyLayer(toback){
		if(kag.conductor.curStorage == "title.ks"){
			clearMultiWindow();
		}
	}
	function onExchangeForeBack(){}
	function onSaveSystemVariables(){}
}
kag.addPlugin(global.multiwindow_object = new MultiWindowPlugin());
@endscript
@endif

;*******************************************************************************
;　マルチウィンドウの初期化
;*******************************************************************************
@macro name="mlt_nm"
@if exp="multiwindow_object.winArray.count == 0"
@eval exp="multiwindow_object.addMultiWindow(mp)"
@waittrig name="multi_show" canskip=true onskip="multiwindow_object.winArray[0].opacity=255"
@else
@eval exp="multiwindow_object.changeFace(mp.storage)"
@endif
@eval exp="multiwindow_object.winArray[0].msg.clear();" cond="multiwindow_object.winArray.count != 0"
@eval exp="f.speaker=(mp.rt!=void)?(mp.rt):(mp.t)"
@eval exp="f.speaking = true"
@vo s=%s history=true
; BGMを下げる処理
@fadebgm volume="&(int)sysBgmDownVolume" time=300 cond="sysBgmTempFade && mp.s !== void && !kag.bgm.currentBuffer.inFadeAndStop"
@eval exp="tf.bgmTempFadeFlag=true"
@ch text=%t
; 次の書き出しは初めてのフリをしてオートインデントが効く様に偽装
@eval exp="multiwindow_object.winArray[0].msg.lastDrawnCh = ''"
@r
@endmacro

@macro name="mlt_mini"
@eval exp="multiwindow_object.addMultiWindow2(mp)"
@eval exp="kag.historyLayer.store(mp.t)"
@hr
@endmacro

@macro name="mlt_clr"
@eval exp="multiwindow_object.hideMultiWindow()"
@waittrig name="multi_hide" canskip=true
@eval exp="multiwindow_object.clearMultiWindow()"
@eval exp="setCurrentMessageLayer()"
@endmacro

@return

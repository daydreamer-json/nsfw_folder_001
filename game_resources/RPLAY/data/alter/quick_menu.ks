@if exp="typeof(global.quickmenu_object) == 'undefined'"
@iscript

class QucikMenuPlugin extends KAGPlugin
{

	var quickBgLayer;
	var quickRightLayer;
	var quickLeftLayer;
	var quickButtons = [];

	//var bgImg = "qm_bg_base";	// 背景画像（無ければ適当に生成）
	var bgImg = "";				// 背景画像（無ければ適当に生成）
	var bgColor = 0x55000000;	// 0xAARRGGBB
	var afterFunc;				// このレイヤーを閉じた際に実行する関数

	var cx = 0;
	var cy = 0;

	var time = 500;
	var sTick;
	var eTick;
	var accel = 2;

	var itemList = [
		["qm_exit", onExit],
		["qm_backtitle", onBackTitle],
		["qm_config", onConfig],
		["qm_save", onSave],
		["qm_load", onLoad]//,
//		["qm_skip", onSkip],
//		["qm_auto", onAuto]
	];

	var r = 360 / 5;
	function getx(rad, w){ return Math.cos(rad*(Math.PI/180)) * w; }
	function gety(rad, w){ return Math.sin(rad*(Math.PI/180)) * w; }

	var pos;

	function QucikMenuPlugin()
	{
		super.KAGPlugin(...);

		var sRange = 170;
		var dRange = 70;
		pos = [
			%[sx:getx(-70,sRange), sy:gety(-70,sRange), dx:getx(-90,dRange), dy:gety(-90,dRange)],
			%[sx:getx(-70+r*1,sRange), sy:gety(-70+r*1,sRange), dx:getx(-90+r*1,dRange), dy:gety(-90+r*1,dRange)],
			%[sx:getx(-70+r*2,sRange), sy:gety(-70+r*2,sRange), dx:getx(-90+r*2,dRange), dy:gety(-90+r*2,dRange)],
			%[sx:getx(-70+r*3,sRange), sy:gety(-70+r*3,sRange), dx:getx(-90+r*3,dRange), dy:gety(-90+r*3,dRange)],
			%[sx:getx(-70+r*4,sRange), sy:gety(-70+r*4,sRange), dx:getx(-90+r*4,dRange), dy:gety(-90+r*4,dRange)]//,
//			%[sx:getx(r*5,sRange), sy:gety(r*5,sRange), dx:getx(r*5,dRange), dy:gety(r*5,dRange)],
//			%[sx:getx(r*6,sRange), sy:gety(r*6,sRange), dx:getx(r*6,dRange), dy:gety(r*6,dRange)]
		];

		cx = kag.scWidth\2;
		cy = kag.scHeight\2;

		afterFunc = void;

		quickBgLayer = new Layer(kag, kag.primaryLayer);

		// 背景レイヤーを作成
		with(quickBgLayer){
			.hitType=htMask;
			.hitThreshold=0;
			.absolute=3000000;
			.org_onMouseDown = quickBgLayer.onMouseDown;
			.owner = this;
			.onMouseDown = function(x, y, button, shift){
				/*if(button == mbRight)*/owner.onReturn();
				org_onMouseDown(...);
			}incontextof quickBgLayer;
			.joinFocusChain = false;
		}
		clearImage(quickBgLayer);

		// ボタン郡作成
		for(var i=0; i<itemList.count; i++){
			var obj;
			quickButtons.add(obj = new ThreeButtonLayer(kag, quickBgLayer, %[]));
			clearImage(obj);
		}
	}

	function finalize()
	{
		super.finalize(...);
		for(var i=0; i<quickButtons.count; i++)invalidate quickButtons[i] if quickButtons[i] != void;
		invalidate quickBgLayer if quickBgLayer != void;
	}

	function show()
	{
		with(quickBgLayer){
			if(bgImg != "").loadImages(bgImg);
			else{
				.setImageSize(kag.scWidth, kag.scHeight);
				.type = ltAlpha;
				.face = dfAlpha;
				.fillRect(0,0,.imageWidth,.imageHeight, bgColor);
				.joinFocusChain = false;
			}
			.setSizeToImageSize();
			.opacity=0;
			.absolute=3000000;
			.visible=true;
		}

		for(var i=0; i<quickButtons.count; i++){
			var obj = quickButtons[i];
			obj.loadImages(itemList[i][0]);
			obj.clickFunction = itemList[i][1];
			obj.visible = true;
		}

		time = 150;

		sTick = System.getTickCount();
		eTick = sTick + time;
		System.addContinuousHandler(fadein);
	}

	function clearImage(obj)
	{
		// 表示を不可視(不可視にできれば)にし、レイヤをクリアする
		with(obj)
		{
			.visible = false;
			.setSize(32, 32);
			.setImageSize(32, 32);
			.face = dfAlpha;
			.fillRect(0, 0, 32, 32, 0);
			.type = ltAlpha;
			.face = dfAuto;
		}
	}

	function jump(storage = "", target){ kag.process(storage, target); }
	function startAuto(){ kag.enterAutoMode(); };
	function startSkip(){ kag.clickSkipEnabled=true; kag.skipToStop(); };

	function onReturn(){ jump(,"*quickMenuHide"); }
	function onExit(){ if(aynExitGame())kag.closeByScript(%[ask:false]); }
	function onBackTitle(){ if(aynBackTitle())jump(,"*back_title"); }
	function onHide(){ onReturn(); kag.switchMessageLayerHiddenByUser();}
	function onConfig(){ jump("","*goConfig"); }
	function onLoad(){ jump("","*goLoad"); }
	function onSave(){ jump("","*goSave"); }
	function onSkip(){ afterFunc = startSkip; }
	function onAuto(){ afterFunc = startAuto; }

	function fadein(tick)
	{
		if(eTick<tick)return inFinish();

		tick -= sTick;

		// 上弦 ( 最初が動きが早く、徐々に遅くなる )
		tick = 1.0 - tick / time;
		tick = Math.pow(tick, accel);
		tick = int ( (1.0 - tick) * time );

		var ratio = tick/time;

		// 背景は濃ゆくなるだけ
		quickBgLayer.opacity = (255*ratio);

		for(var i=0; i<quickButtons.count; i++){
			quickButtons[i].setPos(cx + pos[i].sx+(pos[i].dx - pos[i].sx)*ratio, cy + pos[i].sy+(pos[i].dy - pos[i].sy)*ratio);
		}
	}

	function inFinish()
	{
		System.removeContinuousHandler(fadein);
		// 背景
		quickBgLayer.opacity = 255;

		for(var i=0; i<quickButtons.count; i++){
			quickButtons[i].setPos(cx + pos[i].dx,  cy + pos[i].dy);
		}

		kag.trigger('quickMenuShow');
	}

	function hide()
	{
		sTick = System.getTickCount();
		eTick = sTick + time;
		System.addContinuousHandler(fadeout);
	}

	function fadeout(tick)
	{
		if(eTick<tick)return outFinish();

		tick -= sTick;

		// 下弦 ( 最初は動きが遅く、徐々に早くなる )
		tick = tick / time;
		tick = Math.pow(tick, accel);
		tick = int ( tick * time );

		var ratio = tick/time;

		// 背景は薄くなるだけ
		quickBgLayer.opacity = (255-(255*ratio));

		for(var i=0; i<quickButtons.count; i++){
			quickButtons[i].setPos(cx + pos[i].dx-(pos[i].dx - pos[i].sx)*ratio, cy + pos[i].dy-(pos[i].dy - pos[i].sy)*ratio);
		}
	}

	function outFinish()
	{
		System.removeContinuousHandler(fadeout);

		// クリア
		clearImage(quickBgLayer);
		for(var i=0; i<quickButtons.count; i++)clearImage(quickButtons[i]);

		kag.trigger('quickMenuHide');

		if(afterFunc !== void)afterFunc();
		afterFunc = void;
	}
}

kag.addPlugin(global.quickmenu_object = new QucikMenuPlugin());

@endscript
@endif
@return

*quickMenuShow
@eval exp="quickmenu_object.show()"
@waittrig name='quickMenuShow'
@s

*quickMenuHide
@eval exp="quickmenu_object.hide()"
@waittrig name='quickMenuHide'
@return

*back_title
@eval exp="quickmenu_object.hide()"
@return storage="title.ks" target="*title_init"

*goConfig
@eval exp="quickmenu_object.hide()"
@waittrig name='quickMenuHide'
@jump storage="config.ks" target="*showconfig"

*goLoad
@eval exp="quickmenu_object.hide()"
@waittrig name='quickMenuHide'
@jump storage="saveload.ks" target="*load"

*goSave
@eval exp="quickmenu_object.hide()"
@waittrig name='quickMenuHide'
@jump storage="saveload.ks" target="*save"

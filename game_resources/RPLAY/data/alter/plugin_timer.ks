@if exp="typeof(global.timer_object) == 'undefined'"
@iscript

class timerPlugin extends KAGPlugin
{
	var timer;
	var eventArray = [];

	var mistLayer;	// 霧用レイヤー
	var mistLayerb;	// 霧裏
	var mistFileName = "loop_mist";
	var mistWay = true;
	var mistMoveWidth = 30;
	var mistLeft;
	var mistTop;
	var mistQuake = true;
	var mistElm = void;
	var isMist = false;

	var deleteAfterTransFlag;

	function timerPlugin()
	{
		super.KAGPlugin(...);
		// 開始時に
		timer = new Timer(timerFunc, "");
		timer.interval = 20;
		timer.enabled = false;
	}

	function finalize()
	{
		timer.enabled=false;
		invalidate timer if timer !== void;
		invalidate mistLayer if mistLayer !== void;
		invalidate mistLayerb if mistLayerb !== void;
		super.finalize();
	}

	function eventAdd(func)
	{
		// とりあえず同じものは増えないように
		if(eventArray.find(func)==-1){
			eventArray.add(func);
			if(!timer.enabled)timer.enabled=true;
		}
	}

	function eventRemove(func)
	{
		eventArray.remove(func,true);
	}

	function timerFunc()
	{
		if(eventArray.count == 0){
			timer.enabled=false;
			return;
		}
		for(var i=eventArray.count-1; i>=0; i--)eventArray[i]();
	}


	function startMist(elm = %[], fv=true)
	{
		stopMist();
		// 各種設定
		mistElm = %[];
		(Dictionary.assign incontextof mistElm)(elm);
		if(elm.speed!==void)mistMoveWidth = +elm.speed;
		else mistMoveWidth=30;
		if(elm.way!==void)mistWay = +elm.way;
		else mistWay = true;
		mistLayer = new Layer(kag, kag.fore.base);
		if(elm.storage!="")mistLayer.loadImages(elm.storage);
		else mistLayer.loadImages(mistFileName);
		if(elm.quake!==void)mistQuake = +elm.quake;
		else mistQuake = false;

//		mistLayer.setSize(800, 600);
		mistLayer.setSize(1280, 720);
		//if(mistWay)mistLeft=-(mistLayer.imageWidth-800),mistTop=-20;
		//else mistLeft=0,mistTop=-20;
		mistLeft = 0;
		mistTop = 0;
		mistLayer.setImagePos(mistLeft, mistTop);
		mistLayer.setPos(0,0);
		mistLayer.absolute = 10000-1;
		mistLayer.hitThreshold=256;
		mistLayer.visible=fv;

		mistLayerb = new Layer(kag, kag.back.base);
		mistLayerb.assignImages(mistLayer);
//		mistLayerb.setSize(800, 600);
		mistLayerb.setSize(1280, 720);
		mistLayerb.setImagePos(mistLeft, mistTop);
		mistLayerb.setPos(0,0);
		mistLayerb.absolute = 10000-1;
		mistLayerb.hitThreshold=256;
		mistLayerb.visible=true;

		deleteAfterTransFlag = false;
		eventAdd(mistFunc);
		isMist=true;
	}

	function mistFunc()
	{
		if(mistWay){	// 正方向に進む場合
			mistLeft+=mistMoveWidth;
//			if(mistLeft>0)mistLeft=-(mistLayer.imageWidth-800)+mistLeft;
			if(mistLeft>0)mistLeft=-(mistLayer.imageWidth-1280)+mistLeft;
		}else{	// 負方向に進む場合
			mistLeft-=mistMoveWidth;
//			if(mistLeft<-(mistLayer.imageWidth-800))mistLeft=mistLeft+(mistLayer.imageWidth-800);
			if(mistLeft<-(mistLayer.imageWidth-1280))mistLeft=mistLeft+(mistLayer.imageWidth-1280);
		}
		if(mistQuake)mistLayer.setImagePos(mistLeft, mistTop+intrandom(-20,20));
		else mistLayer.setImagePos(mistLeft, mistTop);
		mistLayerb.setImagePos(mistLayer.imageLeft, mistLayer.imageTop);
	}

	function stopMist()
	{
		deleteAfterTransFlag = false;
		isMist=false;
		eventRemove(mistFunc);
		invalidate mistLayer if mistLayer !== void;
		invalidate mistLayerb if mistLayer !== void;
		mistLayer = void;
		mistLayerb = void;
	}

	function onStore(f, elm)
	{
		var dic = f.timerPluginStatus = %[];
		dic.mist = isMist;
		dic.mistElm = %[];
		if(mistElm != void)(Dictionary.assign incontextof dic.mistElm)(mistElm);
	}

	function onRestore(f, clear, elm)
	{
		stopMist();

		var dic = f.timerPluginStatus;
		if(dic !== void){
			if(dic.mist)startMist(dic.mistElm);
		}
	}

	function readyStop()
	{
		deleteAfterTransFlag = true;
		if(mistLayerb !== void)mistLayerb.visible = false;
	}

	function onExchangeForeBack()
	{
		if(deleteAfterTransFlag)stopMist();
		else if(isMist && mistLayer !== void && mistLayerb !== void){
			mistLayer.visible = true;
			var tmp = mistLayer;
			mistLayer = mistLayerb;
			mistLayerb = tmp;
		}
	}
}

kag.addPlugin(global.timer_object = new timerPlugin());

@endscript
@endif

@macro name="mist"
@eval exp="timer_object.startMist(mp, false)"
@endmacro

@macro name="smist"
@eval exp="timer_object.stopMist()"
@endmacro

@macro name="rsmist"
@eval exp="timer_object.readyStop()"
@endmacro


@return
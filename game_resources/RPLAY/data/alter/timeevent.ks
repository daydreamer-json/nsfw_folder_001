
@if exp="typeof(global.timeevent_object) == 'undefined'"
@iscript

class event
{

	var beginTime = void;
	var eventTime = void;
	var endTime = void;
	var eventFunction = void;
	var doLast = false;

	function event(begin, time)
	{
		beginTime = begin;
		eventTime = time;
		endTime = begin + time;
		doLast = false;
	}

	function finalize()
	{
	}

	// 時間を過ぎているなら0
	// 過ぎていないなら1を返す
	function doEvent(tick)
	{
		if(tick > endTime){
			if(!doLast){
				doLast = true;
				eventFunction(1);
			}
			return 0;
		}
		if(tick < beginTime)return 1;
		var per = (tick-beginTime)/eventTime;

		eventFunction(per);
		return 1;
	}
}


class timeEvent extends KAGPlugin
{

	var eventArray;
	var startTick;
	var doing;

	function timeEvent()
	{
		super.KAGPlugin();
		eventArray = [];
	}

	function finalize()
	{
		eventFinish();
		super.finalize();
	}

	function addEvent(func, begin, time)
	{
		var index = eventArray.add(new event(begin, time));
		eventArray[index].eventFunction = func incontextof eventArray[index];
		return true;
	}

	function startEvent()
	{
		var invalid = false;
		doing = true;
		for(var i=0; i<eventArray.count; i++)if(eventArray[i].eventFunction === void)invalid = true;
		if(invalid || eventArray.count == 0){
			System.inform("関数が登録されていないオブジェクトがるか、\nオブジェクトが追加されていません。");
			return false;
		}
		startTick = System.getTickCount();
		System.addContinuousHandler(eventLoop);
	}

	function eventLoop(tick)
	{
		var nowTick =  tick - startTick;
		var counter = 0;
		for(var i=0; i<eventArray.count; i++)counter += eventArray[i].doEvent(nowTick);
		if(counter == 0)eventFinish();
	}

	function eventFinish()
	{
		doing = false;
		System.removeContinuousHandler(eventLoop);
		for(var i=0; i<eventArray.count; i++){
			invalidate eventArray[i] if eventArray[i] !== void;
			eventArray[i] = void;
		}
		eventArray = [];
		kag.trigger('timeevent');
	}

	var finishFile="";

	function saveFile(file)
	{
		finishFile = file;
	}

	function loadFile(){ return finishFile; }

	function syaseiSet()
	{
		addEvent(
			function(per){
				kag.fore.layers[2].opacity = 255*per;
			},0,200);
		addEvent(
			function(per){
				kag.fore.layers[2].visible=false;
			},200, 100);
		addEvent(
			function(per){
				kag.fore.layers[4].visible=true;
				kag.fore.layers[1].visible=true;
			},350, 100);
		addEvent(
			function(per){
				effect_object[0].targetLayer.visible = true;
				kag.fore.layers[4].opacity = 255 * (1-per);
			},450, 1500);
		addEvent(
			function(per){
				effect_object[0].targetLayer.opacity = 255 * (1-per);
			},1000, 1500);
	}

	function syaseiSet2()
	{
		addEvent(
			function(per){
				kag.fore.layers[2].opacity = 255*per;
			},0,200);
		addEvent(
			function(per){
				kag.fore.layers[2].visible=false;
			},200, 100);
		addEvent(
			function(per){
				kag.fore.layers[4].visible=true;
				kag.fore.layers[1].visible=true;
			},300, 100);
		addEvent(
			function(per){
				effect_object[0].targetLayer.visible = true;
				kag.fore.layers[4].opacity = 255 * (1-per);
			},400, 800);
		addEvent(
			function(per){
				effect_object[0].targetLayer.opacity = 255 * (1-per);
			},800, 400);
	}
}

kag.addPlugin(global.timeevent_object = new timeEvent());



@endscript
@endif

@macro name="ss"
@eximg layer=1 page=fore storage=%storage visible=false
@eximg layer=2 page=fore storage=white opacity=0
@eximg layer=4 page=fore storage=white visible=false
@eval exp="mp.x=512-(409*((+mp.xp-0.5)/0.5))" cond="mp.xp !== void"
@eval exp="mp.y=384-(307*((+mp.yp-0.5)/0.5))" cond="mp.yp !== void"
@eff storage=%storage size=(1.8,1.8) path="&mp.x+','+mp.y+',255'" absolute=3000 time=1 visible=false
@weff
@layopt layer=3 visible=false
@eval exp="timeevent_object.syaseiSet()"
@eval exp="timeevent_object.saveFile(mp.storage)"
@eval exp="timeevent_object.startEvent()"
@endmacro

@macro name="es"
@waittrig name="timeevent" canskip=true cond="timeevent_object.doing"
@eff_delete
@eval exp="timeevent_object.eventFinish()"
@ev storage="&timeevent_object.loadFile()" time=200
@endmacro

@return

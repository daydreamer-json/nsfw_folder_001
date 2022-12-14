;サンプルコード
;@iscript
;kag.onConductorScenarioLoad = function(storage){
;	if(storage != "" && storage.charAt(0) == "@"){
;		//si(storage);
;		return storage;
;	}else{
;		return true;
;	}
;}incontextof kag;
;@endscript
;@call storage="plugin_delayscript.ks"
;@eval exp="kag.reorderLayers()"
;@call storage="gameinit.ks"
;@setframe
;@show
;@chr st09aba08
;@set_delay s="@wait time=6300"
;@set_delay s="@chr st09aba07"
;@set_delay s="@chr_quake name=弥生 sx=2 sy=5 xcnt=10 ycnt=1 time=250"
;@set_delay s="@wait time=1000"
;@set_delay s="@chr st09aba06 time=10000"
;;@set_delay s="@wait time=1000"
;;@set_delay s="@bg storage=bg001a time=5000"
;;@set_delay s="@wait time=1000"
;;@set_delay s="@chr st09aba04"
;;@set_delay s="@wait time=1000"
;;@set_delay s="@chr st09aba03"
;@start_delay
;@nm t="弥生" s=yay_0024
;「うん。新しく人が入ったことは言ってたけどそんな[r]
;　ことはひと言も……うう、私、これでも相談室の[r]
;　顧問なのに……」[np]


@if exp="typeof(global.delayscript) == 'undefined'"
@iscript

//; シナリオ読み込みを改造する方法
///@iscript
///var myCon = new Conductor(kag, kag.tagHandlers);
///myCon.assign(kag.mainConductor);
///myCon.clear();
///kag.add(myCon);
///myCon.onScenarioLoad = function(storage){
///	reservedScript = "";
///	return storage;
///};
///var reservedScript = "";
///function reserveScript(script){
///	reservedScript += script + "\n";
///}
///@endscript
///@macro name="dchr"
///@eval exp="mp.delay = 1000" cond="mp.delay === void"
///@eval exp="reserveScript('@wait time='+mp.delay)"
///@eval exp="reserveScript('@chr '+mp.s)"
///@eval exp="myCon.loadScenario(reservedScript)"
///@eval exp="myCon.run()"
///@endmacro

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
	var timer;
	var cnt = 0;

	function timeEvent()
	{
		super.KAGPlugin();
		eventArray = [];
		timer = new Timer(eventLoop, "");
	}

	function finalize()
	{
		eventFinish();
		super.finalize();
	}

	function addEvent(script)
	{
		// 前回追加されたものがウェイトで無ければ前回の文字列と連結する
		if(eventArray.count != 0 && eventArray[-1].indexOf("@wait")==-1 && script.indexOf("@wait")==-1){
			eventArray[-1] = eventArray[-1] + "\n" + script;
		}else eventArray.add(script);
	}

	function startEvent()
	{
		doing = true;
		if(eventArray.count == 0){
			dm("予約されたスクリプトが存在しません");
			return false;
		}
		startTick = System.getTickCount();
		cnt = 0;
		while(!doScript()){}
	}

	function doScript()
	{
		if(cnt >= eventArray.count || eventArray.count == 0)return true;
		var script = eventArray[cnt];
		var re = false;
		if(script.indexOf("@wait") != -1){
			var time = script.substr(script.indexOf("time=")+5);
			time = (int)time.substr(0, script.indexOf(" "));
			if(time == 0)time = 1000;
			timer.interval = time;
			timer.enabled = true;
			re = true;
		}else{
			kag.callExtraConductor(script+"\n@return");
			re = false;
		}
		cnt += 1;
		return re;
	}

	function eventLoop(tick)
	{
		// コンフィグ画面表示中とかなら一旦帰る
		if(kag.conductor != kag.mainConductor)return;
		while(!doScript()){}
		if(cnt >= eventArray.count)eventFinish();
	}

	function eventFinish()
	{
		doing = false;
		timer.enabled = false;
		eventArray.clear();
		//kag.trigger('timeevent');
	}
}

kag.addPlugin(global.delayscript = new timeEvent());



@endscript
@endif

@macro name="set_delay"
@eval exp="delayscript.addEvent(mp.s)"
@endmacro

@macro name="start_delay"
@eval exp="delayscript.startEvent()"
@endmacro

@return

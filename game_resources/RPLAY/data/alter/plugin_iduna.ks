@if exp="typeof(global.battou_object) == 'undefined'"
@iscript

// イヅナ抜刀シーン用プラグイン


class BattouPlugin extends KAGPlugin
{
	var timer; // タイマ
	var img = [
		"ev_etc_38_1",
		"ev_etc_38_2",
		"ev_etc_38_3",
		"ev_etc_38_4",
		"ev_etc_38_5",
		"ev_etc_38_6",
		"ev_etc_38_7",
		"ev_etc_38_8",
		"ev_etc_38_9",
		"ev_etc_38_10",
		"ev_etc_38_11",
		"ev_etc_38_12"
	];
	var imgCnt = 0;
	var target = void;

	function BattouPlugin()
	{
		super.KAGPlugin(); // スーパークラスのコンストラクタを呼ぶ
	}

	function finalize()
	{
		stop();
		super.finalize(...);
	}

	function start(isRestore = false)
	{
		if(timer === void){
			imgCnt = 0;
			timer = new Timer(onTimer, "");
		}

		if(isRestore)target = kag.fore.layers[0];
		else target = kag.back.layers[0];

		timer.interval = 70;
		timer.enabled = true;
	}

	function onTimer()
	{
		if(target === void)return;
		imgCnt++;
		if(imgCnt >= img.count)imgCnt = 0;
		kag.fore.layers[0].loadImages(%[storage:img[imgCnt], visible:true]);
	}

	function stop()
	{
		if(timer !== void){
			timer.enabled = false;
			invalidate timer;
			timer = void;
		}
	}

	function onStore(f, elm)
	{
		if(timer !== void){
			f.battou = true;
		}else{
			f.battou = false;
		}
	}

	function onRestore(f, clear, elm)
	{
		if(f.battou)start(true);
		else stop();
	}

	function onExchangeForeBack()
	{
		stop();
	}
}

kag.addPlugin(global.battou_object = new BattouPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

@endscript
@endif

@macro name="ev_etc_38_start"
@eval exp="global.battou_object.start()"
@endmacro

@macro name="ev_etc_38_stop"
@eval exp="global.battou_object.stop()"
@endmacro

@return

@if exp="typeof(global.waitvoice_object) == 'undefined'"
@iscript

class WaitVoicePlugin extends KAGPlugin
{
	var time = 1000;
	var timer = void;
	var paused = false;

	function titleTimerPlugin()
	{
		super.KAGPlugin(...);
	}

	function finalize()
	{
		stop();
		super.finalize();
	}

	function start(elm)
	{
		time = 1000;
		paused = false;
		if(elm.time !== void)time = +elm.time;
		try{
			if(kag.se[kag.se.count-2].status != "play" || kag.se[kag.se.count-2].position >= time)return;	// すでに待ちの時間を過ぎていたり、再生されていない
		}catch(e){
			dm("ボイス待ち開始時に失敗："+e.message);
			return;
		}
		if(timer === void){
			timer = new Timer(timerFunc, "");
			timer.interval = 20;
			timer.enabled = true;
		}
	}

	function timerFunc()
	{
		if(kag.conductor.curStorage == "title.ks"){
			stop();
			return;
		}
		try{
			if(kag.se[kag.se.count-2].position >= time){
				stop();
				pause();
				kag.trigger( "finish_voice_wait");
			}
		}catch(e){
			dm("■ボイス待ち中に失敗："+e.message);
			stop();
			kag.trigger( "finish_voice_wait");
		}
	}

	function pause()
	{
		kag.se[kag.se.count-2].paused = true;
		paused = true;
	}

	function resume()
	{
		if(paused){
			kag.se[kag.se.count-2].paused = false;
			paused = false;
		}
	}

	function skip()
	{
		try{
			stop();
			kag.se[kag.se.count-2].position = time;
		}catch(e){
			dm("■ボイスのスキップに失敗："+e.message);
		}
	}

	function stop()
	{
		if(timer !== void){
			timer.enabled=false;
			invalidate timer;
			timer = void;
		}
	}

	function onStore(f, elm){}
	function onRestore(f, clear, elm){ stop(); }
	function onExchangeForeBack(){}
}

kag.addPlugin(global.waitvoice = new WaitVoicePlugin());

@endscript
@endif

@macro name="internal_wait_voice"
@eval exp="waitvoice.start(mp)"
@waittrig name="finish_voice_wait" canskip=true onskip="waitvoice.skip(), tf.waitVoiceTrigSkipped=true"
@endmacro

@macro name="internal_wait_voice_restart"
@eval exp="waitvoice.resume()"
@endmacro

@macro name="iwv"
@internal_wait_voice *
@l cond="!tf.waitVoiceTrigSkipped"
@internal_wait_voice_restart
@eval exp="tf.waitVoiceTrigSkipped = false"

@r cond="mp.noreline===void"

@endmacro

@return
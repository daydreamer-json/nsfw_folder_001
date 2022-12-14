@if exp="typeof(global.titletimer_object) == 'undefined'"
@iscript

class titleTimerPlugin extends KAGPlugin
{
	var timer = void;

	function titleTimerPlugin()
	{
		super.KAGPlugin(...);
	}

	function finalize()
	{
		del();
		super.finalize();
	}

	function start()
	{
		if(timer === void){
			timer = new Timer(timerFunc, "");
			timer.interval = 40000;
			timer.enabled = true;
		}
	}

	function timerFunc()
	{
		if(kag.conductor.curStorage != "title.ks")return;
		kag.process("title.ks", "*next");
		del();
	}

	function del()
	{
		if(timer !== void){
			timer.enabled=false;
			invalidate timer;
			timer = void;
		}
	}

	function onStore(f, elm){}

	function onRestore(f, clear, elm)
	{
		del();
	}

	function onExchangeForeBack()
	{
		del();
	}
}

kag.addPlugin(global.titletimer_object = new titleTimerPlugin());

@endscript
@endif

@macro name="title_loop_set"
@eval exp="titletimer_object.start();"
@endmacro

@return
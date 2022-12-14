@if exp="typeof(global.scene_skip_object) == 'undefined'"
@iscript

class sceneSKipPlugin extends KAGPlugin
{

	var button;
	var timer;
	var flag;
	var target;

	function sceneSKipPlugin()
	{
		super.KAGPlugin(...);
	}

	function finalize()
	{
		super.finalize(...);
	}

	function show(t)
	{
		target = t;
		if(button === void){
			button = new FunctionButtonLayerEx(kag, kag.primaryLayer);
			button.loadImages("g_scene_skip");
			button.hint = "このシーンをスキップします";
			button.opacity = 0;
			button.setPos(1218, 683);
			button.pressFunction = this.onPress;
			button.visible = true;
			flag = true;
			timer  = new Timer(onTimer, "");
			timer.interval = 20;
			timer.enabled = true;
		}
	}

	function hide()
	{
		if(button !== void){
			button.enabled = false;
			flag = false;
			timer.enabled = true;
		}
	}

	function onTimer()
	{
		if(flag){
			if(button.opacity+5 > 255){
				button.opacity = 255;
				timer.enabled = false;
			}else button.opacity += 5;
		}else{
			if(button.opacity-5 < 0){
				timer.enabled = false;
				invalidate timer;
				invalidate button;
				timer = void;
				button = void;
			}else button.opacity -= 5;
		}
	}

	function onPress()
	{
		kag.process("", target);
	}
}

kag.addPlugin(global.scene_skip_object = new sceneSKipPlugin());

@endscript
@endif

@macro name="show_scene_skip"
@eval exp="tf.skipping = !(kag.skipMode==0 || kag.skipMode==1 || kag.skipMode==4)"
@eval exp="tf.noCtrlSkip=true"
@eval exp="kag.cancelSkip()"
@clickskip enabled=false
@eval exp="scene_skip_object.show(mp.target)"
@endmacro

@macro name="hide_scene_skip"
@eval exp="scene_skip_object.hide()"
@clickskip enabled=sysClickSkip
@eval exp="tf.noCtrlSkip=false"
@eval exp="kag.clickSkipEnabled=true, sysSkipOption ? kag.skipToNextStopMenuItem.click() : kag.onSkipToNextStopMenuItemClick()" cond="sysDoSkip && tf.skipping"
@endmacro
@return
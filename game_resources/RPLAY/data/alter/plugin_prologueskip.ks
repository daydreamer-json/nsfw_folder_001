@if exp="typeof(global.pskip_object) == 'undefined'"
@iscript

// ＊＊＊プラグイン
class PrologueSkipPlugin extends KAGPlugin
{
	var scenario = "";
	var startTick = 0;
	var timer;
	var liveTime = 20000;
	var button;

	function PrologueSkipPlugin() {
		super.KAGPlugin();
	}

	function finalize() {
		invalidate timer if timer !== void;
		invalidate button if button !== void;
		super.finalize(...);
	}

	function onTimer(){
		var curs = kag.mainConductor.curStorage;
		var tick = System.getTickCount();
		if(curs != scenario || (tick - startTick) > liveTime){
			stop();
		}
	}

	function start(){
		stop();
		scenario = kag.mainConductor.curStorage;
		if(scenario == "" || scenario.length > 20)return;	// バックログジャンプでの一瞬表示避け
		startTick = System.getTickCount();
		timer = new Timer(onTimer, "");
		timer.interval = 20;
		timer.enabled = true;
		button = new ThreeButtonLayer(kag, kag.primaryLayer, %[storage:"prologue_skip"]);
		button.pressFunction = onSkip;
		button.setPos(30, 620);
		button.opacity = 255;
		button.absolute = 8;
		button.visible = true;
	}

	function stop(){
		if(timer !== void){
			timer.enabled = false;
			invalidate timer;
			timer = void;
		}
		if(button !== void){
			invalidate button;
			button = void;
		}
	}

	function onSkip(){
		try{
			effAllDeleteNowFunction();
		}catch(e){}
		for(var i=0; i<kag.se.count; i++){
			kag.se[i].stop();
		}
		
		kag.stopAllTransitions();
		kag.skipToPage();
		kag.clearMessageLayers(false);
		try{
			kag.messageLayer.clear();
			kag.nameLayer.clear();
		}catch(e){}
		idleCall(kag.process, "選択画面.ks");
	}
}

// プラグインオブジェクトを作成し、登録する
kag.addPlugin(global.pskip_object = new PrologueSkipPlugin());

@endscript
@endif

; マクロ宣言等
@macro name="prologue_skip"
@eval exp="global.pskip_object.start()"
@endmacro


@return


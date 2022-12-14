@if exp="typeof(global.submenu_object) == 'undefined'"
@iscript

/*
	下のほうに出すサブメニュー
	現在のファイルの特定の場所にジャンプするだけ
 */

class SubMenuPlugin extends KAGPlugin
{

	var baseLayer;		// ベース
	var buttons = [];	// 上に載ってるボタン
	var timer;			// 移動用タイマー
	var fade = false;	// 表示か、非表示か

	function SubMenuPlugin()
	{
		super.KAGPlugin(...);

		// メニューの下敷き作成
		baseLayer = new Layer(kag, kag.primaryLayer);
		baseLayer.loadImages("sl_bg_sub");
		baseLayer.setSizeToImageSize();
		baseLayer.setPos(0, kag.scHeight);
		baseLayer.absolute = 30;
		baseLayer.visible = true;

		// ボタン郡作成
		var file = ["sl_save", "cfg_back", "cfg_title", "cfg_exit"];
		var tjs = [
			"kag.process('','*loadtosave');",
			"kag.process('','*back');",
			"kag.process('','*back_title');",
			"kag.process('','*exit');"
		];
		var pos = [
			[768 ,688-(kag.scHeight-baseLayer.imageHeight)],
			[897 ,688-(kag.scHeight-baseLayer.imageHeight)],
			[1016,688-(kag.scHeight-baseLayer.imageHeight)],
			[1137,688-(kag.scHeight-baseLayer.imageHeight)]
		];
		for(var i=0; i<file.count; i++){
			var obj = new FunctionButtonLayerEx(kag, baseLayer);
			buttons.add(obj);
			with(obj){
				obj.loadImages(file[i]);
				obj.pressTjs = tjs[i];
				obj.setPos(pos[i][0], pos[i][1]);
				obj.visible = true;
			}
		}

		// 移動用タイマー作成
		timer = new Timer(onTimer, "");
		timer.interval = 20;
		timer.enabled = false;
	}

	function finalize()
	{
		invalidate timer;
		invalidate baseLayer;
		for(var i=0; i<buttons.count; i++)invalidate buttons[i];
		super.finalize(...);
	}

	function onTimer()
	{
		var top = baseLayer.top;
		if(fade){
			// 表示へ
			top -= 4;
			if(top <= (kag.scHeight-baseLayer.height)){
				baseLayer.top = (kag.scHeight-baseLayer.height);
				baseLayer.visible = true;
				timer.enabled = false;
			}else baseLayer.top = top;
		}else{
			// 非表示へ
			top += 4;
			if(top >= kag.scHeight){
				baseLayer.top = kag.scHeight;
				baseLayer.visible = false;
				timer.enabled = false;
			}else baseLayer.top = top;
		}
	}

	function show(){change(true);}
	function hide(){change(false);}
	function change(visible)
	{
		fade = visible;
		for(var i=0; i<buttons.count; i++){
			buttons[i].enabled = visible;
		}
		timer.enabled = true;
	}
}

kag.addPlugin(global.submenu_object = new SubMenuPlugin());

@endscript
@endif
@return


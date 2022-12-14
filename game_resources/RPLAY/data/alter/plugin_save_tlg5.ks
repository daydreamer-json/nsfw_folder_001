@if exp="typeof(global.savetlg5_object) == 'undefined'"
@iscript

// セーブ中のローディングを示す用のクラス
class WaittingScene extends Layer
{
	var bar;
	var hi;

	function WaittingScene(win, par)
	{
		super.Layer(...);
		type = ltAlpha;
		face = dfAlpha;
		hitType = htMask;
		hitThreshold = 0;

		show();
	}

	function finalize()
	{
		invalidate bar;
		invalidate hi;
		super.finalize(...);
	}

	function show()
	{
		//setImageSize(window.innerWidth, window.innerHeight);
		loadImages("sl_progress_bg");
		setSizeToImageSize();
		//fillRect(0,0,width,height,0xaa000000);

		bar = new global.Layer(window, this);
		bar.loadImages("sl_progress_bar");
		bar.setSize(1, bar.imageHeight);
		bar.setPos(width\2-bar.imageWidth\2, height\2-bar.imageHeight\2);
		bar.visible=true;
		hi = new global.Layer(window, bar);
		hi.loadImages("sl_progress_hi");
		hi.setSizeToImageSize();
		hi.type = ltPsAdditive;
		hi.visible=true;

		visible = true;
	}

	function setProgress(par)
	{
		if(par > 1)par = 1;
		var w = bar.imageWidth * par;
		if(w <= 0)w = 1;
		bar.width = w;

		var x = (par/0.3)-Math.floor(par/0.3);
		hi.left = x*bar.imageWidth;
	}
}

class SaveTLG5Plugin extends KAGPlugin
{
	var window;
	var progressLayer;

	function SaveTLG5Plugin(win)
	{
		super.KAGPlugin(...);
		window = win;

		window.onSaveLayerImageProgress = this.onSaveLayerImageProgress;
		window.onSaveLayerImageDone = this.onSaveLayerImageDone;

		// キャンセル(終了イベント来る)
		//cancelSaveLayerImage(handler)
		// 停止(終了イベントこない)
		//stopSaveLayerImage(handler);
		
	}

	function save(lay, fn, tags)
	{
		progressLayer = new WaittingScene(window, window.primaryLayer);
		window.startSaveLayerImage(lay, fn, tags);
	}

	function finalize()
	{
		super.finalize(...);
	}

	// 保存中イベント
	function onSaveLayerImageProgress(handler, progress, layer, filename)
	{
		if(progressLayer === void)return;
		progressLayer.setProgress(progress/100);
	}

	// 終了イベント
	function onSaveLayerImageDone(handler, canceled, layer, filename)
	{
		invalidate progressLayer if progressLayer !== void;
		progressLayer = void;
		//System.inform("保存完了");
		//playSystemSound("save_complete");
		try{SaveLoad_object.saveload.makeSaveDataItems();}catch(e){dm(e.message);}
	}
}

kag.addPlugin(global.savetlg5_object = new SaveTLG5Plugin(kag));

function saveThumbnails(lay, fn, tags)
{
	global.savetlg5_object.save(lay, fn, tags);
}

@endscript
@endif
@return

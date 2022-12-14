@if exp="typeof(global.loopbg_object) == 'undefined'"
@iscript

class LoopBgPlugin extends KAGPlugin
{
	var timer;
	var eventArray = [];

	var bg;		// 背景
	var _bg;	// 背景裏

	var opt = [];	// 追加オプション
	var _opt = [];	// 追加オプション裏
	var optMove = [];
	var optLeft = [];
	var optDelay = [];
	var optDStart = [];

	var storeParam;	// パラメータの保存
	var way;
	var nLeft;
	var nTop;
	var moveWidth;

	var doing = false;

	var deleteAfterTransFlag;

	function LoopBgPlugin()
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
		invalidate bg if bg !== void;
		invalidate _bg if _bg !== void;
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

	function start(elm = %[], fv=true)
	{
		stop();
		// 各種設定
		storeParam = %[];
		(Dictionary.assign incontextof storeParam)(elm);

		if(elm.storage=="")return 0;

		if(elm.speed!==void)moveWidth = +elm.speed;
		else moveWidth=30;
		if(elm.way!==void)way = +elm.way;
		else way = true;
		var top;
		if(elm.top!==void)top = +elm.top;
		else top = 0;
		bg = new Layer(kag, kag.fore.base);
		bg.loadImages(elm.storage);
		bg.setSizeToImageSize();

		bg.setSize(kag.scWidth, kag.scHeight);
		bg.setImagePos(nLeft, nTop);
		bg.setPos(0,top);
		bg.absolute = kag.fore.layers[0].absolute+1;
		bg.hitThreshold=256;
		bg.visible=fv;

		_bg = new Layer(kag, kag.back.base);
		_bg.assignImages(bg);
		_bg.setSize(kag.scWidth, kag.scHeight);
		_bg.setImagePos(nLeft, nTop);
		_bg.setPos(0,top);
		_bg.absolute = kag.back.layers[0].absolute+1;
		_bg.hitThreshold=256;
		_bg.visible=true;

		optMove = [];
		optLeft = [];
		optDStart = [];
		for(var i=0;;i++){
			if(elm["optstorage"+i] !== void){
				var obj;
				opt.add(obj = new Layer(kag, kag.fore.base));
				obj.loadImages(elm["optstorage"+i]);
				obj.setSizeToImageSize();
				var opttop;
				if(elm["opttop"+i]!==void)opttop = +elm["opttop"+i];
				else opttop = 0;
				obj.setPos(-obj.width, opttop);
				obj.absolute = bg.absolute+1+i;
				obj.hitThreshold = 256;
				obj.visible = fv;

				var _obj;
				_opt.add(_obj = new Layer(kag, kag.back.base));
				_obj.assignImages(obj);
				_obj.setSize(obj.width, obj.height);
				_obj.setPos(-obj.width, opttop);
				_obj.absolute = _bg.absolute+1+i;
				_obj.hitThreshold = 256;
				_obj.visible = true;

				optLeft.add(-obj.width);
				optDStart.add(System.getTickCount());
				optDelay.add(intrandom(1000, 5000));
				if(elm["optspeed"+i]!==void)optMove.add(+elm["optspeed"+i]);
				else optMove.add(moveWidth);
			}else break;
		}

		deleteAfterTransFlag = false;
		eventAdd(func);
		doing=true;
	}

	function func()
	{
		if(way){	// 正方向に進む場合
			nLeft+=moveWidth;
			if(nLeft>0)nLeft=-(bg.imageWidth-kag.scWidth)+nLeft;
			// 時々飛んでくるオプション
			var nt = System.getTickCount();
			for(var i=0; i<opt.count;i++){
				if(nt - optDStart[i] > optDelay[i]){
					optLeft[i] += optMove[i];
					if(optLeft[i]>kag.scWidth){
						optLeft[i]=-opt[i].width;
						optDStart[i] = nt;
						optDelay[i] = intrandom(1000,5000);
					}
					opt[i].left = _opt[i].left = optLeft[i];
				}
			}
		}else{	// 負方向に進む場合
			nLeft-=moveWidth;
			if(nLeft<-(bg.imageWidth-kag.scWidth))nLeft=nLeft+(bg.imageWidth-kag.scWidth);
			// 時々飛んでくるオプション
			var nt = System.getTickCount();
			for(var i=0; i<opt.count;i++){
				if(nt - optDStart[i] > optDelay[i]){
					optLeft[i] -= optMove[i];
					if(optLeft[i]<0){
						optLeft[i]=opt[i].width;
						optDStart[i] = nt;
						optDelay[i] = intrandom(1000,5000);
					}
					opt[i].left = _opt[i].left = optLeft[i];
				}
			}
		}
		bg.setImagePos(nLeft, nTop);
		_bg.setImagePos(bg.imageLeft, bg.imageTop);
	}

	function stop()
	{
		deleteAfterTransFlag = false;
		doing=false;
		eventRemove(func);
		invalidate bg if bg !== void;
		invalidate _bg if _bg !== void;

		for(var i=0; i<opt.count; i++){
			invalidate opt[i];
			invalidate _opt[i];
		}
		opt = [];
		_opt = [];

		bg = void;
		_bg = void;
	}

	function onStore(f, elm)
	{
		var dic = f.loopBgPluginStatus = %[];
		dic.bgloop = doing;
		dic.storeParam = %[];
		if(storeParam != void)(Dictionary.assign incontextof dic.storeParam)(storeParam);
	}

	function onRestore(f, clear, elm)
	{
		stop();

		var dic = f.loopBgPluginStatus;
		if(dic !== void){
			if(dic.bgloop)start(dic.storeParam);
		}
	}

	function readyStop()
	{
		deleteAfterTransFlag = true;
		if(_bg !== void){
			_bg.visible = false;
			for(var i=0; i<_opt.count; i++){
				_opt[i].visible = false;
			}
		}
	}

	function onCopyLayer(toback){
		if(doing && bg !== void && _bg !== void && !deleteAfterTransFlag){
			if(kag.conductor.curStorage == "title.ks")readyStop();
		}
	}

	function onExchangeForeBack()
	{
		if(deleteAfterTransFlag || kag.conductor.curStorage == "title.ks")stop();
		else if(doing && bg !== void && _bg !== void){
			bg.visible = true;
			var tmp = bg;
			bg = _bg;
			_bg = tmp;

			for(var i=0; i<opt.count; i++){
				opt[i].visible = true;
				var tmp = opt[i];
				opt[i] = _opt[i];
				_opt[i] = tmp;
			}
		}
	}
}

kag.addPlugin(global.loopbg_object = new LoopBgPlugin());

@endscript
@endif

@macro name="loopbg"
@eval exp="loopbg_object.start(mp, false)"
@endmacro

@macro name="sloopbg"
@eval exp="loopbg_object.stop()"
@endmacro

@macro name="rsloopbg"
@eval exp="loopbg_object.readyStop()"
@endmacro

@return
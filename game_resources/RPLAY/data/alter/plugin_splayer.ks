@if exp="typeof(global.spLayerObject) == 'undefined'"
@iscript

//-----------------------------------------------------------------------
// 共用タイマー
//-----------------------------------------------------------------------
class CommonTimer
{
	var timer;
	var funcList = [];

	function CommonTimer()
	{
		timer = new Timer(onTimer, "");
		timer.interval = 30;
		funcList = [];
	}

	function finalize()
	{
		invalidate timer;
	}

	function add(func)
	{
		// 同じものは登録しない
		if(funcList.find(func)==-1)funcList.add(func);
		if(!timer.enabled)timer.enabled = true;
	}

	function clear()
	{
		funcList.clear();
		timer.enabled = false;
	}

	function remove(func)
	{
		if(funcList.find(func)!=-1){
			funcList.erase(funcList.find(func));
		}
	}

	function onTimer()
	{
		if(funcList.count == 0){
			timer.enabled = false;
			return;
		}else{
			for(var i=0; i<funcList.count; i++){
				if(typeof funcList[i] == "Object")funcList[i]();
				else if(typeof funcList[i] == "String")Scripts.eval(funcList[i]);
			}
		}
	}
}
var commonTimer = new CommonTimer();
kag.add(commonTimer);

//-----------------------------------------------------------------------
// 画像が回転するレイヤー
//-----------------------------------------------------------------------
class spinLayer extends Layer
{
	var img;
	var oneAngle = 0.1;
	var nowAngle = 0;
	var nega = false;	// 逆周りか？

	function spinLayer(win, par)
	{
		super.Layer(...);
		img = new global.Layer(win, this);
	}

	function finalize()
	{
		invalidate img;
		super.finalize(...);
	}

	function loadImages(storage)
	{
		var result = img.loadImages(storage);
		setImageSize(img.imageWidth, img.imageHeight);
		setSizeToImageSize();
		visible = true;
		return result;
	}

	function doSpin()
	{
		nowAngle += oneAngle;
		if(nowAngle >= 360)nowAngle-=360;
		setAngle(nowAngle * (nega ? -1 : 1) );
	}

	function setAngle(angle)
	{
		var r = 6.28318530717959*(angle/360)*-1;
		var hh = img.imageWidth\2;
		var hw = img.imageHeight\2;
		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI/2.0) - r);
		var m00 = rc;
		var m01 = -rs;
		var m10 = rs;
		var m11 = rc;
		var mtx = (m00*-hw) + (m10*-hh) + hw;
		var mty = (m01*-hw) + (m11*-hh) + hh;
		affineCopy(img, 0, 0, img.imageWidth, img.imageHeight, true, m00, m01, m10, m11, mtx, mty, stFastLinear, false);
	}

	// 座標の設定は中心を指定するように調整
	function setPos(x, y)
	{
		super.setPos(x-imageWidth\2, y-imageHeight\2);
	}
}

//-----------------------------------------------------------------------
// 上記角度調整できるレイヤーをまとめて管理するクラス
//-----------------------------------------------------------------------
class spinEffPlugin extends KAGPlugin
{
	var list = [];

	function spinEffPlugin()
	{
		super.KAGPlugin(...);
	}

	function finalize()
	{
		super.finalize(...);
	}

	function addCircle(par, x, y, files)
	{
		for(var i=0; i<files.count; i++){
			var obj;
			list.add( obj = new spinLayer(kag, par) );
			obj.absolute = 1;
			obj.hitType = htMask;
			obj.hitThreshold = 256;
			obj.focusable = false;
			obj.loadImages(files[i]);
			obj.nega = i%2;
			obj.oneAngle = (intrandom(1,5)/10);
			obj.setPos(x, y);
			obj.doSpin();		// 一度描画しておく
		}
		commonTimer.add(onTimer);
	}

	function clearCircle()
	{
		for(var i=0; i<list.count; i++){
			invalidate list[i];
		}
		list.clear();
		commonTimer.remove(onTimer);
	}

	function onTimer()
	{
		if(list.count == 0)commonTimer.remove(onTimer);
		else{
			for(var i=0; i<list.count; i++){
				list[i].doSpin();
			}
		}
	}
}
kag.addPlugin(global.spinEff = new spinEffPlugin());

@endscript
@endif
@return
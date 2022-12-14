@if exp="typeof(global.par_object) == 'undefined'"
@iscript

class insectLayer extends Layer
{
	var img;
	var flipLR = false;	// 上下反転するかどうか
	var flipUD = false;	// 左右反転するかどうか
	var size = false;	// 拡大・縮小どらか
	var liveTime = 1000;// 生存時間
	var fadeTime = 200;	// フェードアウト時間
	var startTick = 0;	// 開始時間
	var sx, sy;			// 初期出現座標
	var ssx, ssy;
	var sr = 0, dr = 0;
	var alive = false;	// 生きてるか？
	var sSize = 1;
	var dSize = 1;
	var xacce = 1;
	var yacce = -2;
	var slowly = false;

	function insectLayer(win, par, timg, left, top, way="")
	{
		super.Layer(...);
		img = timg;
		flipLR = intrandom(0,1);
		flipUD = intrandom(0,1);
		size = intrandom(0,1);
		liveTime = intrandom(500, 1000);
		ssx = sx = left;
		ssy = sy = top;

		absolute = 1200000;
		type = ltPsAdditive;
		hitType = htMask;
		hitThreshold = 256;

		reset();

		sSize = 0.2 + Math.random();
		if(size)dSize = 0.5 + Math.random();
		else dSize = 0.1+Math.random();

		startTick = System.getTickCount();

		if(way == "r"){
			xacce = (Math.random()+0.1) * 3;
			slowly = true;
		}else if(way == "l"){
			xacce = (Math.random()+0.1) * -3;
			slowly = true;
		}else{
			xacce = (Math.random()-0.5) * 4;
			slowly = false;
		}
		if(way=="r" || way=="l")yacce = Math.random() - 0.5;
		else yacce = -1.5;
		
		move(startTick);
		visible = true;
		alive = true;
	}

	function finalize()
	{
		super.finalize(...);
	}

	function reset()
	{
		sSize = 1;
		dSize = intrandom(0.5,1.5);
		xacce = intrandom(-1,1);
		yacce = -2;
		sx = ssx + intrandom(-5,5);
		sy = ssy + intrandom(-5,5);
		opacity = 255;
		alive = true;
		liveTime = intrandom(500, 1000);
		startTick = System.getTickCount();
		sr = intrandom(-360,360);
		dr = intrandom(-360,360);
		sr = sr*(Math.PI/180);
		dr = dr*(Math.PI/180);
	}

	function move(tick)
	{
		var _tick = tick-startTick;
		if(_tick >= liveTime){
			alive = false;
		}else{
			// 消えるときのフェード処理
			if(liveTime-_tick<=fadeTime){
				opacity = 255 * ((liveTime-_tick)/fadeTime);
			}

			if(slowly){
				if(xacce>0)xacce -= xacce/60;
				else xacce += -xacce/60;
			}else xacce += Math.random()-0.5;
			sx += xacce;
//			sy += yacce;
			// コピー
			var nowSize = sSize + (dSize-sSize)*_tick/liveTime;
			var nowWidth = img.imageWidth * nowSize;
			var nowHeight = img.imageHeight * nowSize;
			if(nowWidth<1)nowWidth=1;
			if(nowHeight<1)nowHeight=1;
			setImageSize(nowWidth, nowHeight);
			setSizeToImageSize();
			//stretchCopy(0,0,width,height,img,0,0,img.imageWidth,img.imageHeight);
			affine(nowSize, (sr + (dr-sr)*_tick/liveTime));
			setPos(sx-width/2, sy-height/2);
		}
	}

	//(Math.PI/180) * +elm.sr

	function affine(s, r)
	{
		var cx = img.imageWidth/2;
		var cy = img.imageHeight/2;
		var l = imageWidth/2;
		var t = imageHeight/2;
		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI/2.0) - r);

		var m00 = s * rc;
		var m01 = s * -rs;
		var m10 = s * rs;
		var m11 = s * rc;
		var mtx = (m00*-cx) + (m10*-cy) + l;
		var mty = (m01*-cx) + (m11*-cy) + t;

		affineCopy(img, 0, 0, img.imageWidth, img.imageHeight, true, m00, m01, m10, m11, mtx, mty, stFastLinear, true);
	}
}

class ParPlugin extends KAGPlugin
{
	var img;
	var layArray = [];

	var timer;

	function ParPlugin()
	{
		super.KAGPlugin(...);
	}

	function finalize()
	{
		stopPar();
		imgClear();
	}

	function makeNewLayer(storage){
		var obj;
		img.add(obj = new Layer(kag, kag.fore.base));
		obj.loadImages(storage);
	}

	function startPar(elm)
	{
		stopPar();
		if(img === void){
			img = [];
			var storage = "t_star";
			if(elm.storage!==void)storage=elm.storage;
			
			makeNewLayer(storage+"0");
			makeNewLayer(storage+"1");
			makeNewLayer(storage+"2");
			makeNewLayer(storage+"3");
			makeNewLayer(storage+"4");
			makeNewLayer(storage+"5");
		}else{
			var storage="t_star";
			if(elm.storage!==void)storage=elm.storage;
			for(var i=0; i<img.count; i++){
				img[i].loadImages(storage+i);
			}
		}
		if(timer === void)timer = new Timer(move, "");
		timer.interval = 16;
		timer.enabled = false;

		var left = elm.x===void?400:(int)elm.x;
		var top = elm.y===void?200:(int)elm.y;
		var w = elm.w===void?200:(int)elm.w;
		var h = elm.h===void?10:(int)elm.h;

		for(var i=0; i<5; i++)
		for(var t=0; t<20; t+=3)
			layArray.add(new insectLayer(kag, kag.fore.base, img[intrandom(0,img.count-1)], left+intrandom(-w/2,w/2), top+intrandom(-h/2,h/2)+t*2));
		timer.enabled = true;
	}

	function stopPar()
	{
		if(timer !== void){
			timer.enabled = false;
			invalidate timer;
			timer = void;
		}
		if(layArray.count != 0){
			for(var i=0; i<layArray.count; i++){
				invalidate layArray[i];
			}
			layArray = [];
		}
	}

	function imgClear()
	{
		if(img !== void){
			for(var i=0; i<img.count; i++)invalidate img[i];
			img = void;
		}
	}

	function move()
	{
		var tick = System.getTickCount();
		for(var i=0; i<layArray.count; i++){
			if(!layArray[i].alive){
				//invalidate layArray[i];
				//layArray.erase(i);
				//i--;
				layArray[i].reset();
			}
			if(layArray.count>0)layArray[i].move(tick);
			else timer.enabled = false;
		}
	}

	function onStore(f, elm){}

	function onRestore(f, clear, elm){stopPar();}
}

kag.addPlugin(global.par_object = new ParPlugin());

function startPar(elm){global.par_object.startPar(elm);}
function stopPar(){global.par_object.stopPar();}

@endscript
@endif

@macro name="stop_par"
@eval exp="global.par_object.stopPar()"
@eval exp="global.par_object.imgClear()"
@endmacro

@return
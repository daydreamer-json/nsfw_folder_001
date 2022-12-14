@if exp="typeof(global.flower_object) == 'undefined'"
@iscript

class flowerLayer extends Layer
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

	function flowerLayer(win, par, timg, left, top, way="")
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
//		type = ltPsAdditive;
		hitType = htMask;
		hitThreshold = 256;

		setImageSize(img.imageWidth*1.5, img.imageHeight*1.5);
		setSizeToImageSize();

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

		reset();
		
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
		absolute = 10002 + intrandom(-1, 1);
		sSize = 1;
		dSize = intrandom(0.2,0.1);
		xacce = intrandom(4.0,5.0);
		yacce = -2.7;
		//sx = ssx + intrandom(5,8);
		//sy = ssy + intrandom(2,4);
		sx = intrandom(0,800)-100;
		sy = 600-intrandom(0,600-(sx/800*600))+100;
		opacity = 200;
		alive = true;
		liveTime = intrandom(2000, 3000);
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
			}//else if(_tick < fadeTime)opacity = _tick/fadeTime * 255 if 255 >= _tick/fadeTime * 255;

//			if(slowly){
//				if(xacce>0)xacce -= xacce/60;
//				else xacce += -xacce/60;
//			}else xacce += Math.random()-0.5;
			xacce -= 0.0002;
			sx += xacce;
			sy += yacce;
			// コピー
			var nowSize = sSize + (dSize-sSize)*_tick/liveTime;
			var nowWidth = img.imageWidth * nowSize;
			var nowHeight = img.imageHeight * nowSize;
			if(nowWidth<1)nowWidth=1;
			if(nowHeight<1)nowHeight=1;
			//setImageSize(nowWidth, nowHeight);
			//setSizeToImageSize();
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

class FlowerPlugin extends KAGPlugin
{
	var img;
	var imgMain;
	var layArray = [];

	var timer;
	var throughTrans = false;

	function FlowerPlugin()
	{
		super.KAGPlugin(...);
	}

	function finalize()
	{
		stopFlower();
		imgClear();
	}

	function makeNewLayer(storage){
		var obj, obji;
		img.add(obji = new Layer(kag, kag.fore.base));
		if(imgMain === void)imgMain = [];
		imgMain.add(obj = new Layer(kag, kag.fore.base));
		obj.loadImages(storage);
		obji.setImageSize(obj.imageWidth, obj.imageHeight);
	}

	function startFlower(elm)
	{
		stopFlower();
		throughTrans = true;
		if(img === void){
			img = [];

			makeNewLayer("ext_flower");
			makeNewLayer("ext_flower");
			makeNewLayer("ext_flower");
			makeNewLayer("ext_flower");
			makeNewLayer("ext_flower");
			makeNewLayer("ext_flower");
		}else{
			for(var i=0; i<img.count; i++){
				img[i].loadImages("ext_flower");
			}
		}
		if(timer === void)timer = new Timer(move, "");
		timer.interval = 20;
		timer.enabled = false;

		var left = elm.x===void?400:(int)elm.x;
		var top = elm.y===void?200:(int)elm.y;
		var w = elm.w===void?200:(int)elm.w;
		var h = elm.h===void?10:(int)elm.h;

//		for(var i=0; i<5; i++)
//		for(var t=0; t<20; t+=3)
//			layArray.add(new flowerLayer(kag, kag.fore.base, img[intrandom(0,img.count-1)], left+intrandom(-w/2,w/2), top+intrandom(-h/2,h/2)+t*2));
		for(var i=0; i<50; i++){
			if(Math.random() > 0.5)
				layArray.add(new flowerLayer(kag, kag.back.base, img[intrandom(0,img.count-1)], -33, intrandom(0,600)));
			else
				layArray.add(new flowerLayer(kag, kag.back.base, img[intrandom(0,img.count-1)], intrandom(0,800), 600));
		}
		timer.enabled = true;
	}

	function stopFlower()
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
			for(var i=0; i<imgMain.count; i++)invalidate imgMain[i];
			imgMain = void;
		}
	}

	var tt = 500;
	var st;
	var ffff = 0;

	function move()
	{
		if(st === void){
			st = [];
			for(var i=0; i<img.count; i++)st.add(System.getTickCount()+(i*300));
		}
		for(var i=0; i<img.count; i++){
			var nt = System.getTickCount()-st[i];
			var n1 = imgMain[i].imageWidth/2 - 4;
			var n2 = imgMain[i].imageWidth/2 + 4;
			var x,w;
			if(nt < tt){
				x = nt/tt * n1;
			}else if((nt-tt) < tt){
				x = n2 + (imgMain[i].imageWidth-n2)*((nt-tt)/tt);
			}else if((nt-tt*2) < tt){
				x = imgMain[i].imageWidth - (imgMain[i].imageWidth-n2)*((nt-tt*2)/tt);
			}else if((nt-tt*3) < tt){
				x = n1 - ((nt-tt*3)/tt * n1);
			}else{
				st[i] = System.getTickCount();
				x = 0;
			}
			w = imgMain[i].imageWidth - x*2;
			img[i].fillRect(0,0,img[i].imageWidth,img[i].imageHeight,0x0);
			img[i].stretchCopy(x,0,w,imgMain[i].imageHeight,imgMain[i],0,0,imgMain[i].imageWidth,imgMain[i].imageHeight, stNearest);
		}
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
	function onRestore(f, clear, elm){stopFlower();}
	function onExchangeForeBack(){
		if(throughTrans)throughTrans = false;
		else stopFlower();
	}
}

kag.addPlugin(global.flower_object = new FlowerPlugin());

function startFlower(elm){global.flower_object.startFlower(elm);}
function stopFlower(){global.flower_object.stopFlower();}

@endscript
@endif

@macro name="stop_flower"
@eval exp="global.flower_object.stopFlower()"
@eval exp="global.flower_object.imgClear()"
@endmacro

@return
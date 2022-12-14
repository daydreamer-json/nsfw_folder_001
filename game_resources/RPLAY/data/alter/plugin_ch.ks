@if exp="typeof(global.ch_object) == 'undefined'"
@iscript

// 60FPSに制限
//System.setArgument('-contfreq', '60');

// コレ単体では自走できないアフィンレイヤープラグイン
class chEffectPlugin extends KAGPlugin
{
	var cx, cy;		// 回転中心
	var accel;		// 加速度的な動きを行うか
	var moveFunc;	// 移動位置計算用関数
	var zoomFunc;	// 拡大処理用関数
	var clear;		// レイヤをクリアするかどうか
	var blend;		// 重ね合わせの不透明度
	var page;		// ページ裏表
	var mblur;		// 擬似モーションブラー用
	var bblur;		// ボックスブラー用
	var pathtype;	// パスの方式
	var sp_accel;	// 特殊な加減速

	var sr, dr;		// 回転角度
	var path;		// パスの作業用
	var time;		// ひとつのパスを通る時間
	var totalTime;		// 総合時間
	var lasttick=0;		// 前回の描画時間
	var starttick;		// 描画開始時間
	var affintype;		// アフィン変換の方式
	var imgLayer;		// 画像レイヤー
	var targetLayer;	// 対象レイヤー

	var zx = [];		// スプラインワーク
	var zy = [];		// スプラインワーク
	var imageWidthHalf;	// 対象レイヤーの幅の半分
	var imageHeightHalf;// 対象レイヤーの高さの半分

	var size;			// サイズを記録する配列
	var timeForSize;	// サイズ専用の時間

	var moving = false;	// 動作中かどうか
	var alive = false;	// レイヤー類が生きてるかどうか

	// セーブ・ロード用パラメータ記録配列
	var storeDic = %[];

	// トランジション後に消去フラグ
	var deleteAfterTransFlag = false;

	function chEffectPlugin(window, par, img)
	{
		super.KAGPlugin();
		this.window = window;

		if(typeof img == "String"){
			imgLayer = new Layer(window, par);
			imgLayer.loadImages(img);
		}else imgLayer = img;
	}

	function finalize()
	{
		// 一応止めて所持オブジェクト破棄
		stop();
		deleteLayer();

		invalidate imgLayer if imgLayer !== void;

		super.finalize(...);
	}

	function startEffect(elm)
	{
		// 辞書配列をセーブ・ロード用に退避
		(Dictionary.assign incontextof storeDic)(elm);

		// パスのタイプを設定
		this.pathtype = elm.pathtype == "true" ? true : false;

		var base = window.fore.base;

		// 既存の動作を停止
		stop();
		deleteLayer();

		// 画像用レイヤーに効果をかける
		// グレースケール
		if(elm.grayscale=='true')imgLayer.doGrayScale();
		// ガンマ補正
		elm.rgamma = elm.rgamma !== void ? +elm.rgamma : 1.0;
		elm.ggamma = elm.ggamma !== void ? +elm.ggamma : 1.0;
		elm.bgamma = elm.bgamma !== void ? +elm.bgamma : 1.0;
		elm.rfloor = elm.rfloor !== void ? +elm.rfloor : 0;
		elm.gfloor = elm.gfloor !== void ? +elm.gfloor : 0;
		elm.bfloor = elm.bfloor !== void ? +elm.bfloor : 0;
		elm.rceil = elm.rceil !== void ? +elm.rceil : 255;
		elm.gceil = elm.gceil !== void ? +elm.gceil : 255;
		elm.bceil = elm.bceil !== void ? +elm.bceil : 255;
		if(elm.turn=='true'){	// 階調の反転
			var rtemp = elm.rfloor;
			var gtemp = elm.gfloor;
			var btemp = elm.bfloor;
			elm.rfloor = elm.rceil;
			elm.gfloor = elm.gceil;
			elm.bfloor = elm.bceil;
			elm.rceil = rtemp;
			elm.gceil = gtemp;
			elm.bceil = btemp;
		}
		imgLayer.adjustGamma(elm.rgamma, elm.rfloor, elm.rceil, elm.ggamma, elm.gfloor, elm.gceil, elm.bgamma, elm.bfloor, elm.bceil);

		// 反転
		if(elm.fliplr=='true')imgLayer.flipLR();
		if(elm.flipud=='true')imgLayer.flipUD();

		// ボックスブラー
		if(elm.bblur=='true')imgLayer.doBoxBlur((int)elm.bbx, (int)elm.bby);

		//---------------------------
		// 他パラメーター設定
		//---------------------------

		// path の分解
		if(elm.path === void){
			path = [ kag.scWidth*0.5, kag.scHeight*0.5, 255,
					kag.scWidth*0.5, kag.scHeight*0.5, 255 ];
		}else{
			this.path = [].split("(), ", elm.path, , true);
			// 文字として受け取っているものを数値に変える。
			for(var i = this.path.count-1; i>=0; i--)this.path[i] = +this.path[i];
		}

		if(this.path.count < 4){
			// 1点しか指定されていない場合、2点目にも同じ数値を。
			this.path[3]=this.path[0];
			this.path[4]=this.path[1];
			this.path[5]=this.path[2];
		}

		// 回転中心
		if( elm.cx === void )this.cx = imgLayer.imageWidth/2;
		else if( typeof +elm.cx == 'Real' )this.cx = imgLayer.imageWidth * +elm.cx;
		else this.cx = +elm.cx;

		if( elm.cy === void )this.cy = imgLayer.imageHeight/2;
		else if( typeof +elm.cy == 'Real' )this.cy = imgLayer.imageHeight * +elm.cy;
		else this.cy = +elm.cy;

		// 初期角度
		this.sr = (Math.PI/180) * +elm.sr;
		// 最終角度
		this.dr = (Math.PI/180) * +elm.dr;

		// 初期拡縮率
		this.ss = elm.ss !== void ? +elm.ss : 1;
		// 最終拡縮率
		this.ds = elm.ds !== void ? +elm.ds : 1;

		// サイズをパスと同じように扱ってみる
		if(elm.size===void)this.size = [1,1];
		else{
			this.size = [].split("(), ", elm.size, , true);
			for(var i = this.size.count-1; i>=0; i--)this.size[i] = +this.size[i];
		}

		//---------------------------
		// 対象レイヤーを設定
		//---------------------------
//		targetLayer = target;
		if(targetLayer === void)targetLayer = new Layer(window, window.fore.base);
		with(targetLayer){
			var maxSize = 0;
			for(var i=0; i<size.count; i++)if(maxSize<size[i])maxSize = size[i];
			var tempSize = Math.sqrt(imgLayer.imageWidth*imgLayer.imageWidth + imgLayer.imageHeight*imgLayer.imageHeight) * maxSize;
			.setImageSize(tempSize, tempSize);
			.setSizeToImageSize();
			.face = dfAlpha;		// 描画モードは不透明アリ
			.type = ltAlpha;
			.hitType = htMask;
			.hitThreshold = 256;	// 当たり判定無し
			.visible = true;
		}
		// よく使うからとりあえず計算済みのものを。
		imageWidthHalf = targetLayer.imageWidth * 0.5;
		imageHeightHalf = targetLayer.imageHeight * 0.5;
		//----------------------------

		// 時間設定
//		this.time = elm.time !== void ? +elm.time : 1000;
		
		// 時間も細かく指定できるように
		if(elm.time===void)this.time = [1000,1000];
		else{
			this.time = [].split("(), ", elm.time, , true);
			for(var i = this.time.count-1; i>=0; i--)this.time[i] = +this.time[i];
		}

		if(this.time[0]<=1)this.time[0] = 1;
		totalTime = 0;
		// 全体時間を計算
		for(var i=0; i<this.time.count; i++)totalTime += this.time[i];
		// サイズ用の時間を計算
		timeForSize = totalTime \ (this.size.count-1);
		if(this.timeForSize<=1)this.timeForSize = 1;

		// 加速度設定
		this.accel = elm.accel !== void ? +elm.accel : 0;
		// 特殊な加速を使うか？（減速→加速）
		if(elm.sp_accel == "true"){
			this.accel = Math.abs(this.accel);
			this.sp_accel = true;
		}else this.sp_accel = false;

		// 表示タイプ設定
		targetLayer.type = ltAlpha;
		if(elm.type != void){
			// この辞書配列はtjsがはじめから持ってるらしい
			var _type = imageTagLayerType[elm.type].type;
			if(_type !== void)targetLayer.type = _type;
		}

		// レイヤー表示タイプが不透明・もしくは透明だった場合アフィン変換のタイプを精度の高いものへ
		if(targetLayer.type == ltOpaque){
			targetLayer.face = dfOpaque;
			targetLayer.holdAlpha = false;
			affintype = stFastLinear;
		}else if(targetLayer.type == ltAlpha){
			targetLayer.face = dfAlpha;
			affintype = stFastLinear;
		}else {
			targetLayer.face = dfAuto;
			affintype = stNearest;
		}

		// アフィン中に周りをクリアするかどうか
		this.clear = elm.clear == 'true' ? true : false;

		// モーションブラーするかどうか
		this.mbler = elm.mbler == 'true' ? true : false;

		// ブレンドの濃度
		this.blend = elm.blend !== void ? (int)elm.blend : 40;

		// 移動位置計算関数の設定
		if(elm.spline == 'true'){
			PreSpline();
			moveFunc = SplineMover;
		}else moveFunc = LinearMover;

		// ズーム用関数の設定
		zoomFunc = elm.mblur == 'true' ?  blurAt : moveAt;

		// 時間が一秒未満だった場合即終了
		if(this.time[0]<=1){
			finish();
			alive = true;
			moving = false;
			return;
		}

		// 初期位置に表示
		moveFunc(0);
	}

	function moveAt( m00, m01, m10, m11, mtx, mty, opacity )
	{
		// アフィン変換転送
		targetLayer.affineCopy(
					imgLayer, 0, 0, imgLayer.imageWidth, imgLayer.imageHeight, true,
					m00, m01, m10, m11, mtx, mty, affintype, true
					);
	}

	function blurAt( m00, m01, m10, m11, mtx, mty )
	{
		// アフィン変換転送・ブラーもどき処理
		targetLayer.operateAffine(
					imgLayer, 0, 0, imgLayer.imageWidth, imgLayer.imageHeight, true,
					m00, m01, m10, m11, mtx, mty, omAuto, blend, affintype
					);
	}

	function LinearMover(tick)
	{
		// 経過秒数 \ 一点を通過するための時間 * 3
		//var index = tick \ time * 3;
		var index = time.count-1;
		var passedTime = 0;
		for(var i=0; i<time.count; i++){
			if(passedTime+time[i] > tick){
				index = i;
				break;
			}
			passedTime += time[i];
		}

		// 経過秒数 % 一点を通過するための時間 / 一点を通過するための秒数
		// 点と点の間で0～1に変化する値
		//var ratio = tick % time / time;
		var ratio = (tick - passedTime) / time[index];
		if(passedTime == totalTime)ratio=1;
		var sizeIndex = index;
		var sizeRatio = ratio;
		index*=3;

		var p = path;
		var sx = p[index];
		var sy = p[index+1];
		var so = p[index+2];
		var ex = p[index+3];
		var ey = p[index+4];
		var eo = p[index+5];

		// 現在位置を計算
		var l = ((ex-sx)*ratio + sx);
		var t = ((ey-sy)*ratio + sy);

		targetLayer.opacity = eo >= 256 ? so : int((eo-so)*ratio + so);

		var tm = tick / totalTime;

		// 角度・拡大率計算
		var r = ((dr - sr) * tm + sr) * -1;
		//var s = (ds - ss) * tm + ss;
//		var sizeIndex = tick \ timeForSize;
//		var sizeRatio = tick % timeForSize / timeForSize;
		var s = (size[sizeIndex+1] - size[sizeIndex])*sizeRatio + size[sizeIndex];

		// 整数値の座標はレイヤー移動で表現
		targetLayer.setPos(Math.floor(l)-targetLayer.imageWidth/2, Math.floor(t)-targetLayer.imageHeight/2);
		// 小数点以下の座標はアフィン変換で表現
		l = targetLayer.imageWidth/2 + (l-Math.floor(l));
		t = targetLayer.imageHeight/2 + (t-Math.floor(t));

		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI/2.0) - r);

		// 画像の中心を原点(0,0)とした場合の回転中心の座標を求める
		var rx = cx - imgLayer.imageWidth/2;
		var ry = cy - imgLayer.imageHeight/2;

		//  x1 = x0 × cos θ － y0 × sin θ
		//  y1 = x0 × sin θ ＋ y0 × cos θ
		var dx = rx * Math.cos(-r) - ry * Math.sin(-r);
		var dy = rx * Math.sin(-r) + ry * Math.cos(-r);

		// 整数の回転の移動分だけここで設定
		targetLayer.left -= Math.floor(dx);
		targetLayer.top -= Math.floor(dy);
		// やはり小数点以下はアフィン変換に含める
		l -= dx-Math.floor(dx);
		t -= dy-Math.floor(dy);

		var m00 = s * rc;
		var m01 = s * -rs;
		var m10 = s * rs;
		var m11 = s * rc;
		//var mtx = (m00*-cx) + (m10*-cy) + l;
		//var mty = (m01*-cx) + (m11*-cy) + t;
		// 回転中心を画像の中心に
		var mtx = (m00*-imgLayer.imageWidth/2) + (m10*-imgLayer.imageHeight/2) + l;
		var mty = (m01*-imgLayer.imageWidth/2) + (m11*-imgLayer.imageHeight/2) + t;
		
		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty, eo >= 256 ? so : int((eo-so)*ratio + so));
	}

	function SplineMover(tick)
	{
		var index;
		var pindex = (index = tick \ time) * 3;
		var d = tick % time / time;
		var p = path;

		var l = (((zx[index+1] - zx[index])*d +
				zx[index]*3)*d +
				((p[pindex + 3] - p[pindex]) -
				(zx[index]*2 + zx[index+1]))) * d +
				p[pindex];

		var t = (((zy[index+1] - zy[index])*d +
				zy[index]*3)*d +
				((p[pindex + 4] - p[pindex+1]) -
				(zy[index]*2 + zy[index+1]))) * d +
				p[pindex+1];

		var so = p[pindex+2];
		var eo = p[pindex+5];

		targetLayer.opacity = eo >= 256 ? so : int((eo-so)*d + so);

		var tm = tick / totalTime;

		// 角度・拡大率計算
		var r = ((dr - sr) * tm + sr) * -1;
		//var s = (ds - ss) * tm + ss;
		var sizeIndex = tick \ timeForSize;
		var sizeRatio = tick % timeForSize / timeForSize;
		var s = (size[sizeIndex+1] - size[sizeIndex])*sizeRatio + size[sizeIndex];

		if(pathtype == "true"){
			// pathで指定するのは画面の中心に画像のどこのピクセルをを持ってくるか
			l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-cx)*s;
			t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-cy)*s;
		}else{
			// pathで指定するのは画像における中心を画面のどこに置くか
			l -= (imgLayer.imageWidth*0.5-cx)*s;
			t -= (imgLayer.imageHeight*0.5-cy)*s;
		}
		
		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI*0.5) - r);
		
		var m00 = s * rc;
		var m01 = s * -rs;
		var m10 = s * rs;
		var m11 = s * rc;
		var mtx = (m00*-cx) + (m10*-cy) + l;
		var mty = (m01*-cx) + (m11*-cy) + t;
		

		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty);
	}

	function PreSpline()
	{
		if(path.count < 9)
		{
			// 2 点以下 は補完できない
			throw new Exception("3 点以上を指定してください");
		}

		// スプライン補間に必要なワークを計算
		var points = path.count \ 3;
		var tmpx = [], tmpy = [];
		var tx = zx, ty = zy;
		tx[0] = 0;
		ty[0] = 0;
		tx[points-1] = 0;
		ty[points-1] = 0;

		for(var i = points-2, pi = path.count-6; i >= 0; i--, pi -= 3)
		{
			tmpx[i+1] = (path[pi + 3] - path[pi  ]);
			tmpy[i+1] = (path[pi + 4] - path[pi+1]);
		}

		tx[1] = tmpx[2] - tmpx[1] - tx[0];
		ty[1] = tmpy[2] - tmpy[1] - ty[0];

		tmpx[1] = 4;
		tmpy[1] = 4;

		var lim = points - 2;
		for(var i = 1; i < lim; i++)
		{
			var x = 1 / tmpx[i];
			var y = 1 / tmpy[i];
			tx[i+1] = tmpx[i+2] - tmpx[i+1] - tmpx[i] * x;
			ty[i+1] = tmpy[i+2] - tmpy[i+1] - tmpy[i] * y;
			tmpx[i+1] = 4 - x;
			tmpy[i+1] = 4 - y;
		}

		tx[points-2] -= tx[points-1];
		ty[points-2] -= ty[points-1];

		for(var i = points-2; i>0; i--)
		{
			tx[i] = (tx[i] - tx[i+1]) / tmpx[i];
			ty[i] = (ty[i] - ty[i+1]) / tmpy[i];
		}
	}

	function continuousHandler(tick)
	{
		// コンソールにfpsを表示する
		//dm("■FPS：" + 1000/(tick-lasttick));

		lasttick=tick;
		tick -= starttick;

		// まだ始まってないので何もせず帰る
		if(tick < 0)return false;

		// 時間通りか過ぎてるなら終わる
		if(tick >= totalTime)
		{
			finish();
			return;
		}

		if(sp_accel)
		{
			// 減速・加速のセット
			var halfTime = totalTime*0.5;
			if(tick <= halfTime){
				tick = 1.0 - tick / halfTime;
				tick = Math.pow(tick, accel);
				tick = int ( (1.0 - tick) * halfTime );
			}else{
				tick -= halfTime;
				tick = tick / halfTime;
				tick = Math.pow(tick, accel);
				tick = int ( tick * halfTime );
				tick += halfTime;
			}
		}else if(accel < 0)
		{
			// 上弦 ( 最初が動きが早く、徐々に遅くなる )
			tick = 1.0 - tick / totalTime;
			tick = Math.pow(tick, -accel);
			tick = int ( (1.0 - tick) * totalTime );
		}
		else if(accel > 0)
		{
			// 下弦 ( 最初は動きが遅く、徐々に早くなる )
			tick = tick / totalTime;
			tick = Math.pow(tick, accel);
			tick = int ( tick * totalTime );
		}

		// 移動
		moveFunc(tick);
	}

	// 最終状態を表示
	function finish()
	{
		moveFunc(totalTime);
		stop();
	}

	// 停止
	function stop()
	{
		if(moving)
		{
//			window.trigger('effect_plugin');
//			System.removeContinuousHandler(continuousHandler);
			moving = false;
		}
	}

	// レイヤーを削除
	function deleteLayer()
	{
		alive = false;
		invalidate targetLayer if targetLayer !== void;
		targetLayer = void;
	}

	function onStore(f, elm){}

	function onRestore(f, clear, elm){}

	function onStableStateChanged(stable){}

	function onMessageHiddenStateChanged(hidden){}

	function onCopyLayer(toback){}

	function onExchangeForeBack(){}

	function onSaveSystemVariables()
	{
		// システム変数に情報が保存され時に呼ばれる
		// このタイミングで kag.scflags に情報を書き込めば
		// 確実にシステム変数に情報を書くことができる
	}
}

class chPlugin extends KAGPlugin
{

	var drawLayer;	// 描画用レイヤー
	var obj = [];	// アフィン対象
	var window;		// 親ウィンドウ

	var doQuake = false;
	var doEvent = false;

	var eventFlag = [false,false,false,false,false,false];
	var event = [1000,1500,1600,5100,5200,6000];

	var sTick;	// 開始時間
	var isAlive = false;	// 動いてるか
	var startDelay = [];	// 開始ディレイ
	var no = 0;				// オブジェクトNO

	var _CX = 640;	// ウィンドウ中心
	var _CY = 360;	// ウィンドウ中心

	var temp_xinc = 33;  // presetPathReadyAuto関数の直上にあったもの

	function chPlugin(win, no)
	{
		super.KAGPlugin(...);

		this.no = +no;
		window = win;
		_CX = kag.scWidth>>1;
		_CY = kag.scHeight>>1;

		// 描画用のレイヤーを作成
		drawLayer = new Layer(window, window.fore.base);
		drawLayer.setImageSize(window.primaryLayer.imageWidth, window.primaryLayer.imageHeight);
		drawLayer.setSizeToImageSize();
		drawLayer.face = dfAlpha;		// 描画モードは不透明アリ
		drawLayer.type = ltAlpha;
		drawLayer.hitType = htMask;
		drawLayer.hitThreshold = 256;	// 当たり判定無し
		drawLayer.hasImage = false;
		drawLayer.visible = true;

	}

	function finalize()
	{
		clear();
		invalidate drawLayer;
		super.finalize();
	}

	function clear()
	{
		System.removeContinuousHandler(loop);
		isAlive = false;
		for(var i=0; i<obj.count; i++)invalidate obj[i] if obj[i] !== void;
		startDelay = [];
		obj = [];
	}

	// 文字レイヤーを作成
	function addChLayer(str, fh=30)
	{
		var temp =  new Layer(window, drawLayer);

		with(temp){
			.font.face = "ＭＳ Ｐ明朝";
			.font.height = fh;	// フォントサイズ決定
			.font.face = "pchフォント";
			.font.mapPrerenderedFont("筑紫aオールド明朝pr6b_30.tft");
			var h = .font.getTextHeight(str) + 4;	// 文字に必要な幅＋影のサイズ
			var w = .font.getTextWidth(str) + 4;
			.setImageSize(w, h);	// 必要な文字幅よりレイヤーサイズ決定
			.type = ltAlpha;
			.hitType = htMask;
			.hitThreshold = 256;	// 当たり判定無し
			//.drawText(0,0,str,0xffffff,255,true,1024,0x000000, 3, 1, 1);
			//.drawText(0,0,str,0xffffff,255,true,256,0xffffff, 1, 0, 0);
			.drawText(0,0,str,0x000000,255,true,200,0x000000, 3, 4, 4);
			.visible = false;
		}

		obj.add(new chEffectPlugin(window, drawLayer, temp));
	}

	// 複数の文字レイヤーを一気に作成
	function addChLayerMulti(str, fh=30)
	{
		for(var i=0; i<str.length; i++)addChLayer(str[i], fh);
	}

	// 画像レイヤーを作成
	function addImgLayer(storage)
	{
		obj.add(new chEffectPlugin(window, drawLayer, storage));
	}

	// 複数の画像レイヤーを作成
	function addImgLayerMulti(storages)
	{
		if(typeof storages!="Object")return false;
		for(var i=0; i<storages.count; i++)addImgLayer(storage[i]);
	}

	// 複数の画像レイヤーを作成(連番自動読み込み)
	function addImgLayerAuto(head)
	{
		var ies = Storages.isExistentStorage;
		for(var i=0;;i++){
			var name = head+i;
			if(ies(name+".png") || ies(name+".tlg") || ies(name+".jpg"))
				addImgLayer(name);
			else if(i!=0)break;		// 0からでも1からでも始まっていいように
		}
	}

	function ready(elm = %[])
	{
		var sn, en;
		if(elm.s==void)sn=0;
		else sn=(int)elm.s;
		if(elm.e==void)en=0;
		else en=(int)elm.e;
		for(var i=sn; i<=en; i++){
			if(elm.size==void)elm.size = "(1.2,1)";
			if(elm.time==void)elm.time = "200,500";
			if(elm.path==void)elm.path = _cp(_CX,_CY,0,_CX,_CY,255,_CX,_CY,255,_CX,_CY,0);
			if(elm.accel==void)elm.accel=-2;
			obj[i].startEffect(elm);
		}
	}

	function start(delay=0, event="false", quake="false", sp=false){
		// ずらしイベントするか？
		if(event=="true"){
			doEvent=true;
			for(var i=0; i<eventFlag.count; i++)eventFlag[i]=false;
		}else doEvent=false;

		// クエイクするか？
		if(quake=="true")doQuake=true;
		else doQuake=false;

		// 活動開始
		for(var i=0; i<obj.count; i++){
			if(sp=="true")obj[i].lasttick = obj[i].starttick = System.getTickCount() + delay*(i%(obj.count*0.5));
			else obj[i].lasttick = obj[i].starttick = System.getTickCount() + delay*i;
			obj[i].moving = true;
			obj[i].alive = true;
		}
		isAlive = true;
		sTick=System.getTickCount();
		System.addContinuousHandler(loop);
	}

	function presetPathReady(elm = %[])
	{
		var index = elm.index===void ? (obj.count-1) : (int)elm.index;

		if(elm.size==void)elm.size = "2,1.0,0.9,2";
		//if(elm.time==void)elm.time = "200,2000,200";

		elm.time = (elm.intime===void?200:(int)elm.intime)+','+(elm.time===void?2000:(int)elm.time)+','+(elm.outtime===void?200:(int)elm.outtime);

		if(elm.x==void)elm.x=_CX;
		if(elm.y==void)elm.y=_CY;

		// 動作パターンの設定
		if(elm.kind===void) elm.kind = 1;
		switch( elm.kind )
		{
			// その場停滞パス
			case "0": elm.path = mkp01(elm.x, elm.y); break;
			// 消えるときにx座標だけ画面中央から外側に向かって1割増しで逃げる
			case "1": elm.path = mkp01_1(elm.x, elm.y); break;
			// X座標を 10 ～ -10 のランダムな値で＋－する
			case "2": elm.path = mkp02(elm.x, elm.y); break;
			// 消えるときにX座標を「temp_xinc」分ずらす
			case "3": elm.path = mkp03(elm.x, elm.y); break;
			// フェードイン → フェードアウトなし
			case "4": elm.path = mkp04(elm.x, elm.y); break;
			// フェードインなし → フェードアウト
			case "5": elm.path = mkp05(elm.x, elm.y); break;
			// 
			case "6": elm.path = mkp06(elm.x, elm.y); break;
			// 
			default :
				dm("presetPathReady\n「elm.kind」に範囲外が指定されました：" + elm.kind);
				elm.path = mkp01(elm.x, elm.y);
				break;
		}
		if(elm.accel==void)elm.accel=-2;
		startDelay[index] = elm.startdelay===void ? 0 : (int)elm.startdelay;
		obj[index].startEffect(elm);
	}

	function presetPathReadyAuto(elm = %[])
	{
		if(elm.sx==void)elm.sx=300;		// 初期座標
		if(elm.sy==void)elm.sy=_CY;		// 初期座標
		if(elm.xinc==void)elm.xinc=0;	// 位置をどれだけずらして表示するか
		temp_xinc = elm.xinc;
		if(elm.yinc==void)elm.yinc=0;	// 位置をどれだけずらして表示するか
		if(elm.delay==void)elm.delay=100;	// 開始時間をどれだけずらして表示するか
		if(elm.intime==void)elm.intime=200;	// フェードインの時間
		if(elm.time==void)elm.time=1000;	// 停滞時間
		if(elm.outtime==void)elm.outtime=200;	// フェードアウトの時間

		elm.sx = +elm.sx;
		elm.sy = +elm.sy;
		elm.xinc = +elm.xinc;
		elm.yinc = +elm.yinc;
		elm.delay = +elm.delay;
		elm.intime = +elm.intime;
		elm.time = +elm.time;
		elm.outtime = +elm.outtime;

/*
		for(var i=0; i<obj.count; i++){
			if(elm.startdelay!==void)startDelay[i] = +elm.startdelay;
			var xinc = elm.xinc;
			var _x = xinc*i;
			if((obj[i].imgLayer.imageWidth>>1) >= xinc)_x += (obj[i].imgLayer.imageWidth>>1) - (xinc>>1);	// 「―」が一番後ろについてた時用の雑な対応
			presetPathReady(%[x:(elm.sx+_x), y:(elm.sy+elm.yinc*i), intime:(elm.intime+elm.delay*i), time:elm.time, outtime:elm.outtime, index:i, size:elm.reduction !== void ? "2,1.0,0.9,0.5" : (mp.size != void ? mp.size : void), kind:elm.kind, accel:elm.accel, startdelay:(+elm.startdelay*i)]);
		}
*/
		// 文字揃え計算
		if(elm.align !== void){
			var w = 0;
			for(var i=0; i<obj.count; i++){
				w += obj[i].imgLayer.imageWidth + elm.xinc;
			}
			if(elm.align == "center"){
				elm.sx = elm.sx - ((w-elm.xinc)>>1);
			}else if(elm.align == "right"){
				elm.sx = elm.sx - (w-elm.xinc);
			}
		}
		// xincが画像サイズを考慮したpitchになるように調整
		var x = 0;
		for(var i=0; i<obj.count; i++){
			if(elm.startdelay!==void)startDelay[i] = +elm.startdelay;
			x += (obj[i].imgLayer.imageWidth>>1);
			presetPathReady(%[x:(elm.sx+x), y:(elm.sy+elm.yinc*i), intime:(elm.intime+elm.delay*i), time:elm.time, outtime:elm.outtime, index:i, size:elm.reduction !== void ? "2,1.0,0.9,0.5" : (mp.size != void ? mp.size : void), kind:elm.kind, accel:elm.accel, startdelay:(+elm.startdelay*i)]);
			x += (obj[i].imgLayer.imageWidth>>1) + elm.xinc;
		}
			
	}

	// その場停滞パス
	function mkp01(x,y){return createPath([x,y,0,x,y,255,x,y,255,x,y,0]);}
	// 消えるときにx座標だけ画面中央から外側に向かって1割増しで逃げる
	function mkp01_1(x,y){
		var _x;
		var wh = kag.scWidth>>1;
		if(x > wh)_x = wh + (x-wh)*1.1;
		else _x = wh - (wh-x)*1.1;
		return createPath([x,y,0,x,y,255,x,y,255,_x,y,0]);
	}
	function mkp02(x,y){x=(int)x+intrandom(-10,10);return createPath([x,y,0,x,y,255,x,y,255,x,y,0]);}
	function mkp03(x,y){
		//var move = 200 + obj[0].imgLayer.imageWidth * obj.count;
		var move = temp_xinc * (obj.count+1) + 0;
		//return createPath([x,y,255,x-move,y,255,x-move,y,255,x-(450+26*obj.count),y,0]);
		return createPath([x,y,255,x-move,y,255,x-move,y,255,x-(26*obj.count),y,0]);
	}
	function mkp04(x,y){return createPath([x,y,0,x,y,255,x,y,255,x,y,255]);}
	function mkp05(x,y){return createPath([x,y,255,x,y,255,x,y,255,x,y,0]);}
	function mkp06(x,y){return createPath( [x,y+intrandom(-10,-30),0, x,y,255, x,y,255, x,y+intrandom(10,30),0] );}

	// 横均等割付配置パス作成
	function makePath01(w, w2, i)
	{
		var x = (kag.innerWidth-w)\2 + w/(obj.count)*i;
		var x2 = (kag.innerWidth-w2)\2 + w2/(obj.count)*i;
		var x3 = (kag.innerWidth-w2*2)\2 + w2*2/(obj.count)*i;
		var y = _CY-obj[i].imgLayer.imageHeight;
		return createPath([x,y,0,((x2-x)\2+x),y,255,x2,y,255,x3,y,0]);
	}

	// 縦均等割付配置パス作成
	function makePath02(h, h2, i)
	{
		var y = (kag.innerHeight-h)\2 + h/(obj.count)*i;
		var y2 = (kag.innerHeight-h2)\2 + h2/(obj.count)*i;
		var y3 = (kag.innerHeight-h2*2)\2 + h2*2/(obj.count)*i;
		var x = _CX;
		return createPath([x,y,0,x,((y2-y)\2+y),255,x,y2,255,x,y3,0]);
	}

	// 横から縦に
	function makePath03(w, w2, h2, i)
	{
		var x = (kag.innerWidth-w)\2 + w/(obj.count)*i;
		var x2 = (kag.innerWidth-w2)\2 + w2/(obj.count)*i;
		var y = _CY;
		var y2 = (kag.innerHeight-h2)\2 + h2/(obj.count)*i;
		return createPath([x,y,0,((x2-x)\2+x),y,255,x2,y,255,x2,y2,255,_CX,y2,255]);
	}

	// 横から縦に2
	function makePath04(w, w2, h2, i)
	{
		var x = (kag.innerWidth-w)\2 + w/(obj.count)*i;
		var x2 = (kag.innerWidth-w2)\2 + w2/(obj.count)*i;
		var y = _CY;
		var y2 = (kag.innerHeight-h2)\2 + h2/(obj.count)*i;
		return (x+','+y+',0,'+((x2-x)\2+x)+','+y+',255,'+x2+','+y+',255,'
					+_CX+','+y2+',255');
	}

	// 渡された配列をコンマでつなぐだけの関数
	function createPath(array){	return array.join(",",,true);}
	// 渡された引数すべてを配列として受け取ってコンマでつないで返す
	function _cp(array*){	return array.join(",",,true);}

	function loop(tick)
	{
		var alive = false;
		for(var i=0; i<obj.count; i++){
			if((tick-sTick)>=startDelay[i])obj[i].continuousHandler(tick-startDelay[i]);
			// 全体のクエイク
			if(doQuake)obj[i].targetLayer.setPos(obj[i].targetLayer.left+intrandom(-1,1),obj[i].targetLayer.top+intrandom(-1,1));
			// 時々ずらすイベント
			if(doEvent){
				for(var a=0; a<event.count; a++){
					if(!eventFlag[a] && (System.getTickCount()-sTick)>event[a]){
						obj[i].targetLayer.setPos(obj[i].targetLayer.left,obj[i].targetLayer.top-intrandom(-20,20));
						if(i==obj.count-1)eventFlag[a]=true;
					}
				}
			}
			// 生きてるか生きてないかチェック
			if(obj[i].moving)alive = true;
		}
		if(!alive){
			window.trigger('effect_plugin'+no);
			isAlive = false;
			System.removeContinuousHandler(loop);
		}
	}

	function finish()
	{
		System.removeContinuousHandler(loop);
		loop(System.getTickCount() + 99999999999);
	}
}

global.ch_object = [];
kag.addPlugin(global.ch_object[0] = new chPlugin(kag, 0));
kag.addPlugin(global.ch_object[1] = new chPlugin(kag, 1));

@endscript
@endif

@macro name="ch_addimage"
@eval exp="ch_object[+mp.obj].addImgLayer(mp.storage)"
@endmacro
@macro name="ch_addimages"
@eval exp="ch_object[+mp.obj].addImgLayerAuto(mp.storage)"
@endmacro

@macro name="ch_addstrs"
@eval exp="ch_object[+mp.obj].addChLayerMulti(mp.str, mp.fontsize);"
@endmacro

@macro name="ch_setoption"
@eval exp="ch_object[+mp.obj].ready(mp)"
@endmacro

@macro name="ch_setpreoption"
@eval exp="ch_object[+mp.obj].presetPathReady(mp)"
@endmacro

@macro name="ch_setpreoption_auto"
@eval exp="ch_object[+mp.obj].presetPathReadyAuto(mp)"
@endmacro

@macro name="ch_start"
@eval exp="ch_object[+mp.obj].start(mp.delay, mp.event, mp.quake, mp.sp)"
@endmacro

@macro name="ch_clear"
@eval exp="ch_object[+mp.obj].clear()"
@endmacro

@macro name="ch_wait"
@waittrig name="&'effect_plugin'+(+mp.obj)" canskip=true cond="ch_object[+mp.obj].isAlive"
@eval exp="ch_object[+mp.obj].finish()"
@endmacro

@return

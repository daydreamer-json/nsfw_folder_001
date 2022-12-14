@if exp="typeof(global.grain_object) == 'undefined'"
@iscript

class Grain
{
	var img;
	var imgW;	// 画像幅
	var imgH;	// 画像高
	var imgWH;	// 画像幅半分
	var imgHH;	// 画像高半分
	var tarWH;	// このレイヤーの幅半分
	var tarHH;	// このレイヤーの幅半分
	var doFlipLR = false;	// 上下反転するかどうか
	var doFlipUD = false;	// 左右反転するかどうか
	var size = false;	// 拡大・縮小どらか
	var liveTime = 1000;// 生存時間
	var fadeTime = 500;	// フェードアウト時間
	var startTick = 0;	// 開始時間
	var sx, sy;			// 現在の出現座標
	var ssx, ssy;		// 初期出現座標
	var sr = 0, dr = 0;	// 回転角度
	var alive = false;	// 生きてるか？
	var sSize = 1;		// 初期サイズ
	var dSize = 1;		// 最終サイズ
	var xacce = 1;		// x加速値
	var yacce = -2;		// y加速値
	var randomize = false;	// ふらふらとめちゃくちゃに動くか
	var sp_random = false;
	var zSpin = false;		// 奥行きのある回転を行うか
	var turnTime = 1000;	// 一回転に要する時間(z方向の)
	var dofadeIn = false;	// フェードで入ってくるか？

	var min_xacce = 1;	// 加減速の最低値
	var max_xacce = 1;	// 加減速の最大値
	var min_yacce = 1;	// 加減速の最低値
	var max_yacce = 1;	// 加減速の最大値
	var min_sx = 0;		// x座標の最低値
	var max_sx = 1280;	// x座標の最大値
	var min_sy = 0;		// y座標の最低値
	var max_sy = 720;	// y座標の最大値
	var min_sr = -360;	// 初期回転角度の最低値
	var max_sr = 360;	// 初期回転角度の最大値
	var min_dr = -360;	// 最終回転角度の最低値
	var max_dr = 360;	// 最終回転角度の最大値
	var min_ss = 1;		// 開始サイズの最低値
	var max_ss = 1;		// 開始サイズの最大値
	var min_ds = 1;		// 終了サイズの最低値
	var max_ds = 1;		// 終了サイズの最大値
	var size_fluct = 0;	// 初期サイズからの終了サイズの増減値。これが0だった場合は「min_ds,max_ds」が採用される。：Fluctuation
	var min_live = 4000;// 生存時間の最低値
	var max_live = 8000;// 生存時間の最低値

	var sleepMax = 5000;	// 発生開始の遅延時間の最大値
	var sleepTime = 0;		// 発生開始の遅延時間決定値
	var wind_acce = 0;	// 風の強さ(x座標に毎回この値をプラスする)
	var end_cond = 0;	// 終了条件
						// 0：時間半分経過画面外
						// u：syがマイナス値
						// d：syが画面下部より下に行った場合
						// l：sxがマイナス値
						// r：sxが画面右より向こうに行った場合
	var condFunc;		// 終了条件を満たしているか調べる関数
	var opacity = 255;	// 不透明度
	var arrange = false;	// 初期状態で画面全体に配置するか

	var drawLayer;	// 描画対象レイヤー
	var owner;		// プラグインへの参照
	var prevTick;

	function Grain(owner, tar, timg, left, top, way="")
	{
		drawLayer = tar;	// 描画対象レイヤー
		this.owner = owner;

		img = timg;
		imgW = img.width;
		imgH = img.height;
		imgWH = imgW/2;
		imgHH = imgH/2;

		doFlipLR = intrandom(0,1);
		doFlipUD = intrandom(0,1);

		ssx = sx = left;
		ssy = sy = top;

		tarWH = tar.imageWidth\2;
		tarHH = tar.imageHeight\2;

		alive = true;
		condFunc = condCheck;	// 終了条件を設定
	}

	function finalize(){}

	function reset()
	{
		prevTick = startTick = System.getTickCount();

		sSize = intrandom(min_ss*100, max_ss*100) / 100;
		dSize = intrandom(min_ds*100, max_ds*100) / 100;
		// 初期値からの揺らぎが設定されていた場合、そちらを優先
		if(size_fluct != 0)dSize = intrandom((sSize-size_fluct)*100, (sSize+size_fluct)*100) / 100;
		xacce = intrandom(min_xacce*100, max_xacce*100) / 100;
		yacce = intrandom(min_yacce*100, max_yacce*100) / 100;
		sx = ssx = intrandom(min_sx, max_sx);
		sy = ssy = intrandom(min_sy, max_sy);

		alive = true;
		liveTime = intrandom(min_live, max_live);
		sr = intrandom(min_sr,max_sr) * (0.0174532925199433);	//(Math.PI/180)
		dr = intrandom(min_dr,max_dr) * (0.0174532925199433);
		// 遅延
		sleepTime = intrandom(0, sleepMax);

		// 初期全画面配置
		if(arrange){
			arrange = false;
			sx = ssx = intrandom(-100, kag.scWidth+100);
			sy = ssy = intrandom(-100, kag.scHeight+100);
			sleepTime = 0;
		}

		// 描画レイヤーを決定
		setDrawLayer();

		// 初期位置に出現
		move(startTick);
		// 終了条件を再設定
		switch(end_cond){
			case "l":condFunc = condCheckL; break;
			case "r":condFunc = condCheckR; break;
			case "u":condFunc = condCheckU; break;
			case "d":condFunc = condCheckD; break;
			case "d2":condFunc = condCheckD2; break;
			case "ld":condFunc = condCheckLD; break;
			case "rd":condFunc = condCheckRD; break;
			default:condFunc = condCheck; break;
		}
	}

	function setDrawLayer()
	{
		if(sSize < 0.85)drawLayer = owner.backDrawLayer2;
		else drawLayer = owner.backDrawLayer;
	}

	// 回転の状態を計算
	function calcSpin()
	{
		var w = 1.0;
		if(zSpin){
			var already = (System.getTickCount()-startTick)%turnTime;
			var rate = already / (turnTime/2);			// 0.0～2.0までの数値が発生するはず
			if(rate <= 1.0){
				w = 1.0 - 2.0*rate;			// 1.0～-1.0の割合を発生させる
			}else{
				w = -1.0 + 2.0*(rate-1);	// -1.0～1.0の割合を発生させる
			}
		}
		return w;
	}

	function move(tick)
	{
		var _tick = tick-startTick;

		// 遅延が行われていたら帰る
		if(sleepTime != 0){
			if(_tick < sleepTime)return;
			else{
				sleepTime = 0;
				prevTick = startTick = System.getTickCount();
			}
		}

		if(_tick >= liveTime){
			alive = false;
			reset();
		}else{
			// 消えるときのフェード処理
			if(liveTime-_tick<=fadeTime){
				var op = 255 * ((liveTime-_tick)/fadeTime);
				opacity = (op<0) ? 0 : op;
			}else if(dofadeIn && (_tick < fadeTime)){	// フェードイン処理
				var op = _tick/fadeTime * 255;
				opacity = op>255 ? 255 : op;
			}else opacity = 255;

			// -0.25～0.25までの乱数で加速値を乱す
			if(randomize) xacce += (Math.random()-0.5)/2;

			// 20msで一回ループが回ってくるとして、それよりどれだけ早いか、遅いかで調整してみる
			var ms = (tick-prevTick);
			var per = ms/20;

			sx += (xacce*per);
			sy += (yacce*per);

			// 風が設定されてたら適用
			sx += (wind_acce*per);

			// 泡用のスペシャルなブレ
			if(sp_random){
				if((_tick\intrandom(200,300))%2){
					sx += (-Math.random()*2)*per;
				}else{
					sx += (Math.random()*2)*per;
				}
				if((_tick\(intrandom(200,300)))%2){
					sy += (-Math.random()*2)*per;
				}else{
					sy += (Math.random())*per;
				}
			}

			// 終了条件のチェック
			if(condFunc()){
				reset();
				return;
			}

			// コピー
			var nowSize = sSize + (dSize-sSize)*(_tick/liveTime);
			affine(nowSize, (sr + (dr-sr)*_tick/liveTime), sx, sy);
		}
		prevTick = tick;
	}

	function condCheck(tick){
		return (tick > (liveTime \ 2) && 
				(sx<0 || sx>kag.scWidth) &&
				(sy<0 || sy>kag.scHeight) &&
				(sx+imgW<0 || sx+imgW>kag.scWidth) &&
				(sy+imgH<0 || sy+imgH>kag.scHeight));
	}
	function condCheckL(tick){return (sx+imgWH < 0);}
	function condCheckR(tick){return (sx-imgWH > kag.scWidth);}
	function condCheckU(tick){return (sy+imgHH < 0);}
	function condCheckD(tick){return (sy-imgHH > kag.scHeight);}
	function condCheckD2(tick){return (sy > kag.scHeight);}
	function condCheckLD(tick){return (sx+imgWH < 0) || (sy-imgHH > kag.scHeight);}
	function condCheckRD(tick){return (sx-imgWH > kag.scWidth) || (sy-imgHH > kag.scHeight);}

	function affine(s, r, x, y)
	{
		// 角度が0ならただのstretchに。
		if(r == 0){
			drawLayer.operateStretch(x-(imgW*s/2), y-(imgH*s/2), imgW*s, imgH*s, img, -img.imageLeft, 0, imgW, imgH, omAlpha, opacity, stFastLinear);
			return;
		}

		var cx = imgWH;
		var cy = imgHH;
		var l = x/* - imgWH*/;
		var t = y/* - imgHH*/;
		var rc = Math.cos(r);
		var rs = Math.cos((1.5707963267949) - r);	//(Math.PI/2.0)

		var m00 = s * rc * calcSpin();
		var m01 = s * -rs;
		var m10 = s * rs;
		var m11 = s * rc;
		var mtx = (m00*-cx) + (m10*-cy) + l;
		var mty = (m01*-cx) + (m11*-cy) + t;

		drawLayer.operateAffine(img, -img.imageLeft, 0, imgW, imgH, true, m00, m01, m10, m11, mtx, mty, omAlpha, opacity, stFastLinear);
	}
}

class GrainPlugin extends KAGPlugin
{
	var img = [];			// 飛ばしたい画像の配列
	var layArray = [];	// 実際に飛んでいくものの配列

	var grainCount = 0;		// 出現個数、現在値と違った場合、減らしたりしていく
	var show = false;
	var hide = false;
	var alive = false;
	var titleStart = false;	// タイトルで開始された場合true(タイトル用の演出の場合)
	var startTick = 0;		// プラグイン自体の開始時間
	var slowlyTime = -1;		// ゆっくり動かす数を増やしていく場合の時間

	var storeElm = %[];

	var foreDrawLayer;
	var backDrawLayer;
	var foreDrawLayer2;
	var backDrawLayer2;

	function GrainPlugin()
	{
		super.KAGPlugin(...);
		foreDrawLayer = new Layer(kag, kag.fore.base);
		backDrawLayer = new Layer(kag, kag.back.base);
		foreDrawLayer2 = new Layer(kag, kag.fore.base);
		backDrawLayer2 = new Layer(kag, kag.back.base);
	}

	function layerSetting(obj, v){
		obj.hitType = htMask;
		obj.hitThreshold = 256;
		obj.setImageSize(kag.scWidth, kag.scHeight);
		obj.setSizeToImageSize();
		obj.type = ltAlpha;
		obj.face = dfAlpha;
		obj.visible = v;
	}

	function finalize()
	{
		deleteGrain();
		invalidate foreDrawLayer;
		invalidate backDrawLayer;
		invalidate foreDrawLayer2;
		invalidate backDrawLayer2;
		super.finalize(...);
	}

	// 粒の数変更
	function changeNum(num)
	{
		if(alive){
			num = (int)num;
			if(num < grainCount && num > 0){
				// 減算の場合。１個以下にはさせない。なら消そう。
				grainCount = num;
				storeElm.num = num;
			}else if(num > grainCount){
				// 加算の場合。
				var elm = %[];
				(Dictionary.assign incontextof elm)(storeElm);
				elm.num = num;
				startGrain(elm, false, true);
			}
		}
	}

	function startGrain(elm, restore = false, addmode = false)
	{
		if(!addmode){
			deleteGrain();
			show = true;
		}
		
		startTick = System.getTickCount();
		if(elm.slowly === void)slowlyTime = -1;
		else{
			slowlyTime = +elm.slowly;
			delete elm.slowly;		// この値は保存しない
		}

		// タイトルで開始されたものかどうか
		if(kag.conductor.curStorage == "title.ks"){
			titleStart = true;
		}else titleStart = false;

		alive = true;

		// 配列の記録
		(Dictionary.assign incontextof storeElm)(elm);

		// レイヤーのサイズを設定
		if(!addmode){
			layerSetting(foreDrawLayer, false);
			layerSetting(backDrawLayer, true);
			layerSetting(foreDrawLayer2, false);
			layerSetting(backDrawLayer2, true);

			foreDrawLayer.absolute = 11000;
			backDrawLayer.absolute = 11000;
			foreDrawLayer2.absolute = 1500;
			backDrawLayer2.absolute = 1500;
		}

		// 出現個数の決定
		var num = 40;
		if(elm.num !== void)num = (int)elm.num;
		grainCount = num;

		// レイヤー表示タイプの設定
		if(elm.mode !== void && elm.mode != ""){
			var _type = imageTagLayerType[elm.mode].type;
			if(_type !== void)foreDrawLayer.type = backDrawLayer.type = foreDrawLayer2.type = backDrawLayer2.type = _type;
		}

		// 奥行きのある回転を行うかの設定
		var zSpin = false;
		if(elm.zspin == "true")zSpin = true;

		// ふらふら動くかどうかの設定
		var randomize = false;
		if(elm.randomize == "true")randomize = true;

		// storages属性が入ってきたら「,」で分割してファイル名とする
		var files;
		if(elm.storage !== void){ files = /,/gi.split(elm.storage); }
		else 					{ files = ["gr_feather"]; }

		var sizeList = [];	// サイズチェック用・前後レイヤーどちらを使うかの判断材料

		// すべての画像の読み込み
		for(var i=0; i<files.count; i++){
			var obj;
			var storage = Storages.chopStorageExt(files[i]);

			if(Storages.isExistentStorage(storage + ".asd")){
				// アニメーションが有る場合
				var info = [].load(storage + ".asd");
				var setting = info[0].substr(1);	// 一行目に設定が入ってる予定
				var ar = setting.split(/ |\=/,,true);
				var cw, ch;
				var cwi = ar.find("clipwidth");
				var chi = ar.find("clipheight");
				if(cwi != -1 && (cwi+1) < ar.count)cw = ar[cwi+1];
				if(chi != -1 && (chi+1) < ar.count)ch = ar[chi+1];
				if(cw !== void && ch !== void){
					img.add(obj = new CharacterLayer(kag, foreDrawLayer));
					obj.loadImages(%[storage:storage, clipleft:0, cliptop:0, clipwidth:cw, clipheight:ch, visible:false]);
				}else{
					dm("アニメーション情報の読み込みに失敗");
				}
			}else{
				img.add(obj = new Layer(kag, foreDrawLayer));
				obj.loadImages(files[i]);
				obj.setSizeToImageSize();
				// 幅と高さを奇数に。そうしたほうが得意かも？
				if(!(obj.imageWidth%2))obj.imageWidth+=1;
				if(!(obj.imageHeight%2))obj.imageHeight+=1;
			}

			if(obj !== void){
				sizeList.add(obj.imageHeight);
			}
		}

		if(img.count == 0){
			System.inform("粒画像の読み込みに失敗しました");
			deleteGrain();
			return;
		}

		var startCount = 0;
		if(addmode)startCount = layArray.count;
		for(var i=startCount; i<num; i++){
			var no = intrandom(0,img.count-1);
			var __obj = img[no];
			if(img.count == 2)__obj = img[i%2];		// 2つしかない場合は交互に使おう
			var __x = intrandom(-100, kag.scWidth+100);
			var __y = intrandom(0, kag.scHeight);

			//layArray.add(new Grain(this, backDrawLayer, __obj, __x, __y));
			layArray.add(new Grain(this, (i%2) ? backDrawLayer : backDrawLayer2, __obj, __x, __y));

			// パラメータの簡易設定
			// 「rain」「snow」「leaf」「bubble」「bubble2」「cherry」「dandelion」
			if(elm.type !== void){
				with(layArray[-1]){
					switch(elm.type){
						case "sakura":
							zSpin = false;
							randomize = true;
							.dofadeIn = false;
							.min_live = 1000;
							.max_live = 4000;
							.fadeTime = 100;
							.wind_acce = 1.5;
							.min_xacce = 0;
							.max_xacce = 0;
							.min_yacce = 5;
							.max_yacce = 10;
							.min_sx = -200;
							.max_sx = kag.scWidth;
							.min_sy = -10;
							.max_sy = 0;
							.min_sr = 0;
							.max_sr = 0;
							.min_dr = 0;
							.max_dr = 0;
							.end_cond = "rd";
							.arrange = i%2;		// 半分ぐらい画面に初期配置
							.min_ss = 0.7;
							.max_ss = 1;
							.size_fluct = 0.3;	// サイズの振れ幅
							break;
						case "rain":
							zSpin = false;
							.min_live = 80;
							.max_live = 300;
							.fadeTime = 50;
							.min_xacce = (no == 3 ? 5 : 0);
							.max_xacce = (no == 3 ? 5 : 0);
							.min_yacce = (no == 3 ? 50 : 80);
							.max_yacce = (no == 3 ? 60 : 90);
							.min_sx = 0;
							.max_sx = kag.scWidth;
							.min_sy = 0;
							.max_sy = 0;
							.min_sr = 0;
							.max_sr = 1;
							.min_dr = 0;
							.max_dr = 0;
							.min_ss = 0.7;
							.max_ss = 1;
							.sleepMax = 0;
							.end_cond = "d";
							break;
						case "snow":
							zSpin = false;
							randomize = true;
							.min_live = 1000;
							.max_live = 5000;
							.fadeTime = 50;
							.min_xacce = 0;
							.max_xacce = 0;
							.min_yacce = 5;
							.max_yacce = 10;
							.min_sx = 0;
							.max_sx = kag.scWidth;
							.min_sy = -10;
							.max_sy = 0;
							.min_sr = 0;
							.max_sr = 0;
							.min_dr = 0;
							.max_dr = 0;
							break;
						case "leaf":
							zSpin = true;
							randomize = true;
							.min_xacce = 0;
							.max_xacce = 0;
							.min_yacce = 2;
							.max_yacce = 5;
							.min_sx = 0;
							.max_sx = kag.scWidth;
							.min_sy = -50;
							.max_sy = -50;
							.min_sr = -360;
							.max_sr = 360;
							.min_dr = -360;
							.max_dr = 360;
							break;
						case "bubble":
							zSpin = false;
							.dofadeIn = true;
							.min_xacce = 0;
							.max_xacce = 0;
							.min_yacce = -1;
							.max_yacce = -5;
							.min_sx = 0;
							.max_sx = kag.scWidth;
							.min_sy = 0;
							.max_sy = kag.scHeight;
							.min_sr = 0;
							.max_sr = 0;
							.min_dr = 0;
							.max_dr = 0;
							.min_ss = 0.3;
							.max_ss = 0.6;
							.min_ds = 0.8;
							.max_ds = 1;
							break;
						case "dandelion":
							zSpin = false;
							randomize = false;
							.min_xacce = -1;
							.max_xacce = -2;
							.min_yacce = -2;
							.max_yacce = -1;
							.min_sx = 0;
							.max_sx = kag.scWidth;
							.min_sy = kag.scHeight;
							.max_sy = kag.scHeight+10;
							.min_sr = -5;
							.max_sr = 5;
							.min_dr = -5;
							.max_dr = 5;
							.min_ss = 0.9;
							.max_ss = 1;
							.min_ds = 0.5;
							.max_ds = 1.5;
							.min_live = 1000;
							.max_live = 5000;
							break;
						default:break;
					}
				}
			}
			// パラメーターリスト
			var pList = ["dofadeIn","min_xacce","max_xacce","min_yacce","max_yacce","min_sx","max_sx","min_sy","max_sy","min_sr","max_sr","min_dr","max_dr","min_ss","max_ss","min_ds","max_ds","end_cond","arrange","size_fluct"];

			// 設定を各レイヤーに適用
			with(layArray[-1]){
				.zSpin = zSpin;
				.randomize = randomize;
				// 各パラメーターが存在するなら適用
				for(var a=0; a<pList.count; a++){
					if(elm[pList[a]] !== void){
						// arrangeは2回に1回しか適用しない
						if( pList[a] == "arrange" && !( i%2 ) )	layArray[-1][pList[a]] = 0;
						else									layArray[-1][pList[a]] = +elm[pList[a]];
					}
				}
				// ロードからの再生の場合、全て表示状態に,showフラグも倒す
				if(restore){
					show = false;
					foreDrawLayer.visible = backDrawLayer.visible = true;
					foreDrawLayer2.visible = backDrawLayer2.visible = true;
				}
				.reset();
			}
			
		}
		System.removeContinuousHandler(move);
		System.addContinuousHandler(move);
	}

	function stopGrain()
	{
		hide = true;
		backDrawLayer.visible = false;
		backDrawLayer2.visible = false;
	}

	function deleteGrain()
	{
		hide = false;
		alive = false;

		System.removeContinuousHandler(move);

		if(layArray.count != 0){
			for(var i=0; i<layArray.count; i++){
				invalidate layArray[i];
			}
			layArray.clear();
		}
		if(img !== void){
			for(var i=0; i<img.count; i++)invalidate img[i];
			img.clear();
		}

		// レイヤークリア
		foreDrawLayer.visible = backDrawLayer.visible = false;
		foreDrawLayer2.visible = backDrawLayer2.visible = false;
		foreDrawLayer.loadImages("lineBreak");
		backDrawLayer.loadImages("lineBreak");
		foreDrawLayer2.loadImages("lineBreak");
		backDrawLayer2.loadImages("lineBreak");
	}

	function move(tick)
	{
		backDrawLayer.fillRect(0,0,backDrawLayer.width,backDrawLayer.height,0x0);
		backDrawLayer2.fillRect(0,0,backDrawLayer2.width,backDrawLayer2.height,0x0);
		if(layArray.count<=0){
			System.removeContinuousHandler(move);
			return;
		}
		var delCount = 0;
		if(grainCount < layArray.count)delCount = layArray.count - grainCount;

		var cnt = layArray.count-1;
		if(slowlyTime != -1 && (tick-startTick) < slowlyTime){
			cnt = Math.ceil(cnt * ((tick-startTick)/slowlyTime));
		}
		for(var i=cnt; i>=0; i--){
			if(delCount > 0 && layArray[i].sleepTime != 0){
				// 減算処理、対象の粒が次出現待ちだった場合は消す
				invalidate layArray[i];
				delete layArray[i];
				--delCount;
				continue;
			}else{
				layArray[i].move(tick);
			}
		}

		foreDrawLayer.assignImages(backDrawLayer);
		foreDrawLayer2.assignImages(backDrawLayer2);
	}

	// 表裏裏返り用描画レイヤー再セット
	function drawLayerReSet()
	{
		for(var i=0; i<layArray.count; i++){
			layArray[i].setDrawLayer();
		}
	}

	function onStore(f, elm){
		if(f.plugin_grain === void)f.plugin_grain = %[];
		(Dictionary.clear incontextof f.plugin_grain)();
		if(alive){
			(Dictionary.assign incontextof f.plugin_grain)(storeElm);
			f.plugin_grain.alive = true;
		}else f.plugin_grain.alive = false;
	}
	function onRestore(f, clear, elm){
		deleteGrain();
		if(f.plugin_grain === void)f.plugin_grain = %[];
		if(f.plugin_grain.alive)startGrain(f.plugin_grain, true);
	}
	function onExchangeForeBack(){
		var tmp = foreDrawLayer;
		foreDrawLayer = backDrawLayer;
		backDrawLayer = tmp;

		tmp = foreDrawLayer2;
		foreDrawLayer2 = backDrawLayer2;
		backDrawLayer2 = tmp;

		drawLayerReSet();
		if(hide){
			deleteGrain();
		}else if(show){
			show = false;
			foreDrawLayer.visible = backDrawLayer.visible = true;
			foreDrawLayer2.visible = backDrawLayer2.visible = true;
		}
		// タイトルで開始されたものではなく止まっていないものがあるなら停止
		if(!titleStart && kag.conductor.curStorage == "title.ks"){
			deleteGrain();
		}
	}
}
kag.addPlugin(global.grain_object = new GrainPlugin());
@endscript
@endif

;--------------------------------------------
; 属性：
;	storage  ：「,」でつないで複数指定可能、ファイル名(def:"gr_feather")
;	num      ：個数(def:20)
;	type     ：移動方法のデフォルト値
;	         ：「rain」「snow」「leaf」「bubble」「cherry」(def:"rain")
;	zspin    ：奥行きのある回転を行うか(def:false)
;	randomize：左右にふらふら揺れるか(def:false)
;   arrange  ：最初から画面内に画像の表示を行うかどうか
;	※現状ではtypeを設定すると多くのパラメータが上書きされる
;--------------------------------------------
[macro name="start_grain"][eval exp="global.grain_object.startGrain(mp)"][endmacro]
[macro name="change_grain_count"][eval exp="global.grain_object.changeNum(mp.num)"][endmacro]
[macro name="stop_grain"][eval exp="global.grain_object.stopGrain()"][endmacro]

; ※開始、終了命令共に次のトランジションに巻き込まれる事によって開始、終了する
; ※slowlyに時間を入れると、その時間かけて数を増やしながら出現する。徐々に雨が降るとか。
[macro name="env_rain"][start_grain * storage=gr_rain_00,gr_rain_01,gr_rain_02,gr_rain_04 num=%num|200 type=rain arrange=%arrange|true][endmacro]
[macro name="env_sakura"][start_grain * storage=gr_anm_cherryb1a,gr_anm_cherryb2a,gr_anm_cherryb3a,gr_anm_cherryb4a num=50 type=sakura arrange=%arrange|true][endmacro]
[macro name="env_leaf"][start_grain * storage=gr_leaf num=20 type=leaf arrange=%arrange|true][endmacro]
[macro name="env_ash"][start_grain * storage=gr_ash_0,gr_ash_1 num=20 type=leaf arrange=%arrange|true][endmacro]
[macro name="env_snow"][start_grain * storage=gr_snow_0,gr_snow_1,gr_snow_2,gr_snow_3,gr_snow_4 num=100 type=snow arrange=%arrange|true][endmacro]
[macro name="env_bubble"][start_grain * storage=gr_bubble_1,gr_bubble_2,gr_bubble_3 num=10 type=bubble arrange=%arrange|true][endmacro]
[macro name="env_tanpopo"][start_grain * storage=gr_anm_dandeliona1,gr_anm_dandeliona2,gr_anm_dandeliona3 num=30 type=dandelion arrange=%arrange|false][endmacro]

[macro name="env_count"][eval exp="global.grain_object.changeNum(mp.num)"][endmacro]
[macro name="env_stop"][eval exp="global.grain_object.stopGrain()"][endmacro]

@return
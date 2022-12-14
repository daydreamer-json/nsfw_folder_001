@if exp="typeof(global.move_effect_object) == 'undefined'"
@iscript

/*
	画像の拡大縮小直線移動曲線移動回転ボックスブラー・擬似モーションブラー
	それら複数を同時に実行するプラグイン
*/

class MoveEffectPlugin extends KAGPlugin
{
	// このプラグインの管理番号
	var obj_no=0;						// object番号

	var test;
	
	//構成レイヤ
	var tempLayer;						// 画像レイヤー
	var tempLayer2;						// 裏描画の変更
	var targetLayer;					// 対象レイヤー
	var targetLayerBack;				// 対象裏レイヤー
	
	//確認用フラグ
	var moving = false;					// 動作中かどうか
	var alive = false;					// レイヤー類が生きてるかどうか
	var loop = false;					// ループするか
	var loopCount;

	//初期設定
	var size;							// 総合サイズを配列記録する
	var xsize,ysize;					// 縦横サイズを配列記録する
	
	//基本動作系
	var path;							// パスの作業用
	var time;							// ひとつのパスを通る時間
	var accel;							// 加速度的な動きを行うか
	var moveStyle;						// 移動位置計算用関数
	var moveFunc;						// 拡大処理用関数
	var clear;							// レイヤをクリアするかどうか
	var page;							// ページ裏表
	var pathtype;						// パスの方式
	var lu_corner;						// パスの方式・左上隅指定
	var spaccel;						// 特殊な加減速
	var totalTime;						// 総合時間
	var lasttick=0;						// 前回の描画時間
	var starttick;						// 描画開始時間
	var affintype;						// アフィン変換の方式

	var l;
	var	t;
	var	o;
	var ol = 0;
	var ot = 0;
	var oo = 0;
	// 演算用配列
	var zx = [];						// スプラインワーク
	var zy = [];						// スプラインワーク

	// 演算用
	var scWidth;
	var scHeight;
	var scWidthHalf;
	var scHeightHalf;
	var imageWidthHalf;					// 対象レイヤーの幅の半分
	var imageHeightHalf;				// 対象レイヤーの高さの半分

	// セーブ・ロード用パラメータ記録配列
	var storeDic = %[];					// ここに格納したものがセーブデータとして格納
	
	// トランジション動作系
	var deleteAfterTransFlag = false;	// トランジション後に消去フラグ
	var showAfterTransFlag = false;		// トランジション後に全部表示フラグ

	// このプラグインが使われたレイヤーの表と裏の管理
	var foreState = false;				// targetLayerの表示状況
	var backState = false;				// targetLayerBackの表示状況

	var gl_l,gl_t;						//演算処理用の左上座標
	
	//出現関係
	var delay = 0;						// 何ミリ秒遅れて開始されるかの値
	var subflag;						// 描画するか否か
	
	var replacement;					//
	var ImageReload;					//画像の再読み込みを行うか否か
	
	//スタック処理用
	var stack = [];						//スタック処理の配列【内容：辞書配列】
	var StackCount = 0;					//スタック配列の現在使用番号
	var StackLoop = false;				//スタック処理のループフラグ


	//特殊効果系
	var AffectLayer;					//
	var AffectLayerBack;				//
	
	//特殊効果系
	var RideOpacity;					//基本不透明度
	var RideMode;
	var RidePosX;						//
	var RidePosY;						//
	
	var RideTemp;						//

	var RideObj;						//
	
	var RideLayer;						//
	var RideLayerBack;					//
	var RideFlag;						//

	var CoverAlpha;				//
	var CoverOpacity;					//基本不透明度
	var CoverPosX;						//
	var CoverPosY;						//
	var CoverLayer;						//
	var CoverLayerBack;					//
	var CoverFlag;						//

	var ozx = [];						// スプラインワーク
	var ozy = [];						// スプラインワーク
	var OffsetSpline;					//
	var OffsetAccel;					//
	var OffsetSpAccel;					//
	var OffsetPath;						//
	var Offsettime;						//
	var OffsettotalTime;				//
	var Offsettick=0;					// 前回の描画時間
	var Offsetlasttick=0;				// 前回の描画時間
	var Offsetstarttick;				// 描画開始時間
	var Offsetloop;						// 連続再生
	var OffsetloopCount;				// 連続再生
	
	function MoveEffectPlugin(window, no)
	{
		obj_no = no;													//自身のオブジェクト番号を格納
		super.KAGPlugin();												//継承したKAGPluginクラスの初期化
		this.window = window;											//自身の管理ウインドウの格納
		
		// 最初にレイヤー確保
		tempLayer = new CharacterLayer(window, kag.fore.base);			//
		tempLayer.owner = this;											//
		tempLayer.visible = false;										//
		
		targetLayer = new CharacterLayer(window, kag.fore.base);		//
		targetLayerBack = new CharacterLayer(window, kag.back.base);	//

		AffectLayer = new Layer(window, kag.fore.base);
		AffectLayerBack = new Layer(window, kag.back.base);
		
		RideTemp = new Layer(window, kag.fore.base);					//
		RideLayer = new Layer(window, kag.fore.base);					//
		RideLayerBack = new Layer(window, kag.back.base);				//
		
		CoverLayer = new Layer(window, kag.fore.base);					//
		CoverLayerBack = new Layer(window, kag.back.base);				//
		
		// 念のために実体化
		moveStyle = LinearMover;										//

		//配列
		CoverAlpha = new ParamsArray(255);						//初期値は、1

		this.scWidth = window.scWidth;
		this.scHeight = window.scHeight;
		scWidthHalf = this.scWidth \ 2;
		scHeightHalf = this.scHeight \ 2;
	}

	function finalize()
	{
		// 一応止めて所持オブジェクト破棄
		stop();										//動作の停止
		ClearStack();								//溜め込んだスタックの辞書配列を開放
		clearLayer();								//レイヤーの初期化
		deleteLayer();								//実体化したレイヤーの開放
		super.finalize(...);						//継承したクラスの終了処理
		invalidate CoverAlpha;
	}

	function DeleteObject()
	{
		deleteAfterTransFlag = true;
		targetLayerBack.visible = false;
		CoverLayerBack.visible = false;
		RideLayerBack.visible = false;
	}
	
	function DeleteObjectNow()
	{
		finish();
		clearLayer();
	}
	
	function startEffect(elm)
	{

		test = false;
		if(elm.test == "true"){test = true;}
		
		
		// 辞書配列をセーブ・ロード用に退避
		(Dictionary.assign incontextof storeDic)(elm);
		
		//ロード時の呼び出しの不具合の対処
		var endflag = false;
		if(elm.time <= 1){
			elm.time=100;
			endflag = true;
		}
		
		// ループするか？
		this.loop = elm.loop == "true" ? true : false;						//ループフラグ
		this.loopCount = elm.loopcount !== void ? +elm.loopcount : -1;		//ループ回数
		
		//一応初期化と確認項目
		if(this.loopCount == 0){
			elm.time = 0;												//【一度もループしない】なので動作の停止
			this.loop = false;											//ループフラグをオフ
		}else if(this.loopCount != -1) this.loopCount--;				//カウントダウン方式を取る


		this.Offsetloop = elm.offsetloop == "true" ? true : false;							//ループフラグ
		this.OffsetloopCount = elm.offsetloopcount !== void ? +elm.offsetloopcount : -1;	//ループ回数
		
		//一応初期化と確認項目
		if(this.OffsetloopCount == 0){
			elm.Offsettime = 0;											//【一度もループしない】なので動作の停止
			this.OffsetloopCount = false;								//ループフラグをオフ
		}else if(this.OffsetloopCount != -1) this.OffsetloopCount--;	//カウントダウン方式を取る
		
		if(elm.page == "fore"){
			foreState = true;										//前表示
			backState = false;										//後非表示
		}else if(elm.page == "back"){
			foreState = false;										//前非表示
			backState = true;										//後表示
		}else{
			foreState = true;										//前表示
			backState = true;										//後表示
		}
		
		//このエフェクトを他のエフェクトの補助に使う場合
		if(elm.sub !== "true"){
			subflag = false;										//サブフラグをオフ
		}else{
			subflag = true;											//サブフラグをオン
			backState = foreState = false;							//完全非表示
		}

		//画像描画タイプ
		this.pathtype = elm.pathtype == "true" ? true : false;		// 画面中央型かレイヤ中心型
		this.lu_corner = elm.lu_corner == "true" ? true : false;	// 左上座標点か
		deleteAfterTransFlag = elm.delete=="true" ? true : false;	// トランジション後削除のフラグ
		showAfterTransFlag = elm.show=="true" ? true : false;		// トランジション後表裏表示フラグ
		
		// 既存の動作を停止
		stop();
		
		/*画像の読み込み前に画像効果の部分を終わらせる*/

		elm.endflag = endflag;
		{
			var tmp = new CharacterLayer(window, kag.fore.base);			//
			tmp.loadImages(%[storage:elm.storage]);

			var AffineLayer = new CharacterLayer(window, kag.fore.base);			//
			AffineLayer.setSizeToImageSize();
			
			/*まず拡大処理を行う*/
			
			var affintype = stFastLinear;
			clear = elm.clear == 'false' ? false : true;
			
			var r = (elm.rad !== void) ? +elm.rad * (Math.PI/180) * -1 : 0;
			var s = (elm.size !== void) ? +elm.size : 1;
			var s_x = (elm.xsize !== void) ? +elm.xsize : 1;
			var s_y = (elm.ysize !== void) ? +elm.ysize : 1;
			var rc = Math.cos(r);
			var rs = Math.cos((Math.PI/2.0) - r);
			var c_x = 0.5 * tmp.imageWidth;
			var c_y = 0.5 * tmp.imageHeight;
			
			dm("s_x:"+s_x);
			dm("s_y:"+s_y);
			
			var m00 = s * rc * s_x;
			var m01 = s * -rs * s_x;
			var m10 = s * rs * s_y;
			var m11 = s * rc * s_y;

			var tiwh = tmp.imageWidth\2;
			var tihh = tmp.imageHeight\2; 
			
			var ix00 = (int)(Math.abs(-tiwh * m00 + tihh * m01));
			var iy00 = (int)(Math.abs(-tiwh * m10 + tihh * m11));
			
			var ix01 = (int)(Math.abs(tiwh * m00 + tihh * m01));
			var iy01 = (int)(Math.abs(tiwh * m10 + tihh * m11));
			
			var ix10 = (int)(Math.abs(-tiwh * m00 + -tihh * m01));
			var iy10 = (int)(Math.abs(-tiwh * m10 + -tihh * m11));
			
			var ix11 = (int)(Math.abs(tiwh * m00 + -tihh * m01));
			var iy11 = (int)(Math.abs(tiwh * m10 + -tihh * m11));

			var max_w = ix00;
			if(max_w <= ix01){max_w = ix01;}
			if(max_w <= ix10){max_w = ix10;}
			if(max_w <= ix11){max_w = ix11;}

			var max_h = iy00;
			if(max_h <= iy01){max_h = iy01;}
			if(max_h <= iy10){max_h = iy10;}
			if(max_h <= iy11){max_h = iy11;}

			var mtx = ((m00*-c_x) + (m10*-c_y) + max_w);
			var mty = ((m01*-c_x) + (m11*-c_y) + max_h);

			dm("mtx:"+mtx);
			dm("mty:"+mty);
			
			AffineLayer.setImageSize(max_w*2,max_h*2);
			AffineLayer.setSizeToImageSize();
			AffineLayer.affineCopy(tmp, 0, 0, tmp.imageWidth, tmp.imageHeight, true, m00, m01, m10, m11, mtx, mty, affintype, clear);

			if(tmp.anmStorage != "" && tmp.anmInfo.count != 0){
				
				AffineLayer.anmLayer = new EyeAnimationLayer(kag, AffineLayer);
				AffineLayer.anmLayer.hitType = htMask;
				AffineLayer.anmLayer.hitThreshold = 256;
				
				var anm_cnt = tmp.anmLayer.imageWidth \ tmp.anmLayer.width;
				
				var ac_x = 0.5 * tmp.anmLayer.width;
				var ac_y = 0.5 * tmp.anmLayer.height;
				
				var am00 = s * rc * s_x;
				var am01 = s * -rs * s_x;
				var am10 = s * rs * s_y;
				var am11 = s * rc * s_y;
				
				//特殊処理
				var atiwh = tmp.anmLayer.width\2;
				var atihh = tmp.anmLayer.height\2;
				
				var aix00 = (int)(Math.abs(-atiwh * am00 + atihh * am01));
				var aiy00 = (int)(Math.abs(-atiwh * am10 + atihh * am11));
				
				var aix01 = (int)(Math.abs(atiwh * am00 + atihh * am01));
				var aiy01 = (int)(Math.abs(atiwh * am10 + atihh * am11));
				
				var aix10 = (int)(Math.abs(-atiwh * am00 + -atihh * am01));
				var aiy10 = (int)(Math.abs(-atiwh * am10 + -atihh * am11));
				
				var aix11 = (int)(Math.abs(atiwh * am00 + -atihh * am01));
				var aiy11 = (int)(Math.abs(atiwh * am10 + -atihh * am11));

				var amax_w = aix00;
				if(amax_w <= aix01){amax_w = aix01;}
				if(amax_w <= aix10){amax_w = aix10;}
				if(amax_w <= aix11){amax_w = aix11;}
				var amax_h = aiy00;
				if(amax_h <= aiy01){amax_h = aiy01;}
				if(amax_h <= aiy10){amax_h = aiy10;}
				if(amax_h <= aiy11){amax_h = aiy11;}

				AffineLayer.anmLayer.setImageSize(amax_w * 2 * anm_cnt,amax_h * 2);
				
				for(var i=0;i<anm_cnt;i++){
					AffineLayer.anmLayer.affineCopy(
					tmp.anmLayer, tmp.anmLayer.width*i, 0, tmp.anmLayer.width, tmp.anmLayer.height, true,
					m00, m01, m10, m11, mtx, mty, affintype, clear
					);
				}

				AffineLayer.anmStorage = tmp.anmStorage;
				AffineLayer.anmLayer.assign(tmp.anmLayer);
				AffineLayer.anmInfo.assign(tmp.anmInfo);
				AffineLayer.anmLayer.imageLeft = 0;
				AffineLayer.anmLayer.setPos(AffineLayer.anmInfo[1], AffineLayer.anmInfo[2]);
				AffineLayer.anmLayer.width = amax_w;
				AffineLayer.anmLayer.height = amax_h;
				AffineLayer.anmLayer.visible = tmp.anmLayer.visible;
			}else{
				AffineLayer.anmStorage = "";
				AffineLayer.anmInfo.clear();
			}

			
			//dm("AffineLayer.anmLayer:"+AffineLayer.anmLayer);
			tempLayer.assignImages(AffineLayer);
			tempLayer.setSizeToImageSize();
			//dm("tempLayer.anmLayer:"+tempLayer.anmLayer);
			
			invalidate AffineLayer;
			invalidate tmp;
		}
		
		AccompanyEffect(elm);
		
		//---------------------------
		// 対象レイヤーを設定
		//---------------------------

		//ターゲットレイヤの初期化
		targetLayer.setPos(0, 0);					//
		targetLayer.hitType = htMask;				//
		targetLayer.hitThreshold = 256;				//
		targetLayerBack.setPos(0, 0);
		targetLayerBack.hitType = htMask;
		targetLayerBack.hitThreshold = 256;

		//輝度レイヤ
		AffectLayer.setPos(0, 0);				//
		AffectLayer.hitType = htMask;			//
		AffectLayer.hitThreshold = 256;			//
		AffectLayer.visible = false;
		AffectLayerBack.setPos(0, 0);
		AffectLayerBack.hitType = htMask;		//
		AffectLayerBack.hitThreshold = 256;		//
		AffectLayerBack.visible = false;
		
		//エフェクトレイヤの初期化
		CoverLayer.hitType = htMask;
		CoverLayer.hitThreshold = 256;
		CoverLayerBack.hitType = htMask;
		CoverLayerBack.hitThreshold = 256;

		//ライドレイヤの初期化
		RideTemp.hitType = htMask;
		RideTemp.hitThreshold = 256;
		RideLayer.hitType = htMask;
		RideLayer.hitThreshold = 256;
		RideLayerBack.hitType = htMask;
		RideLayerBack.hitThreshold = 256;

		targetLayer.assignImages(tempLayer);
		targetLayer.setSizeToImageSize();
		targetLayerBack.assignImages(targetLayer);
		targetLayerBack.setSizeToImageSize();

		CoverPosX = 0;
		CoverPosY = 0;

		if(elm.bbcover !== void){
			CoverFlag = true;
			CoverLayer.visible = foreState;
			CoverLayerBack.visible = backState;
			
			var CoverOption = [].split("(), ", elm.bbcover, , true);	//	(x, y, extend, sq, mode)
			
			CoverOpacity = 255;
			if(CoverOption[2] !== void) CoverOpacity = +CoverOption[2];
			CoverLayer.opacity = CoverLayerBack.opacity = CoverOpacity;
			
			var bbe = false;
			bbe = (CoverOption[3] !== void) ? +CoverOption[3] : bbe;
			
			var bbsq = false;
			bbsq = (CoverOption[4] !== void) ? +CoverOption[4] : bbsq;
			
			if(bbe){
				CoverPosX = +CoverOption[0];
				CoverPosY = +CoverOption[1];
				
				if(bbsq){
					CoverPosX = CoverPosX * 2;
					CoverPosY = CoverPosY * 2;
				}
				
				CoverLayer.setImageSize(tempLayer.imageWidth+CoverPosX*2,tempLayer.imageHeight+CoverPosY*2);
				CoverLayer.copyRect(CoverPosX,CoverPosY,tempLayer,0,0,tempLayer.imageWidth,tempLayer.imageHeight);
				CoverLayer.setSizeToImageSize();
				
				CoverLayer.doBoxBlur(+CoverOption[0],+CoverOption[1]);
				if(bbsq) CoverLayer.doBoxBlur(+CoverOption[0],+CoverOption[1]);
			}else{
				CoverLayer.assignImages(tempLayer);
				CoverLayer.setSizeToImageSize();
				CoverLayer.doBoxBlur(+CoverOption[0],+CoverOption[1]);
				if(bbsq) CoverLayer.doBoxBlur(+CoverOption[0],+CoverOption[1]);
			}
			
			CoverLayerBack.assignImages(CoverLayer);
			CoverLayerBack.setSizeToImageSize();
			
			var CoverMode = ltAlpha;
			if(CoverOption[5] !== void) CoverMode = imageTagLayerType[CoverOption[5]].type;
			CoverLayer.type = CoverMode;
			CoverLayerBack.type = CoverMode;
			
			CoverOption.clear();
			
		}else if(elm.cover !== void){
			CoverFlag = true;
			CoverLayer.visible = foreState;
			CoverLayerBack.visible = backState;
			
			var CoverOption = [].split("(), ", elm.cover, , true);
			/*描画処理*/
			CoverLayer.assignImages(tempLayer);
			CoverLayer.setSizeToImageSize();
			CoverLayer.AlphaColorRect(+CoverOption[0], +CoverOption[1], +CoverOption[2]);
			CoverLayerBack.assignImages(CoverLayer);
			CoverLayerBack.setSizeToImageSize();
			
			CoverOpacity = +CoverOption[3];
			CoverLayer.opacity = CoverLayerBack.opacity = CoverOpacity;

			var CoverMode = ltAlpha;
			if(CoverOption[4] !== void) CoverMode = imageTagLayerType[CoverOption[4]].type;
			CoverLayer.type = CoverMode;
			CoverLayerBack.type = CoverMode;
			
			CoverOption.clear();
			
		}else{
			CoverOpacity = 0;
			CoverLayer.opacity = CoverLayerBack.opacity = CoverOpacity;
			CoverFlag = false;
			CoverLayer.visible = CoverLayerBack.visible = false;
		}

		//輝度モード
		if(elm.luminance == "true"){
			var tmp = new Layer(window, kag.fore.base);
			tmp.setImageSize(targetLayer.imageWidth,targetLayer.imageHeight);
			tmp.setSizeToImageSize();
			tmp.LuminanceForAlpha(targetLayer);
			
			AffectLayer.assignImages(targetLayer);
			AffectLayer.MaskRect(0, 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight, 3);
			AffectLayer.setSizeToImageSize();
			AffectLayerBack.assignImages(AffectLayer);
			AffectLayerBack.setSizeToImageSize();
			invalidate tmp;
		}else if(elm.affect !== void){
			AffectLayer.assignImages(tempLayer);
			AffectLayer.setSizeToImageSize();
			var AffectOption = [].split("(), ", elm.affect, , true);
			var tmp = new Layer(window, kag.fore.base);
			tmp.loadImages(AffectOption[0]);
			tmp.setSizeToImageSize();
			
			var s = (elm.size !== void) ? +elm.size : 1;
			var s_x = (elm.xsize !== void) ? +elm.xsize : 1;
			var s_y = (elm.ysize !== void) ? +elm.ysize : 1;
			
			s_x = s * s_x;
			s_y = s * s_y;
			
			if(s_x != 1 || s_y != 1){
				AffectLayerBack.setImageSize(tmp.imageWidth*s_x,tmp.imageHeight*s_y);
				AffectLayerBack.setSizeToImageSize();
				AffectLayerBack.fillRect(0,0,AffectLayerBack.imageWidth,AffectLayerBack.imageHeight,0x0);
				AffectLayerBack.stretchCopy(0,0,AffectLayerBack.imageWidth,AffectLayerBack.imageHeight,tmp,0,0,tmp.imageWidth,tmp.imageHeight,stNearest);
				tmp.assignImages(AffectLayerBack);
				tmp.setSizeToImageSize();
			}

			var apx = (+AffectOption[1] !== void) ? +AffectOption[1] : 0;
			var apy = (+AffectOption[2] !== void) ? +AffectOption[2] : 0;
			
			//移動したピクセル数
			var acx = apx - scWidthHalf;
			var acy = apy - scHeightHalf;

			acx = acx * s_x;
			acy = acy * s_y;

			var tcx = acx + (targetLayer.width \ 2) - (tmp.imageWidth \ 2);
			var tcy = acy + (targetLayer.height \ 2) - (tmp.imageHeight \ 2);
			
			
			/*一時的にバックレイヤを演算用に使う*/
			AffectLayerBack.setImageSize(targetLayer.imageWidth,targetLayer.imageHeight);
			AffectLayerBack.fillRect(0,0,AffectLayerBack.imageWidth,AffectLayerBack.imageHeight,0x0);
			AffectLayerBack.copyRect(tcx, tcy, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight);
			AffectLayer.assignImages(tempLayer);
			
			AffectLayer.MaskRect(0, 0, AffectLayerBack, 0, 0, AffectLayerBack.imageWidth, AffectLayerBack.imageHeight, 3);
			AffectLayer.setSizeToImageSize();

			if(elm.testarea !== void){
				AffectLayer.AlphaColorRect(0, 0, 255);			//彩色の変更を実行
				AffectLayer.visible=true;
				AffectLayer.absolute=200000;
				AffectLayerBack.visible=true;
				AffectLayerBack.absolute=200000;
			}
			
			
			/*仮ソース*/
			
			AffectLayerBack.assignImages(AffectLayer);
			AffectLayerBack.setSizeToImageSize();
			
			invalidate tmp;
			
		}else{
			AffectLayer.assignImages(tempLayer);
			AffectLayer.setSizeToImageSize();
			AffectLayerBack.assignImages(AffectLayer);
			AffectLayerBack.setSizeToImageSize();
		}

		CoverAlpha.ArrayForParams(elm.coveralpha);		// サイズ変化を配列化
		
		RidePosX = 0;
		RidePosY = 0;
		
		if(elm.ride !== void){
			RideFlag = true;
			RideLayer.visible = foreState;
			RideLayerBack.visible = backState;
			
			/*描画処理*/
			var inflag = false;
			var outflag = false;
			
			/*描画処理*/
			var oix = (elm.oix !== void) ? +elm.oix:0;
			var oiy = (elm.oiy !== void) ? +elm.oiy:0;
			var oox = (elm.oox !== void) ? +elm.oox:0;
			var ooy = (elm.ooy !== void) ? +elm.ooy:0;
			
			RidePosX = oox;
			RidePosY = ooy;
			
			if(oix != 0 || oiy != 0) inflag = true;
			else inflag = false;
			
			if(oox != 0 || ooy != 0) outflag = true;
			else outflag = false;
			
			if(inflag || outflag){
				//ボカシ用の画面拡張
				var edgeLayer = new Layer(window,kag.fore.base);
				var tmp = new global.Layer(kag, kag.fore.base);
				var tmp2 = new global.Layer(kag, kag.fore.base);
				
				edgeLayer.setImageSize(tempLayer.imageWidth+(oox*2), tempLayer.imageHeight+(ooy*2));
				edgeLayer.setSizeToImageSize();
				edgeLayer.fillRect(0,0,edgeLayer.imageWidth,edgeLayer.imageHeight,0x0);
				edgeLayer.copyRect(oox,ooy,tempLayer,0,0,tempLayer.imageWidth,tempLayer.imageHeight);
				
				tmp2.assignImages(edgeLayer);
				tmp2.setSizeToImageSize();
				
				if(inflag){
					tmp.assignImages(edgeLayer);
					tmp.setSizeToImageSize();
					tmp.turnAlpha();
					edgeLayer.doBoxBlur(oix, oix);
					edgeLayer.operateRect(0, 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight, omAuto, 255);
					edgeLayer.turnAlpha();
					tmp.assignImages(edgeLayer);
					tmp.setSizeToImageSize();
				}
				
				if(outflag){
					if(inflag){
						edgeLayer.assignImages(tmp2);
						edgeLayer.setSizeToImageSize();
					}
					edgeLayer.turnAlpha();
					edgeLayer.doBoxBlur(oox, ooy);
					edgeLayer.operateRect(0, 0, tmp2, 0, 0, tmp2.imageWidth, tmp2.imageHeight, omAuto, 255);
					edgeLayer.turnAlpha();
				}
				
				if(inflag && outflag){
					edgeLayer.operateRect(0, 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight, omAuto, 255);
				}

				edgeLayer.AlphaColorRect(255, 255, 255);
				RideTemp.assignImages(edgeLayer);
				RideTemp.setSizeToImageSize();
				RideLayer.assignImages(RideTemp);
				
				RideLayer.setSizeToImageSize();
				RideLayerBack.assignImages(RideLayer);
				RideLayerBack.setSizeToImageSize();
				
				RideMode = ltAlpha;
				if(elm.ridemode !== void) RideMode = imageTagLayerType[elm.ridemode].type;
				
				RideLayer.type = RideMode;
				RideLayerBack.type = RideMode;
				
				invalidate tmp;
				invalidate tmp2;
				invalidate edgeLayer;


				RideObj = void;
				if(elm.ride !== void){
					RideObj = move_effect_object[+elm.ride].AffectLayer;
				}else{
					RideObj = move_effect_object[0].AffectLayer;
				}
				
			}
			
			RideOpacity = 255;
			RideLayer.opacity = RideLayerBack.opacity = RideOpacity;
		}else{
			RideOpacity = 0;
			RideLayer.opacity = RideLayerBack.opacity = RideOpacity;
			RideFlag = false;
			RideLayer.visible = RideLayerBack.visible = false;
		}
		
		//---------------------------
		// 他パラメーター設定
		//---------------------------
		
		// よく使うからとりあえず計算済みのものを。
		imageWidthHalf = tempLayer.imageWidth / 2;
		imageHeightHalf = tempLayer.imageHeight / 2;
		
		targetLayer.type = targetLayerBack.type = ltAlpha;
		if(elm.mode != void){
			// この辞書配列はtjsがはじめから持ってるらしい
			var _type = imageTagLayerType[elm.mode].type;
			if(_type !== void)targetLayer.type = targetLayerBack.type = _type;
		}
		
		// path の分解
		if(elm.path === void){
			path = [
				targetLayer.imageWidth/2,
				targetLayer.imageHeight/2,
				255,
				targetLayer.imageWidth/2,
				targetLayer.imageHeight/2
				,255
				];
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

		if(elm.offsetpath === void){
			OffsetPath = [
				0,0,255,
				0,0,255
				];
		}else{
			this.OffsetPath = [].split("(), ", elm.offsetpath, , true);
			// 文字として受け取っているものを数値に変える。
			for(var i = this.OffsetPath.count-1; i>=0; i--)this.OffsetPath[i] = +this.OffsetPath[i];
		}

		if(this.OffsetPath.count < 4){
			// 1点しか指定されていない場合、2点目にも同じ数値を。
			this.OffsetPath[3]=this.OffsetPath[0];
			this.OffsetPath[4]=this.OffsetPath[1];
			this.OffsetPath[5]=this.OffsetPath[2];
		}

		OffsetSpline = false;
		if(elm.offsetspline == "true"){
			if(this.OffsetPath.count >= 9){
				OffsetSpline = true;
				PreSpline( OffsetPath, ozx, ozy);
			}else{
				si("OffsetPathを3点以上指定してください!!");
			}
		}

		OffsetAccel = (elm.offsetaccel !== void) ? +elm.offsetaccel : 0;
		
		OffsetSpAccel = false;
		if(elm.offsetspaccel == "true"){
			this.OffsetAccel = Math.abs(this.OffsetAccel);
			this.OffsetSpAccel = true;
		}else this.OffsetSpAccel = false;
		
		
		// 時間設定
		this.time = elm.time !== void ? +elm.time : 1000;
		if(this.time<=1)this.time = 1;

		this.Offsettime = elm.offsettime !== void ? +elm.offsettime : 1000;
		if(this.Offsettime<=1)this.Offsettime = 1;
		
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;
		
		// 全体時間を計算
		OffsettotalTime = (this.OffsetPath.count \ 3 - 1) * Offsettime;

		// 配列時間を計算
		CoverAlpha.TimeForParams(totalTime);				// サイズ用の時間を計算
		
		// 加速度設定
		this.accel = elm.accel !== void ? +elm.accel : 0;
		// 特殊な加速を使うか？（減速→加速）
		if(elm.spaccel == "true"){
			this.accel = Math.abs(this.accel);
			this.spaccel = true;
		}else this.spaccel = false;
		
		// レイヤー表示タイプが不透明・もしくは透明だった場合アフィン変換のタイプを精度の高いものへ
		
		//アフィン変換を最速へ
		affintype = stFastLinear;

		// アフィン中に周りをクリアするかどうか
		this.clear = elm.clear == 'false' ? false : true;

		// 移動位置計算関数の設定
		if(elm.spline == 'true'){
			PreSpline( path, zx, zy);
			moveStyle = SplineMover;
		}else moveStyle = LinearMover;
		
		moveFunc = moveAt;
		
		// ディレイ設定
		if(elm.delay !== void){
			delay = +elm.delay;
			targetLayer.fillRect(0,0,targetLayer.imageWidth,targetLayer.imageHeight,0x0);
			targetLayerBack.assignImages(targetLayer);
		}else delay = 0;

		if(elm.absolute !== void){
			targetLayer.absolute = +elm.absolute;
			
		}else{
			targetLayer.absolute = 15000 + obj_no;
		}
		
		targetLayerBack.absolute = targetLayer.absolute;
		CoverLayerBack.absolute = CoverLayer.absolute = targetLayer.absolute + 1;
		RideLayerBack.absolute = RideLayer.absolute = targetLayer.absolute + 2;
		
		// 時間が一秒未満だった場合即終了
		if(endflag){
			finish();
			targetLayer.visible = foreState;
			targetLayerBack.visible = backState;
			alive = true;
			moving = false;
			return;
		}
		
		// 初期位置に表示
		if(delay == 0){
			moveStyle(0,0);
			targetLayer.visible = foreState;
			targetLayerBack.visible = backState;
		}
		
		// 開始
		lasttick = starttick = System.getTickCount();
		Offsetlasttick = Offsetstarttick = lasttick;
		
		System.addContinuousHandler(continuousHandler);
		moving = true;
		alive = true;
	}
	
	function moveAt(l,t,o,tick)
	{
		// アフィン変換転送
		//targetLayer.assignImages(tempLayer);
		//targetLayer.setSizeToImageSize();
		
		//targetLayerBack.assignImages(targetLayer);
		//targetLayerBack.setSizeToImageSize();
		targetLayer.opacity = targetLayerBack.opacity = o;
		targetLayer.setPos(l,t);
		targetLayerBack.setPos(l,t);

		var op = targetLayer.opacity / 255;

		AffectLayer.setPos(l,t);
		AffectLayerBack.setPos(l,t);
		
		if(CoverFlag){
			var ca = CoverAlpha.GetNowParams(tick) / 255;
			CoverLayer.setPos(l-CoverPosX,t-CoverPosY);
			CoverLayerBack.setPos(l-CoverPosX,t-CoverPosY);
			CoverLayer.opacity = CoverLayerBack.opacity = CoverOpacity * op * ca;
		}
		
		if(RideFlag){
			/*
			RideLayer.assignImages(RideObj);
			RideLayer.setSizeToImageSize();
			RideLayer.setPos(RideObj.left,RideObj.top);
			
			var sx = (l - RidePosX) - RideLayer.left;
			var sw = RideObj.imageWidth;
			var dx = 0;
			var dw = RideTemp.width;
			
			var sy = (t - RidePosY) - RideLayer.top;
			var sh = RideObj.imageHeight;
			var dy = 0;
			var dh = RideTemp.height;
			
			if(sx + dw > sw){
				var mw = sw - (sx + dw);
				dw += mw;
			}
			
			if(sy + dh > sh){
				var mh = sh - (sy + dh);
				dh += mh;
			}
			
			RideLayer.ExMaskRect2( sx, sy, RideTemp, dx, dy, dw, dh, 3);
			
			RideLayerBack.assignImages(RideLayer);
			RideLayerBack.setSizeToImageSize();
			*/

			RideLayer.setPos(l-RidePosX,t-RidePosY);
			RideLayerBack.setPos(l-RidePosX,t-RidePosY);
			RideLayer.opacity = RideLayerBack.opacity = RideOpacity * op;
			
			//演算処理
			var rl = RideObj.left - RideLayer.left;
			var rt = RideObj.top - RideLayer.top;
			
			RideLayer.copyRect(rl,rt,RideObj,0,0,RideObj.imageWidth,RideObj.imageHeight);
			//RideLayer.MaskRect(0, 0, RideTemp, 0, 0, RideTemp.imageWidth, RideTemp.imageHeight, 3);
			RideLayer.ExMaskRect2(0, 0, RideTemp, 0, 0, RideTemp.imageWidth, RideTemp.imageHeight, 3);

			if(test){ tempLayer.AlphaColorRect(0, 255, 0);}			//彩色の変更を実行;
			RideLayer.type = RideMode;
			RideLayerBack.assignImages(RideLayer);
			RideLayerBack.type = RideMode;
		}
	}
	
	
	function BeforeHandle(tick){}
	function AfterHandle(tick){}
	
	function AccompanyEffect(elm){

		var bbx = (elm.bbx !== void) ? +elm.bbx : 0;
		var bby = (elm.bby !== void) ? +elm.bby : 0;

		if(bbx != 0 || bby != 0){
			if(elm.bblur_extend == "true"){
				var bbx_m = (elm.bblur_sq == "true") ? bbx*2:bbx;
				var bby_m = (elm.bblur_sq == "true") ? bby*2:bby;
				
				var BBLayer = new KAGLayer(window, kag.fore.base);
				BBLayer.setImageSize(tempLayer.imageWidth+bbx_m*2,tempLayer.imageHeight+bby_m*2);
				BBLayer.copyRect(bbx_m,bby_m,tempLayer,0,0,tempLayer.imageWidth,tempLayer.imageHeight);
				tempLayer.assignImages(BBLayer);
				tempLayer.setSizeToImageSize();
				invalidate BBLayer;
			}
			
			tempLayer.doBoxBlur(bbx,bby);
			if(elm.bblur_sq == "true") tempLayer.doBoxBlur(bbx,bby);
		}
		
		if(elm.fliplr == "true") tempLayer.flipLR();
		if(elm.flipud == "true") tempLayer.flipUD();
		
		var r_g = (elm.rgamma !== void) ? +elm.rgamma : 1.0;
		var g_g = (elm.ggamma !== void) ? +elm.ggamma : 1.0;
		var b_g = (elm.bgamma !== void) ? +elm.bgamma : 1.0;
		var r_f = (elm.rfloor !== void) ? +elm.rfloor : 0;
		var g_f = (elm.gfloor !== void) ? +elm.gfloor : 0;
		var b_f = (elm.bfloor !== void) ? +elm.bfloor : 0;
		var r_c = (elm.rceil !== void) ? +elm.rceil : 255;
		var g_c = (elm.gceil !== void) ? +elm.gceil : 255;
		var b_c = (elm.bceil !== void) ? +elm.bceil : 255;
		
		//色調の変更
		if(elm.grayscale == "true"){
			tempLayer.doGrayScale();
		}
		if(elm.sepia == "true"){
			tempLayer.doGrayScale();
			r_g = 1.3;
			g_g = 1.1;
			b_g = 1.0;
		}
		
		if(elm.turn == "true"){
			tempLayer.adjustGamma(r_g, r_c, r_f, g_g, g_c, g_f, b_g, b_c, b_f);
		}else{
			tempLayer.adjustGamma(r_g, r_f, r_c, g_g, g_f, g_c, b_g, b_f, b_c);
		}
		
		if(elm.correct == "true" && sysCharCorrect == true){
			doCharacterCorrect(tempLayer);
		}
	}
	
	function LinearMover(tick,otick)
	{
		
		/*セットポス*/
		/*添付のサイズから座標を計算*/
		
		BeforeHandle(tick);

		if(tick < totalTime){
			// 経過秒数 \ 一点を通過するための時間 * 3
			var index = tick \ time * 3;
			// 経過秒数 % 一点を通過するための時間 / 一点を通過するための秒数
			var ratio = tick % time / time;

			var p = path;
			var sx = p[index];
			var sy = p[index+1];
			var so = p[index+2];
			var ex = p[index+3];
			var ey = p[index+4];
			var eo = p[index+5];
			
			// 現在位置を計算
			l = ((ex-sx)*ratio + sx) - imageWidthHalf;
			t = ((ey-sy)*ratio + sy) - imageHeightHalf;
			
			// 唐突に不透明度を変更するための処理。必要であれば。
			
			o = eo >= 256 ? so : int((eo-so)*ratio + so);
		}else{
			var p = path;
			l = p[p.count-3] - imageWidthHalf;
			t = p[p.count-2] - imageHeightHalf;
			o = p[p.count-1];
		}

		if(Offsettick < OffsettotalTime){
			var offi = otick \ Offsettime * 3;
			var offr = otick % Offsettime / Offsettime;

			var op = OffsetPath;
			var osx = op[offi];
			var osy = op[offi+1];
			var oso = op[offi+2];
			var oex = op[offi+3];
			var oey = op[offi+4];
			var oeo = op[offi+5];
				
			if(!OffsetSpline){
				ol = ((oex-osx) * offr + osx);
				ot = ((oey-osy) * offr + osy);
			}else{
				var offpi = offi;
				offi = offpi \ 3;
				
				ol = (((ozx[offi+1] - ozx[offi])*offr + ozx[offi]*3)*offr +
					((op[offpi + 3] - op[offpi]) - (ozx[offi]*2 + ozx[offi+1]))) * offr +
					op[offpi];

				ot = (((ozy[offi+1] - ozy[offi])*offr + ozy[offi]*3)*offr +
						((op[offpi + 4] - op[offpi+1]) - (ozy[offi]*2 + ozy[offi+1]))) * offr +
						op[offpi+1];
			}

			oo = (oeo >= 256 ? oso : int((oeo-oso)*offr + oso)) / 255;
		}else{
			var op = OffsetPath;
			ol = op[op.count-3];
			ot = op[op.count-2];
			oo = op[op.count-1] / 255;
		}
		
		l += ol;
		t += ot;
		o *= oo;
		
		// 移動
		moveFunc(l,t,o,tick);
		AfterHandle(tick);
	}

	function SplineMover(tick,otick)
	{
		BeforeHandle(tick);

		if(tick < totalTime){
			var index;
			var pindex = (index = tick \ time) * 3;
			var d = tick % time / time;
			var p = path;
			
			l = (((zx[index+1] - zx[index])*d +
					zx[index]*3)*d +
					((p[pindex + 3] - p[pindex]) -
					(zx[index]*2 + zx[index+1]))) * d +
					p[pindex] - imageWidthHalf;

			t = (((zy[index+1] - zy[index])*d +
					zy[index]*3)*d +
					((p[pindex + 4] - p[pindex+1]) -
					(zy[index]*2 + zy[index+1]))) * d +
					p[pindex+1] - imageHeightHalf;


			var so = p[pindex+2];
			var eo = p[pindex+5];
			o = eo >= 256 ? so : int((eo-so)*d + so);
		}else{
			var p = path;
			l = p[p.count-3] - imageWidthHalf;
			t = p[p.count-2] - imageHeightHalf;
			o = p[p.count-1];
		}

		if(Offsettick < OffsettotalTime){
			var offi = otick \ Offsettime * 3;
			var offr = otick % Offsettime / Offsettime;

			var op = OffsetPath;
			var osx = op[offi];
			var osy = op[offi+1];
			var oso = op[offi+2];
			var oex = op[offi+3];
			var oey = op[offi+4];
			var oeo = op[offi+5];
			
			if(!OffsetSpline){
				ol = ((oex-osx) * offr + osx);
				ot = ((oey-osy) * offr + osy);
			}else{
				var offpi = offi;
				offi = offpi \ 3;
				
				ol = (((ozx[offi+1] - ozx[offi])*offr + ozx[offi]*3)*offr +
					((op[offpi + 3] - op[offpi]) - (ozx[offi]*2 + ozx[offi+1]))) * offr +
					op[offpi];

				ot = (((ozy[offi+1] - ozy[offi])*offr + ozy[offi]*3)*offr +
						((op[offpi + 4] - op[offpi+1]) - (ozy[offi]*2 + ozy[offi+1]))) * offr +
						op[offpi+1];
			}
			
			oo = (oeo >= 256 ? oso : int((oeo-oso)*offr + oso)) / 255;
			
		}else{
			var op = OffsetPath;
			ol = op[op.count-3];
			ot = op[op.count-2];
			oo = op[op.count-1]  / 255;
		}

		l += ol;
		t += ot;
		o *= oo;
		
		// 移動
		moveFunc(l,t,o,tick);
		AfterHandle(tick);
	}
	
	
	/*通常のパスとアニメーションのパス両方に使用できるように編集*/
	function PreSpline( _path, _zx, _zy)
	{
		if(_path.count < 9)
		{
			// 2 点以下 は補完できない
			throw new Exception("3 点以上を指定してください");
		}
		
		// スプライン補間に必要なワークを計算
		var points = _path.count \ 3;
		var tmpx = [], tmpy = [];
		var tx = _zx, ty = _zy;
		tx[0] = 0;
		ty[0] = 0;
		tx[points-1] = 0;
		ty[points-1] = 0;
		
		for(var i = points-2, pi = _path.count-6; i >= 0; i--, pi -= 3)
		{
			tmpx[i+1] = (_path[pi + 3] - _path[pi  ]);
			tmpy[i+1] = (_path[pi + 4] - _path[pi+1]);
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
	
	function reset_totaltime(){
		// 時間設定
		if(this.time<=1)this.time = 1;
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;
	}
	
	function continuousHandler(tick)
	{
		
		// コンソールにfpsを表示する
		//dm("■1loopの所要時間：" + (tick-lasttick));
		//dm("■FPS：" + 1000/(tick-lasttick));
		
		if(delay != 0){
			var t = (tick-starttick);
			if(delay < t){
				delay = 0;
				lasttick = starttick = System.getTickCount();
				moveStyle(0,0);
				targetLayer.visible = foreState;
				targetLayerBack.visible = backState;
			}
			return;
		}
		
		//dm("■FPS：" + 1000/(tick-lasttick));

		Offsettick = tick;
		Offsetlasttick = Offsettick;
		Offsettick -= Offsetstarttick;
		
		if(Offsettick >= OffsettotalTime){
			if(Offsetloop && OffsetloopCount >= 1){
				OffsetloopCount--;
				Offsetstarttick = Offsetstarttick + OffsettotalTime;
				Offsettick = Offsettick - OffsettotalTime;
			}else{
				Offsettick = OffsettotalTime;
			}
		}
		
		lasttick=tick;
		tick -= starttick;
		
		// 時間通りか過ぎてるなら終わる
		if(tick >= totalTime)
		{
			if(loop){
				// もしループフラグが立ってるなら初期値に戻す
				//starttick = System.getTickCount();
				starttick = starttick + totalTime;
				tick = tick - totalTime;
			}else{
				finish();
				return;
			}
		}

		if(spaccel)
		{
			// 減速・加速のセット
			var halfTime = totalTime/2;
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

		if(OffsetSpAccel){
			// 減速・加速のセット
			var halfTime = OffsettotalTime/2;
			if(Offsettick <= halfTime){
				Offsettick = 1.0 - Offsettick / halfTime;
				Offsettick = Math.pow(Offsettick, OffsetAccel);
				Offsettick = int ( (1.0 - Offsettick) * halfTime );
			}else{
				Offsettick -= halfTime;
				Offsettick = Offsettick / halfTime;
				Offsettick = Math.pow(Offsettick, OffsetAccel);
				Offsettick = int ( Offsettick * halfTime );
				Offsettick += halfTime;
			}
		}else if(OffsetAccel < 0){
			// 上弦 ( 最初が動きが早く、徐々に遅くなる )
			Offsettick = 1.0 - Offsettick / OffsettotalTime;
			Offsettick = Math.pow(Offsettick, -OffsetAccel);
			Offsettick = int ( (1.0 - Offsettick) * OffsettotalTime );
		}else if(OffsetAccel > 0){
			// 下弦 ( 最初は動きが遅く、徐々に早くなる )
			Offsettick = Offsettick / OffsettotalTime;
			Offsettick = Math.pow(Offsettick, OffsetAccel);
			Offsettick = int ( Offsettick * OffsettotalTime );
		}
		
		// 移動
		moveStyle(tick,Offsettick);
	}
	
	// 最終状態を表示
	function finish()
	{
		//if(clear)targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, 0x0);
		
		if(delay != 0){
			if(!subflag){
				targetLayer.visible=true;
				targetLayerBack.visible=true;
			}else{
				subflag = false;
				targetLayer.visible=false;
				targetLayerBack.visible=false;
			}
		}
		
		moveStyle(totalTime,OffsettotalTime);
		stop();
	}
	
	function onTag()
	{
		if(alive && !moving)finish();
		//色調補正
	}

	// 停止
	function stop()
	{
		if(moving)
		{
			System.removeContinuousHandler(continuousHandler);
			moving = false;
			StackCount++;
			if(stack.count > StackCount){
				startEffect(stack[StackCount]);
			}else{
				if(StackLoop){
					StackCount = 0;
					if(stack.count > StackCount){
						startEffect(stack[StackCount]);
					}
				}else{
					window.trigger('move_effect_plugin'+obj_no);
				}
			}
		}
	}
	
	// レイヤーを削除
	function deleteLayer()
	{
		alive = false;
		stop();

		invalidate AffectLayer if AffectLayer !== void;
		invalidate AffectLayerBack if AffectLayerBack !== void;
		
		invalidate RideTemp if RideTemp !== void;
		invalidate RideLayer if RideLayer !== void;
		invalidate RideLayerBack if RideLayerBack !== void;
		RideTemp = RideLayer = RideLayerBack = void;
		
		invalidate CoverLayer if CoverLayer !== void;
		invalidate CoverLayerBack if CoverLayerBack !== void;
		CoverLayer = CoverLayerBack = void;
		
		invalidate tempLayer if tempLayer !== void;
		tempLayer = void;
		invalidate targetLayer if targetLayer !== void;
		invalidate targetLayerBack if targetLayerBack !== void;
		targetLayer = targetLayerBack = void;
	}

	function clearLayer()
	{
		alive = false;
		stop();

		AffectLayer.loadImages("ImgClear");
		AffectLayer.setSizeToImageSize();
		
		AffectLayerBack.loadImages("ImgClear");
		AffectLayerBack.setSizeToImageSize();
		
		RideTemp.loadImages("ImgClear");
		RideTemp.setSizeToImageSize();
		
		RideLayer.loadImages("ImgClear");
		RideLayer.setSizeToImageSize();
		RideLayerBack.loadImages("ImgClear");
		RideLayerBack.setSizeToImageSize();
		
		CoverLayer.loadImages("ImgClear");
		CoverLayer.setSizeToImageSize();
		CoverLayerBack.loadImages("ImgClear");
		CoverLayerBack.setSizeToImageSize();
		
		tempLayer.loadImages(%[storage:"ImgClear"]);
		tempLayer.setSizeToImageSize();
		
		targetLayer.loadImages(%[storage:"ImgClear"]);
		targetLayer.setSizeToImageSize();
		targetLayer.visible=false;
		targetLayer.type = ltAlpha;
		
		targetLayerBack.loadImages(%[storage:"ImgClear"]);
		targetLayerBack.setSizeToImageSize();
		targetLayerBack.visible=false;
		targetLayerBack.type = ltAlpha;
	}

	// 残り時間を再設定する
	function timeReset(re_time)
	{
		var nowTick = System.getTickCount();	// 現在時刻取得
		var tick = nowTick - starttick;			// 何ミリ秒経ったかを計算
		if(tick + re_time < totalTime){
			var endTick = starttick + totalTime;	// 最終時刻を取得
			var new_endTick = nowTick + re_time;	// 新しい最終時刻を設定
			var par = 1-(tick/totalTime);			// 残り時間の割合を計算
			var new_totalTime = re_time / par;		// 新しい合計時間を取得(新しい残り時間が元の残り時間の割合を満たす合計時間を算出)
			starttick = new_endTick - new_totalTime;

			// 新しい全体時間を設定
			totalTime = new_totalTime;
			// 新しい全体時間からパスで割って時間を逆算
			time = totalTime / (path.count \ 3 - 1);
		}
	}

	function onStore(f, elm)
	{
		if(alive){
			var dic = f["move_effect" + obj_no] = %[];
			(Dictionary.assign incontextof dic)(storeDic);
			dic.moving = moving;
			dic.foreVisible = targetLayer.visible;
			dic.backVisible = targetLayerBack.visible;
			dic.deleteAfterTransFlag = deleteAfterTransFlag;
			/*スタック処理*/
			dic.stack = this.stack;
			dic.stackloop = this.StackLoop;
			dic.stackcount = this.StackCount;
		}else{
			f["move_effect" + obj_no] = void;
		}
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		stop(); // 動作を停止
		clearLayer();	// 削除
		var dic = f["move_effect" + obj_no];
		if(dic !== void){
			if(dic.replacement !== void) dic.replacement = "false";
			if(dic.stack !== void) this.stack.assign(dic.stack);
			if(dic.stackloop !== void) this.StackLoop = dic.stackloop;
			if(dic.stackcount !== void) this.StackCount = dic.stackcount;

			if(this.StackCount <= 0){
				if(dic.moving){
					if(dic.page == "back")dic.page = void;
					if(dic.show == "true")dic.show = void;
					startEffect(dic);	// 動作中だった
				}else{
					dic.time = 0;
					if(dic.foreVisible && !dic.backVisible)dic.page="fore";
					else if(!dic.foreVisible && dic.backVisible)dic.page="back";
					else dic.page="with";
					startEffect(dic);	// 停止中だった
				}
			}else if(this.StackCount == this.stack.count){
				var tsc = this.StackCount;
				if(dic.moving){
					if(this.stack[tsc].page == "back")this.stack[tsc].page = void;
					if(this.stack[tsc].show == "true")this.stack[tsc].show = void;
					startEffect(this.stack[tsc]);	// 動作中だった
				}else{
					if(this.stack[tsc].page == "back")this.stack[tsc].page = void;
					if(this.stack[tsc].show == "true")this.stack[tsc].show = void;
					this.stack[tsc].time = 0;
					startEffect(this.stack[tsc]);	// 動作中だった
				}
			}else{
				if(dic.page == "back")dic.page = void;
				if(dic.show == "true")dic.show = void;
				startEffect(this.stack[this.StackCount]);	// 動作中だった
			}
			if(dic.deleteAfterTransFlag !== void)deleteAfterTransFlag = dic.deleteAfterTransFlag;
		}

	}

	//タイトルやゲーム終了時(ボイスあり)の際の画面の初期化用
	function onClearScreenChange(elm)
	{
		if(elm.now === "true") DeleteObjectNow();
		else DeleteObject();
	}
	
	function onStableStateChanged(stable){}

	function onMessageHiddenStateChanged(hidden){}

	function onExchangeForeBack()
	{

		var fore = targetLayer;
		targetLayer = targetLayerBack;
		targetLayerBack = fore;

		var afore = AffectLayer;
		AffectLayer = AffectLayerBack;
		AffectLayerBack = afore;
		
		var cfore = CoverLayer;
		CoverLayer = CoverLayerBack;
		CoverLayerBack = cfore;
		
		var rfore = RideLayer;
		RideLayer = RideLayerBack;
		RideLayerBack = rfore;
		
		
		if(deleteAfterTransFlag){clearLayer();}
		
		if(showAfterTransFlag && targetLayer !== void && targetLayerBack !== void){
			targetLayer.visible = targetLayerBack.visible = true;
			if(CoverFlag){ CoverLayer.visible = CoverLayerBack.visible = true;}
			if(RideFlag){ RideLayer.visible = RideLayerBack.visible = true;}
		}
		
		if(subflag && targetLayer !== void && targetLayerBack !== void){
			targetLayer.visible = targetLayerBack.visible = false;
			if(CoverFlag){ CoverLayer.visible = CoverLayerBack.visible = false;}
			if(RideFlag){ RideLayer.visible = RideLayerBack.visible = false;}
		}
	}

	function onSaveSystemVariables()
	{
		// システム変数に情報が保存され時に呼ばれる
		// このタイミングで kag.scflags に情報を書き込めば
		// 確実にシステム変数に情報を書くことができる
	}

	function StartStack(elm)
	{
		StackLoopCheck(elm);
		this.StackCount = 0;
		if(stack.count > 0){
			startEffect(stack[this.StackCount]);
		}else{
			si("スタックが有りません");
		}
	}
	
	function AddStack(elm)
	{
		stack.add(%[]);
		(Dictionary.assign incontextof stack[stack.count-1])(elm);
	}

	function ClearStack()
	{
		for(var i=0; i<stack.count; i++){
			(Dictionary.clear incontextof stack[i])();
		}
		stack.clear();
	}

	function StopStack(){
		if(stack.count > 0){
			var tmp = %[];
			this.StackLoop = false;
			(Dictionary.assign incontextof tmp)(stack[stack.count-1]);
			tmp.time = 0;
			ClearStack();
			startEffect(tmp);
			(Dictionary.clear incontextof tmp)();
		}
	}

	function StackLoopCheck(elm){
		this.StackLoop = elm.stackloop == "true" ? true : false;
		this.StackCount = -1;
	}
}

var move_effect_object = new Array();
{
	var move_effect_max_num = 3;
	for( var i = 0 ; i < move_effect_max_num; i++ )
	{
		kag.addPlugin(global.move_effect_object[i] = new MoveEffectPlugin(kag, i));
	}
	kag.addPlugin(global.move_efthum_object = new MoveEffectPlugin(kag, move_effect_max_num));
}

// すべてを一気に停止させるための関数
function meffAllStopFunction()
{
	for(var i=0; i<move_effect_object.count; i++){
		if(move_effect_object[i].moving){
			move_effect_object[i].StackLoop = false;
			if(move_effect_object[i].stack.count > 0){
				move_effect_object[i].StopStack();
			}else{
				move_effect_object[i].finish();
			}
		}
	}
}

// すべてを一気に削除予約の関数
function meffAllDeleteFunction()
{
	for(var i=0; i<move_effect_object.count; i++){
		if(move_effect_object[i].alive){
			move_effect_object[i].StackLoop = false;
			move_effect_object[i].ClearStack();
			move_effect_object[i].deleteAfterTransFlag = true;
			move_effect_object[i].targetLayerBack.visible = false;
			if(move_effect_object[i].CoverFlag){ move_effect_object[i].CoverLayerBack.visible = false;}
			if(move_effect_object[i].RideFlag){ move_effect_object[i].RideLayerBack.visible = false;}
		}
	}
}

// すべてを一気に削除の関数
function meffAllDeleteNowFunction()
{
	for(var i=0; i<move_effect_object.count; i++){
		if(move_effect_object[i].alive){
			move_effect_object[i].StackLoop = false;
			move_effect_object[i].ClearStack();
			move_effect_object[i].finish();
			move_effect_object[i].clearLayer();
		}
	}
}

function macro_change_meff(elm){
	var time = 250;
	var delay = 0;
	if(elm.time !== void){
		time = elm.time;
		elm.time = 1;
	}

	if(elm.delay !== void){
		delay = elm.delay;
		elm.delay = void;
	}
	
	elm.page="both";
	elm.replacement="true";
	if(elm.e_delay !== void){
		elm.delay = elm.e_delay;
	}
	elm.obj = FreeObjectNumber(elm);
	move_effect_object[elm.obj].startEffect(elm);
	elm.time = time;
	elm.delay = delay;
}
@endscript
@endif
;
; マクロ登録

@macro name="meff"
@eval exp="move_effect_object[+mp.obj].StackLoopCheck(mp)"
@eval exp="move_effect_object[+mp.obj].startEffect(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="meff_stack_start"
@eval exp="move_effect_object[+mp.obj].StartStack(mp)"
@endmacro

@macro name="meff_stack"
@eval exp="move_effect_object[+mp.obj].AddStack(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro
;
@macro name="wmeff"
@waittrig * name="&'move_effect_plugin'+(int)mp.obj" onskip="move_effect_object[+mp.obj].StopStack(),move_effect_object[+mp.obj].finish()" canskip=%canskip|true cond="move_effect_object[+mp.obj].moving && (!move_effect_object[+mp.obj].loop || move_effect_object[+mp.obj].loopCount != -1) && !move_effect_object[+mp.obj].StackLoop"
@endmacro

@macro name="awmeff"
@eval exp="kag.leftClickHook.clear(); kag.leftClickHook.add(function(){kag.leftClickHook.clear(); effAllStopFunction(); tf.effectSkipFlag = true;});"
@waittrig * name="&'move_effect_plugin0'" onskip="move_effect_object[0].StopStack(),move_effect_object[0].finish()" canskip=%canskip|true cond="move_effect_object[0].moving && (!move_effect_object[0].loop || move_effect_object[0].loopCount != -1) && !move_effect_object[0].StackLoop"
@waittrig * name="&'move_effect_plugin1'" onskip="move_effect_object[0].StopStack(),move_effect_object[1].finish()" canskip=%canskip|true cond="move_effect_object[1].moving && (!move_effect_object[1].loop || move_effect_object[1].loopCount != -1) && !move_effect_object[1].StackLoop"
@waittrig * name="&'move_effect_plugin2'" onskip="move_effect_object[0].StopStack(),move_effect_object[2].finish()" canskip=%canskip|true cond="move_effect_object[2].moving && (!move_effect_object[2].loop || move_effect_object[2].loopCount != -1) && !move_effect_object[2].StackLoop"
@eval exp="kag.leftClickHook.clear(); if(tf.effectSkipFlag){ kag.cancelSkip(); } tf.effectSkipFlag = false;"
@endmacro
;
@macro name="smeff"
@eval exp="move_effect_object[+mp.obj].StopStack(),move_effect_object[+mp.obj].finish()" cond="move_effect_object[+mp.obj].moving"
@endmacro
;
@macro name="asmeff"
@eval exp="meffAllStopFunction()"
@endmacro

@macro name="meff_delete"
@eval exp="move_effect_object[+mp.obj].DeleteObject()" cond="move_effect_object[+mp.obj].alive"
@endmacro

@macro name="meff_delete_now"
@eval exp="move_effect_object[+mp.obj].DeleteObjectNow()" cond="move_effect_object[+mp.obj].alive"
@endmacro

@macro name="meff_trans"
@eval exp="mp.page = 'back'; mp.transTime = +mp.time; mp.time = 0;"
@eval exp="move_effect_object[+mp.obj].startEffect(mp)"
@wmeff *
@trans * layer=base method="&mp.method !== void ? mp.method : (mp.rule === void ? 'crossfade' : 'universal')" time=%transTime|1000
@wt
@eval exp="move_effect_object[+mp.obj].targetLayer.visible=true, move_effect_object[+mp.obj].targetLayerBack.visible=true"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="meff_all_delete"
@eval exp="meffAllDeleteFunction();"
@endmacro

@macro name="meff_all_delete_now"
@eval exp="meffAllDeleteNowFunction();"
@endmacro

@macro name="cmeff"
@meff * page=both replacement=true
@extrans * time=%time|250
@endmacro

@macro name="cmeff_stock"
@meff * page=both replacement=true
@endmacro

@macro name="dcmeff"
@eval exp="global.delayscript.addEvent(mp, 'macro_change_meff')"
@eval exp="global.delayscript.addEvent(mp, 'macro_begin_Transition')"
@endmacro

@return

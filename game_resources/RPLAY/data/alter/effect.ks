@if exp="typeof(global.effect_object) == 'undefined'"

@iscript

/*
	画像の拡大縮小直線移動曲線移動回転ボックスブラー・擬似モーションブラー
	それら複数を同時に実行するプラグイン
*/

class EffectPlugin extends KAGPlugin
{
	var testFlag = false;
	// このプラグインの管理番号
	var obj_no = 0;						// object番号

	var id = void;						// objectの名前
	
	//構成レイヤ
	var tempBmp;
	var targetBmp;
	
	var tempLayer;						// 画像レイヤー
	var tempLayer2;						// 裏描画の変更
	var singleBase;
	var singleBase2;
	var tempSaveLayer;					// 画像レイヤー
	var targetLayer;					// 対象レイヤー
	var targetLayerBack;				// 対象裏レイヤー
	var alphaLayer;						// ADDALPHA用のレイヤー
	var afterLayer = [];				// 残像用レイヤー
	var afterLayerBack = [];			// 残像用レイヤー
	var afterImageOpacity;				//
	var afterImageMax;					//
	var afterImageSkip;					//
	var afterImageCount;				//
	var afterImageStopCount;			//
	
	//確認用フラグ
	var moving = false;					// 動作中かどうか
	var alive = false;					// レイヤー類が生きてるかどうか
	var loop = false;					// ループするか
	var loopCount = -1;					// ループする回数
	
	//基本配列系
	var absolute;						// 絶対位置【表示優先度】を配列記録する
	var size;							// 総合サイズを配列記録する
	var xsize,ysize;					// 縦横サイズを配列記録する
	var cx, cy;							// 回転中心を配列記録する
	var rad;							// 軸データ【Ｚ軸】を配列記録する
	var xspin,yspin;					// 軸データ【Ｘ軸】【Ｙ軸】を配列記録する
	var rgamma,ggamma,bgamma;			// gamma補正値を配列記録する
	var rfloor,gfloor,bfloor;			// floor補正値を配列記録する
	var rceil,gceil,bceil;				// ceil補正値を配列記録する
	var mosaic;							// mosaic情報データを配列記録する
	var alpha_add;						// 強制加算アルファ情報データを配列記録する

	var bbx,bby;						// ボックスブラーの処理
	var bbType;							// ボックスブラーの処理
	var bbExtend;
	var bbSquare;						// ボックスブラーの処理

	var firstTime;						// ハンドル動作が初回かのフラグ
	
	//var storage;
	
	//基本動作系
	var tempImage;						// パスの作業用
	var path;							// パスの作業用
	var time;							// ひとつのパスを通る時間
	var accel;							// 加速度的な動きを行うか
	var moveFunc;						// 移動位置計算用関数
	var zoomFunc;						// 拡大処理用関数
	var clear;							// レイヤをクリアするかどうか
	var page;							// ページ裏表
	var pathtype;						// パスの方式
	var lu_corner;						// パスの方式・左上隅指定
	var spaccel;						// 特殊な加減速
	var totalTime;						// 総合時間
	var lastTick=0;						// 前回の描画時間
	var startTick;						// 描画開始時間
	var affineType;						// アフィン変換の方式
	var smallest = false;				// 画像幅での更新

	// 表示系
	var storageBox = [];				// 裏描画の変更
	var MultiDrawFlag = false;			// 複数枚用
	var twoDrawFlag;					// 二描画の用
	var storageCount;						// 枚数
	
	// 演算用配列
	var zx = [];						// スプラインワーク
	var zy = [];						// スプラインワーク

	// 演算用
	var imageWidthHalf;					// 対象レイヤーの幅の半分
	var imageHeightHalf;				// 対象レイヤーの高さの半分

	// セーブ・ロード用パラメータ記録配列
	var storeDic = %[];					// ここに格納したものがセーブデータとして格納
	var beforeDic = %[];				// 前回のデータを格納するもの
	
	// トランジション動作系
	var deleteAfterTransFlag = false;	// トランジション後に消去フラグ
	var showAfterTransFlag = false;		// トランジション後に全部表示フラグ

	// このプラグインが使われたレイヤーの表と裏の管理
	var foreState = false;				// targetLayerの表示状況
	var backState = false;				// targetLayerBackの表示状況
	var fillColor = "";					// 画面更新の際に先ず最初に塗りつぶす色

	var gl_l,gl_t;						//演算処理用の左上座標

	//色調変更用フラグ
	var MoveColorFlag = false;			// リアルタイム色調フラグ
	var grayscaleFlag;					// リアルタイム色調補正用【白黒化】
	var sepiaFlag;						// リアルタイム色調補正用【セピア】
	var turnFlag;						// リアルタイム色調補正用【反転】

	var alphaEffect;					// alpha用のeffectレイヤーのオブジェ番号
	var alphalayer;						// alpha用のeffectレイヤーのオブジェ番号
	var alphaleff;						// alpha用のeffectレイヤーのオブジェ番号
	var alphameff;
	
	var effectparent;					// 親レイヤー指定用のフラグ
	var layerparent;					// 親レイヤー指定用のフラグ
	var leffparent;						// 親レイヤー指定用のフラグ
	var meffparent;
	
	var CopyEffect = -1;				//
	var AlphaAdd;						//アルファ値の増幅処理の実行フラグ
	var ClearAlphaAdd;					//
	var seeingLevel;					//
	var anm_noise;						//アニメーションノイズ
	var margin_x=0;						//画像表示サイズのピクセル縮小【Ｘ軸】
	var margin_y=0;						//画像表示サイズのピクセル縮小【Ｙ軸】
	

	//継続関数系
	//var inherit = false;				// 前任者の位置を引き継ぐ(最終地点)
	//var inheritState;					// 回転でデータ(配列タイプのものはここで追加してやる)
	
	//出現関係
	var delay = 0;						// 何ミリ秒遅れて開始されるかの値
	var delayVisible = false;			// ディレイ時に初期位置の描画を行うか否か
	var xfade = false;					// 同オブジェクト内でのクロスフェードのための変数
	var fadeInTime = -1;				// フェードインさせる時間
	var fadeOutTime = -1;				// フェードアウトさせる時間
	var subFlag;						// 描画するか否か

	// ラスタスクロール関連【前処理】
	var BeforeRaster;					//RasterScroll用：
	var BeforeRasterInterpolation;		//RasterScroll用：画面端の補完フラグ
	var BeforeRasterTime;				//RasterScroll用：現在時刻
	var BeforeRasterStyle;				//RasterScroll用：
	var BeforeRasterVector;				//RasterScroll用：ラスタスクロールの向き
	var BeforeRasterCycle;				//RasterScroll用：一周期の期間(msec)
	var BeforeRasterMaxHeight;			//RasterScroll用：最大振幅
	var BeforeRasterLine;				//RasterScroll用：一周期あたりのライン数
	var BeforeRasterDomain = [];		//

	// ラスタスクロール関連【後処理】
	var AfterRaster;					//RasterScroll用：
	var AfterRasterInterpolation;		//RasterScroll用：画面端の補完フラグ
	var AfterRasterTime;				//RasterScroll用：現在時刻
	var AfterRasterStyle;				//RasterScroll用：
	var AfterRasterVector;				//RasterScroll用：ラスタスクロールの向き
	var AfterRasterCycle;				//RasterScroll用：一周期の期間(msec)
	var AfterRasterMaxHeight;			//RasterScroll用：最大振幅
	var AfterRasterLine;				//RasterScroll用：一周期あたりのライン数
	var AfterRasterDomain = [];			//
	
	var replacement;					//
	var timingForMosaic;				//mosaic効果の使用タイミング
	var ImageReload;					//画像の再読み込みを行うか否か
	
	//スタック処理用
	var stack = [];						//スタック処理の配列【内容：辞書配列】
	var StackCount = 0;					//スタック配列の現在使用番号
	var StackLoop = false;				//スタック処理のループフラグ
	var nextStack = -1;					//スタック処理の次の実行スタック

	//test処理フラグ
	var RidezoomFunc;				//演算
	var RideFlag = false;			//特殊処理
	var RideLayer;					//演算レイヤ
	var RideLayerBack;				//演算レイヤ
	var RideAlphaLayer;				//マスク演算用レイヤ
	var RideAlphaAdd;				//マスク演算用レイヤ
	var RideAlphaAddPrams;			//マスク演算用レイヤ

	var EMflag;							//
	var EffectMask;						//
	var MaskLevelA;						//
	var MaskLevelB;						//

	var EMATLayer;						//
	var EMATflag;						//
	
	var EMAflag;						//
	var EMRflag;						//
	var EMRmode;						//
	var RTLflag;						//
	var RTLflag2;						//
	var RideTargetLayer;				//
	var RideTargetLayer2;				//
	var R_em;							//
	var G_em;							//
	var B_em;							//
	var EMSflag;						//
	
	var blend;							//
	//var xorIMG;						//排他的表示

	var ol = 0;
	var ot = 0;
	var oo = 0;
	var OffsetSpline;					//
	var OffsetAccel;					//
	var OffsetSpAccel;					//
	var OffsetPath = [];				//
	var ozx = [];						//
	var ozy = [];						//
	var Offsettime;						//
	var OffsettotalTime;				//
	var Offsettick=0;					// 前回の描画時間
	var OffsetlastTick=0;				// 前回の描画時間
	var OffsetstartTick;				// 描画開始時間
	var Offsetloop;						// 連続再生
	var OffsetloopCount;				// 連続再生

	var hangObj = [];
	
	var ImgClearFlag = true;			//
	var test = true;
	
	function EffectPlugin(window, no, _id = void)
	{

		//対象のidに指定がない場合には管理番号がIDになる
		if(_id !== void) id = "" + _id;
		else id = "" + no;
		
		if(typeof global.EffectArray == "undefined"){				//本体がなかった際に作成する
			global.EffectArray = new Array();
		}
		global.EffectArray.add(this);								//自身を管理する配列
		
		obj_no = no;												//自身のオブジェクト番号を格納
		super.KAGPlugin();											//継承したKAGPluginクラスの初期化
		this.window = window;										//自身の管理ウインドウの格納
		
		// 最初にレイヤー確保
		tempLayer = singleBase = new AutoPiledLayer(window, kag.fore.base);		//
		tempLayer.owner = this;										//
		tempLayer.visible = false;									//
		tempLayer2 = singleBase2 = new AutoPiledLayer(window, kag.fore.base);		//
		tempLayer2.owner = this;									//
		tempLayer2.visible = false;									//
		tempSaveLayer = new AutoPiledLayer(window, kag.fore.base);	//
		tempSaveLayer.owner = this;									//
		tempSaveLayer.visible = false;								//

		tempBmp = new Bitmap();
		targetBmp = new Bitmap(kag.scWidth, kag.scHeight);
		
		targetLayer = new Layer(window, kag.fore.base);				//
		targetLayerBack = new Layer(window, kag.back.base);			//
		alphaLayer = new Layer(window, kag.fore.base);				//
		
		RideLayer = new Layer(window, kag.fore.base);				//
		RideLayerBack = new Layer(window, kag.back.base);			//
		
		RideAlphaLayer = new Layer(window, kag.fore.base);			//
		RideAlphaLayer.owner = this;								//
		RideAlphaLayer.visible = false;								//
		RideAlphaLayer.hitType = htMask;							//
		RideAlphaLayer.hitThreshold = 256;							//
		
		// 念のために実体化
		moveFunc = LinearMover;										//
		
		//全ての配列クラスをここで宣言
		ArrayParamsInit();											//配列の実体化
		
		//初期更新
		//inheritState = new Dictionary();							//継承辞書配列を実体化
		
		alphaEffect = void;											//
		alphalayer = void;
		alphaleff = void;
		alphameff = void;
	}

	function finalize()
	{
		// 一応止めて所持オブジェクト破棄
		stop();										//動作の停止
		ClearStack();								//溜め込んだスタックの辞書配列を開放
		clearLayer();								//レイヤーの初期化
		deleteLayer();								//実体化したレイヤーの開放
		super.finalize(...);						//継承したクラスの終了処理
	}

	function ArrayParamsInit(){
		//配列データの終了準備
		tempImage = new ImageArray();					//初期値は、1
		size = new ParamsArray(1);						//初期値は、1
		xsize = new ParamsArray(1);						//初期値は、1
		ysize = new ParamsArray(1);						//初期値は、1
		cx = new ParamsArray(0.5);						//初期値は、0.5(この形式だと画像の中央)
		cy = new ParamsArray(0.5);						//初期値は、0.5(この形式だと画像の中央)
		rad = new ParamsArray(0);						//初期値は、0
		xspin = new ParamsArray(0);						//初期値は、0
		yspin = new ParamsArray(0);						//初期値は、0
		alpha_add = new ParamsArray(0);					//初期値は、0
		absolute = new ParamsArray(15000+obj_no);		//初期値は、15000+オブジェ番号
		rgamma = new ParamsArray(1);					//初期値は、1
		ggamma = new ParamsArray(1);					//初期値は、1
		bgamma = new ParamsArray(1);					//初期値は、1
		rfloor = new ParamsArray(0);					//初期値は、0
		gfloor = new ParamsArray(0);					//初期値は、0
		bfloor = new ParamsArray(0);					//初期値は、0
		rceil = new ParamsArray(255);					//初期値は、255
		gceil = new ParamsArray(255);					//初期値は、255
		bceil = new ParamsArray(255);					//初期値は、255
		mosaic = new ParamsArray(1);					//初期値は、1
		BeforeRasterMaxHeight = new ParamsArray(0);		//初期値は、0
		BeforeRasterLine = new ParamsArray(1);			//初期値は、1
		AfterRasterMaxHeight = new ParamsArray(0);		//初期値は、0
		AfterRasterLine = new ParamsArray(1);			//初期値は、1

		RideAlphaAddPrams = new ParamsArray(0);			//初期値は、1

		bbx = new ParamsArray(0);						//初期値は、0
		bby = new ParamsArray(0);						//初期値は、0
		
		EffectMask = new ParamsArray(128);				//初期値は、128
		MaskLevelA = new ParamsArray(10);				//初期値は、10
		MaskLevelB = new ParamsArray(10);				//初期値は、10
	}
	
	function ArrayParamsFinalize(){
		//配列データの終了準備
		invalidate tempImage;						//
		invalidate size;							//
		invalidate xsize;							//
		invalidate ysize;							//
		invalidate cx;								//
		invalidate cy;								//
		invalidate rad;								//
		invalidate xspin;							//
		invalidate yspin;							//
		invalidate alpha_add;						//
		invalidate absolute;						//
		invalidate rgamma;							//
		invalidate ggamma;							//
		invalidate bgamma;							//
		invalidate rfloor;							//
		invalidate gfloor;							//
		invalidate bfloor;							//
		invalidate rceil;							//
		invalidate gceil;							//
		invalidate bceil;							//
		invalidate mosaic;							//
		invalidate BeforeRasterMaxHeight;			//
		invalidate BeforeRasterLine;				//
		invalidate AfterRasterMaxHeight;			//
		invalidate AfterRasterLine;					//

		invalidate RideAlphaAddPrams;				//

		invalidate bbx;								//
		invalidate bby;								//
		
		invalidate EffectMask;						//
		invalidate MaskLevelA;						//
		invalidate MaskLevelB;						//
	}
	
	function ArrayParamsClear(){
		//配列データの初期化
		tempImage.clear();							//
		size.clear();								//
		xsize.clear();								//
		ysize.clear();								//
		cx.clear();									//
		cy.clear();									//
		rad.clear();								//
		xspin.clear();								//
		yspin.clear();								//
		alpha_add.clear();							//
		absolute.clear();							//
		rgamma.clear();								//
		ggamma.clear();								//
		bgamma.clear();								//
		rfloor.clear();								//
		gfloor.clear();								//
		bfloor.clear();								//
		rceil.clear();								//
		gceil.clear();								//
		bceil.clear();								//
		mosaic.clear();								//
		BeforeRasterMaxHeight.clear();				//
		BeforeRasterLine.clear();					//
		AfterRasterMaxHeight.clear();				//
		AfterRasterLine.clear();					//

		RideAlphaAddPrams.clear();					//

		bbx.clear();								//
		bby.clear();								//
		
		EffectMask.clear();							//
		MaskLevelA.clear();							//
		MaskLevelB.clear();							//
	}

	function startEffect(elm)
	{
		
		nextStack = (elm.nextstack !== void) ? +elm.nextstack : -1;
		storageCount = 0;
		twoDrawFlag = false;
		
		if(MultiDrawFlag){
			//singleBase.assignImages(storageBox[storageBox.count - 1]);
			if(storageBox.count > 0){
				for(var i = storageBox.count - 1; i >= 0; i--) invalidate storageBox[i];
				storageBox.clear();
			}
		}
		MultiDrawFlag = false;
		replacement = false;
		
		if(elm.replacement == "true"){
			var temp_elm = new Dictionary();
			var temp_storage = elm.storage;
			
			(Dictionary.assign incontextof temp_elm)(storeDic);
			(Dictionary.assign incontextof temp_elm)(elm,false);
			(Dictionary.assign incontextof elm)(temp_elm);
			
			invalidate temp_elm;
			
			elm.storage = temp_storage;
			elm.multi = void;
			elm.xfade = "true";
			elm.clear = "false";
			elm.time = 1;
			elm.delay = void;
			replacement = true;
			targetLayerBack.loadImages("ImgClear");
		}

		if(elm.replacement_time !== void) elm.time = elm.replacement_time;
		if(elm.replacement_path !== void) elm.path = elm.replacement_path;


		if(elm.ridealpha !== void){
			elm.sub = "true";
			elm.time = 1;
		}

		//配列の初期化
		ArrayParamsClear();

		// 画像読み込みに必要なボックスブラーの処理のみ先に行う
		if(elm.bbur_extend !== void) elm.bbe = elm.bbur_extend;
		if(elm.bblur_sq !== void) elm.bbs = elm.bblur_sq;
		
		bbx.ArrayForParams(elm.bbx);			//
		bby.ArrayForParams(elm.bby);			//
		//ここまで
		
		elm.fbbx = void;
		elm.fbby = void;
		if(elm.bbtemp !== void) elm.bbt = elm.bbtemp;
		if(elm.bbt === "true"){
			if(!bbx.IsFluctuate()){
				elm.fbbx = bbx.GetNowParams(0);
				bbx.clear();
				bbx.ArrayForParams(void);
			}
			if(!bby.IsFluctuate()){
				elm.fbby = bby.GetNowParams(0);
				bby.clear();
				bby.ArrayForParams(void);
			}
		}

		// 辞書配列をセーブ・ロード用に退避
		(Dictionary.assign incontextof storeDic)(elm);
		
		dm("storage:"+elm.storage);
		elm.storage = renameImagesByTitle(elm.storage);					//作品別の画像名変更処理
		
		ImageReload = true;
		if(!ImgClearFlag && elm.img === void){
			if(elm.storage === beforeDic.storage && elm.storage !== void){ ImageReload = false;}
			if(elm.bind === beforeDic.bind && elm.bind !== void){ ImageReload = false;}
			if(elm.frame !== beforeDic.frame && elm.frame !== void){ ImageReload = true;}
			/*演出チェック*/
			if(!ImageReload) ImageReload = AddEffectFlag(elm);
		}else if(elm.img == "true") ImageReload = true;

		(Dictionary.assign incontextof beforeDic)(storeDic);
		
		//ロード時の呼び出しの不具合の対処
		var endflag = false;
		if(elm.time <= 1){
			elm.time=100;
			endflag = true;
		}
		
		if(elm.rainbow !== void){
			elm.rgamma = "(1,1)";										//七色発光の基礎パラの取得
			elm.ggamma = "(1,1)";										//七色発光の基礎パラの取得
			elm.bgamma = "(1,1)";										//七色発光の基礎パラの取得
			elm.rfloor = "(0,0)";										//七色発光の基礎パラの取得
			elm.gfloor = "(0,0)";										//七色発光の基礎パラの取得
			elm.bfloor = "(0,0)";										//七色発光の基礎パラの取得
			elm.rceil = "(255,255,0,0,0,255,255)";						//七色発光の基礎パラの取得
			elm.gceil = "(0,255,255,255,0,0,0)";						//七色発光の基礎パラの取得
			elm.bceil = "(0,0,0,255,255,255,0)";						//七色発光の基礎パラの取得
			elm.grayscale = "true";										//七色発光の為にグレイスケール化
			elm.movecolor = "true";										//七色発光の為にグレイスケール化
		}
		
		// ループするか？
		this.loop = elm.loop == "true" ? true : false;						//ループフラグ
		this.loopCount = elm.loopcount !== void ? +elm.loopcount : -1;		//ループ回数

		//一応初期化と確認項目
		if(this.loopCount == 0){
			elm.time = 0;													//【一度もループしない】なので動作の停止
			this.loop = false;												//ループフラグをオフ
		}else if(this.loopCount != -1){
			this.loopCount--;												//カウントダウン方式を取る
		}

		this.Offsetloop = elm.offsetloop == "true" ? true : false;							//ループフラグ
		this.OffsetloopCount = elm.offsetloopcount !== void ? +elm.offsetloopcount : -1;	//ループ回数
		
		//一応初期化と確認項目
		if(this.OffsetloopCount == 0){
			elm.Offsettime = 0;											//【一度もループしない】なので動作の停止
			this.OffsetloopCount = false;								//ループフラグをオフ
		}else if(this.OffsetloopCount != -1) this.OffsetloopCount--;	//カウントダウン方式を取る

		
		// もし塗りつぶし色があったら登録
		if(elm.fillcolor !== void) this.fillColor = (int)elm.fillcolor;
		else this.fillColor = "";
		
		//画像描画タイプ
		this.pathtype = elm.pathtype == "true" ? true : false;		// 画面中央型かレイヤ中心型
		this.lu_corner = elm.lu_corner == "true" ? true : false;	// 左上座標点か

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

		//残像処理
		if(afterLayer.count > 0){
			for(var i=0;i<afterLayer.count;i++){
				invalidate afterLayer[i];
				invalidate afterLayerBack[i];
			}
			afterLayer.clear();
			afterLayerBack.clear();
		}
		afterImageOpacity = 0;
		afterImageMax = 0;
		afterImageSkip = 0;
		afterImageCount = 0;
		afterImageStopCount = 0;
		
		if(elm.afterimage !== void){
			var ac = +elm.afterimage;
			afterImageStopCount = ac;
			afterImageOpacity = 255 / (ac + 1);
			for(var i=0;i<ac;i++){
				afterLayer.add(new Layer(window, kag.fore.base));
				afterLayerBack.add(new Layer(window, kag.back.base));
			}

			if(elm.afterimageskip !== void) afterImageSkip = +elm.afterimageskip;
			
			for(var i=0;i<ac;i++){
				var ao = afterImageOpacity * (ac - i);
				afterLayer[i].opacity = ao;
				afterLayerBack[i].opacity = ao;
				afterLayer[i].fillRect(0,0,afterLayer[i].imageWidth,afterLayer[i].imageHeight,0x00000000);
				afterLayerBack[i].fillRect(0,0,afterLayerBack[i].imageWidth,afterLayerBack[i].imageHeight,0x00000000);
				afterLayer[i].hitType = htMask;				//
				afterLayerBack[i].hitType = htMask;				//
				afterLayer[i].hitThreshold = 256;				//
				afterLayerBack[i].hitThreshold = 256;				//
				afterLayer[i].visible = true;
				afterLayerBack[i].visible = true;
			}
		}
		
		//このエフェクトを他のエフェクトの補助に使う場合
		if(elm.sub !== "true"){
			subFlag = false;										//サブフラグをオフ
		}else{
			subFlag = true;											//サブフラグをオン
			backState = foreState = false;							//完全非表示
		}
		
		// トランジション後削除のフラグ
		deleteAfterTransFlag = elm.delete=="true" ? true : false;
		
		// トランジション後表裏表示フラグ
		showAfterTransFlag = elm.show=="true" ? true : false;
		if(foreState && backState) showAfterTransFlag = true;
		
		xfade = (elm.xfade == "true" && alive) ? true : false;
		
		/*内側へ指定ピクセル分だけ縮める処理*/
		this.margin_x = (elm.margin_x !== void) ? +elm.margin_x : 0;		//margi_x属性があるなら、横にmargi属性分ピクセル縮小
		this.margin_y = (elm.margin_y !== void) ? +elm.margin_y : 0;		//margi_y属性があるなら、縦にmargi属性分ピクセル縮小
		if(elm.margin != void) this.margin_y = this.margin_x = +elm.margin;	//margi属性があるなら、縦横にmargi属性分ピクセル縮小
		
		// 既存の動作を停止
		ResetStop();
		//stop();

		this.blend = (elm.blend !== void) ? +elm.blend : 40;				//blur専用
		
		/*
		画像の読み込み前に画像効果の部分を終わらせる
		*/
		//色を配列化する
		rgamma.ArrayForParams(elm.rgamma);		// 色調補正のrgammaの配列のセット
		ggamma.ArrayForParams(elm.ggamma);		// 色調補正のggammaの配列のセット
		bgamma.ArrayForParams(elm.bgamma);		// 色調補正のbgammaの配列のセット
		rfloor.ArrayForParams(elm.rfloor);		// 色調補正のrfloorの配列のセット
		gfloor.ArrayForParams(elm.gfloor);		// 色調補正のgfloorの配列のセット
		bfloor.ArrayForParams(elm.bfloor);		// 色調補正のbfloorの配列のセット
		rceil.ArrayForParams(elm.rceil);		// 色調補正のrceilの配列のセット
		gceil.ArrayForParams(elm.gceil);		// 色調補正のgceilの配列のセット
		bceil.ArrayForParams(elm.bceil);		// 色調補正のbceilの配列のセット

		//ボックスブラー系
		bbSquare = false;
		if(elm.bbs === "true") bbSquare = true;

		bbExtend = false;
		if(elm.bbe === "true") bbExtend = true;
		
		bbType = 1;
		if(elm.bbtype !== void){
			if(elm.bbtype == "both") bbType = 0;
			else if(elm.bbtype == "before") bbType = -1;
		}
		
		if(ImageReload){
			elm.endflag = endflag;
			
			if(elm.multi === void){
				tempLayer = singleBase;
				tempLayer.loadImages(elm.storage, clNone, elm.window == "true" , elm);
				ImgClearFlag = false;
				//dm("XX:"+elm.storage);
				if(elm.storage2 !== void){
					var s_b = [].split("(), ", elm.storage2, , true);
					twoDrawFlag = true;
					for(var i=0; i<s_b.count; i++){
						storageBox.add(new AutoPiledLayer(window, kag.fore.base));
						storageBox[storageBox.count-1].loadImages(s_b[i], clNone, elm.window == "true" , elm);
					}
					tempLayer2 = singleBase2;
					tempLayer2.loadImages(s_b[0], clNone, elm.window == "true" , elm);
				}
			}else{
				MultiDrawFlag = true;
				//var s_b = [].split("(), ", elm.multi, , true);
				
				tempImage.ArrayForParams(elm.multi);
				var s_b = tempImage.GetStorageList();
				for(var i=0; i<s_b.count; i++){
					storageBox.add(new AutoPiledLayer(window, kag.fore.base));
					storageBox[storageBox.count-1].loadImages(s_b[i], clNone, elm.window == "true" , elm);
				}
				tempLayer = storageBox[0];
				//dm("MLcount:"+storageBox.count);
			}
		}else{
			elm.endflag = endflag;
			//dm("ENDFLAG:" + elm.endflag);
		}

		test = false;
		if(elm.test !== void) test = true;
		
		// 画像用レイヤーに効果をかける
		
		// 謎の処理：画像の幅が奇数の物のアフィン変換はとても苦手のようなので
		// 偶数に補正。 これが仕様なのか、下の計算が下手なだけなのかは未調査。
		//		if(tempLayer.imageWidth%2)tempLayer.imageWidth+=1;
		//		if(tempLayer.imageHeight%2)tempLayer.imageHeight+=1;
		
		targetLayer.parent = kag.fore.base;
		targetLayerBack.parent = kag.back.base;
		
		//初期化
		effectparent = void;
		if(elm.effectparent !== void){
			var epc = elm.effectparent;									//LayerParentCount
			var target_obj = CallIdObject(epc);
			
			//最終targetLayerの親レイヤーの指定の画像の読み込み
			if(target_obj !== void && epc != id){
				effectparent = target_obj;
				targetLayer.parent = effectparent.targetLayer;
				targetLayerBack.parent = effectparent.targetLayerBack;
			}
		}

		//初期化
		layerparent = void;
		if(elm.layerparent !== void){
			var lpc = +elm.layerparent;									//LayerParentCount
			if(0 <= lpc && lpc < kag.fore.layers.count){
				targetLayer.parent = kag.fore.layers[lpc];				//レイヤの親を指定、後に変更
				targetLayerBack.parent = kag.back.layers[lpc];			//レイヤの親を指定、後に変更
				layerparent = lpc;										//番号を保存
			}
		}

		//初期化
		leffparent = void;
		if(elm.leffparent !== void){
			if(light_eff_object !== void){
				if(elm.leffparent == "front"){
					targetLayer.parent = light_eff_object.main;
					targetLayerBack.parent = light_eff_object.sub;
					leffparent = "front";										//番号を保存
				}else if(elm.leffparent == "rear"){
					targetLayer.parent = light_eff_object.main2;
					targetLayerBack.parent = light_eff_object.sub2;
					leffparent = "front";										//番号を保存
				}
			}
		}

		//他のレイヤーを丸々コピーする
		CopyEffect = (elm.copyeffect !== void) ? +elm.copyeffect : -1;
		
		if(CopyEffect != -1){
			tempLayer.assignImages(effect_object[CopyEffect].targetLayer);
			tempLayer.parent = kag.fore.base;
		}
		
		//画像にノイズを乗っける
		if(elm.noise_level !== void) tempLayer.noise(+elm.noise_level);		//ノイズのカラー系	【重】
		else if(elm.noise == "true") tempLayer.generateWhiteNoise();		//ノイズの白黒系	【軽】

		//画像に対しての色調補正を後にかける
		MoveColorFlag = (elm.movecolor == "true") ? true : false;
		
		//
		if(MoveColorFlag){
			grayscaleFlag = (elm.grayscale == 'true') ? true : false;		//
			sepiaFlag = (elm.sepia == 'true') ? true : false;				//
			turnFlag = (elm.turn == 'true') ? true : false;					//
		}

		/*
		inheritState["rgamma"] = rgamma.params[0];
		inheritState["ggamma"] = ggamma.params[0];
		inheritState["bgamma"] = bgamma.params[0];
		inheritState["rfloor"] = rfloor.params[0];
		inheritState["gfloor"] = gfloor.params[0];
		inheritState["bfloor"] = bfloor.params[0];
		inheritState["rceil"] = rceil.params[0];
		inheritState["gceil"] = gceil.params[0];
		inheritState["bceil"] = bceil.params[0];

		inheritState["bbx"] = bbx.params[0];
		inheritState["bby"] = bby.params[0];
		*/
		
		//---------------------------
		// 対象レイヤーを設定
		//---------------------------
		if(elm.smallest === "true"){
			smallest = true;																		//最小矩形フラグを入れる
			targetLayer.setImageSize( tempLayer.imageWidth * 1.5, tempLayer.imageHeight * 1.5);		// 最小範囲なら画像サイズ×1.5準備
		}else{
			smallest = false;										//最小矩形フラグを入れない
			targetLayer.setImageSize( kag.scWidth, kag.scHeight);	//描写レイヤの画像サイズをウインドウサイズに合わせる
		}
		targetBmp.setSize(targetLayer.imageWidth,targetLayer.imageHeight);

		targetLayer.setSizeToImageSize();			//描写レイヤの表示サイズを画像サイズに合わせる
		targetLayer.setPos(0, 0);					//
		targetLayer.hitType = htMask;				//
		targetLayer.hitThreshold = 256;				//

		targetLayerBack.setImageSize( targetLayer.imageWidth, targetLayer.imageHeight); //裏描写レイヤの表示サイズを画像サイズに合わせる
		targetLayerBack.setSizeToImageSize();
		targetLayerBack.setPos(0, 0);
		targetLayerBack.hitType = htMask;
		targetLayerBack.hitThreshold = 256;

		
		//---------------------------
		// 他パラメーター設定
		//---------------------------

		xspin.ArrayForParams(elm.xspin);							// 縦回転であるxspinの配列のセット
		yspin.ArrayForParams(elm.yspin);							// 横回転であるyspinの配列のセット
		absolute.ArrayForParams(elm.absolute);						// 絶対位置であるabsoluteの配列のセット
		
		// よく使うからとりあえず計算済みのものを。
		imageWidthHalf = targetLayer.imageWidth / 2;
		imageHeightHalf = targetLayer.imageHeight / 2;
		
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
		
		//前回のパスデータの最終地点の格納
		//if(this.path){//上のデータの格納}
		//
		OffsetPath.clear();
		ozx.clear();
		ozy.clear();
		
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
		
		if(elm.cx !== void){
			var pcx = "(";
			var tmp = [].split("(), ", elm.cx, , true);
			for(var i=0;i<tmp.count;i++){
				tmp[i] = +tmp[i];
				if(tmp[i] <= 0 || 1 <= tmp[i]){
					tmp[i] = tmp[i] / tempLayer.imageWidth;
				}
				pcx += tmp[i];
				if(i<tmp.count-1){pcx += ",";}
			}
			pcx += ")";
			elm.cx = pcx;
			tmp.clear();
		}

		if(elm.cy !== void){
			var pcy = "(";
			var tmp = [].split("(), ", elm.cy, , true);
			for(var i=0;i<tmp.count;i++){
				tmp[i] = +tmp[i];
				if(tmp[i] <= 0 || 1 <= tmp[i]){
					tmp[i] = tmp[i] / tempLayer.imageHeight;
				}
				pcy += tmp[i];
				if(i<tmp.count-1){pcy += ",";}
			}
			pcy += ")";
			elm.cy = pcy;
			tmp.clear();
		}
		cx.ArrayForParams(elm.cx);																												//回転中心【Ｘ軸】の配列化指定
		cy.ArrayForParams(elm.cy);																												//回転中心【Ｙ軸】の配列化指定
		//for(var i=0;i < cx.params.count; i++){ if( typeof cx.params[i] == 'Real' ) cx.params[i] = tempLayer.imageWidth * cx.params[i];}			//回転中心のパラメータが０≦Ｘ≦１の時は、割合として認識する
		//for(var i=0;i < cy.params.count; i++){ if( typeof cy.params[i] == 'Real' ) cy.params[i] = tempLayer.imageHeight * cy.params[i];}		//回転中心のパラメータが０≦Ｙ≦１の時は、割合として認識する
		
		
		mosaic.ArrayForParams(elm.mosaic);					//モザイクのピクセル変動値を配列化
		size.ArrayForParams(elm.size, elm.ss, elm.ds);		// サイズ変化を配列化
		xsize.ArrayForParams(elm.xsize);					// サイズ変化【横】を配列化
		ysize.ArrayForParams(elm.ysize);					// サイズ変化【縦】を配列化
		rad.ArrayForParams(elm.rad, elm.sr, elm.dr);		// 回転角度【Ｚ軸】の配列化
		for(var i = this.rad.params.count-1; i>=0; i--)this.rad.params[i] = +this.rad.params[i]*(Math.PI/180) * -1;	//角度は周期計算なので係数倍を360°=2πとする
		
		BeforeRaster = false;
		if(elm.braster !== void){
			BeforeRaster = (elm.braster == "true") ? true : false;				/**/
			BeforeRasterInterpolation = (elm.bri == "false") ? false : true;	/**/
			BeforeRasterStyle = (elm.brs == "v") ? "v" : "h";					/**/
			BeforeRasterStyle = (elm.brs == "vh") ? "vh" : BeforeRasterStyle;	/**/
			BeforeRasterMaxHeight.ArrayForParams(elm.brm);						/*振幅指定*/
			BeforeRasterLine.ArrayForParams(elm.brl);							/*ライン数指定*/
			BeforeRasterDomain.clear();											/*ライン数指定*/
			if(elm.brd !== void){
				var tmp = [].split("(), ", elm.brd, , true);
				for(var i=0; i<tmp.count;i++){ BeforeRasterDomain.add(+tmp[i]);}
			}else{
				BeforeRasterDomain.add(1);
				BeforeRasterDomain.add(1);
			}
			
			/*周期時間指定*/
			BeforeRasterCycle = (elm.brc !== void) ? +elm.brc : 1;
			
			/*時間指定*/
			BeforeRasterTime = (elm.brs !== void) ? +elm.brs : 0;
		}

		AfterRaster = false;
		if(elm.araster !== void){
			AfterRaster = (elm.araster == "true") ? true : false;				/**/
			AfterRasterInterpolation = (elm.ari == "false") ? false : true;		/**/
			AfterRasterStyle = (elm.ars == "v") ? "v" : "h";					/**/
			AfterRasterStyle = (elm.ars == "vh") ? "vh" : AfterRasterStyle;		/**/
			AfterRasterMaxHeight.ArrayForParams(elm.arm);						/*振幅指定*/
			AfterRasterLine.ArrayForParams(elm.arl);							/*ライン数指定*/
			AfterRasterDomain.clear();											/**/
			if(elm.ard !== void){
				var tmp = [].split("(), ", elm.ard, , true);
				for(var i=0; i<tmp.count;i++){ AfterRasterDomain.add(+tmp[i]);}
			}else{
				AfterRasterDomain.add(1);
				AfterRasterDomain.add(1);
			}
			
			/*周期時間指定*/
			AfterRasterCycle = (elm.arc !== void) ? +elm.arc : 1;
			
			/*時間指定*/
			AfterRasterTime = (elm.ars !== void) ? +elm.ars : 0;
		}

		//EM
		EMflag = false;
		EMAflag = false;
		EMATflag = false;
		EMATLayer = void;
		EMRflag = false;
		RTLflag = false;
		RTLflag2 = false;
		RideTargetLayer = void;
		EMRmode = 0;
		if(elm.em !== void){
			EMflag = true;
			EffectMask.ArrayForParams(elm.em);						//モザイクのピクセル変動値を配列化
			if(elm.ml !== void){
				MaskLevelA.ArrayForParams(elm.ml);					//モザイクのピクセル変動値を配列化
				MaskLevelB.ArrayForParams(elm.ml);					//モザイクのピクセル変動値を配列化
			}else{
				MaskLevelA.ArrayForParams(elm.mla);					//モザイクのピクセル変動値を配列化
				MaskLevelB.ArrayForParams(elm.mlb);					//モザイクのピクセル変動値を配列化
			}

			R_em = (elm.em_r === void) ? 0 : +elm.em_r;				//彩色【Ｒ】
			G_em = (elm.em_g === void) ? 0 : +elm.em_g;				//彩色【Ｇ】
			B_em = (elm.em_b === void) ? 0 : +elm.em_b;				//彩色【Ｂ】

			if(elm.emat !== void){
				EMATflag = true;
				EMATLayer = effect_object[+elm.emat].targetLayer;
			}
			
			if(elm.rtl !== void){
				RTLflag = true;
				RideTargetLayer = effect_object[+elm.rtl].targetLayer;
				if(elm.ema !== void){
					alphaLayer.loadImages(elm.ema);
				}else{
					alphaLayer.loadImages("alpha_img");
				}
				alphaLayer.setSizeToImageSize();
				alphaLayer.visible = false;
			}else if(elm.ema !== void){
				EMAflag = true;
				alphaLayer.loadImages(elm.ema);
				alphaLayer.setSizeToImageSize();
				alphaLayer.visible = false;
			}else if(elm.emr !== void){
				EMRflag = true;
				alphaLayer.loadImages(elm.emr);
				alphaLayer.setSizeToImageSize();
				alphaLayer.visible = false;
				EMRmode = (elm.emrmode === void) ? 0 : +elm.emrmode;
			}

			RideLayer.hitType = htMask;
			RideLayer.hitThreshold = 256;
			RideLayerBack.hitType = htMask;
			RideLayerBack.hitThreshold = 256;
			
			EMSflag = false;
			if(elm.ems !== void){
				EMSflag = true;
				RideLayer.assignImages(targetLayer);			//
				RideLayer.setSizeToImageSize();					//
				RideLayer.fillRect(0,0,RideLayer.imageWidth,RideLayer.imageHeight,0x0);
				RideLayerBack.assignImages(RideLayer);			//
				RideLayerBack.setSizeToImageSize();				//
				RideLayer.visible = true;
				RideLayerBack.visible = true;
				RideLayer.type = RideLayerBack.type = ltAlpha;
				if(elm.emm !== void){
					var _type = imageTagLayerType[elm.emm].type;
					if(_type !== void)RideLayer.type = RideLayerBack.type = _type;
				}
			}
			if(elm.rtl2 !== void){
				RTLflag2 = true;
				RideTargetLayer2 = effect_object[+elm.rtl2].targetLayer;
				RideLayer.assignImages(targetLayer);			//
				RideLayer.setSizeToImageSize();					//
				RideLayer.fillRect(0,0,RideLayer.imageWidth,RideLayer.imageHeight,0x0);
				RideLayerBack.assignImages(RideLayer);			//
				RideLayerBack.setSizeToImageSize();				//
				RideLayer.visible = true;
				RideLayerBack.visible = true;
				RideLayer.type = RideLayerBack.type = ltAlpha;
				if(elm.emm !== void){
					var _type = imageTagLayerType[elm.emm].type;
					if(_type !== void)RideLayer.type = RideLayerBack.type = _type;
				}
			}
		}
		

		// 時間設定
		this.time = elm.time !== void ? +elm.time : 1000;
		if(this.time<=1)this.time = 1;
		
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;
		AllgettimeForState();

		/*
		//前回最終地点をパスの頭に接続する
		if(elm.inherit !== void){
			//∇注意
			if(inheritState.o !== void){
				this.path.unshift(+inheritState.o);
				this.path.unshift(+inheritState.y);
				this.path.unshift(+inheritState.x);
				this.rad.params.unshift(+inheritState.r);
				this.size.params.unshift(+inheritState.s);
				this.xsize.params.unshift(+inheritState.s_x);
				this.ysize.params.unshift(+inheritState.s_y);
				this.xspin.params.unshift(+inheritState.xspin);
				this.yspin.params.unshift(+inheritState.yspin);
				this.absolute.params.unshift(+inheritState.absolute);
				this.cx.params.unshift(+inheritState.cy);
				this.cy.params.unshift(+inheritState.cx);
				if(MoveColorFlag){
					this.rgamma.params.unshift(+inheritState.rgamma);
					this.ggamma.params.unshift(+inheritState.ggamma);
					this.bgamma.params.unshift(+inheritState.bgamma);
					this.rfloor.params.unshift(+inheritState.rfloor);
					this.gfloor.params.unshift(+inheritState.gfloor);
					this.bfloor.params.unshift(+inheritState.bfloor);
					this.rceil.params.unshift(+inheritState.rceil);
					this.gceil.params.unshift(+inheritState.gceil);
					this.bceil.params.unshift(+inheritState.bceil);
				}
				this.bbx.params.unshift(+inheritState.bbx);
				this.bby.params.unshift(+inheritState.bby);
				reset_totaltime();
				inherit = true;
			}else{
				inherit = false;
			}
		}else{
			inherit = false;
		}
		*/
		
		// 加速度設定
		this.accel = elm.accel !== void ? +elm.accel : 0;
		// 特殊な加速を使うか？（減速→加速）
		if(elm.spaccel == "true"){
			this.accel = Math.abs(this.accel);
			this.spaccel = true;
		}else this.spaccel = false;
		
		// 表示タイプ設定
		if(effectparent === void && layerparent === void && leffparent === void){
			
			targetLayer.type = targetLayerBack.type = ltAlpha;
			if(elm.mode != void){
				// この辞書配列はtjsがはじめから持ってるらしい
				var _type = imageTagLayerType[elm.mode].type;
				if(_type !== void)targetLayer.type = targetLayerBack.type = _type;
			}
		}else{
			targetLayer.type = targetLayerBack.type = ltPsNormal;
			alphaLayer.type = ltAlpha;
			if(elm.mode != void){
				// この辞書配列はtjsがはじめから持ってるらしい
				var _type = imageTagLayerType[elm.mode].type;
			}
		}
		// レイヤー表示タイプが不透明・もしくは透明だった場合アフィン変換のタイプを精度の高いものへ
		
		//アフィン変換を最速へ
		affineType = stFastLinear;
		if(elm.at !== void){
			if(elm.at === "stNearest") affineType = stNearest;
			else if(elm.at === "stFastLinear") affineType = stFastLinear;
			else if(elm.at === "stLinear") affineType = stLinear;
			else if(elm.at === "stCubic") affineType = stCubic;
		}

		// アフィン中に周りをクリアするかどうか
		this.clear = elm.clear == 'false' ? false : true;

		// 移動位置計算関数の設定
		if(elm.spline == 'true'){
			PreSpline( path, zx, zy);
			moveFunc = SplineMover;
		}else moveFunc = LinearMover;

		if(elm.mblur !== void){
			zoomFunc = (elm.mblur == "true") ? blurAt : moveAt;
		}else{
			zoomFunc = (fillColor == "") ? moveAt : moveAtWithFillRect;
		}
		
		RidezoomFunc = ridemoveAt;

		delayVisible = false;
		// ディレイ設定
		if(elm.delay !== void){
			delay = +elm.delay;
			targetLayer.fillRect(0,0,targetLayer.imageWidth,targetLayer.imageHeight,0x0);
			targetLayerBack.assignImages(targetLayer);

			if(elm.dv !== void){
				delayVisible = true;
			}
		}else delay = 0;
		
		//effect用アルファの生成
		//ここでアルファで使用するレイヤーのアドレスを取得させる
		alphaEffect = void;
		if(elm.alphaeffect !== void){
			var aec = elm.alphaeffect;
			var target_obj = CallIdObject(aec);
			if(target_obj !== void && aec != id) alphaEffect = target_obj;
		}

		alphalayer = void;
		if(elm.alphalayer !== void){
			var alc = +elm.alphalayer;
			if(kag.fore.layers[alc] !== void){
				alphalayer = kag.fore.layers[alc];
			}
		}

		alphaleff = void;
		if(elm.alphaleff !== void){
			if(elm.alphaleff == "front"){
				alphaleff = light_eff_object.main;	//foreを指定
			}else if(elm.alphaleff == "rear"){
				alphaleff = light_eff_object.main2;	//backを指定
			}
		}

		alphameff = void;
		if(elm.alphameff !== void){
			var amc = +elm.alphameff;
			if(multi_eff_object[amc] !== void) alphameff = multi_eff_object[amc];
		}
		
		/*
		alphaEffect = "false";
		if(elm.alphaeffect !== void && elm.alphaeffect == "leff"){
			alphaEffect = "leff";
			smallest = false;
		}else if(elm.alphaeffect !== void){
			smallest = false;
			var temp = +elm.alphaeffect;
			if(effect_object[temp] !== void && temp != obj_no) alphaEffect = temp;
		}
		*/
		
		// フェード設定
		if(elm.fadeintime !== void)fadeInTime = +elm.fadeintime;
		else fadeInTime = -1;
		if(elm.fadeouttime !== void)fadeOutTime = +elm.fadeouttime;
		else fadeOutTime = -1;
		
		targetLayer.absolute = absolute.params[0];
		targetLayerBack.absolute = absolute.params[0];

		/**/
		
		if(elm.alphaturn == "true") tempLayer.turnAlpha();
		if(elm.alphaturn2 == "true") tempLayer.turnAlpha3();

		RideFlag = false;
		if(elm.ride !== void && tempLayer.ereLayer !== void){
			RideFlag = true;
			RideAlphaLayer.setImageSize( targetLayer.imageWidth, targetLayer.imageHeight);	// 最小範囲なら画像サイズ×1.5準備
			RideAlphaLayer.setSizeToImageSize();											//描写レイヤの表示サイズを画像サイズに合わせる
			RideAlphaLayer.setPos(0, 0);													//
			RideAlphaLayer.visible=false;
			
			//RideLayer.visible = targetLayer.visible;
			//RideLayerBack.visible = targetLayerBack.visible;
			
			RideLayer.hitType = htMask;
			RideLayer.hitThreshold = 256;
			RideLayerBack.hitType = htMask;
			RideLayerBack.hitThreshold = 256;
			
			RideLayer.visible = foreState;
			RideLayerBack.visible = backState;
			
			RideLayer.type = tempLayer.ereLayer.RideMode;
			RideLayerBack.type = tempLayer.ereLayer.RideMode;
			
			if(elm.raa !== void){
				RideAlphaAdd = true;											//アルファ増幅を行うフラグをオンへ
				RideAlphaAddPrams.ArrayForParams(elm.raa);						//アルファ増幅用の配列の作成
				RideAlphaAddPrams.TimeForParams(totalTime);						//アルファ増幅用の時間基本値の取得
			}
		}else{
			RideFlag = false;
			RideAlphaLayer.visible=false;
			RideLayer.visible = false;
			RideLayerBack.visible = false;
		}

		AlphaAdd = false;
		ClearAlphaAdd = false;
		seeingLevel = 0;
		if(elm.alpha_add !== void){
			AlphaAdd = true;												//アルファ増幅を行うフラグをオンへ
			alpha_add.ArrayForParams(elm.alpha_add);						//アルファ増幅用の配列の作成
			alpha_add.TimeForParams(totalTime);								//アルファ増幅用の時間基本値の取得
			ClearAlphaAdd = (elm.clearalpha !== void) ? true : false;		//不透明0の物を処理しないフラグをセット
			seeingLevel = (elm.slv !== void) ? +elm.slv : 0;				//アルファ許可域に指定
		}
		
		if(elm.acb !== void){
			if(elm.a_r2 !== void || elm.a_g2 !== void || elm.a_b2 !== void){
				elm.a_r = (elm.a_r === void) ? -1 : +elm.a_r;												//彩色【Ｒ】を強制変更
				elm.a_g = (elm.a_g === void) ? -1 : +elm.a_g;												//彩色【Ｇ】を強制変更
				elm.a_b = (elm.a_b === void) ? -1 : +elm.a_b;												//彩色【Ｂ】を強制変更
				
				elm.a_r2 = (elm.a_r2 === void) ? -1 : +elm.a_r2;											//彩色【Ｒ】を強制変更
				elm.a_g2 = (elm.a_g2 === void) ? -1 : +elm.a_g2;											//彩色【Ｇ】を強制変更
				elm.a_b2 = (elm.a_b2 === void) ? -1 : +elm.a_b2;											//彩色【Ｂ】を強制変更

				tempLayer.AlphaColorBlend2(elm.a_r, elm.a_g, elm.a_b, elm.a_r2, elm.a_g2, elm.a_b2);		//彩色の変更を実行
				
			}else if(elm.a_r !== void || elm.a_g !== void || elm.a_b !== void){
				elm.a_r = (elm.a_r === void) ? -1 : +elm.a_r;					//彩色【Ｒ】を強制変更
				elm.a_g = (elm.a_g === void) ? -1 : +elm.a_g;					//彩色【Ｇ】を強制変更
				elm.a_b = (elm.a_b === void) ? -1 : +elm.a_b;					//彩色【Ｂ】を強制変更
				tempLayer.AlphaColorBlend(elm.a_r, elm.a_g, elm.a_b);			//彩色の変更を実行
			}
		}else{
			/*
			if(elm.a_r !== void || elm.a_g !== void || elm.a_b !== void){
				elm.a_r = (elm.a_r === void) ? -1 : +elm.a_r;					//彩色【Ｒ】を強制変更
				elm.a_g = (elm.a_g === void) ? -1 : +elm.a_g;					//彩色【Ｇ】を強制変更
				elm.a_b = (elm.a_b === void) ? -1 : +elm.a_b;					//彩色【Ｂ】を強制変更
				tempLayer.AlphaColorRect(elm.a_r, elm.a_g, elm.a_b);			//彩色の変更を実行
			}
			*/
		}
		
		/*追加*/
		if(BeforeRaster){
			BackupTempSaveLayer(elm);
			BeforeRasterTime = totalTime * BeforeRasterCycle;
		}

		if(AfterRaster){ AfterRasterTime = totalTime * AfterRasterCycle;}
		
		timingForMosaic = "after";
		if(elm.addmosaic !== void){
			if(elm.addmosaic == "before"){
				timingForMosaic = "before";
				BackupTempSaveLayer(elm);
			}
		}

		firstTime = true;
		/*
		xorIMG = -1;
		if(elm.xorimg !== void){
			xorIMG = +elm.xorimg;
		}
		*/
		
		// 時間が一秒未満だった場合即終了
		if(endflag){
			targetLayer.visible = foreState;
			targetLayerBack.visible = backState;
			
			alive = true;
			moving = false;
			
			if(!replacement){
				finish();
			}else{
				twoDrawFlag = true;
				replacement_finish();
			}
			return;
		}
		
		// 初期位置に表示
		if(delay == 0){
			Offsettick = 0;
			moveFunc(0,0);
			targetLayer.visible = foreState;
			targetLayerBack.visible = backState;
		}else if(delayVisible){
			/*特殊記述*/
			Offsettick = 0;
			moveFunc(0,0);
			targetLayer.visible = foreState;
			targetLayerBack.visible = backState;
		}

		if(elm.ridealpha !== void){
			targetLayer.doGrayScale();
			targetLayer.LightForAlpha(targetLayer);
		}

		if(elm.hang === void){
			// 開始
			lastTick = startTick = System.getTickCount();
			OffsetlastTick = OffsetstartTick = lastTick;
			System.addContinuousHandler(continuousHandler);
		}else{
			lastTick = startTick = RegistrationHangObj(+elm.hang);
			OffsetlastTick = OffsetstartTick = lastTick;
		}
		moving = true;
		alive = true;
	}

	
	//
	function ReloadImage(){
		if(alive){
			var elm = %[];
			var tmp_moving = moving;
			var temp_elm = new Dictionary();
			var temp_storage = elm.storage;
			(Dictionary.assign incontextof temp_elm)(storeDic);
			(Dictionary.assign incontextof temp_elm)(elm,false);
			(Dictionary.assign incontextof elm)(temp_elm);
			invalidate temp_elm;

			if(foreState && backState){
				elm.page = void;
				elm.xfade = false;
			}else if(foreState){
				elm.page = "fore";
				elm.show = void;
				elm.xfade = false;
			}else if(backState){
				elm.page = "back";
			}else{
				elm.page = void;
				elm.show = void;
			}
			elm.replacement = false;
			if(!tmp_moving) elm.time = 1;
			elm.delay = void;
			elm.img = "true";

			startEffect(elm);
			
			
			/*
			var newStorage = renameImagesByTitle(elm.storage);
			
			if(newStorage != elm.storage){
				if(foreState && backState){
					elm.page = void;
					elm.xfade = false;
				}else if(foreState){
					elm.page = "fore";
					elm.show = void;
					elm.xfade = false;
				}else if(backState){
					elm.page = "back";
				}else{
					elm.page = void;
					elm.show = void;
				}
				elm.replacement = false;
				if(!tmp_moving) elm.time = 1;
				elm.delay = void;
				elm.img = "true";

				startEffect(elm);
			}
			*/
		}
	}
	
	function moveAtWithFillRect( m00, m01, m10, m11, mtx, mty )
	{
		ImageFunction.fillRect(targetBmp, fillColor);
		ImageFunction.operateAffine(targetBmp, tempBmp, m00, m01, m10, m11, mtx, mty, , , true, omOpaque, dfOpaque, 255, affineType, false);
	}

	function blurAt( m00, m01, m10, m11, mtx, mty )
	{
		targetLayer.operateAffine(
					tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
					m00, m01, m10, m11, mtx, mty, omAuto, blend, affineType
					);
		//targetLayerBack.assignImages(targetLayer);
	}

	function moveAt( m00, m01, m10, m11, mtx, mty )
	{
		
		ImageFunction.fillRect(targetBmp,0x0);
		ImageFunction.operateAffine(targetBmp, tempBmp, m00, m01, m10, m11, mtx, mty, , , true, omOpaque, dfOpaque, 255, affineType, false);
		
		/*
		if(xfade){
			targetLayerBack.affineCopy(
					tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
					m00, m01, m10, m11, mtx, mty, affineType, clear
					);
		}else if(replacement){
			targetLayerBack.affineCopy(
					tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
					m00, m01, m10, m11, mtx, mty, affineType, clear
					);
			ImageFunction.operateAffine(targetBmp,tempBmp,m00,m01,m10,m11,mtx,mty,,,true);
		}else{
			// アフィン変換転送
			targetLayer.affineCopy(
						tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
						m00, m01, m10, m11, mtx, mty, affineType, clear
						);
			ImageFunction.operateAffine(targetBmp,tempBmp,m00,m01,m10,m11,mtx,mty,,,true);
			//targetLayerBack.assignImages(targetLayer);
		}
		*/
	}

	function ridemoveAt( m00, m01, m10, m11, mtx, mty )
	{
		with(tempLayer){
			if(xfade){
				RideAlphaLayer.affineCopy(
						.ereLayer, 0, 0, .ereLayer.imageWidth, .ereLayer.imageHeight, true,
						m00, m01, m10, m11, mtx, mty, affineType, clear
						);
			}else if(replacement){
				RideAlphaLayer.affineCopy(
						.ereLayer, 0, 0, .ereLayer.imageWidth, .ereLayer.imageHeight, true,
						m00, m01, m10, m11, mtx, mty, affineType, clear
						);
			}else{
				// アフィン変換転送
				RideAlphaLayer.affineCopy(
						.ereLayer, 0, 0, .ereLayer.imageWidth, .ereLayer.imageHeight, true,
						m00, m01, m10, m11, mtx, mty, affineType, clear
						);
			}

			RideLayer.assignImages(.ereLayer.RideTmp);			//
			RideLayer.setSizeToImageSize();
			RideLayer.MaskRect(0, 0, .ereLayer.RideAlpha, 0, 0, .ereLayer.RideAlpha.imageWidth, .ereLayer.RideAlpha.imageHeight, 3);
			//dm("RW:"+RideLayer.imageWidth+" RH:"+RideLayer.imageHeight);
			//dm("RAW:"+RideAlphaLayer.imageWidth+" RAH:"+RideAlphaLayer.imageHeight);
			if(RideLayer.imageWidth == RideAlphaLayer.imageWidth && RideLayer.imageHeight == RideAlphaLayer.imageHeight){
				RideLayer.MaskRect(0, 0, RideAlphaLayer, 0, 0, RideAlphaLayer.imageWidth, RideAlphaLayer.imageHeight, 3);
			}else{
				dm("処理不能");
			}
			RideLayer.setSizeToImageSize();
		}
	}

	function RasterNowTick(tick,SetTotalTime){
		var ttick = tick \ SetTotalTime;
		var ntick = tick - (ttick * SetTotalTime);
		return ntick;
	}
	
	function BeforeHandle(tick){
		var _bbx = bbx.GetNowParams(tick);
		var _bby = bby.GetNowParams(tick);

		/*
		inheritState["bbx"] = _bbx;
		inheritState["bby"] = _bby;
		*/
		
		var _rect = new Rect(0,0,tempLayer.width,tempLayer.height);

		if((_bbx != 0 || _bby != 0) && bbExtend){
			//dm("BHBB(" + _bbx + "," + _bby + ")");
			//領域拡張処理
			var __bbx = (bbSquare) ? _bbx * 2 : _bbx;
			var __bby = (bbSquare) ? _bby * 2 : _bby;

			//レイヤー→レイヤー貼り付け→Bmp ←こっちの方が早い
			//レイヤー→BMP→BMP貼り付け
			var tmp = new Layer(window, kag.fore.base);
			tmp.setImageSize(tempLayer.width + __bbx * 2,tempLayer.height + __bby * 2);
			tmp.copyRect(__bbx,__bby,tempLayer,0,0,tempLayer.width,tempLayer.height);
			tmp.copyToBitmapFromMainImage(tempBmp);
				
			_rect.width = tempBmp.width;
			_rect.height = tempBmp.height;
			invalidate tmp;
		}else{
			tempLayer.copyToBitmapFromMainImage(tempBmp);
			//tempBmp.independ(true);
			/*
			var tmp = new Bitmap();
			tempLayer.copyToBitmapFromMainImage(tmp);
			dm("(" + tmp.width + "," + tmp.height + ")");
			dm("(" + tempBmp.width + "," + tempBmp.height + ")");
			ImageFunction.operateRect(tempBmp, 0, 0, tmp, , , omAlpha, dfAlpha,,);
			invalidate tmp;
			*/
		}
		
		if(BeforeRaster){
			var rmh = BeforeRasterMaxHeight.GetNowParams(tick);
			var rl = BeforeRasterLine.GetNowParams(tick);
			
			if(rmh >= 1){
				//初期化
				var tmp = new Layer(kag, kag.fore.base);
				tmp.assignImages(tempSaveLayer);
				tmp.setSizeToImageSize();
				tempLayer.fillRect(0, 0, tempLayer.width, tempLayer.height, 0x0);
				//tempLayer.copyRaster2(tempSaveLayer, rmh, rl, RasterCycle, tick);

				if(BeforeRasterStyle == "v" || BeforeRasterStyle == "vh"){
					if(BeforeRasterInterpolation) tempLayer.copyVerticalInterpolationRaster(tmp, rmh, rl, BeforeRasterDomain, BeforeRasterTime, RasterNowTick(tick,BeforeRasterTime));
					else tempLayer.copyVerticalNotInterpolationRaster(tmp, rmh, rl, BeforeRasterDomain, BeforeRasterTime, RasterNowTick(tick,BeforeRasterTime));
				}

				if(BeforeRasterStyle == "vh"){
					tmp.assignImages(tempLayer);
					tmp.setSizeToImageSize();
					tempLayer.fillRect(0, 0, tempLayer.width, tempLayer.height, 0x0);
				}

				if(BeforeRasterStyle == "h" || BeforeRasterStyle == "vh"){
					if(BeforeRasterInterpolation) tempLayer.copyInterpolationRaster(tmp, rmh, rl, BeforeRasterDomain, BeforeRasterTime, RasterNowTick(tick,BeforeRasterTime));
					else tempLayer.copyNotInterpolationRaster(tmp, rmh, rl, BeforeRasterDomain, BeforeRasterTime, RasterNowTick(tick,BeforeRasterTime));
				}
				
				tempLayer.setSizeToImageSize();
			}else{
				tempLayer.assignImages(tempSaveLayer);
				tempLayer.setSizeToImageSize();
			}
		}

		if(timingForMosaic == "before"){
			var _mosaic = (int)mosaic.GetNowParams(tick);
			
			if(_mosaic >= 2){
				tempLayer.fillRect(0, 0, tempLayer.width, tempLayer.height, 0x0);
				tempLayer.AddMosaic(tempSaveLayer,_mosaic);
				tempLayer.setSizeToImageSize();
			}else{
				tempLayer.assignImages(tempSaveLayer);
				tempLayer.setSizeToImageSize();
			}
		}

		//元画像にかかわらない処理
		//残像処理
		if(afterImageOpacity != 0){
			afterImageCount++;
			if(afterImageCount >= afterImageSkip){
				afterImageCount = 0;
				for(var i = afterImageMax - 1; i >= 0; i--){
					if(i == 0){
						afterLayer[i].assignImages(targetLayer);
						afterLayer[i].setSizeToImageSize();
						afterLayer[i].absolute = targetLayer.absolute;
						afterLayerBack[i].assignImages(targetLayerBack);
						afterLayerBack[i].setSizeToImageSize();
						afterLayerBack[i].absolute = targetLayer.absolute;
					}else{
						afterLayer[i].assignImages(afterLayer[i - 1]);
						afterLayer[i].setSizeToImageSize();
						afterLayer[i].absolute = afterLayer[i - 1].absolute;
						afterLayerBack[i].assignImages(afterLayerBack[i - 1]);
						afterLayerBack[i].setSizeToImageSize();
						afterLayerBack[i].absolute = afterLayer[i - 1].absolute;
					}
				}
				if(afterImageMax < afterLayer.count) afterImageMax++;
			}
		}

		if(bbType != 1){
			if(_bbx != 0 || _bby != 0){
				ImageFunction.doBoxBlur(tempBmp,_bbx,_bby);
				if(bbSquare) ImageFunction.doBoxBlur(tempBmp,_bbx,_bby);
			}
		}
		invalidate _rect;
	}
	
	function AfterHandle(tick){
		if(bbType != -1){
			var _bbx = bbx.GetNowParams(tick);
			var _bby = bby.GetNowParams(tick);

			/*
			inheritState["bbx"] = _bbx;
			inheritState["bby"] = _bby;
			*/
			
			if(_bbx != 0 || _bby != 0){
				//dm("AHBB(" + _bbx + "," + _bby + ")");
				var _rect = new Rect(0,0,targetBmp.width,targetBmp.height);
				ImageFunction.doBoxBlur(targetBmp,_bbx,_bby);
				if(bbSquare) ImageFunction.doBoxBlur(targetBmp,_bbx,_bby);
				invalidate _rect;
			}
		}
		
		/*
		if(xorIMG > -1){
			targetLayer.PixelAlphaXOR(effect_object[xorIMG].targetLayer);
		}*/
		/*
		grayscale
		右に6つシフト
		*/
		if(xfade){
			targetLayerBack.copyFromBitmapToMainImage(targetBmp);
		}else if(replacement){
			targetLayerBack.copyFromBitmapToMainImage(targetBmp);
		}else{
			targetLayer.copyFromBitmapToMainImage(targetBmp);
			targetLayerBack.copyFromBitmapToMainImage(targetBmp);
		}
		
		AccompanyEffect(tick);
		
		firstTime = false;
	}
	
	function BackupTempSaveLayer(elm){
		tempSaveLayer.assignImages(tempLayer);
		tempSaveLayer.setSizeToImageSize();
	}
	
	function RestoreTempSaveLayer(){
		tempLayer.assignImages(tempSaveLayer);
		tempLayer.setSizeToImageSize();
	}
	
	function AccompanyEffect(tick){
		
		if(alphaEffect !== void){
			if(!smallest && !alphaEffect.smallest){
				if(alphaEffect.alive){
					if(!replacement){
						targetLayer.MaskRect(0, 0, alphaEffect.targetLayer, 0, 0, targetLayer.imageWidth, targetLayer.imageHeight,3);
					}else{
						targetLayerBack.MaskRect(0, 0, alphaEffect.targetLayer, 0, 0, targetLayerBack.imageWidth, targetLayerBack.imageHeight,3);
					}
				}
			}
		}

		if(alphameff !== void){
			if(!smallest){
				if(alphameff.alive){
					if(!replacement){
						targetLayer.MaskRect(0, 0, alphameff.targetLayer, 0, 0, targetLayer.imageWidth, targetLayer.imageHeight,3);
					}else{
						targetLayerBack.MaskRect(0, 0, alphameff.targetLayer, 0, 0, targetLayerBack.imageWidth, targetLayerBack.imageHeight,3);
					}
				}
			}
		}
		
		/*
		if(alphaleff !== void){
			if(!smallest){
				if(light_eff_object.main.visible){
					targetLayer.MaskRect(0, 0, light_eff_object.main, 0, 0, targetLayer.imageWidth, targetLayer.imageHeight,3);
				}
			}
		}*/
		
		/*
		if(alphaEffect != "false"){
			//処理の変更
			if(alphaEffect != "leff"){
				if(!smallest && !effect_object[alphaEffect].smallest){
					if(effect_object[alphaEffect].alive){
						if(!replacement){
							targetLayer.MaskRect(0, 0, effect_object[alphaEffect].targetLayer, 0, 0, targetLayer.imageWidth, targetLayer.imageHeight,3);
						}else{
							targetLayerBack.MaskRect(0, 0, effect_object[alphaEffect].targetLayer, 0, 0, targetLayerBack.imageWidth, targetLayerBack.imageHeight,3);
						}
					}
				}
			}else{
				if(!smallest){
					if(light_eff_object.main.visible){
						targetLayer.MaskRect(0, 0, light_eff_object.main, 0, 0, targetLayer.imageWidth, targetLayer.imageHeight,3);
					}
				}
			}
		}
		*/
		
		if(anm_noise){
			targetLayer.generateWhiteNoise();
		}

		if(AlphaAdd){
			var _a_add = (int)(alpha_add.GetNowParams(tick));
			
			if(seeingLevel == 0){
				targetLayer.AlphaAdd(_a_add,ClearAlphaAdd);
			}else{
				targetLayer.AlphaAdd2(_a_add,seeingLevel);
			}
		}

		if(EMflag){
			var _e_mask = (int)(EffectMask.GetNowParams(tick));
			var _m_level_a = (int)(MaskLevelA.GetNowParams(tick));
			var _m_level_b = (int)(MaskLevelB.GetNowParams(tick));

			var ATLayer = void;
			if(EMATflag){ ATLayer = EMATLayer;
			}else{ ATLayer = alphaLayer;}
			
			
			if(RTLflag2){
				targetLayer.MaskImageRideRect8(RideTargetLayer,ATLayer,_e_mask);
				RideLayer.fillRect(0,0,RideLayer.imageWidth,RideLayer.imageHeight,0x0);
				RideLayer.visible = true;
				RideLayerBack.visible = true;
				RideLayer.AlphaBorderImageCoverRect(RideTargetLayer2,targetLayer,ATLayer,_e_mask,_m_level_a);
				RideLayerBack.assignImages(RideLayer);
			}else if(EMSflag){
				RideLayer.fillRect(0,0,RideLayer.imageWidth,RideLayer.imageHeight,0x0);
				targetLayer.AlphaBorderInnerRect(ATLayer,_e_mask);
				RideLayer.visible = true;
				RideLayerBack.visible = true;
				RideLayer.MaskImageRideRect7(RideTargetLayer,ATLayer,_e_mask,_m_level_a);
				RideLayerBack.assignImages(RideLayer);
				
			}else if(RTLflag){
				//targetLayer.MaskImageRideRect5(RideTargetLayer,ATLayer,_e_mask,_m_level_a);
				targetLayer.MaskImageRideRect4(RideTargetLayer,ATLayer,_e_mask,_m_level_b, R_em, G_em, B_em);
			}else if(EMRflag){
				if(EMRmode == 2){
					targetLayer.MaskImageRideRect3(ATLayer,_e_mask,_m_level_b, R_em, G_em, B_em);
				}else if(EMRmode == 1){
					targetLayer.MaskImageRideRect2(ATLayer,_e_mask,_m_level_a, R_em, G_em, B_em);
				}else{
					targetLayer.MaskImageRideRect(ATLayer,_e_mask,_m_level_a,_m_level_b, R_em, G_em, B_em);
				}
			}else if(EMAflag){
				targetLayer.MaskImageEffectRect(ATLayer,_e_mask,_m_level_a,_m_level_b, R_em, G_em, B_em);
			}else{
				targetLayer.LevelMaskRect2(_e_mask,_m_level_a,_m_level_b);
			}
		}
		
		if(MoveColorFlag){
			var r_g = rgamma.GetNowParams(tick);
			var g_g = ggamma.GetNowParams(tick);
			var b_g = bgamma.GetNowParams(tick);
			var r_f = rfloor.GetNowParams(tick);
			var g_f = gfloor.GetNowParams(tick);
			var b_f = bfloor.GetNowParams(tick);
			var r_c = rceil.GetNowParams(tick);
			var g_c = gceil.GetNowParams(tick);
			var b_c = bceil.GetNowParams(tick);
			
			//色調が変化する時のみ
			/*
			inheritState["rgamma"] = r_g;
			inheritState["ggamma"] = g_g;
			inheritState["bgamma"] = b_g;
			inheritState["rfloor"] = r_f;
			inheritState["gfloor"] = g_f;
			inheritState["bfloor"] = b_f;
			inheritState["rceil"] = r_c;
			inheritState["gceil"] = g_c;
			inheritState["bceil"] = b_c;
			*/
			
			//色調の変更
			if(grayscaleFlag)targetLayer.doGrayScale();
			if(sepiaFlag){
				targetLayer.doGrayScale();
				r_g = 1.3;
				g_g = 1.1;
				b_g = 1.0;
			}
			if(turnFlag){
				targetLayer.adjustGamma(r_g, r_c, r_f, g_g, g_c, g_f, b_g, b_c, b_f);
			}else{
				targetLayer.adjustGamma(r_g, r_f, r_c, g_g, g_f, g_c, b_g, b_f, b_c);
			}
		}

		if(AfterRaster){
			var rmh = AfterRasterMaxHeight.GetNowParams(tick);
			var rl = AfterRasterLine.GetNowParams(tick);
			
			if(rmh >= 1){
				var tmp = new Layer(kag, kag.fore.base);
				tmp.assignImages(targetLayer);
				tmp.setSizeToImageSize();
				targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, 0x0);
				
				if(AfterRasterStyle == "v" || AfterRasterStyle == "vh"){
					if(AfterRasterInterpolation) targetLayer.copyVerticalInterpolationRaster(tmp, rmh, rl, AfterRasterDomain, AfterRasterTime, RasterNowTick(tick,AfterRasterTime));
					else targetLayer.copyVerticalNotInterpolationRaster(tmp, rmh, rl, AfterRasterDomain, AfterRasterTime, RasterNowTick(tick,AfterRasterTime));
				}

				if(AfterRasterStyle == "vh"){
					tmp.assignImages(targetLayer);
					tmp.setSizeToImageSize();
					targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, 0x0);
				}
				
				if(AfterRasterStyle == "h" || AfterRasterStyle == "vh"){
					if(AfterRasterInterpolation) targetLayer.copyInterpolationRaster(tmp, rmh, rl, AfterRasterDomain, AfterRasterTime, RasterNowTick(tick,AfterRasterTime));
					else targetLayer.copyNotInterpolationRaster(tmp, rmh, rl, AfterRasterDomain, AfterRasterTime, RasterNowTick(tick,AfterRasterTime));
				}
				
				invalidate tmp;
			}
		}

		if(timingForMosaic == "after"){
			var _mosaic = (int)mosaic.GetNowParams(tick);
			if(_mosaic >= 2){
				var tmp = new Layer(kag, kag.fore.base);
				tmp.assignImages(targetLayer);
				tmp.setSizeToImageSize();
				targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, 0x0);
				targetLayer.AddMosaic(tmp,_mosaic);
				invalidate tmp;
			}
		}
		
		if(!twoDrawFlag){
			targetLayerBack.assignImages(targetLayer);
		}
	}
	
	function LinearMover(tick,otick=0)
	{
		BeforeHandle(tick);
		
		if(CopyEffect != -1){
			tempLayer.assignImages(effect_object[CopyEffect].targetLayer);
			tempLayer.parent = kag.fore.base;
			tempLayer.type = ltAlpha;
		}
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
		var l = ((ex-sx)*ratio + sx);
		var t = ((ey-sy)*ratio + sy);

		var rel = l;
		var ret = t;

		
		// 最小範囲の場合、座標移動を行う
		if(smallest){
			var ___x = (int)Math.floor(l);
			var ___y = (int)Math.floor(t);
			l -= ___x;
			t -= ___y;
			targetLayer.setPos(___x-targetLayer.imageWidth\2, ___y-targetLayer.imageHeight\2);
			targetLayerBack.setPos(targetLayer.left, targetLayer.top);
		}
		
// 唐突に不透明度を変更するための処理。必要であれば。
//		var _opacity;
//		if(eo > 255){
//			_opacity = (so > 255) ? (so-256) : so;
//		}else{
//			so = (so > 255) ? (so-256) : so;
//			eo = (eo > 255) ? (eo-256) : eo;
//			_opacity = int((eo-so)*ratio + so);
//		}

		var _opacity = eo >= 256 ? so : int((eo-so)*ratio + so);

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
		_opacity *= oo;
		
		if(fadeInTime != -1){
			if(tick < fadeInTime){
				_opacity *= (tick/fadeInTime);
			}else{
				fadeInTime = -1;
			}
		}
		if(fadeOutTime != -1){
			var remTime = totalTime-tick;
			if(remTime < 0)_opacity = 0;
			else if(remTime <= fadeOutTime){
				_opacity *= (remTime/fadeOutTime);
			}
		}

		
		_opacity = _opacity > 0 ? _opacity : 0;
		targetLayer.opacity = targetLayerBack.opacity = _opacity;

		//現在のポジションの不透明度
		/*
		if(lu_corner){
			inheritState["x"] = targetLayer.left;
			inheritState["y"] = targetLayer.top;
		}
		inheritState["o"] = targetLayer.opacity;
		*/

		//
		if(MultiDrawFlag){
			var tempnum = tempImage.GetNowParams(tick);
			tempLayer = storageBox[tempnum];
		}

		var tmpW = +tempBmp.width;
		var tmpH = +tempBmp.height;

		
		// 角度・拡大率計算
		var r = rad.GetNowParams(tick);
        var s = size.GetNowParams(tick);
		var s_x = xsize.GetNowParams(tick);
		var s_y = ysize.GetNowParams(tick);
        var xsp = xspin.GetNowParams(tick);
		var ysp = yspin.GetNowParams(tick);
		var abs = absolute.GetNowParams(tick);
		var c_x = cx.GetNowParams(tick) * tmpW;
		var c_y = cy.GetNowParams(tick) * tmpH;
		
		var rec_x = 0;
		var rec_y = 0;
		
		if(RideFlag){
			rec_x = cx.GetNowParams(tick) * tempLayer.ereLayer.imageWidth;
			rec_y = cy.GetNowParams(tick) * tempLayer.ereLayer.imageHeight;
		}
		
		if(margin_x != 0){
			var mx_rate = ((s * s_x * tmpW) - (margin_x*2)) / (s * s_x * tmpW);
			s_x = s_x * mx_rate;
			//dm("mx_rate:"+mx_rate);
		}
		if(margin_y != 0){
			var my_rate = ((s * s_y * tmpH) - (margin_y*2)) / (s * s_y * tmpH);
			s_y = s_y * my_rate;
			//dm("my_rate:"+my_rate);
		}

		/*
		inheritState["r"] = r;
		inheritState["s"] = s;
		inheritState["s_x"] = s_x;
		inheritState["s_y"] = s_y;
		inheritState["xspin"] = xsp;
		inheritState["yspin"] = ysp;
		inheritState["absolute"] = abs;
		inheritState["cx"] = c_x;
		inheritState["cy"] = c_y;
		*/
		
		targetLayer.absolute = abs;
		targetLayerBack.absolute = targetLayer.absolute;
		
		if(lu_corner){
			l += (tmpW/2)*s;
			t += (tmpH/2)*s;
		}else if(pathtype){
			// pathで指定するのは画面の中心に画像のどこのピクセルをを持ってくるか
			//l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-cx)*s;
			//t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-cy)*s;

			l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-c_x)*s;
			t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-c_y)*s;
		}else{
			// pathで指定するのは画像における中心を画面のどこに置くか
			l -= (tmpW/2-c_x)*s;
			t -= (tmpH/2-c_y)*s;
			
			if(RideFlag){
				rel -= (tempLayer.ereLayer.imageWidth/2-rec_x)*s;
				ret -= (tempLayer.ereLayer.imageHeight/2-rec_y)*s;
			}
		}

		// メンバに現在座標をセット
		gl_l = l;
		gl_t = t;

		//現在のポジションのデータ
		/*
		if(!lu_corner){
			inheritState["x"] = gl_l;
			inheritState["y"] = gl_t;
		}
		*/
		
		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI/2.0) - r);
		
		// 縦・横回転のコード
		var xrate = 1, yrate = 1;
		xrate = Math.sin(Math.PI*(xsp * 2 + 0.5));
		yrate = Math.sin(Math.PI*(ysp * 2 + 0.5));

		/*
		//旧コードスピンのみの対応
		var rate = (tick/totalTime);
		var xrate = 1, yrate = 1;
		if(xspin != 0){
			xrate = rate*(2*xspin)+0.5;
			xrate = Math.sin(Math.PI*xrate);
		}
		if(yspin != 0){
			yrate = rate*(2*yspin)+0.5;
			yrate = Math.sin(Math.PI*yrate);
		}
		*/

		var m00 = s * rc * yrate * s_x;
		var m01 = s * -rs * yrate * s_x;
		var m10 = s * rs * xrate * s_y;
		var m11 = s * rc * xrate * s_y;
		//var mtx = (m00*-cx) + (m10*-cy) + l;
		//var mty = (m01*-cx) + (m11*-cy) + t;

		var mtx = ((m00*-c_x) + (m10*-c_y) + l);
		var mty = ((m01*-c_x) + (m11*-c_y) + t);

		var remtx = ((m00*-rec_x) + (m10*-rec_y) + rel);
		var remty = ((m01*-rec_x) + (m11*-rec_y) + ret);
		
		if(smallest){
			mtx += targetLayer.imageWidth\2;
			mty += targetLayer.imageHeight\2;
		}
		
		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty);
		
		if(RideFlag){
			RidezoomFunc(m00, m01, m10, m11, remtx, remty);
			if(RideAlphaAdd){
				var ra_add = (int)(RideAlphaAddPrams.GetNowParams(tick));
				RideLayer.AlphaAdd(ra_add,false);
			}
			RideLayerBack.assignImages(RideLayer);
			RideLayerBack.setSizeToImageSize();
			
			RideLayer.absolute = targetLayer.absolute + 1;
			RideLayerBack.absolute = targetLayerBack.absolute + 1;
		}
		
		if(twoDrawFlag && !replacement){
			// アフィン変換転送
			targetLayerBack.affineCopy(
				tempLayer2, 0, 0, tempLayer2.imageWidth, tempLayer2.imageHeight, true,
				m00, m01, m10, m11, mtx, mty, affineType, clear
				);
		}
		
		//AccompanyEffect(tick);
		AfterHandle(tick);
	}

	function SplineMover(tick,otick=0)
	{
		BeforeHandle(tick);
		if(CopyEffect != -1){
			tempLayer.assignImages(effect_object[CopyEffect].targetLayer);
			tempLayer.parent = kag.fore.base;
			tempLayer.type = ltAlpha;
		}
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

		var rel = l;
		var ret = t;
		
		// 最小範囲の場合、座標移動を行う
		if(smallest){
			var ___x = (int)Math.floor(l);
			var ___y = (int)Math.floor(t);
			l -= ___x;
			t -= ___y;
			targetLayer.setPos(___x-targetLayer.imageWidth\2, ___y-targetLayer.imageHeight\2);
			targetLayerBack.setPos(targetLayer.left, targetLayer.top);
		}

		var so = p[pindex+2];
		var eo = p[pindex+5];
		
		// 唐突に不透明度を変更するための処理。必要であれば。
		//		var _opacity;
		//		if(eo > 255){
		//			_opacity = (so > 255) ? (so-256) : so;
		//		}else{
		//			so = (so > 255) ? (so-256) : so;
		//			eo = (eo > 255) ? (eo-256) : eo;
		//			_opacity = int((eo-so)*ratio + so);
		//		}

		var _opacity = eo >= 256 ? so : int((eo-so)*d + so);
		
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
		_opacity *= oo;
		_opacity = _opacity > 0 ? _opacity : 0;
		targetLayer.opacity = targetLayerBack.opacity = _opacity;
		
		//現在のポジションの不透明度
		//inheritState["o"] = targetLayer.opacity;

		//
		if(MultiDrawFlag){
			var tempnum = tempImage.GetNowParams(tick);
			tempLayer = storageBox[tempnum];
		}

		var tmpW = tempBmp.width;
		var tmpH = tempBmp.height;
		
		// 角度・拡大率計算
		var r = rad.GetNowParams(tick);
        var s = size.GetNowParams(tick);
		var s_x = xsize.GetNowParams(tick);
		var s_y = ysize.GetNowParams(tick);
        var xsp = xspin.GetNowParams(tick);
		var ysp = yspin.GetNowParams(tick);
		var abs = absolute.GetNowParams(tick);
		var c_x = cx.GetNowParams(tick) * tmpW;
		var c_y = cy.GetNowParams(tick) * tmpH;

		var rec_x = 0;
		var rec_y = 0;
		
		if(RideFlag){
			rec_x = cx.GetNowParams(tick) * tempLayer.ereLayer.imageWidth;
			rec_y = cy.GetNowParams(tick) * tempLayer.ereLayer.imageHeight;
		}
		
		if(margin_x != 0){
			var mx_rate = ((s * s_x * tmpW) - (margin_x*2)) / (s * s_x * tmpW);
			s_x = s_x * mx_rate;
			//dm("mx_rate:"+mx_rate);
		}
		if(margin_y != 0){
			var my_rate = ((s * s_y * tmpH) - (margin_y*2)) / (s * s_y * tmpH);
			s_y = s_y * my_rate;
			//dm("my_rate:"+my_rate);
		}

		/*
		inheritState["r"] = r;
		inheritState["s"] = s;
		inheritState["s_x"] = s_x;
		inheritState["s_y"] = s_y;
		inheritState["xspin"] = xsp;
		inheritState["yspin"] = ysp;
		inheritState["absolute"] = abs;
		inheritState["cx"] = c_x;
		inheritState["cy"] = c_y;
		*/
		
		targetLayer.absolute = abs;
		targetLayerBack.absolute = targetLayer.absolute;
		
		if(pathtype == "true"){
			// pathで指定するのは画面の中心に画像のどこのピクセルをを持ってくるか
			//l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-cx)*s;
			//t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-cy)*s;
			l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-c_x)*s;
			t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-c_y)*s;
		}else{
			// pathで指定するのは画像における中心を画面のどこに置くか
			//l -= (tempLayer.imageWidth/2-cx)*s;
			//t -= (tempLayer.imageHeight/2-cy)*s;
			l -= (tmpW/2-c_x)*s;
			t -= (tmpH/2-c_y)*s;

			if(RideFlag){
				rel -= (tempLayer.ereLayer.imageWidth/2-rec_x)*s;
				ret -= (tempLayer.ereLayer.imageHeight/2-rec_y)*s;
			}
		}
		
		// メンバに現在座標をセット
		gl_l = l;
		gl_t = t;
		
		//現在のポジションのデータ
		/*
		inheritState["x"] = gl_l;
		inheritState["y"] = gl_t;
		*/
		
		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI/2.0) - r);
		
		// 縦・横回転のコード
		var xrate = 1, yrate = 1;
		xrate = Math.sin(Math.PI*(xsp * 2 + 0.5));
		yrate = Math.sin(Math.PI*(ysp * 2 + 0.5));
		
		/*
		//旧コードスピンのみの対応
		var rate = (tick/totalTime);
		var xrate = 1, yrate = 1;
		if(xspin != 0){
			xrate = rate*(2*xspin)+0.5;
			xrate = Math.sin(Math.PI*xrate);
		}
		if(yspin != 0){
			yrate = rate*(2*yspin)+0.5;
			yrate = Math.sin(Math.PI*yrate);
		}
		*/

		var m00 = s * rc * yrate * s_x;
		var m01 = s * -rs * yrate * s_x;
		var m10 = s * rs * xrate * s_y;
		var m11 = s * rc * xrate * s_y;
		//var mtx = (m00*-cx) + (m10*-cy) + l;
		//var mty = (m01*-cx) + (m11*-cy) + t;

		var mtx = (m00*-c_x) + (m10*-c_y) + l;
		var mty = (m01*-c_x) + (m11*-c_y) + t;

		var remtx = ((m00*-rec_x) + (m10*-rec_y) + rel);
		var remty = ((m01*-rec_x) + (m11*-rec_y) + ret);
		
		if(smallest){
			mtx += targetLayer.imageWidth\2;
			mty += targetLayer.imageHeight\2;
		}
		
		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty);

		if(RideFlag){
			RidezoomFunc(m00, m01, m10, m11, remtx, remty);
			if(RideAlphaAdd){
				var ra_add = (int)(RideAlphaAddPrams.GetNowParams(tick));
				RideLayer.AlphaAdd(ra_add,false);
			}
			RideLayerBack.assignImages(RideLayer);
			RideLayer.absolute = RideLayerBack.absolute = targetLayer.absolute + 1;
			RideLayerBack.setSizeToImageSize();
		}
		
		if(twoDrawFlag && !replacement){
			// アフィン変換転送
			targetLayerBack.affineCopy(
				tempLayer2, 0, 0, tempLayer2.imageWidth, tempLayer2.imageHeight, true,
				m00, m01, m10, m11, mtx, mty, affineType, clear
				);
		}
		//AccompanyEffect(tick);
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
		AllgettimeForState();
	}

	/*pathは別口に必要が有るので変更*/
	function AllgettimeForState(){
		tempImage.TimeForParams(totalTime);
		size.TimeForParams(totalTime);				// サイズ用の時間を計算
		xsize.TimeForParams(totalTime);				// サイズ用の時間を計算
		ysize.TimeForParams(totalTime);				// サイズ用の時間を計算
		rad.TimeForParams(totalTime);				// 角度用の時間を計算
		xspin.TimeForParams(totalTime);				// XSpin用の時間を計算
		yspin.TimeForParams(totalTime);				// YSpin用の時間を計算
		absolute.TimeForParams(totalTime);			// absolute用の時間を計算
		
		cx.TimeForParams(totalTime);				// cx用の時間を計算
		cy.TimeForParams(totalTime);				// cy用の時間を計算
		rgamma.TimeForParams(totalTime);			// rgamma用の時間を計算
		ggamma.TimeForParams(totalTime);			// ggamma用の時間を計算
		bgamma.TimeForParams(totalTime);			// bgamma用の時間を計算
		rfloor.TimeForParams(totalTime);			// rfloor用の時間を計算
		gfloor.TimeForParams(totalTime);			// gfloor用の時間を計算
		bfloor.TimeForParams(totalTime);			// bfloor用の時間を計算
		rceil.TimeForParams(totalTime);				// rceil用の時間を計算
		gceil.TimeForParams(totalTime);				// gceil用の時間を計算
		bceil.TimeForParams(totalTime);				// bceil用の時間を計算

		bbx.TimeForParams(totalTime);				//
		bby.TimeForParams(totalTime);				//
		
		if(BeforeRaster){
			BeforeRasterMaxHeight.TimeForParams(totalTime);	// RasterScroll用最大振幅の時間を計算
			BeforeRasterLine.TimeForParams(totalTime);		// RasterScroll用ライン数の時間を計算
		}
		
		if(AfterRaster){
			AfterRasterMaxHeight.TimeForParams(totalTime);	// RasterScroll用最大振幅の時間を計算
			AfterRasterLine.TimeForParams(totalTime);		// RasterScroll用ライン数の時間を計算
		}
		
		mosaic.TimeForParams(totalTime);							// mosaic用の時間を計算

		if(RideAlphaAdd){ RideAlphaAddPrams.TimeForParams(totalTime);}
		if(EMflag){
			EffectMask.TimeForParams(totalTime);
			MaskLevelA.TimeForParams(totalTime);
			MaskLevelB.TimeForParams(totalTime);
		}
	}
	
	function continuousHandler(tick)
	{
		//dm("obj_no:"+obj_no);
		
		// コンソールにfpsを表示する
		//dm("■1loopの所要時間：" + (tick-lastTick));
		//dm("■FPS：" + 1000/(tick-lastTick));
		
		if(delay != 0){
			var t = (tick-startTick);
			if(delay < t){
				delay = 0;
				lastTick = startTick = System.getTickCount();
				moveFunc(0,0);
				targetLayer.visible = foreState;
				targetLayerBack.visible = backState;
			}
			return;
		}
		
		//dm("■FPS：" + 1000/(tick-lastTick));

		Offsettick = tick;
		OffsetlastTick = Offsettick;
		Offsettick -= OffsetstartTick;
		
		if(Offsettick >= OffsettotalTime){
			if(Offsetloop && OffsetloopCount != 0){
				if(OffsetloopCount >= 0){ OffsetloopCount--;}
				OffsetstartTick = OffsetstartTick + OffsettotalTime;
				Offsettick = Offsettick - OffsettotalTime;
				//ここを修正
				
			}else{
				Offsettick = OffsettotalTime;
			}
		}
		
		lastTick=tick;
		tick -= startTick;
		
		// 時間通りか過ぎてるなら終わる
		if(tick >= totalTime)
		{
			if(loop){
				//前回の最終描画計算を引き継ぐ
				/*
				if(inherit == true){
					//前回の配列の第一配列を削除
					for(var i=0;i < 3;i++){path.shift();}
					rad.shift();
					size.shift();
					xsize.shift();
					ysize.shift();
					xspin.shift();
					yspin.shift();
					absolute.shift();
					cx.shift();
					cy.shift();
					
					rgamma.shift();
					ggamma.shift();
					bgamma.shift();
					rfloor.shift();
					gfloor.shift();
					bfloor.shift();
					rceil.shift();
					gceil.shift();
					bceil.shift();

					bbx.shift();
					bby.shift();
					
					if(moveFunc == SplineMover){
						PreSpline(path, zx, zy);
					}
			
					inherit = false;
					startTick = startTick + time;
				}
				*/
				
				// もしループフラグが立ってるなら初期値に戻す
				//startTick = System.getTickCount();
				if(loopCount == -1){
					startTick = startTick + totalTime;
					tick = tick - totalTime;
				}else if(loopCount > 0){
					startTick = startTick + totalTime;
					tick = tick - totalTime;
					loopCount--;
				}else{
					/*
					//別オブジェクトの完全同期用
					for(var i = 0; i < hangObj.count; i++){
						var hang = CallIdObject(hangObj[i]);
						hang.continuousHandler(lastTick);
					}
					*/
					finish();
					return;
				}
			}else{
				if(afterImageOpacity != 0){
					if(afterImageStopCount<=0){
						finish();
						return;
					}else{
						var aic = afterImageCount;
						aic++;
						if(aic >= afterImageSkip) afterImageStopCount--;
						tick = totalTime;
					}
					moveFunc(tick);
					return;
				}
				
				//別オブジェクトの完全同期用
				/*
				for(var i = 0; i < hangObj.count; i++){
					var hang = CallIdObject(hangObj[i]);
					hang.continuousHandler(lastTick);
				}
				*/
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
		}else if(accel < 0){
			// 上弦 ( 最初が動きが早く、徐々に遅くなる )
			tick = 1.0 - tick / totalTime;
			tick = Math.pow(tick, -accel);
			tick = int ( (1.0 - tick) * totalTime );
		}else if(accel > 0){
			// 下弦 ( 最初は動きが遅く、徐々に早くなる )
			tick = tick / totalTime;
			tick = Math.pow(tick, accel);
			tick = int ( tick * totalTime );
		}
		// 移動
		moveFunc(tick,Offsettick);

		//別オブジェクトの完全同期用
		for(var i = 0; i < hangObj.count; i++){
			var hang = CallIdObject(hangObj[i]);
			hang.continuousHandler(lastTick);
		}
	}
	
	// 最終状態を表示
	function finish()
	{
		//別オブジェクトの完全同期用
		for(var i = 0; i < hangObj.count; i++){
			var hang = CallIdObject(hangObj[i]);
			hang.finish();
		}

		for(var i = 0; i < afterLayer.count;i++){
			afterLayer[i].visible = false;
			afterLayerBack[i].visible = false;
		}
		
		if(alive){
			if(clear)targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, 0x0);
			if(delay != 0){
				if(!subFlag){
					targetLayer.visible=true;
					targetLayerBack.visible=true;
				}else{
					subFlag = false;
					targetLayer.visible=false;
					targetLayerBack.visible=false;
				}
			}
			moveFunc(totalTime,OffsettotalTime);
			stop();
		}else{
			stop();
		}
	}

	function replacement_finish()
	{
		moveFunc(totalTime,OffsettotalTime);
		//twoDrawFlag = false;
		//replacement = false;
		stop();
	}

	function onTag()
	{
		if(alive && !moving)finish();
		//色調補正
	}

	function ResetStop()
	{
		if(moving)
		{
			System.removeContinuousHandler(continuousHandler);
			moving = false;
			//全ての破棄
			window.trigger('effect_plugin'+obj_no);
		}
	}
	
	// 停止
	function stop()
	{
		if(moving)
		{
			System.removeContinuousHandler(continuousHandler);
			moving = false;
			if(nextStack == -1) StackCount++;
			else StackCount = nextStack;

			//dm("StackCount:"+StackCount);
			
			if(stack.count > StackCount){
				startEffect(stack[StackCount]);
			}else{
				if(StackLoop){
					StackCount = 0;
					if(stack.count > StackCount){
						startEffect(stack[StackCount]);
					}
				}else{
					//dm("FullStop");
					StopStack();
					window.trigger('effect_plugin'+obj_no);
					DeleteHangObj();
				}
			}
		}
	}

	// 停止
	function cutin_move_stop()
	{
		if(tempLayer.cutinLayer !== void)
		{
			if(!tempLayer.cutinLayer.cmactiv && !tempLayer.cutinLayer.mmactiv && !tempLayer.cutinLayer.lmactiv){
				window.trigger('effect_plugin_cutin'+obj_no);
				tempLayer.cutinLayer.stop_move();
			}
		}
	}
	
	/*画像保存用*/
	function saveLayer(){
		targetLayer.saveLayerImage(System.exePath+"obj_"+obj_no+".png","png");
	}
	
	/*アルファ画像作成用*/
	/*
	function load_alpha_make(str){
		var _alpha_make = [].split("()", str, , true);
		if(_alpha_make.count >= 1){
			var _atype = Composition(_alpha_make[0]);
			var atmp1 = new Layer(window, kag.fore.base);
			var atmp2 = new Layer(window, kag.fore.base);
			var lx = 0;
			var rx = 0;
			var ty = 0;
			var by = 0;
			
			var sl = 0;
			var st = 0;
			var sw = 0;
			var sh = 0;
			var il = 0;
			var it = 0;
			var iw = kag.scWidth;
			var ih = kag.scHeight;
			var _am = [].split(", ", _alpha_make[1], , true);
			if(_am[1] !== void){_am[1] = +_am[1];}else{_am.add(0);}
			if(_am[2] !== void){_am[2] = +_am[2];}else{_am.add(0);}
			if(_am[3] !== void){_am[3] = +_am[3];}else{_am.add(1);}
			if(_am[4] !== void){_am[4] = +_am[4];}else{_am.add(1);}
			if(_am[3] <= 0){_am[3] = 1;si("指定サイズに0がしてされています");}
			if(_am[4] <= 0){_am[4] = 1;si("指定サイズに0がしてされています");}
			
			atmp1.loadImages((_am[0] != "true") ? _am[0] : "alpha_img");	//atmp1に添付
			lx = (_am[1] < 0) ? _am[1] : 0;									//全体の左端
			rx = (_am[1] > 0) ? _am[1] : 0;									//全体の右端
			ty = (_am[2] < 0) ? _am[2] : 0;									//全体の上端			
			by = (_am[2] > 0) ? _am[2] : 0;									//全体の下端
			sw = atmp1.imageWidth * _am[3];									//最終描画矩形の幅
			sh = atmp1.imageHeight * _am[4];								//最終描画矩形の高さ
			sl = (lx == 0) ? _am[1] : 0;									//最終描画スタート左端
			st = (ty == 0) ? _am[2] : 0;									//最終描画スタート上端
			il = (lx * -1) + rx;											//
			it = (ty * -1) + by;											//
			
			if(sw + il > iw){iw = sw + il;}									//矩形サイズ
			if(sh + it > ih){ih = sh + it;}									//矩形サイズ
			
			atmp2.setImageSize(sw,sh);
			atmp2.setSizeToImageSize();
			atmp2.stretchCopy( 0, 0, sw, sh, atmp1, 0, 0, atmp1.imageWidth, atmp1.imageHeight);
			alphaLayer.setImageSize(iw,ih);
			alphaLayer.setSizeToImageSize();
			if(_atype == 2 || _atype == 3){alphaLayer.fillRect(0,0,iw,ih,0xff000000);}else{alphaLayer.fillRect(0,0,iw,ih,0x00000000);}
			alphaLayer.MaskRect(sl, st, atmp2, 0, 0, atmp2.imageWidth, atmp2.imageHeight, _atype);
			
			for(var i=2;i < _alpha_make.count;i++){
				_am = [].split(", ", _alpha_make[i], , true);
				if(_am[1] !== void){_am[1] = +_am[1];}else{_am.add(0);}
				if(_am[2] !== void){_am[2] = +_am[2];}else{_am.add(0);}
				if(_am[3] !== void){_am[3] = +_am[3];}else{_am.add(1);}
				if(_am[4] !== void){_am[4] = +_am[4];}else{_am.add(1);}
				if(_am[3] <= 0){_am[3] = 1;si("指定サイズに0がしてされています");}
				if(_am[4] <= 0){_am[4] = 1;si("指定サイズに0がしてされています");}
				//準備
				atmp1.loadImages((_am[0] != "true") ? _am[0] : "alpha_img");
				
				//セット
				lx = (_am[1] < lx) ? _am[1] : lx;								//全体の左端
				rx = (_am[1] > rx) ? _am[1] : rx;								//全体の右端
				ty = (_am[2] < ty) ? _am[2] : ty;								//全体の上端
				by = (_am[2] > by) ? _am[2] : by;								//全体の下端
				
				sw = atmp1.imageWidth * _am[3];									//最終描画矩形の幅
				sh = atmp1.imageHeight * _am[4];								//最終描画矩形の高さ

				sl = (lx == _am[1]) ? 0 : _am[1]-lx;							//最終描画スタート左端
				st = (ty == _am[2]) ? 0 : _am[2]-ty;							//最終描画スタート上端
				
				il = (lx * -1) + rx;											//
				it = (ty * -1) + by;											//

				//領域外アクセス→近くの色に塗りつぶされる
				atmp2.setImageSize(sw,sh);
				atmp2.setSizeToImageSize();
				atmp2.stretchCopy( 0, 0, sw, sh, atmp1, 0, 0, atmp1.imageWidth, atmp1.imageHeight);
				
				if(sw + il > iw || sh + it > ih){
					if(sw + il > iw){iw = sw + il;}									//矩形サイズ
					if(sh + it > ih){ih = sh + it;}									//矩形サイズ
					
					alphaLayer.setImageSize(iw,ih);
					alphaLayer.setSizeToImageSize();
					if(_atype == 2 || _atype == 3){
						
						atmp1.assignImages(alphaLayer);
						alphaLayer.fillRect(0,0,alphaLayer.imageWidth, alphaLayer.imageHeight,0xff000000);
						alphaLayer.MaskRect(0, 0, atmp1, 0, 0, alphaLayer.imageWidth, alphaLayer.imageHeight, 0);
					}
				}
				alphaLayer.MaskRect(sl, st, atmp2, 0, 0, atmp2.imageWidth, atmp2.imageHeight, _atype);
			}
			for(var i=0;i < alpha_x.params.count;i++){alpha_x.params[i] = alpha_x.params[i] + lx;}
			for(var i=0;i < alpha_y.params.count;i++){alpha_y.params[i] = alpha_y.params[i] + ty;}
			invalidate atmp1;
			invalidate atmp2;
		}else{
			si("指定が有りません");

		}
	}
	*/
	
	// レイヤーを削除
	function deleteLayer()
	{
		alive = false;
		stop();
		for(var i=0;i<storageBox.count;i++){invalidate storageBox[i] if storageBox[i] !== void;}
		tempLayer = void;
		tempLayer2 = void;
		singleBase = void;
		invalidate singleBase if singleBase !== void;
		singleBase = void;
		invalidate singleBase2 if singleBase2 !== void;
		singleBase2 = void;
		invalidate tempSaveLayer if tempSaveLayer !== void;
		tempSaveLayer = void;

		invalidate tempBmp if tempBmp !== void;
		tempBmp = void;
		invalidate targetBmp if targetBmp !== void;
		targetBmp = void;
		
		invalidate targetLayer if targetLayer !== void;
		invalidate targetLayerBack if targetLayerBack !== void;
		invalidate alphaLayer if alphaLayer !== void;
		invalidate RideLayer if RideLayer !== void;
		RideLayer = void;
		invalidate RideLayerBack if RideLayerBack !== void;
		RideLayerBack = void;
		invalidate RideAlphaLayer if RideAlphaLayer !== void;
		RideAlphaLayer = void;
		
		targetLayer = targetLayerBack = alphaLayer = void;

		if(afterLayer.count > 0){
			for(var i=0;i<afterLayer.count;i++){
				invalidate afterLayer[i];
				invalidate afterLayerBack[i];
			}
			afterLayer.clear();
			afterLayerBack.clear();
		}
	}

	function clearLayer()
	{
		alive = false;
		stop();

		RideLayer.fillRect(0,0,RideLayer.imageWidth,RideLayer.imageHeight,0x0);
		RideLayer.visible=false;
		
		RideLayerBack.fillRect(0,0,RideLayerBack.imageWidth,RideLayerBack.imageHeight,0x0);
		RideLayerBack.visible=false;

		RideAlphaLayer.fillRect(0,0,RideAlphaLayer.imageWidth,RideAlphaLayer.imageHeight,0x0);
		RideAlphaLayer.visible=false;

		tempLayer = singleBase;
		tempLayer2 = singleBase2;

		ImgClearFlag = true;
		singleBase.loadImages("ImgClear");
		singleBase.setSizeToImageSize();
		singleBase2.loadImages("ImgClear");
		singleBase2.setSizeToImageSize();
		tempSaveLayer.loadImages("ImgClear");
		tempSaveLayer.setSizeToImageSize();

		for(var i=0;i<storageBox.count;i++){invalidate storageBox[i] if storageBox[i] !== void;}
		storageBox.clear();
		
		targetLayer.loadImages("ImgClear");
		targetLayer.setSizeToImageSize();
		targetLayer.visible=false;
		targetLayer.type = ltAlpha;
		
		targetLayerBack.loadImages("ImgClear");
		targetLayerBack.setSizeToImageSize();
		targetLayerBack.visible=false;
		targetLayerBack.type = ltAlpha;
		
		alphaLayer.loadImages("ImgClear");
		alphaLayer.setSizeToImageSize();
		alphaLayer.visible=false;

		if(afterLayer.count > 0){
			for(var i=0;i<afterLayer.count;i++){
				invalidate afterLayer[i];
				invalidate afterLayerBack[i];
			}
			afterLayer.clear();
			afterLayerBack.clear();
		}
		
		effectparent = void;
		layerparent = void;
		leffparent = void;
		
		alphaEffect = void;
		alphalayer = void;
		alphaleff = void;
		alphameff = void;
	}

	// 残り時間を再設定する
	function timeReset(re_time)
	{
		var nowTick = System.getTickCount();	// 現在時刻取得
		var tick = nowTick - startTick;			// 何ミリ秒経ったかを計算
		if(tick + re_time < totalTime){
			var endTick = startTick + totalTime;	// 最終時刻を取得
			var new_endTick = nowTick + re_time;	// 新しい最終時刻を設定
			var par = 1-(tick/totalTime);			// 残り時間の割合を計算
			var new_totalTime = re_time / par;		// 新しい合計時間を取得(新しい残り時間が元の残り時間の割合を満たす合計時間を算出)
			startTick = new_endTick - new_totalTime;

			// 新しい全体時間を設定
			totalTime = new_totalTime;
			// 新しい全体時間からパスで割って時間を逆算
			time = totalTime / (path.count \ 3 - 1);

			AllgettimeForState();
		}
	}

	function onStore(f, elm)
	{
		if(alive){
			var dic = f["effect" + obj_no] = %[];
			(Dictionary.assign incontextof dic)(storeDic);
			dic.moving = moving;
			dic.foreVisible = targetLayer.visible;
			dic.backVisible = targetLayerBack.visible;
			dic.deleteAfterTransFlag = deleteAfterTransFlag;
			/*スタック処理*/
			dic.stack = this.stack;
			dic.stackloop = this.StackLoop;
			dic.stackcount = this.StackCount;
			
			if(!moving){ dic.fadeintime = -1;}
			
			if(tempLayer.cutinLayer !== void){
				if(!tempLayer.cutinLayer.cmactiv && !tempLayer.cutinLayer.mmactiv && !tempLayer.cutinLayer.lmactiv){dic.cutin_end = true;
				}else{dic.cutin_end = false;}
				dic.cutin = tempLayer.cutinLayer.storeDic.cutin;
				dic.main = tempLayer.cutinLayer.storeDic.main;
				dic.line = tempLayer.cutinLayer.storeDic.line;
			}
		}else{
			f["effect" + obj_no] = void;
		}
	}

	function onRestore(f, clear, elm)
	{
		//スタックのクリア処理の追加
		
		// 栞を読み出すとき
		stop(); 		// 動作を停止
		clearLayer();	// 削除
		ClearStack();	// スタックリストをクリア
		ClearBeforeDictionary();
		//
		
		var dic = f["effect" + obj_no];
		if(dic !== void){
			if(dic.replacement !== void) dic.replacement = "false";
			if(dic.stack !== void) this.stack.assign(dic.stack);
			if(dic.stackloop !== void) this.StackLoop = dic.stackloop;
			if(dic.stackcount !== void) this.StackCount = dic.stackcount;
			
			StackLoopCheck(dic);
			
			if(this.stack.count <= 0){
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
				var tsc = this.StackCount - 1;
				if(dic.moving){
					if(this.stack[tsc].page == "back")this.stack[tsc].page = void;
					if(this.stack[tsc].show == "true")this.stack[tsc].show = void;
					startEffect(this.stack[tsc]);	// 動作中だった
					//dm("動作");
				}else{
					if(this.stack[tsc].page == "back")this.stack[tsc].page = void;
					if(this.stack[tsc].show == "true")this.stack[tsc].show = void;
					this.stack[tsc].time = 0;
					startEffect(this.stack[tsc]);	// 動作中だった
				}
			}else{
				if(dic.page == "back")dic.page = void;
				if(dic.show == "true")dic.show = void;
				if(this.StackCount == -1){
					//dm("XX:"+this.stack.count);
					//dm("XX:"+this.StackCount);
					startEffect(this.stack[0]);	// 動作中だった
				}else{
					//dm("YY:"+this.stack.count);
					//dm("YY:"+this.StackCount);
					startEffect(this.stack[StackCount]);	// 動作中だった
				}
			}
			if(dic.deleteAfterTransFlag !== void)deleteAfterTransFlag = dic.deleteAfterTransFlag;
		}
	}

	//画面の初期化
	function onClearScreenChange(elm){
		if(elm.now === "true") DeleteObjectNow();
		else DeleteObject();
	}
	
	function onStableStateChanged(stable){}

	function onMessageHiddenStateChanged(hidden){}
	
	function onCopyLayer(toback)
	{
		/*
		if(toback)
			// 表→裏
			targetLayerBack = targetLayer;
		else
			// 裏→表
			targetLayer = targetLayerBack;
		*/
	}

	function onExchangeForeBack()
	{
		if(xfade){
			xfade = false;
			clear = true;
			finish();
		}

		var fore = targetLayer;
		targetLayer = targetLayerBack;
		targetLayerBack = fore;
		
		var rfore = RideLayer;
		RideLayer = RideLayerBack;
		RideLayerBack = rfore;
		
		//if(!alive)return;
		
		if(replacement && twoDrawFlag){
			targetLayerBack.assignImages(targetLayer);
			twoDrawFlag = false;
			replacement = false;
		}

		if(twoDrawFlag){
			var tmp = tempLayer;
			tempLayer = tempLayer2;
			tempLayer2 = tmp;
			storageCount++;
			if(storageBox.count > 0){
				if(storageCount >= storageBox.count){storageCount--;}
				tempLayer2.assignImages(storageBox[storageCount]);
			}
		}
		
		if(deleteAfterTransFlag){
			ClearStack();
			clearLayer();
		}
		
		if(showAfterTransFlag && targetLayer !== void && targetLayerBack !== void){
			targetLayer.visible = targetLayerBack.visible = true;
			if(RideFlag){ RideLayer.visible = RideLayerBack.visible = true;}
		}
		
		if(subFlag && targetLayer !== void && targetLayerBack !== void){
			targetLayer.visible = targetLayerBack.visible = false;
			if(RideFlag){ RideLayer.visible = RideLayerBack.visible = false;}
		}

		foreState = targetLayer.visible;
		backState = targetLayerBack.visible;
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

	/*
	function StartStack2(elm)
	{
		var SetupStack = [];
		SetupStack.assign(stack); //copy
		ClearStack();
		this.StackCount = +elm.ssc;
		if(stack.count <= this.StackCount) this.StackCount = stack.count - 1;
		
		StackLoopCheck(elm);
		if(stack.count > 0){
			for(var i = 0; i < stack.count; i++){
			
			}
			startEffect(stack[]);
		}else si("スタックが有りません");
	}*/
	

	function StartStack2(elm)
	{
		StackLoopCheck(elm);
		this.StackCount = +elm.ssc;
		if(stack.count <= this.StackCount) this.StackCount = stack.count - 1;
		dm("max:" + stack.count + ", scnt:" + this.StackCount);
		if(stack.count > 0){
			dm("実行番号:"+StackCount);
			dm("動作の実行:"+stack[this.StackCount].time);
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
		StackCount = -1;
	}

	function StopStack(){
		//dm("SS:"+stack.count);
		
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

	function ClearBeforeDictionary(){
		(Dictionary.clear incontextof beforeDic)();
	}

	function DeleteObject(){
		deleteAfterTransFlag = true;
		targetLayerBack.visible = false;
		RideLayerBack.visible = false;
		ClearBeforeDictionary();
	}

	function DeleteObjectNow(){
		finish();
		clearLayer();
		ClearBeforeDictionary();
	}

	function AddEffectFlag(elm){
		if(elm.fliplr !== beforeDic.flipud) return true;
		if(elm.flipud !== beforeDic.flipud) return true;
		if(elm.movecolor !== beforeDic.movecolor) return true;
		if(elm.grayscale !== beforeDic.grayscale) return true;
		if(elm.sepia !== beforeDic.sepia) return true;
		if(elm.correct !== beforeDic.correct) return true;
		if(elm.turn !== beforeDic.turn) return true;
		if(elm.rgamma !== beforeDic.rgamma) return true;
		if(elm.ggamma !== beforeDic.ggamma) return true;
		if(elm.bgamma !== beforeDic.bgamma) return true;
		if(elm.rfloor !== beforeDic.rfloor) return true;
		if(elm.gfloor !== beforeDic.gfloor) return true;
		if(elm.bfloor !== beforeDic.bfloor) return true;
		if(elm.rceil !== beforeDic.rceil) return true;
		if(elm.gceil !== beforeDic.gceil) return true;
		if(elm.bceil !== beforeDic.bceil) return true;
		if(elm.light !== beforeDic.light) return true;
		if(elm.brightness !== beforeDic.brightness) return true;
		if(elm.contrast !== beforeDic.contrast) return true;
		if(elm.colorize !== beforeDic.colorize) return true;
		if(elm.hue !== beforeDic.hue) return true;
		if(elm.saturation !== beforeDic.saturation) return true;
		if(elm.blend !== beforeDic.blend) return true;
		if(elm.modulate !== beforeDic.modulate) return true;
		if(elm.luminance !== beforeDic.luminance) return true;
		if(elm.translucent !== beforeDic.translucent) return true;

		//タイミングが問題
		if(elm.fbbx !== beforeDic.fbbx) return true;
		if(elm.fbby !== beforeDic.fbby) return true;
		if(elm.bbs !== beforeDic.bbs) return true;
		if(elm.bbe !== beforeDic.bbe) return true;
		
		return false;
	}

	function RegistrationHangObj(num){
		var hang = CallIdObject(num);
		hang.AddHangObj(obj_no);
		return hang.startTick;
	}
	
	function AddHangObj(num){
		hangObj.add(num);
	}
	
	function DeleteHangObj(){
		hangObj.clear();
	}
}

var effect_object = new Array();
{
	var effect_max_num = 12;
	for( var i = 0 ; i < effect_max_num; i++ )
	{
		kag.addPlugin(global.effect_object[i] = new EffectPlugin(kag, i));
	}

	/**/
	
	kag.addPlugin(global.efthum_object = new EffectPlugin(kag, effect_max_num,"thumbnail"));
	kag.addPlugin(global.efthum_object_sub = new EffectPlugin(kag, effect_max_num+1,"thumbnail_sub"));
}

// すべてを一気に停止させるための関数
function effAllStopFunction()
{
	for(var i=0; i<effect_object.count; i++){
		if(effect_object[i].moving){
			effect_object[i].StackLoop = false;
			if(effect_object[i].stack.count > 0){
				effect_object[i].StopStack();
			}else{
				effect_object[i].finish();
			}
		}
	}
}

function Composition(mode){
	switch(mode){
		case "change": return 0; break;
		case "add": return 1; break;
		case "sub": return 2; break;
		case "mul": return 3; break;
	}
	return 4;
}

// すべてを一気に削除予約の関数
function effAllDeleteFunction()
{
	for(var i=0; i<effect_object.count; i++){
		if(effect_object[i].alive){
			effect_object[i].StackLoop = false;
			effect_object[i].ClearStack();
			effect_object[i].deleteAfterTransFlag = true;
			effect_object[i].targetLayerBack.visible = false;
			effect_object[i].ClearBeforeDictionary();
			if(effect_object[i].RideFlag || effect_object[i].EMflag){
				effect_object[i].RideLayerBack.visible = false;
			}
		}
	}
}

// すべてを一気に削除の関数
function effAllDeleteNowFunction()
{
	for(var i=0; i<effect_object.count; i++){
		if(effect_object[i].alive){
			effect_object[i].StackLoop = false;
			effect_object[i].ClearStack();
			effect_object[i].finish();
			effect_object[i].clearLayer();
			effect_object[i].ClearBeforeDictionary();
		}
	}
}

function effAllSaveLayer(){
	for(var i=0; i<effect_object.count; i++){
		if(effect_object[i].targetLayer.visible){
			effect_object[i].targetLayer.saveLayerImage(System.exePath+"obj_"+ i +".png","png");
		}
	}
}


function saveLayerSquare(){
	var temp = new Layer(kag, kag.fore.base);
	temp.imageWidth = kag.scWidth;
	temp.imageHeight = kag.scHeight;
	//temp.fillRect(0,0,kag.scWidth,kag.scHeight,0x00000000);
	temp.fillRect(0,0,kag.scWidth,kag.scHeight,0x0);
	for(var i=0; i<effect_object.count; i++){
		if(effect_object[i].targetLayer.visible){
			with(effect_object[i].targetLayer){
				//ペアレント系は、一度α系に直す
				if(effect_object[i].effectparent !== void || effect_object[i].layerparent || effect_object[i].leffparent){
					var alpha_temp = new Layer(kag,kag.fore.base);
					
					alpha_temp.assignImages(.parent);
					var t_w = .imageWidth;
					var t_h = .imageHeight;
					alpha_temp.adjustGamma(1, 255, 255, 1, 255, 255, 1, 255, 255);
					var rem_face = effect_object[i].targetLayer.face;
					effect_object[i].targetLayer.face = dfMask;
					alpha_temp.operateRect(.parent.left - .left,.parent.height - .height, effect_object[i].targetLayer, 0, 0, t_w, t_h, omMultiplicative, 255);
					effect_object[i].targetLayer.face = rem_face;
					alpha_temp.face = rem_face;
					temp.operateRect(.left,alpha_temp.top,alpha_temp,0,0,.imageWidth,.imageHeight,.type,.opacity);
					
					invalidate alpha_temp;
				}else{
					temp.operateRect(.left,.top,effect_object[i].targetLayer,0,0,.imageWidth,.imageHeight,.type,.opacity);
				}
			}

		}
	}

	var temp_name = "";
	temp_name = "sp_" + Storages.chopStorageExt(kag.mainConductor.curStorage);	//.ksを除く
	temp_name = temp_name + "_" + kag.mainConductor.curLabel.substring(1);		//アスタリスクを除く
	temp_name = temp_name + ".png";
	temp.saveLayerImage(System.exePath+temp_name,"png");
	invalidate temp;
}

function macro_change_eff(elm){
	if(elm.seff == "true"){
		if(effect_object[+elm.obj].moving){
			effect_object[+elm.obj].StopStack();
			effect_object[+elm.obj].finish();
		}
	}
	if(elm.aseff == "true") effAllStopFunction();
	
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
	effect_object[elm.obj].startEffect(elm);
	elm.time = time;
	elm.delay = delay;
}

function cutin_change_move(elm){
	if(effect_object[+elm.obj].tempLayer.cutinLayer !== void){
		/*storeの書き換え動作？*/
		effect_object[+elm.obj].tempLayer.cutinLayer.change_move(elm);
	}
}

function cutin_stop_move(elm){
	if(effect_object[+elm.obj].tempLayer.cutinLayer !== void){
		effect_object[+elm.obj].tempLayer.cutinLayer.stop_move();
	}
}

function FreeObjectNumber(elm){
	if(elm.obj !== void){
		return +elm.obj;
	}else{
		var fnum = -1;
		for(var i=0;i<effect_object.count && fnum == -1;i++){if(!effect_object[i].alive){fnum = i;}}
		if(fnum == -1){si("すべて実行中です、0扱いにします");fnum=0;}
		return fnum;
	}
}



function CallIdObject(id){
	//読み込んだ時点では、実態がわからないのが問題
	//IDの検索
	var num = 0;
	for(var i = 0; i < global.EffectArray.count; i++){
		if(global.EffectArray[i].id == id){
			return global.EffectArray[i];					//一致したオブジェクトを返す
		}
	}
	return void;
}

function CallIdObjectAnimationSlotController(id){
	var num = 0;
	for(var i = 0; i < global.EffectArray.count; i++){
		if(global.EffectArray[i].id == id){
			return global.EffectArray[i].tempLayer.SyncAnimationSlotController();
		}
	}
	return void;
}

function StartIdEffect(elm){
	var obj = CallIdObject(elm.id);
	if(obj === void){
		obj.StackLoopCheck(elm);
		obj.startEffect(elm);
		return true;
	}else{
		return false;
	}
}

@endscript
@endif
;
; マクロ登録

;@macro name="eff"
;@eval exp="mp.obj = FreeObjectNumber(mp);"
;@eval exp="effect_object[+mp.obj].startEffect(mp)"
;@eval exp="setCgVer(mp.storage)"
;@endmacro

@macro name="eff"
@eval exp="effect_object[+mp.obj].StackLoopCheck(mp)"
@eval exp="effect_object[+mp.obj].startEffect(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="eff_stack_start"
@eval exp="effect_object[+mp.obj].StartStack(mp)"
@endmacro

@macro name="eff_stack_start2"
@eval exp="effect_object[+mp.obj].StartStack2(mp)"
@endmacro

@macro name="eff_stack"
@eval exp="effect_object[+mp.obj].AddStack(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro
;
@macro name="weff"
@waittrig * name="&'effect_plugin'+(int)mp.obj" onskip="effect_object[+mp.obj].StopStack(),effect_object[+mp.obj].finish()" canskip=%canskip|true cond="effect_object[+mp.obj].moving && (!effect_object[+mp.obj].loop || effect_object[+mp.obj].loopCount != -1) && !effect_object[+mp.obj].StackLoop"
@eval exp="effect_object[+mp.obj].StopStack(),effect_object[+mp.obj].finish()"
@endmacro

@macro name="aweff"
@eval exp="kag.leftClickHook.clear(); kag.leftClickHook.add(function(){kag.leftClickHook.clear(); effAllStopFunction(); tf.effectSkipFlag = true;});"
@waittrig * name="&'effect_plugin0'" onskip="effect_object[0].StopStack(),effect_object[0].finish()" canskip=%canskip|true cond="effect_object[0].moving && (!effect_object[0].loop || effect_object[0].loopCount != -1) && !effect_object[0].StackLoop"
@waittrig * name="&'effect_plugin1'" onskip="effect_object[1].StopStack(),effect_object[1].finish()" canskip=%canskip|true cond="effect_object[1].moving && (!effect_object[1].loop || effect_object[1].loopCount != -1) && !effect_object[1].StackLoop"
@waittrig * name="&'effect_plugin2'" onskip="effect_object[2].StopStack(),effect_object[2].finish()" canskip=%canskip|true cond="effect_object[2].moving && (!effect_object[2].loop || effect_object[2].loopCount != -1) && !effect_object[2].StackLoop"
@waittrig * name="&'effect_plugin3'" onskip="effect_object[3].StopStack(),effect_object[3].finish()" canskip=%canskip|true cond="effect_object[3].moving && (!effect_object[3].loop || effect_object[3].loopCount != -1) && !effect_object[3].StackLoop"
@waittrig * name="&'effect_plugin4'" onskip="effect_object[4].StopStack(),effect_object[4].finish()" canskip=%canskip|true cond="effect_object[4].moving && (!effect_object[4].loop || effect_object[4].loopCount != -1) && !effect_object[4].StackLoop"
@waittrig * name="&'effect_plugin5'" onskip="effect_object[5].StopStack(),effect_object[5].finish()" canskip=%canskip|true cond="effect_object[5].moving && (!effect_object[5].loop || effect_object[5].loopCount != -1) && !effect_object[5].StackLoop"
@waittrig * name="&'effect_plugin6'" onskip="effect_object[6].StopStack(),effect_object[6].finish()" canskip=%canskip|true cond="effect_object[6].moving && (!effect_object[6].loop || effect_object[6].loopCount != -1) && !effect_object[6].StackLoop"
@waittrig * name="&'effect_plugin7'" onskip="effect_object[7].StopStack(),effect_object[7].finish()" canskip=%canskip|true cond="effect_object[7].moving && (!effect_object[7].loop || effect_object[7].loopCount != -1) && !effect_object[7].StackLoop"
@waittrig * name="&'effect_plugin8'" onskip="effect_object[8].StopStack(),effect_object[8].finish()" canskip=%canskip|true cond="effect_object[8].moving && (!effect_object[8].loop || effect_object[8].loopCount != -1) && !effect_object[8].StackLoop"
@waittrig * name="&'effect_plugin9'" onskip="effect_object[9].StopStack(),effect_object[9].finish()" canskip=%canskip|true cond="effect_object[9].moving && (!effect_object[9].loop || effect_object[9].loopCount != -1) && !effect_object[9].StackLoop"
@waittrig * name="&'effect_plugin10'" onskip="effect_object[10].StopStack(),effect_object[10].finish()" canskip=%canskip|true cond="effect_object[10].moving && (!effect_object[10].loop || effect_object[10].loopCount != -1) && !effect_object[10].StackLoop"
@waittrig * name="&'effect_plugin11'" onskip="effect_object[11].StopStack(),effect_object[11].finish()" canskip=%canskip|true cond="effect_object[11].moving && (!effect_object[11].loop || effect_object[11].loopCount != -1) && !effect_object[11].StackLoop"
@eval exp="kag.leftClickHook.clear(); if(tf.effectSkipFlag){ kag.cancelSkip(); } tf.effectSkipFlag = false;"
@endmacro
;
@macro name="seff"
@eval exp="effect_object[+mp.obj].StopStack(),effect_object[+mp.obj].finish()" cond="effect_object[+mp.obj].moving"
@endmacro
;
@macro name="aseff"
@eval exp="effAllStopFunction()"
@endmacro

@macro name="eff_delete"
@eval exp="effect_object[+mp.obj].DeleteObject();" cond="effect_object[+mp.obj].alive"
@endmacro

@macro name="eff_delete_now"
@eval exp="effect_object[+mp.obj].DeleteObjectNow()" cond="effect_object[+mp.obj].alive"
@endmacro

@macro name="eff_trans"
@eval exp="mp.page = 'back'; mp.transTime = +mp.time; mp.time = 0;"
@eval exp="effect_object[+mp.obj].startEffect(mp)"
@weff *
@trans * layer=base method="&mp.method !== void ? mp.method : (mp.rule === void ? 'crossfade' : 'universal')" time=%transTime|1000
@wt
@eval exp="effect_object[+mp.obj].targetLayer.visible=true, effect_object[+mp.obj].targetLayerBack.visible=true"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="eff_all_delete"
@eval exp="effAllDeleteFunction();"
@endmacro

@macro name="eff_all_delete_now"
@eval exp="effAllDeleteNowFunction();"
@endmacro

; エフェクト残り時間を再設定
@macro name="eff_time_reset"
@eval exp="effect_object[+mp.obj].timeReset(+mp.time)" cond="mp.time !== void"
@endmacro

; エフェクト
@macro name="eff_save"
@eval exp="effect_object[+mp.obj].saveLayer();"
@endmacro

; エフェクト
@macro name="eff_all_save"
@eval exp="effAllSaveLayer();"
@endmacro

@macro name="eff_Square_save"
@eval exp="saveLayerSquare();"
@endmacro

; ウィンドウ表示用マクロ
@macro name="show_fwin"
@eval exp="f['fwin_storage'] = mp.storage"
@eval exp="f['fwin_path'] = mp.path"
@eff * obj=10 xspin=(0.249,0.249,0) yspin=(0.25,0,0) window=true clear=true time=250 size=%size|(0.7,0.7)
@weff obj=10
@endmacro

@macro name="change_fwin"
@eval exp="mp.storage = f['fwin_storage']" cond="mp.storage === void"
@eval exp="mp.path = f['fwin_path']" cond="mp.path === void"
@eff * obj=10 window=true clear=false time=1 xfade=true size=%size|(0.7,0.7)
@weff obj=10
@extrans time=250
@endmacro

@macro name="fwin"
@eval exp="mp.storage = f['fwin_storage']" cond="mp.storage === void"
@eval exp="mp.path = f['fwin_path']" cond="mp.path === void"
@eval exp="f['fwin_path'] = mp.path"
@eff * obj=10 window=true size=%size|(0.7,0.7) clear=true time=%time|1000
@weff obj=10
@endmacro

@macro name="hide_fwin"
@eff * obj=10 xspin=(0,0.249,0.249) yspin=(0,0,0.25) window=true clear=true time=250 size=%size|(0.7,0.7)
@weff obj=10
@eff_delete_now obj=10
@endmacro

@macro name="ceff"
@eff * page=both replacement=true
@extrans * time=%time|250
@endmacro

@macro name="ceff_stock"
@eff * page=both replacement=true
@endmacro

@macro name="dceff"
@eval exp="global.delayscript.addEvent(mp, 'macro_change_eff')"
@eval exp="global.delayscript.addEvent(mp, 'macro_begin_Transition')"
@endmacro

@macro name="eff_cutin"
@eval exp="cutin_change_move(mp)"
@endmacro

@macro name="seff_cutin"
@eval exp="cutin_stop_move(mp)"
@endmacro

@macro name="weff_cutin"
@waittrig * name="&'effect_plugin_cutin'+(int)mp.obj" onskip="effect_object[+mp.obj].cutin_move_stop()" canskip=%canskip|true
@endmacro

@return

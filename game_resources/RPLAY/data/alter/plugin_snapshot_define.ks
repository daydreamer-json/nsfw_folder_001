
@iscript
;//【VariableImageObjectPlugin】は、エフェクトの基本動作を持っているPlugin
;//【SnapshotPlugin】と【SnapshotFramePlugin】はこれを継承して作られている
;//

class VariableImageObjectPlugin extends KAGPlugin
{
	var name;																			// セーブの呼び出し用名
	var window;																			// 画面管理クラス
	var nowBitmap;																		// 現在画面の画像
	var targetBitmap;																	// 現在画面を使用した描画画像
	var drawRect;																		// 現在画面のサイズ用のRECTクラス
	var foreLayer;																		// 前景レイヤ(キャプチャー画面)
	var backLayer;																		// 後景レイヤ(キャプチャー画面)

	var variable;																		// 画像が可変的であるかどうか
	var alive;																			// 表示が生きているかどうか
	var moving;																			// 動作が生きているかどうか
	var loop;																			// ループフラグ
	var loopCount;																		// ループの回数-1は無限
	
	var totalTime;																		// 効果全体の時間
	var lastTick;																		// 前回の描画時間
	var startTick;																		// 描画開始時間
	var accel;																			// 描画時間の加速度
	
	var zoomFunc;																		// 描画処理の指定関数
	var clearColor;																		// 描画処理の初期化色
	var osType;																			// 描画処理の精度
	
	var foreState;																		// 前景レイヤの表示状態
	var backState;																		// 後景レイヤの表示状態
	var deleteAfterTransFlag;															// トランジション後の削除フラグ
	var showAfterTransFlag;																// トランジションの表示

	//座標配列
	var px;																				// 相対PATH_X
	var py;																				// 相対PATH_Y
	var pa;																				// 相対PATH_A

	//サイズ配列
	var size;																			// 拡大縮小関連size
	var Xsize;																			// 拡大縮小関連size_X
	var Ysize;																			// 拡大縮小関連size_Y

	//効果系配列
	var bblur;																			// BoxBlurのフラグ
	var bbx;																			// BoxBlurの配列
	var bby;																			// BoxBlurの配列

	// ラスタスクロール関連【後処理】
	var raster;																			// RasterScroll用：
	var rasterInterpolation;															// RasterScroll用：画面端の補完フラグ
	var rasterTime;																		// RasterScroll用：現在時刻
	var rasterStyle;																	// RasterScroll用：
	var rasterVector;																	// RasterScroll用：ラスタスクロールの向き
	var rasterCycle;																	// RasterScroll用：一周期の期間(msec)
	var rasterMaxHeight;																// RasterScroll用：最大振幅
	var rasterLine;																		// RasterScroll用：一周期あたりのライン数
	var rasterDomain = [];																// RasterScroll用：画面の効果割合

	var cutOut;																			// 切り取り処理
	var cutOutWidth;																	// 切り取り処理
	var cutOutHeight;																	// 切り取り処理
	var cutOutColor;																	// 切り取り処理
	
	// 計算用にあらかじめ取得しておく
	var dpWidth;																		// 表示サイズの横
	var dpHeight;																		// 表示サイズの縦
	var dpWidthHalf;																	// 表示サイズの横の半分
	var dpHeightHalf;																	// 表示サイズの縦の半分

	// 画像色の加工用
	var nowCCF = %[];																	// 配色変更系のフラグを管理する辞書配列(一時的に画像名も保持する)(ＣＣＦはＣｏｌｏｒＣｈａｎｇｅＦｌａｇの略)
	var beforeCCF = %[];																// 前回の配色変更系のフラグを管理する辞書配列(一時的に画像名も保持する)
	
	var storeDic = %[];																	// セーブ用の辞書配列
	
	var test = false;																	// テストメッセージ用のフラグ
	
	//◆コンストラクタ
	function VariableImageObjectPlugin(win,abs)
	{
		name = 'vio';																	// セーブ用の名称であり、トリガの名称でもある
		super.KAGPlugin();																// ＫＡＧプラグインを初期化
		initParams();																	// パラメータの初期化
		window = win;																	// 自身の親を指定
		nowBitmap = new Bitmap();														// 基本画像の保持を行うBitmapクラスをメモリ上に確保
		dpWidth = win.scWidth;															// ウインドウサイズの横幅を取得
		dpHeight = win.scHeight;														// ウインドウサイズの縦幅を取得
		dpWidthHalf = dpWidth \ 2;														// ウインドウサイズの横幅の半分を取得（計算用）
		dpHeightHalf = dpHeight \ 2;													// ウインドウサイズの縦幅の半分を取得（計算用）
		drawRect = new Rect(0,0,dpWidth,dpHeight);										// 描画画像の計算用のRectクラスをメモリ上に確保
		targetBitmap = new Bitmap(win.scWidth,win.scHeight);							// 描画画像の保持を行うBitmapクラスをメモリ上に確保
		foreLayer = new global.KAGLayer(window, window.fore.base);						// 表表示レイヤをメモリ上に確保
		foreLayer.absolute = abs;														// 表表示レイヤの優先度を指定
		foreLayer.hitType = htMask;														// 表表示レイヤの当たり判定のタイプを変更マスク系へ
		foreLayer.hitThreshold = 256;													// 表表示レイヤの当たり判定をカット
		backLayer = new global.KAGLayer(window, window.back.base);						// 裏表示レイヤをメモリ上に確保
		backLayer.absolute = abs;														// 裏表示レイヤの優先度を指定
		backLayer.hitType = htMask;														// 裏表示レイヤの当たり判定のタイプを変更マスク系へ
		backLayer.hitThreshold = 256;													// 裏表示レイヤの当たり判定をカット
		foreState = false;																// 表表示の状態を初期化
		backState = false;																// 裏表示の状態を初期化
		zoomFunc = void;																// 描画処理を初期化
		clearColor = 0x0;																// 画面クリアする際の色を初期化
	}

	//◆デストラクタ
	function finalize()
	{
		//配列関連の削除
		clearParams();																	// パラメータを初期化
		finalizeParams();																// パラメータのfinalize
		
		//レイヤ関連の削除
		clearLayer();																	// レイヤを初期化
		invalidate nowBitmap;															// 基本画像の保持を行うBitmapクラスをメモリ上から解放
		invalidate drawRect;															// 描画画像の計算用のRectクラスをメモリ上から解放
		invalidate targetBitmap;														// 描画画像の保持を行うBitmapクラスをメモリ上から解放
		invalidate foreLayer;															// 表表示レイヤをメモリ上から解放
		invalidate backLayer;															// 裏表示レイヤをメモリ上から解放

		//辞書配列の開放
		(Dictionary.clear incontextof nowCCF)();										// 配色変更系のフラグを管理する辞書配列を初期化
		(Dictionary.clear incontextof beforeCCF)();										// 前回の配色変更系のフラグを管理する辞書配列を初期化 
		//(Dictionary.clear incontextof storeDic)();									// セーブ用の配列を初期化
		super.finalize(...);															// ＫＡＧプラグインのfinalize
	}

	//■表示の初期化
	function clearLayer()
	{
		alive = false;																	// 存在フラグをＯＦＦへ
		Stop();																			// 動作を強制停止
		//ImageFunction.fillRect(nowBitmap, 0x0);										// 基本画像の保持を行うBitmapクラスを初期化
		ImageFunction.fillRect(targetBitmap, 0x0);										// 描画画像の保持を行うBitmapクラスを初期化
		
		//表示の削除
		foreLayer.fillRect( 0, 0, foreLayer.imageWidth, foreLayer.imageHeight, 0x0);	// 表表示レイヤを初期化
		backLayer.fillRect( 0, 0, backLayer.imageWidth, backLayer.imageHeight, 0x0);	// 裏表示レイヤを初期化
		foreState = false;																// 表表示の状態を初期化
		backState = false;																// 裏表示の状態を初期化
		foreLayer.visible = foreState;													// 表表示レイヤを表表示の状態へ強制変更
		backLayer.visible = backState;													// 裏表示レイヤを裏表示の状態へ強制変更
		
	}

	//■パラメータ関連の初期化
	function initParams()
	{
		//配列型の宣言
		px = new ParamsArray(0);														// 座標系Ｘの配列クラスをメモリ上に取得：初期値は、0
		py = new ParamsArray(0);														// 座標系Ｙの配列クラスをメモリ上に取得：初期値は、0
		pa = new ParamsArray(255);														// 座標系Ａの配列クラスをメモリ上に取得：初期値は、255
		
		size = new ParamsArray(1.0);													// サイズ系の配列クラスをメモリ上に取得：初期値は、1.0
		Xsize = new ParamsArray(1.0);													// サイズ系Ｘの配列クラスをメモリ上に取得：初期値は、1.0
		Ysize = new ParamsArray(1.0);													// サイズ系Ｙの配列クラスをメモリ上に取得：初期値は、1.0

		bbx = new ParamsArray(0);														// ボックスブラー系Ｘの配列クラスをメモリ上に取得：初期値は、0
		bby = new ParamsArray(0);														// ボックスブラー系Ｙの配列クラスをメモリ上に取得：初期値は、0
                                                                                           
		rasterMaxHeight = new ParamsArray(0);											// ラスタスクロール系振幅の配列クラスをメモリ上に取得：初期値は、0
		rasterLine = new ParamsArray(1);												// ラスタスクロール系振幅強度の配列クラスをメモリ上に取得：初期値は、1
                                                                                           
		cutOutWidth = new ParamsArray(0);												// 外枠系Ｘの配列クラスをメモリ上に取得：初期値は、0
		cutOutHeight = new ParamsArray(0);												// 外枠系Ｙの配列クラスをメモリ上に取得：初期値は、0
	}

	//■パラメータ関連のfinalize
	function finalizeParams()
	{
		invalidate px;																	// 座標系Ｘの配列クラスをメモリから解放
		invalidate py;																	// 座標系Ｙの配列クラスをメモリから解放
		invalidate pa;																	// 座標系Ａの配列クラスをメモリから解放

		invalidate size;																// サイズ系の配列クラスをメモリから解放
		invalidate Xsize;																// サイズ系Ｘの配列クラスをメモリから解放
		invalidate Ysize;																// サイズ系Ｙの配列クラスをメモリから解放

		invalidate bbx;																	// ボックスブラー系Ｘの配列クラスをメモリから解放
		invalidate bby;																	// ボックスブラー系Ｙの配列クラスをメモリから解放

		invalidate rasterMaxHeight;														// ラスタスクロール系振幅の配列クラスをメモリから解放
		invalidate rasterLine;															// ラスタスクロール系振幅強度の配列クラスをメモリから解放

		invalidate cutOutWidth;															// 外枠系Ｘの配列クラスをメモリから解放
		invalidate cutOutHeight;														// 外枠系Ｙの配列クラスをメモリから解放
	}

	//■配列型の初期化
	function clearParams()
	{
		px.clear();																		// 座標系Ｘの配列クラスを初期化
		py.clear();																		// 座標系Ｙの配列クラスを初期化
		pa.clear();																		// 座標系Ａの配列クラスを初期化

		size.clear();																	// サイズ系の配列クラスを初期化
		Xsize.clear();																	// サイズ系Ｘの配列クラスを初期化
		Ysize.clear();																	// サイズ系Ｙの配列クラスを初期化
		
		bbx.clear();																	// ボックスブラー系Ｘの配列クラスを初期化
		bby.clear();																	// ボックスブラー系Ｙの配列クラスを初期化
		
		rasterMaxHeight.clear();														// ラスタスクロール系振幅の配列クラスを初期化
		rasterLine.clear();																// ラスタスクロール系振幅強度の配列クラスを初期化

		cutOutWidth.clear();															// 外枠系Ｘの配列クラスを初期化
		cutOutHeight.clear();															// 外枠系Ｙの配列クラスを初期化

		(Dictionary.clear incontextof nowCCF)();										// 今回の色調変化系のフラグを初期化
	}

	function setupEffect(elm)
	{
		//セーブ用の保存
		(Dictionary.assign incontextof storeDic)(elm);									// マクロのタグデータをセーブ用の辞書配列へコピー
		
		//座標の指定
		var pathNum = 2;																// path数の変数を宣言、全体時間の計算用に使用
		if(elm.path !== void){
			var path = [].split("(), ", elm.path, , true);								// 実行されるpathタグのデータを格納しやすいように分解
			pathNum = path.count \ 3;													// その配列からpath数を取得
			for(var i = 0; i < pathNum; i++){
				px.AddArrayForParams(+path[i*3]);										// pathデータのＸの値を座標系Ｘの配列クラスへ格納
				py.AddArrayForParams(+path[i*3+1]);										// pathデータのＹの値を座標系Ｙの配列クラスへ格納 
				pa.AddArrayForParams(+path[i*3+2]);										// pathデータのＡの値を座標系Ａの配列クラスへ格納
			}
		}else{
			px.ArrayForParams(void,0,0);												// 座標系Ｘの配列クラスへ基準データを初期セット
			py.ArrayForParams(void,0,0);												// 座標系Ｙの配列クラスへ基準データを初期セット
			pa.ArrayForParams(void,255,255);											// 座標系Ａの配列クラスへ基準データを初期セット
		}

		//サイズの指定
		size.ArrayForParams(elm.size);													// サイズ系の配列クラスへパラメータをセット
		Xsize.ArrayForParams(elm.xsize);												// サイズ系Ｘの配列クラスへパラメータをセット
		Ysize.ArrayForParams(elm.ysize);												// サイズ系Ｙの配列クラスへパラメータをセット

		//ボックスブラーの指定
		bbx.ArrayForParams(elm.bbx);													// ボックスブラー系Ｘの配列クラスへパラメータをセット
		bby.ArrayForParams(elm.bby);													// ボックスブラー系Ｙの配列クラスへパラメータをセット
		bblur = true;
		if(!bbx.IsFluctuate() && !bby.IsFluctuate()){
			if(bbx.maximum() == 0 && bby.maximum() == 0) bblur = false;					// ボックスブラー系Ｘまたはボックスブラー系Ｙに動作があれば、ブラー処理フラグをＯＮへ
		}
		
		//ラスタスクロールの指定
		raster = (elm.raster === "true") ? true : false;								// ラスタスクロールの実行を指定
		if(elm.raster !== void){
			rasterInterpolation = (elm.ri == "false") ? false : true;					// 外枠のはみ出した部分の補完を行うかのフラグを指定
			rasterStyle = (elm.rs == "v") ? "v" : "h";									// ラスタスクロールの方向を指定
			rasterStyle = (elm.rs == "vh") ? "vh" : rasterStyle;						// 縦、横、両方の三種類のいづれかを指定
			rasterMaxHeight.ArrayForParams(elm.rm);										// 振幅パラメータを配列クラスに格納
			rasterLine.ArrayForParams(elm.rl);											// ライン数パラメータを配列クラスに格納
			rasterDomain.clear();														// ラスタスクロールの画面の効果割合を初期化
			if(elm.rd !== void){
				var tmp = [].split("(), ", elm.rd, , true);								// ラスタスクロールの画面の効果割合を配列に格納
				for(var i=0; i<tmp.count;i++){ rasterDomain.add(+tmp[i]);}				// 文字列を数値にキャスト
			}else{
				rasterDomain.add(1);													// 指定がない場合は、
				rasterDomain.add(1);													// 初期値をラスタスクロールの画面効果割合を配列に格納 
			}
			rasterCycle = (elm.rc !== void) ? +elm.rc :	 1;								// 周期時間指定
		}

		//切り取り系処理の指定
		cutOut = false;																	// 外枠処理の使用フラグを初期化
		cutOutColor = 0x0;																// 外枠処理の配色を初期化
		if(elm.coc !== void){															// 
			cutOut = true;																// 
			cutOutWidth.ArrayForParams(elm.cow);										// 外枠系Ｘの配列クラスへパラメータをセット
			cutOutHeight.ArrayForParams(elm.coh);										// 外枠系Ｙの配列クラスへパラメータをセット
			cutOutColor = (int)elm.coc;													// 外枠処理の配色をセット
		}

		//拡大縮小系の初期化色
		clearColor = 0x0;																// 描画処理が拡縮の場合に全塗りつぶしを行う配色の初期化
		if(elm.cc !== void) clearColor = (int)elm.cc;									// 描画処理が拡縮の場合に全塗りつぶしを行う配色のパラメータをセット
		
		// 処理時間の計算
		totalTime = 1000;																// 全体時間を初期化
		if(elm.time !== void) totalTime = +elm.time * (pathNum - 1);					// 全体時間を計算
		if(totalTime == 0) totalTime = 1;												// 全体時間が０除算の場合困るための調整

		// 加速度設定
		this.accel = elm.accel !== void ? +elm.accel : 0;								// 加速度のパラメータをセット
		
		// ループ関連
		loop = false;																	// ループのフラグを初期化
		if(elm.loop === "true") loop = true;											// ループのフラグのパラメータをセット
		loopCount = -1;																	// ループ回数を初期化
		if(elm.loopcount !== void) loopCount = +elm.loopcount;							// ループ回数のパラメータをセット
		
		// 画像の表示モード変更
		foreLayer.type = backLayer.type = ltAlpha;										// 表示レイヤのモードを初期化
		if(elm.mode != void){
			// この辞書配列はtjsがはじめから持ってるらしい
			var _type = imageTagLayerType[elm.mode].type;								// 文字列より表示レイヤの番号を検索
			if(_type !== void) foreLayer.type = backLayer.type = _type;					// 表示レイヤのモードのパラメータをセット
		}

		// 描画面の表示の有無
		if(elm.page === "fore"){
			foreState = true;															// 前景のみの表示指定なので。
			backState = false;															// 前景は表示、後景は非表示
		}else if(elm.page === "back"){
			foreState = false;															// 後景のみの表示指定なので。
			backState = true;															// 前景は非表示、後景は表示
		}else{
			foreState = true;															// 両方とも表示指定なので。
			backState = true;															// 前景は表示、後景も表示
		}

		var sif = (!size.IsFluctuate() && size.maximum() == 1) ? true : false;			// サイズのパラメータの変動をチェック、拡縮があるかの確認
		var xsif = (!Xsize.IsFluctuate() && size.maximum() == 1) ? true : false;		// Ｘサイズのパラメータの変動をチェック、拡縮があるかの確認
		var ysif = (!Ysize.IsFluctuate() && size.maximum() == 1) ? true : false;		// Ｙサイズのパラメータの変動をチェック、拡縮があるかの確認
		zoomFunc = (sif && xsif && ysif) ? CopyDraw : StretchDraw;						// すべてのサイズ系に変動と拡縮がなければ、描画処理をCopy系にする
		
		osType = stFastLinear;															// 拡縮処理が行われる場合の描画補完精度の指定
		if(elm.ost !== void){															//
			if(elm.ost === "stNearest") osType = stNearest;								// 補完に【stNearest】を指定（最低精度かつ最速）
			else if(elm.ost === "stFastLinear") osType = stFastLinear;					// 補完に【stFastLinear】を指定（下二番目の精度かつ上二番目の速度）
			else if(elm.ost === "stLinear") osType = stLinear;							// 補完に【stLinear】を指定（上二番目の精度かつ下二番目の速度）
			else if(elm.ost === "stCubic") osType = stCubic;							// 補完に【stCubic】を指定（最高精度かつ最遅）
		}

		//レイヤの初期表示セット
		foreLayer.visible = foreState;													// 表表示のレイヤに表示状態を指定
		backLayer.visible = backState;													// 裏表示のレイヤに表示状態を指定
		
		// トランジション後の動作
		showAfterTransFlag = false;														// トランジション後の表示切替フラグをセット
		if(elm.show === "true") showAfterTransFlag = true;								// トランジション後に両面表示にする場合はＯＮ
		deleteAfterTransFlag = false;													// トランジション後の表示切替フラグをセット
		if(elm.delete === "true") deleteAfterTransFlag = true;							// トランジション後に非表示にする場合はＯＮ
		
		//テスト用
		
		//時間のセット
		setTimeParams(totalTime);														// 配列型のパラメータに自身の進行時間の設定を行う
	}

	//■配列型の時間計算用
	function setTimeParams(tt)
	{
		px.TimeForParams(tt);															// 座標系Ｘの進行時間を計算
		py.TimeForParams(tt);                                                       	// 座標系Ｙの進行時間を計算
		pa.TimeForParams(tt);                                                       	// 座標系Ａの進行時間を計算

		size.TimeForParams(tt);                                                     	// サイズ系の進行時間を計算
		Xsize.TimeForParams(tt);                                                    	// サイズ系Ｘの進行時間を計算
		Ysize.TimeForParams(tt);                                                    	// サイズ系Ｙの進行時間を計算
		
		bbx.TimeForParams(tt);                                                      	// ボックスブラー系Ｘの進行時間を計算
		bby.TimeForParams(tt);                                                      	// ボックスブラー系Ｙの進行時間を計算

		rasterMaxHeight.TimeForParams(tt);                                          	// ラスタスクロール系振幅の進行時間を計算
		rasterLine.TimeForParams(tt);                                               	// ラスタスクロール系振幅強度の進行時間を計算
		rasterTime = totalTime * rasterCycle;                                       	// ラスタスクロール系周期の時間を計算
		
		cutOutWidth.TimeForParams(tt);													// 外枠系Ｘの進行時間を計算
		cutOutHeight.TimeForParams(tt);													// 外枠系Ｙの進行時間を計算
	}
	
	//■配列型のループを否定する系
	function NotLoopParams()
	{
		cutOutWidth.end = true;															// 外枠系Ｘのパラメータを最終状態で固定
		cutOutHeight.end = true;														// 外枠系Ｙのパラメータを最終状態で固定 
	}

	//■画像色の加工用フラグをセット
	function SetNowCCF(elm)
	{
		test = (elm.test === "true") ? true : false;														// テストメッセージ用のフラグをセットする
		
		nowCCF["grayscale"] = (elm.grayscale === "true") ? true : false;									// グレースケールのフラグをセット
		nowCCF["sepia"] = (elm.sepia === "true") ? true : false;											// セピアのフラグをセット
		nowCCF["turn"] = (elm.turn === "true") ? true : false;												// 色調反転のフラグをセット
		
		nowCCF["acb"] = (elm.acb === "true") ? true : false;												// 強制色調変更をグラデーション系の処理でかけるかのフラグをセット
		
		nowCCF["a_r"] = (elm.a_r !== void) ? +elm.a_r : -1;													// 強制色調変更の基本色１のパラメータＲをセット
		nowCCF["a_g"] = (elm.a_g !== void) ? +elm.a_g : -1;													// 強制色調変更の基本色１のパラメータＧをセット 
		nowCCF["a_b"] = (elm.a_b !== void) ? +elm.a_b : -1;													// 強制色調変更の基本色１のパラメータＢをセット
			
		nowCCF["a"] = true;																					// 強制色調変更の基本色１の使用フラグを初期化
		if(nowCCF["a_r"] == -1 && nowCCF["a_g"] == -1 && nowCCF["a_b"] == -1) nowCCF["a"] = false;			// 強制色調変更の基本色１の使用フラグをセット
		
		nowCCF["a_r2"] = (elm.a_r2 !== void) ? +elm.a_r2 : -1;												// 強制色調変更の基本色２のパラメータＲをセット
		nowCCF["a_g2"] = (elm.a_g2 !== void) ? +elm.a_g2 : -1;												// 強制色調変更の基本色２のパラメータＧをセット
		nowCCF["a_b2"] = (elm.a_b2 !== void) ? +elm.a_b2 : -1;												// 強制色調変更の基本色２のパラメータＢをセット

		nowCCF["a2"] = true;																				// 強制色調変更の基本色２の使用フラグを初期化
		if(nowCCF["a_r2"] == -1 && nowCCF["a_g2"] == -1 && nowCCF["a_b2"] == -1) nowCCF["a2"] = false;		// 強制色調変更の基本色２の使用フラグをセット
		
	}

	//■前の状態との比較
	function ComparisonSetNowCCF()
	{
		if(nowCCF["storage"] !== beforeCCF["storage"]) return true;											// 画像名を比較
		
		if(nowCCF["grayscale"] !== beforeCCF["grayscale"]) return true;										// グレースケールのフラグを比較
		if(nowCCF["sepia"] !== beforeCCF["sepia"]) return true;												// セピアのフラグを比較
		if(nowCCF["turn"] !== beforeCCF["turn"]) return true;												// 色調反転のフラグを比較

		if(nowCCF["acb"] !== beforeCCF["acb"]) return true;													// 強制色調変更をグラデーション系の処理でかけるかのフラグを比較
		
		if(nowCCF["a_r"] !== beforeCCF["a_r"]) return true;													// 強制色調変更の基本色１のパラメータＲを比較
		if(nowCCF["a_g"] !== beforeCCF["a_g"]) return true;													// 強制色調変更の基本色１のパラメータＧを比較 
		if(nowCCF["a_b"] !== beforeCCF["a_b"]) return true;													// 強制色調変更の基本色１のパラメータＢを比較

		if(nowCCF["a_r2"] !== beforeCCF["a_r2"]) return true;												// 強制色調変更の基本色２のパラメータＲを比較
		if(nowCCF["a_g2"] !== beforeCCF["a_g2"]) return true;												// 強制色調変更の基本色２のパラメータＧを比較
		if(nowCCF["a_b2"] !== beforeCCF["a_b2"]) return true;												// 強制色調変更の基本色２のパラメータＢを比較

		return false;																						// 基本画像の更新を行わない
	}
	
	//■画像の加工(nowBitmap)
	function ColorChange()
	{
		if(nowCCF["grayscale"] || nowCCF["sepia"]) ImageFunction.doGrayScale(nowBitmap);												// グレースケール処理を実行
		if(nowCCF["sepia"]) ImageFunction.adjustGamma(nowBitmap,1.3, 0, 255, 1.1, 0, 255, 1.0, 0, 255);									// セピア処理を実行
		if(nowCCF["turn"]) ImageFunction.adjustGamma(nowBitmap,1.0, 255, 0, 1.0, 255, 0, 1.0, 255, 0);									// 色調反転処理を実行
		
		//彩色の変更を実行
		if(nowCCF["a"]){
			var tmp = new global.KAGLayer(window, window.fore.base);																	// 処理用のレイヤを一時的にメモリ上に取得
			tmp.copyFromBitmapToMainImage(nowBitmap);																					// 基本画像のBitmapから処理用のレイヤへコピー
			if(nowCCF["acb"]){
				if(!nowCCF["a2"]) tmp.AlphaColorBlend(nowCCF["a_r"], nowCCF["a_g"], nowCCF["a_b"]);										// 不透明度によるグラデーションを単色で実行
				else tmp.AlphaColorBlend2(nowCCF["a_r"], nowCCF["a_g"], nowCCF["a_b"], nowCCF["a_r2"], nowCCF["a_g2"], nowCCF["a_b2"]); // 不透明度によるグラデーションを二色で実行
			}else tmp.AlphaColorRect(nowCCF["a_r"], nowCCF["a_g"], nowCCF["a_b"]);														// 強制配色変更を実行
			tmp.copyToBitmapFromMainImage(nowBitmap);																					// 処理用のレイヤから基本画像のBitmapへコピー
			invalidate tmp;																												// 処理用のレイヤをメモリ上から解放
		}
	}
	
	//■パラメータの挿入と動作の開始
	function StartEffect(elm)
	{
		//前回の動作を強制停止する
		Stop();																// 前回の動作を強制停止する
		clearParams();														// パラメータの初期化
		SetNowCCF(elm);														// 画像色の加工用
		if(elm.storage !== void){
			nowCCF["storage"] = elm.storage;								// 画像名の登録
			if(ComparisonSetNowCCF()){
				nowBitmap.load(elm.storage);								// 基本画像の読み込み
				ColorChange();												// 画像色の加工を実行
			}
		}
		(Dictionary.assign incontextof beforeCCF)(nowCCF);					// 前回のカラー系列の配列として記憶
		setupEffect(elm);													// その他のパラメータをセット
		
		//動作の実行を開始
		lastTick = startTick = System.getTickCount();						// 初期時間を実行
		System.addContinuousHandler(ContinuousHandler);						// システムのタイマーにセット
		moving = true;														// 移動フラグをＯＮ
		alive = true;														// 存在フラグをＯＮ
	}

	//■実行中に走る処理
	function ContinuousHandler(tick)
	{
		//var test1 = System.getTickCount();								// テスト用のフラグ
		//dmT("CH間:" + (tick - lastTick));									// 動作時間の確認用
		
		lastTick = tick;													// 現在の時間を保存
		tick -= startTick;													// 開始時間から経過時間を計算
		
		// 時間通りか過ぎてるなら終わる
		if(tick >= totalTime){
			if(loop){
				startTick = startTick + totalTime;							// ループ動作が走った場合
				tick = tick - totalTime;									// 現在の経過時間を再計算
				if(loopCount > -1){
					loopCount--;											// ループ動作に回数がある場合、ループカウントを一つ減らし、
					if(loopCount == -1) loop = false;						// -1になった場合はループのフラグをカット
				}
				NotLoopParams();											// ループをしないパラメータのフラグをＯＦＦに→関数【NotLoopParams】での記述された配列型は一度限りの処理
			}else{
				Finish();													// 動作処理を終了する
				return;														// 処理を中断
			}
		}
		//var test2 = System.getTickCount();								// テスト用のフラグ
		//dmT("CH中:" + (test2 - test1));									// 動作時間の確認用

		if(accel < 0){
			tick = 1.0 - tick / totalTime;									// 減速処理の計算(上弦)
			tick = Math.pow(tick, -accel);									// 最初が動きが早く、徐々に遅くなる
			tick = int ( (1.0 - tick) * totalTime );						// 値が低いほど動作が先よりになる
		}else if(accel > 0){
			tick = tick / totalTime;										// 加速処理の計算(下弦)
			tick = Math.pow(tick, accel);									// 最初は動きが遅く、徐々に早くなる
			tick = int ( tick * totalTime );								// 値が高いほど動作が後ろよりになる
		}
		
		DrawLayer(tick);													// 現在状態の描画を行う
	}

	//■描画処理前に画像にかける処理
	function BeforeHandler(tick)
	{
	}
	
	//■動いてる最中の処理
	function EffectMove(tick)
	{
		BeforeHandler(tick);												// 画像に描画計算処理前に行う動作
		
		var x = px.GetNowParams(tick);										// 画像の現在の位置情報Ｘ
		var y = py.GetNowParams(tick);										// 画像の現在の位置情報Ｙ
		var a = pa.GetNowParams(tick);										// 画像の現在の不透明度Ａ
		var xs = Xsize.GetNowParams(tick) * size.GetNowParams(tick);		// 横方向の拡大サイズ
		var ys = Ysize.GetNowParams(tick) * size.GetNowParams(tick);		// 縦方向の拡大サイズ
		
		foreLayer.opacity = a;												// 表レイヤの不透明度を現在値へ変更
		backLayer.opacity = a;												// 裏レイヤの不透明度を現在値へ変更 
		
		var sw = nowBitmap.width * xs;										// 拡大後のサイズを計算Ｘ（横）
		var sh = nowBitmap.height * ys;										// 拡大後のサイズを計算Ｙ（縦）
		var sl = (dpWidth - sw) \ 2;										// 中心座標系のずれを計算Ｘ
		var st = (dpHeight - sh) \ 2;										// 中心座標系のずれを計算Ｙ
		
		sl += x;															// 拡大した際の中心からの座標を補完Ｘ
		st += y;															// 拡大した際の中心からの座標を補完Ｙ

		//相対パラメータを調整
		var srcRect = new Rect();											// 拡大計算用のパラメータを保存するRectクラスをメモリ上に確保
		srcRect.setSize(sw,sh);												// 拡大計算用のパラメータを保存するRectクラスへサイズを指定
		srcRect.setOffset(sl,st);											// 拡大計算用のパラメータを保存するRectクラスへ位置を指定 

		zoomFunc(srcRect,a);												// 描画計算処理を実行
		invalidate srcRect;													// 拡大計算用のパラメータを保存するRectクラスをメモリ上から解放
		
		AfterHandler(tick);													// 画像に描画計算処理後に行う動作
	}

	//■描画処理後に画像にかける処理
	function AfterHandler(tick)
	{
		// ラスタスクロールの処理
		if(raster){
			var targetLayer = new Layer(kag, kag.fore.base);																										// 現在のプラグインのバージョンだとBitmapに対するラスタスクロールの演算処理を持たない為、
			targetLayer.copyFromBitmapToMainImage(targetBitmap);																									// 新たにメモリ上にレイヤクラスを確保し、そこに現在画像をコピーする
			
			var rmh = rasterMaxHeight.GetNowParams(tick);																											// ラスタスクロールの現在の振幅値を取得
			var rl = rasterLine.GetNowParams(tick);																													// ラスタスクロールの現在の一周期あたりのライン数を取得
			
			if(rmh >= 1){
				var tmp = new Layer(kag, kag.fore.base);																											// ラスタスクロールはレイヤとレイヤ間に行われる演算の為、
				tmp.assignImages(targetLayer);																														// 画像元用のレイヤをメモリに確保する
				tmp.setSizeToImageSize();																															// 描画される側の描画面を初期化して、
				targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, 0x0);																				// 描画面と表示面のサイズ情報を整理
				
				if(rasterStyle == "v" || rasterStyle == "vh"){
					if(rasterInterpolation) targetLayer.copyVerticalInterpolationRaster(tmp, rmh, rl, rasterDomain, rasterTime, RasterNowTick(tick,rasterTime));	// 縦方向のラスタスクロールを実行（余白計算有り）
					else targetLayer.copyVerticalNotInterpolationRaster(tmp, rmh, rl, rasterDomain, rasterTime, RasterNowTick(tick,rasterTime));					// 縦方向のラスタスクロールを実行（余白計算無し） 
				}

				if(rasterStyle == "vh"){
					tmp.assignImages(targetLayer);																													// 両方同時にラスタスクロールを行う場合の特別処理
					tmp.setSizeToImageSize();																														// 画像元用を更新して、描画される側を初期化、
					targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, 0x0);																			// 描画面と表示面のサイズ情報を整理 
				}
				
				if(rasterStyle == "h" || rasterStyle == "vh"){
					if(rasterInterpolation) targetLayer.copyInterpolationRaster(tmp, rmh, rl, rasterDomain, rasterTime, RasterNowTick(tick,rasterTime));			// 横方向のラスタスクロールを実行（余白計算有り）
					else targetLayer.copyNotInterpolationRaster(tmp, rmh, rl, rasterDomain, rasterTime, RasterNowTick(tick,rasterTime));							// 横方向のラスタスクロールを実行（余白計算無し）
				}
				invalidate tmp;																																		// 画像元用のレイヤのメモリを解放
			}

			targetLayer.copyToBitmapFromMainImage(targetBitmap);																									// 最終結果を描画Bitmapクラスへ転送
			invalidate targetLayer;																																	// 新たにメモリ上に確保したレイヤクラスを開放
		}

		// カッティング動作
		if(cutOut){
			var cow = (int)cutOutWidth.GetNowParams(tick);										// 外淵の横方向の強制塗りつぶし処理の現在値を取得
			var coh = (int)cutOutHeight.GetNowParams(tick);										// 外淵の縦方向の強制塗りつぶし処理の現在値を取得
			var _r = new Rect();																// 外淵の強制塗りつぶし処理の計算用Rect型をメモリ上に取得
			
			if(coh > 0){
				_r.setSize(dpWidth,coh);														// 縦方向への塗りつぶし範囲を指定
				_r.setOffset(0, 0);																// 縦方向への塗りつぶしの開始地点を指定
				ImageFunction.fillRect(targetBitmap, cutOutColor,_r);							// 縦方向への塗りつぶし範囲を実行
				_r.setOffset(0, dpHeight - coh);												// 縦方向への塗りつぶしの開始地点を再指定
				ImageFunction.fillRect(targetBitmap, cutOutColor,_r);							// 縦方向への塗りつぶし範囲を実行 
			}
				
			if(cow > 0){
				_r.setSize(cow,dpHeight);														// 横方向への塗りつぶし範囲を指定
				_r.setOffset(0, 0);																// 横方向への塗りつぶしの開始地点を指定
				ImageFunction.fillRect(targetBitmap, cutOutColor,_r);							// 横方向への塗りつぶし範囲を実行
				_r.setOffset(dpWidth - cow, 0);													// 横方向への塗りつぶしの開始地点を再指定
				ImageFunction.fillRect(targetBitmap, cutOutColor,_r);							// 横方向への塗りつぶし範囲を実行 
			}
			
			invalidate _r;																		// 外淵の強制塗りつぶし処理の計算用Rect型をメモリ上から解放
		}

		// ボックスブラーの動作
		if(bblur){
			var _bbx = bbx.GetNowParams(tick);													// 現在画像に対して横方向のボックスブラーの現在値を取得
			var _bby = bby.GetNowParams(tick);													// 現在画像に対して縦方向のボックスブラーの現在値を取得 
			if(_bbx != 0 || _bby != 0) ImageFunction.doBoxBlur(targetBitmap,_bbx,_bby);			// 現在値が(0, 0)でなければボックスブラーを実行する
		} 
	}

	//■描画処理（直接コピー型）
	function CopyDraw(srcRect,a)
	{
		targetBitmap.copyFrom(nowBitmap);														// 描画処理はコピー（アドレスの共有）の動作のみ
		foreLayer.setPos(srcRect.left,srcRect.top);												// ここでの【Left】や【top】は、表示レイヤの実座標になる
		backLayer.setPos(srcRect.left,srcRect.top);												// その為、裏表の表示レイヤに転写する前に座標を入力
	}

	//■描画処理（拡縮処理型）
	function StretchDraw(srcRect,a)
	{
		ImageFunction.fillRect(targetBitmap, clearColor);																// 先ずは現在の画面を特定色で塗りつぶし
		ImageFunction.operateStretch(targetBitmap, nowBitmap, srcRect, drawRect, , omOpaque, dfOpaque, 255, osType);	// その後、拡縮コピーを実行（範囲外は↑の配色になる）

	}

	//■表裏の表示レイヤに現在状態を転写
	function DisplayLayerCopyFromBitmapToMainImage()
	{
		foreLayer.copyFromBitmapToMainImage(targetBitmap);					// 表表示レイヤに現在の描画面を転写
		backLayer.copyFromBitmapToMainImage(targetBitmap);					// 裏表示レイヤに現在の描画面を転写
		foreLayer.setSizeToImageSize();										// 表表示レイヤの表示サイズを調整
		backLayer.setSizeToImageSize();										// 裏表示レイヤの表示サイズを調整

	}

	//■現在状態の描画
	function DrawLayer(tick)
	{
		EffectMove(tick);													// 描画用Bitmapに描画処理を実行
		DisplayLayerCopyFromBitmapToMainImage();							// 表裏レイヤに転写
	}

	// ■最終状態を表示
	function Finish(){
		if(alive){
			DrawLayer(totalTime);											// 最終状態描画処理を実行
			Stop();															// 現在の動作を停止
		}
	}
	
	// ■停止処理
	function Stop(){
		if(moving)
		{
			System.removeContinuousHandler(ContinuousHandler);				// システムのタイマーから外す
			moving = false;													// 動作のフラグをＯＦＦへ
			window.trigger('ps_plugin');									// 待ち用のトリガを発砲
		}
	}
	
	//■ ラスタの時間の特殊計算
	function RasterNowTick(tick,SetTotalTime){
		var ttick = tick \ SetTotalTime;									// ラスタスクロール用の特殊な時間を計算
		var ntick = tick - (ttick * SetTotalTime);							// ラスタスクロールは通常の配列型のパラメータのみではなく
		return ntick;														// 周期の処理があるため特殊な計算を行う
	}
	
	//■削除時
	function DeleteObject(){
		deleteAfterTransFlag = true;										// トランジション後に削除を行うフラグをＯＮへ
		backState = false;													// 裏表示系の表示フラグをＯＦＦへ
		backLayer.visible = backState;										// 裏表示レイヤの表示をＯＦＦへ
	}
	
	//■即時削除時
	function DeleteObjectNow(){
		Finish();															// 現在の処理を終了
		clearLayer();														// 表示状態を初期化する
	}

	//■セーブ処理
	function onStore(f, elm)
	{
		if(alive){
			var dic = f[name] = %[];										// 保存するアドレスの確保
			(Dictionary.assign incontextof dic)(storeDic);					// 現在の動作しているパラメータを保存
			dic.moving = moving;											// 現在の動作フラグを保存
			dic.foreVisible = foreLayer.visible;							// 表レイヤの現在の表示状態を保存
			dic.backVisible = backLayer.visible;							// 裏レイヤの現在の表示状態を保存
			dic.deleteAfterTransFlag = deleteAfterTransFlag;				// トランジション後の削除フラグを保存
		}else{
			f[name] = void;													// 動作してない場合はセーブするパラメータは無し
		}
	}

	//■ロード処理
	function onRestore(f, clear, elm)
	{
		Stop(); 																						// 現在の動作を停止
		clearLayer();																					// 現在の画面を初期化
		var dic = f[name];																				// ロードするアドレスを取得
		if(dic !== void){
			if(dic.moving){
				// 動作中だった場合
				if(dic.foreVisible && !dic.backVisible) dic.page="fore";								// ロードするオブジェクトの表示パラメータを取得し、
				else if(!dic.foreVisible && dic.backVisible) dic.page="back";							// それに合わせてロードするパラメータを改変する
				else dic.page="with";																	// こちらは動作中の為、表示状態のみ気を付ければ問題がない
				StartEffect(dic);																		// 表示パラメータ変更の後に実行
			}else{
				// 停止中だった場合
				dic.time = 0;
				if(dic.page == "back") dic.page = void;													// 停止中で残ってる場合は基本両面表示
				if(dic.show == "true") dic.show = void;													// その場合は、両面表示フラグは不必要なのでパラメータを改変する
				StartEffect(dic);																		// 表示パラメータ変更の後に実行
			}
			if(dic.deleteAfterTransFlag !== void) deleteAfterTransFlag = dic.deleteAfterTransFlag;		// 動作停止に問わず、削除フラグは取得する
		}
	}
	
	//■トランジション時
	function onExchangeForeBack()
	{
		var temp = foreLayer;							// 表裏レイヤのアドレスを移動
		foreLayer = backLayer;							// 表裏を逆にする
		backLayer = temp;								// アクセス先が入れ替わる
		
		if(deleteAfterTransFlag){
			deleteAfterTransFlag = false;				// トランジション後に削除する動作
			clearLayer();								// 表裏レイヤを初期化する
		}else if(showAfterTransFlag){
			foreState = true;							// トランジション後に両面表示にする動作
			backState = true;							// 表裏表示フラグをＯＮへ
			showAfterTransFlag = false;					// 動作後に二度行う必要がないのでフラグを初期化する
		}
		
		foreLayer.visible = foreState;					// トランジション後の表示状態を指定
		backLayer.visible = backState;					// 表裏表示フラグをそれぞれに格納
	}

	//■スナップショット時の描画表示
	function onSnapshotUnvislbe()
	{
		foreLayer.visible = false;						// 表表示レイヤを強制的に不可視に
		backLayer.visible = false;						// 裏表示レイヤを強制的に不可視に
	}

	//■スナップショット時の描画表示
	function onSnapshotAfter()
	{
		foreLayer.visible = foreState;					// 表表示レイヤを現在の状態に戻す
		backLayer.visible = backState;					// 裏表示レイヤを現在の状態に戻す
	}

	//■画面の初期化(プラグイン共通)
	function onClearScreenChange(elm){
		if(elm.now === "true") DeleteObjectNow();		// 画面の初期化を即時に行う
		else DeleteObject();							// 画面の初期化をトランジション後に行う
	}

	//★テスト実行用にデバックメッセージを流す用(最悪不要)
	function dmT(message){
		if(test) dm(message);							// testフラグが立っていた場合のみdm関数を実行する
	}
}


@endscript
;

@return

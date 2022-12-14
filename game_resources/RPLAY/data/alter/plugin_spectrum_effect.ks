@if exp="typeof(global.spectrum_effect_object) == 'undefined'"

@iscript

class SpectrumEffectPlugin extends KAGPlugin
{
	// このプラグインの管理番号
	var obj_no=0;
	var accel;		// 加速度的な動きを行うか
	var moveFunc;	// 移動位置計算用関数
	var zoomFunc;	// 拡大処理用関数
	var clear;		// レイヤをクリアするかどうか
	var page;		// ページ裏表
	var bblur;		// ボックスブラー用
	var pathtype;	// パスの方式
	var lu_corner;	// パスの方式・左上隅指定
	var spaccel;	// 特殊な加減速
	
	var path;		// パスの作業用
	var time;		// ひとつのパスを通る時間
	var totalTime;		// 総合時間
	var lasttick=0;		// 前回の描画時間
	var starttick;		// 描画開始時間
	var affintype;		// アフィン変換の方式
	var tempLayer;		// 画像レイヤー
	var targetLayer;	// 対象レイヤー
	var targetLayerBack;// 対象裏レイヤー
	var alphaLayer;		// ADDALPHA用のレイヤー
	
	var zx = [];		// スプラインワーク
	var zy = [];		// スプラインワーク
	var imageWidthHalf;	// 対象レイヤーの幅の半分
	var imageHeightHalf;// 対象レイヤーの高さの半分
	var cx, cy;			// 回転中心
	var size;			// サイズを記録する配列
	var xsize,ysize;	// サイズを記録する配列
	var rad;			// 
	var xspin,yspin;	// 横軸（縦回転） 縦軸（横回転）
	var alpha_x,alpha_y;// ADDALPHA用のレイヤー
	var alpha_size;		// ADDALPHA用
	var absolute;		//
	
	var moving = false;	// 動作中かどうか
	var alive = false;	// レイヤー類が生きてるかどうか
	
	// セーブ・ロード用パラメータ記録配列
	var storeDic = %[];
	
	// トランジション後に消去フラグ
	var deleteAfterTransFlag = false;
	// トランジション後に全部表示フラグ
	var showAfterTransFlag = false;
	
	// このプラグインが使われたレイヤーの表と裏の管理
	var foreState = false;
	var backState = false;
	
	var loop = false;	// ループするか
	var loopCount = -1;	// ループする回数
	var fillColor = "";	// 画面更新の際に先ず最初に塗りつぶす色
	
	var gl_l,gl_t;
	
	var smallest = false;	// 画像幅での更新
	
	var rgamma,ggamma,bgamma;	// gamma補正値
	var rfloor,gfloor,bfloor;	// floor補正値
	var rceil,gceil,bceil;		// ceil補正値
	
	var grayscaleflag;		// リアルタイム色調補正用
	var sepiaflag;			// リアルタイム色調補正用
	var turnflag;			// リアルタイム色調補正用
	//var correct = false;	//
	
	var delay = 0;			// 何ミリ秒遅れて開始されるかの値
	var fadeInTime = -1;	// フェードインさせる時間
	var fadeOutTime = -1;	// フェードアウトさせる時間

	var alphaeffect;		// alpha用のeffectレイヤーのオブジェ番号
	var spalpha;			// ADDALPHA用のレイヤー
	
	
	var xfade = false;		// 同オブジェクト内でのクロスフェードのための変数
	var subflag;			//描画するか否か
	var MoveColorFlag = false;
	
	var anm_noise;			//アニメーションノイズ
	var EffectParent = false;
	var CopyEffect = -1;
	
	var margin_x=0;			//画像領域のマージン
	var margin_y=0;			//画像領域のマージン
	
	var fps;				//FPS
	var fcnt;				//1frameの単位時間

	var AlphaAdd;			//
	var ClearAlphaAdd;
	var seeingLevel;
	var alpha_add;
	var timeForAlphaAdd;

	var ImageReload;		//画像の再読み込みを行うか否か
	var ImageSubReload;		//画像の再読み込みを行うか否か


	var Spectrum;					//残像を行うか否か
	var SpectrumLayer = [];			//残像レイヤ前
	var SpectrumLayerBack = [];		//残像レイヤ後
	var SpectrumSubOpacity = [];	//残像の個数
	var SpectrumAbsolute = [];		//残像の個数
	var Spectrum_Max;				//残像の最大個数
	var Spectrum_Num;				//残像の個数
	var Spectrum_Time;				//残像の経過時間
	var Spectrum_Sector_Time;		//残像の総合時間
	var Spectrum_end_count;			//残り何回で処理が終了するか
	var Spectrum_Timer = void;		//残像の処理の更新時間
	var Spectrum_interval;			//残像の処理の更新時間
	var Spectrum_mode;				//残像の画像合成方法
	var Spectrum_absolute;			//残像の追加優先度
	var Spectrum_stop;				//残像の停止フラグ
	var Spectrum_stopCount;			//残像の停止フラグカウント

	var stack = []		;			//スタック処理型
	var StackCount = 0;				//スタック処理型の
	var StackLoop = false;			//
	var SpStop = false;				//エフェクト動作終了時に別の任意のエフェクトを実行再生する
	var SpScript = "";				//エフェクト動作終了時に別の任意のエフェクトを実行再生する

	var EMflag;							//
	var EffectMask;						//
	var MaskLevelA;						//
	var MaskLevelB;						//

	var EMAflag;						//
	var EMRflag;						//
	var EMRmode;						//
	var RTLflag;						//
	var RideTargetLayer;				//
	var R_em;
	var G_em;
	var B_em;
	
	function SpectrumEffectPlugin(window, no)
	{
		obj_no = no;
		super.KAGPlugin();
		this.window = window;

		// 最初にレイヤー確保
		tempLayer = new AutoPiledLayer(window, kag.fore.base);
		tempLayer.owner = this;
		tempLayer.visible = false;
		targetLayer = new Layer(window, kag.fore.base);
		targetLayerBack = new Layer(window, kag.back.base);
		alphaLayer = new Layer(window, kag.fore.base);
		
		// 念のために実体化
		moveFunc = LinearMover;
		
		//配列系の初期更新
		ArrayParamsInit();
		//初期更新
		alphaeffect = "false";
	}

	function finalize()
	{
		// 一応止めて所持オブジェクト破棄
		stop();
		ClearStack();
		clearLayer();
		deleteLayer();
		ArrayParamsFinalize();
		super.finalize(...);
	}

	function DeleteObject()
	{
		deleteAfterTransFlag = true;
		targetLayerBack.visible = false;
		StackCount = 0;
	}
	
	function DeleteObjectNow()
	{
		finish();
		clearLayer();
	}
	
	function ArrayParamsInit(){
		//配列データの終了準備
		size = new ParamsArray(1);						//
		xsize = new ParamsArray(1);						//
		ysize = new ParamsArray(1);						//
		cx = new ParamsArray(0.5);						//
		cy = new ParamsArray(0.5);						//
		rad = new ParamsArray(0);						//
		xspin = new ParamsArray(0);						//
		yspin = new ParamsArray(0);						//
		alpha_x = new ParamsArray(1);					//
		alpha_y = new ParamsArray(1);					//
		alpha_size = new ParamsArray(1);				//
		absolute = new ParamsArray(15000+obj_no);		//初期値は、15000+オブジェ番号

		EffectMask = new ParamsArray(128);				//
		MaskLevelA = new ParamsArray(10);				//
		MaskLevelB = new ParamsArray(10);				//
	}
	
	function ArrayParamsFinalize(){
		//配列データの終了準備
		invalidate size;								//
		invalidate xsize;								//
		invalidate ysize;								//
		invalidate cx;									//
		invalidate cy;									//
		invalidate rad;									//
		invalidate xspin;								//
		invalidate yspin;								//
		invalidate alpha_x;								//
		invalidate alpha_y;								//
		invalidate alpha_size;							//
		invalidate absolute;							//
		
		invalidate EffectMask;
		invalidate MaskLevelA;
		invalidate MaskLevelB;
	}
	
	function ArrayParamsClear(){
		//配列データの初期化
		size.clear();									//
		xsize.clear();									//
		ysize.clear();									//
		cx.clear();										//
		cy.clear();										//
		rad.clear();									//
		xspin.clear();									//
		yspin.clear();									//
		alpha_x.clear();								//
		alpha_y.clear();								//
		alpha_size.clear();								//
		absolute.clear();								//
		
		EffectMask.clear();
		MaskLevelA.clear();							//
		MaskLevelB.clear();							//
	}
	
	function LoopSpectrumHandler(){
		if(Spectrum_Time >= totalTime){
			if(loop){
				Spectrum_Time = Spectrum_Time - totalTime;
				return false;
			}else{
				return true;
			}
		}else{
			return false;
		}
	}

	function ExSpectrumHandler(){
		if(Spectrum_stopCount > 0){
			if(Spectrum_stop){Spectrum_stopCount--;}
			//0が有る場合は
			Spectrum_Time += Spectrum_Timer.interval;
			var Last = LoopSpectrumHandler();
			var smn = 0;
			if(!Last){
				var fn = (Spectrum_Time \ Spectrum_Sector_Time);									//FactorNumber
				var pfn = (Spectrum_Time - (fn * Spectrum_Sector_Time)) / Spectrum_Sector_Time;		//ParsentFactorNumber
				var cn = Spectrum_Num[fn+1] - Spectrum_Num[fn];										//ChangeNumber
				if(fn >= Spectrum_Num.count-1) fn=Spectrum_Num.count-1;								//
				smn = (int)(Spectrum_Num[fn] + (pfn * cn));											//SpectrumMoveNumber
			}else{
				smn = Spectrum_Num[Spectrum_Num.count-1];											//最終の個数
			}
			
			if(smn>Spectrum_stopCount){smn = Spectrum_stopCount;}
			
			if(SpectrumLayer.count > 0){
				for(var i = Spectrum_Max-1; i>0; i--){
					SpectrumLayer[i].assignImages(SpectrumLayer[i-1]);						//自身に自身の前の所持しているデータを自分に贈る【画像情報】
				}
				
				SpectrumLayer[0].assignImages(targetLayer,true,false);						//ターゲットレイヤが所持している情報を残像レイヤの先頭配列へ贈る【画像情報】
				SpectrumLayer[0].absolute = SpectrumLayer[0].absolute + Spectrum_absolute;	//ターゲットレイヤが所持している情報を残像レイヤの先頭配列へ贈る【絶対位置】
				SpectrumLayer[0].type = Spectrum_mode;										//強制的に変更
				
				/*残像のみに使用する効果*/
				SpectrumLayer[0].SpectrumAdjustGamma();
				
				for(var i=0;i<Spectrum_Max;i++){															//
					SpectrumLayer[i].SetSubOpacity(smn);													//残像の一つあたりの消失不透明度を配列に再配置
					SpectrumLayer[i].SetOpacity();															//
					SpectrumLayer[i].visible = SpectrumLayer[i].visible * targetLayer.visible;				//
					SpectrumLayerBack[i].assignImages(SpectrumLayer[i],false);								//
					SpectrumLayerBack[i].visible = SpectrumLayerBack[i].visible * targetLayerBack.visible;	//動作確認が必要
				}
			}
		}
	}

	function SetupLoadImage(elm){
		tempLayer.loadImages(elm.storage, clNone, elm.window == "true" , elm);
	}
	
	function startEffect(elm)
	{
		ImageReload = true;
		if(elm.storage === "keep"){ImageReload = false; elm.storage = storeDic.storage;}
		if(elm.bind === "keep"){ImageReload = false; elm.bind = storeDic.bind;}
		
		
		// 辞書配列をセーブ・ロード用に退避
		(Dictionary.assign incontextof storeDic)(elm);

		
		//ロード時の呼び出しの不具合の対処
		var endflag = false;
		if(elm.time <= 1){
			elm.time=100;
			endflag = true;
		}
				
		// ループするか？
		this.loop = elm.loop == "true" ? true : false;
		this.loopCount = elm.loopcount !== void ? +elm.loopcount : -1;
		// もし塗りつぶし色があったら登録
		if(elm.fillcolor !== void){
			this.fillColor = (int)elm.fillcolor;
		}else{
			this.fillColor = "";
		}

		// パスのタイプを設定
		this.pathtype = elm.pathtype == "true" ? true : false;
		// もういっちょ
		this.lu_corner = elm.lu_corner == "true" ? true : false;

		if(elm.page == "fore"){
			foreState = true;
			backState = false;
		}else if(elm.page == "back"){
			foreState = false;
			backState = true;
		}else{
			foreState = true;
			backState = true;
		}

		//このエフェクトを他のエフェクトの補助に使う場合
		if(elm.sub !== "true"){
			subflag = false;
		}else{
			subflag = true;
			backState = foreState = false;
		}

		// トランジション後削除のフラグ
		deleteAfterTransFlag = elm.delete=="true" ? true : false;
		// トランジション後表裏表示フラグ
		showAfterTransFlag = elm.show=="true" ? true : false;

		var base = window.fore.base;

		if(elm.xfade == "true" && alive)xfade = true;
		else xfade = false;
		
		if(elm.anm_noise == "true"){
			anm_noise = true;
		}else{
			anm_noise = false;
		}

		/*内側へ指定ピクセル分だけ縮める処理*/
		this.margin_x = (elm.margin_x !== void) ? +elm.margin_x : 0;
		this.margin_y = (elm.margin_y !== void) ? +elm.margin_y : 0;
		if(elm.margin != void){
			this.margin_y = this.margin_x = +elm.margin;
		}

		SpStop = false;
		SpScript = "";
		
		// 既存の動作を停止
		stop();

		/*
		画像の読み込み前に画像効果の部分を終わらせる
		*/
		
		//色を配列化する
		rgamma = (elm.rgamma !== void) ? +elm.rgamma : 1;		// 色調補正のrgammaの配列のセット
		ggamma = (elm.ggamma !== void) ?+elm.ggamma : 1;		// 色調補正のggammaの配列のセット
		bgamma = (elm.bgamma !== void) ?+elm.bgamma : 1;		// 色調補正のbgammaの配列のセット
		rfloor = (elm.rfloor !== void) ?+elm.rfloor : 0;		// 色調補正のrfloorの配列のセット
		gfloor = (elm.gfloor !== void) ?+elm.gfloor : 0;		// 色調補正のgfloorの配列のセット
		bfloor = (elm.bfloor !== void) ?+elm.bfloor : 0;		// 色調補正のbfloorの配列のセット
		rceil = (elm.rceil !== void) ? +elm.rceil : 255;		// 色調補正のrceilの配列のセット
		gceil = (elm.gceil !== void) ? +elm.gceil : 255;		// 色調補正のgceilの配列のセット
		bceil = (elm.bceil !== void) ? +elm.bceil : 255;		// 色調補正のbceilの配列のセット

		if(elm.reload === void){
			if(ImageReload){
				elm.endflag = endflag;
				tempLayer.loadImages(elm.storage, clNone, elm.window == "true" , elm);
			}
		}else{
			tempLayer.Reload(elm);
		}
		// 画像用レイヤーに効果をかける
		if(tempLayer.charaLayer === void && tempLayer.standLayer === void){
			if(elm.correct == "true" && sysCharCorrect == true){
				doCharacterCorrect(tempLayer);
			}
		}
		
		
		// 謎の処理：画像の幅が奇数の物のアフィン変換はとても苦手のようなので
		// 偶数に補正。 これが仕様なのか、下の計算が下手なだけなのかは未調査。
		//		if(tempLayer.imageWidth%2)tempLayer.imageWidth+=1;
		//		if(tempLayer.imageHeight%2)tempLayer.imageHeight+=1;

		//if(elm.alpha_x != void){alpha_x = +elm.alpha_x;}else{alpha_x = 0;}
		//if(elm.alpha_y != void){alpha_y = +elm.alpha_y;}else{alpha_y = 0;}

		ArrayParamsClear();
		
		alpha_x.ArrayForParams(elm.alpha_x);			// alpha_xの配列のセット
		alpha_y.ArrayForParams(elm.alpha_y);			// alpha_yの配列のセット
		alpha_size.ArrayForParams(elm.alpha_size);		// 絶対位置であるabsoluteの配列のセット
		
		spalpha = false;
		
		EffectParent = false;
		targetLayer.parent = kag.fore.base;
		targetLayerBack.parent = kag.back.base;
		
		// 画像の端にαを掛ける特殊な処理
		if(elm.spalpha != "false" && elm.spalpha != void){
			// αを画面に対して固定する
			spalpha = true;
			if(elm.alpha_make !== void){
				load_alpha_make(elm.alpha_make);
			}else{
				alphaLayer.loadImages((elm.spalpha != "true") ? elm.spalpha : "alpha_img");
			}
			alphaLayer.visible = false;
			elm.smallest = false;
		}else if(elm.addalpha != "false" && elm.addalpha != void){
			if(elm.alpha_make !== void){
				load_alpha_make(elm.alpha_make);
			}else{
				alphaLayer.loadImages((elm.addalpha != "true") ? elm.addalpha : "alpha_img");
				alphaLayer.visible = false;
			}
			
			// αを掛けた画像を移動する場合
			//alphaLayer.loadImages((elm.addalpha != "true") ? elm.addalpha : "alpha_img");
			//alphaLayer.visible = false;
			var tmp = new Layer(window, kag.fore.base);
			tmp.setImageSize(tempLayer.imageWidth,tempLayer.imageHeight);
			tmp.fillRect(0,0,tmp.imageWidth,tmp.imageHeight,0x00000000);
			/*
			*/
			tmp.stretchCopy( alpha_x[0], alpha_y[0],(alphaLayer.imageWidth * alpha_size[0]),(alphaLayer.imageHeight * alpha_size[0]),alphaLayer, 0, 0, alphaLayer.imageWidth, alphaLayer.imageHeight);
			
			/*不可能*/
			tempLayer.MaskRect(0, 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight, 3);
			invalidate tmp;
		}else if(elm.effectparent !== void){
			var tmp_ep = [].split("(), ", elm.effectparent, , true);
			var temp_add = +tmp_ep[0];
			//α画像の読み込み
			if(tmp_ep.count == 1){
				tmp_ep.add("eff");
			}
			
			EffectParent = true;
			
			if(tmp_ep[1] == "eff"){
				//最終targetLayerの親レイヤーの指定の画像の読み込み
				if(effect_object[temp_add].targetLayer !== void && temp_add < obj_no){
					targetLayer.parent = effect_object[temp_add].targetLayer;
					targetLayerBack.parent = effect_object[temp_add].targetLayerBack;
				}
			}else if(tmp_ep[1] == "layer"){
				if(0 <= temp_add && temp_add < kag.fore.layers.count){
					targetLayer.parent = kag.fore.layers[temp_add];
					targetLayerBack.parent = kag.back.layers[temp_add];
				}
			}else if(tmp_ep[1] == "leff"){
				temp_add = tmp_ep[0];
				if(light_eff_object !== void){
					if(temp_add == "front"){
						targetLayer.parent = light_eff_object.main;
						targetLayerBack.parent = light_eff_object.sub;
					}else if(temp_add == "rear"){
						targetLayer.parent = light_eff_object.main2;
						targetLayerBack.parent = light_eff_object.sub2;
					}else{
						EffectParent = false;
					}
				}else{
					EffectParent = false;
				}
			}
		}

		//他のレイヤーを丸々コピーする
		if(elm.copyeffect !== void){CopyEffect = +elm.copyeffect;}else{CopyEffect = -1;}

		//画像にノイズを乗っける
		if(elm.noise_level !== void){
			tempLayer.noise(+elm.noise_level);
		}else if(elm.noise == "true"){
			tempLayer.generateWhiteNoise();
		}
		
		if(elm.movecolor == "true"){MoveColorFlag = true;}else{MoveColorFlag = false;}
		// 画像用レイヤーに効果をかける
		
		if(tempLayer.charaLayer === void && tempLayer.standLayer === void){
			if(MoveColorFlag){
				if(elm.grayscale=='true'){grayscaleflag = true;}else{grayscaleflag = false;}
				if(elm.sepia == 'true'){sepiaflag = true;}else{sepiaflag = false;}
				if(elm.turn=='true'){turnflag = true;}else{turnflag = false;}
			}else{
				// グレースケール
				if(elm.grayscale=='true')tempLayer.doGrayScale();
				// ガンマ補正
				if(elm.sepia == 'true'){
					tempLayer.doGrayScale();
					rgamma = 1.3;
					ggamma = 1.1;
					bgamma = 1.0;
				}if(elm.turn=='true'){	// 階調の反転
					var rtemp = rfloor;
					var gtemp = gfloor;
					var btemp = bfloor;
					rfloor = rceil;
					gfloor = gceil;
					bfloor = bceil;
					rceil = rtemp;
					bceil = btemp;
				}
				tempLayer.adjustGamma(rgamma, rfloor, rceil, ggamma, gfloor, gceil, bgamma, bfloor, bceil);
			}

			if(elm.fliplr == 'true'){
				tempLayer.flipLR();
			}
			
			if(elm.flipud=='true'){
				tempLayer.flipUD();
			}
			// ボックスブラー
			if(elm.bblur=='true'){
				if(elm.bblur_extend == 'true'){
					//bblurの特殊コピー
					var bb_temp  = new AutoPiledLayer(kag, kag.fore.base);
					bb_temp.assignImages(tempLayer);
					bb_temp.setImageSize(bb_temp.imageWidth+(+elm.bbx*2), bb_temp.imageHeight+(+elm.bby*2));
					bb_temp.setSizeToImageSize();
					bb_temp.fillRect(0,0,bb_temp.imageWidth,bb_temp.imageHeight,0x0);
					bb_temp.copyRect(+elm.bbx,+elm.bby,tempLayer,0,0,tempLayer.imageWidth,tempLayer.imageHeight);
					tempLayer.assignImages(bb_temp);
					invalidate bb_temp;
				}
				
				tempLayer.doBoxBlur((int)elm.bbx, (int)elm.bby);
				if(elm.bblur_sq !== void){tempLayer.doBoxBlur((int)elm.bbx, (int)elm.bby);}
			}
		}
		
		//---------------------------
		// 対象レイヤーを設定
		//---------------------------
		if(elm.smallest === "true"){
			smallest = true;
			// 最小範囲なら画像サイズ×1.5準備
			targetLayer.setImageSize( tempLayer.imageWidth * 1.5, tempLayer.imageHeight * 1.5);
		}else{
			smallest = false;
			// ウィンドウサイズを変えられた場合に対処してみる
			targetLayer.setImageSize( kag.scWidth, kag.scHeight);
			//targetLayer.setImageSize( base.imageWidth, base.imageHeight);
		}

		targetLayer.setSizeToImageSize();
		targetLayer.setPos(0, 0);
		targetLayer.hitType = htMask;
		targetLayer.hitThreshold = 256;

		targetLayerBack.setImageSize( targetLayer.imageWidth, targetLayer.imageHeight);
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
		
		// 回転中心
		
		cx.ArrayForParams(elm.cx);
		for(var i=0;i < cx.params.count; i++){
			if( typeof cx.params[i] == 'Real' )cx.params[i] = tempLayer.imageWidth * cx.params[i];
		}

		cy.ArrayForParams(elm.cy);
		for(var i=0;i < cy.params.count; i++){
			if( typeof cy.params[i] == 'Real' )cy.params[i] = tempLayer.imageHeight * cy.params[i];
		}

		// 初期拡縮率
		this.ss = elm.ss !== void ? +elm.ss : 1;
		// 最終拡縮率
		this.ds = elm.ds !== void ? +elm.ds : 1;

		// サイズをパスと同じように扱ってみる
		size.ArrayForParams(elm.size);				//新関数
		xsize.ArrayForParams(elm.xsize);			//
		ysize.ArrayForParams(elm.ysize);			//
		
		// 角度もパスと同じように
		rad.ArrayForParams(elm.rad);
		for(var i = this.rad.params.count-1; i>=0; i--)this.rad.params[i] = +this.rad.params[i]*(Math.PI/180) * -1;

		//EM
		EMflag = false;
		EMAflag = false;
		EMRflag = false;
		RTLflag = false;
		EMRmode = 0;
		if(elm.em !== void){
			EMflag = true;
			EffectMask.ArrayForParams(elm.em);					//モザイクのピクセル変動値を配列化
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

			RideTargetLayer = void;
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
		}
		
		// 時間設定
		this.time = elm.time !== void ? +elm.time : 1000;
		if(this.time<=1)this.time = 1;
		
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;
		AllgettimeForState();
		
		// 加速度設定
		this.accel = elm.accel !== void ? +elm.accel : 0;
		
		// 特殊な加速を使うか？（減速→加速）
		if(elm.spaccel == "true"){
			this.accel = Math.abs(this.accel);
			this.spaccel = true;
		}else this.spaccel = false;
		
		// 表示タイプ設定
		if(EffectParent == false){
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
		affintype = stFastLinear;

		// アフィン中に周りをクリアするかどうか
		this.clear = elm.clear == 'false' ? false : true;

		// 移動位置計算関数の設定
		if(elm.spline == 'true'){
			PreSpline( path, zx, zy);
			moveFunc = SplineMover;
		}else moveFunc = LinearMover;

		// ズーム用関数の設定
		zoomFunc = fillColor == "" ? moveAt : moveAtWithFillRect;
		
		// ディレイ設定
		if(elm.delay !== void){
			delay = +elm.delay;
			targetLayer.fillRect(0,0,targetLayer.imageWidth,targetLayer.imageHeight,0x0);
			targetLayerBack.assignImages(targetLayer);
		}else delay = 0;
		
		//effect用アルファの生成
		alphaeffect = "false";
		if(elm.alphaeffect !== void && elm.alphaeffect == "leff"){
			alphaeffect = "leff";
			smallest = false;
		}else if(elm.alphaeffect !== void){
			smallest = false;
			var temp = +elm.alphaeffect;
			if(effect_object[temp] !== void && temp != obj_no){
				alphaeffect = temp;
			}
		}
		
		// フェード設定
		if(elm.fadeintime !== void)fadeInTime = +elm.fadeintime;
		else fadeInTime = -1;
		if(elm.fadeouttime !== void)fadeOutTime = +elm.fadeouttime;
		else fadeOutTime = -1;

		if(elm.fps !== void){
			fps = +elm.fps;
			fcnt = 1000 / fps;
		}else{
			fps = -1;
			fcnt = -1;
		}
		
		targetLayer.absolute = absolute.params[0];
		targetLayerBack.absolute = absolute.params[0];

		/**/
		if(elm.alphaturn !== void){
			tempLayer.turnAlpha();
		}

		if(elm.outline !== void){
			//ボカシ用の画面拡張
			var outline_temp = new AutoPiledLayer(kag, kag.fore.base);
			outline_temp.assignImages(tempLayer);
			outline_temp.setImageSize(outline_temp.imageWidth+(+elm.outline_x*2), outline_temp.imageHeight+(+elm.outline_y*2));
			outline_temp.setSizeToImageSize();
			outline_temp.fillRect(0,0,outline_temp.imageWidth,outline_temp.imageHeight,0x0);
			outline_temp.copyRect(+elm.outline_x,+elm.outline_y,tempLayer,0,0,tempLayer.imageWidth,tempLayer.imageHeight);
			tempLayer.assignImages(outline_temp);
			invalidate outline_temp;
			
			if(elm.outline == "in"){
				/*問題なし*/
				var tmp = new Layer(kag, kag.fore.base);
				tmp.assignImages(tempLayer);
				tmp.turnAlpha();
				tempLayer.doBoxBlur(+elm.outline_x, +elm.outline_y);
				tempLayer.operateRect(0,0, tmp, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, omPsNormal, 255);
				tempLayer.turnAlpha();
				
				invalidate tmp;
			}else if(elm.outline == "out"){
				/*問題なし*/
				var tmp = new Layer(kag, kag.fore.base);
				var tmp_face;
				tmp.assignImages(tempLayer);
				tempLayer.doBoxBlur(+elm.outline_x, +elm.outline_y);
				tempLayer.turnAlpha();
				tmp_face = tempLayer.face;
				tempLayer.face = dfOpaque;
				tempLayer.operateRect(0,0, tmp, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, omAlpha, 255);
				tempLayer.turnAlpha();
				//tempLayer.turnOutline();
				tempLayer.face = tmp_face;
				invalidate tmp;
			}else if(elm.outline == "both"){
				/*問題なし*/

				var tmp1 = new Layer(kag, kag.fore.base);
				tmp1.assignImages(tempLayer);
				tmp1.doBoxBlur(+elm.outline_x, +elm.outline_y);
				tmp1.turnOutline();

				var tmp2 = new Layer(kag, kag.fore.base);
				
				tmp2.assignImages(tempLayer);
				tmp2.turnAlpha();
				tmp2.doBoxBlur(+elm.outline_x, +elm.outline_y);
				tmp2.turnOutline();

				var tmp_face;
				tmp_face = tempLayer.face;
				tempLayer.face = dfOpaque;
				tempLayer.assignImages(tmp1);
				tempLayer.operateRect(0,0, tmp2, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, omAlpha, 255);
				tempLayer.face = tmp_face;
				tempLayer.turnOutline();
				tempLayer.turnAlpha3();
				
				invalidate tmp1;
				invalidate tmp2;
			}
		}

		AlphaAdd = false;
		ClearAlphaAdd = false;
		seeingLevel = 0;
		if(elm.alpha_add !== void){
			AlphaAdd = true;
			alpha_add = set_array(elm.alpha_add,0);
			timeForAlphaAdd = gettimeForState(alpha_add);

			if(elm.clearalpha !== void){
				ClearAlphaAdd = true;
			}
			
			if(elm.slv !== void){
				seeingLevel = +elm.slv;
			}
		}
		
		if(elm.a_r !== void || elm.a_g !== void || elm.a_b !== void){
			if(elm.a_r === void){elm.a_r = -1;}else{elm.a_r = +elm.a_r;}
			if(elm.a_g === void){elm.a_g = -1;}else{elm.a_g = +elm.a_g;}
			if(elm.a_b === void){elm.a_b = -1;}else{elm.a_b = +elm.a_b;}
			tempLayer.AlphaColorRect(elm.a_r, elm.a_g, elm.a_b);
		}

		//残像演出処理
		Spectrum = false;
		Spectrum_stop = false;
		if(elm.spectrum_max !== void){
			Spectrum = true;
			Spectrum_Max = +elm.spectrum_max;
			Spectrum_stopCount = Spectrum_Max;
			
			if(elm.spectrum_num !== void) Spectrum_Num = set_array(elm.spectrum_num,Spectrum_Max);
			else Spectrum_Num = [Spectrum_Max, Spectrum_Max];
			Spectrum_Time = 0;
			Spectrum_Sector_Time = totalTime \ (Spectrum_Num.count - 1);
			if(elm.spectrum_mode !== void) Spectrum_mode = imageTagLayerType[elm.spectrum_mode].type;
			else Spectrum_mode = targetLayer.type;
			
			if(elm.spectrum_absolute !== void) Spectrum_absolute = +elm.spectrum_absolute;
			else Spectrum_absolute = 0;
			
			var so = 1 / (Spectrum_Max + 1);
			if(Spectrum_Max > SpectrumLayer.count){
				//エフェクト数を合わせる【作成】
				var cslc = Spectrum_Max - SpectrumLayer.count;
				for(var i=0;i<cslc;i++){
					SpectrumLayer.add(new ExSpectrumLayer(kag, kag.fore.base, i));
					SpectrumLayerBack.add(new ExSpectrumLayer(kag, kag.back.base, i));
					SpectrumLayer[i].SizeSetup(targetLayer.imageWidth,targetLayer.imageHeight);
					SpectrumLayer[i].visible = foreState;
					SpectrumLayerBack[i].assignImages(SpectrumLayer[i]);
					SpectrumLayerBack[i].visible = backState;
				}

				for(var i=cslc;i<SpectrumLayer.count;i++){
					SpectrumLayer[i].Init();
					SpectrumLayerBack[i].Init();
				}
			}else{
				//エフェクト数を合わせる【削除】
				for(var i=Spectrum_Max;i<SpectrumLayer.count;){
					invalidate SpectrumLayer[i];
					SpectrumLayer.erase(i);
					invalidate SpectrumLayerBack[i];
					SpectrumLayerBack.erase(i);
				}
			}
			
			Spectrum_Timer = new Timer(ExSpectrumHandler,"");
			Spectrum_Timer.enabled = false;
			Spectrum_Timer.interval = 100;
			if(elm.spectrum_interval !== void){ Spectrum_Timer.interval = +elm.spectrum_interval;}
			if(elm.spectrum_adjust !== void && SpectrumLayer.count > 0){
				SpectrumLayer[0].SetAdjustGamma(elm);
			}
		}else{
			for(var i=0; i < SpectrumLayer.count; i++){
				SpectrumLayer[i].visible = false;
				invalidate SpectrumLayer[i];
			}
			for(var i=0; i < SpectrumLayerBack.count; i++){
				SpectrumLayerBack[i].visible = false;
				invalidate SpectrumLayerBack[i];
			}
			SpectrumLayer.clear();
			SpectrumLayerBack.clear();
			Spectrum_Max = 0;
		}
		
		if(elm.play !== void) SpScript = elm.play;
		if(elm.stop !== void) SpStop = (elm.play == "true") ? true : false;
		
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
			moveFunc(0);
			targetLayer.visible = foreState;
			targetLayerBack.visible = backState;
		}
		// 開始
		if(Spectrum){Spectrum_Timer.enabled = true;}
		lasttick = starttick = System.getTickCount();
		
		System.addContinuousHandler(continuousHandler);
		moving = true;
		alive = true;
	}

	function moveAtWithFillRect( m00, m01, m10, m11, mtx, mty )
	{
		targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, fillColor);
		// アフィン変換転送
		targetLayer.affineCopy(
					tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
					m00, m01, m10, m11, mtx, mty, affintype, clear
					);
		//targetLayerBack.assignImages(targetLayer);
	}

	function moveAt( m00, m01, m10, m11, mtx, mty )
	{
		if(xfade){
			targetLayerBack.affineCopy(
					tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
					m00, m01, m10, m11, mtx, mty, affintype, clear
					);
		}else{
			// アフィン変換転送
			targetLayer.affineCopy(
						tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
						m00, m01, m10, m11, mtx, mty, affintype, clear
						);
			//targetLayerBack.assignImages(targetLayer);
		}
	}
	
	// 現在の角度を取得する関数
	function getAngle(tick)
	{
		var ratio = tick / totalTime;
		// 角度・拡大率計算
		// パスと同等に角度も扱った場合
		var radIndex = (int)(tick / timeForRad);
		var radRatio = (tick-(radIndex*timeForRad)) / timeForRad;
		var r = (rad[radIndex+1] - rad[radIndex])*radRatio + rad[radIndex];
		return r;
	}

	//要素を引き出す物
	function getNowState(tick,state,tf_state)
	{
		//サイズの作りに合わせる
		var StateIndex = (int)(tick / tf_state);
		var StateRatio = (tick - (StateIndex*tf_state))/ tf_state;
		var n_s = (state[StateIndex+1] - state[StateIndex])*StateRatio + state[StateIndex];
		
		return n_s;
	}
	
	//自身の配列間の時間を確認
	function gettimeForState(state){
		var timeForState = totalTime / (state.count-1);
		if(timeForState<=1)return 1;
		return timeForState;
	}

	//配列の格納
	function set_array(e_array,a_def){
		var s_array;
		if(e_array === void)s_array = [a_def,a_def];
		else{
			s_array = [].split("(), ", e_array, , true);
			if(s_array.count != 1){
				for(var i = s_array.count-1; i>=0; i--)s_array[i] = (+s_array[i]);
			}else{
				s_array = [(+s_array[s_array.count-1]),(+s_array[s_array.count-1])];
			}
		}
		return s_array;
	}
	function BeforeHandle(tick){}
	
	function AfterHandle(tick){
		targetLayerBack.assignImages(targetLayer);
	}

	function ReturnAccelTick(_t){
		var _at = _t;
		if(spaccel){
			// 減速・加速のセット
			var halfTime = totalTime/2;
			if(_at <= halfTime){
				_at = 1.0 - _at / halfTime;
				_at = Math.pow(_at, accel);
				_at = int ( (1.0 - _at) * halfTime );
			}else{
				_at -= halfTime;
				_at = _at / halfTime;
				_at = Math.pow(_at, accel);
				_at = int ( _at * halfTime );
				_at += halfTime;
			}
		}else if(accel < 0){
			// 上弦 ( 最初が動きが早く、徐々に遅くなる )
			_at = 1.0 - _at / totalTime;
			_at = Math.pow(_at, -accel);
			_at = int ( (1.0 - _at) * totalTime );
		}else if(accel > 0){
			// 下弦 ( 最初は動きが遅く、徐々に早くなる )
			_at = _at / totalTime;
			_at = Math.pow(_at, accel);
			_at = int ( _at * totalTime );
		}
		
		return _at;
	}
	
	function AccompanyEffect(tick){
		
		//spalphaの不透明化処理
		var al_s = alpha_size.GetNowParams(tick);
		var al_x = alpha_x.GetNowParams(tick);
		var al_y = alpha_y.GetNowParams(tick);
		
		if(alphaeffect != "false"){
			if(alphaeffect != "leff"){
				if(!smallest && !effect_object[alphaeffect].smallest){
					if(effect_object[alphaeffect].alive){
						targetLayer.MaskRect(0, 0, effect_object[alphaeffect].targetLayer, 0, 0, targetLayer.imageWidth, targetLayer.imageHeight,3);
					}
				}
			}else{
				if(!smallest){
					if(light_eff_object.main.visible){
						targetLayer.MaskRect(0, 0, light_eff_object.main, 0, 0, targetLayer.imageWidth, targetLayer.imageHeight,3);
					}
				}
			}
		}else if(spalpha == true){
			var tmp = new Layer(kag, kag.fore.base);
			tmp.setImageSize(targetLayer.imageWidth,targetLayer.imageHeight);
			tmp.stretchCopy( al_x , al_y,(alphaLayer.imageWidth * al_s),(alphaLayer.imageHeight * al_s),alphaLayer, 0, 0, alphaLayer.imageWidth, alphaLayer.imageHeight);
			targetLayer.MaskRect(0, 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight,3);
			invalidate tmp;
		}
		
		if(anm_noise){
			targetLayer.generateWhiteNoise();
		}

		if(AlphaAdd){
			var _a_add = (int)(getNowState(tick,alpha_add,timeForAlphaAdd));
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
			//"mla:"+_m_level_a);
			//dm("mlb:"+_m_level_b);
			//targetLayer.LevelMaskRect(_e_mask,_m_level_a);
			if(RTLflag){
				targetLayer.MaskImageRideRect4(RideTargetLayer,alphaLayer,_e_mask,_m_level_b, R_em, G_em, B_em);
			}else if(EMRflag){
				if(EMRmode == 2){
					targetLayer.MaskImageRideRect3(alphaLayer,_e_mask,_m_level_b, R_em, G_em, B_em);
				}else if(EMRmode == 1){
					targetLayer.MaskImageRideRect2(alphaLayer,_e_mask,_m_level_a, R_em, G_em, B_em);
				}else{
					targetLayer.MaskImageRideRect(alphaLayer,_e_mask,_m_level_a,_m_level_b, R_em, G_em, B_em);
				}
			}else if(EMAflag){
				targetLayer.MaskImageEffectRect(alphaLayer,_e_mask,_m_level_a,_m_level_b, R_em, G_em, B_em);
			}else{
				targetLayer.LevelMaskRect2(_e_mask,_m_level_a,_m_level_b);
			}
		}
	}
	
	function LinearMover(tick)
	{
		BeforeHandle(tick);
		
		// 経過秒数 \ 一点を通過するための時間 * 3
		var index = tick \ time * 3;
		// 経過秒数 % 一点を通過するための時間 / 一点を通過するための秒数
		var ratio = tick % time / time;

		if(tick >= totalTime){
			index = totalTime \ time * 3;
			ratio = 0;
		}
		
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
		targetLayer.opacity = targetLayerBack.opacity = _opacity;

		//現在のポジションの不透明度
		
		// 角度・拡大率計算
		var r = rad.GetNowParams(tick);
        var s = size.GetNowParams(tick);
		var s_x = xsize.GetNowParams(tick);
		var s_y = ysize.GetNowParams(tick);
        var xsp = xspin.GetNowParams(tick);
		var ysp = yspin.GetNowParams(tick);
		var abs = absolute.GetNowParams(tick);
		var c_x = cx.GetNowParams(tick);
		var c_y = cy.GetNowParams(tick);

		if(margin_x != 0){
			var mx_rate = ((s * s_x * tempLayer.imageWidth) - (margin_x*2)) / (s * s_x * tempLayer.imageWidth);
			s_x = s_x * mx_rate;
			//dm("mx_rate:"+mx_rate);
		}
		if(margin_y != 0){
			var my_rate = ((s * s_y * tempLayer.imageHeight) - (margin_y*2)) / (s * s_y * tempLayer.imageHeight);
			s_y = s_y * my_rate;
			//dm("my_rate:"+my_rate);
		}
		
		targetLayer.absolute = abs;
		targetLayerBack.absolute = targetLayer.absolute;
		
		if(lu_corner){
			l += (tempLayer.imageWidth/2)*s;
			t += (tempLayer.imageHeight/2)*s;
		}else if(pathtype){
			// pathで指定するのは画面の中心に画像のどこのピクセルをを持ってくるか
			//l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-cx)*s;
			//t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-cy)*s;

			l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-c_x)*s;
			t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-c_y)*s;
		}else{
			// pathで指定するのは画像における中心を画面のどこに置くか
			//l -= (tempLayer.imageWidth/2-cx)*s;
			//t -= (tempLayer.imageHeight/2-cy)*s;

			l -= (tempLayer.imageWidth/2-c_x)*s;
			t -= (tempLayer.imageHeight/2-c_y)*s;
		}

		// メンバに現在座標をセット
		gl_l = l;
		gl_t = t;

		//現在のポジションのデータ
		
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

		if(smallest){
			mtx += targetLayer.imageWidth\2;
			mty += targetLayer.imageHeight\2;
		}		
		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty);
		
		AccompanyEffect(tick);
		AfterHandle(tick);
	}

	function SplineMover(tick)
	{
		BeforeHandle(tick);
		
		var index;
		var pindex = (index = tick \ time) * 3;
		var d = tick % time / time;
		var p = path;

		if(tick >= totalTime){
			index = totalTime \ time * 3;
			pindex = index;
			d = 0;
		}
		
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

		targetLayer.opacity = targetLayerBack.opacity = eo >= 256 ? so : int((eo-so)*d + so);
		
		//現在のポジションの不透明度
		
		// 角度・拡大率計算
		var r = rad.GetNowParams(tick);
        var s = size.GetNowParams(tick);
		var s_x = xsize.GetNowParams(tick);
		var s_y = ysize.GetNowParams(tick);
        var xsp = xspin.GetNowParams(tick);
		var ysp = yspin.GetNowParams(tick);
		var abs = absolute.GetNowParams(tick);
		var c_x = cx.GetNowParams(tick);
		var c_y = cy.GetNowParams(tick);
		
		if(margin_x != 0){
			var mx_rate = ((s * s_x * tempLayer.imageWidth) - (margin_x*2)) / (s * s_x * tempLayer.imageWidth);
			s_x = s_x * mx_rate;
		}
		if(margin_y != 0){
			var my_rate = ((s * s_y * tempLayer.imageHeight) - (margin_y*2)) / (s * s_y * tempLayer.imageHeight);
			s_y = s_y * my_rate;
		}

		targetLayer.absolute = abs;
		targetLayerBack.absolute = targetLayer.absolute;
		
		if(pathtype == "true"){
			// pathで指定するのは画面の中心に画像のどこのピクセルをを持ってくるか
			l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-c_x)*s;
			t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-c_y)*s;
		}else{
			// pathで指定するのは画像における中心を画面のどこに置くか
			l -= (tempLayer.imageWidth/2-c_x)*s;
			t -= (tempLayer.imageHeight/2-c_y)*s;
		}

		// メンバに現在座標をセット
		gl_l = l;
		gl_t = t;
		
		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI/2.0) - r);

		// 縦・横回転のコード
		var xrate = 1, yrate = 1;
		xrate = Math.sin(Math.PI*(xsp * 2 + 0.5));
		yrate = Math.sin(Math.PI*(ysp * 2 + 0.5));
		
		var m00 = s * rc * yrate * s_x;
		var m01 = s * -rs * yrate * s_x;
		var m10 = s * rs * xrate * s_y;
		var m11 = s * rc * xrate * s_y;
		
		var mtx = (m00*-c_x) + (m10*-c_y) + l;
		var mty = (m01*-c_x) + (m11*-c_y) + t;
		
		if(smallest){
			mtx += targetLayer.imageWidth\2;
			mty += targetLayer.imageHeight\2;
		}

		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty);
		AccompanyEffect(tick);
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
		size.TimeForParams(totalTime);						//サイズ用の時間を計算
		xsize.TimeForParams(totalTime);						//サイズ用の時間を計算
		ysize.TimeForParams(totalTime);						//サイズ用の時間を計算
		rad.TimeForParams(totalTime);						// 角度用の時間を計算
		xspin.TimeForParams(totalTime);						// XSpin用の時間を計算
		yspin.TimeForParams(totalTime);						// YSpin用の時間を計算
		absolute.TimeForParams(totalTime);					// absolute用の時間を計算
		alpha_size.TimeForParams(totalTime);				// alpha_size用の時間を計算
		alpha_x.TimeForParams(totalTime);					// alpha_x用の時間を計算
		alpha_y.TimeForParams(totalTime);					// alpha_y用の時間を計算
		cx.TimeForParams(totalTime);						// alpha_x用の時間を計算
		cy.TimeForParams(totalTime);						// alpha_y用の時間を計算

		if(EMflag){
			EffectMask.TimeForParams(totalTime);
			MaskLevelA.TimeForParams(totalTime);
			MaskLevelB.TimeForParams(totalTime);
		}
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
				moveFunc(0);
				targetLayer.visible = foreState;
				targetLayerBack.visible = backState;
			}
			return;
		}

		if(fcnt > (tick-lasttick)){
			return;
		}
		//dm("■FPS：" + 1000/(tick-lasttick));
		
		lasttick=tick;
		tick -= starttick;
		
		// 時間通りか過ぎてるなら終わる
		if(tick >= totalTime)
		{
			if(loop){
				// もしループフラグが立ってるなら初期値に戻す
				if(loopCount == -1){
					starttick = starttick + totalTime;
					tick = tick - totalTime;
				}else if(loopCount > 0){
					starttick = starttick + totalTime;
					tick = tick - totalTime;
					loopCount--;
				}else{
					finish();
					return;
				}
			}else{
				Spectrum_stop = true;
				if(stack.count-1 != StackCount || StackLoop){
					Spectrum_stopCount = 0;
				}
				if(Spectrum_stopCount<=0){
					finish();
					return;
				}else{
					tick = totalTime;
				}
			}
			moveFunc(tick);
			return;
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
		// 移動
		moveFunc(tick);
	}
	
	// 最終状態を表示
	function finish()
	{
		if(clear)targetLayer.fillRect(0, 0, targetLayer.width, targetLayer.height, 0x0);
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
		
		moveFunc(totalTime);
		stop();
	}

	function replacement_finish()
	{
		moveFunc(totalTime);
		stop();
	}

	function onTag()
	{
		if(alive && !moving)finish();
		//色調補正
	}

	// 停止
	function stop(sflag = false)
	{
		if(moving)
		{
			System.removeContinuousHandler(continuousHandler);
			moving = false;
			if(Spectrum_Timer !== void){
				Spectrum_Timer.enabled = false;
				invalidate Spectrum_Timer;
				Spectrum_Timer = void;
			}
			if(SpScript != ""){ spectrum_effect_object[SpScript].StartStack(%[]);}
			StackCount++;
			if(stack.count > StackCount && !SpStop){
				startEffect(stack[StackCount]);
			}else{
				if(StackLoop && !SpStop){
					StackCount = 0;
					if(stack.count > StackCount) startEffect(stack[StackCount]);
				}else if(!SpStop){
					//si(obj_no);
					window.trigger('sp_effect_plugin'+obj_no);
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
				window.trigger('sp_effect_plugin_cutin'+obj_no);
				tempLayer.cutinLayer.stop_move();
			}
		}
	}
	
	/*画像保存用*/
	function saveLayer(){
		targetLayer.saveLayerImage(System.exePath+"obj_"+obj_no+".bmp","bmp");
	}
	
	/*アルファ画像作成用*/
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
						/**/
						atmp1.assignImages(alphaLayer);
						alphaLayer.fillRect(0,0,alphaLayer.imageWidth, alphaLayer.imageHeight,0xff000000);
						alphaLayer.MaskRect(0, 0, atmp1, 0, 0, alphaLayer.imageWidth, alphaLayer.imageHeight, 0);
					}
				}
				alphaLayer.MaskRect(sl, st, atmp2, 0, 0, atmp2.imageWidth, atmp2.imageHeight, _atype);
			}
			for(var i=0;i < alpha_x.count;i++){alpha_x[i] = alpha_x[i] + lx;}
			for(var i=0;i < alpha_y.count;i++){alpha_y[i] = alpha_y[i] + ty;}
			invalidate atmp1;
			invalidate atmp2;
		}else{
			si("指定が有りません");

		}
	}
	
	// レイヤーを削除
	function deleteLayer()
	{
		alive = false;
		stop();
		invalidate tempLayer if tempLayer !== void;
		tempLayer = void;
		invalidate targetLayer if targetLayer !== void;
		invalidate targetLayerBack if targetLayerBack !== void;
		invalidate alphaLayer if alphaLayer !== void;
		targetLayer = targetLayerBack = alphaLayer = void;
	}

	function clearLayer()
	{
		alive = false;
		stop();
		tempLayer.loadImages("ImgClear");
		tempLayer.setSizeToImageSize();
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
		spalpha=false;
		EffectParent = false;
		alphaeffect="false";
		
		if(Spectrum){
			if(Spectrum_Timer !== void){
				Spectrum_Timer.enabled = false;
				invalidate Spectrum_Timer;
			}
			
			for(var i=0;i<Spectrum_Max;i++){
				SpectrumLayer[i].loadImages("ImgClear");
				SpectrumLayer[i].visible = false;
				SpectrumLayerBack[i].loadImages("ImgClear");
				SpectrumLayerBack[i].visible = false;
				invalidate SpectrumLayer[i];
				invalidate SpectrumLayerBack[i];
			}
			Spectrum = false;
			Spectrum_Max = 0;
			SpectrumLayer.clear();
			SpectrumLayerBack.clear();
		}
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
			
			AllgettimeForState();
		}
	}

	function onStore(f, elm)
	{
		if(alive){
			var dic = f["spectrum_effect" + obj_no] = %[];
			(Dictionary.assign incontextof dic)(storeDic);
			dic.moving = moving;
			dic.foreVisible = targetLayer.visible;
			dic.backVisible = targetLayerBack.visible;
			dic.deleteAfterTransFlag = deleteAfterTransFlag;
			/*スタック処理*/
			dic.stack = this.stack;
			dic.stackloop = this.StackLoop;
			dic.stackcount = this.StackCount;
			if(tempLayer.cutinLayer !== void){
				if(!tempLayer.cutinLayer.cmactiv && !tempLayer.cutinLayer.mmactiv && !tempLayer.cutinLayer.lmactiv){dic.cutin_end = true;
				}else{dic.cutin_end = false;}
				dic.cutin = tempLayer.cutinLayer.storeDic.cutin;
				dic.main = tempLayer.cutinLayer.storeDic.main;
				dic.line = tempLayer.cutinLayer.storeDic.line;
			}
		}else{
			f["spectrum_effect" + obj_no] = void;
		}
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		stop(); // 動作を停止
		clearLayer();	// 削除
		var dic = f["spectrum_effect" + obj_no];
		if(dic !== void){
			if(dic.stack !== void) this.stack.assign(dic.stack);
			if(dic.stackloop !== void) this.StackLoop = dic.stackloop;
			if(dic.stackcount !== void) this.StackCount = dic.stackcount;
			
			if(this.StackCount == -1){
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
				StopStack();
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

		if(Spectrum){
			for(var i=0;i < SpectrumLayer.count;i++){
				var tmp = SpectrumLayer;
				SpectrumLayer = SpectrumLayerBack;
				SpectrumLayerBack = tmp;
			}
		}
		
		if(deleteAfterTransFlag){clearLayer();}
		
		if(showAfterTransFlag && targetLayer !== void && targetLayerBack !== void){
			targetLayer.visible = targetLayerBack.visible = true;
			if(Spectrum){
				for(var i=0;i < SpectrumLayer.count;i++){
					SpectrumLayer[i].visible = SpectrumLayerBack[i].visible = true;
				}
			}
		}
		if(subflag && targetLayer !== void && targetLayerBack !== void){
			targetLayer.visible = targetLayerBack.visible = false;
			if(Spectrum){
				for(var i=0;i < SpectrumLayer.count;i++){
					SpectrumLayer[i].visible = SpectrumLayerBack[i].visible = false;
				}
			}
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
			dm("スタックが有りません");
		}
	}

	function StartNumberStack(lp,n)
	{
		StackLoopCheck(%[stackloop:lp]);
		this.StackCount = +n;
		if(stack.count > this.StackCount){
			dm(":"+this.StackCount);
			StackCount = this.StackCount;
			stop();
			//startEffect(stack[this.StackCount]);
		}else{
			dm("そのスタックは有りません");
		}
	}

	function StartCallStack(lp,n)
	{
		dm("N:"+n);
		dm("n:"+this.StackCount);
		
		if(n > this.StackCount || (n == this.StackCount && moving == false)){
			StackLoopCheck(%[stackloop:lp]);
			this.StackCount = +n;
			dm("SC:"+this.StackCount);
			dm("sc:"+this.stack.count);
			if(stack.count > this.StackCount){
				StackCount = this.StackCount;
				stop();
				startEffect(stack[this.StackCount]);
			}else{
				dm("そのスタックは有りません");
			}
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
		StackCount=0;
		//dm("stack:"+stack.count);
	}

	function StopStack(){
		if(stack.count > 0){
			var tmp = %[];
			this.StackLoop = false;
			(Dictionary.assign incontextof tmp)(stack[stack.count-1]);
			tmp.time = 0;
			startEffect(tmp);
			(Dictionary.clear incontextof tmp)();
		}
	}

	function StackLoopCheck(elm){
		StackLoop = elm.stackloop == "true" ? true : false;
		StackCount = -1;
	}
	
}

var spectrum_effect_object = new Array();
{
	var effect_max_num = 3;
	for( var i = 0 ; i < effect_max_num; i++ )
	{
		kag.addPlugin(global.spectrum_effect_object[i] = new SpectrumEffectPlugin(kag, i));
	}
}

// すべてを一気に停止させるための関数
function SpectrumEffectAllStopFunction(){
	for(var i=0; i<spectrum_effect_object.count; i++){
		if(spectrum_effect_object[i].moving){
			spectrum_effect_object[i].StackLoop = false;
			if(spectrum_effect_object[i].stack.count > 0){
				spectrum_effect_object[i].StopStack();
			}else{
				spectrum_effect_object[i].finish();
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
function SpectrumEffectAllDeleteFunction(){
	for(var i=0; i<spectrum_effect_object.count; i++){
		if(spectrum_effect_object[i].alive){
			spectrum_effect_object[i].StackLoop = false;
			spectrum_effect_object[i].ClearStack();
			spectrum_effect_object[i].deleteAfterTransFlag = true;
			spectrum_effect_object[i].targetLayerBack.visible=false;
		}else{
			spectrum_effect_object[i].ClearStack();
		}
	}
}

// すべてを一気に削除の関数
function SpectrumEffectAllDeleteNowFunction(){
	for(var i=0; i<spectrum_effect_object.count; i++){
		if(spectrum_effect_object[i].alive){
			spectrum_effect_object[i].StackLoop = false;
			spectrum_effect_object[i].ClearStack();
			spectrum_effect_object[i].finish();
			spectrum_effect_object[i].clearLayer();
		}else{
			spectrum_effect_object[i].ClearStack();
		}
	}
}

function SpectrumEffectFinish(mp){
	var num = +mp.obj;
	for(var i=0;i<spectrum_effect_object[num].stack.count;i++){
		if(spectrum_effect_object[num].stack[i].play !== void){
			var n = +spectrum_effect_object[num].stack[i].play;
			var td = %[];
			with(spectrum_effect_object[n]){
				(Dictionary.assign incontextof td)(.stack[0]);
			}
			spectrum_effect_object[n].startEffect(td);
			(Dictionary.clear incontextof td)();
			
		}
	}
	spectrum_effect_object[num].StopStack();
	spectrum_effect_object[num].finish();
}

function SpectrumAllCallFlag(num){
	var flag = false;
	for(var i=0;i<spectrum_effect_object.count;i++){
		for(var j=0;j<spectrum_effect_object[i].stack.count;j++){
			if(spectrum_effect_object[i].stack[j].play !== void){
				if(+spectrum_effect_object[i].stack[j].play == num){
					flag = true;
				}
			}
		}
	}
	return flag;
}

function SpectrumEffectSkipFlag(elm){
	var num = +mp.obj;
	var flag = true;
	
	if(spectrum_effect_object[num].StackLoop) flag=false;
	if(spectrum_effect_object[num].moving){
		if(spectrum_effect_object[num].loop){
			if(spectrum_effect_object[num].loopCount == -1){
				flag = false;
			}
		}
	}else{
		if(!SpectrumAllCallFlag(num)){
			flag = false;
		}
	}
	
	//dm("flag:"+flag);
	return flag;
}

@endscript
@endif
;
; マクロ登録

@macro name="speff"
@eval exp="spectrum_effect_object[+mp.obj].StackLoopCheck(mp)"
@eval exp="spectrum_effect_object[+mp.obj].startEffect(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="speff_load"
@eval exp="spectrum_effect_object[+mp.obj].SetupLoadImage(mp)"
@endmacro

@macro name="speff_stack_start"
@eval exp="spectrum_effect_object[+mp.obj].StartStack(mp)"
@endmacro

@macro name="speff_stack_start_call"
@eval exp="spectrum_effect_object[+mp.obj].StartCallStack(mp.stackloop,mp.stacknum)"
@endmacro

@macro name="speff_stack_start_num"
@eval exp="spectrum_effect_object[+mp.obj].StartNumberStack(mp.stackloop,mp.stacknum)"
@endmacro

@macro name="speff_stack"
@eval exp="spectrum_effect_object[+mp.obj].AddStack(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro

;
@macro name="spweff"
@waittrig * name="&'sp_effect_plugin'+(int)mp.obj" onskip="SpectrumEffectFinish(mp)" canskip=%canskip|true cond="SpectrumEffectSkipFlag(mp)"
@endmacro

@macro name="spwseff"
//@waittrig * name="&'sp_effect_plugin'+(int)mp.obj+'_'+(int)(mp.stack)" onskip="SpectrumEffectFinish(mp)" canskip=%canskip|true cond="SpectrumEffectSkipFlag(mp)"
@endmacro
;
@macro name="spseff"
@eval exp="spectrum_effect_object[+mp.obj].finish()" cond="spectrum_effect_object[+mp.obj].moving"
@endmacro
;
@macro name="spaseff"
@eval exp="SpectrumEffectAllStopFunction()"
@endmacro

@macro name="speff_delete"
@eval exp="spectrum_effect_object[+mp.obj].DeleteObject()" cond="spectrum_effect_object[+mp.obj].alive"
@endmacro

@macro name="speff_delete_now"
@eval exp="spectrum_effect_object[+mp.obj].DeleteObjectNow()" cond="spectrum_effect_object[+mp.obj].alive"
@endmacro

@macro name="speff_trans"
@eval exp="mp.page = 'back'; mp.transTime = +mp.time; mp.time = 0;"
@eval exp="spectrum_effect_object[+mp.obj].startEffect(mp)"
@weff *
@trans * layer=base method="&mp.method !== void ? mp.method : (mp.rule === void ? 'crossfade' : 'universal')" time=%transTime|1000
@wt
@eval exp="spectrum_effect_object[+mp.obj].targetLayer.visible=true, spectrum_effect_object[+mp.obj].targetLayerBack.visible=true"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="speff_all_delete"
@eval exp="SpectrumEffectAllDeleteFunction();"
@endmacro

@macro name="speff_all_delete_now"
@eval exp="SpectrumEffectAllDeleteNowFunction();"
@endmacro


@return

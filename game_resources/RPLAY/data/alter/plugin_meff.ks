@if exp="typeof(global.multi_eff_object) == 'undefined'"

@call storage="plugin_meff_define.ks"
@call storage="plugin_meff_spmode.ks"

@iscript
;//今後の改造予定
;//マルチ系のエフェクト計算を上位の管理クラスが管理を行う

class MultiEffectPlugin extends KAGPlugin
{
	var window;
	var obj_no = 0;						// object番号
	
	var tempBmp = [];					//
	var targetBmp;						//
	//var targetAfterBmp;				//
	var tempLayer = [];					// 画像の読み込まれたレイヤ
	var tempAttribute = [];				// 画像の属性（画像名や反転など）
	var targetLayer;					// 表、裏へのアクセス
	var targetLayerBack;				// 表、裏へのアクセス
	var absolute = 15000;				// レイヤーの絶対位置
	var drawObj = [];					// 描画用オブジェクトの配列
	var objStore = [];					// 描画オブジェクト記録用
	var ccStore = [];
	var myStore = %[];					// 自身の記録用
	var alive = false;					// 動作中かのフラグ
	var stick = 0;						// 開始時間
	var btick = 0;						// 前回の時間
	var intime = 0;						// フェードイン時間
	var outtime = 0;					// フェードアウト時間
	var time = -1;						// 全体時間
	var deleteAfterTransFlag = false;	// トランジション後に消去フラグ
	var showAfterTransFlag = false;		// トランジション後に全部表示フラグ
	var SaveResults = [];				// 規則系のランダム生成時に使用
	var FullLinkage = false;			// 同期させるか否か
	var FirstDraw = false;				// 初期描画か否か

	var CalculationController = [];		// 特殊演算系の関数
	
	var targetMoveAfterBlur = false;
	var targetMoveAfterBlurEx = false;
	var targetLeftGap = 0;				//
	var targetTopGap = 0;				//
	var targetPileBase;					//
	var targetPileLayer = [];			//
	var targetAfterBmp = [];			//
	var targetAfterSave = false;		//
	var targetAfterFirst = false;		//
	var targetAfterTarget = [];			//
	var vps;							// 縦の画面表示サイズ【verticalPileSplit】
	var sps;							// 横の画面表示サイズ【sidePileSplit】
	var PileLayerFlipLR;				//
	var PileLayerFlipUD;				//
	var useTargetLayer = 1;				//使用するターゲットレイヤ
	
	var afterAdjustGamma = false;
	var afterRGamma = 1.0;
	var afterGGamma = 1.0;
	var afterBGamma = 1.0;
	var afterRFloor = 0;
	var afterGFloor = 0;
	var afterBFloor = 0;
	var afterRCeil = 255;
	var afterGCeil = 255;
	var afterBCeil = 255;
	
	function MultiEffectPlugin(win,no)
	{
		window = win;
		obj_no = no;												//自身のオブジェクト番号を格納
		
		super.KAGPlugin(...);
		targetBmp = new Bitmap(kag.scWidth, kag.scHeight);

		// レイヤー生成
		targetLayer = new Layer(kag, kag.fore.base);
		targetLayerBack = new Layer(kag, kag.back.base);
		targetPileBase = new Layer(kag, kag.fore.base);
		
		// レイヤー設定
		layerSetting(targetLayer);
		layerSetting(targetLayerBack);
		layerSetting(targetPileBase);
	}

	function finalize()
	{
		stop();
		tempLayerClear();
		invalidate targetBmp;
		invalidate targetLayer;
		invalidate targetLayerBack;
		invalidate targetPileBase;
		targetPileLayerClear();
		targetAfterBmpClear();
		super.finalize(...);
	}

	function DeleteObject(){
		deleteAfterTransFlag = true;
		targetLayerBack.visible = false;
	}
	
	function DeleteObjectNow(){
		stop();
		clearLayer();
	}
	
	// レイヤー設定用関数
	function layerSetting(target)
	{
		with(target){
			.setImageSize(kag.scWidth,kag.scHeight);
			.setSizeToImageSize();
			.type = ltAlpha;
			.face = dfAlpha;
			.hitType = htMask;
			.hitThreshold = 256;
			.visible = false;
		}
	}

	
	function CheckNewStorage(elm,i){
		if(elm.img !== tempAttribute[i].img) return true;
		if(elm.fliplr !== tempAttribute[i].flipud) return true;
		if(elm.flipud !== tempAttribute[i].flipud) return true;
		if(elm.movecolor !== tempAttribute[i].movecolor) return true;
		if(elm.grayscale !== tempAttribute[i].grayscale) return true;
		if(elm.sepia !== tempAttribute[i].sepia) return true;
		if(elm.correct !== tempAttribute[i].correct) return true;
		if(elm.turn !== tempAttribute[i].turn) return true;
		if(elm.bbx !== tempAttribute[i].bbx) return true;
		if(elm.bby !== tempAttribute[i].bby) return true;
		if(elm.rgamma !== tempAttribute[i].rgamma) return true;
		if(elm.ggamma !== tempAttribute[i].ggamma) return true;
		if(elm.bgamma !== tempAttribute[i].bgamma) return true;
		if(elm.rfloor !== tempAttribute[i].rfloor) return true;
		if(elm.gfloor !== tempAttribute[i].gfloor) return true;
		if(elm.bfloor !== tempAttribute[i].bfloor) return true;
		if(elm.rceil !== tempAttribute[i].rceil) return true;
		if(elm.gceil !== tempAttribute[i].gceil) return true;
		if(elm.bceil !== tempAttribute[i].bceil) return true;
		if(elm.light !== tempAttribute[i].light) return true;
		if(elm.brightness !== tempAttribute[i].brightness) return true;
		if(elm.contrast !== tempAttribute[i].contrast) return true;
		if(elm.colorize !== tempAttribute[i].colorize) return true;
		if(elm.hue !== tempAttribute[i].hue) return true;
		if(elm.saturation !== tempAttribute[i].saturation) return true;
		if(elm.blend !== tempAttribute[i].blend) return true;
		if(elm.modulate !== tempAttribute[i].modulate) return true;
		if(elm.luminance !== tempAttribute[i].luminance) return true;
		if(elm.translucent !== tempAttribute[i].translucent) return true;
		
		return false;
	}
	
	function AddTempLayer(elm){
		//同一のファイル構成を確認
		var max = tempLayer.count;
		for(var i = 0; i < tempLayer.count; i++) if(!CheckNewStorage(elm,i)) return i;
		tempLayer.add(new AutoPiledLayer(kag, kag.fore.base));
		var attribute = %[];
		(Dictionary.assign incontextof attribute)(elm);
		tempAttribute.add(attribute);
		tempBmp.add(new Bitmap());
		tempLayer[max].loadImages(elm.img, clNone, elm.window == "true" , elm);
		return max;
	}
	
	// 規則系のデータ保存用
	function addSaveResults(result){
		SaveResults.add(result);
	}
	
	// エフェクトオブジェクトの追加
	function addDrawObj(elm)
	{
		var _i = objStore.add(%[]);
		(Dictionary.assign incontextof objStore[_i])(elm);
		var index = drawObj.add(new MultiEffectObject(this, drawObj.count));
		drawObj[index].startEffect(elm);
	}
	
	function AddCalculationController(elm)
	{
		var ap = new ArithmeticProcessing(this,elm);
		var _i = ccStore.add(%[]);
		(Dictionary.assign incontextof ccStore[_i])(elm);
		CalculationController.add(ap);
		return CalculationController.count - 1;
	}
	
	// エフェクト類の動作
	function start(elm)
	{
		if(elm.spmode=="1") for(var i=0; i<50; i++)addDrawObj(%[storage:"gr_light", spmode:"1", rev:elm.rev]);
		if(drawObj.count == 0) return;
		
		// 属性保存
		(Dictionary.clear incontextof myStore)();			//AddCalculationControllerのデータを初期化
		(Dictionary.assign incontextof myStore)(elm);		//AddCalculationControllerのデータを保存する処理が必要

		// 奥行き設定
		if(elm.absolute !== void){
			absolute = +elm.absolute;
			targetLayer.absolute = targetLayerBack.absolute = absolute;
		}
		
		//++そもそものターゲットレイヤの動作を決める+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		PileLayerFlipLR = false;
		PileLayerFlipUD = false;
		targetMoveAfterBlur = false;
		targetMoveAfterBlurEx = false;
		targetPileLayerClear();
		if(elm.kaleidoscope !== void){
			var tmp = [].split("(), ", elm.kaleidoscope, , true);
			targetKaleidoScope(+tmp[0],+tmp[1]);
			vps = +tmp[1];
			sps = +tmp[0];
		}else if(elm.pile !== void){
			var num = +elm.pile;
			targetMoveAfterBlur = true;
			targetPile(num);
			vps = num;
			sps = 1;
			if(elm.sppile !== void) targetMoveAfterBlurEx = true;
		}else{
			targetKaleidoScope(1,1);
			vps = 1;
			sps = 1;
		}

		if(elm.kaleidoscopeflip !== void){
			var tmp = [].split("(), ", elm.kaleidoscopeflip, , true);
			if(tmp[0] == "true") PileLayerFlipLR = true;
			if(tmp[1] == "true") PileLayerFlipUD = true;
		}
		
		//--そもそものターゲットレイヤの動作を決める-------------------------------------------------------------

		targetAfterBmpClear();
		targetAfterSave = false;
		targetAfterFirst = false;
		if(elm.after !== void){
			var an = +elm.after;
			var tpw = targetPileLayer[0].width;
			var tph = targetPileLayer[0].height;
			for(var i = 0; i < an; i++) targetAfterBmp.add(new Bitmap(tpw,tph));
			targetAfterFirst = true;
			targetAfterSave = true;
			if(targetMoveAfterBlur){
				if(an <= 1) targetMoveAfterBlur = false;
			}
		}

		targetAfterTarget.clear();
		
		if(elm.placement !== void){
			if(elm.placement.substring(0,1) == "M") MovePlacement(elm);
			else if(elm.placement.substring(0,1) == "R") RandomPlacement(elm);
		}else{
			var tnum = 0;
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < targetPileLayer.count; i++){
				if(tnum >= tmax) tnum = 0;
				targetAfterTarget.add(tnum);
				tnum++;
			}
		}

		afterAdjustGamma = false;
		if(elm.aag !== void){
			//dm("set");
			afterAdjustGamma = true;
			var tmp = [].split("(), ", elm.aag, , true);
			afterRGamma = +tmp[0];
			afterGGamma = +tmp[1];
			afterBGamma = +tmp[2];
			afterRFloor = +tmp[3];
			afterGFloor = +tmp[4];
			afterBFloor = +tmp[5];
			afterRCeil = +tmp[6];
			afterGCeil = +tmp[7];
			afterBCeil = +tmp[8];
		}

		/*
		if(elm.tcode !== void){
			dm("FULL:"+targetAfterTarget.count);
			for(var i = 0; i < targetAfterTarget.count; i++) dm("TA[" + i + "]:"+targetAfterTarget[i]);
		}
		*/
		
		if(elm.effectparent !== void){
			var tmp_ep = [].split("(), ", elm.effectparent, , true);
			var temp_add = +tmp_ep[0];
			//α画像の読み込み
			if(tmp_ep.count == 1){
				tmp_ep.add("eff");
			}
			if(tmp_ep[1] == "eff"){
				//最終targetLayerの親レイヤーの指定の画像の読み込み
				if(effect_object[temp_add].targetLayer !== void && temp_add < effect_object.count){
					targetLayer.parent = effect_object[temp_add].targetLayer;
					targetLayerBack.parent = effect_object[temp_add].targetLayerBack;
					//dm("TL_A:"+targetLayer.parent);
					//dm("ETLP_A:"+effect_object[temp_add].targetLayer.parent);
				}
			}else if(tmp_ep[1] == "layer"){
				if(0 <= temp_add && temp_add < kag.fore.layers.count){
					targetLayer.parent = kag.fore.layers[temp_add];
					targetLayerBack.parent = kag.back.layers[temp_add];
				}
			}
		}
		
		if(elm.effectparent === void){
			targetLayer.type = targetLayerBack.type = ltAlpha;
			// 表示タイプ設定
			if(elm.mode != void){
				var _type = imageTagLayerType[elm.mode].type;		// この辞書配列はtjsがはじめから持ってるらしい
				targetLayer.type = targetLayerBack.type = _type;
			}
		}else{
			targetLayer.type = targetLayerBack.type = ltPsNormal;
		}
		
		if(elm.page === void){
			targetLayer.visible = targetLayerBack.visible = true;
		}else if(elm.page === "fore"){
			targetLayer.visible = true;
			targetLayerBack.visible = false;
		}else if(elm.page === "back"){
			targetLayer.visible = false;
			targetLayerBack.visible = true;
		}
		
		showAfterTransFlag = false;
		if(elm.show === "true") showAfterTransFlag = true;

		deleteAfterTransFlag = false;
		if(elm.delete === "true") deleteAfterTransFlag = true;

		if(elm.sub !== void){
			targetLayer.visible = false;
			targetLayerBack.visible = false;
			showAfterTransFlag = false;
			deleteAfterTransFlag = false;
		}
		
		// 時間を設定
		if(elm.time !== void) time = +elm.time;
		else time = -1;
		
		// フェードイン・アウトを設定
		if(elm.intime != 0){
			intime = +elm.intime;
			targetLayer.opacity = targetLayerBack.opacity = 0;
		}else{
			intime = 0;
			targetLayer.opacity = targetLayerBack.opacity = 255;
		}
		if(elm.outtime != 0)outtime = +elm.outtime;
		else outtime = 0;

		FirstDraw = false;
		FullLinkage = false;
		if(elm.flink === "true"){ FullLinkage = true;}
		
		stick = btick = System.getTickCount();

		for(var i = 0; i < drawObj.count; i++){
			drawObj[i].SetStartTick(stick);
		}

		if(targetAfterFirst){
			var draw_order = [];
			var drawObj_absolute = [];
			for(var i = 0;i < drawObj.count;i++){
				draw_order[i] = i;
				drawObj_absolute[i] = drawObj[i].absolute.GetNowParams(0);
			}

			for(var i = 0;i < drawObj_absolute.count-1;i++){
				for(var j = i+1;j < drawObj_absolute.count;j++){
					if(drawObj_absolute[i] > drawObj_absolute[j]){
						var temp;
						temp = drawObj_absolute[j];
						drawObj_absolute[j] = drawObj_absolute[i];
						drawObj_absolute[i] = temp;

						temp = draw_order[j];
						draw_order[j] = draw_order[i];
						draw_order[i] = temp;
					}
				}
			}
			//tempBitMapを更新
			for(var i = 0; i < tempLayer.count; i++){
				tempLayer[i].copyToBitmapFromMainImage(tempBmp[i]);
				tempBmp[i].independ(true);
			}
			ImageFunction.fillRect(targetBmp,0x0);
			for(var i=0; i< drawObj.count; i++){
				drawObj[draw_order[i]].continuousHandler(stick);
			}
			draw_order.clear();
			drawObj_absolute.clear();
			
			if(targetAfterSave){
				for(var i = 0; i < targetAfterBmp.count; i++) targetAfterBmp[i].copyFrom(targetBmp);
				targetAfterFirst = false;
			}
		}
		
		// 必ず一つしか登録されないように念のために一度削除
		System.removeContinuousHandler(continuousHandler);
		System.addContinuousHandler(continuousHandler);

		alive = true;
	}

	// ループ本体
	function continuousHandler(tick)
	{
		// あまりに早く来る場合は拒否
		if(tick-btick < 15)return;
		btick = tick;
		
		var ntick = tick - stick;
		if(intime != 0){
			if(ntick < intime) targetLayer.opacity = targetLayerBack.opacity = (int)((ntick/intime)*255);
			else if(foreLayer.opacity != 255) targetLayer.opacity = targetLayerBack.opacity = 255;
		}
		// 終了時間が決まっている場合の処理
		if(time != -1){
			if(ntick > (time-outtime)) targetLayer.opacity = targetLayerBack.opacity = (int)((((time-ntick)/outtime)*255));
			if(ntick >= time){
				kag.trigger('meff');
				return stop();
			}
		}
		
		//描画更新
		var draw_order = [];
		var drawObj_absolute = [];
		for(var i = 0;i < drawObj.count;i++){
			draw_order[i] = i;
			drawObj_absolute[i] = drawObj[i].absolute.GetNowParams(tick);
		}

		for(var i = 0;i < drawObj_absolute.count-1;i++){
			for(var j = i+1;j < drawObj_absolute.count;j++){
				if(drawObj_absolute[i] > drawObj_absolute[j]){
					var temp;
					temp = drawObj_absolute[j];
					drawObj_absolute[j] = drawObj_absolute[i];
					drawObj_absolute[i] = temp;

					temp = draw_order[j];
					draw_order[j] = draw_order[i];
					draw_order[i] = temp;
				}
			}
		}

		if(!FirstDraw){
			FirstDraw = true;
			if(FullLinkage){
				var stime = tick;
				/*完全同期化*/
				for(var i=0; i< drawObj.count; i++){
					drawObj[draw_order[i]].Restart(stime);
				}
			}
		}

		//tempBitMapを更新
		for(var i = 0; i < tempLayer.count; i++){
			tempLayer[i].copyToBitmapFromMainImage(tempBmp[i]);
			tempBmp[i].independ(true);
		}
		
		ImageFunction.fillRect(targetBmp,0x0);
		for(var i=0; i< drawObj.count; i++){
			drawObj[draw_order[i]].continuousHandler(tick);
		}
		
		if(targetAfterSave){
			targetAfterBmp.unshift(targetAfterBmp[targetAfterBmp.count - 1]);
			targetAfterBmp.pop();
			targetAfterBmp[0].copyFrom(targetBmp);
			
			if(targetMoveAfterBlur){
				if(afterAdjustGamma) ImageFunction.adjustGamma(targetAfterBmp[1], afterRGamma, afterRFloor, afterRCeil, afterGGamma, afterGFloor, afterGCeil, afterBGamma, afterBFloor, afterBCeil);
				if(targetMoveAfterBlurEx){
					for(var i = 1; i < targetAfterBmp.count; i++){
						ImageFunction.doBoxBlur(targetAfterBmp[i], 3, 3);
					}
				}else ImageFunction.doBoxBlur(targetAfterBmp[1], 3, 3);
			}
			
			for(var i = 0; i < targetPileLayer.count;i++){
				targetPileLayer[i].copyFromBitmapToMainImage(targetAfterBmp[targetAfterTarget[i]]);
				targetPileLayer[i].setSizeToImageSize();
			}
			
		}else{
			for(var i = 0; i < targetPileLayer.count;i++){
				targetPileLayer[i].copyFromBitmapToMainImage(targetBmp);
				targetPileLayer[i].setSizeToImageSize();
			}
		}

		if(PileLayerFlipLR || PileLayerFlipUD){
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var num = i * sps + j;
					if(PileLayerFlipLR){
						if(j % 2 != 0) targetPileLayer[num].flipLR();
					}
					if(PileLayerFlipUD){
						if(i % 2 != 0) targetPileLayer[num].flipUD();
					}
				}
			}
		}
		
		targetPileBase.fillRect(0,0,targetPileBase.width,targetPileBase.height,0x0);
		targetPileBase.piledCopy(0,0,targetPileBase,0,0,targetPileBase.width,targetPileBase.height);
		for(var i=0; i< drawObj.count; i++) drawObj[draw_order[i]].afterFunc();
		targetLayer.assignImages(targetPileBase);
		targetLayerBack.assignImages(targetPileBase);
		//targetLayer.copyFromBitmapToMainImage(targetBmp);			// 描画面に表示
		//targetLayerBack.copyFromBitmapToMainImage(targetBmp);		// 描画面に表示
		draw_order.clear();
		drawObj_absolute.clear();
	}

	function drawObjClear(){
		for(var i=drawObj.count-1; i>0; i--) invalidate drawObj[i];
		drawObj.clear();
	}
	
	function tempLayerClear(){
		for(var i=0; i< tempLayer.count; i++) invalidate tempLayer[i];
		tempLayer.clear();

		for(var i=0; i< tempBmp.count; i++) invalidate tempBmp[i];
		tempBmp.clear();
		
		for(var i=0; i< tempAttribute.count; i++) (Dictionary.clear incontextof tempAttribute[i])();
		tempAttribute.clear();
	}

	function clearLayer()
	{
		alive = false;
		stop();

		targetLayer.visible = false;
		targetLayer.loadImages("ImgClear");
		targetLayer.setSizeToImageSize();
		targetLayer.visible=false;
		targetLayer.type = ltAlpha;
		targetLayerBack.visible = false;
		targetLayerBack.loadImages("ImgClear");
		targetLayerBack.setSizeToImageSize();
		targetLayerBack.visible=false;
		targetLayerBack.type = ltAlpha;
		
		tempLayerClear();
	}

	function targetKaleidoScope(hnum,vnum){
		/**/
		var max = vnum * hnum;
		var osw = kag.scWidth \ hnum;
		var osh = kag.scHeight \ vnum;
		var lg = 0;
		var tg = 0;
		
		if(osw * hnum < kag.scWidth){
			osw++;
			lg = (osw * hnum - kag.scWidth) \ 2;
		}
		if(osh * vnum < kag.scHeight){
			osh++;
			tg = (osh * vnum - kag.scHeight) \ 2;
		}

		//dm("lg" + lg);
		//dm("tg" + tg);
		
		for(var i = 0; i < vnum; i++){
			for(var j = 0; j < hnum; j++){
				var num = i * hnum + j;
				targetPileLayer.add(new Layer(kag, targetPileBase));
				targetPileLayer[num].setImageSize(osw,osh);
				targetPileLayer[num].setSizeToImageSize();
				targetPileLayer[num].visible = true;
				targetPileLayer[num].setPos(osw * j + lg, osh * i + tg);
				//dm( num + ":(" + (osw * j + lg) + "," + (osh * i + tg) + ")");
			}
		}
		
		//サイズの強制
		targetLeftGap = (osw - kag.scWidth) \ 2;
		targetTopGap = (osh - kag.scHeight) \ 2;
		targetBmp.setSize(osw,osh);
	}

	function targetPile(num){
		var op = 255 \ num;
		//dm("OP:"+op);
		for(var i = 0; i < num; i++){
			targetPileLayer.add(new Layer(kag, targetPileBase));
			targetPileLayer[i].setImageSize(kag.scWidth,kag.scHeight);
			targetPileLayer[i].setSizeToImageSize();
			targetPileLayer[i].visible = true;
			targetPileLayer[i].setPos(0, 0);
			targetPileLayer[i].absolute = absolute - (num + 1);
			targetPileLayer[i].opacity = 255 - (op * i);
			//dm("targetPileLayer["+i+"].opacity:" + targetPileLayer[i].opacity);
		}
		
		//サイズの強制
		targetLeftGap = 0;
		targetTopGap = 0;
		targetBmp.setSize(kag.scWidth,kag.scHeight);
	}
	
	function targetPileLayerClear(){
		for(var i=0; i< targetPileLayer.count; i++) invalidate targetPileLayer[i];
		targetPileLayer.clear();
	}

	function targetAfterBmpClear()
	{
		for(var i=0; i< targetAfterBmp.count; i++) invalidate targetAfterBmp[i];
		targetAfterBmp.clear();
	}
	
	// 完全停止
	function stop()
	{
		alive = false;
		
		System.removeContinuousHandler(continuousHandler);
		SaveResults.clear();
		targetLayer.visible = targetLayerBack.visible = false;
		drawObjClear();
		tempLayerClear();
		// 記録破棄
		for(var i = 0; i < objStore.count; i++) (Dictionary.clear incontextof objStore[i])();
		objStore.clear();

		for(var i = 0; i < ccStore.count; i++) (Dictionary.clear incontextof ccStore[i])();
		ccStore.clear();
		
		
		ccStore.clear();
		(Dictionary.clear incontextof myStore)();

		for(var i = 0; i < CalculationController.count; i++) invalidate CalculationController[i];
		CalculationController.clear();
	}
	
	// 表示したまま完全停止
	function stop2()
	{
		alive = false;
		System.removeContinuousHandler(continuousHandler);
		drawObjClear();
		tempLayerClear();
		// 記録破棄
		for(var i = 0; i < objStore.count; i++) (Dictionary.clear incontextof objStore[i])();
		objStore.clear();
		
		for(var i = 0; i < ccStore.count; i++) (Dictionary.clear incontextof ccStore[i])();
		ccStore.clear();
		
		(Dictionary.clear incontextof myStore)();

		for(var i = 0; i < CalculationController.count; i++) invalidate CalculationController[i];
		CalculationController.clear();
	}

	function ObjFinish(elm)
	{
		/*確認しながら*/
		var obj = -1;
		if(elm.obj != void){
			if(drawObj[+elm.obj] != void){
				obj = +elm.obj;
				if(elm.stoploop == "true") drawObj[obj].loop = false;
			}
		}

		if(obj != -1){
			drawObj[obj].delay = 0;
			drawObj[obj].lasttick=System.getTickCount();
			drawObj[obj].starttick=drawObj[obj].lasttick - drawObj[obj].totalTime;
			drawObj[obj].alive = false;
			drawObj[obj].moving = false;
		}
	}

	function ObjAllFinish(elm){
		
		if(elm.stoploop == "true"){
			for(var i=0;i < drawObj.count;i++){
				drawObj[i].loop = false;
			}
		}
		
		for(var i=0; i<drawObj.count; i++){
			drawObj[i].delay = 0;
			drawObj[i].lasttick=System.getTickCount();
			drawObj[i].starttick=drawObj[i].lasttick - drawObj[i].totalTime;
		}
	}

	function MovePlacement(elm){
		if(elm.placement === "M73"){
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var tnum = (i + j) % tmax;
					targetAfterTarget.add(tnum);
				}
			}
		}else if(elm.placement === "M46"){
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var tnum = (i + j) % tmax;
					targetAfterTarget.add(tnum);
				}
			}
		}else if(elm.placement === "M19"){
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var tnum = (vps - (i + 1) + j) % tmax;
					targetAfterTarget.add(tnum);
				}
			}
		}else if(elm.placement === "M28"){
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var tnum = (vps - (i + 1)) % tmax;
					targetAfterTarget.add(tnum);
				}
			}
		}else if(elm.placement === "M37"){
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var tnum = (vps - (i + 1) + sps - (j + 1)) % tmax;
					targetAfterTarget.add(tnum);
				}
			}
		}else if(elm.placement === "M64"){
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var tnum = (sps - (j + 1)) % tmax;
					targetAfterTarget.add(tnum);
				}
			}
		}else if(elm.placement === "M91"){
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var tnum = (i + sps - (j + 1)) % tmax;
					targetAfterTarget.add(tnum);
				}
			}
		}else if(elm.placement === "M82"){
			var tmax = targetAfterBmp.count;
			for(var i = 0; i < vps; i++){
				for(var j = 0; j < sps; j++){
					var tnum = i % tmax;
					targetAfterTarget.add(tnum);
				}
			}
		}
	}

	function RandomPlacement(elm){
		if(elm.placement === "R"){
			var tmax = targetAfterBmp.count - 1;
			for(var i = 0; i < targetPileLayer.count; i++){
				var tnum = intrandom(0,tmax);
				targetAfterTarget.add(tnum);
			}
		}else if(elm.placement === "RX"){
			var ta = [];
			for(var i = 0; i < targetPileLayer.count; i++) ta.add(i);
			for(var i = 0; i < targetPileLayer.count; i++){
				var tnum = intrandom(0,ta.count - 1);
				targetAfterTarget.add(ta[tnum]);
				ta.erase(tnum);
			}
		}
	}
	
	// 表裏を常に正しく指定するように参照を入れ替え
	function onExchangeForeBack()
	{
		var tmp = targetLayerBack;
		targetLayerBack = targetLayer;
		targetLayer = tmp;
		
		if(showAfterTransFlag){
			targetLayer.visible = targetLayerBack.visible = true;
			showAfterTransFlag = false;
		}
		if(deleteAfterTransFlag){
			stop();
			deleteAfterTransFlag = false;
		}
	}

	// セーブ
	function onStore(f, elm)
	{
		var dicName = "meff" + obj_no;

		// 無かった場合の対処
		if(f[dicName + "_cc"] === void) f[dicName + "_cc"] = [];
		if(f[dicName + "_obj"] === void) f[dicName + "_obj"] = [];
		if(f[dicName + "_my"] === void) f[dicName + "_my"] = %[];

		if(alive){
			//この中にCalculationControllerの内容が必要になる
			var dic = f[dicName + "_cc"];
			dic.assignStruct(ccStore);

			dic = f[dicName + "_obj"];
			dic.assignStruct(objStore);
			for(var i = 0; i < drawObj.count; i++){
				//動作分を付け加える
				drawObj[i].onStore(f,elm);
			}
			
			dic = f[dicName + "_my"];
			(Dictionary.clear incontextof dic)();
			(Dictionary.assign incontextof dic)(myStore);
		}else{
			f[dicName + "_cc"].clear();
			f[dicName + "_obj"].clear();
			(Dictionary.clear incontextof f[dicName + "_my"])();
		}
		f[dicName] = alive;
	}

	// ロード
	function onRestore(f, clear, elm)
	{
		stop(); // 動作を停止

		var dicName = "meff" + obj_no;
		
		if(f[dicName]){
			var dic = f[dicName + "_cc"];
			for(var i=0; i<dic.count; i++) AddCalculationController(dic[i]);	//
			dic = f[dicName + "_obj"];
			for(var i=0; i<dic.count; i++){
				if(f[dicName + "_" + i] === void) dic[i].time = 1;
				else if(f[dicName + "_" + i]) dic[i].time = 1;
				addDrawObj(dic[i]); 					//この中にCalculationControllerの内容が必要になる
				drawObj[i].onRestore(f, clear, elm);
			}

			//上を処理したうえで現在の進行度合いに変更する
			
			start(f[dicName + "_my"], false);
		}
	}

	//タイトルやゲーム終了時(ボイスあり)の際の画面の初期化用
	function onClearScreenChange(elm)
	{
		if(elm.now === "true") DeleteObjectNow();
		else DeleteObject();
	}
}


class MultiEffectObject
{
	var owner = void;	// 管理クラス
	var name;			// 管理用の名称
	var ap = void;
	var storageNum=0;	// 画像ナンバー
	var obj_no=0;		// このプラグインの管理番号
	var groupNum = 0;	//
	var groupMax = 0;	//
	//--------------------------------------------------
	var path;			// パス管理用
	var cx, cy;			// 回転中心
	var size;			// サイズを記録する配列
	var xsize;			// 横軸（縦回転）
	var ysize;			// 縦軸（横回転）
	var xspin;			// 横軸（縦回転）
	var yspin;			// 縦軸（横回転）
	var rad;			// 回転角
	var absolute;		// absolute
	//--------------------------------------------------

	var AlphaAdd;
	var alpha_add;
	
	//--------------------------------------------------
	//RandPathArrayAttribute
	var rpath = void;		//
	//RandSingleArrayAttribute
	var rcx = void;			// 回転中心
	var rcy = void;			// 回転中心
	var rsize = void;		// サイズを記録する配列
	var rxsize = void;		// 横軸（縦回転）
	var rysize = void;		// 縦軸（横回転）
	var rxspin = void;		// 横軸（縦回転）
	var ryspin = void;		// 縦軸（横回転）
	var rrad = void;		// 回転角
	var rabsolute = void;	// absolute

	var rtime = void;	//
	var rdelay = void;	// 
	var raccel = void;	//
	//---------------------------------------------------
	var spParams = %[];
	//---------------------------------------------------
	
	var accel;			// 加速度的な動きを行うか
	var spaccel;		// 特殊な加減速
	var moveFunc;		// 移動位置計算用関数
	var zoomFunc;		// 拡大処理用関数
	var pathtype;		// パスの方式
	var lu_corner;		// パスの方式・左上隅指定
	var time;			// ひとつのパスを通る時間
	var totalTime;		// 総合時間
	var nowTick = 0;
	var lasttick=0;		// 前回の描画時間
	var starttick;		// 描画開始時間
	var affintype;		// アフィン変換の方式
	var spline;
	var zx = [];		// スプラインワーク
	var zy = [];		// スプラインワーク
	var imageWidthHalf;	// 対象レイヤーの幅の半分
	var imageHeightHalf;// 対象レイヤーの高さの半分

	var moving = false;	// 動作中かどうか
	var alive = false;	// レイヤー類が生きてるかどうか
	
	// セーブ・ロード用パラメータ記録配列
	var storeDic = %[];
	var loop = false;		// ループするか
	var lcnt = 0;			// ループ回数
	var gl_l,gl_t;

	var delay = 0;				// 何ミリ秒遅れて開始されるかの値
	var delayVisible = false;	//delay時に描画をするか否か
	var delayFirst = false;
	var fadeCoefficient = 1;	//
	var fadeInTime = -1;	// フェードインさせる時間
	var fadeOutTime = -1;	// フェードアウトさせる時間

	var timeOutDraw = false;	// 時間が終了しても最終地点を描画し続けるか？

	var spmode = -1;
	var exmode = 0;


	var specialMoving = void;
	var specialMovingFirst = false;
	var specialMovingPhase = 0;
	var function_group = [];		//ランダムを配列形へ→記述を注意
	var function_target = [];		//ランダムを配列形へ→記述を注意

	
	var spmd_rev;
	var spmst;

	var inherit = false;		//前任者の位置を引き継ぐ(最終地点)
	var inherit_state;			//回転でデータ(配列タイプのものはここで追加してやる)

	var SaveValue = [];			//再生成が必要な値を保存
	
	var MoveColorFlag = false;

	/*offset処理*/
	var ol = 0;
	var ot = 0;
	var oo = 0;
	var offsetSpline;					//
	var offsetAccel;					//
	var offsetSpAccel;					//
	var offsetPath = [];				//
	var ozx = [];						//
	var ozy = [];						//
	var offsetTime;						//
	var offsetTotalTime;				//
	var offsetDelay;					//
	var offsetTick=0;					// 前回の描画時間
	var offsetLastTick=0;				// 前回の描画時間
	var offsetStartTick;				// 描画開始時間
	var offsetLoop;						// 連続再生
	var offsetLoopCount;				// 連続再生

	/*追従処理*/
	var follow = void;
	
	var judgment = false;//
	var judgmentRect;

	var afterMoveNum = -1;
	var afterMove = [];
	
	var issue = -1;
	
	function MultiEffectObject(owm, no)
	{
		owner = owm;
		obj_no = no;
		ArrayParamsInit();												//配列の実体化
		//初期更新
		inherit_state = new Dictionary();
	}

	//配列データのコンストラクタ
	function ArrayParamsInit(){
		size = new ParamsArray(1);						//初期値は、1
		xsize = new ParamsArray(1);						//初期値は、1
		ysize = new ParamsArray(1);						//初期値は、1
		cx = new ParamsArray(0.5);						//初期値は、0.5(この形式だと画像の中央)
		cy = new ParamsArray(0.5);						//初期値は、0.5(この形式だと画像の中央)
		rad = new ParamsArray(0);						//初期値は、0
		xspin = new ParamsArray(0);						//初期値は、0
		yspin = new ParamsArray(0);						//初期値は、0
		absolute = new ParamsArray(15000+obj_no);		//初期値は、15000+オブジェ番号
		alpha_add = new ParamsArray(0);					//初期値は、0
	}
	
	//配列データのデストラクタ
	function ArrayParamsFinalize(){
		invalidate size;									//
		invalidate xsize;									//
		invalidate ysize;									//
		invalidate cx;										//
		invalidate cy;										//
		invalidate rad;										//
		invalidate xspin;									//
		invalidate yspin;									//
		invalidate absolute;								//
		
		invalidate alpha_add;								//
		//invalidate judgmentRect if judgmentRect !== void;
	}
	
	//配列データの初期化
	function ArrayParamsClear(){
		size.clear();								//
		xsize.clear();								//
		ysize.clear();								//
		cx.clear();									//
		cy.clear();									//
		rad.clear();								//
		xspin.clear();								//
		yspin.clear();								//
		absolute.clear();							//
		alpha_add.clear();
		
		invalidate rpath if rpath !== void;
		invalidate rcx if rcx !== void;
		invalidate rcy if rcy !== void;
		invalidate rsize if rsize !== void;
		invalidate rxsize if rxsize !== void;
		invalidate rysize if rysize !== void;
		invalidate rxspin if rxspin !== void;
		invalidate ryspin if ryspin !== void;
		invalidate rrad if rrad !== void;
		invalidate rabsolute if rabsolute !== void;

		invalidate rtime if rtime !== void;
		invalidate rdelay if rdelay !== void;
		invalidate raccel if raccel !== void;
		
		rpath = void;		//
		rcx = void;			// 回転中心
		rcy = void;			// 回転中心
		rsize = void;		// サイズを記録する配列
		rxsize = void;		// 横軸（縦回転）
		rysize = void;		// 縦軸（横回転）
		rxspin = void;		// 横軸（縦回転）
		ryspin = void;		// 縦軸（横回転）
		rrad = void;		// 回転角
		rabsolute = void;	// absolute
		rtime = void;		// time
		rdelay = void;		// delay
		raccel = void;		// accel
	}

	function ResetRandomArray(){
		if(rpath !== void) rpath.ResetRandom();
		if(rcx !== void) rcx.ResetRandom();
		if(rcy !== void) rcy.ResetRandom();
		if(rsize !== void) rsize.ResetRandom();
		if(rxsize !== void) rxsize.ResetRandom();
		if(rysize !== void) rysize.ResetRandom();
		if(rxspin !== void) rxspin.ResetRandom();
		if(ryspin !== void) ryspin.ResetRandom();
		if(rrad !== void) rrad.ResetRandom();
		if(rabsolute !== void) rabsolute.ResetRandom();

		if(rtime !== void) this.time = rtime.ResetRandom();
		if(raccel !== void) this.accel = raccel.ResetRandom();
	}
	
	function ResetTotalTime(){
		// 時間設定
		if(this.time<=1)this.time = 1;
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;
		AllGettimeForState();
	}

	//pathは別口に必要が有るので変更
	function AllGettimeForState(){
		size.TimeForParams(totalTime);				// サイズ用の時間を計算
		xsize.TimeForParams(totalTime);				// サイズ用の時間を計算
		ysize.TimeForParams(totalTime);				// サイズ用の時間を計算
		rad.TimeForParams(totalTime);				// 角度用の時間を計算
		xspin.TimeForParams(totalTime);				// XSpin用の時間を計算
		yspin.TimeForParams(totalTime);				// YSpin用の時間を計算
		absolute.TimeForParams(totalTime);			// absolute用の時間を計算
		cx.TimeForParams(totalTime);				// alpha_x用の時間を計算
		cy.TimeForParams(totalTime);				// alpha_y用の時間を計算
		alpha_add.TimeForParams(totalTime);					//
	}
	
	function finalize()
	{
		// 一応止めて所持オブジェクト破棄
		stop();
		SaveValue.clear();
		ArrayParamsFinalize();
		(Dictionary.clear incontextof spParams)();
		for(var i = 0; i < afterMove.count; i++) (Dictionary.clear incontextof afterMove[i])();
		afterMove.clear();
	}

	function startEffect(elm)
	{
		// 辞書配列をセーブ・ロード用に退避
		(Dictionary.assign incontextof storeDic)(elm);
		
		groupNum = (elm.quantitynum !== void) ? +elm.quantitynum : 0;
		groupMax = (elm.quantity !== void) ? +elm.quantity : 1;

		if(elm.name !== void) name = elm.name;
		else name = "";
		
		follow = void;
		if(elm.ap !== void) follow = owner.CalculationController[elm.ap];
		
		//特殊動作
		if(elm.exmode !== void){
			elm = ExmodeSet(owner,elm,obj_no);
			exmode = true;
		}
		
		// 最終時間を過ぎた時に最終地点の描画を続けるかどうか
		if(elm.timeoutdraw == "true")timeOutDraw = true;
		else timeOutDraw = false;

		// ループするか？
		this.loop = elm.loop == "true" ? true : false;
		lcnt = 0;

		this.offsetLoop = elm.offsetloop == "true" ? true : false;							//ループフラグ
		this.offsetLoopCount = elm.offsetloopcount !== void ? +elm.offsetloopcount : -1;	//ループ回数
		
		//一応初期化と確認項目
		if(this.offsetLoopCount == 0){
			elm.offsettime = 0;											//【一度もループしない】なので動作の停止
			this.offsetLoopCount = false;								//ループフラグをオフ
		}else if(this.offsetLoopCount != -1) this.offsetLoopCount--;	//カウントダウン方式を取る
		
		// パスのタイプを設定
		this.pathtype = elm.pathtype == "true" ? true : false;
		// もういっちょ
		this.lu_corner = elm.lu_corner == "true" ? true : false;
		
		// 既存の動作を停止
		stop();

		if(elm.bbx !== void || elm.bby !== void) elm.bblur = true;

		if(elm.storage !== void){
			var _storage = [].split("(), ", elm.storage, , true);
			if(_storage.count > 1){
				var ts = groupNum % _storage.count;
				elm.img = "" + _storage[ts];
			}else elm.img = elm.storage;
		}
		//画像スロットの取得
		storageNum = owner.AddTempLayer(elm);//本体側に確認して格納
		
		// 謎の処理：奇数に補正。
		// 縦横の数値が奇数偶数混ざってると苦手なのかも？
		if(!(owner.tempLayer[storageNum].imageWidth%2)) owner.tempLayer[storageNum].imageWidth+=1;
		if(!(owner.tempLayer[storageNum].imageHeight%2)) owner.tempLayer[storageNum].imageHeight+=1;

		ArrayParamsClear();

		/*
		judgment = false;
		if(elm.Judgment !== "true"){
			judgment = true;
			judgmentRect = new Rect();
		}
		*/
		
		//---------------------------
		// 他パラメーター設定
		//---------------------------
		cx.ArrayForParams(elm.cx);											// 回転中心																												//回転中心【Ｘ軸】の配列化指定
		cy.ArrayForParams(elm.cy);											// 回転中心
		size.ArrayForParams(elm.size, elm.ss, elm.ds)	;					// サイズ変化を配列化
		xsize.ArrayForParams(elm.xsize);									// サイズ変化【横】を配列化
		ysize.ArrayForParams(elm.ysize);									// サイズ変化【縦】を配列化
		rad.ArrayForParams(elm.rad, elm.sr, elm.dr);						// 回転角度【Ｚ軸】の配列化
		for(var i = this.rad.params.count-1; i>=0; i--){
			this.rad.params[i] = +this.rad.params[i] * (Math.PI/180) * -1;	//角度は周期計算なので係数倍を360°=2πとする
		}
		xspin.ArrayForParams(elm.xspin);									// 縦回転であるxspinの配列のセット
		yspin.ArrayForParams(elm.yspin);									// 横回転であるyspinの配列のセット
		absolute.ArrayForParams(elm.absolute);								// 絶対位置であるabsoluteの配列のセット

		// よく使うからとりあえず計算済みのものを。
		imageWidthHalf = kag.scWidth / 2;
		imageHeightHalf = kag.scHeight / 2;
		
		// path の分解
		if(elm.path === void) path = [imageWidthHalf,imageHeightHalf,255,imageWidthHalf,imageHeightHalf,255];
		else{
			this.path = [].split("(), ", elm.path, , true);
			for(var i = this.path.count-1; i>=0; i--)this.path[i] = +this.path[i];
		}

		if(this.path.count < 4){
			// 1点しか指定されていない場合、2点目にも同じ数値を。
			this.path[3]=this.path[0];
			this.path[4]=this.path[1];
			this.path[5]=this.path[2];
		}
		
		offsetPath.clear();
		ozx.clear();
		ozy.clear();
		
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;

		//+++offsetの処理+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		//自力移動パスアニメの追加
		if(elm.offsetpath === void){
			offsetPath = [
				0,0,255,
				0,0,255
				];
		}else{
			this.offsetPath = [].split("(), ", elm.offsetpath, , true);
			// 文字として受け取っているものを数値に変える。
			for(var i = this.offsetPath.count-1; i>=0; i--)this.offsetPath[i] = +this.offsetPath[i];
		}

		if(this.offsetPath.count < 4){
			// 1点しか指定されていない場合、2点目にも同じ数値を。
			this.offsetPath[3]=this.offsetPath[0];
			this.offsetPath[4]=this.offsetPath[1];
			this.offsetPath[5]=this.offsetPath[2];
		}
		
		// フェード設定
		if(elm.fadeintime !== void && elm.fadeouttime !== void){
			fadeInTime = +elm.fadeintime;
			fadeOutTime = +elm.fadeouttime;
		}else if(elm.fadeintime !== void){
			fadeInTime = +elm.fadeintime;
		}else if(elm.fadeouttime !== void){
			fadeOutTime = +elm.fadeouttime;
		}

		offsetSpline = false;
		if(elm.offsetspline == "true"){
			if(this.offsetPath.count >= 9){
				offsetSpline = true;
				PreSpline( offsetPath, ozx, ozy);
			}else{
				si("offsetPathを3点以上指定してください!!");
			}
		}
		offsetAccel = (elm.offsetaccel !== void) ? +elm.offsetaccel : 0;
		offsetSpAccel = false;
		if(elm.offsetspaccel == "true"){
			this.offsetAccel = Math.abs(this.offsetAccel);
			this.offsetSpAccel = true;
		}else this.offsetSpAccel = false;
		
		this.offsetTime = elm.offsettime !== void ? +elm.offsettime : 1000;
		if(this.offsetTime<=1)this.offsetTime = 1;
		
		// 全体時間を計算
		offsetTotalTime = (this.offsetPath.count \ 3 - 1) * offsetTime;
		//+++offsetの処理+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

		AlphaAdd = false;
		if(elm.alpha_add !== void){
			AlphaAdd = true;												//アルファ増幅を行うフラグをオンへ
			alpha_add.ArrayForParams(elm.alpha_add);						//アルファ増幅用の配列の作成
			alpha_add.TimeForParams(totalTime);								//アルファ増幅用の時間基本値の取得
			//ClearAlphaAdd = (elm.clearalpha !== void) ? true : false;		//不透明0の物を処理しないフラグをセット
			//seeingLevel = (elm.slv !== void) ? +elm.slv : 0;				//アルファ許可域に指定
		}
		
		//+ディレイ設定+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		if(elm.delay !== void){
			offsetTick = 0;
			var _delay = [].split("(), ", elm.delay, , true);
			if(elm.wtdelay === "true") delay = +_delay[0] + _delay[1] * groupNum;
			else{
				if(_delay.count == 1) delay = +_delay[0];
				else delay = intrandom(+_delay[0], +_delay[1]);
			}
			//dm("delay:"+delay);
		}else{
			offsetTick = 0;
			delay = 0;
		}
		
		if(elm.delay_visible !== void && elm.delay_visible != false) delayVisible = true;
		else elm.delay_visible = false;
		
		if(elm.offsetdelay !== void) offsetDelay = +elm.offsetdelay;
		else offsetDelay = 0;
		//-ディレイ設定------------------------------------------------------------------------
		
		// 時間設定
		this.time = elm.time !== void ? +elm.time : 1000;
		if(this.time<=1)this.time = 1;

		// 加速度設定
		this.accel = elm.accel !== void ? elm.accel : 0;

		if(elm.func !== void){
			set_function_group(elm);
			if(this.time<=1){this.time = 1;}
		}else{
			ChangeRealNumber();
		}

		/**/
		if(elm.rand !== void){
			var rg = [].split("()", elm.rand, , true);
			for(var i = 0; i < rg.count; i++){
				var rd = [].split(",", rg[i], , true);
				switch(rd[0]){
					case "x":
						if(rpath === void) rpath = new RandPathArrayAttribute(this.path);
						rpath.AddTargetPathArray("x",+rd[1],+rd[2],+rd[3]);
						break;
					case "y":
						if(rpath === void) rpath = new RandPathArrayAttribute(this.path);
						rpath.AddTargetPathArray("y",+rd[1],+rd[2],+rd[3]);
						break;
					case "a":
						if(rpath === void) rpath = new RandPathArrayAttribute(this.path);
						rpath.AddTargetPathArray("a",+rd[1],+rd[2],+rd[3]);
						break;
					case "cx":
						if(rcx === void) rcx = new RandSingleArrayAttribute(this.cx);
						rcx.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "cy":
						if(rcy === void) rcy = new RandSingleArrayAttribute(this.cy);
						rcy.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "size":
						if(rsize === void) rsize = new RandSingleArrayAttribute(this.size);
						rsize.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "xsize":
						if(rxsize === void) rxsize = new RandSingleArrayAttribute(this.xsize);
						rxsize.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "ysize":
						if(rysize === void) rysize = new RandSingleArrayAttribute(this.ysize);
						rysize.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "xspin":
						if(rxspin === void) rxspin = new RandSingleArrayAttribute(this.xspin);
						rxspin.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "yspin":
						if(ryspin === void) ryspin = new RandSingleArrayAttribute(this.yspin);
						ryspin.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "rad":
						if(rrad === void) rrad = new RandSingleArrayAttribute(this.rad);
						rrad.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "absolute":
						if(rabsolute === void) rabsolute = new RandSingleArrayAttribute(this.absolute);
						rabsolute.AddTargetArray(+rd[1],+rd[2],+rd[3]);
						break;
					case "time":
						if(rtime === void) rtime = new RandSingleAttribute(this.time);
						rtime.AddSingle(+rd[1],+rd[2]);
						break;
					case "delay":
						if(rdelay === void) rdelay = new RandSingleAttribute(this.delay);
						rdelay.AddSingle(+rd[1],+rd[2]);
						break;
					case "accel":
						if(raccel === void) raccel = new RandSingleAttribute(this.accel);
						raccel.AddSingle(+rd[1],+rd[2]);
						break;
				}
			}
			ResetRandomArray();
			if(rdelay !== void) this.delay = rdelay.ResetRandom();
		}

		//sp
		spline = false;
		
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;
		
		AllGettimeForState();
		

		//前回最終地点をパスの頭に接続する
		if(elm.inherit !== void){
			//∇注意
			if(inherit_state.o !== void){
				this.path.unshift(+inherit_state.o);
				this.path.unshift(+inherit_state.y);
				this.path.unshift(+inherit_state.x);
				this.rad.params.unshift(+inherit_state.r);
				this.size.params.unshift(+inherit_state.s);
				this.xsize.params.unshift(+inherit_state.xsize);
				this.ysize.params.unshift(+inherit_state.ysize);
				this.xspin.params.unshift(+inherit_state.xspin);
				this.yspin.params.unshift(+inherit_state.yspin);
				this.absolute.params.unshift(+inherit_state.absolute);
				
				ResetTotalTime();
				inherit = true;
			}else{
				inherit = false;
			}
		}else{
			inherit = false;
		}
		
		// 特殊な加速を使うか？（減速→加速）
		if(elm.spaccel == "true"){
			this.accel = Math.abs(this.accel);
			this.spaccel = true;
		}else this.spaccel = false;

		affintype = stFastLinear;

		// アフィン中に周りをクリアするかどうか
		this.clear = elm.clear == 'true' ? true : false;

		// モーションブラーするかどうか
		this.mbler = elm.mbler == 'true' ? true : false;

		// ブレンドの濃度
		this.blend = elm.blend !== void ? (int)elm.blend : 40;

		// 移動位置計算関数の設定
		if(elm.spline == 'true' || spline){
			PreSpline( path, zx, zy);
			moveFunc = SplineMover;
		}else moveFunc = LinearMover;
		
		// ズーム用関数の設定
		if(elm.zoom === "add") zoomFunc = moveAt2;
		else zoomFunc = moveAt;
		
		// 時間が一秒未満だった場合即終了
		if(this.time<=1){
			finish();
			alive = true;
			moving = false;
			return;
		}

		// 初期位置に表示
		if(delayVisible){
			moveFunc(0,0);
		}

		// 開始
		lasttick = starttick = System.getTickCount();
		offsetLastTick = offsetStartTick = lasttick;
		
		//System.addContinuousHandler(continuousHandler);
		moving = true;
		alive = true;
	}

	function SetStartTick(tick){
		lasttick = starttick = tick;
		offsetLastTick = offsetStartTick = lasttick;
	}
	
	//
	function moveAt( m00, m01, m10, m11, mtx, mty, opa )
	{
		ImageFunction.operateAffine(owner.targetBmp,owner.tempBmp[storageNum],m00,m01,m10,m11,mtx,mty,,,true,,,opa);
	}

	//
	function moveAt2( m00, m01, m10, m11, mtx, mty, opa )
	{
		/*
		var tmp = new Bitmap(kag.scWidth, kag.scHeight);
		ImageFunction.operateAffine(tmp,owner.tempBmp[storageNum],m00,m01,m10,m11,mtx,mty,,,true,,,opa,,);
		ImageFunction.operateRect(owner.targetBmp,0,0,tmp,,,omPsAdditive,,opa);
		invalidate tmp;
		*/
		
		
		//ImageFunction.operateAffine(owner.targetBmp,owner.tempBmp[storageNum],m00,m01,m10,m11,mtx,mty,,,true,omAddAlpha,dfOpaque,opa);
		//ImageFunction.operateAffine(owner.targetBmp,owner.tempBmp[storageNum],m00,m01,m10,m11,mtx,mty,,,true,omAddAlpha,dfAddAlpha,opa);
	}

	//要素を引き出す物
	function getNowState(tick,state,tf_state)
	{
		//サイズの作りに合わせる
		var StateIndex = (int)(tick / tf_state);
		var StateRatio = tick % tf_state / tf_state;
		var n_s = (state[StateIndex+1] - state[StateIndex])*StateRatio + state[StateIndex];
		return n_s;
	}
	
	function gettimeForState(state){
		/*
		var sc_num = state.count - 1;
		if(sc_num == 0)sc_num=1
		*/
		
		var timeForState = totalTime / (state.count - 1);
		if(timeForState<=1)return 1;
		return timeForState;
	}
	
	// 配列の格納
	function set_array(e_array,a_def){
		var s_array;
		if(e_array === void)s_array = [a_def,a_def];
		else{
			s_array = [].split("(), ", e_array, , true);
			if(s_array.count == 1){
				s_array = [(s_array[s_array.count-1]),(s_array[s_array.count-1])];
			}
		}
		return s_array;
	}
	
	function function_split(line){
		if(line.charAt(0) == "(" && line.charAt(line.length-1) == ")"){
			line = line.substring(1,line.length-2);
		}

		var astr = [];
		var parenthesis_cnt = 0;
		var s_cnt = 0;
		for(var i=0;i<line.length;i++){
			if(line.charAt(i) == ","){
				if(parenthesis_cnt == 0){
					if(i-s_cnt != 0){
						astr.add(line.substring(s_cnt,i-s_cnt));
					}
					s_cnt = i+1;
				}
			}
			if(line.charAt(i) == "(")parenthesis_cnt++;
			if(line.charAt(i) == ")")parenthesis_cnt--;
		}
		//最後の格納
		astr.add(line.substring(s_cnt));
		return astr;
	}
	
	function set_function_group(elm){
		function_group.clear();
		function_target.clear();
		/*
		var temp_line = function_split(elm.func);
		
		for(var i=0;i<temp_line.count;i++){
			function_group.add(temp_line[i]);
			function_target.add([]);
		}
		
		//全ての配列関数を監視
		//function_targetにアドレスを確保
		//この実行動作が一番重い
		for(var i=0;i<temp_line.count;i++){
			if(time == "f"+i){function_target[i].add("time");}
			if(accel == "f"+i){function_target[i].add("accel");}
			if(delay == "f"+i){function_target[i].add("delay");}
			for(var j=0;j<path.count;j++)if(path[j] == "f"+i){function_target[i].add("path["+j+"]");}
			for(var j=0;j<absolute.count;j++)if(absolute[j] == "f"+i){function_target[i].add("absolute["+j+"]");}
			//for(var j=0;j<cx.count;j++)if(cx[j] == "f"+i){function_target[i].add("cx["+j+"]");}
			//for(var j=0;j<cy.count;j++)if(cy[j] == "f"+i){function_target[i].add("cy["+j+"]");}
			for(var j=0;j<size.count;j++)if(size[j] == "f"+i){function_target[i].add("size["+j+"]");}
			for(var j=0;j<xsize.count;j++)if(xsize[j] == "f"+i){function_target[i].add("xsize["+j+"]");}
			for(var j=0;j<ysize.count;j++)if(ysize[j] == "f"+i){function_target[i].add("ysize["+j+"]");}
			for(var j=0;j<xspin.count;j++)if(xspin[j] == "f"+i){function_target[i].add("xspin["+j+"]");}
			for(var j=0;j<yspin.count;j++)if(yspin[j] == "f"+i){function_target[i].add("yspin["+j+"]");}
			for(var j=0;j<rad.count;j++)if(rad[j] == "f"+i){function_target[i].add("rad["+j+"]");}
			if(fadeInTime == "f"+i){function_target[i].add("fadeInTime");}
			if(fadeOutTime == "f"+i){function_target[i].add("fadeOutTime");}
		}
		*/

		//set_FunctionForArray();
	}
	
	function set_FunctionForArray(){
		for(var i=0;i<function_group.count;i++){
			if(64 <= function_target[i].count)safe();
			for(var j=0;j<function_target[i].count;j++){
				/*全ての関数に挿入*/
				(function_target[i][j] + "=" + (function_group[i]!))!;
			}
		}
		ChangeRealNumber();
	}

	function ChangeRealNumber(){
		/*
		this.time = +this.time;
		this.accel = +this.accel;
		this.delay = +this.delay;
		for(var i=0;i<path.count;i++){this.path[i] = +this.path[i];}
		for(var i=0;i<absolute.params.count;i++){this.absolute.params[i] = +this.absolute.params[i];}
		for(var i=0;i<cx.params.count;i++){this.cx.params[i] = +this.cx.params[i];}
		for(var i=0;i<cy.params.count;i++){this.cy.params[i] = +this.cy.params[i];}
		for(var i=0;i<size.params.count;i++){this.size.params[i] = +this.size.params[i];}
		for(var i=0;i<xsize.params.count;i++){this.xsize.params[i] = +this.xsize.params[i];}
		for(var i=0;i<ysize.params.count;i++){this.ysize.params[i] = +this.ysize.params[i];}
		for(var i=0;i<xspin.params.count;i++){this.xspin.params[i] = +this.xspin.params[i];}
		for(var i=0;i<yspin.params.count;i++){this.yspin.params[i] = +this.yspin.params[i];}
		for(var i=0;i<rad.params.count;i++){this.rad.params[i] = +this.rad.params[i];}
		this.fadeInTime = +this.fadeInTime;
		this.fadeOutTime = +this.fadeOutTime;
		*/
	}
	
	function path_split(spath){
		var rspath = spath;
		var tbc;
		var ebc;
		
		for(var i = 0; i < rspath.count; i++){
			tbc = 0;
			ebc = 0;
			//()カウント
			for(var slc=0;slc < rspath[i].length; slc++){
				if(rspath[i].charAt(slc) == "("){tbc++;}
				if(rspath[i].charAt(slc) == ")"){ebc++;}
			}
			
			//()カウントが異なれば前後を削る
			if(tbc > ebc){rspath[i] = rspath[i].substring(1,rspath[i].length-1);
			}else if(tbc < ebc){rspath[i] = rspath[i].substring(0,rspath[i].length-1);}
			
			if(/@/g.test(rspath[i])){
				rspath[i] = /@/g.replace(rspath[i],",");
			}
		}
		/*
		tbc = "";
		for(var i = 0; i < rspath.count; i++){
			tbc += rspath[i];
			tbc += ",";
		}
		si(tbc);*/
		
		return rspath;
	}
	
	function LinearMover(tick,otick=0)
	{
		
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

		var ap = void;
		
		if(follow !== void){
			ap = follow.MovingFunction(this,tick);
			if(ap.x !== void) l += ap.x;
			if(ap.y !== void) t += ap.y;
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

		fadeCoefficient = 1;
		var rtick = totalTime - tick;
		if(tick < fadeInTime) fadeCoefficient = tick / fadeInTime;
		else if(rtick < fadeOutTime) fadeCoefficient = rtick / fadeOutTime;
		
		var _opacity = eo >= 256 ? so : int((eo-so)*ratio + so);

		//if(moving) dm("(" + l + "," + t + "," + _opacity + ")");
		
		if(offsetTick < offsetTotalTime){
			var offi = otick \ offsetTime * 3;
			var offr = otick % offsetTime / offsetTime;

			var op = offsetPath;
			var osx = op[offi];
			var osy = op[offi+1];
			var oso = op[offi+2];
			var oex = op[offi+3];
			var oey = op[offi+4];
			var oeo = op[offi+5];
				
			if(!offsetSpline){
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
			var op = offsetPath;
			ol = op[op.count-3];
			ot = op[op.count-2];
			oo = op[op.count-1] / 255;
		}
		
		l += ol;
		t += ot;
		_opacity *= oo * fadeCoefficient;
		//dm("_opacity:"+_opacity);
		
		if(_opacity <= 0){_opacity = 0;}
		if(_opacity >= 255){_opacity = 255;}
		
		//現在のポジションの不透明度
		inherit_state["o"] = _opacity;
		// 角度・拡大率計算

		var tiw = owner.tempLayer[storageNum].imageWidth;
		var tih = owner.tempLayer[storageNum].imageHeight;
		
		var r = rad.GetNowParams(tick);
		var s = size.GetNowParams(tick);
		var s_x = xsize.GetNowParams(tick);
		var s_y = ysize.GetNowParams(tick);
		var xsp = xspin.GetNowParams(tick);
		var ysp = yspin.GetNowParams(tick);
		var abs = absolute.GetNowParams(tick);
		
		var c_x = cx.GetNowParams(tick) * tiw;
		var c_y = cy.GetNowParams(tick) * tih;

		if(follow !== void){
			if(ap.r !== void) r += ap.r;
			if(ap.s !== void) s *= ap.y;
			if(ap.s_x !== void) s_x *= ap.s_x;
			if(ap.s_y !== void) s_y *= ap.s_y;
			if(ap.xsp !== void) xsp += ap.xsp;
			if(ap.ysp !== void) ysp += ap.ysp;
			if(ap.abs !== void) abs += ap.abs;
			(Dictionary.clear incontextof ap)();
		}
		
		
		if(lu_corner){
			l += (tiw/2)*s;
			t += (tih/2)*s;
		}else if(pathtype){
			// pathで指定するのは画面の中心に画像のどこのピクセルをを持ってくるか
			l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-c_x)*s;
			t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-c_y)*s;
		}else{
			// pathで指定するのは画像における中心を画面のどこに置くか
			l -= (tiw/2-c_x)*s;
			t -= (tih/2-c_y)*s;
		}

		//このタイミングだと思われる
		if(owner !== void){
			l += owner.targetLeftGap;
			t += owner.targetTopGap;
		}
		
		// メンバに現在座標をセット
		gl_l = l;
		gl_t = t;

		//現在のポジションのデータ
		inherit_state["x"] = gl_l;
		inherit_state["y"] = gl_t;
		
		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI/2.0) - r);
		

		// 縦・横回転のコード
		var xrate = 1, yrate = 1;
		xrate = Math.sin(Math.PI*(xsp * 2 + 0.5));
		yrate = Math.sin(Math.PI*(ysp * 2 + 0.5));
		
		/*
		//旧 縦・横回転のコード
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
		var mtx = (m00*-c_x) + (m10*-c_y) + l;
		var mty = (m01*-c_x) + (m11*-c_y) + t;
		
		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty, _opacity);
		
		//afterFunc(tick);
	}

	function SplineMover(tick,otick=0)
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

		var rel = l;
		var ret = t;
		
		var so = p[pindex+2];
		var eo = p[pindex+5];

		var ap = void;
		
		if(follow !== void){
			ap = follow.MovingFunction(this,tick);
			if(ap.x !== void) l += ap.x;
			if(ap.y !== void) t += ap.y;
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

		fadeCoefficient = 1;
		var rtick = totalTime - tick;
		if(tick < fadeInTime) fadeCoefficient = tick / fadeInTime;
		else if(rtick < fadeOutTime) fadeCoefficient = rtick / fadeOutTime;
		
		var _opacity = eo >= 256 ? so : int((eo-so)*d + so);
		/*
		if(aa != -1){
			_opacity = _opacity * aa / 255;
			if(true){
				if(_opacity > 255){
					_opacity = 255;
				}else if(_opacity < 0){
					_opacity = 0;
				}
			}
		}
		*/

		if(offsetTick < offsetTotalTime){
			var offi = otick \ offsetTime * 3;
			var offr = otick % offsetTime / offsetTime;

			var op = offsetPath;
			var osx = op[offi];
			var osy = op[offi+1];
			var oso = op[offi+2];
			var oex = op[offi+3];
			var oey = op[offi+4];
			var oeo = op[offi+5];
			
			if(!offsetSpline){
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
			var op = offsetPath;
			ol = op[op.count-3];
			ot = op[op.count-2];
			oo = op[op.count-1]  / 255;
		}

		l += ol;
		t += ot;
		_opacity *= oo * fadeCoefficient;
		//dm("_opacity:"+_opacity);
		_opacity = _opacity > 0 ? _opacity : 0;
		//targetLayer.opacity = targetLayerBack.opacity = _opacity;
		
		//現在のポジションの不透明度
		inherit_state["o"] = _opacity;

		var tiw = owner.tempLayer[storageNum].imageWidth;
		var tih = owner.tempLayer[storageNum].imageHeight;
		
		// 角度・拡大率計算
		var r = rad.GetNowParams(tick);
		var s = size.GetNowParams(tick);
		var s_x = xsize.GetNowParams(tick);
		var s_y = ysize.GetNowParams(tick);
		var xsp = xspin.GetNowParams(tick);
		var ysp = yspin.GetNowParams(tick);
		var abs = absolute.GetNowParams(tick);
		
		var c_x = cx.GetNowParams(tick) * tiw;
		var c_y = cy.GetNowParams(tick) * tih;

		if(follow !== void){
			if(ap.r !== void) r += ap.r;
			if(ap.s !== void) s *= ap.y;
			if(ap.s_x !== void) s_x *= ap.s_x;
			if(ap.s_y !== void) s_y *= ap.s_y;
			if(ap.xsp !== void) xsp += ap.xsp;
			if(ap.ysp !== void) ysp += ap.ysp;
			if(ap.abs !== void) abs += ap.abs;
			(Dictionary.clear incontextof ap)();
		}
		
		inherit_state["r"] = r;
		inherit_state["s"] = s;
		inherit_state["s_x"] = s_x;
		inherit_state["s_y"] = s_y;
		inherit_state["xspin"] = xsp;
		inherit_state["yspin"] = ysp;
		inherit_state["absolute"] = abs;

		inherit_state["cx"] = c_x;
		inherit_state["cy"] = c_y;
		
		if(pathtype == "true"){
			// pathで指定するのは画面の中心に画像のどこのピクセルをを持ってくるか
			l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-c_x)*s;
			t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-c_y)*s;
		}else{
			// pathで指定するのは画像における中心を画面のどこに置くか
			l -= (tiw/2-c_x)*s;
			t -= (tih/2-c_y)*s;
		}
		
		if(owner !== void){
			l += owner.targetLeftGap;
			t += owner.targetTopGap;
		}
		
		//現在のポジションのデータ
		inherit_state["x"] = gl_l;
		inherit_state["y"] = gl_t;
		
		// メンバに現在座標をセット
		gl_l = l;
		gl_t = t;

		var rc = Math.cos(r);
		var rs = Math.cos((Math.PI/2.0) - r);

		// 縦・横回転のコード
		var xrate = 1, yrate = 1;
		xrate = Math.sin(Math.PI*(xsp * 2 + 0.5));
		yrate = Math.sin(Math.PI*(ysp * 2 + 0.5));
		// 縦・横回転のコード
		/*
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
		var mtx = (m00*-c_x) + (m10*-c_y) + l;
		var mty = (m01*-c_x) + (m11*-c_y) + t;
		
		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty, _opacity);

		//afterFunc(tick);
	}

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
	
	function onTag()
	{
		if(alive && !moving)finish();
		//色調補正
	}

	function Restart(tick){
		lasttick = starttick = tick;
	}
	
	function continuousHandler(tick)
	{
		// コンソールにfpsを表示する
		//dm("■FPS：" + 1000/(tick-lasttick));
		if(delay != 0){
			var t = (tick-starttick);
			if(delay < t){
				var subTime = t - delay;
				lasttick = starttick = tick - subTime;
				delay = 0;
				//lasttick = starttick = System.getTickCount();
				moveFunc(0,0);
			}
			
			if(delayVisible == false){
				return;
			}else{
				moveFunc(0,0);
				return;
			}
			
			//return;
		}

		//再計算
		offsetTick = tick;
		offsetLastTick = offsetTick;
		offsetTick -= offsetStartTick;

		if(offsetTick > offsetDelay){
			offsetTick -= offsetDelay;
			if(offsetTick >= offsetTotalTime){
				if(offsetLoop && offsetLoopCount != 0){
					if(offsetLoopCount >= 0){ offsetLoopCount--;}
					offsetStartTick = offsetStartTick + offsetTotalTime + offsetDelay;
					offsetTick = offsetTick - offsetTotalTime - offsetDelay;
					//ここを修正
					
				}else{
					offsetTick = offsetTotalTime;
				}
			}
		}else{
			offsetTick = 0;
		}
		
		lasttick=tick;
		tick -= starttick;

		//
		
		// 時間通りか過ぎてるなら終わる
		if(tick >= totalTime)
		{
			if(loop){
				lcnt++;
				// もしループフラグが立ってるなら初期値に戻す
				//starttick = System.getTickCount();
				//moveFunc(totalTime);
				starttick = starttick + totalTime;
				tick = tick - totalTime;
				
				if(function_group.count != 0){
					//set_FunctionForArray();
				}

				if(follow !== void) follow.LoopingFunction(this);
				
				if(inherit == true){
					//前回の配列の第一配列を削除
					for(var i=0;i < 3;i++){path.shift();}
					rad.params.shift();
					size.params.shift();
					xsize.params.shift();
					ysize.params.shift();
					xspin.params.shift();
					yspin.params.shift();
					absolute.params.shift();
					if(moveFunc == SplineMover) PreSpline(path, zx, zy);
					inherit = false;
				}else if(moveFunc == SplineMover) PreSpline(path, zx, zy);
				
				ResetRandomArray();
				ResetTotalTime();
			}else if(AfterMoveStart()){
				var stick = starttick + totalTime;
				tick = tick - totalTime;
				startEffect(afterMove[afterMoveNum]);
				(Dictionary.clear incontextof owner.objStore[obj_no])();
				(Dictionary.assignStruct incontextof owner.objStore[obj_no])(afterMove[afterMoveNum]);
				(Dictionary.clear incontextof afterMove[afterMoveNum])();
				afterMove.shift();
				ResetRandomArray();
				ResetTotalTime();
				SetStartTick(stick);
			}else{
				nowTick = totalTime;
				finish();
				return;
			}
		}

		if(spaccel){
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
			tick = int ( (1.0 - tick) * totalTime);
		}else if(accel > 0){
			// 下弦 ( 最初は動きが遅く、徐々に早くなる )
			tick = tick / totalTime;
			tick = Math.pow(tick, accel);
			tick = int ( tick * totalTime );
		}
		// 移動
		nowTick = tick;
		moveFunc(tick,offsetTick);
	}

	function afterFunc()
	{
		//アルファ増加処理を追加
		if(AlphaAdd){
			var _a_add = (int)(alpha_add.GetNowParams(nowTick));
			//dm("_a_add:"+_a_add);
			owner.targetPileBase.AlphaAdd(_a_add,false);
		}
	}
	
	// 最終状態を表示
	function finish()
	{
		moveFunc(totalTime,offsetTotalTime);
		if(!timeOutDraw) stop();
	}

	// 停止
	function stop()
	{
		if(moving) moving = false;
	}
	
	function SearchDrawObj(sname){
		if(name == sname) return true;
		return false;
	}

	function AfterMoveSet(elm){
		var _i = afterMove.add(%[]);
		(Dictionary.assign incontextof afterMove[_i])(elm);
		if(afterMoveNum == -1) afterMoveNum = 0;
	}
	
	function AfterMoveStart(){
		if(afterMoveNum == -1) return false;
		if(afterMoveNum >= afterMove.count) return false;
		//ここで登録する
		return true;
	}
	
	//セーブ用
	function onStore(f,elm)
	{
		var fname = "meff" + owner.obj_no + "_" + obj_no;
		if(f[fname + "_after"] === void) f[fname + "_after"] = [];
		
		if(alive){
			f[fname + "_moving"] = moving;
			f[fname + "_after"].assignStruct(afterMove);
		}else{
			f[fname + "_moving"] = void;
			f[fname + "_after"].clear();
			f[fname] = void;
		}
	}

	//ロード用
	function onRestore(f, clear, elm)
	{
		for(var i = 0; i < afterMove.count; i++) (Dictionary.clear incontextof afterMove[i])();
		afterMove.clear();

		var fname = "meff" + owner.obj_no + "_" + obj_no;
		
		if(f[fname + "_moving"] !== void){
			if(f[fname + "_moving"]){
				var afterName = fname + "_after";
				if(f[afterName] !== void){
					afterMove.assignStruct(f[afterName]);
					afterMoveNum = 0;
				}
			}else{
				//強制的に止める必要がある
				//totalTime = 1;
				//stop();
			}
		}else if(moving){
			//強制的に止める必要がある
			stop();
		}
	}
}


var multi_eff_object = new Array();
{
	var multi_effect_max = 1;
	for( var i = 0 ; i < multi_effect_max; i++ )
	{
		kag.addPlugin(global.multi_eff_object[i] = new MultiEffectPlugin(kag,i));
	}
}

// すべてを一気に停止させるための関数
function meffAllStopFunction()
{
	for(var i=0; i<multi_eff_object.count; i++){
		if(multi_eff_object[i].moving) multi_eff_object[i].finish();
	}
}

// すべてを一気に削除予約の関数
function meffAllDeleteFunction()
{
	for(var i=0; i<multi_eff_object.count; i++){
		if(multi_eff_object[i].alive){
			multi_eff_object[i].deleteAfterTransFlag = true;
			multi_eff_object[i].targetLayerBack.visible = false;
		}
	}
}

// すべてを一気に削除の関数
function meffAllDeleteNowFunction()
{
	for(var i=0; i<multi_eff_object.count; i++){
		if(multi_eff_object[i].alive){
			multi_eff_object[i].finish();
		}
	}
}

function SetMultiObject(elm){
	if(elm.quantity === void) elm.quantity = 1;
	//このタイミングで処理計算をかける
	//multi_eff_object[+elm.obj].XXXX(elm.spmode);
	//SpecialMovingCalculation(multi_eff_object[+elm.obj],elm);
	var ap = multi_eff_object[+elm.obj].AddCalculationController(elm);
	
	for(var i = 0; i < +elm.quantity; i++){
		elm.quantitynum = i;
		elm.ap = ap;
		multi_eff_object[+elm.obj].addDrawObj(elm);
	}
}

function SetMultiObjectAfterMove(elm){
	var tg = +elm.obj;
	//+検索対象がいる
	var top = -1;
	for(var i = 0; i < multi_eff_object[tg].drawObj.count; i++){
		if(multi_eff_object[tg].drawObj[i].SearchDrawObj(elm.link)){
			top = i;
			break;
		}
	}
	
	if(top == -1) return;
	var quantity = 1;
	if(elm.quantity === void) elm.quantity = 1;
	else quantity = +elm.quantity;
	//このタイミングで処理計算をかける
	var ap = multi_eff_object[tg].AddCalculationController(elm);
	elm.ap = ap;

	var num = 0;
	for(var i = top; i < top + quantity; i++){
		elm.quantitynum = num;
		multi_eff_object[tg].drawObj[i].AfterMoveSet(elm);
		num++;
	}
}

@endscript
@endif

;//マルチエフェクト内のオブジェクトをセット
@macro name="meff_objset"
@eval exp="SetMultiObject(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro

;//マルチエフェクト内のオブジェクトをセット
@macro name="meff_objset_after"
@eval exp="SetMultiObjectAfterMove(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro

;//マルチエフェクトとしての実行
@macro name="meff"
@eval exp="multi_eff_object[+mp.obj].start(mp)"
@endmacro

;//マルチエフェクト
@macro name="smeff"
@eval exp="multi_eff_object[+mp.obj].finish();"
@endmacro

;//全マルチエフェクトの停止
@macro name="asmeff"
@eval exp="meffAllStopFunction();"
@endmacro

;//マルチエフェクトの表示OFFと削除
@macro name="meff_delete"
@eval exp="multi_eff_object[+mp.obj].DeleteObject();"
@endmacro

;//マルチエフェクトの表示OFFと削除(即時)
@macro name="meff_delete_now"
@eval exp="multi_eff_object[+mp.obj].DeleteObjectNow();"
@endmacro

;//全マルチエフェクトの表示OFFと削除
@macro name="meff_all_delete"
@eval exp="meffAllDeleteFunction();"
@endmacro

;//全マルチエフェクトの表示OFFと削除(即時)
@macro name="meff_all_delete_now"
@eval exp="meffAllDeleteNowFunction();"
@endmacro

@return

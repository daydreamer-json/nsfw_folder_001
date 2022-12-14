@if exp="typeof(global.light_eff_object) == 'undefined'"

@call storage="plugin_leff_exmode.ks"

@iscript

/*
	「effect.ks」を内包して一つのレイヤーに描くプラグイン
*/

class LightEffectPlugin extends KAGPlugin
{
	var foreLayer, backLayer;	// 表、裏へのアクセス
	var main, sub;				// 描画面記録
	var foreLayer2, backLayer2;	// 表、裏へのアクセス
	var main2, sub2;			// 描画面記録
	var absolute = 15000;		// レイヤーの絶対位置
	var drawObj = [];			// 描画用オブジェクトの配列
	var objStore = [];			// 描画オブジェクト記録用
	var myStore = %[];			// 自身の記録用
	var alive = false;			// 動作中かのフラグ

	var stick = 0;	// 開始時間
	var btick = 0;	// 前回の時間

	var intime = 0;		// フェードイン時間
	var outtime = 0;	// フェードアウト時間
	var time = -1;		// 全体時間
	var mblur = 0;		//
	var mblur_system;	//
	var alphaturn1;
	var alphaturn2;
	var mcolor = [];
	var end_mblur_count = 0;

	var deleteAfterTransFlag = false;	// トランジション後に消去フラグ
	var showAfterTransFlag = false;		// トランジション後に全部表示フラグ
	var EffectParent1 = false;
	var EffectParent2 = false;

	var SaveResults = [];				//規則系のランダム生成時に使用

	var FullLinkage = false;			//同期させるか否か
	var FirstDraw = false;				//初期描画か否か
	
	function LightEffectPlugin()
	{
		super.KAGPlugin(...);
		// レイヤー生成
		main = foreLayer = new Layer(kag, kag.fore.base);
		sub = backLayer = new Layer(kag, kag.back.base);

		main2 = foreLayer2 = new Layer(kag, kag.fore.base);
		sub2 = backLayer2 = new Layer(kag, kag.back.base);

		
		// レイヤー設定
		layerSetting(foreLayer);
		layerSetting(backLayer);
		layerSetting(foreLayer2);
		layerSetting(backLayer2);

	}

	function finalize()
	{
		stop();
		invalidate foreLayer;
		invalidate backLayer;
		super.finalize(...);
	}

	// レイヤー設定用関数
	function layerSetting(target)
	{
		with(target){
			.setImageSize(kag.scWidth, kag.scHeight);
			.setSizeToImageSize();
			.type = ltAlpha;
			.face = dfAlpha;
			.hitType = htMask;
			.hitThreshold = 256;
			.visible = true;
		}
	}

	// 裏表何かのプロパティを弄るための設定
	function setLayerOption(member, value){ foreLayer[member] = backLayer[member] = value;	}
	function setLayer2Option(member, value){ foreLayer2[member] = backLayer2[member] = value;	}

	// 規則系のデータ保存用
	function addSaveResults(result){
		SaveResults.add(result);
	}
	
	// エフェクトオブジェクトの追加
	function addDrawObj(elm)
	{
		var _i = objStore.add(%[]);
		(Dictionary.assign incontextof objStore[_i])(elm);
		var index = drawObj.add(new EffectObject(kag, drawObj.count, this));
		drawObj[index].startEffect(elm);
	}

	// エフェクトオブジェクトの途中変更
	function DrawObj_change(elm)
	{
		if(elm.obj !== void){
			//辞書配列の生成
			if(elm.inherit_storage == "true"){
				elm.storage = objStore[elm.obj].storage;
			}
			
			(Dictionary.assign incontextof objStore[+elm.obj])(elm);
			drawObj[+elm.obj].startEffect(elm);
		}else{
			dm("objの指定が有りません。");
		}
	}

	function DrawObj_inherit_change(elm)
	{
		if(elm.obj !== void){
			drawObj[+elm.obj].startEffect(elm);
		}else{
			dm("objの指定が有りません。");
		}
	}
	
	// エフェクト類の動作
	function start(elm, ready)
	{
		if(elm.spmode2=="true"){
			for(var i=0; i<50; i++)addDrawObj(%[storage:"gr_light", spmode2:"true", rev:elm.rev]);
		}

		if(!main.visible){
			main.fillRect(0,0,kag.scWidth,kag.scHeight,0x0);
			main2.fillRect(0,0,kag.scWidth,kag.scHeight,0x0);
		}
		
		// 属性保存
		(Dictionary.clear incontextof myStore)();
		(Dictionary.assign incontextof myStore)(elm);

		// 表示タイプ設定
		var _type;
		if(elm.mode != void)_type = imageTagLayerType[elm.mode].type;	// この辞書配列はtjsがはじめから持ってるらしい
		setLayerOption("type", (_type !== void ? _type : ltAlpha));
		setLayer2Option("type", (_type !== void ? _type : ltAlpha));

		if(elm.quake === "true"){
			setLayerOption("type", ltPsNormal);
			setLayer2Option("type", ltPsNormal);
		}
		//擬似モーションブラーの生成
		
		if(elm.mblur !== void){
			mcolor.clear();
			var _mblur = elm.mblur.split("(),",,true);
			if(_mblur[0] != 0){
				if(_mblur.count == 7){
					mblur = +_mblur[0];	 //alpha
					mcolor.add(+_mblur[1]);//before_red
					mcolor.add(+_mblur[2]);//after_red
					mcolor.add(+_mblur[3]);//before_green
					mcolor.add(+_mblur[4]);//after_green
					mcolor.add(+_mblur[5]);//before_blue
					mcolor.add(+_mblur[6]);//after_blue

					if(elm.ex_mblur == "true"){
						mblur_system = "ex_cveAddblurAt";
					}else{
						mblur_system = "cveAddblurAt";
					}
					end_mblur_count = (int)((255 \ mblur) + 1);
				}else if(_mblur.count == 4){
					mblur = +_mblur[0];
					mcolor.add(+_mblur[1]);
					mcolor.add(+_mblur[2]);
					mcolor.add(+_mblur[3]);
					mblur_system = "rgbasubtractionblurAt";
					end_mblur_count = (int)((255 \ mblur) + 1);
				}else{
					mblur = +_mblur[0];
					if(elm.ex_mblur == "true"){
						mblur_system = "wtbblurAt";
					}else{
						mblur_system = "subtractionblurAt";
						mblur = mblur * -1;
					}
					end_mblur_count = (int)((255 \ mblur) + 1);
				}
			}else{
				mblur = 0;
				end_mblur_count = 0;
			}
		}else{
			mblur = 0;
			mcolor.clear();
			end_mblur_count = 0;
		}
		
		
		main.parent = kag.fore.base;
		sub.parent = kag.back.base;

		EffectParent1 = false;

		if(elm.alphaturn1 == "true"){
			alphaturn1 = true;
		}else{
			alphaturn1 = false;
		}

		if(elm.alphaturn2 == "true"){
			alphaturn2 = true;
		}else{
			alphaturn2 = false;
		}
		
		if(elm.effectparent1 !== void){
			var tmp_ep = [].split("(), ", elm.effectparent1, , true);
			var temp_add = +tmp_ep[0];
			//α画像の読み込み
			if(tmp_ep.count == 1){
				tmp_ep.add("eff");
			}
			if(tmp_ep[1] == "eff"){
				//最終targetLayerの親レイヤーの指定の画像の読み込み
				if(effect_object[temp_add].targetLayer !== void && temp_add < obj_no){
					main.parent = effect_object[temp_add].targetLayer;
					sub.parent = effect_object[temp_add].targetLayerBack;
				}
			}else if(tmp_ep[1] == "layer"){
				if(0 <= temp_add && temp_add < kag.fore.layers.count){
					main.parent = kag.fore.layers[temp_add];
					sub.parent = kag.back.layers[temp_add];
				}
			}else if(tmp_ep[1] == "leff"){
				//if(effect_object[temp_add].targetLayer !== void && temp_add < obj_no){
					//main.parent = ;
					//sub.parent = ;
				//}
			}
			EffectParent1 = true;
		}
		
		main2.parent = kag.fore.base;
		sub2.parent = kag.back.base;
		EffectParent2 = false;
		
		if(elm.effectparent2 !== void){
			var tmp_ep = [].split("(), ", elm.effectparent2, , true);
			var temp_add = +tmp_ep[0];
			//α画像の読み込み
			if(tmp_ep.count == 1){
				tmp_ep.add("eff");
			}
			if(tmp_ep[1] == "eff"){
				//最終targetLayerの親レイヤーの指定の画像の読み込み
				if(effect_object[temp_add].targetLayer !== void && temp_add < obj_no){
					main2.parent = effect_object[temp_add].targetLayer;
					sub2.parent = effect_object[temp_add].targetLayerBack;
				}
			}else if(tmp_ep[1] == "layer"){
				if(0 <= temp_add && temp_add < kag.fore.layers.count){
					main2.parent = kag.fore.layers[temp_add];
					sub2.parent = kag.back.layers[temp_add];
				}
			}else if(tmp_ep[1] == "leff"){
				//if(effect_object[temp_add].targetLayer !== void && temp_add < obj_no){
				//	main2.parent = effect_object[temp_add].targetLayer;
				//	sub2.parent = effect_object[temp_add].targetLayerBack;
				//}
			}
			EffectParent2 = true;
		}

		// 奥行き設定
		if(elm.absolute !== void){
			absolute = +elm.absolute;
		}
		
		setLayerOption("absolute", absolute + 1);
		setLayer2Option("absolute", absolute - 1);
		
		// 裏から始める場合
		if(ready){
			showAfterTransFlag = true;
			foreLayer.visible = false;
			backLayer.visible = true;
			foreLayer2.visible = false;
			backLayer2.visible = true;
		}else{
			showAfterTransFlag = false;
			setLayerOption("visible", true);
			setLayer2Option("visible", true);

		}

		// 時間を設定
		if(elm.time !== void){
			time = +elm.time;
		}else{
			time = -1;
		}
		
		// フェードイン・アウトを設定
		if(elm.intime != 0){
			intime = +elm.intime;
			setLayerOption("opacity", 0);
			setLayer2Option("opacity", 0);
		}else{
			intime = 0;
			setLayerOption("opacity", 255);
			setLayer2Option("opacity", 255);
		}
		if(elm.outtime != 0)outtime = +elm.outtime;
		else outtime = 0;

		FirstDraw = false;
		FullLinkage = false;
		if(elm.flink === "true"){ FullLinkage = true;}
		
		stick = btick = System.getTickCount();

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
			if(ntick < intime){
				setLayerOption("opacity", (int)((ntick/intime)*255));
				setLayer2Option("opacity", (int)((ntick/intime)*255));
			}else if(foreLayer.opacity != 255){
				setLayerOption("opacity", 255);
				setLayer2Option("opacity", 255);
			}
		}
		// 終了時間が決まっている場合の処理
		if(time != -1){
			if(ntick > (time-outtime)){
				setLayerOption("opacity", (int)(((time-ntick)/outtime)*255));
				setLayer2Option("opacity", (int)(((time-ntick)/outtime)*255));
			}
			if(ntick >= time){
				kag.trigger('leff');
				return stop();
			}
		}

		
		if(mblur == 0){
			main.fillRect(0,0,kag.scWidth,kag.scHeight,0x0);
			main2.fillRect(0,0,kag.scWidth,kag.scHeight,0x0);
		}else{
			if(mblur_system == "subtractionblurAt"){
				main.AlphaAdd(mblur);
				main2.AlphaAdd(mblur);
			}else if(mblur_system == "rgbasubtractionblurAt"){
				main.ColorAlphaAdd(mcolor[0],mcolor[1],mcolor[2],mblur);
				main2.ColorAlphaAdd(mcolor[0],mcolor[1],mcolor[2],mblur);
			}else if(mblur_system == "cveAddblurAt"){
				main.ColorVectorEffectAdd(mcolor[0],mcolor[1],mcolor[2],mcolor[3],mcolor[4],mcolor[5],mblur);
				main2.ColorVectorEffectAdd(mcolor[0],mcolor[1],mcolor[2],mcolor[3],mcolor[4],mcolor[5],mblur);
			}else if(mblur_system == "ex_cveAddblurAt"){
				main.ExtraColorVectorEffectAdd(mcolor[0],mcolor[1],mcolor[2],mcolor[3],mcolor[4],mcolor[5],mblur);
				main2.ExtraColorVectorEffectAdd(mcolor[0],mcolor[1],mcolor[2],mcolor[3],mcolor[4],mcolor[5],mblur);
			}else if(mblur_system == "wtbblurAt"){
				main.WhiteToBlueBlurAdd(mblur);
				main2.WhiteToBlueBlurAdd(mblur);
			}
		}
		
		//描画更新
		var draw_order = [];
		var drawObj_absolute = [];
		for(var i = 0;i < drawObj.count;i++){
			draw_order[i] = i;
			drawObj_absolute[i] = drawObj[i].absolute.GetNowParams(tick);
			
			if(absolute < drawObj_absolute[i]){
				drawObj[draw_order[i]].drawTargetChange(main);
			}else{
				drawObj[draw_order[i]].drawTargetChange(main2);
			}
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
		
		for(var i=0; i< drawObj.count; i++){
			drawObj[draw_order[i]].continuousHandler(tick);
		}

		if(alphaturn1){
			main.turnAlpha();
		}

		if(alphaturn2){
			main2.turnAlpha();
		}
		
		sub.assignImages(main);
		sub2.assignImages(main2);
	}

	// 完全停止
	function stop()
	{
		alive = false;
		
		System.removeContinuousHandler(continuousHandler);
		
		for(var i=drawObj.count-1; i>0; i--){
			invalidate drawObj[i];
		}
		
		drawObj.clear();
		SaveResults.clear();
		
		setLayerOption("visible", false);
		setLayer2Option("visible", false);

		// 記録破棄
		objStore.clear();
		(Dictionary.clear incontextof myStore)();
	}
	
	// 表示したまま完全停止
	function stop2()
	{
		alive = false;

		System.removeContinuousHandler(continuousHandler);
		for(var i=0; i<drawObj.count; i++){
			invalidate drawObj[i];
		}
		drawObj.clear();

		// 記録破棄
		objStore.clear();
		(Dictionary.clear incontextof myStore)();
	}

	function obj_obj_finish(elm)
	{
		/*確認しながら*/
		var obj = -1;
		if(elm.obj != void){
			if(drawObj[+elm.obj] != void){
				obj = +elm.obj;
				if(elm.stoploop == "true"){
					drawObj[obj].loop = false;;
				}
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

	function obj_all_finish(elm){
		
		if(elm.stoploop == "true"){
			for(var i=0;i < drawObj.count;i++){
				drawObj[i].loop = false;
			}
		}
		
		if(elm.clear != "true"){
			obj_all_finish_1();
		}else{
			obj_all_finish_2();
		}
	}
	
	function obj_all_finish_1()
	{
		alive = false;
		
		for(var i=0; i<drawObj.count; i++){
			drawObj[i].delay = 0;
			drawObj[i].lasttick=System.getTickCount();
			drawObj[i].starttick=drawObj[i].lasttick - drawObj[i].totalTime;
			drawObj[i].alive = false;
			drawObj[i].moving = false;
		}
		readyStop();
		if(!sub.visible){
			sub.fillRect(0,0,kag.scWidth,kag.scHeight,0x0);
			sub2.fillRect(0,0,kag.scWidth,kag.scHeight,0x0);
		}

	}

	function obj_all_finish_2()
	{
		for(var i=0; i<drawObj.count; i++){
			drawObj[i].delay = 0;
			drawObj[i].lasttick=System.getTickCount();
			drawObj[i].starttick=drawObj[i].lasttick - drawObj[i].totalTime;
		}
	}
	
	// 次のトランジションに巻き込まれて停止するように指示
	function readyStop()
	{
		deleteAfterTransFlag = true;
		//foreLayer.visible = true;		// すでに表示されてなかった場合があるのでいちいち表示状態にしないでみる
		backLayer.visible = false;
		//foreLayer2.visible = true;
		backLayer2.visible = false;
	}

	// 表裏を常に正しく指定するように参照を入れ替え
	function onExchangeForeBack()
	{
		if(showAfterTransFlag){
			setLayerOption("visible", true);
			setLayer2Option("visible", true);
			showAfterTransFlag = false;
		}
		if(deleteAfterTransFlag){
			stop();
			deleteAfterTransFlag = false;
		}

		var tmp = foreLayer;
		var tmp2 = foreLayer2;
		foreLayer = backLayer;
		foreLayer2 = backLayer2;
		backLayer = tmp;
		backLayer2 = tmp2;
	}

	// セーブ
	function onStore(f, elm)
	{
		// 無かった場合の対処
		if(f["leff_obj"] === void)f["leff_obj"] = [];
		if(f["leff_my"] === void)f["leff_my"] = %[];

		if(alive){
			var dic = f["leff_obj"];
			dic.assignStruct(objStore);

			dic = f["leff_my"];
			(Dictionary.clear incontextof dic)();
			(Dictionary.assign incontextof dic)(myStore);
		}else{
			f["leff_obj"].clear();
			(Dictionary.clear incontextof f["leff_my"])();
		}
		f["leff"] = alive;
	}

	// ロード
	function onRestore(f, clear, elm)
	{
		stop(); // 動作を停止

		//addDrawObj
		
		if(f["leff"]){
			var dic = f["leff_obj"];
			for(var i=0; i<dic.count; i++){
				addDrawObj(dic[i]);
			}
			start(f["leff_my"], false);
		}
	}

	function onStableStateChanged(stable){}
	function onMessageHiddenStateChanged(hidden){}
	function onCopyLayer(toback){}
	function onSaveSystemVariables(){}
}

class EffectObject
{

	var owner = void;		//管理クラス
	
	// このプラグインの管理番号
	var obj_no=0;

	//--------------------------------------------------
	var size;			// サイズを記録する配列
	var cx, cy;			// 回転中心
	var xsize;			// 横軸（縦回転）
	var ysize;			// 縦軸（横回転）
	var xspin;			// 横軸（縦回転）
	var yspin;			// 縦軸（横回転）
	var rad;			// 回転角
	var absolute;		// absolute
	var rgamma;			// rgamma補正値
	var ggamma;			// ggamma補正値
	var bgamma;			// bgamma補正値
	var rfloor;			// rfloor補正値
	var gfloor;			// gfloor補正値
	var bfloor;			// bfloor補正値
	var rceil;			// rceil補正値
	var gceil;			// gceil補正値
	var bceil;			// bceil補正値
	//--------------------------------------------------
	
	var accel;			// 加速度的な動きを行うか
	var moveFunc;		// 移動位置計算用関数
	var zoomFunc;		// 拡大処理用関数
	var clear;			// レイヤをクリアするかどうか
	var blend;			// 重ね合わせの不透明度
	var page;			// ページ裏表
	var mblur;			// 擬似モーションブラー用
	var bblur;			// ボックスブラー用
	var pathtype;		// パスの方式
	var lu_corner;		// パスの方式・左上隅指定
	var spaccel;		// 特殊な加減速

	var sr, dr;			// 回転角度
	var path;			// パスの作業用
	var time;			// ひとつのパスを通る時間
	var totalTime;		// 総合時間
	var lasttick=0;		// 前回の描画時間
	var starttick;		// 描画開始時間
	var affintype;		// アフィン変換の方式
	var tempLayer;		// 画像レイヤー
	var effecttempLayer;// 色の配列化のみ使用

	var zx = [];		// スプラインワーク
	var zy = [];		// スプラインワーク
	var imageWidthHalf;	// 対象レイヤーの幅の半分
	var imageHeightHalf;// 対象レイヤーの高さの半分

	var moving = false;	// 動作中かどうか
	var alive = false;	// レイヤー類が生きてるかどうか

	// セーブ・ロード用パラメータ記録配列
	var storeDic = %[];

	// このプラグインが使われたレイヤーの表と裏の管理
	var foreState = false;
	var backState = false;

	var loop = false;		// ループするか
	var lcnt = 0;			// ループ回数
	var fillColor = "";		// 画面更新の際に先ず最初に塗りつぶす色

	var gl_l,gl_t;

	var smallest = false;	// 画像幅での更新
	var blink = false;		// 明滅オプション

	var grayscaleflag;		// リアルタイム色調補正用
	var sepiaflag;			// リアルタイム色調補正用
	var turnflag;			// リアルタイム色調補正用

	//var alpha_x;
	//var alpha_y;
	
	var delay = 0;				// 何ミリ秒遅れて開始されるかの値
	var delay_visible = false;	//delay時に描画をするか否か
	var fadeInTime = -1;	// フェードインさせる時間
	var fadeOutTime = -1;	// フェードアウトさせる時間

	var targetLayer;
	var targetWidth = kag.scWidth;
	var targetHeight = kag.scHeight;

	var timeOutDraw = false;	// 時間が終了しても最終地点を描画し続けるか？

	var spmode = 0;
	var spmode2 = 0;
	var exmode = 0;


	var function_group = [];		//ランダムを配列形へ→記述を注意
	var function_target = [];		//ランダムを配列形へ→記述を注意

	
	var spmd_rev;
	var spmst;
	var alphamode;

	var inherit = false;		//前任者の位置を引き継ぐ(最終地点)
	var inherit_state;			//回転でデータ(配列タイプのものはここで追加してやる)

	var SaveValue = [];			//再生成が必要な値を保存
	
	var MoveColorFlag = false;

	/*offset処理*/
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
	var OffsetDelay;					//
	var Offsettick=0;					// 前回の描画時間
	var Offsetlasttick=0;				// 前回の描画時間
	var Offsetstarttick;				// 描画開始時間
	var Offsetloop;						// 連続再生
	var OffsetloopCount;				// 連続再生
	
	function EffectObject(window, no, owm)
	{

		owner = owm;
		
		obj_no = no;

		this.window = window;

		// 最初にレイヤー確保
		tempLayer = new AutoPiledLayer(window, kag.fore.base);
		tempLayer.owner = this;

		//初期確保
		effecttempLayer = new Layer(window, kag.fore.base);
		effecttempLayer.owner = this;
		
		/*
		// 最初にレイヤー確保
		tempLayer = new Layer(window, kag.fore.base);
		*/

		targetLayer = owner.main;

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
		rgamma = new ParamsArray(1);					//初期値は、1
		ggamma = new ParamsArray(1);					//初期値は、1
		bgamma = new ParamsArray(1);					//初期値は、1
		rfloor = new ParamsArray(0);					//初期値は、0
		gfloor = new ParamsArray(0);					//初期値は、0
		bfloor = new ParamsArray(0);					//初期値は、0
		rceil = new ParamsArray(255);					//初期値は、255
		gceil = new ParamsArray(255);					//初期値は、255
		bceil = new ParamsArray(255);					//初期値は、255
	}
	
	//配列データのデストラクタ
	function ArrayParamsFinalize(){
		invalidate size;							//
		invalidate xsize;							//
		invalidate ysize;							//
		invalidate cx;								//
		invalidate cy;								//
		invalidate rad;								//
		invalidate xspin;							//
		invalidate yspin;							//
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
		rgamma.clear();								//
		ggamma.clear();								//
		bgamma.clear();								//
		rfloor.clear();								//
		gfloor.clear();								//
		bfloor.clear();								//
		rceil.clear();								//
		gceil.clear();								//
		bceil.clear();								//
	}

	function reset_totaltime(){
		// 時間設定
		if(this.time<=1)this.time = 1;
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;
		AllgettimeForState();
	}

	//pathは別口に必要が有るので変更
	function AllgettimeForState(){
		size.TimeForParams(totalTime);				// サイズ用の時間を計算
		xsize.TimeForParams(totalTime);				// サイズ用の時間を計算
		ysize.TimeForParams(totalTime);				// サイズ用の時間を計算
		rad.TimeForParams(totalTime);				// 角度用の時間を計算
		xspin.TimeForParams(totalTime);				// XSpin用の時間を計算
		yspin.TimeForParams(totalTime);				// YSpin用の時間を計算
		absolute.TimeForParams(totalTime);			// absolute用の時間を計算
		cx.TimeForParams(totalTime);				// alpha_x用の時間を計算
		cy.TimeForParams(totalTime);				// alpha_y用の時間を計算
		rgamma.TimeForParams(totalTime);			// rgamma用の時間を計算
		ggamma.TimeForParams(totalTime);			// ggamma用の時間を計算
		bgamma.TimeForParams(totalTime);			// bgamma用の時間を計算
		rfloor.TimeForParams(totalTime);			// rfloor用の時間を計算
		gfloor.TimeForParams(totalTime);			// gfloor用の時間を計算
		bfloor.TimeForParams(totalTime);			// bfloor用の時間を計算
		rceil.TimeForParams(totalTime);				// rceil用の時間を計算
		gceil.TimeForParams(totalTime);				// gceil用の時間を計算
		bceil.TimeForParams(totalTime);				// bceil用の時間を計算
	}

	function drawTargetChange(drawTarget){
		targetLayer = drawTarget;
	}
	
	function finalize()
	{
		// 一応止めて所持オブジェクト破棄
		stop();
		clearLayer();
		deleteLayer();
		SaveValue.clear();
		ArrayParamsFinalize();
	}

	function startEffect(elm)
	{
		
		// 辞書配列をセーブ・ロード用に退避
		(Dictionary.assign incontextof storeDic)(elm);

		
		// 特殊処理：
		if(elm.spmode == "true"){
			//elm.path = intrandom(50,1230) + "," + intrandom(50,690) + ",255";
			var __x = intrandom(50,1230);
			var __y = intrandom(50,690);
			elm.path = __x + "," + __y + ",255," + (__x+intrandom(-50,50)) + "," + (__y+intrandom(-50,50)) + ",255";
			elm.size = 0 + "," + (intrandom(8,15)/10);
			
			elm.xspin = "0," + intrandom(1,5)/10;
			elm.yspin = "0," + intrandom(1,5)/10;
			
			/*
			elm.xspin = [0,intrandom(1,5)/10];
			elm.yspin = [0,intrandom(1,5)/10];
			*/
			
			elm.loop = "true";
			elm.accel = "-1.8";
			elm.delay = intrandom(0,1000);
			elm.fadeouttime = "500";

			SaveValue.add((elm.time_max !== void) ? +elm.time_max:1500);
			SaveValue.add((elm.time_min !== void) ? +elm.time_min:1000);
			
			elm.time = intrandom((int)(SaveValue[1]),(int)(SaveValue[0]));
			spmode = true;
		}else spmode = false;

		if(elm.spmode2 == "true"){
			spmst = System.getTickCount();
			var __x = intrandom(0,1280);
			var __y = intrandom(0,720);
			if(elm.rev == "true"){
				spmd_rev = true;
				elm.path = "317,716,255," + __x + "," + __y + ",255";
				elm.accel = "1.8";
			}else{
				spmd_rev = false;
				elm.path = __x + "," + __y + ",255,317,716,255";
				elm.accel = "-1.8";
			}
			elm.size = 1 + "," + (Math.random()-0.5);
			elm.loop = "true";
			elm.delay = intrandom(0,500);
			elm.fadeouttime = "250";
			elm.time = intrandom(1000, 5000);
			spmode2 = true;
		}else spmode2 = false;

		//特殊動作
		if(elm.exmode !== void){
			elm = ExmodeSet(owner,elm,obj_no);
			exmode = true;
		}
		
		
		if(elm.rainbow !== void){
			elm.rgamma = "(1,1)";
			elm.ggamma = "(1,1)";
			elm.bgamma = "(1,1)";
			elm.rfloor = "(0,0)";
			elm.gfloor = "(0,0)";
			elm.bfloor = "(0,0)";
			elm.rceil = "(255,255,0,0,0,255,255)";
			elm.gceil = "(0,255,255,255,0,0,0)";
			elm.bceil = "(0,0,0,255,255,255,0)";
			elm.grayscale = "true";
			elm.movecolor = "true";
		}
		
		// 最終時間を過ぎた時に最終地点の描画を続けるかどうか
		if(elm.timeoutdraw == "true")timeOutDraw = true;
		else timeOutDraw = false;

		// ループするか？
		this.loop = elm.loop == "true" ? true : false;
		lcnt = 0;

		this.Offsetloop = elm.offsetloop == "true" ? true : false;							//ループフラグ
		this.OffsetloopCount = elm.offsetloopcount !== void ? +elm.offsetloopcount : -1;	//ループ回数
		
		//一応初期化と確認項目
		if(this.OffsetloopCount == 0){
			elm.Offsettime = 0;											//【一度もループしない】なので動作の停止
			this.OffsetloopCount = false;								//ループフラグをオフ
		}else if(this.OffsetloopCount != -1) this.OffsetloopCount--;	//カウントダウン方式を取る
		
		// 明滅するか？
		blink = elm.blink == "true" ? true : false;

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
		
		var base = window.fore.base;

		// 既存の動作を停止
		stop();
		
		//---------------------------
		// 画像用レイヤーを確保
		//---------------------------
		// 画像をロード・指定されていない場合特定レイヤーをコピー
		var ImageReload=true;
		if(ImageReload){
			tempLayer.loadImages(elm.storage, clNone, elm.window == "true" , elm);
		}
		
		/*
		if(elm.storage!==void){
			if(Storages.isExistentStorage(Storages.chopStorageExt(elm.storage)+".pos")){
				var inf = Scripts.evalStorage(Storages.chopStorageExt(elm.storage)+".pos");
				var re = tempLayer.loadImages(inf[0]);
				var _temp = new global.Layer(kag, kag.back.base);
				_temp.loadImages(elm.storage);
				tempLayer.copyRect(inf[2], inf[1], _temp, 0, 0, _temp.imageWidth, _temp.imageHeight);
				invalidate _temp;
			}else tempLayer.loadImages(elm.storage, clNone);
		}*/

		if(elm.a_r !== void || elm.a_g !== void || elm.a_b !== void){
			elm.a_r = (elm.a_r === void) ? -1 : +elm.a_r;					//彩色【Ｒ】を強制変更
			elm.a_g = (elm.a_g === void) ? -1 : +elm.a_g;					//彩色【Ｇ】を強制変更
			elm.a_b = (elm.a_b === void) ? -1 : +elm.a_b;					//彩色【Ｂ】を強制変更
			tempLayer.AlphaColorRect(elm.a_r, elm.a_g, elm.a_b);			//彩色の変更を実行
		}

		// 謎の処理：奇数に補正。
		// 縦横の数値が奇数偶数混ざってると苦手なのかも？
		if(!(tempLayer.imageWidth%2))tempLayer.imageWidth+=1;
		if(!(tempLayer.imageHeight%2))tempLayer.imageHeight+=1;
		
		//if(elm.alpha_x != void){alpha_x = elm.alpha_x;}else{alpha_x = 0;}
		//if(elm.alpha_y != void){alpha_y = elm.alpha_y;}else{alpha_y = 0;}


		alphamode=false;
		
		// 画像の端にαを掛ける特殊な処理
		if(elm.addalpha != "false" && elm.addalpha != void){
			var tmp = new Layer(kag, kag.fore.base);
			if(elm.addalpha != "true"){
				tmp.loadImages(elm.addalpha);
			}else{
				tmp.loadImages("alpha_img");
			}
			
			/*
			var rem_face = tempLayer.face;
			tempLayer.face = dfMask;
			//tempLayer.copyRect(0, 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight);
			tempLayer.copyRect((elm.alpha_x !== void) ? +elm.alpha_x : 0, (elm.alpha_y !== void) ? +elm.alpha_y : 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight);
			tempLayer.face = rem_face;
			invalidate tmp;
			*/
			var alpha_x;
			var alpha_y;
			if(elm.alpha_x != void){alpha_x = elm.alpha_x;}else{alpha_x = 0;}
			if(elm.alpha_y != void){alpha_y = elm.alpha_y;}else{alpha_y = 0;}
			
			if(elm.alphamode === void || elm.alphamode != "true"){
				var rem_face = tempLayer.face;
				tempLayer.face = dfMask;
				tempLayer.fillRect(0,0,tempLayer.imageWidth,tempLayer.imageHeight,0x00000000);
				tempLayer.copyRect(alpha_x, alpha_y, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight);
				tempLayer.face = rem_face;
				invalidate tmp;
			}else{
				alphamode = true;
				if(elm.addalpha != "true"){
					tmp.adjustGamma(1, 255, 0, 1, 255, 0, 1, 255, 0);
				}
				var t_w = tempLayer.imageWidth;
				var t_h = tempLayer.imageHeight;
				tmp.operateRect(((tmp.imageWidth - t_w) / 2) - alpha_x, ((tmp.imageHeight - t_h) / 2) - alpha_y, tempLayer, 0, 0, t_w, t_h, omMultiplicative, 255);
				tempLayer.fillRect(0,0,t_w,t_h,0x00000000);
				tempLayer.copyRect(0,0,tmp,((tmp.imageWidth - t_w) / 2) - alpha_x,((tmp.imageHeight - t_h) / 2) - alpha_y, t_w, t_h);
				invalidate tmp;
			}
		}

		//画像にノイズを乗っける
		if(elm.noise_level !== void){
			tempLayer.noise(+elm.noise_level);
		}else if(elm.noise == "true"){
			tempLayer.generateWhiteNoise();
		}
		
	
		rgamma.ArrayForParams(elm.rgamma);		// 色調補正のrgammaの配列のセット
		ggamma.ArrayForParams(elm.ggamma);		// 色調補正のggammaの配列のセット
		bgamma.ArrayForParams(elm.bgamma);		// 色調補正のbgammaの配列のセット
		rfloor.ArrayForParams(elm.rfloor);		// 色調補正のrfloorの配列のセット
		gfloor.ArrayForParams(elm.gfloor);		// 色調補正のgfloorの配列のセット
		bfloor.ArrayForParams(elm.bfloor);		// 色調補正のbfloorの配列のセット
		rceil.ArrayForParams(elm.rceil);		// 色調補正のrceilの配列のセット
		gceil.ArrayForParams(elm.gceil);		// 色調補正のgceilの配列のセット
		bceil.ArrayForParams(elm.bceil);		// 色調補正のbceilの配列のセット

		
		if(elm.movecolor == "true"){MoveColorFlag = true;}else{MoveColorFlag = false;}
		
		/*
		// 画像用レイヤーに効果をかける
		if(tempLayer.charaLayer === void && tempLayer.standLayer === void){
			if(MoveColorFlag){
				if(elm.grayscale=='true'){grayscaleflag = true;}else{grayscaleflag = false;}
				if(elm.sepia == 'true'){sepiaflag = true;}else{sepiaflag = false;}
				if(elm.turn=='true'){turnflag = true;}else{turnflag = false;}
			}else{
				// 画像用レイヤーに効果をかける
				// グレースケール
				if(elm.grayscale=='true')tempLayer.doGrayScale();
				// ガンマ補正
				elm.rgamma = rgamma[0] !== void ? rgamma[0] : 1.0;
				elm.ggamma = ggamma[0] !== void ? ggamma[0] : 1.0;
				elm.bgamma = bgamma[0] !== void ? bgamma[0] : 1.0;
				elm.rfloor = rfloor[0] !== void ? rfloor[0] : 0;
				elm.gfloor = gfloor[0] !== void ? gfloor[0] : 0;
				elm.bfloor = bfloor[0] !== void ? bfloor[0] : 0;
				elm.rceil = rceil[0] !== void ? rceil[0] : 255;
				elm.gceil = gceil[0] !== void ? gceil[0] : 255;
				elm.bceil = bceil[0] !== void ? bceil[0] : 255;
				
				if(elm.sepia == 'true'){
					tempLayer.doGrayScale();
					elm.rgamma = 1.3;
					elm.ggamma = 1.1;
					elm.bgamma = 1.0;
				}if(elm.turn == 'true'){	// 階調の反転
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
				
				
				tempLayer.adjustGamma(elm.rgamma, elm.rfloor, elm.rceil, elm.ggamma, elm.gfloor, elm.gceil, elm.bgamma, elm.bfloor, elm.bceil);

				inherit_state["rgamma"] = elm.rgamma;
				inherit_state["ggamma"] = elm.ggamma;
				inherit_state["bgamma"] = elm.bgamma;
				inherit_state["rfloor"] = elm.rfloor;
				inherit_state["gfloor"] = elm.gfloor;
				inherit_state["bfloor"] = elm.bfloor;
				inherit_state["rceil"] = elm.rceil;
				inherit_state["gceil"] = elm.gceil;
				inherit_state["bceil"] = elm.bceil;
			}
			
			// 反転
			if(elm.fliplr=='true')tempLayer.flipLR();
			if(elm.flipud=='true')tempLayer.flipUD();
			// ボックスブラー
			if(elm.bblur=='true')tempLayer.doBoxBlur((int)elm.bbx, (int)elm.bby);
		}
		*/
		
		/*明度とコントラスト*/
		if(elm.light == "true"){
			var brightness;	//brightness	明度 -255 ～ 255, 負数の場合は暗くなる
		    var contrast;	//contrast		コントラスト -100 ～100, 0 の場合変化しない
			if(elm.brightness !== void){brightness = elm.brightness;}else{brightness = 0;}
			if(elm.contrast !== void){contrast = elm.contrast;}else{contrast = 0;}
			
			tempLayer.light(brightness, contrast);
		}
		
		/*色相と彩度*/
		if(elm.colorize == "true"){
			var hue;			//基礎パラメータ:色相(HUE)			-180～180 (度)
			var saturation;		//基礎パラメータ:彩度(SATURATION)	-100～100 (%)
			var colorize_blend;	//基礎パラメータ:ブレンド 0 (効果なし) ～ 1 (full effect)
			
			if(elm.hue !== void){hue = elm.hue;}else{hue = 0;}
			if(elm.saturation !== void){saturation = elm.saturation;}else{saturation = 0;}
			if(elm.colorize_blend !== void){colorize_blend = elm.colorize_blend;}else{colorize_blend = 0;}
			
			tempLayer.colorize(hue, saturation, colorize_blend);
		}
		
		
		/*色相変更*/
		if(elm.modulate == "true"){
			var hue;		//基礎パラメータ:色相(HUE)			-180～180 (度)
			var saturation;	//基礎パラメータ:彩度(SATURATION)	-100～100 (%)
			var luminance;	//基礎パラメータ:輝度(luminance)	-100～100 (%)
			
			if(elm.hue !== void){hue = elm.hue;}else{hue = 0;}
			if(elm.saturation !== void){saturation = elm.saturation;}else{saturation = 0;}
			if(elm.luminance !== void){luminance = elm.luminance;}else{luminance = 0;}
			
			tempLayer.modulate( hue, saturation, luminance);
		}
		
		//---------------------------
		// 他パラメーター設定
		//---------------------------
		// 縦回転・横回転の設定
		/*
		if(elm.xspin !== void)xspin = +elm.xspin;
		else xspin = 0;
		if(elm.yspin !== void)yspin = +elm.yspin;
		else yspin = 0;
		*/

		xspin.ArrayForParams(elm.xspin);							// 縦回転であるxspinの配列のセット
		yspin.ArrayForParams(elm.yspin);							// 横回転であるyspinの配列のセット
		absolute.ArrayForParams(elm.absolute);						// 絶対位置であるabsoluteの配列のセット

		// よく使うからとりあえず計算済みのものを。
		imageWidthHalf = kag.scWidth / 2;
		imageHeightHalf = kag.scHeight / 2;

		// path の分解
		if(elm.path === void){
			path = [imageWidthHalf,imageHeightHalf,255,imageWidthHalf,imageHeightHalf,255];
		}else{
			this.path = [].split("(), ", elm.path, , true);
		}

		if(this.path.count < 4){
			// 1点しか指定されていない場合、2点目にも同じ数値を。
			this.path[3]=this.path[0];
			this.path[4]=this.path[1];
			this.path[5]=this.path[2];
		}

		OffsetPath.clear();
		ozx.clear();
		ozy.clear();
		
		//自力移動パスアニメの追加
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

		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;

		this.Offsettime = elm.offsettime !== void ? +elm.offsettime : 1000;
		if(this.Offsettime<=1)this.Offsettime = 1;
		
		// 全体時間を計算
		OffsettotalTime = (this.OffsetPath.count \ 3 - 1) * Offsettime;
		
		
		// 回転中心
		cx.ArrayForParams(elm.cx);											// 回転中心																												//回転中心【Ｘ軸】の配列化指定
		cy.ArrayForParams(elm.cy);											// 回転中心
		size.ArrayForParams(elm.size, elm.ss, elm.ds);						// サイズ変化を配列化
		xsize.ArrayForParams(elm.xsize);									// サイズ変化【横】を配列化
		ysize.ArrayForParams(elm.ysize);									// サイズ変化【縦】を配列化
		rad.ArrayForParams(elm.rad, elm.sr, elm.dr);						// 回転角度【Ｚ軸】の配列化
		for(var i = this.rad.params.count-1; i>=0; i--){
			this.rad.params[i] = +this.rad.params[i] * (Math.PI/180) * -1;	//角度は周期計算なので係数倍を360°=2πとする
		}

		// ディレイ設定
		if(elm.delay !== void){
			Offsettick = 0;
			delay = elm.delay;
		}else{
			Offsettick = 0;
			delay = 0;
		}

		if(elm.delay_visible !== void && elm.delay_visible != false){delay_visible = true;}
		
		else{elm.delay_visible = false;}

		if(elm.offsetdelay !== void){
			OffsetDelay = +elm.offsetdelay;
		}else{
			OffsetDelay = 0;
		}

		
		// フェード設定
		if(elm.fadeintime !== void)fadeInTime = elm.fadeintime;
		else fadeInTime = -1;
		if(elm.fadeouttime !== void)fadeOutTime = elm.fadeouttime;
		else fadeOutTime = -1;
		
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
		
		// 全体時間を計算
		totalTime = (this.path.count \ 3 - 1) * time;
		
		AllgettimeForState();
		

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

				this.rgamma.params.unshift(+inherit_state.rgamma);
				this.ggamma.params.unshift(+inherit_state.ggamma);
				this.bgamma.params.unshift(+inherit_state.bgamma);
				this.rfloor.params.unshift(+inherit_state.rfloor);
				this.gfloor.params.unshift(+inherit_state.gfloor);
				this.bfloor.params.unshift(+inherit_state.bfloor);
				this.rceil.params.unshift(+inherit_state.rceil);
				this.gceil.params.unshift(+inherit_state.gceil);
				this.bceil.params.unshift(+inherit_state.bceil);
				
				reset_totaltime();
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
		if(elm.spline == 'true'){
			PreSpline( path, zx, zy);
			moveFunc = SplineMover;
		}else moveFunc = LinearMover;

		// ズーム用関数の設定
		zoomFunc = moveAt;
		
		// 時間が一秒未満だった場合即終了
		if(this.time<=1){
			finish();
			alive = true;
			moving = false;
			return;
		}

		// 初期位置に表示
		if(delay_visible){
			moveFunc(0,0);
		}

		// 開始
		lasttick = starttick = System.getTickCount();
		Offsetlasttick = Offsetstarttick = lasttick;
		
		//System.addContinuousHandler(continuousHandler);
		moving = true;
		alive = true;
	}

	function moveAt( m00, m01, m10, m11, mtx, mty, opa )
	{
		// アフィン変換転送
		if(!MoveColorFlag){
			/*
			targetLayer.face = dfAddAlpha;
			targetLayer.operateAffine(
						tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
						m00, m01, m10, m11, mtx, mty, omAddAlpha, opa, affintype
						);
			*/
			
			targetLayer.operateAffine(
						tempLayer, 0, 0, tempLayer.imageWidth, tempLayer.imageHeight, true,
						m00, m01, m10, m11, mtx, mty, omAuto, opa, affintype
						);
			
		}else{
			targetLayer.operateAffine(
						effecttempLayer, 0, 0, effecttempLayer.imageWidth, effecttempLayer.imageHeight, true,
						m00, m01, m10, m11, mtx, mty, omAuto, opa, affintype
						);
		}
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
			for(var j=0;j<rgamma.count;j++)if(rgamma[j] == "f"+i){function_target[i].add("rgamma["+j+"]");}
			for(var j=0;j<ggamma.count;j++)if(ggamma[j] == "f"+i){function_target[i].add("ggamma["+j+"]");}
			for(var j=0;j<bgamma.count;j++)if(bgamma[j] == "f"+i){function_target[i].add("bgamma["+j+"]");}
			for(var j=0;j<rfloor.count;j++)if(rfloor[j] == "f"+i){function_target[i].add("rfloor["+j+"]");}
			for(var j=0;j<gfloor.count;j++)if(gfloor[j] == "f"+i){function_target[i].add("gfloor["+j+"]");}
			for(var j=0;j<bfloor.count;j++)if(bfloor[j] == "f"+i){function_target[i].add("bfloor["+j+"]");}
			for(var j=0;j<rceil.count;j++)if(rceil[j] == "f"+i){function_target[i].add("rceil["+j+"]");}
			for(var j=0;j<gceil.count;j++)if(gceil[j] == "f"+i){function_target[i].add("gceil["+j+"]");}
			for(var j=0;j<bceil.count;j++)if(bceil[j] == "f"+i){function_target[i].add("bceil["+j+"]");}
			if(fadeInTime == "f"+i){function_target[i].add("fadeInTime");}
			if(fadeOutTime == "f"+i){function_target[i].add("fadeOutTime");}
		}
		*/

		set_FunctionForArray();
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
		for(var i=0;i<rgamma.params.count;i++){this.rgamma.params[i] = +this.rgamma.params[i];}
		for(var i=0;i<ggamma.params.count;i++){this.ggamma.params[i] = +this.ggamma.params[i];}
		for(var i=0;i<bgamma.params.count;i++){this.bgamma.params[i] = +this.bgamma.params[i];}
		for(var i=0;i<rfloor.params.count;i++){this.rfloor.params[i] = +this.rfloor.params[i];}
		for(var i=0;i<gfloor.params.count;i++){this.gfloor.params[i] = +this.gfloor.params[i];}
		for(var i=0;i<bfloor.params.count;i++){this.bfloor.params[i] = +this.bfloor.params[i];}
		for(var i=0;i<rceil.params.count;i++){this.rceil.params[i] = +this.rceil.params[i];}
		for(var i=0;i<gceil.params.count;i++){this.gceil.params[i] = +this.gceil.params[i];}
		for(var i=0;i<bceil.params.count;i++){this.bceil.params[i] = +this.bceil.params[i];}
		this.fadeInTime = +this.fadeInTime;
		this.fadeOutTime = +this.fadeOutTime;
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

		if(_opacity <= 0){_opacity = 0;}
		if(_opacity >= 255){_opacity = 255;}
		
		//現在のポジションの不透明度
		inherit_state["o"] = targetLayer.opacity;
		// 角度・拡大率計算
		
		var r = rad.GetNowParams(tick);
		var s = size.GetNowParams(tick);
		var s_x = xsize.GetNowParams(tick);
		var s_y = ysize.GetNowParams(tick);
		var xsp = xspin.GetNowParams(tick);
		var ysp = yspin.GetNowParams(tick);
		var abs = absolute.GetNowParams(tick);
		
		var c_x = cx.GetNowParams(tick) * tempLayer.imageWidth;
		var c_y = cy.GetNowParams(tick) * tempLayer.imageHeight;

		var r_g;
		var g_g;
		var b_g;
		var r_f;
		var g_f;
		var b_f;
		var r_c;
		var g_c;
		var b_c;

		inherit_state["r"] = r;
		inherit_state["s"] = s;
		inherit_state["s_x"] = s_x;
		inherit_state["s_y"] = s_y;
		inherit_state["xspin"] = xsp;
		inherit_state["yspin"] = ysp;
		inherit_state["absolute"] = abs;

		inherit_state["cx"] = c_x;
		inherit_state["cy"] = c_y;
		
		//色調が変化する時のみ
		if(MoveColorFlag){
			r_g = rgamma.GetNowParams(tick);
            g_g = ggamma.GetNowParams(tick);
            b_g = bgamma.GetNowParams(tick);
            r_f = rfloor.GetNowParams(tick);
            g_f = gfloor.GetNowParams(tick);
            b_f = bfloor.GetNowParams(tick);
            r_c = rceil.GetNowParams(tick);
            g_c = gceil.GetNowParams(tick);
            b_c = bceil.GetNowParams(tick);
			
			if(r_g < 0){r_g = 0;}else if(r_g > 255){r_g = 255;}
			if(g_g < 0){g_g = 0;}else if(g_g > 255){g_g = 255;}
			if(b_g < 0){b_g = 0;}else if(b_g > 255){b_g = 255;}
			if(r_f < 0){r_f = 0;}else if(r_f > 255){r_f = 255;}
			if(g_f < 0){g_f = 0;}else if(g_f > 255){g_f = 255;}
			if(b_f < 0){b_f = 0;}else if(b_f > 255){b_f = 255;}
			if(r_c < 0){r_c = 0;}else if(r_c > 255){r_c = 255;}
			if(g_c < 0){g_c = 0;}else if(g_c > 255){g_c = 255;}
			if(b_c < 0){b_c = 0;}else if(b_c > 255){b_c = 255;}
			
			inherit_state["rgamma"] = r_g;
			inherit_state["ggamma"] = g_g;
			inherit_state["bgamma"] = b_g;
			inherit_state["rfloor"] = r_f;
			inherit_state["gfloor"] = g_f;
			inherit_state["bfloor"] = b_f;
			inherit_state["rceil"] = r_c;
			inherit_state["gceil"] = g_c;
			inherit_state["bceil"] = b_c;
		}

		if(lu_corner){
			l += (tempLayer.imageWidth/2)*s;
			t += (tempLayer.imageHeight/2)*s;
		}else if(pathtype){
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


		if(MoveColorFlag){
			effecttempLayer.assignImages(tempLayer);
			//色調の変更
			if(grayscaleflag)effecttempLayer.doGrayScale();
			if(sepiaflag){
				effecttempLayer.doGrayScale();
				r_g = 1.3;
				g_g = 1.1;
				b_g = 1.0;
			}
			if(turnflag){
				effecttempLayer.adjustGamma(r_g, r_c, r_f, g_g, g_c, g_f, b_g, b_c, b_f);
			}else{
				effecttempLayer.adjustGamma(r_g, r_f, r_c, g_g, g_f, g_c, b_g, b_f, b_c);
			}
		}
		
		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty, _opacity);
	}

	function SplineMover(tick,otick=0)
	{
		
		var index;
		var pindex = (index = tick \ time) * 3;
		var d = tick % time / time;
		var p = path;
		
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
		inherit_state["o"] = targetLayer.opacity;
		
		// 角度・拡大率計算
		var r = rad.GetNowParams(tick);
		var s = size.GetNowParams(tick);
		var s_x = xsize.GetNowParams(tick);
		var s_y = ysize.GetNowParams(tick);
		var xsp = xspin.GetNowParams(tick);
		var ysp = yspin.GetNowParams(tick);
		var abs = absolute.GetNowParams(tick);
		
		var c_x = cx.GetNowParams(tick) * tempLayer.imageWidth;
		var c_y = cy.GetNowParams(tick) * tempLayer.imageHeight;

		var r_g;
		var g_g;
		var b_g;
		var r_f;
		var g_f;
		var b_f;
		var r_c;
		var g_c;
		var b_c;

		inherit_state["r"] = r;
		inherit_state["s"] = s;
		inherit_state["s_x"] = s_x;
		inherit_state["s_y"] = s_y;
		inherit_state["xspin"] = xsp;
		inherit_state["yspin"] = ysp;
		inherit_state["absolute"] = abs;

		inherit_state["cx"] = c_x;
		inherit_state["cy"] = c_y;
		
		//色調が変化する時のみ
		if(MoveColorFlag){
			r_g = rgamma.GetNowParams(tick);
            g_g = ggamma.GetNowParams(tick);
            b_g = bgamma.GetNowParams(tick);
            r_f = rfloor.GetNowParams(tick);
            g_f = gfloor.GetNowParams(tick);
            b_f = bfloor.GetNowParams(tick);
            r_c = rceil.GetNowParams(tick);
            g_c = gceil.GetNowParams(tick);
            b_c = bceil.GetNowParams(tick);
			
			if(r_g < 0){r_g = 0;}else if(r_g > 255){r_g = 255;}
			if(g_g < 0){g_g = 0;}else if(g_g > 255){g_g = 255;}
			if(b_g < 0){b_g = 0;}else if(b_g > 255){b_g = 255;}
			if(r_f < 0){r_f = 0;}else if(r_f > 255){r_f = 255;}
			if(g_f < 0){g_f = 0;}else if(g_f > 255){g_f = 255;}
			if(b_f < 0){b_f = 0;}else if(b_f > 255){b_f = 255;}
			if(r_c < 0){r_c = 0;}else if(r_c > 255){r_c = 255;}
			if(g_c < 0){g_c = 0;}else if(g_c > 255){g_c = 255;}
			if(b_c < 0){b_c = 0;}else if(b_c > 255){b_c = 255;}
			
			inherit_state["rgamma"] = r_g;
			inherit_state["ggamma"] = g_g;
			inherit_state["bgamma"] = b_g;
			inherit_state["rfloor"] = r_f;
			inherit_state["gfloor"] = g_f;
			inherit_state["bfloor"] = b_f;
			inherit_state["rceil"] = r_c;
			inherit_state["gceil"] = g_c;
			inherit_state["bceil"] = b_c;
		}

		if(pathtype == "true"){
			// pathで指定するのは画面の中心に画像のどこのピクセルをを持ってくるか
			l = imageWidthHalf  + (imageWidthHalf-l)*s  - (imageWidthHalf-c_x)*s;
			t = imageHeightHalf + (imageHeightHalf-t)*s - (imageHeightHalf-c_y)*s;
		}else{
			// pathで指定するのは画像における中心を画面のどこに置くか
			l -= (tempLayer.imageWidth/2-c_x)*s;
			t -= (tempLayer.imageHeight/2-c_y)*s;
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

		if(MoveColorFlag){
			effecttempLayer.assignImages(tempLayer);
			//色調の変更
			if(grayscaleflag)effecttempLayer.doGrayScale();
			if(sepiaflag){
				effecttempLayer.doGrayScale();
				r_g = 1.3;
				g_g = 1.1;
				b_g = 1.0;
			}
			if(turnflag){
				effecttempLayer.adjustGamma(r_g, r_c, r_f, g_g, g_c, g_f, b_g, b_c, b_f);
			}else{
				effecttempLayer.adjustGamma(r_g, r_f, r_c, g_g, g_f, g_c, b_g, b_f, b_c);
			}
		}
		
		// 移動
		zoomFunc(m00, m01, m10, m11, mtx, mty, _opacity);
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
				delay = 0;
				lasttick = starttick = System.getTickCount();
				moveFunc(0,0);
			}
			
			if(delay_visible == false){
				return;
			}else{
				moveFunc(0,0);
				return;
			}
			
			//return;
		}

		//再計算
		Offsettick = tick;
		Offsetlasttick = Offsettick;
		Offsettick -= Offsetstarttick;

		if(Offsettick > OffsetDelay){
			Offsettick -= OffsetDelay;
			if(Offsettick >= OffsettotalTime){
				if(Offsetloop && OffsetloopCount != 0){
					if(OffsetloopCount >= 0){ OffsetloopCount--;}
					Offsetstarttick = Offsetstarttick + OffsettotalTime + OffsetDelay;
					Offsettick = Offsettick - OffsettotalTime - OffsetDelay;
					//ここを修正
					
				}else{
					Offsettick = OffsettotalTime;
				}
			}
		}else{
			Offsettick = 0;
		}
		
		lasttick=tick;
		tick -= starttick;

		
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
				// spmode
				if(spmode){
					var __x = intrandom(50,1230);
					var __y = intrandom(50,690);
					
					path[0] = __x;
					path[1] = __y;
					path[3] = __x+intrandom(-50,50);
					path[4] = __y+intrandom(-50,50);
					
					size.params[0] = 0;
					size.params[1] = (intrandom(8,15)/10);
					xspin.params[0] = 0;
					xspin.params[1] = intrandom(1,5)/10;
					yspin.params[0] = 0;
					yspin.params[1] = intrandom(1,5)/10;

					time = intrandom((int)(SaveValue[1]),(int)(SaveValue[0]));
					reset_totaltime();
				}
				if(spmode2){
					var __np = (System.getTickCount()-spmst)/5000;
					if(__np > 1)__np = 1;
					if(spmd_rev){
						path[0] = 317;
						path[1] = 716;
						path[3] = intrandom(0,1280);
						path[4] = intrandom(0,720);
					}else{
						path[0] = intrandom(0,1280);
						path[1] = intrandom(0,720);
						path[3] = 317;
						path[4] = 716;
					}
					var rate = (tick/totalTime);
					size[0] = 1;
					size[1] = Math.random()-0.5;
				}
				
				if(function_group.count != 0){
					set_FunctionForArray();
				}
				if(moveFunc == SplineMover){
					PreSpline(path, zx, zy);
				}
				
				
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
					rgamma.params.shift();
					ggamma.params.shift();
					bgamma.params.shift();
					rfloor.params.shift();
					gfloor.params.shift();
					bfloor.params.shift();
					rceil.params.shift();
					gceil.params.shift();
					bceil.params.shift();
					reset_totaltime();
					if(moveFunc == SplineMover){
						PreSpline(path, zx, zy);
					}
					inherit = false;
					//starttick = starttick + time;
				}
				reset_totaltime();
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
			tick = int ( (1.0 - tick) * totalTime);
		}
		else if(accel > 0)
		{
			// 下弦 ( 最初は動きが遅く、徐々に早くなる )
			tick = tick / totalTime;
			tick = Math.pow(tick, accel);
			tick = int ( tick * totalTime );
		}

		// 移動
		moveFunc(tick,Offsettick);
	}

	// 最終状態を表示
	function finish()
	{
		moveFunc(totalTime,OffsettotalTime);
		if(!timeOutDraw)stop();
	}

	// 停止
	function stop()
	{
		if(moving)moving = false;
	}

	// レイヤーを削除
	function deleteLayer()
	{
		alive = false;
		stop();
		invalidate tempLayer if tempLayer !== void;
		tempLayer = void;
	}

	function clearLayer()
	{
		alive = false;
		stop();
		tempLayer.loadImages("ImgClear");
		tempLayer.setSizeToImageSize();
	}

	function onStore(f, elm)
	{
		if(alive){
			var dic = f["leff" + obj_no] = %[];
			(Dictionary.assign incontextof dic)(storeDic);
			dic.moving = moving;
		}else{
			f["leff" + obj_no] = void;
		}
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		stop(); // 動作を停止
		clearLayer();	// 削除
		var dic = f["leff" + obj_no];
		if(dic !== void){
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
		}

	}
}

function DrawObj_Area_change(mp){
	for(var i = +mp.astart;i < +mp.aend;i++){
		mp.obj=i;
		light_eff_object.DrawObj_inherit_change(mp);
	}
}

function DrawObj_All_change(mp){
	for(var i=0;i<light_eff_object.drawObj.count;i++){
		mp.obj=i;
		light_eff_object.DrawObj_inherit_change(mp);
	}
}

function Draw_leff_fo(elm){
	var mp = new Dictionary();
	(Dictionary.assign incontextof mp)(elm);
	for(var i=0; i<elm.max; i++){
		(Dictionary.assign incontextof elm)(mp);
		light_eff_object.addDrawObj(elm);
	}
	invalidate mp;
}

function safe()
{
    for(var i=0;i<63;i++)
    {
        Scripts.eval("%d".sprintf(i));
    }
}

function leffSaveLayer(){
	if(light_eff_object.main.visible){
		light_eff_object.main.saveLayerImage(System.exePath+"front.bmp","bmp");
	}
	if(light_eff_object.main2.visible){
		light_eff_object.main2.saveLayerImage(System.exePath+"back.bmp","bmp");
	}
}

kag.addPlugin(global.light_eff_object = new LightEffectPlugin());

@endscript
@endif
;----------------------------------------------------
; マクロ登録
;----------------------------------------------------
; eff追加
@macro name="leff_add"
@eval exp="light_eff_object.addDrawObj(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="leff_add_num"
@eval exp="for(var i=0; i<mp.num; i++)light_eff_object.addDrawObj(mp)"
@eval exp="setCgVer(mp.storage)"
@endmacro

; 即時開始
;	intime	：フェードイン時間
;	outtime	：フェードアウト時間
;	time	：全体時間、時間過ぎると勝手に止まる。設定無ければ止まらない
@macro name="leff"
@eval exp="light_eff_object.start(mp, false)"
@endmacro
; 次のトランジションにあわせて開始
@macro name="leff_back"
@eval exp="light_eff_object.start(mp, true)"
@endmacro

; 即時停止
@macro name="osleff"
@eval exp="light_eff_object.obj_obj_finish(mp);"
@endmacro

; 即時停止
@macro name="asleff"
@eval exp="light_eff_object.obj_all_finish(mp);"
@endmacro

; 即時停止
@macro name="sleff"
@eval exp="light_eff_object.stop()"
@endmacro
; 即時停止
@macro name="sleff2"
@eval exp="light_eff_object.stop2()"
@endmacro
; トランジション後停止
@macro name="sleff_back"
@eval exp="light_eff_object.readyStop()"
@endmacro
; 時間が設定されている場合のみ終了待ち
@macro name="wleff"
@waittrig * name="leff" onskip="light_eff_object.stop()" canskip=%canskip|true cond="light_eff_object.alive && light_eff_object.time != -1"
@endmacro

@macro name="leff_fo"
;@eval exp="for(var i=0; i<mp.max; i++)light_eff_object.addDrawObj(mp)"
;@eval exp="setCgVer(mp.storage)"
@eval exp="safe()"
@eval exp="Draw_leff_fo(mp)"
@leff_back mode=%mode|alpha absolute=%c_absolute|15000 cond="mp.stock != 'true'"
@extrans method=crossfade time=100 cond="mp.stock != 'true'"
@endmacro


@macro name="gather_leff"
@eval exp="mp.inherit = 'true'"
@eval exp="mp.inherit_storage = 'true'"
@eval exp="for(var i=0; i<mp.max; i++)mp.obj = i,light_eff_object.DrawObj_change(mp)"
@endmacro
; エフェクト残り時間を再設定
;@macro name="eff_time_reset"
;@eval exp="effect_object[+mp.obj].timeReset(+mp.time)" cond="mp.time !== void"
;@endmacro

; エフェクトをキャプチャして吐き出す
@macro name="leffSaveLayer"
@eval exp="leffSaveLayer()"
@endmacro

; エフェクトを途中で書き換える
@macro name="leff_change"
@eval exp="light_eff_object.DrawObj_change(mp)"
@endmacro

@macro name="leff_change_all"
@eval exp="DrawObj_All_change(mp);"
@endmacro

@macro name="leff_change_area"
@eval exp="DrawObj_Area_change(mp);"
@endmacro


@return

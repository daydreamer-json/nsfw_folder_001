
@iscript

class ImageArray{
	var storage = [];		//データ配列
	var params = [];		//データ配列
	var time;				//一コマあたりの時間

	//コンストラクタ
	function ParamsArray(){ fluctuate = false;}

	//デストラクタ
	function finalize(){
		clear();
	}
	
	//初期化
	function clear(){
		storage.clear();	//
		params.clear();		//配列を初期化
		time = 1;			//
	}

	//要素を引き出す物
	function GetStorageList()
	{
		return storage;
	}
	
	//要素を引き出す物
	function GetNowParams(tick)
	{
		var ParamsIndex = (int)(tick / time);
		if(ParamsIndex < params.count){
			return params[ParamsIndex];
		}else{
			return params[params.count-1];
		}
	}
	
	//自身の配列間の時間を確認
	function TimeForParams(totalTime){
		time = totalTime / (params.count-1);
		if(time<=1) time = 1;
		if(time>=totalTime) time = totalTime;
	}

	//配列の格納
	function ArrayForParams(e_array){
		if(e_array !== void){
			var tmp = [].split("(), ", e_array, , true);
			if(tmp.count != 1){
				storage.add(tmp[0]);
				params.add(0);
				var totalCnt = 1;
				for(var i = 1; i < tmp.count; i++){
					var addFlag = true;
					for(var j = 0; j < totalCnt; j++){
						if(tmp[j] == tmp[i]){
							params.add(j);
							addFlag = false;
							break;
						}
					}
					
					if(addFlag){
						storage.add(tmp[i]);
						params.add(totalCnt);
						totalCnt++;
					}
				}
				params.add(params[params.count - 1]);
				/*
				for(var i = 0; i < params.count; i++){
					dm(":"+params[i]);
				}
				*/
			}else{
				storage.add(tmp[0]);
				params = [0,0];
			}
			tmp.clear();
		}else{
			storage.add("black");
			params = [0,0];
		}
	}
}


class ParamsArray{
	var params = [];		//データ配列
	var time;				//一コマあたりの時間
	var standerd;
	var fluctuate;			//変動処理があるかないか
	//var processing;			// 特殊処理系

	//コンストラクタ
	function ParamsArray(std){
		standerd = std;
		//processing = false;
	}

	//デストラクタ
	function finalize(){
		clear();
	}
	
	//初期化
	function clear(){
		params.clear();		//配列を初期化
		time = 1;			//
	}
	
	//要素を引き出す物
	function GetNowParams(tick)
	{
		if(!fluctuate) return params[0];
		
		var ParamsIndex = (int)(tick / time);
		if(ParamsIndex < params.count){
			var ParamsRatio = (tick - (ParamsIndex*time))/ time;
			var n_s = (params[ParamsIndex+1] - params[ParamsIndex])*ParamsRatio + params[ParamsIndex];
			return n_s;
		}else{
			return params[params.count-1];
		}
	}

	function IsFluctuate(){
		var p0 = params[0];
		fluctuate = false;
		for(var i = 1; i < params.count; i++){
			if(p0 != params[i]){
				fluctuate = true;
				return true;
			}
		}
		//processing = false;
		return false;
	}
	
	//自身の配列間の時間を確認
	function TimeForParams(totalTime){
		time = totalTime / (params.count-1);
		if(time<=1) time = 1;
		if(time>=totalTime) time = totalTime;
		IsFluctuate();
	}

	//配列の格納
	function ArrayForParams(e_array,sd = void,dd = void){
		if(sd === void && dd === void && e_array !== void){
			params = [].split("(), ", e_array, , true);
			if(params.count != 1){
				for(var i = params.count-1; i>=0; i--)params[i] = (+params[i]);
			}else{
				params = [(+params[params.count-1]),(+params[params.count-1])];
			}
		}else if(sd !== void || dd !== void){
			var _sd = (sd !== void) ? +sd : standerd;
			var _dd = (dd !== void) ? +dd : standerd;
			params = [ _sd, _dd];
		}else params = [standerd,standerd];
	}

	function AddArrayForParams(unit){
		params.add(unit);
	}

	//最大の値の取得
	function maximum()
	{
		var max = params[0];
		if(!fluctuate) return max;
		for(var i = 1; i < params.count; i++){
			if(max < params[i]) max = params[i];
		}
		return max;
	}

	//最小の値の取得
	function minimum()
	{
		var min = params[0];
		if(!fluctuate) return min;
		for(var i = 1; i < params.count; i++){
			if(min > params[i]) min = params[i];
		}
		return min;
	}
}


function cutindataReader(file,i)
{
	var file = [].load(file);
	var data = file[i].split(/\t/,,false);
	return data;
}

class CutinPiledLayer extends Layer
{
	//var delay;							//
	var w;								//レイヤサイズ幅
	var h;								//レイヤサイズ高さ
	var wh;								//レイヤサイズ幅 / 2
	var hh;								//レイヤサイズ高さ / 2

	var cl;								//基本レイヤ座標移動用
	var ct;								//基本レイヤ座標移動用
	var cw;								//基本レイヤ座標移動用
	var ch;								//基本レイヤ座標移動用
	var cwh;							//基本レイヤ座標移動用
	var chh;							//基本レイヤ座標移動用
	var activ;							//レイヤの動作中かどうか【レイヤを合成するかどうか】
	var cmactiv;						//カットインレイヤのムーブが終了しているか
	var caactiv;						//カットインレイヤのアニメが終了しているか
	var mmactiv;						//メインインレイヤのムーブが終了しているか
	var maactiv;						//メインインレイヤのアニメが終了しているか
	var lmactiv;						//ラインインレイヤのムーブが終了しているか
	var laactiv;						//ラインインレイヤのアニメが終了しているか
	var owner = void;					//親
	
	var cutinLayer;						//大本レイヤ		単数
	var cutinmovedata = [];				//baseデータ保管用【move】
	var cutinanmata = [];				//baseデータ保管用【anm】
	var mainLayer = [];					//総合レイヤ		複数
	var mainmovedata = [];				//mainデータ保管用【move】
	var mainanmdata = [];				//mainデータ保管用【anm】
	var lineLayer = [];					//ラインレイヤ		複数
	var linemovedata = [];				//lineデータ保管用【move】
	var lineanmdata = [];				//lineデータ保管用【anm】

	//アクセル
	var skip_interval;					//ディレイ代わり
	var skip_count;						//ディレイ代わり

	var storeDic = %[];					//内部書き換え辞書配列
	
	function CutinPiledLayer(win, par, storage)
	{
		super.Layer(...);
	}

	function AddEffect(lay,elm){
	}
	
	function finalize(){
		clear();
		super.finalize(...);
	}
	
	function loadImages(elm = %[])
	{
		// 辞書配列をセーブ・ロード用に退避
		(Dictionary.clear incontextof storeDic)();
		storeDic.cutin = elm.cutin;
		storeDic.main = elm.main;
		storeDic.line = elm.line;
		
		activ = true;		//とまる
		w = kag.scWidth;	//
		h = kag.scHeight;
		wh = w\2;
		hh = h\2;
		skip_count = 0;
		skip_interval = 0;
		cmactiv = false;
		caactiv = false;
		mmactiv = false;
		maactiv = false;
		lmactiv = false;
		laactiv = false;
		
		if(cutinLayer === void){
			cutinLayer = new global.Layer(window, this);
			var ct = [].split("(),", elm.cutin, , true);
			if(ct[0] !== void){
				cutinLayer.loadImages("black");
				cutinmovedata.clear();
				var cf = +ct[0];
				var ccs =  -(+ct[1]);												//スキップコマ					move_count_start
				var cs_w = (+ct[3]) * cutinLayer.imageWidth;
				var cs_h = (+ct[4]) * cutinLayer.imageHeight;
				var cv1_x = (+ct[5] - +ct[3]) / cf * cutinLayer.imageWidth / 2;
				var cv1_y = (+ct[6] - +ct[4]) / cf * cutinLayer.imageHeight / 2;
				if(cv1_x == 0 && cv1_y == 0){
					cutinmovedata = [ false, ccs, cf, cs_w, cs_h, 0, 0, +ct[2]];
				}else{
					cutinmovedata = [ true, ccs, cf, cs_w, cs_h, -cv1_x, -cv1_y, +ct[2]];
					cmactiv = true;
				}
				//dm("cmactiv:"+cmactiv);
				cw = cutinmovedata[3];
				ch = cutinmovedata[4];
				cwh = cw\2;
				chh = ch\2;
				cl = wh - cwh;
				ct = hh - chh;
				cutinLayer.setPos(cl,ct);
				cutinLayer.setSize(cw,ch);
				cutinLayer.visible = true;
			}else{
				//ct = (x_size,y_size,x_size,y_size)
				
			}

			var mtemp = [].split("[]", elm.main, , true);
			for(var i=0;i<mtemp.count;i++){
				//mt = [(name, move_frame, skipframe, accel, anm, anm_frame)(move【2点】)]
				//ムーブ
				mainLayer.add(new global.CharacterLayer(window, cutinLayer));
				var mt = [].split("()", mtemp[i], , true);								//メインレイヤの１枚に対しての動作集合体
				var mt1 = [].split(",", mt[0], , true);									//メインレイヤの基本動作
				var mt2 = [].split(",", mt[1], , true);									//メインレイヤの動作情報
				for(var j=0;j<mt2.count;j++){mt2[j] = +mt2[j];}
				mainLayer[i].loadImages(%[storage:mt1[0]]);
				mainLayer[i].setSizeToImageSize();
				var mw = mainLayer[i].imageWidth;
				var mh = mainLayer[i].imageHeight;
				var mcs =  -(+mt1[2]);													//スキップコマ					move_count_start
				var accel = +mt1[3];													//加速度						accel
				//ムーブ
				if(mt2 !== void){
					if(mt2[0] != mt2[3] || mt2[1] != mt2[4] || mt2[2] != mt2[5]){
						var mcm = (+mt1[1] > 0) ? +mt1[1] : 0;												//最大コマ数					move_count_max
						var mv1_x = (mt2[3] - mt2[0]) / +mcm;												//一コマの移動値				move_1_x
						var mv1_y = (mt2[4] - mt2[1]) / +mcm;												//一コマの移動値				move_1_y
						var mv1_o = (mt2[5] - mt2[2]) / +mcm;												//一コマの移動値				move_1_o
						mainmovedata.add([true,mcs,mcm,mt2[0],mt2[1],mt2[2],mv1_x,mv1_y,mv1_o,accel]);		//[自身の番号,現在コマ,最大コマ数,初位置_X,初位置_Y,初不透明,移動値_X,移動値_Y,移動値_不透明,加速度]
						mmactiv = true;
					}else{
						mainmovedata.add([false,0,9,mt2[0],mt2[1],mt2[2],0,0,0,0]);
					}
				}else{
					mainmovedata.add([false,0,9,640,360,255,0,0,0,0]);
				}
				mainLayer[i].opacity = mainmovedata[i][5];
				
				//アニメーション
				if(mt1[4] != "-1"){
					//基本動作とアニメーションを後回し
					/*
					var d_cma = cutindataReader("anm.cma",+mt1[4]);									//カットイン線用アニメーションデータ	data_cutin_main_animetion
					mainLayer[i].setSize(+d_cma[0],+d_cma[1]);
					mainLayer[i].setImagePos(+d_cma[2],+d_cma[3]);
					var acm = (+mt1[5] > 0) ? +mt1[5] : 0;											//最大コマ数		anm_count_max
					var mv1_x = (+d_cma[4] - +d_cma[2]) / +acm;										//一コマの移動値	move_1_x
					var mv1_y = (+d_cma[5] - +d_cma[3]) / +acm;										//一コマの移動値	move_1_y
					mainanmdata.add([true,0,acm,+d_cma[2],+d_cma[3],mv1_x,mv1_y]);					//[自身の番号,現在コマ,最大コマ数,初位置_X,初位置_Y,移動値_X,移動値_Y]
					mainmovedata[i][3] -= (+d_cma[0]\2);
					mainmovedata[i][4] -= (+d_cma[1]\2);
					maactiv = true;*/
					var d_cma;
					d_cma = [0,0,0,0,0,0];
					if(Storages.isExistentStorage(Storages.chopStorageExt(mt1[0]) + ".asd")){
						//クリップデータの保存
						var file = [].load(Storages.chopStorageExt(mt1[0]) + ".asd");
						var anmdata = file[0].split(" ;/=",,true);
						for(var i=0;i<anmdata.count;i++){
							if(anmdata[i] == "clipwidth"){d_cma[0] = anmdata[i+1];}
							if(anmdata[i] == "clipHeight"){d_cma[1] = anmdata[i+1];}
						}
						anmdata.clear();
					}else{
						//無い場合
						if(mainLayer[i].imageWidth > w){d_cma[0] = w;}else{d_cma[0] = mainLayer[i].imageWidth;}
						if(mainLayer[i].imageHeight > h){d_cma[1] = h;}else{d_cma[1] = mainLayer[i].imageHeight;}
					}

					switch(+mt1[4]){
						case 0:{ d_cma[2] = 0; d_cma[3] = d_cma[1] - mainLayer[i].imageHeight; d_cma[4] = 0; d_cma[5] = 0; break;}	//top:
						case 1:{ d_cma[2] = 0; d_cma[3] = 0; d_cma[4] = 0; d_cma[5] = d_cma[1] - mainLayer[i].imageHeight; break;}	//buttom:
						case 2:{ d_cma[2] = d_cma[0] - mainLayer[i].imageWidth; d_cma[3] = 0; d_cma[4] = 0; d_cma[5] = 0; break;}	//left:
						case 3:{ d_cma[2] = 0; d_cma[3] = 0; d_cma[4] = d_cma[0] - mainLayer[i].imageWidth; d_cma[5] = 0; break;}	//right:
					}
					
					mainLayer[i].setSize(+d_cma[0],+d_cma[1]);
					mainLayer[i].setImagePos(+d_cma[2],+d_cma[3]);
					var acm = (+mt1[5] > 0) ? +mt1[5] : 0;											//最大コマ数		anm_count_max
					var mv1_x = (+d_cma[4] - +d_cma[2]) / +acm;										//一コマの移動値	move_1_x
					var mv1_y = (+d_cma[5] - +d_cma[3]) / +acm;										//一コマの移動値	move_1_y
					mainanmdata.add([true,0,acm,+d_cma[2],+d_cma[3],mv1_x,mv1_y,+mt1[4]]);					//[自身の番号,現在コマ,最大コマ数,初位置_X,初位置_Y,移動値_X,移動値_Y]
					//if(+mt1[1]>1){mainmovedata[i][3] -= (+d_cma[0]\2);}else{mainmovedata[i][4] -= (+d_cma[1]\2);}
					mainmovedata[i][3] -= (+d_cma[0]\2);
					mainmovedata[i][4] -= (+d_cma[1]\2);
					maactiv = true;
					d_cma.clear();
				}else{
					mainanmdata.add([false,0,0,mw,mh,0,0,-1]);
					mainLayer[i].setSizeToImageSize();
					mainmovedata[i][3] -= (mw\2);
					mainmovedata[i][4] -= (mh\2);
				}
				mainLayer[i].setPos(mainmovedata[i][3]-cl,mainmovedata[i][4]-ct);
				mainLayer[i].visible = true;
			}
			
			//引数(読み込み画像,move方法番号,moveコマ数,anm番号,anmコマ数) * n
			var ltemp = [].split("()", elm.line, , true);
			for(var i=0;i<ltemp.count;i++){
				lineLayer.add(new global.CharacterLayer(window, this));
				var lt = [].split(",", ltemp[i], , true);
				lineLayer[i].loadImages(%[storage:lt[0]]);
				
				var lw = lineLayer[i].imageWidth;
				var lh = lineLayer[i].imageHeight;
				//ムーブ
				if(lt[1] != "-1"){
					var lf = cutinmovedata[1];										//スタートコマ数				move_count_max
					var mcm = cutinmovedata[2];										//最大コマ数					move_count_max
					var mv1_x = cutinmovedata[5];									//一コマの移動値				move_1_x
					var mv1_y = cutinmovedata[6];									//一コマの移動値				move_1_y
					var mc_add_l = 0;
					var mc_add_t = 0;
					if(lt[1] != void){
						switch(+lt[1]){
							case 0:{ mv1_x = 0; mv1_y = mv1_y; break;}						//top:
							case 1:{ mv1_x = 0; mv1_y = -mv1_y; mc_add_t = ch; break;}		//buttom:
							case 2:{ mv1_x = mv1_x; mv1_y = 0; break;}						//left:
							case 3:{ mv1_x = -mv1_x; mv1_y = 0; mc_add_l = cw; break;}		//right:
						}
					}
					
					linemovedata.add([true,lf,mcm,cl+mc_add_l,ct+mc_add_t,mv1_x,mv1_y,cutinmovedata[7],lt[1]]);		//[自身の番号,現在コマ,最大コマ数,初位置_X,初位置_Y,移動値_X,移動値_Y,アクセル,配置情報]
					lmactiv = true;
				}else{
					linemovedata.add([false,0,0,0,0,0,0,-1]);
				}
				
				//アニメーション
				if(lt[2] != "-1"){
					var d_cla;
					d_cla = [0,0,0,0,0,0];
					if(Storages.isExistentStorage(Storages.chopStorageExt(lt[0]) + ".asd")){
						//クリップデータの保存
						var file = [].load(Storages.chopStorageExt(lt[0]) + ".asd");
						var anmdata = file[0].split(" ;/=",,true);
						for(var i=0;i<anmdata.count;i++){
							if(anmdata[i] == "clipwidth"){d_cla[0] = anmdata[i+1];}
							if(anmdata[i] == "clipHeight"){d_cla[1] = anmdata[i+1];}
						}
						anmdata.clear();
					}else{
						//無い場合
						if(lineLayer[i].imageWidth > w){d_cla[0] = w;}else{d_cla[0] = lineLayer[i].imageWidth;}
						if(lineLayer[i].imageHeight > h){d_cla[1] = h;}else{d_cla[1] = lineLayer[i].imageHeight;}
					}

					switch(+lt[2]){
						case 0:{ d_cla[2] = 0; d_cla[3] = d_cla[1] - lineLayer[i].imageHeight; d_cla[4] = 0; d_cla[5] = 0; break;}	//top:
						case 1:{ d_cla[2] = 0; d_cla[3] = 0; d_cla[4] = 0; d_cla[5] = d_cla[1] - lineLayer[i].imageHeight; break;}	//buttom:
						case 2:{ d_cla[2] = d_cla[0] - lineLayer[i].imageWidth; d_cla[3] = 0; d_cla[4] = 0; d_cla[5] = 0; break;}	//left:
						case 3:{ d_cla[2] = 0; d_cla[3] = 0; d_cla[4] = d_cla[0] - lineLayer[i].imageWidth; d_cla[5] = 0; break;}	//right:
					}
					
					lineLayer[i].setSize(+d_cla[0],+d_cla[1]);
					lineLayer[i].setImagePos(+d_cla[2],+d_cla[3]);
					var acm = (+lt[3] > 0) ? +lt[3] : 0;											//最大コマ数		anm_count_max
					var mv1_x = (+d_cla[4] - +d_cla[2]) / +acm;										//一コマの移動値	move_1_x
					var mv1_y = (+d_cla[5] - +d_cla[3]) / +acm;										//一コマの移動値	move_1_y
					lineanmdata.add([true,0,acm,+d_cla[2],+d_cla[3],mv1_x,mv1_y,+lt[2]]);			//[自身の番号,現在コマ,最大コマ数,初位置_X,初位置_Y,移動値_X,移動値_Y]
					if(+lt[1]>1){linemovedata[i][3] -= (+d_cla[0]\2);}else{linemovedata[i][4] -= (+d_cla[1]\2);}
					laactiv = true;
					d_cla.clear();
				}else{
					lineanmdata.add([false,0,0,lw,lh,0,0,-1]);
					lineLayer[i].setSizeToImageSize();
					if(+lt[1]>1){linemovedata[i][3] -= (lw\2);}else{linemovedata[i][4] -= (lh\2);}
				}
				lineLayer[i].setPos(linemovedata[i][3],linemovedata[i][4]);
				lineLayer[i].visible = true;
			}
			activ_flag();
			if(elm.cutin_end){
				stop_move();
			}
			if(elm.skip_interval !== void){skip_interval = +elm.skip_interval;}
			setImageSize(w, h);
			setSizeToImageSize();
			type = ltAlpha;
			face = dfAlpha;
			fillRect(0,0,width,height,0x0);
			
			if(elm.emain != void){
				var emtemp = [].split("[]", elm.emain, , true);
				var rgb;
				for(var i=0;i<emtemp.count;i++){
					//(fliplr,flipud,効果)
					var emt = void;
					var femt;
					emt = [].split("()", emtemp[i], , true);					//メインレイヤの効果
					var tel = +emt[0];
					rgb = [1,1,1,0,0,0,255,255,255];
					//ターゲットレイヤ
					for(var j=1;j<emt.count;j++){
						femt = [].split(",", emt[j], , true);					//メインレイヤの効果
						if(femt[0] == "grayscale"){mainLayer[tel].doGrayScale();}
						if(femt[0] == "sepia"){mainLayer[tel].doGrayScale();rgb[0]=1.3;rgb[1]=1.1;rgb[2]=1.0;}
						if(femt[0] == "lr"){mainLayer[tel].flipLR();}
						if(femt[0] == "ud"){mainLayer[tel].flipUD();}
						if(femt[0] == "rgamma"){ rgb[0]=+femt[1];}
						if(femt[0] == "ggamma"){ rgb[1]=+femt[1];}
						if(femt[0] == "bgamma"){ rgb[2]=+femt[1];}
						if(femt[0] == "rfloor"){ rgb[3]=+femt[1];}
						if(femt[0] == "gfloor"){ rgb[4]=+femt[1];}
						if(femt[0] == "bfloor"){ rgb[5]=+femt[1];}
						if(femt[0] == "rceil"){ rgb[6]=+femt[1];}
						if(femt[0] == "gceil"){ rgb[7]=+femt[1];}
						if(femt[0] == "bceil"){ rgb[8]=+femt[1];}
						if(femt[0] == "gamma"){ rgb[0]=+femt[1]; rgb[1]=+femt[2]; rgb[2]=+femt[3];}
						if(femt[0] == "floor"){ rgb[3]=+femt[1]; rgb[4]=+femt[2]; rgb[5]=+femt[3];}
						if(femt[0] == "ceil"){ rgb[6]=+femt[1]; rgb[7]=+femt[2]; rgb[8]=+femt[3];}
						if(femt[0] == "red"){ rgb[0]=+femt[1]; rgb[3]=+femt[2]; rgb[6]=+femt[3];}
						if(femt[0] == "green"){ rgb[1]=+femt[1]; rgb[4]=+femt[2]; rgb[7]=+femt[3];}
						if(femt[0] == "blue"){ rgb[2]=+femt[1]; rgb[5]=+femt[2]; rgb[8]=+femt[3];}
						if(femt[0] == "color"){ rgb[0]=+femt[1]; rgb[1]=+femt[2]; rgb[2]=+femt[3]; rgb[3]=+femt[4]; rgb[4]=+femt[5]; rgb[5]=+femt[6]; rgb[6]=+femt[7]; rgb[7]=+femt[8]; rgb[8]=+femt[9];}
						if(femt[0] == "turn"){
							var temp = rgb[3]; rgb[3]=rgb[6]; rgb[6]=temp;
							temp=rgb[4]; rgb[4]=rgb[7]; rgb[7]=temp;
							temp=rgb[5]; rgb[5]=rgb[8]; rgb[8]=temp;
						}
						if(femt[0] == "bblur"){
							if(femt[3] !== void){
								if(femt[3] == "true"){
									var bb_temp  = new CharacterLayer(kag, kag.fore.base);
									var bbx = (+femt[1]*2);
									var bby = (+femt[2]*2);
									bb_temp.assignImages(mainLayer[tel]);
									bb_temp.setImageSize(bb_temp.imageWidth+bbx, bb_temp.imageHeight+bby);
									bb_temp.setSize(bb_temp.width,bb_temp.height);
									bb_temp.fillRect(0,0,bb_temp.imageWidth,bb_temp.imageHeight,0x0);
									bb_temp.copyRect(+femt[1],+femt[2],mainLayer[tel],0,0,mainLayer[tel].imageWidth,mainLayer[tel].imageHeight);
									mainLayer[tel].assignImages(bb_temp);
									if(mainanmdata[tel][7] != -1){
										if(mainanmdata[tel][7] == 3){
											mainanmdata[tel][3] = -(+femt[1]);//+3
											mainLayer[tel].setImagePos(mainanmdata[tel][3],mainanmdata[tel][4]);
										}
										if(mainanmdata[tel][7] == 1){
											mainanmdata[tel][4] = -(+femt[2]);
											mainLayer[tel].setImagePos(mainanmdata[tel][3],mainanmdata[tel][4]);
										}
									}
									//mainmovedata[tel][3] -= +femt[1];
									//mainmovedata[tel][4] -= +femt[2];
									invalidate bb_temp;
								}
							}
							mainLayer[tel].doBoxBlur((int)+femt[1], (int)+femt[2]);
							if(femt[4] !== void){ if(femt[4] == "true"){mainLayer[tel].doBoxBlur((int)+femt[1], (int)+femt[2]);}}
						}
						
						if(femt[0] == "size"){
							var s_temp  = new CharacterLayer(kag, kag.fore.base);
							var _sx = mainLayer[tel].imageWidth;
							var _sy = mainLayer[tel].imageHeight;
							var tsx = +femt[1];
							var tsy = +femt[2];
							var sx = tsx * _sx;
							var sy = tsy * _sy;
							var stype = stFastLinear;
							if(femt[3] !== void){
								if(+femt[3] == 0){stype = stNearest;}
								if(+femt[3] == 2){stype = stLinear;}
								if(+femt[3] == 3){stype = stCubic;}
							}
							
							s_temp.setImageSize(sx,sy);
							s_temp.setSize(mainLayer[tel].width,mainLayer[tel].height);
							s_temp.stretchCopy(0,0,sx,sy,mainLayer[tel],0,0,_sx,_sy,stype);
							mainLayer[tel].assignImages(s_temp);
							invalidate s_temp;

							if(mainanmdata[tel][0]){
								mainanmdata[tel][3] = mainanmdata[tel][3] * tsx;
								mainanmdata[tel][4] = mainanmdata[tel][4] * tsy;
								mainanmdata[tel][5] = mainanmdata[tel][5] * tsx;
								mainanmdata[tel][6] = mainanmdata[tel][6] * tsy;
								setImagePos(mainanmdata[tel][3],mainanmdata[tel][4]);
							}else{
								mainLayer[tel].setSizeToImageSize();
							}
							
							mainmovedata[tel][3] -= (sx - _sx)\2;
							mainmovedata[tel][4] -= (sy - _sy)\2;
							mainLayer[tel].setPos(mainmovedata[tel][3]-cl,mainmovedata[tel][4]-ct);
							
						}
						femt.clear();
					}
					mainLayer[tel].adjustGamma(rgb[0],rgb[3],rgb[6],rgb[1],rgb[4],rgb[7],rgb[2],rgb[5],rgb[8]);
					rgb.clear();
				}
			}
			
			if(elm.eline != void){
				var eltemp = [].split("[]", elm.eline, , true);
				for(var i=0;i<eltemp.count;i++){
					//(fliplr,flipud,効果)
					var elt = void;
					var felt;
					var rgb;
					elt = [].split("()", eltemp[i], , true);					//メインレイヤの効果
					var tel = +elt[0];
					//ターゲットレイヤ
					rgb = [1,1,1,0,0,0,255,255,255];
					for(var j=1;j<elt.count;j++){
						felt = [].split(",", elt[j], , true);					//メインレイヤの効果
						if(felt[0] == "grayscale"){lineLayer[tel].doGrayScale();}
						if(felt[0] == "sepia"){lineLayer[tel].doGrayScale();rgb[0]=1.3;rgb[1]=1.1;rgb[2]=1.0;}
						if(felt[0] == "lr"){lineLayer[tel].flipLR();}
						if(felt[0] == "ud"){lineLayer[tel].flipUD();}
						if(felt[0] == "rgamma"){ rgb[0]=+felt[1];}
						if(felt[0] == "ggamma"){ rgb[1]=+felt[1];}
						if(felt[0] == "bgamma"){ rgb[2]=+felt[1];}
						if(felt[0] == "rfloor"){ rgb[3]=+felt[1];}
						if(felt[0] == "gfloor"){ rgb[4]=+felt[1];}
						if(felt[0] == "bfloor"){ rgb[5]=+felt[1];}
						if(felt[0] == "rceil"){ rgb[6]=+felt[1];}
						if(felt[0] == "gceil"){ rgb[7]=+felt[1];}
						if(felt[0] == "bceil"){ rgb[8]=+felt[1];}
						if(felt[0] == "gamma"){ rgb[0]=+felt[1]; rgb[1]=+felt[2]; rgb[2]=+felt[3];}
						if(felt[0] == "floor"){ rgb[3]=+felt[1]; rgb[4]=+felt[2]; rgb[5]=+felt[3];}
						if(felt[0] == "ceil"){ rgb[6]=+felt[1]; rgb[7]=+felt[2]; rgb[8]=+felt[3];}
						if(felt[0] == "red"){ rgb[0]=+felt[1]; rgb[3]=+felt[2]; rgb[6]=+felt[3];}
						if(felt[0] == "green"){ rgb[1]=+felt[1]; rgb[4]=+felt[2]; rgb[7]=+felt[3];}
						if(felt[0] == "blue"){ rgb[2]=+felt[1]; rgb[5]=+felt[2]; rgb[8]=+felt[3];}
						if(felt[0] == "color"){ rgb[0]=+felt[1]; rgb[1]=+felt[2]; rgb[2]=+felt[3]; rgb[3]=+felt[4]; rgb[4]=+felt[5]; rgb[5]=+felt[6]; rgb[6]=+felt[7]; rgb[7]=+felt[8]; rgb[8]=+felt[9];}
						if(felt[0] == "turn"){
							var temp = rgb[3]; rgb[3]=rgb[6]; rgb[6]=temp;
							temp=rgb[4]; rgb[4]=rgb[7]; rgb[7]=temp;
							temp=rgb[5]; rgb[5]=rgb[8]; rgb[8]=temp;
						}
						if(felt[0] == "bblur"){
							if(felt[3] !== void){
								if(felt[3] == "true"){
									var bb_temp  = new CharacterLayer(kag, kag.fore.base);
									var bbx = (+felt[1]*2);
									var bby = (+felt[2]*2);
									bb_temp.assignImages(lineLayer[tel]);
									bb_temp.setImageSize(bb_temp.imageWidth+bbx, bb_temp.imageHeight+bby);
									bb_temp.setSize(bb_temp.width,bb_temp.height);
									bb_temp.fillRect(0,0,bb_temp.imageWidth,bb_temp.imageHeight,0x0);
									bb_temp.copyRect(+felt[1],+felt[2],lineLayer[tel],0,0,lineLayer[tel].imageWidth,lineLayer[tel].imageHeight);
									lineLayer[tel].assignImages(bb_temp);
									if(lineanmdata[tel][7] != -1){
										if(lineanmdata[tel][7] == 3){lineanmdata[tel][3] = -(+felt[1]);lineLayer[tel].setImagePos(lineanmdata[i][3],lineanmdata[i][4]);}
										if(lineanmdata[tel][7] == 1){lineanmdata[tel][4] = -(+felt[2]);lineLayer[tel].setImagePos(lineanmdata[i][3],lineanmdata[i][4]);}
									}
									invalidate bb_temp;
								}
							}
							lineLayer[tel].doBoxBlur((int)+felt[1], (int)+felt[2]);
							if(felt[4] !== void){ if(felt[4] == "true"){lineLayer[tel].doBoxBlur((int)+felt[1], (int)+felt[2]);}}
						}
						if(felt[0] == "size"){
							var s_temp  = new CharacterLayer(kag, kag.fore.base);
							var _sx = lineLayer[tel].imageWidth;
							var _sy = lineLayer[tel].imageHeight;
							var tsx = +felt[1];
							var tsy = +felt[2];
							var sx = tsx * _sx;
							var sy = tsy * _sy;
							var stype = stFastLinear;
							if(felt[3] !== void){
								if(+felt[3] == 0){stype = stNearest;}
								if(+felt[3] == 2){stype = stLinear;}
								if(+felt[3] == 3){stype = stCubic;}
							}
							
							s_temp.setImageSize(sx,sy);
							s_temp.setSize(lineLayer[tel].width * tsx,lineLayer[tel].height * tsy);
							s_temp.stretchCopy(0,0,sx,sy,lineLayer[tel],0,0,_sx,_sy,stype);
							lineLayer[tel].assignImages(s_temp);
							invalidate s_temp;

							if(linemovedata[tel][8] == 0){ linemovedata[tel][4] -= (sy - _sy)\2;}
							if(linemovedata[tel][8] == 1){ linemovedata[tel][4] -= (sy - _sy)\2;}
							if(linemovedata[tel][8] == 2){ linemovedata[tel][3] -= (sx - _sx)\2;}
							if(linemovedata[tel][8] == 3){ linemovedata[tel][3] -= (sx - _sx)\2;}
							lineLayer[tel].setPos(linemovedata[tel][3],linemovedata[tel][4]);
						}
						
						felt.clear();
					}
					lineLayer[tel].adjustGamma(rgb[0],rgb[3],rgb[6],rgb[1],rgb[4],rgb[7],rgb[2],rgb[5],rgb[8]);
					rgb.clear();
				}
			}
			//piledCopy(0,0,this,0,0,w,h);
		}
	}

	function stop_move(){
		if(cutinmovedata[0]){
			cutinmovedata[0] = false;
			cutinmovedata[1] = cutinmovedata[2];
			cw = cutinmovedata[3] - (cutinmovedata[5]*cutinmovedata[1]*2);
			ch = cutinmovedata[4] - (cutinmovedata[6]*cutinmovedata[1]*2);
			cwh = cw\2;
			chh = ch\2;
			cl = wh - cwh;
			ct = hh - chh;
			cutinLayer.setPos(cl,ct);
			cutinLayer.setSize(cw,ch);
		}
		
		for(var i=0;i<mainmovedata.count;i++){mainmovedata[i][1] = mainmovedata[i][2] - 1;}
		for(var i=0;i<linemovedata.count;i++){linemovedata[i][1] = linemovedata[i][2] - 1;}
		move();
	}

	function change_store(elm){
		//書き換え動作を行う
		if(elm.cutin !== void){
			
			var otc = [].split("(),", storeDic.cutin, , true);
			var ntc = [].split("(),", elm.cutin, , true);
			var tc_str = "("+ntc[0]+","+ntc[1]+","+ntc[2]+","+otc[5]+","+otc[6]+","+ntc[3]+","+ntc[4]+")";
			storeDic.cutin = tc_str;
		}

		if(elm.main !== void){
			var otam = [].split("[]", storeDic.main, , true);
			var ntam = [].split("[]", elm.main, , true);
			var tm_str = "";
			for(var i=0;i<otam.count;i++){
				var otm = [].split("()", otam[i], , true);
				var otmo = [].split("(),", otm[0], , true);
				var otmm = [].split("(),", otm[1], , true);
				
				var ntm = [].split("()", ntam[i], , true);
				var ntmo = [].split(",", ntm[0], , true);
				var ntmm = [].split(",", ntm[1], , true);
				
				var a_str = "";
				var o_str = "("+otmo[0]+","+ntmo[0]+","+ntmo[1]+","+ntmo[2]+","+otmo[4]+","+otmo[5]+")";
				var m_str = "("+otmm[3]+","+otmm[4]+","+otmm[5]+","+ntmm[0]+","+ntmm[1]+","+ntmm[2]+")";
				a_str = "["+o_str+m_str+"]";
				tm_str += a_str;
			}
			storeDic.main = tm_str;
		}
		
	}
	
	function change_move(elm){
		change_store(elm);
		activ = true;
		if(elm.cutin !== void){
			//ct[]= [0:コマ数,1:待機コマ,2:アクセル,3:サイズX,4:サイズY]
			var ct = [].split("(),", elm.cutin, , true);
			if(ct[0] != "-1"){
				cutinmovedata.clear();
				var cf = +ct[0];
				var ccs =  -(+ct[1]);				//スキップコマ					move_count_start
				var accel = +ct[2];					//アクセル
				var cs_w = cw; 						//現在値の挿入
				var cs_h = ch;	 					//現在値の挿入
				var v1_x = (+ct[3] * cutinLayer.imageWidth) - cs_w;
				var v1_y = (+ct[4] * cutinLayer.imageHeight) - cs_h;
				var cv1_x = v1_x / cf / 2;
				var cv1_y = v1_y / cf / 2;
				if(cv1_x == 0 && cv1_y == 0){
					cutinmovedata[0] = false;
					cutinmovedata[1] = 0;
					cutinmovedata[2] = 0;
					cutinmovedata[3] = cs_w;
					cutinmovedata[4] = cs_h;
					cutinmovedata[5] = 0;
					cutinmovedata[6] = 0;
					cutinmovedata[7] = accel;
				}else{
					cutinmovedata[0] = true;
					cutinmovedata[1] = ccs;
					cutinmovedata[2] = cf;
					cutinmovedata[3] = cs_w;
					cutinmovedata[4] = cs_h;
					cutinmovedata[5] = -cv1_x;
					cutinmovedata[6] = -cv1_y;
					cutinmovedata[7] = accel;
					cmactiv = true;
				}
				cwh = cw\2;
				chh = ch\2;
				cl = wh - cwh;
				ct = hh - chh;
				cutinLayer.setPos(cl,ct);
				cutinLayer.setSize(cw,ch);
			}
			
			for(var i=0;i<linemovedata.count;i++){
				var lf = cutinmovedata[1];										//スタートコマ数				move_count_max
				var mcm = cutinmovedata[2];										//最大コマ数					move_count_max
				var mv1_x = cutinmovedata[5];									//一コマの移動値				move_1_x
				var mv1_y = cutinmovedata[6];									//一コマの移動値				move_1_y
				switch(linemovedata[i][8]){
					case 0:{ mv1_x = 0; mv1_y = mv1_y; break;}					//top:
					case 1:{ mv1_x = 0; mv1_y = -mv1_y; break;}					//buttom:
					case 2:{ mv1_x = mv1_x; mv1_y = 0; break;}					//left:
					case 3:{ mv1_x = -mv1_x; mv1_y = 0; break;}					//right:
				}

				//[自身の番号,現在コマ,最大コマ数,初位置_X,初位置_Y,移動値_X,移動値_Y,配置情報,アクセル]
				linemovedata[i][0] = true;
				linemovedata[i][1] = lf;
				linemovedata[i][2] = mcm;
				linemovedata[i][3] = lineLayer[i].left;
				linemovedata[i][4] = lineLayer[i].top;
				linemovedata[i][5] = mv1_x;
				linemovedata[i][6] = mv1_y;
				linemovedata[i][7] = cutinmovedata[7];
				lmactiv = true;
			}
			
		}
		
		if(elm.main != void){
			var mtemp = [].split("[]", elm.main, , true);
			for(var i=0;i<mtemp.count;i++){
				//mt = [(move_frame, skipframe, accel)(move【移動先】)]
				var mt = [].split("()", mtemp[i], , true);								//メインレイヤの１枚に対しての動作集合体
				var mt1 = [].split(",", mt[0], , true);									//メインレイヤの基本動作
				for(var j=0;j<mt1.count;j++){mt1[j] = +mt1[j];}
				var mt2 = [].split(",", mt[1], , true);									//メインレイヤの動作情報
				for(var j=0;j<mt2.count;j++){mt2[j] = +mt2[j];}
				var mcs = -mt1[1];														//スキップコマ					move_count_start
				var accel = mt1[2];														//加速度						accel
				//ムーブ
				
				if(mt2 !== void){
					var mcm = (mt1[0] > 0) ? mt1[0] : 0;													//最大コマ数					move_count_max
					var mv1_x = (mt2[0] - (mainLayer[i].left + mainLayer[i].width\2) - cl) / mcm;			//一コマの移動値				move_1_x
					var mv1_y = (mt2[1] - (mainLayer[i].top + mainLayer[i].height\2) - ct) / mcm;			//一コマの移動値				move_1_y
					var mv1_o = (mt2[2] - mainLayer[i].opacity) / mcm;										//一コマの移動値				move_1_o
					mainmovedata[i][0] = true;
					mainmovedata[i][1] = mcs;
					mainmovedata[i][2] = mcm;
					mainmovedata[i][3] = mainLayer[i].left + cl;
					mainmovedata[i][4] = mainLayer[i].top + ct;
					mainmovedata[i][5] = mainLayer[i].opacity;
					mainmovedata[i][6] = mv1_x;
					mainmovedata[i][7] = mv1_y;
					mainmovedata[i][8] = mv1_o;
					mainmovedata[i][9] = accel;
					mmactiv = true;
				}
			}
		}
		activ_flag();
	}

	function activ_flag(){
		if(activ){
			if(mmactiv){mmactiv=false;for(var i=0;i<mainmovedata.count;i++){if(mainmovedata[i][0]){mmactiv = true;}}}
			if(maactiv){maactiv=false;for(var i=0;i<mainanmdata.count;i++){if(mainanmdata[i][0]){maactiv = true;}}}
			if(lmactiv){lmactiv=false;for(var i=0;i<linemovedata.count;i++){if(linemovedata[i][0]){lmactiv = true;}}}
			if(laactiv){laactiv=false;for(var i=0;i<lineanmdata.count;i++){if(lineanmdata[i][0]){laactiv = true;}}}
			if(!cmactiv && !mmactiv && !maactiv && !lmactiv && !laactiv){
				activ = false;
				//dm("切り替え");
			}else{
				//dm("継続");
			}
		}
	}

	function activ_action(){
		if(skip_count > skip_interval){
			move();
		}else{
			skip_count++;
		}
		animetion();
		activ_flag();
		//onTag();
	}
	
	function move(){
		if(cmactiv || mmactiv){
			for(var i=0;i<mainmovedata.count;i++){
				if(mainmovedata[i][0]){
					if(mainmovedata[i][1] < 0){
						mainmovedata[i][1]++;
						mainLayer[i].setPos(mainmovedata[i][3], mainmovedata[i][4]);
					}else if(mainmovedata[i][1] < mainmovedata[i][2]){
						mainmovedata[i][1]++;
						var mma = mainmovedata[i][9];
						var tick = mainmovedata[i][1];
						
						if(mma < 0){
							// 上弦 ( 最初が動きが早く、徐々に遅くなる )
							tick = 1.0 - tick / mainmovedata[i][2];
							tick = Math.pow(tick, -mma);
							tick = ( (1.0 - tick) * mainmovedata[i][2] );
						}
						else if(mma > 0)
						{
							// 下弦 ( 最初は動きが遅く、徐々に早くなる )
							tick = tick / mainmovedata[i][2];
							tick = Math.pow(tick, mma);
							tick = ( tick * mainmovedata[i][2] );
						}
						mainLayer[i].setPos(mainmovedata[i][3]+mainmovedata[i][6]*tick,mainmovedata[i][4]+mainmovedata[i][7]*tick);
						mainLayer[i].opacity = mainmovedata[i][5]+mainmovedata[i][8]*tick;
					}else{
						mainmovedata[i][0] = false;
						mainLayer[i].setPos(mainmovedata[i][3]+mainmovedata[i][6]*mainmovedata[i][2], mainmovedata[i][4]+mainmovedata[i][7]*mainmovedata[i][2]);
					}
				}else{
					mainLayer[i].setPos(mainmovedata[i][3]+mainmovedata[i][6]*mainmovedata[i][2], mainmovedata[i][4]+mainmovedata[i][7]*mainmovedata[i][2]);
				}
			}
		}
		
		if(cmactiv || mmactiv){
			if(cutinmovedata[1] >= 0){
				if(cutinmovedata[1] < cutinmovedata[2]){
					cutinmovedata[1]++;
					var cma = cutinmovedata[7];
					var tick = cutinmovedata[1];
					if(cma < 0){
						// 上弦 ( 最初が動きが早く、徐々に遅くなる )
						tick = 1.0 - tick / cutinmovedata[2];
						tick = Math.pow(tick, -cma);
						tick = ( (1.0 - tick) * cutinmovedata[2] );
					}else if(cma > 0){
						// 下弦 ( 最初は動きが遅く、徐々に早くなる )
						tick = tick / cutinmovedata[2];
						tick = Math.pow(tick, cma);
						tick = ( tick * cutinmovedata[2]);
					}
					var cv_x = cutinmovedata[3] - cutinmovedata[5] * tick * 2;
					var cv_y = cutinmovedata[4] - cutinmovedata[6] * tick * 2;
					//cw = cw - (cutinmovedata[5]*2);
					cw = cv_x;
					//ch = ch - (cutinmovedata[6]*2);
					ch = cv_y;
					cwh = cw\2;
					chh = ch\2;
					cl = wh - cwh;
					ct = hh - chh;
					cutinLayer.setPos(cl,ct);
					cutinLayer.setSize(cw,ch);
					for(var i=0;i<mainLayer.count;i++){
						mainLayer[i].left -= cl;
						mainLayer[i].top -= ct;
					}
				}else{
					cmactiv = false;
					for(var i=0;i<mainLayer.count;i++){
						mainLayer[i].left -= cl;
						mainLayer[i].top -= ct;
					}
				}
			}else{
				cutinmovedata[1]++;
				for(var i=0;i<mainLayer.count;i++){
					mainLayer[i].left -= cl;
					mainLayer[i].top -= ct;
				}
			}
		}
		
		if(lmactiv){
			for(var i=0;i<linemovedata.count;i++){
				if(linemovedata[i][0]){
					if(linemovedata[i][1] < 0){
						linemovedata[i][1]++;
					}else if(linemovedata[i][1] < linemovedata[i][2]){
						linemovedata[i][1]++;
						var lma = linemovedata[i][7];
						var tick = linemovedata[i][1];
						if(lma < 0){
							// 上弦 ( 最初が動きが早く、徐々に遅くなる )
							tick = 1.0 - tick / linemovedata[i][2];
							tick = Math.pow(tick, -lma);
							tick = ( (1.0 - tick) * linemovedata[i][2] );
						}else if(lma > 0){
							// 下弦 ( 最初は動きが遅く、徐々に早くなる )
							tick = tick / linemovedata[i][2];
							tick = Math.pow(tick, lma);
							tick = ( tick * linemovedata[i][2]);
						}
						var lv_x = (int)(linemovedata[i][3]+linemovedata[i][5]*tick);
						var lv_y = (int)(linemovedata[i][4]+linemovedata[i][6]*tick);
						lineLayer[i].setPos(lv_x,lv_y);
					}else{
						linemovedata[i][0] = false;
					}
				}
			}
		}
	}
	
	function animetion(){
		if(maactiv){
			for(var i=0;i<mainanmdata.count;i++){
				if(mainanmdata[i][0]){
					mainanmdata[i][1]++;
					if(mainanmdata[i][1] >= mainanmdata[i][2])mainanmdata[i][1]=0;
					mainLayer[i].setImagePos(mainanmdata[i][3]+mainanmdata[i][5]*mainanmdata[i][1],mainanmdata[i][4]+mainanmdata[i][6]*mainanmdata[i][1]);
				}
			}
		}
		
		if(laactiv){
			for(var i=0;i<lineanmdata.count;i++){
				if(lineanmdata[i][0]){
					lineanmdata[i][1]++;
					if(lineanmdata[i][1] >= lineanmdata[i][2])lineanmdata[i][1]=0;
					lineLayer[i].setImagePos(lineanmdata[i][3]+lineanmdata[i][5]*lineanmdata[i][1],lineanmdata[i][4]+lineanmdata[i][6]*lineanmdata[i][1]);
				}
			}
		}
	}

	function onTag(elm)
	{
		if(activ){
			//全域更新用
			//fillRect(0,0,w,h,0x0);
			//piledCopy(0,0,this,0,0,w,h);
		}
		
		//if(owner !== void && typeof owner.onTag != "undefined"){owner.onTag();}
	}
	
	function clear()
	{
		
		for(var i=0;i<lineLayer.count;i++){invalidate lineLayer[i] if lineLayer[i] !== void;}
		lineLayer.clear();
		linemovedata.clear();
		lineanmdata.clear();
		
		for(var i=0;i<mainLayer.count;i++){invalidate mainLayer[i] if mainLayer[i] !== void;}
		mainLayer.clear();
		mainmovedata.clear();
		mainanmdata.clear();
		
		invalidate cutinLayer if cutinLayer !== void;
		cutinLayer = void;
		cutinmovedata.clear();
	}
}

class AutoBindLayer extends Layer{
	var bindLayer = [];
	var bindflag = [];
	var fillbindLayer;
	var storeDic;				//リロード用されたときの高速化
	function AutoBindLayer(win, par, storage){
		super.Layer(...);
	}

	function loadImages(elm = %[]){
		if(elm.bind !== void){
			var new_bind = elm.bind;
			storeDic = elm.bind;
			var bl_list = [].split("[]", elm.bind, , true);
			var abl_cx = kag.scWidth\2;
			var abl_cy = kag.scHeight\2;
			if(elm.fillbind !== void){
				var fillbind = [].split("(),", elm.fillbind, , true);
				if(fillbindLayer === void){fillbindLayer = new CharacterLayer(kag, kag.fore.base);}
				fillbindLayer.setImageSize(+fillbind[1],+fillbind[2]);
				fillbindLayer.setSizeToImageSize();
				fillbindLayer.fillRect( 0, 0, fillbindLayer.imageWidth, fillbindLayer.imageHeight, (int)fillbind[0]);
				bindflag.add(true);
			}
			
			for(var i=0;i<bl_list.count;i++){
				var i_storage = "black";
				var edb = %[];
				edb["mode"] = "alpha";
				edb["path"] = "("+abl_cx+","+abl_cy+",255)";
				edb["rad"] = 0;
				edb["size"] = 1;
				edb["size_x"] = 1;
				edb["size_y"] = 1;
				edb["fliplr"] = "false";
				edb["flipud"] = "false";
				edb["grayscale"] = "false";
				edb["sepia"] = "false";
				edb["turn"] = "false";
				edb["color"] = [1,1,1,0,0,0,255,255,255];
				edb["bblur"] = "false";
				edb["bblur_extend"] = "false";
				edb["bbx"] = 0;
				edb["bby"] = 0;
				edb["alphaeffect"] = -1;
				edb["sub"] = false;
				
				var l_list = [].split(" ", bl_list[i], , true);
				bindLayer.add(new CharacterLayer(kag, kag.fore.base));
				bindflag.add(true);
				for(var j=0;j<l_list.count;j++){
					var list = [].split("=", l_list[j], , true);
					if(list[0] == "storage"){edb.i_storage = list[1];}
					else if(list[0] == "mode"){edb.mode = list[1];}
					else if(list[0] == "path"){edb.path = list[1];}
					else if(list[0] == "rad"){edb.rad = list[1];}
					else if(list[0] == "size"){edb.size = list[1];}
					else if(list[0] == "size_x"){edb.size_x = list[1];}
					else if(list[0] == "size_y"){edb.size_y = list[1];}
					else if(list[0] == "fliplr"){edb.fliplr = list[1];}
					else if(list[0] == "flipud"){edb.flipud = list[1];}
					else if(list[0] == "grayscale"){edb.grayscale = list[1];}
					else if(list[0] == "sepia"){edb.sepia = list[1];}
					else if(list[0] == "turn"){edb.turn = list[1];}
					else if(list[0] == "rgamma"){edb.color[0] = +list[1];}
					else if(list[0] == "ggamma"){edb.color[1] = +list[1];}
					else if(list[0] == "bgamma"){edb.color[2] = +list[1];}
					else if(list[0] == "rfloor"){edb.color[3] = +list[1];}
					else if(list[0] == "gfloor"){edb.color[4] = +list[1];}
					else if(list[0] == "bceil"){edb.color[5] = +list[1];}
					else if(list[0] == "rceil"){edb.color[6] = +list[1];}
					else if(list[0] == "gceil"){edb.color[7] = +list[1];}
					else if(list[0] == "bceil"){edb.color[8] = +list[1];}
					else if(list[0] == "bblur"){edb.bblur = list[1];}
					else if(list[0] == "bblur_extend"){edb.bblur_extend = list[1];}
					else if(list[0] == "bbx"){edb.bbx = +list[1];}
					else if(list[0] == "bby"){edb.bby = +list[1];}
					else if(list[0] == "alphaeffect"){edb.alphaeffect = +list[1];}
					else if(list[0] == "sub"){edb.sub = +list[1];}
					list.clear();
				}
				
				bindLayer[i].loadImages(%[storage:edb.i_storage]);
				var _rad = [].split("(),", edb.rad, , true);
				var _size = [].split("(),", edb.size, , true);
				var _size_x = [].split("(),", edb.size_x, , true);
				var _size_y = [].split("(),", edb.size_y, , true);
				edb.rad = +_rad[0] * (Math.PI/180) * -1;
				edb.size = +_size[0];
				edb.size_x = +_size_x[0] * edb.size;
				edb.size_y = +_size_y[0] * edb.size;
				bindLayer[i].setSizeToImageSize();
				var mg_x = 0;
				var mg_y = 0;

				if(edb.bblur_extend == "true"){
					mg_x = edb.bbx;
					mg_y = edb.bby;
				}

				if(edb.rad == 0){
					if(edb.size_x != 1 || edb.size_y != 1){
						var tmp = new CharacterLayer(kag, kag.fore.base);
						tmp.setImageSize(bindLayer[i].imageWidth*edb.size_x + mg_x * 2,bindLayer[i].imageHeight*edb.size_y + mg_y * 2);
						tmp.setSizeToImageSize();
						/*回転処理にする*/
						tmp.stretchCopy(mg_x, mg_y, tmp.imageWidth-mg_x*2, tmp.imageHeight-mg_y*2, bindLayer[i], 0, 0, bindLayer[i].imageWidth, bindLayer[i].imageHeight, stFastLinear);
						bindLayer[i].assignImages(tmp);
						bindLayer[i].setSizeToImageSize();
						invalidate tmp;
					}else if(mg_x != 0 || mg_y != 0){
						var tmp = new CharacterLayer(kag, kag.fore.base);
						tmp.setImageSize(bindLayer[i].imageWidth + mg_x * 2,bindLayer[i].imageHeight + mg_y * 2);
						tmp.setSizeToImageSize();
						tmp.stretchCopy(mg_x, mg_y, tmp.imageWidth-mg_x*2, tmp.imageHeight-mg_y*2, bindLayer[i], 0, 0, bindLayer[i].imageWidth, bindLayer[i].imageHeight, stFastLinear);
						bindLayer[i].assignImages(tmp);
						bindLayer[i].setSizeToImageSize();
						invalidate tmp;
					}

					var _path = [].split("(),", edb.path, , true);
					var _l = +_path[0] - (bindLayer[i].imageWidth\2);
					var _t = +_path[1] - (bindLayer[i].imageHeight\2);
					var _o = +_path[2];
				
					bindLayer[i].setPos(_l,_t);
					bindLayer[i].opacity = _o;
					bindLayer[i].type = imageTagLayerType[edb.mode].type;
				}else{
					
					/*サイズの計算*/
					var cx = bindLayer[i].imageWidth\2;
					var cy = bindLayer[i].imageHeight\2;
					var rc = Math.cos(edb.rad);
					var rs = Math.cos((Math.PI/2.0) - edb.rad);

					//var _rc = Math.abs(rc);
					//var _rs = Math.abs(rs);
					var _txs = bindLayer[i].imageWidth * edb.size_x + mg_x * 2;
					var _tys = bindLayer[i].imageHeight * edb.size_y + mg_y * 2;
					var _ll;
					if(_txs >= _tys){
						_ll = _txs;
					}else{
						_ll = _tys;
					}
					/*特殊処理*/
					var tmp = new CharacterLayer(kag, kag.fore.base);
					tmp.setImageSize( _ll, _ll);
					tmp.setSizeToImageSize();
					
					var imageWidthHalf = tmp.imageWidth / 2;
					var imageHeightHalf = tmp.imageHeight / 2;
					
					var l = imageWidthHalf;
					var t = imageHeightHalf;
					
					var m00 = edb.size_x * rc;
					var m01 = edb.size_x * -rs;
					var m10 = edb.size_y * rs;
					var m11 = edb.size_y * rc;
					var mtx = ((m00*-cx) + (m10*-cy) + l);
					var mty = ((m01*-cx) + (m11*-cy) + t);
					
					tmp.affineCopy(bindLayer[i], 0, 0, bindLayer[i].imageWidth, bindLayer[i].imageHeight, true, m00, m01, m10, m11, mtx, mty, stFastLinear, true);
					bindLayer[i].assignImages(tmp);
					bindLayer[i].setSizeToImageSize();
					invalidate tmp;

					var _path = [].split("(),", edb.path, , true);
					var _l = (+_path[0] - (bindLayer[i].imageWidth\2));
					var _t = (+_path[1] - (bindLayer[i].imageHeight\2));
					var _o = +_path[2];
				
					bindLayer[i].setPos(_l,_t);
					bindLayer[i].opacity = _o;
					bindLayer[i].type = imageTagLayerType[edb.mode].type;

				}
				if(edb.bblur == "true"){
					bindLayer[i].doBoxBlur(edb.bbx,edb.bby);
				}
				if(edb.fliplr == "true"){bindLayer[i].flipLR();}
				if(edb.flipud == "true"){bindLayer[i].flipUD();}

				if(edb["grayscale"] == "true" || edb["sepia"] == "true"){
					bindLayer[i].doGrayScale();
					if(edb["sepia"] == "true"){
						edb.color[0] = 1.3;
						edb.color[1] = 1.1;
						edb.color[2] = 1.0;
					}
				}
				if(edb["turn"] != "true"){
					bindLayer[i].adjustGamma(edb.color[0],edb.color[3],edb.color[6],edb.color[1],edb.color[4],edb.color[7],edb.color[2],edb.color[5],edb.color[8]);
				}else{
					bindLayer[i].adjustGamma(edb.color[0],edb.color[6],edb.color[3],edb.color[1],edb.color[7],edb.color[4],edb.color[2],edb.color[8],edb.color[5]);
				}
				
				if(edb["alphaeffect"] != -1){
					//dm("アルファ処理");
					var src = edb["alphaeffect"];
					var tmp = new CharacterLayer(kag, kag.fore.base);
					tmp.setImageSize(bindLayer[i].imageWidth,bindLayer[i].imageHeight);
					tmp.setSizeToImageSize();
					tmp.fillRect(0,0,tmp.imageWidth,tmp.imageHeight,0x00000000);
					tmp.copyRect(bindLayer[src].left-bindLayer[i].left,bindLayer[src].top-bindLayer[i].top,bindLayer[src],0,0,bindLayer[src].imageWidth,bindLayer[src].imageHeight);
					bindLayer[i].MaskRect(0, 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight,3);
					invalidate tmp;
				}
				if(edb["sub"]){bindflag[i] = false;}
				
				(Dictionary.clear incontextof edb)();
				l_list.clear();
				invalidate edb;
			}
			bl_list.clear();
			Bind();
		}else{
			if(elm.snapshot == "true"){	// スナップショットレイヤーを使ってメッセージ含め全部コピー
				SnapShotBind();
			}else{
				if(elm.snapshot == "back"){
					BackLayerBind();
				}else{
					ForeLayerBind();
				}
			}
		}
	}
	
	function SnapShotBind(){
		this.setImageSize(kag.scWidth, kag.scHeight);
		kag.lockSnapshot();
		this.copyRect(0,0,kag.snapshotLayer,0,0,kag.scWidth,kag.scHeight);
		kag.unlockSnapshot();
	}

	function LayerBind(layers){
		var ASFFL = AbsoluteSort(layers);	//AbsoluteSortForForeLayer
		var bglay = layers[ASFFL[0]];		//bg系のレイヤを読み込む
		this.assignImages(bglay);			//先ず背景コピー
		this.setSizeToImageSize();
		for(var i=1; i<ASFFL.count; i++){	//残りコピー
			var lays = layers[ASFFL[i]];
			var _ll = lays.left - bglay.left;
			var _lt = lays.top - bglay.top;
			if(lays.anmLayer === void){
				this.operateRect( _ll, _lt, lays, 0, 0, lays.width, lays.height, lays.type, 255);
			}else{
				this.operateRect( _ll, _lt, lays, 0, 0, lays.width, lays.height, lays.type, 255);
				this.operateRect( lays.anmLayer.left+_ll, lays.anmLayer.top+_lt, lays.anmLayer, 0, 0, lays.anmLayer.width, lays.anmLayer.height, lays.anmLayer.type, 255);
			}
		}
	}

	//layersは配列状態のレイヤ
	function AbsoluteSort(layers){
		var _ra = [];
		//visible状態のものだけを抽出
		for(var i=0;i<layers.count;i++){
			if(layers[i].visible){ _ra.add(i);}
		}
		//visible状態のものだけを抽出
		var __swap;
		for(var i=0;i<_ra.count-1;i++){
			for(var j=i;j<_ra.count;j++){
				if(layers[_ra[i]].absolute > layers[_ra[j]].absolute){
					__swap = _ra[i];
					_ra[i] = _ra[j];
					_ra[j] = __swap;
				}
			}
		}
		return _ra;
	}
	
	function ForeLayerBind(){ LayerBind(kag.fore.layers);}
	function BackLayerBind(){ LayerBind(kag.back.layers);}

	function Bind(){
		var cnt = 0;
		if(fillbindLayer !== void){
			assignImages(fillbindLayer);
			setSizeToImageSize();
			setPos((kag.scWidth-fillbindLayer.imageWidth)\2,(kag.scHeight-fillbindLayer.imageHeight)\2);
		}else{
			assignImages(bindLayer[0]);
			setSizeToImageSize();
			setPos(bindLayer[0].left,bindLayer[0].top);
			cnt = 1;
		}
		
		if(bindLayer.count > cnt){
			for(var i=cnt;i<bindLayer.count;i++){
				if(bindflag[i]){
					operateRect(bindLayer[i].left-left,bindLayer[i].top-top, bindLayer[i], 0, 0, bindLayer[i].imageWidth, bindLayer[i].imageHeight, omAuto, bindLayer[i].opacity);
				}
			}
		}
		clear();
	}
	function clear(){
		invalidate fillbindLayer if fillbindLayer !== void;
		fillbindLayer = void;
		for(var i=0;i<bindLayer.count;i++){
			invalidate bindLayer[i];
		}
		bindflag.clear();
		bindLayer.clear();
	}
	function finalize(){
		invalidate fillbindLayer if fillbindLayer !== void;
		fillbindLayer = void;
		for(var i=0;i<bindLayer.count;i++){
			invalidate bindLayer[i];
		}
		bindflag.clear();
		bindLayer.clear();
	}
}

class WordLayer extends Layer{
	//再生成を行うことを加味する
	var word_px;				//文字のX座標
	var word_py;				//文字のY座標
	var word_str;				//描画する文字列
	var line_str;				//１行ごとの文字列
	var word_color;				//描画する色
	var word_opacity;			//描画する文字の不透明度
	var aa;						//アンチエイリアス
	var shadow_level;			//影の不透明度
	var shadow_color;			//文字の影の色
	var shadow_width;			//文字の影の幅（ぼけ）を指定
	var shadow_px;				//文字の影のX座標
	var shadow_py;				//文字の影のY座標
	var WordSpace;				//１文字間の距離
	var LineSpace;				//文字行間の距離
	var LineWordMax;			//行間の最大文字数⇒オート改行用
	var word_absolute;			//文字列の優先度
	var word_outline_s_color;	//外淵の配色
	
	//レイヤーに元々ある変数
	//font.face;				//文字のフォント
	//font.height;				//文字のサイズ
	//font.bold;				//太文字化
	//font.italic;				//斜文字化：【イタリック】
	//font.strikeout;			//未実装：訂正線追加(吉里吉里２では未実装)
	//font.underline;			//未実装：下線追加(吉里吉里２では未実装)
	//font.angle;				//未実装：文字列の回転配置(吉里吉里２では未実装)

	function WordLayer(win, par, storage){
		super.Layer(...);
		WordDataInit();
	}

	function WordDataInit(){
		word_str = "";						//文字列の初期化
		line_str = [];						//文字列の初期化
		word_color =  0xffffff;				//文字色の初期化
		aa = false;							//アンチエイリアスの初期化
		shadow_level = 1024;				//影の不透明度の初期化
		shadow_color = 0x000000;			//文字の影の色の初期化
		shadow_width = 3;					//文字の影の幅の初期化
		shadow_px = 1;						//文字の影のX座標の初期化
		shadow_py = 1;						//文字の影のY座標の初期化
		WordSpace = 0;						//１文字間の距離の初期化
		LineSpace = 30;						//文字行間の距離の初期化
		LineWordMax = 16;					//行間の最大文字数の初期化
		this.font.face = "ＭＳ Ｐ明朝";		//フォントの初期化
		this.font.height = 22;				//フォントサイズの初期化
		this.font.bold = false;				//太文字化の初期化
		this.font.italic = false;			//斜文字化の初期化
		//this.font.strikeout = false;		//訂正線の有無の初期化
		//this.font.underline = false;		//下線の有無の初期化
		//this.font.angle = 0;				//文字の回転配置の角度の初期化
		word_absolute = false;				//文字列の優先度の初期化
		word_outline_s_color = "0x0";		//外淵の配色の初期化
	}
	
	function WordDataSet(elm){
		if(elm.word !== void){word_str = elm.word;line_str = word_str.split(/￥ｎ/,,false);}		//文字列の再格納
		if(elm.word_color !== void){word_color = elm.word_color;}									//文字色の再格納
		if(elm.word_aa === "true"){aa = true;}														//アンチエイリアスの再格納
		if(elm.word_sl !== void){shadow_level = +elm.word_sl;}										//影の不透明度の再格納
		if(elm.word_s_color !== void){shadow_color = elm.word_s_color;}								//文字の影の色の再格納
		if(elm.word_sw !== void){shadow_width = +elm.word_sw;}										//文字の影の幅の再格納
		if(elm.word_sx !== void){shadow_px = +elm.word_sx;}											//文字の影のX座標の再格納
		if(elm.word_sy !== void){shadow_py = +elm.word_sy;}											//文字の影のY座標の再格納
		if(elm.word_sp !== void){WordSpace = +elm.word_sp;}											//１文字間の距離の再格納
		if(elm.word_ls !== void){LineSpace = +elm.word_ls;}											//文字行間の距離の再格納
		if(elm.word_lwm !== void){LineWordMax = +elm.word_lwm;}										//行間の最大文字数の再格納
		if(elm.font !== void){this.font.face = elm.font;}											//フォントの再格納
		if(elm.word_size !== void){this.font.height = +elm.word_size;}								//フォントサイズの再格納
		if(elm.word_b === "true"){this.font.bold = true;}else{this.font.bold = false;}				//太文字化の再格納
		if(elm.word_i === "true"){this.font.italic = true;}else{this.font.italic = false;}			//斜文字化の再格納
		//if(elm.word_s === "true"){this.font.strikeout = true;}else{this.font.strikeout = false;}	//訂正線の有無の再格納
		//if(elm.word_u === "true"){this.font.underline = true;}else{this.font.underline = false;}	//下線の有無の再格納
		//if(elm.word_a !== void){this.font.angle = +elm.word_a;}else{this.font.angle = 0;}			//文字の回転配置の角度の再格納
		if(elm.word_absolute !== void){ word_absolute = elm.word_absolute;}							//文字列の優先度の再格納
		if(elm.word_outline_s_color !== void){ word_outline_s_color = elm.word_outline_s_color;}	//外淵の配色の再格納

		draw();
	}

	function clear(){
		WordDataSet(elm);
		.loadImages("ImgClear", clNone, elm.window == "false" , elm);//塗りつぶし
	}
	
	function draw(){
		//初期化を行う
		with(this){
			var max_line = line_str.count;
			var max_line_count = line_str[0].length;
			var max_line_num = 0;
			for(var i = 0;i < line_str.count;i++){
				max_line += line_str[i].length \ LineWordMax;
				if(max_line_count < line_str[i].length){
					max_line_count = line_str[i].length;
					max_line_num = i;
				}
			}
			if(max_line_count > LineWordMax){max_line_count = LineWordMax;}
			
			var h;	// 文字に必要な幅＋影のサイズ
			if(line_str.count != 1){
				h = (.font.getTextHeight(word_str) * max_line) + (shadow_width * 2) + LineSpace  * (max_line);
			}else{
				h = .font.getTextHeight(word_str) + (shadow_width * 2);
			}
			
			var w;
			if(line_str.count != 1){
				w = .font.getTextWidth(line_str[max_line_num]) + (shadow_width * 2) + (WordSpace * (max_line_count - 1));
			}else{
				w = .font.getTextWidth(word_str) + (shadow_width * 2) + (WordSpace * (word_str.length - 1));
			}
			
			var wsx = shadow_width;
			var wsy = shadow_width;
			
			if(shadow_px > 0){h += shadow_px;}else{h -= shadow_px;wsx -= shadow_px;}
			if(shadow_py > 0){w += shadow_py;}else{w += shadow_py;wsy -= shadow_py;}
			if(.font.italic){w = w + (.font.height * 0.75);wsx += (.font.height * 0.75) / 2;}
			
			//if(WordSpace >= 0){wsx += WordSpace / 2;}else{wsx -= WordSpace / 2;}
			
			/*
			if(.font.angle != 0){
				var w_a = Math.sin(.font.angle * Math.PI / 1800);//係数
				var h_a = Math.cos(.font.angle * Math.PI / 1800);//係数
				if(w_a < 0){w_a = w_a * -1;}
				if(h_a < 0){h_a = h_a * -1;}
				w = (int)(w * (1 + w_a));
				h = (int)(h * (1 + h_a));
				wsx = wsx * w_a;
				wsy = wsy * h_a;
			}
			*/
			
			.setImageSize(w, h);	// 必要な文字幅よりレイヤーサイズ決定
			.setSizeToImageSize();
			.type = ltAlpha;
			.hitType = htMask;
			.hitThreshold = 256;	// 当たり判定無し
			
			//.fillRect(0,0,.imageWidth,.imageHeight,0xff00ff00);
			
			var nwsx = wsx;
			var nwsy = wsy;
			//var nwsx = 0;
			//var nwsy = 0;

			var lineCount = 0;
			if(line_str.count != 1){
				for(var i=0; i<line_str.count; i++){
					var t = line_str[i];
					if(t == ""){
						lineCount++;
						continue;
					}
					if(t.length <= LineWordMax || (t.length <= LineWordMax + 1 && t.charAt(LineWordMax) === "、")){
						.drawText(0,(LineSpace*lineCount++),t,word_color,255,true,shadow_level,shadow_color,shadow_width,shadow_px,shadow_py);
					}else{
						// 自動改行
						var max = Math.ceil(t.length/LineWordMax);
						for(var j=0; j<max; j++){
							.drawText(0,(LineSpace*lineCount++),t.substr(j*LineWordMax, LineWordMax),word_color,255,true,shadow_level,shadow_color,shadow_width,shadow_px,shadow_py);
						}
					}
				}
			}else{
				if(word_absolute == "false"){
					if(.font.italic) nwsx = w - shadow_width - .font.getTextWidth(word_str.charAt(word_str.length-1)) - wsx;
					else nwsx = w - shadow_width - .font.getTextWidth(word_str.charAt(word_str.length-1));
					for(var i = word_str.length-1;i >= 0;i--){
						.drawText(nwsx,nwsy,word_str.charAt(i),word_color,255,aa,shadow_level,shadow_color,shadow_width,shadow_px,shadow_py);
						if(word_outline_s_color != "0x0") .drawText(nwsx,nwsy,word_str.charAt(i),word_color,255,aa,shadow_level/4,word_outline_s_color,shadow_width/3,shadow_px,shadow_py);
						nwsx -= (.font.getTextWidth(word_str.charAt(i-1)) + WordSpace);
						//if(WordSpace < 0){nwsx -= WordSpace;}
					}
				}else{
					for(var i=0;i < word_str.length;i++){
						.drawText(nwsx,nwsy,word_str.charAt(i),word_color,255,aa,shadow_level,shadow_color,shadow_width,shadow_px,shadow_py);
						if(word_outline_s_color != "0x0") .drawText(nwsx,nwsy,word_str.charAt(i),word_color,255,aa,shadow_level/4,word_outline_s_color,shadow_width/3,shadow_px,shadow_py);
						nwsx += (.font.getTextWidth(word_str.charAt(i)) + WordSpace);
						//if(WordSpace < 0){nwsx += WordSpace;}
					}
				}
			}
			.visible = false;
		}
	}
	
	function finalize(){
	}
}

/*
	画像の拡大縮小直線移動曲線移動回転ボックスブラー・擬似モーションブラー
	それら複数を同時に実行するプラグイン
*/

class ExSpectrumLayer extends Layer{
	var no;										//作成番号
	var Main_Opacity;							//元々の不透明度
	var Sub_Opacity;							//残像個数による変動する不透明度割合
	var rgamma,ggamma,bgamma;					//gamma補正地
	var rfloor,gfloor,bfloor;					//floor補正地
	var rceil,gceil,bceil;						//ceil補正地
	
	function ExSpectrumLayer(win,par,n){
		no = n;									//作成個数
		super.Layer(win,par);					//スーパークラスを初期化
		focusable = false;						//他の機能に関与しない
		hitThreshold = 256;						//他の機能に関与しない
		Init();									//初期化
		InitAdjustGamma();						//初期化
	}

	function finalize(){ super.finalize(...);}	//スーパークラスの終了準備

	//初期化
	function Init(){
		Main_Opacity = 0;
		Sub_Opacity = 0;
		absolute = 0;
	}

	function InitAdjustGamma(){
		rgamma = 1.0;
		ggamma = 1.0;
		bgamma = 1.0;
		rfloor = 0;
		gfloor = 0;
		bfloor = 0;
		rceil = 255;
		gceil = 255;
		bceil = 255;
	}

	function SetAdjustGamma(elm){
		if(elm.spectrum_adjust !== void){
			var ag = [].split("(), ", elm.spectrum_adjust, , true);
			rgamma = +ag[0];
			ggamma = +ag[1];
			bgamma = +ag[2];
			rfloor = +ag[3];
			gfloor = +ag[4];
			bfloor = +ag[5];
			rceil = +ag[6];
			gceil = +ag[7];
			bceil = +ag[8];
			ag.clear();
		}
	}

	function SizeSetup(w,h){
		setImageSize(w,h);
		setSizeToImageSize();
		fillRect(0,0,imageWidth,imageHeight,0x0);
	}
	
	function SetSubOpacity(smn){
		var so = 1 / (smn + 1);													//残像の一つあたりの消失不透明度
		Sub_Opacity = so * (smn - no);											//残像の一つあたりの消失不透明度を配列に再配置
		if(Sub_Opacity > 1){Sub_Opacity = 1;}									//残像の予備不透明度の最大割合
		if(Sub_Opacity < 0){Sub_Opacity = 0;}									//残像の予備不透明度の最小割合
	}
	
	function SetOpacity(){ opacity = (int)(Main_Opacity * Sub_Opacity);}		//残像の最終不透明値の格納
	
	//オーバーラップ
	function assignImages(elm,front = true,flag = true){
		super.assignImages(elm);												//レイヤの画像情報をコピー
		setSizeToImageSize();													//表示矩形サイズを固定
		if(flag){
			if(elm.Main_Opacity !== void) Main_Opacity = elm.Main_Opacity;		//基準不透明度のコピー
			if(elm.absolute !== void) absolute = elm.absolute;					//優先度のコピー
			if(elm.type !== void) type = elm.type;								//表示合成方法をコピー
			//フロントとリアの処理が必要
			if(!front){
				if(elm.Sub_Opacity !== void) Sub_Opacity = elm.Sub_Opacity;		//表示合成方法をコピー
				if(elm.opacity !== void) opacity = elm.opacity;					//表示合成方法をコピー
			}
		}else{
			Main_Opacity = elm.opacity;											//基準不透明度のコピー
			absolute = elm.absolute;											//優先度のコピー
			type = elm.type;													//表示合成方法をコピー
		}
	}

	function SpectrumAdjustGamma(){
		if(no >= 1){
			//処理を考える
		}else{
			super.adjustGamma(rgamma, rfloor, rceil, ggamma, gfloor, gceil, bgamma, bfloor, bceil);
		}
	}
}

/*
//Movieをエフェクトのテンプレートとして使うクラス
;//仮テスト
Plugins.link("AlphaMovie.dll");
//注意項レイヤ再生しか要らない

class SingleLayerAlphaMoviePlayer extends AlphaMovie
{
	var		moving = false; // タイマーが始動しているかどうか
	var		lastTick;
	var		drawlayer;
	var		OutputLayer;
	var		alphaMovie;
	var		lastFrame;
	var		remain;
	var		movieVisible;
	var		slot;
	var		hasNext;
	var		currentNumberOfFrame;
	var		currentLoop;
	var		spLoop = false;		// ループを特定のフレームにする

	function SingleLayerAlphaMoviePlayer( obj , output) {
		this.moving = false;
		this.drawlayer = new CharacterLayer( kag, kag.fore.base, "alpha movie 00" + obj, 1234 + obj );
		CreateDrawLayer( kag.fore.base, this.drawlayer, obj );
		
		this.OutputLayer = output;		//対象レイヤを選択枚フレームpiledCopyで吐き出し
		this.movieVisible = true;
		this.slot = obj;
		this.hasNext = false;
		this.isLoopNext = false;
		this.currentNumberOfFrame = 0;
	}

	function finalize() {
		stop();
	}

	function play() {
		if( moving ) { stop(); }

		super.play();
		if(moving == false) {
			hasNext = false;
			remain = 0;
			currentNumberOfFrame = numOfFrame;
			currentLoop = loop;
			lastTick = System.getTickCount();
			System.addContinuousHandler(handler);
			moving = true;
			drawlayer.fillRect(0,0,drawlayer.imageWidth,drawlayer.imageHeight,0x0);
			//showNextImage( drawlayer );	// 最初の一回の描画を行う(なんかできなかったのでとりあえずクリア)
		}
	}
	function CreateDrawLayer( parent, target, index ) {
		target.type = ltAddAlpha;
		target.face = dfAddAlpha;
		target.absolute = 100000;
		target.visible = false;
	}

	function stop() {
		if(moving) {
			System.removeContinuousHandler(handler);
			moving = false;
		}
		super.stop();
	}

	function setNextMovieFile( storage ) {
		super.setNextMovieFile( storage );
		hasNext = true;
	}

//	interval > scale * 1000 / Rate
//	interval * rate / scale > 1000

	function handler(tick) {
		var		interval = tick - lastTick;
		var		rate = (int)( interval * FPSRate / FPSScale + remain );
		if( rate > 1000 ) {
			var ret = showNextImage( drawlayer );
			if( currentLoop == false ) {
				if( ret == (currentNumberOfFrame-1) ) {
					if( hasNext == false ) {
						stop();
						kag.trigger( "finish_alpha_movie_" + slot );
					} else {
						hasNext = false;
						currentNumberOfFrame = numOfFrame;
						currentLoop = loop;
						kag.trigger( "next_alpha_movie_" + slot );
					}
				}
			}else{
				if( ret == (currentNumberOfFrame-1) && spLoop && numOfFrame < 48 ){
					frame = 48;
				}
			}
			lastTick = tick;
			remain = rate - 1000;
		}
		OutputLayer.fillRect(0,0,OutputLayer.width,OutputLayer.height,0x0);
		OutputLayer.piledCopy(0,0,drawlayer,0,0,OutputLayer.width,OutputLayer.height);
	}

	property absolute {
		getter { return drawlayer.absolute; }
		setter(x) { drawlayer.absolute = x; }
	}
	property type {
		getter { return drawlayer.type; }
		setter(x) { drawlayer.type = x; }
	}
	property face {
		getter { return drawlayer.face; }
		setter(x) { drawlayer.face = x; }
	}
	property visible {
		getter { return movieVisible; }
		setter(x) {
			movieVisible = x;
			if( movieVisible == false ) {
				drawlayer.visible = false;
			}else{
				drawlayer.visible = true;
			}
		}
	}
	property OutputLayer {
		getter { return OutputLayer; }
		setter(x) { OutputLayer = x;}
	}
	property width { getter { screenWidth; } }
	property height { getter { screenHeight; } }
	property loop {
		getter { return super.loop; }
		setter(x) { super.loop = x; currentLoop = x; }
	}
	property opacity {
		getter { return drawlayer.opacity; }
		setter(x) { drawlayer.opacity = x; }
	}
}
*/

//作成するレイヤ
class EffectRideEdgeLayer extends Layer{
	var oix;					//OutLineX
	var oiy;					//OutLineY
	var oox;					//OutLineX
	var ooy;					//OutLineY
	var inflag;					//
	var outflag;				//
	
	var RideTmp;					//基本画像のアドレス
	var RideAlpha;
	var RideMode;
	var RideBlend;

	//レイヤ系統
	var standLayer;
	var edgeLayer;
	
	function EffectRideEdgeLayer(win,par){
		super.Layer(win,par);
		oox = 0;
		ooy = 0;
		oix = 0;
		oiy = 0;
		inflag = false;
		outflag = false;
	}
	
	function finalize(){
		super.finalize(...);
	}

	//敷き詰める処理
	function loadImages(elm){
		standLayer = new global.CharacterLayer(this.window,this);
		standLayer.absolute = 1100;
		edgeLayer = new global.CharacterLayer(this.window,this);
		edgeLayer.absolute = 200;
		
		standLayer.loadImages(%[storage:elm.storage]);
		standLayer.setSizeToImageSize();
		SetupRide(elm);
		DrawEdge(elm);
		
		invalidate standLayer;
		invalidate edgeLayer;
	}

	function SetupRide(elm){

		oix = (elm.oix !== void) ? +elm.oix:0;
		oiy = (elm.oiy !== void) ? +elm.oiy:0;
		oox = (elm.oox !== void) ? +elm.oox:0;
		ooy = (elm.ooy !== void) ? +elm.ooy:0;

		if(oix != 0 || oiy != 0){inflag = true;}else{inflag = false;}
		if(oox != 0 || ooy != 0){outflag = true;}else{outflag = false;}
		
		RideAlpha = void;
		RideTmp = void;
		var tmp = [].split("(), ", elm.ride, , true);
		if(tmp[0] !== void){ RideAlpha = effect_object[+tmp[0]].targetLayer;}else{ RideAlpha = effect_object[0].targetLayer;}
		if(tmp[1] !== void){ RideTmp = effect_object[+tmp[1]].targetLayer;}else{ RideTmp = effect_object[0].targetLayer;}
		
		RideMode = ltAlpha;
		if(elm.ridemode !== void) RideMode = imageTagLayerType[elm.ridemode].type;
		RideBlend = (elm.rideblend !== void) ? +elm.rideblend : 255;
	}
	
	function DrawEdge(elm){

		if(inflag || outflag){
			
			//ボカシ用の画面拡張
			edgeLayer.setImageSize(standLayer.imageWidth+(oox*2), standLayer.imageHeight+(ooy*2));
			edgeLayer.setSizeToImageSize();
			edgeLayer.fillRect(0,0,edgeLayer.imageWidth,edgeLayer.imageHeight,0x0);
			edgeLayer.copyRect(oox,ooy,standLayer,0,0,standLayer.imageWidth,standLayer.imageHeight);
			
			standLayer.assignImages(edgeLayer);
			standLayer.setSizeToImageSize();

			var tmp = new global.Layer(kag, kag.fore.base);
			
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
					edgeLayer.assignImages(standLayer);
					edgeLayer.setSizeToImageSize();
				}
				edgeLayer.turnAlpha();
				edgeLayer.doBoxBlur(oox, ooy);
				edgeLayer.operateRect(0, 0, standLayer, 0, 0, standLayer.imageWidth, standLayer.imageHeight, omAuto, 255);
				edgeLayer.turnAlpha();
			}
			
			if(inflag && outflag){
				edgeLayer.operateRect(0, 0, tmp, 0, 0, tmp.imageWidth, tmp.imageHeight, omAuto, 255);
			}

			edgeLayer.AlphaColorRect(255, 0, 0);

			this.assignImages(edgeLayer);
			this.setSizeToImageSize();
			
			invalidate tmp;
			invalidate edgeLayer;
		}else{
			dm("ERROR");
		}
	}
}


//敷き詰め画像を作成するレイヤ
class FullPaintLayer extends Layer{
	var tmp;
	function FullPaintLayer(win,par){
		super.Layer(win,par);
		tmp = new global.Layer(this.window,this);
	}
	
	function finalize(){
		invalidate tmp;
		super.finalize(...);
	}

	//敷き詰める処理
	function loadImages(storage){
		tmp.loadImages(storage);
		tmp.setSizeToImageSize();
	}

	function FullPaint(w,h){
		var xcnt = w \ tmp.width;
		var ycnt = h \ tmp.height;
		this.setImageSize(xcnt*tmp.width,ycnt*tmp.height);
		this.setSizeToImageSize();
		this.fillRect(0,0,this.width,this.height,0x0);
		for(var i=0;i<xcnt;i++){
			for(var j=0;j<ycnt;j++){
				this.copyRect(i*tmp.width,j*tmp.height,tmp,0,0,tmp.width,tmp.height);
			}
		}
	}
}

//*テストソース//
//アニメーションを管理する機能
class SyncPathScriptLeaderController{
	var owner;						//このクラスを管理するオブジェクトのアドレス
	var pathSlot = [];
	
	function SyncPathScriptLeaderController(own){
		owner = own;
	}

	//終了準備
	function finalize(){
		for(var i = 0; i < pathSlot.count; i++) invalidate pathSlot[i];
		pathSlot.clear();
	}

	function AddPathSlot( cl, path, time, accel = void, sync = -1){
		pathSlot.add(new SyncPathScriptLeader(this, cl));
		var cnt = pathSlot.count -1;
		pathSlot[cnt].SetupPath(path, time, accel);
		if(sync != -1){
			pathSlot[cnt].AddSyncParent(pathSlot[sync]);
			pathSlot[sync].AddSyncChild(pathSlot[cnt]);
		}
	}

	function Play(){
		for(var i = 0; i < pathSlot.count; i++) pathSlot[i].Play();
	}

	function SetupEnvironment(elm){
		for(var i = 0; i < pathSlot.count; i++) pathSlot[i].SetupEnvironment(elm);
	}

	function PosCorrection(num, cx, cy){
		pathSlot[num].PosCorrection(cx, cy);
	}
	
	function onTag(elm)
	{
		owner.onTag(elm);
	}

	function IsSlotBehaviorArea(num){
		return pathSlot[num].BehaviorArea();
	}
	
	
	/*
	function IsOwner()
	{
		return owner;
	}
	*/
}

//

class SyncPathScriptLeader{
	var owner;				//このクラスを管理するオブジェクトのアドレス
	var client;				//アニメーションを実行するレイヤのアドレスを格納
	var syncParent = -1;	//
	var syncClild = [];		//

	var max;				//アニメーションの最大のコマ数
	var count;				//アニメーションの現在のコマ数
	var loop;				//アニメーションのループ再生フラグ
	var reverse;			//アニメーションの逆再生フラグ
	var turn;				//アニメーションの折り返し再生フラグ

	var startTime = 0;
	
	var s_interval = [];	// スクリプト上で指定された時間配列
	var s_accel = [];		// スクリプト上で指定されたアクセル配列
	var s_pl = [];			// スクリプト上で指定された左上座標配列Ｘ
	var s_pt = [];			// スクリプト上で指定された左上座標配列Ｙ
	var s_pa = [];			// スクリプト上で指定されたα値配列

	var interval = [];		// 動作中に使用する時間配列
	var accel = [];			// 動作中に使用するアクセル配列
	var pl = [];			// 動作中に使用する左上座標配列Ｘ
	var pt = [];			// 動作中に使用する左上座標配列Ｙ
	var pa = [];			// 動作中に使用するα値配列
	
	var nl = 0;				// 現在のleft
	var nt = 0;				// 現在のtop
	var na = 255;			// 現在のopacity

	var ml = 0;
	var mr = 0;
	var mt = 0;
	var mb = 0;
	//初期化
	function SyncPathScriptLeader(own,cl){
		owner = own;										//このクラスを管理するオブジェクトのアドレスの格納
		client = cl;										//アニメーションを実行するレイヤを格納
		init();
	}

	//終了準備
	function finalize(){
		Stop();
		ClearInitPathData();							//記録アニメーションデータの削除
		ClearPlayPathData();							//実行アニメーションデータの削除
		syncClild.clear();
	}

	function AddSyncParent(parent){
		syncParent = parent;
	}
	
	function AddSyncChild(clild){
		syncClild.add(clild);
	}

	//記録アニメーションデータの削除
	function ClearInitPathData(){
		s_interval.clear();									//配列の初期化
		s_accel.clear();									//配列の初期化
		s_pl.clear();										//配列の初期化
		s_pt.clear();										//配列の初期化
		s_pa.clear();										//配列の初期化
		
	}

	//実行アニメーションデータの削除
	function ClearPlayPathData(){
		interval.clear();									//配列の初期化
		accel.clear();										//配列の初期化
		pl.clear();											//配列の初期化
		pt.clear();											//配列の初期化
		pa.clear();											//配列の初期化
	}

	//アニメーションの開始コマンド
	function Play(){
		SetupArray();									// 実行アニメーションデータを格納
		startTime = System.getTickCount();				// 実行時間の取得
		count = 0;										// 開始コマにカウントを移行
		client.setPos(pl[count], pt[count]);			// 初期位置を指定
		client.opacity = pa[count];						// 不透明度の変更
		System.addContinuousHandler(DrawPath);			// システムハンドラに追加
	}

	//アニメーションの停止コマンド
	function Stop(){
		System.removeContinuousHandler(DrawPath);
	}
	
	//基本初期化
	function init(){
		nl = 0;											//
		nt = 0;											//
		na = 255;										//
		max = 0;										//初期化【最大コマ】
		count = 0;										//初期化【現在コマ】
		loop = true;									//初期化【ループ再生フラグ】
	}
	
	//アニメーションの実行動作
	function DrawPath(tick){
		//dm("動作中");
		CountUp(tick);									//
		var nowTime = tick - startTime;
		if(count != max){
			var nowAccel = accel[count];
			var space = interval[count + 1] - interval[count];
			var remainder = nowTime - interval[count];
			if(nowAccel < 0){
				// 上弦 ( 最初が動きが早く、徐々に遅くなる )
				remainder = 1.0 - remainder / space;
				remainder = Math.pow(remainder, -nowAccel);
				remainder = int ( (1.0 - remainder) * space );
			}else if(nowAccel > 0){
				// 下弦 ( 最初は動きが遅く、徐々に早くなる )
				remainder = remainder / space;
				remainder = Math.pow(remainder, nowAccel);
				remainder = int ( remainder * space );
			}
			var parsent = remainder / space;
			
			nl = (int)(pl[count] + (pl[count + 1] - pl[count]) * parsent);
			nt = (int)(pt[count] + (pt[count + 1] - pt[count]) * parsent);
			na = (int)(pa[count] + (pa[count + 1] - pa[count]) * parsent);
		}else{
			nl = pl[max - 1];
			nt = pt[max - 1];
			na = pa[max - 1];
		}
		
		client.setPos(nl, nt);						//
		client.opacity = na;						//
		owner.onTag(%[]);							//管理クラスの更新を行う
	}
	
	function DrawChildPath(tick){
		CountUp(tick);									//
		var nowTime = tick - startTime;
		if(count != max){
			var space = interval[count + 1] - interval[count];
			var parsent = (nowTime - interval[count]) / space;
			nl = (int)(pl[count] + (pl[count + 1] - pl[count]) * parsent);
			nt = (int)(pt[count] + (pt[count + 1] - pt[count]) * parsent);
			na = (int)(pa[count] + (pa[count + 1] - pa[count]) * parsent);
		}else{
			nl = pl[count];
			nt = pt[count];
			na = pa[count];
		}
		//dm("(" + nl + "," + nt + "," + na + ")");
		client.setPos(nl, nt);						//
		client.opacity = na;						//
	}
	
	function CountUp(tick){
		var nowTime = tick - startTime;
		for(var i = count; i < interval.count; i++){
			if(interval[i] >= nowTime) break;
			else count = i;
		}
		
		if(count >= max){									//最大を越えた処理
			if(loop){
				//内部処理
				count = 0;									//最初のコマに戻す
				for(var i = 1; nowTime - interval[max] * i > 0 ; i++){
					startTime += interval[max];
				}
				CountUp(tick);
			}else{
				count = max;								//最終コマで停止
				Stop();										//停止
			}
		}
	}

	//アニメーションの基本動作の格納
	function SetupEnvironment(elm){
		loop = (elm.tloop !== void) ? +elm.tloop : false;			//アニメーションのループ再生のフラグ
		reverse = (elm.treverse !== void) ? elm.treverse : false;	//アニメーションの逆再生のフラグ
		turn = (elm.tturn !== void) ? elm.tturn : false;			//アニメーションの折り返し再生のフラグ
	}
	
	//アニメーションデータの格納
	function SetupPath(path, time, accel){
		ClearInitPathData();
		var itmp = [].split(",()", time, , true);
		for(var i = 0; i < itmp.count; i++) s_interval.add(+itmp[i]);

		if(accel !== void){
			var atmp = [].split(",()", accel, , true);
			for(var i = 0; i < atmp.count; i++) s_accel.add(+atmp[i]);
		}else{
			for(var i = 0; i < itmp.count; i++) s_accel.add(0);
		}
		
		var ptmp = [].split(",()", path, , true);
		for(var i = 0; i * 3 < ptmp.count; i++){
			var tnum = i * 3;
			s_pl.add(+ptmp[tnum]);
			s_pt.add(+ptmp[tnum + 1]);
			s_pa.add(+ptmp[tnum + 2]);
		}

		ml = s_pl[0];
		mr = s_pl[0];
		mt = s_pt[0];
		mb = s_pt[0];
		for(var i = 1; i < s_pl.count; i++){
			if(ml > s_pl[i]) ml = s_pl[i];
			else if(mr < s_pl[i]) mr = s_pl[i];
			if(mt > s_pt[i]) mt = s_pt[i];
			else if(mb < s_pt[i]) mb = s_pt[i];
		}
		mr += client.width;
		mb += client.height;
	}

	function BehaviorArea(){
		return [ml, mr, mt, mb];
	}

	function PosCorrection(cx, cy){
		for(var i = 0; i < s_pl.count; i++) s_pl[i] += cx;
		for(var i = 0; i < s_pt.count; i++) s_pt[i] += cy;
	}
	
	//実行アニメーションデータを格納
	function SetupArray(){
		ClearPlayPathData();					//実行アニメーションデータの削除
		if(reverse){
			var tTime = 0;
			for(var i=0;i<s_pl.count;i++){
				interval.insert(0,tTime);			//逆格納【インターバル】
				accel.insert(0,s_accel[i]);				//配列の初期化
				pl.insert(0,s_pl[i]);				//逆格納【画像左端Ｘ座標】
				pt.insert(0,s_pt[i]);				//逆格納【画像左端Ｙ座標】
				pa.insert(0,s_pa[i]);				//逆格納【画像左端Ｙ座標】
				tTime += s_interval[i];
			}
			interval.add(tTime);					//逆格納【インターバル】
		}else{
			var tTime = 0;
			for(var i=0;i<s_pl.count;i++){
				interval.add(tTime);				//順格納【インターバル】
				accel.add(s_accel[i]);				//配列の初期化
				pl.add(s_pl[i]);					//順格納【画像左端Ｘ座標】
				pt.add(s_pt[i]);					//順格納【画像左端Ｙ座標】
				pa.add(s_pa[i]);					//順格納【画像左端Ｙ座標】
				tTime += s_interval[i];
			}
			
			if(turn){
				for(var i=s_pl.count-1;i>=0;i--){
					interval.add(tTime);			//逆格納【インターバル】
					accel.add(s_accel[i]);			//配列の初期化
					pl.add(s_pl[i]);				//逆格納【画像左端Ｘ座標】
					pt.add(s_pt[i]);				//逆格納【画像左端Ｙ座標】
					pa.add(s_pa[i]);				//逆格納【画像左端Ｙ座標】
					tTime += s_interval[i];
				}
				interval.add(tTime);				//逆格納【インターバル】
			}else{
				interval.add(tTime);				//逆格納【インターバル】
			}
		}
		max = interval.count-1;						//

	}
}

//***//
//*テストソース//
//アニメーションを管理する機能
class SyncAnimetionScriptLeaderController{
	var owner;						//このクラスを管理するオブジェクトのアドレス
	var animetionSlot = [];
	
	function SyncAnimetionScriptLeaderController(own){
		owner = own;
	}

	//終了準備
	function finalize(){
		for(var i = 0; i < animetionSlot.count; i++) invalidate animetionSlot[i];
		animetionSlot.clear();
	}

	function AddAnimetionSlot( cl, asd, sync = -1){
		animetionSlot.add(new SyncAnimetionScriptLeader(this, cl));
		var cnt = animetionSlot.count -1;
		animetionSlot[cnt].SetupAnimetion(asd);
		if(sync != -1){
			animetionSlot[cnt].AddSyncParent(animetionSlot[sync]);
			animetionSlot[sync].AddSyncChild(animetionSlot[cnt]);
		}
	}

	function AddOtherTempAnimetionSlot( child = -1, parent = -1){
		if(child !== -1 && parent !== -1){
			if(animetionSlot.count > 0){
				animetionSlot[0].OtherTempParent(parent);
				CallIdObjectAnimationSlotController(parent).animetionSlot[0].OtherTempChild(child);
			}
		}
	}

	function UpdateFunctionAdress(){
		if(animetionSlot.count > 0) return animetionSlot[0].UpdateFunctionAdress();
		return void;
	}
	
	/*
	function AddAnimetionScriptSlot( cl, path, sync = -1){
		animetionSlot.add(new SyncAnimetionScriptLeader(this, cl));
		var cnt = animetionSlot.count -1;
		animetionSlot[cnt].SetupAnimetionScript(path);
		if(sync != -1){
			animetionSlot[cnt].AddSyncParent(animetionSlot[sync]);
			animetionSlot[sync].AddSyncChild(animetionSlot[cnt]);
		}
	}
	*/

	function Play(){
		for(var i = 0; i < animetionSlot.count; i++) animetionSlot[i].Play();
	}

	function SetupEnvironment(elm){
		for(var i = 0; i < animetionSlot.count; i++) animetionSlot[i].SetupEnvironment(elm);
	}

	function onTag(elm)
	{
		owner.onTag(elm);
	}

	function IsAnimetionCount(num){
		return animetionSlot[num].IsAnimetionCount();
	}
	/*
	function IsOwner()
	{
		return owner;
	}
	*/
}

//

class SyncAnimetionScriptLeader{
	var owner;				//このクラスを管理するオブジェクトのアドレス
	var client;				//アニメーションを実行するレイヤのアドレスを格納
	var syncParent = -1;	//
	var syncClild = [];		//
	
	var cw;					//画像表示区域の横幅【ClipWidth】
	var ch;					//画像表示区域の縦幅【ClipHeight】
	

	var animetion;			//アニメーションの動作フラグ
	var animetionTimer;		//アニメーション用のタイマー
	
	var start;				//アニメーションの開始のコマ数
	//var loop_start;		//アニメーションの開始のコマ数
	var end;				//アニメーションの開始のコマ数
	
	var max;				//アニメーションの最大のコマ数
	var count;				//アニメーションの現在のコマ数
	var loop;				//アニメーションのループ再生フラグ
	var reverse;			//アニメーションの逆再生フラグ
	var turn;				//アニメーションの折り返し再生フラグ
	
	
	var s_interval = [];	//一コマあたりのインターバル
	var s_acl = [];			//一コマの画像位置の配列【左上Ｘ座標】[AnimetionClipLeft]
	var s_act = [];			//一コマの画像位置の配列【左上Ｙ座標】[AnimetionClipTop]

	var interval = [];		//実行する一コマあたりのインターバル
	var acl = [];			//実行する一コマの画像位置の配列【左上Ｘ座標】[AnimetionClipLeft]
	var act = [];			//実行する一コマの画像位置の配列【左上Ｙ座標】[AnimetionClipTop]

	var averageInterval;	//
	var other = void;
	
	//初期化
	function SyncAnimetionScriptLeader(own,cl){
		owner = own;										//このクラスを管理するオブジェクトのアドレスの格納
		client = cl;										//アニメーションを実行するレイヤを格納
		averageInterval = -1;								//
		animetionTimer = new Timer(DrawAnimetion, '');		//タイマーの初期セット
		animetionTimer.enabled = false;						//タイマーの初期セット
		animetionTimer.interval = 100;						//タイマーの初期セット
		init();
	}

	//終了準備
	function finalize(){
		animetionTimer.enabled = false;						//タイマーを終了
		invalidate animetionTimer;							//タイマーの終了準備
		ClearInitAnimetionData();							//記録アニメーションデータの削除
		ClearPlayAnimetionData();							//実行アニメーションデータの削除
		syncClild.clear();
		other = void;
	}

	function AddSyncParent(parent){
		syncParent = parent;
		animetion = false;
	}
	
	function AddSyncChild(clild){
		syncClild.add(clild);
	}

	function OtherTempParent(obj){
		animetion = false;
	}

	function OtherTempChild(obj){
		other = CallIdObjectAnimationSlotController(obj).UpdateFunctionAdress();
	}
	
	//記録アニメーションデータの削除
	function ClearInitAnimetionData(){
		s_interval.clear();									//配列の初期化
		s_acl.clear();										//配列の初期化
		s_act.clear();										//配列の初期化
		
	}

	//実行アニメーションデータの削除
	function ClearPlayAnimetionData(){
		interval.clear();										//配列の初期化
		acl.clear();											//配列の初期化
		act.clear();											//配列の初期化
		other = void;
	}

	//アニメーションの開始コマンド
	function Play(){
		SetupArray();										//実行アニメーションデータを格納
		count = start;										//開始コマにカウントを移行
		client.setImagePos(acl[count], act[count]);			//初期位置を指定
		animetionTimer.interval = interval[count];			//次回インターバルを設定
		animetionTimer.enabled = animetion;					//アニメーションの実行を許可
		//dm("Play："+animetion);
	}

	//アニメーションの停止コマンド
	function Stop(){ animetionTimer.enabled = false;}		//アニメーションの実行を不可
	
	//基本初期化
	function init(){
		cw = 12;											//初期化【横幅】
		ch = 12;											//初期化【縦幅】
		start = 0;											//初期化【開始コマ】
		max = 0;											//初期化【最大コマ】
		count = 0;											//初期化【現在コマ】
		loop = false;										//初期化【ループ再生フラグ】
	}

	function IsAnimetionCount(){
		return s_interval.count;
	}
	
	//アニメーションの実行動作
	function DrawAnimetion(){
		//dm("動作中");
		CountUp();											//
		client.setImagePos(acl[count], act[count]);			//
		animetionTimer.interval = interval[count];			//

		for(var i = 0; i < syncClild.count; i++){
			syncClild[i].DrawChildAnimetion();
		}

		if(other !== void) other();
		
		owner.onTag(%[]);									//管理クラスの更新を行う
	}

	function DrawChildAnimetion(){
		CountUp();											//
		client.setImagePos(acl[count], act[count]);			//
		animetionTimer.interval = interval[count];			//
	}
	
	function CountUp(){
		count++;											//コマを先送り
		if(count > max){									//最大を越えた処理
			if(loop){
				count = 0;									//最初のコマに戻す
			}else{
				count = max;								//最終コマで停止
				Stop();										//停止
			}
		}
	}

	//アニメーションの基本動作の格納
	function SetupEnvironment(elm){
		start = (elm.anm_start !== void) ? +elm.anm_start : 0;			//アニメーションの開始コマ
		end = (elm.anm_end !== void) ? +elm.anm_end : 0;				//アニメーションの終了コマ
		loop = (elm.anm_loop !== void) ? elm.anm_loop : true;			//アニメーションのループ再生のフラグ
		reverse = (elm.anm_reverse !== void) ? elm.anm_reverse : false;	//アニメーションの逆再生のフラグ
		turn = (elm.anm_turn !== void) ? elm.anm_turn : false;			//アニメーションの折り返し再生のフラグ
		animetion = (elm.anm !== void) ? elm.anm : true;				//アニメーションの動作
		averageInterval = (elm.interval !== void) ? +elm.interval : -1;	//アニメーションの動作
	}
	
	//アニメーションデータの格納
	function SetupAnimetion(asd){
		ClearInitAnimetionData();
		var tmp = [].load(asd + ".asd");
		var cmd_d = -1;
		var cmd_s = 0;
		var cmd_e = tmp.count-1;
		for(var i = 0; i < tmp.count; i++){
			if(tmp[i].substr(0,1) == ";"){cmd_d = i;}
			if(tmp[i].substr(0,5) == "*loop"){cmd_s = i;}
			if(tmp[i].substr(0,5) == "@jump"){cmd_e = i;}
		}

		var data = tmp[cmd_d].split(" ;/=",,true);						//列のデータを解体
		var dmp = %[];													//パラメータ用
		for(var j=1;j < data.count;j+=2){ dmp[data[j]] = +data[j+1];}	//パラメータを辞書配列化
		cw = dmp.clipwidth;												//初期値を格納横幅
		ch = dmp.clipheight;											//初期値を格納縦幅
		client.setSize(cw,ch);											//初期値を格納縦幅
		data.clear();													//使用した仮配列の初期化
		(Dictionary.clear incontextof dmp)();							//使用した仮配列の初期化
		
		for(var i = cmd_s; i < cmd_e; i++){
			var line = tmp[i].split(" ;/=",,true);	//列のデータを解体
			var mp = %[];							//パラメータ用
			
			//パラメータを辞書配列化
			for(var j=1;j < line.count;j+=2){ mp[line[j]] = +line[j+1];}

			
			if(line[0] == "@wait"){
				if(averageInterval == -1){
						s_interval.add(mp.time);	//時間の格納
				}else{
					s_interval.add(averageInterval);
				}
			}
			if(line[0] == "@clip"){
				s_acl.add(-1 * mp.left);					//ImageLeftなのでマイナスの値になる
				s_act.add(-1 * mp.top);						//ImageTopなのでマイナスの値になる
			}
			
			line.clear();
			(Dictionary.clear incontextof mp)();
		}
	}

	/*
	function SetupAnimetionScript(path){
		ClearInitAnimetionData();
		var asd = [].split(",()", path, , true);
	}
	*/
	
	//実行アニメーションデータを格納
	function SetupArray(){
		ClearPlayAnimetionData();					//実行アニメーションデータの削除
		if(reverse){
			for(var i=0;i<s_interval.count;i++){
				interval.insert(0,s_interval[i]);	//逆格納【インターバル】
				acl.insert(0,s_acl[i]);				//逆格納【画像左端Ｘ座標】
				act.insert(0,s_act[i]);				//逆格納【画像左端Ｙ座標】
			}
		}else{
			for(var i=0;i<s_interval.count;i++){
				interval.add(s_interval[i]);		//順格納【インターバル】
				acl.add(s_acl[i]);					//順格納【画像左端Ｘ座標】
				act.add(s_act[i]);					//順格納【画像左端Ｙ座標】
			}
			
			if(turn){
				for(var i=s_interval.count-1;i>=0;i--){
					interval.add(s_interval[i]);	//逆格納【インターバル】
					acl.add(s_acl[i]);				//逆格納【画像左端Ｘ座標】
					act.add(s_act[i]);				//逆格納【画像左端Ｙ座標】
				}
			}
		}
		max = interval.count-1;						//
		if(end != 0){max = end;}					//最大
	}

	function UpdateFunctionAdress(){
		return DrawAnimetion;
	}
}
//***//



//アニメーションを管理する機能
class AnimetionScriptLeader{
	var owner;				//このクラスを管理するオブジェクトのアドレス
	var client;				//アニメーションを実行するレイヤのアドレスを格納
	var cw;					//画像表示区域の横幅【ClipWidth】
	var ch;					//画像表示区域の縦幅【ClipHeight】

	var animetion;			//アニメーションの動作
	
	var start;				//アニメーションの開始のコマ数
	//var loop_start;		//アニメーションの開始のコマ数
	var end;				//アニメーションの開始のコマ数
	
	var max;				//アニメーションの最大のコマ数
	var count;				//アニメーションの現在のコマ数
	var loop;				//アニメーションのループ再生フラグ
	var reverse;			//アニメーションの逆再生フラグ
	var turn;				//アニメーションの折り返し再生フラグ
	
	var AnimetionTimer;		//アニメーション用のタイマー
	
	var s_interval = [];	//一コマあたりのインターバル
	var s_acl = [];			//一コマの画像位置の配列【左上Ｘ座標】[AnimetionClipLeft]
	var s_act = [];			//一コマの画像位置の配列【左上Ｙ座標】[AnimetionClipTop]

	var interval = [];		//実行する一コマあたりのインターバル
	var acl = [];			//実行する一コマの画像位置の配列【左上Ｘ座標】[AnimetionClipLeft]
	var act = [];			//実行する一コマの画像位置の配列【左上Ｙ座標】[AnimetionClipTop]

	var AverageInterval;	//
	
	//初期化
	function AnimetionScriptLeader(own,cl){
		owner = own;										//このクラスを管理するオブジェクトのアドレスの格納
		client = cl;										//アニメーションを実行するレイヤを格納
		AverageInterval = -1;								//
		AnimetionTimer = new Timer(DrawAnimetion, '');		//タイマーの初期セット
		AnimetionTimer.enabled = false;						//タイマーの初期セット
		AnimetionTimer.interval = 100;						//タイマーの初期セット
	}

	//終了準備
	function finalize(){
		AnimetionTimer.enabled = false;						//タイマーを終了
		invalidate AnimetionTimer;							//タイマーの終了準備
		ClearInitAnimetionData();							//記録アニメーションデータの削除
		ClearPlayAnimetionData();							//実行アニメーションデータの削除
	}

	//記録アニメーションデータの削除
	function ClearInitAnimetionData(){
		s_interval.clear();									//配列の初期化
		s_acl.clear();										//配列の初期化
		s_act.clear();										//配列の初期化
		
	}

	//実行アニメーションデータの削除
	function ClearPlayAnimetionData(){
		interval.clear();										//配列の初期化
		acl.clear();											//配列の初期化
		act.clear();											//配列の初期化
	}

	//アニメーションの開始コマンド
	function Play(){
		SetupArray();										//実行アニメーションデータを格納
		count = start;										//開始コマにカウントを移行
		client.setImagePos(acl[count], act[count]);			//初期位置を指定
		AnimetionTimer.interval = interval[count];			//次回インターバルを設定
		AnimetionTimer.enabled = animetion;					//アニメーションの実行を許可
		//dm("実行中："+animetion);
	}

	//アニメーションの停止コマンド
	function Stop(){ AnimetionTimer.enabled = false;}		//アニメーションの実行を不可
	
	//基本初期化
	function init(){
		cw = 12;											//初期化【横幅】
		ch = 12;											//初期化【縦幅】
		start = 0;											//初期化【開始コマ】
		max = 0;											//初期化【最大コマ】
		count = 0;											//初期化【現在コマ】
		loop = false;										//初期化【ループ再生フラグ】
	}
	
	//アニメーションの実行動作
	function DrawAnimetion(){
		CountUp();											//
		client.setImagePos(acl[count], act[count]);			//
		AnimetionTimer.interval = interval[count];			//
		owner.onTag(%[]);									//管理クラスの更新を行う
	}

	function CountUp(){
		count++;											//コマを先送り
		if(count > max){									//最大を越えた処理
			if(loop){
				count = 0;									//最初のコマに戻す
			}else{
				count = max;								//最終コマで停止
				Stop();										//停止
			}
		}
	}

	//アニメーションの基本動作の格納
	function SetupEnvironment(elm){
		start = (elm.anm_start !== void) ? +elm.anm_start : 0;			//アニメーションの開始コマ
		end = (elm.anm_end !== void) ? +elm.anm_end : 0;				//アニメーションの終了コマ
		loop = (elm.anm_loop !== void) ? elm.anm_loop : true;			//アニメーションのループ再生のフラグ
		reverse = (elm.anm_reverse !== void) ? elm.anm_reverse : false;	//アニメーションの逆再生のフラグ
		turn = (elm.anm_turn !== void) ? elm.anm_turn : false;			//アニメーションの折り返し再生のフラグ
		animetion = (elm.anm !== void) ? elm.anm : true;				//アニメーションの動作
		AverageInterval = (elm.interval !== void) ? +elm.interval : -1;	//アニメーションの動作
	}
	
	//アニメーションデータの格納
	function SetupAnimetion(asd){
		ClearInitAnimetionData();
		var tmp = [].load(asd + ".asd");
		var cmd_d = -1;
		var cmd_s = 0;
		var cmd_e = tmp.count-1;
		for(var i = 0; i < tmp.count; i++){
			if(tmp[i].substr(0,1) == ";"){cmd_d = i;}
			if(tmp[i].substr(0,5) == "*loop"){cmd_s = i;}
			if(tmp[i].substr(0,5) == "@jump"){cmd_e = i;}
		}

		var data = tmp[cmd_d].split(" ;/=",,true);						//列のデータを解体
		var dmp = %[];													//パラメータ用
		for(var j=1;j < data.count;j+=2){ dmp[data[j]] = +data[j+1];}	//パラメータを辞書配列化
		cw = dmp.clipwidth;												//初期値を格納横幅
		ch = dmp.clipheight;											//初期値を格納縦幅
		client.setSize(cw,ch);											//初期値を格納縦幅
		data.clear();													//使用した仮配列の初期化
		(Dictionary.clear incontextof dmp)();							//使用した仮配列の初期化
		
		for(var i = cmd_s; i < cmd_e; i++){
			var line = tmp[i].split(" ;/=",,true);	//列のデータを解体
			var mp = %[];							//パラメータ用
			
			//パラメータを辞書配列化
			for(var j=1;j < line.count;j+=2){ mp[line[j]] = +line[j+1];}

			
			if(line[0] == "@wait"){
				if(AverageInterval == -1){
						s_interval.add(mp.time);	//時間の格納
				}else{
					s_interval.add(AverageInterval);
				}
			}
			if(line[0] == "@clip"){
				s_acl.add(-1 * mp.left);					//ImageLeftなのでマイナスの値になる
				s_act.add(-1 * mp.top);						//ImageTopなのでマイナスの値になる
			}
			
			line.clear();
			(Dictionary.clear incontextof mp)();
		}
	}

	//実行アニメーションデータを格納
	function SetupArray(){
		ClearPlayAnimetionData();					//実行アニメーションデータの削除
		if(reverse){
			for(var i=0;i<s_interval.count;i++){
				interval.insert(0,s_interval[i]);	//逆格納【インターバル】
				acl.insert(0,s_acl[i]);				//逆格納【画像左端Ｘ座標】
				act.insert(0,s_act[i]);				//逆格納【画像左端Ｙ座標】
			}
		}else{
			for(var i=0;i<s_interval.count;i++){
				interval.add(s_interval[i]);		//順格納【インターバル】
				acl.add(s_acl[i]);					//順格納【画像左端Ｘ座標】
				act.add(s_act[i]);					//順格納【画像左端Ｙ座標】
			}
			
			if(turn){
				for(var i=s_interval.count-1;i>=0;i--){
					interval.add(s_interval[i]);	//逆格納【インターバル】
					acl.add(s_acl[i]);				//逆格納【画像左端Ｘ座標】
					act.add(s_act[i]);				//逆格納【画像左端Ｙ座標】
				}
			}
		}
		max = interval.count-1;						//
		if(end != 0){max = end;}					//最大
	}
}


// 立ち絵を読み込めるようにするためのクラス
class AutoPiledLayer extends Layer
{
	//使用するレイヤ
	var baseLayer;
	var moldLayer;
	var bgLayer;
	var bgAlphaLayer;
	var frameLayer;
	var limitLayer;
	var charaLayer;
	var standLayer;
	var cutinLayer;
	var bindLayer;
	var wordLayer;
	var fpLayer;
	var ereLayer;

	//var sbLayer = [];	//SpeachBallownLayer
	
	var timer;

	//ムービー系
	var movie;
	var movieLayer;
	var BackupFrontLayer;
	var BackupBackLayer;
	//var SLAMP;

	var w = 250;
	var h = 178;

	//外部操作用
	var owner = void;

	//レイヤアニメーション動作用
	var asl;
	var syncAsl = void;
	var syncPath = void;
	var halfMask = -1;
	var sbCount = 0;
	
	//画像操作系
	var aemask = void;			//ボックスブラーの二度掛け
	var alphaturn = false;		//
	var color;					//動作色調変化
	var a_r,a_g,a_b;			//色調gamma値
	var rgamma,ggamma,bgamma;	//色調gamma値
	var rfloor,gfloor,bfloor;	//色調floor値
	var rceil,gceil,bceil;		//色調ceil値
	var correct;				//背景効果
	var grayscale;				//モノクロ化フラグ
	var sepia;					//セピア化フラグ
	var turn;					//色調反転
	var flip_lr = false;		//左右反転
	var flip_ud = false;		//上下反転
	var bblur;
	var bbx,bby;
	var bbe,bbs;
	var EffectLight;			//明度とコントラスト
	var brightness;				//brightness	明度 -255 ～ 255, 負数の場合は暗くなる
	var contrast;				//contrast		コントラスト -100 ～100, 0 の場合変化しない
	var EffectColorize;			//色相と彩度
	var hue;					//基礎パラメータ:色相(HUE)			-180～180 (度)
	var saturation;				//基礎パラメータ:彩度(SATURATION)	-100～100 (%)
	var blend;					//基礎パラメータ:ブレンド 0 (効果なし) ～ 1 (full effect)
	var EffectModulate;			//色相変更
	var erp;					//【ExclusiveReplacementProcessing】
	var erpca;
	var erpcb;
	var erpp;
	//var hue;					//基礎パラメータ:色相(HUE)			-180～180 (度)	※重複するので削除
	//var saturation;			//基礎パラメータ:彩度(SATURATION)	-100～100 (%)	※重複するので削除
	var luminance;				//基礎パラメータ:輝度(luminance)	-100～100 (%)
	var outline;				//輪郭作成用パラメータのフラグ
	var olm = 0;				//輪郭作成用パラメータのフラグ[OutLineMode]
	var olx = 0;				//輪郭作成用パラメータのフラグ[OutLineX]
	var oly = 0;				//輪郭作成用パラメータのフラグ[OutLineY]
	var olt = false;
	var maskBontd = "";			//
	var mbpsx = 0;				//
	var mbpex = 0;				//
	var mbpsy = 0;				//
	var mbpey = 0;				//
	var biasedInline = false;
	var biv = [0,0,0,0];
	
	var BeforeBoxBlurLeft = 0;
	var BeforeBoxBlurWidth = 0;

	var translucent;
	var translucent_r;
	var translucent_g;
	var translucent_b;
	
	//確認用レイヤ
	var testLayer;
	var testLayer2;
	var testLayer3;

	var animation;
	
	function AutoPiledLayer(win, par, storage)
	{
		super.Layer(...);
	}

	function AddEffectFlagCheck(storage,elm){
		if(elm.sanm == "true") elm.anm = "false";						//anmの変数を逆にした処理

		animation = (elm.anm === 'false') ? false : true;
		aemask = (elm.aemask !== void) ? elm.aemask : void;
		alphaturn = (elm.aemaskturn !== void) ? +elm.aemaskturn : false;
		flip_lr = (elm.fliplr == 'true') ? true : false;
		flip_ud = (elm.flipud == 'true') ? true : false;
		color = (elm.movecolor != 'true') ? true : false;
		grayscale = (elm.grayscale == 'true') ? true : false;
		sepia = (elm.sepia == 'true') ? true : false;

		if(storage.substr(0,2) == "st") correct = (elm.correct == 'false') ? false : true;
		else correct = (elm.correct == 'true') ? true : false;
		
		turn = (elm.turn == 'true') ? true : false;
		if(elm.acb === void){
			a_r = (elm.a_r !== void) ? +elm.a_r : -1;
			a_g = (elm.a_g !== void) ? +elm.a_g : -1;
			a_b = (elm.a_b !== void) ? +elm.a_b : -1;
		}else{
			a_r = -1;
			a_g = -1;
			a_b = -1;
		}
		rgamma = (elm.rgamma !== void) ? +elm.rgamma : 1.0;
		ggamma = (elm.ggamma !== void) ? +elm.ggamma : 1.0;
		bgamma = (elm.bgamma !== void) ? +elm.bgamma : 1.0;
		rfloor = (elm.rfloor !== void) ? +elm.rfloor : 0;
		gfloor = (elm.gfloor !== void) ? +elm.gfloor : 0;
		bfloor = (elm.bfloor !== void) ? +elm.bfloor : 0;
		rceil = (elm.rceil !== void) ? +elm.rceil : 255;
		gceil = (elm.gceil !== void) ? +elm.gceil : 255;
		bceil = (elm.bceil !== void) ? +elm.bceil : 255;
		
		EffectLight = (elm.light == 'true') ? true : false;
		brightness = (elm.brightness !== void) ? +elm.brightness : 0;
		contrast = (elm.contrast !== void) ? +elm.contrast : 0;
		
		EffectColorize = (elm.colorize == 'true') ? true : false;
		hue = (elm.hue !== void) ? +elm.hue : 0;
		saturation = (elm.saturation !== void) ? +elm.saturation : 0;
		blend = (elm.blend !== void) ? +elm.blend : 0;
		
		EffectModulate = (elm.modulate == 'true') ? true : false;
		luminance = (elm.luminance !== void) ? +elm.luminance : 0;

		erp = (elm.erp !== void) ? true : false;
		if(erp){
			var s_b = [].split("(), ", elm.erp, , true);
			erpca = (int)s_b[0];
			erpcb = (int)s_b[1];
			erpp = +s_b[2];
		}
		
		if(elm.translucent !== void){
			translucent = true;
			var stl = [].split("(),", elm.translucent, , true);
			translucent_r = (stl[0] !== void) ? +stl[0] : 0;
			translucent_g = (stl[1] !== void) ? +stl[1] : 0;
			translucent_b = (stl[2] !== void) ? +stl[2] : 0;
		}else{
			translucent = false;
		}

		//輪郭用のフラグ
		outline = false;
		olm = 0;
		olx = 0;
		oly = 0;
		if(elm.outline !== void){
			outline = true;
			var ol = [].split("(),", elm.outline, , true);
			olm = (ol[0] !== void) ? +ol[0] : 0;
			olx = (ol[1] !== void) ? +ol[1] : 0;
			oly = (ol[2] !== void) ? +ol[2] : 0;
		}

		olt = false;
		if(elm.olt !== void) olt = true;


		maskBontd = "";
		if(elm.mb !== void){
			var mb = [].split("(),", elm.mb, , true);
			maskBontd = mb[0];
			mbpsx = +mb[1];
			mbpex = +mb[2];
			mbpsy = +mb[3];
			mbpey = +mb[4];
		}

		biasedInline = false;
		if(elm.bi !== void){
			biasedInline = true;
			var bi = [].split("(),", elm.bi, , true);
			for(var i = 0; i < bi.count; i++) biv[i] = +bi[i];
		}

		bbx = (elm.fbbx !== void) ? elm.fbbx : 0;
		bby = (elm.fbby !== void) ? elm.fbby : 0;
		bblur = false;
		if(bbx != 0 || bby != 0) bblur = true;
		bbe = (elm.bbe === "true") ? true : false;
		bbs = (elm.bbs === "true") ? true : false;
	}
	
	function FlipTurnImage(base,child){
		if(flip_lr){
			base.flipLR();
			if(child !== void){
				var Acnt = child.imageWidth \ child.width;
				var tmp = new global.KAGLayer(window, this);
				tmp.assignImages(child);
				child.fillRect(0,0,child.imageWidth,child.imageHeight,0x0);
				for(var i=0; i < Acnt; i++){
					child.copyRect(i*child.width, 0, tmp, (Acnt-1-i)*child.width, 0, child.width, child.height);
				}
				invalidate tmp;
				child.flipLR();
				child.setPos(base.imageWidth - child.width - child.left, child.top);
			}
		}

		if(flip_ud){
			base.flipUD();
			if(child !== void){
				//位置情報の編集
				child.flipUD();
				child.setPos(child.left, base.imageHeight - child.height - child.top);
			}
		}
	}
	
	function test(lay){
		if(testLayer === void){
			testLayer = new global.KAGLayer(kag,kag.fore.base);
			testLayer.absolute = 150000;
			testLayer.visible=true;
		}
		testLayer.assignImages(lay);
		testLayer.setSizeToImageSize();
	}
	
	function test2(lay){
		if(testLayer2 === void){
			testLayer2 = new global.KAGLayer(kag,kag.fore.base);
			testLayer2.absolute = 160000;
			testLayer2.visible=true;
		}
		testLayer2.setPos(0,testLayer.height);
		testLayer2.assignImages(lay);
		testLayer2.setSizeToImageSize();
	}

	function test3(lay){
		if(testLayer3 === void){
			testLayer3 = new global.KAGLayer(kag,kag.fore.base);
			testLayer3.absolute = 170000;
			testLayer3.visible=true;
		}
		testLayer3.setPos(0,testLayer.height+testLayer2.height);
		testLayer3.assignImages(lay);
		testLayer3.setSizeToImageSize();
	}
	
	function LayerAddEffect(base, child=void){
		var AddEffectLayer = new global.Layer(kag,kag.fore.base);
		if(aemask !== void){ AddEffectLayer.assignImages(base);}
		
		if(erp) base.ExclusiveReplacementProcessing(erpca,erpcb,erpp);
		
		if(child !== void){
			if(EffectLight) child.light(brightness, contrast);					/*明度とコントラスト*/
			if(EffectColorize) child.colorize(hue, saturation, blend);			/*色相と彩度*/
			if(EffectModulate) child.modulate( hue, saturation, luminance);		/*色相変更*/
			if(erp) child.ExclusiveReplacementProcessing(erpca,erpcb,erpp);
		}
		
		// 反転
		FlipTurnImage(base,child);

		if(biasedInline){
			var outLineTmp = new global.KAGLayer(window, base);
			outLineTmp.setImageSize(base.width,base.height);
			outLineTmp.setSizeToImageSize();

			var outLineLeft = void;
			var outLineRight = void;
			var outLineTop = void;
			var outLineBottom = void;
			
			if(biv[0] > 0){
				outLineTmp.OutLineLeft(base);
				outLineLeft = new global.KAGLayer(window, outLineTmp);
				outLineLeft.setImageSize(base.width,base.height);
				outLineLeft.setSizeToImageSize();
				outLineLeft.OutLineCorrectionLeft(outLineTmp,biv[0],true);
				outLineLeft.visible = true;
			}

			if(biv[1] > 0){
				outLineTmp.OutLineRight(base);
				outLineRight = new global.KAGLayer(window, outLineTmp);
				outLineRight.setImageSize(base.width,base.height);
				outLineRight.setSizeToImageSize();
				outLineRight.OutLineCorrectionRight(outLineTmp,biv[1],true);
				outLineRight.visible = true;
			}
			
			if(biv[2] > 0){
				outLineTmp.OutLineTop(base);
				outLineTop = new global.KAGLayer(window, outLineTmp);
				outLineTop.setImageSize(base.width,base.height);
				outLineTop.setSizeToImageSize();
				outLineTop.OutLineCorrectionTop(outLineTmp,biv[2],true);
				outLineTop.visible = true;
			}

			if(biv[3] > 0){
				outLineTmp.OutLineBottom(base);
				OutLineBottom = new global.KAGLayer(window, outLineTmp);
				OutLineBottom.setImageSize(base.width,base.height);
				OutLineBottom.setSizeToImageSize();
				OutLineBottom.OutLineCorrectionBottom(outLineTmp,biv[3],true);
				OutLineBottom.visible = true;
			}
			
			outLineTmp.fillRect(0,0,outLineTmp.width,outLineTmp.height,0x0);
			base.fillRect(0,0,base.imageWidth,base.imageHeight,0x0);
			base.piledCopy(0,0,outLineTmp,0,0,outLineTmp.width,outLineTmp.height);
			base.setSizeToImageSize();

			invalidate outLineTmp;
			invalidate outLineLeft if outLineLeft !== void;
			invalidate outLineRight if outLineRight !== void;
		}
		
		if(aemask !== void){ EffectMaskRect(base,AddEffectLayer);}

		if(translucent){
			base.TranslucentColorBlend(translucent_r, translucent_g, translucent_b);
		}

		if(outline){
			var tmp = new global.KAGLayer(window, this);
			var tmp2 = new global.KAGLayer(window, this);
			var tmp3 = new global.KAGLayer(window, this);
			
			//ボカシ用の画面拡張
			tmp.setImageSize(base.imageWidth+(olx*2), base.imageHeight+(oly*2));
			tmp.setSizeToImageSize();
			tmp.fillRect(0,0,tmp.imageWidth,tmp.imageHeight,0x0);
			tmp.copyRect(olx,oly,base,0,0,base.imageWidth,base.imageHeight);
			
			tmp2.setImageSize(base.imageWidth, base.imageHeight);
			tmp2.setSizeToImageSize();
			tmp2.fillRect(0,0,tmp2.imageWidth,tmp2.imageHeight,0x0);
			tmp2.copyRect(0,0,base,0,0,base.imageWidth,base.imageHeight);

			if(olm != 2){
				tmp.turnAlpha();
				tmp.doBoxBlur(olx, oly);
				tmp.operateRect(olx, oly, base, 0, 0, base.imageWidth, base.imageHeight, omAuto, 255);
				tmp.turnAlpha();
			}

			if(olm != 1){
				tmp2.turnAlpha();
				tmp2.doBoxBlur(olx, oly);
				tmp2.MaskRect(0, 0, base, 0, 0, base.imageWidth, base.imageHeight, 3);
				if(olm == 0) tmp.operateRect(olx, oly, tmp2, 0, 0, tmp2.imageWidth, tmp2.imageHeight, omAuto, 255);
				else tmp.assignImages(tmp2);
			}

			if(olt) tmp.AlphaColorRect(220,120, 20);
			else tmp.AlphaColorRect(0, 0, 0);
			
			base.assignImages(tmp);
			base.setSizeToImageSize();
			
			invalidate tmp;
			invalidate tmp2;
			invalidate tmp3;
		}

		if(maskBontd != ""){
			//内部で作成を行い、それをメインに張り合わせる
			var mbLeft = mbpsx * base.width;
			var mbTop = mbpsy * base.height;
			var mbWidth = (mbpex - mbpsx) * base.width;
			var mbHeight = (mbpey - mbpsy) * base.height;
			var mftmp = new global.KAGLayer(window, this);
			var tmp = new global.KAGLayer(window, this);
			mftmp.loadImages(maskBontd);
			mftmp.setSizeToImageSize();
			tmp.setImageSize(mbWidth,mbHeight);
			tmp.setSizeToImageSize();
			tmp.stretchCopy( 0, 0, mbWidth, mbHeight, mftmp, 0, 0, mftmp.width, mftmp.height, stFastLinear);
			base.MaskRect(mbLeft, mbTop, tmp, 0, 0, mbWidth, mbHeight, 3);
			invalidate mftmp;
			invalidate tmp;
		}

		/*
		base+childの画像を作成(小さめで作ると高速化できる)
			↓
		childに張り合わせ(元のサイズ)
			↓
		baseのみの画像ボカシを作成
		*/

		//
		if(bblur){
			var _bbx = (bbs) ? bbx * 2 : bbx;
			var _bby = (bbs) ? bby * 2 : bby;

			//大きめに処理したほうがいいかも
			if(child !== void){
				var cl = child.left;				// 子のレイヤの左端✕座標
				var ct = child.top; 				// 子のレイヤの左端Ｙ座標
				var cw = child.width;				// 子のレイヤの元サイズ横幅
				var ch = child.height;				// 子のレイヤの元サイズ縦幅
				var cact = child.imageWidth \ cw;	// アクションの個数
				
				var sw = cw + _bbx * 2;				// 最終のサイズ横幅
				var sh = ch + _bby * 2;				// 最終のサイズ縦幅
				
				var dw = cw +  _bbx * 4;			// 作業のサイズ横幅
				var dh = ch +  _bby * 4;			// 作業のサイズ縦幅
				
				//childのコピー
				var ctmp = new global.KAGLayer(window, this);
				ctmp.setImageSize(child.imageWidth,child.imageHeight);
				ctmp.copyRect( 0, 0, child, 0, 0, child.imageWidth, child.imageHeight);
				
				//作業場のレイヤ
				var tmp = new global.KAGLayer(window, this);
				tmp.setImageSize( dw, dh);
				tmp.setSizeToImageSize();

				child.setImageSize(sw * cact, sh);
				child.setSize(sw,sh);
				child.fillRect( 0, 0, cw, ch, 0x0);

				var dbbx = _bbx * 2;
				var dbby = _bby * 2;
				
				for(var i = 0; i < cact; i++){
					tmp.fillRect( 0, 0, dw, dh, 0xff00ff00);
					var bx = cl - dbbx;
					var by = ct - dbby;
					tmp.copyRect(0, 0, base, bx, by, dw, dh, omPsNormal);

					var ccw = cw * i;
					var cch = 0;
					dm("ccw:"+ccw);
					tmp.operateRect( dbbx, dbby, ctmp, ccw, cch, cw, ch, omPsNormal);

					tmp.doBoxBlur(bbx,bby);
					if(bbs) tmp.doBoxBlur(bbx,bby);

					var sl = sw * i;
					var st = 0;
					child.copyRect( sl, st, tmp, _bbx, _bby, sw, sh, omPsNormal);
				}

				//ピクセル変更の動作があればいい
				child.setSize(sw,sh);
				child.setPos(cl - _bbx, ct - _bby);

				if(animation){
					child.cw = cw;
					child.owner = this;
					child.org_org_clip = child.org_clip;
					child.org_clip = child.clip;
					child.clip = function(elm){
						var facnt = elm.left \ cw;
						var anmleft = width * facnt;
						setImagePos(-anmleft, elm.top);
						owner.onTag(elm);
						return 0;
					}incontextof child;
				}
				
				invalidate ctmp;
				invalidate tmp;
			}
			
			if(bbe){
				var tmp = new global.KAGLayer(window, this);
				tmp.setImageSize(base.width + _bbx * 2,base.height + _bby * 2);
				tmp.setSizeToImageSize();
				tmp.copyRect( _bbx, _bby, base, 0, 0, base.imageWidth, base.imageHeight);
				base.assignImages(tmp);
				base.setSize(base.width + _bbx * 2,base.height + _bby * 2);
			}

			base.doBoxBlur(bbx, bby);
			if(bbs) base.doBoxBlur(bbx, bby);

			if(child !== void) base.fillRect(child.left, child.top,child.width, child.height, 0x0);

			
		}

		if(correct && sysCharCorrect == true){
			doCharacterCorrect(base);
			//↓子のレイヤ（animationLayer等）は処理をしくくれるらしいので処理をカット
			//if(child !== void) doCharacterCorrect(child);
		}

		if(a_r != -1 || a_g != -1 || a_b != -1){
			base.AlphaColorRect(a_r, a_g, a_b);									//彩色の変更を実行
			if(child !== void) child.AlphaColorRect(a_r, a_g, a_b);			//彩色の変更を実行
		}
		
		
		if(color){
			if(grayscale || sepia){
				base.doGrayScale();
				if(child !== void) child.doGrayScale();
			}
			// ガンマ補正
			if(sepia){
				base.adjustGamma(1.3, 0, 255, 1.1, 0, 255, 1.0, 0, 255);
				if(child !== void) child.adjustGamma(1.3, 0, 255, 1.1, 0, 255, 1.0, 0, 255);
			}
			
			// 階調の反転
			if(turn) base.adjustGamma(rgamma, rceil, rfloor, ggamma, gceil, gfloor, bgamma, bceil, bfloor);
			else base.adjustGamma(rgamma, rfloor, rceil, ggamma, gfloor, gceil, bgamma, bfloor, bceil);

			if(child !== void){
				if(turn) child.adjustGamma(rgamma, rceil, rfloor, ggamma, gceil, gfloor, bgamma, bceil, bfloor);
				else child.adjustGamma(rgamma, rfloor, rceil, ggamma, gfloor, gceil, bgamma, bfloor, bceil);
			}
		}
		
		
		if(EffectLight) base.light(brightness, contrast);					/*明度とコントラスト*/
		if(EffectColorize) base.colorize(hue, saturation, blend);			/*色相と彩度*/
		if(EffectModulate) base.modulate( hue, saturation, luminance);		/*色相変更*/
		
		invalidate AddEffectLayer;
	}

	function EffectMaskRect(base,adLayer){
		 //マスク画像を読み込む前に一時レイヤを作成
		var tmp_b = new global.Layer(kag,kag.fore.base);
		var tmp_bm = new global.Layer(kag,kag.fore.base);
		//前準備
		tmp_b.loadImages(aemask);
		tmp_b.setSizeToImageSize();
		dm(":"+alphaturn);
		if(alphaturn) tmp_b.turnAlpha();
		tmp_bm.setImageSize(base.imageWidth,base.imageHeight);
		tmp_bm.setSizeToImageSize();
		tmp_bm.stretchCopy(0,0,tmp_bm.width,tmp_bm.height,tmp_b,0,0,tmp_b.width,tmp_b.height,stFastLinear);
		base.MaskRect(0, 0, tmp_bm, 0, 0, base.imageWidth, base.imageHeight, 3);
		adLayer.operateRect(0,0,base,0,0,base.width,base.height,omAuto,255);
		base.assignImages(adLayer);
		base.setSizeToImageSize();
		
		invalidate tmp_b;
		invalidate tmp_bm;
	}

	function AddInLine(acLayer,_tmp){
		
		var tmp = new global.KAGLayer(window, this);
		tmp.assignImages(_tmp);
		tmp.turnAlpha();
		acLayer.assignImages(_tmp);
		acLayer.doBoxBlur(bbx, bby);
		acLayer.operateRect(0,0, tmp, 0, 0, acLayer.imageWidth, acLayer.imageHeight, omPsNormal, 255);
		acLayer.turnAlpha();
		invalidate tmp;
	}
	
	function finalize(){
		timer.enabled = false;
		invalidate timer if timer !== void;
		loop.clear();
		biv.clear();
	}

	function Reload(elm){
		asl.Stop();											//アニメーション停止
		asl.SetupEnvironment(elm);							//アニメーションの基本動作の読み込み
		asl.SetupAnimetion(elm.storage);					//アニメーションスクリプトデータの読み込み
		asl.Play();											//アニメーション開始
	}
	
	function loadImages(storage, key, win=false, elm = %[])
	{
		// asd ファイルがあった場合、その中に clipWidth と clipHeight が存在するかつ 0 より大きい値が設定されているかのチェック
		var asdExist = Storages.isExistentStorage(Storages.chopStorageExt(storage) + ".asd");
		var clipDataExist = false;

		if(asdExist){
			var tmp = [].load(Storages.chopStorageExt(storage) + ".asd");
			var cmd_d = -1;

			for(var i = 0; i < tmp.count; i++){
				if(tmp[i].substr(0,1) == ";"){cmd_d = i;}
			}

			var data = tmp[cmd_d].split(" ;/=",,true);						//列のデータを解体
			var dmp  = %[];													//パラメータ用

			for(var i=1;i < data.count;i+=2){ dmp[data[i]] = +data[i+1]; }	//パラメータを辞書配列化

			if( dmp.clipwidth !== void && dmp.clipheight !== void )
			{
				if( dmp.clipwidth > 0 && dmp.clipheight > 0 ) clipDataExist = true;
			}

			data.clear();													//使用した仮配列の初期化
			(Dictionary.clear incontextof dmp)();							//使用した仮配列の初期化
		}
		//dm("asdExist"+asdExist);
		//dm("clipDataExist:"+clipDataExist);


		//初期化の追加
		clear();
		AddEffectFlagCheck(storage,elm);
		
		if(elm.ride !== void && (elm.oox !== void || elm.ooy !== void || elm.oix !== void || elm.oiy !== void)){
			if(ereLayer === void){
				ereLayer = new EffectRideEdgeLayer(window,kag.fore.base);
			}
			ereLayer.loadImages(elm);
		}

		movie == "";
		
		if(elm.movie !== void){
			w = kag.scWidth;
			h = kag.scHeight;
			setImageSize(w, h);
			setSizeToImageSize();
			fillRect(0,0,w,h,0x00000000);
			opacity=255;
			type = imageTagLayerType["rect"].type;
			//type = imageTagLayerType["alpha"].type;
			
			movie = Storages.extractStorageExt(elm.movie);
			if(false){
				if(movie != ".amv"){
					dm("ミキシングテスト");
					try{
						kag.movies[0].setOptions(%[mode:"vomMixer",visible:"true"]);
						kag.movies[0].setSize(w,h);
						kag.movies[0].loop = false;
						kag.movies[0].setMixingLayer(this);
						//kag.movies[0].setVideoLayer(this,%[channel:1]);
						kag.movies[0].play(elm.movie);
					}catch{
						dm("ムービーファイルの読み込みに失敗しました");
					}
				}
			}else if(movie == ".amv"){
				try{
					///////////////////////////////////////////////////////////////////////////////////////////////////
					/*独自形式のアルファ再生機能*/
					/*SingleLayerAlphaMoviePlayer記述部分のコメントアウトをはずしてAlphamovie.dllを読み込めば使用可能*/
					//if(SLAMP === void){SLAMP = new SingleLayerAlphaMoviePlayer(+elm.obj,this);}
					//SLAMP.open(elm.movie);
					//SLAMP.play();
					///////////////////////////////////////////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////////////////////////////////////////
					/*現状有るアルファムービーを使用する*/
					/*
					var movie_storage = Storages.chopStorageExt(elm.movie);
					if(movieLayer === void){movieLayer = new global.Layer(window, this);}
					movieLayer.assignImages(this);
					//現在のアドレスの確保
					BackupFrontLayer = void;
					BackupBackLayer = void;
					BackupFrontLayer = alphamovie_object.movies[0].drawlayer;
					BackupBackLayer = alphamovie_object.movies[0].drawlayerBack;
					//現在の差し替え
					alphamovie_object.movies[0].drawlayer = this;//( kag, kag.fore.base, "alpha movie 00" + index, 1234 + index )
					alphamovie_object.movies[0].CreateDrawLayer( kag.fore.base, alphamovie_object.movies[0].drawlayer, 0 );
					alphamovie_object.movies[0].drawlayerBack = movieLayer;//( kag, kag.fore.base, "alpha movie 00" + index, 1234 + index )
					alphamovie_object.movies[0].CreateDrawLayer( kag.back.base, alphamovie_object.movies[0].drawlayerBack, 0 );
					alphamovie_object.playmovie(%[slot:"0",storage:elm.movie,loop:"true"]);
					*/
					///////////////////////////////////////////////////////////////////////////////////////////////////
				}catch{
					dm("アルファムービーファイルの読み込みに失敗しました");
				}
			}else{
				try{
					kag.movies[0].setOptions(%[mode:"layer",visible:"true"]);
					kag.movies[0].setSize(w,h);
					kag.movies[0].loop = false;
					kag.movies[0].setVideoLayer(this,%[channel:1]);
					kag.movies[0].play(elm.movie);
				}catch{
					dm("ムービーファイルの読み込みに失敗しました");
				}
			}
		}else if(elm.fillimage == "true"){
			if(fpLayer === void){ fpLayer = new FullPaintLayer(window,kag.fore.base);}
			fpLayer.loadImages(elm.storage);
			var sws = (elm.fillwidth !== void) ? +elm.fillwidth : kag.scWidth;
			var shs = (elm.fillheight !== void) ? +elm.fillheight : kag.scHeight;
			var xcnt = (sws \ fpLayer.tmp.width);
			var ycnt = (shs \ fpLayer.tmp.height);
			for(;xcnt * fpLayer.tmp.width < sws + fpLayer.tmp.width;){ xcnt++;}
			for(;ycnt * fpLayer.tmp.height < shs + fpLayer.tmp.height;){ ycnt++;}
			w = xcnt * fpLayer.tmp.width;
			h = ycnt * fpLayer.tmp.height;
			fpLayer.FullPaint(w, h);
			setImageSize(w, h);
			setSizeToImageSize();
			type = ltAlpha;
			face = dfAlpha;
			fillRect(0,0,w,h,0x0);
			piledCopy(0,0,fpLayer,0,0,w,h);
		}else if(elm.cutin !== void){
			
			if(cutinLayer === void){
				cutinLayer = new global.CutinPiledLayer(window,kag.fore.base);
			}
			cutinLayer.loadImages(elm);
			var cutin_interval = 100;
			cutin_interval = (elm.interval !== void) ? +elm.interval : 100;
			if(cutinLayer.activ){
				timer = new Timer(cutinLayer_activ_action, '');
				timer.interval = cutin_interval;
				timer.enabled = true;
			}
			//cutinLayer.visible=true;
			w = cutinLayer.imageWidth;
			h = cutinLayer.imageHeight;
			setImageSize(w, h);
			setSizeToImageSize();
			type = ltAlpha;
			face = dfAlpha;
			fillRect(0,0,width,height,0x0);
			piledCopy(0,0,cutinLayer,0,0,w,h);
		}else if(elm.word !== void){
			//文字列描画用
			if(wordLayer === void){wordLayer = new global.WordLayer(window,kag.fore.base);}
			wordLayer.WordDataSet(elm);
			w = wordLayer.imageWidth;
			h = wordLayer.imageHeight;
			setImageSize(w, h);
			setSizeToImageSize();
			type = ltAlpha;
			face = dfAlpha;
			fillRect(0,0,width,height,0x0);
			piledCopy(0,0,wordLayer,0,0,w,h);
		}else if(elm.bind !== void || storage === void){
			//dm("通過ＳＳＳ");
			if(bindLayer === void){bindLayer = new global.AutoBindLayer(window,kag.fore.base);}
			bindLayer.loadImages(elm);
			w = bindLayer.imageWidth;
			h = bindLayer.imageHeight;
			setImageSize(w, h);
			setSizeToImageSize();
			type = ltAlpha;
			face = dfAlpha;
			fillRect(0,0,width,height,0x0);
			piledCopy(0,0,bindLayer,0,0,w,h);
			if(elm.autobind === "true"){
				var bind_interval = 30;
				if(elm.interval !== void){bind_interval = +elm.interval;}
				
				/*要するにリアルタイムで変化するかどうか*/
				timer = new Timer(AutoBindHandler, '');
				timer.interval = bind_interval;
				timer.enabled = true;
			}
			
		}else if(elm.scroll !== void){
			// ウィンドウの背景設定
			if(baseLayer === void)baseLayer = new global.Layer(window, this);
			baseLayer.loadImages("sp_com_bg3");
			baseLayer.setSizeToImageSize();
			LayerAddEffect(baseLayer);

			w = baseLayer.imageWidth;
			h = baseLayer.imageHeight;

			// キャラクター読み込み用レイヤー
			if(charaLayer === void)charaLayer = new global.CharacterLayer(window, baseLayer);
//			charaLayer.loadImages(%[storage:(elm.storage===void ? "sp_fwin_scroll_ch_01" : elm.storage), visible:true, clipleft:0, cliptop:0, clipwidth:264, clipheight:386]);
			if(elm.scroll == "0")charaLayer.loadImages(%[storage:"sp_fwin_scroll_ch_01", visible:true, clipleft:0, cliptop:0, clipwidth:1, clipheight:270]);
			else charaLayer.loadImages(%[storage:"sp_fwin_scroll_ch_02", visible:true, clipleft:0, cliptop:0, clipwidth:1, clipheight:270]);
			charaLayer.width = charaLayer.imageWidth;	// アニメーションの幅は全域
			LayerAddEffect(charaLayer);
			charaLayer.setPos(baseLayer.imageWidth\2-charaLayer.width\2, 8);
			charaLayer.visible = true;
			charaLayer.owner = this;
			charaLayer.org_clip = charaLayer.clip;
			charaLayer.clip = function(elm){
				var result = org_clip(elm);
				owner.onTag(elm);
				return result;
			}incontextof charaLayer;
			
			if(elm.window_x !== void){charaLayer.left = +elm.window_x;}
			if(elm.window_y !== void){charaLayer.top = +elm.window_y;}
			
			// 上に乗せるフレーム設置
			if(frameLayer === void)frameLayer = new global.Layer(window, baseLayer);
			frameLayer.loadImages("sp_com_frame3");
			LayerAddEffect(frameLayer);
			frameLayer.setSizeToImageSize();
			frameLayer.visible= true;
			
			// 全部重ねた画像を作る
			setImageSize(w, h);
			setSizeToImageSize();
			type = ltAlpha;
			face = dfAlpha;
			fillRect(0,0,width,height,0x0);
			piledCopy(0,0,baseLayer,0,0,w,h);

		}else if(elm.clip !== void){
			var clip = elm.clip.split("(),",,true);
			if(baseLayer === void) baseLayer = new global.Layer(window, this);
			if(clip.count => 2){
				w = +clip[0];
				h = +clip[1];
			}else{
				w = 1;
				h = 1;
				dm("error:clipサイズを入力してください->clip=(width,height)");
			}
			baseLayer.setImageSize(w,h);
			baseLayer.setSizeToImageSize();
			baseLayer.visible = true;
			
			if(bgLayer === void)bgLayer = new global.Layer(window, baseLayer);
			bgLayer.loadImages(elm.storage);
			bgLayer.setSizeToImageSize();
			LayerAddEffect(bgLayer);
			bgLayer.visible = true;
			if(elm.tpath !== void && elm.ttime !== void){
				//var clipPath = elm.tpath.split("(),",,true);
				//var clipTime = elm.ttime.split("(),",,true);
				//内部を作成
				syncPath = new SyncPathScriptLeaderController(this);				//アニメーション管理クラスの生成
				syncPath.AddPathSlot(bgLayer, elm.tpath, elm.ttime, elm.taccel, 0);
			}
			
			this.setImageSize(w,h);
			this.setSizeToImageSize();
			this.fillRect(0,0,w,h,0x0);
			this.piledCopy(0,0,baseLayer,0,0,w,h);
			
			if(syncPath !== void){
				syncPath.SetupEnvironment(elm);
				syncPath.Play();
			}
		}else if(elm.cutinline !== void){
			var cutinline = elm.cutinline.split("(),",,true);
			if(baseLayer === void)baseLayer = new global.Layer(window, this);
			if(bgLayer === void){ bgLayer = new global.Layer(window, baseLayer);}
			if(frameLayer === void){ frameLayer = new global.Layer(window, baseLayer);}

			//動作
			var spaceH = 500;
			
			bgLayer.loadImages(cutinline[0]);
			bgLayer.setSizeToImageSize();
			var bhH = bgLayer.height \ 2;
			bgLayer.setPos(0,0);
			bgLayer.visible = true;
			frameLayer.loadImages(cutinline[1]);
			frameLayer.setSizeToImageSize();
			var fhH = frameLayer.height \ 2;
			bgLayer.setPos(0, spaceH + bhH - fhH);
			frameLayer.visible = true;
			
			var bw = bgLayer.width;
			var fw = frameLayer.width;
			if(bw > fw) w = bw;
			else  w = fw;
			if(w > kag.scWidth) w = kag.scWidth;
			h = spaceH + bhH + fhH;

			//dm("W:" + w + " H:" + h);
			
			baseLayer.setImageSize(w,h);
			baseLayer.setSizeToImageSize();
			baseLayer.visible = true;
			this.setImageSize(w, h);
			this.setSizeToImageSize();
			this.fillRect(0,0,w,h,0xff00ff00);
			this.piledCopy(0,0,baseLayer,0,0,w,h);
			
			//syncPath = new SyncPathScriptLeaderController(this);				//アニメーション管理クラスの生成
			
		}else if(elm.sync !== void){
			var sync = elm.sync.split("(),",,true);
			syncAsl = new SyncAnimetionScriptLeaderController(this);			//アニメーション管理クラスの生成
			if(baseLayer === void) baseLayer = new global.Layer(window, this);
			baseLayer.loadImages(elm.storage);
			syncAsl.AddAnimetionSlot(baseLayer, elm.storage);
			//オブジェクト名
			if(sync.count > 0){
				if(+sync[0] != -1) syncAsl.AddOtherTempAnimetionSlot( owner.obj_no, +sync[0]);
			}
			baseLayer.visible = true;
			w = baseLayer.width;
			h = baseLayer.height;
			this.setImageSize(w, h);
			this.setSizeToImageSize();
			this.fillRect(0,0,w,h,0xff00ff00);
			this.piledCopy(0,0,baseLayer,0,0,w,h);
			syncAsl.SetupEnvironment(elm);
			syncAsl.Play();
		}else if(elm.sbf !== void){
			// 背景画像の処理をかます。
			// 配列化を行う
			
			var sbf = elm.sbf.split("(),",,true);
			var sabs = -1;
			var mr = void;
			var clipCount = 0;
			syncAsl = new SyncAnimetionScriptLeaderController(this);			//アニメーション管理クラスの生成
			syncPath = new SyncPathScriptLeaderController(this);				//アニメーション管理クラスの生成
			if(elm.hm !== void){
				mr = elm.hm.split("(),",,true);
				for(var i = 0; i < mr.count; i++) mr[i] = +mr[i];
				if(mr.count >= 4){
					halfMask = 1;
				}else halfMask = 0;
			}else halfMask = 0;
			
			var frameStorage = "";
			if(baseLayer === void) baseLayer = new global.Layer(window, this);
			
			for(var i = 0; i < sbf.count; i++){
				if(i == 0){
					if(bgLayer === void){ bgLayer = new global.Layer(window, baseLayer);}
					
					if(sbf[i] == "storage"){
						sabs = i;
						if(charaLayer === void){ charaLayer = new global.KAGLayer(window, baseLayer);}
						charaLayer.loadImages(elm.storage);
						charaLayer.visible = true;
						bgLayer.setImageSize(charaLayer.imageWidth,charaLayer.imageHeight);
						bgLayer.setSizeToImageSize();
						bgLayer.visible= true;
					}else{
						bgLayer.loadImages(sbf[i]);
						bgLayer.setSizeToImageSize();
						bgLayer.visible= true;
						var asdFile = sbf[i] + ".asd";
						if(Storages.isExistentStorage(asdFile)){
							syncAsl.AddAnimetionSlot(bgLayer, sbf[i]);
							clipCount = syncAsl.IsAnimetionCount(0);
						}
					}
				}else{
					if(sbf[i] == "storage"){
						sabs = i;
						if(charaLayer === void){ charaLayer = new global.KAGLayer(window, baseLayer);}
						charaLayer.loadImages(elm.storage);
						charaLayer.setSizeToImageSize();
						charaLayer.visible = true;
					}else{
						if(frameLayer === void)frameLayer = new global.Layer(window, baseLayer);
						frameStorage = sbf[i];
						frameLayer.loadImages(sbf[i]);
						frameLayer.setSizeToImageSize();
						frameLayer.visible= true;
						var asdFile = sbf[i] + ".asd";
						if(Storages.isExistentStorage(asdFile)) syncAsl.AddAnimetionSlot(frameLayer, sbf[i], 0);
					}
				}
			}
			
			if(charaLayer.anmLayer != void && animation){
				if(typeof charaLayer.anmLayer != "undefined"){
					charaLayer.anmLayer.owner = this;
					charaLayer.anmLayer.org_clip = charaLayer.anmLayer.clip;
					charaLayer.anmLayer.clip = function(elm){
						var result = org_clip(elm);
						owner.onTag(elm);
						return result;
					}incontextof charaLayer.anmLayer;
				}
			}
			
			var ba = void;
			if(charaLayer !== void){
				if(elm.sbfliplr !== void) charaLayer.flipLR();
				if(elm.sbflipud !== void) charaLayer.flipUD();
				if(elm.sbac !== void){
					var acr = elm.sbac.split("(),",,true);
					charaLayer.AlphaColorRect(+acr[0], +acr[1], +acr[2]);
				}
				
				if(elm.sbpath !== void && elm.sbtime !== void){
					syncPath.AddPathSlot(charaLayer, elm.sbpath, elm.sbtime, elm.sbaccel, 0);
					ba = syncPath.IsSlotBehaviorArea(0);
				}
			}
			
			var bal = 0;
			var bat = 0;
			var baw = 12;
			var bah = 12;
			
			//表示領域の確保
			if(baseLayer !== void){
				baw = bgLayer.width;
				bah = bgLayer.height;
				if(halfMask != -1){
					if(ba !== void){
						var bgl = 0, chl = 0;
						var bgr = 0, chr = 0;
						var bgt = 0, cht = 0;
						var bgb = 0, chb = 0;

						bgl = 0;
						bgr = bgLayer.width;
						chl = ba[0];
						chr = ba[1];
						bgt = 0;
						bgb = bgLayer.height;
						cht = ba[2];
						chb = ba[3];
						
						var maxl = (bgl > chl) ? chl : bgl;
						var maxr = (bgr < chr) ? chr : bgr;
						var maxt = (bgt > cht) ? cht : bgt;
						var maxb = (bgb < chb) ? chb : bgb;
						
						baw = maxr - maxl;
						bah = maxb - maxt;
						
						baseLayer.setImageSize(baw, bah);

						if(mr[0] < 0){ mr[0] = 0; em("エフェクト(hm)：マスク座標Ｘ(範囲外)→強制後："+mr[0]);}
						else if(mr[0] > baw){ mr[0] = baw; em("エフェクト(hm)：マスク座標Ｘ(範囲外)→強制後："+mr[0]);}
						if(mr[1] < 0){ mr[1] = 0; em("エフェクト(hm)：マスク座標Ｙ(範囲外)→強制後："+mr[1]);}
						else if(mr[1] > bah){ mr[1] = bah; em("エフェクト(hm)：マスク座標Ｙ(範囲外)→強制後："+mr[1]);}
						if(mr[2] + mr[0] > baw){ mr[2] = baw - mr[0]; em("エフェクト(hm)：マスク横幅(範囲外)→強制後："+mr[2]);}
						if(mr[3] + mr[1] > bah){ mr[3] = bah - mr[1]; em("エフェクト(hm)：マスク縦幅(範囲外)→強制後："+mr[3]);}
						
						bal = ba[0];
						bat = ba[2];

						if(bal < 0 && bat < 0) syncPath.PosCorrection(0,-bal,-bat);
						else if(bal < 0) syncPath.PosCorrection(0,-bal,0);
						else if(bat < 0) syncPath.PosCorrection(0,0,-bat);
					}

					var innerFrame = false;
					
					if(bgLayer !== void){
						if(bal > 0) bgLayer.left = 0;
						else bgLayer.left = -bal;
						if(bat > 0) bgLayer.top = 0;
						else bgLayer.top = -bat;

						//αを作成する
						if(bgAlphaLayer === void) bgAlphaLayer = new global.Layer(window, this);
						if(clipCount != 0){
							bgAlphaLayer.setImageSize(mr[2] * clipCount, mr[3]);
							bgAlphaLayer.setSize(mr[2], mr[3]);
							bgAlphaLayer.setPos(mr[0], mr[1]);
							var bgl = bgLayer.left;				//左端
							var bgr = bgl + bgLayer.width;		//右端
							var bgt = bgLayer.top;				//左端
							var bgb = bgt + bgLayer.height;		//右端
							//dm("bgl:" + bgl + ", bgr:" + bgr + " bgt:" + bgt + ", bgb:" + bgb);
							if(bgr < mr[0]) bgAlphaLayer.fillRect(0,0,bgAlphaLayer.imageWidth,bgAlphaLayer.imageHeight,0x0);
							else if(bgl > mr[0] + mr[2]) bgAlphaLayer.fillRect(0,0,bgAlphaLayer.imageWidth,bgAlphaLayer.imageHeight,0x0);
							else if(bgb < mr[1]) bgAlphaLayer.fillRect(0,0,bgAlphaLayer.imageWidth,bgAlphaLayer.imageHeight,0x0);
							else if(bgt > mr[1] + mr[3]) bgAlphaLayer.fillRect(0,0,bgAlphaLayer.imageWidth,bgAlphaLayer.imageHeight,0x0);
							else{
								innerFrame = true;
								var cpx = mr[0];
								var cpy = mr[1];
								var spx = bgLayer.left;
								var spy = bgLayer.top;
								var spw = bgLayer.width;
								var sph = bgLayer.height;
								if(bgl > mr[0]){
									cpx = (spx - cpx);
									spx = 0;
								}else{
									spx = (cpx - spx);
									cpx = 0;
									spw -= spx;
									if(spw > mr[2]) spw = mr[2];
								}
								
								if(bgt > mr[1]){
									cpy = (spy - cpy);
									spy = 0;
								}else{
									spy = (cpy - spy);
									cpy = 0;
									sph -= spy;
									if(sph > mr[3]) sph = mr[3];
								}
								
								for(var i = 0; i < clipCount; i++){
									bgAlphaLayer.copyRect(cpx, cpy, bgLayer, spx, spy, spw, sph);
									cpx += mr[2];
									spx += bgLayer.width;
								}
							}
						}else{
							bgAlphaLayer.setImageSize(baseLayer.imageWidth, baseLayer.imageHeight);
							bgAlphaLayer.setSizeToImageSize();
							bgAlphaLayer.copyRect(mr[0], mr[1], bgLayer, mr[0], mr[1], mr[2], mr[3]);	//ただのコピー
						}
					}

					if(frameLayer !== void){
						if(bal > 0) frameLayer.left = 0;
						else frameLayer.left = -bal;
						if(bat > 0) frameLayer.top = 0;
						else frameLayer.top = -bat;
						
						if(innerFrame){
							if(limitLayer === void) limitLayer = new global.Layer(window, baseLayer);
							limitLayer.setImageSize(frameLayer.imageWidth,frameLayer.imageHeight);
							var bgl = frameLayer.left;				//左端
							var bgr = bgl + frameLayer.width;		//右端
							var bgt = frameLayer.top;				//左端
							var bgb = bgt + frameLayer.height;		//右端
							
							var cpx = frameLayer.left;
							var cpy = frameLayer.top;
							var spx = mr[0];
							var spy = mr[1];
							var spw = mr[2];
							var sph = mr[3];
							if(bgl < mr[0]){
								cpx = (spx - cpx);
								spx = 0;
							}else{
								spx = (cpx - spx);
								cpx = 0;
								spw -= spx;
								if(spw > frameLayer.width) spw = frameLayer.width;
							}
								
							if(bgt < mr[1]){
								cpy = (spy - cpy);
								spy = 0;
							}else{
								spy = (cpy - spy);
								cpy = 0;
								sph -= spy;
								if(sph > frameLayer.height) sph = frameLayer.height;
							}
							
							for(var i = 0; i < clipCount; i++){
								limitLayer.copyRect(cpx, cpy, frameLayer, cpx, cpy, spw, sph);
								cpx += frameLayer.width;
							}
							
							if(bal > 0) limitLayer.left = 0;
							else limitLayer.left = -bal;
							if(bat > 0) limitLayer.top = 0;
							else limitLayer.top = -bat;
							
							limitLayer.visible= true;
							var asdFile = frameStorage + ".asd";
							if(Storages.isExistentStorage(asdFile)) syncAsl.AddAnimetionSlot(limitLayer, frameStorage, 0);
						}
					}
				}else baseLayer.setImageSize(baw, bah);
				baseLayer.setSizeToImageSize();
				baseLayer.visible = true;
			}
			
			w = baseLayer.width;
			h = baseLayer.height;
			setImageSize(w, h);
			setSizeToImageSize();
			//type = ltAlpha;
			//face = dfAlpha;

			var fmtest = false;
			if(elm.fmtest !== void) fmtest = true;
			if(fmtest){
				//dm("W:" + w + " H:" + h);
				if(testLayer === void){
					testLayer = new global.Layer(kag,baseLayer);
					testLayer.setImageSize(w, h);
					testLayer.setSizeToImageSize();
					testLayer.fillRect(0,0,w,h,0x80ff0000);
					testLayer.visible = true;
				}

				if(testLayer2 === void){
					testLayer2 = new global.Layer(kag,baseLayer);
					testLayer2.setImageSize(w, h);
					testLayer2.setSizeToImageSize();
					testLayer2.fillRect(mr[0],mr[1],mr[2],mr[3],0x8000ff00);
					testLayer2.visible = true;
				}
			}
			
			fillRect(0,0,width,height,0xff00ff00);
			piledCopy(0,0,baseLayer,0,0,w,h);
			try{
				if(bgAlphaLayer !== void){
					dm("ML:" + mr[0] + " MT:" + mr[1] + " MW:" + mr[2] + " MH:" + mr[3]);
					this.MaskRect(bgAlphaLayer.left, bgAlphaLayer.top, bgAlphaLayer, 0, 0, bgAlphaLayer.width, bgAlphaLayer.height,3);
				}else this.MaskRect(0, 0, baseLayer, baseLayer.imageLeft, baseLayer.imageTop, baseLayer.width, baseLayer.height,3);
			}catch{
				dm("マスクのサイズ指定ミス");
			}
			syncAsl.SetupEnvironment(elm);
			syncPath.SetupEnvironment(elm);
			syncAsl.Play();
			syncPath.Play();
		}else if(elm.frame !== void && storage.substr(0,2) == "st"){
			
			//∇
			// 基本レイヤがウインドウつき画像にしたい場合
			// ウィンドウの背景設定
			var frame = elm.frame;				//
			var bg = "black";					//読み込むフレーム背景
			var fr = "black";					//読み込むフレーム枠
			var stchr = storage.substr(2,2);	//現在の立ち絵番号
			var stphose = storage.charAt(4);	//現在のポーズ
			var stsize = storage.charAt(5);		//現在のサイズ
			
			if(Storages.isExistentStorage("frametype.csv")){
				var fta = loadFrameSetting("frametype.csv");
				for(var i = 1; i < fta.count; i++){
					if(fta[i][0] == frame && fta[i][1] == stsize){
						bg = fta[i][2];
						fr = fta[i][3];
						i = fta.count;
					}
				}
				fta.clear();
			}

			if(baseLayer === void){ baseLayer = new global.Layer(window, this);}
			baseLayer.loadImages(bg);
			baseLayer.setSizeToImageSize();
			baseLayer.visible= true;

			//基準幅が確定
			w = baseLayer.imageWidth;
			h = baseLayer.imageHeight;
			
			if(limitLayer === void){ limitLayer = new global.Layer(window, baseLayer);}
			limitLayer.setImageSize(baseLayer.imageWidth, baseLayer.imageHeight);
			limitLayer.setSizeToImageSize();
			limitLayer.left = 0;
			limitLayer.top = 0;
			limitLayer.hasImage = false;
			limitLayer.visible = true;

			if(charaLayer === void){ charaLayer = new global.KAGLayer(window, limitLayer);}
			charaLayer.loadImages(storage);
			charaLayer.setSizeToImageSize();
			charaLayer.opacity = 255;
			charaLayer.visible = true;
			LayerAddEffect(charaLayer);

			if(charaLayer.anmLayer != void){
				if(typeof charaLayer.anmLayer != "undefined"){
					LayerAddEffect(charaLayer.anmLayer);
					charaLayer.anmLayer.owner = this;
					charaLayer.anmLayer.org_clip = charaLayer.anmLayer.clip;
					charaLayer.anmLayer.clip = function(elm){
						var result = org_clip(elm);
						owner.onTag(elm);
						return result;
					}incontextof charaLayer.anmLayer;
				}
			}else if(charaLayer.anmLayer != void){
				LayerAddEffect(charaLayer.anmLayer);
			}

			if(Storages.isExistentStorage("framepos.csv")){
				var cpa = loadFrameSetting("framepos.csv");
				for(var i = 1; i < cpa.count; i++){
					if(cpa[i][0] == stchr && cpa[i][1] == stphose && cpa[i][2] == stsize){
						var cleft = w\2 + +cpa[i][3];
						var ctop = +cpa[i][4];
						charaLayer.setPos( cleft, ctop);
						i = cpa.count;
					}
				}
				cpa.clear();
			}else{
				var ar = getCharPosArray(storage);
				charaLayer.left = w\2 + ar[0];
			}
			
			if(frameLayer === void)frameLayer = new global.Layer(window, baseLayer);
			frameLayer.loadImages(fr);
			frameLayer.setSizeToImageSize();
			frameLayer.visible= true;
			
			setImageSize(w, h);
			setSizeToImageSize();
			type = ltAlpha;
			face = dfAlpha;
			fillRect(0,0,width,height,0x0);
			piledCopy(0,0,baseLayer,0,0,w,h);
			
		}else if(win){
			
			var csize = storage.charAt(5);
			if(baseLayer === void)baseLayer = new global.Layer(window, this);
			if(elm.otherbg === void){
				if(storage.substring(0,2) == "st"){
					if(csize == "a"){baseLayer.loadImages("sp_window_bg_a");}
					if(csize == "b"){baseLayer.loadImages("sp_window_bg_b");}
					if(csize == "c"){baseLayer.loadImages("sp_window_bg_c");}
				}else{
					//baseLayer.loadImages("ev_2018a_frame0");
				}
			}else{
				baseLayer.loadImages(elm.otherbg);
			}

			if(elm.base_x !== void || elm.base_y !== void){
				var bx = 0;
				var by = 0;
				bx = +elm.base_x;
				by = +elm.base_y;
				baseLayer.setPos(bx,by);
			}
			
			baseLayer.setSizeToImageSize();
			if(elm.w_color != "true") LayerAddEffect(baseLayer);
			//else LayerAddEffect(baseLayer,%[movecolor:elm.movecolor,grayscale:elm.w_grayscale,sepia:elm.w_sepia,turn:elm.w_turn,rgamma:elm.w_rgamma,ggamma:elm.w_ggamma,bgamma:elm.w_bgamma,rfloor:elm.w_rfloor,gfloor:elm.w_gfloor,bfloor:elm.w_bfloor,rceil:elm.w_rceil,gceil:elm.w_gceil,bceil:elm.w_bceil]);
			
			w = baseLayer.imageWidth;
			h = baseLayer.imageHeight;

			// キャラクター用の表示範囲限定レイヤー
			if(limitLayer === void)limitLayer = new global.Layer(window, baseLayer);

			if(elm.otherframe !== void){
				limitLayer.setSize(baseLayer.imageWidth, baseLayer.imageHeight);
				limitLayer.left = 0;
				limitLayer.top = 0;
				limitLayer.hasImage = false;
				limitLayer.visible = true;
			}else{
				limitLayer.setSize(baseLayer.imageWidth, baseLayer.imageHeight);
				limitLayer.left = 0;
				limitLayer.top = 0;
				limitLayer.hasImage = false;
				limitLayer.visible = true;
			}
			
			// キャラクター読み込み用レイヤー
			if(charaLayer === void){
				if(storage=="sp_noie_scroll" || storage=="sp_noie_scroll2"){
					charaLayer = new global.ScrollAnimLayer(window, limitLayer);
				}else charaLayer = new global.KAGLayer(window, limitLayer);
			}

			var isSt = false;
			/*
			if(storage.substr(0,2) == "st" && storage.indexOf("_") == -1){
				if(storage.charAt(5) != "a")storage = storage.substr(0,5)+"a"+storage.substr(6);
				isSt = true;
			}*/

			charaLayer.loadImages(storage);
			charaLayer.opacity=150;
			
			charaLayer.setSizeToImageSize();
			if(storage.substr(0,2) == "st"){
				try{
					var ar = getCharPosArray(storage);
					charaLayer.left = w\2 + ar[0];
				}catch(e){
					//dm(e.message);
					charaLayer.left = w\2 - charaLayer.imageWidth\2;
				}
			}
			switch(storage.substr(0,4)){
				case "st07":charaLayer.top = charaLayer.top - 250;break;
			}
			
			if(storage=="sp_noie_scroll" || storage=="sp_noie_scroll2"){
				charaLayer.setPos(w\2-charaLayer.width\2, h\2-charaLayer.height\2);
			}
			
			//charaLayer.setImageSize(limitLayer.width-charaLayer.left,limitLayer.height-charaLayer.top);
			
			LayerAddEffect(charaLayer);
			charaLayer.visible = true;
			
			if(charaLayer.anmLayer != void && animation){
				if(typeof charaLayer.anmLayer != "undefined"){
					LayerAddEffect(charaLayer.anmLayer);
					charaLayer.anmLayer.owner = this;
					charaLayer.anmLayer.org_clip = charaLayer.anmLayer.clip;
					charaLayer.anmLayer.clip = function(elm){
						var result = org_clip(elm);
						owner.onTag(elm);
						return result;
					}incontextof charaLayer.anmLayer;
				}
			}else if(charaLayer.anmLayer != void){
				LayerAddEffect(charaLayer.anmLayer);
			}
			
			if(elm.fliplr){
				charaLayer.flipLR();
				if(storage.substring(0,2) == "st"){
					if(storage.charAt(9) == "a"){elm.window_x = elm.window_x !== void ? (+elm.window_x - 145): -145; elm.window_y = elm.window_y !== void ? +elm.window_y: -60;}
					if(storage.charAt(9) == "b"){elm.window_x = elm.window_x !== void ? (+elm.window_x - 100): -100; elm.window_y = elm.window_y !== void ? +elm.window_y: -40;}
					if(storage.charAt(9) == "c"){elm.window_x = elm.window_x !== void ? (+elm.window_x - 60): -60; elm.window_y = elm.window_y !== void ? +elm.window_y: -20;}
				}
			}else{
				if(storage.substring(0,2) == "st"){
					if(storage.charAt(9) == "a"){elm.window_x = elm.window_x !== void ? (+elm.window_x - 250): -250; elm.window_y = elm.window_y !== void ? +elm.window_y: -60;}
					if(storage.charAt(9) == "b"){elm.window_x = elm.window_x !== void ? (+elm.window_x - 185): -185; elm.window_y = elm.window_y !== void ? +elm.window_y: -40;}
					if(storage.charAt(9) == "c"){elm.window_x = elm.window_x !== void ? (+elm.window_x - 130): -130; elm.window_y = elm.window_y !== void ? +elm.window_y: -20;}
				}
			}
			
			if(elm.window_x !== void){charaLayer.left = +elm.window_x;}
			if(elm.window_y !== void){charaLayer.top = +elm.window_y;}

			//※甲
			
			// 上に乗せるフレーム設置
			if(frameLayer === void)frameLayer = new global.Layer(window, baseLayer);

			var file = "sp_window_frame";
			if(elm.otherframe === void){
				if(csize == "a"){file = "sp_window_frame_a";}
				if(csize == "b"){file = "sp_window_frame_b";}
				if(csize == "c"){file = "sp_window_frame_c";}
			}else{
				if(elm.otherframe != ""){
					file = elm.otherframe;
				}else{
					file = "";
				}
			}
			
			if(file != ""){
				frameLayer.loadImages(file);
			
				if(elm.w_color != "true") LayerAddEffect(frameLayer);
				//else LayerAddEffect(frameLayer,%[movecolor:elm.movecolor,grayscale:elm.w_grayscale,sepia:elm.w_sepia,turn:elm.w_turn,rgamma:elm.w_rgamma,ggamma:elm.w_ggamma,bgamma:elm.w_bgamma,rfloor:elm.w_rfloor,gfloor:elm.w_gfloor,bfloor:elm.w_bfloor,rceil:elm.w_rceil,gceil:elm.w_gceil,bceil:elm.w_bceil]);
				frameLayer.setSizeToImageSize();
				frameLayer.visible= true;
			}
			
			// 全部重ねた画像を作る
			setImageSize(w, h);
			setSizeToImageSize();
			type = ltAlpha;
			face = dfAlpha;
			fillRect(0,0,width,height,0x0);
			piledCopy(0,0,baseLayer,0,0,w,h);

			//visible = true;
		}else if(storage.substr(0,2) == "st"){
			if(!animation){
				if(charaLayer === void){ charaLayer = new global.KAGLayer(window, this);}
				charaLayer.loadImages(storage);
				charaLayer.setSizeToImageSize();
				charaLayer.opacity = 255;
				
				if(baseLayer === void){ baseLayer = new global.Layer(window, this);}
				baseLayer.setImageSize(charaLayer.imageWidth,charaLayer.imageHeight);
				baseLayer.setSizeToImageSize();
				baseLayer.copyRect(0,0,charaLayer,0,0,charaLayer.imageWidth,charaLayer.imageHeight);
				if(charaLayer.anmLayer != void){
					if(typeof charaLayer.anmLayer != "undefined"){
						baseLayer.operateStretch(charaLayer.anmLayer.left,charaLayer.anmLayer.top,charaLayer.anmLayer.width,charaLayer.anmLayer.height,charaLayer.anmLayer,charaLayer.anmLayer.width,0,charaLayer.anmLayer.width,charaLayer.anmLayer.height);
					}
				}
				baseLayer.visible= true;
				LayerAddEffect(baseLayer);
				invalidate charaLayer;
				
				w = baseLayer.imageWidth;
				h = baseLayer.imageHeight;
				setImageSize(w, h);
				setSizeToImageSize();
				type = ltAlpha;
				face = dfAlpha;
				fillRect(0,0,width,height,0x0);
				piledCopy(0,0,baseLayer,0,0,w,h);
			}else{
				// && storage.indexOf("_") == -1
				// 立ち絵のみの読み込み用
				if(standLayer === void)standLayer = new global.KAGLayer(window, this);
				standLayer.loadImages(storage);
				standLayer.setSizeToImageSize();
				standLayer.visible = false;
				
				if(standLayer.anmLayer != void && animation){
					//LayerAddEffect(standLayer);
					//画像を特殊生成する
					if(typeof standLayer.anmLayer != "undefined"){
						standLayer.anmLayer.owner = this;
						standLayer.anmLayer.org_clip = standLayer.anmLayer.clip;
						standLayer.anmLayer.clip = function(elm){
							var result = org_clip(elm);
							owner.onTag(elm);
							return result;
						}incontextof standLayer.anmLayer;
					}else{
							//レイヤー効果の追加
						LayerAddEffect(standLayer);
					}
					LayerAddEffect(standLayer, standLayer.anmLayer);
					//アニメーションがあり、目パチを行う
					w = standLayer.imageWidth;
					h = standLayer.imageHeight;
					setImageSize(w, h);
					setSizeToImageSize();
					piledCopy(0,0,standLayer,0,0,w,h);
				}else{
					LayerAddEffect(standLayer, standLayer.anmLayer);
					//アニメーションがあり、目パチを行う
					w = standLayer.imageWidth;
					h = standLayer.imageHeight;
					setImageSize(w, h);
					setSizeToImageSize();
					piledCopy(0,0,standLayer,0,0,w,h);
				}
			}
		}else if( asdExist && clipDataExist ){  //}else if(Storages.isExistentStorage(Storages.chopStorageExt(storage) + ".asd")){
			if(baseLayer === void)baseLayer = new global.Layer(window, this);
			if(elm.reload === void) baseLayer.loadImages(storage);		//
			asl = new AnimetionScriptLeader(this,baseLayer);			//アニメーション管理クラスの生成
			asl.SetupEnvironment(elm);									//アニメーションの基本動作の読み込み
			asl.SetupAnimetion(storage);								//アニメーションスクリプトデータの読み込み
			w = baseLayer.width;										//
			h = baseLayer.height;										//
			if(w == 0) w = baseLayer.imageWidth;						//
			if(h == 0) h = baseLayer.imageHeight;						//
			setImageSize(w, h);											//
			setSizeToImageSize();										//
			fillRect(0,0,w,h,0x0);										//
			
			if(asl.animetion){
				piledCopy(0,0,baseLayer,0,0,w,h);							//初期画像の呼び出し
				asl.Play();													//アニメーション開始
			}else{
				asl.Play();													//アニメーション開始
				piledCopy(0,0,baseLayer,0,0,w,h);							//初期画像の呼び出し
			}
		}else{
			var tmp = super.loadImages(...);
			this.setSizeToImageSize();
			LayerAddEffect(this);
			
			return tmp;
		}
	}

	function SyncAnimationSlotController(){
		if(syncAsl !== void) return syncAsl;
		return void;
	}
	
	function AutoBindHandler(){
		bindLayer.loadImages(%[]);
		fillRect(0,0,width,height,0x0);
		piledCopy(0,0,bindLayer,0,0,w,h);
		onTag();
	}
	
	function onTag(elm)
	{
		//dm("onTag");
		// ウィンドウ更新用
		if(baseLayer !== void)piledCopy(0,0,baseLayer,0,0,w,h);
		// 立ち絵更新用
		else if(timer !== void && standLayer) piledCopy(0,0,standLayer,0,0,standLayer.imageWidth,standLayer.imageHeight);
		else if(standLayer !== void){
			if(!flip_ud){
				piledCopy(0,0,standLayer,0,0,standLayer.imageWidth,standLayer.imageHeight\2);
			}else{
				piledCopy(0,0,standLayer,0,0,standLayer.imageWidth,standLayer.imageHeight);
			}
			
		}

		if(halfMask == 0){
			this.MaskRect(bgLayer.left, bgLayer.top, bgLayer, -bgLayer.imageLeft, -bgLayer.imageTop, bgLayer.width, bgLayer.height,3);
		}else if(halfMask == 1){
			var cnt = -bgLayer.imageLeft \ bgLayer.width;
			this.MaskRect(bgAlphaLayer.left, bgAlphaLayer.top, bgAlphaLayer, cnt * bgAlphaLayer.width, 0, bgAlphaLayer.width, bgAlphaLayer.height,3);
		}
		
		if(owner !== void && typeof owner.onTag != "undefined"){
			owner.onTag();
		}
	}
	
	function cutinLayer_activ_action(){
		if(cutinLayer.activ){
			cutinLayer.activ_action();
			piledCopy(0,0,cutinLayer,0,0,w,h);
			if(owner !== void){
				owner.cutin_move_stop();
			}
		}
		if(owner !== void && typeof owner.onTag != "undefined"){owner.onTag();}
	}
	
	function clear()
	{
		if(movie == ".amv"){
			//////////////////////////////////////////////
			/*独自形式のアルファ再生機能*/
			/*SingleLayerAlphaMoviePlayer記述部分のコメントアウトをはずしてAlphamovie.dllを読み込めば使用可能*/
			//SLAMP.stop();
			//invalidate SLAMP if SLAMP !== void;
			//SLAMP = void;
			//////////////////////////////////////////////

			/*
			alphamovie_object.stopmovie(%[slot:"0"]);
			alphamovie_object.movies[0].drawlayer = BackupFrontLayer;		//旧アドレスに戻す
			alphamovie_object.movies[0].drawlayerBack = BackupFrontLayer;
			alphamovie_object.movies[0].CreateDrawLayer( kag.fore.base, alphamovie_object.movies[0].drawlayer, 0 );
			alphamovie_object.movies[0].CreateDrawLayer( kag.back.base, alphamovie_object.movies[0].drawlayerBack, 0 );
			*/
			movie = "";
		}else if(movie != ""){
			fillRect(0,0,width,height,0x0);
			if(visible){visible = false;}
			kag.movies[0].stop();
			movie = "";
		}

		if(asl !== void){
			asl.Stop();
			invalidate asl;
		}

		if(syncAsl !== void) invalidate syncAsl;
		if(syncPath !== void) invalidate syncPath;
		
		asl = void;
		syncAsl = void;
		syncPath = void;
		invalidate timer if timer !== void;
		timer = void;
		invalidate standLayer if standLayer !== void;
		standLayer = void;
		invalidate frameLayer if frameLayer !== void;
		frameLayer = void;
		invalidate charaLayer if charaLayer !== void;
		charaLayer = void;
		invalidate limitLayer if limitLayer !== void;
		limitLayer = void;
		invalidate baseLayer if baseLayer !== void;
		baseLayer = void;
		invalidate moldLayer if moldLayer !== void;
		moldLayer = void;
		invalidate bgLayer if bgLayer !== void;
		bgLayer = void;
		invalidate bgAlphaLayer if bgAlphaLayer !== void;
		bgAlphaLayer = void;
		invalidate cutinLayer if cutinLayer !== void;
		cutinLayer = void;
		invalidate bindLayer if bindLayer !== void;
		bindLayer = void;
		invalidate wordLayer if wordLayer !== void;
		wordLayer = void;

		invalidate testLayer if testLayer !== void;
		testLayer = void;
		invalidate testLayer2 if testLayer2 !== void;
		testLayer2 = void;
		invalidate testLayer3 if testLayer3 !== void;
		testLayer3 = void;
		/*AlphaMovie用*/
		/*
		invalidate movieLayer if movieLayer !== void;
		movieLayer = void;
		*/
		invalidate fpLayer if fpLayer !== void;
		fpLayer = void;
		
		invalidate ereLayer if ereLayer !== void;
		ereLayer = void;

		halfMask = -1;
		/*
		for(var i = 0; i < sbLayer.count; i++) invalidate sbLayer[i];
		sbLayer.clear();
		*/
	}

	function finalize()
	{
		clear();
		super.finalize(...);
	}

	function loadFrameSetting(file)
	{
		var file = [].load(file);
		for(var i=0; i<file.count; i++)file[i] = file[i].split(/\t/,,false);
		return file;
	}
}

/*
class AutoRasterTempLayer extends Layer{
	var tempLayer;			//基礎レイヤー
	function AutoRasterTempLayer(win, par, storage){
		super.Layer(...);
	}
}
*/


/*画像加工用基本レイヤ*/
/*
class EffectStanderdLayer extend Layer{
	//
	var aemask = void;			//後付けのアルファ
	var alphaturn = false;		//
	var color;					//動作色調変化
	var rgamma,ggamma,bgamma;	//色調gamma値
	var rfloor,gfloor,bfloor;	//色調floor値
	var rceil,gceil,bceil;		//色調ceil値
	var correct;				//背景効果
	var grayscale;				//モノクロ化フラグ
	var sepia;					//セピア化フラグ
	var turn;					//色調反転
	var bblur = false;			//ボックスブラーのフラグ
	var bblur_extend = false;	//ボックスブラーの外縁補完
	var bblur_sq = false;		//ボックスブラーの二度掛け
	var bbx = 0;				//ボカシ範囲Ｘ
	var bby = 0;				//ボカシ範囲Ｙ
	var flip_lr = false;		//左右反転
	var flip_ud = false;		//上下反転
	var EffectLight;			//明度とコントラスト
	var brightness;				//brightness	明度 -255 ～ 255, 負数の場合は暗くなる
	var contrast;				//contrast		コントラスト -100 ～100, 0 の場合変化しない
	var EffectColorize;			//色相と彩度
	var hue;					//基礎パラメータ:色相(HUE)			-180～180 (度)
	var saturation;				//基礎パラメータ:彩度(SATURATION)	-100～100 (%)
	var blend;					//基礎パラメータ:ブレンド 0 (効果なし) ～ 1 (full effect)
	var EffectModulate;			//色相変更
	//var hue;					//基礎パラメータ:色相(HUE)			-180～180 (度)	※重複するので削除
	//var saturation;			//基礎パラメータ:彩度(SATURATION)	-100～100 (%)	※重複するので削除
	var luminance;				//基礎パラメータ:輝度(luminance)	-100～100 (%)
	
	function EffectStanderdLayer(win, par, storage){ super.Layer(...);}
	function loadImages(elm){}
	function loadEffect(elm){}
	function AddEffect(){}
	function finalize(...){ super.finalize(...);}
}
*/


/*
画像加工の工程
【最初期のロード】
↓
【最初期への全体加工】
↓
【最初期のアニメーション】
↓
【初期への部分加工】
↓
【エフェクトの移動】
↓
【エフェクトへの最終加工】

*/

/*
;//本体は基礎系の加工後
class EffectGeneralTempLayer extends Layer{
	var LoadLayer;			//初期系
	var SaveLayer;			//基本系
	//var SLAMP;			//ムービープレイヤー
	
	function EffectGeneralSaveLayer(win, par, storage){
		super.Layer(...);
	}
	
	function loadImages(elm = %[]){
		clear();
		
		if(elm.movie !== void){ LoadLayer = new movieLayer();								//movieLayer+SingleLayerAlphaMoviePlayer
		}else if(elm.cutin !== void){ LoadLayer = new CutinPiledLayer();					//CutinPiledLayer
		}else if(elm.word !== void){ LoadLayer = new WordLayer();							//WordLayer
		}else if(elm.bind !== void || storage === void){ LoadLayer = new AutoBindLayer();	//AutoBindLayer
		}else{ LoadLayer = new AutoPiledLayer();}											//AutoPiledLayer
		
	}
	
	function clear()
	{
		invalidate LoadLayer if LoadLayer !== void;
		LoadLayer = void;
		invalidate SaveLayer if SaveLayer !== void;
		SaveLayer = void;
	}
	function update(){
		SaveLayer.assignImages(LoadLayer);
	}

	function finalize()
	{
		clear();
		super.finalize(...);
	}
}
*/

//CutInLineアニメーションの作成
//拡張子.claファイルの作成
//表示領域幅 表示領域高さ 表示領域左端開始位置 表示領域左端終了位置

//line:引数=(読み込み画像,move方法,moveコマ数,anm番号,anmコマ数) * n

//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

//エフェクトの基本骨組みを作成
class EffectParamsController
{
	var size;											//サイズ全体のパラメータ
	var xsize;											//横幅サイズのパラメータ
	var ysize;											//縦幅サイズのパラメータ
	var cx;												//
	var cy;												//
	var rad;											//
	var xspin;											//
	var yspin;											//
	var alpha_add;										//
	var alpha_x;										//
	var alpha_y;										//
	var alpha_size;										//
	var absolute;										//
	var rgamma;											//
	var ggamma;											//
	var bgamma;											//
	var rfloor;											//
	var gfloor;											//
	var bfloor;											//
	var rceil;											//
	var gceil;											//
	var bceil;											//
	var mosaic;											//
	var BeforeRasterMaxHeight;							//
	var BeforeRasterLine;								//
	var AfterRasterMaxHeight;							//
	var AfterRasterLine;								//
	var RideAlphaAddPrams;								//
	var bbx;											//
	var bby;											//
	var EffectMask;										//
	var MaskLevelA;										//
	var MaskLevelB;										//
	
	function EffectParamsController(obj_no){
		size = new ParamsArray(1);						//初期値は、1
		xsize = new ParamsArray(1);						//初期値は、1
		ysize = new ParamsArray(1);						//初期値は、1
		cx = new ParamsArray(0.5);						//初期値は、0.5(この形式だと画像の中央)
		cy = new ParamsArray(0.5);						//初期値は、0.5(この形式だと画像の中央)
		rad = new ParamsArray(0);						//初期値は、0
		xspin = new ParamsArray(0);						//初期値は、0
		yspin = new ParamsArray(0);						//初期値は、0
		alpha_add = new ParamsArray(0);					//初期値は、0
		alpha_x = new ParamsArray(0);					//初期値は、0
		alpha_y = new ParamsArray(0);					//初期値は、0
		alpha_size = new ParamsArray(1);				//初期値は、1
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
		bbx = new ParamsArray(0);						//
		bby = new ParamsArray(0);						//
		EffectMask = new ParamsArray(128);				//
		MaskLevelA = new ParamsArray(10);				//
		MaskLevelB = new ParamsArray(10);				//
	}
	
	function finalize()
	{
		//配列データの終了準備
		invalidate size;							//
		invalidate xsize;							//
		invalidate ysize;							//
		invalidate cx;								//
		invalidate cy;								//
		invalidate rad;								//
		invalidate xspin;							//
		invalidate yspin;							//
		invalidate alpha_add;						//
		invalidate alpha_x;							//
		invalidate alpha_y;							//
		invalidate alpha_size;						//
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

	function ParamsSet(elm){
		size.ArrayForParams(elm.size, elm.ss, elm.ds);		// サイズ変化を配列化
		xsize.ArrayForParams(elm.xsize);					// サイズ変化【横】を配列化
		ysize.ArrayForParams(elm.ysize);					// サイズ変化【縦】を配列化
		cx.ArrayForParams(elm.cx);							// 回転中心【Ｘ軸】の配列化指定
		cy.ArrayForParams(elm.cy);							// 回転中心【Ｙ軸】の配列化指定
		rad.ArrayForParams(elm.rad, elm.sr, elm.dr);		// 回転角度【Ｚ軸】の配列化
		for(var i = rad.params.count-1; i>=0; i--){
			rad.params[i] = +rad.params[i]*(Math.PI/180) * -1;	//角度は周期計算なので係数倍を360°=2πとする
		}
		xspin.ArrayForParams(elm.xspin);					// 縦回転であるxspinの配列のセット
		yspin.ArrayForParams(elm.yspin);					// 横回転であるyspinの配列のセット
		alpha_add.ArrayForParams(elm.alpha_add);			//アルファ増幅用の配列の作成
		alpha_x.ArrayForParams(elm.alpha_x);				// alpha_xの配列のセット
		alpha_y.ArrayForParams(elm.alpha_y);				// alpha_yの配列のセット
		alpha_size.ArrayForParams(elm.alpha_size);			// 絶対位置であるabsoluteの配列のセット
		absolute.ArrayForParams(elm.absolute);				// 絶対位置であるabsoluteの配列のセット
		rgamma.ArrayForParams(elm.rgamma);					// 色調補正のrgammaの配列のセット
		ggamma.ArrayForParams(elm.ggamma);					// 色調補正のggammaの配列のセット
		bgamma.ArrayForParams(elm.bgamma);					// 色調補正のbgammaの配列のセット
		rfloor.ArrayForParams(elm.rfloor);					// 色調補正のrfloorの配列のセット
		gfloor.ArrayForParams(elm.gfloor);					// 色調補正のgfloorの配列のセット
		bfloor.ArrayForParams(elm.bfloor);					// 色調補正のbfloorの配列のセット
		rceil.ArrayForParams(elm.rceil);					// 色調補正のrceilの配列のセット
		gceil.ArrayForParams(elm.gceil);					// 色調補正のgceilの配列のセット
		bceil.ArrayForParams(elm.bceil);					// 色調補正のbceilの配列のセット
		mosaic.ArrayForParams(elm.mosaic);					//モザイクのピクセル変動値を配列化
		BeforeRasterMaxHeight.ArrayForParams(elm.brm);		//振幅指定
		BeforeRasterLine.ArrayForParams(elm.brl);			//ライン数指定
		AfterRasterMaxHeight.ArrayForParams(elm.arm);		//振幅指定
		AfterRasterLine.ArrayForParams(elm.arl);			//ライン数指定
		bbx.ArrayForParams(elm.bbx);						//
		bby.ArrayForParams(elm.bby);						//
		EffectMask.ArrayForParams(elm.em);					//モザイクのピクセル変動値を配列化
		if(elm.ml !== void){
			MaskLevelA.ArrayForParams(elm.ml);				//モザイクのピクセル変動値を配列化
			MaskLevelB.ArrayForParams(elm.ml);				//モザイクのピクセル変動値を配列化
		}else{
			MaskLevelA.ArrayForParams(elm.mla);				//モザイクのピクセル変動値を配列化
			MaskLevelB.ArrayForParams(elm.mlb);				//モザイクのピクセル変動値を配列化
		}
	}
	
	function ArrayParamsClear(){
		size.clear();								//
		xsize.clear();								//
		ysize.clear();								//
		cx.clear();									//
		cy.clear();									//
		rad.clear();								//
		xspin.clear();								//
		yspin.clear();								//
		alpha_add.clear();							//
		alpha_x.clear();							//
		alpha_y.clear();							//
		alpha_size.clear();							//
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

	/*pathは別口に必要が有るので変更*/
	function AllgettimeForState(totalTime){
		size.TimeForParams(totalTime);						// サイズ用の時間を計算
		xsize.TimeForParams(totalTime);						// サイズ用の時間を計算
		ysize.TimeForParams(totalTime);						// サイズ用の時間を計算
		rad.TimeForParams(totalTime);						// 角度用の時間を計算
		xspin.TimeForParams(totalTime);						// XSpin用の時間を計算
		yspin.TimeForParams(totalTime);						// YSpin用の時間を計算
		absolute.TimeForParams(totalTime);					// absolute用の時間を計算
		alpha_add.TimeForParams(totalTime);					// alpha_size用の時間を計算
		alpha_size.TimeForParams(totalTime);				// alpha_size用の時間を計算
		alpha_x.TimeForParams(totalTime);					// alpha_x用の時間を計算
		alpha_y.TimeForParams(totalTime);					// alpha_y用の時間を計算
		cx.TimeForParams(totalTime);						// alpha_x用の時間を計算
		cy.TimeForParams(totalTime);						// alpha_y用の時間を計算
		rgamma.TimeForParams(totalTime);					// rgamma用の時間を計算
		ggamma.TimeForParams(totalTime);					// ggamma用の時間を計算
		bgamma.TimeForParams(totalTime);					// bgamma用の時間を計算
		rfloor.TimeForParams(totalTime);					// rfloor用の時間を計算
		gfloor.TimeForParams(totalTime);					// gfloor用の時間を計算
		bfloor.TimeForParams(totalTime);					// bfloor用の時間を計算
		rceil.TimeForParams(totalTime);						// rceil用の時間を計算
		gceil.TimeForParams(totalTime);						// gceil用の時間を計算
		bceil.TimeForParams(totalTime);						// bceil用の時間を計算
		bbx.TimeForParams(totalTime);						//
		bby.TimeForParams(totalTime);						//
		BeforeRasterMaxHeight.TimeForParams(totalTime);		// RasterScroll用最大振幅の時間を計算
		BeforeRasterLine.TimeForParams(totalTime);			// RasterScroll用ライン数の時間を計算
		AfterRasterMaxHeight.TimeForParams(totalTime);		// RasterScroll用最大振幅の時間を計算
		AfterRasterLine.TimeForParams(totalTime);			// RasterScroll用ライン数の時間を計算
		mosaic.TimeForParams(totalTime);					// mosaic用の時間を計算
		RideAlphaAddPrams.TimeForParams(totalTime);			//
		EffectMask.TimeForParams(totalTime);				//
		MaskLevelA.TimeForParams(totalTime);				//
		MaskLevelB.TimeForParams(totalTime);				//
	}

	function NowParams(elm,tick){
		elm["s"] = size.GetNowParams(tick);						// サイズ用の時間を計算
		elm["s_x"] = xsize.GetNowParams(tick);					// サイズ用の時間を計算
		elm["s_y"] = ysize.GetNowParams(tick);					// サイズ用の時間を計算
		elm["r"] = rad.GetNowParams(tick);						// 角度用の時間を計算
		elm["xspin"] = xspin.GetNowParams(tick);				// XSpin用の時間を計算
		elm["yspin"] = yspin.GetNowParams(tick);				// YSpin用の時間を計算
		elm["absolute"] = absolute.GetNowParams(tick);			// absolute用の時間を計算
		elm["s"] = alpha_add.GetNowParams(tick);				// alpha_size用の時間を計算
		elm["alpha_size"] = alpha_size.GetNowParams(tick);		// alpha_size用の時間を計算
		elm["alpha_x"] = alpha_x.GetNowParams(tick);			// alpha_x用の時間を計算
		elm["alpha_y"] = alpha_y.GetNowParams(tick);			// alpha_y用の時間を計算
		elm["cx"] = cx.GetNowParams(tick);						// alpha_x用の時間を計算
		elm["cy"] = cy.GetNowParams(tick);						// alpha_y用の時間を計算
		elm["rgamma"] = rgamma.GetNowParams(tick);				// rgamma用の時間を計算
		elm["ggamma"] = ggamma.GetNowParams(tick);				// ggamma用の時間を計算
		elm["bgamma"] = bgamma.GetNowParams(tick);				// bgamma用の時間を計算
		elm["rfloor"] = rfloor.GetNowParams(tick);				// rfloor用の時間を計算
		elm["gfloor"] = gfloor.GetNowParams(tick);				// gfloor用の時間を計算
		elm["bfloor"] = bfloor.GetNowParams(tick);				// bfloor用の時間を計算
		elm["rceil"] = rceil.GetNowParams(tick);				// rceil用の時間を計算
		elm["gceil"] = gceil.GetNowParams(tick);				// gceil用の時間を計算
		elm["bceil"] = bceil.GetNowParams(tick);				// bceil用の時間を計算
		/*
		elm["bbx"] = bbx.GetNowParams(tick);					//
		elm["bby"] = bby.GetNowParams(tick);					//
		elm["brmh"] = BeforeRasterMaxHeight.GetNowParams(tick);	// RasterScroll用最大振幅の時間を計算
		elm["brl"] = BeforeRasterLine.GetNowParams(tick);		// RasterScroll用ライン数の時間を計算
		elm["armh"] = AfterRasterMaxHeight.GetNowParams(tick);	// RasterScroll用最大振幅の時間を計算
		elm["arl"] = AfterRasterLine.GetNowParams(tick);		// RasterScroll用ライン数の時間を計算
		elm["mosaic"] = mosaic.GetNowParams(tick);				// mosaic用の時間を計算
		elm["raap"] = RideAlphaAddPrams.GetNowParams(tick);		//
		elm["em"] = EffectMask.GetNowParams(tick);				//
		elm["mla"] = MaskLevelA.GetNowParams(tick);				//
		elm["mlb"] = MaskLevelB.GetNowParams(tick);				//
		*/
	}
}


@endscript

@return


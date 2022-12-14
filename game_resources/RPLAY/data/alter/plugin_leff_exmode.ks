
@iscript

//予測関数
function PredictionPointSet( elm, target, vn, tr, as = 0){
	var osrc = 3 * vn + as;											//配列の添え字
	elm.offsetpath += MovementPredictionPoint( target, osrc, tr);	//位置予測地点計算をする
	
	//この辺はオプションがあったほうがいいかも
	elm.rad += AnglePredictionPoint( target, osrc, elm.rcnt);		//角度予測地点の計算をする		【Result】
}

//位置座標の予測関数
function MovementPredictionPoint( target, osrc, tr){
	var _cx = target.SaveResults[osrc];								//位置情報の基本値を取得		【CosXpos】
	var _sy = target.SaveResults[osrc + 1];							//位置情報の基本値を取得		【SinYpos】
	var ex = (int)(_cx * tr);										//最終点のX座標					【EndXpos】
	var ey = (int)(_sy * tr);										//最終点のY座標					【EndYpos】
	
	return "(" + ex + "," + ey + ",255)";							//戻り値
}

//角度の予測関数
function AnglePredictionPoint( target, osrc, rcnt){
	var n_r = target.SaveResults[osrc + 2];							//位置情報の基本値を取得		【NowRotate】
	var _rcnt = (rcnt !== void) ? +rcnt * 360 : 0;					//
	n_r += _rcnt;
	return "(" + n_r + ")";											//戻り値
}

//回転時の先格納計算
function RotationAngleCalculation(target, pn){
	var ia = 360 / pn;												//内接円の中心部の内角			【interrior_angle】
	var iar = (2 * Math.PI) / pn;									//内接円の中心部の内角			【interrior_angle_Rotate】

	var cnt = 0;
	
	//円に内接する座標点計算を先に行う
	for(cnt = 0; cnt < pn; cnt++){
		var tia = ia * cnt;											//角度の計算					【temp_interrior_angle】
		var tiar = iar * cnt;										//角度の計算					【temp_interrior_angle_Rotate】

		//↓2角度θの正弦値と余弦値を求める。座標算出に使用
		var _cx = Math.cos(tiar);									//cosθの計算結果
		var _sy = Math.sin(tiar);									//sinθの計算結果

		//↓3重複演算を防ぐために、一時的に保存
		target.addSaveResults(_cx);									//計算結果を親の管理クラスへ保存【cosθ】
		target.addSaveResults(_sy);									//計算結果を親の管理クラスへ保存【sinθ】
		target.addSaveResults(tia);									//計算結果を親の管理クラスへ保存【Rotate】
	}
	return cnt*3;													//計算の格納個数を返す
}

function XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX(){
	/**/var _xx = 1 - (x*x);
}

//特定動作のアニメーション作成
function ExmodeSetCircle(owner,elm,obj_no){
	var mcr = +elm.mcr;												//最大サイズ					【MaxCircleRadius】
	var pn = +elm.pn;												//内接角の個数					【PolygonNunber】
	var mcn = +elm.mcn;												//最大サイズ内の円の生成数		【MaxCircleNumber】

	//一つ目の場合は使用する演算を先に行う
	if(obj_no == 0){ RotationAngleCalculation(owner, pn);}			//回転計算

	//
	var startpath = "(0,0,255)";									//始点パス						【StartPath】
	var startrad = "";												//始点角度						【StartRotate】
	var trn = obj_no \ pn;											//囲い番号						【TreeRingsNumber】
	var vn = obj_no - (trn * pn);									//頂点番号						【VertexNumber】
	var tr = mcr / mcn;												//こいつの半径					【thisRadius】
	tr = tr * (trn + 1);											//半径の計算

	var rcnt = trn;													//回転数						【RotateCnt】
	elm.rcnt = rcnt;
	
	elm.offsetpath = startpath;										//始点パスを格納
	elm.rad = startrad;												//始点角度を格納
	PredictionPointSet( elm, owner, vn, tr);						//終点の格納
	
	elm.size = "(1,1)";												//値を格納
	if(elm.offsettime === void){ elm.offsettime = +elm.time / 2;}	//値を格納
	return elm;														//戻り値
}

function ExmodeSetSpiral(owner,elm,obj_no){
	var mcr = +elm.mcr;												//最大サイズ					【MaxCircleRadius】
	var pn = +elm.pn;												//内接角の個数					【PolygonNunber】
	var mcn = +elm.mcn;												//最大サイズ内の円の生成数		【MaxCircleNumber】
	var max_n = pn * mcn;											//最大個数
	var spn = obj_no / max_n; 										//【SpiralNubler】
	var tr = mcr * spn;												//こいつの半径					【thisRadius】

	//一つ目の場合は使用する演算を先に行う
	if(obj_no == 0){ RotationAngleCalculation(owner, pn);}			//回転計算

	var startpath = "(0,0,255)";									//始点パス						【StartPath】
	var startrad = "";												//始点角度						【StartRotate】
	var trn = obj_no \ pn;											//囲い番号						【TreeRingsNumber】
	var vn = obj_no - (trn * pn);									//頂点番号						【VertexNumber】
	var tr = mcr / mcn;												//こいつの半径					【thisRadius】
	tr = tr * (trn + 1);											//半径の計算

	var rcnt = trn;													//回転数						【RotateCnt】
	elm.rcnt = rcnt;

	elm.offsetpath = startpath;										//始点パスを格納
	elm.rad = startrad;												//始点角度を格納
	PredictionPointSet( elm, owner, vn, tr);						//終点の格納
	
	elm.size = "(0,"+ spn +")";										//
	elm.offsetdelay = 10 * (max_n - obj_no);						//
	
	if(elm.offsettime === void){ elm.offsettime = +elm.time / 2;}	//値を格納
	if(elm.offsetaccel === void){elm.offsetaccel = "-1.3";}			//値を格納
	
	return elm;
}

function ExmodeSetSpiral2(owner,elm,obj_no){
	var mcr = +elm.mcr;												//最大サイズ					【MaxCircleRadius】
	var pn = +elm.pn;												//内接角の個数					【PolygonNunber】
	var mcn = +elm.mcn;												//最大サイズ内の円の生成数		【MaxCircleNumber】
	var max_n = pn * mcn;											//最大個数
	var spn = obj_no / max_n; 										//【SpiralNubler】
	var tr = mcr * spn;												//こいつの半径					【thisRadius】

	var racus = 0;													//配列の仕様個数				【RotationAngleCalculationUsedSpace】
	
	//一つ目の場合は使用する演算を先に行う
	if(obj_no == 0){ racus = RotationAngleCalculation(owner, pn);}	//回転計算

	var pcnt = (elm.pcnt !== void) ? +elm.pcnt: 2;					//移動値						【PathCount】
	var tv = (elm.tv !== void) ? +elm.tv: 0;						//移動値						【TravelValue】
	var tva = (elm.tva !== void) ? +elm.tva: 0;						//移動値の加速度				【TravelValueAccel】

	/**/
	var startpath = "";												//始点パス						【StartPath】
	var startrad = "";												//始点角度						【StartRotate】
	var trn = obj_no \ pn;											//囲い番号						【TreeRingsNumber】
	var vn = obj_no - (trn * pn);									//頂点番号						【VertexNumber】

	/**/
	var trs = mcr / mcn;											//こいつの半径の基準値			【thisRadiusStanderd】
	var tr = trs * (trn);											//こいつの半径					【thisRadius】

	elm.offsetpath = startpath;										//始点パスを格納
	elm.rad = startrad;												//始点角度を格納
	var rcnt = trn;													//回転数						【RotateCnt】
	elm.rcnt = rcnt;
	PredictionPointSet( elm, owner, vn, tr);						//終点の格納
	
	
	//dm("rcnt[" + obj_no + "]:" + rcnt);
	//半径演算
	//var xxx = mcr -((x - pcnt) * (x - pcnt));
	
	for(var i = 1; i < pcnt; i++, tv += tva){
		vn += tv;
		
		//内接頂点の移動
		for(;vn >= pn; rcnt++){ vn -= pn;}
		elm.rcnt = rcnt;
		
		//半径回り
		trn++;														//一つ外側の円へ
		var tr = trs * (trn);									//半径の再計算
		
		//演算
		PredictionPointSet( elm, owner, vn, tr);					//終点の格納
	}
	
	//elm.offsetdelay = 100 * (max_n - obj_no);						//
	if(elm.offsettime === void){ elm.offsettime = +elm.time / (pcnt-1);}	//値を格納
	if(elm.offsetaccel === void){ elm.offsetaccel = 0;}				//値を格納

	//elm.offsetdelay = 10 * (max_n - obj_no);						//
	//dm("path[" + obj_no + "]:" + elm.offsetpath);
	//dm("rad[" + obj_no + "]:" + elm.rad);
	return elm;
}

function ExmodeSet(owner, elm, obj_no){
	var r_elm;
	
	if(elm.exmode == "Circle"){
		r_elm = ExmodeSetCircle(owner,elm,obj_no);
	}else if(elm.exmode == "Spiral"){
		r_elm = ExmodeSetSpiral(owner,elm,obj_no);
	}else if(elm.exmode == "Spiral2"){
		r_elm = ExmodeSetSpiral2(owner,elm,obj_no);
	}else{
		r_elm = elm;
	}
	
	return r_elm;
	
	return elm;
}

@endscript

@return


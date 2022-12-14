;//f特殊動作の外部ファイル
;//こっちの関数を本家で呼ぶ形
;//関数には本体を呼ぶように必ず第一引数はowner

;//処理を大雑把に説明すると
;//初期計算(必要)
;//描画時の計算(必要)
;//ループ時の再計算(絶対に必要ではない)

;//FunctionCalculationで初期計算をセット
;//FunctionSelectで描画時の計算をセット
;//LoopFunctionSelectでループ時の再計算をセット

;//新規で作成したい場合は、必要な関数を作成、
;//必要な部分にセットすればいい(elm.spmodeのif分け)
;//後は勝手に処理してくれる
;//現在は、現状は位置情報のみだが、そのうちサイズなども編集する
;//急ぎで必要な場合は声をかけてください。（追加処理自体は難しくはない）

@iscript

class ArithmeticProcessing
{
	var owner = void;													// 自身を管理しているプラグイン
	var array = [];														// 計算結果でのパラメータを保存する
	var params = [];													// エフェクトで使用しているクラスを保持する配列
	var element = [];													// マクロからのパラメータを保存する
	var dic = %[];														// 計算での必要パラメータを保存する
	var totalTime = 1;													// オブジェクトの移動終了までの時間
	var func = void;													// 描画時で実行する関数を指定、デフォルトはvoid
	var loop = void;													// ループで実行する関数を指定、デフォルトはvoid
	var storeDic = %[];													// セーブ保存用

	//生成時(コンストラクタ)
	function ArithmeticProcessing(own, elm)
	{
		owner = own;													// 自身を管理しているプラグインを設定
		func = void;													// 描画時で実行する関数を初期化
		loop = void;													// ループで実行する関数を初期化
		(Dictionary.assign incontextof storeDic)(elm);					// 自身のマクロパラメータを保存
		
		// パス全体の時間を取得
		var pathNum = 1;												// パスの個数
		if(elm.path !== void){
			var temp = [].split("(), ", elm.path, , true);				// マクロのパラメータよりpath属性を分解
			pathNum = (temp.count \ 3) - 1;								// パスの個数を取得
		}
		
		totalTime = 1;													// 全体の時間
		if(elm.time !== void) totalTime = pathNum * +elm.time;			// 全体の時間を設定
		FunctionCalculation(elm);										// 初期計算を実行
		FunctionSelect(elm);											// 描画時で実行する関数を指定
		LoopFunctionSelect(elm);										// ループで実行する関数を指定
	}

	//終了時(デストラクタ)
	function finalize()
	{
		for(var i = 0; i < array.count; i++) array[i].clear();			// 計算結果でのパラメータを初期化
		array.clear();													// 計算結果でのパラメータを初期化
		for(var i = 0; i < params.count; i++) invalidate params[i];		// エフェクトで使用しているクラスを開放
		params.clear();													// エフェクトで使用しているクラスを保持する配列の初期化
		for(var i = 0; i < element.count; i++) element[i].clear();		// マクロからのパラメータを保存する配列を初期化
		element.clear();												// マクロからのパラメータを保存する配列を初期化
		(Dictionary.clear incontextof dic)();							// 計算での必要パラメータを保存する辞書配列を初期化
		(Dictionary.clear incontextof storeDic)();						// セーブ保存用辞書配列を初期化
	}

	//初期に行う計算処理の指定
	function FunctionCalculation(elm)
	{
		if(elm.spdor === void) elm.dor = 1;								// 円運動の際の向きを指定(指定パラメータがなければ右回り)
		if(elm.spdor == "l") elm.dor = -1;								// 円運動の際の向きを指定(左回り)
		if(elm.spdor == "r") elm.dor = 1;								// 円運動の際の向きを指定(右回り)
		
		if(elm.spmode == "rp") RandomPos(elm);
		if(elm.spmode == "crp") ConnectRandomPos(elm);
		//if(elm.spmode == "c") Circle(elm);
		if(elm.spmode == "cr") CircleRotation(elm);
		if(elm.spmode == "sr") Spiral(elm);
	}

	//毎回行う動作を指定
	function FunctionSelect(elm)
	{
		if(elm.spmode == "rp") func = AdvancingPoint;
		if(elm.spmode == "crp") func = AdvancingPoint;
		//if(elm.spmode == "c") func = AdvancingPoint;
		if(elm.spmode == "cr") func = AdvancingCircle;
		if(elm.spmode == "sr") func = AdvancingSpiral;
	}

	//ループの際に実行する関数を指定
	function LoopFunctionSelect(elm)
	{
		if(elm.spmode == "rp") loop = LF_RandomPos;
		if(elm.spmode == "crp") loop = LF_ConnectRandomPos;
	}
	
	//作業動作中
	function MovingFunction(obj,tick)
	{
		if(func !== void) return func(obj,tick);
		return %[];
	}

	//ループした際の処理
	function LoopingFunction(obj)
	{
		if(loop !== void) loop(obj);
	}

	//指定されているランダム点を配置
	function RandomPos(elm)
	{
		//配列に追加して呼び出す
		for(var i = 0; i < element.count; i++) element[i].clear();		// 範囲の配列を初期化
		element.clear();												// 範囲の配列を初期化
		element.add([]);												// xの範囲配列
		element.add([]);												// yの範囲配列
		if(elm.spzone !== void){
			var temp = [].split("(), ", elm.spzone, , true);			// 指定範囲の文字列を分解
			for(var i = 0; i < temp.count; i+=4){
				element[0].add(+temp[i]);								// ４つで一つ配列群
				element[1].add(+temp[i+1]);								// (x1,y1)(x2,y2)・・・という形でセットする
				element[0].add(+temp[i+2]);								// (x1～x2,y1～y2)が座標の取りえる範囲になる
				element[1].add(+temp[i+3]);								// 第二座標指定がない場合は第一座標と同じ座標が選択されるためランダムで移動しない座標となる
			}
			temp.clear();												// 文字列配列を初期化
		}else{
			element[0].add(-100);										// (-100,-100)(100,100)
			element[1].add(-100);										// の間を標準指定とする
			element[0].add(100);										// (-100～100,-100～100)が座標の取りえる範囲になる
			element[1].add(100);										// 第二座標は第一座標と同じ座標が選択されるためランダムで移動しない座標となる
		}
		dic.max = +elm.quantity;										// 最大個数
		for(var i = 0; i < dic.max; i++){
			var pos = [];												// 座標群
			for(var j = 0; j < element[0].count; j+=2){
				pos.add(intrandom(element[0][j],element[0][j+1]));		// Ｘの座標点をセット
				pos.add(intrandom(element[1][j],element[1][j+1]));		// Ｙの座標点をセット
			}
			array.add(pos);												// 座標群を管理配列へセット
		}

		//二点なければ二点にする
		if(array[0].count == 2){
			dic.fixed = true;												// 再セット時に同じ動作を行うための判別フラグ
			for(var i = 0; i < array.count; i++){
				array[i].add(array[i][0]);									// Ｘの始点を終点にもセット
				array[i].add(array[i][1]);									// Ｙの始点を終点にもセット
			}
		}

		dic.count = array[0].count \ 2;										// 座標間の個数を取得
		dic.tick = totalTime / (dic.count - 1);								// 座標間の時間を計算
	}

	//ループ時に指定されているランダム点を再配置
	function LF_RandomPos(obj)
	{
		var num = obj.groupNum;												//オブジェクト番号
		for(var i = 0; i < array[num].count; i+=2){
			array[num][i] = intrandom(element[0][i],element[0][i+1]);		//
			array[num][i + 1] = intrandom(element[1][i],element[1][i+1]);	//
		}

		if(dic.fixed === true){
			array[num][2] = array[num][0];									// 初期計算時にpathが一点の場合に次点にも同じＸ座標を格納
			array[num][3] = array[num][1];									// 初期計算時にpathが一点の場合に次点にも同じＹ座標を格納
		}
	}

	//終点を始点に格納して指定されているランダム点を配置
	function ConnectRandomPos(elm)
	{
		//配列に追加して呼び出す
		for(var i = 0; i < element.count; i++) element[i].clear();
		element.clear();
		element.add([]);		//xの範囲
		element.add([]);		//yの範囲
		if(elm.spzone !== void){
			var temp = [].split("(), ", elm.spzone, , true);
			for(var i = 0; i < temp.count; i+=4){
				element[0].add(+temp[i]);
				element[1].add(+temp[i+1]);
				element[0].add(+temp[i+2]);
				element[1].add(+temp[i+3]);
			}
			temp.clear();
		}else{
			element[0].add(-100);
			element[1].add(-100);
			element[0].add(100);
			element[1].add(100);
		}
		dic.max = +elm.quantity;		//最大個数

		/*特殊配列*/
		for(var i = 0; i < dic.max; i++){
			var pos = [];
			pos.add(0);
			pos.add(0);
			for(var j = 0; j < element[0].count; j+=2){
				pos.add(intrandom(element[0][j],element[0][j+1]));
				pos.add(intrandom(element[1][j],element[1][j+1]));
			}
			array.add(pos);
		}
		dic.count = array[0].count \ 2;
		dic.tick = totalTime / (dic.count - 1);
	}

	//ループ時に終点を始点に格納して指定されているランダム点を再配置
	function LF_ConnectRandomPos(obj)
	{
		//個物処理
		var num = obj.groupNum;
		var lastX = array[num].count - 2;
		var lastY = array[num].count - 1;
		array[num][0] = array[num][lastX];
		array[num][1] = array[num][lastY];
		
		for(var i = 0; i < array[num].count - 2; i+=2){
			array[num][i + 2] = intrandom(element[0][i],element[0][i+1]);
			array[num][i + 3] = intrandom(element[1][i],element[1][i+1]);
		}
	}
	
	//円表示の準備処理
	function Circle(elm)
	{		
		var max = +elm.quantity;		//最大個数
		var unit = 2 * Math.PI / max;	//基準角
		var ur = 0;
		var sr;
		var er;
		
		//周期の開始点を指定
		if(elm.periodpoint !== void) ur = (+elm.periodpoint / 180) * Math.PI;

		//配列に追加して呼び出す
		if(elm.spradius !== void){
			var temp = [].split("(), ", elm.spradius, , true);
			for(var i = 0; i < temp.count; i++) temp[i] = +temp[i];
			sr = temp[0];
			er = temp[1];
		}else{
			sr = 300;
			er = 300;
		}
		
		for(var i = 0; i < array.count; i++) array[i].clear();
		array.clear();
		
		unit = unit * elm.dor;
		//初期角度の追加が必要
		for(var i = 0; i <= max; i++){
			var _x = Math.cos(ur);
			var _y = Math.sin(ur);
			array.add([sr * _x, sr * _y, er * _x, er * _y, ur]);
			ur += unit;
		}
	}
	
	//回転の準備処理
	function CircleRotation(elm)
	{
		var max = +elm.quantity;		//最大個数
		var unit = 2 * Math.PI / max;	//基準角
		var ur = 0;
		
		//周期の開始点を指定
		if(elm.periodpoint !== void) ur = (+elm.periodpoint / 180) * Math.PI;
		
		//配列に追加して呼び出す
		if(elm.spradius !== void){
			var temp = [].split("(), ", elm.spradius, , true);
			for(var i = 0; i < temp.count; i++) temp[i] = +temp[i];
			dic.sr = temp[0];
			dic.r = temp[1];
			dic.ar = temp[1] - temp[0];
		}else{
			dic.sr = 300;
			dic.r = 300;
			dic.ar = 0;
		}
		unit = unit * elm.dor;
		params.add(new ParamsArray(0));
		params.add(new ParamsArray(0));
		params.add(new ParamsArray(0));
		
		//初期角度の追加が必要
		for(var i = 0; i <= max; i++){
			params[0].AddArrayForParams((Math.cos(ur)));
			params[1].AddArrayForParams((Math.sin(ur)));
			params[2].AddArrayForParams((ur));
			ur += unit;
		}
		
		params[0].TimeForParams(totalTime);
		params[1].TimeForParams(totalTime);
		params[2].TimeForParams(totalTime);
	}

	function Spiral(elm){
		
		params.add(new ParamsArray(0));			//（0,0）からの大きさ１の円運動の✕のパラメータ
		params.add(new ParamsArray(0));			//（0,0）からの大きさ１の円運動のＹのパラメータ
		params.add(new ParamsArray(0));			// (1.0) と大きさ１の円運動の座標(X,Y)とで形成される角度
		params.add(new ParamsArray(100));		// 半径のパラメータ

		var ur = 0;

		//周期の開始点を指定
		if(elm.periodpoint !== void) ur = (+elm.periodpoint / 180) * Math.PI;
			
		//配列に追加して呼び出す
		if(elm.spradius !== void){
			var temp = [].split("(), ", elm.spradius, , true);
			for(var i = 0; i < temp.count; i++) temp[i] = +temp[i];
			if(temp.count < 2) temp.add(temp[0]);
			params[3].AddArrayForParams(+temp[0]);
			params[3].AddArrayForParams(+temp[1]);
			temp.clear();
		}else{
			params[3].AddArrayForParams(100);
			params[3].AddArrayForParams(100);
		}

		var not;
		var period;
		if(elm.spcircle !== void){
			var temp = [].split("(), ", elm.spcircle, , true);
			for(var i = 0; i < temp.count; i++) temp[i] = +temp[i];
			not = temp[1];
			period = temp[0];
			temp.clear();
		}else{
			not = 1;
			period = 12;
		}
		
		//配列値
		var max = period * not;				//最大個数
		var unit = 2 * Math.PI / period;	//基準角
		unit = unit * elm.dor;
		
		for(var i = 0; i <= max; i++){
			params[0].AddArrayForParams(Math.cos(ur));
			params[1].AddArrayForParams(Math.sin(ur));
			params[2].AddArrayForParams(ur);
			ur += unit;
		}
		
		params[0].TimeForParams(totalTime);
		params[1].TimeForParams(totalTime);
		params[2].TimeForParams(totalTime);
		params[3].TimeForParams(totalTime);

		dic.interval = totalTime / not;
		dic.interval = dic.interval / +elm.quantity;
	}
	
	
	//ランダム二点の進行処理
	function AdvancingPoint(obj,tick){
		var ap = %[];
		var num = obj.groupNum;
		if(num == 0){
			var now = tick \ dic.tick;
			dic.nowX = now * 2;
			dic.nowY = dic.nowX + 1;
			dic.nextX = dic.nowX + 2;
			dic.nextY = dic.nextX + 1;
			dic.per = (tick - now * dic.tick) / dic.tick;
		}
		
		if(dic.per == 0){
			ap.x = array[num][dic.nowX];
			ap.y = array[num][dic.nowY];
		}else{
			ap.x = array[num][dic.nowX] + (array[num][dic.nextX] - array[num][dic.nowX]) * dic.per;
			ap.y = array[num][dic.nowY] + (array[num][dic.nextY] - array[num][dic.nowY]) * dic.per;
		}
		return ap;
	}
	
	//円の回転処理(スキップ番号をかませると変な動きになる)
	function AdvancingCircle(obj,tick){
		var ap = %[];
		//進行度tickをいじる(時間を一コマ早くする)
		if(obj.groupNum == 0){
			//配列を意図的にずらす
			var per = tick / totalTime;
			dic.r = dic.sr + (dic.ar * per);
		}else{
			//加速処理
			tick += params[0].time * obj.groupNum;
			if(tick >= totalTime) tick -= totalTime;
		}
		
		ap.x = params[0].GetNowParams(tick) * dic.r;		// 現在のＸ座標
		ap.y = params[1].GetNowParams(tick) * dic.r;		// 現在のＹ座標
		ap.r = params[2].GetNowParams(tick);				// 現在の回転
		return ap;											// 結果を辞書配列で返す
	}
	
	function AdvancingSpiral(obj,tick){
		var ap = %[];
		//進行度tickをいじる(時間を一コマ早くする)
		//dm("GN:"+obj.groupNum);
		if(obj.groupNum == 0){
			//配列を意図的にずらす
			dic.r = params[3].GetNowParams(tick);
		}else{
			//加速処理
			tick += dic.interval * obj.groupNum;
			if(tick >= totalTime) tick -= totalTime;
		}
		ap.x = params[0].GetNowParams(tick) * dic.r;		// 現在のＸ座標
		ap.y = params[1].GetNowParams(tick) * dic.r;		// 現在のＹ座標
		ap.r = params[2].GetNowParams(tick);				// 現在の回転
		return ap;											// 結果を辞書配列で返す
	}
	
	
	/*
	function onStore(){
	}

	function onRestore(){
	}
	*/
}
@endscript
@endif

@return

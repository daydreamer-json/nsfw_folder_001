
@iscript

class RandSingleAttribute
{
	var standerd;
	var minimum;
	var maximum;
	var result;

	function RandSingleAttribute(st)
	{
		result = standerd = st;
	}

	function finalize(){}


	function AddSingle(min,max)
	{
		minimum = min;
		maximum = max;
	}

	function ResetRandom(){
		result = standerd + intrandom(minimum,maximum);
		return result;
	}
}

class RandPathArrayAttribute
{
	var target;				//ParamsArray限定
	var standerd = [];		//ParamsArrayの基準
	var targetArray = [];	//ランダム対象の配列番号の配列
	var minArray = [];		//最小値の配列
	var maxArray = [];		//最大値の配列
	var result = [];		//配列クラスに渡す演算再結果のリスト
	
	function RandPathArrayAttribute(tg)
	{
		target = tg;
		standerd.assign(tg);
		for(var i = 0; i < standerd.count; i++) result.add(0);
	}
	
	function finalize()
	{
		standerd.clear();
		targetArray.clear();
		maxArray.clear();
		minArray.clear();
		result.clear();
	}
	
	function AddTargetPathArray(mode,tg,min,max){
		if(mode == "x") tg = (tg * 3);
		else if(mode == "y") tg = (tg * 3) + 1;
		else if(mode == "a") tg = (tg * 3) + 2;
		else return;
		
		targetArray.add(tg);
		minArray.add(min);
		maxArray.add(max);
	}

	function ResetRandom(){
		for(var i = 0; i < result.count; i++) result[i] = 0;
		
		for(var i = 0; i < targetArray.count; i++){
			var num = targetArray[i];
			result[num] = intrandom(minArray[i],maxArray[i]);
		}
		for(var i = 0; i < result.count; i++) result[i] += standerd[i];
		target.assign(result);
	}
}

class RandSingleArrayAttribute
{
	//リストのコビー
	var target;				//ParamsArray限定
	var standerd = [];		//ParamsArrayの基準
	var targetArray = [];	//ランダム対象の配列番号の配列
	var maxArray = [];		//最大値の配列
	var minArray = [];		//最小値の配列
	var result = [];		//配列クラスに渡す演算再結果のリスト
	
	function RandSingleArrayAttribute(tg)
	{
		target = tg;
		standerd.assign(tg.params);
		for(var i = 0; i < standerd.count; i++) result.add(0);
	}
	
	function finalize()
	{
		standerd.clear();
		targetArray.clear();
		maxArray.clear();
		minArray.clear();
		result.clear();
	}
	
	function AddTargetArray(tg,min,max){
		targetArray.add(tg);
		minArray.add(min);
		maxArray.add(max);
	}

	function ResetRandom(){
		for(var i = 0; i < result.count; i++) result[i] = 0;
		
		for(var i = 0; i < targetArray.count; i++){
			var num = targetArray[i];
			result[num] = intrandom(minArray[i],maxArray[i]);
		}
		
		for(var i = 0; i < result.count; i++) result[i] += standerd[i];
		target.params.assign(result);
	}
}

@endscript
@endif

@return

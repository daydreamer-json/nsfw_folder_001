@iscript

;//スケジュール型

class ParameterScheduleController
{
	var params = [];			// パラメータの変動を記録する配列
	var time = [];				// パラメータの変動する時間を取得する配列
	var stime = [];				// パラメータの変動する時間を取得する配列
	var cnt;					//

	var s;
	
	function ComplementAction()
	{
	}

	function finalize()
	{
		params.clear();			// パラメータの配列を初期化
		time.clear();			// 変動時間の配列を初期化
		stime.clear();			// 開始時間の配列を初期化
	}

	function SetSchedule(array)
	{
	}
	
	function TimeSchedule(totalTime)
	{
		//残りの時間を埋める処理
		//0からたどるしかない
		//stime[0]
	}
	
}

@endscript

@return

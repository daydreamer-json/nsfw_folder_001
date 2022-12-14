@if exp="typeof(global.sigcheckOject) == 'undefined'"
@iscript

// ファイルの正当性チェックプラグイン
class SigCheckPlugin extends KAGPlugin
{
	var initialized = false;	// 初期化を行ったかどうか、関数の上書きを何度も行わないように
	var checkCount = 0;			// チェック対象個数
	var successCount = 0;		// 成功数
	var failedCount = 0;		// 失敗数
	var cancelFlag = false;		// キャンセルした時に立つフラグ
	var isChecking = false;		// チェック中かどうかのフラグ
	var errList = [];
	var pkey = "-----BEGIN PUBLIC KEY-----MIGJAoGBALvVNGMmvEJbTVOXXab58bE++kZXHc1vsBe4ycRtjGqVLWGa7QxVdq3N3ReoyLcDqiu6ZXRhAR2TERRnYwUtKO4Cp3/UQspYK2to50McGBhHIsyl8fjZYcF29+m+qFti1FFzr8HGnXsoRclWG0TrdMTMo7NiN5Ty+IQyp/K1IcFDAgMBAAE=-----END PUBLIC KEY-----";
// layerExLanczos.dll s i g c h e c k
	var list = [
//		System.exePath+"plugin/emoteplayer.dll",
		System.exePath+"plugin/extrans.dll",
		System.exePath+"plugin/fftgraph.dll",
		System.exePath+"plugin/getSample.dll",
		System.exePath+"plugin/KAGParser.dll",
		System.exePath+"plugin/krmovie.dll",
		System.exePath+"plugin/layeredwindow.dll",
		System.exePath+"plugin/layerExAlpha.dll",
		System.exePath+"plugin/layerExColor.dll",
		System.exePath+"plugin/layerExImage.dll",
		System.exePath+"plugin/LayerExMosaic.dll",
		System.exePath+"plugin/layerExRaster.dll",
		System.exePath+"plugin/layerExLanczos.dll",
		System.exePath+"plugin/win32dialog.dll",
		System.exePath+"plugin/windowEx.dll",
		System.exePath+"plugin/wuvorbis.dll"
//		,System.exeName	// やっぱexeは無理、デノボかな・・・
	];
	var checkIndex = 0;
	var currentHander;

	function SigCheckPlugin(){
		super.KAGPlugin();
		init();
	}

	function finalize(){
		allStop();
		super.finalize(...);
	}

	// 初期化、チェック後の関数の呼び出し先をこのオブジェクトに
	function init(){
		if(!initialized){
			kag.onCheckSignatureDone = function(handler, info, result, errormsg){
				if(typeof global.sigcheckObj != "undefined" && isvalid global.sigcheckObj){
					global.sigcheckObj.onCheckSignatureDone(handler, info, result, errormsg);
				}
			}incontextof kag;
			initialized = true;
		}
	}

	// 実際のチェック処理
	// exeは調査できなかった。デノボかな、蹴られる
	function check(){
		if(isChecking)return;		// チェック中みたいだから帰る

		successCount = 0;
		failedCount = 0;
		errList.clear();
		checkIndex = 0;
		isChecking = true;
		checkNext();
	}

	// 終わったらtrueを返す
	function checkNext(){
		if(checkIndex >= list.count)return true;
		var target = list[checkIndex];
		var name = Storages.extractStorageName(target);
		currentHander = kag.checkSignature(target, pkey, name);
		checkIndex+=1;
		return false;
	}

	// 全キャンセル
	function allStop(restart = false){
		if(!isChecking)return;		// チェック中ではないようだ
		isChecking = false;
		kag.stopCheckSignature(currentHander);
		successCount = 0;
		failedCount = 0;
		if(restart)check();
	}

	// チェック終了時に呼び出される(result = -2:エラー -1:キャンセル 0:チェック失敗 1:チェック成功)
	function onCheckSignatureDone(handler, info, result, errormsg){
		if(!isChecking)return;		// チェック中ではないようだ
		//System.inform("hander：" + handler + "\ninfo：" + info + "\nresult：" + result + "\nmsg：" + errormsg);
		if(currentHander == handler && result == 1){successCount += 1;
		}else{
			failedCount += 1;
			errList.add(info);
		}
		if(checkNext())checkFinish();
	}

	// 全ファイルのチェックが終わるとここに来る
	function checkFinish(){
		//System.inform("成功："+successCount+"\n失敗："+failedCount);

		// 失敗した失敗した失敗した失敗した失敗した失敗した失敗した失敗した失敗した失敗した失敗した失敗した
		if(errList.count > 0){
			var str = "以下のDLLの破損発生もしくはチェックに失敗しました。\nゲームの再起動や再インストールを行ってください。\n\n";
			for(var i=0; i<errList.count; i++){
				str += errList[i]+"\n";
			}
			System.exitOnWindowClose = false;
			kag.shutdown();
			global.errMsg = str;
			global.ertrig = new AsyncTrigger(function(){
				System.exitOnWindowClose = true;
				//System.inform(global.errMsg);
				throw new Exception(global.errMsg);
				System.terminate();
			}, '');
			global.ertrig.cached = true;
			global.ertrig.trigger();
		}
		isChecking = false;
	}

	function onStore(f, elm){}
	function onRestore(f, clear, elm){}
	function onStableStateChanged(stable){}
	function onMessageHiddenStateChanged(hidden){}
	function onCopyLayer(toback){}
	function onExchangeForeBack(){}
}

kag.addPlugin(global.sigcheckObj = new SigCheckPlugin());
global.sigcheckObj.check();		// プラグイン生成と同時に即チェック開始

@endscript
@endif

; マクロ登録

@return

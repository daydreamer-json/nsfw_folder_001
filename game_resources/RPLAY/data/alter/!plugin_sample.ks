@if exp="typeof(global.psample_object) == 'undefined'"
@iscript

// ＊＊＊プラグイン
class SamplePlugin extends KAGPlugin
{
	var timer;

	function SamplePlugin() {
		super.KAGPlugin();

		timer = new Timer(onTimer, "");
		timer.interval = 20;
	}

	function finalize() {
		invalidate timer;
		super.finalize(...);
	}

	function onTimer()
	{
	}
	
	function setBaseLayerPos(x, y){
		// クエイクの位置変更時に呼ばれる？
	}

	function onStableStateChanged(stable)
	{
		// 「安定」( s l p の各タグで停止中 ) か、「走行中」 ( それ以外 ) かの状態が変わったときに呼ばれる
	}
	
	function onMessageHiddenStateChanged(hidden)
	{
		// メッセージレイヤがユーザの操作によって隠されるとき、現れるときに
		// 呼ばれる。メッセージレイヤとともに表示/非表示を切り替えたいときはここで設定する。
		if(hidden){
		}else{
		}
	}

	function onCopyLayer(toback) {
		// レイヤの表←→裏の情報のコピー
		// backlay タグやトランジションの終了時に呼ばれる
		// ここでレイヤに関してコピーすべきなのは表示/非表示の情報だけ
		if(toback){
			// 表→裏
		}else{
			// 裏→表
		}
	}
	function onExchangeForeBack() {
		// 裏と表の管理情報を交換
		// children = true のトランジションでは、トランジション終了時に表画面と裏画面のレイヤ構造がそっくり入れ替わるので、
		// それまで 表画面だと思っていたものが裏画面に、裏画面だと思っていたものが表画面になってしまう。ここのタイミングでその情報を
		// 入れ替えれば、矛盾は生じないで済む。
	}

	function onStore(f, elm){
		// セーブ時呼び出し
	}

	function onRestore(f, clear, elm){
		// ロード時呼び出し
	}

	function onSaveSystemVariables(){
		// システムデータ保存前呼び出し
	}
}

// プラグインオブジェクトを作成し、登録する
kag.addPlugin(global.psample_object = new SamplePlugin());

@endscript
@endif

; マクロ宣言等

@return


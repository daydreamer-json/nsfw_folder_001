@if exp="typeof(global.snapshot_object) == 'undefined'"

@call storage="plugin_snapshot_define.ks"

@iscript

//アフィン処理はいらないと思う

class SnapshotPlugin extends VariableImageObjectPlugin
{
	var realTimeSnapshot;										// リアルタイムでスクリーンショットを更新するかのフラグ
	
	//◆コンストラクタ
	function SnapshotPlugin(win,abs)
	{
		super.VariableImageObjectPlugin(win,abs);				// 参照先のプラグインの初期化を実行
		name = 'ssp';											// 名前の修正
	}

	//◆デストラクタ
	function finalize()
	{
		super.finalize(...);									// 参照先のプラグインのfinalize
	}
	
	//■パラメータの挿入と動作の開始
	function StartEffect(elm)
	{
		Stop();													// 前回の動作を強制停止する
		clearParams();											// パラメータ配列の初期化
		SetNowCCF(elm);											// 画像色の加工用
		
		//スクリーンショットの設定
		realTimeSnapshot = false;								// リアルタイムにスクリーンショットを行うかどうかのフラグ
		if(elm.rts === "true") realTimeSnapshot = true;			// リアルタイムにスクリーンショットを行う
		else nowBitMapUpdate();									// リアルタイムにスクリーンショットを行わない

		setupEffect(elm);										// その他のパラメータをセット
		
		//動作の実行を開始
		lastTick = startTick = System.getTickCount();			// 初期時間を実行
		System.addContinuousHandler(ContinuousHandler);			// システムのタイマーにセット
		moving = true;											// 移動フラグをＯＮ
		alive = true;											// 存在フラグをＯＮ
	}

	//■現在状態の描画
	function DrawLayer(tick)
	{
		//キャプチャー用の追加処理
		if(realTimeSnapshot) nowBitMapUpdate();					// 現在画面のキャプチャーをリアルタイムで行う処理
		EffectMove(tick);										// 描画用Bitmapに描画処理を実行
		DisplayLayerCopyFromBitmapToMainImage();				// 表裏レイヤに転写
	}
	
	//■配列型の時間計算用
	function nowBitMapUpdate()
	{
		window.forEachEventHook("onSnapshotUnvislbe", function(handler, f){ handler(f);} incontextof this, %[]);		// キャプチャー時に不要なプラグイン系のレイヤを不可視へ（自身も含まれる）
		var kfm1 = kag.fore.messages[0].visible;																		// メッセージウインドウを状態を取得
		if(kfm1) global.gameButton_object.onHideButtonClick();															// メッセージウインドウを消す
		window.lockSnapshot();																							// ＫＡＧウインドウのキャプチャーを取得
		window.snapshotLayer.copyToBitmapFromMainImage(nowBitmap);														// キャプチャーをBitmapクラスにコピー
		window.unlockSnapshot();																						// ＫＡＧウインドウのキャプチャーを開放
		if(kfm1) global.gameButton_object.onHideButtonClick();															// メッセージウインドウを前の状態へ戻す
		window.forEachEventHook("onSnapshotAfter", function(handler, f){ handler(f);} incontextof this, %[]);			// キャプチャー時に不要なプラグイン系のレイヤを可視へ（自身も含まれる）
		ColorChange();																									// キャプチャー画像に配色加工を行う
	}
}

class SnapshotFramePlugin extends VariableImageObjectPlugin
{
	//◆コンストラクタ
	function SnapshotFramePlugin(win,abs)
	{
		super.VariableImageObjectPlugin(win,abs);							// 参照先のプラグインの初期化を実行
		name = 'sfp';														// 名前の修正
	}

	//◆デストラクタ
	function finalize()
	{
		super.finalize(...);												// 参照先のプラグインのfinalize
	}
	
	//■パラメータの挿入と動作の開始
	function StartEffect(elm)
	{
		Stop();																// 前回の動作を強制停止する
		clearParams();														// パラメータの初期化
		SetNowCCF(elm);														// 画像色の加工用
		
		//フレーム画像の読み込み
		if(elm.frame !== void){
			nowCCF["storage"] = elm.frame;									// 画像名の登録
			if(ComparisonSetNowCCF()){
				nowBitmap.load(elm.frame);									// 基本画像の読み込み
				ColorChange();												// 画像色の加工を実行
			}
		}
		(Dictionary.assign incontextof beforeCCF)(nowCCF);					// 前回のカラー系列の配列として記憶
		setupEffect(elm);													// その他のパラメータをセット
		
		//動作の実行を開始
		lastTick = startTick = System.getTickCount();						// 初期時間を実行
		System.addContinuousHandler(ContinuousHandler);						// システムのタイマーにセット
		moving = true;														// 移動フラグをＯＮ
		alive = true;														// 存在フラグをＯＮ
	}
}

kag.addPlugin(global.snapshot_object = new SnapshotPlugin(kag,900000));
kag.addPlugin(global.snapshotframe_object = new SnapshotFramePlugin(kag,900001));

@endscript
@endif
;
; マクロ登録

;■スナップショット自身
@macro name="snapshot"
@eval exp="snapshot_object.StartEffect(mp)"
@endmacro

@macro name="wsnapshot"
@waittrig * name="&'ps_plugin'" onskip="snapshot_object.Finish()" canskip=%canskip|true cond="snapshot_object.moving && (!snapshot_object.loop || snapshot_object.loopCount != -1)"
@eval exp="snapshot_object.Finish()"
@endmacro

@macro name="ssnapshot"
@eval exp="snapshot_object.Finish()" cond="snapshot_object.moving"
@endmacro

@macro name="snapshot_delete"
@eval exp="snapshot_object.DeleteObject();" cond="snapshot_object.alive"
@endmacro

@macro name="snapshot_delete_now"
@eval exp="snapshot_object.DeleteObjectNow()" cond="snapshot_object.alive"
@endmacro

;■スナップショットフレーム
@macro name="snapshotframe"
@eval exp="snapshotframe_object.StartEffect(mp)"
@endmacro

@macro name="wsnapshotframe"
@waittrig * name="&'psf_plugin'" onskip="snapshotframe_object.Finish()" canskip=%canskip|true cond="snapshotframe_object.moving && (!snapshotframe_object.loop || snapshotframe_object.loopCount != -1)"
@eval exp="snapshotframe_object.Finish()"
@endmacro

@macro name="ssnapshotframe"
@eval exp="snapshotframe_object.Finish()" cond="snapshotframe_object.moving"
@endmacro

@macro name="snapshotframe_delete"
@eval exp="snapshotframe_object.DeleteObject();" cond="snapshotframe_object.alive"
@endmacro

@macro name="snapshotframe_delete_now"
@eval exp="snapshotframe_object.DeleteObjectNow()" cond="snapshotframe_object.alive"
@endmacro


@return

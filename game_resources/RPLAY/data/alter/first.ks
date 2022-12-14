
;■ログ出力解除
;￣￣￣￣￣￣￣￣￣￣
@history output=false enabled=false

;■右クリック標準機能OFF
;￣￣￣￣￣￣￣￣￣￣
@rclick enabled=false

;■初期設定読み込み
;￣￣￣￣￣￣￣￣￣￣
@call storage="init.ks"

;■ちょっと特殊めなプラグイン
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@call storage="plugin_windowresize.ks"
@call storage="plugin_backlogjump.ks"

;■DLLプラグイン読み込み
;￣￣￣￣￣￣￣￣￣￣
@loadplugin module="wuvorbis.dll"
@loadplugin module="extrans.dll"

;■マクロ読み込み
;￣￣￣￣￣￣￣￣￣￣
@call storage="macro.ks"

;■必須/必要KAGプラグイン先行読み込み
;￣￣￣￣￣￣￣￣￣￣
@call storage="effect_define.ks"		// エフェクト用レイヤプラグイン
@call storage="effect.ks"				// エフェクトプラグイン
@call storage="plugin_movecursor.ks"	// マウスカーソル自動移動用プラグイン
@call storage="plugin_tiphint.ks"		// チップヒント
;@call storage="plugin_lovelycall.ks"	// CATIONシリーズ用、音声の停止マクロの中に含まれてしまうので先にないと割と困る

; E-MOTE用
;@call storage="emoteplayer.ks"

;■タイトルロゴ/警告表示
;￣￣￣￣￣￣￣￣￣￣
@call storage="title_logo.ks"

;■KAGプラグイン読み込み
;￣￣￣￣￣￣￣￣￣￣
; 変なコメントの書き方だけど属性としても無視されるのでとりあえずこんな書き方で。
@call storage="plugin_syaseicounter.ks"		// 射精カウンター
;@call storage="plugin_delayscript.ks"		// ディレイスクリプト
@call storage="plugin_delayscript2.ks"		// ディレイスクリプト
@call storage="spectrum.ks"					// スペアナ
@call storage="gamebutton.ks"				// ゲーム下部ボタン
@call storage="saveload.ks"					// セーブロード画面
@call storage="config.ks"					// コンフィグ画面
@call storage="exlink.ks"					// 選択肢プラグイン
@call storage="plugin_info.ks"				// 情報表示プラグイン(クイックセーブとか)
@call storage="org_plugin_miniface.ks"		// ミニ表情表示1
@call storage="plugin_grain.ks"				// 粒プラグイン(葉/灰/雪/雨/泡/桜/タンポポ)
;//@call storage="plugin_leff.ks"				// エフェクトプラグイン
@call storage="plugin_meff.ks"				// エフェクトプラグイン
;//@call storage="plugin_move_effect.ks"		// エフェクトプラグイン
;//@call storage="plugin_spectrum_effect.ks"	// エフェクトプラグイン
;//@call storage="plugin_timeline_effect.ks"	// エフェクトプラグイン
@call storage="plugin_lensflare.ks"			// レンズフレアプラグイン
;@call storage="plugin_film_effect.ks"		// 映写機エフェクトプラグイン
@call storage="staffroll.ks"				// スタッフロールプラグイン
@call storage="plugin_syslayer.ks"			// システム用レイヤー作成プラグイン
@call storage="plugin_lineframe.ks"			// 行ごとにフレームを生成するプラグイン
;@call storage="plugin_makemenu.ks"			// tips用のメニュー作成プラグイン？

; CATIONシリーズ用
;@call storage="menu_status.ks"
;;;@call storage="lovelycall_exp.ks"
@call storage="plugin_bgv.ks"
;@call storage="plugin_lovelycallsetting.ks"
;@call storage="plugin_skillup.ks"
;;;@call storage="plugin_chain.ks"
;;;@call storage="ex_bonus.ks"
;@call storage="gamebutton_map.ks"
;@call storage="plugin_bonus.ks"

;@call storage="plugin_damaged_glass.ks"	// 画面ヒビ割れ演出(BradyonBeda)用プラグイン
;@call storage="plugin_alphamovie.ks"	// αムービープラグイン
@call storage="plugin_waitvoice.ks"	// 特殊ボイス待ち
;@call storage="plugin_miniface.ks"		// ミニ表情表示2
;@call storage="timeEvent.ks"			// 射精演出用プラグイン
;@call storage="plugin_timer.ks"		// 霧プラグイン
@call storage="plugin_ch.ks"			// 画面に文字を出すプラグイン
;@call storage="plugin_splayer.ks"		// アエリアルの時のなんかくるくる回るためのプラグイン
;@call storage="plugin_par.ks"			// パーティクルっぽいプラグイン
;@call storage="plugin_flower.ks"		// 花びら用プラグイン
;@call storage="quick_menu.ks"			// 右クリックメニュー用プラグイン
;@call storage="plugin_cherryb.ks"		// 桜用プラグイン
;@call storage="plugin_scene_skip.ks"	// シーンスキップ用プラグイン
;@call storage="plugin_moji_flow.ks"	// 指定画像を縦に流すプラグイン/アエリアルの時に使用
;@call storage="plugin_mail.ks"			// メール画面を作成するプラグイン
;@call storage="plugin_save_tlg5.ks"	// tlg5で保存
;@call storage="plugin_titletimer.ks"	// タイトルで一定時間たったらどこぞに飛ぶプラグイン
;@call storage="plugin_loopbg.ks"		// 背景ループ用プラグイン
;@call storage="chapter_shift_menu.ks"	// チャプターシフト用プラグイン
@call storage="plugin_makethum.ks"		// セーブデータからサムネイルを動的に作成するプラグイン
;@call storage="plugin_zimaku.ks"		// 字幕プラグイン
;@call storage="plugin_mini_tips.ks"	// 画面中の小さいtips用プラグイン
;@call storage="plugin_multiwindow.ks"	// マルチウィンドウプラグイン
@call storage="plugin_movie_se.ks"	// 動画の時間に合わせてSEやボイスを再生する
@call storage="plugin_movie_switch.ks"
@call storage="plugin_favvoice.ks"
@call storage="plugin_prologueskip.ks"	// プロローグスキップ用関数
@eval exp="Scripts.execStorage('screenshot.tjs')"	// スクリーンショット保存関数
@eval exp="Scripts.execStorage('plugin_interrupted.tjs')"	// 非アクティブ時の動作設定


;■全メッセージレイヤーのクリック待ち画像を固定位置へ
;￣￣￣￣￣￣￣￣￣￣
@iscript
{
	var l = breakGlyphX;
	var t = breakGlyphY;
	var t_fore = kag.fore.messages;
	var t_back = kag.back.messages;
	for(var i=0; i<t_fore.count; i++){
		t_fore[i].setGlyph(%[fix:true, left:l, top:t]);
		t_back[i].setGlyph(%[fix:true, left:l, top:t]);
	}
	kag.messageLayer.setGlyph(%[fix:true, left:l, top:t]);
}
@endscript

;■警告画面の待ち
;￣￣￣￣￣￣￣￣￣￣
@waitclick

;@call storage="plugin_sample.ks"
;■タイトルへ
;￣￣￣￣￣￣￣￣￣￣
@eval exp="kag.cancelSkip();"
@jump storage="title.ks"
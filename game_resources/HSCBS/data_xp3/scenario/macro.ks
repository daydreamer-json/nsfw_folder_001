;状態初期化用
;syscn から呼ばれるのでラインモード命令は含まない
[macro name=initbase]
[clearlayers]
[stopquake]
@stopbgm        cond=!mp.nostopbgm
@stopse buf=all cond=!mp.nostopse
[stopvideo]
[sysmovie state=end]
[history enabled=true]
[sysrclick]
[noeffect  enabled=true]
[clickskip enabled=true]
[current layer=message0]
[init nostopbgm=%nostopbgm]
[endmacro]

; ムービー再生のsflagはコンバートモード時のみ有効
[macro name=movieflag][endmacro]

; parsemacro.ks から呼ばれるポイント
*common_macro

;ラインモード指定とメッセージ初期化まで含む状態初期化用
[macro name=initscene]
[initbase]
[initmode *]
[meswinload page=both]
[endmacro]

[macro name=initmode]
[linemode mode=free craftername=true erafterpage=true]
[autoindent mode=true]
; for rendermsgwin, multilang/translate
;[msgmode mode=true history=true cond=%msgmode|false]
;[msgmode mode=true history=true language=&GetScnConvertLangList() cond=%translate|false]
[endmacro]


; 
[macro name="ゲーム開始"][set name="tf.start_storage" value=%storage][set name="tf.start_target" value=%target|][exit storage="start.ks" target="*jump"][endmacro]
[macro name="ゲーム終了：タイトル"][exit storage="start.ks" target="*gameend_title"][endmacro]
[macro name="ゲーム終了：ロゴ画面"][exit storage="start.ks" target="*gameend_logo" ][endmacro]



; ムービー再生汎用
	;	file		再生するファイル
	;	mode		再生するモード
	;	cancelskip	再生前にスキップ停止
	;	skip		スキップ許可条件
	;	disablerclick	右クリックスキップ禁止
	;	beforetrans	事前トランジション
	;	beforecolor	事前フェードカラー
	;	aftercolor	事後カラー
	;	afterhide	事後消去トランジション
	[macro name=movie]
		[cancelskip cond=%cancelskip|false]
		[_movie_sysmenu_hide_]
		[beginskip skip=%skip eval='&mp.eval!=""?mp.eval:"sf.movie_"+(((string)mp.file).toLowerCase())']
			[begintrans]
				[msgoff]
				[allimage hide]
				[_movie_fill_ * coltag=beforecolor defcol=0x000000]
			[endtrans trans=%beforetrans|normal sync]
			[sysmovie file=%file disablerclick=%disablerclick mode=%mode begincolor=%beforecolor|0x000000 endcolor=%aftercolor|0x000000 keepcolor eval="kag.skipMode<SKIP_CANCEL" stopcheck="SKIP_CANCEL"]
			[begintrans]
				[clearlayers page=back]
				[_movie_fill_ *  coltag=aftercolor defcol=0x000000]
			[endtrans notrans sync]
			[sysmovie state=end]
			[if exp=%afterhide|true]
				[begintrans]
					[allimage hide]
					[layer name=_movie_fill_layer delete]
				[endtrans trans=%aftertrans|normal sync]
			[endif]
		[endskip]
		[_movie_sysmenu_restore_ *]
		[sflag name=&@"movie_${((string)mp.file).toLowerCase()}"]
	[endmacro]
	[macro name="_movie_fill_"]
		[layer name=_movie_fill_layer class=effect file='&@"color,${(mp[mp.coltag]!==void?+mp[mp.coltag]:+mp.defcol)&0xFFFFFF|0xFF000000},width,${kag.scWidth},height,${kag.scHeight}"']
	[endmacro]
	[macro name="_movie_sysmenu_hide_"]
;		[quickmenu fadeout]
	[endmacro]
	[macro name="_movie_sysmenu_restore_"]
;		[quickmenu fadin]
	[endmacro]

;---------------------------------------------

; 以下タイトルに必要なマクロを作成する

[macro name="シナリオ通過"][endrecollection][sflag name=%flag][set name='&"f."+mp.flag' value=1][endmacro]
[macro name="ゲームループ"][next storage=gameloop.txt target=%target|*main][endmacro]

[macro name="クエストフラグ：リセット"  ][eval exp="f.現在のステージ=0, f.現在のウェーブ=0"][if exp=%stage][set name="f.現在のステージ" value=%stage][endif][endmacro]
[macro name="クエストフラグ：次の章進行"][eval exp="f.現在のステージ++, f.現在のウェーブ=0"][endmacro]
[macro name="クエストフラグ：メイン進行"][eval exp="f.現在のウェーブ++"][endmacro]

[macro name="クエスト進行：章維持判定"  ][next storage=%storage target=%target eval="f.現在のステージ>0 && f.現在のウェーブ<4"][endmacro]
[macro name="クエスト進行：章間イベント"][next storage=%storage target=%target eval='&@"f.現在のステージ==${mp.stage}"'][endmacro]
[macro name="クエスト進行：メイン"      ][eval exp='&@"(--f.現在のウェーブ if (f.${mp.flag})), void"'][next storage=%storage target=%target][endmacro]
[macro name="クエスト進行：章別分岐"    ][emb escape=false exp="ExtractQuestBranch(mp,'f.現在のステージ')"][endmacro]
; -> args : min,max,target=*label_%02d



[macro name=クエスト画面初期化][eval exp="tf.quest_bg=get_random_qbg()"][initscene][bgm07 sync][endmacro]
[macro name=クエスト選択][mselinit *][mseladd][mselect][endmacro]

[macro name="_ds_"][clickskip enabled=%enabled][noeffect enabled=%enabled][endmacro]
[macro name="<ds"][_ds_ enabled=false][endmacro]
[macro name="ds>"][_ds_ enabled=true ][endmacro]

; ムービー鑑賞用
[macro name=hscenemovie_begin][linemode mode=tex][noeffect enabled=false][rclick enabled storage="animation.ks" target="*endrecollection" jump][endmacro]
[macro name=hscenemovie_play ][begintrans][clearlayers page=back][ev file=&GetEnvMotionAmvFile(mp.file) loop=true][endtrans quickfade nosync][waitclick][sysse name="moviemode.next"][endmacro]
[macro name=hscenemovie_end  ][lse stop][stopvoice][noeffect enabled=true][linemode][endrecollection][endmacro]

[macro name=章頭アイキャッチ]
	[gamezoom reset]
	[initscene]
;	[cancelskip]
	[jingle file=jm02]
	[<ds][if exp='mp.storage!=""']
		[ev     storage=%storage     normal sync]
	[else  ][ev evalstorage=%evalstorage normal sync][endif][ds>]
	[wait time=7000]
	[jingle stop=1000]
	[ev hide normal sync]
[endmacro]

; ここから自作マクロ
[macro name=エロ魔導書起動ムービー再生]
	[gamezoom reset]
	[noeffect enabled=false]
	[msgoff time=0]
;	[cancelskip]
	;音声SE停止
	[bgm stop]
	[voice stop]
	[se stop]

	[object name=app_bg file=black level=7]
	[wait time=500]
	[object name=app_mov file=e_magic level=8]
	[app_bg file=white notrans]
	;SEを鳴らす場合は↓を有効に
	;[se_e_magic sync]
	[wait time=9000]
	;[se stop]
	[begintrans]
	[bg file=%file]
	[em22 level=0]
	[em hide]
	[ee01 level=0]
	[ee hide]
	[app_mov delete]
	[app_bg delete]
	[endtrans normal]
	[noeffect enabled=true]
[endmacro]

;プレイヤー名表示マクロ
[macro name=プレイヤー名][embex exp=f.name][endmacro]

;[絶頂 file=eva01]
[macro name=絶頂]
	[begintrans]
	[msgoff]
	[object name=white file=%file filter=0xffffffff level=6 show zorder=700]
	[cdown delete]
	[endtrans notrans]
	[lse stop time=1000]
	[hlse stop time=1000]
	[quake hmax=10 vmax=10 time=%qtime|3000]
;
	[white univ rule=%rule|map31 time=100 opacity=128 vague=300]
	[white univ rule=%rule|map31 time=100 opacity=255 vague=300]
	[white univ rule=%rule|map31 time=100 opacity=128 vague=300]
	[white univ rule=%rule|map31 time=100 opacity=255 vague=300]

	[begintrans]
	[ev file=%file xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100]
	[white delete]
	[endtrans sync univ rule=%rule|map31 time=2000 opacity=128 vague=600]
[endmacro]

; [アイキャッチ bgm=ic01]
[macro name=アイキャッチ]
	[gamezoom reset]
	[endrecollection]
	[msgoff time=0]
;	[cancelskip]
	;音声SE停止
	[bgm stop]
	[stopvoice all]
	[se stop]
	[lse stop]
	
	[if exp='mp.file!=""']
		[ev file=%file normal]
	[else]
		[ev evalstorage="get_random_ic(10)" normal]
	[endif]
	[jingle file=%bgm|jm01 sync]
	;[wait time=8000]
	[jingle stop=1000]
	[ev hide normal sync]
	
	[eval exp=f.bgmnum=1]
	[eval exp=f.eyeCatcha=0]

[endmacro]

[macro name=スタッフロール]
	;	file		再生するファイル
	;	mode		再生するモード
	;	cancelskip	再生前にスキップ停止
	;	skip		スキップ許可条件
	;	disablerclick	右クリックスキップ禁止
	;	beforetrans	事前トランジション
	;	beforecolor	事前フェードカラー
	;	aftercolor	事後カラー
	;	afterhide	事後消去トランジション
	[gamezoom reset]
	[endrecollection]
	[noeffect enabled=false]
	[msgoff]
	[bg file=black]
	;音声SE停止
	[voice stop]
	[se stop]
	[cancelskip]
	[cancelautomode]
	
	[clickskip enabled=true]
	[beginskip]
	[bgm13 loop=false]
	[object name=ed_bgmov file=ed_magic loop=true trans=normal show]
	
	[resetwait]
	[staffroll_wait index=1 ][ev file=staffroll seton="01_タイトル" normal]
	[staffroll_wait index=2 ][ev file=staffroll seton="02_企画・原案・キャラデ・原画" normal]
	[staffroll_wait index=3 ][ev file=staffroll seton=03_シナリオ normal]
	[staffroll_wait index=4 ][ev file=staffroll seton=04_キャスト1 normal]
	[staffroll_wait index=5 ][ev file=staffroll seton=05_キャスト2 normal]
	[staffroll_wait index=6 ][ev file=staffroll seton=06_キャスト3 normal]
	[staffroll_wait index=7 ][ev file=staffroll seton=07_キャスト4 normal]
	[staffroll_wait index=8 ][ev file=staffroll seton=08_キャスト5 normal]
	[staffroll_wait index=9 ][ev file=staffroll seton=09_グラフィッカー normal]
	[staffroll_wait index=10][ev file=staffroll seton=10_動画 normal]
	[staffroll_wait index=11][ev file=staffroll seton=11_BGM normal]
	[staffroll_wait index=12][ev file=staffroll seton=12_主題歌 normal]
	[staffroll_wait index=13][ev file=staffroll seton="13_スクリプトデバッグ" normal]
	[staffroll_wait index=14][ev file=staffroll seton=14_アトリエピーチ normal]
	[staffroll_wait index=15][ev file=staffroll seton=15_スペシャルサンクス normal]
	[staffroll_wait index=16][ev file=staffroll seton=16_みるふぁく normal]
	[staffroll_wait index=17]
	[endskip]

	[begintrans]
	[bgm stop]
	[ed_bgmov delete]
	[ev delete]
	[endtrans normal]
	[noeffect enabled=true]
[endmacro]

[macro name=staffroll_wait]
	; スタッフロールの1枚当たりの待ち時間パラメータを決定する（layers=枚数, bgm_time=BGM再生時間, last_time=末尾無音時間 fade_time=layerフェード時間）
	[_staffroll_wait index=%index layers=16 bgm_time=99000 fade_time=1000 last_time=7000]
	;再生時間99000+末尾無音時間7000ミリ秒-16枚*1000、5625ミリ秒ごとに画像変更
[endmacro]
[macro name=_staffroll_wait]
	; 実際の計算  (99000 + 7000 - (16*1000)) \ 16 = 5625
	[waituntil time='&((+mp.bgm_time + +mp.last_time - (+mp.layers * +mp.fade_time)) \ +mp.layers) * +mp.index']
	; 注意：+mp.xxxx のようにマクロ変数は前置 + で数値変換してから計算しないと正しい値が計算できない（文字列で渡されてしまうため）
[endmacro]

; 全角＠をハートに変えるマクロ
[macro name=＠][font face="源ノ角ゴシックB" color=0xFF80C0][emb exp="$0x2665"][font face=user color=default][endmacro]

@return

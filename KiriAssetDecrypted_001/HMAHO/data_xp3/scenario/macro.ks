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
[linemode mode=free craftername=true erafterpage=true]
[autoindent mode=true]
[meswinload page=both]
[endmacro]

; 
[macro name="ゲーム開始"][set name="tf.start_storage" value=%storage][set name="tf.start_target" value=%target|][exit storage="start.ks" target="*jump"][endmacro]
[macro name="ゲーム終了：タイトル"][exit storage="start.ks" target="*gameend_title"][endmacro]
[macro name="ゲーム終了：ロゴ画面"][exit storage="start.ks" target="*gameend_logo" ][endmacro]

; 以下タイトルに必要なマクロを作成する

[macro name="シナリオ通過"][endrecollection][sflag name=%flag][set name='&"f."+mp.flag' value=1][endmacro]
[macro name="ゲームループ"][next storage=gameloop.txt target=%target|*main][endmacro]


[macro name=クエスト画面初期化][initscene][bgm08 sync][endmacro]
[macro name=クエスト選択][mselinit *][mseladd][mselect][endmacro]

[macro name="_ds_"][clickskip enabled=%enabled][noeffect enabled=%enabled][endmacro]
[macro name="<ds"][_ds_ enabled=false][endmacro]
[macro name="ds>"][_ds_ enabled=true ][endmacro]

; ムービー鑑賞用
[macro name=hscenemovie_begin][linemode mode=tex][noeffect enabled=false][rclick enabled storage="animation.ks" target="*endrecollection" jump][endmacro]
[macro name=hscenemovie_play ][begintrans][clearlayers page=back][ev file=&GetEnvMotionAmvFile(mp.file) loop=true][endtrans quickfade nosync][waitclick][sysse name="moviemode.next"][endmacro]
[macro name=hscenemovie_end  ][lse stop][stopvoice][noeffect enabled=true][linemode][endrecollection][endmacro]

[macro name=章頭アイキャッチ]
	[initscene]
	[cancelskip]
	[jingle file=ic02]
	[<ds][if exp='mp.storage!=""']
		[ev     storage=%storage     normal sync]
	[else  ][ev evalstorage=%evalstorage normal sync][endif][ds>]
	[wait time=7000]
	[jingle stop=1000]
	[ev hide normal sync]
[endmacro]

; ここから自作マクロ
[macro name=エロ魔法起動ムービー]
	[noeffect enabled=false]
	[msgoff time=0]
;	[cancelskip]
	;音声SE停止
	[bgm stop]
	[voice stop]
	[se stop]

	[object name=bgwhite file=white level=6]
	[wait time=500]
	[object name=movie file=e_magic level=6]
	[se_e_magic sync]
	;[wait time=7000]
	[se stop]
	[movie delete]
	[bgwhite delete normal]
	[noeffect enabled=true]
[endmacro]

; [アイキャッチ bgm=ic01]
[macro name=アイキャッチ]
	[endrecollection]
	[msgoff time=0]
;	[cancelskip]
	;音声SE停止
	[bgm stop]
	[voice stop]
	[se stop]
	
	[if exp='mp.file!=""']
		[ev file=%file normal]
	[else]
		[ev evalstorage="get_random_ic(10)" normal]
	[endif]
	[jingle file=%bgm|ic01 sync]
	;[wait time=8000]
	[jingle stop=1000]
	[ev hide normal sync]
	
	[eval exp=f.bgmnum=1]
	[eval exp=f.eyeCatcha=0]

[endmacro]

[macro name=スタッフロール]
	[endrecollection]
	[noeffect enabled=false]
	[msgoff time=0]
	[bg file=black]
	;音声SE停止
	[voice stop]
	[se stop]
	[cancelskip]
	[cancelautomode]
	
	[clickskip enabled=true]
	[beginskip]
	[bgm14 loop=false]
	[object name=movie file=ed_magic loop=true trans=normal show]
	
	;再生時間127000ミリ秒、6300ミリ秒ごとに画像変更
	[wait time=6300]
	[ev file=staffroll diff=01タイトル normal]
	[wait time=6300]
	[ev file=staffroll diff="02企画　原画" normal]
	[wait time=6300]
	[ev file=staffroll diff=03シナリオ normal]
	[wait time=6300]
	[ev file=staffroll diff=04キャスト１ normal]
	[wait time=6300]
	[ev file=staffroll diff=05キャスト2 normal]
	[wait time=6300]
	[ev file=staffroll diff=06キャスト3 normal]
	[wait time=6300]
	[ev file=staffroll diff=07キャスト4 normal]
	[wait time=6300]
	[ev file=staffroll diff=08キャスト5 normal]
	[wait time=6300]
	[ev file=staffroll diff=09グラフィッカー normal]
	[wait time=6300]
	[ev file=staffroll diff=10動画 normal]
	[wait time=6300]
	[ev file=staffroll diff=11BGM normal]
	[wait time=6300]
	[ev file=staffroll diff=12主題歌 normal]
	[wait time=6300]
	[ev file=staffroll diff="13スクリプト デバッグ" normal]
	[wait time=6300]
	[ev file=staffroll diff=14アトリエピーチ normal]
	[wait time=6300]
	[ev file=staffroll diff=15スペシャルサンクス normal]
	[wait time=6300]
	[ev file=staffroll diff=16みるふぁく normal]
	[wait time=6300]
	[endskip]

	[begintrans]
	[bgm stop]
	[movie delete]
	[ev delete]
	[endtrans normal]
	[noeffect enabled=true]
[endmacro]

@return

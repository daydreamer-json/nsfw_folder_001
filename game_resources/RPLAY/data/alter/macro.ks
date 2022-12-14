@iscript
var DEF_CAMERA_MARGIN_W = 0;
var DEF_CAMERA_MARGIN_H = 0;

// ミニ表情表示可否
f.permission_face = false;

// マクロ内で使う関数の定義
Scripts.execStorage('macro_function.tjs');
@endscript

;@call storage="macro_effect.ks"	// 演出用マクロ
@call storage="macro_other.ks"	// 作品個別マクロ
;@call storage="macro_cation.ks"	// Cation系マクロ

;****************************************************************************************************
;**** INDEX
;****	◆その他
;****	◆メッセージウィンドウ関連
;****	◆立ち絵関連
;****	◆背景関連
;****	◆EVCG表示関連
;****	◆カットイン画像表示関連
;****	◆BGM関連
;****	◆SE関連
;****	◆その他
;****************************************************************************************************

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;		：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣



;****************************************************************************************************
;****	◆その他
;****************************************************************************************************

;■タイトルに戻るマン
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="return_title"
@jump storage=title.ks target=*title_init
@endmacro


;■Ｈシーンの開始に行う処理
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="h_scene_start"
@eval exp="f.isHScene = 1"
;Ｈシーンに専用メッセージフレームがある場合使用。それ以外の時はコメントアウト推奨
@setframe_h
@endmacro

;■Ｈシーンの終わりに行う処理
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="h_scene_end"
@eval exp="f.isHScene = 0"
@setframe
@endmacro


;■次の選択肢へジャンプのジャンプ先を設定するマクロ
;  空呼び出しでクリア
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	storage：ファイル名	def:
;		target ：ラベル名	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="set_gonextselect"
@eval exp="f.GoNextSelectStorage = mp.storage === void ? '' : mp.storage"
@eval exp="f.GoNextSelectTarget = mp.target === void ? '' : mp.target"
@endmacro


;■スキップモードとオートモード停止
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="cancel_autoskip"
@eval exp="kag.cancelSkip()"
@eval exp="kag.cancelAutoMode()"
@endmacro


;■待ち時間のついでに画像をキャッシュするかもしれない(不確定)ウェイト
;  ルール画像とか食わせるのはダメらしい。あくまでCGとか背景とか。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	storages：コンマ区切りのファイル名羅列
;		time    ：待つ時間	def:500
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="cache_wait"
@if exp="mp.storages !== void && mp.storages != ''"
@resetwait
@eval exp="mp.time = (int)mp.time"
@eval exp="mp.time = 500" cond="mp.time < 500"
@eval exp="tf.cacheAr = mp.storages.split(',',,true)"
@eval exp="System.touchImages(tf.cacheAr, -2*1024*1024, mp.time-200);"
@wait mode=until time=%time
@eval exp="delete tf.cacheAr" cond="tf.cacheAr !== void"
@endif
@endmacro


;■複数のレイヤーに位置変更命令を出すマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	layers：コンマ区切りのレイヤー番号
;		他    ：moveタグの属性と同様
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="shift_move"
@eval exp="shiftLayer(mp)"
@endmacro
@iscript
// 複数のレイヤーに指定ピクセルずらすmove命令を出す関数
function shiftLayer(mp)
{
	// 渡された辞書配列を一応コピー
	var elm = %[];
	(Dictionary.assign incontextof elm)(mp);
	// 足し引きするので数値化
	elm.x = +elm.x;
	elm.y = +elm.y;
	// 時間のデフォルト値
	if(elm.time === void)elm.time = 1000;
	elm.time = +elm.time;
	var target = kag.fore.layers;
	if(elm.page == "back")target = kag.back.layers;
	// layers属性があったらコンマ区切り文字列として該当レイヤーだけ処理する
	if(elm.layers !== void && elm.layers != ""){
		var ar = elm.layers.split(/,/,,true);	// 空の要素無視で,で分割
		for(var i=0; i<ar.count; i++){
			var index = +ar[i];
			if(index < 0 || index >= target.count)continue;	// 限界値チェック
			var t = target[index];
			if(t.visible){	// 表示されているものだけ処理
				elm.path = (t.left+elm.x)+","+(t.top+elm.y)+","+t.opacity;
				t.beginMove(elm);
			}
		}
	}else{
		// 全部処理バージョン
		for(var i=0; i<target.count; i++){
			var t = target[i];
			if(t.visible){	// 表示されているものだけ処理
				elm.path = (t.left+elm.x)+","+(t.top+elm.y)+","+t.opacity;
				t.beginMove(elm);
			}
		}
	}
}
@endscript


;■フラッシュ（画像を表示して指定秒数待つだけ。）
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.		def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="flash"
@eximg * layer=%layer|10 storage=%storage|white page=fore
@wait time=%time|80
@freeimage layer=%layer|10
@wait time=%time|80
@endmacro

;■フラッシュかつ、別の画像に変更
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.		def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="flash_img"
@eximg layer=5 storage=white page=fore
@wait time=%time|80
@eximg * storage=%storage page=fore
@freeimage layer=5
@wait time=%time|80
@endmacro



;****************************************************************************************************
;****	◆メッセージウィンドウ関係
;****************************************************************************************************

;■圏点用マクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="・"
@ruby text="・"
@endmacro

;■heart にはハートマークの画像
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
[macro name="heart"][graph storage="ch_heart" alt="~0" char=false][endmacro]

;■文字演出用マクロ（１行）
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="img_ch"
@ch_addstrs str=%txt fontsize=55
@ch_setpreoption_auto kind=4 xinc=26 sx=200 sy=300 intime=1000 outtime=0 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=100
[ch_start][ch_wait][waitclk]
@ch_setpreoption_auto kind=5 xinc=26 sx=200 sy=300 intime=0 outtime=1000 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=0
[ch_start][ch_wait][ch_clear]
@endmacro

;■文字演出用マクロ（２行）
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="img_ch2"
@ch_addstrs str=%txt1 fontsize=55
@ch_addstrs str=%txt2 fontsize=55 obj=1
@ch_setpreoption_auto kind=4 xinc=26 sx=200 sy=300 intime=1000 outtime=0 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=100
@ch_setpreoption_auto kind=4 xinc=26 sx=200 sy=350 intime=1000 outtime=0 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=100 obj=1
[ch_start][ch_wait][ch_start obj=1][ch_wait obj=1][waitclk]
@ch_setpreoption_auto kind=5 xinc=26 sx=200 sy=300 intime=0 outtime=1000 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=0
@ch_setpreoption_auto kind=5 xinc=26 sx=200 sy=350 intime=0 outtime=1000 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=0 obj=1
[ch_start][ch_start obj=1][ch_wait][ch_clear][ch_clear obj=1]
@endmacro



;■バックログへのテキストログ書き出し
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	s:		バックログ画面でのテキストクリック時に再生するボイス等音
;		text:	バックログへ書き込むテキスト※'#r'もしくは'[r]'で改行できます(３行まで)
;
;		演出などの画面表示をバックログにテキストを書き込む用に使用する。
;		指定するボイスを直接再生はしません、@voマクロでこのマクロの外で鳴らしてください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="rireki_write"
@eval exp="mp.splited = mp.text.split(/(#r)|(\[r\])/gi,,true)"
@hact exp="&'playVoice(\'' + mp.s + '\')'" cond="mp.s != void"
;)	// サクラエディタでずれるの回避用
@eval exp="mp.splited.remove('#r',true)"
@eval exp="mp.splited.remove('\[r\]',true)"
[eval exp="kag.historyLayer.store(mp.splited[0])" cond="mp.splited[0] !== void"][hr cond="mp.splited[0] !== void"]
[eval exp="kag.historyLayer.store(mp.splited[1])" cond="mp.splited[1] !== void"][hr cond="mp.splited[1] !== void"]
[eval exp="kag.historyLayer.store(mp.splited[2])" cond="mp.splited[2] !== void"][hr cond="mp.splited[2] !== void"]
@endhact cond="mp.s != void"
@endmacro

;■複数行に文字を同時表示
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="overlap_ch"
@call storage="macro.ks" target="*overlap_ch"
@endmacro


;ルビ対応版
;// ※使い方
;// @mmsgから指定のラベルの間に複数行の文章を書く。
;// 空行ＯＫ、@スクリプトＮＧ、[スクリプト]ＯＫ、[文字'ルビ]ＯＫ、ルビは１文字に対してのみ、全て１文字カウントなので半角文字は表示速度が崩れる
;//
;//  @nm t="名前"
;//  @mmsg target="*mmsg1"
;//  「あ[white]い[う'ルビA]え[お'ルビルビルビB]あいうえお」
;//  「かきくけ[こ'ルビC]＋かきくけこ＋」
;//  「さし[ruby text="るび"]すせさしすせ」
;//  *mmsg1
@macro name="mmsg"
@history output=false
@call storage="&makeMultiMessageScript(getMultiMessage())"
@history output=true
@np
@jump storage=%storage target=%target
@endmacro


;■メッセージ表示
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	メッセージウィンドウを表示します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="show"
@backlay
@eval exp="for(var i=0; i<kag.back.messages.count; i++)kag.back.messages[i].visible=true" cond="mp.button != 'true'"
@if exp="f.frameType == 'novel' || f.frameType == 'novel2'"
@gamebutton backvisible="&mp.nobutton == 'true' ? 'false' : 'true'"
;;;@gamebutton2 backvisible="&mp.nobutton == 'true' ? 'false' : 'true'"
@else
@gamebutton backvisible="&mp.nobutton == 'true' ? 'false' : 'true'"
@endif
@extrans *
@backlay
@endmacro

;■メッセージ瞬間表示
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="sshow"
@eval exp="for(var i=0; i<kag.fore.messages.count; i++)kag.fore.messages[i].visible=true"
@if exp="f.frameType == 'novel' || f.frameType == 'novel2'"
@gamebutton forevisible="&mp.nobutton == 'true' ? 'false' : 'true'"
;;;@gamebutton2 forevisible="&mp.nobutton == 'true' ? 'false' : 'true'"
@else
@gamebutton forevisible="&mp.nobutton == 'true' ? 'false' : 'true'"
@endif
@backlay
@endmacro

;■メッセージ消去
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	メッセージウィンドウを消去します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="hide"
@backlay
@eval exp="for(var i=0; i<kag.back.messages.count; i++)kag.back.messages[i].visible=false"
@gamebutton backvisible="&mp.select == 'true' ? 'true' : 'false'"
@extrans *
@backlay
@endmacro

;■メッセージ瞬間消去
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="shide"
@eval exp="for(var i=0; i<kag.fore.messages.count; i++)kag.fore.messages[i].visible=false"
@gamebutton forevisible=false
@backlay
@endmacro

;■メッセージレイヤー裏画面を全て綺麗に
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="clearmessages"
@eval exp="for(var i=0; i<kag.back.messages.count; i++)kag.back.messages[i].clear(),kag.back.messages[i].visible=false"
@endmacro

;■ミニ表情の出現許可
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	左下の表情の出現を許可します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="enable_face"
@eval exp="f.permission_face=true"
@endmacro
;■ミニ表情の出現禁止
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	左下の表情の出現を禁止します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="disable_face"
@eval exp="f.permission_face=false"
@endmacro

;■ミニ表情変更
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="face"
;@show_miniface * sepia=%sepia grayscale=%grayscale
@if exp="sysFaceVisible || mp.force=='true'"
@show_miniface *
@endif
@eval exp="saveFace(mp.storage)" cond="mp.storage!==void"
@eval exp="saveFace(mp.s)" cond="mp.s!==void"
@endmacro
; ※基本ミニ表情無しでサブキャラのみ出したい場合
[macro name="fface"][face * force=true][endmacro]

;■ミニ表情全消去
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
[macro name="clear_face"][eval exp="clearFace()"][endmacro]

;****************************************************************************************************
;****	◆立ち絵関係
;****************************************************************************************************

;//----------------------------------------------------------------
;// 服装強制変更用
;// in.	target：対象キャラクター
;// 	dress：服装「a～z」
;// このマクロを引数無しで呼び出せばリセット
;//----------------------------------------------------------------
@macro name="change_dress"
@eval exp="f.relpaceDressTarget = mp.target===void ? '' : (characterNameToNum[mp.target]), f.replaceDressAlphabet = mp.dress;"
@endmacro


;###################################### setframe系マクロ統一化 ################################################

;■メッセージウィンドウのみのbacklay
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="backlay_msg"
@eval exp="for(var i=0; i<kag.back.messages.count; i++)kag.back.messages[i].assignComp()"
@endmacro

;■メッセージフレーム設定
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="setframe"
@eval exp="f.isHScene = (mp.hscene == 'true')"

; 「game_setting.tjs」にて設定
@eval exp="msgFrameSetting()"
@setframe_sub * ftype='adv'

; 太字設定をシステムに準拠させる
@eval exp="setMessageLayerBold()"
@backlay_msg
@endmacro

;■メッセージフレーム設定(EVCGでシンプルに変更用)
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="setframe_ev"
; 「game_setting.tjs」にて設定
@eval exp="evcgMsgFrameSetting()"
@setframe_sub * ftype='adv'
@backlay_msg
@endmacro

;■Ｈシーン用メッセージフレーム設定
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="setframe_h"
@eval exp="f.isHScene = true"

; 「game_setting.tjs」にて設定
@eval exp="hsceneMsgFrameSetting()"
@setframe_sub * ftype='adv'

; フレームの濃度をHシーン用に調整
@layopt layer=message0 page=fore opacity="&sysHMsgOpacity" cond="sysHMsgDesign == 1"
@backlay_msg
@endmacro


;■ノベルモード
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
[macro name="setframe_novel"]
; 「game_setting.tjs」にて設定
@eval exp="novelMsgFrameSetting()"
[setframe_sub * ftype='novel']
[endmacro]


;■setframeサブマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;#ftype		：メッセージタイプ('adv'→通常ADV,'novel'→ノベルモード)
;#frame		：メッセージフレーム用画像名
;#frame2	：話者名表示用フレーム画像名
;#maximize	：ノベルモードメッセージフレーム用フラグ。これが定義されているときはmfl,mftを無視する
;#────────────┬──┬──┬──┬──┬─────┬─────┬─────┬─────┐
;#       対象             │ 左 │ 上 │ 幅 │高さ│マージンl │マージンt │マージンr │マージンb │
;#────────────┼──┼──┼──┼──┼─────┼─────┼─────┼─────┤
;#名前表示フレーム        │nfl │nft │  - │  - │─────│─────│─────│─────│
;#メッセージフレーム      │mfl │mft │mfw │mfh │─────│─────│─────│─────│
;#名前表示レイヤー        │nll │nlt │nlw │nlh │   nlml   │   nlmt   │   nlmr   │   nlmb   │
;#メッセージ表示レイヤー  │mll │mlt │mlw │mlh │   mlml   │   mlmt   │   mlmr   │   mlmb   │
;#────────────┴──┴──┴──┴──┴─────┴─────┴─────┴─────┘
@iscript
// 指定されなかったときの初期値設定
function setMsgFrameDefaultParam(){
	if(mp.mfl === void)mp.mfl = 30;
	if(mp.mft === void)mp.mft = 509;
	if(mp.nfl === void)mp.nfl = 107;
	if(mp.nft === void)mp.nft = 507;

	if(mp.nll === void)mp.nll = 107;
	if(mp.nlt === void)mp.nlt = 507;
	if(mp.nlw === void)mp.nlw = 400;
	if(mp.nlh === void)mp.nlh = 50;
	if(mp.nlfsize === void)mp.nlfsize = 28;

	if(mp.nlml === void)mp.nlml = 10;
	if(mp.nlmt === void)mp.nlmt = 5;
	if(mp.nlmr === void)mp.nlmr = 0;
	if(mp.nlmb === void)mp.nlmb = 0;

	if(mp.mll === void)mp.mll = 30;
	if(mp.mlt === void)mp.mlt = 509;
	if(mp.mlw === void)mp.mlw = kag.scWidth;
	if(mp.mlh === void)mp.mlh = 211;
	if(mp.mlfsize === void)mp.mlfsize = 28;

	if(mp.mlml === void)mp.mlml = 80;
	if(mp.mlmt === void)mp.mlmt = 55;
	if(mp.mlmr === void)mp.mlmr = 160;
	if(mp.mlmb === void)mp.mlmb = 0;

	if(mp.glyph_line === void)mp.glyph_line = kag.fore.messages[0].lineBreakGlyph;
	if(mp.glyph_page === void)mp.glyph_page = kag.fore.messages[0].pageBreakGlyph;
	if(mp.glyph_left === void)mp.glyph_left = breakGlyphX;
	if(mp.glyph_top === void)mp.glyph_top = breakGlyphY;
	if(mp.glyph_fix === void)mp.glyph_fix = true;
}
@endscript
@macro name="setframe_sub"
; デフォ値設定
@eval exp="setMsgFrameDefaultParam()"

@if exp="mp.ftype=='adv' || mp.ftype===void"
;通常ADVモード
@eval exp="f.frameType = 'adv'"
@eval exp="mp.frame=(mp.frame===void)?('g_frame'):(mp.frame)"
@eval exp="mp.frame2=(mp.frame2===void)?('g_frame2'):(mp.frame2)"
@else
;ノベルモード
@eval exp="f.frameType = 'novel'" cond="mp.ftype=='novel'"
@eval exp='mp.frame=(mp.frame===void)?(""):(mp.frame)' cond="mp.ftype=='novel'"
@endif

; 名前フレーム
@position layer=message1 page=fore opacity=0 visible=false frame=%frame2 left=%nfl top=%nft
@eval exp="kag.fore.messages[1].opacity = kag.back.messages[1].opacity = 0" cond="mp.ftype=='adv' || mp.ftype===void"

; メッセージフレーム
@position layer=message0 page=fore frame=%frame left=%mfl top=%mft opacity=%mf_opacity|255
@layopt layer=message0 page=fore opacity="&sysMsgOpacity"
; メッセージフレームの幅高さが指定されたとき用
@position layer=message0 width="&mp.mfw"  cond="mp.mfw !== void && (+mp.mfw) != 0"
@position layer=message0 height="&mp.mfh" cond="mp.mfh !== void && (+mp.mfh) != 0"
@position layer=message0 left=0 top=0 width="&kag.scWidth" height="&kag.scHeight" cond="mp.maximize"

; 名前表示レイヤー
@eval exp="setCurrentNameLayer()"
@position left=%nll top=%nlt width=%nlw height=%nlh marginl=%nlml margint=%nlmt marginr=%nlmr marginb=%nlmb visible=true opacity=0
[deffont face=&mp.nlfface size=%nlfsize bold=false][resetfont]

; 文章表示レイヤー
@eval exp="setCurrentMessageLayer()"
@position left=%mll top=%mlt width=%mlw height=%mlh marginl=%mlml margint=%mlmt marginr=%mlmr marginb=%mlmb visible=true opacity=0 vertical="&mp.vertical ? 'true' : 'false'"
[deffont face=&mp.mlfface rubyoffset=&mp.rubyoffset size=%mlfsize bold=false rubysize="&globalDefRubySize"][resetfont]
[defstyle linespacing=%linespacing|11][resetstyle]

; クリック待ち記号
@glyph fix=%glyph_fix left=%glyph_left top=%glyph_top line=%glyph_line page=%glyph_page

; メッセージレイヤーのみ表を裏にコピー
@backlay_msg
@endmacro
;##############################################################################################################



;//ノベルモード行間設定用
@macro name="nrl"
@l
@eval exp="mp.y = kag.current.fontSize + 15" cond="mp.y == void"
@eval exp="dm( mp.y )"
@eval exp="mp.y = &kag.current.y - kag.current.marginT + +mp.y"
@locate x=%x|0 y=%y|0
@endmacro

;■名前表示
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	t: 表示する名前
;		rt:本当の名前		def:-
;		s:再生するボイスファイル	def:-
;		 「,」カンマで複数ボイスの同時再生指定※最大3キャラ分まで、それ以上はいつもどおりファイルを合成して下さい。
;exp.	名前表示用のマクロです。本当の名前は内部で使用するので、「？？？」等の表示の時に必ず入力してください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript

// レイヤー0がEVCGかどうかのチェック関数
function isLayer0Evimage(){
	var tar = kag.fore.layers[0].Anim_loadParams;
	if(tar !== void && tar.storage !== void && tar.storage != ""){
		return (tar.storage.substr(0,2) == "ev");
	}else return false;
}

// 性器呼称のボイス判別(男性器呼称、女性器呼称どちらのフラグを見るか)
global.curScenario = [];
global.curFilename = "";
function checkGenitalVoiceSex(voice){
	var ies = Storages.isExistentStorage;
	// そもそもbのボイスが無ければチェックの必要も無い
	if(ies(voice+"b.wav") || ies(voice+"b.ogg") || ies(voice+"b1.wav") || ies(voice+"b1.ogg")){
		if(kag.mainConductor.curStorage != global.curFilename){
			global.curFilename = kag.mainConductor.curStorage;
			global.curScenario.load(global.curFilename);
		}
		var line = kag.mainConductor.curLine;
		var findTinko = false;
		var findManko = false;
		for(var i=0; i<50 && (line+i) < curScenario.count; i++){
			var txt = curScenario[line+i];
			if(txt !== void && txt != ""){
				var head = txt.charAt(0);
				if(head == ";")continue;	// コメントは無視
				if(head == "*")break;		// 次のラベルが見つかったら何もせず帰る
				if(txt.indexOf("男性器]") != -1)findTinko = true;
				if(txt.indexOf("女性器]") != -1)findManko = true;
				if(findTinko && findManko)break;
			}
		}
		if(findTinko && findManko){
			// 複合パターンの場合
			     if(!sf[f.speaker+'男性器呼称'] &&  sf[f.speaker+'女性器呼称'])voice += "b1";
			else if( sf[f.speaker+'男性器呼称'] && !sf[f.speaker+'女性器呼称'])voice += "b2";
			else if(!sf[f.speaker+'男性器呼称'] && !sf[f.speaker+'女性器呼称'])voice += "b3";
		}else if(	(findTinko && !sf[f.speaker+'男性器呼称']) ||
					(findManko && !sf[f.speaker+'女性器呼称'])
				){
			voice += "b";
		}
	}
	return voice;
}

// 特別なボイスの自動検索 - 正規呼称分岐、主人公苗字分岐等ここで行う
function checkSpecialVoice(voice, elm=%[]){

	// 性器呼称自動分岐
	return checkGenitalVoiceSex(voice);

	var checkList = [
		// 付加して探すボイス, 付けるべき条件
		//["_mute", (!isDefaultName('苗字'))],	// _muteボイスがある、主人公苗字がデフォルトでないとき
		//["_name", (!isDefaultName('名前'))],	// _nameボイスがある、主人公名前がデフォルトでないとき
		//["b",     (characterList.find(f.speaker)!=-1 && ((elm.genital == 'man' && !sf[f.speaker+'男性器呼称']) || (elm.genital == 'woman' && !sf[f.speaker+'女性器呼称'])))]	// 名前がキャラクターリストに存在し、男性器呼称が偽、女性器呼称が真の時にはボイス名に「b」を付ける
	];
	var ies = Storages.isExistentStorage;
	for(var i=0; i<checkList.count; i++){
		var v = voice + checkList[i][0];
		var flag = checkList[i][1];
		if( (ies(v+".wav") || ies(v+".ogg")) && flag)voice = v;
	}
	return voice;
}

// 汎用ボイス再生 - マルチボイス・ラブリーコール・通常ボイスをこの関数で分岐する
// 引数にmp辞書を投げても直で文字列を投げてもOK、ラブリーコール文字列でもOK
function generalPlayVoice(_elm){
	var argType = typeof _elm;
	var elm = %[];
	var voice;

	if(argType == "Object"){	// mp辞書が投げられた場合
		(Dictionary.assign incontextof elm)(_elm);		// 念のためローカル変数にコピー
	}else if(argType == "String"){	// 文字列が投げられた場合
		elm.s = _elm;
	}else{
		if(tf.debugFlag)System.inform("ボイス再生関数に想定外の型が引き渡されました："+argType+"\n"+kag.consuctor.curStorage+"\n"+kag.conductor.curLine+"\n"+kag.conductor.curLineStr);
		return;
	}

	voice = elm.s;

	if(voice.indexOf(",")!=-1){
		// コンマがあった場合はマルチボイス
		var ar = voice.split(",",,true);
		var v = "";
		for(var i=0; i<ar.count; i++)v += checkSpecialVoice(ar[i], elm) + ",";
		playMultiVoice(v);
	}else if(isHeroine() && voice.indexOf('/')!=-1){
		// 話者がヒロインかつ、「/」がある場合はラブリーコール
		if(voice.charAt(0)!="/" && voice.charAt(voice.length-1)!="/"){
			// 頭、最後以外に「/」がある場合は特別なボイスの自動検索をかける
			var ar = voice.split("/",,false);
			if(ar.count != 2){
				if(tf.debugFlag)System.inform("想定外のラブリーコール入力がありました：\n"+kag.consuctor.curStorage+"\n"+kag.conductor.curLine+"\n"+kag.conductor.curLineStr);
			}else{
				voice = checkSpecialVoice(ar[0], elm)+"/"+checkSpecialVoice(ar[1], elm);
			}
		}
		elm.storage = elm.s = voice;
		playLovelyCallMacro(elm);	// ラブリーコール再生
	}else{
		// 上記以外
		elm.s = checkSpecialVoice(voice, elm);
		elm.history = true;
		playVoiceMacro(elm);	// 通常ボイス再生
	}
}

// 名前置換関連のコード
if(Storages.isExistentStorage("#name_replace.csv")){
	global.nameReplaceList =  %[];
	var temp = LoadCsv("#name_replace.csv");
	// 一行目を言語名として取り出す
	for(var i=0; i<temp[0].count; i++){		// 行ループ
		var obj = global.nameReplaceList[temp[0][i]] = %[];
		for(var j=1; j<temp.count; j++){	// 列ループ
			obj[temp[j][0]] = temp[j][i];	// 1列目がメンバ名、2列目以降が実際の文章
		}
	}
}else{
	global.nameReplaceList = %[];
}

// 名前をメッセージレイヤーに書き込む関数、ノベルモードなら履歴出力のみ
function nameDraw(name, align = "left", nameFrame = false){
	// 言語モードによる名前の置き換え
	if(sf.lang !== void && sf.lang != "jp" && name !== void && name != ""){
		if(nameReplaceList[sf.lang] !== void){
			var tmpName = nameReplaceList[sf.lang][name];
			if(tmpName !== void)name = tmpName;
		}
	}
	// ノベルモード、もしくはフレームに名前が書きこんであるフラグがあるなら履歴出力のみ
	kag.historyLayer.store("【"+name+"】");		// 履歴への出力
	if(f.frameType != "novel" && !nameFrame){
		setCurrentNameLayer();
		setFontColor(f.speaker);
		kag.current.setStyle(%[align:align]);
		kag.nameLayer.processCh(name);
		mp.t = name;
	}
	// 履歴改行
	kag.historyLayer.reline();
}

// メッセージフレームを状況に合わせて調整する関数
function adjustMsgFrame(name = ""){
	var obj = kag.fore.messages;

	if(f.isHScene && sysHMsgDesign){
		// Hシーン中のメッセージウィンドウ設定
		obj[0].opacity = sysHMsgOpacity;
	}else if(!f.isHScene || (f.isHScene && !sysHSceneWindow) || (f.isHScene && sysHMsgDesign == 0)){
		// 通常のメッセージウィンドウ設定
		var enableName = mp.t != "";		//(mp.t != "" && mp.t != "　" && mp.t != " ");		// 空白の名前を許さない場合
		obj[1].opacity = sysMsgOpacity;
		obj[1].visible = (enableName ? true : false);

		if(f.frameType == "adv"){
			// タイプ別の動作(game_setting.tjsで宣言)
			if(sysTextFrameType == 0){
				// 名前付き、無しのメッセージフレームが存在
				obj[0].setPosition(%[frame:enableName ? "g_frame_l" : "g_frame"]);
			}else if(sysTextFrameType == 1){
				// 名前用の分割フレーム画像が存在、伸縮する
				var tmp = new Layer(kag, kag.primaryLayer);
				with(obj[1]){
					var w = 0;
					for(var i=0; i<name.length; i++)w += kag.nameLayer.lineLayer.font.getTextWidth(name.charAt(i));
					w += (134+134);	// フレーム左＋フレーム右が最小保障
					.width = .imageWidth = w;
					tmp.loadImages("g_frame_nc");
					for(var i=0; i<.width; i+=tmp.imageWidth).copyRect(i, 0, tmp, 0,0,tmp.imageWidth,tmp.imageHeight);
					tmp.loadImages("g_frame_nl");
					.copyRect(0, 0, tmp, 0,0,tmp.imageWidth,tmp.imageHeight);
					tmp.loadImages("g_frame_nr");
					.copyRect(.width-tmp.imageWidth, 0, tmp, 0,0,tmp.imageWidth,tmp.imageHeight);
				}
				kag.back.messages[1].width = obj[1].width;
				kag.back.messages[1].assignImages(obj[1]);
				invalidate tmp;
			}else if(sysTextFrameType == 2){
				// 名前が書きこまれた個別の名前フレームがある場合
				var file = "g_nm_" + name;
				var ies = Storages.isExistentStorage;
				if(ies(file+".png") || ies(file+".tlg") || ies(file+".jpg")){
					obj[1].setPosition(%[frame:file, visible:true]);
					obj[1].opacity = 255;
				}else{
					obj[1].setPosition(%[frame:""]);
				}
			}else if(sysTextFrameType == 3){
				// 名前専用のフレームがあるが、固定サイズ
			}
		}
	}
}

@endscript



;■名前表示
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	t: 表示する名前
;		rt:本当の名前		def:-
;		mf:ミニフェイスフラグ	def:true
;		s:再生するボイスファイル	def:-
;		 「,」カンマで複数ボイスの同時再生指定※最大3キャラ分まで、それ以上はいつもどおりファイルを合成して下さい。
;exp.	名前表示用のマクロです。本当の名前は内部で使用するので、「？？？」等の表示の時に必ず入力してください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="nm"
@eval exp="mp.t = sf.名前+mp.t" cond="mp.addname=='true'"
@eval exp="f.speaker=(mp.rt!=void)?(mp.rt):(mp.t)"
@eval exp="f.speaking = true"
@eval exp="mp.mf = true" cond="mp.mf === void"

; ミニ表情
@show_miniface storage="&f[mp.rt !== void ? mp.rt : (mp.t === void ? 'aa' : mp.t)]" sepia=%sepia grayscale=%grayscale cond="sysFaceVisible && mp.mf"
; ボイス再生
@if exp="mp.s !== void"
@svo
@eval exp="generalPlayVoice(mp)"
@endif

; BGV一時停止
@bgv_auto_pause

; BGMを下げる処理
@if exp="sysBgmTempFade && mp.s !== void && !kag.bgm.currentBuffer.inFadeAndStop && kag.skipMode < 2"
@fadebgm volume="&(int)sysBgmDownVolume" time=300
@eval exp="tf.bgmTempFadeFlag=true"
@endif

; ノベルの場合は履歴出力のみ、そうでない場合は名前を書き込み(表示名, align, 名前フレームに名前が書きこんであるか)
@eval exp="nameDraw(mp.t, 'left', sysTextFrameType == 2)"

; メッセージフレームを状況に合わせて調整
@eval exp="adjustMsgFrame(mp.t)"

@backlay layer=message0
@backlay layer=message1
@endif
@eval exp="setCurrentMessageLayer();"
@endmacro


;■改ページ＋音声待ち＆停止
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	改ページ待ちを行います。音声の終了待ちや、左下表情の消去も兼ねます。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="np"
;@eval exp="kag.messageLayer.autoHyperLink()" cond="kag.skipMode == 0 || kag.skipMode == 1"
; 自動スキップのフラグをチェック
@eval exp="tf.autoSkipMode = false" cond="(kag.skipMode == 0 || kag.skipMode == 1)"
@endhact
@eval exp="kag.clickSkipEnabled = true;"
@wq canskip=true
@eval exp="kag.clickSkipEnabled = sysClickSkip"
@if exp="kag.autoMode && canWaitVoice()"
@wvo_auto
@hr
@else
@p
@endif

; ラブリーコール終了待ち
@wlc cond="kag.autoMode && sysLovelyCall"
@delay_script_skip
@eval exp="kag.messageLayer.clear(), kag.nameLayer.clear(), kag.messageLayer.visible = kag.nameLayer.visible = true"
@svo cond="sysVoiceCancel"
; ラブリーコールを止める
@lc_stop cond="sysVoiceCancel && sysLovelyCall" 
@hr
; 立ち絵表示・消去のトランジションが続いていたら場合、止める
@stoptrans
@backlay
; ミニ表情消去
@hide_miniface
@eval exp="f.speaking = false"
; 文字色クリア
@eval exp="setFontColor('')"
; 名前フレームを消去
@eval exp="kag.fore.messages[1].opacity = kag.back.messages[1].opacity = kag.fore.messages[1].visible = kag.back.messages[1].visible = 0"
; メッセージのフレームを正規化
@eval exp="frameCheckNpMacro()"
@backlay layer=message0
; お気に入りボイス用の記録削除
@eval exp="f.favoriteVoice = ''"
@endmacro

@iscript
// npマクロでのフレームチェック用関数
// Hシーンならデザインに従う、そうじゃなければEVCG変更モードかどうかによって変わる
function frameCheckNpMacro(){
	if(sysTextFrameType != 0 || f.frameType != "adv")return;

	var frame = "g_frame";
	if(f.isHScene)frame = sysHMsgDesign == 0 ? "g_frame" : (sysHMsgDesign == 1 ? "g_frame_h" : "LineBreak");
	else if(sysEvFrameChange && isLayer0Evimage())frame = "g_frame_h";

	kag.fore.messages[0].setPosition(%[frame:frame]);
	kag.back.messages[0].assignComp();
}
@endscript

;■改ページ＋音声待ち＆停止２
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="np2"
@endhact
@wait time=1500
@wvo
@cm
@svo cond="sysVoiceCancel"
@hide_miniface
@hr
@hr
@endmacro

;■音声待ち付きクリック待ち
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="nr"
@wvl *
@endmacro
@macro name="wvl"
;@eval exp="kag.messageLayer.autoHyperLink()" cond="kag.skipMode == 0 || kag.skipMode == 1"
@endhact
@p
@ws buf="&kag.se.count-2" canskip=true cond="kag.autoMode"
@delay_script_skip
@svo cond="sysVoiceCancel"
@locate y="&kag.current.y-kag.current.marginT+15"
@r
@hide_miniface
@hr
@eval exp="kag.nameLayer.clear()"
@eval exp="setFontColor('')"
@endmacro

;■ノベル用インデント
@macro name="novel_indent"
@locate x="&kag.current.lineLayer.font.getTextWidth('「')"
@indent
@endmacro

;■スキップの時とオートの時無視されるクリック待ち
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="waitclk"
@waitclick canskip=true cond="!kag.autoMode && (kag.skipMode==0 || kag.skipMode==1)"
@wait time=2000 cond="kag.autoMode"
@endmacro

;■スキップさせない強制クリック待ち、体験版終わりとか。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="waitclick2"
@eval exp="tf.noCtrlSkip = true"
@eval exp="kag.cancelSkip()"
@eval exp="kag.cancelAutoMode()"
@waitclick canskip=true
@eval exp="tf.noCtrlSkip = false"
@endmacro

;****************************************************************************************************
;****	◆立ち絵関係
;****************************************************************************************************
;■立ち絵マクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	****,*,*:立ち絵ファイル名,場所,優先度
;exp.	場所、優先度はデフォルトで0,0になります。主にこのマクロは直接使うことはなく、ツールにてお願いします。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="chr"
@wt
@backlay
@eval exp="kag.messageLayer.visible = false" cond="sysMsgAutoHide"
@hide cond="sysMsgAutoHide"
@eval exp="mpExpansion(), setCharacter(mp)"
@trans method=crossfade time="&sysDoCharFade == false ? 1 : (mp.time === void ? 250 : mp.time)"
@wt cond="sysMsgAutoHide"
@show cond="sysMsgAutoHide"
@eval exp="kag.messageLayer.visible = true" cond="sysMsgAutoHide"
@endmacro

@macro name="chr2"
@chr *
@show_miniface storage="&f[f.speaker]" sepia=%sepia grayscale=%grayscale cond="f.speaker!=void && f.speaker!='' && sysFaceVisible && f.frameType != 'novel'"
@endmacro


;■立ち絵をbackスクリーンに配置するためのマクロ
;  目パチのある立ち絵でsimageができないため
@macro name="chr_back"
@wt
@backlay
@eval exp="mpExpansion(), setCharacter(mp)"
@endmacro

;■キャラクター消去
@macro name="chr_del"
@wt
@eval exp="characterDelete(mp.name,,mp)"
@trans method=crossfade time="&sysDoCharFade == false ? 1 : (mp.time === void ? 250 : mp.time)"
;@wt
;@backlay
@endmacro

;■キャラクター歩き去る
[macro name="chr_del_walk"][wt][eval exp="characterDelete(mp.name, 'walk', mp)"][wm][forelay][endmacro]
;■キャラクター走り去る
[macro name="chr_del_dash"][wt][eval exp="characterDelete(mp.name, 'dash', mp)"][wm][forelay][endmacro]
;■キャラクター飛び去る
[macro name="chr_del_jump"][eval exp="mp.way = 'u', characterDelete(mp.name, '', mp)"][wm][forelay][endmacro]
;■キャラクター倒れる
[macro name="chr_del_down"][eval exp="mp.way = 'd', characterDelete(mp.name, '', mp)"][wm][forelay][endmacro]
;■キャラクタージャンプ
[macro name="chr_jump"][eval exp="characterJump(mp.name, mp.time)"][wm][stopmove][endmacro]
;■キャラクターフェード登場
[macro name="chr_walk"][eval exp="mpExpansion(), mp.move='true', setCharacter(mp)"][wm][stopmove][backlay][endmacro]
;■キャラクターフェード登場（立ち上がり）
[macro name="chr_standup"][eval exp="mpExpansion(), mp.standup='true', mp.move='true', setCharacter(mp)"][wm][stopmove][backlay][endmacro]
;■キャラクターフェード登場（飛び降り）
[macro name="chr_drop"][eval exp="mpExpansion(), mp.drop='true', mp.move='true', setCharacter(mp)"][wm][stopmove][backlay][endmacro]

;■キャラクターの場所移動
@macro name="chr_poschange"
@wt
@eval exp="mpExpansion(), characterPosChange(mp)"
@wm
@stopmove
@backlay
@endmacro

;■キャラクターのおじぎ
@macro name="chr_bow"
@chr_quake sx=0 xcnt=0 sy=%sy|10 ycnt=1 name=%name time=%time|700
@wqu
@sq
@endmacro

;■キャラクター専用クエイク
@macro name="chr_quake"
@eval exp="mp.pos = characterToLayer(mp.name)"
@quake * pos=%pos
@endmacro

;■キャラクター怯える
@macro name="shake"
@eval exp="mp.pos = characterToLayer(mp.name)"
@quake * x=3 y=2 loop=true pos=%pos
@endmacro

;■立ち絵の色補正強度の変更を元に戻す
;  設定の仕方は立ち絵マクロに「intensity=0.5」のように指定する。
;  クリアするまで設定は持続する。
@macro name="clear_intensity"
@eval exp="f.correctIntensity = void"
@endmacro



;****************************************************************************************************
;****	◆背景関係
;****************************************************************************************************

;■前景レイヤー裏画面を全て綺麗に
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="clearlayers"
@eval exp="for(var i=0; i<kag.back.layers.count; i++)kag.back.layers[i].freeImage()"
;==========
;e-mote用
;@emotestop seg=0 page=back
;@eval exp="emoteFullClear();"
;@eval exp="f.emoteEvcg = void"
;==========
@endmacro

;■デフォルト属性付き"image"タグ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="eximg"
@eval exp="mp.grayscale=true, mp.rgamma=1.3, mp.ggamma=1.1, mp.bgamma=1.0" cond="mp.sepia=='true'"
@if exp="mp.layer!==void && mp.layer!=0"
@image * storage=%storage|black layer=%layer page=%page|fore left=%left|0 top=%top|0 opacity=%opacity|255 visible=%visible|true index="&mp.index !== void ? mp.index : (10000+(int)mp.layer)"
@else
@image * storage=%storage|black layer=%layer|0 page=%page|fore left=%left|0 top=%top|0 opacity=%opacity|255 visible=%visible|true
@endif
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="simg"
@eximg *
@endmacro

;■デフォルト属性付きトランジション
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="extrans"
@eval exp="mp.time=1" cond="!sysDoCgFade && mp.nofadeskip !== 'true'"
@if exp="mp.trans != 'false'"
@trans * layer=base time=%time|500 method="&mp.rule === void ? (mp.method === void ? 'crossfade' : mp.method) : 'universal'"
@wt *
@endif
@endmacro

@macro name="imgtrans"
@eximg * page=back
@extrans *
@endmacro

@macro name="img"
@backlay
@eximg * layer=%layer|1 page=back
@extrans *
@endmacro

;■特定レイヤーのクリア
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	layer:	レイヤー名
;exp.	レイヤー名を続けて指定してください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="dellay"
@backlay
@eval exp="for(var i=0; i<mp.layer.length; i++)if(i<kag.back.layers.count)kag.back.layers[mp.layer[i]].freeImage()"
@extrans *
@endmacro

; 上記の一瞬バージョン
@macro name="sdellay"
@backlay
@eval exp="for(var i=0; i<mp.layer.length; i++)if(i<kag.back.layers.count)kag.back.layers[mp.layer[i]].freeImage()"
@forelay
@endmacro

;▼画像の追加読み込み

;追加読み込み記録用配列
@eval exp="f.addimgLayerArray = [];"

@macro name="addimg"
@eval exp="mp.layer = mp.layer == void ? (string)getFreeLayer() : mp.layer"
@eval exp="f.addimgLayerArray.add(mp.layer)"
@eximg * layer=%layer page=back
@extrans *
@endmacro

@macro name="del_addimg"
@eval exp="for(var i=0; i<f.addimgLayerArray.count; i++)if((int)f.addimgLayerArray[i]<kag.back.layers.count)kag.back.layers[(int)f.addimgLayerArray[i]].freeImage()"
@extrans *
@eval exp="f.addimgLayerArray = [];"
@endmacro

;■背景表示
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	storage: ファイル名
;		layer:レイヤー番号		def:0
;		time:フェードする時間	def:500
;		left:x座標です			def:-200
;		top:y座標です			def:-150
;exp.	背景CG表示用マクロ・基本的にstorage属性しか使いません。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bg"
@eval exp="mp.grayscale=true, mp.rgamma=1.3, mp.ggamma=1.1, mp.bgamma=1.0" cond="mp.sepia=='true'"
@backlay
@clear_face
@clearlayers

@eval exp="mp.x = -DEF_CAMERA_MARGIN_W, mp.y = -DEF_CAMERA_MARGIN_H"
@eval exp="mp.xp = 1, mp.yp = 1"
@eval exp="mp.xp=((int)mp.xper/100)" cond="mp.xper!==void"
@eval exp="mp.yp=((int)mp.yper/100)" cond="mp.yper!==void"
@if exp="mp.angle !== void"
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W+(DEF_CAMERA_MARGIN_W*mp.xp)" cond="mp.angle.indexOf('l') != -1"
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W-(DEF_CAMERA_MARGIN_W*mp.xp)" cond="mp.angle.indexOf('r') != -1"
@eval exp="mp.y = -DEF_CAMERA_MARGIN_H+(DEF_CAMERA_MARGIN_H*mp.yp)" cond="mp.angle.indexOf('u') != -1"
@eval exp="mp.y = -DEF_CAMERA_MARGIN_H-(DEF_CAMERA_MARGIN_H*mp.yp)" cond="mp.angle.indexOf('d') != -1"
@eval exp="mp.left=mp.x,mp.top=mp.y"
@endif

@eval exp="f.cameraAngle = [(mp.x+DEF_CAMERA_MARGIN_W), (mp.y+DEF_CAMERA_MARGIN_H)];"
@eval exp="f.nowBgTime = checkTime((mp.storage === void || mp.grayscale) ? 'black' : mp.storage)"

; 裏画面のレイヤーの順番を正規化
@eval exp="reorderBackLayers()"

; 立ち絵情報クリア
@eval exp="characterInfoClear(), reorderBackLayers()"
; 立ち絵配置も共に配置
@eval exp="mpExpansion(), setCharacter(mp)"

@if exp="mp.storage=='black' || mp.storage=='white' || mp.storage=='red' || mp.storage=='blue'"
@eval exp="mp.left = 0"
@eval exp="mp.top = 0"
@else
@eval exp="mp.left = -DEF_CAMERA_MARGIN_W" cond="mp.left === void"
@eval exp="mp.top = -DEF_CAMERA_MARGIN_H" cond="mp.top === void"
@endif

@imgtrans * left=%left top=%top

@setframe cond="sysEvFrameChange"
@endmacro


@macro name="bg_effect"
@eval exp="f.nowBgTime = 0"
@eval exp="f.nowBgTime = 1" cond="mp.state == '夕'"
@eval exp="f.nowBgTime = 2" cond="mp.state == '夜'"
@eval exp="f.nowBgTime = 3" cond="mp.state == '特殊'"
@endmacro
;■過去回想
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bg_mosaic"
@eval exp="mp.grayscale=true, mp.rgamma=1.3, mp.ggamma=1.1, mp.bgamma=1.0" cond="mp.sepia=='true'"
@backlay
@clear_face
@clearlayers

@eval exp="mp.x = -DEF_CAMERA_MARGIN_W, mp.y = -DEF_CAMERA_MARGIN_H"
@eval exp="mp.xp = 1, mp.yp = 1"
@eval exp="mp.xp=((int)mp.xper/100)" cond="mp.xper!==void"
@eval exp="mp.yp=((int)mp.yper/100)" cond="mp.yper!==void"
@if exp="mp.angle !== void"
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W+(DEF_CAMERA_MARGIN_W*mp.xp)" cond="mp.angle.indexOf('l') != -1"
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W-(DEF_CAMERA_MARGIN_W*mp.xp)" cond="mp.angle.indexOf('r') != -1"
@eval exp="mp.y = -DEF_CAMERA_MARGIN_H+(DEF_CAMERA_MARGIN_H*mp.yp)" cond="mp.angle.indexOf('u') != -1"
@eval exp="mp.y = -DEF_CAMERA_MARGIN_H-(DEF_CAMERA_MARGIN_H*mp.yp)" cond="mp.angle.indexOf('d') != -1"
@eval exp="mp.left=mp.x,mp.top=mp.y"
@endif
@eval exp="f.cameraAngle = [(mp.x+DEF_CAMERA_MARGIN_W), (mp.y+DEF_CAMERA_MARGIN_H)];"
@eval exp="f.nowBgTime = checkTime((mp.storage === void || mp.grayscale) ? 'black' : mp.storage)"

; 裏画面のレイヤーの順番を正規化
@eval exp="reorderBackLayers()"

; 立ち絵情報クリア
@eval exp="characterInfoClear(), reorderBackLayers()"
; 立ち絵配置も共に配置
@eval exp="mpExpansion(), setCharacter(mp)"
@eval exp="mp.left = -DEF_CAMERA_MARGIN_W" cond="mp.left === void"
@eval exp="mp.top = -DEF_CAMERA_MARGIN_H" cond="mp.top === void"

@imgtrans * left=%left top=%top method=mosaic

@endmacro


;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bg_move"
@eval exp="mp.grayscale=true, mp.rgamma=1.3, mp.ggamma=1.1, mp.bgamma=1.0" cond="mp.sepia=='true'"
@backlay
@clear_face
@clearlayers
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W, mp.y = -DEF_CAMERA_MARGIN_H"
@eval exp="mp.xp = 1, mp.yp = 1"
@eval exp="mp.xp=((int)mp.xper/100)" cond="mp.xper!==void"
@eval exp="mp.yp=((int)mp.yper/100)" cond="mp.yper!==void"
@if exp="mp.angle !== void"
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W+(DEF_CAMERA_MARGIN_W*mp.xp)" cond="mp.angle.indexOf('l') != -1"
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W-(DEF_CAMERA_MARGIN_W*mp.xp)" cond="mp.angle.indexOf('r') != -1"
@eval exp="mp.y = -DEF_CAMERA_MARGIN_H+(DEF_CAMERA_MARGIN_H*mp.yp)" cond="mp.angle.indexOf('u') != -1"
@eval exp="mp.y = -DEF_CAMERA_MARGIN_H-(DEF_CAMERA_MARGIN_H*mp.yp)" cond="mp.angle.indexOf('d') != -1"
@eval exp="mp.left=mp.x,mp.top=mp.y"
@endif
@eval exp="f.cameraAngle = [(mp.x+DEF_CAMERA_MARGIN_W), (mp.y+DEF_CAMERA_MARGIN_H)];"
@eval exp="f.nowBgTime = checkTime((mp.storage === void || mp.grayscale) ? 'black' : mp.storage)"
@move * layer=%layer|0 page=back accel=%accel|-1.8

; 裏画面のレイヤーの順番を正規化
@eval exp="reorderBackLayers()"

; 立ち絵情報クリア
@eval exp="characterInfoClear(), reorderBackLayers()"
; 立ち絵配置も共に配置
@eval exp="mpExpansion(), setCharacter(mp)"
@eval exp="mp.left = -DEF_CAMERA_MARGIN_W" cond="mp.left === void"
@eval exp="mp.top = -DEF_CAMERA_MARGIN_H" cond="mp.top === void"

@imgtrans * page=back left=%left top=%top
@wm
@endmacro

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bg_slide"
@eval exp="mp.x=-150" cond="mp.x===void"
@eval exp="mp.y=-1200" cond="mp.y===void"
@move layer=0 path="&'('+mp.x+','+mp.y+',255)'" time=%time|1000 accel=%accel|-2
@wm
@endmacro

;■背景をトランジッションと一緒にムーブインさせる
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bg_slide_in"
@clearlayers
@eval exp="mp.way = 'l'" cond="mp.way === void"
@simg * layer=%layer|0 page=back storage=%storage top=%top|0 left=%left|-25 index=%index|1000 cond="mp.way == 'l'"
@simg * layer=%layer|0 page=back storage=%storage top=%top|0 left=%left|25 index=%index|1000 cond="mp.way == 'r'"
@eval exp="f.nowBgTime = checkTime((mp.storage === void || mp.grayscale) ? 'black' : mp.storage)"
@move layer=%layer|0 page=back path=%path|(0,0,255) time=%time|1000 accel=%accel|-2
@extrans rule=%rule|rule_a_r time=%time|1000 cond="mp.way == 'l'"
@extrans rule=%rule|rule_a_l time=%time|1000 cond="mp.way == 'r'"
@stopmove
@endmacro

;■背景拡大準備
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bgz_ready"
@eff * page=back time=0 absolute=%absolute|1001 show=true
@weff
@endmacro

@macro name="bgz_del_ready"
@eff_delete *
@endmacro

@macro name="bgz"
@backlay
@bgz_ready *
@trans * layer=base time=%time|500 method="&mp.rule === void ? (mp.method === void ? 'crossfade' : mp.method) : 'universal'"
@wt
@endmacro

@macro name="bgz_del"
@backlay
@bgz_del_ready *
@trans * layer=base time=%time|500 method="&mp.rule === void ? (mp.method === void ? 'crossfade' : mp.method) : 'universal'"
@wt
@endmacro

;■黒フェード
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	time:フェードする時間	def:500
;exp.	黒にフェードアウトします。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="black"
@clear_face
@clearlayers
@eval exp="characterInfoClear(), reorderBackLayers()"
@imgtrans *
@eval exp="reorderBackLayers()"
@endmacro
;■白、赤、青各種派生
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
[macro name="white"][black * storage=%storage|white][endmacro]
[macro name="red"][black * storage=%storage|red][endmacro]
[macro name="blue"][black * storage=%storage|blue][endmacro]


;■カメラ効果
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	angle: 'l''r''u''d'の組み合わせ	def:-
;		xper:移動量の％		def:100
;		yper:移動量の％		def:100
;exp.	背景スライド用のマクロです。lrudの組み合わせと、方向に対してどれだけの割合(1～100)で動くかを指定します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="camera"
@wt
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W, mp.y = -DEF_CAMERA_MARGIN_H"
@eval exp="mp.xp = 1, mp.yp = 1"
@eval exp="mp.xp=((int)mp.xper/100)" cond="mp.xper!==void"
@eval exp="mp.yp=((int)mp.yper/100)" cond="mp.yper!==void"
@if exp="mp.angle !== void"
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W+(DEF_CAMERA_MARGIN_W*mp.xp)" cond="mp.angle.indexOf('l') != -1"
@eval exp="mp.x = -DEF_CAMERA_MARGIN_W-(DEF_CAMERA_MARGIN_W*mp.xp)" cond="mp.angle.indexOf('r') != -1"
@eval exp="mp.y = -DEF_CAMERA_MARGIN_H+(DEF_CAMERA_MARGIN_H*mp.yp)" cond="mp.angle.indexOf('u') != -1"
@eval exp="mp.y = -DEF_CAMERA_MARGIN_H-(DEF_CAMERA_MARGIN_H*mp.yp)" cond="mp.angle.indexOf('d') != -1"
@endif

;// 前景への移動命令
@eval exp="cameraMover(mp)"
@move layer=0 page=fore path="&mp.x + ',' + mp.y + ',255'" time=%time|500 accel=%accel|-1.9
@wm
@stopmove
@backlay
@endmacro

;▼カメラ移動用関数
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript
function cameraMover(elm)
{
	f.cameraAngle = [(elm.x+DEF_CAMERA_MARGIN_W), (elm.y+DEF_CAMERA_MARGIN_H)];

	for(var i=0; i<f.showingLayer.count; i++){
		if(kag.fore.layers[f.showingLayer[i]].visible){
			var magnification = 1;
			var storage=kag.fore.layers[f.showingLayer[i]].Anim_loadParams["storage"];
			switch(getChrSize(storage)){
				case "a":magnification=1.5;break;
				case "b":magnification=1.3;break;
				case "c":magnification=1.2;break;
			}
			kag.tagHandlers.move(%[layer:(string)f.showingLayer[i], page:"fore", path:(f.orgPos[i][0]+f.cameraAngle[0]*magnification)+','+(f.orgPos[i][1]+f.cameraAngle[1]*1.1)+','+kag.fore.layers[f.showingLayer[i]].opacity, time:elm.time !== void ? elm.time : 500, accel:-1.9 ]);
		}
	}
}
@endscript



;****************************************************************************************************
;****	◆EVCG表示関係
;****************************************************************************************************

;■イベントCG表示
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	storage: ファイル名
;		layer:レイヤー番号		def:0
;		time:フェードする時間	def:500
;		left:x座標です			def:0
;		top:y座標です			def:0
;exp.	イベントCG表示用マクロ・基本的にstorage属性しか使いません。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="ev"
@eval exp="mp.grayscale=true, mp.rgamma=1.3, mp.ggamma=1.1, mp.bgamma=1.0" cond="mp.sepia=='true'"
@backlay
@clearlayers
@clear_face
@eval exp="f.cameraAngle = [0, 0];"
@eval exp="characterInfoClear(), reorderBackLayers()"
@eval exp="mp.time=1" cond="!sysDoCgFade"

@imgtrans * left=%left|0 top=%top|0

; EVCGでのフレーム変更処理
@if exp="sysEvFrameChange && mp.storage !== void && mp.storage.substr(0,2) == 'ev'"
@setframe_ev
@else
@setframe cond="!f.isHScene && f.frameType != 'novel'"
@endif


; 裏画面のレイヤー順序を正規化
@eval exp="reorderBackLayers()"
@endmacro

@macro name="ev_mosaic"
@eval exp="mp.grayscale=true, mp.rgamma=1.3, mp.ggamma=1.1, mp.bgamma=1.0" cond="mp.sepia=='true'"
@backlay
@clearlayers
@clear_face
@eval exp="f.cameraAngle = [0, 0];"
@eval exp="characterInfoClear(), reorderBackLayers()"


@imgtrans * left=%left|0 top=%top|0 method=mosaic

; 裏画面のレイヤー順序を正規化
@eval exp="reorderBackLayers()"
@endmacro

@macro name="ev_slidein"
@backlay
@clearlayers
@clear_face
@eval exp="f.cameraAngle = [0, 0];"
@eval exp="characterInfoClear(), reorderBackLayers()"
@eval exp="mp.left = mp.way=='l'?-100:100"
@simg * page=back left=%left|0 top=%top|0
@eval exp="mp.mtime = mp.time===void ? 300:((int)mp.time*3/5)"
@move layer=%layer|0 page=back path=(0,0,255) time=%mtime accel=-2
@extrans * rule="&mp.way=='l'?'rule_a_r':'rule_a_l'" vague=50
@wm
; 裏画面のレイヤー順序を正規化
@eval exp="reorderBackLayers()"
@endmacro

@macro name="kaiso"
@eval exp="mp.grayscale=true, mp.rgamma=1.3, mp.ggamma=1.1, mp.bgamma=1.0" cond="mp.sepia=='true'"
@bg_mosaic * storage=black left=0 top=0
@eval exp="mp.left=0,mp.top=0" cond="mp.storage!==void && (mp.storage.substr(0,2)=='ev' || mp.storage.substr(0,2)=='sp') && mp.left==void && mp.top==void"
@bg_mosaic * storage=%storage
@endmacro

;■イベントＣＧのフラッシュバック(効果付き)
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="img_flash_noise"
@simg page=back layer=%layer|7 storage=white
[trans method=crossfade time=%wtime|100][wt]
[quake * x=5 y=8 time=%time|350 loop=true]
@eff page=back obj=1 storage=noise01 path=(512,384,255)(512,384,0)(512,384,0)(512,384,0)(512,384,0)(512,384,255) size=(1,1) time=100 rad=(0,0) mode=psmul clear=true loop=true show=true
@eff page=back obj=2 storage=noise02 path=(512,384,0)(512,384,255)(512,384,0)(512,384,0)(512,384,0)(512,384,0) size=(1,1) time=100 rad=(0,0) mode=psmul clear=true loop=true show=true
@eff page=back obj=3 storage=noise03 path=(512,384,0)(512,384,0)(512,384,255)(512,384,255)(512,384,0)(512,384,0) size=(1,1) time=100 rad=(0,0) mode=psmul clear=true loop=true show=true
@eff page=back obj=4 storage=noise04 path=(512,384,0)(512,384,0)(512,384,0)(512,384,0)(512,384,255)(512,384,0) size=(1,1) time=100 rad=(0,0) mode=psmul clear=true loop=true show=true
@simg page=back layer=%layer|7 storage=%storage|white
[trans method=universal time=%ftime|1000 rule=%rule|rule_m_inout vague=100][wt]
[quake * x=5 y=8 time=%time|350 loop=true]
@wait time=%time|1000
@eff_delete obj=1
@eff_delete obj=2
@eff_delete obj=3
@eff_delete obj=4
@simg page=back layer=%layer|7 storage=white
[trans method=crossfade time=%wtime|100][wt]
@freeimage layer=%layer|7 page=back
@sq
[trans method=crossfade time=%btime|100][wt]
@endmacro


;■EVCGの登録
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="cg_flag_on"
@eval exp="evcgFlagsOn(mp)"
@endmacro
@iscript
function evcgFlagsOn(mp)
{
	var ar = mp.storage.split(/,/,,true);
	var ies = Storages.isExistentStorage;
	for(var i = 0; i < ar.count; i++)
	{
		if( ies(ar[i]+".png") || ies(ar[i]+".tlg" )){
			sf[ar[i]] = 1;
		}
		else{ si(ar[i]+"は存在しないファイル名です！"); }
	}
}
@endscript


;****************************************************************************************************
;****	◆カットイン画像表示関係
;****************************************************************************************************
;■カットイン
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="cutin"
@eximg * storage=%storage page=fore layer=%layer|4 left=%sx top=%sy opacity=%opacity|0 visible=true
@move * layer=%layer|4 time=%time|1000 accel=%accel|-2 path="&mp.dx+','+mp.dy+','+(mp.do===void?'255':(+mp.do))"
@wm cond="mp.nowait===void"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="cutin_fade"
@backlay
@eximg * storage=%storage page=back layer=%layer|4 left=%x top=%y opacity=%opacity|255 visible=true
@extrans *
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="cutin_center"
@eval exp="mp.layer = (mp.layer === void ? 4 : mp.layer)"
@eval exp="mp.opacity = (mp.opacity === void ? 0 : mp.opacity)"
@eval exp="mp.ex = 0, mp.ey = 0"

@eximg * storage=%storage page=fore layer=&mp.layer left=0 top=0 opacity=mp.opacity visible=false

;カットイン画像を画面の真中に配置したときの座標
@if exp="kag.scWidth != kag.fore.layers[mp.layer].width"
@eval exp="mp.ex = kag.scWidth/2 - kag.fore.layers[mp.layer].width/2"
@endif

@if exp="kag.scHeight != kag.fore.layers[mp.layer].height"
@eval exp="mp.ey = kag.scHeight/2 - kag.fore.layers[mp.layer].height/2"
@endif

;指定されていなければランダム
@eval exp="mp.way = (mp.way === void) ? intrandom(4) : mp.way"

;上からフェードイン
@if exp="mp.way=='d' | mp.way == 0"
@eval exp="kag.fore.layers[mp.layer].top = mp.ey - (mp.inc === void ? 50 : mp.inc)"
;下からフェードイン
@elsif exp="mp.way=='u' | mp.way ==1 "
;開始位置を真中から下に
@eval exp="kag.fore.layers[mp.layer].top = mp.ey + (mp.inc === void ? 50 : mp.inc)"
;右からフェードイン
@elsif exp="mp.way=='r' | mp.way == 2"
@eval exp="kag.fore.layers[mp.layer].top = mp.ey"
@eval exp="kag.fore.layers[mp.layer].left = mp.ex + (mp.inc === void ? 50 : mp.inc)"
;左から
@elsif exp="mp.way=='l' | mp.way == 3"
@eval exp="kag.fore.layers[mp.layer].top = mp.ey"
@eval exp="kag.fore.layers[mp.layer].left = mp.ex - (mp.inc === void ? 50 : mp.inc)"
@endif

@eval exp="kag.fore.layers[mp.layer].visible=true"

@move * layer=&mp.layer time=%time|1000 accel=%accel|-2 path="&mp.ex + ',' + mp.ey + ',' + (mp.do === void ? '255' : (+mp.do))"
@wm cond="mp.nowait===void"

@endmacro

;■カットアウト
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="cutout"
@move * layer=%layer|4 path="&mp.x+','+mp.y+',0'" time=%time|1000 accel=-2
@wm cond="mp.nowait===void"
@layopt layer=%layer|4 opacity=255 visible=false top=0 left=0 cond="mp.nowait===void"
@freeimage layer=%layer|4 cond="mp.nowait===void"
@backlay layer=%layer|4
@endmacro

;■演出画像設置用
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="spimg"
@eval exp="mp.left=0" cond="mp.left===void"
@eval exp="mp.top=0" cond="mp.top===void"
@eval exp="mp.time=300" cond="mp.time===void"
@eff_trans * storage=%storage path="&mp.left+','+mp.top+',255'" lu_corner=true
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="del_spimg"
@backlay
@eff_delete *
@extrans *
@endmacro

@macro name="del_reserve_spimg"
@eff_delete *
@endmacro

@macro name="cutio"
@eff * storage=%storage lu_corner=true  clear=%clear|true
@weff * cond="mp.nowait!='true'"
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="wcutio"
@weff *
@endmacro

@macro name="spmove"
@eval exp="mp.time=10000" cond="mp.time==void"
@eval exp="mp.fadetime=500" cond="mp.fadetime==void"
@eval exp="mp.sx=+mp.sx,mp.sy=+mp.sy,mp.dx=+mp.dx,mp.dy=+mp.dy,mp.time=+mp.time,mp.fadetime=+mp.fadetime"
@eval exp="mp.fw = Math.abs((mp.dx-mp.sx)*(mp.fadetime/mp.time))" cond="(mp.dx-mp.sx)!=0"
@eval exp="mp.fh = Math.abs((mp.dy-mp.sy)*(mp.fadetime/mp.time))" cond="(mp.dy-mp.sy)!=0"
@eval exp="mp.sx == mp.dx ? (mp.fw=0) : (mp.sx > mp.dx ? (mp.fw*=-1) : (mp.fw))"
@eval exp="mp.sy == mp.dy ? (mp.fh=0) : (mp.sy > mp.dy ? (mp.fh*=-1) : (mp.fh))"
@eval exp="mp.absolute = mp.storage.substr(0,2)=='bg' ? 1001 : (10000+(+mp.obj))" cond="mp.absolute===void"
@eff * storage=%storage path="&mp.sx+','+mp.sy+','+(mp.nofade=='true'?255:0)+','+(+mp.sx+mp.fw)+','+(+mp.sy+mp.fh)+',255'" lu_corner=true time="&mp.fadetime" accel=1.8 absolute=%absolute
@weff *
@eff * storage=%storage path="&(+mp.sx+mp.fw)+','+(+mp.sy+mp.fh)+',255,'+mp.dx+','+mp.dy+',255'" lu_corner=true time="&mp.time-mp.fadetime" accel=-1.8 absolute=%absolute
@eval exp="setCgVer(mp.storage)"
@endmacro

@macro name="del_sp"
@backlay
@eff * storage=%storage path="&mp.sx+','+mp.sy+',255,'+mp.dx+','+mp.dy+',255'" lu_corner=true time=%time|500 clear=%clear|true accel=1.8 absolute="&10000+(+mp.obj)" cond="mp.storage!=void"
@eff_delete *
@extrans cond="mp.reserve!='true'"
@endmacro

@macro name="del_sp_all"
@backlay
@eff_delete * obj=0
@eff_delete * obj=1
@eff_delete * obj=2
@eff_delete * obj=3
@extrans cond="mp.reserve!='true'"
@endmacro

;▼プリセットクエイク
[macro name="q_big"][quake * x=50 y=50 time=%time|350][endmacro]
[macro name="q_normal"][quake * x=15 y=15 time=%time|350][endmacro]
[macro name="q_small"][quake * x=5 y=5 time=%time|350][endmacro]
[macro name="mq_big"][quake * x=50 y=50 msg=true time=%time|300][endmacro]
[macro name="mq_normal"][quake * x=20 y=20 msg=true time=%time|300][endmacro]
[macro name="mq_small"][quake * sx=5 sy=5 xcnt=9 ycnt=3 msg=true time=%time|300][endmacro]
[macro name="sqlr_big"][quake * sx=50 xcnt=%count|4 sy=0 time=%time|1000][endmacro]
[macro name="sqlr_normal"][quake * sx=30 xcnt=%count|4 sy=0 time=%time|1000][endmacro]
[macro name="sqlr_small"][quake * sx=10 xcnt=%count|4 sy=0 time=%time|1000][endmacro]
[macro name="squd_big"][quake * sy=50 ycnt=%count|4 x=0 time=%time|1000][endmacro]
[macro name="squd_normal"][quake * sy=30 ycnt=%count|4 x=0 time=%time|1000][endmacro]
[macro name="squd_small"][quake * sy=10 ycnt=%count|4 x=0 time=%time|1000][endmacro]
[macro name="sq"][stopquake][endmacro]
;▼クエイク終了待ち
[macro name="wqu"][wq canskip=true][endmacro]


;-------------------------------------
; コメントマクロ
;-------------------------------------
@macro name="rem"
@eval exp="dm('■コメント■' + mp.t)"
@endmacro


;■ボタン設置簡略化
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

;■ボタンON状態で無効化の簡略(裏レイヤー10を使うのに気を付けて)
@macro name="btt_on"
@eval exp="mp.graphic = mp.grp" cond="mp.grp!=void"
@image layer=10 page=back storage=%graphic
@pimage dx=%x dy=%y layer=0 page=back storage=%graphic sx="&kag.back.layers[10].width\3" sy=0 sw="&kag.back.layers[10].width\3" sh="&kag.back.layers[10].height"
@freeimage layer=10 page=back
@endmacro

;■直前に設置されたボタンを透過して無効化
@macro name="btt_off"
@btt_off_var off=true
@endmacro
@macro name="btt_off2"
@btt_off_var off2=true
@endmacro

@macro name="btt_ex"
@locate *
@eval exp="mp.graphic = mp.grp" cond="mp.grp!=void"
@eval exp="kag.tagHandlers[mp.macro](mp)"
@btt_off_var *
@endmacro

@macro name="btt_off_var"
@eval exp="kag.back.messages[+mp.layer].links[-1].storage=''; kag.back.messages[+mp.layer].links[-1].target=''; kag.back.messages[+mp.layer].links[-1].exp=''; kag.back.messages[+mp.layer].links[-1].object.hitThreshold = 256; kag.back.messages[+mp.layer].links[-1].object.opacity = 100,kag.back.messages[+mp.layer].links[-1].object.doGrayScale();" cond="mp.off !== void && mp.off!"
@eval exp="kag.back.messages[+mp.layer].links[-1].storage=''; kag.back.messages[+mp.layer].links[-1].target=''; kag.back.messages[+mp.layer].links[-1].exp=''; kag.back.messages[+mp.layer].links[-1].object.hitThreshold = 256; kag.back.messages[+mp.layer].links[-1].object.opacity = 100;" cond="mp.off2 !== void && mp.off2!"
@eval exp="kag.back.messages[+mp.layer].links[-1].object.opacity=0;" cond="mp.off3 !== void && mp.off3!"
@eval exp="kag.back.messages[+mp.layer].links[-1].storage=''; kag.back.messages[+mp.layer].links[-1].target=''; kag.back.messages[+mp.layer].links[-1].exp=''; kag.back.messages[+mp.layer].links[-1].object.hitThreshold = 256; kag.back.messages[+mp.layer].links[-1].enabled=false;" cond="mp.off4 !== void && mp.off4!"
@endmacro

; bttは普通のボタン
; 2,3,4はその数の画像のボタン
; 5：2枚画像＋輝き用1枚画像
; bstar：3枚画像＋輝き用1枚画像(_h)＋星屑画像
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
[macro name="btt"] [btt_ex * macro="button" ][endmacro]
[macro name="btt2"][btt_ex * macro="button2"][endmacro]
[macro name="btt3"][btt_ex * macro="button3"][endmacro]
[macro name="btt4"][btt_ex * macro="button4"][endmacro]
[macro name="btt5"][btt_ex * macro="button5"][endmacro]
[macro name="btt_bstar"][btt_ex * macro="button_bstar"][endmacro]
[macro name="btt_spin"][btt_ex * macro="button_spin"][endmacro]
[macro name="btt_anm3bt"][btt_ex * macro="button_anm3bt"][endmacro]

;■右下ボタンの画像入れ替え
@macro name="btn_change"
@eval exp="gamebuttonImageChange(mp.str)"
@endmacro


;■タイトルセット用
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="show_title"
@ch_addstrs str=%title fontsize=60
@ch_addstrs str="&'―'.repeat(mp.title.length*1.5)" fontsize=60 obj=1
@ch_setpreoption_auto kind=3 xinc=%xinc|30 sx="&kag.scWidth" sy=600 intime=1000 outtime=1000 time=3000 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=0
@ch_setpreoption_auto kind=3 xinc=%xinc|30 sx="&kag.scWidth+50" sy=620 intime=1000 outtime=1000 time=3000 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=0 obj=1
[ch_start][ch_start obj=1][ch_wait][ch_clear][ch_clear obj=1]
@eval exp="f.chapterTitle = mp.title" cond="mp.title!==void"
@endmacro

@macro name="set_title"
@eval exp="f.chapterTitle = mp.title" cond="mp.title!==void"
;@show_title title=%title
@endmacro

;■チャプター表示用
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="call_chapter"
@imgtrans * storage=%storage layer=%layer|5 time=%time|1000
@wait time=%wait|2000
@waitclk
@dellay layer=%layer|5 time=%time|1000
@endmacro

;■通常のゲームモードの準備
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="gameinit"
@clearlayers
@clearmessages
@clear_face
@frame_normal
@endmacro



;■ムービー再生(レイヤー再生)
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="play_movie"
@eval exp="skipAutoPause()"
@fovo
@info_stop
@eval exp="kag.rightClickHook.clear(), kag.keyDownHook.clear();"
@eval exp="mp.var = 'op_movie'" cond="mp.storage === 'op_movie.mpg'"
@shide
; 最初がホワイトアウトの時の対応
@white time=500 cond="mp.bwhite == 'true'"
@clearlayers
@clearmessages
@simg storage=white page=back cond="mp.bwhite == 'true'"
@forelay
@freeimage layer=1 page=fore
@layopt layer=1 page=fore visible=false opacity=255 left=0 top=0 
@video visible=true left=0 top=0 slot=0 loop=false mode=layer
@videolayer slot=0 channel=1 page=fore layer=1
@openvideo slot=0 storage=%storage
; ボリュームを設定：大域音量には完全に従うが、BGMボリュームは70を最大としてなんとなくボリューム設定
@eval exp="mp.volume = (int)((100*((sysGlobalVolume/100000)*(sysBgmVolume/70))))" cond="mp.volume === void"
@eval exp="mp.volume = 100" cond="(+mp.volume) > 100"
@video volume=%volume
@preparevideo slot=0
@wp slot=0 for="prepare"
@playvideo slot=0
@layopt layer=1 page=fore visible=true
@eval exp="kag.cancelSkip()"
@eval exp="kag.clickSkipEnabled = false"
@wait time=2000 canskip=false
;コレまでにたまったスキップ予定を破棄
@eval exp="kag.cancelSkip()"
@eval exp="kag.clickSkipEnabled = true"
;最後がホワイトアウトだった時の対応
@simg storage=white cond="mp.awhite == 'true'"
@eval exp="mp.canskip='false'" cond="mp.var == 'op_movie' && !sf.op_movie"
@wv slot=0 canskip=%cankip|true
@stopvideo slot=0
@clearvideolayer slot=0 channel=1
@freeimage layer=1 page=fore
@eval exp="sf[mp.var]=true" cond="mp.var !== void && mp.var !== ''"
@eval exp="kag.rightClickHook.add(gameRClickFunc), kag.keyDownHook.add(gameKeyFunc);"
@eval exp="skipAutoResume()"
@endmacro

;■背景ムービー用
@macro name="bg_movie"
@clearlayers
@clearmessages
@forelay
@freeimage layer=0 page=back
@layopt layer=0 page=back visible=true opacity=255 left=0 top=0
@layopt layer=0 page=fore visible=false opacity=255 left=0 top=0
@video visible=true left=0 top=0 slot=0 loop=true mode=layer
@videolayer slot=0 channel=1 page=back layer=0
@videolayer slot=0 channel=2 page=fore layer=0
@openvideo slot=0 storage=%storage
@eval exp="mp.volume = (int)((100*((sysGlobalVolume/100000)*(sysBgmVolume/70))))" cond="mp.volume === void"
@eval exp="mp.volume = 100" cond="(+mp.volume) > 100"
@video volume=%volume
@preparevideo slot=0
@wp slot=0 for="prepare"
@playvideo slot=0
@extrans *
@backlay
@endmacro
;■背景ムービー停止
@macro name="sbg_movie"
;裏チャンネル描画停止
@black * cond="mp.notrans !== void"
@stopvideo slot=0
@clearvideolayer slot=0 channel=1
@clearvideolayer slot=0 channel=2
@freeimage layer=0 page=back
@endmacro

;■他ムービー用
@macro name="fg_movie"
;@clearlayers
;@clearmessages
;@forelay
@freeimage layer=%layer|10 page=back
@freeimage layer=%layer|10 page=fore
@layopt layer=%layer|10 page=back visible=true opacity=255 left=0 top=0 index=30000
@layopt layer=%layer|10 page=fore visible=true opacity=255 left=0 top=0 index=30000
@video visible=true left=0 top=0 slot=0 loop=%loop|false mode=layer
@videolayer slot=0 channel=1 page=back layer=%layer|10
@videolayer slot=0 channel=2 page=fore layer=%layer|10
@openvideo slot=0 storage=%storage
@eval exp="mp.volume = (int)((100*((sysGlobalVolume/100000)*(sysBgmVolume/70))))" cond="mp.volume === void"
@eval exp="mp.volume = 100" cond="(+mp.volume) > 100"
@eval exp="mp.playrate = (mp.storage.substr(0,2) == 'mv' ? 1.5 : 1)"
@video volume=%volume playrate=%playrate
@preparevideo slot=0
@wp slot=0 for="prepare"
@playvideo slot=0
@wv slot=0 canskip=%cankip|true
@stopvideo slot=0
@clearvideolayer slot=0 channel=1
@clearvideolayer slot=0 channel=2
@freeimage layer=%layer|10 page=back
@freeimage layer=%layer|10 page=fore
@layopt layer=%layer|10 page=back index=11000
@layopt layer=%layer|10 page=fore index=11000
@endmacro

;****************************************************************
;****	◆BGM関連
;****************************************************************

;■BGM再生
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	storage: ファイル名
;		loop: ループ再生するか？	def: true
;exp.	指定されたBGMを再生します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bgm"
@eval exp="f.pausedStorage = void, f.pausedTime = 0" cond="mp.noclear!='true'"
@playbgm * storage=%storage loop=%loop|true cond="kag.bgm.playingStorage != mp.storage"
@if exp="mp.storage !== void && mp.storage!='' && sysShowBgmTitle"
@showbgmtitle * cond="mp.notitle === void"
@endif
@endmacro

;■BGMフェードイン
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	storage: ファイル名
;		loop: ループ再生するか？	def: true
;exp.	指定されたBGMを再生します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="fibgm"
@eval exp="f.pausedStorage = void, f.pausedTime = 0"
@fadeinbgm * storage=%storage time=%time|2000
@eval exp="mp.storage=void" cond="mp.storage==''"
@if exp="mp.storage !== void && mp.storage!='' && sysShowBgmTitle"
@showbgmtitle * cond="mp.notitle === void"
@endif
@endmacro

;■BGMフェードアウト
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	time: フェードする時間	def: 2000
;exp.	BGMを指定された時間でフェードアウトします。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="fobgm"
@fadeoutbgm time=%time|2500
@endmacro

;■BGMクロスフェード
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	storage: ファイル名
; 	time: フェードする時間	def: 2000
;		overlap: 2重で再生される時間	def:2000
;exp.	BGMを指定された時間でクロスフェード再生します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="xbgm"
@eval exp="f.pausedStorage = void, f.pausedTime = 0"
@wbgm
@xchgbgm * storage=%storage time=%time|2000 overlap=%overlap|2000
@eval exp="mp.storage=void" cond="mp.storage==''"
@if exp="mp.storage !== void && mp.storage!='' && sysShowBgmTitle"
@showbgmtitle * cond="mp.notitle === void"
@endif
@endmacro

;■BGMフェード待ち
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	BGMのフェードを待ちます。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="wbgm"
@wb canskip=%canskip|true
@endmacro

;■BGM停止
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	BGMを停止します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="sbgm"
@stopbgm
@endmacro

;■BGM一時停止
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	BGMを一時停止します。止めた位置も記録します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="pbgm"
@eval exp="f.pausedStorage = kag.bgm.playingStorage"
@eval exp="f.pausedTime = kag.bgm.currentBuffer.position"
@sbgm
@endmacro

;■BGM再開
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	一時停止状態のBGMを再開します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="rbgm"
@if exp="f.pausedStorage !== void"
@bgm * storage="&f.pausedStorage" noclear=true
@eval exp="kag.bgm.currentBuffer.position = f.pausedTime"
@eval exp="f.pausedStorage = void, f.pausedTime = 0"
@endif
@endmacro


;■BGM途中再生
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	BGMを任意の再生位置から再生
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="skbgm"
@bgmopt volume=0
@eval exp="mp.pos = 0" cond="mp.pos===void"
@playbgm storage=%storage
@eval exp="kag.bgm.currentBuffer.position = mp.pos"
@fadebgm volume=100 time=%time|1000

@if exp="mp.storage !== void && mp.storage!='' && sysShowBgmTitle"
@showbgmtitle * cond="mp.notitle === void"
@endif
@endmacro


;****************************************************************
;****	◆SE関連
;****************************************************************

;■ボイス再生
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript

function getVoiceVolume(storage)
{
	var fileName = storage.substr(0,4);
	var per = 1.0;
	if(fileName === void || fileName == "")fileName = " ";
	if(fileName === "chi_")fileName = "tit_";	// 千歳のラブリーコール用特別対応
	var tar = voiceHeaderList[fileName];

	if(tar !== void){
		per=sf["vom"+tar] ? 0 : sf["vol"+tar];
		if(!sf[tar+"played"]){
			if(kag.conductor.curStorage !== "config.ks"){
				sf[tar+"played"] = 1;
			}
		}
	}else{
		// 該当ボイスが女ボイスか？
		if(womanVoiceList.find(fileName) != -1){
			per=sf["vomその他女"] ? 0 : sf["volその他女"];
		}else{
			per=sf["vomその他男"] ? 0 : sf["volその他男"];
		}
	}
	if(per === void){
		dm("ボイスの音量取得に失敗しました、設定されていない可能性があります。"+tar);
		per = 1.0;
	}
	return per;
}

function getBgvVolume(storage)
{
	var fileName = storage.substr(0,4);
	var per = void;
	var tar;

	if(fileName === void || fileName == "")fileName = " ";
	tar = voiceHeaderList[fileName];

	if(tar !== void){
		per=sf["bgm"+tar] ? 0 : sf["bgv"+tar];
		if(!sf[tar+"played"]){
			if(kag.conductor.curStorage !== "config.ks"){
				sf[tar+"played"] = 1;
			}
		}
	}else{
		// 該当ボイスが女ボイスか？
		if(womanVoiceList.find(fileName) != -1){
			per=sf["bgmその他女"] ? 0 : sf["bgvその他女"];
		}else{
			per=sf["bgmその他男"] ? 0 : sf["bgvその他男"];
		}
	}

	if(per === void){
		dm("ボイスの音量取得に失敗しました、設定されていない可能性があります。"+tar);
		per = 1.0;
	}
	return per;
}

function playVoice(storage, _per=void, index=kag.numSEBuffers-2, forcePer=void, aTalk=true, saFlag=false)
{
	
	if(storage === void || storage == "")return;

	var fileName = storage.substr(0,4);
	
	// 主人公ボイスはHシーンで流さない設定
	if(!sysMainHVoPlay && f.isHScene && (fileName == "")){
		return;
	}

	// 個別ボイス音量の割合を取得
	var per = getVoiceVolume(storage);

	if(_per !== void)per *= (+_per)/100;
	if(forcePer !== void)per = (forcePer/100);
	
    // 効果音バッファ buf にて storage を再生する
    // KAG がスキップ処理中の場合は処理を行わない
    if(kag.skipMode==0 || kag.skipMode==1){
    	
    	try{
//			kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:(int)(sysVoiceVolume*per)]);
//			kag.se[kag.se.count-2].play(%[ storage : storage ]);

    		if( !saFlag ) kag.se[index].setOptions(%[volume:100,gvolume:(int)(sysVoiceVolume*per)]);
    		else          kag.se[index].setOptions(%[volume:100,gvolume:(int)(sysSecondAudioVolume*per)]);
			kag.se[index].play(%[ storage : storage ]);
    	}catch{ dm("★no_voice：" + storage); }
    	
    	// e-mote口パク処理
   		//if(sysEmoteAnim){
   		//	// EVCG E-mote口パクt
   		//	var obj0 = global.emote_player_object.layerList[0];
   		//	if(obj0 !== void && obj0.foreParam.storage != "" && obj0.foreParam.storage.substr(0, 3) == "ev_"){
   		//		if(fileName == "hrk_" || fileName == "yzk_"){
   		//			if(!global.emote_player_object.layerList[0].talkForce)
   		//				emote_player_object.variable(%[seg:0, page:"fore", name:"face_talk", buf:kag.se.count-2]);
   		//		}else{
   		//			if(!global.emote_player_object.layerList[0].talkForce)
   		//				emote_player_object.variable(%[seg:0, page:"fore", name:"face_talk", value:0]);
   		//		}
   		//	}else if( aTalk && (fileName == "hrk_" || fileName == "yzk_") ){
    	//		// ヒロインのみ口パク
    	//		try{
    	//			for(var i=0; i<f.emoteObjectList.count; i++){
    	//				if(f.emoteObjectList[i] == "")continue;
    	//				var doTalk = false;
    	//				if(f.emoteObjectList[i] != ""){
    	//					var jpName = voiceHeaderList[fileName];
    	//					var file = f.emoteObjectList[i];
    	//					if(file.indexOf(jpName) != -1)doTalk = true;
    	//				}
    	//				if(doTalk){
    	//					if(!global.emote_player_object.layerList[i].talkForce)
	    //						emote_player_object.variable(%[seg:i, page:"fore", name:"face_talk", buf:kag.se.count-2]);
    	//				}else{
    	//					if(!global.emote_player_object.layerList[i].talkForce)
    	//						emote_player_object.variable(%[seg:i, page:"fore", name:"face_talk", value:0]);
    	//				}
    	//			}
    	//		}catch(e){ dm("★E-moteの口パク処理に失敗しました"); }
    	//	}else{
    	//		// 口パク停止
    	//		for(var i=0; i<f.emoteObjectList.count; i++){
    	//			if(f.emoteObjectList[i] != "")emote_player_object.variable(%[seg:i, page:"fore", name:"face_talk", value:0]);
    	//		}
    	//	}
    	//}
    }else{
    	// e-moteスキップ中は口パクを停止
    	//for(var i=0; i<f.emoteObjectList.count; i++){
		//	if(f.emoteObjectList[i] != "")emote_player_object.variable(%[seg:i, page:"fore", name:"face_talk", value:0]);
		//}
    }
}
function createHistoryActionExp(storage)
{
    // メッセージ履歴をクリックしたときに実行する TJS 式を生成する
    return "playVoice('" + storage + "')";
}
// 待つべき一番長いボイスを探す
function VoiceWaitBufferSearch(){
	var waitbuffer = kag.se.count - 2;
	var time = 0;
	// 一度も読み込まれていないバッファのtotalTimeを参照してはいけない(ハードウェア例外がでる)
	// サウンドデバイスがない環境ではロードはされるが、playステータスになることはない
	if(kag.se[waitbuffer].status == "play")time = kag.se[waitbuffer].totalTime;
	for(var i = kag.se.count - 3;i >= kag.se.count-5; i--){
		if(kag.se[i].status == "play"){
			if(time <  kag.se[i].totalTime){
				time = kag.se[i].totalTime;
				waitbuffer = i;
			}
		}
	}
	return waitbuffer;
}
// ボイス待ちが発生するかどうかチェック
function canWaitVoice(){
	var target = kag.se[VoiceWaitBufferSearch()];
	var result = target.canWaitStop();
	// オートモードの待ちよりもボイスが短い場合待たない(待ちはpタグに任せる)
	if(target.status == "play" && kag.autoModePageWait > target.totalTime)result = false;
	return result;
}
// voマクロの中身を関数化
function playVoiceMacro(_elm){
	var elm = %[];
	(Dictionary.assign incontextof elm)(_elm);		// 念のためローカル変数にコピー
	if(elm.history!)kag.tagHandlers.hact(%[exp:createHistoryActionExp(elm.s)]);
	playVoice(elm.s, elm.volume, elm.index, void, elm.talk);
	f.lastPlayVoice = elm.s;
	f.favoriteVoice = f.lastPlayVoice;
}
@endscript


@macro name="vo"
@eval exp="playVoiceMacro(mp)"
@endmacro

; ボイスの終了待ち
@macro name="wvo"
@endhact
@eval exp="mp.buffer = VoiceWaitBufferSearch()"
@eval exp="kag.clickSkipEnabled = true"
;@ws buf="&kag.se.count-2" canskip=true
@ws buf=%buffer canskip=%canskip|true
@eval exp="kag.clickSkipEnabled = sysClickSkip"
@svo
@endmacro

; オート用、ボイスを待つけど停止しない
@macro name="wvo_auto"
@endhact
@eval exp="mp.buffer = VoiceWaitBufferSearch()"
@eval exp="kag.clickSkipEnabled = true"
@ws_auto buf=%buffer canskip=%canskip|true
@eval exp="kag.clickSkipEnabled = sysClickSkip"
@endmacro

;■全ボイスデータの停止
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	SEを停止します。同時に再生している場合buf属性を使って停止するバッファを指定してください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="svo"
@stopse buf="&kag.se.count-2"
@stopse buf="&kag.se.count-3"
@stopse buf="&kag.se.count-4"
@lc_stop cond="sysLovelyCall"
@endmacro

;■全ボイスデータのフェードアウト変更
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	time: フェードする時間	def: 500
;exp.	Voiceを指定された時間フェードしながら停止します。

@macro name="fovo"
@fadeoutse buf="&kag.se.count-2" time=%time|500
@fadeoutse buf="&kag.se.count-3" time=%time|500
@fadeoutse buf="&kag.se.count-4" time=%time|500
@endmacro

;■SE再生用関数
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript
// ボリューム指定があった場合、そのボリュームに、なければ100にする関数
function adjustSeVolume(_buf, vol){
	var buf = +_buf;
	if(buf >= 0 && buf < kag.se.count){
		if(vol === void){
			if(kag.se[buf].currentVolume != 100)kag.se[buf].setOptions(%[volume:100]);
		}else{
			kag.se[buf].setOptions(%[volume:vol]);
		}
	}
	// SE鳴らす前にシステムから指定されている音量をチェック違うなら合わせるように
	if(f.isHScene){
		var gvol = (int)(sysHSeVolume*1000);
		if(kag.se[buf].volume2 != gvol)kag.se[buf].setOptions(%[gvolume:sysHSeVolume]);
	}else{
		var gvol = (int)(sysSeVolume*1000);
		if(kag.se[buf].volume2 != gvol)kag.se[buf].setOptions(%[gvolume:sysSeVolume]);
	}
	
}
// ファイルの存在チェック+SEを再生していいか決定する+ループファイルがあるならループフラグを立てる
function iesSound(){
	var storage = mp.storage;
	var ies = Storages.isExistentStorage;
	if(ies(storage+".wav") || ies(storage+".ogg") || ies(storage)){
		if(ies(storage+".wav.sli") || ies(storage+".ogg.sli") || ies(storage+".sli"))mp.loop = "true";
		return true;
	}else{
		if(tf.debugFlag){
			try{
				debugErrorOutput("存在しないSE指定があります："+storage);
			}catch(e){dm(e.message);}
		}
		return false;
	}
}
@endscript

;■SE再生
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	storage: ファイル名
;		buf: バッファ番号	def: 0
;exp.	指定されたSEを再生します。同時に再生する場合buf属性を使ってください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="se"
@sse *
@if exp="iesSound() && !(f.isHScene && (sysHSound==0 || (sysHSound==2 && +mp.hse)))"
@eval exp="adjustSeVolume(mp.buf, mp.volume)"
@playse * storage=%storage buf=%buf|0 cond="(kag.skipMode==0 || kag.skipMode==1) || mp.loop == 'true'"
@endif
@endmacro

;■SE再生
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	storages: ファイル名（コンマ区切り）
;		buf: バッファ番号	def: 0
;exp.	指定されたSEを再生します。同時に再生する場合buf属性を使ってください。
;		また、「storage」ではなく「storages」なのに注意。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript
function soundRandomCreate(){
	if(mp.storage !== void)mp.storages = mp.storage;
	if(mp.storages !== void){
		var seList = mp.storages.split(/,/,,true);
		mp.storage = (seList[intrandom(0, seList.count-1)]).trim();
		return true;
	}else return false;
}
@endscript
@macro name="se_rand"
@eval exp="soundRandomCreate()"
@if exp="iesSound() && !(f.isHScene && (sysHSound==0 || (sysHSound==2 && +mp.hse)))"
@eval exp="adjustSeVolume(mp.buf, mp.volume)"
@se * storage=%storage
@endif
@endmacro

;■SEフェードイン
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in. 	storage: ファイル名
;		buf: バッファ番号	def: 0
;		time: フェードする時間	def: 500
;exp.	指定されたSEを指定された時間フェードしながら再生します。同時に再生する場合buf属性を使ってください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="fise"
@if exp="iesSound() && !(f.isHScene && (sysHSound==0 || (sysHSound==2 && +mp.hse)))"
@eval exp="adjustSeVolume(mp.buf, mp.volume)"
@fadeinse * storage=%storage buf=%buf|0 time=%time|500 cond="(kag.skipMode==0 || kag.skipMode==1) || mp.loop == 'true'"
@endif
@endmacro

;■SE停止
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	buf: バッファ番号	def: 0
;exp.	SEを停止します。同時に再生している場合buf属性を使って停止するバッファを指定してください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="sse"
@stopse buf=%buf|0
@endmacro

;■SEフェードアウト
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	buf: バッファ番号	def: 0
;		time: フェードする時間	def: 500
;exp.	SEを指定された時間フェードしながら停止します。同時に再生している場合buf属性を使って停止するバッファを指定してください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="fose"
@if exp="kag.skipMode!=0 && kag.skipMode!=1"
@sse buf=%buf|0
@else
@fadeoutse buf=%buf|0 time=%time|500
@endif
@endmacro


;■SEフェード待ち
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	buf: バッファ番号	def: 0
;exp.	指定されたバッファの終了を待ちます。同時に再生している場合buf属性を使って待ちを行うバッファを指定してください。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="wse"
@eval exp="kag.clickSkipEnabled = true"
@if exp="kag.se[+mp.buf].inFadeAndStop && kag.se[+mp.buf].looping"
@wf buf=%buf|0 canskip=%canskip|true
@else
@ws buf=%buf|0 canskip=%canskip|true
@endif
@eval exp="kag.clickSkipEnabled = sysClickSkip"
@endmacro


;■音関連フェードで全停止
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	time: フェードする時間	def: 2000
;exp.	SE,BGM,VOICEをすべてフェードで停止します。
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="allstopsound"
@eval exp="mp.time = 2000" cond="mp.time === void"
@fobgm time=%time
@eval exp="for(var i=0; i<kag.se.count; i++)kag.se[i].fadeOut(%[time:mp.time])"
@endmacro



;****************************************************************
;****	◆その他
;****************************************************************

;■回想から戻る用のマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="return_evmode"
@jump storage="ex_replay.ks" target="*end_scene" cond="tf.isEvMode"
@eval exp="sf['*h_scene_'+mp.no] = 1"
@endmacro

;■プラグインのマクロの呼び出し
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="plugin_call"
@eval exp="kag.forEachEventHook(mp.name, function(handler, f){ handler(f);} incontextof this, mp);"
@endmacro

;■オートセーブマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript
function AutoSaveFunc()		// オートセーブ用関数
{
	var num = sf.autoSaveNum;
	if(glRouteSave){
		var routeNo = (int)f[glRouteSaveFlagName];
		var _btn_max = global.SaveLoad_object.saveload._btn_max;		// セーブロードレイヤーからセーブデータのページ数を取ってくる
		var _item_max = global.SaveLoad_object.saveload._item_max;		// セーブロードレイヤーからセーブデータのセーブ数を取ってくる
		var baseNum = (routeNo+1) * (_btn_max * _item_max + glAutoSaveCount) - glAutoSaveCount;		// 自身の最大数からオートセーブ分引いた場所から開始
		num = baseNum + (int)sf.autoSaveCount[routeNo];
	}else{
		num = sf.autoSaveNum;
	}
	// このtrycatch要らないかも、saveAddInfoと似てる。暇なときに要検証。
	try{
		// セーブに必要な情報を追加
		if(kag.scflags.bookMarkComments !== void)
			kag.scflags.bookMarkComments[num] = ''; // コメントは一応クリア
		if(kag.scflags.bookMarkTitles === void)kag.scflags.bookMarkTitles = [];
		kag.scflags.bookMarkTitles[num] = f.chapterTitle;	// タイトルは設定
	}catch(e){
		if(typeof e !== "undefined")dm("オートセーブの追記情報の生成に失敗"+e.message);
		else dm("オートセーブの追記情報の生成に失敗、エラー情報無し");
	}
	saveAddInfo(num);		// セーブ時のゲーム変数のシステム変数への追記用関数
	// オートセーブカウントアップ
	if(glRouteSave){
		var routeNo = f[glRouteSaveFlagName];
		if((++sf.autoSaveCount[routeNo]) >= glAutoSaveCount)sf.autoSaveCount[routeNo] = 0;
	}else{
		if((++sf.autoSaveNum) >= glAutoSaveNum+glAutoSaveCount)sf.autoSaveNum = glAutoSaveNum;
	}
	// セーブ自体はセーブの終了待ちしてるっぽい雰囲気があるのでマクロで処理する。(コンダクタに-4返してた)
	return num;
}
@endscript
@macro name="auto_save"
@if exp="!tf.noAutoSaveOnece"
@save place="&AutoSaveFunc()" ask=false
@endif
@eval exp="tf.noAutoSaveOnece = false"
@endmacro



;▼動画再生用
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;※※！前提準備！
;main_setting.tjs：72行目付近、「numSEBuffers       = 20 + 4;」の下に「numMovies = 2;	// 同時に扱う動画の数」を挿入。
;まぁなくてもとりあえず動くようなコードも一応書いておく。
;//@iscript
;//if(kag.numMovies == 1){
;//	kag.add(kag.movies[1] = new Movie(kag,1));
;//	kag.numMovies = 2;
;//}
;//@endscript

;----------------------------------------------------------------------------------------------------------------
;※動画マクロ：指定されたスロットに動画をロード、裏レイヤー(スロット番号と同じレイヤー番号)に描画を開始し、
;※　　　　　　トランジション、裏レイヤーが表にまわるので再度裏レイヤーにチャンネル指定して表裏描画開始
;※　　　　　　これはサブマクロなので実際には「ev_movie01/ev_movie02」を使用
;----------------------------------------------------------------------------------------------------------------
@macro name="ev_movie"
@fovo
@info_stop
@clearlayers
@freeimage layer=%layer|0 page=back
@layopt layer=%layer|0 page=back visible=true opacity=255 left=0 top=0
@video visible=true left=0 top=0 slot=%slot|0 loop=true mode=layer
@videolayer slot=%slot|0 channel=1 page=back layer=%layer|0
@openvideo slot=%slot|0 storage=%storage
@eval exp="mp.volume = (int)((100*((sysGlobalVolume/100000)*(sysBgmVolume/70))))" cond="mp.volume === void"
@eval exp="mp.volume = 100" cond="(+mp.volume) > 100"
@video slot=%slot|0 volume=%volume
@preparevideo slot=%slot|0
@wp slot=%slot|0 for="prepare"
@playvideo slot=%slot|0
@video slot=%slot|0 frame=%frame cond="mp.frame !== void"
@extrans *
; トランジション終了後にchannnel設定を行い、表裏同時に描画するように調節
@videolayer slot=%slot|0 channel=2 page=back layer=%layer|0
@endmacro

;----------------------------------------------------------------------------------------------------------------
;※動画停止マクロ：スロット0,1両方のレイヤーの裏レイヤーを特定し、描画を停止、トランジション。
;　　　　　　　　　その後スロット0,1両方のチャンネル1,2を停止。
;----------------------------------------------------------------------------------------------------------------
@macro name="ev_movie_stop"
;この段階でchannelのどちらが裏レイヤーを指しているか分からないので特定しつつ停止
@clearvideolayer slot=0 channel="&kag.movies[0].layer1 == kag.back.layers[0] ? '1' : '2'"
@freeimage layer=0 page=back
@simg storage=%storage|black layer=0 page=back
@stopvideo slot=1
@clearvideolayer slot=1 channel="&kag.movies[1].layer1 == kag.back.layers[1] ? '1' : '2'"
@freeimage layer=1 page=back
@simg storage=%storage|black layer=1 page=back
@extrans *
@backlay
@stopvideo slot=0
@stopvideo slot=1
@clearvideolayer slot=0 channel=1
@clearvideolayer slot=0 channel=2
@clearvideolayer slot=1 channel=1
@clearvideolayer slot=1 channel=2
@endmacro


;----------------------------------------------------------------------------------------------------------------
;※動画マクロ：指定されたスロットに動画をロード、裏レイヤー(スロット番号と同じレイヤー番号)に描画を開始し、
;※　　　　　　トランジション、裏レイヤーが表にまわるので再度裏レイヤーにチャンネル指定して表裏描画開始
;----------------------------------------------------------------------------------------------------------------
@macro name="ev_movie01"
@ev_movie * layer=0 slot=0
@stopvideo slot=1
@clearvideolayer slot=1 channel=1
@clearvideolayer slot=1 channel=2
@freeimage layer=1 page=fore
@freeimage layer=1 page=back
@endmacro


@macro name="ev_movie02"
@ev_movie * layer=1 slot=1
@stopvideo slot=0
@clearvideolayer slot=0 channel=1
@clearvideolayer slot=0 channel=2
@freeimage layer=0 page=fore
@freeimage layer=0 page=back
@endmacro

@return


;▼複数行表示の為のサブルーチン
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
*overlap_ch
@history output=false
@iscript
// とりあえずエラーチェック
if(mp.txt1 === void || mp.txt2 === void)System.inform("エラー：複数行表示マクロ\n\n2つ以上指定してください。");

// フォントが変更された直後の呼び出しではフォントサイズが変わっていないので
// 確定させるため。じゃないと正しく何行必要か取得できぬ。
kag.current.decideSizeChange();

tf.lineCount=1;			//いくつの文字列が入力されたか
tf.chNum=0;			//現在何文字目か
tf.maxCh=mp.txt1.length;	//最大文字数
tf.xPos = new Array();		//それぞれの行の次に描画するx座標を記憶
tf.yPos = new Array();		//それぞれの行の次に描画するy座標を記憶
tf.lineEnd = new Array();	//行が終わったかどうかの配列
tf.lastLineTmp=true;		//最終行が無ければ(描画が終了すれば)falseになる。

// いくつの文字列を同時に表示するのか取得＋一番長い文字の文字数を取得
while(mp["txt"+(tf.lineCount+1)]!==void){
	if(tf.maxCh < mp["txt"+(tf.lineCount+1)].length)tf.maxCh=mp["txt"+(tf.lineCount+1)].length;
	tf.lineCount++;
}

// 最終行を設定
tf.lastLine=tf.lineCount;

// 最大文字数を表示するために何行必要とするか取得
// (その文字数で必要な幅\現在の書き込める領域の幅+1ドット)+1=必要な行数
// 1ドット増やしてるのは必要な幅と書き込める領域幅が同じだった場合、2行とカウントされるから。実際には1行でおけ。
if(!kag.current.vertical)
	tf.reline=( kag.current.fontSize*tf.maxCh + kag.current.pitch*(tf.maxCh-1) + kag.current.marginL ) \ (kag.current.relinexpos + 1) + 1;
else
	tf.reline=( kag.current.fontSize*tf.maxCh + kag.current.pitch*(tf.maxCh-1) + kag.current.marginT ) \ (kag.current.relinexpos + 1) + 1;

// 空行を空ける分カウントを増やす
if(mp.space)tf.reline+=(int)mp.space;

// それぞれの行の初期描画位置を設定。
if(!kag.current.vertical)
	for(var i=1; i <= tf.lineCount;i++){
		tf.xPos[i]=kag.current.x-kag.current.marginL;
		tf.yPos[i]=kag.current.y-kag.current.marginT+((kag.current.fontSize+kag.current.lineSpacing)*tf.reline*(i-1));
	}
else
	for(var i=1; i <= tf.lineCount;i++){
		tf.xPos[i]=kag.current.x-kag.current.marginL-((kag.current.fontSize+kag.current.lineSpacing)*tf.reline*(i-1));
		tf.yPos[i]=kag.current.y-kag.current.marginT;
	}

@endscript

;//描画開始
*overlap_ch_loop

@iscript
//それぞれの文字列の一文字ずつを最終行の手前の文字列まで表示
tf.lineNum=1;
while(tf.lineNum < tf.lastLine){
	if(tf.lineEnd[tf.lineNum]===void){
		//描画位置をロード
		kag.current.locate(tf.xPos[tf.lineNum],tf.yPos[tf.lineNum]);
		//自動インデントの影響を消す為に開始位置を偽る
		kag.current.lineLayerPos = 5;
		kag.current.processCh(mp["txt"+tf.lineNum][tf.chNum]);
		//次の描画位置を記憶
		tf.xPos[tf.lineNum]=kag.current.x-kag.current.marginL;
		tf.yPos[tf.lineNum]=kag.current.y-kag.current.marginT;
	}
	tf.lineNum++;
}
//最終行の描画位置をロード
kag.current.locate(tf.xPos[tf.lineNum],tf.yPos[tf.lineNum]);
//自動インデントの影響を消す為に開始位置を偽る
kag.current.lineLayerPos = 5;

@endscript

;//最終行を描画
@emb exp="mp['txt'+tf.lineNum][tf.chNum]"

@iscript
//最終行の次回描画位置を記憶
tf.xPos[tf.lineNum]=kag.current.x-kag.current.marginL;
tf.yPos[tf.lineNum]=kag.current.y-kag.current.marginT;

//次の文字へ
tf.chNum++;

// 最終行の再設定
tf.lastLineTmp=false;
for(var i=1; i <= tf.lastLine;i++){
	if(tf.lineEnd[i]===void){
		if(mp['txt'+i][tf.chNum]=='')
			tf.lineEnd[i]=true;
		else tf.lastLineTmp = i;
	}
}
tf.lastLine = tf.lastLineTmp;
@endscript

@jump storage="macro.ks" target="*overlap_ch_loop" cond="tf.lastLineTmp"

@history output=true
@iscript
for(var i=1; i <= tf.lineCount; i++){
	for(var j=0; j < mp['txt'+i].length; j++)
		kag.historyLayer.store(mp['txt'+i][j]);
	if(i != tf.lineCount)kag.historyLayer.reline();
}
@endscript
@return

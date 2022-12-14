
;****************************************************************************************************
;**** INDEX
;****◇タイトルによって中身が変わるかもしれないけれど基本汎用的に使えそうなマクロ関連
;****	◆その他
;****	◆呼び方変更関連
;****	◆パーティクル関連処理（一部新エンジンのみ）
;****	◆BGM関連
;****	◆EVCG関連
;****	◆アイキャッチ関連
;****◇タイトルによってしか使えそうにないマクロ関連
;****	◆「きゃらぶれ」関連
;****	◆「はるとゆき、」関連
;****	◆「竜騎士」関連
;****	◆「手垢塗れシリーズ」関連
;****	◆「命のスペア」関連
;****	◆「LOVESICK_PUPPIES（犬）」関連
;****	◆「イヅナ」関連
;****************************************************************************************************

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def：
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣


;========================================================================================================================================================================================================
;****◇タイトルによって中身が変わるかもしれないけれど基本汎用的に使えそうなマクロ関連
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



;****************************************************************************************************
;****	◆呼び方変更関連
;****************************************************************************************************

;■主人公の名前・一人称を設定したもので表示する
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="nm_苗字"
; もし名前画像が無かった場合
@eval exp="setCurrentNameLayer();"
; 文字色調整
;@eval exp="setFontColor(sf.苗字)"
; 文字設置
[nowait][emb exp="sf.苗字"][endnowait]
@hr
@eval exp="setCurrentMessageLayer();"
@endmacro

@macro name="nm_名前"
;//;@position layer=message0 frame="g_msg_frame_wn" page=fore
;//;@position layer=message0 frame="g_msg_frame_wn" page=back
;//; もし名前画像が無かった場合
;//@eval exp="setCurrentNameLayer();"
;//; 文字色調整
;//;@eval exp="setFontColor(sf.苗字)"
;//; 文字設置
;//@style align=center
;//[nowait][emb exp="sf.名前"][endnowait]
;//@hr
;//@eval exp="setCurrentMessageLayer();"
@eval exp="sf.名前 = ' '" cond="sf.名前 === void"
@nm t="&sf.名前"
@endmacro

;;;【苗字】【名前】【呼び名】は「plugin_lovelycall.ks」を参照してください
[macro name="一人称"][emb exp="sf.一人称"][endmacro]



;■ヒロインの呼び名を設定したもので表示する
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
[macro name="遥"][emb exp="sf.遥呼び名"][endmacro]
[macro name="柚季"][emb exp="sf.柚季呼び名"][endmacro]
@macro name="ヒロイン名"
@遥       cond="f.攻略対象 == '遥'"
@柚季     cond="f.攻略対象 == '柚季'"
@endmacro



;****************************************************************************************************
;****	◆パーティクル関連処理（一部新エンジンのみ）
;****************************************************************************************************

;■蛍マクロ、新エンジンのみで実装
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
[macro name="firefly_start"][endmacro]
[macro name="firefly_end"][endmacro]


;■雨マクロ・トランジション巻き込み出し入れ型
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def：
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="rain_start"
@eff obj=8 storage=rain_big path=(640,-48,255)(640,768,255) time=250 loop=true absolute=15000 back=true show=true
@endmacro
@macro name="rain_end"
@eff_delete obj=8
@endmacro



;****************************************************************************************************
;****	◆BGM関連
;****************************************************************************************************

;■指定した BGM のループ範囲フラグ(flags)を立てる
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	flags ：立てるループフラグ番号（1～15）		def：なし
;		reset ：1～15 のフラグをすべて 0 にするか？	def：「true」
;exp.	「BGM.tjs」に「ループするときはフラグ0を0にしておくルールに!」とあるので、
;		ここでは BGM flags[0] に影響を与えないようにしておく
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bgm_flags_on"
@if exp="mp.flags !== void && mp.flags != 0"
@if exp="%reset|'true'"
@eval exp="for( var i = 1; i < kag.bgm.currentBuffer.flags.count; i++ ){ kag.bgm.currentBuffer.flags[ i ] = 0; }"
@endif
@eval exp="kag.bgm.currentBuffer.flags[mp.flags] = 1"
@endif
@endmacro


;■指定した BGM のループ範囲フラグ(flags)をおろす
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	flags：おろすフラグ番号（1～15）	def:なし
;exp.	指定がない場合は、1～15 すべてのループ範囲フラグ(flags)をおろす。
;		「BGM.tjs」に「ループするときはフラグ0を0にしておくルールに!」とあるので、
;		ここでは BGM flags[0] に影響を与えないようにしておく
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="bgm_flags_off"
@if exp="mp.flags !== 0"
@if exp="mp.flags !== void"
@eval exp="kag.bgm.currentBuffer.flags[mp.flags] = 0"
@else
@eval exp="for( var i = 1; i < kag.bgm.currentBuffer.flags.count; i++ ){ kag.bgm.currentBuffer.flags[ i ] = 0; }"
@endif
@endif
@endmacro



;****************************************************************************************************
;****	◆EVCG関連
;****************************************************************************************************

; 
;■evcg強制変更用
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
; in.	dress：服装「a～z」
;exp.	このマクロを引数無しで呼び出せばリセット
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="change_evcg"
@eval exp="f.addEvcgAlphabet = mp.alphabet;"
@endmacro



;****************************************************************************************************
;****	◆アイキャッチ関連
;****************************************************************************************************

;■アイキャッチマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	sse_start：マクロ開始時に再生されている音を止めるかの判別用	def：true
;		sse_end  ：マクロ終了時に再生されている音を止めるかの判別用	def：true
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="eyecatch"
@eff_all_delete
@allStopSound time=300 cond=%sse_start|true
;//きゃらぶれアイキャッチ
@bg storage=sp_ec_bg
[se storage="特殊_アイキャッチ" buf=9]
@eff obj=0 storage=sp_ec_logo00 path=(263,62,0)(263,242,255) time=250 lu_corner=true absolute=15000
@weff obj=0
@eff obj=0 storage=sp_ec_logo00 path=(263,242,255)(263,272,255) time=200 lu_corner=true accel=-2 rad=(0,-5) absolute=15000
@weff obj=0
[fose buf=9 time=300]
@wait time=300
[sse buf=9]
@eff obj=0 storage=sp_ec_logo00 path=(263,272,255)(263,242,255) time=600 lu_corner=true accel=2 rad=(-5,0) absolute=15000
@weff obj=0
@eff_delete obj=0
@eff page=back show=true obj=1 storage=sp_ec_logo01 path=(263,242,255) time=1 lu_corner=true absolute=15000
@eff page=back show=true obj=2 storage=sp_ec_logo04 path=(478,260,255)(468,260,255)(478,260,255)(488,260,255)(478,260,255) time=20 rad=(0,3,0,3,0) loop=true lu_corner=true absolute=15001
@eff page=back show=true obj=3 storage=sp_ec_logo02 path=(687,296,255) time=1 lu_corner=true absolute=15002
@extrans
@wait time=800
;//オートセーブ
@auto_save cond="glDoAutoSave"	cond="!tf.isEvMode && mp.nosave != 'true'"
@eff_all_delete
@black rule=rule_tv01_i_o_tb
;//きゃらぶれアイキャッチ ここまで
;ＳＥが追加されたときの一応
@allStopSound time=300 cond=%sse_end|true
@wait time=500
@endmacro


;■つづくアイキャッチマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.  	sse_start：マクロ開始時に再生されている音を止めるかの判別用	def：true
;	  	sse_end  ：マクロ終了時に再生されている音を止めるかの判別用	def：true
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="to_be_continued"
@eff_all_delete
@black time=1
@allStopSound time=300 cond=%sse_start|true

;//はるとゆき、用
@bg storage=sp_at_bg time=1000
@wt
@wait time=50
@eff obj=1 storage=sp_at_continue path=(1085,606,0)(1090,606,255) time=1000 absolute=15001
@weff obj=1
@aseff
@wait time=2000
;//オートセーブ
@auto_save cond="glDoAutoSave"	cond="!tf.isEvMode && mp.nosave != 'true'"

@eff_all_delete
@black time=1000
;ＳＥが追加されたときの一応
@allStopSound time=300 cond=%sse_end|true
@wait time=2000
@endmacro



;■グランド用アイキャッチマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.  	sse_start：マクロ開始時に再生されている音を止めるかの判別用	def：true
;	  	sse_end  ：マクロ終了時に再生されている音を止めるかの判別用	def：true
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="eyecatch_grand"
@eff_all_delete
@black time=1
@allStopSound time=300 cond=%sse_start|true

;//はるとゆき、用
@bg storage=sp_at_bg time=1000 sepia=true
@wt
@wait time=50
@eff obj=1 storage=sp_at_logo path=(1208,537,0)(1208,537,255) time=1000 absolute=15001 sepia=true
@weff obj=1
@aseff
@wait time=2000
;//オートセーブ
@auto_save cond="glDoAutoSave"	cond="!tf.isEvMode && mp.nosave != 'true'"

@eff_all_delete
@black time=1000
;ＳＥが追加されたときの一応
@allStopSound time=300 cond=%sse_end|true
@wait time=2000
@endmacro




;========================================================================================================================================================================================================



;========================================================================================================================================================================================================
;****◇タイトルによってしか使えそうにないマクロ関連
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;****************************************************************************************************
;****	◆「きゃらぶれ」関連
;****************************************************************************************************

;■コロナキラキラマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.  	：	def：
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="キラキラ"
@eff page=back show=true obj=5 storage=sp_co_kirakira path=(383,169,255)(383,169,0)(383,169,255) size=(0.3,0.31,0.3) time=900 loop=true absolute=2000
@eff page=back show=true obj=6 storage=sp_co_kirakira path=(428,203,255)(428,203,0)(428,203,255) size=(0.2,0.22,0.2) time=1200 loop=true absolute=2001
@eff page=back show=true obj=7 storage=sp_co_kirakira path=(842,167,255)(842,167,0)(842,167,255) size=(0.3,0.29,0.3) time=1500 loop=true absolute=2002
@eff page=back show=true obj=8 storage=sp_co_kirakira path=(805,285,255)(805,285,0)(805,285,255) size=(0.35,0.33,0.35) time=800 loop=true absolute=2003
@eff page=back show=true obj=9 storage=sp_co_kirakira path=(779,100,255)(779,100,0)(779,100,255) size=(0.2,0.21,0.2) time=900 loop=true absolute=2004
@extrans time=250
@endmacro

;■コロナハートマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.  	：	def：
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="ハート"
@eff obj=5 storage=sp_co_heart path=(383,169,0)(383,149,255)(383,129,0) size=(0.3,0.31,0.32) time=900 accel=-2 loop=true absolute=2000
@eff obj=6 storage=sp_co_heart path=(428,203,0)(428,183,255)(428,163,0) size=(0.2,0.22,0.24) time=1200 accel=-2 loop=true absolute=2001
@eff obj=7 storage=sp_co_heart path=(842,167,0)(842,147,255)(842,127,0) size=(0.3,0.305,0.31) time=1500 accel=-2 loop=true absolute=2002
@eff obj=8 storage=sp_co_heart path=(805,285,0)(805,265,255)(805,245,0) size=(0.35,0.351,0.352) time=800 accel=-2 loop=true absolute=2003
@eff obj=9 storage=sp_co_heart path=(779,100,0)(779,80,255)(779,60,0) size=(0.2,0.21,0.22) time=900 accel=-2 loop=true absolute=2004
@endmacro

;■コロナガーンマクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.  	：	def：
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="ガーン"
@eff obj=7 storage=sp_co_shock00 path=(798,222,0)(798,222,255)(798,242,0) spline=true size=(0.1,0.1) time=900 accel=-2 absolute=2000
@eff obj=8 storage=sp_co_shock01 path=(807,285,0)(807,285,255)(807,305,0) spline=true size=(0.2,0.2) time=1500 accel=-2 absolute=2001
@eff obj=9 storage=sp_co_shock02 path=(405,175,0)(405,175,255)(405,195,0) spline=true size=(0.22,0.22) time=1100 accel=-2 absolute=2002
@endmacro

;■コロナ♀マクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.  	：	def：
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="メス"
@eff obj=7 storage=sp_co_rut path=(365,165,0)(365,165,255)(365,165,255)(365,165,255)(365,165,0)(365,165,0) rad=(-10,0,10,0,-10,-10) size=(0.3,0.3) time=600 loop=true absolute=2000
@eff obj=8 storage=sp_co_rut path=(854,100,0)(854,100,255)(854,100,255)(854,100,255)(854,100,0)(854,100,0) rad=(-6,0,6,0,-6,-6) size=(0.32,0.32) time=700 loop=true absolute=2001
@eff obj=9 storage=sp_co_rut path=(811,292,0)(811,292,255)(811,292,255)(811,292,255)(811,292,0)(811,292,0) rad=(15,0,-15,0,15,15) size=(0.25,0.25) time=800 loop=true absolute=2002
@endmacro




;****************************************************************************************************
;****	◆「はるとゆき、」関連
;****************************************************************************************************

;■Tips登録関連
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript
function getTipsElement(elm){
	var ar = [];
	ar.assign(elm);
	for(var i=0; i<ar.count; i+=2){
		if(ar[i] != "tagname")return ar[i];
	}
	return "";
}
@endscript

@macro name="tips"
@if exp="mp.t !== void"
@eval exp="tf.tipsName = mp.t"
@eval exp="tf.showName = mp.rt"
@else
@eval exp="tf.tipsName = tf.showName = getTipsElement(mp)"
@endif

@tips_unlock name="&tf.showName"

@link exp="&'tf.openTips = \''+tf.showName + '\'; if(kag.inStable)kag.callExtraConductor(\'ex_tips.ks\', \'*text_call\');'"
@font color=0xff7777
@emb exp="tf.tipsName"
@resetfont
@endlink
@endmacro

@macro name="tips_unlock"
;ここにアンロックコード書いて呼ぶ
@eval exp="sf['tips_'+mp.name] = 0" cond="sf['tips_'+mp.name] === void"
@endmacro

@macro name="leader_wait"
@wait time="&1000 + (+mp.count)*500"
@endmacro



;■各話のアバンタイトル表示マクロ
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	no : タイトル番号	def:01
;		sse_start：マクロ開始時に再生されている音を止めるかの判別用	def：true
;		sse_end  ：マクロ終了時に再生されている音を止めるかの判別用	def：true
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript
function abant_tagSplit(mp){
	var res = "";
	var tag = mp.no;
	if( tag.substring(0,4) == 'san_' ||
		tag.substring(0,4) == 'nek_' ||
		tag.substring(0,4) == 'sak_' ||
		tag.substring(0,4) == 'koh_'){
		res = tag.substring(4,2);
	}else{
		res = tag;
	}
	return res;
}
@endscript
@macro name="アバンタイトル"
@eff_all_delete
@stop_grain
@allStopSound time=300 cond=%sse_start|true
@white time=1000
@eval exp="mp.no = (mp.no !== void) ? mp.no : '01'"
@eval exp="mp.storage1 = 'sp_at_no' + abant_tagSplit(mp)"
@eval exp="mp.storage2 = 'sp_at_' + mp.no"
@eval exp="mp.se = (mp.se !== void) ? mp.se : '環_温泉かぽーん02'"
@eff page=back show=true obj=0 storage=sp_at_logo path=(1191,144,255) time=1 absolute=15001
@start_grain storage=gr_light,sp_anm_桜1a,sp_anm_桜2a type=cherry arrange=false num=20
@bg storage=sp_at_bg time=1000
@wait time=1000
@eff page=back show=true obj=1 storage=%storage1 path=(736,141,255) time=1 absolute=5002
@eff obj=2 storage=sp_at_alpha path=(640,-720,255)(640,720,255) time=3000 absolute=5003 delay=2000 sub=true
@eff obj=3 storage=%storage2 path=(640,354,255) time=3000 absolute=5004 alphaeffect=2 delay=2000
@extrans rule=rule_01_rt_lb time=3000
@weff obj=2
@se storage=%se buf=0 cond="mp.se != 'false'"
@aseff
@stop_grain
@extrans time=800
@waitclk
@eff_all_delete
@white time=1000
@allStopSound time=300 cond=%sse_end|true
@wait time=1000
@endmacro



;■成仏するときにでるエフェクト
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="成仏エフェクト"
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage="&'gr_snow_'+intrandom(0,4)" spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_add storage=gr_light spmode=true time_max=&'intrandom(3000,5000)' time_min=&'intrandom(500,1000)'
@leff_back * mode=psdodge5
@endmacro



;****************************************************************************************************
;****	◆「竜騎士」関連
;****************************************************************************************************

;■ドラゴンの咆哮時にＳＥを足す
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	buf：再生バッファ	def:15
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="火竜咆哮plusse"
@se storage="イ_booom13" buf=%buf|15
@endmacro



;****************************************************************************************************
;****	◆「手垢塗れシリーズ」関連
;****************************************************************************************************

;■副音声再生用関数群
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript
function isSecondAudio(){return (sysRealIntention || f.trialFixSAudio);}
function isSecondAudioText(){return sysRealIntentionText;}
function isSecondAudioCG(){return sysRealIntentionCG;}
function createSecondAudioLog(front, back){
	kag.historyLayer.store2("!isSecondAudioText() ? \""+back+"\":\""+front+"\"", (back.length > 38) || (front.length > 38));	// 履歴文字列作成
	tf.frontText = front;
	tf.backText = back;
}
function createSecondAudioLink(fv, bv){
	kag.historyLayer.setNewAction("playVoice(isSecondAudio() ? \""+bv+"\" : \""+fv+"\");");
	kag.historyLayer.setNewAction2("playVoice(isSecondAudio() ? \""+fv+"\" : \""+bv+"\", , kag.numSEBuffers-3, , true);");
	f.lastPlayVoice = "!playVoice(isSecondAudio() ? \""+bv+"\" : \""+fv+"\");";
	f.lastPlaySecondAudio = "!playVoice(isSecondAudio() ? \""+fv+"\" : \""+bv+"\", , kag.numSEBuffers-3, , true);";
	playVoice(isSecondAudio() ? bv : fv);	// ボイス再生
}
@endscript

;■副音声再生
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="saudio"
@secondaudio_enable
@eval exp="createSecondAudioLink(mp.fv, mp.bv)"
@nm t=%t rt=&mp.rt
; BGMを下げる処理
@fadebgm volume="&(int)sysBgmDownVolume" time=300 cond="sysBgmTempFade && !kag.bgm.currentBuffer.inFadeAndStop && kag.skipMode < 2"
@eval exp="createSecondAudioLog(mp.front, mp.back)"
[history output=false][emb exp="isSecondAudioText() ? mp.back : mp.front"][history output=true][np]

;オートモード中に裏のセリフも流す場合
@if exp="kag.autoMode && sysDoSecondAudioAuto"
@eval exp="createSecondAudioLink(mp.bv, mp.fv)"
@nm t=%t rt=&mp.rt
; BGMを下げる処理
@fadebgm volume="&(int)sysBgmDownVolume" time=300 cond="sysBgmTempFade && !kag.bgm.currentBuffer.inFadeAndStop && kag.skipMode < 2"
@eval exp="createSecondAudioLog(mp.back, mp.front)"
[history output=false][emb exp="isSecondAudioText() ? mp.front : mp.back"][history output=true][np]
@endif

@eval exp="tf.frontText = tf.backText = f.lastPlaySecondAudio = ''"
@secondaudio_disable
@endmacro



;****************************************************************************************************
;****	◆「命のスペア」関連
;****************************************************************************************************

;■タイトル効果演出用
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="シナリオ進行度"
@if exp="mp.progress !== void && mp.progress != ''"
[if exp="mp.progress > 100"][eval exp="mp.progress=100"]
[elsif exp="mp.progress < 0"][eval exp="mp.progress=0"]
[endif]
@eval exp="sf.storyProgress = f.storyProgress = mp.progress"

@else
@eval exp="f.storyProgress += 2.3"
[if exp="f.storyProgress > 100"][eval exp="f.storyProgress=100"]
[endif]
@eval exp="sf.storyProgress = f.storyProgress"

@endif
@endmacro



;****************************************************************************************************
;****	◆「LOVESICK_PUPPIES（犬）」関連
;****************************************************************************************************

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@iscript
function pda_perticle_pos_set(x_pos,size,bf_flag){
	var temp_line;
	var rvp_array;
	if(bf_flag == "true"){
		if(size == "a"){rvp_array = [500,780,520,600,255,255,320,960,310,760,1,1,2];		//大
		}else if(size == "b"){rvp_array = [600,680,320,400,255,255,420,860,110,560,1,1,2];	//中
		}else{rvp_array = [620,660,400,420,255,255,520,760,340,480,1,1,2];					//小
		}
	}else{
		if(size == "a"){rvp_array = [500,780,550,600,255,255,480,800,550,600,128,196,5];		//大
		}else if(size == "b"){rvp_array = [600,680,350,400,255,255,580,700,350,400,128,196,5];	//中
		}else{rvp_array = [620,660,400,420,255,255,610,670,395,430,128,196,5];					//小
		}
	}
	rvp_array[0] += kag.scWidth * (x_pos / 10 - 0.5);
	rvp_array[1] += kag.scWidth * (x_pos / 10 - 0.5);
	rvp_array[6] += kag.scWidth * (x_pos / 10 - 0.5);
	rvp_array[7] += kag.scWidth * (x_pos / 10 - 0.5);
	
	temp_line = "(" + rvp_array[0];
	for(var i = 1;i< rvp_array.count;i++){
		temp_line += "," + rvp_array[i];
	}
	temp_line += ")";
	
	return temp_line;
	
}

function pda_stand_pos_x(x_pos,size){
	var px;
	if(size == 'b') px=355;
	else px=497.5;
	//313
	//313
	//142.5
	
	
	px += (kag.scWidth * (+x_pos / 10 - 0.5));
	return px;
}

function pda_stand_light_pos_x(size){
	var px;
	if(size == 'b') px=136;
	else px=68;
	return px;
}

function pda_stand_chr_absolute(size,add_abs){
	var temp;
	if(size == "a"){temp = 7000;		//大
	}else if(size == "b"){temp = 6000;	//中
	}else{temp =  5000;					//小
	}
	temp += +add_abs;
	return temp;
}

function mpExpansion3()
{
	var tempArray = [];
	tempArray.assign(mp);
	tf.fp = [];	// ファイルネーム配列
	tf.ap = [];	// 場所配列
	tf.pp = [];	// 優先度配列
	tf.cp = [];	// 立ち絵分裂用配列

	for(var i=0; i<tempArray.count; i+=2){
		var tar = tempArray[i];

		if(tar!="tagname"){
			tf.fp.add(tar);
			var cut = ((string)tempArray[i+1]).split(/,/,,false);
			// 空の要素には文字列"true"が入ってくる。優先度しかなかった場合空白がくる。
			if(cut[0]=="true" || cut[0]=="")tf.ap.add(void);
			else tf.ap.add(cut[0]);
			
			if(cut[1]!==void && cut[0]!="")tf.pp.add(cut[1]);
			else tf.pp.add(void);
			// 立ち絵分裂用パラメーター
			if(cut[2]!==void && cut[2]!="")tf.cp.add(cut[2]);
			else tf.cp.add(void);
		}
	}
}
function updata_pda_pos(mp,num){
	var temp="";
	var pos_x = +mp.pos_x;
	var pos_y0 = +mp.pos_y;
	var pos_y1 = +mp.pos_y;
	var pos_y2 = +mp.pos_y;
	
	pos_y0 = pos_y0 - 220;
	pos_y1 = pos_y1 - 120;
	pos_y2 = pos_y2 - 20;
		
	
	switch(num){
		case 0:pos_x = pos_x - 60;temp = "("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y1+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y1+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)";break;
		case 1:pos_x = pos_x + 5;temp = "("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y1+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y1+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)";break;
		case 2:pos_x = pos_x + 70;temp = "("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y0+",255)("+pos_x+","+pos_y1+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y2+",255)("+pos_x+","+pos_y1+",255)("+pos_x+","+pos_y0+",255)";break;
	}

	return temp;
}


function algorithm_set(mp){
	var h_space;						//h_space→横幅→horizon_space
	var v_space;						//v_space→縦幅→vertical_space
	var temp = [0,0,0,0];

	
	if(mp.hmax === void) mp.hmax=1280;	//hmax→横幅最大→horizon_maximum
	if(mp.hmin === void) mp.hmin=0;		//hmin→横幅最小→horizon_minimum
	if(mp.vmax === void) mp.vmax=720;	//vmax→縦幅最大→vertical_maximum
	if(mp.vmin === void) mp.vmin=0;		//hmin→縦幅最小→vertical_minimum
	if(mp.amax === void) mp.amax=255;	//amax→不透明度最大→alpha_maximum
	if(mp.amin === void) mp.amin=255;		//amin→不透明度最小→alpha_minimum
	if(mp.hac === void) mp.hac=1;		//hac→横個数→horizon_area_count
	if(mp.vac === void) mp.vac=1;		//vac→縦個数→vertical_area_count

	mp.hac = (int)(+mp.hac);			//カウントを整数化
	mp.vac = (int)(+mp.vac);			//カウントを整数化
	
	h_space =(int)(+mp.hmax - +mp.hmin) \ +mp.hac;
	v_space =(int)(+mp.vmax - +mp.vmin) \ +mp.vac;
	
	for(var i=0;i<+mp.hac;i++){
		for(var j=0;j<+mp.vac;j++){
			temp[0] = +mp.hmin + (i * h_space);
			temp[1] = +mp.hmin + ((i+1) * h_space);
			temp[2] = +mp.vmin + (j * v_space);
			temp[3] = +mp.vmin + ((j+1) * v_space);
			mp.rand_path = temp[0] + "," + temp[1] + "," + temp[2] + "," + temp[3] + "," + +mp.amin + "," + +mp.amax;
			dm("mp.rand_path["+i+"]["+j+"]:"+mp.rand_path);
			light_eff_object.addDrawObj(mp);
		}
	}
}

function safe()
{
    for(var i=0;i<63;i++)
    {
        Scripts.eval("%d".sprintf(i));
    }
}

@endscript

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="stand_solaris"
@wt
@backlay cond="mp.stock != 'true'"
@eval exp="mp.left = getCharPosArray(mp.storage.substring(0,6))[0];"
@eval exp="mp.left += kag.scWidth * +mp.storage.substring(10,4) / 10;"
@eval exp="mp.top = getCharPosArray(mp.storage.substring(0,6))[1];"
@eval exp="mp.opacity = (mp.opacity !== void) ? mp.opacity : 255"
@eval exp="mp.path = '('+ mp.left + ',' + mp.top + ',' + mp.opacity + ')'"
@eval exp="mp.left1 = pda_stand_pos_x(mp.storage.substring(10,4),mp.storage.substring(5,1))"
@eval exp="mp.top1 = 477"
@eval exp="mp.left2 = mp.left1-pda_stand_light_pos_x(mp.storage.substring(5,1))"
@eval exp="mp.top2 = 0"
@eval exp="mp.storage1 = 'soraris_stand_pda_' + mp.storage.substring(5,1)"
@eval exp="mp.storage2 = 'sp_pda_face_light_' + mp.storage.substring(5,1)"
@eval exp="mp.index = pda_stand_chr_absolute(mp.storage.substring(5,1),mp.storage.substring(15))"
@eval exp="mp.index1 = mp.index - 2"
@eval exp="mp.index2 = mp.index + 2"
@eval exp="mp.absolute1 = mp.index - 1000"
@eval exp="mp.absolute2 = mp.index + 1000"
@eval exp="mp.rvp1 = pda_perticle_pos_set(mp.storage.substring(10,4),mp.storage.substring(5,1),true)"
@eval exp="mp.rvp2 = pda_perticle_pos_set(mp.storage.substring(10,4),mp.storage.substring(5,1),false)"
@eval exp="mp.storage = mp.storage.substring(0,9)"
@leff_fo storage=gr_light2 stock=true loop=true rand_vector_path=%rvp1 rand_time=(1500,3000) size=(0.2,0.3) rand_delay=(0,0) max=%bmax|40 rand_vector_rad=(0,0,0,360,2) rand_color=(0,1,0,1,0,1,0,0,0,0,0,0,255,255,255,255,255,255) absolute=%absolute1
@eval exp="safe()"
@leff_fo storage=gr_light2 stock=true loop=true rand_vector_path=%rvp2 rand_time=(2000,3000) size=(0.35,0.45) rand_delay=(0,0) max=%fmax|10 rand_vector_rad=(0,0,0,360,2) rand_color=(0,1,0,1,0,1,0,0,0,0,0,0,255,255,255,255,255,255) absolute=%absolute2 start_opacity_0=true
@simg page=back layer=13 storage=%storage left=%left top=%top index=%index
@simg page=back layer=12 storage=%storage1 left=%left1 top=%top1 index=%index1 cond="mp.storage.substring(5,1) != 'a' && mp.stand == 'true'"
@simg page=back layer=14 storage=%storage2 left=%left2 top=%top2 index=%index2 opacity=%light_opa|50 cond="mp.storage.substring(5,1) != 'a' && mp.light == 'true'"
@leff_back absolute=%index
@extrans * cond="mp.stock != 'true'"
@face storage=%storage cond="mp.miniface != 'true'"
@endmacro

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="change_solaris"
@backlay cond="mp.stock != 'true'"
@eval exp="mp.left = kag.fore.layers[13].left"
@eval exp="mp.top =  kag.fore.layers[13].top"
@eval exp="mp.storage = mp.storage.substring(0,9)"
@eval exp="mp.index = kag.fore.layers[13].absolute"
@face storage=%storage cond="mp.miniface != 'true'"
@simg page=back layer=13 storage=%storage left=%left top=%top index=%index
@eval exp="saveFace(mp.storage)"
@extrans time=250 cond="mp.stock != 'true'"
@backlay cond="mp.stock != 'true'"
@endmacro

@iscript
function macro_change_solaris(elm){
	elm.left = kag.fore.layers[13].left;
	elm.top =  kag.fore.layers[13].top;
	elm.storage = elm.storage.substring(0,9);
	elm.index = kag.fore.layers[13].absolute;
	if(elm.time === void)elm.time = 250;
	elm.method = "crossfade";
	if(elm.stock === void || elm.stock != "true"){
		kag.tagHandlers.backlay(%[]);
	}
	kag.back.layers[13].loadImages(elm);
	kag.fore.base.stopTransition();
	kag.fore.base.beginTransition(elm);
	if(elm.miniface != "true" || elm.miniface === void){
		miniface_object.showMainFace(%[storage:elm.storage]);
	}
}
@endscript


;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="dchange_solaris"
@eval exp="global.delayscript.addEvent(mp, 'macro_change_solaris')"
@endmacro

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="delete_solaris"
@freeimage layer=12 page=back cond="mp.stand != 'true'"
@freeimage layer=13 page=back cond="mp.solaris != 'true'"
@freeimage layer=14 page=back cond="mp.light != 'true'"
@sleff_back cond="mp.solaris != 'true'"
@extrans * cond="mp.stock != 'true'"
@endmacro

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="pda_updata_kotaro"
@eval exp="mp.path0 = '('+ +mp.pos_x +','+ +mp.pos_y +',255)'"
@eval exp="mp.path1 = updata_pda_pos(mp,0)"
@eval exp="mp.path2 = updata_pda_pos(mp,1)"
@eval exp="mp.path3 = updata_pda_pos(mp,2)"
@eval exp="dm(mp.path0)"
@eval exp="dm(mp.path1)"
@eval exp="dm(mp.path2)"
@eval exp="dm(mp.path3)"
@leff_add storage=sp_pda_bg_updata_00 path=%path0 time=0 absolute=15000
@leff_add storage=sp_pda_bg_updata_01 path=%path1 size=1 time=500 absolute=15001 yspin=(0,0,1,2,2,2,3,4,4,4) loop=true
@leff_add storage=sp_pda_bg_updata_02 path=%path2 size=1 time=500 absolute=15002 yspin=(0,0,0,1,2,2,2,3,4,4) loop=true
@leff_add storage=sp_pda_bg_updata_03 path=%path3 size=1 time=500 absolute=15003 yspin=(0,0,0,0,1,2,2,2,3,4) loop=true
@leff_back * cond="mp.stock != 'true'"
@extrans * cond="mp.stock != 'true'"
@endmacro

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="pda_updata_kotaro_delete"
@sleff_back
@extrans * cond="mp.stock != 'true'"
@endmacro


;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="algorithm_fo"
@eval exp="algorithm_set(mp)"
@endmacro

@iscript
function delay_rhythm(elm){
	if(elm.delay === void){
		elm.delay = 0;
	}else{
		elm.delay = +elm.delay;
	}
	for(var i=0; i<elm.max; i++){
		elm.delay = +elm.delay + +elm.delay_rhythm;
		light_eff_object.addDrawObj(elm);
	}
}

@endscript

;■
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
;in.	：	def:
;exp.	
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name=leff_fo_delay_rhythm
@eval exp="delay_rhythm(mp)"
@leff_back mode=%mode|alpha absolute=%c_absolute|15000 cond="mp.stock != 'true'"
@extrans method=crossfade time=100 cond="mp.stock != 'true'"
@endmacro



;****************************************************************************************************
;****	◆「イヅナ」関連
;****************************************************************************************************

;■イヅナ文字演出用マクロ（２行）
;￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
@macro name="iduna_law"
@simg layer=7 page=back storage=black opacity=100
[trans method=crossfade time=%trans|250][wt]
@ch_addstrs str=%txt1 fontsize=%fontsize|40
@ch_addstrs str=%txt2 fontsize=%fontsize|40 obj=1
@ch_setpreoption_auto kind=4 xinc=52 sx=150 sy=300 intime=250 outtime=0 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=50
@ch_setpreoption_auto kind=4 xinc=48 sx=150 sy=350 intime=250 outtime=0 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=50 obj=1
[ch_start][ch_wait][ch_start obj=1][ch_wait obj=1][waitclk]
@ch_setpreoption_auto kind=5 xinc=52 sx=150 sy=300 intime=0 outtime=250 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=0
@ch_setpreoption_auto kind=5 xinc=48 sx=150 sy=350 intime=0 outtime=250 time=0 size=0.5,0.5,0.5,0.5 accel=0 delay=0 startdelay=0 obj=1
[ch_start][ch_start obj=1][ch_wait][ch_clear][ch_clear obj=1]
@freeimage layer=%layer|7 page=back
[trans method=crossfade time=%trans|250][wt]
@backlay
@endmacro


;========================================================================================================================================================================================================

@return
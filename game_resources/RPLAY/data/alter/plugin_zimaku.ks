@if exp="typeof(global.zimaku_object) == 'undefined'"
@iscript

class ZimakuPlugin extends KAGPlugin
{

	var layer;			// 背景用レイヤー
	var ary = [];		// 文字ストック用配列

	function ZimakuPlugin()
	{
		super.KAGPlugin();
	}

	function finalize()
	{
		clear();
		super.finalize(...);
	}

	function add(str)
	{
		if(str == "")return;

		// ■が付いていたらすぐ開始
		var startFlag = false;
		if(str.charAt(str.length-1) == "■"){
			str = str.substr(0,str.length-1);
			startFlag = true;
		}

		if(str.charAt(0) == "　" || str.charAt(0) == "（")str = str.substr(1);
		if(str.charAt(str.length-1) == "）"){
			str = str.substr(0,str.length-1);
			var lw = str.charAt(str.length-1);
			if(lw != "！" && lw != "？" && lw != "。")str = str + "。";
		}
		// 横棒を縦棒に見せかける処理
		str = /―/gi.replace(str,"｜");
		str = /－/gi.replace(str,"｜");
		// 半角を全角に調整する処理
		str = /\|/gi.replace(str,"｜");
		// 半角英語を全角英語に調整する処理
		if(/[a-z]/g.test(str)){
			str = /a/g.replace(str,"ａ");
			str = /b/g.replace(str,"ｂ");
			str = /c/g.replace(str,"ｃ");
			str = /d/g.replace(str,"ｄ");
			str = /e/g.replace(str,"ｅ");
			str = /f/g.replace(str,"ｆ");
			str = /g/g.replace(str,"ｇ");
			str = /h/g.replace(str,"ｈ");
			str = /i/g.replace(str,"ｉ");
			str = /j/g.replace(str,"ｊ");
			str = /k/g.replace(str,"ｋ");
			str = /l/g.replace(str,"ｌ");
			str = /m/g.replace(str,"ｍ");
			str = /n/g.replace(str,"ｎ");
			str = /o/g.replace(str,"ｏ");
			str = /p/g.replace(str,"ｐ");
			str = /q/g.replace(str,"ｑ");
			str = /r/g.replace(str,"ｒ");
			str = /s/g.replace(str,"ｓ");
			str = /t/g.replace(str,"ｔ");
			str = /u/g.replace(str,"ｕ");
			str = /v/g.replace(str,"ｖ");
			str = /w/g.replace(str,"ｗ");
			str = /x/g.replace(str,"ｘ");
			str = /y/g.replace(str,"ｙ");
			str = /z/g.replace(str,"ｚ");
		}

		if(/[A-Z]/g.test(str)){
			str = /A/g.replace(str,"Ａ");
			str = /B/g.replace(str,"Ｂ");
			str = /C/g.replace(str,"Ｃ");
			str = /D/g.replace(str,"Ｄ");
			str = /E/g.replace(str,"Ｅ");
			str = /F/g.replace(str,"Ｆ");
			str = /G/g.replace(str,"Ｇ");
			str = /H/g.replace(str,"Ｈ");
			str = /I/g.replace(str,"Ｉ");
			str = /J/g.replace(str,"Ｊ");
			str = /K/g.replace(str,"Ｋ");
			str = /L/g.replace(str,"Ｌ");
			str = /M/g.replace(str,"Ｍ");
			str = /N/g.replace(str,"Ｎ");
			str = /O/g.replace(str,"Ｏ");
			str = /P/g.replace(str,"Ｐ");
			str = /Q/g.replace(str,"Ｑ");
			str = /R/g.replace(str,"Ｒ");
			str = /S/g.replace(str,"Ｓ");
			str = /T/g.replace(str,"Ｔ");
			str = /U/g.replace(str,"Ｕ");
			str = /V/g.replace(str,"Ｖ");
			str = /W/g.replace(str,"Ｗ");
			str = /X/g.replace(str,"Ｘ");
			str = /Y/g.replace(str,"Ｙ");
			str = /Z/g.replace(str,"Ｚ");
		}
		// ……の置き換え処理
		str = /…/g.replace(str,"・・・");

		ary.add("　" + str);

		if(startFlag)show();
	}

	function join()
	{
		// 3行ぐらいになるように繋げてみる
		if(ary.count > 3){
			for(var i=1; i<ary.count; i++){
				var lw = ary[i-1].charAt(ary[i-1].length-1);
				if(lw != "。" && lw != "！" && lw != "？" && (ary[i-1].length+ary[i].length)<26){
					ary[i-1] = ary[i-1] + ary[i];
					ary.erase(i);
				}
			}
		}
		// 縦書きだと全角（）が正しく表示されないので半角に変更
		for(var i=0; i<ary.count; i++){
			ary[i] = ary[i].replace(/（/, "(");
				ary[i] = ary[i].replace(/）/, ")");
		}
	}

	function show()
	{
//		if(!sf.zimaku){
//			ary = [];
//			return;
//		}
		//join();

		if(layer === void)layer = new MessageLayer(kag, kag.primaryLayer);
		with(layer){
			.clear();
			.absolute = kag.nameLayer.absolute;
			.setPosition(%[vertical:"true", left:kag.scWidth\2, top:0, width:kag.scWidth\2, height:kag.scHeight, marginr:50, margint:5, marginb:-10, visible:true, opacity:0]);
			.setFont(%[size:22]);
			.setDefaultFont(%[face:"VLゴシック_字幕用", size:20, bold:false, shadow:false, edge:true, edgecolor:0x000000]);
			.edgeExtent=3;
			//.edgeEmphasis=4096;
			.edgeEmphasis=3000;
			.resetFont();
			.decideSizeChange();
			.lineLayer.font.mapPrerenderedFont("vlg_字幕.tft");
			for(var i=0; i<ary.count; i++){
				for(var j=0; j<ary[i].length; j++){
					var ch = ary[i].charAt(j);
					.org_processCh(ary[i].charAt(j));
				}
				if(i != ary.count-1){
					.reline();
				}
			}
		}
		ary = [];
	}

	// 横書きバージョン
	function _show()
	{
		if(!sf.zimaku){
			ary = [];
			return;
		}
		join();

		if(layer === void)layer = new MessageLayer(kag, kag.primaryLayer);
		with(layer){
			.clear();
			.absolute = kag.nameLayer.absolute;
			.setPosition(%[vertical:"false", left:0, top:420, width:kag.scWidth, height:kag.scHeight\2, marginr:50, margint:0, visible:true, opacity:0]);
			//.setDefaultFont(%[face:"VL ゴシック", size:20, bold:false, shadow:false, edge:true, edgecolor:0x000000]);
			.setDefaultFont(%[face:"ニューシネマ", size:22, bold:false, shadow:false, edge:true, edgecolor:0x000000]);
			.edgeExtent=4;
			.edgeEmphasis=4096;
			.resetFont();
			.decideSizeChange();
			.lineLayer.font.mapPrerenderedFont("ニューシネマ.tft");
			.setStyle(%[align:"center", linespacing:2]);
			for(var i=0; i<ary.count; i++){
				for(var j=0; j<ary[i].length; j++)
				.org_processCh(ary[i].charAt(j));
				.reline();
			}
			.top = 560 - .y;
		}
		ary = [];
	}

	function clear()
	{
		ary = [];
		if(layer !== void)invalidate layer;
		layer = void;
	}

	// 以下、KAGPlugin のメソッドのオーバーライド
	function onRestore(f, _clear, elm){ clear();}
	function onStore(f, elm){}
	function onStableStateChanged(stable){}
	function onMessageHiddenStateChanged(hidden){}
	function onCopyLayer(toback){}
	function onExchangeForeBack(){}
	function onSaveSystemVariables(){}
}
kag.addPlugin(global.zimaku_object = new ZimakuPlugin());

@endscript
@endif

; 以下マクロ
@macro name="z"
@eval exp="global.zimaku_object.add(mp.t);"
@endmacro

@macro name="z_show"
@eval exp="global.zimaku_object.show()"
@endmacro
@macro name="z_sshow"
@eval exp="global.zimaku_object.sshow()"
@endmacro

@macro name="z_clear"
@eval exp="global.zimaku_object.clear()"
@endmacro

@return

@if exp="typeof(global.exlink_object) == 'undefined'"
@iscript

// 選択肢プラグイン

class exLinkBaseLayer extends Layer
{
	var storage;
	var target;
	var exp;
	var exp2;
	var onImage;
	var offImage;
	var useChangeType = true;
	var win;
	var par;
	var owner;
	var text;
	var text2;	//表示テキスト変更用
	var rby;
	var rby2;
	var ss;
	var bgFlag = 0;
	var bg = void;

	var ssLayer;

	var msgLayer;					// テキスト表示用レイヤー
	var shadowHeight = 2;			// 影の幅
	var fontColor    = 0xffffff;	// 文字色
	var shadowColor  = 0x000000;	// 影の色

	var clickFlag = false;

	function exLinkBaseLayer(win, par, owner)
	{
		super.Layer(...);

		this.win = win;
		this.par = par;
		this.owner = owner;
		if(typeof win.cursorPointed !== "undefined")
			cursor = win.cursorPointed;

		focusable = true;
		joinFocusChain = true;
		visible = true;

		ssLayer = new global.Layer(win, this);
		ssLayer.hitType = htMask;
		ssLayer.hitThreshold = 256;
	}

	function finalize()
	{
		if(bg !== void)invalidate bg;
		bg = void;
		invalidate ssLayer;
		invalidate msgLayer if msgLayer !== void;

		invalidate rby		if rby !== void;
		invalidate rby2		if rby2 !== void;
		
		super.finalize();
	}

	function readyBad()
	{
		bgFlag = 1;
		bg = new EffectPlugin(kag, 6);
	}

	function decision()
	{
		clickFlag = true;
		owner.linkDisable();
		if(exp !== void || exp!="")Scripts.exec(exp + ';');
		if(exp2 !== void || exp2!="")Scripts.exec(exp2 + ';');

		var pressImg = "g_select_press";
		var ies = Storages.isExistentStorage;
		if(ies(pressImg+".png") || ies(pressImg+".tlg") || ies(pressImg+".jpg")){
			loadImages(pressImg);
		}

		//選択肢文字列が複数行のときバックログを複数行にする
		var i;
		var choice = text.split(/￥ｎ￥ｎ/,,false);

		if(choice[0] != "") {//選択肢文字列が空白のときは何もログに出力しない
			// 履歴レイヤーを最適化～
			kag.historyLayer.reline();
			kag.historyLayer.reline();
			kag.historyLayer.store("────────────────────────────");
			kag.historyLayer.reline();
//			kag.historyLayer.store(text);
			for(i = 0; i < choice.count; i++){
				kag.historyLayer.store(choice[i]);
			kag.historyLayer.reline();
			}

			kag.historyLayer.store("────────────────────────────");
			kag.historyLayer.reline();
			kag.historyLayer.reline();
		}

		owner.storage=storage;
		owner.target=target;
		if(storage=="timelimit")kag.conductor.trigger('timeLimit');
		else win.process("exlink.ks", "*jump");
	}

	function onMouseDown(x, y, button, shift)
	{
		if(button == mbLeft)decision();
	}

	function onKeyDown(key, shift)
	{
		if(win.preProcessKeys(key, shift)) return;
		if(key == VK_RETURN)
			decision();
		super.onKeyDown(key, shift, true);
	}

	function onHitTest(x, y, process)
	{
		if(process)
		{
			// 右ボタンが押されていたときにイベントを透過
			if(System.getKeyState(VK_RBUTTON))
				super.onHitTest(x, y, false);
			else
				super.onHitTest(x, y, true);
		}
	}

	function on()
	{
		loadImages(onImage);
		if(ss !== void){
			ssLayer.loadImages(ss);
			ssLayer.setPos(49, 15);
			ssLayer.setSizeToImageSize();
			ssLayer.opacity=255;
			ssLayer.visible = true;
		}
		if(bg !== void){
			//absolute = 2000000 - 15;
			bg.startEffect(%[storage:"bg_next_chapter", path:"640,360,180", size:"(1.05,1,1.05)", time:"5000", accel:"-1.8", loop:"true", mblur:"true"]);
		}
		if(useChangeType)type = ltAlpha;
	}

	function off()
	{
		loadImages(offImage);
		if(ss !== void){
			ssLayer.loadImages(ss);
			ssLayer.setPos(49, 15);
			ssLayer.doGrayScale();
			ssLayer.setSizeToImageSize();
			ssLayer.opacity=255;
			ssLayer.visible = true;
		}
		if(bg !== void){
			if(bg.alive){
				bg.finish();
				bg.clearLayer();
			}
		}
	}

	function onFocus()
	{
		on();

		if( text2 !== void && !clickFlag ) changeText( text2, rby2 );
	}

	function onBlur()
	{
		off();
		if(useChangeType)type = ltPsMultiplicative;

		if( text2 !== void && !clickFlag ) changeText( text, rby );
	}

	function onMouseEnter()
	{
		if(win.mouseCursorState != mcsTempHidden)
			focus(true);
	}

	function onMouseLeave()
	{
		win.focusedLayer = null;
	}

	function changeText( aText="", aRby )
	{
		with( msgLayer )
		{
			.fillRect(0, 0, .width, .height, 0);

			var i;

			.type         = ltAlpha;
			.enabled      = false;
			.hitThreshold = 256;
			.absolute     = 1000000 + 15;

			//通常(選択肢)テキストのフォント設定
			.font.height  = 22;
			.font.face    = "VLG22";
			.font.mapPrerenderedFont( "vlg22.tft" );

			var textHeight = .font.getTextHeight( aText );			//テキストの高さ
			var rbyHeight  = .font.height * 0.46;					//ルビの高さ
			var rowSpaces  = .font.height * 0.33;					//行間
			var rowHeight  = textHeight + rowSpaces + shadowHeight;	//テキスト1列の高さ(テキストの高さ+行間+ルビの高さ+ルビの影)
			var textTop    = shadowHeight;							//テキストの表示開始位置

			if( aRby !== void )
			{
				textTop   += rbyHeight;	// ルビがある場合、表示開始位置をずらす
				rowHeight += rbyHeight;	// サイズも増やす
			}

			var txtLayMaxW = .font.getTextWidth( aText );
			var txtLayMaxH = rowHeight;
			var ar;

			//改行の対応
			if( aText.indexOf( "￥ｎ" ) != -1 )
			{
				ar         = aText.split( /￥ｎ￥ｎ/,,false );
				txtLayMaxW = .font.getTextWidth( ar[ 0 ] );

				for( i = 0; i < ar.count; i++ )
				{
					var tw = .font.getTextWidth( ar[ i ] );
					if( txtLayMaxW < tw ) txtLayMaxW = tw;
				}

				txtLayMaxH = rowHeight * ar.count;
			}
			else
			{
				ar = [];
				ar.add( aText );
			}

			.setSize( txtLayMaxW, txtLayMaxH );
			.setPos( left+width\2 - .width\2, top+height\2 - .height\2);
			//.fillRect(0, 0, .width, .height, 0);

			var _top = 0;
			for( i = 0; i < ar.count; i++  )
			{
				//ルビの高さ分下げてテキスト表示
				if( enabled )	.drawText( 0, textTop + _top, ar[i], fontColor, 255, true, 255, shadowColor, 1, 2, shadowHeight);
				else			.drawText( 0, textTop + _top, ar[i], 0x888888,  255, true, 255, 0x000000,    1, 2, shadowHeight);

				_top += rowHeight;
			}

			var noNltxt = [];

			//ルビがある
			if( aRby !== void )
			{
				//元テキストの幅覚えておく
				var orgTextW = .font.getTextWidth( aText );
				var orgTextH = .font.getTextHeight( aText );
				var orgTextChW;	//元文字列１文字分の幅
				var rW;			//ルビテキストの幅
				var offset;
				var strl;		//テキスト文字列開始位置

				//テキスト１文字ずつ左端座標を割り出す
				var locate = [];
				locate.add( 0 );

				strl = 0;

				for( i = 0; i < aText.length + 1; i++ )
				{
					//改行文字のとき
					if( aText.charAt( i ) == '￥' )
					{
						i += "￥ｎ￥ｎ".length;
						strl = i;
						locate.add( 0 );	//改行
						noNltxt.add( "￥ｎ" );
					}

					var str = aText.substr( strl, i - strl );
					var len = .font.getTextWidth( str ) + .font.getTextWidth( aText.charAt( 0 ) );
					locate.add( len );

					noNltxt.add( aText.charAt( i ) );
				}

				//ルビ文字高さ
				.font.height = .font.height * 0.46;
				.font.face   = "ＭＳ Ｐゴシック";
				.font.unmapPrerenderedFont();
				.font.bold   = false;

				var rby_top = 0;

				for( i = 0; i < aRby.count; i++ )
				{
					if( aRby[ i ].length != 0 )
					{
						rW = .font.getTextWidth( aRby[ i ] );

						//テキスト１文字のサイズ
						if( i == aRby.count - 1 )	orgTextChW = txtLayMaxW - locate[ i ];		//最終文字
						else						orgTextChW = locate[ i + 1 ] - locate[ i ];	//それ以外は1文字後ろとの差分

						//ルビ表示開始位置
						offset = ( rW * 0.5 ) - ( orgTextChW * 0.5 );

						//ルビ文字列が(選択肢)テキスト幅より超える場合サイズを伸ばす
						if((( locate[i] - offset ) + rW ) > txtLayMaxW)	.setSize(( locate[i] - offset ) + rW, txtLayMaxH );

						//"￥ｎ￥ｎ"がきた場合改行指示なので表示しない
						if( aRby[ i ] == "￥ｎ￥ｎ" )
						{
							rby_top += rowHeight;
							continue;
						}

						if( enabled )	.drawText(locate[i] - offset, rby_top, aRby[i], 0xffffff, 255, true, 255, 0x000000, 1, 2, shadowHeight);
						else			.drawText(locate[i] - offset, rby_top, aRby[i], 0x888888, 255, true, 255, 0x000000, 1, 2, shadowHeight);
					}
				}

				locate.clear();
				invalidate locate;

				//rby.clear();
				//invalidate rby;

				//rbyflg = false;
			}
			.visible = true;
		}
	}

	property enabled
	{
		setter(x){
			if(!x && ss !== void){
				ssLayer.doGrayScale();
			}
			super.enabled = x;
		}
		getter{
			return super.enabled;
		}
	}
}

class ExLinkPlugin extends KAGPlugin // 拡張選択肢プラグインクラス
{
	var linkObj = [];
	var shadowHeight = 2;	// 影の幅
	var linkSpaceDef = 25;	// 選択肢同士の幅デフォルト値
	var linkSpace    = 25;	// 実際の選択肢同士の幅
	var linkMaxWidth = 720;	// 選択肢を置ける領域
	var randx = false;		// 選択肢のx座標をずらす

	var hidden = false;

	var storage;	// 選択肢から受け取る
	var target;		// 選択肢から受け取る

	var dic = [];

	var showing = false;

	function ExLinkPlugin(window)
	{
		super.KAGPlugin();
	}

	function finalize()
	{
		for(var i = 0; i < linkObj.count; i++){
			invalidate linkObj[i] if linkObj[i] !== void;
		}
		super.finalize(...);
	}

	function readyLink(elm)
	{
		var re = new RegExp("<'([^>]+)'>","gi");
		var rel = new RegExp("￥ｎ￥ｎ","gi");
		var cpy;
		var tmp, c;
		var norubytxt = "";

		if( elm.txt !== void )
		{
			elm.rby = [];
			elm.rbyflg = false;
			
			for(var i = 0; i < elm.txt.length; i++) {
				cpy = elm.txt.substring(i);
				c = cpy.charAt(0);
				switch(c){
					case '<':	//ルビ用マーク
						tmp = re.match(cpy);
						if(tmp.count != 0) {
							i += tmp[0].length-1;
							elm.rby.add(tmp[1]);
							i++;
							norubytxt += cpy.charAt(tmp[0].length);
							elm.rbyflg = true;
						} else {
							elm.rby.add("");
							norubytxt += cpy.txt.charAt(0);
						}

						break;
					case '￥':	//改行
						tmp = rel.match(cpy);
						if(tmp.count != 0) {
							i += tmp[0].length -1;
							elm.rby.add(tmp[0]);
							norubytxt += cpy.substr(0, tmp[0].length);
						}
						break;

					default:
						elm.rby.add("");
						norubytxt += cpy.charAt(0);
						break;
				}
			}

			if(!elm.rbyflg) {
				elm.rby.clear();
			} else {
				elm.txt = norubytxt;
			}
		}

		if( elm.txt2 !== void )
		{
			elm.rby2 = [];
			elm.rbyflg2 = false;

			norubytxt   = "";

			for(var i = 0; i < elm.txt2.length; i++) {
				cpy = elm.txt2.substring(i);
				c = cpy.charAt(0);
				switch(c){
					case '<':	//ルビ用マーク
						tmp = re.match(cpy);
						if(tmp.count != 0) {
							i += tmp[0].length-1;
							elm.rby2.add(tmp[1]);
							i++;
							norubytxt += cpy.charAt(tmp[0].length);
							elm.rbyflg2 = true;
						} else {
							elm.rby2.add("");
							norubytxt += cpy.txt.charAt(0);
						}
            
						break;
					case '￥':	//改行
						tmp = rel.match(cpy);
						if(tmp.count != 0) {
							i += tmp[0].length -1;
							elm.rby2.add(tmp[0]);
							norubytxt += cpy.substr(0, tmp[0].length);
						}
						break;
            
					default:
						elm.rby2.add("");
						norubytxt += cpy.charAt(0);
						break;
				}
			}
            
			if(!elm.rbyflg2) {
				elm.rby2.clear();
			} else {
				elm.txt2 = norubytxt;
			}
		}


		dic.add(%[]);
		(Dictionary.assignStruct incontextof dic[-1])(elm);
	}

	function startLink(elm, spParent)
	{
		var _parent = kag.back.base;
		if(spParent !== void)_parent = spParent;
		with(linkObj[linkObj.add(new exLinkBaseLayer(kag, _parent, this))]){

			if(elm.ss !== void){
				.ss = elm.ss;
			}
			if(elm.onimg !== void).onImage = elm.onimg;
			else .onImage="g_select_on";
			if(elm.offimg !== void).offImage = elm.offimg;
			else .offImage="g_select_off";

			// バッドエンド画像だったら背景を出す試み
			if(elm.onimg == "g_select_bad_on").readyBad();

			//.loadImages(.offImage);
			.off();
			//.type = ltPsMultiplicative;
			.type = ltAlpha;
			.useChangeType = false;
			.text  = ( elm["txt"] !== void ) ? elm["txt"] : void;
			.text2 = ( elm["txt2"] !== void ) ? elm["txt2"] : void;
			.setSizeToImageSize();

			if( elm["rbyflg"]  )
			{
				.rby = [];
				.rby.assignStruct( elm["rby"] );

				elm["rby"].clear();
				invalidate elm["rby"];
				elm["rbyflg"]  = false;
			}

			if( elm["rbyflg2"] )
			{
				.rby2 = [];
				.rby2.assignStruct( elm["rby2"] );

				elm["rby2"].clear();
				invalidate elm["rby2"];
				elm["rbyflg2"] = false;
			}

			if(elm.hide=="true"){
				hidden = true;
				.height=.height\2;
				.width=.width\2;
				.opacity=0;
			}else{
				hidden = false;
				.opacity = ( elm.opacity === void ) ? 255 : +elm.opacity;
			}
			.setPos(0,0);
			.absolute = 1000000 + 14;

			if(elm["storage"]==void && elm["target"] == void){
				.storage="timelimit";
				.target="timelimit";
			}else{
				if(elm["storage"]!=void)
					.storage=elm["storage"];
				else .storage = kag.conductor.curStorage;
				.target=elm["target"];
			}

			.exp=elm["exp"];
			.exp2=elm["exp2"];
			if(elm.enabled===void || elm.enabled == "true" || elm.enabled == true){
				.enabled=true;
			}else{
				.enabled=false;
				//.adjustGamma(1.0, 0, 150, 1.0, 0, 150, 1.0, 0, 150);
				//.opacity=150;
			}

			with( .msgLayer = new Layer( kag, _parent ) )
			{
				.opacity = ( elm.opacity === void ) ? 255 : +elm.opacity;
			}

			.changeText( .text, .rby );
		}

		showing = true;
	}

	function setLinkPos(elm, spParent, sDic)
	{
		var linkHeight, linkWidth;
		var posX, posY;
		var _linkSpaceX = 10; // 選択肢が二列以上の時の横の間隔
		var _relineCnt   = 1; // 一行に置くボタン数：デフォルト=1

		// リンクの幅指定があったら従う
		if(elm.space_x !== void) _linkSpaceX = +elm.space_x;
		if(elm.space !== void)	 linkSpace  = +elm.space;
		else					 linkSpace  = linkSpaceDef;

		// 一行に置くボタン数指定があったら従う
		if(elm.reline !== void)	_relineCnt = +elm.reline;

		// 全画面サムネイル時に再現用にパラメーター全保存
		if(spParent === void){
			// 保存可能ラベルを通過した時点でのフラグにねじ込み
			kag.pflags.exlinkDic = [];
			kag.pflags.exlinkDic.assignStruct(dic);
		}else{
			dic.assign(sDic);
		}
		// ロードで来てる場合のロード時のフラグ消去
		f.exlinkDic = void;

		for(var i=dic.count-1; i >= 0; i--){ startLink(dic[i], spParent); }

		linkWidth  = linkObj[0].width;
		linkHeight = linkObj[0].height;

		posX = (kag.scWidth\2) - (linkWidth*_relineCnt\2) - (_linkSpaceX*(_relineCnt-1));

		if(hidden)	posY = (linkMaxWidth - (linkSpace*((linkObj.count-2)\_relineCnt)) - (linkHeight*((linkObj.count-1\_relineCnt))))\2;
		else		posY = (linkMaxWidth - (linkSpace*((linkObj.count-1)\_relineCnt)) - (linkHeight*(linkObj.count\_relineCnt)))\2;

		for(var i = 0; i < linkObj.count; i++){
			var obj   = linkObj[i];
			var _posx = posX + (linkWidth+linkSpace)*(i%_relineCnt);
			var _posy = posY + (linkHeight+linkSpace)*((linkObj.count-1)\_relineCnt-(i\_relineCnt));

			if(randx){
				var check;

				if(linkObj.count%2)	check = i%2;
				else				check = (i+1)%2;

				if(check) _posx = posX+25+intrandom(0,50);
				else	  _posx = posX-25-intrandom(0,50);
			}

			// 固定座標に設置
			//msgObj[i].setPos(linkObj[i].left+400, linkObj[i].top + linkObj[i].height\2 - msgObj[i].height\2);
			obj.setPos(_posx, _posy);
			obj.msgLayer.setPos(obj.left+obj.width\2-obj.msgLayer.width\2, obj.top + obj.height\2 - obj.msgLayer.height\2);
		}

		if(spParent === void){	// 通常処理
			linkObj[0].focus();
			if(hidden)	linkObj[-1].left+=linkObj[-1].width\2;
			kag.focusedLayer=linkObj[0];
			if(typeof global.moveCursor != "undefined")	global.moveCursor(kag.primaryLayer, linkObj[-1].left+(linkObj[-1].width>>1), linkObj[-1].top+(linkObj[-1].height>>1));
		}
		else{	// 全画面セーブ用処理
			linkDisable();
		}
	}

	function linkDisable()
	{
		for(var i = 0; i < linkObj.count; i++){
			linkObj[i].enabled = false;
			linkObj[i].msgLayer.enabled = false;
		}
	}

	function endLink()
	{
		f.exlinkDic = void;
		for(var i = 0; i < linkObj.count; i++){
			invalidate linkObj[i] if linkObj[i] != void;
		}
		linkObj.clear();
		dic.clear();
		showing = false;
	}

	function onMessageHiddenStateChanged(hidden){}
	function onRestore(){ endLink(); }

	function tempHide()
	{
		if(showing){
			for(var i = 0; i < linkObj.count; i++)
			{
				linkObj[i].visible = false;
				linkObj[i].msgLayer.visible = false;
			}
		}
	}

	function reShow()
	{
		if(showing){
			var obj;
			for(var i = 0; i < linkObj.count; i++){
				obj = linkObj[i];
				obj.parent  = kag.fore.base;
				obj.visible = true;

				obj.msgLayer.parent  = kag.fore.base;
				obj.msgLayer.visible = true;
			}
		}
	}

}

kag.addPlugin(global.exlink_object = new ExLinkPlugin(kag));
kag.addPlugin(global.exlink_thumb = new ExLinkPlugin(kag));
// プラグインオブジェクトを作成し、登録する

@endscript
@endif
;------------------------
; マクロ登録
;------------------------

; 選択肢登録
@macro name="exlink"
@eval exp="exlink_object.readyLink(mp)"
@endmacro

; 選択肢表示
@macro name="showexlink"
@eval exp="skipAutoPause()"
@backlay
@eval exp="exlink_object.setLinkPos(mp)"
@trans layer=base method=crossfade time=500
@wt

@if exp="!tf.isEvMode && mp.nosave != 'true'"
@auto_save cond="glDoAutoSave"
@endif

@s cond="mp.nowait!='true'"
@endmacro

; 待ちなしの選択肢の終了
@macro name="end_nowait_exlink"
@trans layer=base method=crossfade time=500
@wt
@endhact
@cm
@svo cond="sysVoiceCancel"
@eval exp="exlink_object.endLink()"
@endmacro

@return

;------------------------------------------------
;	選択肢選ばれた後のジャンプ処理
;------------------------------------------------

*jump
@eval exp="kag.cancelSkip()"
@trans layer=base method=crossfade time=500
@wt
;------------------
; 改ページマクロの改ページ待ちなし・音声待ちなしバージョンを入れる
; 改ページ待ちが無いから履歴の改行は2行ぶん。
@endhact
@cm
@svo cond="sysVoiceCancel"
;------------------
@eval exp="exlink_object.endLink()"
; スキップ・オート継続モード
@eval exp="skipAutoResume()"
@jump storage="&exlink_object.storage" target="&exlink_object.target"

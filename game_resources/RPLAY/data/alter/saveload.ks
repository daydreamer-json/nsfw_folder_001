@if exp="typeof(global.SaveLoad_object) == 'undefined'"
@iscript

Scripts.execStorage("saveload_setting.tjs");

// 
class SaveDataItemPanel extends Layer
{
	var str = "";

	function SaveDataItemPanel(win, par, str)
	{
		str = str;
		super.Layer(...);
		face = dfAlpha;
		type = ltAlpha;
		hitType = htMask;
		hitThreshold = 0;
		focusable = true;
		joinFocusChain = true;
	}

	function finalize()
	{
		super.finalize(...);
	}

	function set(w, h)
	{
		setImageSize(w, h);
		setSizeToImageSize();
		onMouseLeave();
	}

	function onFocus()
	{
		onMouseEnter();
	}

	function onBlur()
	{
		onMouseLeave();
	}

	function onMouseEnter()
	{
		fillRect(0,0,width,height,0xff0a246a);
		drawText(5,1,str, 0xffffff, 255, false);
	}

	function onMouseLeave()
	{
		fillRect(0,0,width,height,0x0);
		drawText(5,1,str, 0x000000, 255, false);
	}

	function onClick(x, y)
	{
		parent.onLayerClick(this);
	}

	function onKeyDown(key, shift)
	{
		if(key == VK_RETURN)
			parent.onLayerClick(this);
		else if(key == VK_ESCAPE)
			parent.visible = false;
		else super.onKeyDown(...);
	}
}

// エディット
class SaveDataControlPanel extends Layer
{
	var itemBg      = "sl_edit_items_bg";	// 編集一覧の背景
	var itemWidth   = 50;					// 
	var itemHeight  = 17;					// 
	var itemOffsetX = 0;                    // 
	var itemOffsetY = 0;                    // 
	var itemDiffX   = 0;                    // 
	var itemDiffY   = 0;                    // 

	var items = [		// 
		"コメント編集",
		"コピー",
		"移動",
		"削除"
	];

	var fontSize = 13;			// フォントサイズ
	var layers   = [];			// 
	var bgColor  = 0xffffffff;	// 背景色

	var isButton   = false;	// 編集一覧が画像のみで構成されるかどうか。自動判別
	var haveItemBg = false; // 編集一覧に専用の背景があるかどうか。自動判別


	function SaveDataControlPanel(win, par)
	{
		super.Layer(...);
		var ies = Storages.isExistentStorage;
		var w   = 0;

		font.height = fontSize;

		// 画像があれば画像で行う
		isButton = true;
		for(var i=0; i<items.count; i++){
			if(!ies("sl_edit_"+items[i]+".png") && !ies("sl_edit_"+items[i]+".tlg") && !ies("sl_edit_"+items[i]+".jpg")){
				isButton = false;
				break;
			}
		}

		// 編集一覧に背景画像が指定してあればそれを項目の背景として使用する
		haveItemBg = true;
		if( itemBg != "" && !ies(itemBg+".png") && !ies(itemBg+".tlg") && !ies(itemBg+".jpg")){
			haveItemBg = false;
		}

		for(var i=0; i<items.count; i++){
			var w_tmp = 0;
			for(var j=0; j<items[i].length; j++)
				w_tmp += font.getTextWidth(items[i].charAt(j));
			if(w_tmp > w)w = w_tmp;
		}
		itemWidth = w + 8;

		if(isButton)	makeMenuFromImg();
		else			makeMenu();

		if( haveItemBg )
		{
			loadImages( itemBg );
			setSizeToImageSize();
		}
	}

	function finalize()
	{
		for(var i=0; i<layers.count; i++)invalidate layers[i];
		super.finalize();
	}

	// 画像を使用して編集一覧を作成
	function makeMenuFromImg()
	{
		var _w = 0;
		var _h = 0;
		var _x = itemOffsetX;
		var _y = itemOffsetY;

		for(var i=0; i<items.count; i++){
			var obj;
			layers.add(obj = new FunctionButtonLayerEx(window, this, onLayerClick));
			obj.loadImages("sl_edit_"+items[i]);
			obj.setPos(_x, _y);
			obj.str  = items[i];
			_w       = obj.width;
			_h      += obj.height;

			_x += itemDiffX;
			_y += obj.height + itemDiffY;

			obj.visible=true;
		}
		setImageSize(_w, _h);
		setSizeToImageSize();
	}

	// フォントを使用して編集一覧を作成
	function makeMenu()
	{
		setImageSize(itemWidth, itemHeight*items.count);
		setSizeToImageSize();
		face = dfAlpha;
		type = ltAlpha;
		fillRect(0,0,width,height,bgColor);
		fillRect(1,1,1,height-2, 0xffffffff);		// 左縦ハイライト
		fillRect(1,1,width-3,1, 0xffffffff);		// 上横ハイライト
		fillRect(width-2,1,1,height-2, 0xff808080);	// 右1影
		fillRect(1,height-2,width-2,1, 0xff808080);	// 下1影
		fillRect(width-1,0,1,height, 0xff404040);	// 右2影
		fillRect(0,height-1,width,1, 0xff404040);	// 下2影

		for(var i=0; i<items.count; i++){
			var obj;
			layers.add(obj = new SaveDataItemPanel(window, this));
			obj.setPos(0+1,i*itemHeight+1);
			obj.str = items[i];
			obj.set(itemWidth-2, itemHeight-1);
			obj.visible=true;
		}
	}

	function onLayerClick(obj)
	{
		visible=false;
		parent.owner.dataOperation(layers.find(obj));
	}

	property visible
	{
		setter(x){
			super.visible = x;
			// 開いたら即フォーカスが来るように
			if(x)window.focusedLayer = layers[0];
		}
		getter{
			return super.visible;
		}
	}
}


//クリックされたときに実行する関数を指定できるボタンレイヤー
class SaveLoadButtonLayer extends ButtonLayer
{
	var onClickFunction;
	var page                = 0;
	var nowfocus            = false;
	var Butt_showFocusImage = true;
	var isQuadruple         = true;

	function SaveLoadButtonLayer(window, parent, func)
	{
		super.ButtonLayer(window, parent);
		focusable = true;
		joinFocusChain = true;
		onClickFunction = func;
	}

	function drawState(s)
	{
		imageLeft = -s * width;
	}

	function loadImages(storage, key)
	{
		if(isQuadruple){
			return super.loadImages(...);
		}else{
			var re = global.Layer.loadImages(storage, key);
			global.Layer.setSize(imageWidth\3, imageHeight);
			return re;
		}
	}

	function draw()
	{
		// 現在の状態にあわせて描画を行う
		if(isQuadruple){
			if(Butt_mouseDown)    drawState(1);
			else if(nowfocus)     drawState(3);
			else if(focused)      drawState(2);
			else if(Butt_mouseOn) drawState(2);
			else                  drawState(0);
		}else{
			if(Butt_mouseDown)    drawState(1);
			else if(nowfocus)     drawState(1);
			else if(focused)      drawState(2);
			else if(Butt_mouseOn) drawState(2);
			else                  drawState(0);
		}
	}

	function finalize()
	{
		super.finalize(...);
	}

	function onClick()
	{
		super.onClick(...);
	}

	function onKeyDown(key, shift)
	{
		if(key == VK_RETURN){
//			window.focusedLayer = null;
			onClickFunction(this);
		}else super.onKeyDown(...);
	}

	function onMouseUp(x, y, button, shift)
	{
		super.onMouseUp(...);

		if(enabled && button == mbLeft){
//			focusNext();
			onClickFunction(this);
		}
	}

	function onMouseDown(x, y, button, shift)
	{
		//super.onMouseDown(...);
		Butt_mouseDown = true;
		update();
	}

	// 右クリックには基本反応しない
	function onHitTest(x, y, process)
	{
		if(process){
			if(System.getKeyState(VK_RBUTTON))super.onHitTest(x, y, false);
			else super.onHitTest(x, y, process);
		}
	}
}


//セーブメニューの栞一つ一つのレイヤー
//背景を入れるわけでなくて当たり判定つくるだけのレイヤー
class SaveLoadItemLayer extends Layer
{
	// 栞一個一個に対応するレイヤ
	var drawLayer;	// 各種描画を行うレイヤー
	var saveloadswitch = global.SaveLoad_object.saveload.state;

	var num; 				// 栞番号
	var maxWidth    = 1069;	// レイヤーのサイズ（幅）
	var maxHeight   = 161;	// レイヤーのサイズ（高さ）
	var baseImage   = "";	// このレイヤーに画像を使う場合、指定がある
	var baseQImage  = "";	// このレイヤーに画像を使う場合の、クイックロード用
	var baseImageH  = "";	// ハイライト画像
	var baseQImageH = "";	// クイックロードのハイライト画像
	var checkPosX   = 149;	// 上書き禁止チェックの場所（X座標）
	var checkPosY   = 23;	// 上書き禁止チェックの場所（Y座標）
	var _noPosX     = 0;	// Noの位置（X座標）
	var _noPosY     = 0;	// Noの位置（Y座標）
	var _timePosX   = 9;	// 日付の位置（X座標）
	var _timePosY   = 20;	// 日付の位置（Y座標）

	var fontFace = "ＭＳ Ｐゴシック,ＭＳ Ｐ明朝";	// フォント
	var fontSize = 15;								// フォントサイズ

	var noIsImage       = false;		// Noは画像かどうか
	var noColor         = 0x000000;		// Noの色
	var noShadowColor   = 0xffffff;		// Noの影の色

	var dateIsImage     = false;		// 日付は画像かどうか
	var dateImageName   = "sl_num_day";	// 日付画像名
	var dateReline      = false;		// 日付の時間のところで改行するか（今は画像のみ対応）
	var dateColor       = 0xffffff;		// 日付の色
	var dateShadowColor = 0x000000;		// 日付の影の色

	var _protectCheckBoxEnabled = true;	// 上書き禁止チェックボックスを有効化するか？
	var protectCheckBox;				// 上書き禁止チェックボックス用レイヤー
	var protectStorage;					// 上書き禁止チェックの画像

	var qDateImageName     = "sl_num_day";	// 日付画像名
	var _q_timePosX        = 100;			// クイックロード用レイヤーの日付の位置(X座標※相対座標)
	var _q_timePosY        = 10;			// クイックロード用レイヤーの日付の位置(Y座標※相対座標)
	var _q_dateColor       = 0xffffff;		// 
	var _q_dateShadowColor = 0x000000;		// 
	var _q_fontSize        = 18;

	var ctrlImage;					// コントロール用レイヤー
	var ctrlImageName = "sl_edit";	// コントロール用ボタン画像
	var ctrlPosX      = 100;		// コントロール用ボタンのx座標
	var ctrlPosY      = 20;			// コントロール用ボタンのy座標

	var _moveBt;			// 移動ボタン
	var _moveBtStorage="sl_edit_移動";	// 移動ボタンファイルネーム(無しで作成されない)
	var _moveBtX = 297;
	var _moveBtY = 11;
	var _copyBt;			// コピーボタン
	var _copyBtStorage="sl_edit_コピー";	// コピーボタンファイルネーム(無しで作成されない)
	var _copyBtX = 321;
	var _copyBtY = 11;
	var _textBt;			// コメント入力ボタン
	var _textBtStorage="sl_edit_コメント編集";	// コメントボタンファイルネーム(無しで作成されない)
	var _textBtX = 345;
	var _textBtY = 11;
	var _deleteBt;			// 削除ボタン
	var _deleteBtStorage="sl_edit_削除";// 削除ボタンファイルネーム(無しで作成されない)
	var _deleteBtX = 369;
	var _deleteBtY = 11;

	var thumbEnabled  = false;	// 個別表示サムネイルを有効化するか
	var thumbQEnabled = false;  // クイックセーブのサムネイルを有効化するか
	var thumbPosX     = 0;
	var thumbPosY     = 0;
	var thumbPosQX    = 0;
	var thumbPosQY    = 0;
	var thumbSizeW    = 120;
	var thumbSizeH    = 68;

	var commentEnabled  = true;	// 個別コメントを描画するか？
	var commentFontSize = 18;
	var commentColor    = 0xffffff;
	var commentX        = 197;
	var commentY        = 40;
	var commentW        = 200;
	var commentH        = 82;

	var loadExclusiveImg = false;	// ロード専用画像ある？
	var autoExclusiveImg = false;	// オート専用画像ある？

	function SaveLoadItemLayer(window, parent, num, viewNum = void)
	{
		super.Layer(window, parent);
		var tmplayer = new global.Layer(window, parent);
		var str;	//日付表示用

		drawLayer = new global.Layer(window, this);
		this.num  = num;

		(saveLoadItem_config incontextof this)();	// 設定を更新

		drawLayer.font.height = fontSize;	// フォントサイズ設定
		drawLayer.font.bold   = false;		// 太字設定
		drawLayer.font.face   = fontFace;	// フォント設定

		if(baseImage != ""){
			if(num==defQuickSaveNum)loadImages(baseQImage);
			else{
				if(parent.owner.owner.isSaveMode){
					loadImages(baseImage);
				}else{
					var ies = Storages.isExistentStorage;
					if(ies(baseImage+"_l.png") || ies(baseImage+"_l.tlg") || ies(baseImage+"_l.jpg")){
						loadExclusiveImg = true;
						loadImages(baseImage+"_l");
					}else if(num >= glAutoSaveNum && (ies(baseImage+"_auto.png") || ies(baseImage+"_auto.tlg") || ies(baseImage+"_auto.jpg"))){
						autoExclusiveImg = true;
						loadImages(baseImage+"_auto");
					}else{
						loadImages(baseImage);
					}
				}
			}
		}else{
			setImageSize(maxWidth, maxHeight);
		}

		setSizeToImageSize();
		drawLayer.setImageSize(width, height);
		drawLayer.setSizeToImageSize();
		drawLayer.face = dfBoth;
		drawLayer.hitType = htMask;
		drawLayer.hitThreshold = 256;
		drawLayer.visible = true;

		hitType = htMask;
		hitThreshold = 0;
		cursor = kag.cursorPointed;
		focusable = true; // フォーカスは受け取れる

		//上書き禁止チェックボックス
		protectCheckBox = new TwoImgCheck(window, drawLayer, %[storage:(protectStorage=="") ? "sl_check" : protectStorage]);
		protectCheckBox.setPos(checkPosX, checkPosY);
		protectCheckBox.visible = true;
		protectCheckBox.check = kag.bookMarkProtectedStates[num];
		// もしクイックロードと同じ番号なら表示しない
		if(num==defQuickSaveNum)protectCheckBox.visible = false;
		// そもそもいらない場合
		protectCheckBox.visible = _protectCheckBoxEnabled;
		// 追加：オートセーブの場合もチェックいらない
//!!!		if(num >= 126){
//!!!			fillRect(137,17,29,20,0xff0c3350);
//!!!			protectCheckBox.visible = false;
//!!!		}

		// 各種コントロールボタン。クイックロードでは作らない
		if(num!=defQuickSaveNum){
			if(_moveBtStorage != ""){
				_moveBt = new ThreeButtonLayer(window, drawLayer, %[func:onDataMove]);
				_moveBt.loadImages(_moveBtStorage);
				_moveBt.setPos(_moveBtX, _moveBtY);
				_moveBt.visible = true;

				_moveBt.hint = "移動";
			}
			if(_copyBtStorage != ""){
				_copyBt = new ThreeButtonLayer(window, drawLayer, %[func:onDataCopy]);
				_copyBt.loadImages(_copyBtStorage);
				_copyBt.setPos(_copyBtX, _copyBtY);
				_copyBt.visible = true;

				_copyBt.hint = "コピー";
			}
			if(_textBtStorage != ""){
				_textBt = new ThreeButtonLayer(window, drawLayer, %[func:onDataEdit]);
				_textBt.loadImages(_textBtStorage);
				_textBt.setPos(_textBtX, _textBtY);
				_textBt.visible = true;

				_textBt.hint = "コメント編集";
			}
			if(_deleteBtStorage != ""){
				_deleteBt = new ThreeButtonLayer(window, drawLayer, %[func:onDataDelete]);
				_deleteBt.loadImages(_deleteBtStorage);
				_deleteBt.setPos(_deleteBtX, _deleteBtY);
				_deleteBt.visible = true;

				_deleteBt.hint = "削除";
			}

			if(ctrlImageName != ""){
				ctrlImage = new ThreeButtonLayer(window, drawLayer, %[func:showControl]);
				ctrlImage.loadImages(ctrlImageName);
				ctrlImage.setPos(ctrlPosX, ctrlPosY);
				ctrlImage.visible = true;
				ctrlImage.org_onMouseEnter = ctrlImage.onMouseEnter;
			}
		}

//============================================================================================
// ※特殊：もしクイックロードと同じ番号なら日付、コントロールを右にずらし、サイズも増やす
		if(num==defQuickSaveNum){
			_timePosX = _q_timePosX;
			_timePosY = _q_timePosY;
			dateColor = _q_dateColor;
			dateShadowColor = _q_dateShadowColor;
			drawLayer.font.height = _q_fontSize;
			ctrlPosX += 116;
//			maxWidth += 116;
			if(ctrlImage !== void)ctrlImage.visible=false;
		}
//============================================================================================

		// データNo
		if(num!=defQuickSaveNum){	// もしクイックロードと同じ番号なら表示しない
			if(noIsImage){
				var chNum;
				if(viewNum !== void){
					chNum = (string)("%03d".sprintf(viewNum+1));
					if(tf.debugFlag){
						drawLayer.font.height = 12;
						drawLayer.drawText(0, 0, "RealNo："+"%03d".sprintf(num+1), 0x000000, 255, false, 2048, 0xffffff, 1, 0, 0);
					}
				}else chNum = (string)("%03d".sprintf(num+1));
				tmplayer.loadImages("sl_num_no");
				var w = tmplayer.imageWidth/10;
				var h = tmplayer.imageHeight;
				for(var i=0; i<chNum.length; i++)drawLayer.operateRect(_noPosX + i*w, _noPosY,tmplayer,((int)chNum[i])*w,0,w,h,omAuto);
			}else{
				drawLayer.drawText(_noPosX, _noPosY, /*"No："+*/"%03d".sprintf(num+1), noColor, 255, true, 200, noShadowColor, 1, 3, 2);
			}
		}

		//日付を表示
		if(kag.bookMarkDates[num] == '')	str = "----/--/-- --:--";
		else								str = kag.bookMarkDates[num];

		// 日付
		if(dateIsImage){
			var w;
			var h;
			var relineFlag = false;

			if( num == defQuickSaveNum )
			{
				tmplayer.loadImages(qDateImageName);
				w = tmplayer.imageWidth/13;
			}
			else
			{
				tmplayer.loadImages(dateImageName);
				w = tmplayer.imageWidth/13;
			}

			h = tmplayer.imageHeight;

			for(var i=0; i<str.length; i++){
				var index;
				if(str.charAt(i)=="/")		index = 10;
				else if(str.charAt(i)==":")	index = 11;
				else if(str.charAt(i)=="-")	index = 12;
				else						index = (int)str.charAt(i);

				if(str.charAt(i)!=" "){
					if(dateReline && relineFlag)	drawLayer.operateRect(_timePosX + (i-8)*(w), _timePosY+h+5,tmplayer,index*w,0,w,h,omAuto);
					else							drawLayer.operateRect(_timePosX + i*(w), _timePosY,tmplayer,index*w,0,w,h,omAuto);
				}else{
					if(dateReline)	relineFlag = true;
				}
			}
		}else{
			//++++++++このレイヤーでの日付の位置。
			drawLayer.drawText(_timePosX, _timePosY, str, dateColor, 255, true, 200, dateShadowColor, 1, 3, 2);
		}

		// サムネ
		if(thumbEnabled && kag.bookMarkDates[num] != ''){
			var tnname = Storages.chopStorageExt(kag.getBookMarkFileNameAtNum(num)) + ".jpg";
			var ies = Storages.isExistentStorage;

			if(ies(tnname)){
				var maskName = "sl_mask_panel";
				tmplayer.loadImages(tnname);

				if(num==defQuickSaveNum){
					if( thumbQEnabled ) drawLayer.stretchCopy(thumbPosQX, thumbPosQY, thumbSizeW, thumbSizeH, tmplayer, 0,0,tmplayer.imageWidth,tmplayer.imageHeight,stFastLinear);
				}else{
					drawLayer.stretchCopy(thumbPosX, thumbPosY, thumbSizeW, thumbSizeH, tmplayer, 0,0,tmplayer.imageWidth,tmplayer.imageHeight,stFastLinear);
				}

				// マスクデータがあれば適用
				if(ies(maskName+".png") || ies(maskName+".tlg") || ies(maskName+".jpg")){
					var mask = new global.Layer(window, this);
					mask.loadImages(maskName);

					drawLayer.face = dfMask;
					drawLayer.copyRect(thumbPosX, thumbPosY, mask, 0, 0, mask.imageWidth, mask.imageHeight);
					drawLayer.face = dfAlpha;

					invalidate mask;
				}
			}
		}

		// コメント描画
		if(commentEnabled){
			var comment = "";

			if(kag.scflags.bookMarkComments !== void)	comment = kag.scflags.bookMarkComments[num];

			if(comment != "" && comment != void){
				var xpos = commentX;
				var ypos = commentY;

				drawLayer.font.height = commentFontSize;
				//var ar = comment.split(/￥ｎ/,,false);
				//for(var i=0; i<ar.count; i++){
				//	drawLayer.drawText(commentX,commentY+(fontSize+4)*i,ar[i],commentColor,255,true);
				//}

				for(var i=0; i<comment.length; i++){
					var ch = comment[i];
					var w = drawLayer.font.getTextWidth(ch);

					if(xpos+w > commentX+commentW){
						xpos = commentX;
						ypos += commentFontSize;
						if(ypos >= commentY+commentH)	break;	// 最大値をこえたら描画しない
					}
					drawLayer.drawText(xpos,ypos,ch,commentColor,255,true);
					xpos += w;
				}
			}
		}

		// チャプター名表示
		if(kag.scflags.bookMarkTitles !== void){
			var title = kag.scflags.bookMarkTitles[num];
			if(title !== void && title != ""){
				drawLayer.drawText(35, 63, title, dateColor, 255, true);
			}
		}

		// Cation用キャラクタールート表示
		/*
		if(kag.scflags.bookMarkChr !== void){
			var name = kag.scflags.bookMarkChr[num];
			if(name !== void && name != ""){
				tmplayer.loadImages("map_iconm_" + name);
				drawLayer.operateRect((num==defQuickSaveNum) ? 0 : 0, (num==defQuickSaveNum) ? 48 : 48, tmplayer, 0, 0, tmplayer.imageWidth, tmplayer.imageHeight, omAlpha, 255);
			}
		}
		*/

		if( kag.scflags.bookMarkChr !== void ) setInfoRoute( window, parent, kag.scflags.bookMarkChr[num] );	//	セーブ情報に突入ルートの情報を描画する

		invalidate tmplayer;
	}

	function finalize()
	{
		invalidate _moveBt if _moveBt !== void;
		invalidate _copyBt if _copyBt !== void;
		invalidate _textBt if _textBt !== void;
		invalidate _deleteBt if _deleteBt !== void;
		invalidate ctrlImage if ctrlImage !== void;
		invalidate protectCheckBox if protectCheckBox !== void;
		invalidate drawLayer if drawLayer !== void;
		super.finalize(...);
	}


	//	セーブ情報に突入ルートの情報を描画する
	function setInfoRoute( aWindow, aParent, aRoute )
	{
		if( aRoute === void || aRoute == "" ) return;

		var _route         = "sl_icon_" + aRoute;
		var _ies           = Storages.isExistentStorage;
		var _templayer     = new global.Layer( aWindow, aParent );
		var _infoRoutePosX = 76;
		var _infoRoutePosY = 0;

		if( _ies( _route+".png" ) || _ies( _route+".tlg" ) || _ies( _route+".jpg" ) )
		{
			_templayer.loadImages( _route );
			drawLayer.operateRect( _infoRoutePosX, _infoRoutePosY, _templayer, 0, 0, _templayer.imageWidth, _templayer.imageHeight, omAuto );
		}

		invalidate _templayer;
	}


	function onDataMove(){ if(kag.bookMarkDates[num] != ''){parent.owner.srcData = num; parent.owner.operationMove();} }
	function onDataCopy(){ if(kag.bookMarkDates[num] != ''){parent.owner.srcData = num; parent.owner.operationCopy();} }
	function onDataEdit(){ if(kag.bookMarkDates[num] != ''){parent.owner.srcData = num; parent.owner.operationEdit();} }
	function onDataDelete(){
		if(kag.bookMarkDates[num] != ''){
			parent.owner.srcData = num;
			//parent.operationDelete();
			// このセーブデータパネルはこの後消えてしまうので、この関数を抜けたら
			// 削除されるようにトリガをセット
			if(typeof parent.owner.opDeleteTrigger != "undefined" && parent.owner.opDeleteTrigger !== void){
				//dm("前回のトリガ削除");
				invalidate parent.owner.opDeleteTrigger;
			}
			parent.owner.opDeleteTrigger = new AsyncTrigger(parent.owner.operationDelete, '');
			parent.owner.opDeleteTrigger.cached = true;
			parent.owner.opDeleteTrigger.trigger();
		}
	}

	function saveToSystemVariable()
	{
		// 状態をシステム変数に記録する
		if(kag.scflags.bookMarkComments === void)
			kag.scflags.bookMarkComments = [];
//!!		if(commentUse)kag.scflags.bookMarkComments[num] = commentEdit.text;
		kag.bookMarkProtectedStates[num] = protectCheckBox.checked;
	}

	function onFocus()
	{
		super.onFocus(...);
		if(num==defQuickSaveNum){
			if(baseQImageH != "")loadImages(baseQImageH);
		}else{
			if(baseImageH != ""){
				if(loadExclusiveImg && !parent.owner.owner.isSaveMode){
					loadImages(baseImageH+"_l");
				}else if(autoExclusiveImg){
					loadImages(baseImageH+"_auto");
				}else{
					loadImages(baseImageH);
				}
			}
		}
		parent.owner.setInfo(num, this);
	}

	function onBlur()
	{
		// フォーカスを失った
		super.onBlur(...);
		if(num==defQuickSaveNum){
			if(baseQImage != "")loadImages(baseQImage);
		}else{
			if(baseImage != ""){
				if(loadExclusiveImg && !parent.owner.owner.isSaveMode){
					loadImages(baseImage+"_l");
				}else if(autoExclusiveImg){
					loadImages(baseImage+"_auto");
				}else{
					loadImages(baseImage);
				}
			}
		}
		//parent.reSetInfo();
	}

	function onMouseEnter()
	{
//!!		if(!commentUse || (commentUse && !commentEdit.focused))
		focus(true);
	}

	function onMouseLeave()
	{
//!!		if(!commentUse || (commentUse && !commentEdit.focused))
		focus(false);
	}

	function showControl()
	{
		// コントロールメニューを呼び出し
		// クイックロードでも呼び出せるように変更
		//if(kag.bookMarkDates[num] != '' && num!=defQuickSaveNum)
		if(kag.bookMarkDates[num] != ''){
			if(ctrlImage !== void){
				// コントロールメニューが画像モードなら下に出す
				if(parent.owner.ctrlPanel.isButton){
					parent.owner.callPanel(left+ctrlImage.left, top+ctrlImage.top, ctrlImage.height, num);
				}else{
					parent.owner.callPanel(left+ctrlImage.left+ctrlImage.width\2, top+ctrlImage.top, ctrlImage.height\2, num);
				}
			}
		}
	}

	function onHitTest(x, y, process)
	{
		if(process)
		{
			// 右ボタンが押されていたときにイベントを透過
			if(System.getKeyState(VK_RBUTTON)){
				super.onHitTest(x, y, false);
			}else
				super.onHitTest(x, y, true);
		}
	}

	function onKeyDown(key, shift)
	{
		// キーが押された
		if(key == VK_RETURN || key == VK_SPACE)
		{
			// スペースキーまたはエンターキー
			super.onKeyDown(key, shift,false);
			saveToSystemVariable();
			parent.owner.onLoadOrSave(num, this);
		}else super.onKeyDown(...);
	}

	function onMouseDown(x, y, button, shift)
	{
		super.onMouseDown(...);
		if(button == mbLeft)
		{
			focus();
			saveToSystemVariable();
			parent.owner.onLoadOrSave(num, this);
		}
	}
}


// 栞一個一個に対応するレイヤ
class SaveLoadItemButton extends ButtonLayer
{
	var num; 				// 栞番号
	var maxWidth  = 1069;	// レイヤーのサイズ（幅）
	var maxHeight = 161;	// レイヤーのサイズ（高さ）
	var checkPosX = 149;	// 上書き禁止チェックの場所（X座標）
	var checkPosY = 23;		// 上書き禁止チェックの場所（Y座標）
	var _noPosX   = 0;		// Noの位置（X座標）
	var _noPosY   = 0;		// Noの位置（Y座標）
	var _timePosX = 9;		// 日付の位置（X座標）
	var _timePosY = 20;		// 日付の位置（Y座標）

	var fontFace = "ＭＳ Ｐゴシック,ＭＳ Ｐ明朝";	// フォント
	var fontSize = 15;								// フォントサイズ

	var noIsImage       = false;	// Noは画像かどうか
	var noColor         = 0x000000;	// Noの色
	var noShadowColor   = 0xffffff;	// Noの影の色

	var dateIsImage     = false;	// 日付は画像かどうか
	var dateColor       = 0xffffff;	// 日付の色
	var dateShadowColor = 0x000000;	// 日付の影の色

	var _protectCheckBoxEnabled = true;	// 上書き禁止チェックボックスを有効化するか？
	var protectCheckBox;				// 上書き禁止チェックボックス用レイヤー

	var ctrlImage;					// コントロール用レイヤー
	var ctrlImageName = "sl_edit";	// コントロール用ボタン画像
	var ctrlPosX      = 100;		// コントロール用ボタンのx座標
	var ctrlPosY      = 20;			// コントロール用ボタンのy座標


	function SaveLoadItemButton(window, parent, num)
	{
		super.ButtonLayer(window, parent);
		this.num = num;

		// メンバが全部いないと動かない
		//(saveLoadItem_config incontextof this)();	// 設定を更新

		cursor = kag.cursorPointed;
		focusable = true; // フォーカスは受け取れる

		loadImages("sl_quickload");
		//loadImages(SaveLoad_object.saveload.state ? "sl_l_quickload" : "sl_s_quickload");
	}

	function finalize()
	{
		super.finalize(...);
	}

	function saveToSystemVariable(){}

	function onFocus()
	{
		super.onFocus(...);
		parent.setInfo(num, this);
	}

	function onBlur()
	{
		// フォーカスを失った
		super.onBlur(...);
		//parent.reSetInfo();
	}

	function onMouseEnter()
	{
		focus(true);
		super.onMouseEnter(...);
	}

	function onMouseLeave()
	{
		focus(false);
		super.onMouseLeave();
	}

	function onHitTest(x, y, process)
	{
		if(process)
		{
			// 右ボタンが押されていたときにイベントを透過
			if(System.getKeyState(VK_RBUTTON)){
				super.onHitTest(x, y, false);
			}else
				super.onHitTest(x, y, true);
		}
	}

	function onKeyDown(key, shift)
	{
		// キーが押された
		if(key == VK_RETURN || key == VK_SPACE)
		{
			// スペースキーまたはエンターキー
			super.onKeyDown(key, shift,false);
			parent.onLoadOrSave(num, this);
		}else super.onKeyDown(...);
	}

	function onMouseDown(x, y, button, shift)
	{
		super.onMouseDown(...);
		if(button == mbLeft)
		{
			focus();
			parent.onLoadOrSave(num, this);
		}
	}
}


//セーブ、ロードを作るレイヤー。全員の親
class SaveLoadLayer extends fadeLayer // セーブとロードの画面レイヤー
{
	var _mainBgColor = 0x803761a8;	// すべての親(背景画像よりさらに後ろ)の色設定

	var saveDataItems;
	var saveDataItemsSizeW = 1280;//1192; // セーブ＆ロードアイコン全画面表示用、横幅
	var saveDataItemsSizeH = 720;//660;   // セーブ＆ロードアイコン全画面表示用、縦幅

	var saveDataScroll    = false;	// セーブデータのスクロール切り替えを行えるか
	var scrollBarEnabled  = false;	// スクロールバーを有効化するか
	var scrollBar;					// 
	var scrollBarPosX     = 1250;	// 
	var scrollBarPosY     = 20;		// 
	var scrollBarBgPosX   = 1225;	// スクロールバーの背景x座標
	var scrollBarBgPosY   = 24;		// スクロールバーの背景y座標
	var scrollBarSizeH    = 500;	// 
	var scrollClipPosX    = 0;		// 基本的には「0」スタート「scrollClipMarginW」で初期位置調整
	var scrollClipPosY    = 20;		// 
	var scrollClipSizeW   = 1280;	// 基本的には画面横幅いっぱい
	var scrollClipSizeH   = 500;	// 
	var scrollClipMarginW = 27;		// 基本的には「saveload_setting.tjs」にある「_item_x」と同じ値
	var scrollClipMarginH = 10;		// 
	var scrollBarTop      = "";     // スクロールバーの画像。なしでデフォルト
	var scrollBarCenter   = "";     // スクロールバーの画像。なしでデフォルト
	var scrollBarUnder    = "";     // スクロールバーの画像。なしでデフォルト

	var scrollModeImgMulti = "sl_line_multi";		// スクロールモードに切り替えるボタンの画像名
	var scrollModeImgSingle = "sl_line_single";
	var scrollModeButtonX = 723;		// スクロールモードに切り替えるボタンの座標
	var scrollModeButtonY = 648;

	var state;				// 0：セーブ  1：ロード
	var owner;				// SaveLoadPlugin オブジェクトへの参照
	var currentPage = 0;	// セーブデータ選択中に表示中のページ
	var buttons;			// ボタン類全て

	var _item_x        = 73;	// セーブデータの1つ目のX
	var _item_y        = 657;	// セーブデータの1つ目のY
	var _item_xinc     = 178;	// 同じ行の次のセーブデータまでの幅
	var _item_yinc     = 165;	// 同じ列の次のセーブデータまでの高さ
	var _item_line_cnt = 3;		// 一行に含めるセーブデータの量
	var _item_max      = 9;		// 1ページにおける最大数

	var _btn_x            = 19;	// ページボタンの1つ目のX
	var _btn_y            = 9;	// ページボタンの1つ目のY
	var _btn_xinc         = 34;	// 同じ行の次のページボタンまでの幅
	var _btn_yinc         = 0;	// 同じ列の次のページボタンまでの高さ
	var _btn_line_cnt     = 10;	// 一行に含めるページボタンの量
	var _btn_max          = 14;	// 1ページにおける最大数
	var _btn_hitThreshold = 0;	// ボタンのあたり判定閾値

	var _btnScroll = true;		// ページボタンスクロールを有効化するか
	var _btnPrev_x = 36;		// ページボタン戻るx
	var _btnPrev_y = 659;		// ページボタン戻るy
	var _btnNext_x = 551;		// ページボタン進むx
	var _btnNext_y = 659;		// ページボタン進むy

	var pageBtNext;		// ページボタンが複数ページある場合の進むボタン
	var pageBtPrev;
	var pageButtonCurrent = 0;	// ページボタンの現在ページ

	var _tabFileNames  = ["", "愛子", "雪", "乃々"];	// ルートごとのタブ及び背景のファイル名の追加文字列
	var _tab_x         = 350;
	var _tab_y         = 45;
	var _tab_xDiff     = 174;
	var _tab_yDiff     = 0;
	var _tabItemsBt = [];
	var _currentTab;

	var _openSFBtName = "sl_opensavefolder";	// セーブフォルダを開くボタン画像
	var _openX          = 747;					// セーブフォルダを開くx
	var _openY          = 660;					// セーブフォルダを開くy
	
	var _backTitleBtName = "sl_title";	// タイトルに戻るボタン画像
	var _titleX          = 1018;		// タイトルへ戻るボタンのx
	var _titleY          = 648;			// タイトルへ戻るボタンのy

	var _exitBtName      = "sl_exit";	// 終了ボタン画像
	var _exitX           = 1136;		// ゲーム終了ボタンのx
	var _exitY           = 648;			// ゲーム終了ボタンのy

	var _backBtName      = "sl_back";	// 戻るボタン画像
	var _backX           = 900;			// ゲームに戻るボタンのx
	var _backY           = 648;			// ゲームに戻るボタンのy

	var _goSaveBtName    = "sl_save";	// セーブ画面に変更ボタン画像
	var _goLoadBtName    = "sl_load";	// ロード画面に変更ボタン画像
	var _slX             = 782;			// セーブ・ロード画面に変更ボタンx
	var _slY             = 648;			// セーブ・ロード画面に変更ボタンy

	var _qloadEnabled    = true;		// クイックロード領域を表示するか
	var _qloadX          = 656;			// クイックロード領域の場所x
	var _qloadY          = 651;			// クイックロード領域の場所y
	var _qloadIsButton   = false;		// クイックロードがただのボタンだった場合有効化

	var _autoBtEnabled   = true;		// オートページを有効にするか
	var _autoBtName      = "sl_auto";	// オートページボタン画像
	var _autoBtnX        = 585;			// オートページボタンのx座標
	var _autoBtnY        = 651;			// オートページボタンのy座標

	var ctrlPanel;			// 右クリックメニュー
	var srcData        = 0;	// 現在の操作対象のセーブデータ
	var operationState = 0;	// 現在の操作状態「0:通常」「1:コピー」「2:移動」「3:削除」
	var shadowLayer;
	var shadowTimer;

	var thumbsLayer;
	var infoThumbEnabled = 0;	// 選択中サムネイルを使用するか
	var thumbPosX        = 647;	// サムネイルのx座標
	var thumbPosY        = 78;	// サムネイルのy座標

	var newestLayer;			// 最新画像表示用用レイヤー
	var newIsAnimation = false;	// new画像はアニメーションかどうか
	var newAnimWidth   = 40;	// new画像がアニメーションの場合の幅
	var newAnimHeight  = 19;	// new画像がアニメーションの場合の高さ
	var newPosX        = 27;	// 最新画像位置（X座標）
	var newPosY        = 541;	// 最新画像位置（Y座標）

	var infoLayer;
	var commentLayer;

	var _infoLayEnabled     = 0;				// 情報レイヤーを有効化するか
	var _infoLayX           = 0;				// 情報レイヤーの設定場所
	var _infoLayY           = 0;				// 情報レイヤーの設定場所
	var _infoLayWidth       = 400;				// 情報レイヤーの幅
	var _infoLayHeight      = 300;				// 情報レイヤーの高さ
	var _infoLayerFillColor = 0x0;				// 情報レイヤーの塗りつぶし色

	var _infoLayFontFace    = "ＭＳ ゴシック";	// 情報レイヤーのフォント
	var _infoLayFontSize    = 15;				// 情報レイヤーのフォントサイズ
	var _infoLayFontColor   = 0xffffff;			// 情報レイヤーのフォントカラー

	var _infoTitlePosX      = 5;				// 情報レイヤー上でのタイトル表示の座標
	var _infoTitlePosY      = 5;				// 情報レイヤー上でのタイトル表示の座標

	var _infoDateStorage    = "";				// 情報レイヤー上で使用する画像名（空白で画像を使わない）
	var _infoDateSplitCount = 13;				// 画像の分割数
	var _infoDateFontColor  = 0x000000;			// 情報レイヤー上での時刻表示の色
	var _infoDatePosX       = 5;				// 情報レイヤー上での時刻表示の座標
	var _infoDatePosY       = 20;				// 情報レイヤー上での時刻表示の座標

	var _infoNoEnabled      = false;			// 情報レイヤー上でNoを表示するか
	var _infoNoStorage      = "";				// 情報レイヤー上でNoは画像で描画するか
	var _infoNoPosX         = 0;				// 情報レイヤー上でのNoのx座標
	var _infoNoPosY         = 0;				// 情報レイヤー上でのNoのy座標
	var _infoNoColor        = 0xffffff;			// 情報レイヤー上でのNoの色

	var _infoCommentPosX    = 5;				// 情報レイヤー上でのコメント表示の座標
	var _infoCommentPosY    = 35;				// 情報レイヤー上でのコメント表示の座標
	var _infoLayLineSpacing = 2;				// 情報レイヤーコメントの行間
	var _infoCommentWidth   = 700;				// コメントの最大表示幅

	var _infoChapter        = "";				// 情報レイヤー上でのチャプター名
	var _infoChapterPosX    = 5;				// 情報レイヤー上でのチャプター名表示のx座標
	var _infoChapterPosY    = 315;				// 情報レイヤー上でのチャプター名表示のy座標

	var commentEdit;
	var decisionButton;

	var _editPosX             = 770;			// エディットボックスを出現させるx座標
	var _editPosY             = 511;			// エディットボックスを出現させるy座標
	var _editWidth            = 447;			// エディットボックス幅
	var _editHeight           = 23;				// エディットボックス高さ
	var _editFontSize         = 20;				// エディットボックスフォントサイズ
	var _editLines            = 6;				// エディットボックスの編集時の行数
	var _editFontColor        = 0x000000;		// エディットボックスのフォントカラー
	var _editSetUnderSaveData = 0;				// エディットボックスを座標無視してセーブデータの下に設置するか
	var _editDecisionBtDiffX  = 0;				// エディットボックスの決定ボタンをエディットボックスの右端よりどれだけずらした位置に置くか
	var _editDecisionBtDiffY  = -2;				// エディットボックスの決定ボタンをエディットボックスの上端よりどれだけずらした位置に置くか

	var bigThumbNail     = false;	// 全画面サムネイルの場合
	var thumbType        = true;	// サムネイルタイプ：true/jpgで保存 false/セーブから状態を再現
	var ctrlPanelReverse = false;	// コンパネのメニューを上向きに出す場合
	var ctrlPanelDirDef  = false;	// コンパネのメニューを出すデフォルト向き（true：上 false：下）
	var ctrlPanelDiffX   = 0;		// コンパネのx座標をずらす場合の数値
	
	var bgLayerLeft = 0;		// 背景レイヤーの位置
	var bgLayerTop = 0;
	var bgLayerScrollLeft = 0;	// 背景レイヤーの位置(スクロールモード時)
	var bgLayerScrollTop = 0;

	var bgLayer;			// 最背面に配置する何か
	var bgLayer2;			// 最背面2に配置する何か
	var bgLayer2img = "sl_scrollbar_bg";	// 最背面2に使用する画像名。なしでデフォルト
	var pageNoLayer;		// ページ番号表示用レイヤー

	var saveBgStorage     = "sl_sbg";	// セーブの背景
	var loadBgStorage     = "sl_lbg";	// ロードの背景
	var saveScrollBgStorage = "sl_sbg";	// セーブの背景(スクロールモード)
	var loadScrollBgStorage = "sl_lbg";	// ロードの背景(スクロールモード)
	var saveButtonStorage = "sl_bt";	// セーブのページボタンの画像名の頭
	var loadButtonStorage = "sl_bt";	// ロードのページボタンの画像名の頭

	var addBgImages = [];		// 追加の背景画像
	var addLayers = [];			// 追加背景のレイヤー

	// 特殊処理
//	var bgPageLayer;	// 今何ページかを表わす画像


	function SaveLoadLayer(win, par, owner)
	{
		super.fadeLayer(win, par);
		this.owner = owner;

		(saveLoadMain_config incontextof this)();	// 設定を更新

		// セーブロードパネル表示レイヤー設定
		saveDataItems = new InvisibleLayer(win, this);
		saveDataItems.owner = this;
		saveDataItems.setSize(kag.scWidth, kag.scHeight);

		// 背景設定
		bgLayer              = new global.Layer(win, this);
		bgLayer.hitType      = htMask;
		bgLayer.hitThreshold = 256;
		bgLayer.focusable    = false;
		bgLayer.absolute     = 9;
		bgLayer.visible      = true;

		// 追加背景
		for(var i=0; i<addBgImages.count; i++){
			var index = addLayers.add(new global.Layer(win, this));
			with(addLayers[index]){
				.loadImages(addBgImages[i][0]);
				.setSizeToImageSize();
				.setPos(addBgImages[i][1], addBgImages[i][2]);
				.hitType = htMask;
				.hitThreshold = 256;
				.enabled = false;
				.absolute = 3 + i;
				.visible = true;
			}
		}

		// スクロールモードのスクロールバーの背景
		bgLayer2              = new global.Layer(win, this);
		bgLayer2.hitType      = htMask;
		bgLayer2.hitThreshold = 256;
		bgLayer2.focusable    = false;
		bgLayer2.absolute     = 10;
		bgLayer2.visible      = false;

		if( bgLayer2img !== void && bgLayer2img !== "" ){
			bgLayer2.loadImages( bgLayer2img );
			bgLayer2.setSizeToImageSize();
			bgLayer2.setPos( scrollBarBgPosX, scrollBarBgPosY );
		}
		else{
			bgLayer2.setSize( kag.scWidth, kag.scHeight );
		}

		// レイヤの状態を初期化
		setPos(0, 0);
		type = ltAlpha;
		face = dfAlpha;
		setImageSize(kag.scWidth, kag.scHeight);
		setSizeToImageSize();
		fillRect(0,0,width,height,_mainBgColor);
		hitType      = htMask;
		hitThreshold = 0; //全域不透過(当たり判定ばりばり)
		focusable    =false;
		visible      =false;

		// 右クリックメニューを準備
		ctrlPanel                = new SaveDataControlPanel(window, saveDataItems);
		shadowLayer              = new global.Layer(window, this);
		shadowLayer.hitType      = htMask;
		shadowLayer.hitThreshold = 256;
		shadowTimer              = new Timer(onTimer, "");

		commentLayer = new global.Layer(window, this);
		commentLayer.setImageSize(kag.scWidth, kag.scHeight);
		commentLayer.setSizeToImageSize();
		commentLayer.type         = ltAlpha;
		commentLayer.face         = dfAlpha;
		commentLayer.hitType      = htMask;
		commentLayer.hitThreshold = 0;
		commentLayer.visible      = false;
		commentLayer.onMouseDown  = function(x, y, button, shift){
			if(button == mbRight){
				parent.commentDecision();
				visible = false;
			}
		}incontextof commentLayer;

		//commentEdit = new CustomEditLayer(window, commentLayer);
		commentEdit = new MultiEditLayer(window, commentLayer, _editLines);
		commentEdit.setPos(_editPosX, _editPosY);
		commentEdit.width = _editWidth;
		commentEdit.height = _editHeight;
//		commentEdit.color = 0xffffff;
//		commentEdit.opacity = 255;
//		commentEdit.textColor = 0x000000;
//		commentEdit.Edit_antialiased = true;
//		commentEdit.Edit_opacity = 255;
//		commentEdit.font.height = _editFontSize;
		commentEdit.textColor = _editFontColor;
		commentEdit.fontSize = _editFontSize;
		commentEdit.visible = true;
/*		commentEdit.onKeyDown = function(key, shift){
			if(key == VK_RETURN || key == VK_ESCAPE){
				parent.parent.commentDecision();
				parent.visible = false;
			}else global.CustomEditLayer.onKeyDown(...);
		}incontextof commentEdit;
*/
		try{
			var tar = commentEdit.editLayer;
			for(var i=0; i<tar.count; i++){
				tar[i].font.face = "sl_vlg";
				tar[i].font.height = 20;
				tar[i].font.mapPrerenderedFont("vlg20.tft");
			}
		}catch(e){
			dm("セーブロードのエディットボックスのフォントの割り当て失敗"+e.message);
		}
		decisionButton = new ThreeButtonLayer(window, commentLayer);
		decisionButton.pressFunction = function(){parent.parent.commentDecision(), parent.visible = false;};
		decisionButton.quadruple = true;
		decisionButton.loadImages("sl_decision");
		//decisionButton.setPos(commentEdit.left+commentEdit.width-decisionButton.width, commentEdit.top+commentEdit.height);
		decisionButton.setPos(commentEdit.left+commentEdit.width+_editDecisionBtDiffX, commentEdit.top+_editDecisionBtDiffY);
		decisionButton.visible = true;

		if(_infoLayEnabled){
			infoLayer = new global.infoLayer(window, this, %[x:_infoLayX, y:_infoLayY, w:_infoLayWidth, h:_infoLayHeight, face:_infoLayFontFace, size:_infoLayFontSize]);
			try{
				infoLayer.font.face = "sl_vlg";
				infoLayer.font.height = 20;
				infoLayer.font.mapPrerenderedFont("vlg20.tft");
			}catch(e){
				dm("セーブロードのフォントの割り当て失敗"+e.message);
			}
			infoLayer.visible = true;
		}

		// 全画面サムネイルの場合の設定
		if(infoThumbEnabled){
			if(bigThumbNail){
				thumbsLayer = new global.infoLayer(window, this, %[x:thumbPosX, y:thumbPosY, w:kag.thumbnailWidth, h:((int)(kag.thumbnailWidth * (kag.scHeight / kag.scWidth)))]);
				thumbsLayer.absolute = 1;
			}else thumbsLayer = new global.infoLayer(window, this, %[x:thumbPosX, y:thumbPosY, w:kag.thumbnailWidth, h:((int)(kag.thumbnailWidth * (kag.scHeight / kag.scWidth)))]);
		}

		if(newIsAnimation){
			newestLayer = new CharacterLayer(window, saveDataItems);
			newestLayer.loadImages(%[storage:"sl_new",clipleft:0,cliptop:0,clipwidth:newAnimWidth,clipheight:newAnimHeight]);
		}else{
			//newestLayer = new global.Layer(window, this);
			newestLayer = new BrightLayer(window, saveDataItems);
			//newestLayer = new FloatLayer(window, this);
			newestLayer.loadImages("sl_new");
			newestLayer.setSizeToImageSize();
		}
		newestLayer.visible=false;

		// 特殊
//		bgPageLayer = new global.Layer(window, this);
	}

	function finalize()
	{
		clear();
		clearTabButtons();
		invalidate pageBtPrev    if pageBtPrev    !== void;
		invalidate pageBtNext    if pageBtNext    !== void;
//		invalidate bgPageLayer; // 特殊
		invalidate bgLayer       if bgLayer       !== void;
		invalidate bgLayer2      if bgLayer2      !== void;
		for(var i=0; i<addLayers.count; i++)invalidate addLayers[i] if addLayers[i] !== void;
		invalidate newestLayer   if newestLayer   !== void;
		invalidate pageNoLayer   if pageNoLayer   !== void;
		invalidate saveDataItems if saveDataItems !== void;
		invalidate scrollBar     if scrollBar     !== void;

		if(commentEdit    != void && isvalid commentEdit)    invalidate commentEdit;
		if(decisionButton != void && isvalid decisionButton) invalidate decisionButton;
		if(commentLayer   != void && isvalid commentLayer)   invalidate commentLayer;
		if(infoLayer      != void && isvalid infoLayer)      invalidate infoLayer;
		if(thumbsLayer    != void && isvalid thumbsLayer)    invalidate thumbsLayer;
		if(ctrlPanel      != void && isvalid ctrlPanel)      invalidate ctrlPanel;
		if(shadowLayer    != void && isvalid shadowLayer)    invalidate shadowLayer;
		if(shadowTimer    != void && isvalid shadowTimer)    invalidate shadowTimer;

		super.finalize(...);
	}

	function setInfo(num=0, obj=void, cv=true)
	{
		var date    = "";
		var title   = "";
		var comment = "";

		if(obj === void){
			obj = saveDataItems.buttons[num%_item_max];
		}

		if(kag.scflags.bookMarkDates[num] != ""){
			date = kag.bookMarkDates[num];
			if(kag.scflags.bookMarkTitles   !== void) title   = kag.scflags.bookMarkTitles[num];
			if(kag.scflags.bookMarkComments !== void) comment = kag.scflags.bookMarkComments[num];
		}else date = "----/--/-- --:--";

		//if(title == "")title = "no title...";
		if(title == "")title = "　";

		if(_infoLayEnabled){
			with(infoLayer){
				.pclear();
				.fillRect(0,0,.width,.height,_infoLayerFillColor);

				if(num!=defQuickSaveNum && _infoNoEnabled) setInfoNo();                // ＮＯも画像で描画する
				if(date != "")                             setInfoDate( date );        // 日付の描画
//				if(title != "　")	                       setInfoChapter( title );    // チャプターの描画
				if(cv && num != defQuickSaveNum)           setInfoComment( comment );  // コメントの描画
				setInfoCation( num );  // ケーション用の追加描画
			}
		}


		// サムネイル表示
		if(kag.bookMarkDates[num] != ''){	// 日付が存在しないデータは存在しないことに
			var tnname = Storages.chopStorageExt(kag.getBookMarkFileNameAtNum(num)) + ".jpg";

			if(infoThumbEnabled){
				if(bigThumbNail){
					if(thumbType){
						if(Storages.isExistentStorage(tnname)){
							thumbsLayer.loadImages(tnname);
							thumbsLayer.setSizeToImageSize();
							thumbsLayer.setPos(0,0);
							thumbsLayer.visible = true;
						}
					}else{
						global.makethumbs_object.make(num);
					}
				}else{
					if(Storages.isExistentStorage(tnname)){
						var ies      = Storages.isExistentStorage;
						var maskName = "sl_mask_prev";

						thumbsLayer.loadImages(tnname);
						thumbsLayer.setSizeToImageSize();
						thumbsLayer.visible = true;

						// マスクデータがあれば適用
						if(ies(maskName+".png") || ies(maskName+".tlg") || ies(maskName+".jpg")){
							var mask = new global.Layer(window, this);
							mask.loadImages(maskName);

							thumbsLayer.face = dfMask;
							thumbsLayer.copyRect(0, 0, mask, 0, 0, mask.imageWidth, mask.imageHeight);
							thumbsLayer.face = dfAlpha;
							invalidate mask;
						}
					}
				}
			}
		}else reSetInfo();
	}


	// セーブ情報にナンバーを描画する
	function setInfoNo()
	{
		with( infoLayer )
		{
			if(_infoNoStorage != ""){
				var tmplayer = new global.Layer(window, parent);
				var chNum = (string)("%03d".sprintf(num+1));
				tmplayer.loadImages(_infoNoStorage);
				var w = tmplayer.imageWidth/10;
				var h = tmplayer.imageHeight;
				for(var i=0; i<chNum.length; i++).operateRect(_infoNoPosX + i*w, _infoNoPosY,tmplayer,((int)chNum[i])*w,0,w,h,omAuto);
				invalidate tmplayer;
			}else{
				//.drawText(_infoNoPosX, _infoNoPosY, /*"No："+*/"%03d".sprintf(num+1), noColor, 255, true, 200, noShadowColor, 1, 3, 2);
				.drawText(_infoNoPosX, _infoNoPosY, /*"No："+*/"%03d".sprintf(num+1), _infoNoColor, 255, true, 0);
			}
		}
	}


	// セーブ情報に日付を描画する
	function setInfoDate( aDate )
	{
		with( infoLayer )
		{
			var _tempInfoPosX = _infoDatePosX + bgLayer.left;
			var _tempInfoPosY = _infoDatePosY + bgLayer.top;

			if(_infoDateStorage != ""){
				var tmplayer = new global.Layer(window, this);
				tmplayer.loadImages(_infoDateStorage);
				var w = tmplayer.imageWidth/_infoDateSplitCount;
				var h = tmplayer.imageHeight;

				for(var i=0; i<aDate.length; i++){
					var index;
					if     (aDate.charAt(i)=="/") index = 10;
					else if(aDate.charAt(i)==":") index = 11;
					else if(aDate.charAt(i)=="-") index = 12;
					else if(aDate.charAt(i)==" ") continue;
					else                          index = (int)aDate.charAt(i);
					.operateRect(_tempInfoPosX + i*w, _tempInfoPosY,tmplayer,index*w,0,w,h,omAuto);
				}
				invalidate tmplayer;
			}else{
				.drawText(_tempInfoPosX,_tempInfoPosY,aDate,_infoDateFontColor,255,true);
			}
		}
	}


	// セーブ情報にチャプターを描画する
	function setInfoChapter( aTitle )
	{
/*
		var ies = Storages.isExistentStorage;
		if(ies(title+".png") || ies(title+".tlg")){
			.pimage(%[storage:title]);
		}else{
			//.pclear();
			var ta = title.split(/￥ｎ/,,true);
			for(var i=0; i<ta.count; i++){
				//.drawText(_infoTitlePosX, _infoTitlePosY+(i*(infoLayer.font.height+_infoLayLineSpacing)),ta[i],_infoLayFontColor,255,true);
				// センタリングしてみる
				var _chw = 0;
				for(var a=0; a<ta[i].length; a++)_chw += font.getTextWidth(ta[i].charAt(a));
				.drawText(_infoTitlePosX-_chw, _infoTitlePosY+(i*(infoLayer.font.height+_infoLayLineSpacing)),ta[i],_infoLayFontColor,255,true,2048,(_infoLayFontColor^0xFFFFFF),2,0,0);
			}
		}
*/
		var templayer  = new global.Layer( window, this );
		var templayer2 = new global.Layer( window, this );
		var w;
		var h;
		var route      = aTitle.substr( 0,3 );
		var routeNum   = aTitle.substr( 3 );
		var _chapterList = %[
			"com" => "chapter_common",
			"sef" => "chapter_sefi",
			"fre" => "chapter_frey",
			"lil" => "chapter_lil",
			"can" => "chapter_canon"
		];

		//チャプタータイトル
		templayer.loadImages( _chapterList[ route ] );
		templayer.setSizeToImageSize();

		//チャプター番号
		templayer2.loadImages( "chapter_num" );
		w = templayer2.imageWidth * 0.1;
		h = templayer2.imageHeight;

		with( infoLayer )
		{
			//真ん中にあってくれない？
			_infoChapterPosX = ( .width * 0.5 ) - ( ( templayer.width - 20 + ( w * routeNum.length ) ) * 0.5 );

			.operateRect( _infoChapterPosX, _infoChapterPosY, templayer, 0, 0, templayer.width, templayer.height, omAuto);
			_infoChapterPosX += ( templayer.width + 10 );

			for( var i = 0; i < routeNum.length; i++ )
			{
				var index = (int)routeNum.charAt( i );
				.operateRect( _infoChapterPosX + i * w, _infoChapterPosY + 2, templayer2, index * w, 0, w, h, omAuto );
				//.operateRect( _infoDatePosX, _infoChapterPosY, templayer, 0, 0, templayer.width, templayer.height, omAuto );
			}
		}

		invalidate templayer;
	}


	//	セーブ情報にコメントを描画する
	function setInfoComment( aComment )
	{
		with( infoLayer )
		{
			var _tempCommentPosX = _infoCommentPosX + bgLayer.left;
			var _tempCommentPosY = _infoCommentPosY + bgLayer.top;

			if(aComment != ""){
				var ar = aComment.split(/￥ｎ/,,false);
				for(var i=0; i<ar.count; i++){
					var w = 0;
					for(var a=0; a<ar[i].length; a++){
						w += .font.getTextWidth(ar[i].charAt(a));
						if(w >= _infoCommentWidth){
							ar[i] = ar[i].substr(0,a);
							break;
						}
					}
					.drawText(_tempCommentPosX,_tempCommentPosY+(infoLayer.font.height+_infoLayLineSpacing)*i,ar[i],_infoLayFontColor,255,true);
				}
			}else .drawText(_tempCommentPosX,_tempCommentPosY," ",_infoLayFontColor,255,true);
		}
	}


	//	セーブ情報にケーション用の情報を描画する
	function setInfoCation( num )
	{
		var _tmplayer = new global.Layer(kag, kag.primaryLayer);
		// Cation用：ゲーム内の日付表示
		if(kag.scflags.bookMarkMonth !== void){
			var year  = kag.scflags.bookMarkYear  !== void ? kag.scflags.bookMarkYear[num]  : 1;       // 年
			var month = kag.scflags.bookMarkMonth !== void ? kag.scflags.bookMarkMonth[num] : 4;       // 月
			var date  = kag.scflags.bookMarkDate  !== void ? kag.scflags.bookMarkDate[num]  : 1;       // 日
			var week  = kag.scflags.bookMarkWeek  !== void ? kag.scflags.bookMarkWeek[num]  : 1;       // 週
			var day   = kag.scflags.bookMarkDay   !== void ? kag.scflags.bookMarkDay[num]   : "平日";  // 曜日

			if(month !== void && month != ""){
				var numDraw = function(dest, src, no, x, y, w, h){
					if(no == "99" || no == 99){
						dest.operateRect(x, y, src, w*10, 0, w, h, omAlpha, 255);
					}else{
						var str = (string)no;
						for(var i=0; i<str.length; i++){
							var num = (int)str.charAt(str.length-(i+1));
							dest.operateRect(x-(i*w), y, src, w*num, 0, w, h, omAlpha, 255);
						}
					}
				};

				var paste = function(obj, tar, x, y, img=""){
					if(img != "")obj.loadImages(img);
					tar.operateRect(x,y,obj,0,0,obj.imageWidth,obj.imageHeight,omAlpha,255);
				};

				_tmplayer.loadImages("sl_num_preview");

//				numDraw(infoLayer, _tmplayer, year, 925, 455, _tmplayer.imageWidth\10, _tmplayer.imageHeight);    // 年の表示
//				if( month >= 10 ) numDraw(infoLayer, _tmplayer, 1, 1005, 455, _tmplayer.imageWidth\10, _tmplayer.imageHeight); // 月の１０桁の表示
//				numDraw(infoLayer, _tmplayer, month%10, 1030, 455, _tmplayer.imageWidth\10, _tmplayer.imageHeight); // 月の１桁の表示
//				//numDraw(infoLayer, _tmplayer, date,  1150, 455, _tmplayer.imageWidth\10, _tmplayer.imageHeight);  // 日の表示
//				numDraw(infoLayer, _tmplayer, week, 1110, 455, _tmplayer.imageWidth\10, _tmplayer.imageHeight);    // 週の表示
//
//				_tmplayer.loadImages("sl_pre_" + (day === void ? "平日" : day == "平日" ? day : "休日"));
//				infoLayer.operateRect(1165, 452, _tmplayer, 0, 0, _tmplayer.imageWidth, _tmplayer.imageHeight, omAlpha, 255);

				paste(_tmplayer, infoLayer, 925, 455, "sl_year_"+year);
				paste(_tmplayer, infoLayer, 1005, 455, "sl_month_"+month);
				paste(_tmplayer, infoLayer, 1110, 455, "sl_week_"+week);
				paste(_tmplayer, infoLayer, 1165, 452, "sl_pre_" + (day === void ? "平日" : day == "平日" ? day : "休日"));
			}
		}

		// Cation用難易度画像
		if(kag.scflags.bookMarkDif !== void){
			var dif = kag.scflags.bookMarkDif[num];

			if(dif !== void && dif != ""){
				_tmplayer.loadImages(dif ? "sl_icon_normal" : "sl_icon_easy");
				infoLayer.operateRect(785, 449, _tmplayer, 0, 0, _tmplayer.imageWidth, _tmplayer.imageHeight, omAlpha, 255);
			}
		}

		//// Cation用キャラクタールート画像
		//if(kag.scflags.bookMarkChr !== void){
		//	var name = kag.scflags.bookMarkChr[num];
        //
		//	//if(name === void || name == "")name = "共通";	// 共通はないポイ
		//	if(name !== void && name != ""){
		//		_tmplayer.loadImages("sl_icon_" + name);
		//		.operateRect(343, 271, _tmplayer, 0, 0, _tmplayer.imageWidth, _tmplayer.imageHeight, omAlpha, 255);
		//	}
		//}
		invalidate _tmplayer;
	}


	function reSetInfo()
	{
		clearThumbsLayer();
		if(_infoLayEnabled)infoLayer.fillRect(0,0,infoLayer.width,infoLayer.height,0x0);
	}


	// フェードアウトが終了した際にサムネイルレイヤーを消す
	function fadeFinish()
	{
		if(!fadeShow)clearThumbsLayer();
		return super.fadeFinish();
	}

	// 右クリックメニュー呼び出し
	function callPanel(x, y, h, num)
	{
		if(operationState != 0){
			hideShadow();
			ctrlPanel.visible = false;
			return;
		}

		// スクロールモードがある場合、編集ボタンで表示する各ボタンをパネルの上と下どちらに出すか調整する
		if( scrollBarEnabled )
		{
			var temp = (_item_yinc*(num\_item_max)+scrollBar.target.top) + scrollClipPosY + scrollClipMarginH;
			if( temp < ctrlPanel.height ) ctrlPanelReverse = false;
			else            ctrlPanelReverse = true;
		}else{
			ctrlPanelReverse = ctrlPanelDirDef;
		}

		var _x = x + ctrlPanelDiffX;
		var _y = (ctrlPanelReverse) ? (y-ctrlPanel.height) : (y+h);

		// すでに表示状態、場所も同じなら隠して帰る
		if(ctrlPanel.visible && ctrlPanel.left == _x && ctrlPanel.top == _y){
			ctrlPanel.visible = false;
			return;
		}
		srcData = num;

		ctrlPanel.setPos(_x, _y);
		ctrlPanel.order = 100 + glAutoSaveNum + glAutoSaveCount;
		ctrlPanel.visible=true;
	}

	// 右クリックメニューからの操作呼び出し
	function dataOperation(index = 0)
	{
		switch(index){
			case 0:operationEdit();break;	// コメント編集
			case 1:operationCopy();break;
			case 2:operationMove();break;
			case 3:operationDelete();break;
			default:operationState = 0;
		}
	}

	// 影レイヤーをマウスに追従させる
	function onTimer()
	{
		shadowLayer.setPos(cursorX-shadowLayer.width\2, cursorY-shadowLayer.height\2);
	}

	// コピー・移動用の影レイヤー
	function makeShadow()
	{
		var _panelDiffY = 0;
		if( scrollBarEnabled ) _panelDiffY = (_item_yinc*(srcData\_item_max)+scrollBar.target.top) + scrollClipPosY;

		shadowLayer.setImageSize(saveDataItems.buttons[srcData%_item_max].width, saveDataItems.buttons[srcData%_item_max].height);
		shadowLayer.setSizeToImageSize();
		shadowLayer.piledCopy(0,0, this, saveDataItems.buttons[srcData%_item_max].left, saveDataItems.buttons[srcData%_item_max].top+_panelDiffY,saveDataItems.buttons[srcData%_item_max].width, saveDataItems.buttons[srcData%_item_max].height);
		shadowLayer.opacity=150;
		shadowLayer.order = 100;
		onTimer();	// 位置を初期位置に移動
		shadowTimer.interval = 25;
		shadowTimer.enabled = true;
		shadowLayer.visible=true;
	}

	// 影レイヤーを不可視に
	function hideShadow()
	{
		operationState = 0;
		shadowLayer.visible=false;
		shadowTimer.enabled = false;
	}

	// コメント編集モードへ
	function operationEdit()
	{
		if(kag.bookMarkDates[srcData] != "" && srcData != defQuickSaveNum){
			
			if(true){
				var panel_obj     = saveDataItems.buttons[srcData%_item_max];
				var _panelDiffY   = scrollBarEnabled ? ( (_item_yinc*(srcData\_item_max)+scrollBar.target.top)+scrollClipPosY) : 0;
				var _cutPanel     = 0;

				// スクロールモードの場合
				if( scrollBarEnabled )
				{
					_cutPanel = (_item_yinc*(srcData\_item_max)+scrollBar.target.top) + scrollClipPosY;
					if( _cutPanel >= 0 ) _cutPanel = 0;
					else                 _cutPanel = Math.abs( _cutPanel ) + scrollClipMarginH;
				}

				commentEdit.setPos(_editPosX + bgLayer.left, _editPosY + bgLayer.top );
				decisionButton.setPos(commentEdit.left+commentEdit.width+_editDecisionBtDiffX, commentEdit.top+_editDecisionBtDiffY);

				commentLayer.order = 100;
	//			commentLayer.fillRect(0,0,kag.scWidth,kag.scHeight,0xaa000000);
				commentLayer.loadImages("sl_comment_input");
				commentLayer.setSizeToImageSize();

				// エディット時の黒背景をずれた分だけずらす処理
				if(scrollBarEnabled){
					var diff = bgLayerScrollTop - bgLayerTop;
					commentLayer.copyRect(0, diff, commentLayer, 0, 0, commentLayer.imageWidth, commentLayer.imageHeight);
				}

				commentLayer.fillRect(panel_obj.left,panel_obj.top+_panelDiffY+_cutPanel,panel_obj.width,panel_obj.height-_cutPanel,0x0);
				//if(_infoLayEnabled)commentLayer.fillRect(infoLayer.left,infoLayer.top,infoLayer.width,infoLayer.height,0x0);
				if(_editSetUnderSaveData){
					// 浮動コメントエディット
					var x = panel_obj.left;
					var y = panel_obj.top+panel_obj.height;
					if(x < 0)x = 0;
					if(x+commentEdit.width > kag.scWidth)x = kag.scWidth - commentEdit.width;
					if(y < 0)y = 0;
					if(y+commentEdit.height > kag.scHeight)y = kag.scHeight - commentEdit.height;
					commentEdit.setPos(x, y);
					decisionButton.setPos(commentEdit.left+commentEdit.width-decisionButton.width, commentEdit.top+commentEdit.height);
				}
				//commentLayer.fillRect(0,20,550,67,0x0);
				commentEdit.resetCursor();	// 選択状態など各種リセット
				if(kag.scflags.bookMarkComments !== void)commentEdit.text = kag.scflags.bookMarkComments[srcData];
				else commentEdit.text = "";
				commentLayer.visible = true;
				window.focusedLayer = commentEdit;
				// ！！モーダル情報を一時変更
				try{
					removeMode();
					commentLayer.setMode();
				}catch(e){
					dm("■セーブロードにてモーダル状態の切り替えに失敗");
				}
				
				// コメントを一時的に消去
				setInfo(srcData,,false);
			}else{
				var iText = System.inputString("コメントの入力", "コメントを入力してください", kag.scflags.bookMarkComments[srcData]);
				if(iText !== void){
					kag.scflags.bookMarkComments[srcData] = iText;
					// 表示を更新
					setInfo(srcData);
					makeSaveDataItems();
				}
			}
		}
	}

	// コピーモードへ
	function operationCopy()
	{
		makeShadow();
		operationState = 1;
	}

	// 移動モードへ
	function operationMove()
	{
		makeShadow();
		operationState = 2;
	}

	// 削除
	function operationDelete()
	{
		// どこにもフォーカスがない場合にダイアログが出るとボタンが光るので対処
		window.focusedLayer = saveDataItems.buttons[srcData];
		if(aynOpDelete(srcData)){
			clearSaveDataItems();
			operationDelete_sub();
			makeSaveDataItems(); // 表示を更新
		}
	}

	// 削除本体
	function operationDelete_sub()
	{
		kag.eraseBookMark(srcData);
		if(sf.newest_save == srcData)sf.newest_save = void;	// 最新のセーブデータだった場合はそれも削除
		if(kag.scflags.bookMarkComments !== void)kag.scflags.bookMarkComments[srcData] = ''; // コメントクリア
		// 各種追記情報削除
		for(var i=0; i<saveAddInfoList.count; i++){
			var name = saveAddInfoList[i][0];
			if(kag.scflags[name] !== void)kag.scflags[name][srcData] = "";
		}
	}

	function clearThumbsLayer()
	{
		if(infoThumbEnabled){
			// サムネイルレイヤーを非表示に
			thumbsLayer.setImageSize(32,32);
			thumbsLayer.setSizeToImageSize();
			thumbsLayer.fillRect(0,0,32,32,0x0);
			thumbsLayer.visible = false;

			if(bigThumbNail)global.makethumbs_object.clear();
		}
	}

	function clearSaveDataItems()
	{
		// セーブデータ表示のクリア
		if(saveDataItems.buttons !== void)
		{
			for(var i = 0; i < saveDataItems.buttons.count; i++)
			{
				saveDataItems.buttons[i].saveToSystemVariable();
				invalidate saveDataItems.buttons[i];
			}
			//saveDataItems = void;
			saveDataItems.clear();
			kag.setBookMarkMenuCaptions();
		}

		invalidate scrollBar if scrollBar !== void;
		kag.wheelSpinHook.clear();

		clearThumbsLayer();
	}

	// ホイールフック
	function wheelHook(shift, delta, x, y)
	{
		try{
			if( delta > 0 )	global.SaveLoad_object.saveload.scrollBar.prev(delta\120);
			else			global.SaveLoad_object.saveload.scrollBar.next(Math.abs(delta\120));
		}catch(e){
			dm("■セーブロード用ホイール動作に失敗+\n"+e.message);
		}
		return true;
	}

	function reSetTargetSize()
	{
		var y = 0;

		for(var i = 0; i < saveDataItems.buttons.count; i++)
		{
			var tar = saveDataItems.buttons[i];
			if( y < tar.top + tar.height ) y = tar.top + tar.height;
		}

		y += scrollClipMarginH;	// 最後の余白
		saveDataItems.height = y;
	}

	function makeSaveDataItems()
	{
		var _save_data_item_max = 0;
		// セーブデータの表示
		clearSaveDataItems();
		// どうも画像がTLGだと画像キャッシュに乗るらしく、更新されないので
		// メモリ強制解放
//		System.doCompact();

		saveDataItems.buttons = [];
		newestLayer.visible = false;	// とりあえずnew画像は消しておく

		saveDataItems.top = 0;
		infoLayer.top = _infoLayY;
		if( scrollBarEnabled ){
			_save_data_item_max = glAutoSaveNum;
			if( !owner.isSaveMode ) _save_data_item_max += glAutoSaveCount;

			scrollBar = new ScrollBarLayerFree(window, this, %[top:scrollBarTop, center:scrollBarCenter, under:scrollBarUnder]);
			with(scrollBar){
				.setTarget( saveDataItems );
				.setClipPos( scrollClipPosX, scrollClipPosY );
				.setClipSize( scrollClipSizeW, scrollClipSizeH );
				.setScrollBarPos( scrollBarPosX, scrollBarPosY, scrollBarSizeH );
			}

			// ホイール動作登録
			kag.wheelSpinHook.add(wheelHook);
		}else{
			_save_data_item_max  = _item_max;
			saveDataItems.parent = this;
			saveDataItems.setSize(kag.scWidth, kag.scHeight);
		}


		// 当たり判定作成
		for( var i = 0; i < _save_data_item_max; i++ )
		{
			var obj;
			var cur;
			//var obj = new SaveLoadItemLayer(window, this, currentPage * _item_max + i);

			if( scrollBarEnabled )
			{
				cur = i;
				obj = new SaveLoadItemLayer( window, saveDataItems, i );
				saveDataItems.addObject(obj);
				obj.setPos(0+(i%_item_line_cnt)*_item_xinc+scrollClipMarginW, (i\_item_line_cnt)*_item_yinc+scrollClipMarginH);
			}
			else
			{
				// 表示すべきセーブデータの特定
				// タブがある場合は最大数＋オートセーブの数(glAutoSaveCount)分を移動させたものを表示。
				// SaveLoadItemLayerの第4引数を新設し、見かけ上の番号を送るように設定。voidを送れば数値通りに表記
				var viewCur;
				if(glRouteSave){
					cur = currentPage * _item_max + i + _currentTab * (_btn_max * _item_max + glAutoSaveCount);
					viewCur = currentPage * _item_max + i;
				}else{
					cur = currentPage * _item_max + i;
					viewCur = void;
				}
				obj = new SaveLoadItemLayer( window, saveDataItems, cur,  viewCur);
				saveDataItems.addObject(obj);
				obj.setPos(_item_x+(i%_item_line_cnt)*_item_xinc, _item_y+(i\_item_line_cnt)*_item_yinc);
			}

			// ※フォーカスチェーンの順番は奥行きが最優先で、
			// 奥行きが同じなら先に作られたものが優先されるようだ
			obj.order = 50+i;
			obj.visible = true;

			// 最新画像を設置
			if(sf.newest_save !== void && sf.newest_save == cur){
				newestLayer.setPos(obj.left + newPosX, obj.top + newPosY);
				newestLayer.visible=true;
			}
		}

		if( scrollBarEnabled )
		{
			reSetTargetSize();
			scrollBar.initScrollBar();
		}

		// ロードの場合で有効化されている場合、クイックセーブ領域も表示
		if(state == 1 && _qloadEnabled){
			var obj;
			if(_qloadIsButton) obj = new SaveLoadItemButton(window, this, defQuickSaveNum);
			else               obj = new SaveLoadItemLayer(window, saveDataItems, defQuickSaveNum);

			//saveDataItems.add(obj);
			saveDataItems.addObject(obj);
			obj.setPos(_qloadX, _qloadY);
			// クイックセーブデータの有無でボタンの不透明度変更
			if((kag.bookMarkDates[defQuickSaveNum] != '' && kag.bookMarkDates[defQuickSaveNum] !== void)){
				obj.opacity = 255;
			}else{
				obj.opacity = 100;
			}
			obj.visible = true;
		}

		// 情報レイヤーを更新、最初のセーブデータがハイライトされるように
		//setInfo(currentPage * _item_max);
		try{
			if(sf.newest_save !== void && currentPage == (sf.newest_save\_item_max))window.focusedLayer = saveDataItems.buttons[sf.newest_save%_item_max];
			else window.focusedLayer = saveDataItems.buttons[0];
		}catch(e){
			dm("フォーカス失敗"+e.message);
		}

		newestLayer.absolute = _save_data_item_max + 10;	// 最新画像が隠れないように調整
		if(shadowLayer.visible)shadowLayer.absolute = saveDataItems.buttons[-1].absolute + 20;	// コピー/移動用複製画像が隠れないように調整

		// 特殊
		/*with(bgPageLayer){
			if(currentPage >= _btn_max).loadImages("sl_imga");
			else .loadImages("sl_img"+currentPage);
			.setSizeToImageSize();
			.hitType = htMask;
			.hitThreshold = 256;
			.setPos(196,14);
			.visible = true;
		}*/

		// ページ数表示
		var pageNoImage = "sl_now_" + (state==1?"l":"s") + (currentPage==_btn_max?"auto":("p"+(currentPage+1)) );
		var ies         = Storages.isExistentStorage;

		//
		if(ies(pageNoImage+".tlg") || ies(pageNoImage+".png") || ies(pageNoImage+".jpg")){
			if(pageNoLayer === void) pageNoLayer = new global.Layer(window, this);
			pageNoLayer.loadImages(pageNoImage);
			pageNoLayer.setSizeToImageSize();
			pageNoLayer.hitType      = htMask;
			pageNoLayer.hitThreshold = 256;
			pageNoLayer.setPos(0, 35);
			pageNoLayer.visible = true;
		}else{
			if(pageNoLayer !== void) pageNoLayer.visible = false;
		}
		absolute = 10;
	}

	function onShow()
	{
		// 情報レイヤーを更新、最初のセーブデータがハイライトされるように
		// ページ切り替えにも同じ処理を入れてあるが、最初に開いた時だけはフォーカスがシステムにより変更される模様。
		//setInfo(currentPage * _item_max);
		try{
			if(sf.newest_save !== void && currentPage == (sf.newest_save\_item_max))window.focusedLayer = saveDataItems.buttons[sf.newest_save%_item_max];
			else window.focusedLayer = saveDataItems.buttons[0];
		}catch(e){
			dm("フォーカス失敗"+e.message);
		}
	}

	function clearButtons()
	{
		// ページボタンのクリア
		if(buttons !== void)
		{
			for(var i = 0; i < buttons.count; i++)
			{
				invalidate buttons[i];
			}
			buttons = void;
		}

		// ページボタンスクロールボタンのクリア
		if( _btnScroll )
		{
			if( pageBtPrev !== void ){ invalidate pageBtPrev; pageBtPrev = void; }
			if( pageBtNext !== void ){ invalidate pageBtNext; pageBtNext = void; }
		}
	}

	function clearTabButtons()
	{
		if( _tabItemsBt !== void )
		{
			for( var i = 0; i < _tabItemsBt.count; i++ )
			{
				invalidate _tabItemsBt[i];
			}
			_tabItemsBt = void;
		}
	}

	// ページボタンが複数ページになっているときの次のページへ移動する
	function pageNext(){
		++pageButtonCurrent;
		if(pageButtonCurrent * _btn_line_cnt >= _btn_max)pageButtonCurrent = 0;
		pageButtonVisibleAdjust();
		// ページ切り替えが行われたら一番左のページを押したことにする
		buttons[_btn_line_cnt * pageButtonCurrent].onKeyDown(VK_RETURN);
	}

	// ページボタンが複数ページになっているときの前のページへ移動する
	function pagePrev(){
		--pageButtonCurrent;
		if(pageButtonCurrent < 0)pageButtonCurrent = Math.ceil(_btn_max / _btn_line_cnt) - 1;
		pageButtonVisibleAdjust();
		// ページ切り替えが行われたら一番左のページを押したことにする
		buttons[_btn_line_cnt * pageButtonCurrent].onKeyDown(VK_RETURN);
	}

	// ページボタンが複数ページになっているときのページ数に合わせて表示を調整する
	function pageButtonVisibleAdjust(){
		// 一旦全ボタンを消して、必要なページを表示し直す
		for(var i=0; i<_btn_max; i++)buttons[i].visible = false;
		for(var i=0; i<_btn_line_cnt; i++){
			var index = _btn_line_cnt * pageButtonCurrent + i;
			if(index < buttons.count)buttons[index].visible = true;
			else break;
		}
	}


	// ページボタンを作成する
	function makeButtons(head)
	{
		clearButtons();
		buttons = [];
		var obj;

		// セーブデータパネルを全画面に表示しない場合はページ番号を表示する
		if( !scrollBarEnabled ){
			for(var i = 0; i < _btn_max; i++)
			{
				buttons.add(obj = new SaveLoadButtonLayer(window, this, onChangePageClick));
				obj.hitThreshold = _btn_hitThreshold;
				obj.Butt_showFocusImage=true;
				obj.loadImages(head + (i+1));		//++++++++ページボタン。連番
				//++++++++ページボタンのそれぞれの位置。
				obj.setPos(_btn_x+(i%_btn_line_cnt)*_btn_xinc, _btn_y+(i\_btn_line_cnt)*_btn_yinc);

				obj.focusable = true;
				obj.enabled = currentPage != i;
				obj.nowfocus = currentPage == i;
				obj.order = 100 + i;
				obj.visible = true;
				obj.draw();
				obj.page = i;
			}

			// ※※ボタンがスクロールする場合の対応
			if(_btnScroll){
				if(pageBtPrev === void) pageBtPrev = new SaveLoadButtonLayer(window, this, pagePrev);
				if(pageBtNext === void) pageBtNext = new SaveLoadButtonLayer(window, this, pageNext);

				pageBtPrev.isQuadruple = false;
				pageBtPrev.loadImages("sl_page_prev");
				pageBtPrev.setPos(_btnPrev_x,_btnPrev_y);
				pageBtPrev.visible = true;
				pageBtNext.isQuadruple = false;
				pageBtNext.loadImages("sl_page_next");
				pageBtNext.setPos(_btnNext_x,_btnNext_y);
				pageBtNext.visible = true;

				pageButtonCurrent = 0;
				pageButtonVisibleAdjust();
			}

			// ロード画面の場合かつオートのページが有効の場合のみオート画面のを作成
			if(state == 1 && _autoBtEnabled){
				buttons.add(obj = new SaveLoadButtonLayer(window, this, onChangePageClick));
				obj.isQuadruple = false;
				obj.hitThreshold = _btn_hitThreshold;
				obj.Butt_showFocusImage=true;
				obj.loadImages(_autoBtName);
				obj.setPos(_autoBtnX, _autoBtnY);

				obj.focusable = true;
				obj.enabled   = currentPage != _btn_max;
				obj.nowfocus  = currentPage == _btn_max;
				obj.order     = 100 + _btn_max + 1;
				obj.visible   = true;
				obj.draw();
				obj.page      = _btn_max;
			}
		}

		if( saveDataScroll )
		{
			var _img = scrollBarEnabled ? scrollModeImgSingle : scrollModeImgMulti;
			var _x   = scrollModeButtonX;
			var _y   = scrollModeButtonY;
			
			buttons.add(obj = new ThreeButtonLayer(window, this, %[func:onChangeSaveDataLine]));
			obj.loadImages( _img );
			obj.setPos( _x, _y );

			obj.enabled      = true;
			obj.hitThreshold = _btn_hitThreshold;
			obj.hint         = "セーブデータの表示形式を変更します";
			obj.visible      = true;


			bgLayer2.visible = false;
			if( scrollBarEnabled )
			{
				bgLayer2.visible=true;

				if( bgLayer2img === void || bgLayer2img === "" ){
					bgLayer2.fillRect(scrollBarPosX-2, scrollBarPosY-3, 15, scrollBarSizeH+5, 0xffffffff);
				}
			}
		}

		buttons.add(obj = new ThreeButtonLayer(window, this, %[func:onOpenSaveFolder]));
		obj.setPos(_openX, _openY);
		obj.focusable = true;
		obj.loadImages(_openSFBtName);
		obj.hint="セーブデータフォルダを開きます";
		obj.visible = true;

		if(state == 1){	//ロード
			buttons.add(obj = new ThreeButtonLayer(window, this, %[func:onGoSaveButton]));
			obj.loadImages(_goSaveBtName);
			//if(owner.callByTitle){	// タイトルから呼ばれた場合、少し暗くして無効に}
			if(kag.mainConductor.curStorage == "title.ks"){	// タイトルから呼ばれた場合、少し暗くして無効に
				obj.adjustGamma(1.0, 0, 200, 1.0, 0, 200, 1.0, 0, 200);
				obj.hitType = htMask;
				obj.enabled = false;
			}else{
				obj.enabled = true;
				obj.hitThreshold = _btn_hitThreshold;
			}
			obj.hint="セーブ画面へ移動します";
		}else{
			buttons.add(obj = new ThreeButtonLayer(window, this, %[func:onGoLoadButton]));
			obj.loadImages(_goLoadBtName);
			obj.hitThreshold = _btn_hitThreshold;
			obj.hint="ロード画面へ移動します";
		}
		obj.setPos(_slX, _slY);
		obj.visible=true;

		buttons.add(obj = new ThreeButtonLayer(window, this, %[func:onBackButtonClick]));
		obj.setPos(_backX, _backY);
		obj.focusable = true;
		obj.loadImages(_backBtName);
		obj.hint="ゲームに戻ります";
		obj.visible = true;

		buttons.add(obj = new ThreeButtonLayer(window, this, %[func:onTitleBackButton]));
		obj.setPos(_titleX, _titleY);
		obj.loadImages(_backTitleBtName);
		obj.hint="タイトル画面に戻ります";
		obj.visible=true;

		buttons.add(obj = new ThreeButtonLayer(window, this, %[func:onExitButton]));
		obj.setPos(_exitX, _exitY);
		obj.loadImages(_exitBtName);
		obj.hint="ゲームを終了します";
		obj.visible=true;
	}

	// クイックロード
	function onQloadButton(){
		if(tf.isEvMode)return;
		if(!Storages.isExistentStorage(kag.getBookMarkFileNameAtNum(defQuickSaveNum)))return;
		if(aynQLoad()){
			kag.loadBookMark(defQuickSaveNum);
			onBackButtonClick();
		}
	}

	// セーブデータフォルダを開く
	function onOpenSaveFolder()
	{
		System.ba4423e5cd484bb69c84512dcd34ceb0(Storages.getLocalName(kag.saveDataLocation));
	}

	// セーブ画面へ
	function onGoSaveButton()
	{
		kag.process("saveload.ks", "*loadtosave");
		onBackButtonClick();
	}

	// ロード画面へ
	function onGoLoadButton()
	{
		kag.process("saveload.ks", "*savetoload");
		onBackButtonClick();
	}

	// タイトルに戻る関数
	function onTitleBackButton(){
		// タイトルからの呼び出しだった場合、何も聞かずに閉じる
		if(owner.callByTitle)onBackButtonClick();
		else if(aynBackTitle()){
			kag.process("saveload.ks", "*back_title");
			onBackButtonClick();
		}
	}

	// ゲームを終了する関数
	function onExitButton(){
		var result = aynExitGame();
		return result ? kag.closeByScript(%[ask:false]) : false;
//		return kag.closeByScript(%[ask:false]);
	}

	// 戻るボタンや右クリックの動作
	function onBackButtonClick(){
		ctrlPanel.visible = false;
		commentLayer.visible = false;
//		clearThumbsLayer();
		owner.onSaveLoadClose();
	}

	// ボタン作成
	function make(state, _bg = void){
		var storage = _btnScroll ? (!state ? saveScrollBgStorage : loadScrollBgStorage) : (!state ? saveBgStorage : loadBgStorage);
		var head    = !state ? saveButtonStorage : loadButtonStorage;
		if(_bg !== void)storage = _bg;		// 意図的に背景が指定されていた場合はそれを採用(ルートごとにタブがある場合の動作)

		this.state = state;
		clear();
		// 背景ロード
		bgLayer.loadImages(storage);
		bgLayer.setSizeToImageSize();

		if( scrollBarEnabled ){
			// スクロールモード時のコメント(背景)位置設定
			bgLayer.setPos(bgLayerScrollLeft, bgLayerScrollTop);
		}else{
			// 通常時のコメント(背景)位置設定
			bgLayer.setPos(bgLayerLeft, bgLayerTop);
		}

		setImageSize(kag.scWidth, kag.scHeight);
		setSizeToImageSize();
		//fillRect(0,0,width,height,_mainBgColor);
		// ボカシ埋め込み
		piledCopy(0,0,kag.fore.base,0,0,kag.scWidth,kag.scHeight);
		doGrayScale();
		doBoxBlur(10,10);
		doBoxBlur(10,10);
		// 最新のセーブデータの位置で開くように調整
		if(glRouteSave){
			// ルートごとの場合
			currentPage = 0;
		}else{
			if(sf.newest_save !== void)currentPage = (sf.newest_save\_item_max);
			// セーブを開く場合、オートがカレントで選択されていてはまずい
			if(state == 0 && currentPage == _btn_max)currentPage = _btn_max-1;
		}

		if( glRouteSave )makeTab();  //セーブデータにルートごとのタブがある場合
		makeSaveDataItems();
		makeButtons(head);
	}

	function clear()
	{
		clearSaveDataItems();
		clearButtons();
		operationState = 0;
		hideShadow();
	}

	function makeTab(){
		if( _tabItemsBt ) return;

		var _bgStorage = state == 0 ? saveBgStorage : loadBgStorage;
		var _tabs      = [];
		_tabs.assign(_tabFileNames);

		_tabItemsBt = [];
		_currentTab = (int)f[glRouteSaveFlagName];
		var _targetChar = _tabFileNames[_currentTab];

		for( var i = 0; i < _tabs.count; i++ )
		{
			var obj;
			var _storage    = "sl_tab_bt";
			var _current    = _tabs[ i ] == _targetChar;

			if( _tabs[ i ] != "" && _tabs[ i ] !== void ) _storage += ("_" + _tabs[ i ]);
			if( _targetChar != "" && _targetChar == _tabs[ i ] ){
				bgLayer.loadImages( _bgStorage + "_" + _tabs[ i ] );
				bgLayer.setSizeToImageSize();
			}

			_tabItemsBt.add( obj = new CheckBox_4imgEx(window, this, %[ storage:_storage] ));
			obj.setPos( _tab_x + (_tab_xDiff * i), _tab_y + (_tab_yDiff * i) );
			obj.check = _current;

			_tabItemsBt[i-1].linkObj = obj;
			obj.linkObj = _tabItemsBt[i-1];

			obj.pressTjs = "SaveLoad_object.saveload.changeTab(\""+ i +"\")";

			if(state == 0) obj.enabled = false;// セーブの場合タブを変更できるとまずい
		}
	}

	function changeTab( tabno ){
		_currentTab = tabno;
		currentPage = 0;
		var aTarget = _tabFileNames[tabno];
		var _bgStorage = state == 0 ? saveBgStorage : loadBgStorage;
		if( aTarget !== void && aTarget != "" ) _bgStorage += "_" + aTarget;

		make( state, _bgStorage );
	}

	// コメントの決定
	function commentDecision()
	{
		kag.scflags.bookMarkComments[srcData] = commentEdit.text;
		// ！！モーダル情報を元に戻す
		try{
			commentLayer.removeMode();
			setMode();
		}catch(e){
			dm("■セーブロードにてモーダル状態の切り替えに失敗");
		}
		// 表示を更新
		setInfo(srcData);
		makeSaveDataItems();
	}

	function onChangePageClick(sender)
	{
		ctrlPanel.visible = false;	// とりあえずつつかれたら右クリックメニューは消す
		var newpage = sender.page;
		// ページを変更するとき
		if(buttons !== void)
		{
			window.focusedLayer = null;		// 取りあえずフォーカスを取っておかないと無効にした瞬間にfocusNextが走っている感じがする
			buttons[currentPage].nowfocus = false;
			buttons[currentPage].enabled = true;
			buttons[newpage].nowfocus = true;
			buttons[newpage].enabled = false;
			currentPage = newpage;
			makeSaveDataItems();
		}
		// makeSaveDataItems()の中で一つ目のセーブデータにフォーカスをあわせるようにした。
		//window.focusedLayer = null;
	}

	function onLoadOrSave(num)
	{
		if(operationState != 0){
			shadowTimer.enabled = false;
			if(operationState == 1){
				if((+srcData) == (+num) || num == defQuickSaveNum){hideShadow(); return;}
				if(aynOpCopy(srcData, num)){
					clearSaveDataItems();
					if(sf.newest_save == (+num))sf.newest_save = void;	// コピー先がセーブデータだった場合は最新を無しに
					copyBookMark(+srcData, +num);
					makeSaveDataItems();
				}
				hideShadow();
			}else if(operationState == 2){
				if((+srcData) == (+num) || num == defQuickSaveNum){hideShadow(); return;}
				if(aynOpMove(srcData, num)){
					if(sf.newest_save == srcData)sf.newest_save = num;	// 最新のセーブデータだった場合はそれも移動
					clearSaveDataItems();
					copyBookMark(+srcData, +num);
					operationDelete_sub();
					makeSaveDataItems();
				}
				hideShadow();
			}
//			hideShadow();
			return;
		}

		ctrlPanel.visible = false;	// 右クリック必ず非表示に

		// 番号 num をセーブまたはロード
		if(state == 1){
			if(num < kag.numBookMarks && kag.bookMarkDates[num] == "") // bookMarkDates が空文字の場合は栞は存在しない
			return false;
			// ロード
			kag.loadBookMarkWithAsk(num);
			tf.noautosave = true;						///////////////////////////////// ★オートセーブ対応★
		}else{
			// セーブ
			if(kag.saveBookMarkWithAsk(num))
			{
				// セーブしたら最新データ位置を更新
				sf.newest_save=num;
				clearSaveDataItems();
				saveAddInfo(num);
				makeSaveDataItems(); // 表示を更新
				// 情報表示
				setInfo(num);
			}
		}
	}

	function onChangeSaveDataLine()
	{
		scrollBarEnabled = !scrollBarEnabled;

		if( state ) kag.process("saveload.ks", "*savetoload");
		else        kag.process("saveload.ks", "*loadtosave");
		onBackButtonClick();
	}

	// セーブデータのコピー（KAGのヤツはサムネイル非対応）
	function copyBookMark(from, to)
	{
		with(kag){
			// 栞番号 from から栞番号 to に栞をコピーする
			if(.readOnlyMode) return false;
			if(.bookMarkProtectedStates[to]) return;

			if(.scflags.bookMarkComments !== void){
				.scflags.bookMarkComments[to] = .scflags.bookMarkComments[from]; // コメントもコピー
			}
			// 各種追記情報コピー
			for(var i=0; i<saveAddInfoList.count; i++){
				var name = saveAddInfoList[i][0];
				if(kag.scflags[name] !== void)kag.scflags[name][to] = kag.scflags[name][from];
			}

			var fn = .getBookMarkFileNameAtNum(from);

			if(!Storages.isExistentStorage(fn)) return; //ファイルがない

			var data = Scripts.evalStorage(fn, "z");

			fn = .getBookMarkFileNameAtNum(to);

			// サムネイルファイルのコピー
			if(.saveThumbnail){
				var tnname = Storages.chopStorageExt(kag.getBookMarkFileNameAtNum(from)) + ".jpg";
				if(Storages.isExistentStorage(tnname)){
					var tmplayer = new global.Layer(window, parent);
					tmplayer.loadImages(tnname);
					tmplayer.saveLayerImage(Storages.chopStorageExt(fn) + ".jpg", "jpg080");
					(Dictionary.saveStruct incontextof data)(fn, "z");
					invalidate tmplayer;
				}
			}else (Dictionary.saveStruct incontextof data)(fn, "z");

			.getBookMarkInfoFromData(data.core, to);
		}
	}

	function saveToSystemVariable()
	{
		// システム変数にデータを保存する必要があるとき
		if(saveDataItems.buttons !== void)
		{
			for(var i = 0; i < saveDataItems.buttons.count; i++)
				saveDataItems.buttons[i].saveToSystemVariable();
			kag.setBookMarkMenuCaptions();
		}
	}

	// 画像を開放
	function imgClear(process = true)
	{
		if(process)
		{
			visible = false;
			setSize(32, 32);
			setImageSize(32, 32);
			face = dfAlpha;
			fillRect(0, 0, 32, 32, 0);
			type = ltAlpha;
			face = dfAuto;
		}
	}

	function onKeyDown(key)
	{
		super.onKeyDown(...);
		if(key == VK_ESCAPE)onBackButtonClick(); // ESC キーが押されたらレイヤを隠す
	}

	function onMouseDown(x, y, button, shift)
	{
		super.onMouseDown(...);
		if(button == mbRight){
			ctrlPanel.visible = false;	// とりあえずつつかれたら右クリックメニューは消す
			hideShadow();				// つつかれたら影レイヤーも消そう
			if(button == mbRight)onBackButtonClick(); // 右クリックされたらこのレイヤを隠す
		}
	}
}


class SaveLoadPlugin extends KAGPlugin
{
	var window;					// ウィンドウへの参照
	var saveload;				// 設定レイヤ
	var showing     = false;
	var callByTitle = false;

	var org_onMouseWheel;

	var isSaveMode = false;	// セーブモードかロードモードか表す

	function SaveLoadPlugin(window)
	{
		//SaveLoadPlugin コンストラクタ
		super.KAGPlugin(); // スーパークラスのコンストラクタを呼ぶ

		this.window = window; // window への参照を保存する
// 独立メッセージレイヤー用設定
//		saveload = new SaveLoadLayer(window, kag.back.base, this);
		saveload = new SaveLoadLayer(window, kag.primaryLayer, this);
	}

	function finalize()
	{
		invalidate saveload if saveload !== void;
		super.finalize(...);
	}

	function showSave()
	{
		callByTitle = false;	// タイトルから呼ばれたときのみtrue
// 独立メッセージレイヤー用設定
//		saveload.parent = window.fore.base;	// 親の再設定する
//		saveload.absolute = 2000000-11;

		isSaveMode = true;
		saveload.clearTabButtons();
		saveload.make(0);
		showing = true;
		window.saveloadShowing = true;

		saveload.show();
	}

	function showLoad(cbt = false)
	{
		callByTitle = cbt;	// タイトルから呼ばれたときのみtrue
// 独立メッセージレイヤー用設定
//		saveload.parent = window.fore.base;
//		saveload.absolute = 2000000-11;

		isSaveMode = false;
		saveload.clearTabButtons();
		saveload.make(1);
		showing = true;
		window.saveloadShowing = true;

		saveload.show();
	}

	function showLoadByTitle()
	{
		showLoad(true);
	}

	function onSaveLoadClose()
	{
		// 設定レイヤが閉じるとき
		closeSaveLoad();
		showing = false;
		window.saveloadShowing = false;
		window.trigger('saveload'); //saveloadトリガ発動
	}

	function closeSaveLoad()
	{
		kag.wheelSpinHook.clear();
		
		//設定レイヤを閉じる
		if(showing)saveload.hide() if saveload !== void;
		saveload.imgClear();
		showing = false;
		window.saveloadShowing = false;
	}

	// ロード時の動作
	function onRestore(f, clear, elm){
		closeSaveLoad();
		_loadInit();		// 各種設定をロード
	}
	// セーブ時の動作
	function onSaveSystemVariables(){ if(saveload !== void) saveload.saveToSystemVariable(); }

	// 以下、KAGPlugin のメソッドのオーバーライド

	function onStore(f, elm){}
	function onStableStateChanged(stable){}
	function onMessageHiddenStateChanged(hidden){}
	function onCopyLayer(toback){}
	function onExchangeForeBack(){}
}

kag.addPlugin(global.SaveLoad_object = new SaveLoadPlugin(kag));

@endscript
@endif
@return

*savetoload
@waittrig name="configFadeEnd"
@unlocksnapshot cond="kag.snapshotLockCount"
@jump target="*load"

*loadtosave
@waittrig name="configFadeEnd"
@unlocksnapshot cond="kag.snapshotLockCount"
@jump target="*save"

*save
@return cond="tf.isEvMode"
@fovo
@eval exp="try{ systemSE(defCallSave); }catch(e){ dm(e.message); }"
@locksnapshot
@eval exp="SaveLoad_object.showSave();"
@jump target="*wait"

*load
@return cond="tf.isEvMode"
@fovo
; ロードオープンボイス
@eval exp="try{ systemSE(defCallLoad); }catch(e){ dm(e.message); }"
@eval exp="SaveLoad_object.showLoad();"
@jump target="*wait"

*loadbytitle
; ロードオープンボイス
@eval exp="try{ systemSE(defCallLoad); }catch(e){ dm(e.message); }"
@eval exp="f[glRouteSaveFlagName] = 0" cond="glRouteSave"
@eval exp="SaveLoad_object.showLoadByTitle()"

*wait
@locklink
@eval exp="tf.slc_showing=true"
@waittrig name="configFadeEnd"
@waittrig name="saveload"
@waittrig name="configFadeEnd"
@unlocksnapshot cond="kag.snapshotLockCount"
@unlocklink
@return

*back_title
@return storage="title.ks" target="*title_init"

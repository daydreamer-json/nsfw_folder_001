@if exp="typeof(global.tiphelp_object) == 'undefined'"
@iscript

// ツールチップヒントを表示する

class TipHintPlugin extends KAGPlugin
{
	var fore; // 表画面のレイヤと裏画面のレイヤ
	var window; // ウィンドウへの参照

	var tipHeight = 25;			// 画像ではなく文字として処理したときの高さ
	var tipColor = 0xcc5555aa;	// 画像ではなく文字として処理したときの色(グリム/0xccd61156)

	var isImg = false;

	function TipHintPlugin(window)
	{
		super.KAGPlugin(); // スーパークラスのコンストラクタを呼ぶ

		this.window = window; // window への参照を保存する
	}

	function finalize()
	{
		invalidate fore if fore !== void;
		super.finalize(...);
	}

	function start(img, str, obj)
	{
		// なんだろ？
//		if(!sysSpTipHint){
//			finish();
//			return;
//		}

		if(fore == void){
			fore = new Layer(window, window.primaryLayer);
			fore.font.height = 12;
			fore.font.face = "ＭＳ ゴシック";
		}

		// クリア
		fore.fillRect(0, 0, fore.imageWidth, fore.imageHeight, 0x00000000);

		// マウスメッセージは全域透過
		fore.hitType = htMask;
		fore.hitThreshold = 256;

		// 画像ヘルプを優先
		if(img != void){
			fore.loadImages(img);
			isImg = true;
		}else if(str != void){
			isImg = false;
			fore.face=dfAlpha;
			fore.type=ltAlpha;
			// メッセージサイズの調査
			var msgW = 0;
			var msgH = 0;
			// ※特殊処理：LoadStringと記述があったらそれは式として評価する
			if(str.indexOf("LoadString") != -1)str = str!;
			if(str ===void || str == "")str = " ";		// 完全に文字列無しだと幅測るところで落ちる

			for(var i=0; i<str.length; i++){
				msgW += fore.font.getTextWidth(str.charAt(i));
				msgH += fore.font.getTextHeight(str.charAt(i));
			}
			msgH \= str.length;
			fore.setImageSize(msgW + 16 , tipHeight);
			fore.fillRect(0, 0, fore.imageWidth, fore.imageHeight, tipColor);
			fore.fillRect(2, 2, fore.imageWidth-4, 1, 0xffffffff);					// 上
			fore.fillRect(2, fore.imageHeight-3, fore.imageWidth-4, 1, 0xffffffff);	// 下
			fore.fillRect(2, 3, 1, fore.imageHeight-5, 0xffffffff);					// 左
			fore.fillRect(fore.imageWidth-3, 3, 1, fore.imageHeight-5, 0xffffffff);	// 右
			fore.drawText(fore.imageWidth\2-msgW\2, fore.imageHeight\2-msgH\2+1, str, 0xffffff, 255, false, 512, 0x000000, 1, 1, 0);
		}else{
			fore.fillRect(0, 0, fore.imageWidth, fore.imageHeight, 0x00000000);
		}
		fore.setSizeToImageSize();
		fore.visible = true;

		changePos(obj);
	}

	// 指定位置を中心にフォントサイズを指定して枠なしで出現
	// 画像指定があったら画像優先
	function start2(img, str, x=0, y=683)
	{
		if(fore == void){
			fore = new Layer(window, window.primaryLayer);
			fore.font.height = 22;
			fore.font.face = "vlg22";
			fore.font.mapPrerenderedFont("vlg22.tft");
		}
		if(img !== void && img != ""){
			fore.loadImages(img);
			fore.setSizeToImageSize();
			isImg = true;
			fore.setPos(x, y);
		}else{
			isImg = false;
			fore.face=dfAlpha;
			fore.type=ltAlpha;
			// メッセージサイズの調査
			var msgW = 0;
			var msgH = 0;
			for(var i=0; i<str.length; i++){
				msgW += fore.font.getTextWidth(str.charAt(i));
				msgH += fore.font.getTextHeight(str.charAt(i));
			}
			msgH \= str.length;
			fore.setImageSize(msgW + 16 , tipHeight);
			fore.drawText((fore.imageWidth>>1)-(msgW>>1), (fore.imageHeight>>1)-(msgH>>1)+1, str, 0xffffff, 255, false, 512, 0x000000, 1, 1, 0);
			fore.setSizeToImageSize();
			fore.setPos(x-(fore.imageWidth>>1), y-(fore.imageHeight>>1));
		}
		fore.visible = true;
	}

	//pos：0：センター 1：左 2：右
	function changePos(obj, pos=0)
	{
		//if(fore !== void){
		//	var x = obj.left+obj.width\2;
		//	var y = obj.top+obj.height\2;
		//	if(x>kag.scWidth\2)x-=fore.width;
		//	// ※現在は必ず上に出るように調整中
		//	y-=(obj.height\2+fore.height);
		//	//if(y>kag.scHeight\2)y-=(obj.height\2+fore.height);
		//	//else y+=obj.height\2;
		//	if(isImg){
		//		x = obj.left+obj.width\2-fore.width\2;		// 画像だった場合センタリングをかけてみる
		//		// ただ画面からはみ出すのは許さん
		//		if(x < 0)x = 0;
		//		if(x+fore.width > kag.scWidth)x = kag.scWidth-fore.width;
		//	}
		//	fore.setPos(x, y);
		//}

		if(fore !== void)
		{
			var x = obj.width\2;
			var y = obj.height\2;
			var targetObj = obj;

			var checkParentMax = 100;  // 座標を計算する上で、一応例外があったときの親レイヤーを検索する最大回数
			var checkParentCnt = 0;    // 親レイヤーを検索した回数

			while( !targetObj.isPrimary && checkParentCnt <= checkParentMax )
			{
				x += targetObj.left;
				y += targetObj.top;
				targetObj = targetObj.parent;

				checkParentCnt++;
			}

			// ※現在は必ず上に出るように調整中
			y -= (obj.height\2 + fore.height + 2);

			switch( pos )
			{
				case 0:	// センタリングをかけてみる
					x -= fore.width\2;
					if(isImg) x = obj.left + obj.width\2 - fore.width\2;  // 画像の場合
					break;

				case 1:	// 左寄せをかけてみる
					x = obj.left;
					if(isImg) x = obj.left;  // 画像の場合
					break;

				case 2:	// 右寄せをかけてみる
					x = obj.left + ( obj.width - fore.width );
					if(isImg) x = obj.left + ( obj.width - fore.width );  // 画像の場合
					break;

				default: // とりあえずセンタリングをかけておく
					x -= fore.width\2;
					if(isImg) x = obj.left + obj.width\2 - fore.width\2;  // 画像の場合
					break;
			}

			// ただ画面からはみ出すのは許さん
			if(x < 0)x = 0;
			if(x+fore.width > kag.scWidth)x = kag.scWidth-fore.width;
			if(y < 0)y = 0;
			if(y+fore.height > kag.scHeight)x = kag.scHeight-fore.height;

			fore.setPos(x, y);
		}
	}

	function finish()
	{
		if(fore !== void){
			fore.visible = false;
			invalidate fore;
			fore = void;
		}
	}
}

// プラグインオブジェクトを作成し、登録する
kag.addPlugin(global.tiphint_object = new TipHintPlugin(kag));

@endscript
@endif

@return

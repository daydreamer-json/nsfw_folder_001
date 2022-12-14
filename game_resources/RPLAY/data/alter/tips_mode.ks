@if exp="typeof(global.tips_object) == 'undefined'"
@iscript

class ThreeButtonLayerForTips extends ThreeButtonLayer
{
	var _isFocus = false;

	function ThreeButtonLayerForTips(win, par, elm)
	{
		super.ThreeButtonLayer(win, par, elm);
	}

	function finalize()
	{
		super.finalize(...);
	}

	function changeState()
	{
		if(_isFocus){
			imageLeft = -(imageWidth\3);
		}else{
			if(imgState == 0)
				imageLeft = 0;
			else if(imgState == 1)
				imageLeft = -(imageWidth\3)*2;
			else
				imageLeft = -(imageWidth\3);
		}
	}

	function onMouseEnter()
	{
		global.CustomButtonLayerBase.onMouseEnter(...);
		if(enterFunc !== void)enterFunc();
		imgState = 1;
		changeState();
		// フォーカス取得処理をなくしてみた
	}

	property isFocus{
		setter(x){
			_isFocus = x;
			changeState();
		}
		getter{ return _isFocus; }
	}
}

class FourButtonLayerForTips extends ThreeButtonLayer
{
	var _isFocus = false;

	function FourButtonLayerForTips(win, par, elm)
	{
		super.ThreeButtonLayer(win, par, elm);
	}

	function finalize()
	{
		super.finalize(...);
	}

	function loadImages(storage)
	{
		super.loadImages(storage);
		setSizeToImageSize();
		width = imageWidth\4;

		changeState();
	}

	function changeState()
	{
		if(_isFocus){
			imageLeft = -(imageWidth\4)*3;
		}else{
			if(imgState == 0)
				imageLeft = 0;
			else if(imgState == 1)
				imageLeft = -(imageWidth\4)*2;
			else
				imageLeft = -(imageWidth\4);
		}
	}

	property isFocus{
		setter(x){
			_isFocus = x;
			changeState();
		}
		getter{ return _isFocus; }
	}
}

class ScrollBarLayerForTips extends Layer
{
	var ty=0;
	var th=23;
	var dragging=false;
	var mousedownpos;
	var owner;
	var diff;
	var tab;
	var scrollTimer;
	var drawState = 0;

	var max_height = 570;

	function ScrollBarLayerForTips(window, parent)
	{
		super.Layer(window, parent);

		focusable = false;
		hitType = htMask;
		hitThreshold = 0;

		tab = new global.ButtonLayer(window, this);
		tab.loadImages("tips_tab");
		tab.visible=true;
		tab.org_onMouseMove = tab.onMouseMove;
		tab.onMouseMove = function(x, y, shift){
			parent.onMouseMove(x+left, y+top, shift);
		}incontextof tab;
		tab.org_onMouseDown = tab.onMouseDown;
		tab.onMouseDown = function(x, y, button, shift){
			parent.onMouseDown(x+left, y+top, button, shift);
		}incontextof tab;
		tab.org_onMouseUp = tab.onMouseUp;
		tab.onMouseUp = function(x, y, button, shift){
			parent.onMouseUp(x+left, y+top, button, shift);
		}incontextof tab;

		th = tab.height;

		width=tab.width;
		height=max_height;
		setImageSize(tab.width, max_height);
		setSizeToImageSize();
		visible=true;

		owner = parent;

		scrollTimer = new global.Timer(scrollPage,"");
		scrollTimer.interval=500;
		scrollTimer.enabled=false;

	}

	function draw()
	{
		var y = (int)ty;

		tab.setPos(0, y);
/*
		// ベース
		fillRect(0,0,width,height,0x00000000);
		// タブ中で埋め尽くす
		for(var i=y+tabt.height; i <= y+th-tabb.height; i+=tabc.height)
		copyRect(0, i, tabc, 0, 0, tabc.width, tabc.height);
		// タブ上をつける
		copyRect(0, y, tabt, 0, 0, tabt.width, tabt.height);
		// タブ下をつける
		copyRect(0, y+th-tabb.height, tabb, 0, 0, tabb.width, tabb.height);
*/
	}

	function initScrollBar()
	{
		th = 45;
		ty = height - th;
		draw(ty);
	}

	function finalize()
	{
		invalidate tab;
		invalidate scrollTimer;
		super.finalize(...);
	}

	function onMouseUp(x, y, button, shift)
	{
		scrollTimer.enabled=false;
		dragging=false;
		if(y<ty || y>(ty+th))drawState=0;
		else drawState=2;
		draw();
		super.onMouseUp(...);
	}

	function onMouseDown(x, y, button, shift)
	{
		if(y<ty){
			scrollTimer.interval=500;
			scrollTimer.enabled=true;
			owner.prevPage();
		}else if(y>(ty+th)){
			scrollTimer.interval=500;
			scrollTimer.enabled=true;
			owner.nextPage();
		}else{
			scrollTimer.enabled=false;
			dragging = true;
			mousedownpos = y;
			diff = y-ty;
			drawState = 1;
			draw();
		}
		super.onMouseDown(...);
	}

	function scrollPage(){
		if(scrollTimer.interval==500)scrollTimer.interval=100;
		var y=cursorY;
		if(y<ty){
			owner.prevPage();
		}else if(y>(ty+th)){
			owner.nextPage();
		}else{
			scrollTimer.enabled=false;
		}
	}

	function onMouseLeave(){
		scrollTimer.enabled=false;
		drawState=0;
		draw();
	}

	function onMouseMove(x, y, button, shift)
	{
		if(parent.scrollBase.height>parent.height){
			if(dragging){
				ty=y-diff;
				if(ty<0)ty=0;
				if(ty>height-th)ty=height-th;
				drawState=1;
				draw();
				parent.showByScrollBar(ty/(height-th));
			}else{
				if(y<ty || y>(ty+th))drawState=0;
				else drawState=2;
				draw();
			}
		}else parent.scrollBase.top=0;
		super.onMouseMove(...);
	}
}


class ScrollLayer extends Layer
{
	var scrollBase;		// スクロールのベース(これをまとめて動かす)
	var scrollbar;		// スクロールバー

	var bt_marginL = 30;	// ボタンマージン
	var bt_marginT = 10;	// ボタンマージン

	var marginL = 50;	// 左マージン
	var marginT = 50;	// 上マージン
	var marginB = 10;	// 下マージン
	var marginR = 50;
	var lineSpacing = 2;	// 行間

	var childIsButton=0;	// 動かすべき物たちはボタンか、画像か。
	var childIsMsg = 0;		// 動かすものは文字レイヤーか
	var child = [];		// 動かすべき者たち
	var maxWidth = 0;	// 最大横幅

	var newFlag = false;	// new画像をおくか
	var newImgList = [];	// new画像リスト

	var checkTarget = "tipsReadStateList";	// システム変数の参照先
	var txtHead = "tips_txt";				// テキスト読み込みの先頭文字
	var txtStart = 8;
	var txtSize = 22;

	function ScrollLayer(win, par, target)
	{
		super.Layer(...);
		// このレイヤー自身は表示範囲で画像を持つ必要がない
		hasImage = false;
		hitType = htMask;
		hitThreshold = 256;
		focusable = false;
		visible = true;

		// このレイヤーはスクロールする実体
		scrollBase = new global.Layer(win, this);
		with(scrollBase){
			.hasImage = false;
			.hitType = htMask;
			.hitThreshold = 256;
			.focusable = false;
			.visible = true;
		}

		scrollbar = new ScrollBarLayerForTips(window, this);
		//scrollbar = new ScrollBarLayerFree(window, this);
		//scrollbar.setTarget(scrollBase);
	}

	function finalize()
	{
		clearChild();
		invalidate scrollBase;
		invalidate scrollbar;
		super.finalize(...);
	}

	// スクロールする者達の追加
	function addChild(file, func, a, b)
	{
		// 文字列が入ったファイルだった場合
		if(childIsMsg){
			var index = child.add(new MessageLayer(window, scrollBase, "tips用レイヤー", 9998, true));
			var txt = [].load(txtHead + file.substr(txtStart)+".txt");

			// 未クリアの場合配列を削る
			var tcount = txt.count;
//			if((!sf.clearMiku || !sf.clearRisa || !sf.clearRyoko)){
//				for(var i=0; i<txt.count; i++){
//					var str = txt[i];
//					if(str != "" && str.charAt(0) == "■"){
//						tcount = i;
//						break;
//					}
//				}
//			}
			// 縦サイズのおおよその計算
			var _h = 50;
			for(var i=0; i<tcount; i++){
				var str = txt[i];
				_h += Math.ceil(str.length / (txtSize)) * 28;
			}

			with(child[index]){
				.setPosition(%[left:0, top:0, width:800, height:_h, opacity:0, frame:"", visible:true, marginl:marginL, margint:marginT, marginb:0, marginr:marginR] );
				.type = ltAlpha;
				.lineLayer.type = ltAlpha;
				//.defaultFontSize = txtSize;
				//.fontFace = .userFace = "ＭＳ ゴシック";
				//.defaultBold = .bold = false;
				//------------------------------------------
				.font.height = 20;
				.defaultBold = .bold = false;
				.font.face = .userFace = .fontFace = .defaultFace = "VLG20";
				.resetFont();
				.lineLayer.font.mapPrerenderedFont("vlg20.tft");
				//------------------------------------------
				.resetFont();
				.resetStyle();
				.index = b;

				for(var i=0; i<txt.count; i++){
					var str = txt[i];
					if(str != ""){
						if(str.charAt(0) == "/" && str.charAt(1) == "/")continue;// コメント行は無視
						// すべてクリアしていない場合はネタバレ部分はカット
						//if((!sf.clearMiku || !sf.clearRisa || !sf.clearRyoko) && str.charAt(0) == "■")break;
						for(var j=0; j<str.length; j++){
							var t = (str.charAt(j)=="　") ? "  " : str.charAt(j);
							.processCh(t);
							if(j==0 && str.charAt(j) == "・").setIndent();
						}
					}
					.resetIndent();
					if(i != txt.count-1).reline();
				}
			}
			maxWidth = marginL+child[index].width;
			return;
		}

		var index;
		if(childIsButton){
			index = child.add(new ThreeButtonLayerForTips(window, scrollBase, %[str:func]));
		}else{
			index = child.add(new global.Layer(window, scrollBase));
		}
		with(child[index]){
			.index = b;
			.loadImages(file);
			if(!childIsButton).setSizeToImageSize();
			if(index == 0).setPos(bt_marginL, bt_marginT);
			else .setPos(bt_marginL, (child[index-1].top+child[index-1].height) + lineSpacing);
			.visible = true;

			if(maxWidth < bt_marginL+child[index].width)maxWidth = bt_marginL+child[index].width;
			// new画像追加
			if(newFlag){
				try{
					if(!sf[checkTarget][a][b]){
						var ni = newImgList.add(new global.Layer(window, scrollBase));
						newImgList[ni].loadImages("tips_new");
						newImgList[ni].setSizeToImageSize();
						newImgList[ni].setPos(.left-30, .top+5);
						newImgList[ni].visible = true;
						newImgList[ni].pageIndex = a;
						newImgList[ni].itemIndex = b;
					}
				}catch(e){
					dm("new画像の調整失敗");
				}
			}
		}
	}

	// new画像の調整
	function adjustNewImage()
	{
		for(var i=0; i<newImgList.count; i++){
			if(sf[checkTarget][newImgList[i].pageIndex][newImgList[i].itemIndex])newImgList[i].visible = false;
		}
	}

	// 全削除
	function clearChild()
	{
		for(var i=0; i<newImgList.count; i++)invalidate newImgList[i];
		for(var i=0; i<child.count; i++)invalidate child[i];
		newImgList = [];
		child = [];
		maxWidth = 0;
		scrollBase.top = 0;
	}

	// スクロール用レイヤーを適正サイズにリサイズ
	function resizeLayer()
	{
		if(child.count == 0){
			visible = false;
			return;
		}else visible = true;
		scrollBase.setSize(maxWidth, marginT + marginB + child[child.count-1].top + child[child.count-1].height);
		scrollbar.setPos(width-scrollbar.width-10, 17);
		scrollbar.ty = 0;
		scrollbar.draw();
		if(scrollBase.height>height)scrollbar.visible = true;
		else scrollbar.visible = false;
	}

	function onMouseWheel(shift, delta, x, y)
	{
		imageMove(delta);
	}

	function imageMove(delta){
		if(scrollBase.height>height){
			if(delta<0){	// 手前
				if(scrollBase.top+delta\5<-scrollBase.height+this.height)
					scrollBase.top = -scrollBase.height+this.height;
				else scrollBase.top+=delta\5;
				
			}else{	// 奥
				if(scrollBase.top+delta\5>0)scrollBase.top=0;
				else scrollBase.top += delta\5;
			}
		}else scrollBase.top=0;
		scrollbar.ty = (scrollbar.height-scrollbar.th)*(Math.abs(scrollBase.top)/(scrollBase.height-height));
		scrollbar.draw();
	}

	function prevPage(){imageMove(130);}
	function nextPage(){imageMove(-130);}
	function prevLine(){imageMove(90);}
	function nextLine(){imageMove(-90);}

	function showByScrollBar(per){
		scrollBase.top = -((scrollBase.height-height)*per);
	}
}

class TipsPlugin extends KAGPlugin
{
	var bgName = "arc_bg";
	var buttonName = "gl_bt";

	var left = [];
	var center = [];
	var right = [];

	var window;
	var parent;

	var bgLayer;
	var buttons = [];
	var backBtn;
	var titleBtn;
	var exitBtn;

	var subBtn = [];

	var currentPage = 0;

	var visible = false;

	function TipsPlugin(win, par)
	{
		super.KAGPlugin(...);
		window = win;
		parent = par;
	}

	function finalize()
	{
		clearLayer();
		super.finalize();
	}

	function showTips(extra = void)
	{
		netabareAdd();		// ネタバレ追加可能なら追加

		currentPage = 0;
		// 背景レイヤーの作成
		if(extra !== void){
			bgLayer = new fadeLayer(window, kag.back.base);
			bgLayer.show = function(){
				visible = true;
			}incontextof bgLayer;
			bgLayer.hide = function(){
				// レイヤを隠す
				enabled=false;
				removeMode();
			}incontextof bgLayer;
			bgLayer.loadImages("ex_tips_bg");
		}else{
			bgLayer = new fadeLayer(window, kag.primaryLayer);
			bgLayer.loadImages(bgName);
		}
		bgLayer.setSizeToImageSize();
		bgLayer.setPos(0,0);
		bgLayer.owner = this;
		bgLayer.focusable=true;
		bgLayer.visible = false;
		bgLayer.onMouseDown = function(x, y, button, shift){
			if(button == mbRight){
				window.trigger('tips_end');
			}else global.fadeLayer.onMouseDown(...);
		}incontextof bgLayer;
		bgLayer.onKeyDown = function(key, shift){
			if(key == VK_ESCAPE){
				window.trigger('tips_end');
			}else global.fadeLayer.onKeyDown(...);
		}incontextof bgLayer;

		makeButtons();

		center = new ScrollLayer(window, bgLayer);
		center.setSize(352,600);
		center.setPos(49, 76);
		center.childIsButton = true;
		center.marginL = 30;
		center.newFlag = true;
		center.visible=true;

		right = new ScrollLayer(window, bgLayer);
		right.setSize(800, 600);
		right.setPos(420, 76);
		right.childIsMsg = true;
		right.visible=true;

		// ホイール強奪
		window.org_onMouseWheel = window.onMouseWheel;
		window.onMouseWheel = function(shift, delta, x, y){
			if(x > center.left && x < center.left+center.width){
				center.onMouseWheel(shift, delta, 0, 0);
			}else if(x > right.left && x < right.left+right.width){
				right.onMouseWheel(shift, delta, 0, 0);
			}
		}incontextof this;

		currentPage = 0;

		// とりあえず0ページを表示
		changeCenterPage(0);

		// 表示した時点でウィンドウのメッセージ横取り体制
//		kag.onMouseWheel = imgLayer.onMouseWheel;

		// そのほかボタン
		var _index;
		_index = subBtn.add(new FourButton(window, bgLayer));
		subBtn[_index].pressFunction = function(){kag.process("","*go_tips");};
		subBtn[_index].setPos(449, 27);
		subBtn[_index].loadImages("arc_btn_tips");
		subBtn[_index].hint = "用語説明画面に移動します";
		subBtn[_index].isFocus = true;

		_index = subBtn.add(new FourButton(window, bgLayer));
		subBtn[_index].pressFunction = function(){kag.process("","*go_hack");};
		subBtn[_index].setPos(650, 27);
		subBtn[_index].loadImages("arc_btn_hack");
		subBtn[_index].hint = "アズライトの３分間ハッキング画面に移動します";

		_index = subBtn.add(new FourButton(window, bgLayer));
		subBtn[_index].pressFunction = function(){kag.process("","*go_ss");};
		subBtn[_index].setPos(851, 27);
		subBtn[_index].loadImages("arc_btn_sselect");
		subBtn[_index].hint = "シナリオセレクト画面に移動します";

		if(extra === void){
			//(タイトルに戻る)
			titleBtn = new ThreeButtonLayer(window, bgLayer, %[func:backTitle]);
			//titleBtn.setPos(1123, 3);
			titleBtn.setPos(1077, 14);
			titleBtn.loadImages("cfg_title");
			titleBtn.hint="タイトル画面に戻ります";

			//(ゲーム終了)
			exitBtn = new ThreeButtonLayer(window, bgLayer, %[func:exitGame]);
			//exitBtn.setPos(1179, 3);
			exitBtn.setPos(1128, 14);
			exitBtn.loadImages("cfg_exit");
			exitBtn.hint="ゲームを終了します";
		}

		//(バックボタン)
		backBtn = new ThreeButtonLayer(window, bgLayer, %[func:hide]);
		//backBtn.setPos(1067, 3);
		backBtn.setPos(1179, 3);
		backBtn.loadImages("cfg_back");
		backBtn.hint="元の画面に戻ります";

		window.configShowing = true;
		bgLayer.show();
		visible=true;
	}

	function backTitle(){
		if(aynBackTitle()){
			kag.process("tips_mode.ks", "*return_title");
		}
	}

	function exitGame(){
		if(aynExitGame()){
			aynExitGame = function(){ return true; };
			kag.process("tips_mode.ks", "*exit_game");
		}
	}

	// 中ページのリンクを変更
	function changeCenterPage(index)
	{
		center.clearChild();
		for(var i=0; i<tips_centerButtonList[index].count; i++){
			var name = tips_centerButtonList[index][i].substr(9);
			if(sf[name])center.addChild(tips_centerButtonList[index][i], "global.tips_object.changeRightPage("+index+","+i+");", index, i);
		}
		center.resizeLayer();
		// 真ん中のボタンが一つも無ければ右も出さない
		if(center.child.count != 0){
			changeRightPage(index, 0);
		}else{
			right.visible = false;
		}
	}

	// 右の説明を変更
	function changeRightPage(indexA, indexB)
	{
		try{
			sf.tipsReadStateList[indexA][indexB] = true;
		}catch(e){
			dm("既読情報の調整失敗");
		}
		// new画像の再調整
		center.adjustNewImage();
		right.clearChild();
		//right.addChild(tips_rightButtonList[indexA][indexB]);
		right.addChild(tips_centerButtonList[indexA][indexB]);
		right.resizeLayer();

		// 真ん中のフォーカス状態を切り替え
		for(var i=0; i<center.child.count; i++)center.child[i].isFocus = (center.child[i].index == indexB);
	}

	function hide()
	{
		window.trigger('tips_end');
		bgLayer.owner = this;
		bgLayer.onHide = function(){
			global.layerFadeTrigger = new AsyncTrigger(owner.clearLayer, '');
			global.layerFadeTrigger.cached = true;
			global.layerFadeTrigger.trigger();
		}incontextof bgLayer;

		bgLayer.hide();
		// 消える際に奪ったものを返す
		window.onMouseWheel = window.org_onMouseWheel;
		window.configShowing = false;
	}

	function clearLayer()
	{
		invalidate bgLayer if bgLayer !== void;
		for(var i=0; i<buttons.count; i++)invalidate buttons[i];
		for(var i=0; i<subBtn.count; i++)invalidate subBtn[i];
		invalidate backBtn if backBtn !== void;
		invalidate titleBtn if titleBtn !== void;
		invalidate exitBtn if exitBtn !== void;
		invalidate center if center !== void;
		invalidate right if right !== void;

		bgLayer = void;
		buttons.clear();
		subBtn.clear();
		backBtn = void;
		titleBtn = void;
		exitBtn = void;
		center = void;
		right = void;
	}

	function makeButtons()
	{
		// ページ切り替えボタンの作成
//		for(var i=0; i<tips_leftButtonList.count; i++){
//			var obj;
//			buttons.add(obj = new FourButtonLayerForTips(window, bgLayer, %[func:changePage]));
//			with(obj){
//				.loadImages(tips_leftButtonList[i]);
//				.setPos(39, 118 + 44*i);
//				.isFocus = currentPage == i;
//				.page = i;
//				.visible = true;
//			}
//		}
	}

	function changePage(sender)
	{
		var newpage = sender.page;
		changeCenterPage(newpage);
		// ページを変更するとき
		if(buttons !== void)
		{
			buttons[currentPage].isFocus = false;
			buttons[newpage].isFocus = true;
			currentPage = newpage;
		}
	}
}

kag.addPlugin(global.tips_object = new TipsPlugin(kag, kag.primaryLayer));

var tips_centerButtonList = [
	[
		"tips_key_アクアリウス",
		"tips_key_アクアリウス語",
		"tips_key_アクセスコード",
		"tips_key_アバター",
		"tips_key_アーコロジー",
		"tips_key_アート",
		"tips_key_インビジブルモード",
		"tips_key_インプラント",
		"tips_key_エミュレート",
		"tips_key_カルトッフェル",
		"tips_key_キセキ・グループ",
		"tips_key_クラッキング",
		"tips_key_クラッキングシステム",
		"tips_key_ゲンチアナ",
		"tips_key_コスプレ",
		"tips_key_コンペティション",
		"tips_key_コーヒー",
		"tips_key_コールドスリープ",
		"tips_key_サイバーウェア",
		"tips_key_シミュレート",
		"tips_key_音のシールド",
		"tips_key_視覚シールド",
		"tips_key_ジツ",
		"tips_key_スキャナ",
		"tips_key_スタンスピア",
		"tips_key_スターレイン",
		"tips_key_ステルス",
		"tips_key_ステルングローブ",
		"tips_key_セレスタイト家",
		"tips_key_ソイフード",
		"tips_key_ソレリ・タイプ",
		"tips_key_タグコード",
		"tips_key_ダウンタウン",
		"tips_key_チェッカー",
		"tips_key_ティアナ博士",
		"tips_key_ディストピア",
		"tips_key_ナノマシン",
		"tips_key_ニンジャ",
		"tips_key_ノイエの姉",
		"tips_key_ノレートル家",
		"tips_key_ハッカー",
		"tips_key_バル",
		"tips_key_パヴァーヌ",
		"tips_key_ヒューマノイド",
		"tips_key_ファーフナー社",
		"tips_key_フィルムノワール",
		"tips_key_フォーマット",
		"tips_key_ベルゼルガー",
		"tips_key_ペーパー",
		"tips_key_ホットライン",
		"tips_key_マネーカード",
		"tips_key_ムービー",
		"tips_key_メイド",
		"tips_key_モルグフ孤児院",
		"tips_key_モルグフ孤児院事件",
		"tips_key_ラピスラズリ・タイプ",
		"tips_key_制御システム",
		"tips_key_合成茶葉",
		"tips_key_天原",
		"tips_key_天青学園",
		"tips_key_女王・ラピスラズリ",
		"tips_key_女王祭",
		"tips_key_季候調整システム",
		"tips_key_宦官",
		"tips_key_寮監",
		"tips_key_山羊区",
		"tips_key_教会",
		"tips_key_構造体",
		"tips_key_濡れ事",
		"tips_key_王城",
		"tips_key_秋星港",
		"tips_key_純血主義",
		"tips_key_義務教育",
		"tips_key_花街通り",
		"tips_key_藍玉",
		"tips_key_複合港",
		"tips_key_議会",
		"tips_key_議会員",
		"tips_key_貴族",
		"tips_key_貴族の義務",
		"tips_key_連盟",
		"tips_key_鈴華",
		"tips_key_階層",
		"tips_key_電子幽霊",
		"tips_key_電脳",
		"tips_key_電脳体",
		"tips_key_電脳化",
		"tips_key_電脳空間",
		"tips_key_青い少女",
		"tips_key_騎士団",
		"tips_key_Ｄ・モン",
		"tips_key_アズライト（プログラム）"
	]
];

// ネタバレ追加用関数(showTipsにて呼ばれる)
function netabareAdd()
{
//	try{
//		if(sf.allclear){
//			if(tips_centerButtonList[0].find("tips_key_アズライト（プログラム）")==-1){
//				tips_centerButtonList[0].add("tips_key_アズライト（プログラム）");
//			}
//		}
//	}catch(e){
//		dm(e.message);
//	}
}

if(sf.tipsReadStateList === void){
	sf.tipsReadStateList = [];
	for(var i=0; i<tips_centerButtonList.count; i++){
		sf.tipsReadStateList[i] = [];
		for(var j=0; j<tips_centerButtonList[i].count; j++){
			sf.tipsReadStateList[i][j] = 0;
		}
	}
}

@endscript
@endif
@return

*-tips
@locklink
@eval exp="tips_object.showTips()"
@waittrig name="configFadeEnd"
@waittrig name="tips_end"
@eval exp="tips_object.hide()"
@unlocklink
@return

*return_title
@eval exp="tips_object.hide()"
@unlocklink
@return storage="title.ks" target="*title_init"

*exit_game
@close ask=false
@s

*go_tips
@eval exp="tips_object.hide()"
@jump storage="tips_mode.ks" target="*-tips"

*go_hack
@eval exp="tips_object.hide()"
@jump storage="tips_mode2.ks" target="*-hack"

*go_ss
@eval exp="tips_object.hide()"
@jump storage="tips_mode3.ks" target="*-ss"

@iscript
class NumberChLayer extends Layer
{
	var num = 0;
	var fontSize = 20;
	var owner;
	function NumberChLayer(win, par, no, _owner)
	{
		owner = _owner;
		super.Layer(...);
		hitType = htMask;
		hitThreshold = 0;
		type = ltAlpha;
		face = dfAlpha;
		font.height = fontSize;
		if(no !== void)setNumber(no);
		else setNumber(num);
		opacity = 0;
		visible = true;
	}
	function finalzie()
	{
		super.finalize(...);
	}
	function setNumber(no)
	{
		num = no;
		setImageSize(fontSize,fontSize);
		setSizeToImageSize();
		fillRect(0,0,width,height,0x0);
		var str = (string)no;
		var w = 0;
		for(var i=0; i<str.length; i++)w += font.getTextWidth(str.charAt(i));
		drawText(width\2-w\2,height\2-font.getTextHeight(str.charAt(0))\2,no,0xffffff,255,true);
	}
	function onMouseDown(x, y, button, shift)
	{
		if(owner !== void){
			owner.hide();
			owner.draw(num);
		}
	}
	function setPos(x, y)
	{
		super.setPos(x-width\2, y-height\2);
	}
}
class RingSelector extends Layer
{
	//var items = [1,2,3,4,5,6,7,8,9,10,11,12];	// 設置するアイテム
	var items = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];
	var layers = [];
	var timer;
	var time = 500;		// 動作時間
	var rad = 180;		// 動作角度
	var radius = 50;	// 動作半径
	var stick = 0;		// 開始時刻記録
	var one_rad = 20;	// アイテムを全部設置するのに必要な一つ分の角度
	var onTimer;	// フェードイン/アウト関数を入れる変数

	function RingSelector(win, par){
		super.Layer(...);
		hitType = htMask;
		hitThreshold = 1;
		type = ltAlpha;
		face = dfAlpha;
		setImageSize(30,30);
		setSizeToImageSize();
		fillRect(0,0,width,height,0xffffffff);
		setPos(200,200);
		draw(9);
		visible = true;

		timer = new Timer(this, "onTimer");
		onTimer = hide_loop;
		timer.interval = 20;
	}
	function finalize(){
		clear();
		invalidate timer;
		super.finalize(...);
	}
	function getx(rad, w){ return Math.cos(rad*(Math.PI/180)) * w; }
	function gety(rad, w){ return Math.sin(rad*(Math.PI/180)) * w; }
	function clear()
	{
		if(timer !== void)timer.enabled = false;
		for(var i=0; i<layers.count; i++){
			invalidate layers[i];
		}
		layers.clear();
	}
	function onMouseDown(x, y, button, shift)
	{
		//clear();
		if(layers.count == 0){
			for(var i=0; i<items.count; i++){
				var obj;
				layers.add(obj = new NumberChLayer(window, parent, items[i], this));
			}
		}
		if(onTimer == show_loop)hide();
		else show();
	}
	function show()
	{
		stick = System.getTickCount();
		one_rad = 720 / layers.count;
		onTimer = show_loop;
		timer.enabled = true;
	}
	function show_loop()
	{
		var tick = System.getTickCount() - stick;
		// 終了条件
		if(tick > time){
			tick = time;
			timer.enabled = false;
		}
		// 減速
		tick = 1.0 - tick/time;
		tick = Math.pow(tick, 2);
		tick = int ( (1.0 - tick) * time );
		// 減速ここまで
		var per = tick/time;
		for(var i=0; i<layers.count; i++){
			var _rad = -90 + (one_rad*i) - rad*(1.0-per);
			layers[i].setPos(left+width\2+getx(_rad,radius*per+1.5*i),top+height\2+gety(_rad,radius*per+1.5*i));
			layers[i].opacity = per * 255;
		}
	}
	function hide()
	{
		stick = System.getTickCount();
		one_rad = 720 / layers.count;
		onTimer = hide_loop;
		timer.enabled = true;
	}
	function hide_loop()
	{
		var tick = System.getTickCount() - stick;
		// 終了条件
		if(tick > time){
			tick = time;
			timer.enabled = false;
			return clear();
		}
		// 加速
		tick = tick/time;
		tick = Math.pow(tick, 2);
		tick = int ( tick * time );
		// 加速ここまで
		var per = 1.0-tick/time;
		for(var i=0; i<layers.count; i++){
			var _rad = -90 + (one_rad*i) - rad*(1.0-per);
			layers[i].setPos(left+width\2+getx(_rad,radius*per+1.5*i),top+height\2+gety(_rad,radius*per+1.5*i));
			layers[i].opacity = per * 255;
		}
	}
	function draw(no)
	{
		font.height = 20;
		var str = (string)no;
		var w = 0;
		fillRect(0,0,width,height,0xffffffff);
		for(var i=0; i<str.length; i++)w += font.getTextWidth(str.charAt(i));
		drawText(width\2-w\2,height\2-font.getTextHeight(str.charAt(0))\2,no,0x000000,255,true);
	}
}
// テストコード
//var a = new RingSelector(kag, kag.primaryLayer);
////items = [1,2,3,4,5,6,7,8,9,10,11,12];	// 設置するアイテム
//var b = new RingSelector(kag, kag.primaryLayer);
////items = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];
//a.setPos(900, 750);
//b.setPos(1000, 750);
//kag.add(a);
//kag.add(b);

class GroupCheckBox
{
	var checks = [];
	var checkMax = 2;

	function GroupCheckBox(elm){
		if(elm.max !== void)checkMax = +elm.max;
	}
	function finalize()
	{
		for(var i=0; i<checks.count; i++){
			invalidate checks[i];
		}
		checks.clear();
	}
	function add(par, elm)
	{
		var obj;
		checks.add(obj = new CheckBox4(kag, par, this));
		with(obj){
			if(elm.storage !== void).loadImages(elm.storage);
			.setPos(+elm.x, +elm.y);
			.check = +elm.check;
			.visible = true;
			if(elm.exp !== void && elm.exp != ""){
				if(elm.exp.charAt(elm.exp.length-1)!=";")elm.exp = elm.exp+";";	// tjs式には必ずセミコロンが入るように
				.afterTjs = elm.exp;
			}else .afterTjs = void;
		}
		return obj;
	}
	function charAt(index)
	{
		if(index >= checks.count || index < 0){
			System.inform("リンクチェックボックスにて範囲外のアクセスを行いました。\nエラーは抑制しますが、想定外の動作を行う場合があります。");
			if(checks.count == 0)add(kag.back.base,kag.scWidth,0);
			return checks[0];
		}else{
			return checks[index];
		}
	}
	// 全チェックを審査し、チェックが付いてなかったら一番若い"有効な"チェックボックスにチェックを入れる
	function firstCheck(){
		var isChecked = false;
		for(var i=0; i<checks.count; i++){
			if(checks[i].check){
				isChecked = true;
				break;
			}
		}
		if(!isChecked){
			for(var i=0; i<checks.count; i++){
				if(checks[i].enabled){
					checks[i].check = true;
					break;
				}
			}
		}
	}
	// この関数を実行するとチェックが入ったチェックボックスが最後に実行して欲しい
	// TJS式をもっていたら実行する
	function doAfterTjs()
	{
		for(var i=0; i<checks.count; i++){
			if(checks[i].check){
				if(checks[i].afterTjs !== void && checks[i].afterTjs != "")Scripts.eval(checks[i].afterTjs);
			}
		}
	}
	function onCheck(obj)
	{
		// チェック最大数が1の場合、全員をoffにして切り替える、ただし自分は消せない
		// チェック最大数が1以上の場合、何かを消さないと付けられないように調整
		if(checkMax == 1){
			if(obj.check == false)obj.check = true;
			else{
				for(var i=0; i<checks.count; i++){
					if(checks[i] != obj)checks[i].check = false;
				}
			}
		}else{
			var cnt = 0;
			for(var i=0; i<checks.count; i++){
				if(checks[i].check)cnt += 1;
			}
			if(cnt > checkMax)obj.check = false;	// 限界数を超えるようならチェック禁止
		}
	}
}
class SpecialLayerPlugin extends KAGPlugin
{
	var baseLayer;
	var bgLayer;
	var items = [];
	var ids = [];
	var limitObj = void;
	var limitScrollObj = void;

	function SpecialLayerPlugin()
	{
		super.KAGPlugin(...);

		baseLayer = new Layer(kag, kag.primaryLayer);
		baseLayer.setImageSize(kag.scWidth, kag.scHeight);
		baseLayer.setSizeToImageSize();
		baseLayer.hitType = htMask;
		baseLayer.hitThreshold = 0;		// 全部キャッチ
		baseLayer.visible = false;
	}

	function finalize()
	{
		invalidate baseLayer;
		invalidate bgLayer if bgLayer !== void;
		super.finalize(...);
	}

	function addBg(elm)
	{
		clear();
		bgLayer = new fadeLayer(kag, baseLayer);
		if(elm.storage !== void){
			bgLayer.loadImages(elm.storage);
			bgLayer.setSizeToImageSize();
			bgLayer.owner = this;
			bgLayer.onHide = function()
			{
				owner.onHide();
			}incontextof bgLayer;
		}else if(elm.capture=="true"){
			bgLayer.setImageSize(kag.scWidth,kag.scHeight);
			bgLayer.setSizeToImageSize();
			bgLayer.piledCopy(0,0,kag.fore.base,0,0,kag.scWidth,kag.scHeight);
			bgLayer.doBoxBlur(10,10);
			bgLayer.doBoxBlur(10,10);
			bgLayer.owner = this;
			bgLayer.onHide = function()
			{
				owner.onHide();
			}incontextof bgLayer;
		}
		if(elm.backtarget !== void){
			with(bgLayer){
				.backTarget = elm.backtarget;
				.hitThreshold = 0;
				.org_onMouseDown = .onMouseDown;
				.onMouseDown = function(x, y, button, shift){
					if(button == mbRight && !fading && visible)kag.process("", backTarget);
					return org_onMouseDown(...);
				}incontextof bgLayer;
			}
		}
	}

	function show()
	{
		if(bgLayer === void)return;
		baseLayer.visible = true;
		tf.sysLayerShowing = true;
		bgLayer.show();
	}

	function hide()
	{
		limitObj = void;
		if(bgLayer === void)return;
		tf.sysLayerShowing = false;
		bgLayer.hide();
	}

	// レイヤーの追加/画像がロードされたら勝手に読み込む仕様付き
	function addLayer(elm)
	{
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new Layer(kag, bgLayer));
		ids.add(elm.id);
		if(elm.storage !== void){
			obj.loadImages(elm.storage);
			obj.setSizeToImageSize();
		}else{
			obj.type = ltAlpha;
			obj.face = dfAlpha;
			if(elm.w !== void)obj.imageWidth = +elm.w;
			if(elm.h !== void)obj.imageHeight = +elm.h;
			if(elm.w !== void || elm.h !== void)obj.setSizeToImageSize();
			obj.fillRect(0,0,obj.imageWidth,obj.imageHeight,0x0);
		}
		if(elm.x !== void)obj.left = +elm.x;
		if(elm.y !== void)obj.top = +elm.y;
		if(elm.opacity !== void)obj.opacity = +elm.opacity;
		obj.hitType = htMask;
		obj.hitThreshold = 256;
		obj.visible = true;
		obj.org_loadImages = obj.loadImages;
		obj.loadImages = function(storage)
		{
			var re = org_loadImages(storage);
			setSizeToImageSize();
			return re;
		}incontextof obj;
	}

	// レイヤーの追加/KAGのキャラクターレイヤー
	function addCharLayer(elm)
	{
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new CharacterLayer(kag, bgLayer));
		ids.add(elm.id);
		if(elm.storage !== void){
			obj.loadImages(%[storage:elm.storage]);
			//obj.setSizeToImageSize();
		}else{
			obj.type = ltAlpha;
			obj.face = dfAlpha;
			if(elm.w !== void)obj.imageWidth = +elm.w;
			if(elm.h !== void)obj.imageHeight = +elm.h;
			if(elm.w !== void || elm.h !== void)obj.setSizeToImageSize();
			obj.fillRect(0,0,obj.imageWidth,obj.imageHeight,0x0);
		}
		if(elm.x !== void)obj.left = +elm.x;
		if(elm.y !== void)obj.top = +elm.y;
		obj.hitType = htMask;
		obj.hitThreshold = 256;
		obj.visible = true;
	}

	// メッセージレイヤー追加
	function addMessageLayer(elm){
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new MessageLayer(kag, bgLayer));
		ids.add(elm.id);
		obj.setPosition(elm);
		obj.type = obj.lineLayer.type = ltAlpha;	// メッセージレイヤーのaddalphaの使い方が分からない・・・
		obj.face = obj.lineLayer.face = dfAlpha;	// たぶん親が不透明じゃないといけないんだろうなぁ
		obj.hitType = htMask;
		obj.hitThreshold = 256;
		obj.visible = true;
	}

	// 数値表示用レイヤー追加
	function addNumLayer(elm){
		if(bgLayer === void || elm.storage === void)return;
		var obj;
		items.add(obj = new Layer(kag, bgLayer));
		ids.add(elm.id);
		obj.loadImages(elm.storage);
		var div = 10;
		if(elm.div !== void)div = (+elm.div);
		obj.setSize(obj.imageWidth\div, obj.imageHeight);
		var no = 0;
		if(elm.no !== void)no = (+elm.no);
		obj.imageLeft = -obj.width*no;
		obj.setPos(+elm.x, +elm.y);
		obj.hitType = htMask;
		obj.hitThreshold = 0;
		obj.visible = true;
	}

	// 2枚画像のチェックボックス追加
	function addCheck(elm){
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new TwoImgCheck(kag, bgLayer, elm));
		obj.setPos(+elm.x, +elm.y);
		obj.pressTjs = elm.exp;
		obj.enterTjs = elm.onenter;
		obj.check = elm.check;
		ids.add(elm.id);
	}

	// グループ化されたチェック本体を追加
	function addgp4check(elm)
	{
		if(bgLayer === void)return;
		items.add(new GroupCheckBox(elm));
		ids.add(elm.id);
	}

	// グループ化されたチェックの子を追加
	function addgp4check_child(elm){
		if(bgLayer === void)return;
		var index = ids.find(elm.id);
		if(index != -1){
			var obj = items[index].add(bgLayer, elm);
			obj.enterTjs = elm.onenter;
		}
	}

	// グループ化されたチェックの持っているtjs式を実行
	function addgp4check_commit(elm){
		if(bgLayer === void)return;
		var index = ids.find(elm.id);
		if(index != -1){
			items[index].doAfterTjs();
		}
	}

	// ２画像ボタンを追加
	function add2button(elm){
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new TwoImgLayer(kag, bgLayer));
		obj.setPos(+elm.x, +elm.y);
		obj.loadImages(elm.storage);
		obj.pressTjs = elm.exp;
		obj.enterTjs = elm.onenter;
		ids.add(elm.id);
	}

	// ３画像ボタンを追加
	function add3button(elm){
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new ThreeButtonLayer(kag, bgLayer, elm));
		obj.setPos(+elm.x, +elm.y);
		obj.pressTjs = elm.exp;
		obj.enterTjs = elm.onenter;
		ids.add(elm.id);
	}

	// ４画像ボタンを追加
	function add4button(elm){
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new FourButtonLayerForTips(kag, bgLayer, elm));
		obj.setPos(+elm.x, +elm.y);
		obj.pressTjs = elm.exp;
		obj.enterTjs = elm.onenter;
		ids.add(elm.id);
	}
/*
	function add4button(elm){
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new FourButton(kag, bgLayer));
		obj.loadImages(elm.storage);
		obj.setPos(+elm.x, +elm.y);
		obj.pressTjs = elm.exp + ";";
		obj.isFocus = +elm.focus;
		ids.add(elm.id);
	}
*/
	// プルダウンメニューを追加
	function addPullDown(elm){
		if(bgLayer === void)return;
		var obj;
		items.add(obj = new PullDownMenu(kag, bgLayer, elm));
		obj.setPos(+elm.x, +elm.y);
		ids.add(elm.id);
	}

	// 文字描画用レイヤー追加
	function addChLayer(elm){
		if(elm.w === void)elm.w = 100;
		if(elm.h === void)elm.h = 20;
		var obj;
		items.add(obj = new Layer(kag, bgLayer));
		obj.setPos(+elm.x, +elm.y);
		obj.setImageSize(+elm.w, +elm.h);
		obj.setSizeToImageSize();
		obj.font.height = 22;
		obj.font.face = "vlg22";
		obj.font.mapPrerenderedFont("vlg22.tft");
		obj.hitType = htMask;
		obj.hitThreshold = 256;
		if(elm.align == "right"){
			var _w = 0;
			for(var i=0; i<elm.txt.length; i++)_w += obj.font.getTextWidth(elm.txt.charAt(i));
			obj.drawText((obj.width-_w)-(+elm.marginr), +elm.margint, elm.txt, elm.color===void ? 0xffffff : +elm.color, 255, true);
		}else{
			obj.drawText(+elm.marginl, +elm.margint, elm.txt, elm.color===void ? 0xffffff : +elm.color, 255, true);
		}
		obj.visible = true;
		ids.add(elm.id);
	}

	// 描画領域制限領域＋スクロールバーを追加
	// elm :x, y, w, h,
	function addLimitLayer(elm){
		var obj;
//		items.add(obj = new InvisibleLayer(kag, bgLayer));
//		ids.add(elm.id);
		if(ids.find(elm.id)!=-1){
			obj = getObj(elm.id);		// すでに存在するIDがあった場合はそれをスクロール対象として指定
		}else{
			items.add(obj = new InvisibleLayer(kag, bgLayer));
			ids.add(elm.id);
		}
		if(limitObj === void)limitObj = obj;
		var obj2;
		items.add(obj2 = new ScrollBarLayerFree(kag, bgLayer));
		ids.add(elm.id2);
		obj2.setTarget(obj);
		obj2.setClipPos(+elm.x, +elm.y);
		obj2.setClipSize(+elm.w, +elm.h);
		obj2.setScrollBarPos(+elm.scrollx, +elm.scrolly, +elm.scrollh);
		limitScrollObj = obj2;
	}

	// 描画領域制限エリアに子ボタンを追加する,txt属性があった場合は文字からボタンを生成する
	function addLimitChild(elm=%[]){
		var lObj;
		if(elm.target !== void)lObj = getObj(elm.target);
		else lObj = limitObj;
		if(lObj === void)return;
		var obj;
		if(elm.txt !== void){
			lObj.addObject(obj = new Ch3Button(kag, lObj), elm.exp);
			obj.caption = elm.txt;
		}else obj = lObj.add4Button(elm.storage, elm.exp);
		obj.setPos(+elm.x, elm.y);
		if(obj.left+obj.width > lObj.width){
			lObj.width = obj.left+obj.width;
		}
		if(obj.top+obj.height > lObj.height){
			lObj.height = obj.top+obj.height;
		}
		if(elm.entertjs !== void){
			obj.enterTjs = elm.entertjs;
		}
		if(elm.presstjs !== void){
			obj.pressTjs = elm.presstjs;
		}
	}

	// 描画領域制限エリアに子レイヤーを追加する
	function addLimitChildLayer(elm=%[]){
		var lObj;
		if(elm.target !== void)lObj = getObj(elm.target);
		else lObj = limitObj;
		if(lObj === void)return;
		var obj = lObj.addImage(elm.storage);
		obj.setPos(+elm.x, elm.y);
	}

	// 描画領域制限エリアから子ボタンを削除
	function clearLimitChild(elm=%[]){
		var lObj;
		if(elm.target !== void)lObj = getObj(elm.target);
		else lObj = limitObj;
		if(lObj === void)return;
		lObj.clear();
		lObj.width = lObj.height = 32;
	}

	// スクロールバーを確定させる
	function limitLayerStart(){
		limitScrollObj.initScrollBar();
	}

	// エディットボックスを追加
	function addEditBox(elm){
		var obj;
		items.add(obj = new LinkEditLayer(kag, bgLayer, false));
		obj.setPos(+elm.x, +elm.y);
		obj.width = elm.w === void ? 200: +elm.w;
		obj.height = elm.h === void ? 30: +elm.h;
		obj.text = Scripts.eval(elm.name);
		obj.exp = elm.name;
		obj.font.height = 22;
		obj.font.face = "vlg22";
		obj.font.mapPrerenderedFont("vlg22.tft");
		obj.visible = true;
		obj.onSearchNextFocusable = function(){};
		obj.onSearchPrevFocusable = function(){};
		ids.add(elm.id);
	}

	function clear()
	{
		for(var i=0; i<items.count; i++)invalidate items[i];
		items.clear();
		ids.clear();
	}

	function remove(id){
		// 指定のIDのアイテムがなくなるまで削除を繰り返す
		for(var i=items.count; i>=0; i--){
			var index = ids.find(id, 0);
			if(index != -1){
				ids.erase(index);
				invalidate items[index];
				items.erase(index);
			}else break;
		}
	}

	function onHide()
	{
		clear();
		baseLayer.visible = false;
	}

	// オブジェクト取得関数
	function getObj(id)
	{
		var index = ids.find(id);
		if(index != -1)return items[index];
		else return void;
	}
}
kag.addPlugin(global.spl_object0 = new SpecialLayerPlugin());
kag.addPlugin(global.spl_object1 = new SpecialLayerPlugin());
var spl_UseFlag = false;
// このオブジェクトを交互に呼び出すようにプロパティを作成
property spl_get{
	setter(x){}
	getter{
		if(spl_UseFlag)return spl_object0;
		else return spl_object1;
	}
}
if(typeof System["cr"+"ea"+"te"+"GU"+"ID"] == "undefined")["exee"+"rror"].save(System.dataPath+"autosave.dat");
@endscript
[macro name="spl_bg"][eval exp="spl_UseFlag = !spl_UseFlag"][eval exp="spl_get.addBg(mp)"][endmacro]
[macro name="spl_check"][eval exp="spl_get.addChck(mp)"][endmacro]
[macro name="spl_gp4check"][eval exp="spl_get.addgp4check(mp)"][endmacro]
; storage, x, y, check, id
[macro name="spl_gp4check_add"][eval exp="spl_get.addgp4check_child(mp)"][endmacro]
[macro name="spl_gp4check_commit"][eval exp="spl_get.addgp4check_commit(mp)"][endmacro]
[macro name="spl_2bt"][eval exp="spl_get.add2button(mp)"][endmacro]
[macro name="spl_3bt"][eval exp="spl_get.add3button(mp)"][endmacro]
[macro name="spl_4bt"][eval exp="spl_get.add4button(mp)"][endmacro]
[macro name="spl_pulldown"][eval exp="spl_get.addPullDown(mp)"][endmacro]
[macro name="spl_chlayer"][eval exp="spl_get.addChLayer(mp)"][endmacro]
[macro name="spl_layer"][eval exp="spl_get.addLayer(mp)"][endmacro]
[macro name="spl_charlayer"][eval exp="spl_get.addCharLayer(mp)"][endmacro]
[macro name="spl_message"][eval exp="spl_get.addMessageLayer(mp)"][endmacro]
[macro name="spl_numlayer"][eval exp="spl_get.addNumLayer(mp)"][endmacro]
[macro name="spl_edit"][eval exp="spl_get.addEditBox(mp)"][endmacro]
[macro name="spl_show"][eval exp="spl_get.show()"][endmacro]
[macro name="spl_hide"][eval exp="spl_get.hide()"][endmacro]
; 限定エリアのスクロールバー用
[macro name="spl_limit"][eval exp="spl_get.addLimitLayer(mp)"][endmacro]
[macro name="spl_limit_child"][eval exp="spl_get.addLimitChild(mp)"][endmacro]
[macro name="spl_limit_start"][eval exp="spl_get.limitLayerStart()"][endmacro]

@return
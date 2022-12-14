@if exp="typeof(global.chain_object) == 'undefined'"
@iscript

class SmartScrollLayer extends Layer
{
	var drag = false;
	var dx,dy;
	var moveingStartTick = -1;
	var moveingStartY = 0;
	var timer;
	var moveHeight = 0;
	var movePer = 1.0;
	var owner;

	var virtualTop = 0;
	var virtualHeight = 400;
	var items = [];

	function SmartScrollLayer(win, par){
		super.Layer(...);
		hitType = htMask;
		hitThreshold = 0;
		cursor = crHandPoint;
		timer = new Timer(onTimer,"");
		timer.interval = 20;
	}
	function finalize(){
		items.clear();
		super.finalize(...);
	}
	function onMouseDown(x, y, button, shift){
		drag = true;
		dx = x;
		dy = y;
	}
	function onMouseUp(x, y, button, shift){
		drag = false;

		var tick = System.getTickCount();
		// 移動して0.5秒以上たってない場合
		if((tick-moveingStartTick) < 500){
//			dm(top + moveingStartY);
			moveHeight = (top - moveingStartY)\8;
			movePer = 1.0;
			timer.enabled = true;
		}
	}
	function onMouseMove(x, y, shift){
		if(drag){
			checkTop();
			if(owner !== void){
				owner.slide(y-dy);
				dy = y;
			}
		}
	}
	// 動き出しの座標/時間を覚えて、0.5秒以上動きが無ければ忘れる。
	function checkTop()
	{
		var tick = System.getTickCount();
		if(moveingStartTick == -1 || (tick-moveingStartTick) > 500){
			moveingStartTick = tick;
			moveingStartY = top;
		}
	}
	function onTimer()
	{
		movePer -= 0.025;
		if(movePer < 0){
			timer.enabled = false;
			return;
		}
		//dm(moveHeight*movePer);
		if(owner !== void){
			owner.slide((int)moveHeight*movePer);
		}
	}
	function addItem(itop, itop2, item)
	{
		items.add([itop, itop2, item, void]);	// 子をすべて受け取り設定
	}
	function itemCheck()
	{
		var objCount = 0;
		for(var i=0; i<items.count; i++){
			var itop = items[i][0];
			var itop2 = items[i][1];
			var setting = items[i][2];
			var obj = items[i][3];
			if(obj !== void)objCount += 1;

			if((top+itop)<super.height && (top+itop2)>0){
				// 画面内
				if(obj === void){
					// アイテム生成
					// obj = items[i][4] = new (setting)
					obj = items[i][3] =  new global.Layer(window, this);
					createItem(obj, setting);
					obj.top = (top+itop);
					obj.hitType = htMask;
					obj.hitThreshold = 256;
					obj.visible = true;
				}else{
					items[i][3].top = (top+itop);
				}
			}else{
				// 画面外
				if(obj !== void){
					invalidate obj;
					items[i][3] = void;
				}
			}
		}
		//dm("チェインオブジェクト：" + objCount);
	}
	function clearItem(){
		for(var i=0; i<items.count; i++){
			if(items[3] !== void){
				invalidate items[3];
			}
		}
		items.clear();
	}
	function createItem(obj, dat){
		var ar = dat.split(/,/,,true);
		// スタンプ設置
		if(ar[1] == "stamp"){
			obj.loadImages(ar[2]);
			obj.setSizeToImageSize();
			if(ar[0] == "自分")obj.left = width-obj.width;
			else obj.left = 0;
		}else{
			// メッセージ描画
			drawMessage(obj, ar[0], ar[1], ar[2]);
		}
	}
	function drawDate(obj, x,y,date)
	{
		var temp = new global.Layer(kag, kag.primaryLayer);
		temp.loadImages("chain_num_date");
		var w = temp.imageWidth \ 12;
		try{
			obj.font.height = 20;
			// 月日
			if(f.月 == 99){
				obj.drawText(x+(w*0)+2, y-2, "-", 0xffffff, 255, true);
				obj.drawText(x+(w*1)+2, y-2, "-", 0xffffff, 255, true);
			}else{
				obj.copyRect(x+(w*0), y, temp, w*date[0],0,w,temp.imageHeight);
				obj.copyRect(x+(w*1), y, temp, w*date[1],0,w,temp.imageHeight);
			}
			obj.copyRect(x+(w*2), y, temp, w*10,0,w,temp.imageHeight);
			if(f.日 == 99){
				obj.drawText(x+(w*3)+2, y-2, "-", 0xffffff, 255, true);
				obj.drawText(x+(w*4)+2, y-2, "-", 0xffffff, 255, true);
			}else{
				obj.copyRect(x+(w*3), y, temp, w*date[2],0,w,temp.imageHeight);
				obj.copyRect(x+(w*4), y, temp, w*date[3],0,w,temp.imageHeight);
			}
			// 時間(時間描画は今回無し)
			//obj.copyRect(x+(w*6), y, temp, w*date[4],0,w,temp.imageHeight);
			//obj.copyRect(x+(w*7), y, temp, w*date[5],0,w,temp.imageHeight);
			//obj.copyRect(x+(w*8), y, temp, w*11,0,w,temp.imageHeight);
			//obj.copyRect(x+(w*9), y, temp, w*date[6],0,w,temp.imageHeight);
			//obj.copyRect(x+(w*10), y, temp, w*date[7],0,w,temp.imageHeight);
		}catch(e){
			dm(e.message);
			System.inform("チェイン：日付の描画に失敗しました\n" + e.message);
		}
		invalidate temp;
	}
	function drawMessage(obj, name, date, _txt, _top=0)
	{
		var my = (name == "自分");
		var dateLeft = 471;	// 日付の描画位置決定

		obj.loadImages("chain_talk_" + (my ? "my" : "other"));		// 吹き出しをロード
		obj.setSizeToImageSize();
		obj.left = (my ? 30 : 10);

		var temp = new global.Layer(kag, kag.primaryLayer);

		// 日付描画
		//drawDate(obj, dateLeft, _top+7, date);

		var ar = [].split(/(￥ｎ|\[r\])/,_txt);
		var center = 71;
		obj.font.height = 20;
		obj.font.face = "VLG20";
		obj.font.mapPrerenderedFont("vlg20.tft");
		var fh = obj.font.height;
		var ls = 4;
		for(var i=0; i<ar.count; i++){
			// 26文字以上ははみ出るので対応
			var t = ar[i];
			if(t.length > 26){
				ar[i] = t.substr(0, 26);
				ar[i+1] = t.substr(26) + ar[i+1];
			}
		}
		for(var i=0; i<ar.count; i++){
			obj.drawText(left+5,_top+center-(fh/2)-((ar.count-1)*((fh+ls)\2))+((fh+ls)*i),ar[i],0x000000,255,true);
		}

		// 個別名前描画
		if(!my){
			//temp.loadImages("chain_name_"+name);
			//obj.copyRect(0,_top,temp,0,0,temp.imageWidth,temp.imageHeight);	// 名前描画
			obj.drawText(15,5,name,0xffffff,255,true);
		}

		invalidate temp;
	}
	function org_setImageSize(w, h){ super.setImageSize(w, h); }
	function setImageSize(w, h)
	{
		imageWidth = w;
		virtualHeight = h;
	}
	property parent{
		setter(par){
			super.parent = par;
			super.setImageSize(par.imageWidth, par.imageHeight);
			super.setSizeToImageSize();
		}
		getter{
			return super.parent;
		}
	}
	property top{
		setter(x){
			virtualTop = (int)x;
			itemCheck();
		}
		getter{
			return virtualTop;
		}
	}
	property height{
		setter(h){
			virtualHeight = h;
		}
		getter{
			return virtualHeight;
		}
	}
}

class ChainPlugin extends KAGPlugin
{
	var bg;
	var blackBg;
	var scroll;
	var prev;
	var next;
	var txt;
	var backButton;
	var marginT = 50;
	var marginB = 50;
	var dat = [];
	var timer;
	var showing = false;
	var oneNameMode = false;	// 名前を上にひとつしか書かないモード
	var nameLayer;
	var curName;
	var addLog = true;		// バックログに追加するか

	function ChainPlugin()
	{
		super.KAGPlugin(...);
		bg = new fadeLayer(kag, kag.primaryLayer);
		bg.loadImages("chain_bg");
		bg.setSizeToImageSize();
		bg.absolute = 1;
		bg.hitType = htMask;
		bg.hitThreshold = 256;
		bg.noSetMode = true;
		bg.onMouseDown = function(x, y, button, shift){
			if(button == mbRight){
				kag.process("plugin_chain.ks", "*menu_return");
			}
		}incontextof bg;

		blackBg = new Layer( kag, kag.primaryLayer );
		blackBg.loadImages( "black" );
		blackBg.setSizeToImageSize();
		blackBg.opacity = 200;
		blackBg.absolute = 2;
		blackBg.hitThreshold = 256;
		blackBg.visible=false;

		//txt = new Layer(kag, bg);
		txt = new SmartScrollLayer(kag, bg);
		txt.owner = this;
		txt.type = ltAlpha;
		txt.face = dfAlpha;
		txt.setImageSize(578, 720);
		txt.setSizeToImageSize();
		txt.font.height = 20;
		txt.font.face = "VLG20";
		txt.font.mapPrerenderedFont("vlg20.tft");
		txt.visible = true;
		scroll = new ScrollBarLayerFree(kag, bg, %[top:"chain_scroll_top",center:"chain_scroll_center",under:"chain_scroll_under"]);
		scroll.setClipPos(334, 0);
		scroll.setClipSize(578, 720);
		scroll.setPos(919, 56);
		scroll.height = 609;
		scroll.setTarget(txt);
		scroll.initScrollBar();
		scroll.visible = true;
		prev = new FunctionButtonLayerEx(kag, bg, prevFunc);
		prev.loadImages("chain_bt_prev");
		prev.setPos(913, 26);
		prev.visible = true;
		next = new FunctionButtonLayerEx(kag, bg, nextFunc);
		next.loadImages("chain_bt_next");
		next.setPos(913, 671);
		next.visible = true;
		timer = new Timer(onTimer, "");
		timer.interval = 20;
		backButton = new FunctionButtonLayerEx(kag, bg, backFunc);
		backButton.loadImages("com_bt_back");
		backButton.setPos(1075, 647);

		if(oneNameMode){
			nameLayer = new Layer(kag, bg);
			with(nameLayer){
				.setImageSize(609, 70);
				.setSizeToImageSize();
				.setPos(335, 0);
				.type = ltAlpha;
				.face = dfAlpha;
				.font.face = "vlg30";
				.font.mapPrerenderedFont("vlg30.tft");
				.visible = true;
			}
		}
	}

	function prevFunc(){scroll.prev();}
	function nextFunc(){scroll.next();}
	function backFunc(){kag.process("plugin_chain.ks", "*menu_return");}

	function finalize()
	{
		invalidate nameLayer if nameLayer !== void;
		nameLayer = void;
		invalidate backButton;
		invalidate blackBg;
		invalidate timer;
		invalidate next;
		invalidate prev;
		invalidate txt;
		invalidate scroll;
		invalidate bg;
		super.finalize(...);
	}

	// 子から呼ばれる関数
	function slide(y)
	{
		scroll.shift2(y);
	}

	// チェインログの生成
	function createChainLog()
	{
		var posList = [];
		// まず高さを計算
		var height = marginT + marginB;
		var temp = new Layer(kag, kag.primaryLayer);
		for(var i=0; i<dat.count; i++){
			var ar = dat[i].split(/,/,,true);
			var top = height;
			if(ar[1] == "stamp"){
				temp.loadImages(ar[2]);
				height += temp.imageHeight;
			}else{
				height += 160;
			}
			posList.add([top, height, dat[i]]);		// 座標の開始と終わり、内容を記録
		}
		invalidate temp;

		txt.height = height;
		txt.fillRect(0,0,txt.imageWidth, txt.imageHeight, 0x0);

		txt.clearItem();
		for(var i=0; i<dat.count; i++){
			txt.addItem(posList[i][0], posList[i][1], dat[i]);
		}
		scroll.initScrollBar();
	}

	function show()
	{
		createChainLog();
		scroll.max();
		backButton.visible = false;
		blackBg.visible  = false;
		blackBg.absolute = 1000000-2;
		bg.parent = kag.fore.base;
		bg.absolute = 1000000-1;
		bg.show();
		bg.hitThreshold = 256;
		txt.hitThreshold = 256;
		showing = true;
	}

	function showByMenu()
	{
		createChainLog();
		scroll.max();
		backButton.visible = true;
		blackBg.visible  = true;
		blackBg.absolute = 1000000-2;
		bg.parent = kag.primaryLayer;
		bg.absolute = 1000000-1;
		bg.show();
		bg.hitThreshold = 0;
		txt.hitThreshold = 0;
		showing = true;
	}

	function reCreate()
	{
		var tmp = txt.top;
		createChainLog();
		txt.top = tmp;
		timer.enabled = true;
	}

	function onTimer()
	{
		var par = scroll.shift2(-10);
		if(par >= 1)timer.enabled = false;
	}
	function setMax()
	{
		timer.enabled = false;
		scroll.max();
	}

	function hide()
	{
		if(showing){
			bg.hide();
			blackBg.visible=false;
		}
		showing = false;
	}

	function addText(name, date="0101", time="0000", txt){
		drawName(name);
		if(f.月 !== void && f.日 !== void)date = "%02d".sprintf(f.月) + "%02d".sprintf(f.日);

		txt = txt.replace(/\[一人称\]/,sf.一人称);
		if(txt.indexOf("[一人称]")!=-1)txt = txt.replace(/\[一人称\]/,sf.一人称);
		txt = txt.replace(/\[名前\]/,sf.名前);
		txt = txt.replace(/\[苗字\]/,sf.苗字);
		txt = txt.replace(/\[呼び名\]/,getNickName());
		
		//txt = txt.replace(/\[愛子\]/,sf.愛子呼び名);
		// 上のようなものをヒロインリストから自動生成
		for(var i=0; i<heroineList.count; i++){
			var name = heroineList[i];
			var reg = new RegExp("\\["+name+"\\]");
			txt = reg.replace(txt, sf[name+"呼び名"]);
		}

		addItem(name, date+time, txt);
	}
	function addItem(name = "自分", type="00000000", value="メッセージの描画に失敗しました")
	{
		dat.add(name + "," + type + "," + value);
		if(addLog){
			try{
				if(name == "自分"){
					kag.historyLayer.store("[" + sf.名前 + "]");
					kag.historyLayer.reline();
				}else{
					kag.historyLayer.store("[" + name + "]");
					kag.historyLayer.reline();
				}
				kag.historyLayer.store("[" + value.replace(/(￥ｎ|\[r\])/, "") +"]");
				kag.historyLayer.reline();
				kag.historyLayer.reline();
			}catch(e){
				dm("チェインのバックログへの追加に失敗");
			}
		}
	}
	function drawName(name)
	{
		if(!oneNameMode)return;
		if(name == "自分" || curName == name || name == "" || name === void)return;
		curName = name;
		with(nameLayer){
			var nw = 0;
			for(var i=0; i<name.length; i++)nw += .font.getTextWidth(name.charAt(i));
			.fillRect(0,0,.width,.height,0x0);
			//.fillRect(0,0,.width,.height,0xaaff0000);		// 赤塗りで範囲チェック用
			.drawText((.width>>1)-(nw>>1), (.height>>1)-(.font.getTextHeight(name)>>1)+5, name, 0xffffff, 255, true, 512, 0x000000, 2, 1, 1);
		}
	}

	function onStore(f, elm)
	{
		// 栞を保存するとき
		var dic = f.chainLog = [];
		dic.assign(dat);
		f.chainShowing = showing;
		f.chainName = curName;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.chainLog;
		curName = "";
		drawName(f.chainName);
		if(dic !== void){
			dat.assign(dic);
		}else{
			dat.clear();
		}
		if(f.chainShowing){
			show();
		}else{
			if(showing)hide();
		}
	}

	function logClear()
	{
		dat.clear();
	}
}

// チェイン画面でのキーフック
function chainKeyDownFunc(key, shift){
	switch(key){
		case VK_PRIOR:	global.chain_object.scroll.shift2(600); break;	// PAGEUP
		case VK_NEXT:	global.chain_object.scroll.shift2(-600); break;	// PAGEDOWN
		case VK_HOME:	global.chain_object.scroll.min(); break;	// HOME
		case VK_END:	global.chain_object.scroll.max(); break;	// END
		case VK_UP:		global.chain_object.scroll.shift2(100); break;// ↑
		case VK_DOWN:	global.chain_object.scroll.shift2(-100); break;// ↓
		default:break;
	}
	return true;
}

function chainOnMouseWheelFunc(shift, delta, x, y){

	global.chain_object.scroll.shift2( delta * 0.2 );
	return true;
}

function pickup_speaker_name(name){
	var ar = fullnameForChChrColor();
	var result = ar[name];
	if(result === void)result = " ";
	return result;
}

kag.addPlugin(global.chain_object = new ChainPlugin(kag));

@endscript
@endif

@macro name="chain_show"
@if exp="global.chain_object.showing"
@chain_update
@else
@eval exp="global.chain_object.show()"
@waitclk
@endif
@endmacro

@macro name="chain_add"
@eval exp="f.speaker = pickup_speaker_name(mp.name)"
@eval exp="mp.se = true" cond="mp.se == void"
@eval exp="global.chain_object.addText(mp.name, mp.date, mp.time, mp.txt)" cond="mp.txt !== void"
@se buf=12 storage="chain送" cond="mp.txt !== void && mp.name=='自分'" cond=mp.se
@se buf=12 storage="chain着" cond="mp.txt !== void && mp.name!='自分'" cond=mp.se
@eval exp="global.chain_object.addItem(mp.name, 'stamp', mp.stamp)" cond="mp.stamp !== void"
@se buf=12 storage="chain_スタンプ" cond="mp.stamp !== void" cond=mp.se
@endmacro

@macro name="chain_update"
@eval exp="chain_object.reCreate()"
@waitclk
@eval exp="chain_object.setMax()"
@endmacro

@macro name="chain_hide"
@eval exp="global.chain_object.hide()"
@endmacro

@macro name="chain_clear"
@eval exp="global.chain_object.logClear()"
@endmacro

@return


*menu_open
@iscript
tf.houtput = kag.historyWriteEnabled;
tf.henabled = kag.historyEnabled;
kag.configShowing=true;
kag.keyDownHook.unshift(chainKeyDownFunc);
kag.wheelSpinHook.unshift(chainOnMouseWheelFunc);
@endscript
@history output=false enabled=false
@eval exp="global.chain_object.showByMenu()"
@s


*menu_return
@eval exp="kag.keyDownHook.remove(chainKeyDownFunc);"
@eval exp="kag.wheelSpinHook.remove(chainOnMouseWheelFunc);"
@chain_hide
@history output="&tf.houtput" enabled="&tf.henabled"
@eval exp="kag.configShowing=false"
@return
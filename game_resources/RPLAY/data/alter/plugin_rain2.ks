@if exp="typeof(global.evsnow_object) == 'undefined'"
@iscript

/*
	雪をふらせるプラグイン
*/

class EvSnowGrain
{
	// 雪粒のクラス

	var fore; // 表画面の雪粒オブジェクト
	var back; // 裏画面の雪粒オブジェクト
	var xvelo; // 横速度
	var yvelo; // 縦速度
	var xaccel; // 横加速
	var l, t; // 横位置と縦位置
	var ownwer; // このオブジェクトを所有する EvSnowPlugin オブジェクト
	var spawned = false; // 雪粒が出現しているか
	var window; // ウィンドウオブジェクトへの参照
	var number;	// 読み込んだ画像の番号

	var xmax = kag.scWidth;
	var ymax = kag.scHeight;

	function EvSnowGrain(window, n, owner)
	{
		// EvSnowGrain コンストラクタ
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

		fore.hitType = htMask;
		fore.hitThreshold = 256; // マウスメッセージは全域透過
		back.hitType = htMask;
		back.hitThreshold = 256;

		fore.loadImages("snow" + "%02d".sprintf(n)); // 画像を読み込む
		//fore.doBoxBlur(1, 1);
//		if(fore.imageWidth%2)fore.imageWidth += 1;
//		if(fore.imageHeight%2)fore.imageHeight += 1;

//		if(n == 0)fore.absolute = 10005;
//		else if(n == 1)fore.absolute = 10002 + intrandom(-1, 1);
//		else if(n == 2)fore.absolute = 10002 + intrandom(-1, 1);
//		else fore.absolute = 9997 + (5-n);
		if(fore.imageWidth >= 7)fore.absolute = 10002 + intrandom(-1, 1);
		else fore.absolute = 10000;
		back.absolute = fore.absolute;

//		fore.opacity = back.opacity = 150;

/*※*/		number = n;					// 読み込んだ画像番号を記憶
		back.assignImages(fore);
		fore.setSizeToImageSize(); // レイヤのサイズを画像のサイズと同じに
		back.setSizeToImageSize();
//		xvelo = 0;//Math.random() - 0.5; // 横方向速度
//		yvelo = (5 - n) * 30 + Math.random() * 15; // 縦方向速度
		xvelo = 1 + Math.random()*2;
		yvelo = 2 + Math.random()*2;
		xaccel = Math.random(); // 初期加速度
	}

	function finalize()
	{
		invalidate fore;
		invalidate back;
	}

	function spawn()
	{
		// 出現
		l = Math.random() * window.primaryLayer.width; // 横初期位置
		t = -fore.height; // 縦初期位置
		spawned = true;
		fore.setPos(l, t);
		back.setPos(l, t); // 裏画面の位置も同じに
		fore.visible = owner.foreVisible;
		back.visible = owner.backVisible;
	}

	function randomSpawn()
	{
		// 出現
		l = Math.random() * window.primaryLayer.width; // 横初期位置
		t = Math.random() * window.primaryLayer.height; // 縦初期位置
		spawned = true;
		fore.setPos(l, t);
		back.setPos(l, t); // 裏画面の位置も同じに
		fore.visible = owner.foreVisible;
		back.visible = owner.backVisible;
	}

	function resetVisibleState()
	{
		// 表示・非表示の状態を再設定する
		if(spawned)
		{
			fore.visible = owner.foreVisible;
			back.visible = owner.backVisible;
		}
		else
		{
			fore.visible = false;
			back.visible = false;
		}
	}

	function setOption(member, value)
	{
		fore[member] = value;
		back[member] = value;
	}

	function move()
	{
		// 雪粒を動かす
		if(!spawned)
		{
			// 出現していないので出現する機会をうかがう
			/*if(Math.random() < 0.002)*/ spawn();
		}
		else
		{
			l += xvelo;
			t += yvelo;
//			xvelo += xaccel;
//			xaccel += (Math.random() - 0.5) * 0.3;
//			if(xvelo>=1.5) xvelo=1.5;
//			if(xvelo<=-1.5) xvelo=-1.5;
//			if(xaccel>=0.2) xaccel=0.2;
//			if(xaccel<=-0.2) xaccel=-0.2;

/*※*/		if( (t >= ymax || l >= xmax) || (fore.absolute == 10000 && t >= 500*(1-(l/900))) )
			{
				var number = this.number;
				if(random>0.7)number = 0;
				if(random > 0.3){
					t = -fore.height;
					l = Math.random() * window.primaryLayer.width;
				}else{
					t = Math.random() * window.primaryLayer.height;
					l = -fore.width;
				}
				fore.setPos(l, t);
				back.setPos(l, t); // 裏画面の位置も同じに
				return;
			}

			fore.setPos(l, t);
			back.setPos(l, t); // 裏画面の位置も同じに
		}
	}

	function exchangeForeBack()
	{
		// 表と裏の管理情報を交換する
		var tmp = fore;
		fore = back;
		back = tmp;
	}
}

class EvSnowPlugin extends KAGPlugin
{
	// 雪を振らすプラグインクラス

	var evsnows = []; // 雪粒
	var timer; // タイマ
	var window; // ウィンドウへの参照
	var foreVisible = true; // 表画面が表示状態かどうか
	var backVisible = true; // 裏画面が表示状態かどうか

	var spoption = false;

	function EvSnowPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize メソッド
		// このクラスの管理するすべてのオブジェクトを明示的に破棄
		for(var i = 0; i < evsnows.count; i++)
			invalidate evsnows[i];
		invalidate evsnows;

		invalidate timer if timer !== void;

		super.finalize(...);
	}

	function init(num, options)
	{
		// num 個の雪粒を出現させる
		if(timer !== void) return; // すでに雪粒はでている

		// 雪粒を作成
		for(var i = 0; i < num; i++)
		{
			var n = intrandom(0, 13); // 雪粒の大きさ ( ランダム )
			if(i<=3)n = 0;
			evsnows[i] = new EvSnowGrain(window, n, this);
			if(options.spoption !== void){
				evsnows[i].setOption("absolute", 10002);
				spoption = true;
			}else spoption = false;
			evsnows[i].randomSpawn();
		}
//※		evsnows[0].spawn(); // 最初の雪粒だけは最初から表示

		// タイマーを作成
		timer = new Timer(onTimer, '');
//※		timer.interval = 80;
		timer.interval = 20;
		timer.enabled = true;

		foreVisible = true;
		backVisible = true;
		setOptions(options); // オプションを設定
	}

	function uninit()
	{
		// 雪粒を消す
		if(timer === void) return; // 雪粒はでていない

		for(var i = 0; i < evsnows.count; i++)
			invalidate evsnows[i];
		evsnows.count = 0;

		invalidate timer;
		timer = void;
	}

	function setOptions(elm)
	{
		// オプションを設定する
		foreVisible = +elm.forevisible if elm.forevisible !== void;
		backVisible = +elm.backvisible if elm.backvisible !== void;
		resetVisibleState();
	}

	function onTimer()
	{
		// タイマーの周期ごとに呼ばれる
		var evsnowcount = evsnows.count;
		for(var i = 0; i < evsnowcount; i++)
			evsnows[i].move(); // move メソッドを呼び出す
	}

	function resetVisibleState()
	{
		// すべての雪粒の 表示・非表示の状態を再設定する
		var evsnowcount = evsnows.count;
		for(var i = 0; i < evsnowcount; i++)
			evsnows[i].resetVisibleState(); // resetVisibleState メソッドを呼び出す
	}

	function onStore(f, elm)
	{
		// 栞を保存するとき
		var dic = f.evsnows = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.evsnowCount = evsnows.count;
		dic.spoption = spoption ? "true" : void;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.evsnows;
		if(dic === void || !+dic.init)
		{
			// 雪はでていない
			uninit();
		}
		else if(dic !== void && +dic.init)
		{
			// 雪はでていた
			init(dic.evsnowCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible, spoption:dic.spoption ] );
		}
	}

	function onStableStateChanged(stable)
	{
	}

	function onMessageHiddenStateChanged(hidden)
	{
	}

	function onCopyLayer(toback)
	{
		// レイヤの表←→裏情報のコピー
		// このプラグインではコピーすべき情報は表示・非表示の情報だけ
		if(toback)
		{
			// 表→裏
			backVisible = foreVisible;
		}
		else
		{
			// 裏→表
			foreVisible = backVisible;
		}
		resetVisibleState();
	}

	function onExchangeForeBack()
	{
		// 裏と表の管理情報を交換
		var evsnowcount = evsnows.count;
		for(var i = 0; i < evsnowcount; i++)
			evsnows[i].exchangeForeBack(); // exchangeForeBack メソッドを呼び出す
	}
}

kag.addPlugin(global.evsnow_object = new EvSnowPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

@endscript
@endif
; マクロ登録
@macro name="evsnowinit"
@eval exp="evsnow_object.init(185, mp)"
@endmacro
@macro name="evsnowopt"
@eval exp="evsnow_object.setOptions(mp)"
@endmacro
@macro name="readyevsnow"
@evsnowinit * forevisible=false backvisible=true
@endmacro
@macro name="showevsnow"
@evsnowopt forevisible=true backvisible=true
@endmacro
@macro name="hideevsnow"
@evsnowopt forevisible=true backvisible=false
@endmacro
@macro name="endevsnow"
@eval exp="evsnow_object.uninit()"
@endmacro
@return

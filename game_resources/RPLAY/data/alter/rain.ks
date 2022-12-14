@if exp="typeof(global.snow_object) == 'undefined'"
@iscript

/*
	雪をふらせるプラグイン
*/

class SnowGrain
{
	// 雪粒のクラス

	var fore; // 表画面の雪粒オブジェクト
	var back; // 裏画面の雪粒オブジェクト
	var xvelo; // 横速度
	var yvelo; // 縦速度
	var xaccel; // 横加速
	var l, t; // 横位置と縦位置
	var ownwer; // このオブジェクトを所有する SnowPlugin オブジェクト
	var spawned = false; // 雪粒が出現しているか
	var window; // ウィンドウオブジェクトへの参照
	var number;	// 読み込んだ画像の番号

	function SnowGrain(window, n, owner)
	{
		// SnowGrain コンストラクタ
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

//※		fore.absolute = 2000000-1; // 重ね合わせ順序はメッセージ履歴よりも奥
//※		back.absolute = fore.absolute;
		//fore.absolute = 4000+(1000*(n-2)); // 重ね合わせ順序は立ち絵の前後
		if(n == 0)fore.absolute = 10005;
		else if(n == 1)fore.absolute = 10000 + intrandom(0,2);
		else if(n == 2)fore.absolute = 10002;
		else fore.absolute = 9997 + (5-n);
		back.absolute = fore.absolute;

		fore.hitType = htMask;
		fore.hitThreshold = 256; // マウスメッセージは全域透過
		back.hitType = htMask;
		back.hitThreshold = 256;

		fore.loadImages("rain_" + n); // 画像を読み込む
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

			if(fore.opacity < 200){
				fore.opacity += 15;
				back.opacity = fore.opacity;
			}

/*※*/		if(t >= window.primaryLayer.height || l >= window.primaryLayer.width)
			{
				var number = this.number;
				if(random>0.7)number = 0;
				if(random > 0.3){
					t = -fore.height + 144*number;
					l = Math.random() * window.primaryLayer.width + 256*number;
					fore.opacity = 0;
				}else{
					t = Math.random() * window.primaryLayer.height  + 144*number;
					l = -fore.width + 256*number;
					fore.opacity = 0;
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

class SnowPlugin extends KAGPlugin
{
	// 雪を振らすプラグインクラス

	var snows = []; // 雪粒
	var timer; // タイマ
	var window; // ウィンドウへの参照
	var foreVisible = true; // 表画面が表示状態かどうか
	var backVisible = true; // 裏画面が表示状態かどうか

	function SnowPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize メソッド
		// このクラスの管理するすべてのオブジェクトを明示的に破棄
		for(var i = 0; i < snows.count; i++)
			invalidate snows[i];
		invalidate snows;

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
			var n = intrandom(1, 5); // 雪粒の大きさ ( ランダム )
			if(i<=3)n = 0;
			snows[i] = new SnowGrain(window, n, this);
			snows[i].randomSpawn();
		}
//※		snows[0].spawn(); // 最初の雪粒だけは最初から表示

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

		for(var i = 0; i < snows.count; i++)
			invalidate snows[i];
		snows.count = 0;

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
		var snowcount = snows.count;
		for(var i = 0; i < snowcount; i++)
			snows[i].move(); // move メソッドを呼び出す
	}

	function resetVisibleState()
	{
		// すべての雪粒の 表示・非表示の状態を再設定する
		var snowcount = snows.count;
		for(var i = 0; i < snowcount; i++)
			snows[i].resetVisibleState(); // resetVisibleState メソッドを呼び出す
	}

	function onStore(f, elm)
	{
		// 栞を保存するとき
		var dic = f.snows = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.snowCount = snows.count;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.snows;
		if(dic === void || !+dic.init)
		{
			// 雪はでていない
			uninit();
		}
		else if(dic !== void && +dic.init)
		{
			// 雪はでていた
			init(dic.snowCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible ] );
		}
	}

	function onStableStateChanged(stable)
	{
	}

	function onMessageHiddenStateChanged(hidden)
	{
	}

/*※
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
*/
	function onExchangeForeBack()
	{
		// 裏と表の管理情報を交換
		var snowcount = snows.count;
		for(var i = 0; i < snowcount; i++)
			snows[i].exchangeForeBack(); // exchangeForeBack メソッドを呼び出す
	}
}

kag.addPlugin(global.snow_object = new SnowPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

@endscript
@endif
; マクロ登録
@macro name="raininit"
@eval exp="snow_object.init(85, mp)"
@endmacro
@macro name="rainopt"
@eval exp="snow_object.setOptions(mp)"
@endmacro
@macro name="readyrain"
@raininit forevisible=false backvisible=true
@endmacro
@macro name="showrain"
@rainopt forevisible=true backvisible=true
@endmacro
@macro name="hiderain"
@rainopt forevisible=true backvisible=false
@endmacro
@macro name="endrain"
@eval exp="snow_object.uninit()"
@endmacro
@return

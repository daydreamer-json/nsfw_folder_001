@if exp="typeof(global.drop_object) == 'undefined'"
@iscript

class DropGrain
{
	var fore; // 表画面の粒オブジェクト
	var back; // 裏画面の粒オブジェクト
	var xvelo; // 横速度
	var yvelo; // 縦速度
	var xaccel; // 横加速
	var l, t; // 横位置と縦位置
	var ownwer; // このオブジェクトを所有する DropPlugin オブジェクト
	var spawned = false; // 粒が出現しているか
	var window; // ウィンドウオブジェクトへの参照
	var number;	// 読み込んだ画像の番号

	function DropGrain(window, n, owner)
	{
		// DropGrain コンストラクタ
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

		fore.absolute = kag.fore.layers[0].absolute + 1;
		back.absolute = fore.absolute;

		fore.hitType = back.hitType = htMask;
		fore.hitThreshold = back.hitThreshold = 256; // マウスメッセージは全域透過

		fore.loadImages("ex_snow0" + n); // 画像を読み込む
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
		// 粒を動かす
		if(!spawned)
		{
			// 出現していないので出現する機会をうかがう
			/*if(Math.random() < 0.002)*/ spawn();
		}
		else
		{
			l += xvelo;
			t += yvelo;
			xvelo += xaccel;
			xaccel += (Math.random() - 0.3)*0.2;
			if(xvelo>=1.5) xvelo=1.5;
			if(xvelo<=-1.5) xvelo=-1.5;
			if(xaccel>=0.2) xaccel=0.2;
			if(xaccel<=-0.2) xaccel=-0.2;

/*※*/		if(t >= window.primaryLayer.height || l >= window.primaryLayer.width)
			{
				if(Math.random() >= 0.5){
					t = -fore.height;
					l = Math.random() * window.primaryLayer.width;
				}else{
					t = window.primaryLayer.width * Math.random();
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

class DropPlugin extends KAGPlugin
{
	// なにかを振らすプラグインクラス

	var drops = []; // 粒
	var timer; // タイマ
	var window; // ウィンドウへの参照
	var foreVisible = true; // 表画面が表示状態かどうか
	var backVisible = true; // 裏画面が表示状態かどうか

	var state = 0;
	var autohide = false;

	function DropPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize メソッド
		// このクラスの管理するすべてのオブジェクトを明示的に破棄
		for(var i = 0; i < drops.count; i++)
			invalidate drops[i];
		invalidate drops;

		invalidate timer if timer !== void;

		super.finalize(...);
	}

	function init(num, options)
	{
		if(options.autohide == "true")autohide = true;
		else autohide = false;
		state = 0;

		// num 個の粒を出現させる
		if(timer !== void) return; // すでに粒はでている

		// 粒を作成
		for(var i = 0; i < num; i++)
		{
			var n = intrandom(1, 2); // 粒の大きさ ( ランダム )
			drops[i] = new DropGrain(window, n, this);
			drops[i].randomSpawn();
		}
//※		drops[0].spawn(); // 最初の粒だけは最初から表示

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
		// 粒を消す
		if(timer === void) return; // 粒はでていない

		for(var i = 0; i < drops.count; i++)
			invalidate drops[i];
		drops.count = 0;

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
		var dropcount = drops.count;
		for(var i = 0; i < dropcount; i++)
			drops[i].move(); // move メソッドを呼び出す
	}

	function resetVisibleState()
	{
		// すべての粒の 表示・非表示の状態を再設定する
		var dropcount = drops.count;
		for(var i = 0; i < dropcount; i++)
			drops[i].resetVisibleState(); // resetVisibleState メソッドを呼び出す
	}

	function onStore(f, elm)
	{
		// 栞を保存するとき
		var dic = f.drops = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.dropCount = drops.count;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.drops;
		if(dic === void || !+dic.init)
		{
			// 粒はでていない
			uninit();
		}
		else if(dic !== void && +dic.init)
		{
			// 粒はでていた
			init(dic.dropCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible ] );
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
//		var dropcount = drops.count;
//		for(var i = 0; i < dropcount; i++)
//			drops[i].exchangeForeBack(); // exchangeForeBack メソッドを呼び出す

		// 自動消滅
		if(autohide){
			state += 1;
			if(state == 2)uninit();
		}
	}
}

kag.addPlugin(global.drop_object = new DropPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

@endscript
@endif
; マクロ登録
@macro name="graininit"
@eval exp="drop_object.init(40, mp)"
@endmacro
@macro name="grainopt"
@eval exp="drop_object.setOptions(mp)"
@endmacro
@macro name="grainonce"
@graininit forevisible=false backvisible=true autohide=true
@endmacro
@macro name="readygrain"
@graininit forevisible=false backvisible=true
@endmacro
@macro name="showgrain"
@grainopt forevisible=true backvisible=true
@endmacro
@macro name="hidegrain"
@grainopt forevisible=true backvisible=false
@endmacro
@macro name="endgrain"
@eval exp="drop_object.uninit()"
@endmacro
@return

@if exp="typeof(global.cherryb_object) == 'undefined'"
@iscript

/*
	桜をふらせるプラグイン
*/

class CherryBlossomsGrain
{
	// 桜のクラス

	var fore; // 表画面の桜オブジェクト
	var back; // 裏画面の桜オブジェクト
	var xvelo; // 横速度
	var yvelo; // 縦速度
	var xaccel; // 横加速
	var yaccel;
	var l, t; // 横位置と縦位置
	var ownwer; // このオブジェクトを所有する CherryBlossomsPlugin オブジェクト
	var spawned = false; // 桜が出現しているか
	var window; // ウィンドウオブジェクトへの参照

	var changeTick;
	var animeInterval = 50;
	var curImgPos = 0;
	var turn = false;

	function CherryBlossomsGrain(window, n, owner)
	{
		// CherryBlossomsGrain コンストラクタ
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

//		fore.absolute = 2000000-1; // 重ね合わせ順序はメッセージ履歴よりも奥
///**/		fore.absolute = n >= 2 ? 2000-5 : 2000+5;
			fore.absolute = 2000-5;
		back.absolute = fore.absolute;

		fore.hitType = htMask;
		fore.hitThreshold = 256; // マウスメッセージは全域透過
		back.hitType = htMask;
		back.hitThreshold = 256;

		fore.loadImages("cherryb_" + n); // 画像を読み込む
		back.assignImages(fore);
		fore.setSizeToImageSize(); // レイヤのサイズを画像のサイズと同じに
		back.setSizeToImageSize();

/**/		fore.width = fore.width\3;
/**/		back.width = back.width\3;
/**/		fore.imageLeft = 0;
/**/		back.imageLeft = 0;

//		xvelo = 0; // 横方向速度
//		yvelo = n*0.6 + 1.9 + Math.random() * 0.2; // 縦方向速度
//		xaccel = Math.random(); // 初期加速度

/**/		xvelo = n*0.6 + 1.9 + Math.random() * 0.2;
/**/		yvelo = 0;
/**/		yaccel = Math.random(); // 初期加速度
/**/		changeTick = System.getTickCount();
	}

	function finalize()
	{
		invalidate fore;
		invalidate back;
	}

	function spawn()
	{
		// 出現
//		l = Math.random() * window.primaryLayer.width; // 横初期位置
//		t = -fore.height; // 縦初期位置
		reArrangement();
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

	function reArrangement(){

		animeInterval = 50 + 50*Math.random();
/*
		t = Math.random() * (window.primaryLayer.height * 2) - window.primaryLayer.height;
		if(t <= 0){
			t = -fore.height;
			l = Math.random() * window.primaryLayer.width;
		}else l = window.primaryLayer.width + fore.width;
*/
		// ↑なんでこんな不思議なコード書いたんだろ？
		if(Math.random()>0.4){
			t = -fore.height;
			l = Math.random() * window.primaryLayer.width;
		}else{
			t = Math.random() * window.primaryLayer.height;
			l = window.primaryLayer.width;
		}
	}

	function move()
	{
		// 桜を動かす
		if(!spawned)
		{
			// 出現していないので出現する機会をうかがう
			//if(Math.random() < 0.002) spawn();
			if(Math.random() < 0.005) spawn();
		}
		else
		{
			l -= xvelo;
			t += yvelo;
//			xvelo += xaccel;
//			xaccel += (Math.random() - 0.5) * 0.3;
/**/			yvelo += yaccel;
/**/			yaccel += (Math.random() - 0.5) * 0.3;
//			if(xvelo>=1.5) xvelo=1.5;
//			if(xvelo<=-1.5) xvelo=-1.5;
//			if(xaccel>=0.2) xaccel=0.2;
//			if(xaccel<=-0.2) xaccel=-0.2;

/**/			if(yvelo>=1.5) yvelo=1.5;
/**/			if(yvelo<=-1.5) yvelo=-1.5;
/**/			if(yaccel>=0.15) yaccel=0.15;
/**/			if(yaccel<=-0.2) yaccel=-0.2;
//			if(t >= window.primaryLayer.height)
/**/			if(l <= -fore.width || t >= window.primaryLayer.height)
			{
//				t = -fore.height;
//				l = Math.random() * window.primaryLayer.width;
				// 出さないフラグが立ってたら出さない
				if(owner.noSpawn)return false;
				reArrangement();
			}
t+=2;
			fore.setPos(l, t);
			back.setPos(l, t); // 裏画面の位置も同じに

			// 桜のアニメーション
			var nowTick = System.getTickCount();
			if(nowTick - changeTick >= animeInterval){
				changeTick = nowTick;
				if(turn){
					curImgPos--;
					if(curImgPos < 1)turn = false;
					fore.imageLeft = curImgPos * fore.width * -1;
				}else{
					curImgPos++;
					if(curImgPos > 1)turn = true;
					fore.imageLeft = curImgPos * fore.width * -1;
				}
			}

		}
		return true;
	}

	function exchangeForeBack()
	{
		// 表と裏の管理情報を交換する
		var tmp = fore;
		fore = back;
		back = tmp;
	}
}

class CherryBlossomsPlugin extends KAGPlugin
{
	// 桜を振らすプラグインクラス

	var cherrybs = []; // 桜
	var timer; // タイマ
	var window; // ウィンドウへの参照
	var foreVisible = true; // 表画面が表示状態かどうか
	var backVisible = true; // 裏画面が表示状態かどうか
	var noSpawn = false;	// 降らせないフラグ

	function CherryBlossomsPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize メソッド
		// このクラスの管理するすべてのオブジェクトを明示的に破棄
		for(var i = 0; i < cherrybs.count; i++)
			invalidate cherrybs[i];
		invalidate cherrybs;

		invalidate timer if timer !== void;

		super.finalize(...);
	}

	function init(num, options)
	{
		// num 個の桜を出現させる
		if(timer !== void) return; // すでに桜はでている

		noSpawn = false;

		// 桜を作成
		for(var i = 0; i < num; i++)
		{
			var n = intrandom(0, 4); // 桜の大きさ ( ランダム )
			cherrybs[i] = new CherryBlossomsGrain(window, n, this);
		}
		cherrybs[0].spawn(); // 最初の桜だけは最初から表示

		// タイマーを作成
		timer = new Timer(onTimer, '');
		timer.interval = 20;
		timer.enabled = true;

		foreVisible = true;
		backVisible = true;
		setOptions(options); // オプションを設定
	}

	function uninit()
	{
		// 桜を消す
		if(timer === void) return; // 桜はでていない

		for(var i = 0; i < cherrybs.count; i++)
			invalidate cherrybs[i];
		cherrybs.count = 0;

		invalidate timer;
		timer = void;
	}

	// 徐々に出さなくする
	function hide()
	{
		noSpawn = true;
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
		var cherrybcount = cherrybs.count;
		var end = true;
		for(var i = 0; i < cherrybcount; i++){
			// move メソッドを呼び出す
			// まだ動くオブジェクトがあるならどこかで真が帰ってくる
			if(cherrybs[i].move())end = false;
		}
		if(end)uninit();
	}

	function resetVisibleState()
	{
		// すべての桜の 表示・非表示の状態を再設定する
		var cherrybcount = cherrybs.count;
		for(var i = 0; i < cherrybcount; i++)
			cherrybs[i].resetVisibleState(); // resetVisibleState メソッドを呼び出す
	}

	function onStore(f, elm)
	{
		// セーブするとき出さないフラグがでてたら出さない
		if(noSpawn){
			var dic = f.cherrybs = %[];
			dic.init = false;
			dic.foreVisible = foreVisible;
			dic.backVisible = backVisible;
			dic.cherrybCount = 0;
			return;
		}

		// 栞を保存するとき
		var dic = f.cherrybs = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.cherrybCount = cherrybs.count;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.cherrybs;
		if(dic === void || !+dic.init)
		{
			// 桜はでていない
			uninit();
		}
		else if(dic !== void && +dic.init)
		{
			// 桜はでていた
			init(dic.cherrybCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible ] );
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
		var cherrybcount = cherrybs.count;
		for(var i = 0; i < cherrybcount; i++)
			cherrybs[i].exchangeForeBack(); // exchangeForeBack メソッドを呼び出す
	}
}

kag.addPlugin(global.cherryb_object = new CherryBlossomsPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

@endscript
@endif
; マクロ登録
@macro name="cherrybinit"
@eval exp="cherryb_object.init(17, mp)"
@endmacro
@macro name="cherrybuninit"
@eval exp="cherryb_object.uninit()"
@endmacro
@macro name="cherrybhide"
@eval exp="cherryb_object.hide()"
@endmacro
@macro name="cherrybopt"
@eval exp="cherryb_object.setOptions(mp)"
@endmacro
@return

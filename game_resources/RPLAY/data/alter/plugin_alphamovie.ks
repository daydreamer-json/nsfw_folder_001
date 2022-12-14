@if exp="typeof(global.alphamovie_object) == 'undefined'"
@iscript
const numAlphaMovies = 3;

Plugins.link("AlphaMovie.dll");

class AlphaMoviePlayer extends AlphaMovie
{
	var		moving = false; // タイマーが始動しているかどうか
	var		lastTick;
	var		drawlayer;
	var		alphaMovie;
	var		lastFrame;
	var		remain;
	var		movieVisible;
	var		slot;
	var		hasNext;
	var		currentNumberOfFrame;
	var		currentLoop;

	var 	owner;	// プラグインオブジェクト

	function AlphaMoviePlayer( index, par , o) {
		owner = o;
		this.moving = false;
		this.drawlayer = new CharacterLayer( kag, par, "alpha movie 00" + index, 1234 + index );
		CreateDrawLayer( this.drawlayer, index );

		this.movieVisible = true;
		this.slot = index;
		this.hasNext = false;
		this.isLoopNext = false;
		this.currentNumberOfFrame = 0;
	}

	function finalize() {
		stop();
		invalidate drawlayer;
	}

	function play() {
		if( moving ) { stop(); }

		super.play();
		if(moving == false) {
			hasNext = false;
			remain = 0;
			currentNumberOfFrame = numOfFrame;
			currentLoop = loop;
			lastTick = System.getTickCount();
			System.addContinuousHandler(handler);
			moving = true;
		}
	}
	function CreateDrawLayer( target, index ) {
		//target.type = ltAddAlpha;
		//target.face = dfAddAlpha;
		target.type = ltAddAlpha;
		target.face = dfAddAlpha;
		target.absolute = 100000;
		target.visible = false;
	}

	function stop() {
		if(moving) {
			System.removeContinuousHandler(handler);
			moving = false;
		}
		super.stop();
	}

	function setNextMovieFile( storage ) {
		super.setNextMovieFile( storage );
		hasNext = true;
	}

//	interval > scale * 1000 / Rate
//	interval * rate / scale > 1000

	function handler(tick) {
		var		interval = tick - lastTick;
		var		rate = (int)( interval * FPSRate / FPSScale + remain );
		if( rate > 1000 ) {
			var ret = showNextImage( drawlayer );
			if( drawlayer.visible == false && movieVisible == true ) {
				drawlayer.visible = true;
			}
//			if( loop == false ) {
//				if( ret == (numOfFrame-1) ) {
			if( currentLoop == false ) {
				if( ret == (currentNumberOfFrame-1) ) {
//					dm("next?" + hasNext);
					if( hasNext == false ) {
						stop();
						kag.trigger( "finish_alpha_movie_" + slot );
					} else {
						hasNext = false;
						currentNumberOfFrame = numOfFrame;
						currentLoop = loop;
						kag.trigger( "next_alpha_movie_" + slot );
					}
				}
			}
			lastTick = tick;
			remain = rate - 1000;
			if(slot === 0){
				var hf = numOfFrame/2;
				owner.onHandler(frame / hf);
			}
		}
	}
	function swapFronBack() {
	}
	function swapFronBackVisible() {
	}

	property absolute {
		getter { return drawlayer.absolute; }
		setter(x) { drawlayer.absolute = x; }
	}
	property type {
		getter { return drawlayer.type; }
		setter(x) { drawlayer.type = x; }
	}
	property face {
		getter { return drawlayer.face; }
		setter(x) { drawlayer.face = x; }
	}
	property visible {
		getter { return movieVisible; }
		setter(x) {
			movieVisible = x;
			if( movieVisible == false ) {
				drawlayer.visible = false;
			}
		}
	}
	property width { getter { screenWidth; } }
	property height { getter { screenHeight; } }
	property loop {
		getter { return super.loop; }
		setter(x) { super.loop = x; currentLoop = x; }
	}
	property opacity {
		getter { return drawlayer.opacity; }
		setter(x) { drawlayer.opacity = x; }
	}
}

// 自分のアニメーションと同じ事をさせる友達レイヤーを持つレイヤー。親は同じ
class TwinLayer extends CharacterLayer
{
	var friend;

	function TwinLayer(){
		super.CharacterLayer(...);
		friend = new global.Layer(window, parent);
		friend.hitType = htMask;
		friend.hitThreshold = 256;
		friend.visible = true;
	}

	function finalize()
	{
		invalidate friend;
		super.finalize(...);
	}

	function loadImages(elm)
	{
		var animate = false;
		// asdがあるなら目パチとして勝手に1/3で読み込み
		if(elm.sx === void && Storages.isExistentStorage(Storages.chopStorageExt(elm.storage)+".asd")){
			global.Layer.loadImages(elm.storage);
			elm.clipleft = 0;
			elm.cliptop = 0;
			elm.clipwidth = imageWidth\3;
			elm.clipheight = imageHeight;
			animate = true;
		}
		var result = super.loadImages(...);
		var subname = Storages.chopStorageExt(elm.storage) + "_sub";
		//var subname = Storages.chopStorageExt(elm.storage);
		var ies = Storages.isExistentStorage;
		if(ies(subname + ".png") || ies(subname + ".tlg")){
			friend.loadImages(subname);
			if(animate){
				friend.setSize(width, height);
				if((typeof this.org_clip == "undefined")){
					this.org_clip = clip;
					clip = function(elm){
						eyeClip(elm);
						return org_clip(...);
					}incontextof this;
				}
			}else friend.setSizeToImageSize();
		}else{
			friend.loadImages("LineBreak");
		}
		return result;
	}

	function setPos(x, y)
	{
		var result = super.setPos(...);
		friend.setPos(x, y);
		return result;
	}

	function freeImage()
	{
		var result = super.freeImage(...);
		if(friend !== void){
			friend.loadImages("LineBreak");
			//friend.setImageSize(32,32);
			//friend.setSizeToImageSize();
			//friend.type = ltAlpha;
			//friend.face = dfAlpha;
			//friend.fillRect(0,0,32,32,0x0);
		}
		return result;
	}

	function eyeClip(elm)
	{
		friend.imageLeft = -elm.left;
	}

	property opacity
	{
		setter(x){
			super.opacity = x;
			friend.opacity = 150 * (x/255);		// フレンドレイヤーの不透明度最大値は150
		}
		getter(){
			return super.opacity;
		}
	}
}

// α動画プラグイン
class AlphaMoviePlugin extends KAGPlugin
{
	var currentStorage;
	var currentLayout;
	var movies;

	var base;
	var eye_main;
	var eye_sub;
	var eye, eyeback;

	var timer;

	var storeElm = [];

	function AlphaMoviePlugin() {
		super.KAGPlugin();

		base = new Layer(kag, kag.fore.base);
		base.hitType = htMask;
		base.hitThreshold = 256;
		base.setSize(kag.scWidth, kag.scHeight);
		base.setSizeToImageSize();
		base.type = ltBinder;
		base.absolute = kag.fore.layers[5].absolute+1;
		base.orgx = 0;
		base.orgy = 0;
		base.visible = false;

		movies = new Array();
		var absolute = 100000;
		for( var i = 0; i < numAlphaMovies; i++ ) {
			movies[i] = new AlphaMoviePlayer(i, base, this);
			movies[i].absolute = absolute;
			absolute += 1000;
		}

		eye_main = new TwinLayer(kag, base);
		eye_main.absolute = 100000 + 1;
		eye_main.friend.absolute = 150000;
		eye_main.opacity = 255;
		eye_main.type = ltAlpha;
		eye_main.face = dfAlpha;
		eye_main.fillRect(0,0,eye_main.imageWidth,eye_main.imageHeight,0x0);
		eye_main.visible = true;
		eye_sub = new TwinLayer(kag, base);
		eye_sub.absolute = 100000 + 1;
		eye_sub.friend.absolute = 150000;
		eye_sub.opacity = 0;
		eye_sub.type = ltAlpha;
		eye_sub.face = dfAlpha;
		eye_sub.fillRect(0,0,eye_sub.imageWidth,eye_sub.imageHeight,0x0);
		eye_sub.visible = true;

		eye = eye_main;
		eyeback = eye_sub;
		timer = new Timer(onTimer, "");
		timer.interval = 20;
	}

	function finalize() {
		for( var i = 0; i < movies.count; i++ ) {
			invalidate movies[i];
		}
		invalidate timer;
		invalidate eye_sub;
		invalidate eye_main;
		invalidate base;
		super.finalize(...);
	}

	function changeFace(elm)
	{
		if(timer.enabled)changeFinish();
		eyeback.loadImages(%[storage:elm.face + "_anm"]);
		var pos = %[
			"wt_eye_穂"=>[86,170],
			"wt_eye_鈴"=>[140,209],
			"wt_eye_梓"=>[115,337],
			"wt_eye_千"=>[108,176]
		][elm.face.substr(0,8)];
		if(pos !== void){
			eyeback.setPos(pos[0], pos[1]);
		}
		timer.enabled = true;
	}

	function changeFinish()
	{
		timer.enabled = false;
		eye.opacity = 0;
		eye.freeImage();
		eye.visible = true;
		eyeback.opacity = 255;
		var tmp = eye;
		eye = eyeback;
		eyeback = tmp;
	}

	function onTimer()
	{
		var to = eye.opacity;
		var dif = 15;
		if(to-dif <= 0){
			changeFinish();
		}else{
			eye.opacity = to-dif;
			eyeback.opacity = 255 - to;
		}
	}

	function onHandler(per)
	{
		var moveX = 10;
		var moveY = 10;
		if(per < 1.0){
			base.setPos(base.orgx+moveX*per, base.orgy+moveY*per);
		}else{
			per -= 1.0;
			base.setPos(base.orgx+moveX-(moveX*per),base.orgy+moveY-(moveY*per));
		}
	}

	function play( slot, storage ) {
		try {
			movies[slot].open( storage );
			movies[slot].play();
		} catch(e) {
			dm( e.message );
			return false;
		}
		return true;
	}

	function playmovie( elm ) {
		if( elm.storage !== void ) {
			storeElm[+elm.slot] = %[];
			(Dictionary.assign incontextof storeElm[+elm.slot])(elm);
			var slot = 0;
			if( elm.slot !== void ) slot = +elm.slot;

			if( elm.left !== void ) movies[slot].left = +elm.left;
			if( elm.top !== void ) movies[slot].top = +elm.top;

			var loop = false;
			if( elm.loop !== void ) loop = +elm.loop;
			movies[slot].loop = loop;

			// 座標自動設定
			var pos = %[
				"wt_mv_穂波_制服"	=>[565,25],
				"wt_mv_穂波_私服a"	=>[565,25],
				"wt_mv_穂波_髪"		=>[76,9],
				"wt_mv_鈴鹿_制服"	=>[512,-21],
				"wt_mv_鈴鹿_私服a"	=>[512,-21],
				"wt_mv_鈴鹿_髪"		=>[104,0],
				"wt_mv_梓_制服"		=>[537,-49],
				"wt_mv_梓_私服a"	=>[537,-49],
				"wt_mv_梓_髪"		=>[61,195],
				"wt_mv_千歳_スーツ"	=>[547,-27],
				"wt_mv_千歳_私服a"	=>[547,-27],
				"wt_mv_千歳_髪"		=>[21,18]
			][Storages.chopStorageExt(elm.storage)];
			if(pos !== void){
				if(elm.storage.indexOf("髪")==-1){
					base.orgx = pos[0];
					base.orgy = pos[1];
					base.setPos(pos[0], pos[1]);
					base.setSize(kag.scWidth-pos[0], kag.scHeight-pos[1]);
					movies[slot].left = 0;
					movies[slot].top = 0;
				}else{
					movies[slot].left = pos[0];
					movies[slot].top = pos[1];
				}
			}else{
				System.inform("動画の座標設定に失敗しました："+elm.storage);
				return;
			}
			// 目パチ読み込み
			if(elm.face !== void){
				eye.freeImage();
				eye.visible = true;
				eyeback.freeImage();
				eyeback.visible = true;
				changeFace(elm);
				changeFinish();
			}

			base.parent = kag.fore.base;	// 必ず表面で再生
			base.absolute = kag.fore.layers[5].absolute+1;
			base.visible = true;
			play( slot, elm.storage );
		}
	}
	function stopmovie( elm ) {
		var slot = 0;
		if( elm.slot !== void ) slot = +elm.slot;
		movies[slot].stop();
		if(storeElm[+elm.slot] !== void)
			(Dictionary.clear incontextof storeElm[+elm.slot])();
		base.visible = false;
	}

	function waitstop( elm ) {
		var slot = 0;
		if( elm.slot !== void ) slot = +elm.slot;
		elm["name"] = "finish_alpha_movie_" + slot;
		kag.waitTrigger( elm );
	}

	function nextmovie( elm ) {
		var slot = 0;
		if( elm.slot !== void ) slot = +elm.slot;
		var nloop = false;
		if( elm.loop !== void ) nloop = +elm.loop;
		movies[slot].nextLoop = nloop;
		movies[slot].setNextMovieFile( elm.storage );
	}

	function setoption( elm ) {
		var slot = 0;
		if( elm.slot !== void ) slot = +elm.slot;

		if( elm.left !== void ) movies[slot].left = +elm.left;
		if( elm.top !== void ) movies[slot].top = +elm.top;
		if( elm.loop !== void ) movies[slot].loop = +elm.loop;
		if( elm.visible !== void ) movies[slot].visible = +elm.visible;
		if( elm.frame !== void ) movies[slot].frame = +elm.frame;
		if( elm.opacity !== void ) movies[slot].opacity = +elm.opacity;
	}
	function onCopyLayer(toback) {
		// レイヤの表←→裏の情報のコピー
		// backlay タグやトランジションの終了時に呼ばれる
		// ここでレイヤに関してコピーすべきなのは
		// 表示/非表示の情報だけ

		//for( var i = 0; i < numAlphaMovies; i++ ) {
		//	movies[i].swapFronBackVisible();
		//}
	}
	function onExchangeForeBack() {
		// 裏と表の管理情報を交換
		// children = true のトランジションでは、トランジション終了時に
		// 表画面と裏画面のレイヤ構造がそっくり入れ替わるので、
		// それまで 表画面だと思っていたものが裏画面に、裏画面だと思って
		// いたものが表画面になってしまう。ここのタイミングでその情報を
		// 入れ替えれば、矛盾は生じないで済む。

		//for( var i = 0; i < numAlphaMovies; i++ ) {
		//	movies[i].swapFronBack();
		//}
	}
	function hasNextMovie( elm ) {
		var slot = 0;
		if( elm.slot !== void ) slot = +elm.slot;
		return movies[slot].hasNext;
	}
	function isPlayingMovie( elm ) {
		var slot = 0;
		if( elm.slot !== void ) slot = +elm.slot;
		return movies[slot].moving;
	}
	function frameMove( elm ) {
		var slot = 0;
		if( elm.slot !== void ) slot = +elm.slot;
		movies[slot].beginFrameMove(elm);
		return 0;
	}

	function onStore(f, elm){
//		if(f.alphaMovie === void)f.alphaMovie = [];
//		if(storeElm.count != 0){
//			f.alphaMovie.assignStruct(storeElm);
//		}else f.alphaMovie.clear();
	}

	function onRestore(f, clear, elm){
//		stopmovie(%[slot:0]);
//		stopmovie(%[slot:1]);
//		if(f.alphaMovie !== void && f.alphaMovie.count != 0){
//			for(var i=0; i<f.alphaMovie.count; i++)playmovie(f.alphaMovie[i]);
//		}
	}
}

// プラグインオブジェクトを作成し、登録する
kag.addPlugin(global.alphamovie_object = new AlphaMoviePlugin());

@endscript
@endif

; マクロ定義
; storage, slot, left, top, loop
@macro name=playamov
@eval exp="alphamovie_object.playmovie( mp )"
@endmacro

; 表情変更
@macro name=a_movie_change
@eval exp="alphamovie_object.changeFace( mp )"
@endmacro

; slot
@macro name=stopamov
@eval exp="alphamovie_object.stopmovie( mp )"
@endmacro

; storage, slot, loop
@macro name=nextamov
@eval exp="alphamovie_object.nextmovie( mp )"
@endmacro

; slot, left, top, loop, visible, frame opacity
@macro name=amovopt
@eval exp="alphamovie_object.setoption( mp )"
@endmacro

; slot canskip
@macro name=wam
@if exp="alphamovie_object.isPlayingMovie( mp )"
@if exp="mp.slot !== void"
@eval exp="tf.amov_trig_name = 'finish_alpha_movie_' + mp.slot"
@waittrig name="&tf.amov_trig_name" canskip=%canskip|true
@else
@waittrig name="finish_alpha_movie_0" canskip=%canskip|true
@endif
@endif
@endmacro

; slot canskip
@macro name=wamnext
@if exp="alphamovie_object.hasNextMovie( mp )"
@if exp="mp.slot !== void"
@eval exp="tf.amov_next_trig_name = 'next_alpha_movie_' + mp.slot"
@waittrig name="&tf.amov_next_trig_name" canskip=%canskip|true
@else
@waittrig name="next_alpha_movie_0" canskip=%canskip|true
@endif
@endif
@endmacro

; slot fps path
@macro name=amovmove
@eval exp="alphamovie_object.frameMove( mp )"
@endmacro

@return


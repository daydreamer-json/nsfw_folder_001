@if exp="typeof(global._film_effect_object) == 'undefined' "

@iscript

class _film_effect extends KAGPlugin
{

	var cMaxNoiseCount;	//画面に表示されるノイズ最大数
	var cMaxImages;		//画面に表示されるノイズ用画像数
	var cMaxLifeTime;	//ノイズ１コの最大生存時間
	var cFileName;

	var win;
	var rand;
	var timer;

	var flay, blay;
	var noise_img_f, noise_img_b;

	var fStopTrans, fStartTrans, fRun;
	var alive;

	function _film_effect(window)
	{
		cMaxNoiseCount	= 8;
		cMaxImages		= 68;//31
		cMaxLifeTime	= 5000;	//生存時間 最大5秒
		cFileName		= "sp_noise_";

		fRun		= false;
		fStartTrans	= false;
		fStopTrans	= false;
		alive		= false;

		this.win = window;
		rand = new Math.RandomGenerator();

		flay = new Layer(window, window.fore.base);
		flay.setSize(window.fore.base.width, window.fore.base.height);
		flay.face = dfAlpha;
		flay.type = ltAlpha;
		flay.fillRect(0, 0, flay.width, flay.height, 0);
		flay.hasImage = false;
		flay.absolute = 15000;

		blay = new Layer(window, window.back.base);
		blay.setSize(flay.width, flay.height);
		blay.face = dfAlpha;
		blay.type = ltAlpha;
		blay.fillRect(0, 0, blay.width, blay.height, 0);
		blay.hasImage = false;
		blay.absolute = 15000;

		noise_img_f = new Array();
		noise_img_b = new Array();
	}

	function finalize()
	{
		clean();

		invalidate noise_img_f;
		invalidate noise_img_b;

		invalidate rand;

		super.finalize(...);
	}

	function setup(absolute)
	{
		var i;
		var val;

		for(i = 0; i < cMaxNoiseCount; i++) {

			val = "%02d".sprintf(rand.random32() % cMaxImages);

			noise_img_f[i] = new Layer(this.win, flay);
			noise_img_b[i] = new Layer(this.win, blay);

			noise_img_f[i].loadImages(cFileName + val);
			noise_img_b[i].assignImages(noise_img_f[i]);
			noise_img_b[i].loded_img = noise_img_f[i].loded_img = cFileName + val;
			noise_img_f[i].setSizeToImageSize();

			noise_img_f[i].hitType		= noise_img_b[i].hitType = htMask;
			noise_img_f[i].hitThreshold	= noise_img_b[i].hitThreshold = 256;

			if(absolute != void)	noise_img_f[i].absolute	= noise_img_b[i].absolute = absolute;
			else					noise_img_f[i].absolute	= noise_img_b[i].absolute = 2000000 - 2;

			noise_img_f[i].visible = noise_img_b[i].visible = true;
			noise_img_f[i].life = (rand.random() * cMaxLifeTime) % cMaxLifeTime;
			noise_img_b[i].life = noise_img_f[i].life;
			noise_img_f[i].time = System.getTickCount();
			noise_img_b[i].time = noise_img_f[i].time;

		}
	}

	function update(index)
	{
		var val;
		var alive_time = System.getTickCount() - noise_img_f[index].time;

		if(noise_img_f[index].life < alive_time) {
			val = "%02d".sprintf(rand.random32() % cMaxImages);

			noise_img_f[index].loadImages(cFileName + val);
			noise_img_b[index].assignImages(noise_img_f[index]);
			noise_img_f[index].loded_img = cFileName + val;

			noise_img_f[index].setSizeToImageSize();
			noise_img_b[index].setSizeToImageSize();

			noise_img_f[index].life = (rand.random() * cMaxLifeTime) % cMaxLifeTime;
			noise_img_b[index].life = noise_img_f[index].life;

			noise_img_f[index].time = System.getTickCount();
			noise_img_b[index].time = noise_img_f[index].time;
		}
	}

	function start(elm = %[])
	{
		if(elm.absolute != void)	setup(elm.absolute);
		else						setup(2000000 - 2);

		if(elm.stop == void || elm.stop == "false") {
			fStartTrans = false;
			fRun = true;
		} else {
			fStartTrans = true;
			fRun = false;
		}

		fStopTrans = false;

		flay.visible = false;

		timer = new Timer(onTimer, "");
		//秒間18/24コマ
		timer.interval = 56;//42
		timer.enabled = true;

		alive = true;
	}

	function clean()
	{
		invalidate timer if timer !== void;
		timer = void;

		for(var i = 0; i < noise_img_f.count; i++){
			invalidate noise_img_f[i];
			invalidate noise_img_b[i];
		}

		noise_img_f.clear();
		noise_img_b.clear();

		alive = false;
	}

	function stop()
	{
		fStopTrans	= true;
		alive		= false;
	}


	function onTimer()
	{
		var i;

		if(!fRun){
			if(fStopTrans) {
				clean();
			}
			return;
		}

		flay.visible = false;
		blay.visible = false;
		for(i = 0; i < cMaxNoiseCount; i++) {
			update(i);
			noise_img_f[i].setPos(rand.random32() % 1280, rand.random32() % 720);
			noise_img_b[i].setPos(noise_img_f[i].left, noise_img_f[i].top);
			noise_img_b[i].assignImages(noise_img_f[i]);
		}

		//if( win.fore.base !== flay )	onExchangeForeBack();

		flay.visible = true;
		blay.visible = true;
	}

	function onExchangeForeBack()
	{
		var temp = noise_img_f;
		noise_img_f = noise_img_b;
		noise_img_b = temp;

		if(fStartTrans) {
			fRun = true;
			fStartTrans = false;
		}
		if(fStopTrans) {
			fRun = false;
			//clean();
		}
	}



	function onStore(f, elm)
	{
		// 栞を保存するとき
		//dic.init = timer !== void;
		if( f.plugin_film_effect === void )	f.plugin_film_effect = %[];
		( Dictionary.clear incontextof f.plugin_film_effect )();

		if( alive )	f.plugin_film_effect.alive = true;
		else		f.plugin_film_effect.alive = false;

		if( alive ) f.plugin_film_effect.absolute = noise_img_f[0].absolute;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		clean();
		if( f.plugin_film_effect === void )	f.plugin_film_effect = %[];
		if( f.plugin_film_effect.alive )	start( f.plugin_film_effect );
	}

}

kag.addPlugin(global._film_effect_object = new _film_effect(kag));

@endscript
@endif




@macro name="film_effect_start"
	@eval exp="global._film_effect_object.start(mp)"
@endmacro

@macro name="film_effect_stop"
	@eval exp="global._film_effect_object.stop()"
@endmacro

@macro name="film_effect_stop_now"
	@eval exp="global._film_effect_object.clean()"
@endmacro

@return
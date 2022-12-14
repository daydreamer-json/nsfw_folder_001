@if exp="typeof(global.lensfalre_object) == 'undefined'"

@iscript

class LensFlarePlugin extends KAGPlugin{
	var window;
	var total_time;
	var base_time_a;
	var base_time_b;
	var start_time;
	var accel = 0.0;
	var trans = 0.0;
	var deleteflag = false;
	var showflag = false;
	var radiant_flag = false;
	var radiant_fore = void;
	var radiant_back = void;
	var fore = [];
	var back = [];
	var path_ax = [];
	var path_ay = [];
	var path_aa = [];
	var path_bx = [];
	var path_by = [];
	var path_ba = [];

	var storeDic = %[];		//セーブ用の配列
	var moving = false;		//ムービングフラグ
	var alive = false;		//アクティブフラグ
	
	function LensFlarePlugin(win){
		super.KAGPlugin();
		window = win;
		radiant_fore = new Layer(window,window.fore.base);
		radiant_back = new Layer(window,window.back.base);
		radiant_fore.hitType = htMask;
		radiant_fore.hitThreshold = 256;
		radiant_fore.loadImages("ImgClear");
		radiant_fore.setSizeToImageSize();
		radiant_fore.visible = false;
		radiant_back.hitType = htMask;
		radiant_back.hitThreshold = 256;
		radiant_back.loadImages("ImgClear");
		radiant_back.setSizeToImageSize();
		radiant_back.visible = false;
		PositionInit();
	}

	function finalize(){
		Stop();
		deleteLayer();
		invalidate radiant_fore;
		invalidate radiant_back;
		path_ax.clear();
		path_ay.clear();
		path_aa.clear();
		path_bx.clear();
		path_by.clear();
		path_ba.clear();
		super.finalize();
	}

	// ★イメージファイルを読み込む
	// 引　数：配列（イメージファイル）
	// 戻り値：なし
	//-------------------------------------------------
	function LoadImg(elm){
		(Dictionary.assign incontextof storeDic)(elm);
		deleteLayer();
		var str = [].split("(),",elm.storage,,true);
		var mode = ltAlpha;
		try{
			if(elm.mode !== void){
				mode = imageTagLayerType[elm.mode].type;
			}
		}catch{
			mode = ltAlpha;
			dm("指定された描画形式はありません残念！");
		}

		var grayscale = (elm.grayscale !== void) ? +elm.grayscale : false;
		
		for(var i=0; str.count > i; i++){
			//dm(str[i]);
			fore.add(new Layer(this.window,this.window.fore.base));
			back.add(new Layer(this.window,this.window.back.base));
			fore[i].loadImages(str[i]);
			fore[i].setSizeToImageSize();
			
				if(grayscale){fore[i].doGrayScale();}
			
			back[i].assignImages(fore[i]);
			back[i].setSizeToImageSize();
			fore[i].hitType = htMask;
			fore[i].hitThreshold = 256;
			back[i].hitType = htMask;
			back[i].hitThreshold = 256;
			fore[i].absolute = back[i].absolute = 15000+i;
			fore[i].type = back[i].type = mode;		//TestSorces
		}
	}

	function deleteLayer(){
		for(var i=0;fore.count > i;i++){
			fore[i].visible = false;
			back[i].visible = false;
			invalidate fore[i];
			invalidate back[i];
		}
		fore.clear();
		back.clear();
	}

	function PositionInit(){
		Path_Array_Init(path_ax,path_ay,path_aa);
		Path_Array_Init(path_bx,path_by,path_ba);
	}

	function Path_Array_Init(ax,ay,aa){
		if(ax.count == 0){
			var ipx = window.scWidth\2;
			ax = [ipx,ipx];

			var ipa = 255;
			aa = [ipx,ipx];
		}else if(ax.count == 1){
			ax.add(ax[0]);
		}

		if(ay.count == 0){
			var ipy = window.scHeight\2;
			ay = [ipy,ipy];
		}else if(ay.count == 1){
			ay.add(ay[0]);
		}

		if(aa.count == 0){
			aa = [255,255];
		}else if(aa.count == 1){
			aa.add(aa[0]);
		}
	}
	
	function A_PathClear(){
		path_ax.clear();
		path_ay.clear();
		path_aa.clear();
	
	}

	function B_PathClear(){
		path_bx.clear();
		path_by.clear();
		path_ba.clear();
	}
	
	function MovePositionSet(elm){
		(Dictionary.assign incontextof storeDic)(elm,false);
		if(elm.a_path !== void){
			A_PathClear();
			var path = [].split("(),",elm.a_path,,true);
			for(var i=0; path.count\3 > i; i++){
				path_ax.add(+path[i*3]);
				path_ay.add(+path[i*3+1]);
				path_aa.add(+path[i*3+2]);
			}
			path.clear();
		}
		if(elm.b_path !== void){
			B_PathClear();
			var path = [].split("(),",elm.b_path,,true);
			for(var i=0; path.count\3 > i; i++){
				path_bx.add(+path[i*3]);
				path_by.add(+path[i*3+1]);
				path_ba.add(+path[i*3+2]);
			}
			path.clear();
		}
	}

	function Start(elm){
		(Dictionary.assign incontextof storeDic)(elm,false);
		radiant_flag = false;
		if(elm.radiant !== void){
			radiant_fore.loadImages(elm.radiant);
			radiant_fore.setSizeToImageSize();
			radiant_back.assignImages(radiant_fore);
			radiant_back.setSizeToImageSize();
			radiant_fore.absolute = radiant_back.absolute = 30000;
			radiant_fore.type = radiant_back.type = imageTagLayerType["add"].type;
			radiant_flag = true;
		}

		if(elm.rftime !== void){
			radiant_fade_time = elm.rftime;
		}
		
		if(elm.time !== void){
			total_time = +elm.time;
			// 0除算回避用コード
			if(total_time == 0){
				total_time = 1;
			}
		}else{
			total_time = 1000;
		}

		if(elm.accel !== void){
			accel = +elm.accel;
		}else{
			accel = 0.0;
		}
		
		if(elm.trans !== void){
			trans = +elm.trans;
		}else{
			trans = 0.0;
		}
		
		var forestate = false;
		var backstate = false;
		if(elm.page !== void){
			if(elm.page == "fore"){
				//表面レイヤを表示
				forestate = true;
			}else if(elm.page == "back"){
				//裏面例やを表示
				backstate = true;
			}else{
				//全レイヤを表示
				forestate = true;
				backstate = true;
			}
		}else{
			//全レイヤを表示
			forestate = true;
			backstate = true;
		}
		if(radiant_flag){
			radiant_fore.visible = forestate;
			radiant_back.visible = backstate;
		}
		for(var i = 0; fore.count > i; i++){
			fore[i].visible = forestate;
			back[i].visible = backstate;
		}
		deleteflag = (elm.delete == "true") ? true : false;
		showflag = (elm.show == "true") ? true : false;
		PositionInit();
		base_time_a = total_time / (path_ax.count - 1);
		base_time_b = total_time / (path_bx.count - 1);
		PathPosition(0);
		start_time = System.getTickCount();
		moving = true;
		alive = true;
		System.addContinuousHandler(continuousHandler);
	}

	function PathPosition(tick){
		var n_a,n_b;
		var d_a,d_b;
		n_a = tick\base_time_a;
		n_b = tick\base_time_b;
		d_a = (tick - base_time_a * n_a)/base_time_a;
		d_b = (tick - base_time_b * n_b)/base_time_b;
		var ary_a=[0,0,0];
		var ary_b=[0,0,0];
		if(n_a < path_ax.count-1){
			ary_a[0] = (path_ax[n_a+1] - path_ax[n_a]) *d_a + path_ax[n_a];
			ary_a[1] = (path_ay[n_a+1] - path_ay[n_a]) *d_a + path_ay[n_a];
			ary_a[2] = (path_aa[n_a+1] - path_aa[n_a]) *d_a + path_aa[n_a];
		}else{
			ary_a[0] = path_ax[path_ax.count-1];
			ary_a[1] = path_ay[path_ay.count-1];
			ary_a[2] = path_aa[path_aa.count-1];
		}
		if(n_b < path_bx.count-1){
			ary_b[0] = (path_bx[n_b+1] - path_bx[n_b]) *d_b + path_bx[n_b];
			ary_b[1] = (path_by[n_b+1] - path_by[n_b]) *d_b + path_by[n_b];
			ary_b[2] = (path_ba[n_b+1] - path_ba[n_b]) *d_b + path_ba[n_b];
		}else{
			ary_b[0] = path_bx[path_bx.count-1];
			ary_b[1] = path_by[path_by.count-1];
			ary_b[2] = path_ba[path_ba.count-1];
		}
		PositionDivision(ary_a,ary_b);
		ary_a.clear();
		ary_b.clear();
	}

	function PositionDivision(ap,bp){
		var percent = 1 / (fore.count - 1);
		
		for(var i=0;fore.count > i;i++){
			var aap = percent * i;
			if(trans > 0){
				aap = Math.pow(aap,trans);
			}else if(trans < 0){
				aap = 1.0 - aap;
				aap = Math.pow(aap,-trans);
				aap = 1.0 - aap;
			}
			var ipx = (bp[0] - ap[0]) * aap + ap[0];
			var ipy = (bp[1] - ap[1]) * aap + ap[1];
			var ipa = (bp[2] - ap[2]) * aap + ap[2];
			ImgPosition(i,ipx,ipy,ipa);
		}
	}

	function ImgPosition(n,x,y,a){
		var img_left = x - (fore[n].width\2);
		var img_top = y - (fore[n].height\2);
		fore[n].setPos(img_left,img_top);
		back[n].setPos(img_left,img_top);
		fore[n].opacity = back[n].opacity = a;
		//dm(fore[n].left + ":" + fore[n].top + ":" + fore[n].opacity);
	}

	function continuousHandler(tick){
		var late_time = tick - start_time;
		if(late_time < total_time){
			if(accel > 0){
				late_time = late_time / total_time;
				late_time = Math.pow(late_time,accel);
				late_time = int(late_time * total_time);
			}else if(accel < 0){
				late_time = 1.0 - late_time / total_time;
				late_time = Math.pow(late_time,-accel);
				late_time = int((1.0 - late_time) * total_time);
			}
			PathPosition(late_time);
		}else{
			PathPosition(total_time);
			Stop();
		}
	}

	function Stop(){
		if(moving){
			moving = false;
			PathPosition(total_time);
			System.removeContinuousHandler(continuousHandler);
			window.trigger('lensflare_plugin');
		}
	}

	function onExchangeForeBack(){
		//dm("s:"+showflag);
		//dm("d:"+deleteflag);
		if(deleteflag){
			deleteflag = false;
			radiant_fore.visible = radiant_back.visible = false;
			for(var i=0; fore.count > i;i++){
				fore[i].visible = false;
				back[i].visible = false;
			}
			alive = false;
		}

		if(showflag){
			showflag = false;
			if(radiant_flag){
				radiant_fore.visible = radiant_back.visible = true;
			}
			for(var j=0; fore.count > j; j++){
				fore[j].visible = true;
				back[j].visible = true;
			}
		}
		
		var tmp = fore;
		fore = back;
		back = tmp;

		tmp = radiant_fore;
		radiant_fore = radiant_back;
		radiant_back = tmp;
	}

	function Unvisible(){
		deleteflag = true;
		radiant_back.visible = false;
		for(var i = 0; back.count > i; i++){
			back[i].visible = false;
		}
	}

	//完全瞬間非表示
	function DeleteNowFunction(){
		Stop();
		for(var i=0;i<fore.count;i++){
			fore[i].visible = false;
			back[i].visible = false;
		}
		alive = false;
	}
	
	function onStore(f, elm){
		//表示されていたらセーブ
		if(alive){
			var dic = f["lensfalre"] = %[];
			(Dictionary.assign incontextof dic)(storeDic);
			dic.moving = moving;
			dic.foreVisible = fore[0].visible;
			dic.backVisible = back[0].visible;
			dic.deleteflag = deleteflag;
		}else{
			var dic = f["lensfalre"] = void;
		}
	}
	
	function onRestore(f, clear, elm){
		DeleteNowFunction();
		//動作を終了させて
		var dic = f["lensfalre"];
		if(dic !== void){
			if(dic.moving){
				if(dic.page == "back")dic.page = void;
				if(dic.show == "true")dic.show = void;
				else dic.page="with";
				// 停止中だった
				LoadImg(dic);
				MovePositionSet(dic);
				Start(dic);
			}else{
				dic.time = 0;
				if(dic.foreVisible && !dic.backVisible)dic.page="fore";
				else if(!dic.foreVisible && dic.backVisible)dic.page="back";
				else dic.page="with";
				// 停止中だった
				LoadImg(dic);
				MovePositionSet(dic);
				Start(dic);
			}
		}
	}
}

var lensfalre_object;
kag.addPlugin(global.lensfalre_object = new LensFlarePlugin(kag));

@endscript
@endif


@macro name="lensflare_load"
@eval exp="lensfalre_object.LoadImg(mp);"
@endmacro

@macro name="lensflare_setpos"
@eval exp="lensfalre_object.MovePositionSet(mp);"
@endmacro

@macro name="lensflare_start"
@eval exp="lensfalre_object.Start(mp);"
@endmacro

@macro name="lensflare_wait"
@waittrig * name="lensflare_plugin" onskip="lensfalre_object.Stop();" canskip=%canskip|true cond="lensfalre_object.moving"
@endmacro

@macro name="lensflare_stop"
@eval exp="lensfalre_object.Stop();"
@endmacro

@macro name="lensflare_delete"
@eval exp="lensfalre_object.Unvisible()"
@endmacro

@macro name="lensflare_delete_now"
@eval exp="lensfalre_object.DeleteNowFunction()"
@endmacro


@return



@if exp="typeof(global.movieswitch_object) == 'undefined'"
@iscript

// ムービーと静止画の切り替え用プラグイン

class MovieSwitchPlugin extends KAGPlugin
{
	var evcg = "";
	var movie = "";
	var slot = 0;

	function MovieSwitchPlugin(){
		super.KAGPlugin(...);
	}

	function finalize(){
		super.finalize(...);
	}

	// 再開用ファイルの記録
	function remTargetFile(_evcg="black", _movie, _slot){
		evcg = _evcg;
		movie = _movie;
		slot = _slot;
	}

	// 再開用ファイルを忘れる
	function clearTargetFile(){
		evcg = "";
		movie = "";
		slot = 0;
	}

	// 動画と静止画の切り替え、コンフィグから呼ばれる
	function switchMovieCg(){
		if(evcg == "")return;

		if(sysLive2D){
			// 動画再開
			playMovie(movie, slot);
		}else{
			// CG配置
			loadCg(evcg);
		}
	}

	function playMovie(storage, _slot){
		// 全停止
		kag.movies[0].stop();
		kag.movies[1].stop();
		kag.fore.layers[0].freeImage();
		kag.fore.layers[0].visible = true;
		kag.fore.layers[1].freeImage();
		kag.fore.layers[2].freeImage();
		// オプション
		var layerNo = (_slot == 0) ? 1 : 2;
		var movieObj = kag.movies[_slot];
		kag.fore.layers[layerNo].setOptions(%[opacity:255, left:0, top:0, width:kag.scWidth, height:kag.scHeight]);
		movieObj.setOptions(%[visible:true, left:0, top:0, mode:"layer", loop:true]);
		movieObj.storeLayer( layerNo, "fore", 1 );
		movieObj.setVideoLayer(kag.fore.layers[layerNo], %[channel:1, page:"fore", layer:layerNo]);
		movieObj.storeLayer( layerNo, "back", 2 );
		movieObj.setVideoLayer(kag.fore.layers[layerNo], %[channel:2, page:"back", layer:layerNo]);
		movieObj.open(storage + ".mpg");
		movieObj.play();
		kag.fore.layers[layerNo].visible = true;
	}
	function loadCg(storage){
		// 全停止
		kag.movies[0].stop();
		kag.movies[1].stop();
		kag.fore.layers[1].freeImage();
		kag.fore.layers[2].freeImage();
		kag.fore.layers[0].loadImages(%[storage:storage, visible:true]);
	}

	function onExchangeForeBack() {
		// タイトルに戻ったらクリアするように
		if(kag.mainConductor.curStorage == "title.ks" && evcg != "")clearTargetFile();
	}

	function onStore(f, elm){
		f.movieSwitchEvcg = evcg;
		f.movieSwitchMovie = movie;
		f.movieSwitchSlot = slot;
	}

	function onRestore(f, clear, elm){
		if(f.movieSwitchEvcg === void || f.movieSwitchEvcg == "")return;
		evcg = f.movieSwitchEvcg;
		movie = f.movieSwitchMovie;
		slot = f.movieSwitchSlot;
		if(sysLive2D){	// 動画再開
			playMovie(f.movieSwitchMovie, f.movieSwitchSlot);
		}else{			// CG配置
			loadCg(f.movieSwitchEvcg);
		}
	}
}
// 監視用：global.movieswitch_object.evcg

// もともとの動画のセーブロード機構を削除
for(var i=0; i<kag.movies.count; i++){
	kag.movies[i].store = function(){};
	kag.movies[i].restore = function(){};
}

// プラグインオブジェクトを作成し、登録する
kag.addPlugin(global.movieswitch_object = new MovieSwitchPlugin());

@endscript
@endif
@return
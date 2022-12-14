
@if exp="typeof(global.moviese_object) == 'undefined'"
@iscript

class MovieSePlugin extends KAGPlugin
{
	var numSEBuffers = 10;
	var numVoiceBuffers = 2;
	var se = [];
	var voice = [];
	var cnt = 0;
	var cntv = 0;
	var timer;
	var prevPosition = 0;
	var curPosition = 0;
	var seList = [];
	var voiceList = [];
	var slot;
	
	var seSetList = %[
		"ピストンset1"=>"zmse_Ｈ_ピストン_09,zmse_Ｈ_ピストン_11",
		"ピストンset2"=>"zmse_Ｈ_ピストン_09-2,zmse_Ｈ_ピストン_11-2",
		"ピストンset3"=>"zmse_Ｈ_ピストン_09-3,zmse_Ｈ_ピストン_11-3",
		"ピストン３set1"=>"zmse_Ｈ_ピストン３_01,zmse_Ｈ_ピストン３_02,zmse_Ｈ_ピストン３_03,zmse_Ｈ_ピストン３_04,zmse_Ｈ_ピストン３_05,zmse_Ｈ_ピストン３_06,zmse_Ｈ_ピストン３_07,zmse_Ｈ_ピストン３_08",
		"ピストン３強set1"=>"zmse_Ｈ_ピストン３強_01,zmse_Ｈ_ピストン３強_02,zmse_Ｈ_ピストン３強_03,zmse_Ｈ_ピストン３強_04,zmse_Ｈ_ピストン３強_05,zmse_Ｈ_ピストン３強_06,zmse_Ｈ_ピストン３強_07,zmse_Ｈ_ピストン３強_08",
		"水音set1"=>"zmse_Ｈ_水音_01,zmse_Ｈ_水音_02,zmse_Ｈ_水音_03,zmse_Ｈ_水音_04,zmse_Ｈ_水音_05,zmse_Ｈ_水音_06,zmse_Ｈ_水音_07,zmse_Ｈ_水音_08,zmse_Ｈ_水音_09,zmse_Ｈ_水音_10,zmse_Ｈ_水音_11",
		"肌こすれset1"=>"zmse_Ｈ_肌こすれ_01,zmse_Ｈ_肌こすれ_02,zmse_Ｈ_肌こすれ_03",
		"射精set1"=>"zmse_Ｈ_射精_01,zmse_Ｈ_射精_02,zmse_Ｈ_射精_03",
		"ちゃぷset1"=>"zmse_Ｈ_ちゃぷ_01,zmse_Ｈ_ちゃぷ_02,zmse_Ｈ_ちゃぷ_03,zmse_Ｈ_ちゃぷ_04,zmse_Ｈ_ちゃぷ_05",
		"舐めset1"=>"zmse_Ｈ_舐め_01,zmse_Ｈ_舐め_02,zmse_Ｈ_舐め_03,zmse_Ｈ_舐め_04,zmse_Ｈ_舐め_05,zmse_Ｈ_舐め_06,zmse_Ｈ_舐め_07,zmse_Ｈ_舐め_08,zmse_Ｈ_舐め_09,zmse_Ｈ_舐め_10,zmse_Ｈ_舐め_11,zmse_Ｈ_舐め_12,zmse_Ｈ_舐め_13,zmse_Ｈ_舐め_14,zmse_Ｈ_舐め_15,zmse_Ｈ_舐め_16,zmse_Ｈ_舐め_17,zmse_Ｈ_舐め_18,zmse_Ｈ_舐め_19,zmse_Ｈ_舐め_20,zmse_Ｈ_舐め_21,zmse_Ｈ_舐め_22"
	];

	function MovieSePlugin(){
		super.KAGPlugin(...);
		for(var i = 0; i < numSEBuffers; i++){
			se[i] = new SESoundBuffer(kag, i);
			se[i].yuragi = false;
			se[i].onStatusChanged = function(status){
				if(status == "play" && yuragi){
					var pon = intrandom(0,1) ? 1 : -1;
					frequency = 44100 + (pon * (intrandom(1,5)*1000));
					//dm(frequency);
				}
			}incontextof se[i];
		}
		for(var i = 0; i < numVoiceBuffers; i++){
			voice[i] = new SESoundBuffer(kag, i);
		}
		timer = new Timer(onTimer, "");
		timer.interval = 20;
	}

	function finalize(){
		timer.enabled = false;
		invalidate timer;
		for(var i=0; i<numSEBuffers; i++)invalidate se[i];
		for(var i=0; i<numVoiceBuffers; i++)invalidate voice[i];
		se.clear();
		voice.clear();
		super.finalize(...);
	}

	function addSe(time, storage, yura = true){
		var timeList = [];
		if(time.indexOf(",") != -1){
			var ar = time.split(",");
			timeList.assign(ar);
		}else timeList.add(time);
		for(var i=0; i<timeList.count; i++){
			if(seSetList[storage] !== void){
				seList.add([timeList[i], seSetList[storage], false, +yura]);
			}else{
				seList.add([timeList[i], storage, false, +yura]);
			}
		}
	}
	function addVoice(time, storage){
		voiceList.add([time, storage, false]);
	}

	function start(_slot){
		slot = _slot;
		timer.enabled = true;
	}

	function stop(){
		timer.enabled = false;
		seList.clear();
		voiceList.clear();
		for(var i=0; i<se.count; i++)se[i].fadeOut(%[time:200]);
		for(var i=0; i<voice.count; i++)voice[i].fadeOut(%[time:200]);
		prevPosition = 0;
		slot = void;
	}

	function playSe(storage, yura = true){
		var obj = se[cnt];
		if(storage.indexOf(",") != -1){
			var ar = storage.split(",");
			storage = ar[intrandom(0,ar.count-1)];
		}
		obj.yuragi = yura;
		if(obj.volume2 != (sysSeVolume*1000))obj.setOptions(%[/*volume:100,*/gvolume:sysSeVolume]);
		obj.play(%[storage:storage], true);
		if(++cnt >= numSEBuffers)cnt = 0;
	}

	function playVoice(storage){
		var obj = voice[cntv];
		if(storage.indexOf(",") != -1){
			var ar = storage.split(",");
			storage = ar[intrandom(0,ar.count-1)];
		}

		var per = getVoiceVolume(storage);
		obj.setOptions(%[/*volume:100,*/gvolume:sysVoiceVolume*per]);

		obj.play(%[storage:storage], true);
		if(++cntv >= numVoiceBuffers)cntv = 0;
	}

	function onTimer(){
		var movie;
		if(slot !== void && kag.movies[slot] != void){
			movie = kag.movies[slot];
		}else{
			movie = kag.movies[0].lastStatus == "play" ? kag.movies[0] : kag.movies[1];
		}
		if(movie.lastStatus != "play")return;
		curPosition = movie.position;
		if(curPosition < prevPosition){
			// 一周したら鳴らしたフラグを消す
			prevPosition = 0;
			for(var i=0; i<seList.count; i++){
				seList[i][2] = false;
			}
			for(var i=0; i<voiceList.count; i++){
				voiceList[i][2] = false;
			}
		}
		// SEを鳴らす
		for(var i=0; i<seList.count; i++){
			var tar = seList[i];
			if(!tar[2] && curPosition >= tar[0]){
				playSe(tar[1], tar[3]);
				tar[2] = true;
			}
		}
		// voiceを鳴らす
		for(var i=0; i<voiceList.count; i++){
			var tar = voiceList[i];
			if(!tar[2] && curPosition >= tar[0]){
				playVoice(tar[1]);
				tar[2] = true;
			}
		}
		
		// ひとつ前のフレーム更新
		prevPosition = curPosition;
	}

	function onStore(f, elm){
		if(f.movieSeList === void)f.movieSeList = [];
		if(seList.count != 0){
			f.movieSeList.assignStruct(seList);
		}else f.movieSeList.clear();
		if(f.movieVoiceList === void)f.movieVoiceList = [];
		if(voiceList.count != 0){
			f.movieVoiceList.assignStruct(voiceList);
		}else f.movieVoiceList.clear();
		f.movieSeSlot = slot;
	}

	function onRestore(f, clear, elm){
		stop();
		slot = f.movieSeSlot;
		var replay = false;
		if(f.movieSeList !== void && f.movieSeList.count !=0){
			seList.assignStruct(f.movieSeList);
			replay = true;
		}
		if(f.movieVoiceList !== void && f.movieVoiceList.count !=0){
			voiceList.assignStruct(f.movieVoiceList);
			replay = true;
		}
		if(replay)start();
	}
}

// プラグインオブジェクトを作成し、登録する
kag.addPlugin(global.moviese_object = new MovieSePlugin());




// 開始時間から終了時間まで指定した時間をあけた時間の羅列の文字列を生成((例)0,400,800)
function createRegularIntervalTimeStr(start=0, end=1000, time=400){
	var num = start;
	var result = (string)start;
	while(num <= end){
		num += time;
		result += ("," + num);
	}
	return result;
}


@endscript
@endif

;---------------------------------
; ムービーSEの追加
;---------------------------------
@macro name="mvse_add"
@eval exp="moviese_object.addSe(mp.time, mp.se, mp.yuragi);" cond="mp.se !== void"
@eval exp="moviese_object.addVoice(mp.time, mp.voice);" cond="mp.voice !== void"
@endmacro
;---------------------------------
; ムービーSE再生開始
;---------------------------------
@macro name="mvse_start"
@eval exp="moviese_object.start(mp.slot);"
@endmacro
;---------------------------------
; ムービーSE停止
;---------------------------------
@macro name="mvse_stop"
@eval exp="moviese_object.stop();"
@endmacro


;---------------------------------
; Hシーン用ムービー
;---------------------------------
@macro name="ev_movie"
@eval exp="mp.layer = kag.movies[0].lastStatus != 'play' ? '1' : '2'"
@eval exp="mp.slot = kag.movies[0].lastStatus != 'play' ? '0' : '1'"
@fovo cond="mp.dontstopvo != 'true'"
@info_stop
@clearlayers
@if exp="sysLive2D || mp.force == 'true'"
@layopt layer=%layer|1 page=back visible=false opacity=255 left=0 top=0 
@video visible=true left=0 top=0 slot=%slot|0 mode=layer loop=%loop|true
@videolayer slot=%slot|0 channel=1 page=back layer=%layer|1
@openvideo slot=%slot|0 storage="&(mp.storage+'.mpg')"
@preparevideo slot=%slot|0
@wp slot=%slot|0 for="prepare"
@playvideo slot=%slot|0
; moviese開始
@mvse_start slot=%slot
@layopt layer=%layer|1 page=back visible=true
@trans method=crossfade time=%time|500
@wt
@videolayer slot=%slot|0 channel=1 page=fore layer=%layer|1
@videolayer slot=%slot|0 channel=2 page=back layer=%layer|1
@stopvideo slot="&mp.slot == '0' ? '1' : '0'"
@clearvideolayer slot="&mp.slot == '0' ? '1' : '0'" channel=1
@clearvideolayer slot="&mp.slot == '0' ? '1' : '0'" channel=2
;@videosegloop slot=%slot|0 start=0 end=301
@else
@ev storage=%evcg
@endif
@eval exp="sf[mp.storage]=true" cond="mp.storage !== void && mp.storage !== ''"
@if exp="mp.loop == 'false'"
@eval exp="global.movieswitch_object.remTargetFile('', '', 0)"
@else
@eval exp="global.movieswitch_object.remTargetFile(mp.evcg, mp.storage, mp.slot)"
@endif
@endmacro

;---------------------------------
; ムービーの再生時間-700ms待つ
;---------------------------------
@macro name="ev_movie_wait"
@wait time="&kag.movies[0].lastStatus == 'play' ? (kag.movies[0].totalTime-700) : (kag.movies[1].totalTime-700)"
;@wv slot=%slot canskip=%cankip|true
@endmacro

;---------------------------------
; ムービーの停止を行いつつstorageの画像へ切り替え
;---------------------------------
@macro name="ev_movie_stop"
@simg storage=%storage|black layer=3 page=back
@trans method=crossfade time=%time|500
@wt
@stopvideo slot=0
@stopvideo slot=1
@clearvideolayer slot=0 channel=1
@clearvideolayer slot=0 channel=2
@clearvideolayer slot=1 channel=1
@clearvideolayer slot=1 channel=2
@clearlayers
@simg storage=%storage|black layer=0 page=back
@forelay
@eval exp="global.movieswitch_object.clearTargetFile()"
@endmacro

@return
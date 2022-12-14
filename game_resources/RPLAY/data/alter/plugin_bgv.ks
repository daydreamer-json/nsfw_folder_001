@if exp="typeof(global.bgv_object) == 'undefined'"
@iscript


/*==============================================================================================================
	内容：BGVの再生などを行うクラス
	備考：
==============================================================================================================*/
class BGVPlugin extends KAGPlugin
{
	var owner;
	var bgv;

	var bgvFadeTime;       // フェード時間
	var bgvChar;           // BGV再生キャラクター
	var bgvType;           // BGV再生種類
	var bgvEffect;         // エフェクト付きを再生するか
	var bgvVolumeForce;    // 複数同時再生時用の係数の影響を受けない時用

	var bgvPlayState = false;	// 【f.bgvPlaying】の代用
	var bgvPlaying   = false;
	var noPlayFlag   = false;	// playの再に"stop"のステータス変更が飛んでくるので再playがループしてしまうのを避けるフラグ

	var oldPlayNo = -1;
	var playList  = [];
	var playCount = 0;

	//var bgvList = %[];		// game_setting.tjsに移動「globalBgvList」


	/*------------------------------------------------------------
		内　容：コンストラクタ
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function BGVPlugin()
	{
		super.KAGPlugin(...);
		bgv = new SESoundBuffer(this, 60);
		bgv.owner = this;
		bgv.onStatusChanged = function(status){
			owner.onSoundStatusChanged(status);
		}incontextof bgv;
	}


	/*------------------------------------------------------------
		内　容：デストラクタ
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function finalize()
	{
		invalidate bgv;
		super.finalize(...);
	}


	/*------------------------------------------------------------
		内　容：BGVの再生準備を行い、再生する
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function start()
	{
		var listMax;
		var numList = [];

		if( bgvEffect )	listMax = globalBgvList[bgvType + "エフェクト"].count;
		else			listMax = globalBgvList[bgvType].count;

		playList.clear();

		for(var i=0; i<listMax; i++){ numList.add(i); }
		for(var i=0; i<listMax; i++){
			if(numList.count == 0)break;
			var index = intrandom(0,numList.count-1);
			playList.add(numList[index]);
			numList.erase(index);
		}

		playCount = 0;
		if(playList[0] == oldPlayNo)playCount++;

		bgvPlaying = true;

		playBGV();
		return 1;
	}


	/*------------------------------------------------------------
		内　容：BGV再生の指定キャラクターの個別音量がミュートでないか調べる
		引　数：なし
		戻り値：ミュートの場合     → true
	            ミュートで無い場合 → false
		備　考：
	------------------------------------------------------------*/
	function checkCharVoiceMute()
	{
		var chr = bgvChar;

		if( !( chr == "その他男" || chr == "その他女" ) && characterList.find(chr) != -1 ) chr = "その他女";
		if( sf["vom"+chr] )	                                                               return true;

		return false;
	}


	/*------------------------------------------------------------
		内　容：BGVの音量を変更する
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function bgvChangeVolume()
	{
		//キャラクターボイスのミュートの影響を受ける
		if( bgvPlaying && bgvChar !== void &&  bgvChar != "")
		{
			var _coefficient = owner.coefficient;
			var _voiceVolume;
			var _bgvVolume;

			if( bgvChar == "その他男" || bgvChar == "その他女" )
			{
				_voiceVolume = sysVoiceVolumeMute ? 0 : sf["vol"+bgvChar];
				_bgvVolume   = sysBGVVolumeMute   ? 0 : sf["bgv"+bgvChar];
			}
			else
			{
				var _char = globalNameToVoiceHeader[bgvChar];
				_voiceVolume = sysVoiceVolumeMute ? 0 : getVoiceVolume(_char);
				_bgvVolume   = sysBGVVolumeMute   ? 0 : getBgvVolume(_char);
			}

			// 複数同時再生時に現在の係数の影響を受けない場合、係数の値をデフォルト値に設定
			if( bgvVolumeForce ) _coefficient = owner.COEFFICIENT_DEF;

			// キャラクターボイス音量に影響を受けるとき用
			bgv.volume2 = (int)((sysBGVVolume * _voiceVolume) * _coefficient * 1000);

			// 個別にＢＧＶの音量を設定できるとき用
			//bgv.volume2 = (int)(sysBGVVolume * _voiceVolume * _bgvVolume * _coefficient * 1000);

			// キャラクターボイス音量に影響を受けないかつ個別にＢＧＶの音量が設定できないとき用
			//bgv.volume2 = (int)(sysBGVVolume * _coefficient * 1000);

			if( checkCharVoiceMute() )	bgv.setOptions(%[volume:0]);
			else						bgv.setOptions(%[volume:sysBGVVolume]);
		}
	}

	/*------------------------------------------------------------
		内　容：BGVの音量などを調整して再生する
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function playBGV()
	{
		var searchCnt   = 0;
		var playBgvName = "";
		var ies         = Storages.isExistentStorage;

		var _char = globalNameToVoiceHeader[bgvChar];

		noPlayFlag = true;

		if(bgvChar === void) return 0;
		if(bgvType === void) return 0;

		// ここいらない気がしたのでコメントアウト 2018/04/19 「sysHBgv」もシステム変数から削除したから戻すなら 「!sysBGVVolumeMute」とかですね
		//if(sysHBgv)          bgv.setOptions(%[volume:80]);
		//else                 bgv.setOptions(%[volume:0]);

		bgvChangeVolume();

		if(playCount >= playList.count)playCount = 0;
		oldPlayNo = playList[playCount];

		if( bgvType == "オリジナル" ) playBgvName = globalBgvList[bgvType].count == 0 ? "" : globalBgvList[bgvType][oldPlayNo];
		else if( bgvEffect )          playBgvName = _char+"BGV_"+globalBgvList[bgvType+"エフェクト"][oldPlayNo];
		else                          playBgvName = _char+"BGV_"+globalBgvList[bgvType][oldPlayNo];

		var find = true;
		while( !ies( playBgvName + ".wav" ) && !ies( playBgvName + ".ogg" ) )
		{
			if( searchCnt > playList.count )
			{
				dm(
					"\n==================================================\n"+
					"下記ＢＧＶが存在していません\n"+
					playBgvName+
					"\n==================================================\n"
				  );

				if( bgvType == "オリジナル" && playBgvName == "" || playBgvName === void ) playBgvName = globalBgvList[bgvType][0];
				else if( playBgvName == "" || playBgvName === void )                       playBgvName = _char+"BGV_"+globalBgvList[bgvType][0];

				find = false;
				break;
			}

			playCount++;

			if(playCount >= playList.count)playCount = 0;
			oldPlayNo = playList[playCount];

			if( bgvType == "オリジナル" ) playBgvName = globalBgvList[bgvType].count == 0 ? "" : globalBgvList[bgvType][oldPlayNo];
			else if( bgvEffect )          playBgvName = _char+"BGV_"+globalBgvList[bgvType+"エフェクト"][oldPlayNo];
			else                          playBgvName = _char+"BGV_"+globalBgvList[bgvType][oldPlayNo];

			searchCnt++;
		}

		if(find)bgv.play(%[storage:playBgvName]);
		//if( bgvEffect )	bgv.play(%[storage:_char+"BGV_"+globalBgvList[bgvType+"エフェクト"][oldPlayNo]]);
		//else			bgv.play(%[storage:_char+"BGV_"+globalBgvList[bgvType][oldPlayNo]]);

		playCount += 1;
		noPlayFlag = false;
	}


	/*------------------------------------------------------------
		内　容：フェードアウト
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function fadeout()
	{
		bgvPlaying = false;
		noPlayFlag = false;
		bgvChar = void;
		bgvType = void;
		bgvEffect = false;
		//bgv.stop();
		bgv.fade(%[volume:0, time:bgvFadeTime]);
	}


	/*------------------------------------------------------------
		内　容：一時停止
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function pause()
	{
		bgvPlaying   = false;
		noPlayFlag   = false;

		bgv.fade(%[volume:0, time:100]);
	}


	/*------------------------------------------------------------
		内　容：停止
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function stop()
	{
		bgvPlayState   = false;
		bgvPlaying     = false;
		noPlayFlag     = false;
		bgvChar        = void;
		bgvType        = void;
		bgvEffect      = false;
		bgvVolumeForce = false;

		//bgv.stop();
		bgv.fade(%[volume:0, time:100]);
	}


	/*------------------------------------------------------------
		内　容：
		引　数：status：
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function onSoundStatusChanged(status)
	{
		if(status == "stop" && bgvPlaying && !noPlayFlag){
			playBGV();
		}
	}


	/*------------------------------------------------------------
		内　容：
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function onExchangeForeBack(){}


	/*------------------------------------------------------------
		内　容：BGVフェード停止完了確認
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function onSESoundBufferFadeCompleted()
	{
		// 効果音のフェードが終了した
		kag.conductor.trigger('bgv_fade_end');
	}


	/*------------------------------------------------------------
		内　容：通常ボイス及びLCのステータス変更の際にココが呼ばれる
		引　数：status
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function normalVoiceStateChanged(status){
		// 音声終了後再開
		if( bgvPlayState && !bgvPlaying ) start();
	}
}





/*==============================================================================================================
	内容：BGVの再生を管理するクラス
	備考：
==============================================================================================================*/
class cBgvManager
{
	var COEFFICIENT_DEF = 1.0;  // 複数同時再生時用の音量係数デフォルト値
	var COEFFICIENT_MAX = 1.0;  // 複数同時再生時用の音量係数最大値
	var COEFFICIENT_MIN = 0.5;  // 複数同時再生時用の音量係数最小値

	var numBGVBuffers = 6;
	var bgvList       = [];
	var coefficient   = 1.0;  // 複数同時再生時用の音量係数



	/*------------------------------------------------------------
		内　容：コンストラクタ
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function cBgvManager()
	{
		for( var i = 0; i < numBGVBuffers; i++ )
		{
			bgvList[ i ]       = new BGVPlugin();
			bgvList[ i ].owner = this;
		}
	}


	/*------------------------------------------------------------
		内　容：デストラクタ
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function finalize()
	{
		for( var i = 0; i < bgvList.count; i++ )
		{
			invalidate bgvList[ i ];
		}
		bgvList.clear();
	}


	// データの設定関連
	/*------------------------------------------------------------
		内容       ：各種データを設定
		elm.buf    ：バッファ番号
	    elm.name   ：BGV再生対象キャラクター
	    elm.type   ：BGVの種類
	    elm.effect ：BGVにエフェクトをかけた物をしようするか
	    elm.storage：指定したボイスでBGVのリストを作成するとき用
		戻り値     ：なし
		備考       ：
	------------------------------------------------------------*/
	function setData( elm = %[] )
	{
		var buf = elm.buf;
		if( buf === void )	buf = 0;

		with( bgvList[ buf ] )
		{
			.bgvPlayState = true;

			// BGV対象キャラクターを決定
			if(elm.name === void)elm.name = characterList[0];
			.bgvChar = elm.name;

			// BGVの再生タイプを選択
			if(elm.type === void)elm.type = "喘ぎ弱";
			.bgvType = elm.type;

			// BGVのエフェクトを選択
			if( elm.effect === void ) elm.effect = false;
			.bgvEffect = elm.effect;

			// BGVのオリジナルリストを作成
			if(elm.storage !== void && elm.type == "オリジナル")
			{
				var storages = elm.storage.split(/,/,,true);
				var ies      = Storages.isExistentStorage;

				.bgvList[.bgvType].clear();
				for( var i = 0; i < storages.count; i++ )
				{
					if( ies(storages[ i ]+".wav") || ies(storages[ i ]+".ogg") ) .bgvList[.bgvType].add( storages[ i ] );
					else                                                         dm("BGVのオリジナルリスト追加に失敗しました："+storages[ i ]);
				}
			}

			// 複数同時再生時の係数の影響を受けないかの設定
			if(elm.vol_force === void)elm.vol_force = false;
			.bgvVolumeForce = elm.vol_force;
		}

		setCoefficient();   // BGVを再生しているバッファの数によりBGV音量の係数を変更する
		allChangeVolume();  // 全BGVバッファの音量変更
	}

	/*------------------------------------------------------------
		内容       ：複数同時再生時の係数設定
		戻り値     ：なし
		備考       ：
	------------------------------------------------------------*/
	function setCoefficient()
	{
		var cnt = 0;

		for( var i = 0; i < numBGVBuffers; i++ )
		{
			if( bgvList[ i ].bgvPlayState ) cnt++;
		}

		coefficient = COEFFICIENT_DEF;
		if( cnt >= 2 )                      coefficient = COEFFICIENT_DEF - ( cnt * 0.1 );
		if( coefficient < COEFFICIENT_MIN ) coefficient = COEFFICIENT_MIN;
	}


	// 再生関連
	/*------------------------------------------------------------
		内　容：指定バッファのBGV再生を行う
		aBuf  ：バッファ番号
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function start( aBuf = 0 ){ bgvList[ aBuf ].start(); }


	/*------------------------------------------------------------
		内　容     ：指定したボイスを一度だけBGVとして再生させる
		elm.buf    ：バッファ番号
	    elm.name   ：BGV再生対象キャラクター
	    elm.storage：再生ボイス
		戻り値     ：なし
		備　考     ：
	------------------------------------------------------------*/
	function oneTimePlay( elm = %[] )
	{
		with( bgvList[ elm.buf ] )
		{
			.stop();
			.bgvChar = elm.name;

			if( .bgvChar == "その他男" || .bgvChar == "その他女" )
			{
				var per  = sf["vom"+.bgvChar] ? 0 : sf["vol"+.bgvChar];
				var mute = sf["bgm"+.bgvChar] ? 0 : sf["bgv"+.bgvChar];
				.bgv.volume2 = (int)(sysBGVVolume*per*mute*1000);
			}
			else
			{
				var _char = globalNameToVoiceHeader[.bgvChar];
				.bgv.volume2 = (int)(sysBGVVolume*getVoiceVolume(_char)*getBgvVolume(_char) * 1000);
			}

			if( .checkCharVoiceMute() )	.bgv.setOptions(%[volume:0]);
			else						.bgv.setOptions(%[volume:sysBGVVolume]);
        
			.bgv.play(%[storage:elm.storage]);
		}
	}


	/*------------------------------------------------------------
		内　容：LCのステータス変更の際にココが呼ばれる
		引　数：status
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function normalVoiceStateChanged(status){
		// 音声終了後再開
		for( var i = 0; i < bgvList.count; i++ )
		{
			bgvList[ i ].normalVoiceStateChanged(status);
		}
	}


	// 一時停止関連
	/*------------------------------------------------------------
		内　容：指定したバッファのBGVを一時停止する
		aBuf  ：バッファ番号
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function pause( aBuf = 0 ){ bgvList[ aBuf ].pause(); }


	/*------------------------------------------------------------
		内　容  ：発言者がBGVの再生対象だった場合、BGVを一時停止する
		aSpeaker：発言者
		戻り値  ：なし
		備　考  ：
	------------------------------------------------------------*/
	function autoPause( aSpeaker )
	{
		for( var i = 0; i < bgvList.count; i++ )
		{
			if( bgvList[ i ].bgvChar == aSpeaker )
			{
				bgvList[ i ].pause();
				break;
			}
		}
	}


	// 停止関連
	/*------------------------------------------------------------
		内　容：指定したバッファのBGVを停止する
		aBuf  ：バッファ番号
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function stop( aBuf = 0 )
	{
		bgvList[ aBuf ].stop();

		setCoefficient();   // BGVを再生しているバッファの数によりBGV音量の係数を変更する
		allChangeVolume();  // 全BGVバッファの音量変更
	}


	/*------------------------------------------------------------
		内　容：すべてのバッファのBGVを停止する
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function allStop()
	{
		for( var i = 0; i < bgvList.count; i++ ){ stop( i ); }
	}


	// フェードアウト関連
	/*------------------------------------------------------------
		内　容  ：指定バッファのBGVを指定時間でフェードアウトする
		elm.buf ：バッファ番号
	    elm.time：フェード時間
		戻り値  ：なし
		備　考  ：
	------------------------------------------------------------*/
	function fadeout( elm = %[] )
	{
		var buf = elm.buf;
		if( buf === void ) buf = 0;
		
		bgvList[ buf ].bgvFadeTime = elm.time;
		if( elm.time === void ) bgvList[ buf ].bgvFadeTime = 1000;

		bgvList[ buf ].fadeout();
	}


	// 音量設定関連
	/*------------------------------------------------------------
		内　容    ：指定バッファのBGVの音量設定を行う
		elm.buf   ：バッファ番号
	    elm.volume：音量
		戻り値    ：なし
		備　考    ：
	------------------------------------------------------------*/
	function setVolume( elm = %[] )
	{
		var buf = elm.buf;
		if( buf === void ) buf = 0;

		if( bgvList[ buf ].bgvPlaying ) bgvList[ buf ].setOptions(%[volume:elm.volume]);
	}


	/*------------------------------------------------------------
		内　容    ：全バッファのBGVの音量設定を行う
		elm.volume：音量
		戻り値    ：なし
		備　考    ：
	------------------------------------------------------------*/
	function allSetVolume( elm = %[] )
	{
		for( var i = 0; i < bgvList.count; i++ )
		{
			setVolume( %[buf:i, volume:elm.volume] );
		}
	}


	/*------------------------------------------------------------
		内　容：指定バッファのBGVの音量変更を行う
		aBuf  ：バッファ番号
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function changeVolume( aBuf = 0 ){ bgvList[ aBuf ].bgvChangeVolume(); }


	/*------------------------------------------------------------
		内　容：全バッファのBGVの音量変更を行う
		引　数：なし
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function allChangeVolume()
	{
		for( var i = 0; i < bgvList.count; i++ )
		{
			changeVolume( i );
		}
	}


	// セーブロード関連
	/*------------------------------------------------------------
		内　容：セーブの処理
		f     ：
	    elm   ：
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function onStore(f, elm)
	{
		for( var i = 0; i < bgvList.count; i++ )
		{
			with( bgvList[ i ] )
			{
				if( .bgvPlayState ){
					f["bgvc" + i] = .bgvChar;
					f["bgvt" + i] = .bgvType;
					f["bgve" + i] = .bgvEffect;
					f["bgvo" + i] = void;
					if( .bgvType == "オリジナル" )
					{
						for( var j = 0; j < .bgvList["オリジナル"].count; j++ )
						{
							f["bgvo" + i] += .bgvList["オリジナル"][j] + ",";
						}
						if(f["bgvo"+i] !== void && f["bgvo"+i] != ""){
							f["bgvo" + i].substr( 0, f["bgvo" + i].length - 1 );
						}
					}
					f["bgvv" + i] = .bgvVolumeForce;
				}else{
					f["bgvc" + i] = void;
					f["bgvt" + i] = void;
					f["bgve" + i] = false;
					f["bgvo" + i] = void;
					f["bgvv" + i] = false;
				}
			}
		}
	}


	/*------------------------------------------------------------
		内　容：ロードしたときの処理
		f     ：
	    clear ：
	    elm   ：
		戻り値：なし
		備　考：
	------------------------------------------------------------*/
	function onRestore(f, clear, elm)
	{
		for( var i = 0; i < bgvList.count; i++ )
		{
			with( bgvList[ i ] )
			{
				.stop();
				if(f["bgvc" + i] !== void && f["bgvt" + i] !== void && f["bgve" + i] !== void )
				{
					setData( %[buf:i, storage:f["bgvo" + i], name:f["bgvc" + i], type:f["bgvt" + i], effect:f["bgve" + i], vol_force:f["bgvv" + i]] );
					.start();
				}
			}
		}
	}
}


kag.addPlugin(global.bgv_object = new cBgvManager());

@endscript
@endif




;==============================================================================================================
;     マクロ
;==============================================================================================================
[macro name="bgv_set"][bgv_stop buf=&mp.buf][eval exp="global.bgv_object.setData(%[buf:mp.buf, storage:mp.storage, name:mp.name, type:mp.type, effect:mp.effect, vol_force:mp.vol_force, loop:mp.loop])"][endmacro]

;--------------------------------------------------
;// マクロをglobalBgvListから自動で定義
;--------------------------------------------------
@iscript
{
	tf.bgvMacroTemp = [];
	tf.bgvMacroCount = 0;
	var ar = [];
	ar.assign(globalBgvList);
	for(var i=0; i<ar.count; i+=2){
		tf.bgvMacroTemp.add(ar[i]);
	}
}
@endscript

;※macro宣言はこの場で実行で&は展開される。
;※macroの中身に関してはそのまま保存され、実行時に展開される。なのでマクロ名を分解して呼び出すようにしている。(bgv興奮→興奮)
*macro_define_loop

; マクロ定義
[macro name="&'bgv'+tf.bgvMacroTemp[tf.bgvMacroCount]"]
@bgv_set buf=%buf|0 name=%name type="&mp.tagname.substr(3)" effect=%effect|false vol_force=%vol_force|false
[endmacro]

; ループ
@eval exp="tf.bgvMacroCount += 1"
@jump target=*macro_define_loop cond="tf.bgvMacroCount < tf.bgvMacroTemp.count"

; 使用した変数削除
@iscript
delete tf.bgvMacroTemp;
delete tf.bgvMacroCount;
@endscript

;--------------------------------------------------
; 自動マクロ定義ここまで
;--------------------------------------------------

;[macro name="bgv_one_time"][eval exp="mp.buf=0" cond="mp.buf===void"][eval exp="global.bgv_object.oneTimePlay( %[buf:mp.buf, storage:mp.storage, name:mp.name] )"][endmacro]
[macro name="bgv_resume"][eval exp="mp.buf=0" cond="mp.buf===void"][eval exp="global.bgv_object.start( mp.buf )"][endmacro]
[macro name="bgv_pause"][eval exp="mp.buf=0" cond="mp.buf===void"][eval exp="global.bgv_object.pause( mp.buf )"][endmacro]
[macro name="bgv_stop"][eval exp="mp.buf=0" cond="mp.buf===void"][eval exp="global.bgv_object.stop( mp.buf )"][endmacro]

;[macro name="bgv_auto_play"][eval exp="global.bgv_object.start(%[name:f.bgvChr, type:f.bgvType])" cond="f.bgvPlaying && !global.bgv_object.bgvPlaying"][endmacro]
[macro name="bgv_auto_play"][endmacro]
[macro name="bgv_auto_pause"][eval exp="global.bgv_object.autoPause( mp.s!==void ? mp.s : f.speaker )"][endmacro]
[macro name="bgv_all_stop"][eval exp="global.bgv_object.allStop()"][endmacro]

[macro name="fobgv"][eval exp="global.bgv_object.fadeout( %[buf:mp.buf, time:mp.time] )"][endmacro]
[macro name="wbgv"][eval exp="mp.buf=0" cond="mp.buf === void"][waittrig name='bgv_fade_end' canskip=true cond="global.bgv_object.bgvList[+mp.buf].bgv.inFading"][bgv_stop buf=%buf][endmacro]



@return
@if exp=0
;-----------------------
; コピペ用
;-----------------------
;一応【fobgv】はラベルをまたがない【wbgv】もしくは【bgv_all_stop】【bgv_stop】と併用で使用してください
@fobgv time=1000
@wbgv
@bgv_stop
@bgv_all_stop
@bgv_pause
@bgv_resume
@endif



;//	オブジェクトが生成されているか判断して、生成されていなければ以下の処理を行う
;//==================================================================================================
@if exp="typeof(global.moji_flow_object) == 'undefined'"
@iscript


//	グローバル定数
//====================================================================





//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//	内容　　：文字を画面枠両端に立てに流す
//	修正項目：
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
class cMojiFlowPlugin extends KAGPlugin
{

	//	メンバ定数のつもり
	//====================================================================
	var mABSOLUTE_BASE = 1000000;		// messages[0].absolute + 2000;(画面下部のボタンは+2100)　優先順位の設定
	
	var mMOJI_IMAGE_00 = "sp_signal_light";		//	光っている画像名
	var mMOJI_IMAGE_01 = "sp_signal";			//	光っていない画像名

	var mMOJI_W = 67;							//	横一文字サイズ
	var mMOJI_H = 67;							//	縦一文字サイズ

	var mMOJI_LAYER_W = mMOJI_W * 3;			//	レイヤーの横最大サイズ * 行数
	var mMOJI_LAYER_H = kag.scHeight;			//	レイヤーの縦最大サイズ

	var mMOJI_KIND_NUM = 10;					//	文字の種類数

	var mMOVE_ACTION_INTERVAR   = 30;			//	移動処理の実行間隔
	var mCHANGE_ACTION_INTERVAR = 50;			//	文字変換処理の実行間隔

	var mSAVE_POS_MAX = 6;						//	座標保持最大数
	var mMOVE_SPEED = 20;						//	移動スピード
	var mMIN_Y_POS = 0 - mMOJI_H;				//	Y座標の最小値
	var mMAX_Y_POS = mMOJI_LAYER_H + mMOJI_H;	//	Y座標の最大値
	var mMOJI_ALPHA = 50;						//	不透明度

	var mCNT_DOWN_MAX = 2000;					//	文字表示カウントダウン最大値
	var mCNT_DOWN_MIN = 1000;					//	文字表示カウントダウン最小値

	var mMOJI_CNT_MAX = 10;						//	１行に出す最大文字数


	//	メンバ変数
	//====================================================================
	var mWin = void;					//	親ウィンドウ
	var mForeL, mForeR;					//	前面レイヤー
	var mBackL, mBackR;					//	背面レイヤー

	var mMojiImage_00, mMojiImage_01;	//	文字イメージロード用
	var mMojiImage;						//	文字イメージコピー用

	var mMojiNum = 0;					//	文字番号

	var mPosInitFlag  = new Array();	//	文字位置を初期化するかの判断フラグ

	var mMojiCnt  = new Array();		//	文字出現数カウント
	var mCntDown  = new Array();		//	文字出現間隔管理用
	
	var mSaveXPos = new Array();		//	X座標保持用
	var mSaveYPos = new Array();		//	Y座標保持用

	var mTimer		 = void;			//	文字移動タイマー
	var mChangeTimer = void;			//	文字変換タイマー

	var mUseFlag	= false;			//	現在使用しているかの判断フラグ
	var mDeleteFlag = false;			//	削除するかの判断フラグ


	//====================================================================
	//	内　容	：コンストラクタ
	//	引数１	：ウインドウ
	//	引数２	：前面レイヤー
	//	引数３	：背面レイヤー
	//	戻り値	：なし
	//====================================================================
	function cMojiFlowPlugin( aWindow, aFore, aBack ){ super.KAGPlugin(); }



	//====================================================================
	//	内　容	：初期化
	//	引　数	：なし
	//	戻り値	：なし
	//====================================================================
	function Init()
	{
		StopTimer();
		
		if( mTimer == void )
		{
			mUseFlag = true;
			
			//	レイヤー作成
			//-------------------------------------------------------
			mForeL = new Layer( kag, kag.fore.base );
			mBackL = new Layer( kag, kag.back.base );
			
			mForeR = new Layer( kag, kag.fore.base );
			mBackR = new Layer( kag, kag.back.base );


			//	左端のレイヤーサイズ・位置設定
			//-------------------------------------------------------
			mForeL.setImageSize( mMOJI_LAYER_W, mMOJI_LAYER_H );
			mForeL.setSizeToImageSize();
			mForeL.setPos( 0, 0 );

			mBackL.setImageSize( mMOJI_LAYER_W, mMOJI_LAYER_H );
			mBackL.setSizeToImageSize();
			mBackL.setPos( mForeL.left, mForeL.top );

			mForeR.setImageSize( mMOJI_LAYER_W, mMOJI_LAYER_H );
			mForeR.setSizeToImageSize();
			mForeR.setPos( kag.scWidth - mMOJI_LAYER_W, 0 );

			mBackR.setImageSize( mMOJI_LAYER_W, mMOJI_LAYER_H );
			mBackR.setSizeToImageSize();
			mBackR.setPos( mForeR.left, mForeR.top );



			//	当たり判定無しに
			//-------------------------------------------------------
			mForeL.hitType = mForeR.hitType = mBackL.hitType = mBackR.hitType = htMask;
			mForeL.hitThreshold = mForeR.hitThreshold = mBackL.hitThreshold = mBackR.hitThreshold = 256;

			mForeL.type = mForeR.type = omPsHardLight;
			mBackL.type = mBackR.type = omPsHardLight;


			//	レイヤーの順序を正規化
			//-------------------------------------------------------
			mForeL.absolute = mForeR.absolute = mBackL.absolute = mBackR.absolute = mABSOLUTE_BASE;


			//	文字画像の読み込み
			//-------------------------------------------------------
			mMojiImage_00 = new Layer( kag, kag.primaryLayer );
			mMojiImage_00.loadImages( mMOJI_IMAGE_00 );

			mMojiImage_01 = new Layer( kag, kag.primaryLayer );
			mMojiImage_01.loadImages( mMOJI_IMAGE_01 );



			//	配列の初期化
			//-------------------------------------------------------
			for( var i = 0; i < mSAVE_POS_MAX; i++ )
			{
				mMojiCnt[ i ]     = 0;
				mSaveXPos[ i ]    = 0;
				mSaveYPos[ i ]    = mMIN_Y_POS;
				mPosInitFlag[ i ] = false;

				if( i < ( mSAVE_POS_MAX / 2 ) )	mSaveXPos[ i ] = intrandom( 0, ( mForeL.width - mMOJI_W ) );
				else							mSaveXPos[ i ] = intrandom( 0, ( mForeR.width - mMOJI_W ) );

				mCntDown[ i ] = intrandom( mCNT_DOWN_MIN, mCNT_DOWN_MAX );
			}



			//	実行時間間隔設定
			//-------------------------------------------------------
			mTimer = new Timer( MojiFlow,"" );
			mTimer.interval = mMOVE_ACTION_INTERVAR;
			mTimer.enabled = false;


			mChangeTimer = new Timer( ChangeMoji,"" );
			mChangeTimer.interval = mCHANGE_ACTION_INTERVAR;
			mChangeTimer.enabled = false;
		}
	}



	//=====================================================================
	//	内　容	：デストラクタ
	//	引　数	：なし
	//	戻り値	：なし
	//====================================================================
	function finalize()
	{
		StopTimer();
		super.finalize(...);
	}



	//=====================================================================
	//	内　容	：削除
	//	引　数	：なし
	//	戻り値	：なし
	//====================================================================
	function DeleteFlow()
	{
		if( mTimer !== void )
		{
			invalidate mMojiImage_00 if mMojiImage_00 !== void;
			invalidate mMojiImage_01 if mMojiImage_01 !== void;
			mMojiImage_00 = mMojiImage_01 = void;

			invalidate mForeL if mForeL !== void;
			invalidate mForeR if mForeR !== void;
			invalidate mBackL if mBackL !== void;
			invalidate mBackR if mBackR !== void;
			mForeL = mForeR = mBackL = mBackR = void;

			invalidate mTimer if mTimer !== void;
			mTimer = void;
			
			invalidate mChangeTimer if mChangeTimer !== void;
			mChangeTimer = void;
		}
	}



	//=====================================================================
	//	内　容	：文字を移動させる
	//	引　数	：
	//	戻り値	：なし
	//====================================================================
	function MojiFlow( elm )
	{
		//	最大文字数まで繰り返し
		//-------------------------------------------------------
		for( var i = 0; i < mSAVE_POS_MAX; i++ )
		{

			//	座標設定
			//-------------------------------------------------------
			//if( mSaveYPos[ i ] > mMAX_Y_POS )
			if( mPosInitFlag[ i ] )
			{

				if( mMojiCnt[ i ] > 0 )
				{
					mMojiCnt[ i ]--;
				}
				else
				{
				
					mSaveYPos[ i ] = mMIN_Y_POS;
					mMojiCnt[ i ]  = 0;

					if( i < ( mSAVE_POS_MAX / 2 ) )	mSaveXPos[ i ] = intrandom( 0, ( mForeL.width - mMOJI_W ) );
					else							mSaveXPos[ i ] = intrandom( 0, ( mForeR.width - mMOJI_W ) );

					mCntDown[ i ]     = intrandom( mCNT_DOWN_MIN, mCNT_DOWN_MAX );
					mPosInitFlag[ i ] = false;
				}
			}
			//	発生まで待機
			//-------------------------------------------------------
			else if( mCntDown[ i ] > 0 )
			{
				mCntDown[ i ]--;
			}
			//	移動
			//-------------------------------------------------------
			else
			{
				if( mMojiCnt[ i ] <= mMOJI_CNT_MAX )	mMojiCnt[ i ]++;
				if( mSaveYPos[ i ] > mMAX_Y_POS )		mPosInitFlag[ i ] = true;
				mSaveYPos[ i ] += mMOVE_SPEED;
			}
		}
	}


	//=====================================================================
	//	内　容	：描画文字の変更
	//	引　数	：なし
	//	戻り値	：なし
	//====================================================================
	function ChangeMoji()
	{

		//	タイトルに戻ったとき
		//-------------------------------------------------------
		if( kag.conductor.curStorage == "title.ks" )
		{
			StopTimer();
			return;
		}



		//	レイヤー初期化
		//-------------------------------------------------------
		mForeL.fillRect( 0, 0, mForeL.width, mForeL.height, 0x00000000 );
		mForeR.fillRect( 0, 0, mForeR.width, mForeR.height, 0x00000000 );


		//	最大文字数まで繰り返し
		//-------------------------------------------------------
		for( var i = 0; i < mSAVE_POS_MAX; i++ )
		{
			mMojiImage = mMojiImage_00;
			mForeL.opacity = mMOJI_ALPHA;
			mForeR.opacity = mMOJI_ALPHA;


			//	文字描画
			//-------------------------------------------------------
			for( var j = 0; j <= mMojiCnt[ i ]; j++ )
			{
				//	文字の切り替え
				//-------------------------------------------------------
				if( j == 1 )	mMojiImage = mMojiImage_01;

				if( i < mSAVE_POS_MAX / 2 ) mForeL.operateRect( mSaveXPos[ i ], ( mSaveYPos[ i ] - ( mMOJI_W * j ) ), mMojiImage, ( mMOJI_W * intrandom( 0, mMOJI_KIND_NUM - 1 ) ), 0, mMOJI_W, mMOJI_H );
				else						mForeR.operateRect( mSaveXPos[ i ], ( mSaveYPos[ i ] - ( mMOJI_W * j ) ), mMojiImage, ( mMOJI_W * intrandom( 0, mMOJI_KIND_NUM - 1 ) ), 0, mMOJI_W, mMOJI_H );

				mForeL.assignImages( mForeL );
				mForeR.assignImages( mForeR );
			}
		}
	}



	//=====================================================================
	//	内　容	：タイマーを有効化
	//	引　数	：なし
	//	戻り値	：なし
	//====================================================================
	function ReadyTimer()
	{
		Init();
		
		mTimer.enabled		 = true;
		mChangeTimer.enabled = true;
		
		mForeL.visible = mForeR.visible = false;
		mBackL.visible = mBackR.visible = true;
	}



	//=====================================================================
	//	内　容	：タイマーを止める
	//	引　数	：なし
	//	戻り値	：なし
	//====================================================================
	function StopTimer()
	{
		if( mTimer !== void )
		{
			mTimer.enabled		 = false;
			mChangeTimer.enabled = false;
		}

		DeleteFlow();
		mDeleteFlag = false;
		mUseFlag	= false;
	}



	//=====================================================================
	//	内　容	：削除フラグを立てる
	//	引　数	：なし
	//	戻り値	：なし
	//====================================================================
	function onDeleteFlag()
	{
		mDeleteFlag = true;
		if(mBackL !== void)mBackL.visible = mBackR.visible = false;
	}



	//	以下、KAGPlugin のメソッドのオーバーライド
	//=====================================================================
	function onStableStateChanged( stable ){}
	function onCopyLayer( toback ){}



	//=====================================================================
	//	内　容	：メッセージのON・OFF時
	//	引　数	：
	//	戻り値	：なし
	//=====================================================================
	function onMessageHiddenStateChanged( hidden ){}



	//=====================================================================
	//	内　容	：ロード
	//	引数１	：
	//	引数２	：
	//	引数３	：
	//	戻り値	：なし
	//=====================================================================
	function onRestore( f, clear, elm )
	{
		if( f.useFlag )
		{
			ReadyTimer();
			mForeL.visible = mBackL.visible = mUseFlag;
			mForeR.visible = mBackR.visible = mUseFlag;
		}
		else
		{
			StopTimer();
		}
	}



	//=====================================================================
	//	内　容	：セーブ
	//	引数１	：
	//	引数２	：
	//	戻り値	：なし
	//=====================================================================
	function onStore( f, elm )
	{
		f.useFlag = mUseFlag;
	}




	//=====================================================================
	//	内　容	：トランジッション
	//	引　数	：なし
	//	戻り値	：なし
	//=====================================================================
	function onExchangeForeBack()
	{
		if( mTimer !== void )
		{
			var temp;

			temp	= mForeL;
			mForeL	= mBackL;
			mBackL	= temp;

			temp	= mForeR;
			mForeR	= mBackR;
			mBackR	= temp;

			mForeL.visible = mBackL.visible = mUseFlag;
			mForeR.visible = mBackR.visible = mUseFlag;
		}

		if( mDeleteFlag ) StopTimer();
		
	}
	
	function onSaveSystemVariables(){}
}





//	Kagに処理を追加
//=====================================================================
kag.addPlugin(global.moji_flow_object = new cMojiFlowPlugin(kag, kag.fore.base, kag.back.base));





@endscript
@endif





;//*******************************************************************************
;//		文字を縦に流すエフェクトマクロ
;//*******************************************************************************
@macro name="ready_moji_flow"
@eval exp="moji_flow_object.ReadyTimer()"
@endmacro

@macro name="stop_moji_flow"
@eval exp="moji_flow_object.onDeleteFlag()"
@endmacro

@return










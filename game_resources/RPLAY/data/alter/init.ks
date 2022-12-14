@iscript
/*-----------------------------------------------------------------
    このファイルは起動時必ず実行され、システム変数を元に
    各種設定をロード。BGMの音量などなど。
-----------------------------------------------------------------*/

/*-----------------------------------------------------------------
	起動時設定
-----------------------------------------------------------------*/

// 各種基本設定
Scripts.execStorage("game_setting.tjs");

// 値を取り得る変数をを配列で表現
if(sf.sysConfigArray === void)sf.sysConfigArray = [];
// 真偽値で大丈夫な変数をビットで表現(64bitまで)
if(sf.sysConfigBit === void)  sf.sysConfigBit  = 0x0;
if(sf.sysConfigBit2 === void) sf.sysConfigBit2 = 0x0;


//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ビット操作関数
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function sysBitSet(index, tof){  if(tof)sf.sysConfigBit |= 1 << index; else sf.sysConfigBit &= ~(1 << index); }  // 設定
function sysBitGet(index){       return (sf.sysConfigBit & (1 << index)) >> index; }  // 取得
function sysBitInv(index){       sf.sysConfigBit |= (!sysBitGet(index) << index); }   // 反転

function sysBitSet2(index, tof){ if(tof)sf.sysConfigBit2 |= 1 << index; else sf.sysConfigBit2 &= ~(1 << index); }  // 設定
function sysBitGet2(index){      return (sf.sysConfigBit2 & (1 << index)) >> index; }  // 取得
function sysBitInv2(index){      sf.sysConfigBit2 |= (!sysBitGet(index) << index); }   // 反転


//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// システム管理変数群
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
property sysNotYetReadSpeed{   setter(x){ sf.sysConfigArray[0]  = x; } getter{ return sf.sysConfigArray[0]; } }  // テキストの表示速度設定用
property sysAlreadyReadSpeed{  setter(x){ sf.sysConfigArray[1]  = x; } getter{ return sf.sysConfigArray[1]; } }  // 既読文章の表示速度設定用
property sysAutoSpeed{         setter(x){ sf.sysConfigArray[2]  = x; } getter{ return sf.sysConfigArray[2]; } }  // オートモードのページ切り替え待機時間設定用
property sysGlobalVolume{      setter(x){ sf.sysConfigArray[3]  = x; } getter{ return sysGlobalVolumeMute ? 0 : sf.sysConfigArray[3]; } }  // 全体の音量設定用
property sysBgmVolume{         setter(x){ sf.sysConfigArray[4]  = x; } getter{ return sysBgmVolumeMute    ? 0 : sf.sysConfigArray[4]; } }  // ＢＧＭ音量設定用
property sysSeVolume{          setter(x){ sf.sysConfigArray[5]  = x; } getter{ return sysSeVolumeMute     ? 0 : sf.sysConfigArray[5]; } }  // ＳＥ音量設定用
property sysVoiceVolume{       setter(x){ sf.sysConfigArray[6]  = x; } getter{ return sysVoiceVolumeMute  ? 0 : sf.sysConfigArray[6]; } }  // ボイス音量設定用
property sysSystemVolume{      setter(x){ sf.sysConfigArray[7]  = x; } getter{ return sysSystemVolumeMute ? 0 : sf.sysConfigArray[7]; } }  // システム音量設定用
property sysMsgOpacity{        setter(x){ sf.sysConfigArray[8]  = x; } getter{ return sf.sysConfigArray[8]; } }   // メッセージウィンドウの不透明度調整用
property sysCurType{           setter(x){ sf.sysConfigArray[9]  = x; } getter{ return sf.sysConfigArray[9]; } }   // マウスカーソル設定用
property sysBgmDownVolume{     setter(x){ sf.sysConfigArray[10] = x; } getter{ return sf.sysConfigArray[10]; } }  // 音声再生中のＢＧＭ音量設定用
property sysAlreadyReadColor{  setter(x){ sf.sysConfigArray[11] = x; } getter{ return sf.sysConfigArray[11]; } }  // 既読文字色設定用
property sysSystemVoiceChr{    setter(x){ sf.sysConfigArray[12] = x; } getter{ return sf.sysConfigArray[12]; } }  // システムボイスのキャラ設定用
property sysHMsgOpacity{       setter(x){ sf.sysConfigArray[13] = x; } getter{ return sf.sysConfigArray[13]; } }  // Ｈシーン用メッセージウィンドウの不透明度調整用
property sysHMsgDesign{        setter(x){ sf.sysConfigArray[14] = x; } getter{ return sf.sysConfigArray[14]; } }  // Ｈシーンでメッセージウィンドウのデザイン設定用
property sysHVFinish{          setter(x){ sf.sysConfigArray[15] = x; } getter{ return sf.sysConfigArray[15]; } }  // Ｈシーンの膣射精設定 /0:中だし/1:外だし/2:選択
property sysHFFinish{          setter(x){ sf.sysConfigArray[16] = x; } getter{ return sf.sysConfigArray[16]; } }  // Ｈシーンの口射精設定 /0:中だし/1:外だし/2:選択
property sysDesign{            setter(x){ sf.sysConfigArray[17] = x; } getter{ return sf.sysConfigArray[17]; } }  // タイトル背景設定用
property sysBGVVolume{         setter(x){ sf.sysConfigArray[18] = x; } getter{ return sysBGVVolumeMute ? 0 : sf.sysConfigArray[18]; } }  // ＢＧＶ音量設定用
property sysHSound{            setter(x){ sf.sysConfigArray[19] = x; } getter{ return sf.sysConfigArray[19]; } }  // ＨシーンＳＥ再生判断用 /0:OFF /1:ON /2:射精音のみON
property sysSystemVoiceVolume{ setter(x){ sf.sysConfigArray[20] = x; } getter{ return sf.sysConfigArray[20]; } }  // システムボイス音量設定用
property sysSecondAudioVolume{  setter(x){ sf.sysConfigArray[21] = x; } getter{ return sysSecondAudioVolumeMute ? 0 : sf.sysConfigArray[21]; } }  // 裏の声音量設定用

property sysSecondAudioVolume{	setter(x){ sf.sysConfigArray[23] = x; } getter{ return sysSecondAudioVolumeMute ? 0 : sf.sysConfigArray[23]; } }
property sysSecondAudioVolumeR{	setter(x){ sf.sysConfigArray[23] = x; } getter{ return sf.sysConfigArray[23]; } }
property sysMsgDesign{			setter(x){ sf.sysConfigArray[24] = x; } getter{ return sf.sysConfigArray[24]; } }
property sysHSeVolume{			setter(x){ sf.sysConfigArray[25] = x; } getter{ return sysHSeVolumeMute ? 0 : sf.sysConfigArray[25]; } }  // Hシーン専用ＳＥ音量設定用



// コンフィグの初期設定用に準備(config.xls)
property sysGlobalVolumeR{      setter(x){ sf.sysConfigArray[3]  = x; } getter{ return sf.sysConfigArray[3]; } }   // 
property sysBgmVolumeR{         setter(x){ sf.sysConfigArray[4]  = x; } getter{ return sf.sysConfigArray[4]; } }   // 
property sysSeVolumeR{          setter(x){ sf.sysConfigArray[5]  = x; } getter{ return sf.sysConfigArray[5]; } }   // 
property sysHSeVolumeR{         setter(x){ sf.sysConfigArray[25]  = x; } getter{ return sf.sysConfigArray[25]; } }   // 
property sysVoiceVolumeR{       setter(x){ sf.sysConfigArray[6]  = x; } getter{ return sf.sysConfigArray[6]; } }   // 
property sysSystemVolumeR{      setter(x){ sf.sysConfigArray[7]  = x; } getter{ return sf.sysConfigArray[7]; } }   // 
property sysBGVVolumeR{         setter(x){ sf.sysConfigArray[18] = x; } getter{ return sf.sysConfigArray[18]; } }  // 
property sysSecondAudioVolumeR{ setter(x){ sf.sysConfigArray[21] = x; } getter{ return sf.sysConfigArray[21]; } }  // 


//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// システム管理フラグ群
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// 第１陣：こちらには常用するものを追加記述していきましょう（最大：63）
//============================================================================================================================================================================================================================
// メッセージウィンドウ内
property sysAutoHideMsg{        setter(x){ sysBitSet( 0, x); } getter{ return sysBitGet( 0); } }  // ボイス再生時にメッセージウィンドウを消すか     - true：消す     ／false：消さない ／def：false  ※未実装？ 2018/04/19
property sysMsgAutoHide{        setter(x){ sysBitSet( 1, x); } getter{ return sysBitGet( 1); } }  // 立ち絵変更時にメッセージを自動で消す           - true：消す     ／false：消さない ／def：false
property sysMsgSimple{          setter(x){ sysBitSet( 2, x); } getter{ return sysBitGet( 2); } }  // メッセージウィンドウの装飾を取るかどうか       - true：取る     ／false：取らない ／def：false  ※未実装？ 2018/04/19
property sysHSceneWindow{       setter(x){ sysBitSet( 3, x); } getter{ return sysBitGet( 3); } }  // Ｈシーン専用メッセージウィンドウを有効にするか - true：する     ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysChBorder{           setter(x){ sysBitSet( 4, x); } getter{ return sysBitGet( 4); } }  // 文字の縁取りをするか                           - true：する     ／false：しない   ／def：true
property sysChShadow{           setter(x){ sysBitSet( 5, x); } getter{ return sysBitGet( 5); } }  // 文字に影をつけるか                             - true：する     ／false：しない   ／def：false
property sysNotYetReadColor{    setter(x){ sysBitSet( 6, x); } getter{ return sysBitGet( 6); } }  // 既読文章の色を変更するか                       - true：する     ／false：しない   ／def：false
// 表示
property sysDoCgFade{           setter(x){ sysBitSet( 7, x); } getter{ return sysBitGet( 7); } }  // 立ち絵/CG/演出をフェード表示するか             - true：する     ／false：しない   ／def：true
property sysDoEffFade{          setter(x){ sysBitSet( 8, x); } getter{ return sysBitGet( 8); } }  // エフェクトをフェード表示するか                 - true：する     ／false：しない   ／def：true
property sysDoCharFade{         setter(x){ sysBitSet( 9, x); } getter{ return sysBitGet( 9); } }  // 立ち絵をフェード表示するか                     - true：する     ／false：しない   ／def：true
property sysCharCorrect{        setter(x){ sysBitSet(10, x); } getter{ return sysBitGet(10); } }  // キャラクターの色調補正をするか                 - true：する     ／false：しない   ／def：true   ※コンフィグからON/OFF設定項目削除。強制的にON。 2018/04/19
property sysEyeAnimation{       setter(x){ sysBitSet(11, x); } getter{ return sysBitGet(11); } }  // 目パチをするか                                 - true：する     ／false：しない   ／def：true
property sysFaceVisible{        setter(x){ sysBitSet(12, x); } getter{ return sysBitGet(12); } }  // ミニ表情を表示するか                           - true：する     ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysFaceType{           setter(x){ sysBitSet(13, x); } getter{ return sysBitGet(13); } }  // 顔の切り抜き方法                               - true：全て     ／false：切り抜き ／def：true
property sysGameButtonHold{     setter(x){ sysBitSet(14, x); } getter{ return sysBitGet(14); } }  // ゲームボタンを固定するか                       - true：する     ／false：しない   ／def：false
// 情報
property sysSpTipHint{          setter(x){ sysBitSet(15, x); } getter{ return sysBitGet(15); } }  // ヘルプを表示するか                             - true：する     ／false：しない   ／def：true
property sysShowBgmTitle{       setter(x){ sysBitSet(16, x); } getter{ return sysBitGet(16); } }  // ＢＧＭタイトルを表示するか                     - true：する     ／false：しない   ／def：true
property sysDoEmotion{          setter(x){ sysBitSet(17, x); } getter{ return sysBitGet(17); } }  // エモーションを表示するか                       - true：する     ／false：しない   ／def：true（仕様としてない場合は def：false）
// オートスキップ動作
property sysSkipOption{         setter(x){ sysBitSet(18, x); } getter{ return sysBitGet(18); } }  // 文章スキップ設定                               - true：既読のみ ／false：全て     ／def：true
property sysAutoSkip{           setter(x){ sysBitSet(19, x); } getter{ return sysBitGet(19); } }  // 既読文章を自動スキップするか                   - true：する     ／false：しない   ／def：false
property sysDoSkip{             setter(x){ sysBitSet(20, x); } getter{ return sysBitGet(20); } }  // 選択肢後、スキップを継続するか                 - true：継続     ／false：停止     ／def：true
property sysAutoModeClickStop{  setter(x){ sysBitSet(21, x); } getter{ return sysBitGet(21); } }  // オートモードを左クリックで停止するか           - true：する     ／false：しない   ／def：false
property sysDoAuto{             setter(x){ sysBitSet(22, x); } getter{ return sysBitGet(22); } }  // 選択肢後、オートを継続するか                   - true：する     ／false：しない   ／def：true
property sysClickSkip{          setter(x){ sysBitSet(23, x); } getter{ return sysBitGet(23); } }  // クリックでスキップが可能か                     - true：可能     ／false：不可能   ／def：true
// 音
property sysVoiceCancel{        setter(x){ sysBitSet(24, x); } getter{ return sysBitGet(24); } }  // 次の音声まで音声を停止しないか                 - true：しない   ／false：する     ／def：false
property sysMainViewVoPlay{     setter(x){ sysBitSet(25, x); } getter{ return sysBitGet(25); } }  // 主視点のボイス再生をするか判断用               - true：する     ／false：しない   ／def：true   ※未実装？ 2018/04/19
property sysMainHVoPlay{        setter(x){ sysBitSet(26, x); } getter{ return sysBitGet(26); } }  // Ｈシーン時に主人公のボイスを再生するか         - true：する     ／false：しない   ／def：true
property sysSystemVoice{        setter(x){ sysBitSet(27, x); } getter{ return sysBitGet(27); } }  // システムボイスを再生するか                     - true：する     ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysVoiceRandom{        setter(x){ sysBitSet(28, x); } getter{ return sysBitGet(28); } }  // システムボイスのキャラをランダムにするか       - true：する     ／false：しない   ／def：false
property sysBgmTempFade{        setter(x){ sysBitSet(29, x); } getter{ return sysBitGet(29); } }  // ボイス再生中にＢＧＭ音量を下げるか             - true：下げる   ／false：下げない ／def：
// ダイアログ
property sysDialogSave{         setter(x){ sysBitSet(30, x); } getter{ return sysBitGet(30); } }  // セーブ時の確認するか                           - true：する     ／false：しない   ／def：true
property sysDialogLoad{         setter(x){ sysBitSet(31, x); } getter{ return sysBitGet(31); } }  // ロード時の確認するか                           - true：する     ／false：しない   ／def：true
property sysDialogQSave{        setter(x){ sysBitSet(32, x); } getter{ return sysBitGet(32); } }  // クイックセーブの情報を出すか                   - true：する     ／false：しない   ／def：true
property sysDialogQLoad{        setter(x){ sysBitSet(33, x); } getter{ return sysBitGet(33); } }  // クイックロードの確認するか                     - true：する     ／false：しない   ／def：true
property sysDialogOverwrite{    setter(x){ sysBitSet(34, x); } getter{ return sysBitGet(34); } }  // セーブデータの上書きを確認するか               - true：する     ／false：しない   ／def：true
property sysDialogMove{         setter(x){ sysBitSet(35, x); } getter{ return sysBitGet(35); } }  // セーブデータの移動を確認するか                 - true：する     ／false：しない   ／def：true
property sysDialogDelete{       setter(x){ sysBitSet(36, x); } getter{ return sysBitGet(36); } }  // セーブデータの削除を確認するか                 - true：する     ／false：しない   ／def：true
property sysDialogBackTitle{    setter(x){ sysBitSet(37, x); } getter{ return sysBitGet(37); } }  // タイトルに戻る際の確認するか                   - true：する     ／false：しない   ／def：true
property sysDialogReplayReturn{ setter(x){ sysBitSet(38, x); } getter{ return sysBitGet(38); } }  // 回想シーンから戻る際に確認するか               - true：する     ／false：しない   ／def：true
property sysDialogGameExit{     setter(x){ sysBitSet(39, x); } getter{ return sysBitGet(39); } }  // ゲームを終了する際の確認するか                 - true：する     ／false：しない   ／def：true
property sysDialogBackScene{    setter(x){ sysBitSet(40, x); } getter{ return sysBitGet(40); } }  // 一つ前に戻るときの確認をするか                 - true：する     ／false：しない   ／def：false  ※いらないような？2018/04/18
property sysDialogDefault{      setter(x){ sysBitSet(41, x); } getter{ return sysBitGet(41); } }  // 設定の初期化を確認するか                       - true：する     ／false：しない   ／def：true   ※いらないような？2018/04/18
// ミュート設定
property sysGlobalVolumeMute{   setter(x){ sysBitSet(42, x); } getter{ return sysBitGet(42); } }  // 全体の音量をミュートにするか                   - true：する     ／false：しない   ／def：false
property sysBgmVolumeMute{      setter(x){ sysBitSet(43, x); } getter{ return sysBitGet(43); } }  // ＢＧＭ音量をミュートにするか                   - true：する     ／false：しない   ／def：false
property sysSeVolumeMute{       setter(x){ sysBitSet(44, x); } getter{ return sysBitGet(44); } }  // ＳＥ音量をミュートにするか                     - true：する     ／false：しない   ／def：false
property sysVoiceVolumeMute{    setter(x){ sysBitSet(45, x); } getter{ return sysBitGet(45); } }  // ボイス音量をミュートにするか                   - true：する     ／false：しない   ／def：false
property sysSystemVolumeMute{   setter(x){ sysBitSet(46, x); } getter{ return sysBitGet(46); } }  // システム音音量をミュートにするか               - true：する     ／false：しない   ／def：false
property sysBGVVolumeMute{      setter(x){ sysBitSet(47, x); } getter{ return sysBitGet(47); } }  // ＢＧＶ音量をミュートにするか                   - true：する     ／false：しない   ／def：false
property sysHSeVolumeMute{      setter(x){ sysBitSet(48, x); } getter{ return sysBitGet(48); } }  // ＳＥ音量をミュートにするか                     - true：する     ／false：しない   ／def：false



// 第２陣：こちらは常用するか不明・常用しそうにない特殊なものを記述していきましょう（最大：63）
//============================================================================================================================================================================================================================
// メッセージウィンドウ内
property sysEvFrameChange{         setter(x){ sysBitSet2( 0, x); } getter{ return sysBitGet2( 0); } }  // ＥＶＣＧ表示中にメッセージウィンドウを変更するか - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysHChBorder{             setter(x){ sysBitSet2( 1, x); } getter{ return sysBitGet2( 1); } }  // Ｈシーン中のみ文字の縁取りをするか               - true：する   ／false：しない   ／def：false
property sysHCutin{                setter(x){ sysBitSet2( 2, x); } getter{ return sysBitGet2( 2); } }  // Ｈシーン中のカットインを有効にするか             - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysChapterInfo{           setter(x){ sysBitSet2( 3, x); } getter{ return sysBitGet2( 3); } }  // チャプター更新メッセージを出力するか             - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
// 特殊動作
property sysAutoTips{              setter(x){ sysBitSet2( 4, x); } getter{ return sysBitGet2( 4); } }  // 自動用語説明リンクをするか                       - true：する   ／false：しない   ／def：true
property sysWalkingTalk{           setter(x){ sysBitSet2( 5, x); } getter{ return sysBitGet2( 5); } }  // ウォーキングトークのアニメーションをするか       - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysBgAnimation{           setter(x){ sysBitSet2( 6, x); } getter{ return sysBitGet2( 6); } }  // 背景のアニメーションをするか                     - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysLovelyShot{            setter(x){ sysBitSet2( 7, x); } getter{ return sysBitGet2( 7); } }  // ラブリーショットを有効にするか                   - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
// ラブリーコール
property sysLovelyCall{            setter(x){ sysBitSet2( 8, x); } getter{ return sysBitGet2( 8); } }  // ラブリーコールを使用するか                       - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysHLovelyCall{           setter(x){ sysBitSet2( 9, x); } getter{ return sysBitGet2( 9); } }  // Ｈシーン中にラブリーコールを使用するか           - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
// 副音声および副音声用ＥＶＣＧおよび副音声用テキスト
property sysDoSecondAudio{         setter(x){ sysBitSet2(10, x); } getter{ return sysBitGet2(10); } }  // 副音声ボタンを表示するか                         - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysDoSecondAudioAuto{     setter(x){ sysBitSet2(11, x); } getter{ return sysBitGet2(11); } }  // オートモード時に副音声も再生する                 - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysSecondAudioVolumeMute{ setter(x){ sysBitSet2(12, x); } getter{ return sysBitGet2(12); } }  // 副音声の音量をミュートにするか                   - true：する   ／false：しない   ／def：false
property sysRealIntention{         setter(x){ sysBitSet2(13, x); } getter{ return sysBitGet2(13); } }  // 副音声ボイスを再生するか                         - true：する   ／false：しない   ／def：false
property sysRealIntentionCG{       setter(x){ sysBitSet2(14, x); } getter{ return sysBitGet2(14); } }  // 副音声用のＥＶＣＧを表示するか                   - true：する   ／false：しない   ／def：false
property sysRealIntentionText{     setter(x){ sysBitSet2(15, x); } getter{ return sysBitGet2(15); } }  // 副音声用のテキストを表示するか                   - true：する   ／false：しない   ／def：false
// グロ表現
property sysGoreCG{                setter(x){ sysBitSet2(16, x); } getter{ return sysBitGet2(16); } }  // グロ描写ＣＧを表示するか                         - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
// 射精カウンター
property sysDoSyaseiCounter{       setter(x){ sysBitSet2(17, x); } getter{ return sysBitGet2(17); } }  // 射精カウンターを表示するか                       - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysSyaseiCounterPos{      setter(x){ sysBitSet2(18, x); } getter{ return sysBitGet2(18); } }  // 射精カウンターの位置(２択しかない)               - true：1:右   ／false：0:左     ／def：true
// e-mote用
property sysEmoteAnim{             setter(x){ sysBitSet2(19, x); } getter{ return sysBitGet2(19); } }  // エモートのアニメーションを有効にするか           - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysDoBreathEmote{         setter(x){ sysBitSet2(20, x); } getter{ return sysBitGet2(20); } }  // エモートの口パクを有効にするか                   - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysUseD3DEmote{           setter(x){ sysBitSet2(21, x); } getter{ return sysBitGet2(21); } }  // エモートの処理にＧＰＵの支援を受けるか           - true：受ける ／false：受けない ／def：true（仕様としてない場合は def：false）
// 確認ダイアログ追加分
property sysDialogCalendar{        setter(x){ sysBitSet2(22, x); } getter{ return sysBitGet2(22); } }  // カレンダーの指定日に戻る際に確認をするか         - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysDialogMap{             setter(x){ sysBitSet2(23, x); } getter{ return sysBitGet2(23); } }  // マップ選択決定時に確認をするか                   - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
property sysDialogScreenshot{      setter(x){ sysBitSet2(24, x); } getter{ return sysBitGet2(24); } }  // スクショ保存時に確認をするか                     - true：する   ／false：しない   ／def：true（仕様としてない場合は def：false）
// スクリーンショットの保存先フラグ
property sysScreenshotSaveType{    setter(x){ sysBitSet2(25, x); } getter{ return sysBitGet2(25); } }	// true：デスクトップ	／false：「sf.screenshotSavePath」、void/空白の場合はデスクトップ
// Live2DON/OFF
property sysLive2D{                setter(x){ sysBitSet2(26, x); } getter{ return sysBitGet2(26); } }
// 非アクティブの動作
property sysDeactive{              setter(x){ sysBitSet2(27, x); } getter{ return sysBitGet2(27); } }	// true：動作	／false：停止


try{
	kag.getDoAutoSkip = function(){ return sysAutoSkip; }incontextof kag;
}catch(e){
	Debug.message("自動スキップ機能の有効化に失敗");
}


//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function loadDefaultValue()
{
	// ミュート設定
	sysGlobalVolumeMute      = 0;
	sysBgmVolumeMute         = 0;
	sysSeVolumeMute          = 0;
	sysHSeVolumeMute         = 0;
	sysVoiceVolumeMute       = 0;
	sysSystemVolumeMute      = 0;
	sysBGVVolumeMute         = 0;
	sysSecondAudioVolumeMute = 0;
	// システムボイスのキャラごとのミュート設定がある場合の動作「function_define.tjs」にて自動宣言される
	if(sf.sysVoiceEnabled !== void){
		try{
				var  sysVoiceNameList = getDicKey(global.sysCharacterVoiceList);
				for(var i=0; i<sysVoiceNameList.count; i++){
					if(sf["sysVoiceEnabled"+sysVoiceNameList[i]] !== void)sf["sysVoiceEnabled"+sysVoiceNameList[i]] = 1;
				}
		}catch(e){
			dm("システムボイスの個別ON/OFFの初期化に失敗しました");
		}
	}

	sysSystemVoice = true;

	// 常用は謎の変数設定
	sysWalkingTalk       = false;
	sysBgAnimation       = false;
	sysLovelyCall        = false;
	sysHChBorder         = false;
	sysHCutin            = false;
	sysHLovelyCall       = false;

	sysHSound            = 1;	// ＨシーンＳＥ再生判断用 /0:OFF /1:ON /2:射精音のみON
	sysHMsgOpacity       = 102;
	sysHMsgDesign        = 0;   // Hシーンのメッセージデザイン/0:通常/1:専用/2:無し
	sysHVFinish          = 2;   // Hシーンの膣射精設定/0:中だし/1:外だし/2:選択
	sysHFFinish          = 2;   // Hシーンの口射精設定/0:中だし/1:外だし/2:選択
	sysLovelyShot        = 0;   // ラブリーショットON/OFF
	sysDesign            = 0;   // デザインはデフォルト
	sysBGVVolume         = 80;
	sysSecondAudioVolume = 90;
	sysDoSecondAudio     = false;
	sysDoSecondAudioAuto = false;
	sysEmoteAnim         = 1;
	sysDoBreathEmote     = 1;
	sysUseD3DEmote       = 1;
	sysRealIntention     = false;
	sysRealIntentionCG   = false;
	sysRealIntentionText = false;
	sysGoreCG            = false;

	// LC周りの設定
//	sf.苗字 = getDefSurname();
//	sf.名前 = getDefName();
//	// 理歩関係
//	sf.理歩呼び名 = "理歩";
//	sf.理歩男性器呼称 = 1;
//	sf.理歩女性器呼称 = 1;
//	sf.理歩ルート男性器呼び名 = "股間";
//	sf.理歩ルート女性器呼び名 = "マンコ";

	// 文章周りの設定
	sysSkipOption       = true;  // 1：既読のみスキップ・0：全てスキップ
	sysNotYetReadSpeed  = 30;    // 未読文章の速度
	sysAlreadyReadSpeed = 30;    // 既読文章の速度
	sysAutoSpeed        = 1500;  // オートモードの速度

	// 音周りの設定
	sysGlobalVolume      = 100000;  // 大域音量
	sysBgmVolume         = 20;      // BGM音量
	sysSeVolume          = 70;      // SE音量
	sysHSeVolume         = 60;      // HSE音量
	sysVoiceVolume       = 80;      // VOICE音量
	sysSystemVolume      = 60;      // システム音音量
	sysBgmDownVolume     = 60;      // Voice再生中のBGMダウン音量
	sysSystemVoiceVolume = 80;      // システムボイス音量

	// 他設定
	sysMsgOpacity           = 190;    // メッセージフレームの不透明度
	sysMsgDesign			= 0;	  // メッセージフレームのデザイン
	sysDoSkip               = true;   // 選択肢後、スキップを継続するか？
	sysDoAuto               = true;   // 選択肢後、オートを継続するか？
	sysVoiceCancel          = true;   // 改ページにボイスを停止するか？
	sysFaceType             = true;   // 顔の切り抜き方法「true：全て・fase：切り抜き」
	sysShowBgmTitle         = false;  // BGMタイトルを表示するかどうか
	sysClickSkip            = true;   // クリックでスキップが可能かどうか
	sysGameButtonHold       = false;  // オプションホールド設定「true：ホールド・false：ハイド」
	sysCharCorrect          = true;   // キャラクター色調補正
	sysEvFrameChange        = false;  // EVCGでフレーム変更するかどうか

	// 確認ダイアログ
	sysDialogSave         = true;   // セーブ時の確認
	sysDialogLoad         = true;   // ロード時の確認
	sysDialogQSave        = true;   // クイックセーブの情報を出すか
	sysDialogQLoad        = true;   // クイックロードの確認
	sysDialogOverwrite    = true;   // セーブデータの上書きの確認
	sysDialogMove         = true;   // セーブデータの移動の確認
	sysDialogDelete       = true;   // セーブデータの削除の確認
	sysDialogDefault      = true;   // 設定の初期化の確認
	sysDialogBackTitle    = true;   // タイトルに戻る際の確認
	sysDialogGameExit     = true;   // ゲームを終了する際の確認
	sysDialogReplayReturn = true;   // シーン回想から戻る際の確認
	sysDialogBackScene    = false;  // 一つ前に戻る際の確認
	sysDialogCalendar     = false;   // カレンダージャンプの確認
	sysDialogMap          = false;   // Map決定の確認
	sysDialogScreenshot   = true;

	// スクリーンショットの保存場所
	sysScreenshotSaveType = true;
	// Live2D
	sysLive2D             = true;
	// 非アクティブ時の動作
	sysDeactive           = true;

	sysDoCharFade = true;   // 立ち絵のフェードをするか
	sysDoCgFade   = true;   // CGのフェードをするか
//	sysDoEmotion  = false;  // エモーションを出すか※※非常用
	sysSpTipHint  = true;   // 画像でのチップヒントを出すか※※非常用
	sysCurType    = 0;      // マウスカーソルのタイプ※※非常用

	sysChBorder    = false;  // 文字の縁取り
	sysChShadow    = true;   // 文字の影
	sysAutoSkip    = false;  // 既読文章を自動スキップ
	sysMsgAutoHide = false;  // 立ち絵変更時にメッセージを自動消去
	sysMsgSimple   = false;  // メッセージウィンドウの装飾を取るかどうか
	sysAutoTips    = true;   // 自動用語説明リンクを行うか

	sysBgmTempFade = false;  // ボイス再生時にBGMボリュームを下げる機能

	// 未実装
	sysAutoHideMsg    = false;  // ボイス再生時にメッセージウィンドウを消す機能
	sysMainViewVoPlay = true;	// 主視点のボイス再生をするか判断用


	sysFaceVisible  = false; // ミニ表情の表示・非表示
	sysDoEffFade    = true;  // エフェクト表示のon/off
	sysMainHVoPlay  = false; // Ｈシーン時に主人公のボイスを再生するか
	sysChapterInfo  = true;  // チャプター更新メッセージを出力する
	sysEyeAnimation = true;  // 目パチデフォルトON

	sysHSceneWindow      = true;   // Hシーン専用メッセージウィンドウON
	sysNotYetReadColor   = true;  // 既読文字色の変更OFF
	sysAutoModeClickStop = false;   // オートモードの左クリック動作「true：停止 false：継続」

	sysSystemVoiceChr = "";  // システムボイスのキャラ設定

	sysDoSyaseiCounter  = true;	// 射精カウンター
	sysSyaseiCounterPos = 1;	// 射精カウンター位置：右


	// 初期フォントの設定
	kag.chDefaultFace = sf.systemFont = "学参丸ゴ";
	setMessageLayerBold();
	kag.setMessageLayerUserFont();
	// 初期フォントのチェック状態を再現
	if(typeof kag.resetIncludeFontsMenuCheck != "undefined"){
		for(var i=0; i<includeFontList.count; i++){
			if(kag.chDefaultFace == includeFontList[i][0]){
				kag.resetIncludeFontsMenuCheck(i);
			}
		}
	}

	// 既読文字色
	sysAlreadyReadColor = 0xcccccc;

	// ボイスの再生速度はいるか？？
	// メッセージウィンドウをシンプルなものにかえる機能

	f.lastPlayVoice       = "";  // 最後のボイスファイル
	f.lastPlaySecondAudio = "";  // 副音声ボイスファイル

	// 個別のボイスボリュームおよび個別フォントカラー
	for(var i=0; i<characterList.count; i++){
		sf["vol"+characterList[i]] = 0.9;
		sf["bgv"+characterList[i]] = 1.0;		// bgv個別音量
		sf["sys"+characterList[i]] = 0.9;		// システムボイス個別音量
		sf["fcp"+characterList[i]] = 0xffffff;
		sf["vom"+characterList[i]] = false;		// ボイスのミュート設定
		sf["bgm"+characterList[i]] = false;		// bgvのミュート設定
		sf["sym"+characterList[i]] = false;		// システムボイスのミュート設定
	}
	sf["fcp主人公"] = 0xffffff;

	// キーコンフィグ：glShortcutKeyOrder は「main_setting.tjs」に記述
	if(sf.optionKey === void)	sf.optionKey = [];
	else						sf.optionKey.clear();

	for( var i=0, j=0; i < glShortcutKeyOrder.count; i++ )
	{
		if( glShortcutKeyOrder[i][2] ) sf.optionKey[j++] = glShortcutKeyOrder[i][1];
	}

	// オートセーブ番号
	sf.autoSaveNum = glAutoSaveNum+glAutoSaveCount+1;

	// ゲームのボタンは下がデフォ 0:左 1:下 2:右
	sf.gameButtonPos = 2;
	try	{
		gameButton_object.menuPosSet();
	}catch(e){
		dm("ゲームボタン位置変更に失敗しました。\n"+e.message);
	}

	// マップでワンクリックの決定を行うフラグ
	sf.mapOneclickDicision = true;

	sf.cursorMoveType = 0;	// マウスカーソルの自動移動設定（0：自動移動なし／1：一瞬で移動）
	sf.autoContinue   = 0;	// タイトル画面をスキップして開始するか（0：タイトルスキップ無し／1：タイトルスキップ有り）

	// はるとゆき、衣装変更パッチ
	sf.changeHDress = false;
	sf.replaceTargetID = 0; 			// 誰
	sf.replaceDressID  = [0,0,0,0,0,0]; // どれ
	sf.replaceDressTargetArray   = ['a','a','a','a','a','a'];

	sf.DefaultBold = false;
}


//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// cation
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function getDefSurname()	{ return "和久須";						}
function getDefName()		{ return "響";							}
function getDefNickname()	{ return "ひーくん/ひぃ先輩/ひーくん";	}


//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
function setSystemSettings()
{
	// 文章の速度を設定（既読/未読合同版）
	kag.userChSpeed = kag.userCh2ndSpeed = (sysNotYetReadSpeed == 60 ? 0 : (70 - sysNotYetReadSpeed));

/*
	// 未読文章の速度を設定
	kag.userChSpeed = (sysNotYetReadSpeed == 60 ? 0 : (70 - sysNotYetReadSpeed));

	// 既読文章の速度を設定
	kag.userCh2ndSpeed = (sysAlreadyReadSpeed == 60 ? 0 : (70 - sysAlreadyReadSpeed));
*/

	// 文章の速度を反映
	kag.setUserSpeed();

	// クリックスキップの設定
	/*if(sf.ShowMode==true)kag.clickSkipEnabled = false;
	else */kag.clickSkipEnabled = true;

	// オートモードの速度を設定
	kag.autoModePageWait = sysAutoSpeed;
	kag.autoModeLineWait = (int)(kag.autoModePageWait/3);

	// 全体音量を設定
	WaveSoundBuffer.globalVolume = sysGlobalVolume;

	// BGMの音量を設定
	kag.bgm.setOptions(%[volume:100,gvolume:sysBgmVolume]);

	// SEの音量を設定
	{
		var v = (sysSeVolume == 20 ? 0 : sysSeVolume);
		for(var i = 0; i < kag.numSEBuffers-2 ; i++)
			kag.se[i].setOptions(%[volume:100,gvolume:v]);
	}

	// VOICEの音量を設定
	kag.se[kag.numSEBuffers-2].setOptions(%[volume:100,gvolume:sysVoiceVolume]);

	// 太字の設定を正しく：「afterinit2.tjs」で定義
	setMessageLayerBold();

	// レイヤーのみのクエイク用変数初期化
	f.layer_quake = [];
	f.layer_quake[0] = false;

	// ミニ表情とカメラ位置とオリジナルな座標の記憶リセット
	f.faceRecord = %[
	];

	f.cameraAngle = [0, 0];
	f.orgPos = [];
	for(var i=0; i<6; i++)f.orgPos[i] = [0,0,'a',0,0];

	// フォント色を設定
	setFontColor();

	// カーソルの再設定
/*	if(sysCurType){
		kag.setCursor(%["default"=>"cursor.ani", "pointed"=>"cursor.ani", "click"=>"cursor.ani", "draggable"=>"cursor.ani"]);
	}else{
		kag.setCursor(%["default"=>crArrow, "pointed"=>crHandPoint, "click"=>crArrow, "draggable"=>crSizeAll]);
	}
*/
}


//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 初期化実行
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
if(sf.first_time===void){
	sf.first_time = true;		// 初回起動フラグ
	sf.opmovie    = false;		// OPムービーを見たかのフラグ
	sf.gameButtonPos = 1;		// ゲームのボタンは下がデフォ 0:左 1:下 2:右

	// ボイスの表示配列
	sf.voiceVisible = [];
	loadDefaultValue();

	// cation
	//sf.一人称           = "僕";
	//sf.血液型           = "A";
	//sf.月               = 1;
	//sf.日               = 1;
	//sf.苗字             = getDefSurname();
	//sf.名前             = getDefName();
	//sf.呼び名           = getDefNickname();
	//sf.呼び名ファイル   = "h05:han";
	//sf.nameSelectedId   = 5;
	//sf.nameSelectedNick = 4;

	sf.autoSaveNum = glAutoSaveNum;	// オートセーブ番号
}

setSystemSettings();
@endscript
@return
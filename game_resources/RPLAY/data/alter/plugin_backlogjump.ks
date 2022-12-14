
@if exp="typeof(global.backLogJumpObject) == 'undefined'"
@iscript

// バックログジャンププラグイン

//--------------------------------------------------------------------------------------------------------------
// ■storeJump(storage, label)：ジャンプのログ記録
//		直接は使わない、process関数に仕込まれていてジャンプの記録を取っている。
//		[ファイル, ラベル, ファイル, ラベル, 画面が真っ黒か]を一セットとしてジャンプ元、ジャンプ先、復帰可能ポイントかを記録。
// [
//		[(void),		(void),		"000_00.ks",	(void),					1],
//		["000_00.ks",	"*p171",	"000_00.ks",	"*branch_auto_skip2",	0]
// ]
//--------------------------------------------------------------------------------------------------------------
// ■createFileLog(storage = void)：対象のファイルの情報を取得
//		辞書配列にstr,label,macroのメンバがそれぞれ配列になっていてラベル毎の文字、ラベル名、マクロが得られる。
//		3つのメンバの配列の数は同じ。なのでラベルで検索を掛けて得られたインデックスをほかの配列で参照してよい。
// %[
//		"str"=>[
//			"",
//			"懐かしい香りが鼻孔をくすぐった。"
//			"心地よいまぶしさに目を細めながら、久しぶりの大地の感触を味わう。\n少し、地面が揺れている。"
//		],
//		"label"=>[
//			"*p0"
//			"*p1",
//			"*p2"
//		],
//		"macro"=>[
//			["@bg storage=bg_00a","[se storage=\"が_動_カモメ\" buf=7]","@show"]
//			["[fose buf=7 time=1000]","@hide","@white",～～～～～,"@show"],
//			[]
//		]
// ];
//--------------------------------------------------------------------------------------------------------------
// ■backJump(storage, label)：指定されたファイル、ラベルにジャンプする
//		・仕組みのメモ
//		１．createFileLog()で現在実行中のシナリオ情報を取得、現在ラベルから現在地を割り出す。
//		２．storeJump()が記録したデータ(gLogData配列)を後ろから監視しながらシナリオをさかのぼる。
//			ジャンプ着地点に到達したらcreateFileLog()でジャンプ前のファイルを取得するを繰り返しながら
//			そこまでに通るはずのマクロを貯めていく。(np,nm等文字関連は全部無視)
//		３．戻るべき目的地にたどり着いたらそこからさらに遡り、(gLogData配列)の[4]が復元可能ポイントに到達するまで戻る。
//		４．復元可能ポイントまで到達したら、そこまでにためたマクロの前にスキップ開始、画面クリア、終了直前にスキップ停止、目的地のジャンプを追記して
//			process関数に@付きで渡す。(ファイルへのジャンプではなく文字列をシナリオとして実行する機能を利用)
//--------------------------------------------------------------------------------------------------------------
// ■getLog(storage, label)：指定されたファイル、ラベルまでのログを取得する
//		・仕組みのメモ
//		基本的にはbackJumpとやってることは同じで、取得するのがマクロではなく[文章、シナリオ名、ラベル名]になっている。
//--------------------------------------------------------------------------------------------------------------
// 他メモ
//	・backjumpをするときに呼び出すprocess関数にはstoreJumpがそれすらも記録してしまわないようフラグを準備
//	・getLog()ではそのラベルで実行すべきボイスは取得できないので、履歴のほうでは[シナリオ, ラベル, tjs]のような参照するべきボイス再生ログの生成が必要。ちゃんとしてればLCでも問題ないはず
//	・backJumpは目的地ラベルのマクロは取得しない(目的地ラベルから再開されるので再開直後に目的地のマクロが実行される)

// todo
//	・backJumpで過去マクロを実行する際、bgm音量se音量ボイス音量を一時的にオフにしなければならない
//	・セーブ/ロードのジャンプも記録されてしまうだろうからそこにもstoreJumpよけコードが必要？ どっちにしろgLogDataのロードが必要だから大丈夫？タイミング次第。ただstoreJumpでsaveload.ksを避けるだけでもいいかも
//	・gLogDataをファイルに保存、ロード時に復帰する機能が必要。
//	・gLogDataをタイトルに戻った際にクリア、ゲーム開始前でもいいかもしれない
//	・履歴を開く際にgLogDataがちゃんとなくてもエラー出ないように対処、getLog側がメインかも
//	・履歴の全体量を把握(スクロールバーのため)にラベルのカウンターが必要かも？　でもそもそも全ログを表示するにはスクロールバーが短すぎる、新たなUIが必要かも
//	・まずジャンプの記録をするにあたってexlinkが邪魔、選択肢上で戻られた場合大丈夫か？　大丈夫じゃない気がするそもそもなんでexlinkに飛んでるんだろ、マクロ化及び「@sを@waittrig」化で対処できないだろうか？
//	・現在は履歴を2000行取得するにとどめてる
//	・履歴取得の際永久ループよけをきちんと考えないとフリーズしそう
//	・現状だとexlinkが実行するexp属性は無視されるはず。そこでフラグの上げ下げしてたら無理だなぁ、特別に実行するようにするか？
//	・LCの置換はあるキャラのルートで別のキャラからのLCが発生した場合はうまくいかないかもしれない

// global.backLogJumpObject.gLogData
// global.backLogJumpObject.getLog()

//■特殊出力
function getglog(fname = "gLogData"){
	var _log = backLogJumpObject.gLogData;
	var dbgglog = [];
	for(var i=0; i<_log.count; i++){
		//dbgglog.add(_log[i][0] + "\t" + _log[i][1] + "\t" + _log[i][2] + "\t" + _log[i][3] + "\t" + (_log[i][4] !== void ? "■" : "□"));
		dbgglog.add(_log[i][0] + "\t" + _log[i][1] + "\t" + _log[i][2] + "\t" + _log[i][3] + "\t" + (_log[i][4] !== void ? _log[i][4].readList[-1] : "□"));
	}
	dbgglog.save(System.exePath + "gLogData.csv");
}

class BackLogJumpPlugin extends KAGPlugin
{

	var gLogData = [];
	var exLinkFile = "";
	var exLinkLabel = "";
	var noJumpLog = false;
	var coverLayer;
	var isBacking;

	function BackLogJumpPlugin(){
		super.KAGPlugin(...);
	}

	function finalize(){
		invalidate coverLayer if coverLayer !== void;
		super.finalize(...);
	}

	// ジャンプのログを残す
	function storeJump(storage, label){
		var curFile = kag.conductor.curStorage;
		var curLabel = kag.conductor.curLabel;
		var nextFile = (storage === void || storage == "") ? curFile : storage;
		var nextLabel = label;
		var result = [];
		var isSnrCur = /data\/scenario/.test(Storages.getPlacedPath(curFile));
		var isSnrNext = /data\/scenario/.test(Storages.getPlacedPath(nextFile));
		if(!isSnrCur)isSnrCur = /data.xp3>scenario/.test(Storages.getPlacedPath(curFile));
		if(!isSnrNext)isSnrNext = /data.xp3>scenario/.test(Storages.getPlacedPath(nextFile));
		if(!isSnrCur && !isSnrNext)return;		// 現在ファイルも次のファイルもシナリオでなければ無視
		if(isSnrCur){
			result.add(curFile);
			result.add(curLabel);
		}else if(curFile == "exlink.ks"){	// ためてあるはずなので取得
			result.add(exLinkFile);
			result.add(exLinkLabel);
		}else{
			result.add(void);		// この値がある場合はシナリオの開始地点と思われる
			result.add(void);
		}
		if(isSnrNext){
			result.add(nextFile);
			result.add(nextLabel);
		}else if(nextFile == "exlink.ks"){	// 一時貯め
			exLinkFile = curFile;
			exLinkLabel = curLabel;
			return;
		}else return;

		// ファイルが変わる時
		if(result[0] != result[2]){
			// 再開可能ポイントかチェック
			var target = kag.fore.layers[0].Anim_loadParams;
			var visibleCheck = true;
			var effCheck = true;
			// 表レイヤ０以外全部非表示か
			for(var i=1; i<kag.fore.layers.count; i++){
				if(kag.fore.layers[i].visible)visibleCheck = false;
			}
			// effは全停止状態か
			for(var i=0; i<global.effect_object.count; i++){
				if(global.effect_object[i].alive)effCheck = false;
			}
			// チェック
			if(
				target !==void &&
				(target.storage == "black" || target.storage == "white") &&
				visibleCheck &&
				effCheck
			){
				var idx = result.add(%[]);
				(Dictionary.assignStruct incontextof result[idx])(kag.flags);
				// bgmも覚えてみる
				result[idx]["backJumpBgmStore"] = kag.bgm.playingStorage;
				if(result[idx].backPageData !== void)result[idx].backPageData.clear();
			}else{
				result.add(void);
				//result.add("セーブデータ");
			}
		}else result.add(void);
		var _i = gLogData.add([]);
		gLogData[_i].assignStruct(result);
	}

	// 収集しないマクロ
	var ignoreMacroList = [
		"@mmsg",
		"@jump",
		"@exlink",
		"@showexlink"
	];

	function isIgnoreMacro(str){
		if(str === void && str == "")return false;
		for(var i=0; i<ignoreMacroList.count; i++){
			var tar = ignoreMacroList[i];
			if(str.substr(0,tar.length) == tar)return true;
		}
	}

	//指定ファイルのラベルごとのテキスト生成、チェインログ、chタグ、lcなどは考慮せず
	function createFileLog(storage, getMacro = true){
		if(storage === void)storage = kag.conductor.curStorage;
		var ar = [];
		var result = %[];
		result.label = [];
		result.str = [];
		result.macro = [];
		ar.load(storage);
		var str = "";
		var label = "";
		var macros = [];
		var regReline = new RegExp("\\[r\\]", "gi");			// 正規表現は逐次生成してると遅かったのでまとめて作成
		var regLovelycall = new RegExp("\\[ＬＣ\\]", "gi");
		var regMacro = new RegExp("(\\[[^\\]]+\\])", "gi");
		var regInmacro = new RegExp("\\[[^\\]]+\\]", "gi");
		var regTab = new RegExp("^( |\\t)+", "gi");
		var regLabel = new RegExp("\\|.*", "gi");
		var regName = new RegExp(" t=\"*([^\" ]+)", "gi");
		var regRuby = /\[([^\']+)'([^\]]+)\]/;
		/*
		)		// サクラエディタインデントずれ対策
		*/
		var syaseiCounter = -1;
		var iscriptMode = false;
		var mmsgFlag = false;

		for(var i=0; i<ar.count; i++){
			// 検索位置の初期化
			regReline.start = 0;
			regLovelycall.start = 0;
			regInmacro.start = 0;
			regTab.start = 0;
			regLabel.start = 0;
			regName.start = 0;
			regRuby.start = 0;
			var line = ar[i];
			
			if(iscriptMode && getMacro && line.substr(0,10) != "@endscript"){
				macros.add(line);
				continue;
			}
			
			if(line != "" && line.charAt(0) != ";"){		// コメント行は読まないように
				line = regTab.replace(line, "");	// 先頭の空行、タブを削除
				if(line.indexOf("[r]")!=-1)line = regReline.replace(line, "\n");	// 改行を置換
				if(line.indexOf("[ＬＣ]")!=-1){
					try{
						line = regLovelycall.replace(line, getNickName());
					}catch(e){}	// LCを置換
				}
				// ルビ置換
				var safeCount = 0;
				while(line.indexOf("'")!=-1 && (regRuby.exec(line)).count >= 3){
					regRuby.start = 0;
					line = regRuby.replace(line, regRuby.matches[1] + "(" + regRuby.matches[2] + ")");
					safeCount++;
					if(safeCount>100)break;
				}

				if(getMacro){
					regMacro.start = 0;
					while(1){
						var macroMatch = regMacro.exec(line);		// 行中マクロ取得
						if(macroMatch.count != 0){
							var macroStr = macroMatch[0];
							if(macroStr == "[np]"){
								macros.add("@delay_script_skip");
							}else{
								macros.add(macroStr);
							}
						}else break;
					}
				}
				line = regInmacro.replace(line, "");	// 行中マクロ削除
				var head = line.charAt(0);
				if(head == "*" || line == "@s"){
					/*if(str != "" || macros.count != 0)*/{		// 該当ラベルに何もなかろうが記録しないとラベルが連続してるところが捉えられなくなる
						result.label.add(label);
						result.str.add(str);
						var mi = result.macro.add([]);
						result.macro[mi].assign(macros);
						if(syaseiCounter > -1 && label !== void && label != "" && /\*p[0-9]*/gi.test(label)){	// 射精カウンターが見つかった場合該当ラベルから10ラベル分インクリメントコードを追記
							if(syaseiCounter > 0)result.macro[mi].add("@syaseicounter_inc");
							if(++syaseiCounter > 11)syaseiCounter = -1;
						}
						macros.clear();
						str = "";
					}
					label = regLabel.replace(line, "");	// |以降を消しながら記録
					continue;
				}else if(head == "@"){
					if(line.substr(0,6) == "@nm_名前"){
						str += (sf.名前 + "\n");
					}else if(line.substr(0,3) == "@nm"){
						str += ((regName.match(line))[1] + "\n");
					}else if(line.substr(0,11) == "@overlap_ch"){	// 同時発言対応
						var reg = /"([^"]+)"/gi;
						var ar = reg.exec(line);
						str += (ar[1]+"\n");
						for(var i=0; i<10; i++){
							var ar = reg.exec(line);
							if(ar.count == 0)break;
							str += (ar[1]+"\n");
						}
					}else if(line.substr(0,8) == "@iscript"){
						if(getMacro)macros.add(line);
						iscriptMode = true;
					}else if(line.substr(0,10) == "@endscript"){
						if(getMacro)macros.add(line);
						iscriptMode = false;
					}else if(getMacro && line != "" && !isIgnoreMacro(line)/* && line != "@s"*/){		// @sを無視はやばそう、そのさきまで実行しちゃう？
						macros.add(line);		// 一行マクロ取得
						if(line == "@syaseicounter")syaseiCounter = 0;	// 射精カウンターが見つかった
					}else if(!getMacro && line.substr(0,5) == "@mmsg"){
						mmsgFlag = true;		// 特殊同時発言対応、次のメッセージは改行付きで取得
					}
				}else if(head != ";"){
					if(!iscriptMode){
						if(mmsgFlag){
							str += (line+"\n");
							mmsgFlag = false;
						}else str += line;
					}
				}
			}
		}
		/*if(str != "" || macros.count != 0)*/{		// 該当ラベルに何もなかろうが記録しないとシナリオ、マクロがないラベルが捉えられなくなる
			result.label.add(label);
			result.str.add(str);
			var mi = result.macro.add([]);
			result.macro[mi].assign(macros);
			if(syaseiCounter > -1 && label !== void && label != "" && /\*p[0-9]*/gi.test(label)){	// 射精カウンターが見つかった場合該当ラベルから10ラベル分インクリメントコードを追記
				if(syaseiCounter > 0)result.macro[mi].add("@syaseicounter_inc");
				if(++syaseiCounter > 11)syaseiCounter = -1;
			}
			macros.clear();
		}
		// ■デバッグ出力
		//(Dictionary.saveStruct incontextof result)(System.exePath + "log.txt");
		// ■特殊な出力
		if(0){
			var dbgar = [];
			for(var i=0; i<result.str.count; i++){
				for(var j=0; j<result.macro[i].count; j++){
					if(j == 0)dbgar.add(result.label[i] + "\t" + result.str[i].replace(/\n/gi, "") + "\t" + result.macro[i][j].replace(/\t/gi, ""));
					else dbgar.add("\t\t" + result.macro[i][j].replace(/\t/gi, ""));
				}
			}
			dbgar.save(System.exePath + "log.csv");
		}

		return result;
	}

	function showCover(){
		if(coverLayer === void)coverLayer = new KAGLayer(kag, kag.primaryLayer);
		with(coverLayer){
			.setImageSize(kag.primaryLayer.width, kag.primaryLayer.height);
			.setSizeToImageSize();
			.setPos(0, 0);
			.type = ltAlpha;
			.fillRect(0,0,.width,.height,0xff000000);
			.visible = true;
		}
	}
	function hideCover(){
		if(coverLayer === void)return;
		coverLayer.visible = false;
		invalidate coverLayer;
		coverLayer = void;
	}

	// 履歴から呼ぶジャンプ
	function logBackJump(storage, label){
		if(isBacking || noJumpLog)return;		// 戻ってる途中の再実行は許さない
		showCover();
		kag.historyLayer.hide();
		try{kag.historyLayer.bg.fadeFinish();}catch(e){}
		isBacking = true;
		backJump(storage, label);
	}

	// ひとつ前に戻る
	function backOne_(){
		if(isBacking || noJumpLog)return;		// 戻ってる途中の再実行は許さない
		var curStorage = kag.mainConductor.curStorage;
		var curLabel = kag.mainConductor.curLabel;
		// 最初の最初だと戻れないように
		if(gLogData.count == 1 && (curLabel == "*p1" || curLabel == "*p0")){
			try{
				global.info_object.start(void, "g_nobackpage");
				return;
			}catch(e){ dm("ひとつ前に戻れませんでした：" + (e === void ? "原因不明" : e.message)); }
			return;
		}
		showCover();
		isBacking = true;
		backJump(curStorage, curLabel, true);
	}

	// ひとつ前に戻る、バックログのデータからに変更ver
	function backOne(){
		if(isBacking || noJumpLog)return;		// 戻ってる途中の再実行は許さない
		var history = getLog();
		if(history.count <= 1){
			try{
				global.info_object.start(void, "g_nobackpage");
			}catch(e){ dm("ひとつ前に戻れませんでした：" + (e === void ? "原因不明" : e.message)); }
			return;
		}
		showCover();
		isBacking = true;
		var storage = history[history.count-2][1];
		var label = history[history.count-2][2];
		backJump(storage, label);
	}

	// ジャンプ用
	function backJump(storage, label, backonemode = false){
		if(gLogData === void || gLogData.count == 0){
			System.inform("ログデータが存在しません。");
			hideCover();
			isBacking = false;
			noJumpLog = false;
			return;
		}
		var delayFind = false;			// ひとつ前に戻るモード、見つかる位置を一つずらす
		var curFile = kag.mainConductor.curStorage;
		var curLabel = kag.mainConductor.curLabel;
		var list = createFileLog(curFile);
		var index = list.label.find(curLabel);
		if(index == -1){
			System.inform("ログデータから現在位置が特定できませんでした。\n少し文章を進めてみてください。");
			return;
		}

		var logCount = gLogData.count-1;
		var findedLogCount = -1;
		var logEnd = false;
		var jumpScripts = "";
		var jumpScriptsAr = [];
		var beforeScript = "";

		var data = gLogData[logCount];
		var sStorage = data[2];
		var sLabel = data[3];
		var find = false;
		if(index == -1){
			System.inform("ログの遡り中にラベルを見失いました。\n少し文章を進めてみてください。");
			return;
		}

		for(var j = index; j>=0; j--){
			var lbl = list.label[j];
			if(delayFind && list.str[j] != ""){
				label = lbl;
				delayFind = false;
				//find=true;
			}
			if(find){
				for(var i=list.macro[j].count-1; i>=0; i--){
					var curScript = list.macro[j][i];
					if(curScript != beforeScript)jumpScriptsAr.unshift(curScript);		// 同じスクリプトは追加しない
					beforeScript = curScript;
				}
				// jumpScriptsAr.unshift(lbl);		// ラベルを追記するととても重い
			}
			if(storage == curFile && label == lbl){
				if(backonemode){
					backonemode = false;
					delayFind = true;
				}else{
					find = true;	// 目的の位置が見つかった
					if(findedLogCount == -1)findedLogCount = logCount;
				}
			}

			if(sStorage == curFile && (sLabel == lbl || (sLabel == void && j == 0)) ){	// ジャンプ先に到達
				//si(sStorage + "/" + sLabel);
				if(find && data[4] != void){
					// 開始可能なポイントを発見
					(Dictionary.assignStruct incontextof kag.flags)(data[4]);
					tf.backJumpBgm = kag.flags.backJumpBgmStore;
					break;
				}
				// 前の位置に移動
				curLabel = data[1];
				if(curFile != data[0]){		// ファイルが別なら読み直し
					curFile = data[0];
					if(curFile === void){		// 最初のファイル
						logEnd = true;
						break;
					}
					list = createFileLog(curFile);
				}
				index = list.label.find(curLabel);
				--logCount;

				if(delayFind){
					storage = curFile;
					//label = curLabel;
					if(findedLogCount == -1)findedLogCount = logCount;
				}
				// ※ここで見つかったラベルのスクリプトは追加しない。なぜならそこのラベルから開始されるから
				if(logCount < 0){
					logEnd = true;
					break;
				}
				data = gLogData[logCount];
				sStorage = data[2];
				sLabel = data[3];
				j = index + 1;
			}
		}

		// 遡り確定、読み切ったジャンプログを消す
		if(findedLogCount >= 0){
			for(var i=gLogData.count-1; i>findedLogCount; i--)gLogData.erase(i);
		}

		//■デバッグ出力
		//gLogData.saveStruct(System.exePath + "gLogData.txt");
		//getglog();

		// 実行するべきスクリプトを減らす処理
		// @bg/@ev/@black/@white処理がある場合、その場所まで@bg/@ev/@black/@white/@chr/@echr/@dchr/@chr_******/@dchr_******/@delay_script_skipを実行しない(eff/evalなどはそのままに)
		// eff_all_deleteを発見したら、それ以前のeff/ceff/dceff/effectも全部無視していい
		// @wait/@add_lctime/@hide/@showコマンドは実行の必要なし、ただしhide/showは最後の一つだけどちらも実行する。
		var comment = false;
		var effComment = false;
		for(var i=jumpScriptsAr.count-1; i>=0; i--){
			var line = jumpScriptsAr[i];
			if(!comment && (line.indexOf("@bg ")!=-1 || line.indexOf("@ev ")!=-1 || line.indexOf("@black")!=-1 || line.indexOf("@white")!=-1)){
				comment = true;
				jumpScriptsAr[i] = "@delay_script_skip\n" + jumpScriptsAr[i];		// 念のために画面を消す前にディレイスクリプトを止める
			}else if(
						(comment && 
							(line.indexOf("@bg ")!=-1 ||
							line.indexOf("@ev ")!=-1 ||
							line.indexOf("@black")!=-1 ||
							line.indexOf("@white")!=-1 ||
							line.indexOf("@chr ")!=-1 ||
							line.indexOf("@echr ")!=-1 ||
							line.indexOf("@dchr ")!=-1  ||
							line.indexOf("@chr_")!=-1 ||
							line.indexOf("@dchr_")!=-1 ||
							line.indexOf("@delay_script_skip")!=-1
							)
						) ||
						(effComment &&
							(line.indexOf("@eff ")!=-1 ||
							line.indexOf("@ceff ")!=-1 ||
							line.indexOf("@ceff_stock ")!=-1 ||
							line.indexOf("@effect_")!=-1 ||
							line.indexOf("@dceff ")!=-1
							)
						) ||
						(line.indexOf("@wait ")!=-1 ||
						line.indexOf("@add_lctime ")!=-1 ||
						line.indexOf("@show")!=-1 ||
						line.indexOf("@hide")!=-1
						)
				){
				jumpScriptsAr[i] = ";" + jumpScriptsAr[i];
				//jumpScriptsAr.erase(i);
			}else if(line.indexOf("@eff_all_delete") != -1){
				effComment = true;
			}
		}
		// 最後の@show,@hideだけ実行できるように
		var lastShow = false;
		var lastHide = false;
		for(var i=jumpScriptsAr.count-1; i>=0; i--){
			var line = jumpScriptsAr[i];
			if(!lastShow && (line == ";@show" || line == ";@sshow")){
				lastShow = true;
				jumpScriptsAr[i] = "@sshow";
			}else if(!lastHide && (line == ";@hide" || line == ";@shide")){
				lastHide = true;
				jumpScriptsAr[i] = "@shide";
			}
			if(lastShow && lastHide)break;
		}

		// 各種画面/音のクリアコードを付与
		jumpScripts = 	"@sbgm\n" +
						"@svo\n" +
						"@sq\n" +
						//"@lc_stop\n" +
						"@delay_script_skip\n" +
						"@eval exp='frameCheckNpMacro()'\n" +
						((tf.backJumpBgm != "" && tf.backJumpBgm != void) ? ("@bgm storage='&tf.backJumpBgm'\n") : "")+
						"@bgv_all_stop\n" +
						"@eval exp='global.counterObj.disable()'\n" +
						"@eval exp='WaveSoundBuffer.globalVolume = 0'\n" +
						//"@wait time=50 canskip=false\n" +
						"@eval exp='kag.skipToStop()'\n" +
						"@eval exp='exlink_object.endLink()'\n"+
						((kag.mainConductor.macros.ev_movie_stop !== void) ? "@ev_movie_stop\n" : "")+
						"@env_stop\n" +
						"@cm\n" +
						"@clearlayers\n" +
						"@clearmessages\n" +
						"@eff_all_delete_now\n" +
						"@black\n" +
						"@setframe cond='!f.isHScene'\n" +
						"@setframe_h cond='f.isHScene'\n" +
						jumpScriptsAr.join("\n") + 
						"\n";
		// 全部終わった後に音量を戻してスキップ停止
		jumpScripts += ("@sq\n");
		jumpScripts += ("@cm\n");
		jumpScripts += ("@eval exp='WaveSoundBuffer.globalVolume = sysGlobalVolume'\n");
		jumpScripts += ("@eval exp='kag.cancelSkip()'\n");
		jumpScripts += ("@eval exp='backLogJumpObject.hideCover();'\n");
		jumpScripts += ("@eval exp='backLogJumpObject.noJumpLog = true'\n");
		jumpScripts += ("@eval exp='backLogJumpObject.isBacking = false'\n");
		jumpScripts += ("@eval exp='kag.skipToPage()'\n");
		jumpScripts += ("@eval exp='reHookShortcut()'\n");
		jumpScripts += ("@jump storage=\"" + storage + "\" target=\"" + label + "\"");
		if(0){
			// ■デバッグ出力
			var ar = jumpScripts.split("\n");
			ar.save(System.exePath + "jp.txt");
		}
		backLogJumpObject.noJumpLog = true;
		kag.process("@" + jumpScripts);
	}

	// 履歴取得用
	function getLog(){
		if(gLogData === void || gLogData.count == 0){
			System.inform("ログデータが存在しません。");
			return void;
		}
		var storage = kag.conductor.curStorage;
		var label = kag.conductor.curLabel;
		var curFile = kag.conductor.curStorage;
		var curLabel = kag.conductor.curLabel;
		var list = createFileLog(curFile, false);
		var index = list.label.find(curLabel);
		if(index == -1){
			System.inform("現在位置からログが生成できませんでした。\n少し文章を進めてみてください。");
			return void;
		}

		var logCount = gLogData.count-1;
		var logEnd = false;
		var result = [];

		var data = gLogData[logCount];
		var sStorage = data[2];
		var sLabel = data[3];
		var find = false;
		if(index == -1){
			System.inform("ログの遡り中にラベルを見失いました。\n少し文章を進めてみてください。");
			return void;
		}
		for(var j=index; j>=0; j--){
			var lbl = list.label[j];

			if(list.str[j] != "")result.unshift([list.str[j], curFile, lbl]);
			if(result.count > 2000)break;

			if(sStorage == curFile && (sLabel == lbl || (sLabel == void && j == 0)) ){	// ジャンプ先に到達
				// 前の位置に移動
				curLabel = data[1];
				if(curFile != data[0]){		// ファイルが別なら読み直し
					curFile = data[0];
					if(curFile === void){		// 最初のファイル
						logEnd = true;
						break;
					}
					list = createFileLog(curFile, false);
				}
				index = list.label.find(curLabel);
				if(--logCount < 0){
					logEnd = true;
					break;
				}
				data = gLogData[logCount];
				sStorage = data[2];
				sLabel = data[3];
				j = index + 1;
			}
		}

		return result;
	}

	function clear(){
		gLogData.clear();
		exLinkFile = "";
		exLinkLabel = "";
	}

	function onFileSave(no){
		var fn = kag.saveDataLocation + "/" + kag.dataName + no + ".blj";
		gLogData.saveStruct(fn, /*,"z"*/);
	}
	function onFileLoad(no){
		clear();
		// システム変数の読み込み
		try
		{
			var fn = kag.saveDataLocation + "/" + kag.dataName + no + ".blj";
			if(Storages.isExistentStorage(fn)){
				gLogData = Scripts.evalStorage(fn);
			}else{
				gLogData = [];
			}
		}
		catch(e)
		{
			Systems.inform("バックログジャンプのデータ読み込みに失敗しました(\n" + e.message + ")");
			gLogData = [];
		}
	}

	// システムフラグの保存と復帰なのでこのプラグインでは使えない？
	function onStore(f, elm){}
	function onRestore(f, clear, elm){}

}


kag.addPlugin(global.backLogJumpObject = new BackLogJumpPlugin());

// プロセスに差し込み
kag.org_process = kag.process;
kag.process = function(storage, label, countpage = true, immediate = false){
	if(!backLogJumpObject.noJumpLog)backLogJumpObject.storeJump(storage, label);
	backLogJumpObject.noJumpLog = false;
	return kag.org_process(...);
}incontextof kag;
kag.org_onConductorJump = kag.onConductorJump;
kag.onConductorJump = function(elm){
	if(!backLogJumpObject.noJumpLog)backLogJumpObject.storeJump(elm.storage, elm.target);
	backLogJumpObject.noJumpLog = false;
	return kag.org_onConductorJump(...);
}incontextof kag;


// セーブロードに差し込み
kag.backJump_saveBookMark = kag.saveBookMark;
kag.saveBookMark = function(num){
	global.backLogJumpObject.onFileSave(num);
	return backJump_saveBookMark(...);
}incontextof kag;
kag.backJump_loadBookMark = kag.loadBookMark;
kag.loadBookMark = function(num){
	var re = backJump_loadBookMark(...);
	global.backLogJumpObject.onFileLoad(num);
	return re;
}incontextof kag;

// コンティニューセーブロードへの差し込み
global.backJump_saveBookMarkToFileNoThumbs = global.saveBookMarkToFileNoThumbs;
global.saveBookMarkToFileNoThumbs = function(savehist = true, force=false){
	global.backLogJumpObject.onFileSave("_continue");
	return backJump_saveBookMarkToFileNoThumbs(...);
};
global.backJump_loadBookMarkFromFileNoThumbs = global.loadBookMarkFromFileNoThumbs;
global.loadBookMarkFromFileNoThumbs = function(loaduser = true){
	var re = backJump_loadBookMarkFromFileNoThumbs(...);
	global.backLogJumpObject.onFileLoad("_continue");
	return re;
};


// 仮：ゲーム開始時のクリアに混ぜたい
backPageArray.backJump_clear = backPageArray.clear;
backPageArray.clear = function(){
	global.backLogJumpObject.clear();
	return backJump_clear();
}incontextof backPageArray;

// 射精カウンターインクリメント関数(syaseicounter)
function syaseiCounterIncrement(){
	try{
		global.counterObj.countDown();
	}catch(e){}
}

// キー/マウスショートカットの再登録(evモード以外)
function reHookShortcut(){
	if(kag.rightClickHook.find(gameRClickFunc) == -1 && !tf.isEvMode){
		kag.rightClickHook.clear();
		kag.keyDownHook.clear();
		kag.rightClickHook.add(gameRClickFunc);
		kag.keyDownHook.add(gameKeyFunc);
	}
}


@endscript

@macro name="syaseicounter_inc"
@eval exp="syaseiCounterIncrement()"
@endmacro

@endif

@return

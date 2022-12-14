
;// 履歴の出力を許可
@history output=true enabled=true

@iscript
/*
	「はじめから」を選んだときに初期化されるフラグや、
	その他初期化項目を記述
*/


// 履歴をクリア
clear_history();


// キー及び右クリックの設定
kag.rightClickHook.clear();
kag.keyDownHook.clear();

kag.rightClickHook.add(gameRClickFunc);
kag.keyDownHook.add(gameKeyFunc);

f.isHScene = 0;
sf.storyProgress = f.storyProgress = 0; // ゲーム進行度


// 前に戻る用変数の初期化
backPageArray.clear();
backPageNoSave = false;


// 攻略中ルート初期化
f.攻略対象 = "";


// 好感度初期化



// ゲーム内フラグ初期化
f.okayuReadFlag = 0;			// ビット単位で管理されるHシーンファイル既読リスト、フローチャートのオープン条件に使用
f.readCount = 0;				// 既読カウンタ、通常シーンの差し込み用にカウントアップされる
if(f.readList === void){		// フローチャートからのジャンプ済み一覧、ここに乗っていないものが追加されるときに「f.readCount」がカウントアップされる
	f.readList = [];
}else f.readList.clear();
f.readList.add("100_聖良初体験_00非童貞ver.ks");
f.readList.add("100_聖良初体験_00童貞ver.ks");
f.readList.add("200_莉瑠初体験_00非童貞ver.ks");
f.readList.add("200_莉瑠初体験_00童貞ver.ks");
f.readList.add("301_3p聖女聖女_00_h.ks");
f.readList.add("301_3pバニーメイド_00_h.ks");
f.readList.add("301_3pサキュ魔女_00_h.ks");
f.readList.add("301_3p巫女騎士_00_h.ks");
f.readList.add("105_聖良デート_00.ks");
f.readList.add("205_莉瑠デート_00.ks");
f.readList.add("106_聖良エピローグ_00.ks");
f.readList.add("206_莉瑠エピローグ_00.ks");
f.seiraFirstSnr = void;		// 最初に選ばれた初Hシーン、以降これに固定する
f.riruFirstSnr = void;		// 最初に選ばれた初Hシーン、以降これに固定する
tf.flowCurPage = 0;			// フローチャートの初期ページ(3Pのままになってしまうの避け)

;//【雪亜ルート】

;//【灰ルート】

// 【姫芽ルート】

;//【有珠ルート】

;//【コロナルート】


@endscript

@return
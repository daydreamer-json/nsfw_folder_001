;///////////////////////////////////////////////////////////////////////////////
; クエスト定義ファイル
;
; ※このシナリオは限定されたタグしか使えません（通常のシナリオで使えるタグはNG）
;
;
;-------------------------------------------------------------------------------
; 全体設定
;
; 立ち絵キャラ移動量[px]
@option chmove=50
;
; シナリオ開始時にバックログに残すテキスト(comment=があれば"："で繋げて表示）
@option scnselected="プレイ開始"
;
; タイトル画面からの表示の場合は f.* ではなく sf.* を参照する(オナニー履歴に影響：今までのプレイの累積で表示)
@option staticflag=&'page.indexOf("title")>=0'
;
; オナニー履歴（定義ファイル）            ↓テキスト表示について，UI内包の画像を使用する場合はfalse
@option subtext="ona_history.ks" drawtext=true hidetext=false
;                                                       ↑回数0のキャラの履歴ごと表示しない場合はtrue
;
; ページ分岐用マクロ（page=xyz で現在のページだった場合は *xyz へジャンプする）
[macro name="page_branch"][jump target='&@"*${mp.page}"' cond='&@"page==${$34}${mp.page}${$34}"'][endmacro]
@page_branch page="title"
;
;-------------------------------------------------------------------------------
; メインキャラ攻略状況条件
;
@pmacro name="攻略状況：莉音"			comment="莉音"		point="sca01h:sca02h:sca03h:sca04h:sca05h:sca06h"
@pmacro name="攻略状況：恋乃香"			comment="恋乃香"	point="scb01h:scb02h:scb03h:scb04h:scb05h"
@pmacro name="攻略状況：晶"			comment="晶"		point="scc01h:scc02h:scc03h:scc04h:scc05h"
@pmacro name="攻略状況：奈々子"			comment="奈々子"	point="scd01h:scd02h:scd03h:scd04h:scd05h:scd06h"
@pmacro name="攻略状況：摩耶"			comment="摩耶"		point="sce01h:sce02h:sce03h:sce04h:sce05h"
@pmacro name="攻略状況：ひなた"			comment="ひなた"	point="scf01h:scf02h:scf03h:scf04h:scf05h"
@pmacro name="攻略状況：楓"			comment="楓"		point="scg01h:scg02h:scg03h:scg04h:scg05h"
@pmacro name="攻略状況：優華理"			comment="優華理"	point="sch01h:sch02h:sch03h:sch04h:sch05h"
@pmacro name="攻略状況：リリア"			comment="リリア"	point="sci01h:sci02h:sci03h:sci04h:sci05h"
@pmacro name="攻略状況：リーシャ"		comment="リーシャ"	point="scj01h:scj02h:scj03h:scj04h:scj05h"
;
;-------------------------------------------------------------------------------
; エンド条件
;
@pmacro name="エンド条件：ハーレム"		eval="sca03h && scb03h && scc03h && scd03h && sce03h && scf03h && scg03h && sch03h && sci03h && scj03h"
@pmacro name="エンド条件：母親ハーレム"		eval="sca20h && scb20h && scc20h && scd20h && sce20h && scf20h && scg20h && sch20h && sci20h && scj20h"
@pmacro name="エンド条件：莉音"    		eval="sca06h"
;
;-------------------------------------------------------------------------------
; サブキャラ枠オープン条件
;
@pmacro name="サブキャラ：絵美里"		comment="絵美里"	eval="st03"	point="sck01h"
@pmacro name="サブキャラ：めぐみ"		comment="めぐみ"	eval="st02"	point="scl01h"
@pmacro name="サブキャラ：薫"			comment="薫"		eval="st01"	point="scm01h"
@pmacro name="サブキャラ：玲奈"			comment="玲奈"		eval="st07"	point="scn01h"
@pmacro name="サブキャラ：舞"			comment="舞"		eval="st06"	point="sco01h"
@pmacro name="サブキャラ：祈子"			comment="祈子"		eval="st04"	point="scp01h"
@pmacro name="サブキャラ：かなめ"		comment="かなめ"	eval="st05"	point="scq01h"
@pmacro name="サブキャラ：道子"			comment="道子"		eval="st09"	point="scr01h"
@pmacro name="サブキャラ：珠子"			comment="珠子"		eval="st08"	point="scs01h"
@pmacro name="サブキャラ：遙香"			comment="遙香"		eval="sch01h"	point="sct01h"
;
;-------------------------------------------------------------------------------
; 親子丼枠オープン条件
;
@pmacro name="親子丼：莉音"			eval="sca03h"
@pmacro name="親子丼：恋乃香"			eval="scb04h"
@pmacro name="親子丼：晶"			eval="scc02h"
@pmacro name="親子丼：奈々子"			eval="scd04h"
@pmacro name="親子丼：摩耶"			eval="sce02h"
@pmacro name="親子丼：ひなた"			eval="scf03h"
@pmacro name="親子丼：楓"			eval="scg04h"
@pmacro name="親子丼：優華理"			eval="sch04h"
@pmacro name="親子丼：リリア"			eval="sci04h"
@pmacro name="親子丼：リーシャ"			eval="scj04h"
;
;-------------------------------------------------------------------------------
; ブートキャンプ枠オープン条件
;
@pmacro name="ブートキャンプ：莉音"		eval="sca01h"
@pmacro name="ブートキャンプ：恋乃香"		eval="scb03h"
@pmacro name="ブートキャンプ：晶"		eval="scc04h"
@pmacro name="ブートキャンプ：奈々子"		eval="scd03h"
@pmacro name="ブートキャンプ：摩耶"		eval="sce02h"
@pmacro name="ブートキャンプ：ひなた"		eval="scf01h"
@pmacro name="ブートキャンプ：楓"		eval="scg02h"
@pmacro name="ブートキャンプ：優華理"		eval="sch03h"
@pmacro name="ブートキャンプ：リリア"		eval="sci02h"
@pmacro name="ブートキャンプ：リーシャ"		eval="scj03h"
;
;-------------------------------------------------------------------------------
; 多人数枠オープン条件
;
@pmacro name="多人数：人妻おっぱいバレー"	eval="sca20h && scb20h && scc20h && scj20h"
@pmacro name="多人数：母乳露天風呂"		eval="scx08h"
@pmacro name="多人数：パイズリ看病"		eval="scb03h && scd03h && scf03h"
@pmacro name="多人数：牝猫カフェ"		eval="scx01h"
@pmacro name="多人数：中出し花火大会"		eval="scx02h"
@pmacro name="多人数：強制バニーガール"		eval="scx03h"
@pmacro name="多人数：おっぱい人妻例の参観日"	eval="sca20h && scd20h && sce20h && scf20h && scg20h && sch20h"
;
;-------------------------------------------------------------------------------
; main2選択
; 攻略状況の一覧からボタンを順番に開いていくためのマクロ
[macro name="screen_main2"]
@screen page=%page storage='&"quest_"+mp.page' rclick=main
@main   page=%page name=wave0 pointtag=%page pointnew=%point pointindex=0	storage=gameloop.txt target='&mp.target+"_1"'
@main   page=%page name=wave1 pointtag=%page pointnew=%point pointindex=1	storage=gameloop.txt target='&mp.target+"_2"'
@main   page=%page name=wave2 pointtag=%page pointnew=%point pointindex=2	storage=gameloop.txt target='&mp.target+"_3"'
@main   page=%page name=wave3 pointtag=%page pointnew=%point pointindex=3	storage=gameloop.txt target='&mp.target+"_4"'
@main   page=%page name=wave4 pointtag=%page pointnew=%point pointindex=4	storage=gameloop.txt target='&mp.target+"_5"'
@main   page=%page name=wave5 pointtag=%page pointnew=%point pointindex=5	storage=gameloop.txt target='&mp.target+"_6"'
@main   page=%page name=wave6 pointtag=%page pointnew=%point pointindex=6	storage=gameloop.txt target='&mp.target+"_7"' cond="&GetQuestPointCount(mp.point)>5"
@button page=%page name=back to=main
@exit
[endmacro]
;
;-------------------------------------------------------------------------------
;※インフォーメーション表示が不要なページはこの段階で分岐
;
; お出かけ選択（シナリオ途中での呼び出し）
@page_branch page="odekake"
;
; 各種ステータス画面
@page_branch page="status"
@page_branch page="status_sub"
@page_branch page="status_sub_title"
@page_branch page="status_main_title"
;
; インフォーメーションは選択画面を開いた初回のみで十分なのでページ遷移時はスキップ
@jump target=*page cond=reload
;-------------------------------------------------------------------------------
; インフォーメーション表示条件一覧
;
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=k	flag=sub_k	サブキャラ：絵美里
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=l	flag=sub_l	サブキャラ：めぐみ
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=m	flag=sub_m	サブキャラ：薫
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=n	flag=sub_n	サブキャラ：玲奈
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=o	flag=sub_o	サブキャラ：舞
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=p	flag=sub_p	サブキャラ：祈子
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=q	flag=sub_q	サブキャラ：かなめ
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=r	flag=sub_r	サブキャラ：道子
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=s	flag=sub_s	サブキャラ：珠子
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=t	flag=sub_t	サブキャラ：遙香
;
@info tag=i_x01 text="『メイド牝猫カフェアプリ！』が多人数エロページに追加！"				flag=mul_1	多人数：牝猫カフェ
@info tag=i_x02 text="『セーラー水着中出し花火大会アプリ！』が多人数エロページに追加！"			flag=mul_2	多人数：中出し花火大会
@info tag=i_x03 text="『強制バニーガールアプリ！』が多人数エロページに追加！"				flag=mul_3	多人数：強制バニーガール
@info tag=i_x04 text="『トリプルパイズリナースアプリ！』が多人数エロページに追加！"			flag=mul_4	多人数：パイズリ看病
@info tag=i_x05 text="『人妻おっぱいバレーハーレム！』が多人数エロページに追加！"			flag=mul_5	多人数：人妻おっぱいバレー
@info tag=i_x06 text="『おっぱい人妻例のプール参観日アプリ！』が多人数エロページに追加！"		flag=mul_6	多人数：おっぱい人妻例の参観日
@info tag=i_x07 text="『強制混浴！母乳露天風呂！』が多人数エロページに追加！"				flag=mul_7	多人数：母乳露天風呂
;
@info tag=i_a01 text="孕ませハーレムエンド条件（莉音）を満たしました！"					eval="sca03h"
@info tag=i_b01 text="孕ませハーレムエンド条件（恋乃香）を満たしました！"				eval="scb03h"
@info tag=i_c01 text="孕ませハーレムエンド条件（晶）を満たしました！"					eval="scc03h"
@info tag=i_d01 text="孕ませハーレムエンド条件（奈々子）を満たしました！"				eval="scd03h"
@info tag=i_e01 text="孕ませハーレムエンド条件（摩耶）を満たしました！"					eval="sce03h"
@info tag=i_f01 text="孕ませハーレムエンド条件（ひなた）を満たしました！"				eval="scf03h"
@info tag=i_g01 text="孕ませハーレムエンド条件（楓）を満たしました！"					eval="scg03h"
@info tag=i_h01 text="孕ませハーレムエンド条件（優華理）を満たしました！"				eval="sch03h"
@info tag=i_i01 text="孕ませハーレムエンド条件（リリア）を満たしました！"				eval="sci03h"
@info tag=i_j01 text="孕ませハーレムエンド条件（リーシャ）を満たしました！"				eval="scj03h"
;													↑※「エンド条件：ハーレム」の個々のシナリオ通過フラグであることに注意
;
@info tag=i_a02 text="莉音の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_a	親子丼：莉音
@info tag=i_b02 text="恋乃香の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_b	親子丼：恋乃香
@info tag=i_c02 text="晶の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_c	親子丼：晶
@info tag=i_d02 text="奈々子の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_d	親子丼：奈々子
@info tag=i_e02 text="摩耶の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_e	親子丼：摩耶
@info tag=i_f02 text="ひなたの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_f	親子丼：ひなた
@info tag=i_g02 text="楓の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_g	親子丼：楓
@info tag=i_h02 text="優華理の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_h	親子丼：優華理
@info tag=i_i02 text="リリアの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_i	親子丼：リリア
@info tag=i_j02 text="リーシャの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_j	親子丼：リーシャ
;
@info tag=i_a03	text="おっぱい発育ブートキャンプページに莉音シナリオが追加されました！"			ブートキャンプ：莉音		flag=camp_a
@info tag=i_b03	text="おっぱい発育ブートキャンプページに恋乃香シナリオが追加されました！"		ブートキャンプ：恋乃香		flag=camp_b
@info tag=i_c03	text="おっぱい発育ブートキャンプページに晶シナリオが追加されました！"			ブートキャンプ：晶		flag=camp_c
@info tag=i_d03	text="おっぱい発育ブートキャンプページに奈々子シナリオが追加されました！"		ブートキャンプ：奈々子		flag=camp_d
@info tag=i_e03	text="おっぱい発育ブートキャンプページに摩耶シナリオが追加されました！"			ブートキャンプ：摩耶		flag=camp_e
@info tag=i_f03	text="おっぱい発育ブートキャンプページにひなたシナリオが追加されました！"		ブートキャンプ：ひなた		flag=camp_f
@info tag=i_g03	text="おっぱい発育ブートキャンプページに楓シナリオが追加されました！"			ブートキャンプ：楓		flag=camp_g
@info tag=i_h03	text="おっぱい発育ブートキャンプページに優華理シナリオが追加されました！"		ブートキャンプ：優華理		flag=camp_h
@info tag=i_i03	text="おっぱい発育ブートキャンプページにリリアシナリオが追加されました！"		ブートキャンプ：リリア		flag=camp_i
@info tag=i_j03	text="おっぱい発育ブートキャンプページにリーシャシナリオが追加されました！"		ブートキャンプ：リーシャ	flag=camp_j
;
; オナニー回数のみの更新で更新通知が必要な場合は下記をコメントアウト
@pmacro name=onakeep text=""
;
; キャラ別オナニー履歴							回数のみ？	進捗度		条件
@info tag=i_a04 text="莉音のオナニー履歴を更新しました！"				subtag=_1	eval="sca01h"	withsflag	flag=ona_a1
@info tag=i_a04 text="莉音のオナニー履歴を更新しました！"		onakeep		subtag=_2	eval="sca02h"	withsflag	flag=ona_a2
@info tag=i_a04 text="莉音のオナニー履歴を更新しました！"				subtag=_3	eval="sca03h"	withsflag	flag=ona_a3
@info tag=i_a04 text="莉音のオナニー履歴を更新しました！"				subtag=_4	eval="sca04h"	withsflag	flag=ona_a4
@info tag=i_a04 text="莉音のオナニー履歴を更新しました！"		onakeep		subtag=_5	eval="sca05h"	withsflag	flag=ona_a5
@info tag=i_a04 text="莉音のオナニー履歴を更新しました！"				subtag=_6	eval="sca06h"	withsflag	flag=ona_a6
@info tag=i_a04 text="莉音のオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="sca20h"	withsflag	flag=ona_a_oya
@info tag=i_a04 text="莉音のオナニー履歴を更新しました！"		onakeep		subtag=_camp	eval="sca30h"	withsflag	flag=ona_a_camp
;
@info tag=i_b04 text="恋乃香のオナニー履歴を更新しました！"				subtag=_1	eval="scb01h"	withsflag	flag=ona_b1
@info tag=i_b04 text="恋乃香のオナニー履歴を更新しました！"				subtag=_2	eval="scb02h"	withsflag	flag=ona_b2
@info tag=i_b04 text="恋乃香のオナニー履歴を更新しました！"				subtag=_3	eval="scb03h"	withsflag	flag=ona_b3
@info tag=i_b04 text="恋乃香のオナニー履歴を更新しました！"		onakeep		subtag=_4	eval="scb04h"	withsflag	flag=ona_b4
@info tag=i_b04 text="恋乃香のオナニー履歴を更新しました！"				subtag=_5	eval="scb05h"	withsflag	flag=ona_b5
@info tag=i_b04 text="恋乃香のオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="scb20h"	withsflag	flag=ona_b_oya
@info tag=i_b04 text="恋乃香のオナニー履歴を更新しました！"		onakeep		subtag=_camp	eval="scb30h"	withsflag	flag=ona_b_camp
;
@info tag=i_c04 text="晶のオナニー履歴を更新しました！"					subtag=_1	eval="scc01h"	withsflag	flag=ona_c1
@info tag=i_c04 text="晶のオナニー履歴を更新しました！"					subtag=_2	eval="scc02h"	withsflag	flag=ona_c2
@info tag=i_c04 text="晶のオナニー履歴を更新しました！"			onakeep		subtag=_3	eval="scc03h"	withsflag	flag=ona_c3
@info tag=i_c04 text="晶のオナニー履歴を更新しました！"					subtag=_4	eval="scc04h"	withsflag	flag=ona_c4
@info tag=i_c04 text="晶のオナニー履歴を更新しました！"					subtag=_5	eval="scc05h"	withsflag	flag=ona_c5
@info tag=i_c04 text="晶のオナニー履歴を更新しました！"			onakeep		subtag=_oya	eval="scc20h"	withsflag	flag=ona_c_oya
@info tag=i_c04 text="晶のオナニー履歴を更新しました！"			onakeep		subtag=_camp	eval="scc30h"	withsflag	flag=ona_c_camp
;
@info tag=i_d04 text="奈々子のオナニー履歴を更新しました！"				subtag=_1	eval="scd01h"	withsflag	flag=ona_d1
@info tag=i_d04 text="奈々子のオナニー履歴を更新しました！"		onakeep		subtag=_2	eval="scd02h"	withsflag	flag=ona_d2
@info tag=i_d04 text="奈々子のオナニー履歴を更新しました！"				subtag=_3	eval="scd03h"	withsflag	flag=ona_d3
@info tag=i_d04 text="奈々子のオナニー履歴を更新しました！"				subtag=_4	eval="scd04h"	withsflag	flag=ona_d4
@info tag=i_d04 text="奈々子のオナニー履歴を更新しました！"		onakeep		subtag=_5	eval="scd05h"	withsflag	flag=ona_d5
@info tag=i_d04 text="奈々子のオナニー履歴を更新しました！"				subtag=_6	eval="scd06h"	withsflag	flag=ona_d6
@info tag=i_d04 text="奈々子のオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="scd20h"	withsflag	flag=ona_d_oya
@info tag=i_d04 text="奈々子のオナニー履歴を更新しました！"		onakeep		subtag=_camp	eval="scd30h"	withsflag	flag=ona_d_camp
;
@info tag=i_e04 text="摩耶のオナニー履歴を更新しました！"				subtag=_1	eval="sce01h"	withsflag	flag=ona_e1
@info tag=i_e04 text="摩耶のオナニー履歴を更新しました！"				subtag=_2	eval="sce02h"	withsflag	flag=ona_e2
@info tag=i_e04 text="摩耶のオナニー履歴を更新しました！"		onakeep		subtag=_3	eval="sce03h"	withsflag	flag=ona_e3
@info tag=i_e04 text="摩耶のオナニー履歴を更新しました！"				subtag=_4	eval="sce04h"	withsflag	flag=ona_e4
@info tag=i_e04 text="摩耶のオナニー履歴を更新しました！"				subtag=_5	eval="sce05h"	withsflag	flag=ona_e5
@info tag=i_e04 text="摩耶のオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="sce20h"	withsflag	flag=ona_e_oya
@info tag=i_e04 text="摩耶のオナニー履歴を更新しました！"		onakeep		subtag=_camp	eval="sce30h"	withsflag	flag=ona_e_camp
;
@info tag=i_f04 text="ひなたのオナニー履歴を更新しました！"				subtag=_1	eval="scf01h"	withsflag	flag=ona_f1
@info tag=i_f04 text="ひなたのオナニー履歴を更新しました！"				subtag=_2	eval="scf02h"	withsflag	flag=ona_f2
@info tag=i_f04 text="ひなたのオナニー履歴を更新しました！"		onakeep		subtag=_3	eval="scf03h"	withsflag	flag=ona_f3
@info tag=i_f04 text="ひなたのオナニー履歴を更新しました！"				subtag=_4	eval="scf04h"	withsflag	flag=ona_f4
@info tag=i_f04 text="ひなたのオナニー履歴を更新しました！"				subtag=_5	eval="scf05h"	withsflag	flag=ona_f5
@info tag=i_f04 text="ひなたのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="scf20h"	withsflag	flag=ona_f_oya
@info tag=i_f04 text="ひなたのオナニー履歴を更新しました！"		onakeep		subtag=_camp	eval="scf30h"	withsflag	flag=ona_f_camp
;
@info tag=i_g04 text="楓のオナニー履歴を更新しました！"					subtag=_1	eval="scg01h"	withsflag	flag=ona_g1
@info tag=i_g04 text="楓のオナニー履歴を更新しました！"					subtag=_2	eval="scg02h"	withsflag	flag=ona_g2
@info tag=i_g04 text="楓のオナニー履歴を更新しました！"					subtag=_3	eval="scg03h"	withsflag	flag=ona_g3
@info tag=i_g04 text="楓のオナニー履歴を更新しました！"			onakeep		subtag=_4	eval="scg04h"	withsflag	flag=ona_g4
@info tag=i_g04 text="楓のオナニー履歴を更新しました！"					subtag=_5	eval="scg05h"	withsflag	flag=ona_g5
@info tag=i_g04 text="楓のオナニー履歴を更新しました！"			onakeep		subtag=_oya	eval="scg20h"	withsflag	flag=ona_g_oya
@info tag=i_g04 text="楓のオナニー履歴を更新しました！"			onakeep		subtag=_camp	eval="scg30h"	withsflag	flag=ona_g_camp
;
@info tag=i_h04 text="優華理のオナニー履歴を更新しました！"				subtag=_1	eval="sch01h"	withsflag	flag=ona_h1
@info tag=i_h04 text="優華理のオナニー履歴を更新しました！"				subtag=_2	eval="sch02h"	withsflag	flag=ona_h2
@info tag=i_h04 text="優華理のオナニー履歴を更新しました！"				subtag=_3	eval="sch03h"	withsflag	flag=ona_h3
@info tag=i_h04 text="優華理のオナニー履歴を更新しました！"		onakeep		subtag=_4	eval="sch04h"	withsflag	flag=ona_h4
@info tag=i_h04 text="優華理のオナニー履歴を更新しました！"				subtag=_5	eval="sch05h"	withsflag	flag=ona_h5
@info tag=i_h04 text="優華理のオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="sch20h"	withsflag	flag=ona_h_oya
@info tag=i_h04 text="優華理のオナニー履歴を更新しました！"		onakeep		subtag=_camp	eval="sch30h"	withsflag	flag=ona_h_camp
;
@info tag=i_i04 text="リリアのオナニー履歴を更新しました！"				subtag=_1	eval="sci01h"	withsflag	flag=ona_i1
@info tag=i_i04 text="リリアのオナニー履歴を更新しました！"				subtag=_2	eval="sci02h"	withsflag	flag=ona_i2
@info tag=i_i04 text="リリアのオナニー履歴を更新しました！"		onakeep		subtag=_3	eval="sci03h"	withsflag	flag=ona_i3
@info tag=i_i04 text="リリアのオナニー履歴を更新しました！"				subtag=_4	eval="sci04h"	withsflag	flag=ona_i4
@info tag=i_i04 text="リリアのオナニー履歴を更新しました！"				subtag=_5	eval="sci05h"	withsflag	flag=ona_i5
@info tag=i_i04 text="リリアのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="sci20h"	withsflag	flag=ona_i_oya
@info tag=i_i04 text="リリアのオナニー履歴を更新しました！"		onakeep		subtag=_camp	eval="sci30h"	withsflag	flag=ona_i_camp
;
@info tag=i_j04 text="リーシャのオナニー履歴を更新しました！"				subtag=_1	eval="scj01h"	withsflag	flag=ona_j1
@info tag=i_j04 text="リーシャのオナニー履歴を更新しました！"				subtag=_2	eval="scj02h"	withsflag	flag=ona_j2
@info tag=i_j04 text="リーシャのオナニー履歴を更新しました！"		onakeep		subtag=_3	eval="scj03h"	withsflag	flag=ona_j3
@info tag=i_j04 text="リーシャのオナニー履歴を更新しました！"				subtag=_4	eval="scj04h"	withsflag	flag=ona_j4
@info tag=i_j04 text="リーシャのオナニー履歴を更新しました！"				subtag=_5	eval="scj05h"	withsflag	flag=ona_j5
@info tag=i_j04 text="リーシャのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="scj20h"	withsflag	flag=ona_j_oya
@info tag=i_j04 text="リーシャのオナニー履歴を更新しました！"		onakeep		subtag=_camp	eval="scj30h"	withsflag	flag=ona_j_camp
;
@info tag=i_a05 text="莉音シナリオを完全攻略しました！"							eval="sca06h"
@info tag=i_b05 text="恋乃香シナリオを完全攻略しました！"						eval="scb05h"
@info tag=i_c05 text="晶シナリオを完全攻略しました！"							eval="scc05h"
@info tag=i_d05 text="奈々子シナリオを完全攻略しました！"						eval="scd06h"
@info tag=i_e05 text="摩耶シナリオを完全攻略しました！"							eval="sce05h"
@info tag=i_f05 text="ひなたシナリオを完全攻略しました！"						eval="scf05h"
@info tag=i_g05 text="楓シナリオを完全攻略しました！"							eval="scg05h"
@info tag=i_h05 text="優華理シナリオを完全攻略しました！"						eval="sch05h"
@info tag=i_i05 text="リリアシナリオを完全攻略しました！"						eval="sci05h"
@info tag=i_j05 text="リーシャシナリオを完全攻略しました！"						eval="scj05h"
;
@info tag=i_s01 text="「孕ませ！ハーレムエンド！」条件を満たしました！"			flag=end_1	エンド条件：ハーレム
@info tag=i_s02 text="「おっぱい母親！孕ませ！ハーレムエンド！」条件を満たしました！"	flag=end_2	エンド条件：母親ハーレム
@info tag=i_a06 text="『莉音エンディング』の条件を満たしました！"			flag=end_a	エンド条件：莉音
@info tag=i_s03 text="CGが100％になりました！"						sflag		eval=".sf.cg_complete"
;
@info tag=i_s05 text="「エンディング選択肢」にいけるようになりました！"			flag=ending	eval="end_1 || end_2 || end_a"
@info tag=i_s06 text="「ステージスキップボタン」が使えるようになりました！"		flag=chaptskip	eval="end_1 || end_2 || end_a"
@info tag=i_s99 text="これ以降のステージはありません！\nエンディング選択でゲームをクリアしてください！"	eval="現在のステージ==14"
;
; オナニー履歴を更新(infoが立てるフラグに依存するのでここに配置)
@subtext
;
;-------------------------------------------------------------------------------
;※各ページの設定へジャンプ
;
*page
@page_branch page="main"
@page_branch page="sub"
@page_branch page="boot_camp"
@page_branch page="oyako"
@page_branch page="multi"
@page_branch page="ending"
;@page_branch page="ending14"
; ※オナニー回数の更新処理が必要なため，status_mainはこの位置に配置
@page_branch page="status_main"
;
; 各main2選択へ
@page_branch page="main2_a"
@page_branch page="main2_b"
@page_branch page="main2_c"
@page_branch page="main2_d"
@page_branch page="main2_e"
@page_branch page="main2_f"
@page_branch page="main2_g"
@page_branch page="main2_h"
@page_branch page="main2_i"
@page_branch page="main2_j"
;-------------------------------------------------------------------------------
; それ以外のページはエラー
@error message='&"不明なページです:"+page'
;-------------------------------------------------------------------------------
; メイン選択
;
*main|
@screen page=main storage=quest_main rclick=""
;
@button page=main name=to_status      comment="主人公プロフィール"	to=status
@button page=main name=to_status_main comment="メインキャラプロフ"	to=status_main
@button page=main name=to_status_sub  comment="サブキャラプロフィール"	to=status_sub
@button page=main name=to_endsel      comment="エンディング選択画面"	to=ending	eval="ending" dshide
@button page=main name=to_sub         comment="サブキャラ選択画面"	to=sub		badge="sub_k:sub_l:sub_m:sub_n:sub_o:sub_p:sub_q:sub_r:sub_s:sub_t"
@button page=main name=to_oyako       comment="親子丼選択画面"		to=oyako	badge="oya_a:oya_b:oya_c:oya_d:oya_e:oya_f:oya_g:oya_h:oya_i:oya_j"
@button page=main name=to_boot_camp   comment="ブートキャンプ選択画面"	to=boot_camp	badge="camp_a:camp_b:camp_c:camp_d:camp_e:camp_f:camp_g:camp_h:camp_i:camp_j"
@button page=main name=to_multi       comment="多人数選択画面"		to=multi	badge="mul_1:mul_2:mul_3:mul_4:mul_5:mul_6:mul_7"
@button page=main name=quest_skip     comment="章スキップ"				storage=gameloop.txt target=*nextchapter	eval="chaptskip && 現在のステージ<14" dshide
;												↓親子丼／おっぱい発育のフラグ
@main   page=main name=ch0	to=main2_a	nodisable	攻略状況：莉音		partcomp="state_oyako:sca20n|state_camp:sca30n"
@main   page=main name=ch1	to=main2_b	nodisable	攻略状況：恋乃香	partcomp="state_oyako:scb20n|state_camp:scb30n"
@main   page=main name=ch2	to=main2_c	nodisable	攻略状況：晶		partcomp="state_oyako:scc20n|state_camp:scc30n"
@main   page=main name=ch3	to=main2_d	nodisable	攻略状況：奈々子	partcomp="state_oyako:scd20n|state_camp:scd30n"
@main   page=main name=ch4	to=main2_e	nodisable	攻略状況：摩耶		partcomp="state_oyako:sce20n|state_camp:sce30n"
@main   page=main name=ch5	to=main2_f	nodisable	攻略状況：ひなた	partcomp="state_oyako:scf20n|state_camp:scf30n"
@main   page=main name=ch6	to=main2_g	nodisable	攻略状況：楓		partcomp="state_oyako:scg20n|state_camp:scg30n"
@main   page=main name=ch7	to=main2_h	nodisable	攻略状況：優華理	partcomp="state_oyako:sch20n|state_camp:sch30n"
@main   page=main name=ch8	to=main2_i	nodisable	攻略状況：リリア	partcomp="state_oyako:sci20n|state_camp:sci30n"
@main   page=main name=ch9	to=main2_j	nodisable	攻略状況：リーシャ	partcomp="state_oyako:scj20n|state_camp:scj30n"
;
@prof   page=main name=prof	flag=prof_main	prefix=ch	layers=prof_name:prof_stand:prof_base
;
@number page=main name=chapter cpref=num flag=現在のステージ
@number page=main name=quest   cpref=num flag=現在のウェーブ
;
@exit
;-------------------------------------------------------------------------------
; メイン各キャラのエピソード選択
*main2_a|
	@screen_main2 page=main2_a target=*goto_main_a 攻略状況：莉音
*main2_b|
	@screen_main2 page=main2_b target=*goto_main_b 攻略状況：恋乃香
*main2_c|
	@screen_main2 page=main2_c target=*goto_main_c 攻略状況：晶
*main2_d|
	@screen_main2 page=main2_d target=*goto_main_d 攻略状況：奈々子
*main2_e|
	@screen_main2 page=main2_e target=*goto_main_e 攻略状況：摩耶
*main2_f|
	@screen_main2 page=main2_f target=*goto_main_f 攻略状況：ひなた
*main2_g|
	@screen_main2 page=main2_g target=*goto_main_g 攻略状況：楓
*main2_h|
	@screen_main2 page=main2_h target=*goto_main_h 攻略状況：優華理
*main2_i|
	@screen_main2 page=main2_i target=*goto_main_i 攻略状況：リリア
*main2_j|
	@screen_main2 page=main2_j target=*goto_main_j 攻略状況：リーシャ

;-------------------------------------------------------------------------------
; サブ選択
;
*sub|
@screen page=sub  storage=quest_sub rclick=main
;
@sub    page=sub  name=subch0	サブキャラ：絵美里	new="sub_k"	storage=gameloop.txt target=*goto_sub_k
@sub    page=sub  name=subch1	サブキャラ：めぐみ	new="sub_l"	storage=gameloop.txt target=*goto_sub_l
@sub    page=sub  name=subch2	サブキャラ：薫		new="sub_m"	storage=gameloop.txt target=*goto_sub_m
@sub    page=sub  name=subch3	サブキャラ：玲奈	new="sub_n"	storage=gameloop.txt target=*goto_sub_n
@sub    page=sub  name=subch4	サブキャラ：舞		new="sub_o"	storage=gameloop.txt target=*goto_sub_o
@sub    page=sub  name=subch5	サブキャラ：祈子	new="sub_p"	storage=gameloop.txt target=*goto_sub_p
@sub    page=sub  name=subch6	サブキャラ：かなめ	new="sub_q"	storage=gameloop.txt target=*goto_sub_q
@sub    page=sub  name=subch7	サブキャラ：道子	new="sub_r"	storage=gameloop.txt target=*goto_sub_r
@sub    page=sub  name=subch8	サブキャラ：珠子	new="sub_s"	storage=gameloop.txt target=*goto_sub_s
@sub    page=sub  name=subch9	サブキャラ：遙香	new="sub_t"	storage=gameloop.txt target=*goto_sub_t
;
@prof   page=sub  name=prof	flag=prof_sub	prefix=subch	layers=prof_text:prof_stand:prof_name
;
@button page=sub  name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; 親子丼選択
;
*oyako|
@screen page=oyako storage=quest_oyako rclick=main
;
@oyako page=oyako name=oyako0	comment="莉音＆天舞音"			withnew eval="oya_a"	storage=gameloop.txt target=*goto_oyako_a
@oyako page=oyako name=oyako1	comment="恋乃香＆聖子"			withnew eval="oya_b"	storage=gameloop.txt target=*goto_oyako_b
@oyako page=oyako name=oyako2	comment="晶＆リリンダ"			withnew eval="oya_c"	storage=gameloop.txt target=*goto_oyako_c
@oyako page=oyako name=oyako3	comment="奈々子＆美桜"			withnew eval="oya_d"	storage=gameloop.txt target=*goto_oyako_d
@oyako page=oyako name=oyako4	comment="摩耶＆悦子"			withnew eval="oya_e"	storage=gameloop.txt target=*goto_oyako_e
@oyako page=oyako name=oyako5	comment="ひなた＆香澄"			withnew eval="oya_f"	storage=gameloop.txt target=*goto_oyako_f
@oyako page=oyako name=oyako6	comment="楓＆綾夢"			withnew eval="oya_g"	storage=gameloop.txt target=*goto_oyako_g
@oyako page=oyako name=oyako7	comment="優華理＆沙百合"		withnew eval="oya_h"	storage=gameloop.txt target=*goto_oyako_h
@oyako page=oyako name=oyako8	comment="リリア＆愛海"			withnew eval="oya_i"	storage=gameloop.txt target=*goto_oyako_i
@oyako page=oyako name=oyako9	comment="リーシャ＆ラウダ"		withnew eval="oya_j"	storage=gameloop.txt target=*goto_oyako_j
;
@button page=oyako name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; ブートキャンプ選択
;
*boot_camp|
@screen page=boot_camp storage=quest_boot_camp rclick=main
;
@camp page=boot_camp name=boot_camp0	comment="莉音"			withnew eval="camp_a"	storage=gameloop.txt target=*goto_boot_camp_a
@camp page=boot_camp name=boot_camp1	comment="恋乃香"		withnew eval="camp_b"	storage=gameloop.txt target=*goto_boot_camp_b
@camp page=boot_camp name=boot_camp2	comment="晶"			withnew eval="camp_c"	storage=gameloop.txt target=*goto_boot_camp_c
@camp page=boot_camp name=boot_camp3	comment="奈々子"		withnew eval="camp_d"	storage=gameloop.txt target=*goto_boot_camp_d
@camp page=boot_camp name=boot_camp4	comment="摩耶"			withnew eval="camp_e"	storage=gameloop.txt target=*goto_boot_camp_e
@camp page=boot_camp name=boot_camp5	comment="ひなた"		withnew eval="camp_f"	storage=gameloop.txt target=*goto_boot_camp_f
@camp page=boot_camp name=boot_camp6	comment="楓"			withnew eval="camp_g"	storage=gameloop.txt target=*goto_boot_camp_g
@camp page=boot_camp name=boot_camp7	comment="優華理"		withnew eval="camp_h"	storage=gameloop.txt target=*goto_boot_camp_h
@camp page=boot_camp name=boot_camp8	comment="リリア"		withnew eval="camp_i"	storage=gameloop.txt target=*goto_boot_camp_i
@camp page=boot_camp name=boot_camp9	comment="リーシャ"		withnew eval="camp_j"	storage=gameloop.txt target=*goto_boot_camp_j
;
@button page=boot_camp name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; 多人数選択
;
@info tag=i_x01 text="『メイド牝猫カフェアプリ！』が多人数エロページに追加！"				flag=mul_1	多人数：猫カフェ
*multi|
@screen page=multi storage=quest_multi rclick=main
;
@layer page=multi name=fullhdanim comment="アニメーションお知らせ通知"	        eval="mul_4"
;
@multi page=multi name=multi0	comment="人妻おっぱいバレーハーレム！"		withnew eval="mul_5"	storage=gameloop.txt target=*goto_multi_5
@multi page=multi name=multi1	comment="強制混浴！母乳露天風呂！"		withnew eval="mul_7"	storage=gameloop.txt target=*goto_multi_7
@multi page=multi name=multi2	comment="トリプルパイズリナースアプリ！"	withnew eval="mul_4"	storage=gameloop.txt target=*goto_multi_4
@multi page=multi name=multi3	comment="メイド牝猫カフェアプリ！"		withnew eval="mul_1"	storage=gameloop.txt target=*goto_multi_1
@multi page=multi name=multi4	comment="セーラー水着中出し花火大会アプリ！"	withnew eval="mul_2"	storage=gameloop.txt target=*goto_multi_2
@multi page=multi name=multi5	comment="強制バニーガールアプリ！"		withnew eval="mul_3"	storage=gameloop.txt target=*goto_multi_3
@multi page=multi name=multi6	comment="おっぱい人妻例のプール参観日アプリ！"	withnew eval="mul_6"	storage=gameloop.txt target=*goto_multi_6
;
@button page=multi name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; お出かけ選択（scx08通過版）　※scx0?h は多人数画面のフラグで使用されるのでここでは scx0?n を使用する
*odekake|
@screen page=odekake storage=odekake rclick=""
;
; 既読チェック
@layer page=odekake name=odekake1_read eval="scx01n"
@layer page=odekake name=odekake2_read eval="scx02n"
@layer page=odekake name=odekake3_read eval="scx03n"
;
; ※複数回選択不可？
@button page=odekake name=odekake1  eval="!scx01n" storage=gameloop.txt target=*goto_odekake_1
@button page=odekake name=odekake2  eval="!scx02n" storage=gameloop.txt target=*goto_odekake_2
@button page=odekake name=odekake3  eval="!scx03n" storage=gameloop.txt target=*goto_odekake_3
;
; 終了ボタン（次のステージへ）
@button page=odekake name=nextstage                storage=gameloop.txt target=*stage
;
@exit
;-------------------------------------------------------------------------------
; エンディング選択
;
*ending|
@screen page=ending storage=ending_select rclick=main
;
; newマーク特殊処理（過去にエンディングを見てない場合にのみ表示）
@layer  page=ending name=end0_new eval="end_1 && !.sf.sced01h"
@layer  page=ending name=end1_new eval="end_2 && !.sf.sced02h"
@layer  page=ending name=end2_new eval="end_a && !.sf.sca50h"
;
@ending page=ending name=end0	comment="孕ませ！ハーレムエンド！"			eval="end_1"	storage=gameloop.txt target=*goto_end_1
@ending page=ending name=end1	comment="おっぱい母親！孕ませ！ハーレムエンド！"	eval="end_2"	storage=gameloop.txt target=*goto_end_2
@ending page=ending name=end2	comment="莉音と子作り温泉旅行"				eval="end_a"	storage=gameloop.txt target=*goto_end_a
;
@button page=ending name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; エンディング選択sc14通過版
;
;*ending14|
;@screen page=ending14 storage=ending_select rclick=""
;
;@ending page=ending14 name=end0	comment="孕ませ！ハーレムエンド！"			eval="end_1"	storage=gameloop.txt target=*goto_end_1
;@ending page=ending14 name=end1	comment="おっぱい母親！孕ませ！ハーレムエンド！"	eval="end_2"	storage=gameloop.txt target=*goto_end_2
;@ending page=ending14 name=end2	comment="莉音と子作り温泉旅行"				eval="end_a"	storage=gameloop.txt target=*goto_end_a
;
;@exit
;-------------------------------------------------------------------------------
; ステータス画面
;
*status|
@screen page=status storage=status click=main rclick=main nomenu
;
@status page=status	name=ch0	攻略状況：莉音
@status page=status	name=ch1	攻略状況：恋乃香
@status page=status	name=ch2	攻略状況：晶
@status page=status	name=ch3	攻略状況：奈々子
@status page=status	name=ch4	攻略状況：摩耶
@status page=status	name=ch5	攻略状況：ひなた
@status page=status	name=ch6	攻略状況：楓
@status page=status	name=ch7	攻略状況：優華理
@status page=status	name=ch8	攻略状況：リリア
@status page=status	name=ch9	攻略状況：リーシャ
;
@complete page=status	name=harem	eval=".sf.sced01h"
@complete page=status	name=hmase	eval=".sf.sced02h"
@complete page=status	name=rio	eval=".sf.sca50h"
@number   page=status	name=cgcomp	flag=".sf.cg_ratio" keta=3 cpref=num
@text     page=status	name=player	flag="name"
;
@exit
;-------------------------------------------------------------------------------
; ステータス画面メイン（プロフィール画面メインキャラ用）
;
*status_main|
@screen page=status_main storage=status_main rclick=main nomenu

@call target=*status_main_common
@button page=status_main name=to_status_sub to=status_sub
@button page=status_main name=back to=main withsubtext
;
@exit
;
; 共通処理(ゲーム中/タイトルから呼び出し)
*status_main_common
@button page=status_main name=ch0	withsubtext profile=0	toggle	comment="a:莉音"
@button page=status_main name=ch1	withsubtext profile=1	toggle	comment="b:恋乃香"
@button page=status_main name=ch2	withsubtext profile=2	toggle	comment="c:晶"
@button page=status_main name=ch3	withsubtext profile=3	toggle	comment="d:奈々子"
@button page=status_main name=ch4	withsubtext profile=4	toggle	comment="e:摩耶"
@button page=status_main name=ch5	withsubtext profile=5	toggle	comment="f:ひなた"
@button page=status_main name=ch6	withsubtext profile=6	toggle	comment="g:楓"
@button page=status_main name=ch7	withsubtext profile=7	toggle	comment="h:優華理"
@button page=status_main name=ch8	withsubtext profile=8	toggle	comment="i:リリア"
@button page=status_main name=ch9	withsubtext profile=9	toggle	comment="j:リーシャ"
;
; 下記２行は更新の都合によりprofより前に配置すること
@number page=status_main name=ona_count		flag="0" keta=3 cpref=num
@text   page=status_main name=ona_text		default="履歴情報はありません"
;
@prof   page=status_main name=prof	flag=status_main	prefix="ch"	layers=prof_stand:prof_name radio dress subtext=*update
@button page=status_main name=dress0	dress=0
@button page=status_main name=dress1	dress=1
@button page=status_main name=dress2	dress=2
@button page=status_main name=dress3	dress=3
@button page=status_main name=dress4	dress=4
@button page=status_main name=dress5	dress=5
;
;
;※ズーム時は立ち絵を使うのでキャラ名と服装定義が必要（zoomview="キャラ2:服装1:服装2:...|キャラ2:服装..."） キャラ・服装の順番は画面UIの並びに従うこと
@button page=status_main name=zoom	zoomview="莉音:制服:水着:テニスウェア:スーツ:裸:私服|恋乃香:制服リボンピンク:水着:アイドル:スーツ:裸|晶:制服:水着:部活:スーツ:裸:私服|奈々子:制服:水着:部活:スーツ:裸|摩耶:制服:水着:スーツ:裸:制服スカート無し|ひなた:制服:水着:部活:スーツ:裸|楓:制服:水着:スーツ:裸:ウェイトレス|優華理:制服:水着:部活:スーツ:裸|リリア:制服:水着:部活:スーツ:裸|リーシャ:制服:水着:部活:スーツ:裸"
;
@return
;-------------------------------------------------------------------------------
; ステータス画面サブ（プロフィール画面サブキャラ用）
;
*status_sub|
@screen page=status_sub storage=status_sub rclick=main nomenu
;
@call target=*status_sub_common
;
@button page=status_sub name=to_status_main to=status_main
@button page=status_sub name=back to=main
;
@exit
;
; 共通処理(ゲーム中/タイトルから呼び出し)
*status_sub_common
@button page=status_sub name=subch0	profile=0	toggle	comment="k:絵美里"
@button page=status_sub name=subch1	profile=1	toggle	comment="l:めぐみ"
@button page=status_sub name=subch2	profile=2	toggle	comment="m:薫"
@button page=status_sub name=subch3	profile=3	toggle	comment="n:玲奈"
@button page=status_sub name=subch4	profile=4	toggle	comment="o:舞"
@button page=status_sub name=subch5	profile=5	toggle	comment="p:祈子"
@button page=status_sub name=subch6	profile=6	toggle	comment="q:かなめ"
@button page=status_sub name=subch7	profile=7	toggle	comment="r:道子"
@button page=status_sub name=subch8	profile=8	toggle	comment="s:珠子"
@button page=status_sub name=subch9	profile=9	toggle	comment="t:遙香"
;
@prof   page=status_sub name=prof	flag=status_sub		prefix="subch"	layers=prof_stand:prof_name radio dress
@button page=status_sub name=dress0	dress=0
@button page=status_sub name=dress1	dress=1
@button page=status_sub name=dress2	dress=2
;
;※ズーム時は立ち絵を使うのでキャラ名と服装定義が必要（zoomview="キャラ2:服装1:服装2:...|キャラ2:服装..."）
@button page=status_sub name=zoom	zoomview="絵美里:私服|めぐみ:服:水着:裸|薫:制服|玲奈:服|舞:服|祈子:制服|かなめ:服|道子:服|珠子:制服:スカート無し|遙香:服"
;
@return
;-------------------------------------------------------------------------------
; タイトルからのステータス画面呼び出し

*title
@close storage=custom.ks target=*close_status
@exit

*status_main_title|
; オナニー履歴を更新(タイトルからの呼び出しはinfo~subtextが呼ばれないのでここで呼ぶ)
@subtext
@screen page=status_main_title storage=status_main rclick=title nomenu exp="this.page=tf.title_status='status_main'"
;
@call target=*status_main_common
@button page=status_main name=to_status_sub to=status_sub_title
@button page=status_main name=back to=title
@exit

*status_sub_title|
@screen page=status_sub_title storage=status_sub rclick=title nomenu exp="this.page=tf.title_status='status_sub'"
;
@call target=*status_sub_common
@button page=status_sub name=to_status_main to=status_main_title
@button page=status_sub name=back to=title
@exit

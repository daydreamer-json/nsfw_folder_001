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

;-------------------------------------------------------------------------------
; メインキャラ攻略状況条件
;
@pmacro name="攻略状況：魔恋"			comment="魔恋"			point="sca01h:sca02h:sca03h:sca04h:sca05h"
@pmacro name="攻略状況：キャルル"		comment="キャルル"		point="scb01h:scb02h:scb03h:scb04h:scb05h"
@pmacro name="攻略状況：鷹美"			comment="鷹美"			point="scc01h:scc02h:scc03h:scc04h:scc05h"
@pmacro name="攻略状況：シャルティーナ"		comment="シャルティーナ"	point="scd01h:scd02h:scd03h:scd04h:scd05h"
@pmacro name="攻略状況：キュンキュン"		comment="キュンキュン"		point="sce01h:sce02h:sce03h:sce04h:sce05h"
@pmacro name="攻略状況：エルゼ"			comment="エルゼ"		point="scf01h:scf02h:scf03h:scf04h:scf05h"
@pmacro name="攻略状況：セレスティア"		comment="セレスティア"		point="scg01h:scg02h:scg03h:scg04h:scg05h"
@pmacro name="攻略状況：ロザリナ"		comment="ロザリナ"		point="sch01h:sch02h:sch03h:sch04h:sch05h"
@pmacro name="攻略状況：ソフィア"		comment="ソフィア"		point="sci01h:sci02h:sci03h:sci04h:sci05h"
@pmacro name="攻略状況：ファム"			comment="ファム"		point="scj01h:scj02h:scj03h:scj04h:scj05h"
;
;-------------------------------------------------------------------------------
; エンド条件
;
@pmacro name="エンド条件：ハーレム"		eval="sca03h && scb01h && scc02h && scd01h && sce03h && scf02h && scg03h && sch02h && sci03h && scj01h"
@pmacro name="エンド条件：母親ハーレム"		eval="sca20h && scb20h && scc20h && scd20h && sce20h && scf20h && scg20h && sch20h && sci20h && scj20h"
@pmacro name="エンド条件：魔恋"    		eval="sca05h"
;
;-------------------------------------------------------------------------------
; サブキャラ枠オープン条件
;
@pmacro name="サブキャラ：アルヴィネラ１"	comment="アルヴィネラ1"	eval="sc01"	point="sck01h:sck02h"
@pmacro name="サブキャラ：アルヴィネラ２"	comment="アルヴィネラ2"	eval="sck01h"	point="sck01h:sck02h"
@pmacro name="サブキャラ：フィリス１"		comment="フィリス1"	eval="sc01"	point="scl01h:scl02h"
@pmacro name="サブキャラ：フィリス２"		comment="フィリス2"	eval="scl01h"	point="scl01h:scl02h"
@pmacro name="サブキャラ：アンジェリカ１"	comment="アンジェリカ1"	eval="sc09"	point="scm01h:scm02h"
@pmacro name="サブキャラ：アンジェリカ２"	comment="アンジェリカ2"	eval="scm01h"	point="scm01h:scm02h"
@pmacro name="サブキャラ：リジィ１"		comment="リジィ1"	eval="sc06"	point="scn01h:scn02h"
@pmacro name="サブキャラ：リジィ２"		comment="リジィ2"	eval="scn01h"	point="scn01h:scn02h"
@pmacro name="サブキャラ：リラ"			comment="リラ"		eval="sc04"	point="sco01h"
@pmacro name="サブキャラ：ベルダ"		comment="ベルダ"	eval="sc08"	point="scp01h"
@pmacro name="サブキャラ：マロン"		comment="マロン"	eval="sc05"	point="scq01h"
@pmacro name="サブキャラ：シトラ"		comment="シトラ"	eval="sc03"	point="scr01h"
@pmacro name="サブキャラ：ハピネス１"		comment="ハピネス1"	eval="sc10"	point="scs01h:scs02h"
@pmacro name="サブキャラ：ハピネス２"		comment="ハピネス2"	eval="scs01h"	point="scs01h:scs02h"
@pmacro name="サブキャラ：ラグジュアル"		comment="ラグジュアル"	eval="sc02"	point="sct01h"
;
;-------------------------------------------------------------------------------
; 親子丼枠オープン条件
;
@pmacro name="親子丼：魔恋"			eval="sca02h"
@pmacro name="親子丼：キャルル"			eval="scb02h"
@pmacro name="親子丼：鷹美"			eval="scc04h"
@pmacro name="親子丼：シャルティーナ"		eval="scd01h"
@pmacro name="親子丼：キュンキュン"		eval="sce02h"
@pmacro name="親子丼：エルゼ"			eval="scf01h"
@pmacro name="親子丼：セレスティア"		eval="scg02h"
@pmacro name="親子丼：ロザリナ"			eval="sch02h"
@pmacro name="親子丼：ソフィア"			eval="sci03h"
@pmacro name="親子丼：ファム"			eval="scj02h"
;
;-------------------------------------------------------------------------------
; おっぱいピックアップ枠オープン条件
;
@pmacro name="おっぱいピックアップ：魔恋"		eval="sca01h"
@pmacro name="おっぱいピックアップ：キャルル"		eval="scb03h"
@pmacro name="おっぱいピックアップ：鷹美"		eval="scc03h"
@pmacro name="おっぱいピックアップ：シャルティーナ"	eval="scd02h"
@pmacro name="おっぱいピックアップ：キュンキュン"	eval="sce04h"
@pmacro name="おっぱいピックアップ：エルゼ"		eval="scf02h"
@pmacro name="おっぱいピックアップ：セレスティア"	eval="scg04h"
@pmacro name="おっぱいピックアップ：ロザリナ"		eval="sch01h"
@pmacro name="おっぱいピックアップ：ソフィア"		eval="sci02h"
@pmacro name="おっぱいピックアップ：ファム"		eval="scj01h"
;
;-------------------------------------------------------------------------------
; 多人数枠オープン条件
;
@pmacro name="多人数：ドスケベ学園祭１年生"	eval="sc07"
@pmacro name="多人数：ドスケベ学園祭２年生"	eval="sc07"
@pmacro name="多人数：ドスケベ学園祭３年生"	eval="sc07"
@pmacro name="多人数：全員Ｚカップ母乳風呂"	eval="sca30h && scb30h && scc30h && scd30h && sce30h && scf30h && scg30h && sch30h && sci30h && scj30h"
@pmacro name="多人数：人妻トリプルパイズリ"	eval="scb20h && sce20h && scf20h"
@pmacro name="多人数：ミス母親コンテスト"	eval="sc07"
@pmacro name="多人数：ドスケベ身体測定"		eval="scc03h && scd03h && scg03h && sch03h && scj03h"
@pmacro name="多人数：緊急ドスケベクエスト"	eval="sco01h"
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
;@main   page=%page name=wave5 pointtag=%page pointnew=%point pointindex=5	storage=gameloop.txt target='&mp.target+"_6"'
;@main   page=%page name=wave6 pointtag=%page pointnew=%point pointindex=6	storage=gameloop.txt target='&mp.target+"_7"' cond="&GetQuestPointCount(mp.point)>5"
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
;↓sck01はプロローグで開封済み
;@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=k1	flag=sub_k1	サブキャラ：アルヴィネラ１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=k2	flag=sub_k2	サブキャラ：アルヴィネラ２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=l1	flag=sub_l1	サブキャラ：フィリス１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=l2	flag=sub_l2	サブキャラ：フィリス２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=m1	flag=sub_m1	サブキャラ：アンジェリカ１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=m2	flag=sub_m2	サブキャラ：アンジェリカ２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=n1	flag=sub_n1	サブキャラ：リジィ１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=n2	flag=sub_n2	サブキャラ：リジィ２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=o	flag=sub_o	サブキャラ：リラ
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=p	flag=sub_p	サブキャラ：ベルダ
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=q	flag=sub_q	サブキャラ：マロン
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=r	flag=sub_r	サブキャラ：シトラ
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=s1	flag=sub_s1	サブキャラ：ハピネス１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=s2	flag=sub_s2	サブキャラ：ハピネス２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！"	subtag=t	flag=sub_t	サブキャラ：ラグジュアル
;
@info tag=i_x01 text="『ドスケベ学園祭 １年生』が多人数エロページに追加！"		flag=mul_1	多人数：ドスケベ学園祭１年生
@info tag=i_x02 text="『ドスケベ学園祭 ２年生』が多人数エロページに追加！"		flag=mul_2	多人数：ドスケベ学園祭２年生
@info tag=i_x03 text="『ドスケベ学園祭 ３年生』が多人数エロページに追加！"		flag=mul_3	多人数：ドスケベ学園祭３年生
@info tag=i_x04 text="『全員Zカップ母乳風呂』が多人数エロページに追加！"		flag=mul_4	多人数：全員Ｚカップ母乳風呂
@info tag=i_x05 text="『人妻トリプルパイズリ』が多人数エロページに追加！"		flag=mul_5	多人数：人妻トリプルパイズリ
@info tag=i_x06 text="『ミス母親コンテスト』が多人数エロページに追加！"			flag=mul_6	多人数：ミス母親コンテスト
@info tag=i_x07 text="『ドスケベ身体測定』が多人数エロページに追加！"			flag=mul_7	多人数：ドスケベ身体測定
@info tag=i_x08 text="『緊急ドスケベクエスト』が多人数エロページに追加！"		flag=mul_8	多人数：緊急ドスケベクエスト
;
@info tag=i_a01 text="孕ませハーレムエンド条件（魔恋）を満たしました！"					eval="sca03h"
@info tag=i_b01 text="孕ませハーレムエンド条件（キャルル）を満たしました！"				eval="scb01h"
@info tag=i_c01 text="孕ませハーレムエンド条件（鷹美）を満たしました！"					eval="scc02h"
@info tag=i_d01 text="孕ませハーレムエンド条件（シャルティーナ）を満たしました！"			eval="scd01h"
@info tag=i_e01 text="孕ませハーレムエンド条件（キュンキュン）を満たしました！"				eval="sce03h"
@info tag=i_f01 text="孕ませハーレムエンド条件（エルゼ）を満たしました！"				eval="scf02h"
@info tag=i_g01 text="孕ませハーレムエンド条件（セレスティア）を満たしました！"				eval="scg03h"
@info tag=i_h01 text="孕ませハーレムエンド条件（ロザリナ）を満たしました！"				eval="sch02h"
@info tag=i_i01 text="孕ませハーレムエンド条件（ソフィア）を満たしました！"				eval="sci03h"
@info tag=i_j01 text="孕ませハーレムエンド条件（ファム）を満たしました！"				eval="scj01h"
;													↑※「エンド条件：ハーレム」の個々のシナリオ通過フラグであることに注意
;
@info tag=i_a02 text="魔恋の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_a	親子丼：魔恋
@info tag=i_b02 text="キャルルの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_b	親子丼：キャルル
@info tag=i_c02 text="鷹美の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_c	親子丼：鷹美
@info tag=i_d02 text="シャルティーナの親子丼シナリオが親子丼ページに追加されました！"	flag=oya_d	親子丼：シャルティーナ
@info tag=i_e02 text="キュンキュンの親子丼シナリオが親子丼ページに追加されました！"	flag=oya_e	親子丼：キュンキュン
@info tag=i_f02 text="エルゼの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_f	親子丼：エルゼ
@info tag=i_g02 text="セレスティアの親子丼シナリオが親子丼ページに追加されました！"	flag=oya_g	親子丼：セレスティア
@info tag=i_h02 text="ロザリナの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_h	親子丼：ロザリナ
@info tag=i_i02 text="ソフィアの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_i	親子丼：ソフィア
@info tag=i_j02 text="ファムの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_j	親子丼：ファム
;
@info tag=i_a03	text="おっぱいピックアップページに魔恋シナリオが追加されました！"		おっぱいピックアップ：魔恋		flag=ex30_a
@info tag=i_b03	text="おっぱいピックアップページにキャルルシナリオが追加されました！"		おっぱいピックアップ：キャルル		flag=ex30_b
@info tag=i_c03	text="おっぱいピックアップページに鷹美シナリオが追加されました！"		おっぱいピックアップ：鷹美		flag=ex30_c
@info tag=i_d03	text="おっぱいピックアップページにシャルティーナシナリオが追加されました！"	おっぱいピックアップ：シャルティーナ		flag=ex30_d
@info tag=i_e03	text="おっぱいピックアップページにキュンキュンシナリオが追加されました！"	おっぱいピックアップ：キュンキュン		flag=ex30_e
@info tag=i_f03	text="おっぱいピックアップページにエルゼシナリオが追加されました！"		おっぱいピックアップ：エルゼ		flag=ex30_f
@info tag=i_g03	text="おっぱいピックアップページにセレスティアシナリオが追加されました！"	おっぱいピックアップ：セレスティア		flag=ex30_g
@info tag=i_h03	text="おっぱいピックアップページにロザリナシナリオが追加されました！"		おっぱいピックアップ：ロザリナ		flag=ex30_h
@info tag=i_i03	text="おっぱいピックアップページにソフィアシナリオが追加されました！"		おっぱいピックアップ：ソフィア		flag=ex30_i
@info tag=i_j03	text="おっぱいピックアップページにファムシナリオが追加されました！"		おっぱいピックアップ：ファム	flag=ex30_j
;
; オナニー回数のみの更新で更新通知が必要な場合は下記をコメントアウト
@pmacro name=onakeep text=""
;
; キャラ別オナニー履歴							回数のみ？	進捗度		条件
@info tag=i_a04 text="魔恋のオナニー履歴を更新しました！"				subtag=_1	eval="sca01h"	withsflag	flag=ona_a1
@info tag=i_a04 text="魔恋のオナニー履歴を更新しました！"				subtag=_2	eval="sca02h"	withsflag	flag=ona_a2
@info tag=i_a04 text="魔恋のオナニー履歴を更新しました！"		onakeep		subtag=_3	eval="sca03h"	withsflag	flag=ona_a3
@info tag=i_a04 text="魔恋のオナニー履歴を更新しました！"				subtag=_4	eval="sca04h"	withsflag	flag=ona_a4
@info tag=i_a04 text="魔恋のオナニー履歴を更新しました！"				subtag=_5	eval="sca05h"	withsflag	flag=ona_a5
@info tag=i_a04 text="魔恋のオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="sca20h"	withsflag	flag=ona_a_oya
@info tag=i_a04 text="魔恋のオナニー履歴を更新しました！"		onakeep		subtag=_ex30	eval="sca30h"	withsflag	flag=ona_a_ex30
;
@info tag=i_b04 text="キャルルのオナニー履歴を更新しました！"				subtag=_1	eval="scb01h"	withsflag	flag=ona_b1
@info tag=i_b04 text="キャルルのオナニー履歴を更新しました！"				subtag=_2	eval="scb02h"	withsflag	flag=ona_b2
@info tag=i_b04 text="キャルルのオナニー履歴を更新しました！"				subtag=_3	eval="scb03h"	withsflag	flag=ona_b3
@info tag=i_b04 text="キャルルのオナニー履歴を更新しました！"		onakeep		subtag=_4	eval="scb04h"	withsflag	flag=ona_b4
@info tag=i_b04 text="キャルルのオナニー履歴を更新しました！"				subtag=_5	eval="scb05h"	withsflag	flag=ona_b5
@info tag=i_b04 text="キャルルのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="scb20h"	withsflag	flag=ona_b_oya
@info tag=i_b04 text="キャルルのオナニー履歴を更新しました！"		onakeep		subtag=_ex30	eval="scb30h"	withsflag	flag=ona_b_ex30
;
@info tag=i_c04 text="鷹美のオナニー履歴を更新しました！"					subtag=_1	eval="scc01h"	withsflag	flag=ona_c1
@info tag=i_c04 text="鷹美のオナニー履歴を更新しました！"					subtag=_2	eval="scc02h"	withsflag	flag=ona_c2
@info tag=i_c04 text="鷹美のオナニー履歴を更新しました！"			onakeep		subtag=_3	eval="scc03h"	withsflag	flag=ona_c3
@info tag=i_c04 text="鷹美のオナニー履歴を更新しました！"					subtag=_4	eval="scc04h"	withsflag	flag=ona_c4
@info tag=i_c04 text="鷹美のオナニー履歴を更新しました！"					subtag=_5	eval="scc05h"	withsflag	flag=ona_c5
@info tag=i_c04 text="鷹美のオナニー履歴を更新しました！"			onakeep		subtag=_oya	eval="scc20h"	withsflag	flag=ona_c_oya
@info tag=i_c04 text="鷹美のオナニー履歴を更新しました！"			onakeep		subtag=_ex30	eval="scc30h"	withsflag	flag=ona_c_ex30
;
@info tag=i_d04 text="シャルティーナのオナニー履歴を更新しました！"				subtag=_1	eval="scd01h"	withsflag	flag=ona_d1
@info tag=i_d04 text="シャルティーナのオナニー履歴を更新しました！"				subtag=_2	eval="scd02h"	withsflag	flag=ona_d2
@info tag=i_d04 text="シャルティーナのオナニー履歴を更新しました！"				subtag=_3	eval="scd03h"	withsflag	flag=ona_d3
@info tag=i_d04 text="シャルティーナのオナニー履歴を更新しました！"		onakeep		subtag=_4	eval="scd04h"	withsflag	flag=ona_d4
@info tag=i_d04 text="シャルティーナのオナニー履歴を更新しました！"				subtag=_5	eval="scd05h"	withsflag	flag=ona_d5
@info tag=i_d04 text="シャルティーナのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="scd20h"	withsflag	flag=ona_d_oya
@info tag=i_d04 text="シャルティーナのオナニー履歴を更新しました！"		onakeep		subtag=_ex30	eval="scd30h"	withsflag	flag=ona_d_ex30
;
@info tag=i_e04 text="キュンキュンのオナニー履歴を更新しました！"				subtag=_1	eval="sce01h"	withsflag	flag=ona_e1
@info tag=i_e04 text="キュンキュンのオナニー履歴を更新しました！"				subtag=_2	eval="sce02h"	withsflag	flag=ona_e2
@info tag=i_e04 text="キュンキュンのオナニー履歴を更新しました！"				subtag=_3	eval="sce03h"	withsflag	flag=ona_e3
@info tag=i_e04 text="キュンキュンのオナニー履歴を更新しました！"		onakeep		subtag=_4	eval="sce04h"	withsflag	flag=ona_e4
@info tag=i_e04 text="キュンキュンのオナニー履歴を更新しました！"				subtag=_5	eval="sce05h"	withsflag	flag=ona_e5
@info tag=i_e04 text="キュンキュンのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="sce20h"	withsflag	flag=ona_e_oya
@info tag=i_e04 text="キュンキュンのオナニー履歴を更新しました！"		onakeep		subtag=_ex30	eval="sce30h"	withsflag	flag=ona_e_ex30
;
@info tag=i_f04 text="エルゼのオナニー履歴を更新しました！"				subtag=_1	eval="scf01h"	withsflag	flag=ona_f1
@info tag=i_f04 text="エルゼのオナニー履歴を更新しました！"				subtag=_2	eval="scf02h"	withsflag	flag=ona_f2
@info tag=i_f04 text="エルゼのオナニー履歴を更新しました！"				subtag=_3	eval="scf03h"	withsflag	flag=ona_f3
@info tag=i_f04 text="エルゼのオナニー履歴を更新しました！"				subtag=_4	eval="scf04h"	withsflag	flag=ona_f4
@info tag=i_f04 text="エルゼのオナニー履歴を更新しました！"		onakeep		subtag=_5	eval="scf05h"	withsflag	flag=ona_f5
@info tag=i_f04 text="エルゼのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="scf20h"	withsflag	flag=ona_f_oya
@info tag=i_f04 text="エルゼのオナニー履歴を更新しました！"		onakeep		subtag=_ex30	eval="scf30h"	withsflag	flag=ona_f_ex30
;
@info tag=i_g04 text="セレスティアのオナニー履歴を更新しました！"					subtag=_1	eval="scg01h"	withsflag	flag=ona_g1
@info tag=i_g04 text="セレスティアのオナニー履歴を更新しました！"					subtag=_2	eval="scg02h"	withsflag	flag=ona_g2
@info tag=i_g04 text="セレスティアのオナニー履歴を更新しました！"			onakeep		subtag=_3	eval="scg03h"	withsflag	flag=ona_g3
@info tag=i_g04 text="セレスティアのオナニー履歴を更新しました！"					subtag=_4	eval="scg04h"	withsflag	flag=ona_g4
@info tag=i_g04 text="セレスティアのオナニー履歴を更新しました！"					subtag=_5	eval="scg05h"	withsflag	flag=ona_g5
@info tag=i_g04 text="セレスティアのオナニー履歴を更新しました！"			onakeep		subtag=_oya	eval="scg20h"	withsflag	flag=ona_g_oya
@info tag=i_g04 text="セレスティアのオナニー履歴を更新しました！"			onakeep		subtag=_ex30	eval="scg30h"	withsflag	flag=ona_g_ex30
;
@info tag=i_h04 text="ロザリナのオナニー履歴を更新しました！"				subtag=_1	eval="sch01h"	withsflag	flag=ona_h1
@info tag=i_h04 text="ロザリナのオナニー履歴を更新しました！"				subtag=_2	eval="sch02h"	withsflag	flag=ona_h2
@info tag=i_h04 text="ロザリナのオナニー履歴を更新しました！"		onakeep		subtag=_3	eval="sch03h"	withsflag	flag=ona_h3
@info tag=i_h04 text="ロザリナのオナニー履歴を更新しました！"				subtag=_4	eval="sch04h"	withsflag	flag=ona_h4
@info tag=i_h04 text="ロザリナのオナニー履歴を更新しました！"				subtag=_5	eval="sch05h"	withsflag	flag=ona_h5
@info tag=i_h04 text="ロザリナのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="sch20h"	withsflag	flag=ona_h_oya
@info tag=i_h04 text="ロザリナのオナニー履歴を更新しました！"		onakeep		subtag=_ex30	eval="sch30h"	withsflag	flag=ona_h_ex30
;
@info tag=i_i04 text="ソフィアのオナニー履歴を更新しました！"				subtag=_1	eval="sci01h"	withsflag	flag=ona_i1
@info tag=i_i04 text="ソフィアのオナニー履歴を更新しました！"		onakeep		subtag=_2	eval="sci02h"	withsflag	flag=ona_i2
@info tag=i_i04 text="ソフィアのオナニー履歴を更新しました！"				subtag=_3	eval="sci03h"	withsflag	flag=ona_i3
@info tag=i_i04 text="ソフィアのオナニー履歴を更新しました！"				subtag=_4	eval="sci04h"	withsflag	flag=ona_i4
@info tag=i_i04 text="ソフィアのオナニー履歴を更新しました！"				subtag=_5	eval="sci05h"	withsflag	flag=ona_i5
@info tag=i_i04 text="ソフィアのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="sci20h"	withsflag	flag=ona_i_oya
@info tag=i_i04 text="ソフィアのオナニー履歴を更新しました！"		onakeep		subtag=_ex30	eval="sci30h"	withsflag	flag=ona_i_ex30
;
@info tag=i_j04 text="ファムのオナニー履歴を更新しました！"				subtag=_1	eval="scj01h"	withsflag	flag=ona_j1
@info tag=i_j04 text="ファムのオナニー履歴を更新しました！"				subtag=_2	eval="scj02h"	withsflag	flag=ona_j2
@info tag=i_j04 text="ファムのオナニー履歴を更新しました！"		onakeep		subtag=_3	eval="scj03h"	withsflag	flag=ona_j3
@info tag=i_j04 text="ファムのオナニー履歴を更新しました！"				subtag=_4	eval="scj04h"	withsflag	flag=ona_j4
@info tag=i_j04 text="ファムのオナニー履歴を更新しました！"				subtag=_5	eval="scj05h"	withsflag	flag=ona_j5
@info tag=i_j04 text="ファムのオナニー履歴を更新しました！"		onakeep		subtag=_oya	eval="scj20h"	withsflag	flag=ona_j_oya
@info tag=i_j04 text="ファムのオナニー履歴を更新しました！"		onakeep		subtag=_ex30	eval="scj30h"	withsflag	flag=ona_j_ex30
;
@info tag=i_a05 text="魔恋シナリオを完全攻略しました！"							eval="sca05h"
@info tag=i_b05 text="キャルルシナリオを完全攻略しました！"						eval="scb05h"
@info tag=i_c05 text="鷹美シナリオを完全攻略しました！"							eval="scc05h"
@info tag=i_d05 text="シャルティーナシナリオを完全攻略しました！"					eval="scd05h"
@info tag=i_e05 text="キュンキュンシナリオを完全攻略しました！"						eval="sce05h"
@info tag=i_f05 text="エルゼシナリオを完全攻略しました！"						eval="scf05h"
@info tag=i_g05 text="セレスティアシナリオを完全攻略しました！"						eval="scg05h"
@info tag=i_h05 text="ロザリナシナリオを完全攻略しました！"						eval="sch05h"
@info tag=i_i05 text="ソフィアシナリオを完全攻略しました！"						eval="sci05h"
@info tag=i_j05 text="ファムシナリオを完全攻略しました！"						eval="scj05h"
;
@info tag=i_s01 text="「孕ませ！ハーレムエンド！」条件を満たしました！"			flag=end_2	エンド条件：ハーレム
@info tag=i_s02 text="「おっぱい母親！孕ませ！ハーレムエンド！」条件を満たしました！"	flag=end_1	エンド条件：母親ハーレム
@info tag=i_a06 text="『魔恋エンディング』の条件を満たしました！"			flag=end_a	エンド条件：魔恋
@info tag=i_s03 text="CGが100％になりました！"						sflag		eval=".sf.cg_complete"
;
@info tag=i_s05 text="「エンディング選択肢」にいけるようになりました！"			flag=ending	eval="end_1 || end_2 || end_a"
@info tag=i_s06 text="「ステージスキップボタン」が使えるようになりました！"		flag=chaptskip	eval="end_1 || end_2 || end_a"
;@info tag=i_s99 text="これ以降のステージはありません！\nエンディング選択でゲームをクリアしてください！"	eval="現在のステージ==13"
@info tag=i_s99 text="これ以降のステージはありません！\nエンディング選択でゲームをクリアしてください！"	eval="sca05h && scb05h && scc05h && scd05h && sce05h && scf05h && scg05h && sch05h && sci05h && scj05h"
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
@page_branch page="ex30"
@page_branch page="oyako"
@page_branch page="multi"
@page_branch page="ending"
;@page_branch page="ending12"
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
@button page=main name=to_sub         comment="サブキャラ選択画面"	to=sub		badge="sub_k1:sub_k2:sub_l1:sub_l2:sub_m1:sub_m2:sub_n1:sub_n2:sub_o:sub_p:sub_q:sub_r:sub_s1:sub_s2:sub_t"
@button page=main name=to_oyako       comment="親子丼選択画面"		to=oyako	badge="oya_a:oya_b:oya_c:oya_d:oya_e:oya_f:oya_g:oya_h:oya_i:oya_j"
@button page=main name=to_ex30   comment="おっぱいピックアップ選択画面"	to=ex30	badge="ex30_a:ex30_b:ex30_c:ex30_d:ex30_e:ex30_f:ex30_g:ex30_h:ex30_i:ex30_j"
@button page=main name=to_multi       comment="多人数選択画面"		to=multi	badge="mul_1:mul_2:mul_3:mul_4:mul_5:mul_6:mul_7:mul_8"
@button page=main name=quest_skip     comment="章スキップ"				storage=gameloop.txt target=*nextchapter	eval="chaptskip && 現在のステージ<13" show=chaptskip
;												↓親子丼／おっぱいピックアップのフラグ
@main   page=main name=ch0	to=main2_a	nodisable	攻略状況：魔恋			partcomp="state_oyako:sca20n|state_ex30:sca30n"
@main   page=main name=ch1	to=main2_b	nodisable	攻略状況：キャルル		partcomp="state_oyako:scb20n|state_ex30:scb30n"
@main   page=main name=ch2	to=main2_c	nodisable	攻略状況：鷹美			partcomp="state_oyako:scc20n|state_ex30:scc30n"
@main   page=main name=ch3	to=main2_d	nodisable	攻略状況：シャルティーナ	partcomp="state_oyako:scd20n|state_ex30:scd30n"
@main   page=main name=ch4	to=main2_e	nodisable	攻略状況：キュンキュン		partcomp="state_oyako:sce20n|state_ex30:sce30n"
@main   page=main name=ch5	to=main2_f	nodisable	攻略状況：エルゼ		partcomp="state_oyako:scf20n|state_ex30:scf30n"
@main   page=main name=ch6	to=main2_g	nodisable	攻略状況：セレスティア		partcomp="state_oyako:scg20n|state_ex30:scg30n"
@main   page=main name=ch7	to=main2_h	nodisable	攻略状況：ロザリナ		partcomp="state_oyako:sch20n|state_ex30:sch30n"
@main   page=main name=ch8	to=main2_i	nodisable	攻略状況：ソフィア		partcomp="state_oyako:sci20n|state_ex30:sci30n"
@main   page=main name=ch9	to=main2_j	nodisable	攻略状況：ファム		partcomp="state_oyako:scj20n|state_ex30:scj30n"
;
@prof   page=main name=prof	flag=prof_main	prefix=ch	layers=prof_name:prof_stand
;
@number page=main name=chapter cpref=num flag=現在のステージ
@number page=main name=quest   cpref=num flag=現在のウェーブ
;
@exit
;-------------------------------------------------------------------------------
; メイン各キャラのエピソード選択
*main2_a|
	@screen_main2 page=main2_a target=*goto_main_a 攻略状況：魔恋
*main2_b|
	@screen_main2 page=main2_b target=*goto_main_b 攻略状況：キャルル
*main2_c|
	@screen_main2 page=main2_c target=*goto_main_c 攻略状況：鷹美
*main2_d|
	@screen_main2 page=main2_d target=*goto_main_d 攻略状況：シャルティーナ
*main2_e|
	@screen_main2 page=main2_e target=*goto_main_e 攻略状況：キュンキュン
*main2_f|
	@screen_main2 page=main2_f target=*goto_main_f 攻略状況：エルゼ
*main2_g|
	@screen_main2 page=main2_g target=*goto_main_g 攻略状況：セレスティア
*main2_h|
	@screen_main2 page=main2_h target=*goto_main_h 攻略状況：ロザリナ
*main2_i|
	@screen_main2 page=main2_i target=*goto_main_i 攻略状況：ソフィア
*main2_j|
	@screen_main2 page=main2_j target=*goto_main_j 攻略状況：ファム

;-------------------------------------------------------------------------------
; サブ選択
;
*sub|
@screen page=sub  storage=quest_sub rclick=main
;
@sub    page=sub  name=subch0	サブキャラ：アルヴィネラ１	new="sub_k1"	storage=gameloop.txt target=*goto_sub_k_1
@sub    page=sub  name=subch1	サブキャラ：アルヴィネラ２	new="sub_k2"	storage=gameloop.txt target=*goto_sub_k_2
@sub    page=sub  name=subch2	サブキャラ：フィリス１		new="sub_l1"	storage=gameloop.txt target=*goto_sub_l_1
@sub    page=sub  name=subch3	サブキャラ：フィリス２		new="sub_l2"	storage=gameloop.txt target=*goto_sub_l_2
@sub    page=sub  name=subch4	サブキャラ：アンジェリカ１	new="sub_m1"	storage=gameloop.txt target=*goto_sub_m_1
@sub    page=sub  name=subch5	サブキャラ：アンジェリカ２	new="sub_m2"	storage=gameloop.txt target=*goto_sub_m_2
@sub    page=sub  name=subch6	サブキャラ：リジィ１		new="sub_n1"	storage=gameloop.txt target=*goto_sub_n_1
@sub    page=sub  name=subch7	サブキャラ：リジィ２		new="sub_n2"	storage=gameloop.txt target=*goto_sub_n_2
@sub    page=sub  name=subch8	サブキャラ：リラ		new="sub_o"	storage=gameloop.txt target=*goto_sub_o
@sub    page=sub  name=subch9	サブキャラ：ベルダ		new="sub_p"	storage=gameloop.txt target=*goto_sub_p
@sub    page=sub  name=subch10	サブキャラ：マロン		new="sub_q"	storage=gameloop.txt target=*goto_sub_q
@sub    page=sub  name=subch11	サブキャラ：シトラ		new="sub_r"	storage=gameloop.txt target=*goto_sub_r
@sub    page=sub  name=subch12	サブキャラ：ハピネス１		new="sub_s1"	storage=gameloop.txt target=*goto_sub_s_1
@sub    page=sub  name=subch13	サブキャラ：ハピネス２		new="sub_s2"	storage=gameloop.txt target=*goto_sub_s_2
@sub    page=sub  name=subch14	サブキャラ：ラグジュアル	new="sub_t"	storage=gameloop.txt target=*goto_sub_t
;
@prof   page=sub  name=prof	flag=prof_sub	prefix=subch	layers=prof_text:prof_name:prof_stand:prof_base	order="k1:k2:l1:l2:m1:m2:n1:n2:o:p:q:r:s1:s2:t"
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
@oyako page=oyako name=oyako0	comment="魔恋＆魔美"			withnew eval="oya_a"	storage=gameloop.txt target=*goto_oyako_a
@oyako page=oyako name=oyako1	comment="キャルル＆ベルディア"		withnew eval="oya_b"	storage=gameloop.txt target=*goto_oyako_b
@oyako page=oyako name=oyako2	comment="鷹美＆麗子"			withnew eval="oya_c"	storage=gameloop.txt target=*goto_oyako_c
@oyako page=oyako name=oyako3	comment="シャルティーナ＆ライラ"	withnew eval="oya_d"	storage=gameloop.txt target=*goto_oyako_d
@oyako page=oyako name=oyako4	comment="キュンキュン＆アンアン"	withnew eval="oya_e"	storage=gameloop.txt target=*goto_oyako_e
@oyako page=oyako name=oyako5	comment="エルゼ＆ファビオラ"		withnew eval="oya_f"	storage=gameloop.txt target=*goto_oyako_f
@oyako page=oyako name=oyako6	comment="セレスティア＆ベルナデット"	withnew eval="oya_g"	storage=gameloop.txt target=*goto_oyako_g
@oyako page=oyako name=oyako7	comment="ロザリナ＆イザベル"		withnew eval="oya_h"	storage=gameloop.txt target=*goto_oyako_h
@oyako page=oyako name=oyako8	comment="ソフィア＆ラナエステ"		withnew eval="oya_i"	storage=gameloop.txt target=*goto_oyako_i
@oyako page=oyako name=oyako9	comment="ファム＆ルシア"		withnew eval="oya_j"	storage=gameloop.txt target=*goto_oyako_j
;
@button page=oyako name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; おっぱいピックアップ選択
;
*ex30|
@screen page=ex30 storage=quest_ex30 rclick=main
;
@ex30 page=ex30 name=ex30_0	comment="魔恋"			withnew eval="ex30_a"	storage=gameloop.txt target=*goto_ex30_a
@ex30 page=ex30 name=ex30_1	comment="キャルル"		withnew eval="ex30_b"	storage=gameloop.txt target=*goto_ex30_b
@ex30 page=ex30 name=ex30_2	comment="鷹美"			withnew eval="ex30_c"	storage=gameloop.txt target=*goto_ex30_c
@ex30 page=ex30 name=ex30_3	comment="シャルティーナ"	withnew eval="ex30_d"	storage=gameloop.txt target=*goto_ex30_d
@ex30 page=ex30 name=ex30_4	comment="キュンキュン"		withnew eval="ex30_e"	storage=gameloop.txt target=*goto_ex30_e
@ex30 page=ex30 name=ex30_5	comment="エルゼ"		withnew eval="ex30_f"	storage=gameloop.txt target=*goto_ex30_f
@ex30 page=ex30 name=ex30_6	comment="セレスティア"		withnew eval="ex30_g"	storage=gameloop.txt target=*goto_ex30_g
@ex30 page=ex30 name=ex30_7	comment="ロザリナ"		withnew eval="ex30_h"	storage=gameloop.txt target=*goto_ex30_h
@ex30 page=ex30 name=ex30_8	comment="ソフィア"		withnew eval="ex30_i"	storage=gameloop.txt target=*goto_ex30_i
@ex30 page=ex30 name=ex30_9	comment="ファム"		withnew eval="ex30_j"	storage=gameloop.txt target=*goto_ex30_j
;
@button page=ex30 name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; 多人数選択
;
*multi|
@screen page=multi storage=quest_multi rclick=main
;
@layer page=multi name=fullhdanim comment="アニメーションお知らせ通知"	        eval="mul_4"
;
@multi page=multi name=multi0	comment="ドスケベ学園祭 １年生"		withnew eval="mul_1"	storage=gameloop.txt target=*goto_multi_1
@multi page=multi name=multi1	comment="ドスケベ学園祭 ２年生"		withnew eval="mul_2"	storage=gameloop.txt target=*goto_multi_2
@multi page=multi name=multi2	comment="ドスケベ学園祭 ３年生"		withnew eval="mul_3"	storage=gameloop.txt target=*goto_multi_3
@multi page=multi name=multi3	comment="全員Zカップ母乳風呂"		withnew eval="mul_4"	storage=gameloop.txt target=*goto_multi_4
@multi page=multi name=multi4	comment="人妻トリプルパイズリ"		withnew eval="mul_5"	storage=gameloop.txt target=*goto_multi_5
@multi page=multi name=multi5	comment="ミス母親コンテスト"		withnew eval="mul_6"	storage=gameloop.txt target=*goto_multi_6
@multi page=multi name=multi6	comment="ドスケベ身体測定"		withnew eval="mul_7"	storage=gameloop.txt target=*goto_multi_7
@multi page=multi name=multi7	comment="緊急ドスケベクエスト"		withnew eval="mul_8"	storage=gameloop.txt target=*goto_multi_8
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
@layer  page=ending name=end0_new eval="end_a && !.sf.sca50h"
@layer  page=ending name=end1_new eval="end_1 && !.sf.sced01h"
@layer  page=ending name=end2_new eval="end_2 && !.sf.sced02h"
;
@ending page=ending name=end0	comment="魔恋と子作り温泉旅行"				eval="end_a"	storage=gameloop.txt target=*goto_end_a continue
@ending page=ending name=end1	comment="おっぱい母親！孕ませ！ハーレムエンド！"	eval="end_1"	storage=gameloop.txt target=*goto_end_1 continue
@ending page=ending name=end2	comment="孕ませ！ハーレムエンド！"			eval="end_2"	storage=gameloop.txt target=*goto_end_2 continue
;
@button page=ending name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; エンディング選択sc12通過版
;
;*ending12|
;@screen page=ending12 storage=ending_select rclick=""
;
;@ending page=ending12 name=end0	comment="魔恋と子作り温泉旅行"				eval="end_a"	storage=gameloop.txt target=*goto_end_a
;@ending page=ending12 name=end1	comment="おっぱい母親！孕ませ！ハーレムエンド！"	eval="end_1"	storage=gameloop.txt target=*goto_end_1
;@ending page=ending12 name=end2	comment="孕ませ！ハーレムエンド！"			eval="end_2"	storage=gameloop.txt target=*goto_end_2
;
;@exit
;-------------------------------------------------------------------------------
; ステータス画面
;
*status|
@screen page=status storage=status click=main rclick=main nomenu
;
@status page=status	name=ch0	攻略状況：魔恋
@status page=status	name=ch1	攻略状況：キャルル
@status page=status	name=ch2	攻略状況：鷹美
@status page=status	name=ch3	攻略状況：シャルティーナ
@status page=status	name=ch4	攻略状況：キュンキュン
@status page=status	name=ch5	攻略状況：エルゼ
@status page=status	name=ch6	攻略状況：セレスティア
@status page=status	name=ch7	攻略状況：ロザリナ
@status page=status	name=ch8	攻略状況：ソフィア
@status page=status	name=ch9	攻略状況：ファム
;
@complete page=status	name=harem	eval=".sf.sced02h"
@complete page=status	name=hmase	eval=".sf.sced01h"
@complete page=status	name=mako	eval=".sf.sca50h"
@number   page=status	name=cgcomp	flag=".sf.cg_ratio" keta=3 cpref=num
@text     page=status	name=player	flag="name"
;
@button page=status name=back to=main
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
@button page=status_main name=ch0	withsubtext profile=0	toggle	comment="a:魔恋"
@button page=status_main name=ch1	withsubtext profile=1	toggle	comment="b:キャルル"
@button page=status_main name=ch2	withsubtext profile=2	toggle	comment="c:鷹美"
@button page=status_main name=ch3	withsubtext profile=3	toggle	comment="d:シャルティーナ"
@button page=status_main name=ch4	withsubtext profile=4	toggle	comment="e:キュンキュン"
@button page=status_main name=ch5	withsubtext profile=5	toggle	comment="f:エルゼ"
@button page=status_main name=ch6	withsubtext profile=6	toggle	comment="g:セレスティア"
@button page=status_main name=ch7	withsubtext profile=7	toggle	comment="h:ロザリナ"
@button page=status_main name=ch8	withsubtext profile=8	toggle	comment="i:ソフィア"
@button page=status_main name=ch9	withsubtext profile=9	toggle	comment="j:ファム"
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
@button page=status_main name=dress6	dress=6
@button page=status_main name=dress7	dress=7
;
;
;※ズーム時は立ち絵を使うのでキャラ名と服装定義が必要（profile=番号 name=キャラ dresslist="服装1:服装2:..."） 服装の順番は画面UIの並びに従うこと / profileは↑のprofile定義に合わせること
@chzoom page=status_main profile=0 name="魔恋"			dresslist="制服:サキュバス:水着:裸:裸・淫紋:現世制服"
@chzoom page=status_main profile=1 name="キャルル"		dresslist="制服:サキュバス:水着:裸:裸・淫紋:部活"
@chzoom page=status_main profile=2 name="鷹美"			dresslist="制服:サキュバス:水着:裸:裸・淫紋"
@chzoom page=status_main profile=3 name="シャルティーナ"	dresslist="制服:サキュバス:水着:裸:裸・淫紋:部活"
@chzoom page=status_main profile=4 name="キュンキュン"		dresslist="制服:サキュバス:水着:裸:裸・淫紋:部活"
@chzoom page=status_main profile=5 name="エルゼ"		dresslist="制服:サキュバス:水着:裸:裸・淫紋:部活"
@chzoom page=status_main profile=6 name="セレスティア"		dresslist="制服:サキュバス:水着:裸:裸・淫紋:部活"
@chzoom page=status_main profile=7 name="ロザリナ"		dresslist="制服:サキュバス:水着:裸:裸・淫紋:部活"
@chzoom page=status_main profile=8 name="ソフィア"		dresslist="制服:サキュバス:水着:裸:裸・淫紋:制服・ぬいぐるみ:サキュバス・ぬいぐるみ"
@chzoom page=status_main profile=9 name="ファム"		dresslist="制服:サキュバス:水着:裸:裸・淫紋:制服・包帯:サキュバス・包帯:サキュバス2"
@button page=status_main name=zoom chzoom
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
@button page=status_sub name=subch0	profile=0	toggle	comment="k:アルヴィネラ"
@button page=status_sub name=subch1	profile=1	toggle	comment="l:フィリス"
@button page=status_sub name=subch2	profile=2	toggle	comment="m:アンジェリカ"
@button page=status_sub name=subch3	profile=3	toggle	comment="n:リジィ"
@button page=status_sub name=subch4	profile=4	toggle	comment="o:リラ"
@button page=status_sub name=subch5	profile=5	toggle	comment="p:ベルダ"
@button page=status_sub name=subch6	profile=6	toggle	comment="q:マロン"
@button page=status_sub name=subch7	profile=7	toggle	comment="r:シトラ"
@button page=status_sub name=subch8	profile=8	toggle	comment="s:ハピネス"
@button page=status_sub name=subch9	profile=9	toggle	comment="t:ラグジュアル"
;
@prof   page=status_sub name=prof	flag=status_sub		prefix="subch"	layers=prof_stand:prof_name radio dress
@button page=status_sub name=dress0	dress=0
@button page=status_sub name=dress1	dress=1
@button page=status_sub name=dress2	dress=2
@button page=status_sub name=dress3	dress=3
;
;※ズーム時は立ち絵を使うのでキャラ名と服装定義が必要（profile=番号 name=キャラ dresslist="服装1:服装2@表情:..."）
@chzoom page=status_sub profile=0 name="アルヴィネラ"		dresslist="サキュバス:水着:裸:裸・淫紋"
@chzoom page=status_sub profile=1 name="フィリス"		dresslist="サキュバス:水着:裸:裸・淫紋"
@chzoom page=status_sub profile=2 name="アンジェリカ"		dresslist="本体:悪魔@キラキラ"
@chzoom page=status_sub profile=3 name="リジィ"			dresslist="本体"
@chzoom page=status_sub profile=4 name="リラ"			dresslist="本体"
@chzoom page=status_sub profile=5 name="ベルダ"			dresslist="本体"
@chzoom page=status_sub profile=6 name="マロン"			dresslist="本体"
@chzoom page=status_sub profile=7 name="シトラ"			dresslist="本体"
@chzoom page=status_sub profile=8 name="ハピネス"		dresslist="本体"
@chzoom page=status_sub profile=9 name="ラグジュアル"		dresslist="本体"
@button page=status_sub name=zoom	chzoom
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

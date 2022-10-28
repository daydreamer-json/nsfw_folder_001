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
;-------------------------------------------------------------------------------
; メインキャラ攻略状況条件
;
@pmacro name="攻略状況：英玲奈"			comment="英玲奈"	point="sc_a01h:sc_a02h:sc_a03h:sc_a04h:sc_a05h"
@pmacro name="攻略状況：オルガ"			comment="オルガ"	point="sc_b01h:sc_b02h:sc_b03h:sc_b04h:sc_b05h"
@pmacro name="攻略状況：フィー"			comment="フィー"	point="sc_c01h:sc_c02h:sc_c03h:sc_c04h:sc_c05h"
@pmacro name="攻略状況：リディア"		comment="リディア"	point="sc_d01h:sc_d02h:sc_d03h:sc_d04h:sc_d05h:sc_d06h"
@pmacro name="攻略状況：カシュニア"		comment="カシュニア"	point="sc_e01h:sc_e02h:sc_e03h:sc_e04h:sc_e05h"
@pmacro name="攻略状況：ナオミン"		comment="ナオミン"	point="sc_f01h:sc_f02h:sc_f03h:sc_f04h:sc_f05h"
@pmacro name="攻略状況：カトレーヌ"		comment="カトレーヌ"	point="sc_g01h:sc_g02h:sc_g03h:sc_g04h"
@pmacro name="攻略状況：ミャウ"			comment="ミャウ"	point="sc_h01h:sc_h02h:sc_h03h:sc_h04h"
@pmacro name="攻略状況：かぐや"			comment="かぐや"	point="sc_i01h:sc_i02h:sc_i03h:sc_i04h"
@pmacro name="攻略状況：みぞれ"			comment="みぞれ"	point="sc_j01h:sc_j02h:sc_j03h:sc_j04h:sc_j05h"
;
;-------------------------------------------------------------------------------
; エンド条件
;
@pmacro name="エンド条件：ハーレム"		eval="sc_a01h && sc_b01h && sc_c02h && sc_d01h && sc_e01h && sc_f01h && sc_g01h && sc_h01h && sc_i01h && sc_j01h"
@pmacro name="エンド条件：孕ませ"		eval="sc_a05h && sc_b05h && sc_c05h && sc_d06h && sc_e05h && sc_f05h && sc_g04h && sc_h04h && sc_i04h && sc_j05h"
@pmacro name="エンド条件：英玲奈"    eval="sc_a05h && sc_a20h && sc_b01h && sc_c02h && sc_d01h && sc_e01h && sc_f01h && sc_g01h && sc_h01h && sc_i01h && sc_j01h"
;
;-------------------------------------------------------------------------------
; サブキャラ枠オープン条件
;
@pmacro name="サブキャラ：エレン"		comment="エレン"		eval="sc_01"	point="sc_k01h"
@pmacro name="サブキャラ：サラ１"		comment="サラ１"		eval="sc_03"	point="sc_l01h:sc_l02h"
@pmacro name="サブキャラ：サラ２"		comment="サラ２"		eval="sc_l01h"	point="sc_l01h:sc_l02h"
@pmacro name="サブキャラ：ルミア１"		comment="ルミア１"		eval="sc_05"	point="sc_m01h:sc_m02h"
@pmacro name="サブキャラ：ルミア２"		comment="ルミア２"		eval="sc_m01h"	point="sc_m01h:sc_m02h"
@pmacro name="サブキャラ：ジルダ"		comment="ジルダ"		eval="sc_06"	point="sc_n01h"
@pmacro name="サブキャラ：マリィ"		comment="マリィ"		eval="sc_07"	point="sc_o01h"
@pmacro name="サブキャラ：セリカ１"		comment="セリカ１"		eval="sc_f03h"	point="sc_p01h:sc_p02h"
@pmacro name="サブキャラ：セリカ２"		comment="セリカ２"		eval="sc_p01h"	point="sc_p01h:sc_p02h"
@pmacro name="サブキャラ：ミルファ１"		comment="ミルファ１"		eval="sc_g03h"	point="sc_q01h:sc_q02h"
@pmacro name="サブキャラ：ミルファ２"		comment="ミルファ２"		eval="sc_q01h"	point="sc_q01h:sc_q02h"
@pmacro name="サブキャラ：システィーネ１"	comment="システィーネ１"	eval="sc_02"	point="sc_r01h:sc_r02h"
@pmacro name="サブキャラ：システィーネ２"	comment="システィーネ２"	eval="sc_r01h"	point="sc_r01h:sc_r02h"
@pmacro name="サブキャラ：アサミ"		comment="アサミ"		eval="sc_08"	point="sc_s01h"
@pmacro name="サブキャラ：ティアナ"		comment="ティアナ"		eval="sc_09"	point="sc_t01h"
;
;-------------------------------------------------------------------------------
; 親子丼枠オープン条件
;
@pmacro name="親子丼：英玲奈"			eval="sc_a02h"
@pmacro name="親子丼：オルガ"			eval="sc_b01h"
@pmacro name="親子丼：フィー"			eval="sc_c04h"
@pmacro name="親子丼：リディア"			eval="sc_d04h"
@pmacro name="親子丼：カシュニア"		eval="sc_x03h"
@pmacro name="親子丼：ナオミン"			eval="sc_f02h"
@pmacro name="親子丼：カトレーヌ"		eval="sc_g03h"
@pmacro name="親子丼：ミャウ"			eval="sc_h03h"
@pmacro name="親子丼：かぐや"			eval="sc_i02h"
@pmacro name="親子丼：みぞれ"			eval="sc_j04h"
;
;-------------------------------------------------------------------------------
; 多人数枠オープン条件
;
@pmacro name="多人数：テニス"			eval="sc_f20h"
@pmacro name="多人数：メイド"			eval="sc_c03h && sc_f03h && sc_h02h"
@pmacro name="多人数：運動会"			eval="sc_x03h"
@pmacro name="多人数：露天風呂"			eval="sc_x11h"
@pmacro name="多人数：ツイスタ"			eval="sc_x14h"
;
;-------------------------------------------------------------------------------
;※ステータス画面ではインフォーメーションは不要
@jump target=*status cond="page=='status'"
;-------------------------------------------------------------------------------
; インフォーメーション表示条件一覧
;
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=k		flag=sub_k	サブキャラ：エレン
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=l1		flag=sub_l1	サブキャラ：サラ１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=l2		flag=sub_l2	サブキャラ：サラ２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=m1		flag=sub_m1	サブキャラ：ルミア１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=m2		flag=sub_m2	サブキャラ：ルミア２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=n		flag=sub_n	サブキャラ：ジルダ
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=o		flag=sub_o	サブキャラ：マリィ
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=p1		flag=sub_p1	サブキャラ：セリカ１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=p2		flag=sub_p2	サブキャラ：セリカ２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=q1		flag=sub_q1	サブキャラ：ミルファ１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=q2		flag=sub_q2	サブキャラ：ミルファ２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=r1		flag=sub_r1	サブキャラ：システィーネ１
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=r2		flag=sub_r2	サブキャラ：システィーネ２
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=s		flag=sub_s	サブキャラ：アサミ
@info tag=i_s04 text="「サブキャラシナリオ」が追加更新されました！" subtag=t		flag=sub_t	サブキャラ：ティアナ
;
@info tag=i_x01 text="『人妻エルフテニス倶楽部』が多人数エロページに追加！"		flag=mul_1	多人数：テニス
@info tag=i_x02 text="『異世界メイドトリプルパイズリ』が多人数エロページに追加！"	flag=mul_2	多人数：メイド
@info tag=i_x03 text="『母親対抗パイズリレー』が多人数エロページに追加！"		flag=mul_3	多人数：運動会
@info tag=i_x04 text="『母乳露天風呂』が多人数エロページに追加！"			flag=mul_4	多人数：露天風呂
@info tag=i_x05 text="『孕ませトゥイスターゲーム』が多人数エロページに追加！"		flag=mul_5	多人数：ツイスタ
;
@info tag=i_a01 text="ハーレムエンド条件（英玲奈）を満たしました！"					eval="sc_a01h"
@info tag=i_b01 text="ハーレムエンド条件（オルガ）を満たしました！"					eval="sc_b01h"
@info tag=i_c01 text="ハーレムエンド条件（フィー）を満たしました！"					eval="sc_c02h"
@info tag=i_d01 text="ハーレムエンド条件（リディア）を満たしました！"					eval="sc_d01h"
@info tag=i_e01 text="ハーレムエンド条件（カシュニア）を満たしました！"					eval="sc_e01h"
@info tag=i_f01 text="ハーレムエンド条件（ナオミン）を満たしました！"					eval="sc_f01h"
@info tag=i_g01 text="ハーレムエンド条件（カトレーヌ）を満たしました！"					eval="sc_g01h"
@info tag=i_h01 text="ハーレムエンド条件（ミャウ）を満たしました！"					eval="sc_h01h"
@info tag=i_i01 text="ハーレムエンド条件（かぐや）を満たしました！"					eval="sc_i01h"
@info tag=i_j01 text="ハーレムエンド条件（みぞれ）を満たしました！"					eval="sc_j01h"
;													↑※「エンド条件：ハーレム」の個々のシナリオ通過フラグであることに注意
;
@info tag=i_a02 text="英玲奈の親子丼シナリオが親子丼ページに追加されました！"		flag=oya_a	親子丼：英玲奈
@info tag=i_b02 text="オルガの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_b	親子丼：オルガ
@info tag=i_c02 text="フィーの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_c	親子丼：フィー
@info tag=i_d02 text="リディアの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_d	親子丼：リディア
@info tag=i_e02 text="カシュニアの親子丼シナリオが親子丼ページに追加されました！"	flag=oya_e	親子丼：カシュニア
@info tag=i_f02 text="ナオミンの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_f	親子丼：ナオミン
@info tag=i_g02 text="カトレーヌの親子丼シナリオが親子丼ページに追加されました！"	flag=oya_g	親子丼：カトレーヌ
@info tag=i_h02 text="ミャウの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_h	親子丼：ミャウ
@info tag=i_i02 text="かぐやの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_i	親子丼：かぐや
@info tag=i_j02 text="みぞれの親子丼シナリオが親子丼ページに追加されました！"		flag=oya_j	親子丼：みぞれ
;
@info tag=i_a03 text="英玲奈シナリオを完全攻略しました！"						eval="sc_a05h"
@info tag=i_b03 text="オルガシナリオを完全攻略しました！"						eval="sc_b05h"
@info tag=i_c03 text="フィーシナリオを完全攻略しました！"						eval="sc_c05h"
@info tag=i_d03 text="リディアシナリオを完全攻略しました！"						eval="sc_d06h"
@info tag=i_e03 text="カシュニアシナリオを完全攻略しました！"						eval="sc_e05h"
@info tag=i_f03 text="ナオミンシナリオを完全攻略しました！"						eval="sc_f05h"
@info tag=i_g03 text="カトレーヌシナリオを完全攻略しました！"						eval="sc_g04h"
@info tag=i_h03 text="ミャウシナリオを完全攻略しました！"						eval="sc_h04h"
@info tag=i_i03 text="かぐやシナリオを完全攻略しました！"						eval="sc_i04h"
@info tag=i_j03 text="みぞれシナリオを完全攻略しました！"						eval="sc_j05h"
;													↑※「エンド条件：孕ませ」の個々のシナリオ通過フラグであること？
;
@info tag=i_s01 text="「ハーレムエンディング」条件を満たしました！"			flag=end_1	エンド条件：ハーレム
@info tag=i_s02 text="「孕ませエンディング」条件を満たしました！"			flag=end_2	エンド条件：孕ませ
@info tag=i_a04 text="『英玲奈エンディング』の条件を満たしました！"			flag=end_a	エンド条件：英玲奈
@info tag=i_s03 text="CGが100％になりました！"						sflag		eval=".sf.cg_complete"
;
@info tag=i_s05 text="「エンディング選択肢」にいけるようになりました！"			flag=ending	エンド条件：ハーレム
@info tag=i_s06 text="「章スキップボタン」が使えるようになりました！"			flag=chaptskip	eval="sc_13"
;
;-------------------------------------------------------------------------------
;※各ページの設定へジャンプ
@jump target=*main   cond="page=='main'"
@jump target=*sub    cond="page=='sub'"
@jump target=*oyako  cond="page=='oyako'"
@jump target=*multi  cond="page=='multi'"
@jump target=*ending cond="page=='ending'"
@jump target=*ending14 cond="page=='ending14'"
@error message=&"不明なページです:"+page
;-------------------------------------------------------------------------------
; メイン選択
;
*main|
@screen page=main storage=quest_main rclick=""
;
@button page=main name=to_status comment="主人公プロフィール"	to=status
@button page=main name=to_endsel comment="エンディング選択画面"	to=ending	eval="ending" dshide
@button page=main name=to_sub    comment="サブキャラ選択画面"	to=sub		badge="sub_k:sub_l1:sub_l2:sub_m1:sub_m2:sub_n:sub_o:sub_p1:sub_p2:sub_q1:sub_q2:sub_r1:sub_r2:sub_s:sub_t"
@button page=main name=to_oyako  comment="親子丼選択画面"	to=oyako	badge="oya_a:oya_b:oya_c:oya_d:oya_e:oya_f:oya_g:oya_h:oya_i:oya_j"
@button page=main name=to_multi  comment="多人数選択画面"	to=multi	badge="mul_1:mul_2:mul_3:mul_4:mul_5"
@button page=main name=quest_skip comment="章スキップ"				storage=gameloop.txt target=*nextchapter	eval="chaptskip" dshide
;
@main   page=main name=ch0	攻略状況：英玲奈				storage=gameloop.txt target=*goto_main_a
@main   page=main name=ch1	攻略状況：オルガ				storage=gameloop.txt target=*goto_main_b
@main   page=main name=ch2	攻略状況：フィー				storage=gameloop.txt target=*goto_main_c
@main   page=main name=ch3	攻略状況：リディア				storage=gameloop.txt target=*goto_main_d
@main   page=main name=ch4	攻略状況：カシュニア				storage=gameloop.txt target=*goto_main_e
@main   page=main name=ch5	攻略状況：ナオミン				storage=gameloop.txt target=*goto_main_f
@main   page=main name=ch6	攻略状況：カトレーヌ				storage=gameloop.txt target=*goto_main_g
@main   page=main name=ch7	攻略状況：ミャウ				storage=gameloop.txt target=*goto_main_h
@main   page=main name=ch8	攻略状況：かぐや				storage=gameloop.txt target=*goto_main_i
@main   page=main name=ch9	攻略状況：みぞれ				storage=gameloop.txt target=*goto_main_j
;
@prof   page=main name=prof	flag=prof_main	prefix=ch	layers=prof_name:prof_stand	dress
@button page=main name=dress0	dress=0
@button page=main name=dress1	dress=1
@button page=main name=dress2	dress=2
@button page=main name=dress3	dress=3
@button page=main name=dress3c	dress=3
@button page=main name=dress3h	dress=3
@button page=main name=dress4	dress=4
;
@number page=main name=chapter cpref=num flag=現在の章
@number page=main name=quest   cpref=num flag=クエスト選択回数
;
@exit
;-------------------------------------------------------------------------------
; サブ選択
;
*sub|
@screen page=sub  storage=quest_sub rclick=main
;
@sub    page=sub  name=subch0	サブキャラ：エレン		new="sub_k"	storage=gameloop.txt target=*goto_sub_k
@sub    page=sub  name=subch1	サブキャラ：サラ１		new="sub_l1"	storage=gameloop.txt target=*goto_sub_l1
@sub    page=sub  name=subch2	サブキャラ：サラ２		new="sub_l2"	storage=gameloop.txt target=*goto_sub_l2
@sub    page=sub  name=subch3	サブキャラ：ルミア１		new="sub_m1"	storage=gameloop.txt target=*goto_sub_m1
@sub    page=sub  name=subch4	サブキャラ：ルミア２		new="sub_m2"	storage=gameloop.txt target=*goto_sub_m2
@sub    page=sub  name=subch5	サブキャラ：ジルダ		new="sub_n"	storage=gameloop.txt target=*goto_sub_n
@sub    page=sub  name=subch6	サブキャラ：マリィ		new="sub_o"	storage=gameloop.txt target=*goto_sub_o
@sub    page=sub  name=subch7	サブキャラ：セリカ１		new="sub_p1"	storage=gameloop.txt target=*goto_sub_p1
@sub    page=sub  name=subch8	サブキャラ：セリカ２		new="sub_p2"	storage=gameloop.txt target=*goto_sub_p2
@sub    page=sub  name=subch9	サブキャラ：ミルファ１		new="sub_q1"	storage=gameloop.txt target=*goto_sub_q1
@sub    page=sub  name=subch10	サブキャラ：ミルファ２		new="sub_q2"	storage=gameloop.txt target=*goto_sub_q2
@sub    page=sub  name=subch11	サブキャラ：システィーネ１	new="sub_r1"	storage=gameloop.txt target=*goto_sub_r1
@sub    page=sub  name=subch12	サブキャラ：システィーネ２	new="sub_r2"	storage=gameloop.txt target=*goto_sub_r2
@sub    page=sub  name=subch13	サブキャラ：アサミ		new="sub_s"	storage=gameloop.txt target=*goto_sub_s
@sub    page=sub  name=subch14	サブキャラ：ティアナ		new="sub_t"	storage=gameloop.txt target=*goto_sub_t
;
@prof   page=sub  name=prof	flag=prof_sub	prefix=subch	layers=prof_stand:prof_name:prof_text	order="k:l1:l2:m1:m2:n:o:p1:p2:q1:q2:r1:r2:s:t"
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
@oyako page=oyako name=oyako0	comment="英玲奈＆魔美"			withnew eval="oya_a"	storage=gameloop.txt target=*goto_oyako_a
@oyako page=oyako name=oyako1	comment="オルガ＆マリア"		withnew eval="oya_b"	storage=gameloop.txt target=*goto_oyako_b
@oyako page=oyako name=oyako2	comment="フィー＆ルフィーナ"		withnew eval="oya_c"	storage=gameloop.txt target=*goto_oyako_c
@oyako page=oyako name=oyako3	comment="リディア＆リリンダ"		withnew eval="oya_d"	storage=gameloop.txt target=*goto_oyako_d
@oyako page=oyako name=oyako4	comment="カシュニア＆ナスターシャ"	withnew eval="oya_e"	storage=gameloop.txt target=*goto_oyako_e
@oyako page=oyako name=oyako5	comment="ナオミン＆ムンムン"		withnew eval="oya_f"	storage=gameloop.txt target=*goto_oyako_f
@oyako page=oyako name=oyako6	comment="カトレーヌ＆ロレーヌ"		withnew eval="oya_g"	storage=gameloop.txt target=*goto_oyako_g
@oyako page=oyako name=oyako7	comment="ミャウ＆ディーレ"		withnew eval="oya_h"	storage=gameloop.txt target=*goto_oyako_h
@oyako page=oyako name=oyako8	comment="かぐや＆美竹"			withnew eval="oya_i"	storage=gameloop.txt target=*goto_oyako_i
@oyako page=oyako name=oyako9	comment="みぞれ＆深雪"			withnew eval="oya_j"	storage=gameloop.txt target=*goto_oyako_j
;
@button page=oyako name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; 多人数選択
;
*multi|
@screen page=multi storage=quest_multi rclick=main
;
@multi page=multi name=multi0	comment="人妻エルフテニス倶楽部"		withnew eval="mul_1"	storage=gameloop.txt target=*goto_multi_1
@multi page=multi name=multi1	comment="異世界メイド　トリプルパイズリ"	withnew eval="mul_2"	storage=gameloop.txt target=*goto_multi_2
@multi page=multi name=multi2	comment="親子大運動会　母親対抗パイズリレー"	withnew eval="mul_3"	storage=gameloop.txt target=*goto_multi_3
@multi page=multi name=multi3	comment="母乳露天風呂！"			withnew eval="mul_4"	storage=gameloop.txt target=*goto_multi_4
@multi page=multi name=multi4	comment="孕ませトゥイスターゲーム！"		withnew eval="mul_5"	storage=gameloop.txt target=*goto_multi_5
;
@button page=multi name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; エンディング選択
;
*ending|
@screen page=ending storage=ending_select rclick=main
;
@ending page=ending name=end0	comment="異世界おっぱいハーレムエンド！"	eval="end_1"	storage=gameloop.txt target=*goto_end_1
@ending page=ending name=end1	comment="もっと！孕ませ！ハーレムエンド！"	eval="end_2"	storage=gameloop.txt target=*goto_end_2
@ending page=ending name=end2	comment="英玲奈と新婚生活♪"			eval="end_a"	storage=gameloop.txt target=*goto_end_a
;
@button page=ending name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; エンディング選択sc_14通過版
;
*ending14|
@screen page=ending14 storage=ending_select rclick=""
;
@ending page=ending14 name=end0	comment="異世界おっぱいハーレムエンド！"	eval="end_1"	storage=gameloop.txt target=*goto_end_1
@ending page=ending14 name=end1	comment="もっと！孕ませ！ハーレムエンド！"	eval="end_2"	storage=gameloop.txt target=*goto_end_2
@ending page=ending14 name=end2	comment="英玲奈と新婚生活♪"			eval="end_a"	storage=gameloop.txt target=*goto_end_a

;
@exit
;-------------------------------------------------------------------------------
; ステータス画面
;
*status|
@screen page=status storage=status click=main rclick=main nomenu
;
@status page=status	name=ch0	攻略状況：英玲奈
@status page=status	name=ch1	攻略状況：オルガ
@status page=status	name=ch2	攻略状況：フィー
@status page=status	name=ch3	攻略状況：リディア
@status page=status	name=ch4	攻略状況：カシュニア
@status page=status	name=ch5	攻略状況：ナオミン
@status page=status	name=ch6	攻略状況：カトレーヌ
@status page=status	name=ch7	攻略状況：ミャウ
@status page=status	name=ch8	攻略状況：かぐや
@status page=status	name=ch9	攻略状況：みぞれ
;
@complete page=status	name=harem	eval=".sf.sc_xed01"
@complete page=status	name=hmase	eval=".sf.sc_xed02"
@number   page=status	name=cgcomp	flag=".sf.cg_ratio" keta=3 cpref=num
@text     page=status	name=player	flag="name"
;
@exit

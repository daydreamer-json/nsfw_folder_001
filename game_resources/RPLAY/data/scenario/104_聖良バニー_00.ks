; 
; 
*p0|
@eff obj=0 page=back show=true storage=bg_07c_l path=(150,80,255) size=(1.4,1.4) time=1
@bg storage=bg_07c
@bgm storage=bgm_03
@show
[se storage="物_置_グラス_机00"]
*p1|
@nm t="千尋"
「これは中々美味い……」[np]
@hide
@eff_all_delete
@bg storage=bg_07c_l left=-1280 top=-410
@show
@chr_walk way=r st01abb14
*p2|
@nm t="聖良" s=sei_11569
「あれ……。なに飲んでるの、千尋くん？」[np]
@chr st01abb01
*p3|
@nm t="千尋"
「ん？　これは蜂蜜酒だよ。資料用の写真を撮りに[r]
島を回ってた時に酒場で勧められてさ。試しに買ってみたんだ」[np]
@chr st01abb02
@dchr st01abb04 delay=3483
*p4|
@nm t="聖良" s=sei_11570
「へぇ……そんなのも売ってるんだ？[r]
ふふ、ファンタジー世界っぽいね？」[np]
@chr st01abb03
*p5|
@nm t="千尋"
「ああ。お酒なんて普段はあまり飲まないんだけどな。[r]
飲める歳になってすぐ親父にめちゃくちゃ[r]
飲まされて酷い目にあってさ……」[np]
@chr st01bbb05
@dchr st01bbb03 delay=7375
*p6|
@nm t="聖良" s=sei_11571
「ふふ。自分の息子とお酒飲めるようになったのが[r]
嬉しかったんだよ。わたしの家も、そだったから」[np]
@chr st01bbb02
*p7|
@nm t="千尋"
「聖良も酔いつぶされたのか？」[np]
@chr st01bbb03
*p8|
@nm t="聖良" s=sei_11572
「ううん。こう見えてわたし、お酒強いから。[r]
飲んでも飲んでも全然酔わなかった、よ？」[np]
@chr st01bbb05
@dchr st01bbb13 delay=4657
*p9|
@nm t="聖良" s=sei_11573
「といっても日本酒しか飲んだことないんだけど、ね？[r]
でも、あの時は水みたいにゴクゴク飲めちゃった」[np]
@chr st01bbb02
*p10|
@nm t="千尋"
「へぇ……じゃあ、聖良も飲んでみるか？　甘くて美味しいぞ？」[np]
@chr st01bbb05
@dchr st01bbb03 delay=5055
*p11|
@nm t="聖良" s=sei_11574
「うん。せっかくだし少しもらってもいい？[r]
こうして話してると気になってきちゃって」[np]
@hide
@chr_del_walk way=l name=聖良
@wt
@eff obj=0 page=back show=true storage=bg_07c_l path=(150,340,255) size=(1.4,1.4) time=1 absolute=(2000)
@bg storage=bg_07c
@chr_drop st01bab02
@wt
@show
*p12|
@nm t="千尋"
「飲み方はどうする？[r]
度数は低めのものだけど水かソーダで割ろうか？」[np]
@chr st01bab03
@dchr st01bab05 delay=3044
*p13|
@nm t="聖良" s=sei_11575
「千尋くんと一緒でいいよ？[r]
お酒強いって言った、でしょ？」[np]
@chr st01bab04
*p14|
@nm t="千尋"
「そっか、ならまずはストレートだな」[np]
[se storage="グラス_注_酒01"]
@chr st01bab02
*p15|
グラスに蜂蜜酒を注いで手渡す。[np]
@hide
@eff_all_delete
@bg storage=bg_07c
@show
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
[wse buf=0]
@chr_walk way=l st02abb07
@dchr st02abb04 delay=2921
@dchr st02abb08 delay=7767
*p16|
@nm t="莉瑠" s=rir_10211
「……ふぅ、さっぱりしましたぁ。やっぱり広いお風呂は[r]
いいですねぇ。あとは冷たい麦茶を――って！？」[np]
@chr st02abb09
*p17|
@nm t="千尋"
「莉瑠、風呂上がりなのにその格好なんだな」[np]
@chr st02bbb06
@dchr st02bbb10 delay=2213
*p18|
@nm t="莉瑠" s=rir_10212
「んなことどうでもいいんですよ！！[r]
それより聖良に何を飲ませてるんですか！？」[np]
@chr st02bbb07
*p19|
@nm t="千尋"
「蜂蜜酒だけど」[np]
@chr st02bbb12
@dchr st02bbb06 delay=1684
*p20|
@nm t="莉瑠" s=rir_10213
「今すぐとめて下さい。い、いえ、逃げて下さい……！！」[np]
@chr st02bbb11
*p21|
@nm t="千尋"
「え？　逃げろってどういう意味――」[np]
@fobgm time=2000
@hide
@eff obj=0 page=back show=true storage=bg_07c_l path=(150,340,255) size=(1.4,1.4) time=1 absolute=(2000)
@bg storage=bg_07c st01aab05
@show
[se storage="衣擦れ_抱きしめる2_volup" buf=0 delay=0]
@chr st01adb12
*p22|
@nm t="聖良" s=sei_11576
「――ち～ひろきゅんっ！！」[np]
@bgm storage=bgm_07
@chr st01adb05
*p23|
@nm t="千尋"
「おわぁっ！？」[np]
@chr st01bdb13
@dchr_quake name=聖良 sx=6 sy=2 xcnt=4 ycnt=1 time=2600 delay=1347
*p24|
@nm t="聖良" s=sei_11577
「えへへ～、スリスリ～。[r]
だ～いしゅきらよぉ～……？」[np]
@sq
@chr st01bdb04
*p25|
@nm t="千尋"
「ちょっ！？　い、いきなりどうした……！？」[np]
@chr st01bdb10
@dchr st01bdb06 delay=7152
*p26|
@nm t="聖良" s=sei_11578
「む～……。どうしひゃっへヒドーい……。[r]
わたひがだいしゅきっへ言っへりゅのにぃ……」[np]
@chr st01adb12
@dchr st01adb17 delay=7339
*p27|
@nm t="聖良" s=sei_11579
「そーゆう時は、だいしゅきっへ答えりゅものらのよ？[r]
ほーらぁ、いっへ？　いっへよぉ～」[np]
@chr st01adb05
*p28|
チャーミングスタイルセーラもビックリのデレデレ具合で、[r]
聖良がぎゅっと抱きついてくる。[np]
*p29|
というか、ろれつが回ってない。[r]
めちゃくちゃ酔っぱらってないか、これ。[np]
@hide
@eff_all_delete
@bg storage=bg_07c st02abb09
@show
@chr st02abb11
@dchr st02abb08 delay=1434
*p30|
@nm t="莉瑠" s=rir_10214
「ああもう聖良にお酒なんか飲ませるから……！」[np]
@chr st02abb09
*p31|
@nm t="千尋"
「い、いや、でもさっき本人がお酒に強いって……！」[np]
@chr st02abb10
*p32|
@nm t="莉瑠" s=rir_10215
「妄言ですよ、妄言！！　いつも記憶をなくして[r]
飲んだことすら忘れてるから強いと思い込んでるんですよ！」[np]
@chr st02abb11
*p33|
@nm t="莉瑠" s=rir_10216
「どうしても飲みたいって時は家族総出で、[r]
日本酒と偽って水を出してるくらいですのに……！！」[np]
@chr st02abb09
*p34|
ああ、なるほど……だからさっき日本酒を水と言ってたのか。[np]
@chr st02abb08
*p35|
@nm t="莉瑠" s=rir_10217
「とにかく逃げて下さい……！[r]
こうなった聖良は止められません……！」[np]
@chr st02abb12
*p36|
@nm t="千尋"
「止められないって――」[np]
@hide
@eff obj=0 page=back show=true storage=bg_07c_l path=(150,340,255) size=(1.4,1.4) time=1 absolute=(2000)
@bg storage=bg_07c st01bdb01
@show
@chr st01bdb10
@dchr st01bdb18 delay=2915
*p37|
@nm t="聖良" s=sei_11580
「キスぅ……。キスしよ？　んっ、ちゅぅぅ～……！！」[np]
*p38|
@nm t="千尋"
「んっ、んんっ～～！！？」[np]
@hide
@eff_all_delete
@bg storage=bg_07c st02abb09
@show
@chr st02abb11
*p39|
@nm t="莉瑠" s=rir_10218
「……手遅れでしたか。私の時もそうでしたよ……」[np]
@chr st02abb12
@dchr st02abb14 delay=4425
*p40|
@nm t="莉瑠" s=rir_10219
「聖良に押し倒されて、下着を下ろされて――くぅぅ……！[r]
何故に実の姉と貝合わせなんかするハメに……！！」[np]
@chr st02abb16
*p41|
@nm t="莉瑠" s=rir_10220
「い、いえ、あれは夢……！[r]
悪い夢だったはずです……！！」[np]
@chr st02abb13
@dmq_small delay=800
*p42|
@nm t="千尋"
「そ、それよりも助け――んんっ！？」[np]
@eff obj=0 page=back show=true storage=al_horizon_041_o path=(640,360,255) time=1 ysize=(0.7,0.7)
@eff obj=1 page=back show=true storage=al_horizon_041_o path=(640,360,255) time=1 absolute=(15001) ysize=(0.68,0.68)
@eff obj=2 page=back show=true storage=bg_07c_l path=(150,340,255) size=(2,2) time=1 bbx=(5) bby=(5) bbt=true bbs=true absolute=(15002) alphaeffect=1
@eff obj=3 page=back show=true storage=st01bdb14 path=(654,534,255) size=(1.2,1.2) time=1 absolute=(15003) anm=false alphaeffect=1
@extrans rule=rule_slash02_i_o_lr time=300
@dceff obj=3 storage=st01bdb13 time=400 delay=2939
*p43|
@nm t="聖良" s=sei_11581
「ちゅっ、んちゅぅっ。しゅきっ♪　だいしゅきらよ？」[np]
@ceff obj=3 storage=st01bdb10 time=250
*p44|
@nm t="千尋"
「～～っっ」[np]
*p45|
小っ恥ずかしいが、これはこれで有りかもしれない。[r]
正直、普通に嬉しいし……！！[np]
@eff_all_delete
@extrans rule=rule_slash02_i_o_lr time=400
@chr st02bbb11
@dchr st02bbb08 delay=1093
*p46|
@nm t="莉瑠" s=rir_10221
「……あぁ。どうやら助けは要らなさそうですね」[np]
@chr st02bbb03
*p47|
@nm t="千尋"
「――ハっ！！　ま、待って待って、助けて！」[np]
@chr st02bbb04
*p48|
@nm t="莉瑠" s=rir_10222
「いやいや、どうぞ続けて下さい。[r]
よくよく考えれば止める必要もありませんでした」[np]
@chr st02bbb02
@dchr st02abb07 delay=4260
*p49|
@nm t="莉瑠" s=rir_10223
「まぁ、あとはお若い者同士でということで。[r]
くれぐれも後始末だけはよろしくお願いしますね？」[np]
@chr_del_walk way=l name=莉瑠
[se storage="扉_開き戸_木_019_閉じ" buf=0 delay=0]
[wse buf=0]
*p50|
@nm t="千尋"
「ちょっ……り、莉瑠ぅぅぅーー！！」[np]
*p51|
俺の叫び声が空しくリビングに木霊する。[r]
この状態でエッチとか――[np]
*p52|
@nm t="千尋"
「……って」[np]
@fobgm time=2000
@hide
@eff obj=0 page=back show=true storage=bg_07c_l path=(150,340,255) size=(1.4,1.4) time=1 absolute=(2000)
@bg storage=bg_07c
@show
*p53|
@nm t="聖良" s=sei_11582
「すぅ……すぅ……すぅ……」[np]
*p54|
寝てるし……なんだったんだ。[np]
@hide
@eff_all_delete
@black rule=rule_cross00_o_i_lr
@wbgm
@show
*p55|
………………[np]
*p56|
…………[np]
*p57|
……[np]
@hide
@eff obj=0 page=back show=true storage=bg_11a_l path=(640,120,255) size=(1.6,1.6) time=1 absolute=(2000)
@bg storage=bg_11a rule=rule_cross08_i_o_tb
@bgm storage=bgm_10
@show
[se storage="H_風呂のお湯_ザバー" buf=0 delay=0]
*p58|
@nm t="千尋"
「ふぅ……」[np]
*p59|
湯船に浸かりながら人心地つく。[np]
*p60|
聖良は大丈夫だろうか。[r]
一応、部屋まで運んでベッドに寝かせておいたけど……。[np]
*p61|
しかし、まさか酔ったらあんな風に豹変するとは。[r]
チャーミングセーラよりもデレッデレだったな。[np]
*p62|
@nm t="千尋"
「……今度酔いどれセーラの漫画を描こう……」[np]
*p63|
先程の聖良の様子を思い返して一人頷く。[np]
*p64|
ただでさえデレデレのセーラが酔った勢いで[r]
さらに主人公にイチャついてくるなんて夢のようだ。[np]
[dse storage="液体_風呂26"]
@chr_drop st01bae05
*p65|
@nm t="聖良" s=sei_11583
「えへへぇ～。あ～るじきゅんっ！　ぎゅぅっ～」[np]
@chr st01bae04
*p66|
@nm t="千尋"
「そうそう。こんな風に――って！？」[np]
@chr st01bae06
*p67|
@nm t="聖良" s=sei_11584
「勝手にいなくなっちゃふなんへ、酷いよぉ。[r]
お姉ひゃん、起きたら一人でビックリしちゃっひゃ……」[np]
*p68|
@nm t="千尋"
「せ、聖良……！？　もう目が覚めたのか……！！[r]
というか、その格好……！！」[np]
@chr st01aae12
*p69|
@nm t="聖良" s=sei_11585
「えへへぇ～。やっぱりぃ、イチャイチャすりゅなりゃ、[r]
この格好が一番いいかなぁっへ……」[np]
@chr st01aae06
*p70|
@nm t="聖良" s=sei_11586
「千尋きゅんもしゅきれひょ……？[r]
わたひがこのセーラコスしへりゅの……」[np]
@chr st01aae04
@dchr st01aae06 delay=3595
*p71|
@nm t="聖良" s=sei_11587
「いっつもエッチな目れ、んふふ、見てりゅもんね？」[np]
@chr st01aae03
*p72|
@nm t="千尋"
「うっ……！！　そ、それは……！！」[np]
@chr st01aae06
@dchr st01aae18 delay=6121
@dchr st01aae12 delay=7114
*p73|
@nm t="聖良" s=sei_11588
「いいんらよぉ？　エッチな目れ、たくしゃん見へ？[r]
わたひも、んっ……ちゅぅ。嬉ひいかりゃ」[np]
@chr st01bae13
*p74|
@nm t="聖良" s=sei_11589
「わたひの身体れ、こーふん……しへ？[r]
エッチしたひっへ思ってくれりゅと嬉ひいな？」[np]
@chr st01bae04
*p75|
@nm t="千尋"
「せ、聖良……」[np]
@chr st01bae13
@dchr st01bae17 delay=1818
@dchr_quake name=聖良 sx=3 sy=3 xcnt=2 ycnt=1 time=300 delay=1818
*p76|
@nm t="聖良" s=sei_11590
「えへへぇ……。――ふぁ」[np]
@chr st01bae11
*p77|
グラっと聖良がふらつく。[np]
*p78|
@nm t="千尋"
「お、おいおい、大丈夫か……！？」[np]
@chr st01bae13
*p79|
@nm t="聖良" s=sei_11591
「ちょっと、はぁはぁ、のぼせちゃったかも……」[np]
@chr st01bae02
*p80|
@nm t="千尋"
「酔ってるのに風呂なんか入るからだ……！[r]
ほら、早く上がらないと……」[np]
@chr st01bae06
*p81|
@nm t="聖良" s=sei_11592
「ヤダってばぁ……。お姉ひゃん、もっひょあなひゃと[r]
イチャイチャしひゃいな？」[np]
*p82|
@nm t="千尋"
「そ、そう言われても」[np]
@chr st01bae10
*p83|
@nm t="聖良" s=sei_11593
「らめ……？」[np]
*p84|
上目遣いで言われて、つい息を呑んでしまう。[r]
ダメか、ダメじゃないかで言えばダメじゃないけど……！[np]
@chr st01aae04
@dchr st01aae12 delay=1003
*p85|
@nm t="聖良" s=sei_11594
「あ……えへへ。おちんこ、大きくなっちゃってる……」[np]
@chr st01aae05
*p86|
@nm t="千尋"
「っっ。こ、これは、その……！」[np]
@chr st01aae06
*p87|
@nm t="聖良" s=sei_11595
「照れなくへいいよ……？[r]
わたひとエッチしひゃいって思ってくれへるんれひょ？」[np]
@chr st01aae04
@dchr st01aae18 delay=7643
*p88|
@nm t="聖良" s=sei_11596
「わたひも……したひ、な？[r]
あなひゃと、んっ、ちゅぅ、エッチしひゃい……」[np]
@chr st01aae05
*p89|
不意に聖良が俺の手を握って、自分の胸へ導く。[np]
@chr st01bae13
*p90|
@nm t="聖良" s=sei_11597
「おっぱい、はぁはぁ、パンパンでひょ……？[r]
こーふんしすぎへ、今にもミルクでひゃいそうなの……」[np]
@chr st01bae02
*p91|
@nm t="千尋"
「ミ、ミルク……！！」[np]
@chr st01bae10
@dchr st01bae13 delay=5734
*p92|
@nm t="聖良" s=sei_11598
「飲んれ欲しい、な？[r]
それとも、えへへ、お酒の方がいーい？」[np]
@chr st01bae04
*p93|
@nm t="千尋"
「いや、そんなことは決して……！！」[np]
@chr st01bae13
*p94|
@nm t="聖良" s=sei_11599
「なら飲んれくれりゅ……？　わたひも、はぁはぁ、[r]
のぼせるのなりゃ、あなひゃれのぼせたいな？」[np]
@chr st01aae12
*p95|
@nm t="聖良" s=sei_11600
「あなひゃのおちんこで、はぁはぁ、のぼせたい……」[np]
@chr st01aae05
*p96|
@nm t="千尋"
「お、俺のチンコでのぼせたいって――うわっ！？」[np]
@hide
@eff_all_delete
@white rule=rule_72_i_o
[se storage="人の行動1_もみ(胸・体)_se1910"]
@show
*p97|
不意に視界が真っ白になる。[r]
顔中がめちゃくちゃ温かいものに包まれて……！！[np]
*p98|
これはまさか――[np]
@fobgm time=3000
@hide
@white time=2000
@wbgm
@wait time=1000
@jump storage="104_聖良バニー_01_h.ks"

; 
; 
*p0|
@bg storage=bg_01c
@bgm storage=bgm_04
@show
*p1|
それは、とある夜のことだった――[np]
@hide
@bg storage=bg_07c st02abh01
@show
@chr st02abh07
*p2|
@nm t="莉瑠" s=rir_0683
「ご主人様、喉が渇いたのだけれど」[np]
@chr st02abh03
*p3|
@nm t="千尋"
「ははぁ、紅茶でございます」[np]
@chr st02abh11
@dchr st02abh08 delay=1000
@dchr st02abh10 delay=2400
*p4|
@nm t="莉瑠" s=rir_0684
「……苦い。もっと砂糖とミルクを入れなさいよ」[np]
@chr st02abh09
[se storage="物_置_カップ01ちょっと激"]
@wait time=200
@quake sx=3 xcnt=3 sy=5 ycnt=5 time=300 loop=false fade=false delay=0
*p5|
@nm t="千尋"
「熱いっ！！」[np]
@hide
@black rule=rule_cross50re
@wait time=200
@bg storage=bg_07c st02abh07 rule=rule_cross51
@show
@dchr st02abh02 delay=1600
*p6|
@nm t="莉瑠" s=rir_0685
「小腹が空いたわ。果物を剥いて」[np]
@chr st02abh01
*p7|
@nm t="千尋"
「ははぁ、リンゴでございます」[np]
@chr st02abh11
@dchr st02abh15 delay=1600
*p8|
@nm t="莉瑠" s=rir_0686
「何よこれ。ただ剥いただけじゃない」[np]
@chr st02abh07
@dchr st02abh15 delay=3300
*p9|
@nm t="莉瑠" s=rir_0687
「私はウサちゃんリンゴしか食べない主義なの。[r]
もう一度、剥き直しなさい」[np]
@chr st02abh01
*p10|
@nm t="千尋"
「す、すぐにご用意いたします！」[np]
@hide
@black rule=rule_spiral01
@wait time=200
@bg storage=bg_07c st02abh12 rule=rule_spiral01
@show
@dchr st02abh07 delay=2400
*p11|
@nm t="莉瑠" s=rir_0688
「立つのにも疲れたわね。[r]
……でもソファーまで歩くのも面倒だわ」[np]
@chr st02bbh02
@dchr st02bbh04 delay=1500
*p12|
@nm t="莉瑠" s=rir_0689
「ご主人様、馬になりなさい」[np]
@chr st02bbh03
*p13|
@nm t="千尋"
「は、ははぁ、ただいま……！！」[np]
@hide
@black rule=rule_00_t_b
@eff obj=0 page=back show=true storage=bg_07c_l path=(640,40,255) size=(1.2,1.2) time=1 absolute=(2000) correct=false
[se storage="se4733"]
@bg storage=bg_07c rule=rule_00_t_b
@show
*p14|
言われた通り、直ちに四つん這いになる。[np]
@chr_drop st02bah03 time=500
*p15|
すると莉瑠は満足げに俺の背中へ腰を下ろした。[r]
大きな声では言えないが、やわっこいお尻がベリーグッド！[np]
@chr st02bah05
@dchr st02bah02 delay=1300
@dchr st02bah08 delay=3900
*p16|
@nm t="莉瑠" s=rir_0690
「ふふふ、乗り心地の悪い馬ね。[r]
ほら急ぎなさい。ほら早く」[np]
@chr st02bah05
*p17|
@nm t="千尋"
「は、はいぃ……！！」[np]
@chr st02bah02
*p18|
@nm t="莉瑠" s=rir_0691
「あら。馬が人の言葉を喋るの？」[np]
@chr st02bah01
*p19|
@nm t="千尋"
「パオーン！」[np]
@chr st02aah11
*p20|
@nm t="莉瑠" s=rir_0692
「つまらないボケだわ」[np]
@chr st02aah01
[se storage="コミカル_刺さる01" buf=0 delay=0]
@mq_small
*p21|
@nm t="千尋"
「も、申し訳ありませんっ！！」[np]
@hide
@eff_all_delete
@bg storage=bg_07c
@show
*p22|
そうして莉瑠を乗せたままソファーへと[r]
這って進んでいると、聖良が怖ず怖ずと話しかけてきた。[np]
@chr_walk way=r st01abb07=6 time=700
@wt
@chr st01abb09
@dchr st01abb13 delay=2800
*p23|
@nm t="聖良" s=sei_1725
「そ、その……莉瑠ちゃん。[r]
ロールプレイだとしても、流石にやりすぎ……じゃ」[np]
@chr st01abb07
*p24|
@nm t="千尋"
「……いいんだよ、聖良」[np]
@chr st01bbb08
*p25|
@nm t="聖良" s=sei_1726
「え？」[np]
@chr st01bbb16
*p26|
@nm t="千尋"
「俺は今、すごく幸せを感じているんだから……！」[np]
@chr st01bbb17
*p27|
@nm t="聖良" s=sei_1727
「……え゛？」[np]
*p28|
@nm t="千尋"
「俺はダークネススタイルのドＳなリルルに、[r]
こうして下僕のように扱われたいと、思っていたんだ……！」[np]
@chr st01bbb01
*p29|
@nm t="千尋"
「それが今――叶っている。とっても嬉しい……！」[np]
@chr st01abb07
@wt
@chr_poschange 聖良=6.3
@wm
@chr st01abb08
*p30|
@nm t="聖良" s=sei_1728
「そ……そうなんだ……」[np]
*p31|
嬉し涙を流しながら莉瑠を背に乗せて這う俺を見て、[r]
聖良が一歩後ずさりながら苦笑いを浮かべる。[np]
*p32|
そのドン引き視線すら、[r]
今の俺には不思議な高揚感を与えた。[np]
@hide
@eff obj=0 page=back show=true storage=bg_07c_l path=(940,40,255) size=(1.2,1.2) time=1 absolute=(2000) correct=false
@bg storage=bg_07c st02aah01
@show
@chr st02aah07
@dchr st02aah02 delay=3600
*p33|
@nm t="莉瑠" s=rir_0693
「ふふふ、そういうことですよ聖良。[r]
私は千尋さんのためを思ってやってあげてるんです」[np]
@chr st02aah03
[se storage="人の行動2_叩く_se2219"]
@q_small
*p34|
@nm t="千尋"
「あおぉっ！」[np]
@chr st02aah17
*p35|
@nm t="莉瑠" s=rir_0694
「私だって本当はこんなことしたくはないですよ？」[np]
@chr st02aah06
@dchr st02aah07 delay=3500
@dchr st02aah17 delay=4900
*p36|
@nm t="莉瑠" s=rir_0695
「ですが心を鬼に――いえダークネスリルルにして、[r]
ロールプレイをしてあげているんです」[np]
@chr st02aah05
@q_small
[se storage="人の行動2_叩く_se2242"]
@dq_small delay=800
[dse storage="人の行動2_叩く_se2219" delay=800]
*p37|
@nm t="千尋"
「んあっ！　あふっ！」[np]
@chr st02aah17
*p38|
@nm t="莉瑠" s=rir_0696
「これで少しでも千尋さんの心が満たされるのなら……。[r]
良い作品を描けるようになれば……」[np]
@chr st02aah06
*p39|
@nm t="莉瑠" s=rir_0696a
「そう――心の奥では、[r]
そんな思いやりの精神に溢れているんです」[np]
@chr st02aah05
@q_small
[se storage="人の行動2_叩く_se2219"]
@dq_small delay=750
[dse storage="人の行動2_叩く_se2217" delay=750]
@dq_small delay=1500
[dse storage="人の行動2_叩く_se2242" delay=1500]
*p40|
@nm t="千尋"
「んぁっ！　あふっ！　ふあっ！！」[np]
*p41|
うっとりと語りながら、背に乗ったままの莉瑠が[r]
俺のお尻をペチンペチンと叩いてくる。[np]
*p42|
この投げやりながら楽し気な感じ、いい……！[r]
悪くない、悪くないんだ……！！[np]
@chr st02bah03
@dchr st02bah15 delay=1500
@dchr st02bah02 delay=5700
*p43|
@nm t="莉瑠" s=rir_0697
「ふふふ、さぁご主人様。ソファーに急ぎなさい。[r]
いい加減、ご主人様を馬にするのも飽きてきたわ」[np]
@chr st02bah05
*p44|
@nm t="千尋"
「はいぃ……！」[np]
@hide
@eff_all_delete
@bg storage=bg_07c st01bbb01=6.3
@show
@chr st01bbb07
*p45|
@nm t="聖良" s=sei_1729
「ほ……ほどほどに、ね……？」[np]
@chr st01bbb02
@wt
@chr_del_walk way=r name=聖良 time=500
*p46|
愛想笑いを浮かべつつ、夕食の片付けをする聖良を尻目に[r]
のっしのっしとリビングの床を這い進む。[np]
@hide
@eff obj=0 page=back show=true storage=bg_07c_l path=(1270,-350,255) size=(2,2) time=1 bbx=(3) bby=(3) bbt=true bbs=true correct=false
@eff obj=1 page=back show=true storage=black path=(640,360,128) time=0 absolute=(15001) correct=false
@eff obj=2 page=back show=true storage=al_horizon_041_o path=(640,480,255) time=0 fliplr=true bbx=(1) bby=(1) bbt=true bbs=true absolute=(15002) ysize=(0.8,0.8) correct=false
@eff obj=3 page=back show=true storage=al_horizon_041_o path=(640,480,255) time=0 fliplr=true absolute=(15003) ysize=(0.75,0.75) correct=false
@eff obj=4 page=back show=true storage=bg_07c_l path=(1670,-770,255) size=(3,3) time=0 absolute=(15004) correct=false alphaeffect=3
@eff obj=5 page=back show=true storage=st02bah03 path=(620,570,255) size=(1.5,1.5) time=0 absolute=(15005) alphaeffect=3
@eff obj=6 page=back show=true storage=black path=(640,100,255) time=1000 absolute=(15006) correct=false sub=true
@eff obj=7 page=back show=true storage=st02bah03 path=(620,570,255) size=(1.5,1.5) time=0 absolute=(15007) alphaeffect=6
@bg storage=bg_07c rule=rule_02_i_o_lr
@show
*p47|
しかし、気持ちいい……。[r]
柔らかいお尻とほどよい体重が背中にのしかかって。[np]
*p48|
それにこの感触――間違いない。ストッキング直履きだ。[np]
*p49|
ダークネスリルルの正装ではあるが、[r]
ちゃんとショーツを履かずにいてくれてるなんて。[np]
*p50|
おかげでお尻の感触がたまらなく心地良い……。[np]
@hide
@eff_all_delete
@eff obj=8 storage=bg_07c_l path=(-1800,350,255) size=(2.6,2.6) time=1 bbx=(1) bby=(1) bbs=true absolute=(2000)
@bg storage=bg_07c st02aah01
@show
@chr st02aah02
*p51|
@nm t="莉瑠" s=rir_0698
「――と。ご苦労様、ここでいいわ」[np]
@chr_del_jump name=莉瑠
@mq_normal
*p52|
@nm t="千尋"
「！！」[np]
*p53|
不意に背中に感じていた体重とお尻の感触が離れる。[np]
*p54|
いつの間にかソファーの前に辿り着いていたのか……！[np]
*p55|
こんなことならもっとゆっくり進めば良かった。[r]
そうすれば、お尻だってもっと叩いてもらえただろう。[np]
@hide
@eff_delete obj=8
@eff obj=0 page=back show=true storage=bg_07c_l path=(-512,340,255) size=(1.4,1.4) time=1 absolute=(2000)
@bg storage=bg_07c st02abh01
@show
@chr st02abh06
@dchr st02abh17 delay=6500
*p56|
@nm t="莉瑠" s=rir_0699
「ふふ。どうしたの、ご主人様？[r]
惨めな姿から解放されたのに悔しそうな顔をして」[np]
@chr st02abh05
*p57|
@nm t="千尋"
「っ……それは……」[np]
@chr st02abh02
*p58|
@nm t="莉瑠" s=rir_0700
「まさか……まだまだ馬になっていたかったのかしら？」[np]
@chr st02abh17
@dchr st02abh07 delay=3100
@dchr st02abh06 delay=6800
*p59|
@nm t="莉瑠" s=rir_0701
「ふふ、変態ね。まぁでも、ご主人様の望みなら[r]
叶えてあげなくもないけれど」[np]
@chr st02abh05
*p60|
@nm t="千尋"
「ほ、本当に……！？」[np]
@chr st02abh07
@dchr st02abh12 delay=2100
*p61|
@nm t="莉瑠" s=rir_0702
「ええ。……でも残念ね」[np]
@chr st02bbh02
*p62|
@nm t="莉瑠" s=rir_0703
「頑張ったご主人様に個人的にご褒美をあげようかと[r]
思っていたのだけれど」[np]
@chr st02bbh01
*p63|
@nm t="千尋"
「ご褒美！？」[np]
@chr st02bbh03
*p64|
@nm t="莉瑠" s=rir_0704
「ええ」[np]
@hide
@chr_del_walk way=l name=莉瑠
@wt
@eff_delete obj=0
@eff obj=1 page=back show=true storage=bg_07c_l path=(-2060,300,255) size=(3.7,3.7) time=1 bbx=(1) bby=(1) bbs=true absolute=(2000)
@bg storage=bg_07c
@chr_drop st02aah05 time=600
@wt
@show
*p65|
ソファーに座った莉瑠がこれ見よがしに足をブラブラと[r]
揺らしながら、俺の股間を見つめてくる。[np]
*p66|
――まさか足コキかっ？[r]
足コキをしてくれるということか！？[np]
*p67|
確かに、『とろキン』でも今の状況と[r]
同じようなシチュを描いた覚えはある……！[np]
@chr st02aah07
@dchr st02aah17 delay=4100
*p68|
@nm t="莉瑠" s=rir_0705
「でも……ご主人様が馬になりたいと言うのなら、[r]
それをご褒美にしてあげてもいいわ」[np]
@chr st02aah15
@dchr st02aah02 delay=6400
*p69|
@nm t="莉瑠" s=rir_0706
「正直、あんな乗り心地の悪い馬には[r]
二度と乗りたくはないのだけれど……仕方ないわね」[np]
@chr st02aah03
*p70|
@nm t="千尋"
「ま――待ってくれ……！！」[np]
@chr st02aah05
*p71|
@nm t="千尋"
「リルルのご褒美の方で構わない……！！」[np]
@chr st02aah15
*p72|
@nm t="莉瑠" s=rir_0707
「……構わない？」[np]
@chr st02aah01
*p73|
@nm t="千尋"
「リルル様のご褒美を頂きたいです……！」[np]
@chr st02aah03
@dchr st02aah06 delay=1500
*p74|
@nm t="莉瑠" s=rir_0708
「ふふふ。全くもう、仕方のないご主人様ね」[np]
@chr st02bah15
*p75|
@nm t="莉瑠" s=rir_0709
「いいわ。もっと近くに寄りなさい」[np]
@eff_all_delete
@bg storage=bg_07c
*p76|
満足げな笑みを浮かべて、莉瑠が手招きをしてくる。[np]
*p77|
息を呑みながら近づくと、[r]
予想通り彼女は両足を突き出してきて――[np]
@fobgm time=2000
@hide
@eff_all_delete
@white time=1000
@wbgm
@jump storage="201_莉瑠黒魔_01_h.ks"

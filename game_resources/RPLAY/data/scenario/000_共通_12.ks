; 
; 
*p0|
@bg storage=bg_11a
@bgm storage=bgm_02
@wait time=1000
@eff obj=0 page=back show=true storage=bg_11a_l path=(-315,-310,255) size=(2.5,2.5) time=1 absolute=(1500)
[se storage="H_風呂22" buf=0 delay=0]
@bg storage=bg_11a
@show
*p1|
@nm t="千尋"
「あー……このお風呂とも、もうすぐお別れか……」[np]
*p2|
湯船に浸かりながら呟く。[np]
*p3|
莉瑠の夏休みが終わるのに合わせて、[r]
俺たちは島を離れることに決めていた。[np]
*p4|
残すところ、あと数日だ。[r]
そう思うとふとした拍子に寂寥感が心を満たしてくる。[np]
*p5|
@nm t="千尋"
「色々なことがあったもんだ……」[np]
*p6|
最初は最愛のセーラとリルルのコスをしてくれている[r]
コスプレイヤーさんをひと目見て帰るつもりだった。[np]
*p7|
なのに、そのコスプレイヤーさんたちと[r]
エッチなロールプレイをすることになって。[np]
*p8|
そうしている内に仲良くなって、[r]
好きになって、愛し合うようになって……。[np]
*p9|
気づけば、夏の終わりまでこの島に居座ってしまった。[np]
*p10|
正直、スランプ解消のきっかけだけを求めていたなら、[r]
もっと早々にこの島から立ち去っていたと思う。[np]
*p11|
こんなにこの島にいた理由は一つ。[r]
少しでも長く、あの二人と一緒にいたかったからだ。[np]
*p12|
だからこそ残り数日でこの日々が終わると思うと……[r]
とても寂しい気持ちになってしまう。[np]
@fobgm time=2000
[se storage="扉_引き戸_スチール_220_開け"]
[wait time=250]
*p13|
@nm t="千尋"
「ん？」[np]
*p14|
ちょっとセンチな気分に浸っていると、[r]
不意に風呂場の扉が開いた。[np]
@hide
@eff_all_delete
@bg storage=bg_11a_l left=-640 top=-560
@bgm storage=bgm_09
@show
@chr_walk way=l st02bba01=3 st01bba04=7,1
@dchr st01bba03 delay=1400
@dchr st01bba05 delay=2900
*p15|
@nm t="聖良" s=sei_10160
「えへへ。お邪魔する、ね？」[np]
@hide
@eff obj=0 page=back show=true storage=bg_11a_l path=(-570,-430,255) size=(3,3) time=1 absolute=(1500) correct=false
@bg storage=bg_11a
@show
@chr_drop st02baa17=1.5 st01aaa01=8.5,1
@dchr st02baa11 delay=1100
@dchr st02aaa12 delay=4500
*p16|
@nm t="莉瑠" s=rir_10160
「ふぅ～。もうすぐこのデカいお風呂ともお別れですかー。[r]
家のお風呂じゃもう満足できませんよ」[np]
*p17|
@nm t="千尋"
「ちょっ、何を平然と入ってきてるの……！？」[np]
@chr st02aaa09 st01aaa03
@dchr st01aaa02 delay=1100
@dchr st01aaa12 delay=5200
*p18|
@nm t="聖良" s=sei_10161
「ふふ、一緒にお風呂入るくらいいいじゃない。[r]
それよりももっとすごいことしてきたんだから」[np]
@chr st02aaa17 st01aaa05
@dchr st02aaa15 delay=3600
*p19|
@nm t="莉瑠" s=rir_10161
「今更、私たちの裸に照れますか？[r]
……ま、まぁ嬉しいですけど」[np]
@chr st02baa01
*p20|
そう言うと二人はかけ湯をし、当然のように俺の両脇に座る。[r]
ぴったりと肩をくっつけられ、身動きがとれなくなる。[np]
@chr st01baa13
@dchr st01baa05 delay=4000
*p21|
@nm t="聖良" s=sei_10162
「なんだか幸せ、だね？[r]
こうして三人でお風呂入ってるだけでも」[np]
@chr st02baa02 st01baa04
@dchr st02baa15 delay=2000
*p22|
@nm t="莉瑠" s=rir_10162
「そうですね。帰るまでの残り数日は、[r]
こうして毎日三人で入っちゃいましょうか」[np]
@chr st02baa01
*p23|
@nm t="千尋"
「ふ、二人がいいなら、構わないけど」[np]
@chr st01baa02
@dchr st01baa03 delay=1400
@dchr st01baa05 delay=5200
@dchr st01baa13 delay=7300
*p24|
@nm t="聖良" s=sei_10163
「ふふ、まだ声震えてる。可愛い。[r]
いいんだよ？　チラチラ見なくても、じっと裸見てくれて」[np]
@chr st02baa13 st01baa02
@dchr st02baa17 delay=4800
@dchr st02baa15 delay=7800
*p25|
@nm t="莉瑠" s=rir_10163
「見られるのが嫌なら裸できたりなんてしませんし。[r]
むしろ……まぁ。帰る前に焼き付けて欲しいと言いますか」[np]
@chr st02baa14
*p26|
二人が頬を赤くしつつも[r]
惜しげもなくその裸体を俺に向けてくる。[np]
*p27|
@nm t="千尋"
「ムラムラしちゃっても知らないからな……」[np]
@chr st01baa12
@dchr st01aaa03 delay=2000
@dchr st01aaa12 delay=3900
*p28|
@nm t="聖良" s=sei_10164
「その時は……えへへ。エッチしよ？」[np]
@chr st02aaa08 st01aaa13
@dchr st02aaa13 delay=4800
*p29|
@nm t="莉瑠" s=rir_10164
「というか早くムラムラして下さい。[r]
身体だって自由に触って下さっていいんですから」[np]
*p30|
言いながら、二人が俺の股間をさすってくる。[np]
@chr st01aaa06
@dchr st01aaa12 delay=3400
*p31|
@nm t="聖良" s=sei_10165
「ふふ……硬い。とっくにムラムラしてたんだ？」[np]
@chr st02aaa07 st01aaa05
@dchr st02aaa03 delay=2800
@dchr st02aaa02 delay=4400
*p32|
@nm t="莉瑠" s=rir_10165
「このおちんぽの感触も、ふふ。[r]
すっかり手に馴染んじゃいましたね」[np]
@chr st02aaa05 st01aaa04
@dchr st01aaa06 delay=4500
*p33|
@nm t="聖良" s=sei_10166
「たくさん愛してもらったよね……？[r]
あなたのこのおちんちんで……」[np]
@chr st02aaa17 st01aaa05
@dchr st02aaa13 delay=3300
@dchr st02aaa06 delay=5100
*p34|
@nm t="莉瑠" s=rir_10166
「二人とも虜にされちゃいました。[r]
あなたにも、このおちんぽにも……」[np]
@chr st02aaa05
*p35|
@nm t="千尋"
「それを言うなら俺だって――」[np]
@chr st02aaa17 st01aaa12
*p38|
@nm t="聖良・莉瑠" rt="聖良・莉瑠" s=gou_10008
「「あぁんっ……♪」」[np]
@chr st02aaa03 st01aaa03
*p39|
二人の爆乳に片手ずつ伸ばして、じっくりと揉む。[r]
彼女たちは抵抗せず、自由におっぱいを触らせてくれた。[np]
*p40|
何度揉んでも本当に飽きることのない、[r]
素晴らしいおっぱいだ。[np]
@chr st01aaa12
@dchr st01aaa06 delay=3800
*p41|
@nm t="聖良" s=sei_10168
「えへへ……。やっぱり幸せ……。[r]
大好きな人に身体触ってもらうの……」[np]
@chr st02aaa17 st01aaa05
@dchr st02aaa06 delay=4700
*p42|
@nm t="莉瑠" s=rir_10168
「触り方がやらしすぎるのが、えへへ、[r]
ちょっぴり気持ち悪いですけどね？」[np]
@chr st02aaa05
*p43|
二人それぞれの反応を返しながらも、[r]
二人揃って微笑みかけてくれる。[np]
@chr st01aaa13
@dchr st01baa18 delay=1800
@dchr st01baa10 delay=3200
*p44|
@nm t="聖良" s=sei_10169
「キスも……んちゅ、しよ？」[np]
@chr st02aaa15
@dchr st02baa11 delay=3300
@dchr st02baa17 delay=5100
@dchr st02baa14 delay=7600
*p45|
@nm t="莉瑠" s=rir_10169
「ああもう、ずるいですよ聖良は。[r]
私にも、ん……ちゅっ、下さい」[np]
*p46|
そうしてイチャイチャしていると、[r]
何だか茹ったように身体が熱くなっていく。[np]
@chr st01baa04
@dchr st01baa13 delay=1500
@dchr st01baa05 delay=4100
*p47|
@nm t="聖良" s=sei_10170
「えへへ。ロールプレイもいいけど、[r]
こうして普通にイチャイチャするのもいいね？」[np]
@chr st02baa15 st01baa02
@dchr st02aaa17 delay=5000
*p48|
@nm t="莉瑠" s=rir_10170
「むしろこっちが正常な恋人関係の気もしますが。[r]
まぁ姉妹ごと恋人にしてる時点でアレですけどね？」[np]
@chr st02aaa05 st01baa13
@dchr st01baa03 delay=4900
*p49|
@nm t="聖良" s=sei_10171
「別にわたしは気にしない、よ？[r]
あなたが莉瑠ちゃんのことも好きでも」[np]
@chr st02aaa07 st01baa02
@dchr st02aaa15 delay=3700
@dchr st02aaa02 delay=5500
*p50|
@nm t="莉瑠" s=rir_10171
「私も気にはしませんが。[r]
その代わり、平等に抱いて下さいね？」[np]
@chr st02aaa03
*p51|
普段以上に素直な気持ちを口にする二人。[np]
*p52|
ここでの生活がもうすぐ終わることを、[r]
二人も寂しがってくれているのかもしれない。[np]
@chr st02baa01 st01baa18
*p53|
@nm t="聖良" s=sei_10172
「んっ……ちゅっ……ちゅぁ……んふ」[np]
@chr st02baa17 st01baa02
*p54|
@nm t="莉瑠" s=rir_10172
「ちゅっ……んっ……んふ……ちゅっ」[np]
@chr st02baa14 st01baa13
@dchr st01baa10 delay=6500
*p55|
@nm t="聖良" s=sei_10173
「えへへ……。このままだと三人とものぼせちゃう、ね？[r]
早く上がって、ベッド……行こ？」[np]
@chr st02baa15
@dchr st02baa02 delay=5500
*p56|
@nm t="莉瑠" s=rir_10173
「三人とも裸ですし、脱ぐ手間もかかりませんしね。[r]
夜はまだまだ長いですから」[np]
@chr st02baa01 st01baa03
@dchr st01baa05 delay=1100
@dchr st01baa13 delay=5800
*p57|
@nm t="聖良" s=sei_10174
「たくさんたくさんエッチ、したいな……？[r]
残りの時間、ずーっとあなたと繋がっていたい」[np]
@chr st02aaa07 st01baa02
@dchr st02aaa06 delay=4200
*p58|
@nm t="莉瑠" s=rir_10174
「おちんぽが萎える時間なんてないと思って下さいね？[r]
勃たなくなったとしても、無理やり勃たせてやりますから」[np]
@chr st02aaa05
@wt
@eff_all_delete
@eff obj=1 page=back show=true storage=bg_11a_l path=(-166,107,255) size=(2,2) time=1 bbx=(2) bby=(2) bbt=true bbs=true absolute=(1501)
@bg storage=bg_11a
[se storage="お風呂から出る音" buf=0]
[se storage="H_風呂のお湯_ザバー" buf=1]
@chr_standup st02aaa05=2 st01aaa05=8,1 time=500
*p59|
早く早くとばかりに、[r]
二人がそれぞれ俺と腕を組んで立ち上がる。[np]
*p60|
そんな二人を見て、胸の裡にあった寂寥感が薄れていく。[np]
*p61|
きっと残り数日も、楽しい日々になるだろう。[np]
@chr st01aaa12
@dchr st01baa13 delay=1900
*p62|
@nm t="聖良" s=sei_10175
「何してるの？　ベッドの上で思う存分イチャイチャしよ？」[np]
@chr st02baa15 st01baa04
@dchr st02baa02 delay=2700
*p63|
@nm t="莉瑠" s=rir_10175
「時間が勿体ないですよ。急いで下さい」[np]
@chr st02baa01
*p64|
そうきっと――[np]
@chr st02baa15 st01baa13
@dchr st02aaa17 st01aaa12 delay=2600
*p67|
@nm t="聖良" s=gou_10009
「「早く私たちと……セックスしよ？」」[np]
@hide
@eff_all_delete
@bg storage=bg_11a time=800
@show
*p68|
それはきっと、こんなエッチな日々になるに違いない。[np]
@fobgm time=3000
@hide
@black time=2000
@wbgm
@wait time=1000
@jump storage="選択画面.ks" target="*common_return"

; 
; 
*p0|
@white
@show
*p1|
それは莉瑠との初体験を終えて、[r]
少し経った後――[np]
@hide
@bg storage=bg_08c_l left=-1280 top=-575
@bgm storage=bgm_10
@show
*p2|
@nm t="千尋"
「起きてて言われたものの……。[r]
いつまで起きていればいいんだ？」[np]
*p3|
莉瑠の意味深な笑顔を思い出して呟く。[np]
*p4|
てっきり一緒に寝たりするのかと思っていたけれど、[r]
大浴場で身体を洗った後、莉瑠は部屋へと戻っていった。[np]
*p5|
「もう少しだけ起きていて下さい」とだけ告げて。[np]
*p6|
どういうことだろうか？[r]
また着替えて戻ってくる、とか？[np]
*p7|
考えてもわかりそうにないな――[np]
[se storage="扉_ノック_木_027"]
[wait time=150]
*p8|
@nm t="千尋"
「うわっ！！？」[np]
*p9|
不意に扉がノックされて大声を上げてしまう。[np]
*p10|
莉瑠が戻ってきたのか――と思ったけれど、[r]
聞こえてきたのは違う声だった。[np]
@hide
@bg storage=bg_08c
@wait time=500
@eff obj=0 page=back show=true storage=al_horizon_041_o path=(640,320,255) time=1 absolute=(15000) ysize=(0.5,0.5) correct=false
@eff obj=1 page=back show=true storage=al_horizon_041_o path=(640,320,255) time=1 absolute=(15001) ysize=(0.47,0.47) correct=false
@eff obj=2 page=back show=true storage=sp_bg_08c_ドア左 path=(640,360,255) time=1 absolute=(15002) correct=false alphaeffect=1
@eff obj=3 page=back show=true storage=sp_bg_08c_ドア右 path=(640,360,255) time=1 absolute=(15003) correct=false alphaeffect=1
@eff obj=4 page=back show=true storage=st01bdb07 path=(640,470,255) time=1 absolute=(15004) alphaeffect=1
@bg storage=bg_08c
@show
*p11|
@nm t="聖良" s=sei_10177
「ち……千尋くん。まだ起きて、る……？」[np]
@ceff obj=4 storage=st01bdb01 time=250
*p12|
@nm t="千尋"
「せ、聖良！？　起きてるけど……」[np]
@ceff obj=4 storage=st01bdb16
*p13|
@nm t="聖良" s=sei_10178
「その……ね？　話したいことがあって……。[r]
入ってもいい、かな……？」[np]
@ceff obj=4 storage=st01bdb01
*p14|
@nm t="千尋"
「えっ？　あ――」[np]
@ceff obj=4 storage=st01adb08 path=(760,420,255)
*p15|
@nm t="聖良" s=sei_10179
「や……やっぱりダメ……？」[np]
@eff_all_delete
@bg storage=bg_08c
*p16|
悲しげな聖良の声を聞いて心が痛む。[r]
もう、招き入れないという選択肢はなかった。[np]
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
@wse
@chr_walk way=l st01abb01
@wt
@chr st01abb04
@dchr st01abb12 delay=1753
*p17|
@nm t="聖良" s=sei_10180
「えへへ……。ありがとう……」[np]
@chr st01abb03
*p18|
@nm t="千尋"
「い、いや。それでその……どうしたんだ？」[np]
@chr st01bbb16
@dchr st01bbb10 delay=7314
*p19|
@nm t="聖良" s=sei_10233
「莉瑠ちゃんから、その。何も聞いてない……？[r]
さっきまでエッチしてたん、だよ……ね？」[np]
@chr st01bbb01
*p20|
@nm t="千尋"
「どっ……どうしてそれを……！？」[np]
@chr st01bbb13
*p21|
@nm t="聖良" s=sei_10234
「ふふ、やっぱりそなんだ……？[r]
莉瑠ちゃんがあなたのお部屋に入っていくのが見えて……」[np]
@chr st01bbb05
@dchr st01bbb13 delay=5410
*p22|
@nm t="聖良" s=sei_10235
「でも良かった。ちゃんとしてもらえたみたいで……。[r]
あんまり素直じゃないタイプ、だから。ちょっと心配してたの」[np]
@chr st01bbb04
*p23|
安心したように聖良が息をつく。[r]
俺と莉瑠がしたことについてはいいのだろうか？[np]
*p24|
気になるけれど、これ以上聖良に近づくことができない。[r]
さっきのこともあり、何だかいつも以上に意識してしまう。[np]
@chr st01bbb02
*p25|
風呂上がりなのか聖良の顔が上気して見えて、[r]
いい匂いもするしで、色気を強く感じさせられる。[np]
*p26|
なんかこう、同じ空間に長時間いると、[r]
色香に当てられてしまいそうだ……。[np]
*p27|
というか、莉瑠と愛し合った直後なのに、[r]
自分の節操のない性欲に、ちょっと呆れてしまう。[np]
*p28|
しかし莉瑠に起きててと言われて待っていたら[r]
聖良が現れたってことは、わかってたのかな？[np]
*p29|
そうなると……どういうことだ？[np]
@chr st01bbb15
@dchr st01bbb10 delay=2587
*p30|
@nm t="聖良" s=sei_10236
「じゃあ、その……。お話して、いい……？」[np]
*p31|
@nm t="千尋"
「え、ああ」[np]
@chr st01bbb01
*p32|
答えるも、聖良からなんだか熱っぽい雰囲気を感じて、[r]
まっすぐ直視するとドキドキしてしまう。[np]
@chr st01bbb18
*p33|
彼女の目を見ている振りをしながら、[r]
鼻あたりを見て、彼女の言葉を待つ。[np]
*p34|
すると――[np]
@fobgm time=2000
@shide
@bg storage=bg_08c st01bab01 time=250
@sshow
@mq_small
*p35|
@nm t="千尋"
「うおっ……！？」[np]
*p36|
聖良がずいっと近づいて俺の顔を覗き込んでくる。[r]
不意を突かれて、思わず視線を合わせてしまう……！！[np]
@chr st01bab17
@dchr st01bab07 delay=1542
@dchr st01bab10 delay=3766
*p37|
@nm t="聖良" s=sei_10186
「……ごめんね？　でも、その……。[r]
わたしにとって大切な話だから……」[np]
@chr st01bab03
*p38|
@nm t="聖良" s=sei_10187
「ちゃんとあなたの目を見て、話したくて……」[np]
@chr st01bab02
*p39|
@nm t="千尋"
「聖良……」[np]
*p40|
俺以上に目を合わせるのが苦手な彼女が、[r]
真っ直ぐに俺の目を見て告げてくる。[np]
*p41|
それだけ真剣に俺と向き合おうとしている彼女を見て、[r]
これ以上、俺だけ目を背けるわけにはいかなかった。[np]
@chr st01bab10
@dchr st01bab12 delay=3409
@dchr st01bab10 delay=6489
*p42|
@nm t="聖良" s=sei_10188
「わたし……ね？　その、わたし、あなたが……」[np]
@bgm storage=bgm_11
@chr st01bab13
*p43|
@nm t="聖良" s=sei_10189
「あなたが――好き、なんだと思う」[np]
@chr st01bab02
*p44|
@nm t="千尋"
「っ……」[np]
@chr st01aab17
@dchr st01aab08 delay=1664
*p45|
@nm t="聖良" s=sei_10190
「ご、ごめんね？　『思う』だなんて、[r]
戸惑わせるようなこと言っちゃって……」[np]
@chr st01aab02
@dchr st01aab15 delay=2482
@dchr st01aab13 delay=7635
*p46|
@nm t="聖良" s=sei_10191
「正直、ね？　自分でもまだよくわからなくて……。[r]
あなたを見て、心があったかくなる気持ちの正体、[r]
まだよくわかってなくて……」[np]
@chr st01aab17
@dchr st01aab09 delay=6029
*p47|
@nm t="聖良" s=sei_10192
「恋愛なんて、したことなかったから……。[r]
この気持ちが本当に『好き』なのか、わからなくて……」[np]
@chr st01aab07
*p48|
@nm t="千尋"
「聖良……」[np]
*p49|
きっとその感情は『好き』なんだろう。[r]
さっき莉瑠と身体を重ねた今なら、なんとなくわかる。[np]
*p50|
だからこそ俺も真剣に向き合わないといけない。[r]
聖良と一緒にいると感じる心の熱、その感情に――[np]
*p51|
@nm t="千尋"
「聖良。俺は……俺は、聖良が好きだ」[np]
@chr st01bab11
*p52|
@nm t="聖良" s=sei_10237
「っっ」[np]
*p53|
@nm t="千尋"
「莉瑠とエッチしておいてこんなことを言うのは[r]
自分でも最低だなって思う」[np]
*p54|
@nm t="千尋"
「でも、莉瑠を前にした時と同じなんだ。[r]
聖良が目の前に立ってるだけで心が熱くなる」[np]
*p55|
@nm t="千尋"
「だから……俺はきっと、いいや絶対聖良が好きだ。[r]
莉瑠と同じくらい、好きだと思ってる」[np]
@chr st01bab10
*p56|
@nm t="聖良" s=sei_10238
「千尋、くん……」[np]
@chr st01bab03
*p57|
@nm t="聖良" s=sei_10239
「最低なんかじゃない、よ？[r]
あなたの気持ち……すごく嬉しい」[np]
@chr st01bab13
*p58|
@nm t="聖良" s=sei_10240
「むしろ、良かった。莉瑠ちゃんと同じくらい[r]
好きだって言ってもらえて……」[np]
@chr st01bab04
*p59|
@nm t="千尋"
「聖良……」[np]
@chr st01aab12
*p60|
@nm t="聖良" s=sei_10241
「わたしも、ね……？　濡れちゃうの……」[np]
@chr st01aab05
*p61|
@nm t="千尋"
「へっ！？　ぬ、濡れるっ？」[np]
@chr st01aab17
*p62|
@nm t="聖良" s=sei_10194
「う……うん」[np]
@chr st01aab12
@dchr st01aab17 delay=7905
*p63|
@nm t="聖良" s=sei_10195
「あなたと一緒にいるだけで……。[r]
あなたのお顔見るだけで……。[r]
あなたとお喋りするだけで……」[np]
@chr st01aab06
@dchr st01aab12 delay=9170
*p64|
@nm t="聖良" s=sei_10196
「身体が熱くなって、心が熱くなって。[r]
アソコは……もっと熱くなって」[np]
@chr st01aab05
*p65|
聖良が恥ずかしそうに顔を赤くしながらも、[r]
俺の目を見つめたまま話を続ける。[np]
@chr st01aab17
@dchr st01aab13 delay=3965
*p66|
@nm t="聖良" s=sei_10197
「スケベな告白でごめん、ね？[r]
でも、その。ホントのことで……」[np]
@chr st01aab08
@dchr st01aab13 delay=5042
@dchr st01aab17 delay=8238
*p67|
@nm t="聖良" s=sei_10198
「だから、その。わからなくなって……。[r]
これが恋なのか、わたしがただエッチなだけなのか……」[np]
@chr st01aab13
*p68|
@nm t="聖良" s=sei_10199
「だけど、あなただけなの……。[r]
わたしをこんなにビショビショにしてくれる人は……」[np]
@chr st01bab13
*p69|
@nm t="聖良" s=sei_10200
「エッチしたいって――心も体も疼いちゃう人は……」[np]
@chr st01bab02
*p70|
聖良の告白を聞いて、かぁっと身体に熱がこもる。[r]
いいや、それだけじゃない。俺もまた――[np]
@chr st01bab17
@dchr st01bab07 delay=6803
@dchr st01bab10 delay=9803
*p71|
@nm t="聖良" s=sei_10201
「や、やっぱりこんな告白……おかしい、かな？[r]
恋じゃない、よね……？　ただスケベなだけ、だよね……？」[np]
@chr st01bab01
*p72|
@nm t="千尋"
「だとしたら……俺もスケベなだけなのかもしれない」[np]
@chr st01bab16
*p73|
@nm t="聖良" s=sei_10202
「え……？」[np]
@chr st01bab01
*p74|
じっと俺の目を見つめていたからだろう。[r]
聖良は俺の変化に気づいていないみたいだ。[np]
*p75|
@nm t="千尋"
「俺も同じだ。聖良と一緒にいるだけで、[r]
顔を見ているだけで、話しているだけで……」[np]
*p76|
彼女の視線を誘導するように首を軽く曲げる。[r]
すると、聖良はつられるように目線を下へ向けて――[np]
@chr st01bab08
*p77|
@nm t="聖良" s=sei_10203
「あ……」[np]
@chr st01bab11
*p78|
ようやく大きなテントを張った俺のズボンを見つけた。[np]
*p79|
@nm t="千尋"
「……聖良と話しているうちに、その。[r]
こうなってたんだ。ドキドキしっぱなしで……」[np]
*p80|
@nm t="千尋"
「でも、俺はこれも答えなんだと思う。[r]
聖良のことが好きだから、こんなに勃起するんだ」[np]
@chr st01bab02 time=600
*p81|
@nm t="千尋"
「聖良と、その……。エッチしたいって、[r]
心も体もチンコも、熱くなるんだ」[np]
*p82|
下世話な内容に恥ずかしくなりながら、[r]
それでも彼女の目を見つめて告げる。[np]
*p83|
すると聖良は――[np]
@chr st01bab13
@dchr st01bab05 delay=1567
*p84|
@nm t="聖良" s=sei_10204
「嬉しい……えへへ。すごく、嬉しいな……」[np]
@chr st01bab13
@dchr st01bab03 delay=5402
*p85|
@nm t="聖良" s=sei_10205
「あなたのそういうところ、すごく大好き……。[r]
エッチなわたしのこと受け入れてくれて、励ましてくれて……」[np]
@chr st01bab13
*p86|
@nm t="聖良" s=sei_10206
「こんなわたしに……興奮してくれて」[np]
@hide
@eff obj=0 page=back show=true storage=bg_08c path=(640,360,255) time=0 bbx=(5) bby=(5) bbt=true bbs=true absolute=(2000) correct=false
@eff obj=1 page=back show=true storage=st01bdb02 path=(644,612,255) size=(1.1,1.1) time=1 absolute=(8000)
[se storage="動作_衣擦れ_洋服_02" buf=0 delay=0]
@bg storage=bg_08c
@show
*p87|
おもむろに聖良の顔が近づいてくる。[r]
気持ちが抑えきれないとばかりにそっと抱きしめられる。[np]
*p88|
俺はそんな彼女に応えるように、[r]
ゆっくりと唇を前へ――[np]
@hide
@eff_delete obj=0
@eff_delete obj=1
@eff obj=2 page=back show=true storage=bg_08c_l path=(1170,190,255) size=(1.2,1.2) time=1 rad=(-6,-6) absolute=(15000) bbx=(10) bby=(10) bbt=true bbs=true
@eff obj=3 page=back show=true storage=loop_mist_white2_vertical path=(640,360,80) time=1 gceil=220 bceil=220 absolute=(15001) mode=psdodge5
@eff obj=4 page=back show=true storage=st01bdb18 path=(665,616,255) size=(1.25,1.25) time=1 rad=(-3,-3) absolute=(15002)
@eff obj=5 page=back show=true storage=al_horizon_020_c path=(640,360,255) size=(1.3,1.3) time=1 rad=(-4,-4) bbx=(20) bby=(20) bbt=true bbs=true absolute=(15003) sub=true
@eff obj=6 page=back show=true storage=st01bdb18 path=(665,616,255) size=(1.25,1.25) time=1 rad=(-3,-3) bbx=(2) bby=(2) bbt=true bbs=true absolute=(15004) alphaeffect=5
@extrans
@show
*p89|
@nm t="聖良" s=sei_10207
「ちゅっ……んっ」[np]
*p90|
熱くて柔らかい感触が唇に優しく重ねられた。[r]
色っぽい吐息が顔に当たって、心臓が跳ねてしまう。[np]
@hide
@eff_delete obj=2
@eff_delete obj=3
@eff_delete obj=4
@eff_delete obj=5
@eff_delete obj=6
@eff obj=0 page=back show=true storage=bg_08c path=(640,360,255) time=1 bbx=(3) bby=(3) bbt=true bbs=true absolute=(2000)
@bg storage=bg_08c st01bdb04
@show
@dchr st01bdb13 delay=1500
*p91|
@nm t="聖良" s=sei_10208
「えへへ……。ありがとう、受け止めてくれて……」[np]
@chr st01bdb03
@dchr st01bdb13 delay=4180
*p92|
@nm t="聖良" s=sei_10209
「わたしの初めてのキス……もらってくれて」[np]
@chr st01adb05
*p93|
@nm t="千尋"
「っ……い、いや、俺こそ。[r]
聖良とキスできて、すごく嬉しいというか……」[np]
*p94|
一瞬前のキスの快感を思い出すように、[r]
唇をついつい擦り合わせてしまう。[np]
@chr st01adb03
@dchr st01adb04 delay=1200
*p95|
@nm t="聖良" s=sei_10210
「ふふ。そんなことしなくていいのに」[np]
@chr st01adb06
@dchr st01bdb18 delay=3302
@dchr st01bdb13 delay=6820
@dchr st01bdb18 delay=13000
@dchr st01bdb03 delay=14600
*p96|
@nm t="聖良" s=sei_10211
「したいって言ってくれるなら……んっ、ちゅ……。[r]
えへへ、何度でもするよ？　してくれて、ちゅっ、いいから」[np]
@chr st01bdb02
*p97|
言いながら聖良が何度も唇を重ねてきてくれる。[r]
ちゅっ、ちゅっ、とついばみ、愛情を示すかのように。[np]
*p98|
ただでさえ興奮で血流がチンコへ送り込まれているのに、[r]
こんな幸福感まで感じてしまったら――[np]
@chr st01bdb10
*p99|
@nm t="聖良" s=sei_10212
「……いいよ？」[np]
*p100|
@nm t="千尋"
「聖良……」[np]
@chr st01adb15
*p101|
@nm t="聖良" s=sei_10213
「わたしも……そのつもりで来たん、だもん」[np]
@chr st01adb13
@dchr st01adb17 delay=4813
*p102|
@nm t="聖良" s=sei_10214
「あなたとエッチしたくて……。[r]
あなたに初めてをもらって欲しくて……」[np]
@chr st01adb12
*p103|
@nm t="聖良" s=sei_10215
「もっともっとあなたと……繋がっていたくて」[np]
@eff_all_delete
@bg storage=bg_08c
[se storage="衣擦れ(103)" buf=0 delay=0]
*p104|
そう言って聖良が自分の服に手をかけ、[r]
そのままゆっくりと脱ぎ捨てていく。[np]
@chr_standup st01bba12 time=800
*p105|
@nm t="千尋"
「～～っっ」[np]
@chr st01bba02
*p106|
色気に満ちた美しいその裸を見た瞬間、感動すら覚えてしまう。[np]
*p107|
おっぱいもアソコも見せてもらったことがあるはずなのに、[r]
まるで初めて聖良の裸を見たような感覚に陥っている。[np]
@chr st01bba13
*p108|
@nm t="聖良" s=sei_10216
「えへへ……。興奮してくれて、嬉しいな……」[np]
@chr st01aba13
@dchr st01aba12 delay=4069
*p109|
@nm t="聖良" s=sei_10217
「ちょっぴり恥ずかしいけど、たっぷり見て欲しい……。[r]
わたしの裸……。大好きな、あなたに……」[np]
@chr st01aba13
@dchr st01aba17 delay=4778
*p110|
@nm t="聖良" s=sei_10218
「その代わり……その。あなたの裸も、[r]
わたしに見せてくれる……？」[np]
@chr st01baa02
@wt
[se storage="衣擦れ(32)" buf=0 delay=0]
*p111|
聖良が俺の服をそっと脱がしてくる。[r]
俺は身じろぎ一つもできずに気づけば裸になっていた。[np]
*p112|
って、緊張している場合じゃない。[r]
これから、俺は聖良と……。[np]
*p113|
なら、俺がリードすべきだ、一度とはいえ、[r]
俺の方が経験者なわけだし。[np]
*p114|
そう思い、聖良を押し倒そうと、前のめりになったその時だった。[np]
@shide
@eff obj=0 page=back show=true storage=bg_08c path=(640,360,255) time=1 bbx=(5) bby=(5) bbt=true bbs=true absolute=(2000)
@bg storage=bg_08c st01bda18 time=250
@sshow
*p115|
@nm t="聖良" s=sei_10219
「ちゅっ……んっ。んんっ……」[np]
*p116|
@nm t="千尋"
「～～っっ！？」[np]
@chr st01bda15
*p117|
@nm t="聖良" s=sei_10220
「んちゅぅっ……ちゅっ、んっ……んふ……」[np]
*p118|
再び唇を重ねられ、驚いたのも束の間、[r]
その優しい口づけに勇んでいた気持ちが落ち着いていく。[np]
*p119|
ふっくらと柔らかな唇の感触、口をくすぐる吐息、[r]
その全てが鮮烈で、脳髄に響くような快感だった。[np]
@chr st01bda18
@dceff obj=0 storage=bg_08c path=(640,360,255) time=250 bbx=(0) bby=(0) bbt=false bbs=false absolute=(2000) delay=2100
@dchr st01baa10 delay=2100
@dchr st01baa13 delay=3300
*p120|
@nm t="聖良" s=sei_10221
「ちゅっ、ん。ふぁ……えへへ。[r]
良かった。お顔、柔らかくなってる」[np]
@eff_delete_now obj=0
@chr st01baa04
*p121|
@nm t="千尋"
「え？」[np]
@chr st01baa03
*p122|
@nm t="聖良" s=sei_10222
「さっきまで、すごく固い顔してたから……。[r]
少しでも緊張がほぐれればって思って……」[np]
@chr st01baa02
*p123|
@nm t="千尋"
「っ……ごめん」[np]
@chr st01aaa12
*p124|
@nm t="聖良" s=sei_10223
「ううん。嬉しい、よ？　それだけわたしとのエッチに[r]
真剣になってくれてるってこと、だもん……」[np]
@chr st01aaa02
*p125|
@nm t="聖良" s=sei_10224
「でも上手くしなくちゃ、とか。[r]
リードしなくちゃ、とか。考えなくてもいいよ……？」[np]
@chr st01aaa03
*p126|
@nm t="千尋"
「うっ……！　でも、一度とはいえ、俺の方が経験者なんだし……！」[np]
@chr st01aaa03
@dchr st01aaa06 delay=1261
@dchr st01aaa12 delay=7141
*p127|
@nm t="聖良" s=sei_10242
「ふふ。けど卒業したの、ついさっき……でしょ？[r]
無理してリードしようとしなくていいよ？」[np]
@dchr st01aaa06 delay=8864
*p128|
@nm t="聖良" s=sei_10243
「むしろ、リードできないほど[r]
ドキドキしてくれてる方が嬉しい……。[r]
なんだか初めて同士みたいな気持ちになれて……」[np]
@chr st01baa03
@dchr st01baa13 delay=1619
*p129|
@nm t="聖良" s=sei_10244
「とっても……えへへ。幸せ、だから」[np]
@chr st01baa04
*p130|
聖良が心の底から幸福そうに微笑んでくれる。[r]
その笑顔に、情けなくてしょんぼりしかけた心が浮足立つ。[np]
@chr st01baa03
@dchr st01baa05 delay=10843
*p131|
@nm t="聖良" s=sei_10228
「上手くしなくちゃ、とか。リードしなくちゃ、とか。[r]
考えなくてもいいって言うのも、ね？　幸せだから、だよ？」[np]
@chr st01baa13
*p132|
@nm t="聖良" s=sei_10229
「あなたとのエッチなら……えへへ。[r]
どんな風にされても、気持ち良くなっちゃう自信しかないから」[np]
@chr st01aaa13
*p133|
聖良が照れ臭そうに身体をモジモジと揺らす。[r]
その仕草が可愛くて、裸身ゆえにエッチだった。[np]
@chr st01aaa12
*p134|
@nm t="聖良" s=sei_10230
「だから……あなたの好きなようにしてみて？[r]
わたしもその方が嬉しいから……」[np]
@chr st01aaa06
@dchr st01aaa03 delay=3183
@dchr st01aaa12 delay=5281
*p135|
@nm t="聖良" s=sei_10231
「難しいコト考えずに……えへへ。エッチ、しよ？」[np]
@chr st01baa05
@dchr st01baa13 delay=2746
*p136|
@nm t="聖良" s=sei_10232
「大好きなあなたと……[r]
心ゆくまで気持ちいいコトしたい、な？」[np]
@hide
@white
@show
[se storage="ベッドに倒れる" buf=0 delay=0]
*p137|
@nm t="千尋"
「わっ……！」[np]
*p138|
緊張する俺をリードしてくれるように[r]
聖良がそっと俺の手を引きながらベッドに倒れ込む。[np]
*p139|
そして――[np]
@hide
@wait time=2000
@wait time=1000
@jump storage="100_聖良初体験_01_h.ks"

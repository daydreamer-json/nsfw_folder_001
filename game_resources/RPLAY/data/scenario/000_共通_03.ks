; 
; 
*p0|
@eff obj=0 page=back show=true storage=bg_06a_l path=(270,160,255)(270,660,255) time=30000 accel=-2
@bg storage=bg_06a
@bgm storage=bgm_04
@show
*p1|
@nm t="千尋"
「こ……ここに泊まってるのか？」[np]
*p2|
聖良に連れてこられたのはどう見てもお屋敷だった。[np]
*p3|
というか、コスタリアの広告やＨＰで見たことがある。[r]
確かＶＩＰ専用の宿泊施設だったはずだ。[np]
@hide
@eff_all_delete
@black time=800
@show
*p4|
なんでも宿泊施設と撮影スタジオを兼ねていて、[r]
様々なコンセプトに沿って作られた部屋が揃ってるらしい。[np]
@eff obj=0 page=back show=true storage=white path=(-10,32,255) time=1 rad=(-5,-5) bbx=(2) bby=(2) bbt=true bbe=true bbs=true correct=false
@eff obj=1 page=back show=true storage=bg_08a_l path=(642,75,255) size=(0.6,0.6) time=1 absolute=(15001) correct=false alphaeffect=0
@extrans time=500
@eff obj=6 page=back show=true storage=white path=(1342,659,255) time=1 rad=(-5,-5) bbx=(2) bby=(2) bbt=true bbe=true bbs=true absolute=(15006) correct=false
@eff obj=7 page=back show=true storage=bg_09c_l path=(735,407,255) size=(0.7,0.7) time=1 absolute=(15007) correct=false alphaeffect=6
@dextrans time=500 delay=1000
*p5|
ファンタジー中世風の豪奢な洋室や、[r]
退廃的な空気が漂ういやらしい雰囲気の寝室。[np]
@eff obj=0 storage=white path=(-10,32,255) time=1 rad=(-5,-5) bbx=(2) bby=(2) bbt=true bbe=true bbs=true correct=false
@eff obj=1 storage=bg_08a_l path=(642,75,255) size=(0.6,0.6) time=1 absolute=(15001) correct=false alphaeffect=0
@eff obj=6 storage=white path=(1342,659,255) time=1 rad=(-5,-5) bbx=(2) bby=(2) bbt=true bbe=true bbs=true absolute=(15006) correct=false
@eff obj=7 storage=bg_09c_l path=(735,407,255) size=(0.7,0.7) time=1 absolute=(15007) correct=false alphaeffect=6
@eff obj=2 page=back show=true storage=white path=(1278,-71,255) time=1 rad=(-5,-5) bbx=(2) bby=(2) bbt=true bbe=true bbs=true absolute=(15002) correct=false
@eff obj=3 page=back show=true storage=bg_11a_l path=(732,48,255) size=(0.7,0.7) time=1 absolute=(15003) correct=false alphaeffect=2
@extrans time=500
@eff obj=4 page=back show=true storage=white path=(54,762,255) time=1 rad=(-5,-5) bbx=(2) bby=(2) bbt=true bbe=true bbs=true absolute=(15004) correct=false
@eff obj=5 page=back show=true storage=bg_10c_l path=(1200,290,255) time=1 absolute=(15005) correct=false alphaeffect=4
@dextrans time=500 delay=1000
*p6|
他にも大浴場も絢爛豪華でプールみたいに広々としてて、[r]
地下には牢屋風のセットまで用意されていると聞く。[np]
@eff obj=2 storage=white path=(1278,-71,255) time=1 rad=(-5,-5) bbx=(2) bby=(2) bbt=true bbe=true bbs=true absolute=(15002) correct=false
@eff obj=3 storage=bg_11a_l path=(732,48,255) size=(0.7,0.7) time=1 absolute=(15003) correct=false alphaeffect=2
@eff obj=4 storage=white path=(54,762,255) time=1 rad=(-5,-5) bbx=(2) bby=(2) bbt=true bbe=true bbs=true absolute=(15004) correct=false
@eff obj=5 storage=bg_10c_l path=(1200,290,255) time=1 absolute=(15005) correct=false alphaeffect=4
*p7|
つまり予約もいらず、順番待ちもせず、好きなだけ撮影を[r]
楽しめる、レイヤーさんとっての夢の宿と言えるのだそうだ。[np]
*p8|
そんなところに泊まっているなんて――[np]
@hide
@eff_all_delete
@black
@bg storage=bg_06a st01bbb16
@show
@chr st01bbb08
@dchr st01bbb10 delay=600
@dchr st01abb15 delay=5800
*p9|
@nm t="聖良" s=sei_0165
「あ……！　これは前に出たイベントで偶然優勝、して……！[r]
その賞品がここの宿泊券だっただけ、だから……！」[np]
@chr st01abb07
*p10|
俺の視線に気づいたのか、聖良が慌てて説明してくれる。[np]
@chr st01abb13
@dchr st01abb14 delay=2400
@dchr st01abb15 delay=4900
*p11|
@nm t="聖良" s=sei_0166
「わたしたちもいざやってきてビックリした、の……。[r]
ここまで大きなお屋敷だとは思ってなかったし……」[np]
@chr st01abb01
*p12|
@nm t="千尋"
「そうだったのか……」[np]
@chr st01abb02
@dchr st01abb14 delay=6200
@dchr st01abb12 delay=8600
*p13|
@nm t="聖良" s=sei_0167
「でも、とろキンの合わせをするのには丁度良くて……。[r]
妹は、えと。リルルコスでお外出たくないって頑なだから……」[np]
@chr st01bbb01
@wt
@chr_del_walk way=r name=聖良
*p14|
作者の手前だからか聖良が申し訳なさそうに言ってくる。[np]
*p15|
でもまぁ当然の反応だろう。[r]
衣装によっては大丈夫なものもあるけど、[r]
大体は露出の激しいスケベ衣装だから。[np]
@hide
@eff obj=0 page=back show=true storage=sp_bg_06a time=1 absolute=(1500)
@bg storage=bg_06a
@show
@chr_walk way=r st01aab01=6
*p16|
@nm t="千尋"
「やっぱり、リルルコスをしてたのは……」[np]
@chr st01bab05
@dchr st01bab03 delay=3600
@dchr st01bab13 delay=7300
*p17|
@nm t="聖良" s=sei_0168
「うん。妹、だよ？　いつも一緒に合わせてくれるの。[r]
イベントにも一緒に出てくれて……」[np]
@chr st01bab10
@dchr st01bab12 delay=5300
*p18|
@nm t="聖良" s=sei_0169
「わたし、コスプレしてしまえば大丈夫なんだけど……。[r]
コスプレしてないと、人の多い場所とか苦手で……」[np]
*p19|
ぶつかった瞬間は、相当慌ててたもんな……。[np]
*p20|
そんな性格なのにコスプレをしているということは、[r]
それだけ、コスプレが好き、ということだろう。[np]
*p21|
セーラコスで外に出ることも恥ずかしくないらしいし。[r]
俺が思うよりも遥かに熱意に満ちているのかもしれない。[np]
@chr st01bab08
@dchr st01bab03 delay=1200
*p22|
@nm t="聖良" s=sei_0170
「あ……！　た、立ち話もなんだし、入って……？」[np]
@chr st01bab05
*p23|
@nm t="聖良" s=sei_0171
「リビングで適当にくつろいでくれてていいから」[np]
@chr st01aab01
*p24|
言いながら聖良が玄関扉に鍵をさして回す。[np]
*p25|
@nm t="千尋"
「くつろいでてって……聖良は？」[np]
@chr st01aab02
*p26|
@nm t="聖良" s=sei_0172
「わたしは部屋で着替えてこようと思って……」[np]
@chr st01bab03
*p27|
@nm t="聖良" s=sei_0173
「１５分くらい、待っててもらえる……？」[np]
@chr st01bab02
*p28|
@nm t="千尋"
「あ、ああ」[np]
@hide
@eff_all_delete
@bg storage=bg_01a
@show
*p29|
平静を装うこともできず、緊張で声を上ずらせつつ頷く。[np]
*p30|
セーラのコスプレを見ても、[r]
決して勃起しないように心を落ち着かせておかなければ……。[np]
@hide
@black
@wait time=1000
@bg storage=bg_07a
@show
*p31|
@nm t="千尋"
「おお……！　こ、ここはまさに写真の……！」[np]
*p32|
間違いない。[r]
聖良から送られてきた写真はここで撮られたものだ。[np]
*p33|
なんていうんだろう、直に目にすると、[r]
なんだか変な興奮が沸いてくるな。[np]
[se storage="動物_ゾウ_鳴き声_00" buf=0 delay=0]
*p34|
@nm t="千尋"
「っと、いかん。心を落ち着かせなければ……！」[np]
@fose buf=0 time=200
@hide
@black rule=rule_02_o_i_tb
@show
*p35|
女の子の家というか部屋というか、そういう状況もあってか、[r]
心と身体とチンコがそわそわしている。[np]
*p36|
落ち着くんだ……聖良は確かにどことなくセーラを思い出せる雰囲気で、[r]
油断するとついついドキリとしてしまうが、俺は２次元を愛でる男だ。[np]
*p37|
聖良もあくまで、作家としての俺を気遣って、[r]
励まそうとしてくれているだけ。[np]
*p37a|
いくらコス姿も素晴らしいとは言え、聖良は３次元。[r]
俺なら、そこに現を抜かすようなこと、ありえるはずが──[np]
*p38|
@nm t="女の子" rt="莉瑠" s=rir_0000
「聖良ー？　帰ってきたんです――」[np]
@fobgm time=2000
@hide
@bg storage=bg_07a rule=rule_02_i_o_tb
@show
@chr_walk way=r st02aca09=8
@sbgm
*p39|
@nm t="女の子" rt="莉瑠" s=rir_0001
「か……？」[np]
[se storage="動物_ゾウ_鳴き声_00" buf=0 delay=0]
@mq_small
*p40|
@nm t="千尋"
「っっ！！？」[np]
@bgm storage=bgm_07
@chr st02aca12
*p41|
裸。裸の女の子だ。すごい、あんな風になってるんだ……。[np]
*p41a|
いや、違う違う……危ない、完全に虚を突かれた。[r]
生まれて初めて見た生身の女の子の裸に、思わずピクっと来た。[np]
*p42|
……とはいえ、やはり俺は大丈夫だったな。[r]
生の裸を見せられてもチンピクレベルだ。[np]
*p43|
やはり俺をフル勃起させられるのは、[r]
セーラとリルルだけ――[np]
@chr st02aca14
@dchr st02aca16 delay=900
@dchr st02aca09 delay=3000
@dchr st02aca08 delay=4300
*p44|
@nm t="女の子" rt="莉瑠" s=rir_0002
「～～っっ！！？　だだだ、誰ですか、あなたは！！？[r]
どうやって中に――か、鍵をかけておいたはず……！！」[np]
*p45|
@nm t="千尋"
「え…………あ、いや、俺はっ！！」[np]
@chr st02aca14
*p46|
我に返って全裸の少女に事情を説明しようとする――が。[np]
@chr st02bca06
[se storage="投 (3)" buf=0 delay=0]
*p47|
@nm t="女の子" rt="莉瑠" s=rir_0003
「～～っっ！！　近づかないで下さいっっ！！」[np]
@chr st02bca07
[se storage="ベッドから慌てて起き上がる" buf=0 delay=0]
@q_small
*p48|
@nm t="千尋"
「ぐはっ！！？」[np]
@chr_del_walk way=l name=莉瑠 time=200
*p49|
少女が近場にあったクッションを投げつけてくる。[np]
*p50|
その間に少女はテーブルに[r]
置いてあったスマホへ手を伸ばした。[np]
*p51|
@nm t="女の子" rt="莉瑠" s=rir_0004
「けけけ、警察をっっ……！！[r]
警察を呼ばないと……！！」[np]
@q_small
@bg storage=bg_07a_l left=-1280 top=-460 st02bca13=6.8 time=250
*p52|
@nm t="千尋"
「待って待って待ってください！！　俺は聖良に案内されて──」[np]
@chr st02aca08
@dchr st02aca16 delay=900
[dse storage="投 (3)" buf=0 delay=2900]
@dchr_quake name="莉瑠" sx=-2 xcnt=2 sy=10 ycnt=1 time=150 loop=false fade=false delay=2900
@dchr st02bca12 delay=2900
[dse storage="投 (2)" buf=0 delay=3800]
@dchr_quake name="莉瑠" sx=-2 xcnt=2 sy=10 ycnt=1 time=150 loop=false fade=false delay=3800
@dchr st02bca06 delay=3800
@dchr_quake name="莉瑠" sx=-2 xcnt=2 sy=10 ycnt=1 time=150 loop=false fade=false delay=4600
@dchr st02bca07 delay=4600
*p53|
@nm t="女の子" rt="莉瑠" s=rir_0005
「ひぃっ！！？　だから近づかないで下さいっ……！[r]
変態っ、キモいっ、不審者っ……！！」[np]
[se storage="ベッドから慌てて起き上がる" buf=0 delay=0]
@q_small
@wait time=500
[se storage="コミカル_殴 (3)" buf=0]
@eff obj=0 page=back show=true storage=bg_07a_l path=(930,-2870,255) size=(2,2) time=1 ysize=(2.5,2.5) correct=false
@q_small
@bg storage=bg_07a time=250
*p54|
@nm t="千尋"
「ぐっ、あっ、ふごっ！？」[np]
*p55|
立て続けにクッションやら写真立てやらを[r]
投げつけられて、思わず倒れ伏してしまう。[np]
*p56|
この状況はマズい――[np]
*p57|
@nm t="女の子" rt="莉瑠" s=rir_0006
「も、もしもしっ！　もしも――ちょっ！？[r]
なんでこんな時に限って充電切れなんですかっ！？」[np]
@eff_all_delete
@q_small
@bg storage=bg_07a rule=rule_03_t_b time=200
*p58|
@nm t="千尋"
「お、落ち着いてくれ……頼む！[r]
俺は聖良に案内されて来ただけなんだって……！」[np]
*p59|
@nm t="女の子" rt="莉瑠" s=rir_0007
「はぁ！？　あの人見知りが男を案内できるわけ[r]
ないでしょうが！　適当なこと言わないで下さい……！」[np]
@bg storage=bg_07a_l left=-1280 top=-460 st02aca09=6.8 time=250
*p60|
@nm t="千尋"
「て、適当なことは言ってない。君はアレだろ、[r]
聖良の妹だろう？　そんでもって、[r]
アエット・リエットのリエットだろ……！？」[np]
@chr st02bca09
@dchr st02bca07 delay=600
*p61|
@nm t="女の子" rt="莉瑠" s=rir_0008
「は――？　ど、どうして、それを……！？」[np]
*p62|
@nm t="千尋"
「だから聖良と話してるうちに――というか、[r]
適当いってるわけじゃないってわかってもらえるかな……」[np]
@chr st02bca13
*p63|
図星だったのか少女が動きを止めたのが気配でわかった。[np]
*p64|
良し。これで冷静に話ができれば――[np]
@chr st02aca11
*p65|
@nm t="女の子" rt="莉瑠" s=rir_0009
「……れた……」[np]
*p66|
@nm t="千尋"
「え？」[np]
@chr st02aca03
@dchr st02aca07 delay=2200
@dchr st02aca06 delay=4000
*p67|
@nm t="女の子" rt="莉瑠" s=rir_0010
「ふ、ふふ。どうやらあなた、知ってはいけないことを[r]
知ってしまったらしいですね……」[np]
@chr st02bca15
*p68|
@nm t="女の子" rt="莉瑠" s=rir_0011
「あなたを帰すわけにはいかなくなりました」[np]
@chr st02bca05
@dchr st02bca08 delay=1800
*p69|
@nm t="女の子" rt="莉瑠" s=rir_0012
「その命――……ここに置いていってもらいますよ」[np]
@chr st02bca07
*p70|
@nm t="千尋"
「は、はぁ！？　一体何を言って――」[np]
@chr st02bca06
*p71|
@nm t="女の子" rt="莉瑠" s=rir_0013
「問答無用――！！」[np]
@chr_quake name="莉瑠" sx=3 xcnt=2 sy=10 ycnt=1 time=150 loop=false fade=false delay=0
@chr_del name=莉瑠 time=200
*p72|
@nm t="千尋"
「ちょっ！？」[np]
@bg storage=bg_07a rule=rule_spiral51_i_o time=200
*p73|
全裸少女がその辺のクッション片手に突っ込んでくる。[r]
もう、正直どうしていいやら――[np]
[se storage="転_こける" buf=0 delay=0]
@mq_normal
*p74|
@nm t="女の子" rt="莉瑠" s=rir_0014
「――ぶふっ！！？」[np]
*p75|
……転けた。めちゃくちゃ豪快に……痛そう。[np]
*p76|
@nm t="千尋"
「お、おい……大丈夫か？」[np]
@mq_small
*p77|
@nm t="女の子" rt="莉瑠" s=rir_0015
「～～っっ。ち、近づかないで下さいってば……！！」[np]
*p78|
半泣きで叫ぶ少女。なんとなく見ていられない。[np]
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
[wait time=200]
@chr_walk way=r st01acb14=8,1
@dchr st01acb13 delay=1500
@dchr st01bcb08 delay=3800
*p79|
@nm t="聖良" s=sei_0174
「ど、どした……の？[r]
なんだかすごい音が――って」[np]
@chr_walk way=l st02aca18=6.5 time=200
@wt
@wm
@chr_quake name="聖良" sx=5 xcnt=3 sy=5 ycnt=2 time=200 loop=false fade=false delay=0
@wq
@chr st01acb15
@dchr st02aca08 delay=1300
@dchr st02aca18 delay=2500
*p80|
@nm t="女の子" rt="莉瑠" s=rir_0016
「せ、聖良……！　不審者が、不審者がぁ……！！」[np]
@chr st02aca12 st01acb07
@dchr st01acb17 delay=1400
@dchr st01acb13 delay=4100
*p81|
@nm t="聖良" s=sei_0175
「えっ？　えっ？　ど、どういう、状況……？[r]
どうして裸？　とりあえず、えと。よしよし……」[np]
@chr st02aca13
*p82|
少女が聖良に泣きつく。[np]
@chr st01bcb07
*p83|
そんな彼女の頭を優しく撫でながら、[r]
聖良は俺に説明を求めるような視線を送ってきた。[np]
*p84|
とはいっても……俺には何がなんやらなんだけど。[np]
@fobgm time=2000
@hide
@black rule=rule_spiral01
@wbgm
@wait time=1000
@bg storage=bg_07a_l rule=rule_spiral01 left=-330 top=-460 st02abb09=3 st01bbb16=7,1
@bgm storage=bgm_04
@show
@dchr st01bbb03 delay=1500
@dchr st01abb02 delay=4200
*p85|
@nm t="聖良" s=sei_0176
「えと……。紹介する、ね？[r]
この子が妹の莉瑠ちゃん……だよ？」[np]
@chr st01abb01
*p86|
@nm t="千尋"
「ふ、藤原千尋、と言います……その、よろしく？」[np]
@chr st02abb12
*p87|
@nm t="莉瑠" s=rir_0017
「…………」[np]
@chr st01abb10
*p88|
@nm t="聖良" s=sei_0177
「莉瑠ちゃん、無視しちゃ、メっ……だよ？」[np]
@chr st02abb09 st01abb07
@dchr st01abb13 delay=3600
*p89|
@nm t="聖良" s=sei_0178
「連絡してなかったわたしも悪かったけど、[r]
莉瑠ちゃんも悪かった……から」[np]
@chr st02abb11
*p90|
@nm t="莉瑠" s=rir_0018
「……言われなくともわかってますよ」[np]
@chr st02abb12 st01abb05
@dchr st02abb08 delay=1200
*p91|
@nm t="莉瑠" s=rir_0019
「でもまさか部屋に知らない男の人がいるとは[r]
思わないじゃないですか」[np]
@chr st02abb09
*p92|
@nm t="莉瑠" s=rir_0020
「しかもアエット・リエットの正体まで明かして……」[np]
@chr st02abb08 st01abb07
*p93|
@nm t="莉瑠" s=rir_0021
「絶対に誰にもバラさないでって言いましたよね？」[np]
@chr st02bbb07
*p94|
@nm t="莉瑠" s=rir_0022
「私、顔バレは絶対の絶対にしたくないって言ってましたよね？」[np]
@chr st01bbb17
@dchr st01bbb07 delay=3400
*p95|
@nm t="聖良" s=sei_0179
「それは、えと。ごめん、ね……？」[np]
@chr st02abb11 st01bbb12
@dchr st01bbb10 delay=2400
*p96|
@nm t="聖良" s=sei_0180
「でも、その。[r]
千尋くんは言いふらすような人じゃない、よ……？」[np]
@chr st02abb15
*p97|
@nm t="莉瑠" s=rir_0023
「……どうですかね」[np]
@chr st02abb09 st01bbb07
*p98|
一歩引いた位置から妹さん……莉瑠が訝しげな視線を送ってくる。[np]
*p99|
どうやら彼女は俺たちより一歩先に帰ってきていて、[r]
シャワーを浴びていたらしい。[np]
*p100|
確かに夏真っ盛りの炎天下でゴツいジャケットを着た[r]
男装なんてすれば汗をかいて仕方なかっただろう。[np]
*p101|
そして聖良が帰ってきたと勘違いして、裸のままリビングへ[r]
入ったら――俺がいたということだ。[np]
@chr st01bbb16
@dchr st01bbb03 delay=3500
*p102|
@nm t="聖良" s=sei_0181
「千尋くんは良い人、だよ……？[r]
わたしが足を挫いた時も、助けてくれて……」[np]
@chr st02abb11 st01bbb02
*p103|
@nm t="莉瑠" s=rir_0024
「はぁ……。その程度で良い人って……」[np]
@chr st02abb08 st01bbb16
*p104|
@nm t="莉瑠" s=rir_0025
「下心があって助けたに決まってるじゃないですか」[np]
@chr st02abb15 st01bbb11
@dchr st02abb11 delay=1100
@dchr st02abb09 delay=4300
@dchr st02abb15 delay=6400
*p105|
@nm t="莉瑠" s=rir_0026
「いいですか？　[３次元'リアル]の男はいつも聖良が読んでるような[r]
２次元の男と違うんですよ。迂闊に信用してはいけません」[np]
@chr st02abb09 st01bbb07
*p106|
そう聖良に言い聞かせる莉瑠。[r]
出会い方が悪かったのもあって相当警戒されているようだ。[np]
@chr st02abb15
@dchr st02abb16 st01bbb12 delay=3300
*p111|
@nm t="莉瑠" s=rir_0029
「ともかく聖良は無防備すぎますよ。[r]
ナンパ男をほいほいホテルに連れてきてどうするんです」[np]
@chr st02abb09 st01bbb17
@dchr st01abb17 delay=3300
*p112|
@nm t="聖良" s=sei_0182
「ナ、ナンパ男じゃないよ。千尋くんは、ね――」[np]
@chr st02abb11
@dchr st02abb15 st01abb07 delay=2300
*p113|
@nm t="莉瑠" s=rir_0030
「――じゃあ知り合いなんですか？[r]
いつどこで出会ったんですか？」[np]
@chr st01abb08
@dchr st02abb11 st01bbb07 delay=4100
*p114|
@nm t="聖良" s=sei_0183
「そ、それは今日……だけど。[r]
噴水広場で、えと、ぶつかって……」[np]
@chr st02abb14
@dchr st02bbb06 st01bbb11 delay=1600
@dchr st02bbb12 delay=6400
*p115|
@nm t="莉瑠" s=rir_0031
「ぶつかった！　もしかして、それを運命の出会いだとか[r]
勘違いしちゃったんじゃないでしょうね……！？[r]
頭の中、お花畑過ぎますよ……！？」[np]
@chr st02bbb07 st01bbb17
*p116|
@nm t="聖良" s=sei_0184
「～～っっ！　そ、そういうわけじゃないってば……」[np]
@chr st01bbb12
@dchr st01bbb10 delay=1800
*p117|
@nm t="聖良" s=sei_0185
「でも、えと。運命みたいな偶然があったのも確かで……」[np]
@chr st02abb11
@dchr st02abb12 delay=900
*p118|
@nm t="莉瑠" s=rir_0032
「落ち着いて。落ち着いて下さい、聖良」[np]
@chr st02abb08
@dchr st02abb15 delay=1600
@dchr st02abb11 delay=3300
@dchr st02abb09 delay=5300
*p119|
@nm t="莉瑠" s=rir_0033
「ここは３次元です、２次元じゃありません。[r]
レイヤーが集う島ですが、３次元なんです」[np]
@chr st01bbb17
@dchr st01bbb06 delay=1800
@dchr st01abb17 delay=4300
*p120|
@nm t="聖良" s=sei_0186
「わ、わかってる。わかってるってば。[r]
頭のおかしい人見るような目で見ないでよぉ」[np]
@chr st02abb12 st01abb07
*p121|
当たり前だが全く信用されていないな……。[np]
*p122|
裸を見たのを抜きにしても、彼女にとって俺は[r]
見知らぬ不審者であることは間違いないだろうし。[np]
*p123|
しかしこのままではセーラコスを見ることすらも――[np]
@chr st01abb17
@dchr st01abb13 delay=2500
@dchr st01abb12 delay=7700
*p124|
@nm t="聖良" s=sei_0187
「と、とにかく、ね？　わたし、えと、約束してて……。[r]
千尋くんにセーラコス見せるって……」[np]
@chr st02abb14
*p125|
@nm t="千尋"
「ちょっ――」[np]
@chr st02abb10
*p126|
@nm t="莉瑠" s=rir_0034
「は、はぁ！？　正気ですか！？」[np]
@chr st02abb16 st01abb17
@dchr st02abb14 delay=4400
*p127|
@nm t="莉瑠" s=rir_0035
「あんな痴女みたいな格好で男の前に出たら犯されますよ！？[r]
そうでなくともホテルまで入り込まれてるのに！」[np]
@chr st02abb09 st01abb13
@dchr st01abb12 delay=5700
*p128|
@nm t="聖良" s=sei_0188
「り、莉瑠ちゃんも、着替えてくれない……？[r]
千尋くんに、とろキン合わせ披露したいの……」[np]
@chr_quake name="莉瑠" sx=5 xcnt=5 sy=3 ycnt=3 time=300 loop=false fade=false delay=0
@chr st02bbb09
*p129|
@nm t="莉瑠" s=rir_0036
「話聞いてました！？」[np]
@chr st02bbb07 st01abb14
*p130|
ヤ、ヤバい。どんどんコスプレ姿を見るための[r]
ハードルが高くなっていってる気がする……！[np]
@chr st02bbb11
@dchr st02abb08 delay=1400
@dchr st02abb10 delay=4300
@dchr st02abb15 delay=5900
*p131|
@nm t="莉瑠" s=rir_0037
「いいですか、聖良。何を言われたのか知りませんが、[r]
絶対のぜーったいにやめておいた方がいいです」[np]
@chr st02abb11 st01abb07
@dchr st02abb08 delay=2000
*p132|
@nm t="莉瑠" s=rir_0038
「想像してみて下さい。コスプレとはいえ、[r]
あんな格好で男の人の前に出たら……」[np]
@chr st02abb15
*p133|
@nm t="莉瑠" s=rir_0039
「まず身体中を舐め回すように見られます」[np]
@chr st02abb14 st01abb15
@dchr st02abb08 delay=2900
*p134|
@nm t="莉瑠" s=rir_0040
「そのあと写真撮影するなんて言いながら、[r]
どんどんエッチなポーズを取らされていって……」[np]
@chr st02abb13 st01abb13
@dchr st02abb08 delay=4400
@dchr st02abb14 delay=6200
*p135|
@nm t="莉瑠" s=rir_0041
「それで、は、恥ずかしい場所を見せるように言われたり、[r]
触られたりして……！　最後には――」[np]
@mq_small
*p136|
@nm t="千尋"
「……良い想像力をしてるな。シチュとしては鉄板だ」[np]
@chr st02bbb07
@dchr st02bbb06 delay=900
@dchr st02bbb12 delay=2900
*p137|
@nm t="莉瑠" s=rir_0042
「～～っっ！！　ほら認めましたよ……！！[r]
この人、危ないですってば！」[np]
@chr st02bbb07 st01abb09
@dchr st01abb08 delay=3000
*p138|
@nm t="聖良" s=sei_0189
「ち、違うよ、莉瑠ちゃん……。[r]
千尋くんはそれがお仕事、だから」[np]
@chr_quake name="莉瑠" sx=5 xcnt=10 sy=3 ycnt=7 time=250 loop=false fade=false delay=0
@chr st02bbb09
@dchr st02abb09 st01abb14 delay=2100
*p139|
@nm t="莉瑠" s=rir_0043
「ＡＶ男優ってことですか！？[r]
……その割には童貞臭いような」[np]
@mq_small
*p140|
@nm t="千尋"
「どどど、童貞じゃないし！！」[np]
@chr st01bbb08
@dchr st01bbb16 delay=900
*p141|
@nm t="聖良" s=sei_0190
「えっ……そ、そう、なの……？」[np]
*p142|
@nm t="千尋"
「も、もちろん。セーラやリルルとは[r]
数え切れないくらいエッチしてるからな……脳内で！！」[np]
@chr st02abb14 st01bbb07
*p143|
@nm t="莉瑠" s=rir_0044
「うわぁ……」[np]
*p144|
すごく形容しがたい表情を向けられた。[np]
@chr st01abb02
@dchr st01abb04 delay=3100
*p145|
@nm t="聖良" s=sei_0191
「千尋くんは、ね？　あのティンポジウム先生なんだよ？」[np]
@chr st02abb08 st01abb01
@dchr st02abb12 delay=1100
*p146|
@nm t="莉瑠" s=rir_0045
「……は？　ティンポジウム先生って……」[np]
@chr st01abb02
@dchr st01abb12 delay=2800
*p147|
@nm t="聖良" s=sei_0192
「莉瑠ちゃんも知ってる、よね？[r]
とろキンの作者さん……」[np]
@chr st02abb09 st01abb03
@dchr st02abb08 delay=1500
*p148|
@nm t="莉瑠" s=rir_0046
「は？　作者？　とろキンの？　え？　はぁ？」[np]
@chr st02abb09
*p149|
莉瑠が呆気にとられた様子で俺に視線を向ける。[np]
@chr st02abb11
@dchr st02abb12 delay=1300
*p150|
@nm t="莉瑠" s=rir_0047
「い――いやいや。なんの根拠があって……」[np]
@chr st01abb02
@dchr st01abb12 delay=3400
*p151|
@nm t="聖良" s=sei_0193
「しゃ、写真持ってた、の。わたしたちが[r]
ティンポジウム先生に送った、あの写真……」[np]
@chr st01abb04
*p152|
@nm t="聖良" s=sei_0194
「ほら、これ……」[np]
@chr st02abb15 st01abb03
@dchr_quake name="莉瑠" sx=5 xcnt=10 sy=3 ycnt=7 time=250 loop=false fade=false delay=2400
@dchr st02abb14 delay=2400
*p153|
@nm t="莉瑠" s=rir_0048
「写真って――～～っっ！？」[np]
@chr st02abb16
@dchr st02abb14 st01abb14 delay=1500
@dchr st02abb08 delay=4100
*p154|
@nm t="莉瑠" s=rir_0049
「な、なんですか、これ！？[r]
そもそもティンポジウム先生に送ってたんですか！？[r]
だ、誰にも見せないって約束でしたよね！？」[np]
@chr st02abb09 st01abb17
@dchr st01abb08 delay=1200
*p155|
@nm t="聖良" s=sei_0195
「あ……！　そ、それは、えと……！」[np]
@chr st01abb07
*p156|
聖良、言ってなかったのか。[r]
それは姉妹とはいえ、ちょっと不味いのでは……。[np]
@chr st02bbb11
@dchr st02bbb10 delay=1400
*p157|
@nm t="莉瑠" s=rir_0050
「と、というか、この写真見てわざわざ[r]
島まで駆けつけてきたってことですかっ！？」[np]
@chr st02bbb07
*p158|
@nm t="莉瑠" s=rir_0051
「か、軽くストーカーじゃないですか……！！」[np]
@q_small
[se storage="コミカル_刺さる01" buf=0 delay=0]
@chr st01abb14
*p159|
@nm t="千尋"
「うっ……！」[np]
@chr st01abb17
@dchr st01abb13 delay=3900
*p160|
@nm t="聖良" s=sei_0196
「で、でも、わたしたちのコスプレを見て、[r]
心が奮えたって言ってくれて……」[np]
@chr st02abb09 st01bbb10
*p161|
@nm t="聖良" s=sei_0197
「リアルに存在してるみたいに思ったって言ってくれて……」[np]
@chr st01bbb12
@dchr st01bbb07 delay=3400
*p162|
@nm t="聖良" s=sei_0198
「一目でいいから見てみたいって、[r]
お家を飛び出してきてくれたんだよ……？」[np]
@chr st02abb12
@dchr st02abb13 delay=3400
*p163|
@nm t="莉瑠" s=rir_0052
「わ、私たちのコスプレを見て、[r]
ティンポジウム先生がそんなに……？」[np]
*p164|
莉瑠が仄かに頬を赤らませながら、[r]
俺をちらりと見てくる。[np]
*p165|
羞恥か怒りか、俺には本当のところはわからない。[r]
ただ、悪感情って感じにも見えないような――[np]
@chr st02abb14
@dchr st02bbb08 delay=500
@dchr st02bbb06 delay=2400
@dchr st02bbb12 delay=4900
*p166|
@nm t="莉瑠" s=rir_0053
「ハッ──！？　い、言っておきますけど、[r]
私はあなたのファンじゃないですからね！？[r]
聖良と違ってエッチな漫画も普段全く読みませんし……！！」[np]
@chr st02bbb07 st01bbb08
*p167|
@nm t="千尋"
「そ、そうなのか？」[np]
@chr st02bbb09
@dchr st02abb11 delay=1200
@dchr st02abb15 delay=4700
*p168|
@nm t="莉瑠" s=rir_0054
「そうですよ……！　とろキンは聖良がどうしても[r]
合わせたいって言うから……！　強制的に読まされただけで……！」[np]
@chr st02abb07 st01bbb12
@dchr st02abb10 delay=3000
@dchr st02abb15 delay=5500
*p169|
@nm t="莉瑠" s=rir_0055
「私が学園で何をしているかわかりますか？[r]
生徒会長ですよ、生徒会長……！[r]
生徒会長がエッチな漫画を好き好んで読むわけないでしょう！」[np]
*p170|
その割にはやたらと饒舌なような……[r]
さっきも妄想力がとても逞しかったし。[np]
*p171|
あのシチュエーションの考え方が、なんというか、[r]
シンパシーを感じるんだよな……ムッツリっぽいというか。[np]
@chr st01abb13
@dchr st02abb14 st01abb12 delay=2700
*p172|
@nm t="聖良" s=sei_0199
「お願い、莉瑠ちゃん……。[r]
一目でいいから、見せてあげられない……かな？」[np]
@chr st02abb09 st01abb13
@dchr st01abb17 delay=1600
*p173|
@nm t="聖良" s=sei_0200
「千尋くんに、ティンポジウム先生に、見てもらいたいの……」[np]
@chr st01abb12
*p174|
@nm t="聖良" s=sei_0201
「はるばるここまで来てくれたし……」[np]
@chr st02abb12 st01abb02
@dchr st01abb04 delay=4700
*p175|
@nm t="聖良" s=sei_0202
「わたしたちのコスプレが先生の励みになるなら、[r]
とっても嬉しいし……」[np]
@chr st02bbb09 st01abb03
@dchr st02bbb12 delay=1700
*p176|
@nm t="莉瑠" s=rir_0056
「ま、待って下さい。まだこの人がティンポジウム先生と[r]
決まったわけじゃありませんってば……！」[np]
@chr st02bbb13 st01abb13
@dchr st02bbb07 delay=1300
*p177|
@nm t="莉瑠" s=rir_0057
「あの写真だって、もしかしたら先生から[r]
譲られたものかもしれませんし……！」[np]
@chr st02bbb12
@dchr st02bbb14 delay=1700
@dchr st02abb15 delay=3500
*p178|
@nm t="莉瑠" s=rir_0058
「証明して下さい。あなたが、その。[r]
ティンポジウム先生だって」[np]
@chr st02abb09 st01abb14
*p179|
@nm t="千尋"
「証明って言われても……」[np]
@chr st02abb07
@dchr st02abb02 delay=1700
@dchr st02bbb02 delay=4500
*p180|
@nm t="莉瑠" s=rir_0059
「簡単なことですよ。セーラとリルルを[r]
描いてくれればいいんです。作者なら描けるでしょう？」[np]
@chr st02bbb01 st01bbb07
*p181|
@nm t="千尋"
「それは……そう、だけど」[np]
*p182|
そう。作者なら描けて当たり前だ。[r]
でも、今の俺には――[np]
@chr st02bbb02
*p183|
@nm t="莉瑠" s=rir_0060
「どうしました？」[np]
@chr st02bbb01
*p184|
@nm t="千尋"
「悪いが描けない。……セーラとリルルの姿がぼやけるというか、[r]
これじゃないって感じがして、実はずっと描けてないんだ」[np]
@chr st02bbb10 st01bbb08
*p185|
@nm t="千尋"
「だから、聖良から送られてきた写真を見て……[r]
これだって感じて、心が震えたのかもしれない」[np]
@chr st02bbb11 st01bbb12
@dchr st02bbb13 delay=1800
*p186|
@nm t="莉瑠" s=rir_0061
「た……確かにここ半年ほど更新されてませんが……」[np]
*p187|
莉瑠がぽつりと呟く。[np]
@chr st01bbb07
*p188|
@nm t="聖良" s=sei_0203
「ティンポジウム先生……」[np]
*p189|
……そのうちペンネームは変えよう。[r]
色々台無しだ。[np]
@chr st01abb17
@dchr st01abb13 delay=2600
*p190|
@nm t="聖良" s=sei_0204
「ね、莉瑠ちゃん。先生の力になってあげよ……？」[np]
@chr st02bbb14 st01abb12
@dchr st01abb04 delay=5600
*p191|
@nm t="聖良" s=sei_0205
「莉瑠ちゃんもとろキンの続き、また見たい……よね？」[np]
@chr st02bbb13 st01abb03
*p192|
@nm t="莉瑠" s=rir_0062
「べ、別に私は普段から読んでませんってば」[np]
@chr st02abb12
@dchr st02abb13 delay=2000
*p193|
@nm t="莉瑠" s=rir_0063
「まぁでも……。ひと目見せるくらい、でしたら……まぁ」[np]
@chr st01abb02
*p194|
頬をポリポリとかきつつ、莉瑠が頷く。[r]
……なんだかんだ言いつつも性根は優しいのかもしれない。[np]
@chr st01abb03
*p195|
なんの偶然かリルルにも名前が似ているし。[r]
リルルと同じく不器用な女の子なのかもしれない。[np]
@chr st02abb15
@dchr st02bbb09 delay=1600
@dchr st02bbb13 delay=3900
*p196|
@nm t="莉瑠" s=rir_0064
「でも、その。着てあげる代わりにサイ――」[np]
*p197|
@nm t="千尋"
「サイ？」[np]
@chr st02abb14 st01bbb16
@dchr st02abb08 delay=900
*p198|
@nm t="莉瑠" s=rir_0065
「～～っっ！　い、いえ、なんでもありません……！」[np]
@chr st02abb15
@dchr st02abb14 delay=1200
@dchr st02abb16 delay=2200
*p199|
@nm t="莉瑠" s=rir_0066
「行きましょう、聖良。ちゃちゃっと着替えて、[r]
ちゃちゃっと終わらせますから……！」[np]
@chr st02abb09 st01bbb04
@dchr st01bbb03 delay=1200
@dchr st01bbb05 delay=4500
*p200|
@nm t="聖良" s=sei_0206
「うん。じっくり見せてあげよう、ね？」[np]
@chr st01bbb02
@wt
@chr_del_walk way=r name=聖良莉瑠
*p201|
そうして二人がリビングから出て行く。[np]
*p202|
……本当にあのコスプレ姿を見せてもらえるのか。[np]
*p203|
それが目的で島へとやってきたのは間違いないが、[r]
正直、会えはしないだろうって、どこかで思っていた。[np]
@fobgm time=2000
@hide
@black
@show
*p204|
しかし……実は不安もある。[np]
*p205|
確かに写真で見たコスプレは、すごかった。[np]
*p206|
でも、俺も詳しくはないけど、写真は加工なんか当たり前だろうし、[r]
ポーズもきっちり映えるようにしているはずだ。[np]
*p207|
だから、生で見ると本来見えない部分なんかが見えて、[r]
萎えてしまうなんてことはないだろうか。[np]
*p208|
現金なもので、見られるとなった途端に、[r]
そんな考えが脳裏をよぎりだす――[np]
@hide
@wbgm
@bg storage=bg_07a
@show
*p209|
@nm t="莉瑠" s=rir_0067
「ま、待って下さい……！　まだ心の準備が……！」[np]
*p210|
@nm t="聖良" s=sei_0207
「いいからいいから。いくよ？」[np]
@eff obj=0 storage=al_horizon_030_c path=(640,360,255) size=(1.5,1) time=800 accel=-2
@weff obj=0
*p211|
――扉越しに聞こえてきた声を聞いて、[r]
俺の中には期待と、それより少し大きな不安が募りだす。[np]
*p212|
言ってしまえば、聖良と莉瑠の『声』と、俺の中の[r]
セーラとリルルの『声』のイメージが、合致してないんだ。[np]
*p213|
彼女たちが悪いとか何かが悪いとかじゃなくて、[r]
聖良とセーラ、莉瑠とリルルは別人だ、と感じるというだけだ。[np]
*p214|
勝手に声のイメージを想像していたひいきの漫画がアニメ化し、[r]
キャスティングが想像とまるで違った時に近いかもしれない。[np]
*p215|
わざわざコスプレまでしてくれたのに申し訳ないが、[r]
やはり、期待しすぎていたかもしれない。[np]
*p216|
どうしたって、俺の理想のセーラとリルルは、[r]
２次元世界にしか、存在しえない――[np]
@eff obj=0 storage=al_horizon_030_c path=(640,360,255) size=(1,1.5) time=800 accel=-2
@weff obj=0
@eff_all_delete_now
*p217|
@nm t="聖良" s=sei_0208
「せーの」[np]
@hide
@eff obj=0 page=back show=true storage=bg_07a_l path=(488,-272,255) size=(1.2,1.2) time=1 rad=(55,55) bbx=(5) bby=(5) bbt=true bbs=true correct=false
@eff obj=1 page=back show=true storage=st01bac13 path=(290,760,255) size=(0.7,0.7) time=1 rad=(60,60) absolute=(15001) anm=false
@eff obj=2 page=back show=true storage=st02bac02 path=(-15,517,255) size=(0.7,0.7) time=1 rad=(60,60) absolute=(15002) anm=false
@eff obj=3 page=back show=true storage=al_circle_010_c path=(607,360,255) size=(1.8,1.8) time=1 bbx=(100) bby=(100) bbt=true bbs=true absolute=(15003) mode=pshlight correct=false a_r=255 a_g=230 a_b=255
@bg storage=bg_07a
@show
*p220|
@nm t="セーラ・リルル" rt="聖良・莉瑠" s=gou_0001
「「次元を超えて、会いに来ました――」」[np]
@bgm storage=bgm_09
*p221|
@nm t="千尋"
「っっ！！？」[np]
*p222|
このセリフは物語の始まり、第一話の冒頭で[r]
セーラとリルルが主人公の前に現れた時の……！[np]
*p223|
それに、この声は――[np]
@hide
@eff_all_delete
@bg storage=bg_07a_l left=-1280 top=-460 st01bbc04 time=800
@show
@dchr st01bbc13 delay=1700
@dchr st01bbc03 delay=7200
*p224|
@nm t="セーラ" rt="聖良" s=sei_0210
「ふふふ。ご主人様ったらお目々を真ん丸になさって。[r]
そんなに驚かれて、どう致しましたか？」[np]
@chr st01bbc02
*p225|
@nm t="千尋"
「セセセ、セーラ……！？」[np]
@chr st01bbc05
*p226|
@nm t="セーラ" rt="聖良" s=sei_0211
「はい……セーラです」[np]
@chr st01abc02
@dchr st01abc04 delay=2900
*p227|
@nm t="セーラ" rt="聖良" s=sei_0212
「親愛なるご主人様の従者、セーラですよ？」[np]
@chr st01abc02
@dchr st01abc12 delay=3200
*p228|
@nm t="セーラ" rt="聖良" s=sei_0213
「ご主人様にご奉仕するために……[r]
リルルと共に次元を超えて会いに来ました」[np]
@eff obj=0 storage=bg_07a_l path=(-230,-110,255)(-230,260,255) size=(1.2,1.2) time=20000 accel=-2 bbx=(10) bby=(10) bbt=true bbs=true offsetpath=(0,0,0)(0,0,255) offsettime=1000
@eff obj=1 storage=st01abc05 path=(677,476,255)(677,1017,255) size=(1.2,1.2) time=20000 accel=-2 absolute=(15001) anm=false offsetpath=(0,0,0)(0,0,255) offsettime=1000
*p229|
セーラが３次元に降臨している！[r]
姿形も声も、俺の脳内妄想に合致してる！！[np]
*p230|
それに写真で見るよりよっぽど、[r]
可愛いというか、色っぽいというか……！！[np]
@eff_all_delete
@bg storage=bg_07a_l left=-1280 top=-460 st01abc03
@dchr st01abc02 delay=1600
@dchr st01abc12 delay=6300
*p231|
@nm t="セーラ" rt="聖良" s=sei_0214
「ふふ、大丈夫ですか、ご主人様？[r]
お顔が真っ赤ですよ？」[np]
@chr st01abc01
*p232|
@nm t="千尋"
「いや、えと、そのっ……！！」[np]
@chr st01bbc08
@dchr st01bbc07 delay=4500
@dchr st01bbc05 delay=6100
*p233|
@nm t="セーラ" rt="聖良" s=sei_0215
「もしかしたらお熱があるのかも……。[r]
失礼致しますね？」[np]
@chr_del name=聖良
@wt
@wait time=200
@chr st01bdc15
@wt
@wait time=200
@q_small
*p234|
@nm t="千尋"
「ふぁぁぁああ……！！？」[np]
*p235|
セーラの顔がこんなにも近くに……！！[r]
おでこが当たって……いや、おでこどころか――[np]
@chr st01bdc12
@dchr st01bdc10 delay=6000
*p236|
@nm t="セーラ" rt="聖良" s=sei_0216
「ん……。とても熱い……。[r]
やはりお熱があるようですね……」[np]
@hide
@eff obj=0 page=back show=true storage=bg_07a_l path=(+0.0,260,255) time=1 bbx=(2) bby=(2) bbt=true bbs=true absolute=(1500)
@eff obj=1 page=back show=true storage=al_vertical_080_o path=(640,360,255) time=1 correct=false absolute=(15001) xsize=(0.90,0.90)
@eff obj=2 page=back show=true storage=al_vertical_080_o path=(640,360,255) time=1 absolute=(15002) xsize=(0.87,0.87) correct=false
@eff obj=3 page=back show=true storage=bg_07a_l path=(0,0,255) time=1 bbx=(10) bby=(10) bbt=true bbs=true absolute=(15003) correct=false alphaeffect=2
@eff obj=4 page=back show=true storage=st01bac10 path=(620,1900,255) size=(2,2) time=1 absolute=(15004) anm=false alphaeffect=2
@eff obj=5 page=back show=true storage=sp_聖良_聖女_胸b path=(620,1900,255) size=(2,2) time=1 absolute=(15005) correct=false
@extrans time=300 rule=rule_00_t_b
@show
*p237|
胸が……セーラのおっぱいが大きすぎて、[r]
おっぱいまで、俺に当たってる……！！[np]
*p238|
全神経を接触面に集中させる。[r]
ふにゅっと感じる柔らかさは、まるで雲……！[np]
*p239|
しかも視線を下げれば思わず指を差し入れたい谷間はもちろん、[r]
ピンク色の乳首まで見えてしまいそうで――[np]
@hide
@eff_all_delete
@bg storage=bg_07a_l left=-640 top=-460 st02abc09
@show
*p240|
@nm t="リルル" rt="莉瑠" s=rir_0069
「…………」[np]
*p241|
@nm t="千尋"
「――ハっ！？」[np]
*p242|
冷たい視線を感じて思わずセーラから身を離す。[r]
するとリルルが見つめていることに気づいた。[np]
*p243|
@nm t="セーラ" rt="聖良" s=sei_0217
「ふふ、ほらリルルもご主人様にご挨拶して？」[np]
@chr st02abc14
*p244|
@nm t="リルル" rt="莉瑠" s=rir_0070
「…………っっ」[np]
*p245|
@nm t="千尋"
「リルル……！」[np]
@chr st02abc13
@dchr st02abc15 delay=900
*p246|
@nm t="リルル" rt="莉瑠" s=rir_0071
「あ、あんまりえっちぃ目で見ちゃダメだぞ！」[np]
@chr st02bbc13
@dchr st02bbc14 delay=4300
*p247|
@nm t="リルル" rt="莉瑠" s=rir_0072
「ご主人様がどうしても見たいのなら……その。いいけどさ」[np]
*p248|
リ――リルルだ……！！[r]
リルルが[３次元'リアル]に……！！[np]
@chr st02bbc10
@dchr st02bbc09 delay=1800
*p249|
@nm t="リルル" rt="莉瑠" s=rir_0073
「わわっ。どうして泣いてるんだ、ご主人様っ」[np]
@chr st02bbc11
*p250|
@nm t="千尋"
「すまない、ズビ、感動で涙が……！」[np]
@chr st02abc11
*p251|
@nm t="リルル" rt="莉瑠" s=rir_0074
「……どんだけリルルが好きなんですか」[np]
@chr st02abc09
@dchr st02bbc11 delay=3000
*p252|
@nm t="リルル" rt="莉瑠" s=rir_0075
「とにかく涙拭いて下さい。ほらハンカチ」[np]
@chr_del name=莉瑠
@wt
@wait time=200
@chr st02bdc11
*p253|
@nm t="千尋"
「ズビー……！！」[np]
@chr st02bdc14
@dchr st02bdc13 delay=3800
*p254|
@nm t="リルル" rt="莉瑠" s=rir_0076
「拭いても拭いても出てきますし……。[r]
はぁ……子供じゃないんですから」[np]
@chr st02bdc14
@dchr st02bdc03 delay=1000
@dchr st02bdc02 delay=2700
*p255|
@nm t="リルル" rt="莉瑠" s=rir_0077
「でも……ふふ。こうしてお世話するのも……」[np]
@chr st02bdc01
*p256|
@nm t="千尋"
「え……？」[np]
@chr st02bdc13
@dchr st02bdc08 delay=800
@dchr st02bdc09 delay=4800
*p257|
@nm t="リルル" rt="莉瑠" s=rir_0078
「～～っっ。な、泣き虫なご主人様だなって思ってただけだ。[r]
ほら顔こっち向けて。こっち」[np]
@chr st02bdc07
*p258|
照れ隠しするようにリルルは[r]
俺の目尻をがしがしと拭ってくる。[np]
@chr st02bdc13
*p259|
両手を広げてがしっと掴めば抱きしめられる距離のリルル。[r]
かぐわしい香気と、かすかに触れるおっぱいが、その実在を証明している。[np]
@hide
@eff obj=0 page=back show=true storage=bg_07a_l path=(640,260,255) time=1 bbx=(2) bby=(2) bbt=true bbs=true absolute=(1500) correct=false
@eff obj=1 page=back show=true storage=al_vertical_080_o path=(640,360,255) time=1 flipud=true absolute=(15001) xsize=(0.8,0.8) correct=false
@eff obj=2 page=back show=true storage=al_vertical_080_o path=(640,360,255) time=1 flipud=true absolute=(15002) xsize=(0.77,0.77) correct=false
@eff obj=3 page=back show=true storage=bg_07a_l path=(0,0,255) time=1 bbx=(10) bby=(10) bbt=true bbs=true absolute=(15003) correct=false alphaeffect=2
@eff obj=4 page=back show=true storage=st02bac13 path=(640,1410,255) size=(2,2) time=1 absolute=(15004) anm=false alphaeffect=2
@eff obj=5 page=back show=true storage=sp_莉瑠_聖女_胸b path=(640,1410,255) size=(2,2) time=1 absolute=(15005)
@extrans time=300 rule=rule_00_t_b
@show
*p260|
セーラとの衣装の差もあって、谷間が強調されるのもまたエッチだ。[np]
*p261|
ムッチリとしたおっぱいの質感、そして乳首辺りの膨らみと陰り。[np]
*p262|
視界を占める幸せを噛みしめるうちに……気づけば、俺は勃起していた。[r]
半年ぶりの疼きとズボンが突っ張って痛くて、[r]
思わず前屈みになってしまう。[np]
*p263|
そうすると、ますます視線が胸に――[np]
*p264|
@nm t="リルル" rt="莉瑠" s=rir_0079
「～～っっ！　さ、さっきから[r]
どこ見てるんですか、この変態……！！」[np]
@eff_all_delete
@q_small
@bg storage=bg_07a_l left=-640 top=-460 st02bbc07 time=250
*p265|
@nm t="千尋"
「す、すまないっ！」[np]
*p266|
リルルが慌てた様子で俺から身を離す。[r]
不意に出た莉瑠の素の声を聞いて俺も我に返った。[np]
@fobgm time=2000
@hide
@bg storage=bg_07a st01acc13=7
@bgm storage=bgm_02
@show
@chr_walk way=l st02acc10=5.3,1 time=250
@dchr st02acc16 delay=2000
@dchr st02acc14 delay=2800
*p267|
@nm t="莉瑠" s=rir_0080
「こ、この人、がっつり見てましたよ、がっつり……！[r]
私の胸も、聖良の胸もっ……！！」[np]
@chr st01acc03
@dchr st01acc04 delay=1400
@dchr st01acc06 delay=3500
*p268|
@nm t="聖良" s=sei_0218
「ふふ、良かったね？　エッチな目で見てもらえて」[np]
@chr_quake name="莉瑠" sx=3 xcnt=5 sy=2 ycnt=3 time=250 loop=false fade=false delay=0
@chr st02acc10 st01acc05
*p269|
@nm t="莉瑠" s=rir_0081
「良くないから言ってるんですよ！？」[np]
@chr st02acc09 st01acc14
*p270|
せ、聖良と莉瑠だ……。[np]
*p271|
セーラとリルルにしか見えないのに……。[np]
@chr st01bcc03
@dchr st01bcc05 delay=1600
*p272|
@nm t="聖良" s=sei_0219
「それより……どう、だった？」[np]
@chr st02acc11 st01bcc13
*p273|
@nm t="聖良" s=sei_0220
「心、奮えた……かな？」[np]
@chr st01bcc02
*p274|
@nm t="千尋"
「あ――ああ。奮えた、すごく……。[r]
今もドキドキしてる……」[np]
@chr st02bcc13 st01bcc05
@dchr st01acc06 delay=4100
*p275|
@nm t="聖良" s=sei_0221
「えへへ、なら良かった。[r]
わたしもすごくドキドキしちゃった……」[np]
@chr st01acc02
@dchr st01acc04 delay=1600
@dchr st01acc12 delay=4200
*p276|
@nm t="聖良" s=sei_0222
「ずっと、ね？　してみたかったんだ。[r]
セーラのロールプレイ……」[np]
@chr st02acc09 st01acc05
*p277|
@nm t="千尋"
「ロ、ロールプレイ？」[np]
@chr st01acc03
@dchr st01bcc03 delay=1300
*p278|
@nm t="聖良" s=sei_0223
「うん。キャラになりきって行動するの……」[np]
@chr st01bcc05
@dchr st01bcc13 delay=5400
*p279|
@nm t="聖良" s=sei_0224
「さっきのも、ご主人様があれだけ顔を赤くしていたら、[r]
セーラならきっとおでこをくっつけると思ってしてみたの」[np]
@chr st02acc11 st01bcc10
*p280|
@nm t="聖良" s=sei_0225
「間違ってなかった、かな？」[np]
@chr st02acc12
*p281|
た、確かにセーラならそうするはずだ。[np]
*p282|
だからこそ俺はセーラが、ここにいると感じたんだ。[np]
@chr st02acc09
@dchr st02acc11 delay=3400
*p283|
@nm t="莉瑠" s=rir_0082
「聖良は無駄に演技だけは上手いですからね……。[r]
コスプレ中はいつも別人になるというか……」[np]
@chr st01acc15
@dchr st01acc02 delay=1400
@dchr st01acc04 delay=4600
*p284|
@nm t="聖良" s=sei_0226
「莉瑠ちゃんも、リルルの演技は上手だよ……ね？」[np]
@chr st02acc14 st01acc12
@dchr st01acc04 delay=1900
*p285|
@nm t="聖良" s=sei_0227
「いつもは照れて、キャラ台詞も言ったりしないのに……」[np]
@chr st01acc02
@dchr st01acc06 delay=1800
*p286|
@nm t="聖良" s=sei_0228
「さっきの言動、リルルみたいだった……よ？」[np]
@chr st02acc13 st01acc05
@dchr st02acc16 delay=900
@dchr st02acc15 delay=2700
*p287|
@nm t="莉瑠" s=rir_0083
「～～っっ。う、うるさいですね……！[r]
聖良に合わせて演じてみただけですよ……！」[np]
@chr st01acc03
*p288|
自分を恥じる。自分を殴りたい気分だ。[np]
*p289|
二人のコスプレ姿を見てもダメかもなんて思っていた自分は、[r]
本当になっちゃいなかった。[np]
*p290|
本当に、素晴らしいコスプレだ。[r]
今なら前よりも鮮明に、エロいセーラとリルルの姿を描ける気さえする。[np]
@chr st01bcc03
@dchr st01bcc05 delay=1600
*p291|
@nm t="聖良" s=sei_0229
「衣装もね？　頑張って作ったんだよ？」[np]
@chr st02acc09 st01bcc15
*p292|
@nm t="聖良" s=sei_0230
「特に胸元やショーツの生地を何にするか悩んで……」[np]
@chr st01bcc16
@dchr st01bcc07 delay=4900
@dchr st01bcc01 delay=8500
*p293|
@nm t="聖良" s=sei_0231
「最初は使い慣れたギャバを使ってみたんだけどね？[r]
なんだか光沢が足りなくて。金糸の装飾も浮いちゃうし」[np]
@chr st01bcc03
*p294|
@nm t="聖良" s=sei_0232
「それで厚手のサテン生地を使ってみたんだ」[np]
@chr st01acc04
@dchr st01acc02 delay=3700
*p295|
@nm t="聖良" s=sei_0233
「そしたらグっと煌びやかさが増して、装飾映えもして」[np]
@chr st01acc14
@dchr st01acc15 delay=2500
*p296|
@nm t="聖良" s=sei_0234
「ベールはソフトチュールとオーガンジーの[r]
どっちも試してみたんだけど……」[np]
@chr st01bcc03
@dchr st01bcc05 delay=3600
*p297|
@nm t="聖良" s=sei_0235
「セレスティアスタイルの聖女らしさを表現するには[r]
やっぱり透明感重視かなって思ってオーガンジーにしちゃった」[np]
@chr st02acc12 st01bcc08
@dchr st01bcc03 delay=3500
@dchr st01bcc05 delay=7100
*p298|
@nm t="聖良" s=sei_0236
「あ、でも靴の部分だけはね？　ボリューム出したくて、[r]
ハードチュール使ってるの。あと宝石類は――」[np]
@chr st02acc11
@dchr st02acc08 st01bcc16 delay=2700
*p299|
@nm t="莉瑠" s=rir_0084
「――そこまでにしておくんですね、聖良。[r]
イチイチ解説してたら日が暮れますよ」[np]
@chr st02acc09 st01bcc08
@dchr st01acc09 delay=900
@dchr st01acc12 delay=3200
*p300|
@nm t="聖良" s=sei_0237
「あっ……！　そ、そだよね……！　ごめんなさい……」[np]
@chr st01acc01
*p301|
@nm t="千尋"
「い、いや。素晴らしいクオリティだと思う……。[r]
これを一から作れるとは……」[np]
@chr st01acc12
@dchr st01bcc05 delay=1400
@dchr st01bcc03 delay=6900
*p302|
@nm t="聖良" s=sei_0238
「えへへ……。衣装作りはレイヤーにとって、[r]
青春みたいなものだから……。ね、莉瑠ちゃん……？」[np]
@chr st02acc15 st01bcc02
*p303|
@nm t="莉瑠" s=rir_0085
「それは衣装作りを一切手伝わない私への嫌みですか……」[np]
@chr st02acc11 st01bcc08
@dchr st02acc12 delay=3100
*p304|
@nm t="莉瑠" s=rir_0086
「まぁ別に手を出してもいいんですよ？　聖良が丹精込めて[r]
作った衣装が台無しになるだけですから」[np]
@chr st01bcc17
@dchr st01bcc01 delay=3600
*p305|
@nm t="聖良" s=sei_0239
「莉瑠ちゃんはちょっと不器用なだけだから……[r]
練習すればきっと……」[np]
@chr st02acc14
@dchr st02acc15 st01bcc11 delay=2500
@dchr st02acc11 delay=5300
*p306|
@nm t="莉瑠" s=rir_0087
「は？　ケンカ売ってるんですか？[r]
適材適所ですよ、適材適所！！[r]
聖良は一人じゃ布も買いに行けないんですから！」[np]
@chr st02acc09 st01bcc07
@dchr st01acc08 delay=1000
*p307|
@nm t="聖良" s=sei_0240
「はぅ……。そ、それは言わないで、莉瑠ちゃん……」[np]
@chr st01acc17
@dchr st01acc13 delay=4200
*p308|
@nm t="聖良" s=sei_0241
「わたしはただ衣装作り楽しいよって莉瑠ちゃんに[r]
言いたかっただけ、で……」[np]
@chr st02acc11 st01acc07
*p309|
しかし本当に素晴らしいクオリティだ……。[np]
@chr st02acc08
*p310|
聖良と莉瑠と話しているはずなのに、[r]
セーラやリルルと話している気がしてくる。[np]
@chr st02acc09 st01acc12
*p311|
チンコも――正直、勃起しっぱなしで先っちょぬるぬるしてきた。[np]
@chr st01bcc10
@dchr st01bcc03 delay=1700
@dchr st01bcc05 delay=6300
*p312|
@nm t="聖良" s=sei_0242
「あ、あの。他の衣装にも着替えてきて……いい？[r]
良ければ全部のスタイルのコス、見てもらいたくて……」[np]
@chr st01bcc04
*p313|
@nm t="千尋"
「も、もちろん……お、お願いします！！」[np]
@hide
@eff obj=0 page=back show=true storage=black path=(640,360,100) time=1
@bg storage=bg_07a st02acc12=5.3,1 st01bcc02=7
@show
*p314|
漫画内の設定として、セーラとリルルには[r]
入霊――『エヴォーク』という特殊能力が備わっている。[np]
*p315|
簡単に言えば自分自身に精霊を憑依させる力だ。[np]
*p316|
『とろとろ★エヴォーキング』というエロ漫画の醍醐味は[r]
この憑依能力という設定にある。[np]
*p317|
何故なら、憑依した精霊によってセーラやリルルの性格と[r]
見た目が変わり、いろんな二人とプレイを楽しめるからだ。[np]
*p318|
いま聖良と莉瑠がコスプレしているのは、[r]
聖女としてのありのままの姿――『セレスティアスタイル』。[np]
*p319|
俺のことが大好きで、どんなお願いも聞いてくれて、[r]
服もエロくて、おっぱいもデカくて、エッチも上手い、[r]
――そんな女の子に癒やされたいという俺の欲望の結晶。[np]
*p320|
ご奉仕Ｈ担当のスタイルとなっている。[np]
*p321|
そして現在、漫画内に登場させているスタイルは、[r]
セレスティアスタイルを含めて４種類。[np]
*p322|
黒化して性格が反転した二人に色仕掛けや言葉責めをされる[r]
主人公受け身系Ｈ担当の『ダークネススタイル』。[np]
*p323|
主従関係を超えて恋人や妹のように接しながらイチャラブする[r]
甘々デレデレＨ担当の『チャーミングスタイル』。[np]
*p324|
凛々しい戦士然としたセーラとリルルが魔王に快楽調教されていく[r]
凌辱Ｈ担当の『ヴァリアントスタイル』。[np]
*p325|
『とろキン』のコスをするというのなら、[r]
この辺りもぜひ見てみたいと思ってはいたけど……。[np]
*p326|
先程の事で、さらに期待で胸がいっぱいになってくる。[np]
@hide
@eff_all_delete
@bg storage=bg_07a st02acc12=5.3,1 st01bcc02=7
@show
@chr st02bcc07
@dchr st02bcc12 delay=2500
*p327|
@nm t="莉瑠" s=rir_0088
「か、勘違いしないで下さいね？[r]
聖良にお願いされたので仕方なくですからね」[np]
@chr st02bcc07 st01bcc04
@dchr st01acc02 delay=1200
@dchr st01acc04 delay=3500
*p328|
@nm t="聖良" s=sei_0243
「ふふ。そんなこと言って……。[r]
莉瑠ちゃんも楽しくなってきたん、でしょ……？」[np]
@chr st02acc14 st01acc03
*p329|
@nm t="莉瑠" s=rir_0089
「そ、そんなことは……！」[np]
@chr st02acc12 st01acc14
@dchr st01acc02 delay=2100
*p330|
@nm t="聖良" s=sei_0244
「あ……そうだ。お部屋も替えよ……？」[np]
@chr st02acc09 st01bcc03
@dchr st01bcc05 delay=2000
@dchr st01bcc13 delay=5100
*p331|
@nm t="聖良" s=sei_0245
「このＶＩＰハウス、ね？　色々なお部屋、あるから……。[r]
せっかくだし、コスに合ったお部屋で見て欲しい……な？」[np]
@chr st01bcc05
@dchr st01bcc04 delay=1800
@dchr st01bcc03 delay=3300
*p332|
@nm t="聖良" s=sei_0246
「その方が……えへへ。もっとコスプレ、[r]
楽しめると思う……から」[np]
@chr st01bcc02
*p333|
@nm t="千尋"
「わ、わかった」[np]
*p334|
しかしこれ以上、刺激的なコスプレを見せられて、[r]
俺は耐えられるだろうか……？[np]
*p335|
今でさえ、結構限界が近いというのに……。[np]
@fobgm time=2000
@hide
@black rule=rule_spiral01
@wbgm
@wait time=1000
@bg storage=bg_09c rule=rule_spiral01
@wait time=500
@eff obj=0 page=back show=true storage=al_vertical_080_o path=(640,210,255) time=1 rad=(90,90) bbx=(1) bby=(1) bbt=true bbs=true xsize=(0.25,0.25) ysize=(2,2) correct=false acb=true a_r=255 a_g=100 a_b=255 a_r2=200 a_g2=50 a_b2=200
@eff obj=1 page=back show=true storage=al_vertical_080_o path=(645,210,255) time=1 rad=(90,90) turn=true bbx=(1) bby=(1) bbt=true bbs=true absolute=(15001) xsize=(0.24,0.24) ysize=(2,2) correct=false
@eff obj=2 page=back show=true storage=bg_09c_l path=(-55,-2266,255) size=(1.5,1.5) time=1 rad=(-10,-10) flipud=true bbx=(2) bby=(2) bbt=true bbs=true absolute=(15002) ysize=(2.5,2.5) correct=false alphaeffect=1
@eff obj=3 page=back show=true storage=black path=(640,360,100) time=1 absolute=(15003) correct=false alphaeffect=1 a_r=100 a_g=20 a_b=100
@eff obj=4 page=both show=true storage=st01adg05 path=(1085,260,255) time=1 rad=(7,7) absolute=(15004) clear=false anm=false alphaeffect=1
@bg storage=bg_09c
@show
@dceff obj=4 storage=st01adg06 delay=3500
*p336|
@nm t="セーラ" rt="聖良" s=sei_0247
「ふふ……どうしたの？　そんなに鼻息荒くしちゃって」[np]
@ceff_stock obj=4 storage=st01adg05
@eff obj=5 page=back show=true storage=al_vertical_080_o path=(520,360,255) time=1 flipud=true bbx=(1) bby=(1) bbt=true bbs=true absolute=(15005) xsize=(0.6,0.6) correct=false acb=true a_r=255 a_g=100 a_b=255 a_r2=200 a_g2=50 a_b2=200
@eff obj=6 page=back show=true storage=al_vertical_080_o path=(520,360,255) time=1 turn=true flipud=true bbx=(1) bby=(1) bbt=true bbs=true absolute=(15006) xsize=(0.59,0.59) correct=false
@eff obj=7 page=back show=true storage=bg_09c_l path=(10,-1962,255) size=(1.5,1.5) time=1 flipud=true absolute=(15007) ysize=(2.5,2.5) correct=false alphaeffect=6 bbx=2 bby=2 bbs=true bbt=true
@eff obj=8 page=back show=true storage=black path=(770,360,100) time=1 absolute=(15008) correct=false alphaeffect=6 a_r=100 a_g=20 a_b=100
@eff obj=9 page=back show=true storage=st01bag06 path=(505,1165,255) size=(1.15,1.15) time=1 absolute=(15009) anm=false alphaeffect=6
@eff obj=10 page=back show=true storage=sp_聖良_サキュバス_胸b path=(505,1165,255) size=(1.15,1.15) time=1 absolute=(15010)
@bg storage=bg_09c
*p337|
@nm t="セーラ" rt="聖良" s=sei_0248
「もしかしてお姉さんの姿見て、興奮しちゃった？」[np]
*p338|
@nm t="千尋"
「～～っっ！！」[np]
@hide
@eff_all_delete
@bg storage=bg_09c
@wait time=500
@eff obj=0 page=back show=true storage=al_vertical_080_o path=(640,210,255) time=1 rad=(-90,-90) bbx=(1) bby=(1) bbt=true bbs=true xsize=(0.25,0.25) ysize=(2,2) correct=false acb=true a_r=255 a_g=100 a_b=255 a_r2=200 a_g2=50 a_b2=200
@eff obj=1 page=back show=true storage=al_vertical_080_o path=(645,210,255) time=1 rad=(-90,-90) turn=true bbx=(1) bby=(1) bbt=true bbs=true absolute=(15001) xsize=(0.24,0.24) ysize=(2,2) correct=false
@eff obj=2 page=back show=true storage=bg_09c_l path=(913,-3214,255) size=(2,2) time=1 flipud=true bbx=(2) bby=(2) bbt=true bbs=true absolute=(15002) ysize=(2.5,2.5) correct=false alphaeffect=1
@eff obj=3 page=back show=true storage=black path=(640,360,100) time=1 absolute=(15003) correct=false alphaeffect=1 a_r=100 a_g=20 a_b=100
@eff obj=4 page=back show=true storage=st02adh11 path=(332,300,255) time=1 rad=(-7,-7) absolute=(15004) anm=false alphaeffect=1
@bg storage=bg_09c
@show
@dceff obj=4 storage=st02adh15 delay=4500
*p339|
@nm t="リルル" rt="莉瑠" s=rir_0090
「姿を見ただけでそんなだらしない顔を見せるなんて……。[r]
発情期の犬でも、もう少しお行儀良くするわよ？」[np]
@ceff_stock obj=4 storage=st02adh07
@eff obj=5 page=back show=true storage=al_vertical_080_o path=(800,360,255) time=1 flipud=true bbx=(1) bby=(1) bbt=true bbs=true absolute=(15005) xsize=(0.62,0.62) correct=false acb=true a_r=255 a_g=100 a_b=255 a_r2=200 a_g2=50 a_b2=200
@eff obj=6 page=back show=true storage=al_vertical_080_o path=(800,360,255) time=1 turn=true flipud=true bbx=(1) bby=(1) bbt=true bbs=true absolute=(15006) xsize=(0.61,0.61) correct=false
@eff obj=7 page=back show=true storage=bg_09c_l path=(-400,-1770,255) size=(1.5,1.5) time=1 flipud=true bbx=(2) bby=(2) bbt=true bbs=true absolute=(15007) ysize=(2.5,2.5) correct=false alphaeffect=6
@eff obj=8 page=back show=true storage=black path=(640,360,100) time=1 absolute=(15008) correct=false alphaeffect=6 a_r=100 a_g=20 a_b=100
@eff obj=9 page=back show=true storage=st02bah01 path=(800,1145,255) size=(1.45,1.45) time=1 absolute=(15009) anm=false alphaeffect=6
@eff obj=10 page=back show=true storage=sp_莉瑠_黒魔法使い_胸b path=(800,1145,255) size=(1.45,1.45) time=1 absolute=(15010) correct=false
@bg storage=bg_09c
*p340|
@nm t="リルル" rt="莉瑠" s=rir_0091
「ま……ご主人様に品性を求めるのは酷かもしれないけれど」[np]
*p341|
@nm t="千尋"
「～～っっ！！」[np]
@hide
@eff_all_delete
@bg storage=bg_09c
@show
*p342|
部屋に入ったらと思ったらベッドへ押し倒されて……。[r]
あれやこれやとこの状況なんだけど。[np]
*p343|
というか、サキュバス姿のセーラと魔女姿のリルルがエロい！[r]
いやぁ、我ながらナイスデザインだと思う。わかりやすくていい……！！[np]
@hide
@eff obj=0 page=back show=true storage=sp_bg_09_ぼかし path=(640,360,255) time=1 absolute=(1500)
@bg storage=bg_09c st02aah01=2.5 st01aag05=7,1
@bgm storage=bgm_10
@show
@dchr st01aag06 delay=1300
@dchr st01aag04 delay=4100
*p344|
@nm t="セーラ" rt="聖良" s=sei_0249
「ふふ、お姉さんは嬉しいわよ？[r]
ご主人様がこんなに発情してくれて」[np]
@chr st01aag02
@dchr st01aag06 delay=4900
*p345|
@nm t="セーラ" rt="聖良" s=sei_0250
「今すぐにでも……食べちゃいたいくらい。ご主人様のこと」[np]
@chr st02aah15 st01aag05
@dchr st02aah07 delay=1800
*p346|
@nm t="リルル" rt="莉瑠" s=rir_0092
「私は嫌よ。ご主人様なんて、足蹴にしてあげるくらいが丁度いいわ」[np]
@chr st02aah06
@dchr st02aah05 delay=1400
@dchr st02aah17 delay=3100
*p347|
@nm t="リルル" rt="莉瑠" s=rir_0093
「もっとも……ふふ。変態ご主人様なら、[r]
それでもきっと悦んでしまうのだろうけれど」[np]
@chr st02aah05
*p348|
言いながら二人が――俺のチンコの方へ手足を伸ばしてきて。[np]
@fobgm time=1000
@shide
@eff_all_delete
@q_small
@bg storage=bg_09c time=300
@sshow
*p349|
@nm t="千尋"
「――って、待った待った！？[r]
一体何をする気なんだ、二人とも……！！？」[np]
@bgm storage=bgm_09
@chr_standup st01abg14=7,1
@dchr st01abg13 delay=800
@dchr st01abg07 delay=3200
*p350|
@nm t="聖良" s=sei_0251
「あ――……ご、ごめんなさっ……！[r]
ついセーラになりきりすぎちゃって……」[np]
@chr_standup st02bbh11=3
@dchr st02abh09 delay=3900
*p351|
@nm t="莉瑠" s=rir_0094
「いや、聖良はホントなりきりすぎですよ。[r]
ヤ、ヤバい言葉、口走ってましたからね……？」[np]
@chr st01abg15
@dchr st01abg12 delay=2200
*p352|
@nm t="聖良" s=sei_0252
「い、一度でいいから、セーラみたいに[r]
男の人に迫ってみたく……て……」[np]
@chr st02abh11 st01abg13
*p353|
慌ててベッドから起き上がりつつ、[r]
二人から微妙に距離を取る。[np]
*p354|
……あのまま動かずにいたら、[r]
俺は二人に襲われてしまっていたのだろうか？[np]
*p355|
いや、しかし妄想通り――いや妄想以上だった。[np]
*p356|
普段優しい二人が、サドっ気たっぷりで苛めてくる。[r]
こういうのもいい、と体感して改めて思った。[np]
@chr st02bbh07
*p357|
@nm t="莉瑠" s=rir_0095
「と、というか……」[np]
@chr st02bbh13
@wt
@chr_poschange 莉瑠=3.5
*p358|
莉瑠が顔をほんのり赤くしつつ、聖良に寄り添う。[np]
@chr st02bbh11 st01abg15
@dchr st02bbh14 delay=1500
@dchr st02bbh13 delay=4100
*p359|
@nm t="莉瑠" s=rir_0096
「本気で、その……。ぼ、勃起してましたよね……？[r]
ちょっとネタでなりきってみただけだったのに……」[np]
@chr st01abg13
@Dchr st01abg07 delay=2000
@Dchr st01abg12 delay=4100
*p360|
@nm t="聖良" s=sei_0253
「う……うん。だから、その……。[r]
わたしも頭の中、真っ白になっちゃってつい……」[np]
@chr st01abg05
*p361|
@nm t="千尋"
「……」[np]
@chr st02bbh14 st01abg13
*p362|
なにやらボソボソと言葉を交わす二人。[np]
@chr st01abg15
*p363|
視線がチラりと俺の股間に向かっている気がするのは自意識過剰だろうか。[np]
@chr st02abh09
*p364|
いや、そもそも、バレていたのかもしれない。[np]
@chr st01abg03
*p365|
二人のコスプレとロールプレイに、すっかり俺の股間が[r]
猛りを取り戻してしまっていることに。[np]
@chr st02abh11
*p366|
やはり……スランプ脱却のために必要だったのは、[r]
生のエロスだったのかもしれない。[np]
@chr st02abh09 st01abg05
*p367|
だってすごいもの。聖良なんてさっきよりもさらに露出が増えていて――[np]
@chr st02abh13 st01bbg05
@dchr st01bbg03 delay=1500
*p368|
@nm t="聖良" s=sei_0254
「えへへ……。この衣装も頑張って作ったん、だよ？」[np]
@chr st01bbg08
@dchr st01bbg05 delay=3100
@dchr st01bbg13 delay=6900
*p369|
@nm t="聖良" s=sei_0255
「布部分は基本的にエナメルで……。淫紋も自分で[r]
シール作ったんだ。翼や角は――」[np]
@chr st02abh11 st01bbg04
*p370|
しかし当の本人は気にしていないのか、[r]
嬉しそうに衣装製作について話し始める。[np]
@chr st01abg15
*p371|
厚いエナメル皮で持ち上げられたおっぱいがぱつぱつでスケベだ。[np]
@chr st01abg04
*p372|
淫紋と極小ショーツの組み合わせなんて、[r]
見ているだけで吸精されてしまいそうだ……。[np]
@chr st01abg13
@dchr st01abg12 delay=7600
*p373|
@nm t="聖良" s=sei_0256
「……はぁはぁ。すごく、んっ、見られてる……。[r]
おちんちんも、やっぱりおっきくなってる……」[np]
@chr st02abh14
*p374|
@nm t="千尋"
「へ？」[np]
@chr st02abh12 st01abg16
@dchr st01bbg17 delay=900
@dchr st01bbg10 delay=5900
@dchr st01abg17 delay=8100
*p375|
@nm t="聖良" s=sei_0257
「～～っっ！　し、尻尾もしっかりワイヤーを[r]
通してあるの……！　身体の動きに合わせて、[r]
自然と揺れるような強度に調整してて……！」[np]
@chr st01abg07
*p376|
一瞬何かおかしな言葉が聞こえたような。[r]
聞き間違いだろうか……？[np]
@chr st01bbg17
@dchr st01bbg05 delay=3400
@dchr st01abg12 delay=6000
*p377|
@nm t="聖良" s=sei_0258
「も、もちろん莉瑠ちゃんの衣装もね？[r]
拘って作ってるんだよ？　特にドレス部分が大変で……」[np]
@chr st02abh13 st01abg01
*p378|
@nm t="千尋"
「あ、ああ」[np]
@chr st02bbh14
*p379|
@nm t="莉瑠" s=rir_0097
「べ、別にまじまじ見なくていいですから……！」[np]
@chr st02bbh13 st01abg03
*p380|
莉瑠の魔女コス。[np]
*p381|
一見すると、先程の聖女コスよりも露出が控えめに見えるが……。[np]
@chr st01abg02
@dchr st01abg04 delay=2300
*p382|
@nm t="聖良" s=sei_0259
「えへへ、気づいた？　もちろん、前掛けの下は――」[np]
@chr st01abg01
@wt
@chr_poschange 聖良=6.8
@wm
@chr_quake name="莉瑠" sx=5 xcnt=5 sy=3 ycnt=3 time=300 loop=false fade=false delay=0
@chr st02bbh10
@dchr st02bbh06 delay=700
@dchr st02bbh07 delay=2700
*p383|
@nm t="莉瑠" s=rir_0098
「――ちょぉっ！！？[r]
何をめくりあげようとしてるんですか、何を！？」[np]
@chr st01abg14
@dchr st01abg15 delay=3500
*p384|
@nm t="聖良" s=sei_0260
「だってそこがリルルのダークネススタイルの、[r]
一番のセクシーポイント、だし……」[np]
@chr st02abh08
@dchr st02abh10 delay=2400
*p385|
@nm t="莉瑠" s=rir_0099
「いやいやいや！！　それはそうですけど、[r]
当たり前のように見せるポイントではありませんから！」[np]
@chr st02abh13 st01abg07
*p386|
莉瑠が顔を赤らめて股間を隠す。[np]
*p387|
この反応――やはりそうだったのか。[np]
*p388|
俺は見てしまった。あの短い前掛けの下を。[np]
*p389|
さっき莉瑠が俺のチンコを足蹴にしようとした時に。[np]
*p390|
そう――ノーパンだった。[r]
漫画の設定通りノーパンストッキングだった……！！[np]
@chr st02abh14
@dchr st02abh16 delay=1200
@dchr st02abh12 delay=2700
*p391|
@nm t="莉瑠" s=rir_0100
「～～っっ。言っておきますけど、[r]
これは聖良に完コスを強制させられて……！」[np]
@chr st02abh13 st01abg13
*p392|
@nm t="莉瑠" s=rir_0101
「わ、私はちゃんとショーツ履きたかったのに……！！」[np]
@chr st01abg14
@dchr st02abh12 st01bbg10 delay=4900
*p393|
@nm t="聖良" s=sei_0261
「レイヤーたるもの羞恥心は捨てなきゃ、だよ……？[r]
ショーツなんて履いたら、台無しだもん……」[np]
@chr st02abh09
*p394|
@nm t="莉瑠" s=rir_0102
「せ、聖良はもう少し羞恥心というものを――」[np]
@chr st01bbg05
@dchr st01bbg13 delay=3700
*p395|
@nm t="聖良" s=sei_0262
「じゃあ、次の衣装行こっか。[r]
ふふ、今度はチャーミングスタイル、かな……？」[np]
@chr st02abh14 st01bbg04
*p396|
@nm t="莉瑠" s=rir_0103
「ちょっ……！　は、話はまだ終わって――」[np]
@chr st02abh12 st01bbg16
@dchr st01bbg03 delay=2900
*p397|
@nm t="聖良" s=sei_0263
「千尋くんは、えと……。お風呂で待ってて、くれる……？」[np]
@chr st02abh11 st01abg04
*p398|
@nm t="聖良" s=sei_0264
「今度はチャーミングスタイルの衣装に着替えてくる、から……」[np]
@chr st01abg03
*p399|
@nm t="千尋"
「お、お風呂――！？　裸か水着かは、どうすれば……！？」[np]
@chr st02abh14 st01abg14
@dchr st01abg15 delay=800
@dchr st01abg12 delay=5800
*p400|
@nm t="聖良" s=sei_0265
「えっ……！？　そ、それは、その……。[r]
どっちでもいい……よ？」[np]
@chr st02bbh12 st01abg01
*p401|
@nm t="莉瑠" s=rir_0104
「水着着用に決まってるでしょうに！？」[np]
@chr st02bbh07 st01abg07
*p402|
@nm t="莉瑠" s=rir_0105
「女の子にナニを見せつける気なんですか！？」[np]
*p403|
しかし次はチャーミングスタイルか……。[r]
となると――[np]
@fobgm time=2000
@hide
@black rule=rule_spiral01
@wbgm
@wait time=1000
@bg storage=bg_11a rule=rule_spiral01
@bgm storage=bgm_10
@show
@chr_walk way=r st01aae04=7,1
*p404|
@nm t="セーラ" rt="聖良" s=sei_0266
「――あーるじくんっ？」[np]
@chr st01aae03
@wt
@chr_walk way=l st02bbe04=3
*p405|
@nm t="リルル" rt="莉瑠" s=rir_0106
「えへへ……お兄ちゃん？」[np]
@chr st02bbe03
*p406|
@nm t="千尋"
「お、おおっ……！！」[np]
*p407|
このさっきとは打って変わったデレデレな態度。[r]
まさしくチャーミングスタイルの二人だ。[np]
*p408|
声からして、既に発情しているかのようで甘々で色っぽい。[np]
*p409|
そしてこの露出度満点のビキニベースの衣装。[np]
@hide
@eff obj=0 page=back show=true storage=bg_11a_l path=(580,0,255) size=(1.2,1.2) time=1 rad=(60,60) bbx=(3) bby=(3) bbt=true bbs=true correct=false
@eff obj=1 page=back show=true storage=bg_11a_l path=(580,0,255) size=(1.2,1.2) time=1 rad=(60,60) bbx=(6) bby=(6) bbt=true bbs=true absolute=(15001) mode=pslighten correct=false
@eff obj=2 page=back show=true storage=st01bae13 path=(-325,1010,255) size=(1.2,1.2) time=1 rad=(60,60) absolute=(15002) anm=false
@eff obj=3 page=back show=true storage=al_circle_020_c path=(640,360,255) size=(3,3) time=1 absolute=(15003) mode=psscreen correct=false a_r=200 a_g=150 a_b=200
@bg storage=bg_11a
@show
*p410|
@nm t="セーラ" rt="聖良" s=sei_0267
「ね、主くん？　お姉ちゃんとエッチなことしよ？[r]
主くんとスケベなこと、たくさんしたいな♪」[np]
@hide
@eff_all_delete
@eff obj=4 page=back show=true storage=bg_11a_l path=(488,521,255) size=(1.2,1.2) time=1 rad=(-60,-60) bbx=(3) bby=(3) bbt=true bbs=true absolute=(15000) correct=false
@eff obj=5 page=back show=true storage=bg_11a_l path=(488,521,255) size=(1.2,1.2) time=1 rad=(-60,-60) bbx=(6) bby=(6) bbt=true bbs=true absolute=(15001) mode=pslighten correct=false
@eff obj=6 page=back show=true storage=st02aae17 path=(1375,985,255) size=(1.2,1.2) time=1 rad=(-60,-60) absolute=(15002) anm=false
@eff obj=7 page=back show=true storage=al_circle_020_c path=(640,360,255) size=(3,3) time=1 absolute=(15003) mode=psscreen correct=false a_r=200 a_g=150 a_b=200
@bg storage=bg_11a
@show
*p411|
@nm t="リルル" rt="莉瑠" s=rir_0107
「私もお兄ちゃんとエッチなことしたい……。[r]
お兄ちゃんと……イチャイチャしたい、な？」[np]
@hide
@eff_all_delete
@bg storage=bg_11a st02aae05=1.5 st01aae05=8.5,1 time=800
@show
*p412|
過激なビキニに身を包んだ二人が[r]
左右からぎゅっと抱きついてくる。[np]
*p413|
な、生乳同然の胸が、裸同然の身体が擦りつけられて……！[np]
@chr st01bae18
@dchr st01bae13 delay=2900
@dchr st01bae05 delay=5100
*p414|
@nm t="セーラ" rt="聖良" s=sei_0268
「ちゅっ……ん。大好きだよ？[r]
主くんのこと、お姉ちゃん、だーい好き」[np]
@chr st02aae13 st01bae04
@dchr st02bae17 delay=3300
@dchr st02bae14 delay=4800
@dchr st02bae17 delay=6400
@dchr st02bae14 delay=9600
*p415|
@nm t="リルル" rt="莉瑠" s=rir_0108
「私もお兄ちゃんのこと……ちゅっ。好きぃ……。[r]
はむぅんっ、んっ……。早くエッチ……しよ？」[np]
*p415a|
@nm t="千尋"
「あ、あわわわっ……！！」[np]
*p416|
どれだけノっているのか、セーラとリルルがほっぺにキスしてきた。[r]
頬に触れる柔らかな唇の感触に、ドキドキが止まらない。[np]
*p417|
脳に上がっている熱で、だらしなく口から漏れる荒い息で、[r]
心拍が跳ねあがっていく。[np]
@chr st01bae12
*p418|
別にチンコを触られてるわけでもないのに、[r]
腰奥がむずむずとしてきてしまう――[np]
@fobgm time=2000
@chr_del name=聖良
@wt
@chr st02aae15
@wt
@wait time=250
@chr_del name=莉瑠
@wt
@wait time=500
@chr_walk way=l st02ace09=6,1 st01ace08=8
*p419|
@nm t="千尋"
「ど、どうして離れて――！？」[np]
@chr st02ace14
@dchr st02ace08 delay=1300
@dchr st02ace13 delay=3300
*p420|
@nm t="莉瑠" s=rir_0109
「ホントですよっ……！[r]
聖良が言い出したんじゃないですか！[r]
さっきみたいにロールプレイしてみようって……！」[np]
@bgm storage=bgm_07
@chr st01bce12
@dchr st01bce11 delay=1100、
@dchr st01bce10 delay=4100
*p421|
@nm t="聖良" s=sei_0269
「～～っっ。さ、流石に、その。[r]
恥ずかしくなって、きて……」[np]
@chr st02ace14
@dchr st02bce13 delay=1800
@dchr st02bce07 delay=3100
*p422|
@nm t="莉瑠" s=rir_0110
「だから言ったじゃないですかっ……！！[r]
ほっぺに、キキキ、キスまでさせておいてっ……！！」[np]
@chr st01bce17
@dchr st01bce12 delay=1800
@dchr st01bce10 delay=6200
*p423|
@nm t="聖良" s=sei_0270
「うぅ、だって……。セーラになりきって迫ったら、その。[r]
また勃起してくれるかなって、思って……」[np]
@chr st02bce10
*p424|
@nm t="千尋"
「えっ！？」[np]
@chr st02bce13 st01bce11
@dchr st01ace16 delay=1200
*p425|
@nm t="聖良" s=sei_0271
「～～っっ！！　な、なんでもない……！！」[np]
@chr st01ace08
*p426|
聖良がチラチラと俺の股間を見つめながら、[r]
誤魔化すように首を横に振ってくる。[np]
*p427|
まさか俺を勃起させようとしているのか？[np]
*p428|
そういえばサキュバスコスの時も[r]
何やらひそひそしてたな――って。[np]
*p429|
@nm t="千尋"
「ふ、二人とも……。[r]
何か胸から垂れてない、か？」[np]
@bg storage=bg_11a_l left=-1280 top=-460 st02bbe10=3,1 st01abe14=7
*p432|
@nm t="聖良・莉瑠" rt="聖良・莉瑠" s=gou_0002
「「え？」」[np]
*p433|
乳房の中央――両乳首があるだろう辺りの下から、[r]
うっすらと垂れてきている乳白色の液体が見えた。[np]
@chr st02bbe09 st01abe17
*p434|
あれ、まさか、母乳……？[np]
@chr st01bbe11
@dchr st01bbe17 delay=900
*p435|
@nm t="聖良" s=sei_0273
「～～っっ！！　みみみ、見ないでっ……！！」[np]
@chr st02abe13 st01bbe12
@dchr st01bbe10 delay=1400
@dchr st01abe16 delay=4600
*p436|
@nm t="聖良" s=sei_0274
「これは、えと、たたた、体質でっ……！！[r]
興奮したら、で、出ちゃう体質で……！！」[np]
@chr st02bbe10
@dchr st02bbe09 delay=400
*p437|
@nm t="莉瑠" s=rir_0112
「バっ――何を言ってくれてるんですかっ！？」[np]
@chr st02bbe07 st01abe08
@dchr st02bbe09 delay=1500
*p438|
@nm t="莉瑠" s=rir_0113
「そ、そんなこと言ったら、まるで私たちが[r]
興奮してるみたいに思われちゃうでしょう……！？」[np]
@chr st02bbe07 st01abe07
*p439|
体質……そんなこともあるのか！？[np]
*p440|
しかし実際に二人は母乳を溢れさせてるわけだし……。[np]
@chr st02bbe14
*p441|
@nm t="莉瑠" s=rir_0114
「へ、変な目で見ないで下さいっ……！」[np]
@chr st02abe12 st01bbe01
@dchr st02abe11 delay=2200
*p442|
@nm t="莉瑠" s=rir_0115
「自分でもわかってるんです、[r]
妊娠もしてないのに母乳が出ちゃうなんて……！」[np]
@chr st02abe13
*p443|
@nm t="千尋"
「い、いや。体質的な問題をあれこれ言ったりはしないって……」[np]
@chr st01bbe12
*p444|
あれこれ言うどころか、むしろ、俺には刺さりまくっている。[r]
何を隠そう俺は――[np]
@chr st01bbe10
*p445|
@nm t="聖良" s=sei_0275
「ぼ、母乳好き、だもんね……？」[np]
*p446|
@nm t="千尋"
「っ！？　な、何故それを……！？」[np]
@chr st02abe12 st01abe12
*p447|
@nm t="聖良" s=sei_0276
「とろキン読んでたら丸わかり、だよ……？」[np]
@chr st01abe02
@dchr st01abe04 delay=900
*p448|
@nm t="聖良" s=sei_0277
「セーラもリルルも母乳出してる、から……」[np]
@chr st01abe13
@dchr st01abe15 delay=1800
@dchr st01abe12 delay=3600
@dchr st01abe02 delay=5600
*p449|
@nm t="聖良" s=sei_0278
「急に垂れてきたから、ちょっぴりその、焦ったけど……。[r]
セーラの格好してたら恥ずかしくない、かも……」[np]
@chr st02abe09 st01abe04
@dchr st01abe03 delay=3600
@dchr st01abe02 delay=4700
*p450|
@nm t="聖良" s=sei_0279
「これはこれで完コスの一環だと思えば……えへへ。[r]
よりコスの完成度があがった気もする、し……」[np]
@chr st01abe01
*p451|
確かに母乳が垂れているだけで一段と破壊力が増す。[r]
セーラ口調じゃなくてもチンコがはち切れそうに勃起するほどだ。[np]
@chr st01abe14
@dchr st01abe12 delay=3000
*p452|
@nm t="聖良" s=sei_0280
「あ――……～～っっ。[r]
ま、またビクンビクンして……」[np]
@chr st02abe13 st01bbe12
@dchr st01bbe10 delay=2800
*p453|
@nm t="聖良" s=sei_0281
「どうしよ、はぁはぁ、こんなの見てたら[r]
もっと溢れてきちゃ――」[np]
@chr_poschange 莉瑠=3.5
@wm
@chr st02abe11
*p454|
@nm t="莉瑠" s=rir_0116
「――行きますよ、聖良……！」[np]
@chr st02abe15 st01abe15
*p455|
@nm t="莉瑠" s=rir_0117
「とりあえずある程度搾り出して、着替えましょう……！」[np]
@chr_poschange 莉瑠=4.0
@wm
@chr st01abe14
@dchr st01bbe17 delay=1000
*p456|
@nm t="聖良" s=sei_0282
「えっ？　あ、ちょっ、待って、今――」[np]
@chr_poschange 莉瑠=4.5 聖良=7.3
@wm
@chr st02abe14
@dchr st02abe11 delay=1700
*p457|
@nm t="莉瑠" s=rir_0118
「ま、待ちませんって……！[r]
あんなに見つめてたら変態だと思われますよ……！」[np]
@chr st02abe09 st01bbe11
*p458|
@nm t="莉瑠" s=rir_0119
「いやむしろ既に思われてるかもしれませんが……！」[np]
@chr_poschange 莉瑠=5 聖良=7.6
@wm
@chr st02abe15
@dchr st02abe08 delay=2500
@dchr st02abe11 delay=5700
*p459|
@nm t="莉瑠" s=rir_0120
「興味津々なのはわかりますが、も、もう少し隠して下さい。[r]
痴女だと思われても知りませんからねっ……！？」[np]
@chr_poschange 莉瑠=5.5 聖良=8.0
@wm
@chr st02abe09 st01abe17
@dchr st01abe09 delay=1100
*p460|
@nm t="聖良" s=sei_0283
「～～っっ。そ、そんな露骨だった、かな……？」[np]
@chr_del_walk way=r name=聖良莉瑠
*p461|
莉瑠に引っ張られる形で二人が大浴場から[r]
出て行こうとする。[np]
*p462|
何やら二人で話してるみたいだけど――[np]
*p463|
@nm t="千尋"
「ちょ、ちょっと二人とも……！[r]
俺は一体どうすれば……！！」[np]
@chr_walk way=r st01ace14=9.4
@dchr st01ace02 delay=5400
*p464|
@nm t="聖良" s=sei_0284
「あ……！　今度はヴァリアントスタイルの[r]
コスする、から……！　地下の牢屋で待って、て……！」[np]
@chr st01ace03
@wt
@chr_del_walk way=r name=聖良
*p465|
遠くから叫んでくれる聖良に頷く。[np]
@hide
@bg storage=bg_11a
@show
*p466|
今度こそ勃起するわけにはいかない。[r]
何しろ陵辱系Ｈメインの衣装だ。[np]
*p467|
そんなセーラとリルルのコスをした二人の前で[r]
勃起なんかしたら、レイプ魔のように思われかねない。[np]
*p468|
勃起するにしても心の中だけに留めよう。[r]
決して股間を膨らませるわけにはいかない――[np]
@fobgm time=2000
@hide
@black
@wbgm
@show
*p469|
………………[np]
*p470|
…………[np]
*p471|
……[np]
*p472|
と――思っていたのに。[np]
@hide
@eff obj=0 page=back show=true storage=sp_bg_10c path=(359,360,255) time=1 fliplr=true absolute=(1500) correct=false
@eff obj=1 page=back show=true storage=sp_bg_10c path=(1385,360,255) time=1 absolute=(1501) correct=false
@eff obj=2 page=back show=true storage=sp_000_共通_03_p473_2 path=(640,360,255) time=1 absolute=(15002) correct=false
@eff obj=3 page=back show=true storage=sp_000_共通_03_p473 path=(640,360,255) time=1 absolute=(15003) correct=false
@eff obj=4 page=back show=true storage=bg_10c path=(640,360,255) time=0 bbx=(5) bby=(5) bbt=true bbs=true absolute=(15004) correct=false alphaeffect=3
@bg storage=bg_10c st02bbf07=2.5 st01bbf09=7.5
@show
*p473|
@nm t="聖良" s=sei_0285
「くっ、下劣な……」[np]
@chr st01abf11
*p474|
@nm t="聖良" s=sei_0286
「わたくしたちをどうなさるおつもりですか……」[np]
@chr st02bbf08 st01abf10
@dchr st02bbf12 delay=4900
*p475|
@nm t="莉瑠" s=rir_0121
「ふん。貴様がもし私を辱めようとしているのなら、[r]
覚悟することだな……」[np]
@chr st02bbf07
@dchr st02bbf06 delay=2100
*p476|
@nm t="莉瑠" s=rir_0122
「私に触れたら最期、[r]
あらゆる手段を使って貴様を殺す……！！」[np]
@chr st02bbf07 st01abf10
@dchr st01abf11 delay=1300
@dchr st01bbf09 delay=3600
*p477|
@nm t="聖良" s=sei_0287
「……リルルの言う通りですわ。[r]
わたくしたちを屈服させられると思わないことです」[np]
@chr st01abf10
@dchr st01abf11 delay=4000
*p478|
@nm t="聖良" s=sei_0288
「どんな形であれ、わたくしたちを生き長らえさせれば[r]
貴方はきっと後悔することになりますわ」[np]
@hide
@eff_all_delete
@bg storage=bg_10c
@show
*p479|
壁の首枷で拘束されながらも気丈な顔で[r]
睨みつけてくる二人を見て、恥ずかしげもなく勃起してしまった。[np]
*p480|
というか、どうして拘束されてるんだ！？[r]
俺が来た時には既にこうなっていたんだけど。[np]
*p480a|
こっそりポケットに手を入れ、チンポジを直しながら考えていると、[r]
聖良と莉瑠の表情がふっと柔らかいものへ切り替わる。[np]
@hide
@bg storage=bg_10c_l left=-1280 top=-360 st02bbf13=2.5 st01bbf16=7.5,1
@bgm storage=bgm_10
@show
@dchr st01bbf05 delay=3700
*p481|
@nm t="聖良" s=sei_0289
「単にポーズ取ってるだけ、だよ？[r]
漫画でもセーラとリルルがこうして捕まってる場面あった、し」[np]
@chr st02bbf09 st01bbf04
@dchr st02bbf11 delay=1900
@dchr st02bbf07 st01bbf16 delay=5000
*p482|
@nm t="莉瑠" s=rir_0123
「だ、だからと言って実際に拘束されなくてもいいでしょう。[r]
付き合わされるこっちの身にもなって下さい……！！」[np]
@hide
@bg storage=bg_10c
@show
*p483|
ああ、そうだ。ヴァリアントスタイルが登場する話、[r]
あれのセーラとリルルが魔王の捕虜になったシーンの再現か。[np]
*p484|
漫画だと、この後二人は陵辱・調教されて[r]
俺（魔王）だけの性奴隷へと堕ちていく展開になっている。[np]
*p485|
そう例えば、目の前の二人が――[np]
@hide
@eff obj=0 page=back show=true storage=al_sp_001 path=(640,360,255) time=1 absolute=(15000) a_r=200 a_g=100 a_b=200
@eff obj=1 page=back show=true storage=al_sp_000 path=(640,360,255) time=1 absolute=(15001) mode=psoverlay a_r=230 a_g=200 a_b=230
@bg storage=white method=wave time=1000 wavetype=1 maxh=20 maxomega=0.1 bgcolor1=0xffccff bgcolor2=0xffccff
@show
@eff obj=2 storage=st01baf14 path=(460,1280,200)(460,1380,200) time=10000 accel=-2 absolute=(15002) anm=false offsetpath=(0,0,0)(0,0,255) offsettime=1000
@eff obj=3 storage=sp_吐息01 path=(450,230,0)(450,280,80)(450,230,0) size=(0.1,0.7) time=1200 accel=-2 absolute=(15003) spline=true delay=0
@eff obj=4 storage=sp_吐息12 path=(440,230,0)(440,280,80)(440,230,0) size=(0.1,0.7) time=1200 accel=-2 absolute=(15004) spline=true delay=200
@eff obj=5 storage=sp_吐息19 path=(460,230,0)(460,280,80)(460,230,0) size=(0.1,0.7) time=1200 accel=-2 absolute=(15005) spline=true delay=400
*p486|
@nm t="聖良" s=sei_0290
「はぁはぁ、お恵みを……！　お慈悲をっ……！！」[np]
@eff_delete obj=2
@eff_delete obj=3
@eff_delete obj=4
@eff_delete obj=5
@extrans
@eff obj=2 storage=st01aaf18 path=(1030,1390,200)(930,1390,200) time=10000 accel=-2 absolute=(15002) anm=false offsetpath=(0,0,0)(0,0,255) offsettime=2000
@eff obj=3 storage=sp_吐息01 path=(880,350,0)(830,400,100)(800,350,0) size=(0.5,0.6) time=1200 accel=-2 absolute=(15003) spline=true delay=6300
@eff obj=4 storage=sp_吐息12 path=(880,360,0)(830,410,100)(800,360,0) size=(0.5,0.6) time=1200 accel=-2 absolute=(15004) spline=true delay=6500
@eff obj=5 storage=sp_吐息19 path=(880,370,0)(830,420,100)(800,370,0) size=(0.5,0.6) time=1200 accel=-2 absolute=(15005) spline=true delay=6700
*p487|
@nm t="聖良" s=sei_0291
「どうか貴方様のおちんぽを卑しいメス犬にお恵み下さい……！」[np]
@eff_delete obj=2
@eff_delete obj=3
@eff_delete obj=4
@eff_delete obj=5
@extrans
@eff obj=2 storage=st02baf18 path=(665,1310,200)(665,1210,200) time=15000 accel=-2 absolute=(15002) anm=false offsetpath=(0,0,0)(0,0,255) offsettime=1000
@eff obj=3 storage=sp_吐息01 path=(665,435,0)(665,435,80)(665,435,0) size=(0.1,0.7) time=1200 accel=-2 absolute=(15003) spline=true delay=1000
@eff obj=4 storage=sp_吐息12 path=(655,435,0)(655,435,80)(655,435,0) size=(0.1,0.7) time=1200 accel=-2 absolute=(15004) spline=true delay=1200
@eff obj=5 storage=sp_吐息19 path=(675,435,0)(675,435,80)(675,435,0) size=(0.1,0.7) time=1200 accel=-2 absolute=(15005) spline=true delay=1400
*p488|
@nm t="莉瑠" s=rir_0124
「なるっ、なりますぅ～！　騎士なんかやめて、[r]
魔王様の性奴隷にっ、チンポ奴隷になるぅ～！！」[np]
@hide
@eff_all_delete
@white method=wave time=1000 wavetype=1 maxh=20 maxomega=0.1 bgcolor1=0xffccff bgcolor2=0xffccff
@bg storage=bg_10c
@show
*p489|
@nm t="千尋"
「っ……！？」[np]
*p490|
いかん。変なことを想像してはダメだ。[np]
*p491|
しかし目の前にセーラとリルルがいると、[r]
ついつい想像してしまって――[np]
@hide
@bg storage=bg_10c_l left=-1280 top=-360 st02bbf13=2.5 st01bbf11=7.5,1
@show
@dchr st01abf17 delay=1100
*p492|
@nm t="聖良" s=sei_0292
「～～っっ。ま、また勃起して……」[np]
@chr st02bbf10 st01abf13
*p493|
@nm t="千尋"
「――ハっ！？」[np]
@chr st02abf09
*p494|
もはや隠すことなく聖良が俺のチンコをガン見してくる。[np]
*p495|
@nm t="千尋"
「せ、聖良……？」[np]
@chr st01abf09
@dchr st01abf17 delay=1800
@dchr st01bbf10 delay=3400
@dchr st01bbf12 delay=8800
*p496|
@nm t="聖良" s=sei_0293
「ち、違うのっ、えと……！　男の人のおちんちんが[r]
大きくなってるところ、さっき初めて生で見たから……！」[np]
@chr st02abf11 st01bbf10
@dchr st01bbf17 delay=4900
@dchr st01abf17 delay=8200
*p497|
@nm t="聖良" s=sei_0294
「エ、エッチな漫画でしか見たことないから、[r]
興味本位というか、その……！　そのっ……！！」[np]
@chr st02abf12 st01abf08
@dchr st02abf15 delay=1800
*p498|
@nm t="莉瑠" s=rir_0125
「……まったくもう。やっぱりそういうことでしたか」[np]
@chr st02abf11 st01abf07
*p499|
@nm t="莉瑠" s=rir_0126
「だからわざわざこんな恥ずかしい格好を……」[np]
@chr st02bbf12
@dchr st02bbf08 delay=1400
*p500|
@nm t="莉瑠" s=rir_0127
「というか……私の裸を見た時は[r]
勃起なんてしませんでしたよね……？」[np]
@chr st02bbf11
*p501|
@nm t="莉瑠" s=rir_0128
「どんだけセーラとリルル好きなんですか……」[np]
*p502|
@nm t="千尋"
「い、いや、俺も自分で驚いてるんだ。[r]
半年前から勃ちすらしなかったから……」[np]
@chr st02bbf10 st01abf14
@dchr st01bbf07 delay=1600
*p503|
@nm t="聖良" s=sei_0295
「えっ……？　どういう、こと……？」[np]
@chr st02abf09 st01bbf01
*p504|
@nm t="千尋"
「…………実は……」[np]
@fobgm time=2000
@hide
@black rule=rule_spiral01
@wbgm
@wait time=1000
@bg storage=bg_10c st02abf12=3 st01bbf07=7,1 rule=rule_spiral01
@bgm storage=bgm_02
@show
@dchr st01bbf12 delay=3500
*p505|
@nm t="聖良" s=sei_0296
「そ……そうだったんだ。[r]
描けなくなってから、ずっと、その……」[np]
@chr st02abf11
@dchr st02abf08 delay=2800
*p506|
@nm t="莉瑠" s=rir_0129
「お、女の子に言うことですかね、それ……。[r]
ＥＤになった話なんて……」[np]
@chr st02abf09
*p507|
@nm t="千尋"
「い、いや、ＥＤになったわけじゃないっ……！！[r]
二人のコス姿を見て復活したわけだし、全然現役だし……！！」[np]
@chr st02abf12 st01bbf04
*p508|
これで一通りセーラとリルルの衣装を[r]
見せてもらったことになるが……どれも素晴らしかった。[np]
@chr st01bbf16
*p509|
まさか全てのコスで勃起させられることになるとはな……。[np]
@chr st01bbf10
@dchr st01bbf12 delay=2500
*p510|
@nm t="聖良" s=sei_0297
「だけど、その……。今はまた縮んでる、よね……？」[np]
@chr st02abf14
@dchr st02abf11 delay=5100
*p511|
@nm t="莉瑠" s=rir_0130
「セーラとリルルのどちらかっぽく迫らないと[r]
勃たないってことですか？　難儀なチンポですね」[np]
@chr st02abf09 st01bbf11
*p512|
@nm t="千尋"
「……それだけセーラとリルルを愛していると言って欲しい」[np]
@chr st02bbf11 st01bbf04
*p513|
@nm t="莉瑠" s=rir_0131
「自信満々にいうことじゃないと思いますけどね……」[np]
*p514|
@nm t="千尋"
「でも、これでわかったと思う。[r]
そういう意味では俺は人畜無害だって」[np]
@chr st02abf11 st01bbf02
*p515|
@nm t="莉瑠" s=rir_0132
「それも自信満々にいうことじゃないと思いますけどね……」[np]
*p516|
莉瑠がため息をつきながらヤレヤレと肩を揺らす。[np]
@chr st01abf15
*p517|
@nm t="聖良" s=sei_0298
「セーラっぽく迫らないと……」[np]
@chr st02abf01 st01abf02
@dchr st01abf04 delay=1700
*p518|
@nm t="聖良" s=sei_0299
「だったら千尋くんになら頼める、かも…………」[np]
@chr st01abf03
*p519|
そんな中、聖良が何やら一人呟く。[np]
*p520|
どうしたんだろう。と思っていると、[r]
不意に聖良は顔を上げて――[np]
@chr st01bbf03
@dchr st01bbf13 delay=2000
*p521|
@nm t="聖良" s=sei_0300
「あ、あの。お願いがあるん、だけど……」[np]
@chr st01bbf02
*p522|
@nm t="千尋"
「お、お願い？」[np]
@chr st01bbf04
@dchr st01bbf13 delay=2100
*p523|
@nm t="聖良" s=sei_0301
「う、うん。千尋くんさえ良ければ、だけど――」[np]
@fobgm time=2000
@hide
@black time=800
@wbgm
@wait time=500
@show
*p524|
………………[np]
*p525|
…………[np]
*p526|
……[np]
@hide
@white
@show
*p527|
@nm t="聖良" s=sei_0302
「ふふ、じっとしていて下さいね？[r]
動くと危険ですから」[np]
*p528|
@nm t="千尋"
「～～っっ」[np]
@hide
@eff obj=0 page=back show=true storage=bg_07a_l path=(3186,-1052,255) size=(3,3) time=1 absolute=(1500)
@eff obj=1 page=back show=true storage=st02bac01 path=(278,262,255) time=1 absolute=(1501) anm=false
@eff obj=2 page=back show=true storage=st01bac01 path=(940,207,255) time=1 absolute=(1502) anm=false
@bg storage=bg_07a
@bgm storage=bgm_06
@eff obj=3 page=back show=true storage=al_sp_070 path=(920,314,255) time=1 rad=(-45,-45) absolute=(15003) ysize=(1.5,1.5) correct=false
@eff obj=4 page=back show=true storage=al_sp_070 path=(925,320,255) time=1 rad=(-45,-45) absolute=(15004) ysize=(1.5,1.5) correct=false
@eff obj=5 page=back show=true storage=bg_07a_l path=(6919,801,255) size=(1.5,1.5) time=1 rad=(4,4) bbx=(6) bby=(6) bbt=true bbs=true absolute=(15005) xsize=(4,4) correct=false alphaeffect=4
@eff obj=6 page=back show=true storage=st01aac06 path=(1130,1530,255) time=1 absolute=(15006) alphaeffect=5
@bg storage=bg_07a
@show
@dceff obj=6 storage=st01aac05 delay=2600
@dceff obj=6 storage=st01aac06 delay=3300
*p529|
@nm t="聖良" s=sei_0303
「ご主人様のお耳の中……[r]
とっても垢が溜まってしまっていますね」[np]
@ceff obj=6 storage=st01aac13
@dceff obj=6 storage=st01aac12 delay=1900
*p530|
@nm t="聖良" s=sei_0304
「いけませんよ？　定期的にお掃除しないと」[np]
@ceff obj=6 storage=st01aac05
*p531|
@nm t="千尋"
「ふぁ……」[np]
@ceff obj=6 storage=st01bac05 path=(1060,1545,255)
*p532|
@nm t="聖良" s=sei_0305
「気持ちいいですか？」[np]
@ceff obj=6 storage=st01bac03
@dceff obj=6 storage=st01aac04 path=(1130,1530,255) delay=3800
*p533|
@nm t="聖良" s=sei_0306
「でも動いちゃいけませんからね？[r]
そのままじーっとしていて下さい」[np]
@ceff obj=6 storage=st01aac01
*p534|
聖女姿のセーラに扮した聖良が[r]
耳かき片手に俺の耳を掃除してくれる。[np]
*p535|
ヤバい、夢のようだ。[r]
耳かきもそうだが膝枕が最高で。[np]
*p536|
しかも――[np]
@eff obj=7 page=back show=true storage=al_sp_070 path=(360,314,255) time=1 rad=(45,45) absolute=(15007) ysize=(1.5,1.5) correct=false
@eff obj=8 page=back show=true storage=al_sp_070 path=(355,320,255) time=1 rad=(45,45) absolute=(15008) ysize=(1.5,1.5) correct=false
@eff obj=9 page=back show=true storage=bg_07a_l path=(6919,801,255) size=(1.5,1.5) time=1 rad=(4,4) bbx=(6) bby=(6) bbt=true bbs=true absolute=(15009) xsize=(4,4) correct=false alphaeffect=8
@eff obj=10 page=back show=true storage=st02aac13 path=(130,1480,255) time=1 absolute=(15010) alphaeffect=8
@bg storage=bg_07a
@dceff obj=10 storage=st02aac14 delay=1300
*p537|
@nm t="莉瑠" s=rir_0133
「～～っっ。どうして私まで膝枕せにゃいかんのですか……！」[np]
@ceff obj=6 storage=st01aac10
@dceff obj=6 storage=st01aac15 delay=2500
*p538|
@nm t="聖良" s=sei_0307
「こーら、莉瑠ちゃん。口調口調」[np]
@ceff obj=10 storage=st02bac07 path=(210,1450,255)
*p539|
@nm t="莉瑠" s=rir_0134
「ぐっ――……」[np]
@ceff obj=10 storage=st02bac08
@dceff obj=10 storage=st02bac15 delay=3000
*p540|
@nm t="莉瑠" s=rir_0135
「お、大人しくしてるんだぞ？[r]
もう片方の耳は私がカキカキしてやるからな？」[np]
@ceff_stock obj=6 storage=st01aac04
@ceff obj=10 storage=st02bac07
@dceff obj=6 storage=st01aac02 delay=1100
*p541|
@nm t="聖良" s=sei_0308
「えへへ、上手上手……」[np]
@ceff_stock obj=6 storage=st01aac01
@ceff obj=10 storage=st02aac11 path=(130,1480,255)
*p542|
@nm t="莉瑠" s=rir_0136
「……はぁ。全くもう……」[np]
@ceff obj=10 storage=st02aac12
@dceff obj=10 storage=st02aac13 delay=1700
*p543|
@nm t="莉瑠" s=rir_0137
「聖良のごっこ遊びになんで私まで付き合わされて……」[np]
*p544|
ブツブツ文句を言う莉瑠の声が気にならないほど、[r]
俺はＷ膝枕によってもたらされる興奮に浸っていた。[np]
*p545|
@nm t="千尋"
「し、しかしどうして耳かきを……？」[np]
@ceff_stock obj=6 storage=st01aac02
@ceff obj=10 storage=st02aac01
@dceff obj=6 storage=st01aac04 delay=2500
*p546|
@nm t="聖良" s=sei_0309
「一度でいいから、ね？　セーラみたいに[r]
男の人の耳かきをしてあげてみたかったの……」[np]
@ceff obj=6 storage=st01aac13
@dceff obj=6 storage=st01aac04 delay=2600
*p547|
@nm t="聖良" s=sei_0310
「無理言ってごめん、ね？[r]
付き合ってくれて、ありがとう……」[np]
@ceff obj=6 storage=st01aac03
*p548|
@nm t="千尋"
「い、いや、全然無理なんかじゃ……！！」[np]
*p549|
こんな夢のような体験ができるのであれば、[r]
いくらでも付き合わせていただきたいぐらいだ。[np]
@ceff obj=10 storage=st02aac11
@dceff obj=10 storage=st02aac12 delay=1000
*p550|
@nm t="莉瑠" s=rir_0138
「……はぁ。本当にそれだけだといいんですが……」[np]
@ceff_stock obj=6 storage=st01aac05
@ceff obj=10 storage=st02aac15
*p551|
@nm t="莉瑠" s=rir_0139
「もしものために気を張っておかないと……」[np]
@ceff obj=10 storage=st02aac09
*p552|
@nm t="千尋"
「ん？」[np]
@ceff obj=10 storage=st02bac11 path=(210,1450,255)
*p553|
@nm t="莉瑠" s=rir_0140
「いえ。なんでもないですよ」[np]
@ceff obj=10 storage=st02bac01
*p554|
ぼそりと莉瑠が何か呟いた気がしたが……。[r]
耳かきをされているとどうしても聞こえづらい。[np]
@ceff obj=6 storage=st01bac10 path=(1060,1545,255)
@dceff obj=6 storage=st01bac13 delay=3900
*p555|
@nm t="聖良" s=sei_0311
「申し訳ありません、ご主人様。[r]
もう少しだけ、お顔をこちらに向けて下さいますか？」[np]
@ceff obj=6 storage=st01bac02
*p556|
@nm t="千尋"
「あ、ああ」[np]
@ceff obj=6 storage=st01bac05
@dceff obj=6 storage=st01bac16 delay=2500
@dceff obj=6 storage=st01bac08 delay=4400
*p557|
@nm t="聖良" s=sei_0312
「ありがとうございます。[r]
ん……大きいのが奥にありますね」[np]
@ceff obj=6 storage=st01bac02
*p558|
@nm t="千尋"
「ん、おっ……！」[np]
@ceff obj=6 storage=st01bac16
@dceff obj=6 storage=st01bac03 delay=1400
*p559|
@nm t="聖良" s=sei_0313
「あ……こそばゆかったですか？」[np]
@ceff obj=6 storage=st01bac02
*p560|
@nm t="千尋"
「い、いや……！」[np]
@ceff obj=10 storage=st02aac01 path=(130,1480,255)
*p561|
いつも以上に淡泊な返事しかできない。[r]
太ももが本当に柔らかくて、すべすべで温かくて。[np]
*p562|
しかも、こんなにセーラの股間と胸が近くにある。[r]
いや正確には聖良のだけど――[np]
@ceff obj=6 storage=st01bac15
@dceff obj=6 storage=st01bac04 delay=2100
*p563|
@nm t="聖良" s=sei_0314
「ふぅ～……」[np]
*p564|
@nm t="千尋"
「ふぁぁ……」[np]
@ceff obj=6 storage=st01bac02
*p565|
耳に吐息をかけられて変な声を上げてしまう。[np]
@ceff obj=6 storage=st01bac05
@dceff obj=6 storage=st01bac04 delay=3900
@dceff obj=6 storage=st01bac13 delay=5300
*p566|
@nm t="聖良" s=sei_0315
「心地よさそうなお声を上げて下さって……。[r]
ふふ、気持ちいいのでしたらもう一度」[np]
@ceff obj=6 storage=st01bac18
*p567|
@nm t="聖良" s=sei_0316
「ふぅ～……」[np]
@ceff obj=6 storage=st01bac04
*p568|
@nm t="千尋"
「～～っ」[np]
*p569|
ダメだ。このままでは、また――……！！[np]
*p570|
股間がむずむずムクムクしてきてしまった、と思った時だった。[np]
@ceff obj=6 storage=st01bac08
@dceff obj=6 storage=st01aac05 path=(1130,1530,255) delay=1000
*p571|
@nm t="聖良" s=sei_0317
「あ……えへへ」[np]
@mq_small
*p572|
@nm t="千尋"
「うお……！？」[np]
*p573|
突然、股間に快感が走る。[np]
*p574|
何かが触れて――[np]
*p575|
まさか――[np]
@ceff obj=6 storage=st01aac06
@dceff obj=6 storage=st01aac03 delay=2000
@dceff obj=6 storage=st01aac12 delay=3400
*p576|
@nm t="聖良" s=sei_0318
「耳かきだけではなく、ふふ。[r]
こちらのお世話も致しましょうか？」[np]
@ceff_stock obj=6 storage=st01aac05
@ceff obj=10 storage=st02aac12
*p577|
@nm t="千尋"
「ちょっ！？　せ、聖良……！？」[np]
*p578|
聖良が俺の股間を服の上から撫でてきた。[np]
@ceff obj=6 storage=st01aac12
@dceff obj=6 storage=st01aac06 delay=3500
*p579|
@nm t="聖良" s=sei_0319
「撫でているだけで、はぁ、はぁ……。[r]
どんどん大きくなっていきますね……？」[np]
@ceff obj=6 storage=st01aac04
@dceff obj=6 storage=st01aac12 delay=5000
*p580|
@nm t="聖良" s=sei_0320
「摩られるのが気持ちいいんですか？[r]
でしたらもっと、はぁはぁ、摩りますね？」[np]
@ceff obj=6 storage=st01aac05
*p581|
@nm t="千尋"
「まっ――うっ、うぁぁ……！」[np]
@ceff obj=10 storage=st02aac15
*p582|
一体どうしたっていうんだ……？[r]
これじゃ、まるで俺の妄想みたいじゃないか。[np]
@ceff obj=6 storage=st01aac12
@dceff obj=6 storage=st01bac13 path=(1060,1545,255) delay=1800
*p583|
@nm t="聖良" s=sei_0321
「はぁ、はぁ……！　ズ、ズボンも脱いでしまいましょう」[np]
@ceff_stock obj=6 storage=st01bac03
@ceff obj=10 storage=st02aac14
@dceff obj=6 storage=st01bac05 delay=2200
*p584|
@nm t="聖良" s=sei_0322
「直接、はぁはぁ、摩ってあげますから……」[np]
@ceff obj=6 storage=st01bac04
*p585|
そうして止める間もなく、聖良が俺のズボンを脱が――[np]
@ceff obj=10 storage=st02aac10
@dceff obj=10 storage=st02aac16 delay=1100
*p586|
@nm t="莉瑠" s=rir_0141
「――そこまでですよ、この痴女！！」[np]
@fobgm time=500
@ceff_stock obj=6 storage=st01aac16 path=(1130,1530,255)
@ceff obj=10 storage=st02bac07 path=(210,1450,255)
*p587|
@nm t="聖良" s=sei_0323
「あいたっ！？」[np]
@hide
@eff_all_delete
@bg storage=bg_07a_l left=0 top=-360
@bgm storage=bgm_07
@show
@chr_standup st02abc14=3
@dchr st02abc08 delay=1900
*p588|
@nm t="莉瑠" s=rir_0142
「な、何をしようとしているんですか、あなたは……！！」[np]
@chr st02abc11
@dchr st02bbc12 delay=1500
*p589|
@nm t="莉瑠" s=rir_0143
「あまりに露骨すぎてツッコむのが遅れたじゃないですか！！」[np]
@chr st02bbc07
@wt
@chr_standup st01abc08=7,1
@dchr st01abc09 delay=1100
@dchr st01abc17 delay=4500
*p590|
@nm t="聖良" s=sei_0324
「～～っっ！　だってこんなチャンス、[r]
に、二度とないと思った、から……！」[np]
@chr st01bbc17
@dchr st01bbc12 delay=4200
*p591|
@nm t="聖良" s=sei_0325
「どうしても漫画と、セーラと、[r]
同じようなこと、してみたく……てっ」[np]
@chr st02abc11
*p592|
@nm t="千尋"
「ままま、漫画と同じようなこと……！？」[np]
@chr st02abc09
*p593|
そ、そういえば、ちょっと前に[r]
『ご奉仕プレイが好き』とか言ってたような。[np]
*p594|
『自分もいつかセーラみたいに優しくリードして[r]
気持ちよくしてあげたい』なんてことも言ってたような。[np]
@chr st01bbc10
@dchr st01bbc07 delay=1600
*p595|
@nm t="聖良" s=sei_0326
「ち、千尋くん、今スランプみたいなもの……なんだよね？」[np]
@chr st02abc09 st01bbc15
@dchr st01bbc05 delay=800
@dchr st01bbc03 delay=5300
*p596|
@nm t="聖良" s=sei_0327
「なら自分が描いた漫画と同じようなエッチしたら、[r]
色々なアイデアも浮かぶんじゃ……ない？」[np]
@chr st01bbc02
*p597|
@nm t="千尋"
「それは……いや、そう、かもしれないけど……」[np]
@chr st01abc13
@dchr st01abc12 delay=3200
*p598|
@nm t="聖良" s=sei_0328
「わたし、一度でいいからセーラと同じことしてみたいの」[np]
@chr st01abc17
@dchr st01abc07 delay=3000
@dchr st01abc09 delay=4400
*p599|
@nm t="聖良" s=sei_0329
「本当に一度でいいからっ……。お、お願いっ……！」[np]
@chr st02abc11 st01bbc10
*p600|
@nm t="千尋"
「お願いされても……その、流石に[r]
そんなことをしてもらうわけには……！」[np]
@chr st01bac17
*p601|
@nm t="聖良" s=sei_0330
「わたしが、したいの……！」[np]
@chr st02abc14 st01bac10
*p602|
話している間に熱が増してきてしまったのか、[r]
聖良が前のめりで迫ってくる。[np]
*p603|
顔が近い……！[np]
@chr st02bac10
@dchr st02bac09 delay=600
*p604|
@nm t="莉瑠" s=rir_0144
「ですからアホなこと言わないで下さい……！」[np]
@chr st02bac06
@dchr st02bac07 st01bac08 delay=2300
*p605|
@nm t="莉瑠" s=rir_0145
「逆レイプでもするつもりですか……！[r]
そのセーラのキャラともあってませんって……！」[np]
@chr st01aac14
@dchr st01aac08 delay=900
@dchr st01aac10 delay=3800
*p606|
@nm t="聖良" s=sei_0331
「あ……！　そ、そうだよね……。[r]
セレスティアスタイルのセーラなら――」[np]
@fobgm time=2000
@hide
@bg storage=bg_07a
@show
*p607|
すると聖良は一瞬目を伏せて――[np]
@hide
@eff obj=0 page=back show=true storage=bg_07a_l path=(800,300,255) size=(1.3,1.3) time=1 rad=(50,50) correct=false
@eff obj=1 page=back show=true storage=bg_07a_l path=(800,300,255) size=(1.3,1.3) time=1 rad=(50,50) bbx=(3) bby=(3) bbt=true bbs=true absolute=(15001) mode=pslighten correct=false
@eff obj=2 page=back show=true storage=st01aac06 path=(177,1009,255) time=1 rad=(50,50) absolute=(15002) anm=false
@eff obj=3 page=back show=true storage=st01aac06 path=(177,1009,255) time=1 rad=(50,50) bbx=(3) bby=(3) bbt=true bbe=true bbs=true absolute=(15003) mode=pslighten anm=false
@eff obj=4 page=back show=true storage=st01aac06 path=(177,1009,255) time=1 rad=(50,50) bbx=(60) bby=(60) bbt=true bbs=true absolute=(15004) anm=false sub=true alphaturn=true
@eff obj=5 page=back show=true storage=al_sp_000 path=(640,360,150) time=1 absolute=(15005) mode=psscreen correct=false alphaeffect=4 acb=true a_r=255 a_g=150 a_b=255 a_r2=255 a_g2=255 a_b2=255
@bg storage=bg_07a
@bgm storage=bgm_05
@show
*p608|
@nm t="聖良" s=sei_0332
「恥ずかしがらなくても大丈夫ですよ？[r]
力を抜いて、楽にして下さい」[np]
@ceff_stock obj=2 storage=st01bac13 path=(130,960,255)
@ceff_stock obj=3 storage=st01bac13 path=(130,960,255)
@ceff obj=4 storage=st01bac13 path=(130,960,255) time=500
*p609|
@nm t="聖良" s=sei_0333
「たくさんたくさん……気持ちよくしますから」[np]
*p610|
@nm t="千尋"
「――――」[np]
@fobgm time=2000
@hide
@eff_all_delete
@bg storage=bg_07a_l left=0 top=-360 st02abc14=3 st01bac02=7,1
@show
@dchr st02abc10 delay=800
*p611|
@nm t="莉瑠" s=rir_0146
「違っ……！　ロールプレイしろって[r]
言ってるわけじゃないですってば！！」[np]
@chr st02abc09 st01bac08
@dchr st01bac07 delay=1200
*p612|
@nm t="聖良" s=sei_0334
「えっ？　そ、そうだったの……？」[np]
@bgm storage=bgm_02
@chr st02abc12
*p613|
どうしよう、ヤバい。して欲しい……。[r]
セーラにご奉仕されるシーンが頭に浮かぶ。[np]
@chr st02bac07 st01bac08
@chr_quake name="聖良" sx=5 xcnt=5 sy=3 ycnt=3 time=300 loop=false fade=false delay=0
@dchr st02bac09 delay=2000
*p614|
@nm t="莉瑠" s=rir_0147
「とにかく離れて下さい……！[r]
千尋さんが本当に頷いたらどうするつもりですか……！」[np]
@chr_quake name="莉瑠聖良" sx=10 xcnt=6 sy=0 ycnt=0 time=2000 loop=true fade=true delay=0
@chr st02bac07 st01aac09
@dchr st01aac08 delay=2700
@dchr st01aac17 delay=4900
*p615|
@nm t="聖良" s=sei_0335
「離して莉瑠ちゃん……！[r]
あくまで、えと……！　ロールプレイ、だもん……！」[np]
@chr st02bac12 st01aac08
*p616|
@nm t="千尋"
「お、落ち着いて、二人とも……！！[r]
そんなに引っ張り合ったら――」[np]
@chr st02bac07 st01aac09
*p617|
と、二人を諫めようとした時だった。[np]
@shide
[se storage="動作_破く_洋服_00" buf=0 delay=0]
@sbgm
@white time=100
@sq
@q_small
@bg storage=bg_07a_l left=0 top=-360 st02abd14=3 st01abd14=7,1 rule=rule_cross05_i_o_lr time=250
@show
*p620|
@nm t="聖良・莉瑠" rt="聖良・莉瑠" s=gou_0003
「「あ」」[np]
@bgm storage=bgm_07
*p621|
@nm t="千尋"
「～～っっ！！？」[np]
@bg storage=bg_07a st02acd14=2 st01acd14=4.5,1
*p622|
セーラとリルルの、[np]
*p623|
はだ――[np]
@shide
@eff obj=0 page=back show=true storage=red path=(640,360,255) time=1000 rceil=200
@eff obj=1 page=back show=true storage=al_sp_000 path=(640,360,255) time=1000 absolute=(15001) mode=psoverlay
@q_normal
@black rule=rule_71_i_o time=250
[se storage="人の行動1_こける_se1792" buf=0 delay=0]
@show
*p624|
@nm t="聖良" s=sei_0337
「えっ……！？　ち、千尋く……！？[r]
だだだ、大丈夫っ……！！？」[np]
*p625|
@nm t="莉瑠" s=rir_0149
「……ほ、本当にいるんですね。[r]
女子の裸見て鼻血出して気絶する人……」[np]
*p626|
二人の声が遠くなっていく。[np]
*p627|
俺はそのままピンク色のまどろみの中に落ちていった。[np]
@fobgm time=3000
@hide
@eff_all_delete
@black time=2000
@wbgm
@wait time=1000
@jump storage="000_共通_04.ks"

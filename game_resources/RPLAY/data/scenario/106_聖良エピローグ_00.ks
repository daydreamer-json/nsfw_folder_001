; 
; 
*p0|
@bg storage=bg_07a_l left=0 top=-510
@bgm storage=bgm_02
@show
*p1|
@nm t="千尋"
「よし。こんなものか」[np]
*p2|
荷造りを終えて、一人頷く。[np]
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
*p3|
すると扉を開く音の後に、[r]
聞き慣れた声が耳に届いてきた。[np]
@hide
@bg storage=bg_07a
@chr_walk way=r st01bbb02
@wt
@show
@chr st01bbb03
*p4|
@nm t="聖良" s=sei_12250
「あ……千尋くん。ここにいたんだ？」[np]
@chr st01bbb02
*p5|
@nm t="千尋"
「聖良。そっちはもう終わったのか？」[np]
@chr st01bbb04
@dchr st01abb04 delay=575
@dchr st01abb02 delay=2099
@dchr st01abb12 delay=6198
*p6|
@nm t="聖良" s=sei_12251
「うん。えへへ、島に来た時よりも[r]
荷物が多くなっちゃっててちょっぴり大変だった」[np]
@chr st01abb03
*p7|
@nm t="千尋"
「ははは、俺も同じだったよ」[np]
@hide
@bg storage=bg_07a_l left=0 top=-510
@show
*p8|
島を訪れた時には小さな鞄一つで事足りていた荷物が、[r]
気づけば大きな鞄を買い直しても足りないくらい増えていた。[np]
*p9|
それだけこの島で過ごした時間が[r]
長かったということだろう。[np]
@hide
@bg storage=bg_07a st01bbb02
@show
@chr st01bbb07
@dchr st01bbb15 delay=4663
*p10|
@nm t="聖良" s=sei_12252
「明日で……とうとう帰っちゃうんだよね？[r]
わたしも、千尋くんも……」[np]
@chr st01bbb01
*p11|
@nm t="千尋"
「いつでも会えるよ。住んでる場所もかなり近かったしね」[np]
@chr st01bbb04
@dchr st01bbb05 delay=892
@dchr st01bbb03 delay=2677
@dchr st01bbb08 delay=7141
*p12|
@nm t="聖良" s=sei_12253
「ふふ、そうだね。千尋くんの住所聞いた時は驚いちゃった。[r]
憧れのティンポジウム先生がこんなに近くに住んでたんだって」[np]
@chr st01bbb02
*p13|
@nm t="千尋"
「俺もあの有名なアエット・リエットが[r]
近くに住んでいたとは思ってなかったよ」[np]
*p14|
寂しさを紛らわせるように二人して笑ってみるけれど、[r]
やはり押し寄せてくる侘しさは拭いきれない。[np]
*p15|
そんなことを考えていると、[r]
聖良が懐かしむようにゆっくりと口を開く。[np]
@chr st01bbb05
@dchr st01bbb13 delay=4011
*p16|
@nm t="聖良" s=sei_12254
「色々なことがあった、ね？[r]
長かったようで、短かったような……」[np]
@chr st01bbb02
*p17|
@nm t="千尋"
「エッチばっかりしちゃってたけどな……」[np]
@chr st01abb04
@dchr st01abb06 delay=1226
@dchr st01abb02 delay=4522
*p18|
@nm t="聖良" s=sei_12255
「えへへ。でも楽しかった、よ？[r]
憧れのセーラになれたみたいで嬉しかった」[np]
@chr st01abb03
*p19|
@nm t="千尋"
「俺も愛しのセーラと一緒に暮らしてるみたいで、[r]
毎日が夢のようだったよ」[np]
@chr st01bbb06
*p20|
@nm t="聖良" s=sei_12256
「……それだけ？」[np]
@chr st01bbb10
*p21|
聖良が小首を傾げて上目遣いに尋ねてくる。[np]
@chr st01abb15
@dchr st01abb08 delay=3472
*p22|
@nm t="聖良" s=sei_12257
「わたしと一緒に暮らしたことは……[r]
嬉しくなかったのかな？」[np]
@chr st01abb07
*p23|
@nm t="千尋"
「い、言うまでもなくないかな……」[np]
@chr st01bbb05
@dchr st01bbb13 delay=1206
*p24|
@nm t="聖良" s=sei_12258
「えへへ。最後の最後まで、照れ屋さん……だね？」[np]
@chr_del name=聖良
@wt
@eff obj=0 page=back show=true storage=bg_07a path=(640,360,255) time=1 bbx=(3) bby=(3) bbt=true bbs=true absolute=(2000)
@bg storage=bg_07a st01bab02 time=400
*p25|
そういうと、俺の顔を覗き込んでいた聖良は、[r]
そのまま唇を近づけてきて――[np]
@chr st01bab18
*p26|
@nm t="聖良" s=sei_12259
「ちゅっ……んっ……」[np]
*p27|
@nm t="千尋"
「～～っっ」[np]
*p28|
おもむろに重ねられた唇の感触にドキっとしてしまう。[r]
けれど聖良は口を離すことなく、むしろ押しつけてきた。[np]
@chr st01bab15
*p29|
@nm t="聖良" s=sei_12260
「んぁむっ……んちゅ……ちゅ」[np]
@chr st01bab14 time=400
*p30|
@nm t="聖良" s=sei_12261
「れろぉ……れろろぉ……。んはぁむ、んちゅぅ……」[np]
@chr st01bab18 time=500
*p31|
聖良が俺に抱きつきながら、じっくりと唇を味わうように[r]
濃厚なキスをしてくれる。[np]
*p32|
俺もそんな彼女に応えるようにキスを仕返していた。[np]
@eff_all_delete
@bg storage=bg_07a st01bbb10 time=400
@dchr st01bbb13 delay=3607
*p33|
@nm t="聖良" s=sei_12262
「ぷはぁ……はぁ、はぁ、えへへ」[np]
@chr st01bbb02
*p34|
@nm t="千尋"
「聖良は、はぁ……ホントに大胆になったな……」[np]
@chr st01abb02
@dchr st01abb04 delay=3005
*p35|
@nm t="聖良" s=sei_12263
「あなたのおかげ、だよ？[r]
あなたがわたしをこんなに大胆にしてくれたの」[np]
@chr st01abb02
*p36|
@nm t="聖良" s=sei_12264
「自分の気持ちに、素直になれるようにしてくれた」[np]
@chr st01abb05
*p37|
@nm t="千尋"
「それを言うなら……俺だってそうだな」[np]
@chr st01bbb02
*p38|
聖良がエッチなロールプレイをしてくれたから。[r]
俺の理想のヒロインになりきって接してくれたから。[np]
*p39|
俺は自分の欲望を曝け出せた。[r]
心のどこかで恥ずかしがっていたエロい自分を肯定できた。[np]
*p40|
島を訪れる前に抱えていたスランプはもうない。[r]
チンピクすらしなかったチンコも元気いっぱいになってる。[np]
@chr st01bbb13
@dchr st01bbb05 delay=2327
*p41|
@nm t="聖良" s=sei_12265
「えへへ……もう。相変わらずエッチ、だね？」[np]
@chr st01bbb02
*p42|
@nm t="千尋"
「大好きな彼女にあんなキスなんてされたら、[r]
勃っちゃうに決まってるさ」[np]
@chr st01bbb11
@dchr st01bbb13 delay=2214
*p43|
@nm t="聖良" s=sei_12266
「大好きな彼女……えへへ」[np]
@chr st01bbb04
*p44|
聖良が幸せそうに微笑む。[r]
その笑顔から目を離すことができない。[np]
*p45|
もう俺には彼女が傍にいない生活なんて、[r]
考えることができなくなっていた。[np]
*p46|
@nm t="千尋"
「その、さ。聖良さえ良ければなんだけど……」[np]
@chr st01bbb16
*p47|
@nm t="千尋"
「島を出た後も……一緒に暮らしてくれないか？」[np]
@chr st01bbb08
*p48|
@nm t="聖良" s=sei_12267
「えっ……？」[np]
*p49|
@nm t="千尋"
「っ……い、いや無理ならいいんだ。[r]
あ、いや良くはないけど、一緒に暮らしたいけど……！」[np]
@chr st01abb03 time=300
*p50|
尋ね返されて、思わず取り乱してしまう。[r]
するとそんな俺を見て聖良はクスクスと笑った。[np]
@chr st01abb01
*p51|
そして――[np]
@chr st01abb12
@dchr st01abb04 delay=2092
*p52|
@nm t="聖良" s=sei_12268
「もちろん、いいよ……？」[np]
@chr st01abb17
@dchr st01abb12 delay=3215
*p53|
@nm t="聖良" s=sei_12269
「むしろ一緒に暮らしたい、な？[r]
わたしもあなたとずっとずっと一緒にいたい」[np]
@chr st01abb05
*p54|
@nm t="千尋"
「聖良……」[np]
@chr st01abb08
@dchr st01abb14 delay=1764
*p55|
@nm t="聖良" s=sei_12270
「あ……でも一緒に暮らしたら、[r]
引きこもりさんになっちゃうかも……」[np]
@chr st01abb13
*p56|
@nm t="千尋"
「へ？　どうして？」[np]
@chr st01abb15
*p57|
@nm t="聖良" s=sei_12271
「だって――」[np]
@shide
@chr_del name=聖良
@wt
@eff obj=0 page=back show=true storage=bg_07a path=(640,360,255) time=1 bbx=(5) bby=(5) bbt=true bbs=true absolute=(2000)
[se storage="動作_衣擦れ_洋服_12" buf=0 delay=0]
@bg storage=bg_07a st01bdb02 time=250
@sshow
*p58|
不意に聖良が俺にぎゅっと抱きついてくる。[np]
@chr st01bdb17
@dchr st01bdb18 delay=3096 time=400
@dchr st01bdb10 delay=6218
@dchr st01bdb11 delay=12279
*p59|
@nm t="聖良" s=sei_12272
「だって大好きな人と暮らしたら、んっ、ちゅぅっ……。[r]
毎日毎日朝から晩まで一日中……エッチしちゃいそうだもん」[np]
@chr st01bdb12
@dchr st01bdb15 delay=800 time=400
*p60|
@nm t="千尋"
「それはそれで……んっ、ちゅ。幸せでは……」[np]
@chr st01bdb18
*p61|
惚気るようにキスしてくれる聖良に俺も唇を重ね返す。[r]
どんどん身体は熱を帯び、想いが溢れ出してしまいそうだ。[np]
@chr st01bdb10
@dchr st01bdb13 delay=4924
*p62|
@nm t="聖良" s=sei_12273
「ベッドまで行くの、めんどうだね……？[r]
ううん。ベッドまで、我慢できない……」[np]
@chr st01bdb10
*p63|
@nm t="聖良" s=sei_12274
「ここでしちゃお……？」[np]
@chr st01adb13
@dchr st01adb06 delay=4297
*p64|
@nm t="聖良" s=sei_12275
「大好きなあなたと、エッチ……したいな？」[np]
@chr st01adb05
*p65|
スケベな自分を隠そうともせずに、[r]
そう誘ってくれる聖良の気持ちが嬉しい。[np]
*p66|
彼女への愛しさがより膨れあがって、[r]
チンコがどんどん硬度を増していくのがわかった。[np]
@chr st01adb18
@dchr st01adb12 delay=8586 time=500
*p67|
@nm t="聖良" s=sei_12276
「あっ……んはぁ、あぁん……えへへ、んちゅ、気持ちいい」[np]
@chr st01adb05
*p68|
感情のまま聖良のおっぱいを優しく揉む。[r]
キスをして、二人して微笑み合う。[np]
@chr st01bdb10
@dchr st01bdb13 delay=5929
*p69|
@nm t="聖良" s=sei_12277
「今日は一日中エッチしたい、な……？[r]
この島での最後の思い出、えへへ、作りたい」[np]
@chr st01bdb04
*p70|
@nm t="千尋"
「俺も大好きな彼女との思い出を作りたいな」[np]
@chr st01bdb03
*p71|
@nm t="聖良" s=sei_12278
「後でコスしてもいいよ……？[r]
今日はどの衣装、着て欲しい……？」[np]
@chr st01bdb02
*p72|
@nm t="千尋"
「いや。今日は一日中、そのままの聖良と愛し合っていたいな」[np]
@chr st01adb04
@dchr st01adb02 delay=2466
*p73|
@nm t="聖良" s=sei_12279
「ふふ、おかしい。わたしはコスプレイヤーで、[r]
ここはコスプレ島なのに、最後はコスプレしないなんて」[np]
@chr st01adb06
@dchr st01adb04 delay=3058
*p74|
@nm t="聖良" s=sei_12280
「でも……そう言ってもらえるの、とっても嬉しい」[np]
@chr st01adb03
*p75|
聖良がとびきりの笑顔を見せてくれる。[r]
今までで一番の可愛い笑顔だった。[np]
*p76|
こんな彼女の顔こそ思い出に残しておきたい。[np]
*p77|
@nm t="千尋"
「……もっと写真とか取っておけば良かったな。[r]
コスプレ写真だけじゃなくて、普段の聖良の写真を」[np]
@chr st01bdb08
*p78|
@nm t="聖良" s=sei_12281
「それって……ハメ撮りしたいってこと？」[np]
@chr st01bdb16
*p79|
@nm t="千尋"
「飛躍しすぎっ！？　そうじゃなくって、[r]
普通の思い出写真というか、観光地で取る写真というか！」[np]
@chr st01bdb10
@dchr st01bdb04 delay=1393
@dchr st01adb06 delay=2680
*p80|
@nm t="聖良" s=sei_12282
「じゃあ……ふふ。ハメ撮り写真はいらないんだ？」[np]
@chr st01adb05
*p81|
@nm t="千尋"
「そ、それは……！！」[np]
@chr st01adb04
@dchr st01adb12 delay=1782
*p82|
@nm t="聖良" s=sei_12283
「えへへ……。ホントに最後の最後まで照れ屋さん、だね？」[np]
@chr st01adb05
*p83|
顔を赤くして焦る俺を聖良がおかしそうに笑う。[np]
@chr st01bdb10
@dchr st01bdb03 delay=3882
*p84|
@nm t="聖良" s=sei_12284
「わたしは撮られたい、な？[r]
あなたにエッチな写真、撮られたい……」[np]
@chr st01bdb07
@dchr st01bdb13 delay=5294
*p85|
@nm t="聖良" s=sei_12285
「もう二度とあなたがスランプにならずに済むような……。[r]
おちんちん勃たないなんてことなくなるような……」[np]
@chr st01bdb15
@dchr st01bdb03 delay=3221
@dchr st01bdb10 delay=6629
*p86|
@nm t="聖良" s=sei_12286
「この島での最後の思い出として……[r]
そんなエッチなハメ撮り写真、撮られたいな？」[np]
@chr st01adb05
*p87|
頬を赤らめた聖良の表情は、[r]
とても優しくて、とてもスケベな微笑みだった。[np]
@chr st01adb13
@dchr st01adb12 delay=3532
*p88|
@nm t="聖良" s=sei_12287
「撮って……くれる？[r]
わたしだけのエッチなカメラマン、さん？」[np]
@chr st01adb05
*p89|
@nm t="千尋"
「もちろんだとも……！！」[np]
@chr st01adb03
@dchr st01adb06 delay=1421
*p90|
@nm t="聖良" s=sei_12288
「ふふ。なら――」[np]
@hide
@eff_all_delete
[se storage="動作_座る_ソファ_00"]
@white time=800
@show
*p91|
興奮混じりに応える俺をクスクスとまた笑いながら、[r]
聖良がソファーへと軽く寝転がる。[np]
*p92|
そして、足をぎゅっと抱え込んだ――[np]
@fobgm time=3000
@hide
@white time=2000
@wbgm
@wait time=1000
@jump storage="106_聖良エピローグ_01_h.ks"

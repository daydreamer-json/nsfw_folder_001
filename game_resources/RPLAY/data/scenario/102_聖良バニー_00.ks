; 
; 
*p0|
@black
@show
*p1|
それは、聖良と恋人になって間もない頃――[np]
@hide
@bg storage=bg_07a_l st02abb01=3.0 st01abb01=7.0,10 left=-1020 top=-430
@bgm storage=bgm_02
@show
@chr st02abb10
@dchr st02abb08 delay=4542
*p2|
@nm t="莉瑠" s=rir_10177
「ちょっと聖良！　この卵焼き、タマネギ入ってるじゃない[r]
ですか！　私がタマネギ嫌いだって知ってますよね！？」[np]
@chr st02abb09 st01bbb05
@dchr st01bbb03 delay=2365
*p3|
@nm t="聖良" s=sei_10396
「ダメだよ、莉瑠ちゃん。好き嫌いしちゃ。[r]
大きくなれない、よ……？」[np]
@chr st02abb11 st01bbb02
*p4|
@nm t="莉瑠" s=rir_10178
「いや、十分大きくなってますから。[r]
これ以上、大きくならなくても構いませんし」[np]
@chr st02abb09 st01bbb17
*p5|
@nm t="聖良" s=sei_10397
「む、胸の話じゃなくて――」[np]
@chr st01bbb11
*p6|
@nm t="千尋"
「ふわぁ……。おはよう」[np]
@chr st01abb09
@dchr st01abb16 delay=731
@dchr st01bbb11 delay=2627
@dchr st01bbb17 delay=4089
*p7|
@nm t="聖良" s=sei_10398
「あっ、ち、ちち、千尋く……！[r]
～～っっ。あ、朝ご飯は作ってある、からっ――」[np]
[se storage="コミカル_足_ピューッ01" buf=0 delay=0]
@chr_del_walk way=r name=聖良 time=200
@wt
@chr st02bbb06
@dchr st02bbb10 delay=2971
*p8|
@nm t="莉瑠" s=rir_10179
「ちょっ、聖良！？　卵焼き作り直して――って……。[r]
行っちゃいましたし……」[np]
@chr st02bbb11
*p9|
気のせいかもしれないが俺の顔を見た途端に、[r]
逃げだしていったような……。[np]
*p10|
気のせい……だよな？[np]
@hide
@black rule=rule_spiral01
@wait time=800
@bg storage=bg_11a st01abb01 rule=rule_spiral01
@show
[se storage="物_ブラシ01"]
@chr st01abb02
@dchr_poschange 聖良=4.50 delay=744
@dchr_poschange 聖良=5.00 delay=1768
@dchr_poschange 聖良=5.50 delay=2590
@dchr_poschange 聖良=5.00 delay=3715
*p11|
@nm t="聖良" s=sei_10399
「よい、しょ……。よいしょ……っと」[np]
[fose buf=0]
@chr st01abb03
*p12|
@nm t="千尋"
「聖良？　風呂掃除なら俺も手伝うよ」[np]
[sse buf=0]
@chr st01bbb03
@dchr st01bbb17 delay=1551
@dchr st01abb16 delay=4756
*p13|
@nm t="聖良" s=sei_10400
「――千尋くん……！？[r]
だ、だいじょぶ、一人ででき――ひぃあっ！？」[np]
@chr_del_down name=聖良 time=200
*p14|
@nm t="千尋"
「危ないっ！」[np]
@shide
@bg storage=bg_11a_l st01adb16 left=-640 top=-720 time=250 rule=rule_71_i_o
[se storage="動作_抱きしめる" buf=0 delay=0]
@sshow
*p15|
つるりと滑って転びかけた聖良を[r]
すんでのところで受け止める。[np]
*p16|
@nm t="千尋"
「だ、大丈夫か？」[np]
@chr st01bdb08
@dchr st01bdb17 delay=2994
@dchr st01bdb11 delay=3845
*p17|
@nm t="聖良" s=sei_10401
「あ、ありがと……。――って、～～っっ！！」[np]
[se storage="コミカル_足_ピューッ01" buf=0 delay=0]
@chr_del_walk way=r name=聖良 time=200
[wait time=200]
*p18|
@nm t="千尋"
「あっ！？」[np]
*p19|
……気のせいじゃない、のか？[np]
@hide
@black rule=rule_spiral01
@wait time=800
@eff obj=0 page=back show=true storage=bg_06a_l path=(610,280,255) size=(1.2,1.2) time=1 absolute=(2000)
@bg storage=bg_06a st02abb01=3.10 st01abb07=6.90,10 rule=rule_spiral01
@show
@chr st02abb11
@dchr st02abb08 delay=3157
*p20|
@nm t="莉瑠" s=rir_10180
「ですから私が買いに行きますって。[r]
どうせ聖良は市場で買い物なんてできないでしょうに」[np]
@chr st02abb09 st01abb08
@dchr st01abb17 delay=4657
*p21|
@nm t="聖良" s=sei_10402
「り、莉瑠ちゃんと二人ならだいじょぶ、だもん……。[r]
それに莉瑠ちゃんに任せるとお肉しか買ってこない、から……」[np]
@chr st01abb07
*p22|
@nm t="千尋"
「あ、買い物か？　なら俺も荷物持ちぐらい――」[np]
@chr st01bbb11
*p23|
@nm t="聖良" s=sei_10403
「～～っっ」[np]
@chr_del_walk way=r name=聖良 time=200
[se storage="コミカル_足_ピューッ01" buf=0 delay=0]
[wait time=300]
@chr st02abb01
*p24|
また……！！[r]
しかしそう何度も逃がすわけには……！！[np]
@hide
@eff_delete obj=0
@eff obj=1 page=back show=true storage=sp_bg_06a path=(640,360,255) time=1 absolute=(2000)
@bg storage=bg_06a st02aab01
@show
@chr st02aab11
@dchr st02aab12 delay=1325
*p25|
@nm t="莉瑠" s=rir_10181
「はぁ……何やってるんですか、あの二人は」[np]
@fobgm time=2000
@hide
@eff_all_delete
@black rule=rule_spiral01
@wbgm
@show
*p26|
………………[np]
*p27|
…………[np]
*p28|
……[np]
@hide
@bg storage=bg_02a rule=rule_spiral01
@wait time=500
@eff obj=2 storage=al_horizon_041_o path=(640,360,255) time=300 absolute=(15002) xspin=(0.25,0)
@eff obj=3 storage=al_horizon_041_o path=(640,360,255) time=300 absolute=(15003) ysize=(0.98,0.98) xspin=(0.25,0)
@eff obj=4 storage=bg_02a_l path=(980,-135,255) size=(1.6,1.6) time=301 bbx=(20) bbt=true bbs=true absolute=(15004) correct=false alphaeffect=3
@eff obj=5 storage=loop_noize_side_ph_xblur path=(+0.0,360,255)(1280,360,255) time=750 loop=true turn=true absolute=(15005) mode=psoverlay ysize=(0.7,0.7) correct=false alphaeffect=3
@eff obj=6 storage=st01aab09 path=(694,1016,255)(694,1026,255)(694,1016,255) size=(0.9,0.9) time=150 loop=true absolute=(15006) anm=false alphaeffect=3
@weff obj=3
@seff obj=2
@bgm storage=bgm_07
@show
*p29|
@nm t="聖良" s=sei_10404
「あわわっ、お、追っかけてこないでっ……！！」[np]
*p30|
@nm t="千尋"
「聖良が逃げるからだろっ！？[r]
どうして逃げるんだっ……！？」[np]
*p31|
@nm t="聖良" s=sei_10405
「そ、それは――～～っっ！！」[np]
@shide
@eff obj=6 storage=st01aab09 path=(694,1016,255)(704,1016,255)(664,1016,0) size=(0.9,0.9) time=150 absolute=(15006) anm=false alphaeffect=3
[wait time=200]
[se storage="コミカル_足_ピューッ01" buf=0 delay=0]
@weff obj=6
@eff_delete_now obj=6
@wait time=400
@eff_all_delete
@bg storage=bg_02a rule=rule_slash01_r_l time=350
@sshow
*p32|
揺れる胸がエロ――じゃなくて！[r]
なんて逃げ足の速い……！[np]
*p33|
でも、せっかく想いが通じ合って恋人になったというのに、[r]
避けられっぱなしはつらい。[np]
*p34|
せめてどうして逃げるのか理由を聞かないと……！[np]
@hide
@black rule=rule_03_l_r
@wait time=800
@bg storage=bg_12a st01bbb15 rule=rule_03_l_r
@show
@eff obj=0 page=back show=true storage=bg_12a_l path=(640,360,255) time=1 absolute=(2000)
@dchr st01bab17 delay=1649 time=200
[dse storage="衣擦れ(100)" buf=0 delay=1849]
*p35|
@nm t="聖良" s=sei_10406
「はぁはぁ――……きゃっ！」[np]
@chr st01bab11
*p36|
@nm t="千尋"
「ようやく捕まえた、ぞ……」[np]
@chr st01bab17
@dchr st01bab12 delay=1376
*p37|
@nm t="聖良" s=sei_10407
「は、離して……！　逃げない、から……！」[np]
*p38|
@nm t="千尋"
「いや、絶対逃げるだろ……というか、なんで俺を避けるんだ？」[np]
@chr st01bab07
*p39|
@nm t="聖良" s=sei_10408
「そ……それは……」[np]
@fobgm time=5000
@chr st01bab12
*p40|
@nm t="聖良" s=sei_10409
「は、恥ずかしく……て」[np]
*p41|
@nm t="千尋"
「恥ずかしい……？」[np]
@chr st01bab10
*p42|
@nm t="聖良" s=sei_10410
「だから、その……」[np]
@chr st01bab11
*p43|
すると聖良はチラチラ俺の顔を見ながら、[r]
頬を朱に染めて答えた。[np]
@bgm storage=bgm_09
@chr st01aab09
@dchr st01aab13 delay=3126
*p44|
@nm t="聖良" s=sei_10411
「つ、付き合ってると思うと、[r]
顔見るのも恥ずかしくて……」[np]
@chr st01aab07
*p45|
@nm t="千尋"
「っ……」[np]
*p46|
ぽつりと言われて、[r]
今度は俺の顔に血が上ってくる。[np]
*p47|
@nm t="千尋"
「べ、別に俺なんかに照れなくてもいいって。[r]
それを言ったら、お、俺の方が……」[np]
@chr st01aab14
*p48|
@nm t="聖良" s=sei_10412
「あなたの方……が？」[np]
@chr st01aab13
*p49|
尋ね返されて、つい言葉に詰まってしまう。[np]
*p50|
……確かに改まると非常に照れ臭いかもしれない。[r]
さっきと反対に俺の方が逃げだしてしまいそうだ。[np]
@chr st01aab17
*p51|
@nm t="聖良" s=sei_10413
「千尋くんだって、照れてる……じゃない」[np]
@chr st01aab15
*p52|
@nm t="千尋"
「うっ……！　し、仕方ないだろう。[r]
彼女なんて初めてなんだから……！」[np]
@chr st01aab12
@dchr st01aab08 delay=4812
@dchr st01aab13 delay=7538
*p53|
@nm t="聖良" s=sei_10414
「わたしだって同じ、だもん……。[r]
だから、その……どう接したら良いかわからなく、て……」[np]
@chr st01aab07
*p54|
@nm t="千尋"
「は、初めての時はあんなに落ち着いてたじゃないか」[np]
@chr st01aab17
*p55|
@nm t="聖良" s=sei_10415
「あの時は、えと……！　わたしの方が年上だから、[r]
リードしてあげなくちゃと思って……！」[np]
@chr st01bab12
*p56|
二人してしどろもどろになる。[np]
*p57|
何か気の利いたことでもしなければと思うけど、[r]
情けなくも何をすればいいかわからない。[np]
*p58|
考えてみれば当たり前だ。だからこそ俺は[r]
チャーミングスタイルのセーラを生み出したのだから。[np]
*p59|
こちらから行かなくとも向こうからイチャつきにきてくれる[r]
彼女というか、俺を大好きなスケベ彼女というか――[np]
@chr st01bab15
*p60|
しかし、リアルではそうもいかないらしい。[r]
こっちから行かなくてはいけない時もある。[np]
*p61|
今がまさにそうだ。[np]
*p62|
初体験は聖良にリードしてもらったんだ。[r]
ここでどうにか男を見せないと――……！！[np]
@shide
@eff obj=0 page=back show=true storage=bg_12a_l path=(984,322,254) size=(1.6,1.6) time=1 bbx=(2) bby=(2) bbt=true bbs=true absolute=(2000)
@bg storage=bg_12a st01bdb17 rule=rule_71_i_o time=200
[se storage="動作_抱きしめる" buf=0 delay=0]
@sshow
*p63|
@nm t="聖良" s=sei_10416
「ひぃあっ！？　ど、どして急に抱きしめて……！」[np]
@chr st01bdb11
*p64|
@nm t="千尋"
「～～っっ！！　何かしなくちゃと思って……！！[r]
いいい、嫌だったか……！？」[np]
@chr st01adb09
@dchr st01adb12 delay=1847
*p65|
@nm t="聖良" s=sei_10417
「う……ううん。むしろ嬉しい……」[np]
@chr st01adb09
@dchr st01adb16 delay=3032
*p66|
@nm t="聖良" s=sei_10418
「嬉しいけど、やっぱり――～～っっ！！」[np]
@shide
@eff_all_delete
[se storage="動作_突き飛ばす_人_00"]
@q_small
@bg storage=bg_12a st01abb16 rule=rule_71_i_o time=200
@sshow
*p67|
@nm t="千尋"
「うおっ！？」[np]
@chr st01abb07
*p68|
俺の腕から聖良が抜け出して、距離を取られてしまう。[np]
@chr st01abb09
*p69|
@nm t="聖良" s=sei_10419
「ご、ごめんなさっ、は、はず、恥ずかしく、て……！」[np]
@chr st01abb07
*p70|
@nm t="千尋"
「お、俺が急に抱きしめたのが悪かった……」[np]
*p71|
距離を開けたまま話し続ける。恋人関係になったのに、[r]
どうして俺たちは前より離れているのか……？[np]
*p72|
そう思っていると、聖良が小さな声で呟いてくる。[np]
@chr st01bbb17
*p73|
@nm t="聖良" s=sei_10420
「す……少しだけ待ってて、くれる？[r]
ちゃんと戻ってくる、から……」[np]
@chr st01bbb11
*p74|
@nm t="千尋"
「え？　待っててって……」[np]
@chr st01abb09
*p75|
@nm t="聖良" s=sei_10421
「お、泳いでたりしてていいからっ……！[r]
少しだけ、そのっ、待っててっ……！」[np]
@chr_del_walk way=l name=聖良
@wt
*p76|
@nm t="千尋"
「あ、ちょっ、聖良――」[np]
*p77|
ビーチから離れていく聖良を呆然と見送る。[r]
あっちは……ホテルの洋館の方じゃ？[np]
*p78|
@nm t="千尋"
「泳いで待っててと言われても……」[np]
*p79|
いや水着なら近くの売店で売ってるか……。[r]
海にでも入って火照りを鎮めるのがいいかもしれないな。[np]
@fobgm time=2000
@hide
@black rule=rule_spiral00
@wbgm
@show
*p80|
………………[np]
*p81|
…………[np]
*p82|
……[np]
@hide
@bg storage=bg_12a_l left=-640 top=-720 rule=rule_spiral00
[se storage="が_海波2" buf=9 delay=0 loop=true]
@show
*p83|
@nm t="千尋"
「遅いな……」[np]
*p84|
しばらく一人で泳いで冷静さを取り戻したところで、[r]
砂浜にあがって聖良を待つ。[np]
*p85|
とはいえ聖良がビーチを立ち去ってから[r]
もう２０分以上が経っていた。[np]
*p86|
やっぱり洋館に戻ってしまったんじゃ？[r]
というか、ここには戻ってこないのでは……？[np]
*p87|
そんなことを思い始めた――その時だった。[np]
*p88|
@nm t="聖良" s=sei_10422
「あっ……――あーるじくんっ！」[np]
@q_small
[se storage="人の行動2_抱く_se2528"]
*p89|
@nm t="千尋"
「おわっ！？」[np]
*p90|
急に背後から抱きつかれる。[r]
というか、この口調は――[np]
[fose buf=9 time=3000]
@hide
@black rule=rule_03_l_r time=250
@eff obj=0 page=back show=true storage=bg_12a_l path=(531,-8,255) size=(1.6,1.6) time=1 bbx=(1) bby=(1) bbt=true bbs=true absolute=(2000)
@bg storage=bg_12a st01ade13 rule=rule_03_l_r time=250
@bgm storage=bgm_04
@show
@chr st01ade17
*p91|
@nm t="聖良" s=sei_10423
「お……お待たせ……」[np]
@chr st01ade07
*p92|
@nm t="千尋"
「～～っっ！？　せ、聖良……！？[r]
というか、その格好っ……！！」[np]
*p93|
突然のことに驚く俺に[r]
聖良は緊張で呼吸を乱しながらも呟いてくる。[np]
@chr st01ade17
*p94|
@nm t="聖良" s=sei_10424
「セ、セーラの力を……その。[r]
借りようと思って……」[np]
@chr st01ade13
*p95|
@nm t="千尋"
「セーラの力を……？」[np]
@chr st01ade16
*p96|
@nm t="聖良" s=sei_10425
「だ、だから、えと……っっ」[np]
@chr st01bde11
*p97|
聖良が意を決したように息を呑む。[r]
そして――[np]
@chr st01bde18
*p98|
@nm t="聖良" s=sei_10426
「ちゅっ……！」[np]
*p99|
@nm t="千尋"
「～～っっ！？」[np]
*p100|
聖良の顔がグっと近くに来たと思った瞬間、[r]
柔らかい唇が押し当てられた……！！[np]
@chr st01bde10
*p101|
@nm t="聖良" s=sei_10427
「んっ……ちゅっ、んはぁむっ、んっ……」[np]
@chr st01bde14
*p102|
@nm t="聖良" s=sei_10428
「れろっ……れろろっ、ぺろっ、んちゅ……」[np]
@chr st01bde18
*p103|
驚き固まる俺の唇を割り開き、聖良の舌が入ってくる。[r]
戸惑い、そしてそれよりも大きな喜びに心が沸き立ってしまう。[np]
@chr st01bde13
*p104|
@nm t="聖良" s=sei_10429
「ぷは……はぁはぁ、え、えへへ……」[np]
@chr st01ade05
*p105|
@nm t="千尋"
「はぁはぁ、聖良……」[np]
*p106|
唇を離したところで改めて彼女を見つめる。[np]
*p107|
この衣装に、そして、セーラの力を借りたいという言葉。[r]
つまり聖良は――[np]
@chr st01ade04
@dchr st01ade12 delay=5476
*p108|
@nm t="聖良" s=sei_10430
「さっきは抱きしめてくれてありがとうね、主くん？[r]
すごく、えへへ、嬉しかった……」[np]
@chr st01ade03
*p109|
セーラのような明るい口調で聖良が話しかけてくる。[np]
@chr st01ade02
@dchr st01ade04 delay=2479
*p110|
@nm t="聖良" s=sei_10431
「ホントは私も、ね？　主くんといっぱい[r]
イチャイチャしたかったの」[np]
@chr st01bde03
*p111|
@nm t="聖良" s=sei_10432
「こうしてお顔ちゃんと見てお話したり、[r]
抱きしめたり、キスしたり……」[np]
@chr st01bde13
*p112|
@nm t="聖良" s=sei_10433
「エッチ……したり」[np]
@chr st01bde02
*p113|
@nm t="千尋"
「聖良……」[np]
@chr st01bde03
*p114|
@nm t="聖良" s=sei_10434
「だからセーラの力を借りて、[r]
自分の気持ち伝えようと思って着替えてきちゃった」[np]
@chr st01bde13
@dchr st01bde14 delay=2937
@dchr st01bde10 delay=6414
*p115|
@nm t="聖良" s=sei_10435
「大好きなあなたと、はぁはぁ――んちゅっ、ちゅっ。[r]
めいっぱいイチャイチャしたくて、エッチもしたくて……！」[np]
@chr st01ade12
*p116|
@nm t="聖良" s=sei_10436
「この間みたいに自分の気持ちに正直になりたくて。[r]
スケベな自分を、大好きな人とエッチしたい自分の気持ちを」[np]
@chr st01ade04
*p117|
@nm t="聖良" s=sei_10437
「全部全部、えへへ……。素直に曝け出したくて……」[np]
@chr st01ade18
*p118|
そう言って聖良がぎゅっと抱きついてくる。[r]
そのまま何度もキスをしてくれる。[np]
@dchr st01ade13 delay=5978
*p119|
@nm t="聖良" s=sei_10438
「ちゅっ、んちゅっ……好き、大好き。[r]
あなたのこと、はぁはぁ、愛してる」[np]
@chr st01ade05
*p120|
@nm t="千尋"
「お、俺も、好きだ。聖良のこと愛してる……」[np]
@chr st01ade12
@dchr st01ade03 delay=2110
*p121|
@nm t="聖良" s=sei_10439
「～～っっ。え、えへへ……」[np]
*p122|
応えると聖良は顔を耳まで真っ赤にして照れた。[r]
しかし、先程までとは違って逃げだしたりしない。[np]
@chr st01bde03
*p123|
@nm t="聖良" s=sei_10440
「このコスがわたしに勇気をくれるの……。[r]
普段は言えないこともセーラがちゃんと言わせてくれて……」[np]
@chr st01bde10
*p124|
聖良がモジモジしながら俺を上目遣いに見つめてくる。[r]
その視線だけでも、俺の心臓はドキンと跳ね上がった。[np]
@chr st01bde13
@dchr st01bde10 delay=5005
*p125|
@nm t="聖良" s=sei_10441
「エッチ、しよ？　主くん……？[r]
お姉ちゃん、はぁはぁ、セックスしたくてたまらない」[np]
@chr st01bde13
*p126|
@nm t="聖良" s=sei_10442
「あなたに初めてをあげてからずっと、[r]
はぁはぁ、あなたの顔を見るだけでムラムラしてるの」[np]
@chr st01ade06
@dchr st01ade13 delay=7364
*p127|
@nm t="聖良" s=sei_10443
「声を聞くだけで、はぁはぁ、発情しちゃって……。[r]
抱きしめられるだけで、はぁはぁ、感じちゃって……」[np]
@dchr st01ade18 delay=2274
@dchr st01ade12 delay=5647
*p128|
@nm t="聖良" s=sei_10444
「キスするだけで――んちゅっ……んふっ。[r]
えへへ、軽くイっちゃうくらい」[np]
@chr st01ade05
*p129|
@nm t="千尋"
「っっ」[np]
*p130|
セーラのように愛情を、自分の欲望を、[r]
包み隠さず告げてくれる聖良。[np]
*p131|
こんな彼女を前にして興奮しない男がいるだろうか？[r]
いや、いない。[np]
@chr st01bde14
*p132|
@nm t="聖良" s=sei_10445
「ふぁ――んんっ。ちゅっ、んふっ、ちゅぁ、れろろ……！」[np]
@chr st01bde18
*p133|
今度は俺の方から、聖良の唇を奪う。[r]
俺も欲望のままにそのふっくらとした唇を貪った。[np]
*p134|
@nm t="千尋"
「はぁはぁ、俺も同じだ。聖良とエッチしたくてしたくて[r]
たまらない。スケベなことばっかり考えてる……」[np]
@chr st01bde10
*p135|
@nm t="聖良" s=sei_10446
「はぁはぁ……千尋くん……」[np]
*p136|
幸せそうに俺の名前を呟いてくれる聖良。[np]
*p137|
そんな彼女を見つめていると[r]
視線の端に乳白色の液体が目に入った。[np]
@chr st01ade13
*p138|
@nm t="聖良" s=sei_10447
「興奮しすぎて……母乳溢れてきちゃった」[np]
*p139|
@nm t="千尋"
「っ……！」[np]
@chr st01ade06
*p140|
@nm t="聖良" s=sei_10448
「ふふ、お姉ちゃんのおっぱい飲みたい？[r]
飲みたいのなら、飲んで良いよ？」[np]
@chr st01ade12
*p141|
@nm t="聖良" s=sei_10449
「お姉ちゃんも……はぁはぁ、飲んで欲しいな？[r]
大好きな主くんに、お姉ちゃんのミルク飲んで欲しい」[np]
@dchr st01ade06 delay=3129
*p142|
@nm t="聖良" s=sei_10450
「きっと、えへへ。スケベな味するから」[np]
@chr st01ade05
*p143|
セーラを演じながら、[r]
ちょっぴり照れたような顔をする聖良。[np]
*p144|
そんな風に誘われて、我慢できるはずなんて――ない！[np]
@hide
@eff_all_delete
@white rule=rule_03_b_t time=250
@show
*p145|
@nm t="聖良" s=sei_10451
「あっ――んはぁん♪」[np]
*p146|
聖良のビキニをズラす。[r]
そして、俺はそのまま彼女のおっぱいに吸い付いた――[np]
@fobgm time=3000
@hide
@wait time=2000
[sse buf=9]
@wbgm
@wait time=1000
@jump storage="102_聖良バニー_01_h.ks"

; 
; 
*p0|
@black
@show
*p1|
………………[np]
*p2|
…………[np]
*p3|
……[np]
*p4|
@nm t="千尋"
「ん……」[np]
@hide
@eff obj=0 page=back show=true storage=sp_bg_08d path=(640,360,255) time=1 correct=false
@bg storage=bg_08d
@show
*p5|
@nm t="千尋"
「知らない天蓋だ……」[np]
*p6|
どうして俺はこんな場所に寝かされてるんだ？[np]
*p7|
吹き込む風が涼しい……というか夜になってるじゃないか……。[np]
@hide
@eff_all_delete
@bg storage=bg_08d_l left=-1280 top=-360
@show
*p8|
若干クラつく頭を押さえつつベッドから起き上がる。[np]
*p9|
それと同時に部屋の扉がゆっくりと開いた。[np]
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
[wse buf=0]
*p10|
@nm t="莉瑠" s=rir_0150
「あ。やっと起きましたか」[np]
@bg storage=bg_08c_l left=-1280 top=-360
*p11|
@nm t="聖良" s=sei_0338
「っっ」[np]
@hide
@bg storage=bg_08c st02abb01=4,1 st01abb07=6
@bgm storage=bgm_02
@show
*p12|
@nm t="千尋"
「莉瑠……聖良……？　あ……！」[np]
*p13|
二人の姿を見て、ようやく思い出す。[np]
*p14|
そうだ。コスプレ中に二人の服が破れて――[np]
@hide
@white time=100
@eff obj=0 page=back show=true storage=bg_07a_l path=(1280,360,255) time=1 bbx=(3) bby=(3) bbt=true bbs=true sepia=true
@eff obj=1 page=back show=true storage=st02abd14 path=(336,882.5,255) time=1 absolute=(15001) sepia=true anm=false
@eff obj=2 page=back show=true storage=st01abd14 path=(933,899.5,255) time=1 absolute=(15002) sepia=true anm=false
@eff obj=3 page=back show=true storage=al_square_020_c path=(640,360,200) time=1000 turn=true absolute=(15003)
@bg storage=bg_07a
@wait time=500
@eff_all_delete
@white time=800
@bg storage=bg_08c st02abb14=4,1 st01abb07=6
@show
@dchr st02bbb12 delay=500
*p15|
@nm t="莉瑠" s=rir_0151
「ちょっ！？　何を思いだしてるんですかっ！？」[np]
@chr st02bbb07 st01bbb11
*p16|
@nm t="千尋"
「おおお、思い出してない！[r]
何も思い出してないぞ……！！」[np]
@chr st02bbb06
@dchr st02bbb12 delay=1200
*p17|
@nm t="莉瑠" s=rir_0152
「絶対ウソです！　めっちゃ鼻の下伸ばしてましたもん！」[np]
@chr st02bbb09
*p18|
@nm t="莉瑠" s=rir_0153
「そ、それに――」[np]
@chr st02bbb13 st01bbb08
*p19|
莉瑠がチラっと俺の股間を見つめてくる。[np]
@chr st01bbb10
*p20|
つられて見れば、勃起していた。[r]
寝起きだからなのか、思い出したからなのか、わからない。[r]
というか、こんなに元気になっちゃって……なんだか感慨深い。[np]
@chr st02bbb07
@dchr st02abb16 delay=1000
*p21|
@nm t="莉瑠" s=rir_0154
「～～っっ。へ、変態……！」[np]
@chr st02abb14
*p22|
@nm t="莉瑠" s=rir_0155
「エロ漫画家ってみんなこうなんですかっ……！？」[np]
@chr st02abb09
*p23|
@nm t="千尋"
「ち、違うっ。というか俺は商業的には一般向けで、[r]
別にエロ漫画家と名乗れるほどじゃ――」[np]
@chr st02abb10
*p24|
@nm t="莉瑠" s=rir_0156
「そんなことどうだっていいです……！」[np]
@chr st02abb11
@dchr st02abb12 delay=1500
*p25|
@nm t="莉瑠" s=rir_0157
「というか私の裸を見た時はなんの反応も[r]
してなかったのに……！」[np]
*p25a|
なんだか複雑そうにわなわなしている莉瑠。[r]
俺の名誉のためにも、ここでびしっと言っておかないと。[np]
*p26|
@nm t="千尋"
「つ――つまりはそういうことだ！」[np]
@chr st02abb09 st01bbb16
*p27|
@nm t="千尋"
「そもそも、俺はセーラとリルルにしか反応しない」[np]
*p28|
@nm t="千尋"
「俺は莉瑠と聖良の裸に興奮したわけじゃない。[r]
セーラとリルルの裸に興奮した……ってことだ……！！」[np]
*p29|
@nm t="千尋"
「その点は勘違いしないでもらいたい。[r]
そもそも俺は２次元至上主義だからなっ！」[np]
@chr st02abb14 st01bbb10
*p30|
@nm t="莉瑠" s=rir_0158
「うわぁ……」[np]
@mq_small
*p31|
@nm t="千尋"
「露骨すぎる！！」[np]
*p32|
そんな風に莉瑠と言い合っていると、[r]
不意に聖良が怖ず怖ずと話しかけてきた。[np]
@chr st01bbb12
*p33|
@nm t="聖良" s=sei_0339
「ご、ごめんね、千尋くん……」[np]
@chr st02abb09 st01bbb07
@dchr st01bbb17 delay=1800
*p34|
@nm t="聖良" s=sei_0340
「さっきは、えと。変なこと言っちゃって……」[np]
@chr st01bbb01
*p35|
@nm t="千尋"
「変なこと……？」[np]
@chr st01bbb11
@dchr st01bbb12 delay=3200
*p36|
@nm t="聖良" s=sei_0341
「だ、だから、その……。[r]
エッチな漫画と同じことしたいって……」[np]
*p37|
@nm t="千尋"
「あ――～～っっ！」[np]
@chr st02abb15
*p38|
@nm t="莉瑠" s=rir_0159
「……興奮してるじゃないですか……」[np]
@chr st02abb09 st01bbb10
*p39|
@nm t="千尋"
「だ、だからこれもセーラと、思ったからっていうか……！！」[np]
@chr st01bbb12
@dchr st01abb09 delay=2400
*p40|
@nm t="聖良" s=sei_0342
「とにかく、えと、忘れてっ……？」[np]
@chr st01abb08
@dchr st01abb17 delay=2100
@dchr st01abb16 delay=4000
@dchr st01abb17 delay=5300
*p41|
@nm t="聖良" s=sei_0343
「あれは、その……！　つい本音が――じゃなくて、[r]
つい興奮しちゃって言っちゃっただけで……！」[np]
@chr st02abb11 st01abb13
@dchr st02abb12 delay=2700
*p42|
@nm t="莉瑠" s=rir_0160
「……あんまり意味変わってないですからね？[r]
もしかしてまだ落ち着いていないんですか？」[np]
@chr st01bbb11
*p43|
@nm t="聖良" s=sei_0344
「～～っっ」[np]
@chr st02abb09
*p44|
聖良が顔を真っ赤にして狼狽える。[np]
*p45|
なんだろう、恥ずかしがるポイントがずれてるような。[np]
*p46|
@nm t="千尋"
「大丈夫。まぁ……その。[r]
ロールプレイに熱が入っちゃっただけだと思うし」[np]
@chr st01bbb17
@dchr st01bbb10 delay=2600
*p47|
@nm t="聖良" s=sei_0345
「う、うん……！　そうなの……！」[np]
@chr st02abb12
*p48|
……恨めしくなる、自分のムッツリスケベさ。[np]
*p49|
ここで「ロールプレイしよう」と俺から誘える性格ならば……。[r]
いや、そうなるとセーラとリルルはいなかったか……うーん、悩ましい。[np]
@chr st02abb07
*p50|
@nm t="莉瑠" s=rir_0161
「でも衣装が破れてくれて逆に良かったかもですね」[np]
@chr st02bbb15 st01bbb16
*p51|
@nm t="莉瑠" s=rir_0162
「あのままだと本気で変なことしてたかもですよ……」[np]
@chr st02bbb01 st01bbb12
@dchr st01bbb10 delay=1600
*p52|
@nm t="聖良" s=sei_0346
「あぅ……。もう一度作り直せる、かな……」[np]
*p53|
@nm t="千尋"
「セーラとリルルの衣装のことか？」[np]
@chr st01bbb01
@dchr st01bbb07 delay=2700
@dchr st01bbb12 delay=6500
*p54|
@nm t="聖良" s=sei_0347
「う、うん……。あれ二着作るだけでも、[r]
すごく時間かかっちゃって……」[np]
@chr st02abb01
*p55|
確かに細部まで拘って作られてたもんな……。[np]
*p56|
エロいとかどうこう抜きに、それだけ頑張ってくれたんだと思うと、[r]
作者としては破れてしまったことが残念で仕方がない。[np]
@chr st01bbb07
@dchr st01abb13 delay=2000
@dchr st01abb07 delay=4900
*p57|
@nm t="聖良" s=sei_0348
「どうしよう……これから作り直したら、[r]
きっとまた一ヶ月くらいかかる、よね……」[np]
*p58|
@nm t="千尋"
「一ヶ月？　それはかかりすぎなような……」[np]
@chr st02abb02
*p59|
@nm t="莉瑠" s=rir_0163
「実は本格的な衣装作りは今回が初めてだったんですよ」[np]
@chr st02abb07
*p60|
@nm t="莉瑠" s=rir_0164
「今までは大体いつも既製品を改造して済ませてましたし」[np]
@chr st01bbb17
*p61|
@nm t="聖良" s=sei_0349
「て、手を抜いてるような言い方はやめて……！」[np]
@chr st02abb01 st01bbb09
@dchr st01bbb06 delay=1700
*p62|
@nm t="聖良" s=sei_0350
「改造するにしても完コス目指して拘ってる、もん……！」[np]
@chr st01bbb12
@dchr st01bbb10 delay=1900
@dchr st01abb17 delay=5700
*p63|
@nm t="聖良" s=sei_0351
「確かにその、衣装作りはまだ慣れてないけど……！[r]
し、刺繍は得意だし……！」[np]
@chr st01abb08
*p64|
聖良の言うとおり刺繍はすごくしっかりしていた。[np]
*p65|
でも少し引っ張っただけで破れるってことは縫製が甘いんだと思う。[np]
*p66|
@nm t="千尋"
「良ければ……俺が作ろうか？」[np]
@chr st02abb09 st01abb14
@dchr st01bbb16 delay=900
*p67|
@nm t="聖良" s=sei_0352
「えっ？　つ、作れる……の？」[np]
*p68|
@nm t="千尋"
「俺のセーラとリルルへの愛を舐めてもらっては困る」[np]
*p69|
@nm t="千尋"
「実は仕事とバイトで貯めた金でセーラとリルルの[r]
オーダーメイド等身大フィギュアを買い、衣装も自作しているほどだ」[np]
@chr st02abb12 st01bbb03
@dchr st02abb09 delay=3200
@dchr st02bbb11 delay=5200
*p70|
@nm t="莉瑠" s=rir_0165
「え……。つまり自分で服を縫ってフィギュアに[r]
着せてるんですか？　ぎ、疑似同棲生活的な……？」[np]
@chr st01bbb04
*p71|
@nm t="千尋"
「言わんとすることはわかるが馬鹿にするもんじゃないぞ。[r]
言っておくが我ながら衣装の出来はかなりのものだと思う」[np]
*p72|
@nm t="千尋"
「わりと何でも作ってきたから１週間もあれば[r]
２着くらいは作れると思うけど……良ければ、作ろうか？」[np]
@chr st02bbb13 st01bbb03
@dchr st01bbb05 delay=1700
@dchr st01bbb13 delay=4600
*p73|
@nm t="聖良" s=sei_0353
「作ってもらえるなら、作ってもらいたい……！[r]
お願いしても、いい？」[np]
@chr st02bbb07 st01bbb02
*p74|
@nm t="莉瑠" s=rir_0166
「ま、待って下さいっ……！」[np]
@chr st02bbb12 st01bbb16
@dchr st02bbb08 st01bbb11 delay=4200
@dchr st02bbb12 delay=6200
*p75|
@nm t="莉瑠" s=rir_0167
「そんなこと言いながら私たちの身体を触るつもりでしょう！[r]
フィ、フィッティングとか言ってっ、エロ漫画みたいに！」[np]
@chr st02bbb07
*p76|
@nm t="千尋"
「そんなことはしないって！　というか、さっきも言ったけど、[r]
別に聖良と莉瑠の裸に興味があるとかそういうのじゃない」[np]
*p77|
@nm t="千尋"
「ただ……出会ったばかりの俺に、二人はコス姿を見せてくれただろう」[np]
@chr st01bbb10
*p78|
@nm t="千尋"
「いっときでもセーラとリルルが３次元に[r]
降臨しているような心地を味わわせてくれた」[np]
@chr st01bbb12
*p79|
@nm t="千尋"
「それに……２人のおかげで、俺のムスコも蘇ることが出来た」[np]
@chr st02abb09
*p80|
@nm t="千尋"
「そのお礼をしたいだけだ」[np]
@chr st01bbb13
*p81|
@nm t="聖良" s=sei_0354
「ティンポジウム先生……」[np]
@chr st01bbb04
*p82|
一瞬ですべてが台無しじゃないか、これ。[np]
@chr st01bbb10
@dchr st01bbb13 delay=2100
*p83|
@nm t="聖良" s=sei_0355
「そういうことなら是非お願いしても……いい？」[np]
@chr st01bbb12
@dchr st01bbb03 delay=3400
@dchr st01bbb05 delay=5900
*p84|
@nm t="聖良" s=sei_0356
「ティ、ティンポジウム先生直々に衣装を[r]
作ってもらえるなんてすごく嬉しい、し……」[np]
@chr st01bbb04
*p85|
@nm t="千尋"
「ああ。もちろんだ」[np]
@chr st02abb15
*p86|
@nm t="莉瑠" s=rir_0168
「あ、私の分の衣装は結構ですからね」[np]
@chr st02abb01 st01abb17
*p87|
@nm t="聖良" s=sei_0357
「え……？」[np]
@chr st02abb12 st01abb08
*p88|
@nm t="莉瑠" s=rir_0169
「いや。悲しそうな顔されても……」[np]
@chr st02abb11
@dchr st02abb08 delay=3700
*p89|
@nm t="莉瑠" s=rir_0170
「あんな格好、もう二度としたくありませんし。[r]
破れてくれてせいせいしましたよ」[np]
@chr st02abb07 st01abb07
@dchr st02abb02 delay=1900
*p90|
@nm t="莉瑠" s=rir_0171
「まぁそういうことなので。それじゃあ失礼します」[np]
@chr st02abb01
@wt
@chr_del name=莉瑠
@wt
[wait time=200]
[se storage="扉_開き戸_木_019_閉じ" buf=0 delay=0]
[wse buf=0]
@chr st01bbb17
@dchr st01bbb07 delay=700
*p91|
@nm t="聖良" s=sei_0358
「ちょっと、莉瑠ちゃん――」[np]
@chr st01bbb12
*p92|
@nm t="聖良" s=sei_0359
「……行っちゃった」[np]
@chr st01abb13
@dchr st01abb07 delay=3400
*p93|
@nm t="聖良" s=sei_0360
「もう……。恥ずかしがり屋さん、なんだから……」[np]
*p94|
@nm t="千尋"
「まぁ……あっちが普通の反応だと思うけど」[np]
@chr st01abb13
@dchr st01abb15 delay=2100
@dchr st01abb14 delay=5300
*p95|
@nm t="聖良" s=sei_0361
「どう、だろう。莉瑠ちゃんは、その……。[r]
天邪鬼さんという、か……」[np]
@chr st01abb12
*p96|
@nm t="聖良" s=sei_0362
「言ってることと思ってることが反対のこと、良くあるから」[np]
@chr st01abb01
*p97|
@nm t="千尋"
「そうなのか？」[np]
@chr st01abb03
@dchr st01abb14 delay=2400
@dchr st01abb02 delay=4600
*p98|
@nm t="聖良" s=sei_0363
「う、うん。だから本当はきっと着たいんじゃないかなって」[np]
@chr st01abb01
*p99|
なら一応、莉瑠の衣装も作っておいた方がいいかもしれない。[r]
着るか着ないかは本人に任せればいい。[np]
*p100|
とりあえず明日は……衣装を作るための生地なんかを[r]
見に行かないといけないかな。[np]
*p101|
コスプレリゾートを謳うだけあって、[r]
ここのショップはそういうのもすごく充実していると聞く。[np]
*p102|
そこへ行けば、必要なものは揃えられるだろう。[np]
*p103|
しかし裁縫道具は流石に持ってきていない。[r]
聖良たちが持っていればいいけど。[np]
*p104|
@nm t="千尋"
「ミシンとかは――」[np]
@chr st01bbb16
@dchr st01bbb11 delay=1400
*p105|
@nm t="聖良" s=sei_0364
「あ……～～っっ」[np]
@chr st01bbb12
*p106|
聖良に尋ねようと視線を向けたところで、[r]
彼女がじっと俺を見つめていたことに気づいた。[np]
*p107|
俺と視線が合うや否や、[r]
聖良はバツが悪そうに目を泳がしてくる。[np]
*p108|
@nm t="千尋"
「……どうかした？」[np]
@chr st01bbb08
@dchr st01bbb10 delay=1800
*p109|
@nm t="聖良" s=sei_0365
「あ、えと……！　その……！」[np]
@chr st01abb15
@dchr st01abb13 delay=2600
*p110|
@nm t="聖良" s=sei_0366
「莉瑠ちゃんもいなくなったし、と思って……」[np]
*p111|
@nm t="千尋"
「？？？」[np]
*p112|
ますます意味がわからない。[np]
*p113|
莉瑠がいなくなったから……なんだろう？[np]
@chr st01abb17
@dchr st01abb08 delay=2700
@dchr st01abb13 delay=6400
*p114|
@nm t="聖良" s=sei_0367
「あの……。こんなこと言うと、その……。[r]
変な子だって思われるかもしれないけど……」[np]
@chr st01abb14
@dchr st01abb15 delay=3100
@dchr st01abb17 delay=6100
*p115|
@nm t="聖良" s=sei_0368
「でも、もしも……。もしも、ね……？[r]
千尋くんが嫌じゃないなら、えと……」[np]
@chr st01abb12
*p116|
@nm t="聖良" s=sei_0369
「コ、コスプレ衣装を作ってもらった後に……！」[np]
@chr st01abb07
*p117|
言おうか言うまいか迷うように何度も視線を動かす聖良。[np]
*p118|
しかし、意を決したように俺の目を見据えると――[np]
@chr st01abb17
@dchr st01abb09 delay=3100
@dchr st01abb12 delay=5700
*p119|
@nm t="聖良" s=sei_0370
「わ、わたしと、エッチなロールプレイ、しないっ……？」[np]
@chr st01abb05
*p120|
@nm t="千尋"
「なっ――」[np]
@chr st01bbb10
@dchr st01bbb12 delay=1100
@dchr st01bbb10 delay=2100
*p121|
@nm t="聖良" s=sei_0371
「莉瑠ちゃんには、その。秘密で……！」[np]
@chr st01bbb07
@dchr st01bbb12 delay=2600
*p122|
@nm t="聖良" s=sei_0372
「言うと絶対止めると思う、から……！」[np]
@chr st01bbb17
@dchr st01abb13 delay=2800
@dchr st01abb17 delay=6300
*p123|
@nm t="聖良" s=sei_0373
「でもどうしても、わたし、その……！[r]
してみたく、て……！」[np]
@chr st01abb13
@dchr st01abb08 delay=3000
*p124|
@nm t="聖良" s=sei_0374
「セーラと同じようなエッチ、し、してみたくて……！」[np]
@chr st01abb13
@dchr st01abb17 delay=1900
*p125|
@nm t="聖良" s=sei_0375
「こんなこと頼めるの、あ、あなたしかいないから……！」[np]
@chr st01abb07
*p126|
俺は一体何を真剣に頼まれているんだ……！？[np]
*p127|
セーラみたいなエッチがしたいだって……！？[np]
*p128|
流石にそれは――[np]
@chr st01bbb17
@dchr st01bbb10 delay=700
@dchr st01bbb12 delay=3600
*p129|
@nm t="聖良" s=sei_0376
「や、やっぱり変かな……？」[np]
*p130|
@nm t="千尋"
「っ……」[np]
@chr st01bbb10
@dchr st01bbb07 delay=2600
@dchr st01bbb12 delay=7100
*p131|
@nm t="聖良" s=sei_0377
「変、だよね……。憧れの漫画の作者さんだとしても、[r]
今日会ったばかりの人に、こんなこと頼むの……」[np]
*p132|
@nm t="千尋"
「聖良……」[np]
@chr st01bbb01
@dchr st01bbb07 delay=2500
@dchr st01bbb10 delay=4900
*p133|
@nm t="聖良" s=sei_0378
「自分でも、ね……？　わかってるの。[r]
こんなの普通じゃないって……」[np]
@chr st01bbb12
@dchr st01bbb07 delay=3500
@dchr st01bbb10 delay=8200
*p134|
@nm t="聖良" s=sei_0379
「でも、その……。わたし、小さい時からスケベで……。[r]
エッチな漫画ばっかり好きで……」[np]
@chr st01abb08
*p135|
@nm t="聖良" s=sei_0380
「そのせいで周りから白い目で見られることもあって……」[np]
@chr st01abb17
*p136|
@nm t="聖良" s=sei_0381
「人と喋るのもどんどん苦手になって……」[np]
@chr st01abb13
*p137|
@nm t="千尋"
「…………」[np]
*p138|
……俺も聖良と似たような経験がある。[np]
*p139|
性的な表現が絡むものだと、人によって好き嫌いは出る。[r]
それ自体は、仕方ないとは思うけど──[np]
@chr st01abb07
@dchr st01abb08 delay=1000
@dchr st01abb13 delay=3000
*p140|
@nm t="聖良" s=sei_0382
「だけどやっぱりエッチなこと嫌いになれなくて……」[np]
@chr st01abb14
@dchr st01abb12 delay=2000
*p141|
@nm t="聖良" s=sei_0383
「そんな時に、自分の名前と同じ名前のヒロインの[r]
漫画を見つけて……」[np]
@chr st01abb15
@dchr st01abb13 delay=4800
@dchr st01abb12 delay=9600
*p142|
@nm t="聖良" s=sei_0384
「セーラと自分を重ねて……。[r]
自分もこんな風にエッチできたらって……思って」[np]
@chr st01abb05
*p143|
聖良とセーラの名前が同じだったのは偶然ではあった。[np]
*p144|
けど、そんな偶然があったからこそ、[r]
彼女は俺の作品を読み始めてくれたのか。[np]
*p144a|
こういうのも、縁というものなのかもしれない。[np]
*p145|
そんなことを考えていると、[r]
聖良はふと我に返ったのかパタパタと首を横に振った。[np]
@chr st01abb08
@dchr st01bbb17 delay=1100
@dchr st01bbb12 delay=2400
@dchr st01bbb10 delay=5100
*p146|
@nm t="聖良" s=sei_0385
「～～っっ。ご、ごめんなさっ……！[r]
やっぱり今のは、えと。聞かなかったことにして……！」[np]
@chr st01bbb17
@dchr st01abb16 delay=2000
*p147|
@nm t="聖良" s=sei_0386
「衣装も作らなくていいから……！[r]
ぜ、全部、なかったことに――」[np]
*p148|
@nm t="千尋"
「……俺でいいなら」[np]
@chr st01abb14
*p149|
@nm t="聖良" s=sei_0387
「え……？」[np]
*p150|
@nm t="千尋"
「俺でいいなら、その。付き合う……いや、付き合わせて欲しい」[np]
@chr st01abb13
*p151|
@nm t="千尋"
「こんなこというのは恥ずかしいけど……正直、俺もしてみたい。[r]
何しろあの漫画は俺の欲望を詰め込んだものだし……！」[np]
@chr st01abb14
*p152|
@nm t="千尋"
「それをリアルで――しかもセーラにしか見えない[r]
女の子にしてもらえるなんて俺にとっては夢でしかない！」[np]
@chr st01bbb10
@dchr st01bbb13 delay=1200
*p153|
@nm t="聖良" s=sei_0388
「ち、千尋くん……」[np]
@chr st01bbb04
*p154|
聖良が照れたような、嬉しそうな顔で俺を見つめてくる。[np]
*p155|
その顔を直視していられなくて、俺は背を向けた。[np]
*p156|
@nm t="千尋"
「でも俺は……その、そういう経験もないし、[r]
本当にそういう状況になったら、勃たないかもしれない」[np]
*p157|
@nm t="千尋"
「どれだけコスプレしてもらって、セーラに見えても、[r]
そういうことはあるかもしれないから、そうなったら諦めて欲しい」[np]
@chr st01abb12
@dchr st01abb06 delay=3000
*p158|
@nm t="聖良" s=sei_0389
「う、うん。ありがとう、千尋くん……！」[np]
@chr st01abb05
*p159|
@nm t="千尋"
「いや……お礼を言われることではないと思う、ホントに……」[np]
*p160|
自分で予防線を張ってしまったが、[r]
きっとセーラコスの聖良を見るだけで勃起することだろう。[np]
*p161|
その証拠に、彼女とのロールプレイを想像するだけで、[r]
今もズボンの中のムスコがうずうずと膨らみかかっている。[np]
*p161a|
どう取り繕っても、俺はエロ漫画を描く人間で、[r]
なんだかんだ、エロいことへの興味はある……ってことだと思う。[np]
*p162|
@nm t="千尋"
「そ、それよりミシンってあるかな？[r]
なければ道具類も買うけど……」[np]
@chr st01abb02
@dchr st01abb04 delay=5000
*p163|
@nm t="聖良" s=sei_0390
「リビングに備え付けのものがある、よ？[r]
後で出しておくから好きに使って……？」[np]
@chr st01abb03
*p164|
@nm t="千尋"
「おお、流石コスタリア……わかったよ」[np]
@chr st01bbb08
@dchr st01bbb03 delay=1700
@dchr st01bbb05 delay=3700
*p165|
@nm t="聖良" s=sei_0391
「あ……そうだ。島にいる間は、[r]
ここに泊まってくれていいから、ね？」[np]
@chr st01bbb04
*p166|
@nm t="千尋"
「えっ！？　さ、流石にそれは――」[np]
@chr st01bbb13
@dchr st01bbb03 delay=1700
*p167|
@nm t="聖良" s=sei_0392
「気にしないで……？　お部屋はいっぱい余ってるし……」[np]
@chr st01abb02
@dchr st01abb04 delay=2600
*p168|
@nm t="聖良" s=sei_0393
「今夜泊まってもらうことは莉瑠ちゃんにも話してあるから」[np]
@chr st01abb15
*p169|
それに、と聖良がボソリと呟く。[np]
@chr st01abb02
@dchr st01abb13 delay=1200
@dchr st01abb12 delay=2800
*p170|
@nm t="聖良" s=sei_0394
「わたしとしても……その。[r]
泊まってくれた方が嬉しい、し……」[np]
@chr st01abb03
*p171|
@nm t="千尋"
「そ、それってどういう――」[np]
@chr st01bbb11
@dchr st01bbb17 delay=700
@dchr st01bbb10 delay=2600
*p172|
@nm t="聖良" s=sei_0395
「～～っっ。と、とにかく泊まってくれていい、から……！」[np]
@chr_del name=聖良
*p173|
@nm t="千尋"
「あ……！　聖良――」[np]
[se storage="扉_開き戸_木_019_閉じ" buf=0 delay=0]
*p174|
戸惑ってる間に聖良が出て行く。[np]
*p175|
い、色々なことがありすぎて、[r]
心臓の爆音が止まらない……！[np]
*p175a|
思い立ったようにコスタリアに来た俺は、[r]
当然のようにホテルの予約なんかしてもない。[np]
*p175b|
そういう意味ではすごく助かるし、ありがたいけど、[r]
女の子と一つ屋根の下、なんて……。[np]
*p176|
@nm t="千尋"
「そ、そうだ、漫画を描こう……！」[np]
*p177|
今なら描ける気がする……！　描きたい、と思えるし、[r]
何より気を落ち着かせることにも繋がるかもしれない。[np]
*p178|
それに今日一日で味わった興奮を、リビドーを、[r]
形にしておかなければ、もったいない。[np]
@hide
@bg storage=bg_08c_l left=0 top=-560
@show
*p179|
鞄からタブレットとタッチペンを取り出して、[r]
妄想に筆を走らせる。[np]
*p180|
半年間白紙のままだったページが[r]
みるみるうちに形をなしていった。[np]
@fobgm time=2000
@hide
@black
@wbgm
@show
*p181|
………………[np]
*p182|
…………[np]
*p183|
……[np]
@hide
@bg storage=bg_08c
@show
[se storage="扉_開き戸_木_010_開け_強" buf=0 delay=0]
@chr_walk way=r st02abb15
*p184|
@nm t="莉瑠" s=rir_0172
「はいドーン――」[np]
@bgm storage=bgm_04
@chr st02abb01
[se storage="ノートを閉じる音" buf=0 delay=0]
*p185|
@nm t="千尋"
「うおっ！！？」[np]
*p186|
突然部屋の扉が開けられて、[r]
反射的にタブレットを裏向けにする。[np]
@chr st02abb15
@dchr st02abb12 delay=1400
*p187|
@nm t="莉瑠" s=rir_0173
「……意外ですね。[r]
ベッドで変なことしてると思ってましたのに」[np]
*p188|
@nm t="千尋"
「するわけないだろう……！！」[np]
@chr st02abb09
@dchr st02abb15 delay=900
@dchr st02abb11 delay=3700
*p189|
@nm t="莉瑠" s=rir_0174
「チっ。つまみ出す理由が作れませんでした。作戦失敗です」[np]
*p190|
残念そうに肩をすくめる莉瑠。[r]
というか、本当にしてたらどうする気だったんだ。[np]
*p191|
@nm t="千尋"
「それより何しに来たんだ？」[np]
@chr st02abb15
@dchr st02abb01 delay=1900
*p192|
@nm t="莉瑠" s=rir_0175
「お風呂ですよ。お風呂。[r]
空きましたけど入ります？」[np]
*p193|
@nm t="千尋"
「わざわざ伝えに来てくれたのか？　なんか意外だ……」[np]
@chr st02abb11
@dchr st02abb09 delay=2200
@dchr st02abb12 delay=4100
*p194|
@nm t="莉瑠" s=rir_0176
「聖良に言われたからですよ。[r]
自分で伝えに行けばいいのに何故か嫌がって……」[np]
*p195|
@nm t="千尋"
「そ、そうなのか」[np]
@chr st02abb15
@dchr st02bbb12 delay=1100
*p196|
@nm t="莉瑠" s=rir_0177
「……ん？　なんですか急にドモって……」[np]
@chr st02bbb10
@dchr st02bbb07 delay=1100
*p197|
@nm t="莉瑠" s=rir_0178
「まさか、聖良と何かあったんじゃ――」[np]
*p198|
@nm t="千尋"
「な――ない！　何もなかったって……！」[np]
@chr st02bbb12
*p199|
@nm t="莉瑠" s=rir_0179
「怪しすぎますね……」[np]
@chr st02bbb07
*p200|
@nm t="千尋"
「とにかくお風呂が空いたんだな！[r]
ありがとう、入ってくるよ……！」[np]
@shide
@black rule=rule_03_r_l time=200
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
@wait time=200
@sshow
*p201|
@nm t="莉瑠" s=rir_0180
「あっ、待って下さい。聖良と何を――」[np]
*p202|
莉瑠の声を振り切るように部屋を出る。[r]
詰問されると顔に出てしまいそうだ。[np]
@hide
@wait time=500
@bg storage=bg_08c_l left=-640 top=-360 st02bab13 time=800
@show
*p203|
@nm t="莉瑠" s=rir_0181
「…………」[np]
@chr st02bab09
@dchr st02bab14 delay=2400
*p204|
@nm t="莉瑠" s=rir_0182
「……聖良ばっかりズルいです。[r]
ティンポジウム先生と仲良くして……」[np]
@chr st02aab11
@dchr st02aab12 delay=1100
*p205|
@nm t="莉瑠" s=rir_0183
「まぁ……私の態度が悪いのもいけないのかもですが……」[np]
@chr st02aab13
@dchr st02aab08 delay=1400
*p206|
@nm t="莉瑠" s=rir_0184
「うぅ、どうして私はいつも、こう大事な時に……」[np]
@chr st02aab12
@dchr st02aab09 delay=1700
*p207|
@nm t="莉瑠" s=rir_0185
「そういえば……何か描いてました、よね」[np]
@hide
@black
@wait time=1000
@bg storage=bg_11a
@show
*p208|
@nm t="千尋"
「広っ……！　流石はＶＩＰ用施設だな……」[np]
*p209|
しかも異世界風の作りというか。[r]
中世ヨーロッパ風の作りというか。手が込んでいる。[np]
*p210|
いつまでも入りたくなるような大浴場だけど……[r]
あまり長風呂するのも悪いしパパっと済ませるか。[np]
*p211|
@nm t="千尋"
「あ……しまった、着替え」[np]
*p212|
かけ湯をしようと思ったところでギリギリ思い出す。[r]
慌てて部屋を飛び出したもんな……。[np]
*p213|
鞄の中には数日分の着替えは入れてある。[r]
羽根を伸ばしがてら、多少はゆっくりするつもりだったから。[np]
@fobgm time=2000
@hide
@black
@wait time=1000
@show
*p214|
大浴場を出て再び着替え直し、廊下へ出る。[np]
*p215|
そうして部屋の前に戻ってきた時だった。[np]
@hide
@eff obj=0 page=back show=true storage=st02acb13 path=(290,540,255) size=(0.5,0.5) time=1
@eff obj=1 page=back show=true storage=sp_bg_08c_ドア左 path=(640,360,255) time=1 absolute=(15001) correct=false
@eff obj=2 page=back show=true storage=sp_bg_08c_ドア右 path=(640,360,255) time=1 absolute=(15002) cx=1280 correct=false
@bg storage=bg_08c left=100
@bgm storage=bgm_10
@eff obj=2 storage=sp_bg_08c_ドア右 path=(640,360,255) time=1000 accel=-2 absolute=(15002) cx=1280 xsize=(1,0.98) correct=false
@weff obj=2
@aseff
@show
*p216|
@nm t="？？？" rt="莉瑠" s=rir_0186
「……すご……えっちぃ……す……」[np]
*p217|
@nm t="千尋"
「ん……？」[np]
*p218|
部屋に誰かいる……もしかして部屋を間違えたかな？[np]
*p219|
……間違いなく、この部屋だ。[np]
*p220|
@nm t="？？？" rt="莉瑠" s=rir_0187
「か、描けないって言ってたクセに、[r]
ちゃんと描けてるじゃないですか……」[np]
*p221|
@nm t="？？？" rt="莉瑠" s=rir_0188
「というかこれ……さっきの……」[np]
*p222|
まさかさっき描いた漫画を読まれてる！？[r]
この声、もしや莉瑠か──[np]
@hide
@eff obj=2 storage=sp_bg_08c_ドア右 path=(640,360,255) time=1000 accel=-2 absolute=(15002) cx=1280 xsize=(0.98,0.9) correct=false
@weff obj=2
@show
*p223|
こっそりと部屋の中を覗いてみる。[r]
すると、やはり莉瑠が部屋に居座っていた。[np]
*p224|
左手にある椅子に座って、[r]
漫画を描いたタブレットを開いている。[np]
@hide
@eff_all_delete
@bg storage=bg_08c_l left=0 top=-560 st02acb08=3.5
@show
@dchr st02acb13 delay=1300
*p225|
@nm t="莉瑠" s=rir_0189
「やっぱり昼間の出来事が再現されてます、よね……」[np]
@chr st02bcb14
*p226|
@nm t="莉瑠" s=rir_0190
「リルルがハンカチ持って涙ぬぐって……」[np]
@chr st02bcb10
@dchr st02bcb09 delay=1000
*p227|
@nm t="莉瑠" s=rir_0191
「って――～～っっ。リルルが脱ぎだして……！」[np]
@chr st02bcb16
*p228|
@nm t="莉瑠" s=rir_0192
「わ、私、ここまでしてませんってば……！」[np]
@hide
@eff obj=0 page=back show=true storage=st02bcb16 path=(180,530,255) size=(0.5,0.5) time=1
@eff obj=1 page=back show=true storage=black path=(-520,360,255) time=1 bbx=5 bbt=true bbe=true bbs=true
@eff obj=2 page=back show=true storage=black path=(860,360,255) time=1 bbx=(5) bbt=true bbe=true bbs=true absolute=(15002)
@eff obj=0 page=back show=true storage=st02acb13 path=(290,540,255) size=(0.5,0.5) time=1
@eff obj=1 page=back show=true storage=sp_bg_08c_ドア左 path=(640,360,255) time=1 absolute=(15001) correct=false
@eff obj=2 page=back show=true storage=sp_bg_08c_ドア右 path=(640,360,255) time=1 absolute=(15002) cx=1280 xsize=(0.9,0.9) correct=false
@bg storage=bg_08c left=100
@show
*p229|
@nm t="千尋"
「……っ」[np]
*p230|
マズい……あれを見られるのはマズい。[r]
今日の出来事を土台にして描いてるから。[np]
*p231|
もしもあのままリルルにお世話されて、[r]
パイズリされたら――という内容だ。[np]
*p232|
コスプレしている当人が見れば、[r]
相当気持ち悪いもののはず。[np]
*p232a|
それに思いに任せて、ネームも切らずに描いたものだ。[r]
まだまだ線もばばっと描いてるだけだし、正直、恥ずかしい。[np]
*p233|
止めなければ――[np]
@hide
@eff_all_delete
@bg storage=bg_08c_l left=0 top=-560 st02bcb13=3.5
@show
@dchr st02bcb14 delay=1400
*p234|
@nm t="莉瑠" s=rir_0193
「でも……す、すごく、えっちぃです……」[np]
*p235|
――なんと？[np]
@chr st02acb13
@dchr st02acb08 delay=5700
@dchr st02acb12 delay=7600
*p236|
@nm t="莉瑠" s=rir_0194
「と、というか明らかに私の身体を元に描いてますよね……？[r]
いつものリルルより、にゅ、乳輪大きいですし……」[np]
@chr st02acb13
@dchr st02acb17 delay=3700
*p237|
@nm t="莉瑠" s=rir_0195
「でも、はぁはぁ、すごくえっちぃ……」[np]
@chr st02acb13
@dchr st02acb06 delay=3000
*p238|
@nm t="莉瑠" s=rir_0196
「き、きっとこんな風に私の胸見てたんですね……」[np]
@chr st02acb05
*p239|
気持ち悪がられて……ない？[np]
*p240|
むしろ、めちゃくちゃ読み込まれてるような……。[np]
@chr st02acb15
@dchr st02acb14 delay=2400
*p241|
@nm t="莉瑠" s=rir_0197
「おっぱいの描き方、や、やっぱり上手い……」[np]
@chr st02bcb09
*p242|
@nm t="莉瑠" s=rir_0198
「指が沈み込んでおっぱいが指の隙間から零れてるところとか」[np]
@chr st02bcb13
@dchr st02bcb14 delay=4700
*p243|
@nm t="莉瑠" s=rir_0199
「どうやったらこんな風にエッチな身体描けるんでしょうか。[r]
自分の身体を模写しても、こんな風に描けないのに……」[np]
@chr st02bcb13
@dchr st02bcb11 delay=2000
*p244|
@nm t="莉瑠" s=rir_0200
「私も……こんな風にエッチな身体[r]
描けるようになりたいです……」[np]
@chr st02acb13
@dchr st02acb12 delay=2600
*p245|
@nm t="莉瑠" s=rir_0201
「エッチな漫画……描いてみたい……」[np]
*p246|
莉瑠が悲しげに目を伏せる。[np]
@fobgm time=2000
@hide
@black
@show
*p247|
その表情が、昔の記憶を思い起こさせた。[np]
*p248|
『こんなものを人様の前で読むんじゃない』[r]
『そんな漫画を描いて恥ずかしくないのか』[np]
*p248a|
父さんに……親父に言われた言葉。[r]
父の漫画は、硬派で対極にあるような画風だった。[np]
*p248b|
だから、許容されなかったのかもしれない。[r]
俺は、否定されてしまったけど……でも──[np]
@hide
@bg storage=bg_08c
@bgm storage=bgm_09
@show
*p249|
@nm t="千尋"
「……描けばいいんじゃないか？」[np]
@chr_standup st02acb14=2
@dchr st02bcb06 delay=600
@dchr st02bcb09 delay=2000
*p250|
@nm t="莉瑠" s=rir_0202
「えっ？　――ち、千尋さん！？[r]
おおお、お風呂に行ったはずじゃ……！！」[np]
@chr st02bcb13
*p251|
@nm t="千尋"
「そんなことより──」[np]
@hide
@bg storage=bg_08c_l left=0 top=-360 st02bab10
@show
@chr_quake name="莉瑠" sx=5 xcnt=10 sy=3 ycnt=7 time=300 loop=false fade=false delay=0
[se storage="se_動_掴01+" buf=0 delay=0]
@chr st02aab08
*p252|
@nm t="莉瑠" s=rir_0203
「ひゃっ！？」[np]
@chr st02aab13
*p253|
気づけば俺は部屋に入って莉瑠の肩を掴んでいた。[np]
*p254|
@nm t="千尋"
「描きたいと思うなら、まずは恥ずかしがらず描くべきだ」[np]
@chr st02aab14
@dchr st02aab11 delay=900
@dchr st02aab15 delay=3700
*p255|
@nm t="莉瑠" s=rir_0204
「～～っっ。な、何を言っているのかわかりません。[r]
誰が何を描きたいですって？」[np]
@chr st02aab09
*p256|
@nm t="千尋"
「エロ漫画を描きたいって言ってたじゃないか。[r]
なら、別に趣味でも遊びでもいいから描けばいい」[np]
*p257|
@nm t="千尋"
「別にそれ自体は、恥ずかしいことじゃない」[np]
@chr st02aab12
@dchr st02aab13 delay=800
*p258|
@nm t="莉瑠" s=rir_0205
「っっ……！！　そ、そう言われても……」[np]
@chr st02aab08
@dchr st02aab11 delay=4400
*p259|
@nm t="莉瑠" s=rir_0206
「わ、私、周りには優等生で通ってますし……。[r]
そんな女がエッチな漫画描いてたりしたら……！」[np]
@chr st02aab12
*p260|
@nm t="莉瑠" s=rir_0207
「だ、だからコスプレだって――」[np]
*p261|
@nm t="千尋"
「ひけらかすわけでもなし……いいじゃないか、別に」[np]
@chr st02aab09
*p262|
@nm t="千尋"
「そもそも優等生が実はスケベなんて設定、[r]
そう珍しいものじゃないだろう」[np]
@chr st02bab09
*p263|
@nm t="莉瑠" s=rir_0208
「そ、それは２次元での話で――」[np]
@chr st02bab11
*p264|
@nm t="千尋"
「とにかく――エロが好きなのは恥ずかしいことじゃない」[np]
@chr st02bab14
*p265|
@nm t="莉瑠" s=rir_0209
「ち……千尋さん……」[np]
*p266|
語気の弱くなった莉瑠の声を聞いて、ハっと我に返る。[np]
@hide
@eff obj=0 page=back show=true storage=bg_08c_l path=(1024,360,255) size=(0.8,0.8) time=1 rad=(0,0) clear=true absolute=1500
@bg storage=bg_08c st02bbb14
@show
*p267|
掴んでいた肩を慌てて離して、一歩距離を取った。[np]
*p268|
@nm t="千尋"
「す、すまない……急に」[np]
@chr st02abb01
*p269|
@nm t="千尋"
「つい、その……好きなことを否定するような莉瑠の物言いに、[r]
なんだかムカついてしまって……」[np]
@chr st02abb12
@dchr st02abb13 delay=2100
*p270|
@nm t="莉瑠" s=rir_0210
「ムカついたって……。[r]
そ、そんな気持ちで喋ってたんですかっ？」[np]
*p271|
@nm t="千尋"
「だ、だから悪かったって」[np]
*p272|
さっき聖良の話を聞いて、昔のことを思い出したせいもあるだろう。[r]
ついつい莉瑠にも、昔の自分を重ねてしまった。[np]
*p273|
もしかしたら莉瑠に言った言葉は、[r]
昔の自分に言いたい言葉だったのかもしれない。[np]
*p274|
いいや。昔じゃなくて、今だって俺は――[np]
@chr st02abb12
@dchr st02abb08 delay=1500
*p275|
@nm t="莉瑠" s=rir_0211
「もしかして……千尋さんもなんですか？」[np]
@chr st02abb09
*p276|
@nm t="千尋"
「え？」[np]
@chr st02abb12
@dchr st02abb11 delay=1900
@dchr st02abb13 delay=4000
*p277|
@nm t="莉瑠" s=rir_0212
「だから、その……。エッチな漫画描きたくても[r]
描けないというか……」[np]
@chr st02abb12
@dchr st02abb08 delay=2600
*p278|
@nm t="莉瑠" s=rir_0213
「個人サイトで連載してるのも、そのせいだとか……」[np]
@chr st02bbb11
@dchr st02bbb17 delay=4700
@dchr st02bbb14 delay=6400
*p279|
@nm t="莉瑠" s=rir_0214b
「千尋さん、表の作品では全くエロ描きませんもんね……」[np]
@chr st02bbb09
@dchr st02bbb11 delay=1600
*p280|
@nm t="莉瑠" s=rir_0215
「描かせてもらえないとか、ですか……？」[np]
*p281|
@nm t="千尋"
「っ！？　ちょ、ちょっと待って。[r]
一体、何を言ってるんだ……！？」[np]
@chr st02bbb10
@dchr st02bbb09 delay=1700
@dchr st02bbb13 delay=5500
*p282|
@nm t="莉瑠" s=rir_0216
「で、ですから『天門！！漢学園』描いてるの、[r]
千尋さんなんでしょう？　名義は違いますけど……」[np]
*p283|
@nm t="千尋"
「ええっ！？　どうして、それを……」[np]
@chr st02bbb11
*p284|
@nm t="莉瑠" s=rir_0217
「絵を見たらわかりますよ……」[np]
@chr st02bbb14
@dchr st02bbb13 delay=1200
@dchr st02bbb15 delay=2700
*p285|
@nm t="莉瑠" s=rir_0218
「私が何年、その……。[r]
ティンポジウム先生の作品見てたと思ってるんですか……」[np]
@chr st02abb11
@dchr st02abb12 delay=3700
@dchr st02abb13 delay=6400
*p286|
@nm t="莉瑠" s=rir_0219
「とろキンの連載が始まるよりずっと前の、[r]
イラストしか上げてなかった時代から知ってますもん……」[np]
*p287|
イラストだけの頃からって――かなり前の話だぞ。[np]
*p288|
もしかして莉瑠は俺の絵をずっと見て、追っかけてくれているんだろうか？[np]
@chr st02abb14
@dchr st02abb08 delay=1600
@dchr st02bbb09 delay=3800
*p289|
@nm t="莉瑠" s=rir_0220
「あ――～～っっ。い、今のは忘れて下さい……！[r]
言うつもりは一切なかったんです……！」[np]
@chr st02bbb13
@dchr st02bbb08 delay=1200
@dchr st02bbb12 delay=3000
@dchr st02bbb07 delay=7000
*p290|
@nm t="莉瑠" s=rir_0221
「ただ、えと。私が言いたいのは、自分ができてないのに[r]
偉そうに言うなんてムカつくって話です、はい……！」[np]
@mq_small
[se storage="コミカル_刺さる01" buf=0 delay=0]
*p291|
@nm t="千尋"
「うぐっ……！！」[np]
@chr st02bbb10
@dchr st02bbb09 delay=300
@dchr st02abb08 delay=1600
*p292|
@nm t="莉瑠" s=rir_0222
「あ……！　ち、違います……！[r]
今のは言葉のアヤ的なもので……！」[np]
@chr st02abb13
*p293|
@nm t="莉瑠" s=rir_0223
「本当は、その……」[np]
*p294|
莉瑠が恥じ入るように頬を赤らめる。[np]
*p295|
そして、俺に視線をまっすぐに向けて小さく口を開いた。[np]
@chr st02abb12
@dchr st02abb17 delay=3100
*p296|
@nm t="莉瑠" s=rir_0224
「嬉しくは……ありました。[r]
ティンポジウム先生も、私と同じなんだって思って……」[np]
@chr st02abb13
*p297|
@nm t="千尋"
「莉瑠……」[np]
@chr st02abb14
@dchr st02abb15 delay=600
@dchr st02bbb10 delay=4000
@dchr st02bbb07 delay=6400
*p298|
@nm t="莉瑠" s=rir_0225
「～～っっ。で、でもとんだチキン野郎だとは思います。[r]
こんなに上手いのに商業で描かずにコソコソ描いてるなんて」[np]
@mq_small
[se storage="効果_矢が刺さる" buf=0 delay=0]
*p299|
@nm t="千尋"
「ぐはっ……！！」[np]
@chr st02bbb13
@dchr st02bbb11 delay=2700
@dchr st02bbb14 delay=6000
*p300|
@nm t="莉瑠" s=rir_0226
「けど、えと……。恥ずかしがらずに描けって[r]
言ってもらえたのは心に響きました……」[np]
*p301|
@nm t="千尋"
「り、莉瑠……」[np]
@chr st02abb15
@dchr st02abb11 delay=1000
@dchr st02abb15 delay=5100
*p302|
@nm t="莉瑠" s=rir_0227
「ま、まぁ、本人に見られるかもしれないのに、[r]
さっきの出来事をエロ漫画化するのはキモいですが」[np]
@mq_small
[se storage="コミカル_刺さる01" buf=0 delay=0]
*p303|
@nm t="千尋"
「ぐふぅ……！！」[np]
*p304|
さっきから正論が暴力のように俺に突き刺さる。[np]
@chr st02abb12
@dchr st02abb13 delay=1700
*p305|
@nm t="莉瑠" s=rir_0228
「そ、その……私にも描けます、かね？」[np]
@chr st02abb11
@dchr st02abb08 delay=1900
@dchr st02bbb13 delay=3500
@dchr st02bbb14 delay=6400
*p306|
@nm t="莉瑠" s=rir_0229
「エッチな漫画描いたり、エッチなコスプレしたり、[r]
エッチなことに興味持ってても、変じゃないですか……？」[np]
*p307|
自信なさげな顔で莉瑠が俺を見据えてくる。[np]
*p308|
@nm t="千尋"
「俺は変じゃない、と思う」[np]
@chr st02bbb15
*p309|
@nm t="千尋"
「でも、それを決めるのは莉瑠自身だから、[r]
自分の気持ちを何よりも大事にすべきなんじゃないかな」[np]
@chr st02bbb13
*p310|
@nm t="千尋"
「なんて……スランプ中でうだうだしてる俺が言っても説得力はないか」[np]
@chr st02abb03
@dchr st02abb02 delay=1400
@dchr st02abb17 delay=3000
*p311|
@nm t="莉瑠" s=rir_0230
「ふふ、そうですね。全然説得力ないです」[np]
@chr st02abb03
*p312|
莉瑠は照れたように微笑むと、何度も頷いた。[r]
先程よりも晴れやかな顔をしているようにも見える。[np]
*p313|
笑った顔は……素直に可愛いかった。[np]
*p314|
@nm t="千尋"
「そ、それじゃ俺はこれで……。[r]
着替えを取りに来ただけなんで」[np]
@hide
@eff_all_delete
@bg storage=bg_08c
@show
*p315|
気恥ずかしくなって、莉瑠から顔を背ける。[np]
*p316|
そそくさと鞄から着替えを取り出すと、[r]
すぐに部屋から出て行こうとした。[np]
@chr_walk way=l st02abb08
*p317|
@nm t="莉瑠" s=rir_0231
「あ……！　待って下さい……！」[np]
@chr st02abb09
*p318|
@nm t="千尋"
「な、なんだ？」[np]
@chr st02abb08
@dchr st02abb12 delay=1000
@dchr st02abb08 delay=1800
@dchr st02abb13 delay=3500
*p319|
@nm t="莉瑠" s=rir_0232
「聖良には、えと。黙ってて下さいね……？[r]
私がエッチな漫画描きたがってること、とか……」[np]
*p320|
@nm t="千尋"
「ああ……わかった、黙っておく」[np]
@chr st02bbb14
@dchr st02bbb13 delay=1500
*p321|
@nm t="莉瑠" s=rir_0233
「それと、あと……」[np]
*p322|
すると莉瑠はモジモジとしながら[r]
視線を泳がし、最後に俺を見上げて――[np]
@chr st02bbb08
@dchr st02bbb14 delay=1600
*p323|
@nm t="莉瑠" s=rir_0234
「サ……サイン下さい」[np]
@chr st02bbb11
@dchr st02bbb13 delay=2400
*p324|
@nm t="莉瑠" s=rir_0235
「実は会った時からずっと、お、お願いしたくて……」[np]
*p325|
俺の顔を見ずに色紙を差し出してくる莉瑠。[np]
*p326|
なんだか、莉瑠の素を見た感じだ。[r]
照れた姿が、なんとも愛らしく見えてしまった。[np]
*p327|
@nm t="千尋"
「その……不格好なサインでも良ければ、いくらでも」[np]
*p327a|
デビューしてから、こっそりサインの練習してて良かったぁ……。[np]
@chr st02bbb15
@dchr st02abb17 delay=600
@dchr st02abb04 delay=5600
*p328|
@nm t="莉瑠" s=rir_0236
「～～っっ。で、でしたらリルルの、[r]
チャーミングスタイルのリルルのエッチな絵付きで……！[r]
あのリルルが私、一番好きで……！」[np]
@chr st02abb02
@dchr st02abb17 delay=2300
*p329|
@nm t="莉瑠" s=rir_0237
「こんな漫画が書けるなら、その……。[r]
昼間と違ってイラストくらい書けます、よね……？」[np]
@chr st02bbb01
*p330|
@nm t="千尋"
「……ああ、大丈夫」[np]
*p331|
すぐさま頷いて応える。[np]
*p332|
聖良と莉瑠……２人のおかげで、また描けたんだ。[r]
まだまだ下書きのようなラフなものではあるけど。[np]
*p332a|
それに、せっかく俺なんかのサインが「欲しい」と言ってくれたんだ。[r]
その言葉に応えなきゃ、漫画家なんて、名乗れないよな。[np]
@chr st02bbb15
*p333|
@nm t="莉瑠" s=rir_0238
「わぁ……」[np]
*p334|
俺が色紙にリルルを描いていくのを、[r]
莉瑠が目を輝かせて見つめている。[np]
@chr st02bbb01
*p335|
その嬉しそうな顔をチラっと見るだけで、[r]
コス姿を見せてもらった時と同じくらい元気をもらえた気がした。[np]
*p336|
@nm t="千尋"
「……よし、っと。これでいいかな？」[np]
@chr st02abb04
@dchr st02abb02 delay=1500
@dchr st02abb17 delay=3300
*p337|
@nm t="莉瑠" s=rir_0239
「は、はい、ありがとうございます……！[r]
家宝にしますっ……！」[np]
@chr st02abb03
*p338|
@nm t="千尋"
「そ、それは流石にオーバーすぎる……」[np]
*p339|
@nm t="千尋"
「じゃあ、俺は風呂に行くから、これで」[np]
*p340|
苦笑いしつつ、俺は今度こそ部屋から出て行く。[np]
*p341|
しかし――[np]
@chr st02bbb10
@dchr st02bbb11 delay=1700
*p342|
@nm t="莉瑠" s=rir_0240
「あっ……！　ま、待って下さい。もう一つだけ……！」[np]
*p343|
@nm t="千尋"
「……もう一つ？」[np]
*p344|
首を傾げつつも再度振り返る。[np]
*p345|
すると莉瑠は恐る恐ると言った様子でこう尋ねてきて――[np]
@chr st02bbb13
@dchr st02bbb14 delay=2400
*p346|
@nm t="莉瑠" s=rir_0241
「聖良とエッチなロールプレイ、するつもりなんですか？」[np]
*p347|
@nm t="千尋"
「ぶっ……！？　せ、聖良から聞いた……？」[np]
@chr st02bbb10
@dchr st02bbb09 delay=1200
@dchr st02bbb13 delay=3800
*p348|
@nm t="莉瑠" s=rir_0242
「違いますよ……！　タブレットに描いてあった[r]
漫画の内容が、そう思わせるものでしたから……！」[np]
*p349|
そういえば、漫画にコスプレロールプレイを[r]
臭わせる内容をつい描いてしまった覚えが……！[np]
@chr st02abb12
@dchr st02abb13 delay=1900
*p350|
@nm t="莉瑠" s=rir_0243
「というかその反応……。[r]
やっぱりするつもりなんですね……？」[np]
*p351|
@nm t="千尋"
「いや、その、落ち着いて欲しい。これには深い事情が――」[np]
*p352|
と、慌てて弁解しようとした時だった。[np]
@chr st02abb18
@dchr st02abb15 delay=1900
*p353|
@nm t="莉瑠" s=rir_0244
「わ、私も――しましょうか？」[np]
*p354|
@nm t="千尋"
「え……？」[np]
@chr st02abb14
@dchr st02bbb09 delay=800
@dchr st02bbb08 delay=5000
*p355|
@nm t="莉瑠" s=rir_0245
「～～っっ。だ、だから私もしてあげましょうかって[r]
言ったんです……！　リルルコスして、エッチなロールプレイ」[np]
@chr st02bbb07
*p356|
@nm t="千尋"
「ど、どうしてそんな話にっ！？」[np]
@chr st02bbb10
@dchr st02bbb13 delay=2500
*p357|
@nm t="莉瑠" s=rir_0246
「べ、別に私はしなくてもいいんです。[r]
だけど、不調を直すためには最適みたいですし」[np]
@chr st02abb11
@dchr st02abb15 delay=5100
*p358|
@nm t="莉瑠" s=rir_0247
「一ファンとしては、ティンポジウム先生の[r]
エロい漫画をこれからも読みたいですし。[r]
そのお手伝いをしてあげようってだけの話です」[np]
@chr st02abb08
@dchr st02abb13 delay=3800
*p359|
@nm t="莉瑠" s=rir_0248
「私としてもエッチな漫画を描く時の参考になるでしょうし。[r]
お互いに悪い話ではないと思います」[np]
@chr st02bbb10
@dchr st02bbb07 delay=3900
@dchr st02bbb13 delay=5200
*p360|
@nm t="莉瑠" s=rir_0249
「言っておきますけど、あなただから提案してるんですよ？[r]
わ、私、誰彼構わずこんなこと言いませんから」[np]
*p361|
どこまでも素直じゃない、天邪鬼な莉瑠。[np]
*p362|
素直に言えない気持ちはわからなくもない。[np]
*p363|
けれど、そんなところもきっと、彼女らしさなんだろう。[np]
@chr st02abb15
@dchr st02abb13 delay=2900
@dchr st02abb15 delay=4500
*p364|
@nm t="莉瑠" s=rir_0250
「で。ど、どうですか。して欲しいですか？[r]
私にリルルコスしてエッチなロールプレイ」[np]
@chr st02abb07
@dchr st02abb15 delay=3100
*p365|
@nm t="莉瑠" s=rir_0251
「あなたがどーしてもと泣いてお願いするのなら、[r]
やってあげないこともありませんが」[np]
*p366|
既に聖良にもＯＫを出してしまった身だ。[r]
莉瑠がこう言ってくれるのなら――[np]
*p367|
@nm t="千尋"
「びっくりするほどエロい目で見ても、文句言わない？」[np]
@chr st02abb14
@dchr st02bbb14 delay=800
*p368|
@nm t="莉瑠" s=rir_0252
「っっ。い、言いませんよ」[np]
*p369|
@nm t="千尋"
「ロールプレイの内容をまた漫画にしちゃうかも？」[np]
@chr st02bbb13
@dchr st02bbb08 delay=800
*p370|
@nm t="莉瑠" s=rir_0253
「っっ。い、いいですよ。読んでる人にはわかりませんし」[np]
@chr st02bbb07
*p371|
@nm t="千尋"
「ロールプレイ中、か、かか、[r]
身体を触ってしまう、なんてこともあるかも……！」[np]
@chr st02bbb13
@dchr st02bbb09 delay=800
*p372|
@nm t="莉瑠" s=rir_0254
「～～っっ！　あなたの方がビビってるじゃないですか……！」[np]
@chr st02bbb07
*p373|
@nm t="千尋"
「ビ、ビビってないし、余裕だし……！！」[np]
*p374|
素直じゃない莉瑠を弄るつもりが、話している間に[r]
俺の方が緊張してきてしまった。[np]
@chr st02abb14
@dchr st02abb11 delay=1100
@dchr st02abb15 delay=3000
*p375|
@nm t="莉瑠" s=rir_0255
「と、とにかくあなたがそこまで言うなら、[r]
私もエッチなロールプレイをしてあげます」[np]
@chr st02abb12
@dchr st02abb13 delay=800
*p376|
@nm t="莉瑠" s=rir_0256
「だから私の分のコス衣装も作っておいて下さいね……！」[np]
@chr st02bbb09
*p377|
@nm t="莉瑠" s=rir_0257
「ぜ、絶対ですよ……！」[np]
@chr st02bbb13
@wt
@chr_del_walk way=r name=莉瑠
[wait time=150]
[se storage="扉_開き戸_木_010_閉じ_強" buf=0 delay=0]
*p378|
羞恥心が限界に達したのか、[r]
莉瑠が顔を真っ赤にして部屋から出て行く。[np]
*p379|
@nm t="千尋"
「エッチなロールプレイ、か……」[np]
*p380|
改めて、とんでもない約束をしてしまった。[np]
*p381|
コスプレ衣装を作り上げたら、俺は聖良や莉瑠と――[np]
*p382|
@nm t="千尋"
「っ……」[np]
*p383|
俺は明日から彼女たちと[r]
どんな顔をして話せばいいんだろうか。[np]
@fobgm time=3000
@hide
@black time=2000
@wbgm
@wait time=1000
@jump storage="000_共通_05.ks"

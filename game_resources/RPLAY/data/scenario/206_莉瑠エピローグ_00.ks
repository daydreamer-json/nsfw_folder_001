; 
; 
*p0|
@bg storage=bg_01a
@bgm storage=bgm_09
@show
[dse storage="カメラシャッター単音" buf=0 delay=2000]
*p1|
@nm t="莉瑠" s=rir_12301
「はい、チーズっ」[np]
@hide
@bg storage=bg_02a st02abb01
@show
@chr st02abb04
@dchr st02bbb04 delay=2900
*p2|
@nm t="莉瑠" s=rir_12302
「あはは。なんですか、この顔。[r]
めちゃくちゃ半目になってるじゃないですか」[np]
@chr st02bbb03
*p3|
@nm t="千尋"
「ぐっ……合図のタイミングが唐突なんだよ。[r]
３、２、１で合図してくれ。取り直しを要求する」[np]
@chr st02bbb15
@dchr st02bbb02 delay=2900
@dchr st02bbb04 delay=4500
*p4|
@nm t="莉瑠" s=rir_12303
「えー。コスプレ撮影じゃあるまいし、[r]
これでいいじゃないですか。面白写真として優秀ですし♪」[np]
@chr st02abb02
@dchr st02abb04 delay=2600
@dchr st02aab04 delay=4100
*p5|
@nm t="莉瑠" s=rir_12304
「それより時間が勿体ないです。[r]
次の場所に行きましょう。ほら早く早く」[np]
@hide
@bg storage=bg_01a_l left=-640 top=-720
@show
*p6|
弾けるような笑顔で笑いかけてきながら、[r]
莉瑠が俺の腕を引っ張って歩き出していく。[np]
*p7|
――この日、俺は莉瑠に誘われて、[r]
一緒に島中を巡っていた。[np]
*p8|
行く先々で良いロケーションを見つけては、[r]
何枚も何枚も写真を撮っていく。[np]
@fobgm time=2000
@hide
@black rule=rule_spiral01
@wait time=1000
@bg storage=bg_12a_l left=-1280 top=-360 rule=rule_spiral01
@show
[se storage="動作_突き飛ばす_人_00"]
@q_small
*p9|
@nm t="莉瑠" s=rir_12305
「ドーンっ！」[np]
@shide
@bgm storage=bgm_07
@black rule=rule_spiral51_i_o time=200
@eff obj=1 page=back show=true storage=bg_12a_l path=(-1920,-372,255) size=(2.5,2.5) time=1 absolute=(1500)
[se storage="動_水_倒"]
@q_normal
@bg storage=bg_12a rule=rule_spiral51_i_o time=200
[wse buf=0]
@eff_all_delete
@eff obj=0 page=back show=true storage=bg_12a_l path=(-1280,150,255) size=(2,2) time=1 absolute=(1500) correct=false
[se storage="動_水から顔を出す"]
@q_normal
@bg storage=bg_12a rule=rule_04_lt_rb time=200
@show
*p10|
@nm t="千尋"
「ぶはっ！？　何するんだ……！[r]
ズブ濡れになっちゃったじゃないか……！」[np]
@eff_all_delete
@bg storage=bg_12a_l left=-1280 top=-360 st02abb04
@dchr st02abb06 delay=1200
*p11|
@nm t="莉瑠" s=rir_12306
「あはは、濡れ鼠みたいで可愛いですよ？」[np]
@chr st02abb03
*p12|
@nm t="千尋"
「……ここは水も滴る良い男とか言うところでは？」[np]
@chr st02abb14
@dchr st02abb08 delay=900
*p13|
@nm t="莉瑠" s=rir_12307
「……え？　鏡見たことありますか？」[np]
@chr st02abb09
*p14|
@nm t="千尋"
「ひどいぞっ！！」[np]
@chr st02abb04
@dchr st02bbb05 delay=3300
@dchr st02bbb02 delay=5900
*p15|
@nm t="莉瑠" s=rir_12308
「あはは、冗談ですってば。[r]
そこそこ良い男なんじゃないですか？[r]
ガチャで言えばレア度１くらいの男前ですよ」[np]
@chr st02bbb03
*p16|
@nm t="千尋"
「辛辣すぎないかっ！？」[np]
[se storage="カメラシャッター単音" buf=0 delay=0]
@wait time=300
@chr st02bbb02
@dchr st02bbb04 delay=3000
*p17|
@nm t="莉瑠" s=rir_12309
「ふふ、怒った顔も面白いです。[r]
ほらほら、もっと顔こっち向けて下さい」[np]
@chr st02bbb03
*p18|
子供のようにはしゃぎながら、[r]
莉瑠が何度もシャッターを切ってくる。[np]
@chr st02bbb02
@dchr st02bbb04 delay=2500
*p19|
@nm t="莉瑠" s=rir_12310
「私の写真も撮って下さいね？[r]
後でツーショットも撮りましょう」[np]
@fobgm time=3000
@chr st02bbb01
*p20|
@nm t="千尋"
「そりゃ、もちろんいいけど……。[r]
今日はやたらとテンション高いな」[np]
@chr st02abb12
@dchr st02abb17 delay=4100
*p21|
@nm t="莉瑠" s=rir_12311
「ま、もうすぐ夏休みが終わっちゃいますしね。[r]
今のうちにはしゃげるだけはしゃいでおかないと、ですよ」[np]
@chr st02abb12
*p22|
@nm t="莉瑠" s=rir_12312
「それに……」[np]
*p23|
ふと一瞬だけ莉瑠が寂しげな顔を見せる。[np]
*p24|
@nm t="千尋"
「莉瑠？」[np]
@bgm storage=bgm_02
@chr st02abb08
@dchr st02abb02 delay=600
@dchr st02abb04 delay=1900
@dchr st02bbb04 delay=4400
*p25|
@nm t="莉瑠" s=rir_12313
「っっ。なんでもありません。[r]
あ、ワカメありましたよ、ワカメ！[r]
これ頭に乗せた姿、撮らさせて下さいよ！」[np]
@chr st02bbb03
*p26|
声をかけると莉瑠はわざとらしいほどに明るく振る舞い、[r]
俺に笑顔を向けてきた。[np]
*p27|
どうしたんだろう？　とは思わなかった。[r]
まあ、さすがにそこまで俺も鈍感じゃない。[np]
*p28|
テンションが高いなと尋ねた時点で鈍いんだけど、[r]
一瞬見せた寂しげな顔で、流石に莉瑠の気持ちにも気づく。[np]
@eff obj=0 page=back show=true storage=bg_12a_l path=(0,360,255) size=(1.5,1.5) time=1000 absolute=(1500)
@bg storage=bg_12a st02bab10 rule=rule_71_i_o time=200
[se storage="動作_突き飛ばす_人_00"]
*p29|
@nm t="千尋"
「ドーンっ！」[np]
@chr_del_walk way=r name=莉瑠 time=200
[se storage="動_水_じゃぼん"]
[wse buf=0]
[se storage="動_水から顔を出す"]
@chr_standup st02bbb16=7
@dchr st02bbb09 delay=1100
@dchr st02bbb11 delay=4200
*p30|
@nm t="莉瑠" s=rir_12314
「ぶはっ！！？　――ちょっと、何してくれてるんですか！？[r]
ズブ濡れになっちゃったじゃないですか……！」[np]
*p31|
@nm t="千尋"
「お返し、お返し。濡れ鼠みたいで可愛いぞ」[np]
@chr st02bbb07
@dchr st02bbb08 delay=1100
@dchr st02abb15 delay=4200
*p32|
@nm t="莉瑠" s=rir_12315
「むっ……！　水も滴る良い女と言って下さい……！[r]
自分で言っちゃなんですがレア度５の女ですよ……！」[np]
*p33|
@nm t="千尋"
「そうだな、莉瑠は美少女だもんな」[np]
@chr st02abb14
@dchr st02abb13 delay=1200
@dchr_quake name="莉瑠" sx=3 xcnt=5 sy=2 ycnt=3 time=200 loop=false fade=false delay=1200
@dchr st02abb08 delay=2300
@dchr st02abb13 delay=4500
*p34|
@nm t="莉瑠" s=rir_12316
「美少――～～っっ！　そこはボケて下さいよ……！[r]
いきなり褒められてもむず痒いですってば……！」[np]
*p35|
@nm t="千尋"
「ははは、そうやって褒められて照れる姿が[r]
また一段と可愛いな」[np]
@chr st02abb16
@dchr st02bbb12 delay=2400
@dchr st02bbb06 delay=4400
*p36|
@nm t="莉瑠" s=rir_12317
「ひ、人をバカにしてぇ……！！[r]
そこ動かないで下さいっ！　海に沈めてやりますっ！」[np]
@hide
@eff_all_delete
@bg storage=bg_01a
@show
*p37|
――そんな風に莉瑠とひたすら馬鹿騒ぎをしながら、[r]
二人の時間をゆったりと過ごしていく。[np]
*p38|
カメラで撮った写真だけじゃなく、[r]
いつまでも心に残るような時間を。[np]
@fobgm time=2000
@hide
@black
@wbgm
@show
*p39|
………………[np]
*p40|
…………[np]
*p41|
……[np]
@hide
@bg storage=bg_14a_l left=-1080 top=-360 st02bdb02
@bgm storage=bgm_04
@show
@dchr st02bdb15 delay=2900
*p42|
@nm t="莉瑠" s=rir_12318
「ほら、もっとくっついて下さいって。[r]
じゃないとおさまりませんってば」[np]
@chr st02bdb01
*p43|
@nm t="千尋"
「莉瑠がちっちゃいせいだろ。[r]
腰を屈めるの、中々しんどいんだぞ」[np]
@chr st02bdb11
@dchr st02bdb09 delay=1000
@dchr st02bdb14 delay=3800
*p44|
@nm t="莉瑠" s=rir_12319
「む。私だって背伸びするの辛いですもん。[r]
今日一日で足に筋肉ついちゃいそうです」[np]
*p45|
@nm t="千尋"
「……なら、こういうのはどうだ？」[np]
@chr st02bdb11
[dse storage="衣擦れ_抱きしめる2_volup" buf=0 delay=800]
@dchr st02bdb10 delay=800
@dchr_del_down name=莉瑠 delay=1200
*p46|
@nm t="莉瑠" s=rir_12320
「えっ？　――ひぃあっ！？」[np]
*p47|
木陰に座り込んで、そのまま莉瑠を抱き寄せる。[np]
@eff obj=0 page=back show=true storage=bg_14a_l path=(-1100,-145,255) size=(2,2) time=1 bbx=(2) bby=(2) bbt=true bbs=true absolute=(1500)
@q_small
@bg storage=bg_14a time=200
@chr_drop st02bdb10 time=200
[se storage="カメラシャッター単音" buf=0 delay=0]
*p48|
そうして莉瑠が俺の膝の上に座り込んだところで、[r]
セルフタイマーを仕掛けておいたカメラが煌めいた。[np]
@chr st02bdb13
@dchr st02bdb14 delay=1200
@dchr st02bdb09 delay=4200
*p49|
@nm t="莉瑠" s=rir_12321
「～～っっ。恥ずかしい写真、撮らせないで下さい。[r]
膝の上に乗るなんて子供っぽいじゃないですか」[np]
@chr st02bdb13
*p50|
@nm t="千尋"
「チャーミングスタイルのリルルコスした時は[r]
ノリノリで乗ってくれてたじゃないか……」[np]
@chr st02bdb12
*p51|
@nm t="莉瑠" s=rir_12322
「あれはあくまでロールプレイですってば……！」[np]
@chr st02bdb07
*p52|
莉瑠が照れたように頬を赤らめながらガミガミ言ってくる。[r]
しかし、俺の膝から立ち上がろうとはしなかった。[np]
*p53|
差し込んでくる太陽が眩しい。[np]
*p54|
島に来た時よりも少し涼しくなった風を感じると、[r]
ここで過ごした時間の長さを考えてしまう。[np]
@chr st02adb11
*p55|
そんな中、俺の身体に背中を預けながら、[r]
ぽつりぽつりと莉瑠が話し始める。[np]
@chr st02adb01
@dchr st02adb02 delay=1600
@dchr st02adb07 delay=5700
*p56|
@nm t="莉瑠" s=rir_12323
「思えば色々なことがありましたね……。[r]
あなたと出会ってから酷い目に遭ってばかりでした」[np]
@chr st02adb03
*p57|
@nm t="千尋"
「酷い目ってことはないんじゃない？」[np]
@chr st02adb17
@dchr st02adb15 delay=2200
@dchr st02adb06 delay=4700
*p58|
@nm t="莉瑠" s=rir_12324
「だって、そうじゃないですか。出会いとか最悪でしたし。[r]
舐めるような目で人の裸を見てきて」[np]
@chr st02adb05
*p59|
@nm t="千尋"
「舐めるようには見てないって！[r]
そもそも、あれは事故だっただろう！！」[np]
@chr st02adb07
@dchr st02adb17 delay=2400
@dchr st02adb04 delay=4300
*p60|
@nm t="莉瑠" s=rir_12325
「それだけじゃないですよ。[r]
あなたのインポ治療のために身体まで張らされて」[np]
@chr st02adb15
@dchr st02adb13 delay=2800
*p61|
@nm t="莉瑠" s=rir_12326
「エッチなロールプレイだとか言って、[r]
私の身体も心もめちゃくちゃに弄んできて……」[np]
*p62|
@nm t="千尋"
「……酷い言われようだ」[np]
@chr st02adb03
*p63|
@nm t="莉瑠" s=rir_12327
「ふふ」[np]
*p64|
色々とツッコミたいところがあるのに、[r]
莉瑠の笑顔を見るとその気持ちが吹き飛んでしまう。[np]
@chr st02bdb02
@dchr st02bdb04 delay=4600
*p65|
@nm t="莉瑠" s=rir_12328
「でも決して悪いことばかりじゃありませんでしたよ？[r]
……良いこともたくさんありました」[np]
@chr st02bdb15
@dchr st02bdb14 delay=3900
*p66|
@nm t="莉瑠" s=rir_12329
「ずっとしてみたかったリルルコスをできたことはもちろん、[r]
恥ずかしくて描けなかったエッチな漫画にも挑戦できて」[np]
@chr st02bdb17
@dchr st02bdb02 delay=4500
*p67|
@nm t="莉瑠" s=rir_12330
「ロールプレイを通して、色々なエッチができたり、[r]
自分でも知らなかった自分を知ることができたり……」[np]
@chr st02bdb14
@dchr st02bdb03 delay=2200
@dchr st02bdb15 delay=3700
*p68|
@nm t="莉瑠" s=rir_12331
「大好きな人が……えへへ。できたりもしましたし」[np]
@chr st02bdb01
*p69|
@nm t="千尋"
「莉瑠……」[np]
@fobgm time=2000
*p70|
ふっと莉瑠が少しだけ陰のある寂しそうな顔をして見上げてくる。[np]
@chr st02bdb14
*p71|
@nm t="莉瑠" s=rir_12332
「……また会えますよね？」[np]
@chr st02bdb09
@dchr st02adb13 delay=4300
*p72|
@nm t="莉瑠" s=rir_12333
「島から出て、さよならってわけじゃないですよね？[r]
これからもずっと、私の恋人でいてくれますよね……？」[np]
@bgm storage=bgm_06
*p73|
@nm t="千尋"
「ああ、もちろん。[r]
そうだ、俺も一つ渡すものがあってさ……これだ」[np]
[se storage="鍵ちゃら"]
@chr st02adb01
[wse buf=0]
*p74|
@nm t="莉瑠" s=rir_12334
「これは？」[np]
*p75|
@nm t="千尋"
「俺が住んでるアパートの住所と合い鍵だ。[r]
聖良に聞いたけど、俺たち思いの外、家が近いらしいんだ。[r]
……なんなら引っ越してきてくれたっていいぞ」[np]
@chr st02adb09
*p76|
@nm t="莉瑠" s=rir_12335
「うわぁ……」[np]
@mq_small
*p77|
@nm t="千尋"
「えっ！？　なんで引くの！？」[np]
@chr st02adb11
@dchr st02adb12 delay=2100
@dchr st02adb08 delay=4700
@dchr st02adb17 delay=6700
*p78|
@nm t="莉瑠" s=rir_12336
「普通に引くでしょう。いきなり住所と合い鍵渡すとか。[r]
しかも引っ越してこいとか。これだから童貞は……」[np]
@chr st02adb03
*p79|
@nm t="千尋"
「真実、童貞じゃないんだけどな」[np]
*p80|
既に童貞ではない俺に、その煽りはもう意味がない。[np]
@chr st02adb07
*p81|
@nm t="莉瑠" s=rir_12337
「まぁでも……」[np]
@chr st02bdb01
[se storage="物_鍵音01"]
*p82|
チャリっと莉瑠の手の平の中で鍵の音が鳴る。[np]
@chr st02bdb15
@dchr st02bdb03 delay=3800
@dchr st02bdb02 delay=5200
*p83|
@nm t="莉瑠" s=rir_12338
「すごく……嬉しいです。[r]
えへへ、キュンとしちゃいました……」[np]
@chr st02bdb01
*p84|
受け取った住所メモと合い鍵を握り締めながら、[r]
莉瑠が笑顔で見上げてくる。[np]
@chr st02bdb02
@dchr st02bdb04 delay=2300
@dchr st02bdb15 delay=5200
*p86|
@nm t="莉瑠" s=rir_12339
「引っ越していいって言われたら、[r]
私、ホントに引っ越しちゃいますからね？[r]
好きな人とはずっと一緒にいたいですもん」[np]
@chr st02bdb14
*p87|
@nm t="莉瑠" s=rir_12340
「それに……」[np]
*p88|
莉瑠が不意に唇をそっと近づけてくる。[np]
@chr st02bdb17
*p89|
@nm t="莉瑠" s=rir_12341
「ちゅ……んっ」[np]
@chr st02bdb03
@dchr st02bdb15 delay=2000
*p90|
@nm t="莉瑠" s=rir_12342
「えへへ……。一緒に暮らせばいつでもエッチできますしね？」[np]
@chr st02bdb01
*p91|
@nm t="千尋"
「莉瑠……」[np]
@chr st02adb17
@dchr st02adb13 delay=3300
*p92|
@nm t="莉瑠" s=rir_12343
「あなたがこんな私にしたんですよ？[r]
毎日のようにあなたがエッチなコトしてきますから……」[np]
@chr st02adb08
@dchr st02adb17 delay=5400
*p93|
@nm t="莉瑠" s=rir_12344
「私もう、あなたとエッチしない日々を想像できません。[r]
……そのくらい、あなたとイチャイチャするの好きです」[np]
@chr st02adb13
*p94|
まっすぐ気持ちを伝えてくる莉瑠に呼応するように胸が熱くなる。[r]
俺も莉瑠とエッチしない日々なんてもう想像できない。[np]
@chr st02adb08
@dchr st02adb06 delay=1800
@dchr st02adb17 delay=3000
*p95|
@nm t="莉瑠" s=rir_12345
「ふぁ……あっ、はぁん……。[r]
えへへ、気持ちいいです……」[np]
@chr st02adb13
*p96|
背後から抱きしめながら、軽く莉瑠のおっぱいを揉む。[r]
すると莉瑠は嬉しそうに微笑んできてくれた。[np]
@chr st02bdb15
*p97|
@nm t="莉瑠" s=rir_12346
「そういえば大事な写真、取り忘れてました」[np]
@chr st02bdb14
*p98|
@nm t="千尋"
「大事な写真？」[np]
@chr st02bdb02
@dchr st02bdb15 delay=5300
*p99|
@nm t="莉瑠" s=rir_12347
「はい。コスプレしてる時は何枚も撮りましたけど……。[r]
こうしてコスプレしていない時は撮ってませんよね？」[np]
@chr st02bdb14
@dchr st02bdb05 delay=1600
@dchr st02adb17 delay=3600
*p100|
@nm t="莉瑠" s=rir_12348
「二人で、えへへ、エッチしてる時の写真は」[np]
@chr st02adb05
@wt
[se storage="カメラシャッター単音" buf=0 delay=0]
*p101|
パシャっとシャッター音が響く。[r]
三脚に設置されたカメラが煌めいていた。[np]
@chr st02adb07
@dchr st02adb17 delay=2000
*p102|
@nm t="莉瑠" s=rir_12349
「こんなこともあろうかと、[r]
インターバルタイマーを仕掛けておきました」[np]
@chr st02adb12
@dchr st02adb13 delay=2900
*p103|
@nm t="莉瑠" s=rir_12350
「あなたのお部屋に引っ越すにしても、[r]
すぐ引っ越せるわけじゃありませんからね……」[np]
@chr st02adb02
@dchr st02adb07 delay=4200
@dchr st02adb17 delay=6700
*p104|
@nm t="莉瑠" s=rir_12351
「その間、寂しくないように……。[r]
あなたとのエッチを思い出してオナニーできるように……」[np]
@chr st02bdb15
@dchr st02bdb14 delay=3900
*p105|
@nm t="莉瑠" s=rir_12352
「ありのままの私たちのハメ撮り写真……。[r]
大好きな人とエッチしてる写真……」[np]
@chr st02bdb13
@dchr st02bdb15 delay=3400
*p106|
@nm t="莉瑠" s=rir_12353
「この島での最後の思い出として……残しておきたいです」[np]
@chr st02bdb14
*p107|
@nm t="莉瑠" s=rir_12354
「ダメ……ですか？」[np]
*p108|
恥ずかしそうに莉瑠が俺を見つめてくる。[r]
言葉を出すまでもなかった。[np]
@hide
@eff_all_delete
@bg storage=bg_01a
[se storage="動作_肌着_脱衣_02"]
@show
*p109|
@nm t="莉瑠" s=rir_12355
「ひぃあっ。えへへ」[np]
[se storage="動作_ズボン+ベルト_脱衣_00" buf=1]
*p110|
莉瑠の服をはだける。[r]
すると彼女も嬉しそうに俺のズボンを下ろしてきた。[np]
*p111|
@nm t="莉瑠" s=rir_12356
「ホント、私たち……スケベですね？」[np]
*p112|
幸せそうに小首を傾げて尋ねてくる莉瑠に頷き返す。[np]
*p113|
そして、エッチしている姿がしっかりとカメラに写るように[r]
俺は莉瑠を抱え直した。[np]
@fobgm time=3000
@hide
@white time=2000
[sse buf=0]
[sse buf=1]
@wbgm
@wait time=1000
@jump storage="206_莉瑠エピローグ_01_h.ks"

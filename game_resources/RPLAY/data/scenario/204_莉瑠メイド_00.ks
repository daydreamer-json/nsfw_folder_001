; 
; 
*p0|
@bg storage=bg_08a
@bgm storage=bgm_02
@wait time=500
@eff obj=0 page=back show=true storage=bg_08a_l path=(-485,287,255) size=(1.4,1.4) time=1 absolute=(2000) correct=false
@bg storage=bg_08a
[se storage="PCエンター"]
@show
*p1|
@nm t="千尋"
「よし。これで終わりだな」[np]
@chr st02aab04
@dchr st02aab02 delay=1183
*p2|
@nm t="莉瑠" s=rir_11382
「はい。おかげさまで学園祭用の資料はまとまりました」[np]
@chr st02aab03
*p3|
ノートＰＣにデータを保存したところで、[r]
莉瑠が顔を上げて頷いてくる。[np]
*p4|
コツコツと進めていた莉瑠の生徒会の仕事が、[r]
この日ようやく終わりを迎えたのだ。[np]
@chr st02bab02
@dchr st02bab04 delay=1938
*p5|
@nm t="莉瑠" s=rir_11383
「ありがとうございました。[r]
色々と手伝って頂いて」[np]
@chr st02bab01
*p6|
@nm t="千尋"
「なんてことないさ。俺も莉瑠と聖良には[r]
お世話になりっぱなしだからな」[np]
@chr st02aab12
@dchr st02aab07 delay=2374
*p7|
@nm t="莉瑠" s=rir_11384
「……まぁそれもそうですね。[r]
まるで性奴隷のように身体を酷使させられてますし」[np]
@chr st02aab03
*p8|
@nm t="千尋"
「……俺、そこまで酷いことお願いしてた？」[np]
@chr st02aab04
@dchr st02aab02 delay=2789
*p9|
@nm t="莉瑠" s=rir_11385
「軽い冗談じゃないですか。でも、これからどうします？[r]
思っていたより早く終わりましたけど」[np]
@chr st02aab01
*p10|
@nm t="千尋"
「そうだな……」[np]
*p11|
あえて少し考える振りをする。[np]
*p12|
そうすればきっと――[np]
@chr st02bab14
*p13|
@nm t="莉瑠" s=rir_11386
「あ、あの。特にすることがなければ……ですけど」[np]
@chr st02bab13
*p14|
予想通り莉瑠が少し照れた様子で話しかけてくる。[np]
@chr st02bab15
*p15|
@nm t="莉瑠" s=rir_11387
「今日もお散歩……行きませんか？」[np]
@fobgm time=2000
@hide
@eff_all_delete
@black rule=rule_spiral01
@wbgm
@show
*p16|
………………[np]
*p17|
…………[np]
*p18|
……[np]
@hide
@bg storage=bg_12a rule=rule_spiral01
[se storage="が_海波2" buf=9 delay=0]
@wait time=500
@eff obj=0 page=back show=true storage=bg_12a_l path=(2048,-432,255) size=(1.6,1.6) time=1 bbx=(2) bby=(2) bbt=true bbs=true absolute=(2000) correct=false
@bg storage=bg_12a st02bde17
@bgm storage=bgm_10
@show
*p19|
@nm t="莉瑠" s=rir_11388
「ん……ちゅっ……ちゅぁ、んちゅ……」[np]
@dchr st02bde15 delay=910
@dchr st02bde17 delay=3842
@dchr st02bde15 delay=6503
*p20|
@nm t="莉瑠" s=rir_11389
「えへへ、お兄ちゃん……。[r]
もっと、んちゅ……キスぅ、キスしよ……？」[np]
@chr st02bde05
*p21|
@nm t="千尋"
「…………」[np]
@chr st02bde14
*p22|
@nm t="莉瑠" s=rir_11390
「……どうしたの、お兄ちゃん？[r]
莉瑠とキスするの、はぁはぁ、イヤ……？」[np]
*p23|
@nm t="千尋"
「いや……物凄い変わりようだとふと思ってしまって……」[np]
@chr st02bde07
*p24|
@nm t="莉瑠" s=rir_11391
「～～っっ！！」[np]
@shide
[fose buf=9]
@ceff_stock obj=0 storage=bg_12a_l path=(1792,-288,255) size=(1.4,1.4) time=1 bbx=(0) bby=(0) bbt=false bbs=false absolute=(2000)
[se storage="動作_突き飛ばす_人_00"]
@sbgm
@q_small
@bg storage=bg_12a st02bae07 time=200
@sshow
*p25|
@nm t="千尋"
「うわっ！？」[np]
@bgm storage=bgm_08
*p26|
@nm t="千尋"
「いてて……突き飛ばすことないだろ……」[np]
@chr st02bae06
@dchr st02bae12 delay=2185
*p27|
@nm t="莉瑠" s=rir_11392
「う、うるさいですねっ！　あなたが正気に[r]
戻るようなこと言うからじゃないですかっ……！」[np]
@chr st02bae07
[sse buf=9]
*p28|
莉瑠が顔を真っ赤にしてキレてくる。[np]
*p29|
聖良が買い出しで島を出たあの夜から、[r]
莉瑠は時たま俺を散歩に誘っては、[r]
人気のない場所で甘えてきていた。[np]
*p30|
外に出てくるのは聖良に甘えているところを[r]
見せたくないからだろう。[np]
*p31|
俺としては、なんだか可愛い莉瑠も見れるし、[r]
リルルコスでのロールプレイエッチも満喫出来て両得である。[np]
*p32|
@nm t="千尋"
「悪かった。まぁそう怒らないでくれ」[np]
@chr st02aae14
@dchr st02aae15 delay=2779
*p33|
@nm t="莉瑠" s=rir_11393
「あ、頭撫でないで下さい。そんなことで、[r]
ほだされる私ではありませんからね……！」[np]
@chr st02aae09
*p34|
@nm t="千尋"
「そうか……。なら、やめておくか」[np]
@chr st02aae08
@dchr st02aae14 delay=3387
@dchr st02aae15 delay=6259
*p35|
@nm t="莉瑠" s=rir_11394
「ちょ、ちょっと……！　簡単に諦めないで下さい……！[r]
もしもがあるかもしれないじゃないですか……！[r]
リルルが不機嫌になってもすぐ諦めるんですかっ？」[np]
@chr st02aae09
*p36|
やはり本当は甘えたいのか、[r]
撫でるのをやめた俺に莉瑠が食いかかってくる。[np]
*p37|
@nm t="千尋"
「冗談だ。よしよし。可愛いなぁ、莉瑠は」[np]
@chr st02aae15
@dchr st02aae13 delay=5413
*p38|
@nm t="莉瑠" s=rir_11395
「それはそれで、んんっ、撫ですぎですよ。[r]
子供扱いしないで下さいってばぁ……」[np]
*p39|
@nm t="千尋"
「お兄ちゃんロールプレイをしているだけだって。[r]
だから莉瑠も妹リルルっぽく甘えてきてくれ」[np]
*p40|
@nm t="千尋"
「今度こそ照れて水を差したりしないからさ。[r]
甘えんぼリルルに甘えられる俺の夢をまた叶えて欲しい」[np]
@chr st02aae17
*p41|
@nm t="莉瑠" s=rir_11396
「なんですかもう……。また照れちゃってたんですか？[r]
ふふ、仕方ない人ですね？」[np]
@chr st02aae07
@dchr st02aae06 delay=4377
@dchr st02aae17 delay=8715
*p42|
@nm t="莉瑠" s=rir_11397
「まぁそこまでおねだりされては仕方ありません。[r]
別に私は甘えたくなんて一ミリもありませんが、[r]
あくまでロールプレイとして甘えてあげます」[np]
@chr st02aae05
*p43|
不本意だと言いながら上機嫌に頷く莉瑠。[r]
この天邪鬼っぷりが癖になりそうだ。[np]
*p44|
まあ、俺が照れていたのも事実ではある。[r]
結局のところ二人とも恥ずかしがってはいるんだろう。[np]
*p45|
だからこそ俺たちはロールプレイという大義名分を使って、[r]
普段の自分じゃ見せられない本音を曝け出すんだ。[np]
*p46|
いつも以上に素直になるために。[r]
違う自分に[変身'コスプレ]して。[np]
@chr st02bae15
@dchr st02bae03 delay=1938
*p47|
@nm t="莉瑠" s=rir_11398
「ふぁ……えへへ」[np]
*p48|
莉瑠の身体をぎゅっと抱き寄せて頭を撫でる。[np]
*p49|
きっとこれも常の俺にはできっこない。[r]
莉瑠だって素直に撫でられたりはしないはずだ。[np]
@chr st02bae14
*p50|
@nm t="莉瑠" s=rir_11399
「ね、キスしてもいい……？　してる途中だったから……」[np]
*p51|
莉瑠が上目遣いに見つめてくる。[r]
こんな風に莉瑠がねだってくるのも普通はあり得ない。[np]
*p52|
俺たちは本当に照れ屋で不器用で、[r]
でも、お互いのことが大好きだった。[np]
@hide
@ceff_stock obj=0 storage=bg_12a_l path=(2048,-432,255) size=(1.6,1.6) time=250 bbx=(2) bby=(2) bbt=true bbs=true absolute=(2000) correct=false
@bg storage=bg_12a st02bde17
@show
@dchr st02bde05 delay=4197
*p53|
@nm t="莉瑠" s=rir_11400
「ちゅっ……んっ、んちゅ……えへへ」[np]
*p54|
返事代わりに唇を重ねると、[r]
莉瑠が幸せそうに破顔する。[np]
*p55|
そして、莉瑠の方からもキスの雨を降らせてくる。[np]
@chr st02bde17
@dchr st02bde18 delay=2476
*p56|
@nm t="莉瑠" s=rir_11401
「ん……好き、ちゅっ、ちゅちゅ……。[r]
お兄ちゃんのこと、はぁはぁ、大好きだよ……？」[np]
@chr st02bde17
*p57|
@nm t="莉瑠" s=rir_11402
「んはぁむっ……んちゅっ、れろっ、れろろぉ……！」[np]
*p58|
俺をぎゅっと抱きしめながら、そのたわわな爆乳を[r]
恥ずかしげもなく俺の身体に押し付けてくる。[np]
*p59|
リルルもビックリのデレデレっぷりだ。[np]
*p60|
こうしてリルルに甘えられる妄想を[r]
今までどれだけしてきたか……。[np]
@chr st02bde14
@dchr st02bde17 delay=1644
@dchr st02bde15 delay=2956
@dchr st02bde18 delay=5293
*p62|
@nm t="莉瑠" s=rir_11403
「お兄ちゃんも、ん、ちゅっ……ぎゅっと抱きしめて？[r]
お兄ちゃんにぎゅうぎゅうされたいな……」[np]
@chr st02bde05
*p63|
@nm t="千尋"
「ああ、ぎゅうぎゅうしてやるな」[np]
[se storage="衣擦れ(100)" buf=0 delay=0]
@chr st02bde17
@dchr st02bde15 delay=1312
*p64|
@nm t="莉瑠" s=rir_11404
「んんっ……！　お兄、ちゃん……！　えへへ……」[np]
@chr st02bde03
*p65|
リルルに甘えられる妄想以上に[r]
莉瑠に甘えられてドキドキしている自分がいる。[np]
*p66|
人には見せない秘密を無防備に見せてくれているようで。[r]
莉瑠の純粋で無邪気な気持ちが伝わってくるようで。[np]
*p67|
その相手に俺を選んでくれていることが何よりも嬉しい。[r]
愛しくてたまらなくなってしまう。[np]
@chr st02bde14
@dchr st02bde15 delay=3996
*p68|
@nm t="莉瑠" s=rir_11405
「今日も、はぁはぁ……。[r]
日が沈むまでイチャイチャしたいな……」[np]
@chr st02bde18
*p69|
@nm t="莉瑠" s=rir_11406
「お兄ちゃんと、ん……ちゅっ」[np]
@chr st02bde14
*p70|
@nm t="莉瑠" s=rir_11407
「ここなら聖良も来ないから……。[r]
甘えんぼな自分、お兄ちゃんにしかバレないから……」[np]
@chr st02bde15
*p71|
@nm t="莉瑠" s=rir_11408
「たくさんたくさん……イチャイチャしよ？」[np]
@chr st02bde05
*p72|
好意全開で俺を求めてくれる莉瑠に[r]
俺もほとばしる情欲を抑えられない。[np]
*p73|
照りつける日差し以上に身体が熱を帯びていく。[np]
@chr st02ade17
@dchr st02ade04 delay=1896
*p74|
@nm t="莉瑠" s=rir_11409
「えへへ……。こっち来て、お兄ちゃん？」[np]
@chr st02ade03
*p75|
@nm t="千尋"
「わっ……！　な、なんだっ？」[np]
@chr_del_jump name=莉瑠
*p76|
不意に莉瑠がビーチチェアの方へ俺を引っ張っていく。[np]
@hide
@eff_all_delete
@bg storage=bg_12a st02bce01=4.00
@show
@chr st02bce04
*p77|
@nm t="莉瑠" s=rir_11410
「座って？」[np]
@chr st02bce03
*p78|
@nm t="千尋"
「あ、ああ」[np]
@hide
@bg storage=bg_01a
@show
*p79|
言われるがまま座りこむと、そこに――[np]
@chr_drop st02bde02
[se storage="衣擦れ(32)" buf=0 delay=0]
*p80|
@nm t="莉瑠" s=rir_11411
「よい、しょ」[np]
@chr st02bde03
*p81|
すっぽりと収まるように、[r]
莉瑠が俺の膝の上に座ってくれる。[np]
*p82|
これは……。[np]
@chr st02bde15
*p83|
@nm t="莉瑠" s=rir_11412
「前に言ってたよね？[r]
膝の上に乗せたリルルとイチャイチャするのが夢だって」[np]
@chr st02bde14
@dchr st02bde13 delay=3916
@dchr st02bde15 delay=6030
*p84|
@nm t="莉瑠" s=rir_11413
「あの時は恥ずかしくてできなかったけど……。[r]
今なら……その。してもいいかなって……」[np]
@chr st02bde14
@dchr st02bde10 delay=1390
@dchr st02bde15 delay=2660
*p85|
@nm t="莉瑠" s=rir_11414
「私も……あっ。り、莉瑠も、そんな気分だったし……」[np]
@chr st02bde05
*p86|
思わず素が出てしまいながらも、[r]
莉瑠が照れながら俺に背中を預けてくる。[np]
*p87|
ヤバい、可愛い……！　膝の上に感じるぬくもりと[r]
お尻の柔らかさにドキドキする……！[np]
@hide
@eff obj=0 page=back show=true storage=bg_12a_l path=(0,349,255) size=(1.5,1.5) time=1 bbx=(10) bby=(10) bbt=true bbs=true
@eff obj=1 page=back show=true storage=st02bde05 path=(658,-311,255) size=(1.3,1.3) time=1 absolute=(15001)
@bg storage=bg_12a rule=rule_00_t_b time=300
@show
*p88|
布地の少なさと莉瑠の身長の低さもあって[r]
ここから見る胸の谷間はまさしく絶景だ。[np]
*p89|
手でぐわしと掴み、堪能したくなってくる。[np]
@hide
@eff_all_delete
@bg storage=bg_01a st02ade05
@show
@chr st02ade13
@dchr st02ade17 delay=4247
*p90|
@nm t="莉瑠" s=rir_11415
「いいよ……？　はぁはぁ、好きに揉んで……？[r]
ううん。揉んで欲しい……」[np]
@chr st02ade05
@dchr st02bde15 delay=3770
*p91|
@nm t="莉瑠" s=rir_11416
「リルルとイチャイチャエッチする時みたいに……。[r]
莉瑠ともイチャイチャエッチ……して欲しいな？」[np]
@fobgm time=3000
@hide
@eff_all_delete
@white time=2000
@wbgm
@wait time=1000
@jump storage="204_莉瑠メイド_01_h.ks"

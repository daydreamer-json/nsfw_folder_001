; 
; 
*p0|
@eff obj=0 page=back show=true storage=sp_bg_08d path=(640,360,255) time=1
@bg storage=bg_08d_l left=-1280 top=-630
@bgm storage=bgm_10
@show
*p1|
@nm t="千尋"
「ダメだ……。眠れない……」[np]
@hide
@eff_all_delete
@bg storage=bg_08d
@wait time=800
[se storage="物_部屋_スイッチ"]
@bg storage=bg_08c
@show
*p2|
部屋の灯りを点けて夜風を浴びる。[np]
*p3|
部屋に引きこもったのはいいが、[r]
気づけば結局、彼女たちのことを考えてしまっていた。[np]
*p4|
二人のおかげでまた描けるようになった漫画も、[r]
気を紛らわせることは出来やしなかった。[np]
@hide
@bg storage=bg_08c_l left=0 top=-490
@show
*p5|
@nm t="千尋"
「この気持ちが……恋、でいいのかなぁ……？」[np]
*p6|
どうにも、自信が持てず、気持ちを持て余す。[np]
*p7|
ただ、俺がセーラやリルルを好きだと思うのと[r]
同じような気持ちを、聖良と莉瑠に抱いてしまっている。[np]
*p8|
もちろん、セーラとリルルへの想いに変わりはないんだけど。[np]
*p11|
単に俺が惚れっぽいだけなのだろうか？[np]
*p13|
@nm t="千尋"
「いやいやいや、受け入れてちゃいかん。自制しないと……！！」[np]
*p14|
と、頭を抱えて座り込んでいた、その時だった。[np]
[se storage="扉_ノック_木_027"]
[wait time=200]
@mq_small
*p15|
@nm t="千尋"
「うわっ！！？」[np]
*p16|
急に現実に引き戻されたようで、情けない声を上げてしまった。[np]
@hide
@bg storage=bg_08c
@wait time=500
@eff obj=0 page=back show=true storage=al_horizon_041_o path=(640,320,255) time=1 absolute=(15000) ysize=(0.5,0.5) correct=false
@eff obj=1 page=back show=true storage=al_horizon_041_o path=(640,320,255) time=1 absolute=(15001) ysize=(0.47,0.47) correct=false
@eff obj=2 page=back show=true storage=sp_bg_08c_ドア左 path=(640,360,255) time=1 absolute=(15002) correct=false alphaeffect=1
@eff obj=3 page=back show=true storage=sp_bg_08c_ドア右 path=(640,360,255) time=1 absolute=(15003) correct=false alphaeffect=1
@eff obj=4 page=back show=true storage=st02bdb11 path=(657,442,255) size=(1.1,1.1) time=1 absolute=(15004) alphaeffect=1 anm=false
@bg storage=bg_08c
@show
*p17|
@nm t="莉瑠" s=rir_10237
「千尋さん……？　ま、まだ起きてますか？」[np]
@ceff obj=4 storage=st02bdb13 time=250
*p18|
@nm t="千尋"
「り、莉瑠！？　こんな時間にどうしたんだ？」[np]
@ceff obj=4 storage=st02adb12 path=(578,464,255) time=250
@dceff obj=4 storage=st02adb08 delay=2845
*p19|
@nm t="莉瑠" s=rir_10238
「それは、えと……！[r]
と、とりあえず入っていいですか？」[np]
@ceff obj=4 storage=st02adb09
*p20|
@nm t="千尋"
「えっ？　あ、いや――」[np]
@eff_all_delete
@bg storage=bg_08c
*p21|
答える前に莉瑠が自ら扉を開けて、[r]
部屋の中へと入ってくる。[np]
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
[wait time=300]
@chr_walk way=l st02abb12
@wt
@chr st02abb13
*p22|
@nm t="莉瑠" s=rir_10239
「こ……こんばんはです……」[np]
*p23|
@nm t="千尋"
「あ、うん……こんばんは」[np]
*p24|
まず目に入ったのは莉瑠の赤く染まった顔だった。[r]
まるで長湯でもした後のように耳まで真っ赤だ。[np]
*p25|
表情はなんだか強ばっていて、[r]
身体も力が入って固い感じ、というか、僅かに震えていた。[np]
*p26|
@nm t="千尋"
「それで、その……どうしたんだ？」[np]
@chr st02abb08
*p27|
@nm t="莉瑠" s=rir_10240
「ど、どうしたって。もしかして、[r]
まだ聖良は来てないんですか？」[np]
@chr st02abb09
*p28|
@nm t="千尋"
「へ？　来てないけど……聖良も来るのか？」[np]
@chr st02abb14
@dchr st02abb16 delay=1410
*p29|
@nm t="莉瑠" s=rir_10241
「～～っっ。な、なんでもないです……！！」[np]
@chr st02abb13
*p30|
@nm t="莉瑠" s=rir_10242
「嘘でしょう……！　何やってるんですか、聖良……！[r]
あんなこと言っておいてまだ来てなかったなんて……！」[np]
@chr st02abb14
@dchr st02abb18 delay=4745
*p31|
@nm t="莉瑠" s=rir_10243
「予想外です……！　まさか私の方が先に……[r]
は、羽目になるなんて……！」[np]
@chr st02abb12
*p32|
莉瑠が焦った様子でブツブツと何かを呟く。[r]
何やら苦悩しているらしく頭を右へ左へと振り回していた。[np]
*p33|
髪が靡く度にシャンプーの匂いと、[r]
彼女自身の甘い匂いが部屋に香ってくる。[np]
*p34|
@nm t="千尋"
「っ……」[np]
@chr st02abb13
*p35|
ついつい莉瑠のことを目で追って、[r]
一挙手一投足に反応している自分に気づいた。[np]
*p36|
その瞬間、かぁっと頭に血が上り、[r]
耳には自分の動悸の音さえ聞こえてきた。[np]
*p37|
@nm t="千尋"
「急ぎとかじゃなかったら明日でもいいかな？[r]
あー、実はそろそろ寝るところだったから」[np]
@chr st02bbb06
@dchr st02bbb09 delay=2170
*p38|
@nm t="莉瑠" s=rir_10244
「あっ……！　ま、待って下さいっ……！！[r]
用事がないわけじゃなくて……！！」[np]
@chr st02bbb13
*p39|
腰が引けた俺の言葉に、莉瑠は慌てて顔を上げた。[r]
そして、モジモジと身体を揺らして見つめてくる。[np]
*p40|
なんだろう、恋愛漫画とかエロ漫画でよく見る、[r]
想いを伝える直前のヒロインの動きのようだ。[np]
@fobgm time=3000
@dchr st02bbb14 delay=3462
*p41|
@nm t="莉瑠" s=rir_10245
「で……ですから、その。[r]
あなたさえ嫌じゃなければ、なんですけど……」[np]
*p42|
@nm t="千尋"
「あ、ああ」[np]
@chr st02bbb17
*p43|
すると莉瑠は意を決したように一瞬、息を呑んで――[np]
@bgm storage=bgm_11
@chr st02bbb09
@dchr st02bbb16 delay=2661
*p44|
@nm t="莉瑠" s=rir_10246
「私をっ、だ、抱いて下さいっっ……！！」[np]
@chr st02bbb14
*p45|
@nm t="千尋"
「だ――え！？」[np]
@chr st02bbb13
*p46|
てっきり告白か何かかと身構えていたこともあって、[r]
莉瑠の口から出た一言に頭が真っ白になってしまう。[np]
@chr st02abb16
@dchr st02abb14 delay=4361
*p47|
@nm t="莉瑠" s=rir_10247
「で、ですからエッチですよ、エッチ……！！[r]
本番セックスっ……！！　興味あるのでして下さい……！！」[np]
@chr st02abb13
*p48|
@nm t="千尋"
「待って待ってっ……興味あるからっていきなりそんな……！」[np]
@chr st02abb14
*p49|
@nm t="莉瑠" s=rir_10248
「い、いいじゃないですかっ。あなたも内心では[r]
ずっとヤりたがってたでしょうっ？　バレバレですよっ！？」[np]
@chr st02abb15
@dchr st02abb18 delay=4824
*p50|
@nm t="莉瑠" s=rir_10249
「言っておきますけど、あなたにとってはまたとない[r]
チャンスのはずです。こんなに若くて可愛い女の子と、[r]
し、しかも処女の子とエッチできるなんて……！」[np]
@eff obj=0 page=back show=true storage=bg_08c path=(640,360,255) time=1 bbx=(2) bby=(2) bbt=true bbs=true absolute=(2000)
@chr st02bdb07
*p51|
@nm t="千尋"
「――おわぁっ！？」[np]
*p52|
今にも押し倒してきそうな勢いで莉瑠が迫ってくる。[np]
@chr st02bdb09
*p53|
@nm t="莉瑠" s=rir_10250
「一夏のアヴァンチュールってヤツですよ……！[r]
ほら軽い気持ちでヤっちゃって下さいっ！[r]
私を押し倒して、ズブっといっちゃって下さいっ！」[np]
@chr st02bdb07
*p54|
@nm t="千尋"
「お、落ち着くんだ……！！[r]
莉瑠はそんなのでいいのかっ……！？」[np]
@chr st02bdb08
@dchr st02bdb12 delay=2889
*p55|
@nm t="莉瑠" s=rir_10251
「い、いいから言ってるんでしょうに……！！[r]
嫌だったら最初から言わないですよっ……！！」[np]
@chr st02bdb07
*p56|
はた目から見てもわかるほどテンパりながら、[r]
莉瑠が俺をベッドに押し倒そうとしてくる。[np]
*p57|
慌てふためく彼女を見て、[r]
逆に俺の心は少し落ち着きを取り戻す。[np]
*p58|
とてもじゃないが、興味だけでこんなことを言い出さないと思う。[r]
莉瑠は警戒心の強い子でもあったし、ちょっと違和感が残る。[np]
*p59|
うぬぼれかもしれないけど、もしかしたら……なんて思ったら、[r]
うじうじしてた自分が急激に恥ずかしくなってきた。[np]
@chr st02bdb08
@dchr st02bdb14 delay=5048
@dchr st02bdb16 delay=7161
*p60|
@nm t="莉瑠" s=rir_10252
「なんならお金払いますからっ……！[r]
一万でも、二万でも、三万でもっ……！！[r]
ですからお願いです、抱いて下さいっ……！！」[np]
@chr st02bdb13
*p61|
混乱しすぎて、とんちんかんなお願いをしてくる[r]
そんな彼女に心の底から愛おしさが湧いてくる。[np]
@chr st02bdb07
*p62|
さっきまで何を俺は悩んでいたのだろうか。[r]
自分で認めない限り、この気持ちに自信なんて持てるわけがない。[np]
@chr st02bdb13
*p63|
そうだ、俺は莉瑠のことが――[np]
*p64|
@nm t="千尋"
「……わかった」[np]
@chr st02bdb14
*p65|
@nm t="莉瑠" s=rir_10253
「えっ……？」[np]
*p66|
@nm t="千尋"
「だから、その……。[r]
抱いて欲しいって話……」[np]
*p67|
答えると、莉瑠の顔が何とも複雑そうに歪む。[np]
@chr st02adb14
*p68|
@nm t="莉瑠" s=rir_10254
「そんなにお金が欲しいんですか！？」[np]
*p69|
@nm t="千尋"
「なんでそうなる！？　全然違うから！！」[np]
@chr st02adb13
*p70|
台無しだ。[np]
*p71|
@nm t="千尋"
「ちょっと落ち着いて、今度は俺の話を聞いてくれないか？」[np]
@chr st02adb08
*p72|
@nm t="莉瑠" s=rir_10255
「っっ。あ、あなたの話って……」[np]
@chr st02adb09
*p73|
@nm t="千尋"
「その、俺は莉瑠のこと、多分好きだ……。[r]
いや、多分じゃない、間違いなく……好きだ」[np]
@chr st02adb14
@dchr st02adb18 delay=2406
*p74|
@nm t="莉瑠" s=rir_10256
「好――～～っっ！！？[r]
そ、そんなストレートに言われても……！！」[np]
@chr st02adb13
*p75|
@nm t="千尋"
「どの口で……いや、でも大事なことだからハッキリしたい。[r]
莉瑠は、どうなんだ？」[np]
@chr st02bdb13
*p76|
@nm t="莉瑠" s=rir_10257
「で、ですから、えと……！　私は、その……！」[np]
*p77|
いつもはハキハキと喋る莉瑠が、[r]
ボソボソと恥ずかしそうに呟き続ける。[np]
*p78|
その照れた姿がやっぱり可愛くて、[r]
その顔を見ているだけでも心に熱が灯る。[np]
@chr st02bdb14
*p79|
@nm t="莉瑠" s=rir_10258
「き……嫌いだったら、抱いて欲しいなんて言いませんよ。[r]
私のこと、ビ、ビッチだとでも思ってるんですか……？」[np]
@chr st02bdb15
*p80|
@nm t="莉瑠" s=rir_10259
「す……好きです。あなたのこと……」[np]
@chr st02adb17
*p81|
@nm t="莉瑠" s=rir_10260
「大好き……です……」[np]
@chr st02adb13
*p82|
上目遣いに俺を見つめ、[r]
照れ臭そうに言葉を搾り出してくれる。[np]
*p83|
莉瑠の言葉に、一瞬で心が沸き立つ。[r]
ドクドクと脈打つ血潮が抑えきれない――[np]
@chr st02adb14
*p84|
@nm t="莉瑠" s=rir_10261
「ま、待って下さいっ……！！」[np]
@chr st02adb12
*p85|
@nm t="千尋"
「っ……ど、どうした？」[np]
@chr st02bdb08
@dchr st02bdb09 delay=3100
*p86|
@nm t="莉瑠" s=rir_10262
「ややや、やっぱりエッチは今度にしませんかっ？[r]
抱いて抱いてと言っておいてなんですがっ……！！」[np]
@chr st02bdb08
@dchr st02adb07 delay=3499
*p87|
@nm t="莉瑠" s=rir_10263
「き、気持ちを伝えたらスッキリしましたしね……！！[r]
今日のところは解散ということにしましょうっ……！！」[np]
@eff_all_delete
@chr st02abb13
@wt
*p88|
莉瑠が自分の身体を抱いて[r]
恥ずかしそうに後ずさりながら言ってくる。[np]
*p89|
……きっと勢いに任せて最後まで行くつもりが、[r]
告白合戦になったことで照れてしまったんだろう。[np]
*p90|
大事なところでヘタレる莉瑠に親近感を覚えると同時に、[r]
その可愛らしい姿に、グラグラ来てしまう。[np]
@chr st02bbb08
*p91|
@nm t="莉瑠" s=rir_10264
「そ、それではおやすみなさいっ。[r]
サラバですっっ――」[np]
@chr_del_walk way=l name=莉瑠 time=200
*p92|
@nm t="千尋"
「――待った」[np]
@shide
@black rule=rule_71_i_o time=100
@eff obj=0 page=back show=true storage=sp_bg_08c_ドア右 path=(640,360,255) fliplr=true size=(1.1,1.1) time=1 absolute=(2000) correct=false
@eff obj=1 page=back show=true storage=sp_bg_08c_ドア左 path=(640,360,255) fliplr=true size=(1.1,1.1) time=1 absolute=(2100) correct=false
@eff obj=2 page=back show=true storage=st02bdb10 path=(647,570,180) size=(0.8,0.8) time=1 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@eff obj=3 page=back show=true storage=st02bdb10 path=(634,566,255) size=(0.8,0.8) time=1 absolute=(8100)
[se storage="壁ドン"]
@bg storage=bg_08c rule=rule_71_i_o time=100
@sshow
*p93|
@nm t="莉瑠" s=rir_10265
「ひぃ！！？」[np]
@ceff obj=3 storage=st02bdb13 time=250
*p94|
扉を押さえつけて逃げ出せないようにする。[np]
@ceff obj=3 storage=st02bdb09
@ceff_stock obj=2 storage=st02adb11 path=(615,573,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@dceff obj=3 storage=st02adb11 path=(605,570,255) size=(0.8,0.8) time=250 absolute=(8100) clear=false delay=3949
*p95|
@nm t="莉瑠" s=rir_10266
「ま、まさか私を犯すつもりですかっ……！！？[r]
やめて下さい、助けて下さい、なんでもしますからっ……！！」[np]
@ceff obj=3 storage=st02adb12
*p96|
さっきまで抱いて抱いてと言っていたクセに、[r]
今度は猛烈に嫌がる彼女に苦笑が漏れてしまう。[np]
*p97|
照れ隠しにしては聞こえが悪すぎる言葉も[r]
彼女らしくて愛らしい。[np]
*p98|
そうだ、こんなに恥ずかしがり屋なのに、[r]
勇気を出して俺を訪ねてくれたんだよな。[np]
*p99|
なら、ここからは俺の番だ。[r]
決して柄ではないけれど、俺も勇気を出さないと。[np]
@ceff obj=3 storage=st02adb08
*p100|
@nm t="莉瑠" s=rir_10267
「ふ、ふぇっ……！？」[np]
@ceff obj=3 storage=st02adb13
*p101|
扉を押さえていた手を彼女の肩に下ろして、[r]
莉瑠を真っ直ぐ見つめる。[np]
*p102|
そして、そのまま顔をゆっくりと近づけていく。[np]
@ceff_stock obj=2 storage=st02bdb10 path=(647,570,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02bdb14 path=(634,566,255) size=(0.8,0.8) time=250 absolute=(8100)
*p103|
@nm t="莉瑠" s=rir_10268
「っっ」[np]
*p104|
莉瑠は目をパチクリさせて焦りながらも、[r]
迫る俺から逃げないでくれて――[np]
@hide
@eff_delete obj=0
@eff_delete obj=1
@eff_delete obj=2
@eff_delete obj=3
@eff obj=4 page=back show=true storage=sp_200_莉瑠初体験_00童貞ver_p104 path=(589,331,255) size=(1.25,1.25) time=1 rad=(4,4) bbx=(10) bby=(10) bbt=true bbs=true absolute=(15000) correct=false
@eff obj=5 page=back show=true storage=loop_mist_white2_vertical path=(640,360,150) time=1 gceil=220 bceil=220 bbx=(10) bby=(3) bbs=true absolute=(15001) mode=psdodge5 correct=false
@eff obj=6 page=back show=true storage=st02bdb17 path=(642,594,255) size=(1.25,1.25) time=1 rad=(3,3) absolute=(15002) anm=false
@eff obj=7 page=back show=true storage=al_horizon_020_c path=(640,360,255) size=(1.3,1.3) time=1 rad=(4,4) bbx=(20) bby=(20) bbt=true bbs=true absolute=(15003) correct=false sub=true
@eff obj=8 page=back show=true storage=st02bdb17 path=(642,594,255) size=(1.25,1.25) time=1 rad=(3,3) bbx=(2) bby=(2) bbt=true bbs=true absolute=(15004) alphaeffect=7 anm=false
@bg storage=bg_08c
@show
*p105|
@nm t="莉瑠" s=rir_10269
「ん……ちゅっ……」[np]
*p106|
柔らかくて甘い感触が唇越しに伝わってくる。[r]
薄目を開けると、驚くくらい近くに彼女の顔があった。[np]
*p107|
そうしてしばらく唇を重ねた後、[r]
ゆっくりと顔を離した。[np]
@hide
@eff_delete obj=4
@eff_delete obj=5
@eff_delete obj=6
@eff_delete obj=7
@eff_delete obj=8
@eff obj=0 page=back show=true storage=sp_bg_08c_ドア右 path=(640,360,255) size=(1.1,1.1) fliplr=true time=1 absolute=(2000) correct=false
@eff obj=1 page=back show=true storage=sp_bg_08c_ドア左 path=(640,360,255) size=(1.1,1.1) fliplr=true time=1 absolute=(2100) correct=false
@eff obj=2 page=back show=true storage=st02bdb14 path=(647,570,180) size=(0.8,0.8) time=1 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@eff obj=3 page=back show=true storage=st02bdb14 path=(634,566,255) size=(0.8,0.8) time=1 absolute=(8100)
@bg storage=bg_08c
@show
@dceff obj=3 storage=st02bdb15 time=250 delay=2063
*p108|
@nm t="莉瑠" s=rir_10270
「……意外と、はぁはぁ。強引、なんですね……？」[np]
@ceff obj=3 storage=st02bdb14 delay=0
*p109|
@nm t="千尋"
「嫌だったかな……？」[np]
@ceff obj=3 storage=st02bdb15
*p110|
@nm t="莉瑠" s=rir_10271
「い……いえ。おかげでちょっぴり落ち着きました……」[np]
@ceff obj=3 storage=st02bdb14
*p111|
莉瑠がキスの感触を確かめるように自分の唇を撫でる。[np]
@ceff_stock obj=2 storage=st02adb06 path=(615,573,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02adb06 path=(605,570,255) time=250
@dceff obj=3 storage=st02adb02 path=(605,570,255) time=250 delay=6481
*p112|
@nm t="莉瑠" s=rir_10272
「でも……えへへ。すごく下手くそでした。[r]
歯がガツンガツン当たって痛かったですもん」[np]
@ceff obj=3 storage=st02adb17
*p113|
@nm t="莉瑠" s=rir_10273
「最悪の、ふふ。ファーストキスです」[np]
@ceff obj=3 storage=st02adb05
*p114|
笑顔で文句を言ってくる彼女に[r]
ドキドキしてしまう。[np]
*p115|
莉瑠のこういう素直じゃない可愛さが、[r]
俺はどうしようもなく好きみたいだ。[np]
*p116|
@nm t="千尋"
「一応言っておくけど……俺も初めてだからな」[np]
@ceff obj=3 storage=st02adb17
@dceff obj=3 storage=st02adb04 delay=3046
*p117|
@nm t="莉瑠" s=rir_10274
「えへへ……知ってますよ。というかわかります。[r]
あんなに下手くそなんですもん……」[np]
@ceff_stock obj=2 storage=st02bdb15 path=(647,570,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02bdb15 path=(634,566,255) size=(0.8,0.8) time=250 absolute=(8100)
*p118|
@nm t="莉瑠" s=rir_10275
「でも……嬉しいです」[np]
@ceff obj=3 storage=st02bdb02
@dceff obj=3 storage=st02bdb15 delay=2665
*p119|
@nm t="莉瑠" s=rir_10276
「最悪のキスでしたけど、[r]
あなたの初めてをもらえて……」[np]
*p120|
@nm t="莉瑠" s=rir_10277
「私の初めてを、あなたにもらってもらえて……」[np]
@ceff_stock obj=2 storage=st02adb17 path=(615,573,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02adb17 path=(605,570,255) time=250
*p121|
@nm t="莉瑠" s=rir_10278
「最高に……幸せです」[np]
@ceff obj=3 storage=st02adb05
*p122|
照れながらも莉瑠がそう微笑みかけてくれる。[np]
@ceff obj=3 storage=st02adb13
*p123|
@nm t="莉瑠" s=rir_10279
「……他の初めてももらってくれますか？[r]
あなたに……その。もらって欲しいです……」[np]
@ceff_stock obj=2 storage=st02bdb14 path=(647,570,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02bdb14 path=(634,566,255) size=(0.8,0.8) time=250 absolute=(8100)
*p124|
@nm t="莉瑠" s=rir_10280
「大好きなあなたにもらって欲しいと思って……。[r]
今日はこうしてあなたの部屋に来たんですから……」[np]
*p125|
@nm t="千尋"
「ああ。俺も初めてを莉瑠にもらって欲しい」[np]
@ceff obj=3 storage=st02bdb15
*p126|
@nm t="莉瑠" s=rir_10281
「……えへへ。ありがたく思って下さいね……？[r]
こんなに可愛い女の子で童貞を卒業できるんですから」[np]
@ceff obj=3 storage=st02bdb03
*p127|
冗談めかしに言ってくる莉瑠、俺もまた[r]
冗談っぽく笑いつつ、彼女の服へ手を伸ばしていく。[np]
[se storage="衣擦れ(103)" buf=0 delay=0]
@ceff obj=3 storage=st02bdb14
*p128|
@nm t="莉瑠" s=rir_10282
「あ……」[np]
@eff_delete obj=2
@eff_delete obj=3
@extrans time=250
*p129|
莉瑠は恥ずかしそうに息を呑んだものの、[r]
逃げることなく、俺の動きを受け入れてくれた。[np]
*p130|
それどころか俺の服に手を伸ばして、[r]
こちらを脱がそうとしてくれる。[np]
@hide
@eff_all_delete
[se storage="衣擦れ(32)" buf=0 delay=0]
@bg storage=bg_08c st02aba13
@show
*p131|
@nm t="莉瑠" s=rir_10283
「っっ」[np]
*p132|
そうしてお互いに一糸まとわぬ姿になったところで、[r]
俺たちは改めて向かい合った。[np]
@chr st02bba14
*p133|
@nm t="莉瑠" s=rir_10284
「ふ……不思議です。裸見せるの、すごく恥ずかしくて……。[r]
おっぱいもアソコも見せたことあるはずですのに……」[np]
@chr st02bba16
@dchr st02bba09 delay=7123
*p134|
@nm t="莉瑠" s=rir_10285
「身体中熱くて、はぁはぁ、沸騰しちゃいそうです……。[r]
こうして立ってるだけで、頭の中真っ白になってきて……」[np]
@chr st02bba13
*p135|
莉瑠は顔だけじゃなく、全身を仄かに赤らめる。[r]
熱っぽい吐息を漏らしながら、視線を泳がしている。[np]
*p136|
緊張しているのは目に見えてわかった。[r]
そうして意識してくれることがとても嬉しかった。[np]
*p137|
だからこそ、緊張をほぐしてあげたい。[r]
彼女の大切な初めてを嫌な思い出にはしたくないから。[np]
@hide
@white
[se storage="動作_衣擦れ_洋服_09" buf=0 delay=0]
@show
*p138|
@nm t="莉瑠" s=rir_10286
「ふぁ……！？」[np]
*p139|
できる限りそっと彼女をベッドへと寝かせる。[np]
*p140|
そして――[np]
@hide
@white time=2000
@wait time=1000
@jump storage="200_莉瑠初体験_01_h.ks"

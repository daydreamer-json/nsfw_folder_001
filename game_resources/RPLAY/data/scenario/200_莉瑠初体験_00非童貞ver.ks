; 
; 
*p0|
@white
@show
*p1|
それは聖良との初体験を終えて、[r]
少し経った後――[np]
@hide
@bg storage=bg_08c_l left=-1280 top=-575
@bgm storage=bgm_10
@show
*p2|
@nm t="千尋"
「まだ起きててって言われたものの……。[r]
いつまで起きていればいいんだ？」[np]
*p3|
聖良の意味深な笑顔を思い出して呟く。[np]
*p4|
てっきり一緒に寝たりするのかと思っていたけれど、[r]
大浴場で身体を洗った後、聖良は部屋へと戻っていった。[np]
*p5|
「もう少しだけ起きててね？」とだけ告げて。[np]
*p6|
どういうことだろうか？[r]
また着替えて戻ってくる、とか？[np]
*p7|
考えてもわかりそうにないな――[np]
[se storage="扉_ノック_木_027"]
[wait time=200]
*p8|
@nm t="千尋"
「うわっ！！？」[np]
*p9|
不意に扉がノックされて大声を上げてしまう。[np]
*p10|
聖良が戻ってきたのか――と思ったけれど、[r]
聞こえてきたのは違う声だった。[np]
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
*p11|
@nm t="莉瑠" s=rir_10237
「千尋さん……？　ま、まだ起きてますか？」[np]
@ceff obj=4 storage=st02bdb13 time=250
*p12|
@nm t="千尋"
「り、莉瑠？　こんな時間にどうしたんだ？」[np]
@ceff obj=4 storage=st02adb12 path=(578,464,255) time=250
@dceff obj=4 storage=st02adb08 delay=2845
*p13|
@nm t="莉瑠" s=rir_10238
「それは、えと……！[r]
と、とりあえず入っていいですか？」[np]
@ceff obj=4 storage=st02adb09
*p14|
@nm t="千尋"
「えっ？　あ、いや――」[np]
@eff_all_delete
@bg storage=bg_08c
*p15|
答える前に莉瑠が自ら扉を開けて、[r]
部屋の中へと入ってくる。[np]
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
[wait time=300]
@chr_walk way=l st02abb12
@wt
@chr st02abb13
*p16|
@nm t="莉瑠" s=rir_10239
「こ……こんばんはです……」[np]
*p17|
@nm t="千尋"
「こ、こんばんは」[np]
*p18|
まず目に入ったのは莉瑠の赤く染まった顔だった。[r]
まるで長湯でもした後のように耳まで真っ赤だ。[np]
*p19|
表情はなんだか強ばっていて、[r]
身体も力が入って固い感じ、というか、僅かに震えていた。[np]
*p20|
さっきの聖良の姿がフラッシュバックする。[r]
これは、もしかして──[np]
@chr st02abb08
@dchr st02abb15 delay=6135
*p21|
@nm t="莉瑠" s=rir_10287
「用件は……その。わ、わかってますよね……？[r]
さっきまで聖良と仲良くずっこんばっこんしてたみたいですし」[np]
@chr st02abb13
*p22|
@nm t="千尋"
「き、聞いていたのかっ……！？」[np]
@chr st02abb14
@dchr st02abb16 delay=3941
*p23|
@nm t="莉瑠" s=rir_10288
「『聞こえて』きたんです……！　あんなに、そのっ。[r]
気持ちよさそうに大声で喘いでるんですもん……！」[np]
@chr st02bbb08
@dchr st02bbb09 delay=3470
*p24|
@nm t="莉瑠" s=rir_10289
「あんな声聞かされる身にもなって下さい……。[r]
……エ、エッチな気分にならざるを得ないじゃないですか」[np]
@chr st02bbb14
*p25|
莉瑠が恥ずかしそうに[r]
モジモジと身体を揺らして見つめてくる。[np]
@fobgm time=3000
@chr st02bbb13
*p26|
@nm t="莉瑠" s=rir_10290
「で……ですから、その。[r]
あなたさえ嫌じゃなければ、なんですけど……」[np]
*p27|
すると莉瑠は意を決したように、息を呑んで――[np]
@bgm storage=bgm_11
@chr st02bbb16
*p28|
@nm t="莉瑠" s=rir_10291
「私もっ、抱いて下さいっっ……！！」[np]
@chr st02bbb14
*p29|
@nm t="千尋"
「っっ……！！」[np]
*p30|
状況的に、もしかしてとはかすかに思ってはいたものの、[r]
ここまでストレートだと頭の中が真っ白になってしまう。[np]
*p31|
というか良いのか？[r]
聖良とした後に、今度は莉瑠となんて――[np]
@chr st02abb16
@dchr st02abb14 delay=7004
*p32|
@nm t="莉瑠" s=rir_10292
「べ、別に今更でしょう？　エッチなロールプレイは[r]
私にも聖良にも頼んでるわけですし……！[r]
どっちともエッチしてるわけですし……！」[np]
@chr st02abb10
@dchr st02abb16 delay=3332
*p33|
@nm t="莉瑠" s=rir_10293
「なら本番セックスだって一緒ですよ……！！[r]
聖良としたからって関係ありません……！！」[np]
@chr st02abb13
*p34|
@nm t="千尋"
「そ、そうは言うけどだな」[np]
@chr st02abb14
*p35|
@nm t="莉瑠" s=rir_10248
「い、いいじゃないですかっ。あなたも内心では[r]
ずっとヤりたがってたでしょうっ？　バレバレですよっ！？」[np]
@chr st02abb15
@dchr st02abb18 delay=4824
*p36|
@nm t="莉瑠" s=rir_10249
「言っておきますけど、あなたにとってはまたとない[r]
チャンスのはずです。こんなに若くて可愛い女の子と、[r]
し、しかも処女の子とエッチできるなんて……！」[np]
@eff obj=0 page=back show=true storage=bg_08c path=(640,360,255) time=1 bbx=(2) bby=(2) bbt=true bbs=true absolute=(2000)
@chr st02bdb07
*p37|
@nm t="千尋"
「――おわぁっ！？」[np]
*p38|
今にも押し倒してきそうな勢いで莉瑠が迫ってくる。[np]
@chr st02bdb09
*p39|
@nm t="莉瑠" s=rir_10250
「一夏のアヴァンチュールってヤツですよ……！[r]
ほら軽い気持ちでヤっちゃって下さいっ！[r]
私を押し倒して、ズブっといっちゃって下さいっ！」[np]
@chr st02bdb07
*p40|
@nm t="千尋"
「お、落ち着くんだ……！！[r]
莉瑠はそれでいいのかっ……！？」[np]
@chr st02bdb08
@dchr st02bdb12 delay=2889
*p41|
@nm t="莉瑠" s=rir_10251
「い、いいから言ってるんでしょうに……！！[r]
嫌だったら最初から言わないですよっ……！！」[np]
@chr st02bdb07
*p42|
はた目から見てもわかるほどテンパりながら、[r]
莉瑠が俺をベッドに押し倒そうとしてくる。[np]
*p43|
慌てふためく彼女を見て、[r]
逆に俺の心は少し落ち着きを取り戻す。[np]
*p44|
聖良が起きててと言ったのはやっぱり、[r]
こうしてやってくる莉瑠のためだったんだろう。[np]
@chr st02bdb13
*p45|
俺なんかのことを、と思うと、二人に失礼だけど、[r]
それでも、こうまで想ってくれることが少し信じられない。[np]
*p46|
ただ、さすがに聖良の気持ちを受け取った俺が、[r]
そこに懐疑的になってはいけない。[np]
*p47|
この状況は聖良も後押ししてくれたからこそだ。[r]
ならどうあれ、俺が莉瑠に抱く気持ちは、伝えるべきだ。[np]
@chr st02bdb08
@dchr st02bdb14 delay=5048
@dchr st02bdb16 delay=7161
*p48|
@nm t="莉瑠" s=rir_10252
「なんならお金払いますからっ……！[r]
一万でも、二万でも、三万でもっ……！！[r]
ですからお願いです、抱いて下さいっ……！！」[np]
@chr st02bdb13
*p49|
混乱しすぎて、とんちんかんなお願いをしてくる[r]
そんな彼女に心の底から愛おしさが湧いてくる。[np]
@chr st02bdb07
*p50|
素直じゃないけど、勇気を振り絞った莉瑠の気持ちに、[r]
自分の中の想いの輪郭が、どんどん明確になっていく。[np]
@chr st02bdb13
*p51|
やっぱり俺は莉瑠のことも――[np]
*p52|
@nm t="千尋"
「わかった」[np]
@chr st02bdb14
*p53|
@nm t="莉瑠" s=rir_10253
「えっ……？」[np]
*p54|
@nm t="千尋"
「だから、その……。[r]
抱いて欲しいって話……」[np]
*p55|
答えると、莉瑠の顔が何とも複雑そうに歪む。[np]
@chr st02adb14
*p56|
@nm t="莉瑠" s=rir_10254
「そんなにお金が欲しいんですか！？」[np]
*p57|
@nm t="千尋"
「なんでそうなる！？　全然違うから！！」[np]
@chr st02adb13
*p58|
台無しだ。[np]
*p59|
@nm t="千尋"
「ちょっと落ち着いて、今度は俺の話を聞いてくれないか？」[np]
@chr st02adb08
*p60|
@nm t="莉瑠" s=rir_10255
「っっ。あ、あなたの話って……」[np]
@chr st02adb09
*p61|
@nm t="千尋"
「聖良の気持ちを受け取って、エッチしておいて、[r]
こういうのもどうかと思うけど……」[np]
*p62|
@nm t="千尋"
「俺は莉瑠のことも好きだ。[r]
聖良と同じくらい、好きなんだ」[np]
@chr st02adb13
@dchr st02adb08 delay=1880
*p63|
@nm t="莉瑠" s=rir_10294
「っっ……！！　そんなに馬鹿正直に言われると、[r]
ど、どう反応していいか……！！」[np]
@chr st02adb12
*p64|
@nm t="千尋"
「いや、ここはハッキリしないと。俺は莉瑠が好きだ。[r]
莉瑠は……どうなんだ？」[np]
@chr st02bdb13
*p65|
@nm t="莉瑠" s=rir_10257
「で、ですから、えと……！　私は、その……！」[np]
*p66|
いつもはハキハキと喋る莉瑠が、[r]
ボソボソと恥ずかしそうに呟き続ける。[np]
*p67|
その照れた姿がやっぱり可愛くて、[r]
その顔を見ているだけでも心に熱が灯る。[np]
@chr st02bdb14
*p68|
@nm t="莉瑠" s=rir_10258
「き……嫌いだったら、抱いて欲しいなんて言いませんよ。[r]
私のこと、ビ、ビッチだとでも思ってるんですか……？」[np]
@chr st02bdb15
*p69|
@nm t="莉瑠" s=rir_10259
「す……好きです。あなたのこと……」[np]
@chr st02adb17
*p70|
@nm t="莉瑠" s=rir_10260
「大好き……です……」[np]
@chr st02adb13
*p71|
上目遣いに俺を見つめ、[r]
照れ臭そうに言葉を搾り出してくれる。[np]
*p72|
莉瑠の言葉に、一瞬で心が沸き立つ。[r]
ドクドクと脈打つ血潮が抑えきれない――[np]
@chr st02adb14
*p73|
@nm t="莉瑠" s=rir_10261
「ま、待って下さいっ……！！」[np]
@chr st02adb12
*p74|
@nm t="千尋"
「っ……ど、どうした？」[np]
@chr st02bdb08
*p75|
@nm t="莉瑠" s=rir_10262
「ややや、やっぱりエッチは今度にしませんかっ？[r]
抱いて抱いてと言っておいてなんですがっ……！！」[np]
@dchr st02adb07 delay=3499
*p76|
@nm t="莉瑠" s=rir_10263
「き、気持ちを伝えたらスッキリしましたしね……！！[r]
今日のところは解散ということにしましょうっ……！！」[np]
@eff_all_delete
@chr st02abb13
@wt
*p77|
莉瑠が自分の身体を抱いて[r]
恥ずかしそうに後ずさりながら言ってくる。[np]
*p78|
……きっと勢いに任せて最後まで行くつもりが、[r]
告白合戦になったことで照れてしまったんだろう。[np]
*p79|
大事なところでヘタレる莉瑠に親近感を覚えると同時に、[r]
その可愛らしい姿に、グラグラ来てしまう。[np]
@chr st02bbb08
*p80|
@nm t="莉瑠" s=rir_10264
「そ、それではおやすみなさいっ。[r]
サラバですっっ――」[np]
@chr_del_walk way=l name=莉瑠 time=200
*p81|
@nm t="千尋"
「――待った」[np]
@shide
@black rule=rule_71_i_o time=100
[se storage="壁ドン"]
@eff obj=0 page=back show=true storage=sp_bg_08c_ドア右 path=(640,360,255) size=(1.1,1.1) fliplr=true time=1 absolute=(2000) correct=false
@eff obj=1 page=back show=true storage=sp_bg_08c_ドア左 path=(640,360,255) size=(1.1,1.1) fliplr=true time=1 absolute=(2100) correct=false
@eff obj=2 page=back show=true storage=st02bdb10 path=(647,570,180) size=(0.8,0.8) time=1 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@eff obj=3 page=back show=true storage=st02bdb10 path=(634,566,255) size=(0.8,0.8) time=1 absolute=(8100)
@bg storage=bg_08c rule=rule_71_i_o time=100
@sshow
*p82|
@nm t="莉瑠" s=rir_10265
「ひぃ！！？」[np]
@ceff obj=3 storage=st02bdb13 time=250
*p83|
扉を押さえつけて逃げ出せないようにする。[np]
@ceff obj=3 storage=st02bdb09
@ceff_stock obj=2 storage=st02adb11 path=(615,573,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@dceff obj=3 storage=st02adb11 path=(605,570,255) size=(0.8,0.8) time=250 absolute=(8100) clear=false delay=3949
*p84|
@nm t="莉瑠" s=rir_10266
「ま、まさか私を犯すつもりですかっ……！！？[r]
やめて下さい、助けて下さい、なんでもしますからっ……！！」[np]
@ceff obj=3 storage=st02adb12
*p85|
さっきまで抱いて抱いてと言っていたクセに、[r]
今度は猛烈に嫌がる彼女に苦笑が漏れてしまう。[np]
*p86|
照れ隠しにしては聞こえが悪すぎる言葉も[r]
彼女らしくて愛らしい。[np]
*p87|
そうだ、こんなに恥ずかしがり屋なのに、[r]
勇気を出して俺を訪ねてくれたんだ。[np]
*p88|
なら、ここからは俺の番だ。[r]
決して柄ではないけれど、俺も勇気を出して莉瑠に応えよう。[np]
@ceff obj=3 storage=st02adb08
*p89|
@nm t="莉瑠" s=rir_10267
「ふ、ふぇっ……！？」[np]
@ceff obj=3 storage=st02adb13
*p90|
扉を押さえていた手を彼女の肩に下ろして、[r]
莉瑠を真っ直ぐ見つめる。[np]
*p91|
そして、そのまま顔をゆっくりと近づけていく。[np]
@ceff_stock obj=2 storage=st02bdb10 path=(647,570,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02bdb14 path=(634,566,255) size=(0.8,0.8) time=250 absolute=(8100)
*p92|
@nm t="莉瑠" s=rir_10268
「っっ」[np]
*p93|
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
*p94|
@nm t="莉瑠" s=rir_10269
「ん……ちゅっ……」[np]
*p95|
柔らかくて甘い感触が唇越しに伝わってくる。[r]
薄目を開けると、驚くくらい近くに彼女の顔があった。[np]
*p96|
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
*p97|
@nm t="莉瑠" s=rir_10270
「……意外と、はぁはぁ。強引、なんですね……？」[np]
@ceff obj=3 storage=st02bdb14 delay=0
*p98|
@nm t="千尋"
「嫌だったかな……？」[np]
@ceff obj=3 storage=st02bdb15
*p99|
@nm t="莉瑠" s=rir_10271
「い……いえ。おかげでちょっぴり落ち着きました……」[np]
@ceff obj=3 storage=st02bdb14
*p100|
莉瑠がキスの感触を確かめるように自分の唇を撫でる。[np]
@ceff_stock obj=2 storage=st02adb06 path=(615,573,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02adb06 path=(605,570,255) time=250
@dceff obj=3 storage=st02adb02 path=(605,570,255) time=250 delay=7840
*p101|
@nm t="莉瑠" s=rir_10295
「でも……えへへ。聖良とキスしてた割には下手くそです。[r]
歯がガツンガツン当たって痛かったですもん」[np]
@ceff obj=3 storage=st02adb17
*p102|
@nm t="莉瑠" s=rir_10273
「最悪の、ふふ。ファーストキスです」[np]
@ceff obj=3 storage=st02adb05
*p103|
笑顔で文句を言ってくる彼女に[r]
ドキドキしてしまう。[np]
*p104|
莉瑠のこういう素直じゃない可愛さが、[r]
俺はどうしようもなく好きみたいだ。[np]
@ceff_stock obj=2 storage=st02bdb15 path=(647,570,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02bdb15 path=(634,566,255) size=(0.8,0.8) time=250 absolute=(8100)
*p105|
@nm t="莉瑠" s=rir_10275
「でも……嬉しいです」[np]
@ceff obj=3 storage=st02bdb02
*p106|
@nm t="莉瑠" s=rir_10277
「私の初めてを、あなたにもらってもらえて……」[np]
@ceff_stock obj=2 storage=st02adb17 path=(615,573,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02adb17 path=(605,570,255) time=250
*p107|
@nm t="莉瑠" s=rir_10278
「最高に……幸せです」[np]
@ceff obj=3 storage=st02adb05
*p108|
照れながらも莉瑠がそう微笑みかけてくれる。[np]
@ceff obj=3 storage=st02adb13
*p109|
@nm t="莉瑠" s=rir_10279
「……他の初めてももらってくれますか？[r]
あなたに……その。もらって欲しいです……」[np]
@ceff_stock obj=2 storage=st02bdb14 path=(647,570,180) time=250 rceil=0 gceil=0 bceil=0 bbx=(10) bby=(10) bbs=true absolute=(8000) mode=pssub anm=false
@ceff obj=3 storage=st02bdb14 path=(634,566,255) size=(0.8,0.8) time=250 absolute=(8100)
*p110|
@nm t="莉瑠" s=rir_10280
「大好きなあなたにもらって欲しいと思って……。[r]
今日はこうしてあなたの部屋に来たんですから……」[np]
*p111|
@nm t="千尋"
「莉瑠……」[np]
@ceff obj=3 storage=st02bdb15
@dceff obj=3 storage=st02bdb02 delay=7200
*p112|
@nm t="莉瑠" s=rir_10296
「……えへへ。聖良とのエッチの成果、見せて下さい。[r]
キスみたいに下手くそなエッチしないで下さいね……？」[np]
@ceff obj=3 storage=st02bdb15
*p113|
@nm t="莉瑠" s=rir_10297
「あなたの初めてを頂けなかった分……、[r]
聖良よりも気持ち良くしてもらわないと割に合わないですから」[np]
@ceff obj=3 storage=st02bdb03
*p114|
冗談めかして言ってくる莉瑠に頷きつつ、[r]
俺はゆっくりと彼女の服へ手を伸ばしていく。[np]
[se storage="衣擦れ(103)" buf=0 delay=0]
@ceff obj=3 storage=st02bdb14
*p115|
@nm t="莉瑠" s=rir_10282
「あ……」[np]
@eff_delete obj=2
@eff_delete obj=3
@extrans time=250
*p116|
莉瑠は恥ずかしそうに息を呑んだものの、[r]
逃げることなく、俺の動きを受け入れてくれた。[np]
*p117|
それどころか俺の服に手を伸ばして、[r]
こちらを脱がそうとしてくれる。[np]
@hide
@eff_all_delete
[se storage="衣擦れ(32)" buf=0 delay=0]
@bg storage=bg_08c st02aba13
@show
*p118|
@nm t="莉瑠" s=rir_10283
「っっ」[np]
*p119|
そうしてお互いに一糸まとわぬ姿になったところで、[r]
俺たちは改めて向かい合った。[np]
@chr st02bba14
*p120|
@nm t="莉瑠" s=rir_10284
「ふ……不思議です。裸見せるの、すごく恥ずかしくて……。[r]
おっぱいもアソコも見せたことあるはずですのに……」[np]
@chr st02bba16
@dchr st02bba09 delay=7123
*p121|
@nm t="莉瑠" s=rir_10285
「身体中熱くて、はぁはぁ、沸騰しちゃいそうです……。[r]
こうして立ってるだけで、頭の中真っ白になってきて……」[np]
@chr st02bba13
*p122|
莉瑠は顔だけじゃなく、全身を仄かに赤らめる。[r]
熱っぽい吐息を漏らしながら、視線を泳がしている。[np]
*p123|
緊張しているのは目に見えてわかった。[r]
そうして意識してくれることがとても嬉しかった。[np]
*p124|
だからこそ、緊張をほぐしてあげたい。[r]
彼女の大切な初めてを嫌な思い出にはしたくないから。[np]
@hide
@white
[se storage="動作_衣擦れ_洋服_09" buf=0 delay=0]
@show
*p125|
@nm t="莉瑠" s=rir_10286
「ふぁ……！？」[np]
*p126|
できる限りそっと彼女をベッドへと寝かせる。[np]
*p127|
そして――[np]
@hide
@white time=2000
@wait time=1000
@jump storage="200_莉瑠初体験_01_h.ks"

; 
; 
*p0|
@bg storage=bg_09c
@bgm storage=bgm_03
@show
@chr_walk way=l st02abh11
*p1|
@nm t="莉瑠" s=rir_11055
「あ～……。もうクタクタですぅ……」[np]
@chr st02abh12
*p2|
@nm t="千尋"
「撮影しないのか？　そのために来たんだろ？」[np]
@chr st02abh08
@dchr st02abh11 delay=2967
*p3|
@nm t="莉瑠" s=rir_11056
「ちょっとは休憩させて下さいよー……。[r]
さっきまでずーっと撮影に応えてたんですから……」[np]
@chr_del_walk way=l name=莉瑠
@wt
[se storage="ベッドに倒れる" buf=0 delay=0]
*p4|
ベッドにボフっと倒れ込む莉瑠。[r]
相当疲れてるみたいだな……。[np]
@hide
@eff obj=0 page=back show=true storage=bg_09c_l path=(1150,290,255) size=(1.5,1.5) time=1 bbx=(1) bby=(1) bbt=true bbs=true absolute=(2000) correct=false
@bg storage=bg_09c st02bah01
@show
@chr st02bah02
@dchr st02bah10 delay=3220
*p5|
@nm t="莉瑠" s=rir_11057
「でもまさかまさかでしたね……。[r]
あんなに大勢の人に声をかけられるなんて……」[np]
@chr st02bah01
*p6|
@nm t="千尋"
「ああ、俺も驚いた」[np]
*p7|
部屋に戻ってくるまでの出来事を思い出す。[np]
*p8|
そう――あれは１、２時間前の話だ。[np]
@fobgm time=2000
@hide
@eff_all_delete
@black rule=rule_spiral07_o_i
@wait time=500
@eff obj=0 page=back show=true storage=al_square_020_c path=(640,360,255) size=(1.1,1.1) time=1 turn=true
@bg storage=bg_02c sepia=true
@wait time=500
@eff_all_delete
@bg storage=bg_02c time=800
@wait time=500
@eff obj=0 page=back show=true storage=bg_02c_l path=(740,50,255) time=1 absolute=(2000)
@bg storage=bg_02c st02abh01
@bgm storage=bgm_04
@show
@chr st02bbh02
*p9|
@nm t="莉瑠" s=rir_11058
「さてさて。どの辺がいいですかね？」[np]
@chr st02bbh01
*p10|
@nm t="千尋"
「ダークネススタイルのリルルなら噴水前……よりは、[r]
ほの暗い街灯の下とかの方が合ってそうだな」[np]
*p11|
実は今日は莉瑠たってのお願いで、[r]
外で撮影をすることになっていたのだが――[np]
@hide
@eff_all_delete
@bg storage=bg_02c
@show
@chr_walk way=l st02abh01
*p12|
@nm t="カメラマン" rt="カメラマンＡ" s=kma_10000
「あ、あの。写真撮らせて頂いてもいいですか？」[np]
@chr st02bbh10
*p13|
@nm t="莉瑠" s=rir_11059
「へ？　もしかして私ですか？」[np]
@chr st02bbh01
*p14|
@nm t="カメラマン" rt="カメラマンＡ" s=kma_10001
「は、はい。なんの作品のキャラクターなのか知らなくて[r]
恐縮なんですけど、か、可愛いなって思って……！」[np]
@chr st02bbh04
@dchr st02abh02 delay=3860
*p15|
@nm t="莉瑠" s=rir_11060
「ふふ、はい。もちろんいいですよ？[r]
ちょっと待ってもらってていいですか、千尋さん？」[np]
@chr st02abh03
*p16|
@nm t="千尋"
「ああ、俺は全然」[np]
*p17|
そうして一人の女性に莉瑠が[r]
話しかけられたことがきっかけだった。[np]
*p18|
@nm t="カメラマン" rt="カメラマンＢ" s=kmb_10000
「わ、私も後でお願いしていいですかっ？[r]
私も作品は知らないんですけど、素敵だなって思ってて……！」[np]
@chr st02bbh10
@dchr st02bbh04 delay=876
*p19|
@nm t="莉瑠" s=rir_11061
「えっ？　はい、もちろん」[np]
@chr st02bbh01
*p20|
@nm t="カメラマン" rt="カメラマンＣ" s=kmc_10000
「すみません、良ければ私にも撮らせて下さいっ……！[r]
この前そのコス姿でお買い物していましたよね？[r]
あの日からずっとあなたのこと探していて……！！」[np]
@chr st02bbh03
[se storage="が_がやざわ10_cut" buf=9]
*p21|
気がつけば俺たちというより、莉瑠の周囲には人が集まっていた。[r]
皆カメラ片手に莉瑠に撮影をお願いしている。[np]
@chr st02bbh11
@dchr st02abh02 delay=6168
*p22|
@nm t="莉瑠" s=rir_11062
「これだけ大勢だと一人ずつ撮影してもらうのは[r]
難しそうですね。すみません、囲みでお願いしまーす」[np]
@fobgm time=2000
[fose buf=9]
@hide
@eff obj=0 page=back show=true storage=st02abh02 path=(592,882.5,255) time=1000 sepia=true anm=false
@eff obj=1 page=back show=true storage=al_square_020_c path=(640,360,255) size=(1.1,1.1) time=1000 turn=true absolute=(15001)
@bg storage=bg_02c sepia=true time=800
@wait time=500
@eff_all_delete
@black rule=rule_spiral07_o_i
[sse buf=9]
@bg storage=bg_09c
@bgm storage=bgm_03
@show
*p23|
とまぁ、そういうことがあって一通り撮影に応えた後、[r]
外での撮影を諦めてホテルに戻ってきた。[np]
@hide
@eff obj=0 page=back show=true storage=bg_09c_l path=(1150,290,255) size=(1.5,1.5) time=1 bbx=(1) bby=(1) bbt=true bbs=true absolute=(2000) correct=false
@bg storage=bg_09c st02aah01
@show
@chr st02aah02
@dchr st02aah07 delay=2620
*p24|
@nm t="莉瑠" s=rir_11063
「でもあれだけ人数がいて、ただの一人も[r]
とろキンを知らないなんて逆にすごいですね」[np]
@chr st02aah03
*p25|
@nm t="千尋"
「いやぁ、そんなもんじゃないか」[np]
*p26|
わざとらしく煽ってくる莉瑠に肩をすくめて応えながら、[r]
俺は疑問に思っていたことを口にする。[np]
*p27|
@nm t="千尋"
「でも良かったのか？　知らない人たちに撮影されて。[r]
エロを読んでることを知られたくなかったんじゃ？」[np]
@chr st02aah02
@dchr st02aah17 delay=4269
*p28|
@nm t="莉瑠" s=rir_11064
「この格好なら身バレはしないでしょうし大丈夫ですよ。[r]
まぁ格好が格好なので普段より恥ずかしくはありましたが……」[np]
@chr st02aah04
*p29|
@nm t="莉瑠" s=rir_11065
「でも、一応私もレイヤーの端くれですから。[r]
わざわざ撮影したいと言ってくれた人を断りはしません」[np]
@chr st02bah02
*p30|
@nm t="莉瑠" s=rir_11066
「しかも作品を知らないのに声をかけてくれましたしね。[r]
普通、中々お願いしにくいものですから」[np]
@chr st02bah03
*p31|
それだけ莉瑠のコスを素晴らしいと、[r]
リルルが可愛いとみんなが思ってくれたということだろう。[np]
*p32|
元々周辺で撮影していた人たちが結構いたからではあるけど、[r]
それが一気に合流して、撮影会イベントみたいになってた。[np]
@chr st02aah07
@dchr st02aah04 delay=2686
*p33|
@nm t="莉瑠" s=rir_11067
「ま、感謝して下さい。私のおかげで[r]
あなたの漫画が世に広まるかもしれませんよ？」[np]
@chr st02aah03
*p34|
冗談めかして莉瑠がそう言ってくる。[r]
実際、俺は莉瑠への感謝で胸がいっぱいだった。[np]
*p35|
莉瑠は撮影後お礼を言いに来てくれた人、一人一人に[r]
リルルやとろキンについて話してくれていたんだ。[np]
*p36|
さっき言っていたが、確かに身バレの可能性が低いとはいえ、[r]
莉瑠にとっては隠しておきたいことのはずなのに……。[np]
*p37|
@nm t="千尋"
「ありがとな」[np]
@chr st02bah14
*p38|
@nm t="莉瑠" s=rir_11068
「～～っっ。改まってお礼を言われるのも、[r]
なんだかむず痒いのですが……」[np]
@chr st02bah08
*p39|
@nm t="莉瑠" s=rir_11069
「べ、別にあなたのためにしたわけじゃないですよ。[r]
単なるオタクの習性です。自分の好きなものを誰かに[r]
共有したい的な、そ、そういうアレです……！」[np]
@chr st02aah15
*p40|
@nm t="莉瑠" s=rir_11070
「私のコスに興味を持ってくれたなら、作品自体にも[r]
興味を持ってくれたらいいなって、そう思っただけですから！」[np]
@chr st02aah09
*p41|
話している間にどんどん早口になっていく莉瑠を見て、[r]
心が温かくなってしまう。[np]
@chr st02aah14
@dchr st02aah08 delay=3471
*p42|
@nm t="莉瑠" s=rir_11071
「～～っっ。な、何をにやけてるんですかっ……！[r]
だからあなたのためじゃありませんってば……！！」[np]
@chr st02aah12
*p43|
@nm t="千尋"
「ふふ、そうだな。でも、ありがとな」[np]
@chr st02aah16
@dchr st02aah14 delay=1969
@dchr st02aah15 delay=3495
*p44|
@nm t="莉瑠" s=rir_11072
「だ、だから――……くぅぅっっ！！[r]
決めました、後でめちゃくちゃ犬扱いしてやります……！」[np]
@chr_del_down name=莉瑠 time=200
[se storage="衣擦れ(19)"]
*p45|
真っ赤になった顔をボフっと枕に埋める莉瑠。[r]
お礼を言われて怒るなんて相変わらず天邪鬼さんだ。[np]
*p46|
そんなことを思いながらベッドに寝転がる莉瑠を見やる。[r]
すると――[np]
@hide
@eff_all_delete
@black rule=rule_03_r_l
@eff obj=1 page=back show=true storage=ev_224a path=(384,216,255) size=(1.4,1.4) time=1 rad=(0,0) clear=true
@ev storage=ev_224a rule=rule_03_r_l
@show
*p47|
@nm t="千尋"
（っっ！！）[np]
*p48|
ストッキング越しのおまんこがお目見えしていた。[r]
チラリズム的に見え方の妙に、思わずガッツポーズしかける。[np]
*p49|
じゃなくて、まさか莉瑠、今日も[r]
このまま撮影していたんじゃ……！？[np]
*p50|
確かに前に市場へ買い物に出た時も履いてなかった。[r]
リルルコスとしては正しい、正しいんだけど……！！[np]
@fobgm time=2000
*p51|
@nm t="莉瑠" s=rir_11073
「ふふ……どこを見てるのかしら？」[np]
*p52|
@nm t="千尋"
「――ハっ！」[np]
@hide
@eff_all_delete
@black rule=rule_03_l_r time=250
@bg storage=bg_09c rule=rule_03_l_r time=250
@show
*p53|
リルル口調でからかうように言われて、[r]
俺は慌てて視線を逸らす。[np]
@hide
@eff obj=0 page=back show=true storage=bg_09c_l path=(1150,290,255) size=(1.5,1.5) time=1 bbx=(1) bby=(1) bbt=true bbs=true absolute=(2000) correct=false
@bg storage=bg_09c
@bgm storage=bgm_05
@show
[se storage="衣擦れ(17)"]
@chr_standup st02aah06
*p54|
@nm t="莉瑠" s=rir_11074
「本当にスケベね？　ワンちゃんは」[np]
@chr st02aah05
*p55|
クスクスと笑いながら莉瑠がベッドから起き上がる。[np]
*p56|
@nm t="千尋"
「ち、違う。そういう目で見ていたわけじゃなくて……！[r]
単にその格好で撮影されて良かったのかと思っただけで」[np]
@chr st02aah07
@dchr st02aah02 delay=3123
*p57|
@nm t="莉瑠" s=rir_11075
「その点は心配しないで。エッチな写真は[r]
絶対に撮られないように気を配っていたから」[np]
@chr st02aah06
@dchr st02aah07 delay=3576
*p58|
@nm t="莉瑠" s=rir_11076
「それにここは天下のコスタリア。[r]
許可なくローアングル撮影なんてした日には[r]
即刻カメラを没収された上で島から追放されるもの」[np]
@chr st02aah03
*p59|
@nm t="千尋"
「そ、そうだったのか……」[np]
@chr st02aah17
@dchr st02aah06 delay=3458
*p60|
@nm t="莉瑠" s=rir_11077
「あら。残念そうね、ワンちゃん。[r]
エロ犬としてはローアングル撮影がしたかったのかしら？」[np]
@chr st02aah05
*p61|
@nm t="千尋"
「ざ、残念がってない！　あとワンちゃん扱いはやめてくれ！[r]
今日はロールプレイしないって話だったじゃないか……！」[np]
@chr st02bah02
*p62|
@nm t="莉瑠" s=rir_11078
「撮影のためのロールプレイよ。[r]
その方が良い写真が撮れるかもしれないじゃない」[np]
@chr st02bah15
@dchr st02bah04 delay=4663
*p63|
@nm t="莉瑠" s=rir_11079
「だから、あなたもワンちゃんになっていいのよ？[r]
ほら……この間のように四つん這いになりなさい？[r]
可愛がってあげるわ」[np]
@chr st02bah05
*p64|
@nm t="千尋"
「だ、だから前のことを蒸し返すのは……！」[np]
*p65|
莉瑠のペットになりたがっていた自分を思い出すだけで、[r]
顔から火が出そうなくらい恥ずかしくなってしまう。[np]
*p66|
リルルに苛められること自体は確かに俺の夢の一つ、[r]
あるいは望みではあったが前回のアレは行き過ぎだ。[np]
*p67|
いや確かに気持ち良かった。興奮もした。[r]
だけど、心までペットにされるような気がして……。[np]
@chr st02aah17
@dchr st02aah06 delay=5626
*p68|
@nm t="莉瑠" s=rir_11080
「照れなくて良いのよ？[r]
聖良にはちゃんと秘密にしてあげているから……。[r]
あなたは……ふふ。私だけのワンちゃんだもの」[np]
@chr st02aah05
*p69|
@nm t="千尋"
「照れてるわけじゃなくて……！[r]
とにかく、撮影するならやってしまおう」[np]
@chr st02aah07
@dchr st02aah02 delay=2586
@dchr st02aah06 delay=5519
*p70|
@nm t="莉瑠" s=rir_11081
「ふふ、そうね。撮影の方が大切かしら。[r]
恥ずかしがっているのに無理強いするのも可愛そうだしね」[np]
@chr st02aah05
*p71|
意外と素直に引き下がる莉瑠。[r]
何かありそうで逆に怖いんだけど……。[np]
@chr st02aah06
@dchr st02aah04 delay=4047
*p72|
@nm t="莉瑠" s=rir_11082
「じゃあ撮影を始めましょうか。[r]
ポーズを取るから、撮ってもらえる？」[np]
@chr st02aah05
*p73|
@nm t="千尋"
「あ、ああ」[np]
[se storage="動_ベッドに" buf=0 delay=0]
@chr_del_down name=莉瑠
*p74|
すると莉瑠は再びベッドに寝転がった。[np]
@fobgm time=3000
@hide
@eff_all_delete
@white time=2000
@wbgm
@wait time=1000
@jump storage="203_莉瑠黒魔_01_h.ks"

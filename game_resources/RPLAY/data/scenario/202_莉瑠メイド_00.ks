; 
; 
*p0|
@eff obj=0 page=back show=true storage=bg_07a_l path=(-150,260,255) size=(4,4) time=1 bbx=(1) bby=(1) bbt=true bbs=true correct=false
@eff obj=1 page=back show=true storage=st01bab04 path=(1007,1329,255) size=(1.2,1.2) time=1 absolute=(15001)
@eff obj=2 page=back show=true storage=st02aab03 path=(215,1178,255) size=(1.2,1.2) time=1 absolute=(15002)
@bg storage=bg_07a
@bgm storage=bgm_03
@show
@ceff obj=1 storage=st01bab05 path=(1007,1329,255) size=(1.2,1.2) time=250 absolute=(15001)
*p1|
@nm t="聖良" s=sei_1748
「お姉ちゃんも、お手伝いする……よ？」[np]
@ceff_stock obj=1 storage=st01bab02 path=(1007,1329,255) size=(1.2,1.2) time=250 absolute=(15001)
@ceff obj=2 storage=st02aab08 path=(215,1178,255) size=(1.2,1.2) time=250 absolute=(15002)
@dceff obj=2 storage=st02aab12 path=(215,1178,255) size=(1.2,1.2) time=250 absolute=(15002) delay=3900
*p2|
@nm t="莉瑠" s=rir_0986
「大丈夫ですってば。これくらい一人でできますから。[r]
んしょっと……」[np]
@hide
@eff_all_delete
@bg storage=bg_07a
@show
[se storage="扉_開き戸_木_019_開け" buf=0 delay=0]
[wait time=200]
*p3|
@nm t="千尋"
[resetwait]
「ん？　
[wait mode=until time=800]
[chr_walk way=r st02aab01]
[mq_small]
――っと！」[np]
@chr st02aab08
*p4|
@nm t="莉瑠" s=rir_0987
「わわっ。す、すみません」[np]
@chr_del_walk way=l name=莉瑠
@wt
[se storage="扉_開き戸_木_019_閉じ" buf=0 delay=0]
*p5|
とある日の朝。リビングを訪れると[r]
俺と入れ替わるように莉瑠が出て行った。[np]
*p6|
@nm t="千尋"
「莉瑠のヤツ、どうかしたのか？[r]
なんだか忙しそうな顔してたけど」[np]
@chr_walk way=r st01abb07 time=400
@wt
@dchr st01bbb07 delay=1356
*p7|
@nm t="聖良" s=sei_1749
「うん……。生徒会の仕事に追われてるみたいで……」[np]
@chr st01bbb01
*p8|
@nm t="千尋"
「生徒会の仕事？」[np]
*p9|
そういえば学園では生徒会長を務めてるとか言ってたな。[r]
疑っていたわけじゃないが本当だったのか。[np]
*p10|
@nm t="千尋"
「でも夏休みだろ？　仕事なんてあるのか？」[np]
@chr st01bbb03
@dchr st01bbb16 delay=5100
*p11|
@nm t="聖良" s=sei_1750
「夏休み明けに学園祭があるらしい、よ？[r]
それ用の資料とか作らなきゃいけないらしく、て」[np]
@chr st01bbb07
@dchr st01bbb01 delay=3416
*p12|
@nm t="聖良" s=sei_1751
「でも話を聞いた感じ、莉瑠ちゃんの悪いクセが出てて……」[np]
*p13|
@nm t="千尋"
「悪い癖？」[np]
@chr st01bbb07
@dchr st01bbb16 delay=9858
*p14|
@nm t="聖良" s=sei_1752
「うん。他の生徒会メンバーたちの仕事も引き受けちゃってる[r]
みたい、なの。自分一人でやった方が早いって言って……」[np]
@chr st01bbb07
@dchr st01abb12 delay=7684
*p15|
@nm t="聖良" s=sei_1753
「莉瑠ちゃん、なんでもかんでも一人でやろうとする[r]
ところがある……から。ああ見えて世話焼きでもある、し」[np]
@chr st01abb02
@dchr st01abb04 delay=6776
@dchr st01abb07 delay=12328
@dchr st01abb13 delay=13780
*p16|
@nm t="聖良" s=sei_1754
「きっと他のみんなに夏休みを満喫してもらおうっていう、[r]
莉瑠ちゃんなりの優しさなんだろうけど……ね？[r]
一人で抱え込みすぎなんじゃないかな、って……」[np]
@chr st01abb07
*p17|
@nm t="千尋"
「ブラック企業で使い潰されるタイプだな……」[np]
@chr st01abb14
@dchr st01abb08 delay=7070
*p18|
@nm t="聖良" s=sei_1755
「だからわたしも手伝えることは手伝おうと思って……。[r]
でも莉瑠ちゃんは一人でやるって聞かなく、て……」[np]
@chr st01abb07
*p19|
甘え下手の莉瑠らしい。[r]
基本的に人に頼ることは嫌いなんだろう。[np]
@chr st01abb02
@dchr st01abb04 delay=4413
@dchr st01abb13 delay=8486
*p20|
@nm t="聖良" s=sei_1756
「昔は『お姉ちゃん、お姉ちゃん』って言って、[r]
なんでもわたしに頼ってきてたのに……寂しいな」[np]
*p21|
@nm t="千尋"
「そうなのか？」[np]
@chr st01bbb07
@dchr st01bbb05 delay=1000
@dchr st01bbb03 delay=2300
@dchr st01bbb05 delay=9500
*p22|
@nm t="聖良" s=sei_1757
「うん。ふふ、莉瑠ちゃんね？[r]
小さい頃は一人でお風呂も入れなかったんだよ？[r]
いつもわたしが一緒に入ってあげてたりして……」[np]
@chr st01bbb07
@dchr st01bbb05 delay=3450 time=400
@dchr st01bbb13 delay=9129
*p23|
@nm t="聖良" s=sei_1758
「出かける時も、寝る時も、ずっとわたしの後ろを[r]
くっついて回ってて……。すっごく甘えんぼさんでね？」[np]
@chr st01bbb02
*p24|
@nm t="千尋"
「へぇ。全然そうは見えないな。[r]
むしろ莉瑠が聖良を連れ回してるイメージだったよ」[np]
@chr st01bbb08
@dchr st01bbb04 delay=6266
@dchr st01bbb12 delay=7278
*p25|
@nm t="聖良" s=sei_1759
「昔はわたしもそれなりに活発だった、から……。[r]
今は、その。見る影もないかもだけど……」[np]
@chr st01bbb10
@dchr st01bbb07 delay=7384
*p26|
@nm t="聖良" s=sei_1760
「一時期は、その。引きこもりぼっちだったし……。[r]
エッチな漫画を読んでることを気持ち悪がられちゃって……」[np]
@chr st01bbb08
@dchr st01bbb17 delay=844
@dchr st01bbb12 delay=6170
@dchr st01bbb07 delay=14582
@dchr st01bbb04 delay=22699
*p27|
@nm t="聖良" s=sei_1761
「あ……直接言われたわけじゃないんだけど、ね？[r]
でも、その。周りの空気感という、か……。[r]
わたし自身、気持ち悪いことなのかなとか悩んだりして……」[np]
*p28|
@nm t="千尋"
「聖良……」[np]
*p29|
その気持ちはよくわかる。[np]
*p30|
俺もエッチな漫画を持ってきてると[r]
学園で吊し上げられたことがあるしな……。[np]
*p31|
親父からも『こんなものを読むな』と言われたし……。[np]
*p32|
理解のない人から見れば[r]
気持ち悪くみられるだろうという自覚もある。[np]
@chr st01bbb12
@dchr st01bbb01 delay=7451
*p33|
@nm t="聖良" s=sei_1762
「莉瑠ちゃんがわたしに甘えなくなったのもその頃から、で。[r]
むしろわたしを引っ張ってくれるようになって……」[np]
@chr st01bbb15 time=400
@dchr st01bbb07 delay=7076 time=600
*p34|
@nm t="聖良" s=sei_1763
「きっとわたしがお姉ちゃんをできなくなったから、[r]
自分がしっかりしなくちゃって思ったんだと思う……」[np]
@chr st01bbb03
@dchr st01bbb04 delay=5535
@dchr st01abb13 delay=7125
*p35|
@nm t="聖良" s=sei_1764
「自立しなくちゃ、みたいな気持ち……かな。[r]
甘えんぼだった莉瑠ちゃんがなんでも一人でやるようになって」[np]
@chr st01abb07
*p36|
聖良が悲しそうな顔をする。[r]
今の莉瑠を作ってしまった責任を感じているのかもしれない。[np]
*p37|
しかし小さい頃の莉瑠が甘えん坊だったとは……。[r]
やっぱり甘えたい願望はあったんだな。[np]
*p38|
たぶん莉瑠が天邪鬼な性格をしているのは、甘えたい願望と[r]
自立しなきゃという想いが交錯しているせいだろう。[np]
@chr st01abb15
@dchr st01abb06 delay=7250
*p39|
@nm t="聖良" s=sei_1765
「だけどたまには甘えてもらいたい、な……。[r]
昔みたいに甘えてくれても構わないのに……」[np]
@chr st01abb12
@dchr st01abb13 delay=5499
*p40|
@nm t="聖良" s=sei_1766
「莉瑠ちゃんを変えちゃったわたしが、その……。[r]
言えることじゃないんだけ、ど……」[np]
@chr st01bbb01
*p41|
聖良が心配そうな顔をする。[np]
*p42|
しかし今の話を聞く限り、[r]
莉瑠は特に聖良を頼りたくないんだろう。[np]
*p43|
いいや心の中では頼りたいとは思っているんだろうが……。[r]
素直じゃないからな、莉瑠は……。[np]
*p44|
@nm t="千尋"
「わかった。俺に任せてくれ。[r]
莉瑠の甘え下手を矯正してみせる」[np]
@chr st01bbb08
@dchr st01bbb16 delay=1514
*p45|
@nm t="聖良" s=sei_1767
「えっ？　何かいい手がある、の……？」[np]
*p46|
@nm t="千尋"
「ああ。それこそロールプレイの出番だ」[np]
@chr st01bbb01
*p47|
本心では甘えたがってることは前回のエッチでも[r]
気づいていたしな。聖良に話を聞いて確信も得た。[np]
*p48|
あとは甘えることを恥ずかしがっている本人の意識を[r]
変えてあげるだけだ――[np]
@fobgm time=2000
@hide
@black time=800
@wbgm
@show
*p49|
………………[np]
*p50|
…………[np]
*p51|
……[np]
@fobgm time=2000
@hide
@white time=1000
@wbgm
@jump storage="202_莉瑠メイド_01_h.ks"

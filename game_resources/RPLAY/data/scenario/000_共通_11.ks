; 
; 
*p0|
@bg storage=bg_08b_l left=-1280 top=-560
@bgm storage=bgm_03
@show
*p1|
@nm t="千尋"
「ふぅ……もうこんな時間か」[np]
*p2|
時計を見て、漫画を描いていた手を止める。[np]
*p3|
このぐらいの時間になっても部屋に籠っていると、[r]
聖良か莉瑠がご飯だと呼びに来てくれる。[np]
*p4|
@nm t="千尋"
「……晩ご飯の時間、か」[np]
*p5|
それが当たり前になっていることに思わず小さな笑みがこぼれた。[np]
*p6|
最初は聖良たちと一緒に食べることも照れ臭かったのに、[r]
今ではすっかり慣れてしまった。[np]
*p7|
それだけ……二人との絆が深まったってことだろうか。[r]
まあ、その……たくさんエッチをして、たくさん愛し合ったし。[np]
*p8|
好き、ということに対して、逃げ腰だった自分は、[r]
二人と過ごした時間で、いい意味で変わることが出来たと思う。[np]
*p9|
自分で思ってたスランプなんてものも、気づけば霧散していた。[r]
まあ、結局、自信を失っていたってことだったんだと思う。[np]
@bg storage=bg_08b
*p10|
@nm t="千尋"
「っと……そろそろリビングに行っとこう。[r]
呼びに来てもらうのも悪いし」[np]
@hide
@black
@show
*p11|
つい物思いにふけってしまっていた自分を振り払って、[r]
大好きな二人がいるリビングへと向かう。[np]
*p12|
そして到着すると――[np]
@hide
@bg storage=bg_07b
@show
*p13|
@nm t="千尋"
「あれ……二人ともどこに行ったんだ？」[np]
*p14|
二人の姿も見当たらない。[r]
食卓には晩ご飯も用意されていないし。[np]
*p15|
出かける時はいつも声をかけてくれるし、[r]
もしかしたら撮影でもしてるのか？[np]
@hide
@black rule=rule_20_r_l
@wait time=500
@bg storage=bg_08b fliplr=true rule=rule_20_r_l
@show
*p16|
@nm t="千尋"
「ここにもいない」[np]
@hide
@black rule=rule_20_l_r
@wait time=500
@bg storage=bg_09c rule=rule_20_l_r
@show
*p17|
@nm t="千尋"
「ここも……」[np]
@hide
@black rule=rule_20_r_l
@wait tiem=500
@bg storage=bg_11a rule=rule_20_r_l
@show
*p18|
@nm t="千尋"
「ここにも……いないか」[np]
*p19|
まさかと思って風呂場にまで来たものの、[r]
二人の姿がどこにも見当たらない。[np]
*p20|
あと探していない部屋と言えば――[np]
*p21|
@nm t="千尋"
「えぇ……いや、まさかね……」[np]
*p22|
一応、確認しに行こう。[r]
流石にいないと思うけど……。[np]
@fobgm time=2000
@hide
@black rule=rule_21_rb_lt
@wbgm
@wait time=500
@show
*p23|
地下への階段をゆっくりと降りる。[np]
*p24|
そして、その先の廊下を進んで、鉄格子をゆっくりと開いた――[np]
@hide
[se storage="扉_引き戸_鉄_201_開け" buf=0 delay=0]
@eff obj=0 page=back show=true storage=sp_bg_10c path=(359,360,255) time=1 fliplr=true absolute=(1500) correct=false
@eff obj=1 page=back show=true storage=sp_bg_10c path=(1385,360,255) time=1 absolute=(1501) correct=false
@eff obj=2 page=back show=true storage=sp_000_共通_03_p473_2 path=(640,360,255) time=1 absolute=(15002) correct=false
@eff obj=3 page=back show=true storage=sp_000_共通_03_p473 path=(640,360,255) time=1 absolute=(15003) correct=false
@eff obj=4 page=back show=true storage=bg_10c path=(640,360,255) time=0 bbx=(5) bby=(5) bbt=true bbs=true absolute=(15004) correct=false alphaeffect=3
@wse buf=0
@bg storage=bg_10c st02bbf07=2.5 st01bbf09=7.5
@show
*p25|
@nm t="聖良" s=sei_10151
「はぁ、はぁ……！　ようやく、んふぅん……！[r]
現れましたわね、魔王……！！」[np]
@chr st02bbf16
*p26|
@nm t="莉瑠" s=rir_10151
「この程度の快感で、ふぁ、あぁ……！[r]
私が堕ちると思ったら大間違いだぞ……！」[np]
@chr st02bbf07
*p27|
@nm t="千尋"
「…………」[np]
*p28|
首枷をつけた聖良と莉瑠が、[r]
火照った表情で俺を見つめてくる。[np]
[se storage="h_ローター_くぐもり_01_loop"]
*p29|
ブブブブブと振動音がするあたり――[r]
ローターかバイブをつけてるんだろう。[np]
[fose buf=0 time=1000]
@chr st01abf13
@dchr st01abf17 delay=4300
*p30|
@nm t="聖良" s=sei_10152
「どうしてもわたくしたちを堕としたいのであれば、[r]
はぁはぁ、その逞しいおちんぽで犯して下さいまし……！」[np]
@chr st02abf15 st01abf13
@dchr st02abf16 delay=5200
*p31|
@nm t="莉瑠" s=rir_10152
「たとえ犯されても、はぁはぁ、堕ちはしないがな……！[r]
貴様のデカチンで、子宮をゴリゴリでもされない限り……！」[np]
@bgm storage=bgm_07
@chr st02abf13
[sse buf=0]
*p32|
@nm t="千尋"
「――さよなら」[np]
[se storage="物_鎖01" buf=0 delay=0]
@chr st02abf14 st01bbf17
@dchr st01bbf10 delay=2600
*p33|
@nm t="聖良" s=sei_10153
「っっ！！？　ちょっ、ちょっと待って……！！[r]
どうして帰ろうとしちゃう、のっ……！！？」[np]
@chr st02bbf09
@dchr st02bbf08 delay=6100
*p34|
@nm t="莉瑠" s=rir_10153
「私たち、はぁはぁ、かれこれ一時間も[r]
こうして待ってたんですよ！？　犯して下さいってば……！！」[np]
@chr st02bbf07
*p35|
@nm t="千尋"
「いや……」[np]
@eff_all_delete
@bg storage=bg_10c
*p36|
ついさっき二人との絆とか、そういうことを[r]
考えていたところだったから……。[np]
*p37|
正直、今じゃない、というか……。[np]
@fobgm time=2000
@hide
@bg storage=bg_10c_l left=0 top=-560
@bgm storage=bgm_05
@show
@chr_walk way=r st01aaf17=8.5,1
@dchr st01baf14 delay=3400
*p38|
@nm t="聖良" s=sei_10154
「魔王しゃまぁ……はぁはぁ、どうかわたくしを犯して、[r]
どうか犯して下さいましぃ……」[np]
@chr st01baf10
@wt
@chr_walk way=r st02baf16=5.2
@dchr st02baf09 delay=6000
*p39|
@nm t="莉瑠" s=rir_10154
「私はもう、はぁはぁ、魔王しゃまの[r]
忠実な性奴隷です……。お、堕ちきってますからぁ……」[np]
@chr st02baf14
*p40|
@nm t="千尋"
「うっ……」[np]
*p41|
気分じゃないのは事実だが、それはそれとして、[r]
こうも色っぽく迫られるとついドキリとしてしまう。[np]
@chr st01aaf09
@dchr st01aaf17 delay=5000
*p44|
@nm t="聖良" s=sei_10155
「はぁはぁ……！　イジワルぅ……！[r]
あなたがわたしたちを、こんなにしちゃったのに……」[np]
@chr st02baf09 st01aaf13
@dchr st02aaf13 delay=5600
*p45|
@nm t="莉瑠" s=rir_10155
「そうですよ、はぁはぁ……！　あなたのせいで私、[r]
マゾの扉開けちゃったんですからぁ……！」[np]
*p46|
二人が口々に「犯して」と懇願してくる。[r]
晩ご飯時に、なぜこういうことになっているのか、[r]
正直、教えて欲しいんだけど……。[np]
@chr st01aaf09
@dchr st01aaf08 delay=1700
@dchr st01aaf17 delay=4600
*p47|
@nm t="聖良" s=sei_10156
「こんなこと、はぁはぁ、性奴隷にしてなんてこと、[r]
大好きなあなたにしか頼めない、よ？」[np]
@chr st02aaf18 st01aaf13
@dchr st02aaf12 delay=1900
@dchr st02aaf13 delay=7000
*p48|
@nm t="莉瑠" s=rir_10156
「そう、ですよ。私たちだって、[r]
奴隷になる相手くらい、はぁはぁ、選びます」[np]
@chr st01baf14
@dchr st01baf10 delay=4700
*p49|
@nm t="聖良" s=sei_10157
「いいじゃない。これもロールプレイなんだから……。[r]
あなたに、はぁはぁ、あなたに酷いコトされたいの……」[np]
@chr st02aaf17
@dchr st02baf15 delay=7800
*p50|
@nm t="莉瑠" s=rir_10157
「大好きなあなたに、ふ、ふへへ、モノみたいに[r]
扱われたいんです……。身体中メチャクチャにされたい……」[np]
@chr st02baf14
*p51|
二人が俺への好意を口にしながら、[r]
その口でそのまま犯してと懇願してくる。[np]
*p52|
……もしかすると、これもまた[r]
絆が深くなったからこそなのかもしれない。[np]
*p53|
遠慮なく、したいことを言える、というのは、[r]
きっと、お互いへの信頼とか愛情があるからこそだ。[np]
*p53a|
だったら、ここまで準備をしていた二人に、[r]
俺も日頃の感謝と愛を込めて、応えるべきかもしれない。[np]
*p53b|
ぶっちゃけ、その気はなかったが、目の前で好きな女の子が二人、[r]
いやらしい恰好で、お尻フリフリおねだりしてきたら、[r]
ムラムラしちゃってもしょうがないだろう。[np]
*p54|
@nm t="千尋"
「……よし」[np]
*p54a|
@nm t="千尋"
「……二人ともケツをこちらに向けるんだ」[np]
@chr st02baf05 st01baf11
@dchr st01aaf12 delay=800
@dchr st01aaf18 delay=2400
*p55|
@nm t="聖良" s=sei_10158
「～～っっ！　は、はい、魔王しゃまぁ……！！」[np]
@chr_del_down name=聖良
@wt
@wm
@chr st02baf15
@dchr st02aaf17 delay=2800
*p56|
@nm t="莉瑠" s=rir_10158
「え、えへへぇ……。どうぞ、はぁはぁ、お使い下さい」[np]
@chr_del_down name=莉瑠
@wt
@wm
@bg storage=bg_10c
*p57|
竿役魔王になりきって命令すると、二人は驚くほど従順に[r]
四つん這いになってお尻を突き出してくる。[np]
*p58|
まずは、何も言わずにこんなことをしていた罰に、[r]
お尻叩きをしてあげなくては――[np]
@hide
@bg storage=bg_01b
@show
[se storage="h_叩く_お尻_06" buf=0 delay=0]
[se storage="人の行動2_叩く_se2217" buf=1 delay=0]
*p61|
@nm t="聖良・莉瑠" rt="聖良・莉瑠" s=gou_10007
「「んひぃぃぃいいいいんんんっっ～～♪♪♪」」[np]
*p62|
お尻をパッチーンと叩かれた二人が、[r]
歓喜の嬌声を上げる。[np]
*p63|
……まあ、たまにはこんな日もあっていいのかもしれない。[np]
@fobgm time=3000
@hide
@black time=2000
@wbgm
@wait time=1000
@jump storage="選択画面.ks" target="*common_return"

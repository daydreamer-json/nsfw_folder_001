; 
; 
*p0|
@bg storage=bg_12a
@bgm storage=bgm_04
@show
@chr_walk way=l st02ace02=1.6
*p1|
@nm t="莉瑠" s=rir_10115
「聖良～！　いきましたよ～！」[np]
@chr st02bce01
@wt
@chr_walk way=r st01ace09=8.4
@dchr st01bce11 delay=1000
@dchr st01bce06 delay=2700
@dchr st01ace09 delay=3300
*p2|
@nm t="聖良" s=sei_10116
「う、うーんっ！　あわわっ……！[r]
いったよ、千尋くーんっ」[np]
@chr st01ace14
*p3|
@nm t="千尋"
「…………」[np]
@chr st02bce10 st01ace16
@dchr st01bce17 delay=1200
*p4|
@nm t="聖良" s=sei_10117
「あ、えっと、千尋くーんっ！」[np]
*p5|
@nm t="千尋"
「――ハっ！？　うわっ！？」[np]
[se storage="物_ビーチボールトス02"]
@q_small
@black time=200 rule=rule_70_i_o
@bg storage=bg_01a time=200 rule=rule_70_i_o
*p6|
不意に顔にビーチボールが飛んできて、[r]
思わず尻餅をついてしまう。[np]
*p7|
するとすぐさま聖良と莉瑠が駆け寄ってきた。[np]
@eff obj=0 page=back show=true storage=st02bae11 path=(257.5,1400.5,255) time=1 anm=false sub=true
@eff obj=1 page=back show=true storage=st02bae11 path=(257.5,1400.5,100) time=1 rgamma=0 ggamma=0 bgamma=0 bbx=(10) bby=(10) bbt=true bbe=true bbs=true absolute=(15001) anm=false alphaeffect=0
@eff obj=2 page=back show=true storage=st02bae11 path=(257.5,1414,120) time=1 bbx=(20) bby=(20) bbt=true bbs=true absolute=(15002) mode=psdodge5 anm=false alphaeffect=0 alphaturn=true acb=true a_r=255 a_g=255 a_b=255 a_r2=255 a_g2=255 a_b2=255
@eff obj=6 page=back show=true storage=st01bae07 path=(1025.5,1522,255) time=1 absolute=(15006) anm=false sub=true
@eff obj=7 page=back show=true storage=st01bae07 path=(1028,1538,100) time=1 rgamma=0 ggamma=0 bgamma=0 bbx=(10) bby=(10) bbt=true bbe=true bbs=true absolute=(15007) anm=false alphaeffect=6
@eff obj=8 page=back show=true storage=st01bae07 path=(1022,1540,200) time=1 bbx=(20) bby=(20) bbt=true bbs=true absolute=(15008) mode=psdodge5 anm=false alphaeffect=6 alphaturn=true acb=true a_r=255 a_g=255 a_b=255 a_r2=255 a_g2=255 a_b2=255
@bg storage=bg_01a st02bae11=2,1 st01bae17=8
@dchr st01bae07 delay=1800
*p8|
@nm t="聖良" s=sei_10118
「大丈夫……？　お顔に思いっきり当たってた、けど……」[np]
@eff_delete obj=0
@eff_delete obj=1
@eff_delete obj=2
@eff obj=3 page=back show=true storage=st02aae12 path=(171,1413.5,255) time=1 absolute=(15003) anm=false sub=true
@eff obj=4 page=back show=true storage=st02aae12 path=(172,1413,100) time=1 rgamma=0 ggamma=0 bgamma=0 bbx=(10) bby=(10) bbt=true bbe=true bbs=true absolute=(15004) anm=false alphaeffect=3
@eff obj=5 page=back show=true storage=st02aae12 path=(172,1447,120) time=1 bbx=(20) bby=(20) bbt=true bbs=true absolute=(15005) mode=psdodge5 anm=false alphaeffect=3 alphaturn=true acb=true a_r=255 a_g=255 a_b=255 a_r2=255 a_g2=255 a_b2=255
@chr st02aae11
@wt
@dchr st02aae12 delay=1900
*p9|
@nm t="莉瑠" s=rir_10116
「鈍臭いですね。聖良のボールも取れないなんて」[np]
*p10|
@nm t="千尋"
「っ……大丈夫だ、ちょっとぼーっとしてて」[np]
@chr st02aae09
@dchr st02aae11 delay=1900
@dchr st02aae15 delay=6000
*p11|
@nm t="莉瑠" s=rir_10117
「……その反応。大方、私たちのおっぱいの揺れでも[r]
凝視してましたね……。この変態」[np]
@chr st01bae16
*p12|
@nm t="千尋"
「うっ……！！」[np]
@chr st01bae08
@dchr st01bae12 delay=2100
@dchr st01bae07 delay=4900
*p13|
@nm t="聖良" s=sei_10119
「そ、なの……？　別に見てもいいけど……。[r]
あんまりブルンブルンしてたら恥ずかしい、な……」[np]
*p14|
@nm t="千尋"
「いや、そう思うなら、そもそもそのコスで[r]
ビーチバレーなんてするべきじゃないって」[np]
@hide
@eff_all_delete
@black rule=rule_00_t_b
@bg storage=bg_12a rule=rule_00_t_b
@show
@chr_standup st02abe09=2.5 st01bbe07=7.5,1
@dchr st01bbe12 delay=1800
*p15|
@nm t="聖良" s=sei_10120
「だってわたし、水着これしか持ってない……し」[np]
@chr st02abe11
@dchr st02bbe02 delay=4000
*p16|
@nm t="莉瑠" s=rir_10118
「コスしないで水着だけ着てたら変態ですしね。[r]
それにこの姿ならスタジオで遊んでても撮影だと思われますし」[np]
@chr st02bbe01
*p17|
@nm t="千尋"
「……まぁ、二人がそれでいいのならいいけど……」[np]
*p18|
スタジオに居ても結構ヤバめだとは思うが言うまい。[r]
正直に言って、眼福であることに違いはない。[np]
*p19|
ブルンと揺れるおっぱい、弾ける汗――抜けるような空。[r]
現実の、こんな空の下で、俺が楽しめると夢にも思わなかった。[np]
*p20|
まあ、惜しむらくは二人ともロールプレイを[r]
するつもりが一切ないというところぐらいかな。[np]
*p21|
何せ、今日は単にビーチへ遊びに来ただけだしな。[np]
@chr st02abe01
@dchr st02abe02 delay=1100
*p23|
@nm t="莉瑠" s=rir_10119
「あ……。ちょっと日焼け止め切れたので買ってきますね」[np]
@chr st02abe01 st01abe17
*p24|
@nm t="聖良" s=sei_10121
「一人で大丈夫……？」[np]
@chr st02abe08 st01abe07
@dchr st02abe11 delay=2800
*p25|
@nm t="莉瑠" s=rir_10120
「どの口が言うんですか、どの口が。[r]
聖良よりはよっぽど大丈夫ですよ」[np]
@chr st02abe09
@wt
@chr_del_walk way=l name=莉瑠
@wt
@wm
@chr st01abe15
*p26|
そう言って莉瑠がビーチスタジオの奥にある[r]
海の家へと歩いて行く。すると――[np]
@chr_del name=聖良
@wt
@wait time=200
[se storage="衣擦れ(100)" buf=0 delay=0]
@q_small
@chr st01bde04
*p27|
@nm t="聖良" s=sei_10122
「ぎゅっ～～」[np]
*p28|
@nm t="千尋"
「ふぁ！？　せ、せせ、聖良……！？[r]
何を急に、抱きついて……！？」[np]
@chr st01bde10
@dchr st01bde18 delay=3500
@dchr st01bde13 delay=7300
*p30|
@nm t="聖良" s=sei_10124
「ずっとタイミング狙ってたの……。[r]
んっ……ちゅっ。二人でイチャイチャする、タイミング」[np]
@chr st01bde02
*p31|
熱っぽい瞳で見上げながら聖良が唇を奪ってくる。[np]
@chr st01ade13
@dchr st01ade12 delay=6000
*p32|
@nm t="聖良" s=sei_10125
「莉瑠ちゃんが帰ってくるまでの、はぁはぁ、[r]
少しの時間でいいからイチャイチャしない？」[np]
@chr st01ade13
*p34|
すると聖良はセーラのように明るく弾むように、[r]
ぎゅっと強くさらに抱きついてきて――[np]
@chr st01ade06
@dchr st01ade02 delay=3500
@dchr st01ade04 delay=6100
*p36|
@nm t="聖良" s=sei_10128
「ほーらぁ、おっぱい揉んで？[r]
お姉ちゃんのおっぱい大好きでしょ？」[np]
@chr st01ade03
*p37|
@nm t="千尋"
「っ……せ、聖良っ……！！」[np]
@chr st01ade17
@dchr st01ade12 delay=1300
*p38|
@nm t="聖良" s=sei_10129
「あぁあんっ♪　ふふ、揉みすぎぃっ♪[r]
莉瑠ちゃんにまで、はぁんっ、お姉ちゃんの声届いちゃう♪」[np]
@chr st01ade13
*p51|
ヤバい、可愛い……！[r]
二人きりでロールプレイしている時と同じようにデレデレだ。[np]
@chr_walk way=l st02abe09=1.55
*p56|
@nm t="莉瑠" s=rir_10121
「……なに抱きついてるんですか、二人とも」[np]
@q_small
@chr st01aae16=6 time=200
@dchr st01aae17 delay=2500
*p57|
@nm t="聖良" s=sei_10139
「～～っっ！！？　りりり、莉瑠ちゃん……！！！[r]
も、もう戻ってきた、のっ……！？」[np]
@chr st02abe11 st01aae07
*p58|
莉瑠に声をかけられた瞬間、聖良がバっと離れる。[np]
@chr st02abe09
@dchr st02bbe11 delay=3300
*p59|
@nm t="莉瑠" s=rir_10122
「日焼け止め買いに行っただけですから。[r]
というかなんですか慌てて……」[np]
@chr st01aae09
@dchr st01aae12 delay=2000
@dchr st01aae08 delay=5900
*p60|
@nm t="聖良" s=sei_10140
「な、なんでもないよ？　それよりわたし、[r]
ちょっとお花摘んでくる、ね？」[np]
@chr_del_walk way=l name=聖良 time=200
@wt
@wm
@chr st02bbe13
*p61|
聖良がそそくさとトイレへ向かって歩いて行く。[np]
@chr_del name=莉瑠
@wt
@wm
@wait time=200
[se storage="衣擦れ(100)" buf=0 delay=0]
@q_small
@chr st02bde14
@dchr st02bde05 delay=1000
*p64|
@nm t="莉瑠" s=rir_10123
「ぎゅ――ぎゅぅぅ～～……！！」[np]
*p65|
@nm t="千尋"
「おわっ！！？　り、莉瑠……！！？[r]
お前まで何を抱きついてきて……！！？」[np]
@chr st02bde11
@dchr st02bde14 delay=2600
*p66|
@nm t="莉瑠" s=rir_10124
「お前までってことは……。[r]
やっぱり私がいない間にイチャイチャしてたんですね？」[np]
*p67|
@nm t="千尋"
「――ハっ！」[np]
@chr st02ade13
@dchr st02ade12 delay=3700
@dchr st02ade08 delay=5900
@dchr st02ade13 delay=8800
*p68|
@nm t="莉瑠" s=rir_10125
「ず、ずるいですよ、聖良だけ。私だって、その。[r]
このコスしてると、つい、だから、その……」[np]
@chr st02bde09
@dchr st02bde14 delay=2200
*p69|
@nm t="莉瑠" s=rir_10126
「お兄ちゃんに、甘えたくなるのに……」[np]
*p70|
寂しげな顔で莉瑠が見上げてくる。[r]
これはずるい――[np]
*p71|
@nm t="千尋"
「悪かった……ごめん！！」[np]
[se storage="人の行動2_抱く_se2528"]
@chr_quake name="莉瑠" sx=3 xcnt=2 sy=3 ycnt=3 time=300 loop=false fade=false delay=0
@chr st02bde15
@dchr st02ade17 delay=2500
*p72|
@nm t="莉瑠" s=rir_10127
「ふぁぁぁ……！！[r]
ううん、抱きしめてもらうの気持ちいい……」[np]
@chr st02ade13
@dchr st02ade17 delay=4600
*p73|
@nm t="莉瑠" s=rir_10128
「お兄ちゃん……好き。好きだよ……？[r]
莉瑠もお兄ちゃんこと、好きだからね……？」[np]
@chr st02ade03
*p74|
@nm t="千尋"
「ああ……！！」[np]
@chr st02bde01
@dchr st02bde17 delay=1600
*p75|
@nm t="莉瑠" s=rir_10129
「えへへ……んちゅっ。ちゅぁ、ちゅちゅっ……」[np]
@chr st02bde14
*p76|
@nm t="莉瑠" s=rir_10130
「んはぁむっ、れろぉ、れろろぉ……んっ、んんっ！」[np]
*p77|
おもむろに唇を重ねてきた莉瑠にキスし返す。[r]
口蓋を軽くくすぐってあげると気持ちよさそうに震えた。[np]
*p80|
この甘えんぼな莉瑠……！[r]
可愛すぎるぞっ……！！[np]
@chr_walk way=l st01bce06=1
@dchr st01ace10 st02bde11 delay=3800
*p99|
@nm t="聖良" s=sei_10141
「む……。仲良し、だね？　二人とも……」[np]
@q_small
@chr st02bbe10=3,1
@dchr st02bbe09 delay=2300
*p100|
@nm t="莉瑠" s=rir_10141
「～～っっ！！？　せせせ、聖良っ……！！？[r]
いいい、いつ戻ってきたんですか……！！？」[np]
@chr st02bbe13
@wt
@chr_del_walk way=r name=聖良
*p101|
先程の再現のように莉瑠が唐突に素に戻って、[r]
大慌てで俺から離れる。[np]
@chr_walk way=l st01bbe06=7
@dchr st01bbe10 delay=2700
*p107|
@nm t="聖良" s=sei_10144
「それよりズルいよ、莉瑠ちゃん……！[r]
わたしがいない間にイチャイチャ、して……」[np]
@chr st02bbe09
@dchr st02bbe08 st01bbe12 delay=3400
*p108|
@nm t="莉瑠" s=rir_10144
「先にイチャイチャしてたのは聖良の方じゃないですか……！[r]
これでイーブンですよ、イーブン……！！」[np]
@chr st02bbe07 st01abe09
@dchr st01abe08 delay=4600
@dchr st01abe17 delay=7700
*p109|
@nm t="聖良" s=sei_10145
「イーブンって言われても納得できない、もん……。[r]
わたし、わざわざ身体の火照り、取りに行ってたのに……」[np]
@chr st02abe12 st01abe07
@dchr st02abe13 delay=3300
*p110|
@nm t="莉瑠" s=rir_10145
「そんなこと言ったら私なんて、[r]
今まさに、はぁはぁ、火照ってるところで……」[np]
*p111|
火照り顔で言い争っていた二人が不意に押し黙る。[np]
@chr st01abe10
*p112|
@nm t="聖良" s=sei_10146
「なら……いっそ」[np]
@chr st02abe12
@dchr st02bbe14 delay=2700
*p113|
@nm t="莉瑠" s=rir_10146
「そうですね……いっそ」[np]
@chr st01bbe10
*p114|
二人が俺をじっと見つめてくる。[np]
@chr st01bbe14
@dchr st01bbe13 delay=2800
*p115|
@nm t="聖良" s=sei_10147
「三人で、はぁはぁ、イチャイチャしちゃお？」[np]
@chr st02bbe15 st01bbe10
*p116|
@nm t="莉瑠" s=rir_10147
「いいでしょ、お兄ちゃん？」[np]
*p119|
二人が猫撫で声で甘えてくる。[np]
@chr_del name=聖良莉瑠
@wt
@wait time=200
@chr st02bde14=1.5,1 st01bde10=8.5
*p120|
そのままわざとらしく二人して胸を押し当ててきながら、[r]
上目遣いに俺を見つめると――[np]
@chr st02ade13 st01ade13
*p123|
@nm t="聖良・莉瑠" rt="聖良・莉瑠" s=gou_10005
「「だめ……？」」[np]
*p124|
@nm t="千尋"
「っ……ダ、ダメなわけないさ……！！」[np]
@hide
@q_small
[se storage="足_砂に座る (2)" buf=0 delay=0]
@bg storage=bg_01a
@show
*p127|
@nm t="聖良・莉瑠" rt="聖良・莉瑠" s=gou_10006
「「きゃっ♪」」[np]
*p129|
まったく――最高の夏だ。[np]
@fobgm time=3000
@hide
@black time=2000
@wbgm
@wait time=1000
@jump storage="選択画面.ks" target="*common_return"

; 
; 
*p0|
@bg storage=bg_11a
@bgm storage=bgm_08
@wait time=1000
@eff obj=0 page=back show=true storage=bg_11a_l path=(890,-320,255) size=(2.5,2.5) time=1 absolute=1500
[se storage="H_風呂22" buf=0 delay=0]
@bg storage=bg_11a
@show
*p1|
@nm t="千尋"
「ふぅ……何度入ってもここの風呂は極楽だ……」[np]
*p2|
広々としたこの広さ、もうほぼプールだもんな。[r]
アパートの小さな浴槽には戻れないかもしれない。[np]
*p3|
@nm t="千尋"
「今更だけど……聖良と莉瑠には本当に感謝しないと。[r]
こんなＶＩＰハウスに俺まで泊めてくれて……」[np]
@chr_walk way=r st01abc03=7.5
@dchr st01abc02 delay=1600
@dchr st01abc06 delay=7900
*p4|
@nm t="聖良" s=sei_10085
「えへへ、気にしないでいいよ……？[r]
わたしたちも千尋くんがいてくれて嬉しいから」[np]
@chr st01abc05
@wt
@chr_walk way=l st02abc12=2.5
@dchr st02abc11 delay=1900
@dchr st02abc15 delay=4300
*p5|
@nm t="莉瑠" s=rir_10083
「ま……まぁ。嬉しいとまでは言いませんが。[r]
別に感謝されるほどのものじゃありません」[np]
*p6|
@nm t="千尋"
「そうか……って！？」[np]
@chr st02bbc13 st01abc03
@dchr st01abc06 delay=1600
@dchr st01abc04 delay=3500
*p7|
@nm t="聖良" s=sei_10086
「ふふ。二人で背中流しにきちゃった」[np]
@chr st02bbc09 st01abc03
@dchr st02bbc14 delay=3900
*p8|
@nm t="莉瑠" s=rir_10084
「わ、私は聖良に無理やり連れてこられただけですよっ。[r]
自分の意思じゃありませんからっ……！！」[np]
@chr st02bbc13
*p9|
@nm t="千尋"
「なっ、なな！！？」[np]
*p10|
二人が風呂場にいることは勿論、その姿にも驚いてしまう。[r]
というか背中を流しにきたって……！！[np]
@chr st01abc13
@dchr st01bbc07 delay=2400
@dchr st01bbc10 delay=5700
*p11|
@nm t="聖良" s=sei_10087
「最近……その。疲れてる、でしょ？[r]
お顔見てて思ったから……」[np]
@chr st01bbc15
@dchr st01bbc03 delay=1600
@dchr st01bbc13 delay=4500
*p12|
@nm t="聖良" s=sei_10088
「だから今日はセーラとリルルになりきって、[r]
めいっぱい甘えさせてあげようと思って」[np]
@chr st02abc12 st01bbc02
@dchr st02abc13 delay=2700
*p13|
@nm t="莉瑠" s=rir_10085
「あんまり体調悪そうにされても、[r]
私たちも迷惑ですからね……」[np]
@chr st02abc12
@dchr st02abc11 delay=2900
@dchr st02abc08 delay=4500
*p14|
@nm t="莉瑠" s=rir_10086
「こんなことで癒されるのでしたら、まぁ……。[r]
やってあげてもいいってだけの話です」[np]
@chr st02abc13 st01bbc05
@dchr st01bbc03 delay=2900
@dchr st01bbc13 delay=7000
*p15|
@nm t="聖良" s=sei_10089
「こう言ってるけど、ね？　提案したら、[r]
莉瑠ちゃんも二つ返事で頷いてくれてたんだよ？」[np]
@chr st02abc14 st01bbc02
@dchr st02bbc09 delay=1200
*p16|
@nm t="莉瑠" s=rir_10087
「～～っっ！　余計なこと言わないで下さい……！！」[np]
@chr st02bbc13 st01bbc04
@dchr st01bbc13 delay=1400
@dchr st01bbc05 delay=5200
*p17|
@nm t="聖良" s=sei_10090
「ふふ。そういうことだから、ほら……こっち来て？」[np]
@chr st02bbc14
@wt
@chr_del name=聖良莉瑠 time=300
*p18|
@nm t="千尋"
「わわっ」[np]
[se storage="液体_風呂26"]
*p19|
二人が俺の手を取って、湯船から優しく引き上げてくれる。[np]
@eff_all_delete
@bg storage=bg_11a
*p20|
そしておもむろに着衣を脱ぐと、[r]
ボディーソープを自分たちの身体にかけて泡立てて――[np]
@chr_standup st01abd06=7,1
@dchr st01abd05 delay=1300
@dchr st01abd13 delay=3700
@dchr st01bbd13 delay=7600
*p21|
@nm t="聖良" s=sei_10091
「そのまま、ん……はぁ。じっとしていて下さいね？[r]
リルルと二人で……ん、はぁ、お身体綺麗に致しますから」[np]
@chr st01bbd02
@wt
@chr_standup st02bbd15=3
@dchr st02bbd13 delay=4000
@dchr st02bbd14 delay=5600
@dchr st02bbd15 delay=8800
*p22|
@nm t="莉瑠" s=rir_10088
「わ、私たちのおっぱいブラシで……その。[r]
たっぷりたっぷり洗ってやるから。な……？」[np]
@chr st02bbd01
*p23|
@nm t="千尋"
「～～っっ！！」[np]
@chr_del name=聖良莉瑠
@wt
@chr st02bad14=2 st01aad05=8,1
*p24|
俺の身体を挟んで聖良と莉瑠が手を繋ぎ、[r]
前後からむぎゅうっとおっぱいを押しつけてくれる。[np]
*p25|
おっぱいブラシ、なんて甘美な感覚なんだ……！！[np]
@chr st01aad06
@dchr st01bad13 delay=7100
*p26|
@nm t="聖良" s=sei_10092
「ふふ。心地よさそうなお顔して下さって嬉しい……。[r]
どうぞ身体の力を抜いて、リラックスして下さいね……？」[np]
@chr st02bad15 st01bad02
@dchr st02bad13 delay=2200
@dchr st02aad17 delay=4000
@dchr st02aad02 delay=7600
@dchr st02aad04 delay=11100
*p27|
@nm t="莉瑠" s=rir_10089
「全身くまなく、ん、はぁ……私たちのおっぱいで[r]
洗ってあげるから。しっかり疲れ、んん、取るんだぞ？」[np]
@chr st02aad03
*p28|
言われるまでもなく心地よさと安心感で、[r]
身体の力が抜けていく。[np]
*p29|
まさに聖女のご奉仕……！[r]
全身から疲れが抜け落ちていくようだ……！！[np]
@chr st01bdd13
@dchr st01bdd18 delay=2300
@dchr st01add12 delay=11200
*p30|
@nm t="聖良" s=sei_10093
「お口の中も……んちゅ、れろろぉ……。[r]
わたしたちのベロで洗って差し上げます、ね？」[np]
@chr st02add17 st01add18
@dchr st02bdd18 delay=2700
@dchr st02bdd15 delay=7800
*p31|
@nm t="莉瑠" s=rir_10090
「耳の中も……はむぅん、んっ、れろれろぉ。[r]
キレイにしてあげる、な……？」[np]
@chr st02bdd17
*p32|
まるで夢のようなご奉仕に、うっとりとした息が漏れていく。[np]
@chr st01add06
@dchr st01add05 delay=4000
@dchr st01add12 delay=6600
*p35|
@nm t="聖良" s=sei_10094
「癒やされたい時や甘えたい時は、ん……はぁ。[r]
いつでも言って下さいね……？」[np]
@chr st02bdd14 st01add05
@dchr st02bdd13 delay=4100
@dchr st02bdd14 delay=6700
*p36|
@nm t="莉瑠" s=rir_10091
「無茶なお願いじゃなければ、その。[r]
叶えて、ちゅっ……んっ、あげるからさ……」[np]
*p37|
全身を使って献身的に奉仕してくれながら、[r]
二人が優しい微笑を浮かべて見つめてくる。[np]
@chr st02bdd15 st01add12
*p40|
@nm t="聖良・莉瑠" rt="聖良・莉瑠" s=gou_10004
@overlap_ch txt1="「私たちに好きなだけ甘えて下さい」" txt2="「私たちに好きなだけ甘えていいぞ」"
[np]
@fobgm time=3000
@hide
@black time=2000
@wbgm
@wait time=1000
@jump storage="選択画面.ks" target="*common_return"

; 
; 
*p0|
@eff obj=0 page=back show=true storage=al_square_020_c path=(640,360,255) time=1 sub=true
@eff obj=1 page=back show=true storage=loop_mist_white2 path=(1280,360,255)(640,360,230)(+0.0,360,255) size=(1,1.1,1) time=8000 loop=true gceil=230 bceil=230 absolute=(15001) alphaeffect=0
@eff obj=2 page=back show=true storage=loop_mist_white2 path=(0,360,128)(640,360,255)(1280,360,128) time=12000 gceil=220 bceil=220 flipud=true absolute=(15002) alphaeffect=0
@white
@show
*p1|
@nm t="？？？" rt="聖良" s=sei_10986
「ちゅっ……、んっ、ちゅっ、ちゅちゅ」[np]
*p2|
@nm t="千尋"
「ん……んん」[np]
*p3|
心地良い微睡みの中――[r]
柔らかくて温かい感触が何度も唇に触れてくる。[np]
*p4|
なんだこれ……気持ちいい……。[np]
*p5|
@nm t="？？？" rt="聖良" s=sei_10987
「ちゅ、んふ……主くんの寝顔、とっても可愛い。[r]
はぁはぁ、このまま、ちゅぁむ、食べちゃいたいくらい……」[np]
*p6|
@nm t="？？？" rt="聖良" s=sei_10988
「んはぁむっ……れろ、れろろぉ……」[np]
*p7|
@nm t="千尋"
「っ……！！？」[np]
*p8|
不意に口の中に熱くてトロトロなものが入ってくる。[np]
*p9|
まさかこれは――[np]
@hide
@eff_delete obj=0
@eff_delete obj=1
@eff_delete obj=2
@eff obj=3 page=back show=true storage=sp_bg_08a_ぼかし path=(640,360,255) size=(1,1) time=1 absolute=(2000)
@eff obj=4 page=back show=true storage=st01bde18 path=(644,612,255) time=1 anm=false sub=true absolute=15000
@eff obj=5 page=back show=true storage=st01bde18 path=(644,612,150) time=1 rgamma=0 ggamma=0 bgamma=0 bbx=(20) bby=(20) bbt=true bbe=true bbs=true absolute=(15001) anm=false alphaeffect=4
@eff obj=6 page=back show=true storage=st01bde18 path=(659,626,255) size=(0.98,0.98) time=1 bbx=(30) bby=(30) bbt=true bbe=true bbs=true absolute=(15002) mode=psdodge5 anm=false alphaeffect=4 alphaturn=true acb=true a_r=255 a_g=255 a_b=255 a_r2=255 a_g2=255 a_b2=255
@bg storage=bg_08a st01bde18 rule=rule_tv00_i_o_tb time=800
@bgm storage=bgm_10
@show
*p10|
@nm t="聖良" s=sei_10989
「れろろぉ……ちゅぁっ、ちゅぷぷ――れろれろれろぉ」[np]
*p11|
@nm t="千尋"
「ん゛んっっ！！？」[np]
*p12|
目に飛び込んできたのは聖良のキス顔とコス姿で、[r]
理解が追い付かず、頭の中が真っ白になる。[np]
*p13|
俺は聖良にぎゅっと抱きしめられながら、[r]
めいっぱいキスをされていた。[np]
@hide
@eff_all_delete
@eff obj=0 page=back show=true storage=bg_08a_l path=(-770,170,255) size=(2,2) time=1 absolute=(2000) bbx=(1) bby=(1) bbt=true bbs=true
@bg storage=bg_08a
@show
@chr_standup st01bae15
@dchr st01bae05 delay=1084
*p14|
@nm t="聖良" s=sei_10990
「ぷはぁ、えへへ、おはよう主くん」[np]
@chr st01bae04
*p15|
@nm t="千尋"
「お、おはよう主くん？　じゃなくて！[r]
一体これはどういう状況……！？」[np]
@chr st01bae08
@dchr st01bae13 delay=3017
*p16|
@nm t="聖良" s=sei_10991
「どういう状況って、えへへ。朝起こしに来たら主くんが[r]
ぐっすり寝てたものだから、イチャイチャしてただーけ♪」[np]
@chr st01bae02
*p17|
溌剌とした笑顔で聖良が照れることもなく、[r]
そんなことを言ってくる。[np]
*p18|
なんだこの反応？[r]
目の前にいるのは本当に聖良なのか？[np]
*p19|
まるで――[np]
@chr st01ade18
*p20|
@nm t="聖良" s=sei_10992
「もっと――んちゅぅ、イチャイチャしよ……♪[r]
お姉ちゃんと、いっぱいチュッチュ……んちゅ、しよ♪」[np]
*p21|
@nm t="千尋"
「んっ、んんっ～～！！？」[np]
*p22|
まるでチャーミングスタイルのセーラじゃないか……！！[r]
これ、もしかして夢なんじゃ……！？[np]
@chr st01ade06
@dchr st01ade18 delay=3162
@dchr st01ade13 delay=6614
@dchr st01ade18 delay=10960
@dchr st01ade06 delay=12239
*p24|
@nm t="聖良" s=sei_10993
「ほーらぁ。主くんも、んちゅっ……ちゅっ。[r]
キスし返して……？　それか、んちゅぅ、口開けて……？」[np]
@chr st01ade05
*p25|
@nm t="千尋"
「ふぁ……！」[np]
*p26|
クイっと顎を引かれて口を開けられる。[r]
そして、次の瞬間――[np]
@chr st01ade18
*p27|
@nm t="聖良" s=sei_10994
「れろぉ……れろろろぉ……♪　れろれろぉ……♪[r]
んはぁむっ、んちゅぅ、ぺろ、ぺろろぉ……♪」[np]
*p28|
口内を縦横無尽に這い回る舌が、気持ちいい……！[r]
夢うつつな今の状況もあり、脳がとろけそうだ……！！[np]
@chr st01ade13
@dchr st01ade12 delay=2857
@dchr st01ade18 delay=8837
@dchr st01ade12 delay=10235
*p29|
@nm t="聖良" s=sei_10995
「……はぁはぁ。やっぱり、えへへ……♪[r]
このコスしてたらスケベな自分、んちゅっ、出せるかも♪」[np]
@chr st01ade05
*p30|
耳に入る声に気が向かない。[r]
キスの快感に悶えてしまって考えがまとまらないんだ。[np]
*p31|
@nm t="千尋"
「ん、ふあ……気持ちいい……溺れる……」[np]
@chr st01bde13
@dchr st01bde18 delay=5839
@dchr st01bde10 delay=7647
*p32|
@nm t="聖良" s=sei_10996
「えへへ、溺れていいんだよ、主くん。[r]
一緒に、んっ、ちゅっ……溺れよ？」[np]
@chr st01bde04
*p33|
軽く口づけされる感覚と共に、[r]
両方の手の平にむにゅっと柔らかい感触が広がる。[np]
*p34|
これ、おっぱいじゃないか……！[np]
@chr st01ade17
@dchr st01ade06 delay=3502
*p35|
@nm t="聖良" s=sei_10997
「あぁんっ♪　ふぁ、あぁあんっ♪[r]
ギュウギュウ握ってきちゃって嬉しい♪」[np]
@dchr st01ade12 delay=2540
@dchr st01ade18 delay=6342
@dchr st01ade06 delay=8959
*p36|
@nm t="聖良" s=sei_10998
「好きに揉んでいいよっ？　私も主くんの身体、[r]
ぺろろぉ、好きにさせてもらうから♪」[np]
[se storage="動作_服_脱衣_00" buf=0 delay=0]
@chr st01ade05
[wait time=500]
*p37|
ぼんやりしているうちに、気づけば全裸に剥かれてしまっていた。[np]
*p38|
背中にシーツの冷たい感触が伝わってくるのと同時に、[r]
お腹の上に火照りきったエッチな体温が伝わってくる。[np]
*p39|
その寒暖の差が俺の頭を少しハッキリさせてくる。[r]
一方で、蓄積された快感と情欲は抑えられなくなっていた。[np]
@chr st01ade09
@dchr st01ade17 delay=2244
*p40|
@nm t="聖良" s=sei_10999
「ふぁぁぁっっ……！！　乳首、あはぁん♪[r]
チューチューされてっ……！！」[np]
@chr st01ade12
*p41|
@nm t="聖良" s=sei_11000
「あぁん♪　気持ちいい……！[r]
はぁあんっ、おっぱい揉み回してもらえて……♪」[np]
@chr st01ade06
@dchr st01ade12 delay=7906
*p42|
@nm t="聖良" s=sei_11001
「え、えへへ、吸ったり揉んだり、えっちぃ。[r]
もしかして、あぁんっ、すっかり目覚めちゃってる？」[np]
@chr st01ade05
*p43|
@nm t="千尋"
「あ、ああ。ビックリした……夢かと思ったよ。[r]
起きたら、はぁはぁ、めちゃくちゃキスされてて」[np]
@chr st01ade06
*p44|
@nm t="聖良" s=sei_11002
「ぐっすり寝てるあなたを見てたら、はぁはぁ、[r]
すっごくムラムラしちゃって、つい♪」[np]
@chr st01ade15
@dchr st01ade18 delay=2351
@dchr st01ade13 delay=5704
*p45|
@nm t="聖良" s=sei_11003
「素面じゃ恥ずかしいから、んっ、ちゅぅ、れるるっ。[r]
セーラの力、また借りちゃった♪」[np]
@chr st01ade05
*p46|
淫らな性欲を曝け出すように、[r]
聖良が熱に浮かされたような顔でたっぷりキスしてくる。[np]
*p47|
そんな彼女につられるように、[r]
俺もキスし返しながら聖良の爆乳を揉みしだく。[np]
@chr st01bde18
*p48|
@nm t="聖良" s=sei_11004
「んふっ♪　んっ♪　んんっ～～♪」[np]
@chr st01bde03
@dchr st01bde13 delay=3055
*p49|
@nm t="聖良" s=sei_11005
「――ぷはぁ、はぁはぁ、主くんのスケベさん♪」[np]
@chr st01bde02
*p50|
@nm t="千尋"
「聖良の方が、はぁ、はぁ……スケベだろ。[r]
寝てる相手に夜這い……というか朝這いをかけるなんて」[np]
@chr st01bde05
*p51|
@nm t="聖良" s=sei_11006
「えへへ、迷惑だった？」[np]
@chr st01bde04
*p52|
@nm t="千尋"
「いや――最高だ……！！」[np]
@chr st01bde13
@dchr st01bde14 delay=3080
*p53|
@nm t="聖良" s=sei_11007
「あっ、あぁあんっ♪　えへへっ……！[r]
ちゅっ、んちゅぅっ……！！」[np]
@chr st01bde18
*p54|
まだ微睡みに片足を半分浸からせているような心地の中、[r]
ベッドの上で半裸同然の聖良とくんずほぐれつ絡み合う。[np]
*p55|
欲望全開でイチャついてくる姿は、まさに妄想の中の[r]
セーラそのもの……いや、それ以上で。[np]
*p56|
ドスケベ彼女との夢のような朝に、[r]
起き抜けだというのに、ギンギンに滾ってしまう。[np]
@chr st01ade06
*p57|
@nm t="聖良" s=sei_11008
「もっと気持ちいいコトしよ、主くん♪[r]
お姉ちゃんと、もーっとイチャイチャしよ♪」[np]
@dchr st01ade12 delay=4970
*p58|
@nm t="聖良" s=sei_11009
「朝からたっぷりたっぷり、はぁはぁ、[r]
二人きりのラブラブタイム、楽しみたいな♪」[np]
@hide
@eff_all_delete
@white time=800
[se storage="衣擦れ(66)" buf=0 delay=0]
@show
*p59|
頷くと、聖良が発情した顔で[r]
身体の上に跨がってきてくれた。[np]
*p60|
俺もまた聖良の爆乳を鷲掴みにして、[r]
お互いの身体を好きなように貪っていく。[np]
*p61|
そして――[np]
@fobgm time=3000
@hide
@wait time=2000
@wbgm
@wait time=1000
@jump storage="103_聖良バニー_01_h.ks"

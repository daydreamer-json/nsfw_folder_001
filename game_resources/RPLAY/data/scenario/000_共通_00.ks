; 
; 
*p0|
*p1|
@if exp="sf.共通_05クリア"
@prologue_skip
@wait time=1000
@endif
*prologue
@white
@show
*p2|
『２次元嫁が[３次元'リアル]に降臨する』――[r]
それは本来、ありえないことだ。[np]
*p3|
空想、妄想……人によってはそれこそ、[r]
２次元だからこそいい、という人だっているだろう。[np]
*p4|
実のところ、俺もそう思っていた。[np]
@hide
@wait time=1000
@eff obj=6 page=back show=true storage=sp_bg_08a_ぼかし path=(864,348,255) size=(1.5,1.5) time=1 correct=false absolute=15000
@eff obj=7 page=back show=true storage=st01bdc04 path=(753,210,255) size=(1.2,1.2) time=1 absolute=(15007) anm=false
@eff obj=8 page=back show=true storage=st01bdc04 path=(776,217,100) size=(1.18,1.18) time=1 rgamma=0 ggamma=0 bgamma=0 bbx=(10) bby=(10) bbt=true bbe=true bbs=true absolute=(15008) anm=false alphaeffect=7
@bg storage=bg_08a rule=rule_02_i_o_tb time=800
@bgm storage=bgm_10
@show
@ceff obj=7 storage=st01bdc08
@dceff obj=7 storage=st01bdc13 delay=4500
*p5|
@nm t="？？？" rt="聖良" s=sei_0408
「もう……。いけませんよ、ご主人様。[r]
湯船で居眠りなんて……」[np]
@hide
@eff_all_delete
@eff obj=9 page=back show=true storage=sp_bg_08a_ぼかし path=(1034,-234,255) size=(1.5,1.5) time=1 rad=(-90,-90) flipud=true correct=false absolute=15009
@eff obj=10 page=back show=true storage=st02bdc14 path=(420,189,255) time=1 absolute=(15010) anm=false
@eff obj=11 page=back show=true storage=st02bdc01 path=(432,231,100) size=(0.98,0.98) time=1 rgamma=0 ggamma=0 bgamma=0 bbx=(10) bby=(10) bbt=true bbe=true bbs=true absolute=(15011) anm=false alphaeffect=10
@bg storage=bg_08a time=800
@show
@ceff obj=10 storage=st02bdc11
@dceff obj=10 storage=st02bdc09 delay=1600
*p6|
@nm t="？？？" rt="莉瑠" s=rir_0273
「本当に……風邪を引いちゃったらどうするんだ」[np]
@hide
@eff_all_delete
@eff obj=0 page=back show=true storage=sp_bg_08a_ぼかし path=(640,360,255) time=1 correct=false
@eff obj=1 page=back show=true storage=st02bac01 path=(-560,-480,255) time=1 rad=(130,130) absolute=(15001)
@eff obj=2 page=back show=true storage=st02bac01 path=(-560,-480,100) size=(0.98,0.98) time=1 rad=(130,130) rgamma=0 ggamma=0 bgamma=0 bbx=(10) bby=(10) bbt=true bbe=true bbs=true absolute=(15002) anm=false alphaeffect=1
@eff obj=3 page=back show=true storage=st01bdc04 path=(860,600,255) time=1 absolute=(15003)
@eff obj=4 page=back show=true storage=st01bdc04 path=(819,654,100) size=(0.98,0.98) time=1 rgamma=0 ggamma=0 bgamma=0 bbx=(50) bby=(50) bbt=true bbe=true bbs=true absolute=(15004) anm=false alphaeffect=3
@bg storage=bg_08a time=800
@show
*p7|
彼女たちが――俺の前に現れるまでは。[np]
*p8|
@nm t="千尋"
「セーラ……？　リルル……？」[np]
@ceff obj=3 storage=st01bdc05
@dceff obj=3 storage=st01bdc13 delay=4000
*p11|
@nm t="セーラ" rt="聖良" s=sei_0410
「あ。起き上がらなくていいですよ？[r]
そのまま横になっていて下さい」[np]
@ceff_stock obj=1 storage=st02bac13
@ceff obj=3 storage=st01bdc04
@dceff obj=1 storage=st02bac14 delay=2300
*p12|
@nm t="リルル" rt="莉瑠" s=rir_0275
「私にも、その。して欲しいことがあれば言うんだぞ……？」[np]
@ceff obj=1 storage=st02bac02
@dceff obj=1 storage=st02bac15 delay=2400
*p13|
@nm t="リルル" rt="莉瑠" s=rir_0276
「無茶なお願いじゃなければ、叶えてあげるからな……？」[np]
@ceff_stock obj=1 storage=st02bac01
@ceff obj=3 storage=st01bdc02
*p14|
目の前に確かに存在する──３次元の彼女たちに見惚れ、[r]
心臓と股間がうるさいくらい早鐘を打つ。[np]
*p15|
だって、この二人は……セーラとリルルは──[np]
*p16|
俺の理想と欲望を詰め込んだエロ漫画、[r]
『とろとろ★エヴォーキング』のヒロインたちで──[np]
*p17|
──俺の２次元嫁なのだから。[np]
*p48|
存在しないはずの二人が、今、目の前にいる。[r]
その事実が、俺の脳みそを熱く茹らせていく。[np]
@hide
@eff_all_delete
@white time=1000
@show
*p51a|
一方で、頭の中にかすかに残った冷静な部分が自問自答する。[np]
*p51b|
なぜ、俺はこんな夢のような状況にいるのか、と。[np]
*p51c|
事の始まりは、そう……俺がとある島を訪れたことだった──[np]
@fobgm time=3000
@hide
@black time=2000
@wbgm
@wait time=1000
@jump storage="000_共通_01.ks"

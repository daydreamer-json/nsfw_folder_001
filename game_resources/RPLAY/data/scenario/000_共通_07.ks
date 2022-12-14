; 
; 
*p0|
@bg storage=bg_05a
@bgm storage=bgm_02
@chr_walk way=r st02abb01=4,1
@wt
@wm
@show
@chr_walk way=r st01abb09=6
@dchr st02abb09 st01abb17 delay=1300
*p1|
@nm t="聖良" s=sei_10067
「ちょ、待っ……！　莉瑠ちゃん、おいてかない、でっ……！」[np]
@chr st02abb11 st01abb07
@dchr st02abb08 delay=2000
*p2|
@nm t="莉瑠" s=rir_10061
「あーもう。そんなにくっつかれると暑いですってば」[np]
@chr st02abb09
*p3|
@nm t="千尋"
「何とも言えない光景だな……」[np]
@chr st01abb13
*p4|
身を屈めて莉瑠の背中に隠れながら[r]
店内を歩く聖良を見て呟く。[np]
@chr st02abb12
@dchr st02abb15 delay=1600
@dchr st02abb08 delay=5000
*p5|
@nm t="莉瑠" s=rir_10062
「でしょう？　人の多い場所に行くといつもそうなんです。[r]
全くもう。人混みが嫌いならついてこなければいいですのに」[np]
@chr st02abb09 st01abb14
@dchr st01abb15 delay=2800
@dchr st01abb13 delay=8400
*p6|
@nm t="聖良" s=sei_10068
「だって莉瑠ちゃんじゃ、どの生地買えばいいとか[r]
どの糸買えばいいとか、わからない、でしょ……？」[np]
@chr st02abb14
@dchr st02abb13 delay=1200
*p7|
@nm t="莉瑠" s=rir_10063
「うっ……！　まぁそれはそうですけど……！」[np]
@chr st01abb03
*p8|
その日、俺たちは島にあるコスプレショップを訪れていた。[np]
@chr st02abb11
*p9|
痛んでしまった衣装の修繕用素材や、[r]
小道具、メイク道具といった諸々の買い物が主な用事だ。[np]
@chr st02abb12
@dchr st02abb09 delay=1700
@dchr st02abb08 delay=4300
*p10|
@nm t="莉瑠" s=rir_10064
「というか一体どんなプレイしてるんですか……。[r]
またしても衣装がほつれるなんて……」[np]
@chr st02abb09 st01abb13
@dchr st01abb07 delay=4700
@dchr st01abb08 delay=8300
*p11|
@nm t="聖良" s=sei_10069
「り、莉瑠ちゃんも人のこと言えない、でしょ。[r]
むしろわたしより……その。ボロボロになってた、よね？」[np]
@chr st02abb14
@dchr st02bbb09 delay=800
@dchr st02bbb12 delay=1900
*p12|
@nm t="莉瑠" s=rir_10065
「～～っっ！！　なってません……！[r]
なってたとしてもそれは千尋さんのせいですし……！！」[np]
@chr st02bbb07 st01abb07
*p13|
@nm t="千尋"
「い、いいから買い物を早く済ませよう。[r]
あんまり騒ぐと他の人に迷惑だし……！」[np]
@chr st01bbb16
*p14|
@nm t="聖良" s=sei_10070
「あ……誤魔化した」[np]
@chr st02abb09
*p15|
@nm t="莉瑠" s=rir_10066
「誤魔化しましたね」[np]
@bg storage=bg_05a_l left=-1280 top=-460
*p16|
ジトっともの言いたげに俺を見てくる二人を必死にかわし、[r]
必要な道具や素材を見繕っていく。[np]
*p17|
聖良たちもそれぞれ足りなくなってきたものを[r]
他のお客さんたちに紛れながら見ているみたいだった。[np]
@hide
@black rule=rule_spiral01
@wait time=500
@bg storage=bg_05a rule=rule_spiral01
@show
@chr_walk way=l st02abb03=4,1 st01bbb02=6
*p18|
にしても……[np]
*p19|
@nm t="千尋"
「……気づかれないもんだなぁ」[np]
@chr st02abb01 st01bbb16
*p20|
@nm t="莉瑠" s=rir_10067
「へ？　何がですか？」[np]
*p21|
戻ってきた二人にふと疑問をぶつける。[np]
*p22|
@nm t="千尋"
[resetwait]
「だから二人がアエット・リエ――
[wait mode=until time=500]
[chr st02bdb07=4.5 st01bbb02]
[se storage="衣擦れ(100)" buf=0]
[q_small]
もごごっ！！？」[np]
@chr st02bdb13
@dchr st02bdb09 delay=1200
@dchr st02bdb12 delay=2200
*p23|
@nm t="莉瑠" s=rir_10068
「～～っっ！！　ちょっと、こんな場所で[r]
何を言おうとしてるんですか……！！？」[np]
@chr st02bdb07
*p24|
二人のコスプレネームを口にしかけた瞬間、[r]
莉瑠が勢いよくバっと口を塞いでくる。[np]
@chr st02bdb08
@dchr st02bdb06 delay=2100
@dchr st02bdb12 delay=4000
*p25|
@nm t="莉瑠" s=rir_10069
「秘密だって言いましたよね……！？　男装したり、[r]
仮面付けたりして、気づかれない努力をしてるから[r]
気づかれないんですよ……！」[np]
@chr st02bdb07
*p26|
@nm t="千尋"
「もがもが、ふが……！」[np]
@chr_del name=莉瑠
@wt
@chr st02abb11=4,1
*p27|
@nm t="莉瑠" s=rir_10070
「全くもう……」[np]
@chr st02abb09
*p28|
頭を縦に振り、理解と謝罪を示すと、[r]
ようやく莉瑠が手を離してくれる。[np]
@chr st01abb15
@dchr st01abb13 delay=2500
*p29|
@nm t="聖良" s=sei_10071
「そこまで気にする必要ないと思う……けど」[np]
@chr st02abb08
@dchr st02abb15 delay=1400
@dchr st02abb11 delay=3900
@dchr st02abb15 delay=7500
*p30|
@nm t="莉瑠" s=rir_10071
「はぁ？　それじゃあ聖良はいいんですか？[r]
今ここでもし私たちの正体がバレたら、[r]
きっと店内は阿鼻叫喚ですよ？」[np]
@chr st02abb11 st01abb15
@dchr st02abb09 st01abb17 delay=3800
@dchr st02abb15 delay=5900
*p31|
@nm t="莉瑠" s=rir_10072
「一挙に人という人が押し寄せてくること請け合いです。[r]
そんな人の波に――聖良は果たして耐えられるんですか？」[np]
@chr st01abb16
@dchr st01abb08 delay=1400
*p32|
@nm t="聖良" s=sei_10072
「はぅ……！　そ、それは、えと……！」[np]
@chr st02abb09
*p33|
聖良が焦った顔をする。[r]
ホントにコスしてる時とは別人みたいだ……。[np]
*p34|
アエット・リエットとして活動している時も、[r]
こんな感じだったんだろうか。[np]
*p35|
@nm t="千尋"
「そういえば、どうして男装だったんだ？」[np]
@chr st02abb01 st01bbb16
*p35a|
@nm t="千尋"
「とろキンコスしたいって言うくらいなら、[r]
最初からアニメヒロインのコスとかしそうなものだけど」[np]
@chr st02abb09 st01bbb04
@dchr st01bbb03 delay=1500
@dchr st01bbb12 delay=9500
*p36|
@nm t="聖良" s=sei_10073
「う、うん。実際ね……？　初めてコスする時も、[r]
とろキン合わせでイベント出よって言ってたんだけど……」[np]
@chr st02abb14
@dchr st02abb08 delay=2500
*p37|
@nm t="莉瑠" s=rir_10073
「で、出られるわけがないじゃないですか……！[r]
あんな肌色注意なコスで……！！」[np]
@chr st02abb13 st01bbb07
@dchr st01bbb01 delay=3000
*p38|
@nm t="聖良" s=sei_10074
「というような感じで、ね……？[r]
莉瑠ちゃんがどうしても嫌がっちゃって……」[np]
@chr st02abb09 st01bbb16
@dchr st01bbb03 delay=3100
@dchr st01bbb05 delay=8400
*p39|
@nm t="聖良" s=sei_10075
「それで当時はまってたゲームの兄弟キャラが[r]
露出も少なくて胸も潰せて丁度いいからって話になったの」[np]
@chr st02abb11 st01bbb02
@dchr st02abb15 delay=3000
@dchr st02abb12 delay=6000
*p40|
@nm t="莉瑠" s=rir_10074
「初イベントは壮絶でしたけどね……。[r]
謎の仮面男装姉妹レイヤーだとか妙に話題になってしまって」[np]
@chr st02abb09
@dchr st02abb11 delay=3500
*p41|
@nm t="莉瑠" s=rir_10075
「カメラマンさんに話しかけられて聖良はきょどるわ……。[r]
勘違いでコスプレネームが決められちゃうわで……」[np]
@chr st02abb12
*p42|
@nm t="千尋"
「勘違いで？　どういうことだ？」[np]
@chr st01bbb16
@dchr st01bbb12 delay=1800
*p43|
@nm t="聖良" s=sei_10076
「あ、えっと……！　それは……！」[np]
*p44|
@nm t="千尋"
「……あー、なるほど。大体わかったよ」[np]
@chr st02abb09 st01bbb16
*p45|
恐らくコスプレネームを尋ねられて、[r]
聖良が「あ、えっと」と答えたのを勘違いされたんだろう。[np]
@chr st02abb08
@dchr st02abb15 delay=3800
*p46|
@nm t="莉瑠" s=rir_10076
「しかも、きょどって私に助けを求めようとして、[r]
本名呼ぼうとするんですもん……」[np]
@chr st02abb11 st01bbb01
@dchr st02abb12 delay=4000
*p47|
@nm t="莉瑠" s=rir_10077
「危うくアエット・リルになるところでした……。[r]
まぁ名前を呼ぶ寸前に気づいて、聖良に合わせましたけど……」[np]
@chr st01bbb08
@dchr st01bbb16 delay=4900
@dchr st01bbb07 delay=8000
@dchr st01bbb12 delay=13300
*p48|
@nm t="聖良" s=sei_10077
「あ……。だから急に『リエットです』って言ったん、だ？[r]
てっきりわたし、莉瑠ちゃんがコスプレに乗り気で……。[r]
コスプレネームも密かに考えてたのかと思ってた……」[np]
@chr st02bbb07
@dchr st02bbb08 delay=2600
@dchr st02bbb09 delay=5600
*p49|
@nm t="莉瑠" s=rir_10078
「んなわけないじゃないですか……！？[r]
聖良の口から『り』の文字が聞こえてきた時の、[r]
私の焦りようがわかりますか！？」[np]
@chr st02bbb07 st01abb08
@dchr st01abb13 delay=1000
*p50|
@nm t="聖良" s=sei_10078
「はぅ……。ご、ごめん……ね？」[np]
@chr st02abb12
@dchr st02abb07 delay=6200
*p51|
@nm t="莉瑠" s=rir_10079
「……まぁ男装姉妹レイヤーとして有名になったのは[r]
逆にラッキーでしたけどね。あれ以来、男装コス縛りに[r]
なったといっても過言じゃありませんし」[np]
@chr st02abb03 st01bbb06
@dchr st01bbb07 delay=4900
*p52|
@nm t="聖良" s=sei_10079
「むぅ……。わたしは何度も提案した、のに……。[r]
とろキンだけじゃなくて他のキャラのコスも……」[np]
*p53|
なんにせよ色々と大変だったらしい。[r]
生々しくなると困るし、あまり深くは掘り下げないでおこう。[np]
@chr st01bbb15
@dchr st01bbb04 delay=1000
@dchr st01bbb13 delay=2800
*p54|
@nm t="聖良" s=sei_10080
「でも……えへへ。今までセーラコスしなくて[r]
確かに良かったかも……」[np]
@chr st02abb01 st01bbb03
@dchr st01bbb05 delay=3800
*p55|
@nm t="聖良" s=sei_10081
「おかげで……千尋くんと出会えたし、ね？」[np]
@chr st01bbb04
*p56|
@nm t="千尋"
「きゅっ、急に何を言い出すんだ」[np]
@chr st01bbb13
@dchr st01abb04 delay=5600
@dchr st01abb02 delay=8000
*p57|
@nm t="聖良" s=sei_10082
「えへへ、照れちゃって可愛い……。[r]
さ、早くお買い物済ませちゃお……？」[np]
@chr st01abb06
@dchr st01abb12 delay=5800
*p58|
@nm t="聖良" s=sei_10083
「早く帰って、衣装調整して、それでまた……[r]
一緒にロールプレイしたい、な？」[np]
@chr st02abb09 st01abb05
*p59|
@nm t="千尋"
「～～っっ」[np]
@chr st02abb11
@dchr st02abb13 delay=2200
*p60|
@nm t="莉瑠" s=rir_10080
「ま……全くもう。この淫乱たちは……。[r]
公衆の面前で何を発情して……」[np]
@chr st01abb15
@dchr st01abb13 delay=3500
*p61|
@nm t="聖良" s=sei_10084
「莉瑠ちゃんはしたくない、の……？[r]
リルルコスして、ロールプレイ……」[np]
@chr st02abb14
@dchr st02abb12 delay=1300
*p62|
@nm t="莉瑠" s=rir_10081
「そ、それは、その……！」[np]
@chr st02bbb14
@dchr st02bbb13 delay=4100
*p63|
@nm t="莉瑠" s=rir_10082
「千尋さんがどーしてもしたいと言うのでしたら、[r]
してあげるのもやぶさかではありませんけど……」[np]
@chr st02bbb14 st01bbb10
*p64|
そう言って二人が上目遣いに見上げてくる。[np]
*p65|
これは……衣装の修繕、急いで仕上げないといけないな。[np]
@fobgm time=3000
@hide
@black time=2000
@wbgm
@wait time=1000
@jump storage="選択画面.ks" target="*common_return"

@title name="このソフトについて"
@image storage="about" page=fore top=0 left=0 layer=base
@rclick jump=true target=*exit
@clickskip enabled=false
@position left=-20 top=90 width=297 height=100 color="0x444444" opacity=0 marginl=-20 margint=0 marginr=-20 marginb=-20 visible=true
@style align=center linespacing=5 pitch=1
@font size=20 face="ＭＳ Ｐゴシック" shadow=false color=0xFFFFFF edge=true edgecolor=0x000000
@backlay
@current page=fore
@layopt layer=message0 page=fore opacity=0

[nowait]Version：[emb exp="global.appVer"][endnowait][r]
[link exp="System.ba4423e5cd484bb69c84512dcd34ceb0(global.appURL)"][ch text="　　　　　　　　　　　　　　　　　　　　　　　　"][endlink]

@move layer=message0 path=(-5,90,255) time=1000 accel=-2
@wm
@s

*exit
@stopmove
@close
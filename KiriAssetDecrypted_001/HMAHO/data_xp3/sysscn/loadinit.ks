*loadinit
		[exit noautolabel storage=loadinit.ks target=*doload exp='tf.loadinit="loadinit",  tf.noclearhistory=false']
*gobacktitle
		[exit noautolabel storage=loadinit.ks target=*doload exp='tf.loadinit="titleback", tf.noclearhistory=false']
*endrecollection
		[exit noautolabel storage=loadinit.ks target=*doload exp='tf.loadinit="endreplay", tf.noclearhistory=false']
*afterstory
		[exit noautolabel storage=loadinit.ks target=*doload exp='tf.loadinit="afterstory",tf.noclearhistory=false']
*emergencyreboot
		[exit noautolabel storage=loadinit.ks target=*doload exp='tf.loadinit="emerinit",  tf.noclearhistory=false']
*noclearhistory
		[exit noautolabel storage=loadinit.ks target=*doload exp='tf.loadinit="previnit",  tf.noclearhistory=true']
;
*exec
[syscurrent name="game"]
[historyopt uiload]
[freesnapshot]
[initbase]
[sysupdate]
[return]
;
*doload
[linemode]
; ���[�h����
[clickskip enabled=false]
[video visible=false]
[locklink]
;
[eval exp='tf.fadetime=1000']
[syshook name=&'tf.loadinit+".start"']
;
; ��ʁEBGM�t�F�[�h�A�E�g
[fadeoutbgm time=&tf.fadetime cond="tf.fadetime>0"]
[envstop    time=&tf.fadetime cond="tf.fadetime>0"]
;[bgm stop  time=&tf.fadetime cond="tf.fadetime>0"]
[delaycancel]
[stoptrans]
[eval exp=terminator.invoke()]
[begintrans]
[clearlayers page=back]
[envclearimage]
;[allimage hide]
;[all ontype=layer delete]
;[systrans env name=&tf.loadinit method=crossfade time=&tf.fadetime]
;[wt]
[endtrans trans=crossfade time=&tf.fadetime sync]
;
[syshook name=&'tf.loadinit+".end"']
[syscurrent name="game"]
[historyopt uiload]
[clearhistory cond="!tf.noclearhistory"]
[initbase nostopse=&tf.loadinitnostopse]
[eval exp="doLoad()"]
[sysupdate]
*exit

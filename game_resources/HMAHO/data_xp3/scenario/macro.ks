;��ԏ������p
;syscn ����Ă΂��̂Ń��C�����[�h���߂͊܂܂Ȃ�
[macro name=initbase]
[clearlayers]
[stopquake]
@stopbgm        cond=!mp.nostopbgm
@stopse buf=all cond=!mp.nostopse
[stopvideo]
[sysmovie state=end]
[history enabled=true]
[sysrclick]
[noeffect  enabled=true]
[clickskip enabled=true]
[current layer=message0]
[init nostopbgm=%nostopbgm]
[endmacro]

; ���[�r�[�Đ���sflag�̓R���o�[�g���[�h���̂ݗL��
[macro name=movieflag][endmacro]

; parsemacro.ks ����Ă΂��|�C���g
*common_macro

;���C�����[�h�w��ƃ��b�Z�[�W�������܂Ŋ܂ޏ�ԏ������p
[macro name=initscene]
[initbase]
[linemode mode=free craftername=true erafterpage=true]
[autoindent mode=true]
[meswinload page=both]
[endmacro]

; 
[macro name="�Q�[���J�n"][set name="tf.start_storage" value=%storage][set name="tf.start_target" value=%target|][exit storage="start.ks" target="*jump"][endmacro]
[macro name="�Q�[���I���F�^�C�g��"][exit storage="start.ks" target="*gameend_title"][endmacro]
[macro name="�Q�[���I���F���S���"][exit storage="start.ks" target="*gameend_logo" ][endmacro]

; �ȉ��^�C�g���ɕK�v�ȃ}�N�����쐬����

[macro name="�V�i���I�ʉ�"][endrecollection][sflag name=%flag][set name='&"f."+mp.flag' value=1][endmacro]
[macro name="�Q�[�����[�v"][next storage=gameloop.txt target=%target|*main][endmacro]


[macro name=�N�G�X�g��ʏ�����][initscene][bgm08 sync][endmacro]
[macro name=�N�G�X�g�I��][mselinit *][mseladd][mselect][endmacro]

[macro name="_ds_"][clickskip enabled=%enabled][noeffect enabled=%enabled][endmacro]
[macro name="<ds"][_ds_ enabled=false][endmacro]
[macro name="ds>"][_ds_ enabled=true ][endmacro]

; ���[�r�[�ӏܗp
[macro name=hscenemovie_begin][linemode mode=tex][noeffect enabled=false][rclick enabled storage="animation.ks" target="*endrecollection" jump][endmacro]
[macro name=hscenemovie_play ][begintrans][clearlayers page=back][ev file=&GetEnvMotionAmvFile(mp.file) loop=true][endtrans quickfade nosync][waitclick][sysse name="moviemode.next"][endmacro]
[macro name=hscenemovie_end  ][lse stop][stopvoice][noeffect enabled=true][linemode][endrecollection][endmacro]

[macro name=�͓��A�C�L���b�`]
	[initscene]
	[cancelskip]
	[jingle file=ic02]
	[<ds][if exp='mp.storage!=""']
		[ev     storage=%storage     normal sync]
	[else  ][ev evalstorage=%evalstorage normal sync][endif][ds>]
	[wait time=7000]
	[jingle stop=1000]
	[ev hide normal sync]
[endmacro]

; �������玩��}�N��
[macro name=�G�����@�N�����[�r�[]
	[noeffect enabled=false]
	[msgoff time=0]
;	[cancelskip]
	;����SE��~
	[bgm stop]
	[voice stop]
	[se stop]

	[object name=bgwhite file=white level=6]
	[wait time=500]
	[object name=movie file=e_magic level=6]
	[se_e_magic sync]
	;[wait time=7000]
	[se stop]
	[movie delete]
	[bgwhite delete normal]
	[noeffect enabled=true]
[endmacro]

; [�A�C�L���b�` bgm=ic01]
[macro name=�A�C�L���b�`]
	[endrecollection]
	[msgoff time=0]
;	[cancelskip]
	;����SE��~
	[bgm stop]
	[voice stop]
	[se stop]
	
	[if exp='mp.file!=""']
		[ev file=%file normal]
	[else]
		[ev evalstorage="get_random_ic(10)" normal]
	[endif]
	[jingle file=%bgm|ic01 sync]
	;[wait time=8000]
	[jingle stop=1000]
	[ev hide normal sync]
	
	[eval exp=f.bgmnum=1]
	[eval exp=f.eyeCatcha=0]

[endmacro]

[macro name=�X�^�b�t���[��]
	[endrecollection]
	[noeffect enabled=false]
	[msgoff time=0]
	[bg file=black]
	;����SE��~
	[voice stop]
	[se stop]
	[cancelskip]
	[cancelautomode]
	
	[clickskip enabled=true]
	[beginskip]
	[bgm14 loop=false]
	[object name=movie file=ed_magic loop=true trans=normal show]
	
	;�Đ�����127000�~���b�A6300�~���b���Ƃɉ摜�ύX
	[wait time=6300]
	[ev file=staffroll diff=01�^�C�g�� normal]
	[wait time=6300]
	[ev file=staffroll diff="02���@����" normal]
	[wait time=6300]
	[ev file=staffroll diff=03�V�i���I normal]
	[wait time=6300]
	[ev file=staffroll diff=04�L���X�g�P normal]
	[wait time=6300]
	[ev file=staffroll diff=05�L���X�g2 normal]
	[wait time=6300]
	[ev file=staffroll diff=06�L���X�g3 normal]
	[wait time=6300]
	[ev file=staffroll diff=07�L���X�g4 normal]
	[wait time=6300]
	[ev file=staffroll diff=08�L���X�g5 normal]
	[wait time=6300]
	[ev file=staffroll diff=09�O���t�B�b�J�[ normal]
	[wait time=6300]
	[ev file=staffroll diff=10���� normal]
	[wait time=6300]
	[ev file=staffroll diff=11BGM normal]
	[wait time=6300]
	[ev file=staffroll diff=12���� normal]
	[wait time=6300]
	[ev file=staffroll diff="13�X�N���v�g �f�o�b�O" normal]
	[wait time=6300]
	[ev file=staffroll diff=14�A�g���G�s�[�` normal]
	[wait time=6300]
	[ev file=staffroll diff=15�X�y�V�����T���N�X normal]
	[wait time=6300]
	[ev file=staffroll diff=16�݂�ӂ��� normal]
	[wait time=6300]
	[endskip]

	[begintrans]
	[bgm stop]
	[movie delete]
	[ev delete]
	[endtrans normal]
	[noeffect enabled=true]
[endmacro]

@return

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
[initmode *]
[meswinload page=both]
[endmacro]

[macro name=initmode]
[linemode mode=free craftername=true erafterpage=true]
[autoindent mode=true]
; for rendermsgwin, multilang/translate
;[msgmode mode=true history=true cond=%msgmode|false]
;[msgmode mode=true history=true language=&GetScnConvertLangList() cond=%translate|false]
[endmacro]


; 
[macro name="�Q�[���J�n"][set name="tf.start_storage" value=%storage][set name="tf.start_target" value=%target|][exit storage="start.ks" target="*jump"][endmacro]
[macro name="�Q�[���I���F�^�C�g��"][exit storage="start.ks" target="*gameend_title"][endmacro]
[macro name="�Q�[���I���F���S���"][exit storage="start.ks" target="*gameend_logo" ][endmacro]



; ���[�r�[�Đ��ėp
	;	file		�Đ�����t�@�C��
	;	mode		�Đ����郂�[�h
	;	cancelskip	�Đ��O�ɃX�L�b�v��~
	;	skip		�X�L�b�v������
	;	disablerclick	�E�N���b�N�X�L�b�v�֎~
	;	beforetrans	���O�g�����W�V����
	;	beforecolor	���O�t�F�[�h�J���[
	;	aftercolor	����J���[
	;	afterhide	��������g�����W�V����
	[macro name=movie]
		[cancelskip cond=%cancelskip|false]
		[_movie_sysmenu_hide_]
		[beginskip skip=%skip eval='&mp.eval!=""?mp.eval:"sf.movie_"+(((string)mp.file).toLowerCase())']
			[begintrans]
				[msgoff]
				[allimage hide]
				[_movie_fill_ * coltag=beforecolor defcol=0x000000]
			[endtrans trans=%beforetrans|normal sync]
			[sysmovie file=%file disablerclick=%disablerclick mode=%mode begincolor=%beforecolor|0x000000 endcolor=%aftercolor|0x000000 keepcolor eval="kag.skipMode<SKIP_CANCEL" stopcheck="SKIP_CANCEL"]
			[begintrans]
				[clearlayers page=back]
				[_movie_fill_ *  coltag=aftercolor defcol=0x000000]
			[endtrans notrans sync]
			[sysmovie state=end]
			[if exp=%afterhide|true]
				[begintrans]
					[allimage hide]
					[layer name=_movie_fill_layer delete]
				[endtrans trans=%aftertrans|normal sync]
			[endif]
		[endskip]
		[_movie_sysmenu_restore_ *]
		[sflag name=&@"movie_${((string)mp.file).toLowerCase()}"]
	[endmacro]
	[macro name="_movie_fill_"]
		[layer name=_movie_fill_layer class=effect file='&@"color,${(mp[mp.coltag]!==void?+mp[mp.coltag]:+mp.defcol)&0xFFFFFF|0xFF000000},width,${kag.scWidth},height,${kag.scHeight}"']
	[endmacro]
	[macro name="_movie_sysmenu_hide_"]
;		[quickmenu fadeout]
	[endmacro]
	[macro name="_movie_sysmenu_restore_"]
;		[quickmenu fadin]
	[endmacro]

;---------------------------------------------

; �ȉ��^�C�g���ɕK�v�ȃ}�N�����쐬����

[macro name="�V�i���I�ʉ�"][endrecollection][sflag name=%flag][set name='&"f."+mp.flag' value=1][endmacro]
[macro name="�Q�[�����[�v"][next storage=gameloop.txt target=%target|*main][endmacro]

[macro name="�N�G�X�g�t���O�F���Z�b�g"  ][eval exp="f.���݂̃X�e�[�W=0, f.���݂̃E�F�[�u=0"][if exp=%stage][set name="f.���݂̃X�e�[�W" value=%stage][endif][endmacro]
[macro name="�N�G�X�g�t���O�F���̏͐i�s"][eval exp="f.���݂̃X�e�[�W++, f.���݂̃E�F�[�u=0"][endmacro]
[macro name="�N�G�X�g�t���O�F���C���i�s"][eval exp="f.���݂̃E�F�[�u++"][endmacro]

[macro name="�N�G�X�g�i�s�F�͈ێ�����"  ][next storage=%storage target=%target eval="f.���݂̃X�e�[�W>0 && f.���݂̃E�F�[�u<4"][endmacro]
[macro name="�N�G�X�g�i�s�F�͊ԃC�x���g"][next storage=%storage target=%target eval='&@"f.���݂̃X�e�[�W==${mp.stage}"'][endmacro]
[macro name="�N�G�X�g�i�s�F���C��"      ][eval exp='&@"(--f.���݂̃E�F�[�u if (f.${mp.flag})), void"'][next storage=%storage target=%target][endmacro]
[macro name="�N�G�X�g�i�s�F�͕ʕ���"    ][emb escape=false exp="ExtractQuestBranch(mp,'f.���݂̃X�e�[�W')"][endmacro]
; -> args : min,max,target=*label_%02d



[macro name=�N�G�X�g��ʏ�����][initscene][bgm07 sync][endmacro]
[macro name=�N�G�X�g�I��][mselinit *][mseladd][mselect][endmacro]

[macro name="_ds_"][clickskip enabled=%enabled][noeffect enabled=%enabled][endmacro]
[macro name="<ds"][_ds_ enabled=false][endmacro]
[macro name="ds>"][_ds_ enabled=true ][endmacro]

; ���[�r�[�ӏܗp
[macro name=hscenemovie_begin][linemode mode=tex][noeffect enabled=false][rclick enabled storage="animation.ks" target="*endrecollection" jump][endmacro]
[macro name=hscenemovie_play ][begintrans][clearlayers page=back][ev file=&GetEnvMotionAmvFile(mp.file) loop=true][endtrans quickfade nosync][waitclick][sysse name="moviemode.next"][endmacro]
[macro name=hscenemovie_end  ][lse stop][stopvoice][noeffect enabled=true][linemode][endrecollection][endmacro]

[macro name=�͓��A�C�L���b�`]
	[gamezoom reset]
	[initscene]
	[cancelskip]
	[jingle file=jm02]
	[<ds][if exp='mp.storage!=""']
		[ev     storage=%storage     normal sync]
	[else  ][ev evalstorage=%evalstorage normal sync][endif][ds>]
	[wait time=7000]
	[jingle stop=1000]
	[ev hide normal sync]
[endmacro]

; �������玩��}�N��
[macro name=�G���A�v���N�����[�r�[�Đ�]
	[gamezoom reset]
	[noeffect enabled=false]
	[msgoff time=0]
;	[cancelskip]
	;����SE��~
	[bgm stop]
	[voice stop]
	[se stop]

	[lse file=lse_�A�v���N����]
	[object name=app_bg file=black level=5]
	[wait time=500]
	[object name=app_mov file=e_appli level=6]
	[app_bg file=white notrans]
	;[se_e_appli sync]
	[wait time=6000]
	;[se stop]
	[begintrans]
	[app_mov delete]
	[app_bg file=app diff="" level=5]
	[endtrans time=500]
	[lse stop]
	[se_�K�V�����o��]
	[object name=app_sp file=app seton=%seton level=6 �����オ�葬]
	[wait time=3000]
	[noeffect enabled=true]
[endmacro]

; [�A�C�L���b�` bgm=ic01]
[macro name=�A�C�L���b�`]
	[gamezoom reset]
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
	[jingle file=%bgm|jm01 sync]
	;[wait time=8000]
	[jingle stop=1000]
	[ev hide normal sync]
	
	[eval exp=f.bgmnum=1]
	[eval exp=f.eyeCatcha=0]

[endmacro]

[macro name=�X�^�b�t���[��]
	;	file		�Đ�����t�@�C��
	;	mode		�Đ����郂�[�h
	;	cancelskip	�Đ��O�ɃX�L�b�v��~
	;	skip		�X�L�b�v������
	;	disablerclick	�E�N���b�N�X�L�b�v�֎~
	;	beforetrans	���O�g�����W�V����
	;	beforecolor	���O�t�F�[�h�J���[
	;	aftercolor	����J���[
	;	afterhide	��������g�����W�V����
	[gamezoom reset]
	[endrecollection]
	[noeffect enabled=false]
	[msgoff]
	[bg file=black]
	;����SE��~
	[voice stop]
	[se stop]
	[cancelskip]
	[cancelautomode]
	
	[clickskip enabled=true]
	[beginskip]
	[bgm14 loop=false]
	[object name=ed_app file=ed_appli loop=true trans=normal show]
	
	;�Đ�����94000�~���b�A4600�~���b���Ƃɉ摜�ύX
	[wait time=4600]
	[ev file=staffroll seton="01_�^�C�g��" normal]
	[wait time=4600]
	[ev file=staffroll seton="02_���E���āE�L�����f�E����" normal]
	[wait time=4600]
	[ev file=staffroll seton=03_�V�i���I normal]
	[wait time=4600]
	[ev file=staffroll seton=04_�L���X�g1 normal]
	[wait time=4600]
	[ev file=staffroll seton=05_�L���X�g2 normal]
	[wait time=4600]
	[ev file=staffroll seton=06_�L���X�g3 normal]
	[wait time=4600]
	[ev file=staffroll seton=07_�L���X�g4 normal]
	[wait time=4600]
	[ev file=staffroll seton=08_�L���X�g5 normal]
	[wait time=4600]
	[ev file=staffroll seton=09_�O���t�B�b�J�[ normal]
	[wait time=4600]
	[ev file=staffroll seton=10_���� normal]
	[wait time=4600]
	[ev file=staffroll seton=11_BGM normal]
	[wait time=4600]
	[ev file=staffroll seton=12_���� normal]
	[wait time=4600]
	[ev file=staffroll seton="13_�X�N���v�g�f�o�b�O" normal]
	[wait time=4600]
	[ev file=staffroll seton=14_�A�g���G�s�[�` normal]
	[wait time=4600]
	[ev file=staffroll seton=15_�X�y�V�����T���N�X normal]
	[wait time=4600]
	[ev file=staffroll seton=16_�݂�ӂ��� normal]
	[wait time=4600]
	[endskip]

	[begintrans]
	[bgm stop]
	[ed_app delete]
	[ev delete]
	[endtrans normal]
	[noeffect enabled=true]
[endmacro]

; �S�p�����n�[�g�ɕς���}�N��
[macro name=��][font face="���m�p�S�V�b�NB" color=0xFF80C0][emb exp="$0x2665"][font face=user color=default][endmacro]

@return

; �u���E�U�p�}�N���Q
;
	@brows mode=proc init
	@s
*_init|
	@call target=*_macro
;;
	@rclick enabled=false
	@current page=fore layer=message0
	@delay speed=nowait
;;
	@_remargin
	@defstyle pitch=0 linespacing=4 linesize=4
	@deffont size=12
;;
	@brows mode=font setfont=caption bold size=16
	@brows mode=font setfont=link  color=0x0000FF
	@brows mode=font setfont=visit color=0x4000C0
	@brows mode=font setfont=click color=0x008000 bold
	@brows mode=font setfont=tab   color=0x008000 bold
	@brows mode=font setfont=btn   color=0x000000 bold
	@brows mode=font setfont=sec   color=0x000000 bold
;;
	@_reset
	@_endinit
	@s
*_cancel|
	@brows mode=proc cancel
*_close|
	@brows mode=proc close
	@s
*_fore|
	@brows mode=history fore
	@s
*_back|
	@brows mode=history back
	@s

*_macro
	[macro name=_endinit][brows mode=proc endinit][endmacro]\
	[macro name=_endterm][brows mode=proc endterm][endmacro]\
;;
	[macro name=hd]�� [endmacro]\
	[macro name=li]�� [endmacro]\
;;
	[macro name=_font][brows mode=font reffont=%ref][endmacro]\
	[macro name=_fontcaption][_font ref=caption][endmacro]\
	[macro name=_fontlink   ][_font ref=link   ][endmacro]\
	[macro name=_fontvisit  ][_font ref=visit  ][endmacro]\
	[macro name=_fontclick  ][_font ref=click  ][endmacro]\
	[macro name=_fonttab    ][_font ref=tab    ][endmacro]\
	[macro name=_fontbtn    ][_font ref=btn    ][endmacro]\
	[macro name=_fontsec    ][_font ref=sec    ][endmacro]\
;;
	@macro name=_fontsel
	@brows mode=font selfont off=link on=visit flag=%flag
	@endmacro
;;
	@macro name=_reset
	@resetfont
	@resetstyle
	@endmacro
;;
	@macro name=_remargin
	@brows mode=layout margin marginL=8 marginR=8 marginT=2 marginB=44
	@endmacro
;;
	@macro name=_icon
	@brows mode=image icon=%name
	@endmacro
;;
	@macro name=_text
	@brows mode=text caption=%caption text=%text section=%section game=%game pos=%pos name=%name default=%default
	@endmacro
;;
	@macro name=_link
	@_fontsel           flag=%tag
	@brows mode=link    link=%tag
	@brows mode=text section=%tag text=%text
	@endlink
	@_reset
	@endmacro
;;
	@macro name=_usage
	@style align=right
	@_fontsel           flag=usage
	@brows mode=link    link=usage
	@brows mode=text section=usage
	@endlink
	@r
	@_reset
	@endmacro
;;
	@macro name=_extmenu
	@_fontsel        flag=%tag
	@brows mode=link menu=%tag
	@chd text=%text
	@_icon name=ext
	@endlink
	@_reset
	@endmacro
;;
	[macro name=_homepage][_extmenu tag=helpWebMenuItem          text=%text][endmacro]\
	[macro name=_sptool  ][_extmenu tag=helpSupportToolsMenuItem text=%text][endmacro]\
	[macro name=_readme  ][_extmenu tag=helpReadmeMenuItem text=&global.ENV_ReadmeName][endmacro]\
;;
	@macro name=_click
	@_fontclick
	@brows mode=link click=%tag usepos=%pos text=%text
	@endlink
	@_reset
	@endmacro
;;
	@macro name=_exec
	@_fontlink
	@brows mode=link exec=%exec param=%param
	@chd text=%text
	@_icon name=ext
	@endlink
	@_reset
	@endmacro
;;
	@macro name=_begin
	@er
	@brows mode=history push
	@_fontbtn
	@button icon=brows_back w=24 h=20 storage=brows.ks target=*_back enabled=&'brows.pageBackCount()>1' halftone
	@button icon=brows_fore w=24 h=20 storage=brows.ks target=*_fore enabled=&'brows.pageForeCount()>0' halftone
	@_reset
	@brows mode=link tab
	@_reset
	@brows mode=draw hline
	@_fontcaption
	@hd
	@brows mode=text caption
	@_reset
	@brows mode=draw hline
	@endmacro
;;
	@macro name=_end
	@_reset
	@r
	@brows mode=layout margin marginL=8 marginR=8 marginT=0 marginB=0 y=&brows.pxHeight-56
	@r
	@brows mode=draw hline
	@_fontbtn
	@if exp=brows.hasDelayedApply
		@locate x=&brows.pxWidth-128-8
		@button text=�L�����Z�� w=96 h=25 storage=brows.ks target=*_cancel
		@locate x=&brows.pxWidth-128-8-114
		@button text=�n�j w=96 h=25 storage=brows.ks target=*_close
	@else
		@locate x=&brows.pxWidth-128-8
		@button text=���� w=96 h=25 storage=brows.ks target=*_close
	@endif
	@_reset
	@_remargin
	@s
	@endmacro
;;
	@macro name=_beginbox
	@brows mode=draw box begin text=%text
	@endmacro
;;
	@macro name=_endbox
	@brows mode=draw box end
	@endmacro
;;
	@macro name=_fullsel
	@if exp=kag.fullScreened
		@_text name=%tag
	@else
		@_click tag=%tag
	@endif
	@endmacro
;;
	@macro name=_cimg
	@style align=center
	@brows mode=image file=%file align=center
	@r
	@_reset
	@endmacro
;;
	@macro name=_rimg
	@brows mode=image file=%file align=right
	@endmacro
;;
	[macro name=ul]�@[indent][endmacro]\
	[macro name=/ul][endindent][endmacro]\
;;
	@return

;----------------------------------------------------------------
*usage|���̃E�B���h�E�̎g����
@_begin

	@ul
	[li][indent]�E��́u[_fonttab][[�~][_reset]�v���N���b�N���Ă��̃E�B���h�E���܂��B
	�E��́u[_fonttab][[�H][_reset]�v���N���b�N���Ă��̃y�[�W���J���܂��B
	����́u[_fonttab]HELP[_reset]�v���N���b�N���Ėڎ������J���܂��B[endindent]
	[ul]
	[li][indent]�{������[_fontlink][link exp="" hint=&'"�������N���b�N���Ă�\n�����N����܂���"']�������N����[endlink][_reset]\
	���N���b�N����ƁA�֘A�y�[�W�ɔ�Ԃ��Ƃ��ł��܂��B
	�����N�̖��A�C�R���u[_fontlink][_icon name=ext][_reset]�v�͊O���E�B���h�E���J�����Ƃ��Ӗ����Ă��܂��B[endindent]
	[ul]
	[li][indent]�{������[_fontclick][link exp="" hint=&'"�������N���b�N���Ă�\n�����N����܂���"']�ΐF�̕���[endlink][_reset]\
	���N���b�N����ƁA�֘A����ݒ��ύX���Ă��̃E�B���h�E����܂��B
	���݂̐ݒ�ɂ���āu[_fontclick][_icon name=check][_reset]�v��\
	�u[_fontclick][_icon name=radon][_reset]�v�̃A�C�R�����\������܂��B[endindent]
	[ul]
	[li]�E�N���b�N�őO�̃y�[�W�ɖ߂�܂��B
	@/ul

@_end


; �w���v�\���e�L�X�g
; �����t�H�[�}�b�g�� data/main/helpover.ks �t�@�C�������ƃe�L�X�g���㏑���ł���
;
;----------------------------------------------------------------
*index|�e�X�g�g�b�v|�L�[���[�h|�Z����
@_begin
	@_usage
	@if exp='getExistImageName(aboutDialogConfig.storage)!=""'
		@_cimg file=&"aboutDialogConfig.storage" 
	@else
		@r
	@endif
	@ul
	@if exp='brows.getEnabledMenuItem("helpReadmeMenuItem")'
		[li][_readme]
		
	@endif
	[li][_link tag=faq]

	[li][_link tag=menu]

	[li][_link tag=conf]

	[li][_link tag=support]
	@/ul

@_end

;----------------------------------------------------------------
*faq|�悭���鎿��
@_begin

	@ul
	[li][_link tag=faq.slow]

	[li][_link tag=faq.wide]

	[li][_link tag=faq.movie]

	[li][_link tag=faq.tier]

	[li][_link tag=faq.fullscr]
	@/ul

@_end

;----------------------------------------------------------------
*faq.slow|�Q�[���̓��삪�d���i�x���j
@_begin

	���g����PC�̃X�y�b�N�iCPU�N���b�N�Ⓥ�ڃ������Ȃǁj���v���X�y�b�N�𖞂����Ă��Ȃ��ꍇ�A
	�Q�[���̓��삪�ɒ[�ɒx���Ȃ�ꍇ������܂��B

	[_text game=���̃Q�[��]�̗v���X�y�b�N�̏ڍׂɂ��Ă�[_homepage text=�z�[���y�[�W]���炲�m�F���������B
	�����X�y�b�N�𖞂����Ă��Ă����삪�x���ꍇ�́A�ȉ��̍��ڂɂ��Ă��������������B

	@ul
	[li]�󂫃�����������Ȃ��ꍇ������̂ŁA���ɋN�����Ă���\�t�g������΂��ׂďI������

	[li][_link tag=menu.lowmem]��[_click tag=memusage text=�`�F�b�N]�����ăQ�[�����ċN������

	[li]PC�̓�����d������悤�ȏ풓�\�t�g�i�Ⴆ�΃E�B���X�΍�\�t�g�Ȃǁj�������Ă��Ȃ����m�F����
	@/ul

	����ł����삪���P����Ȃ��ꍇ��[_link tag=support text=�T�|�[�g�ւ��₢���킹]���������B

@_end
;----------------------------------------------------------------
*faq.wide|�\���������܂��͏c���ɂȂ�
@_begin

	�t���X�N���[���\�����ɉ�ʂ��c�����≡�����Ɉ����L�΂���ĕ\������邱�Ƃ�����܂��B
	������̖��́A���g����PC�ɐڑ����ꂽ���j�^��r�f�I�J�[�h�̎�ނ�ݒ�ɂ��N����܂��B
	[_cimg file=help_aspect]
	�ȉ��̂����ꂩ�̍��ڂ����������������B

	@ul
	[li][_link tag=menu.fsres]���u[_click tag=fsres.nochange]�v�ɂ���

	[li]���j�^��r�f�I�J�[�h�̐ݒ���u�A�X�y�N�g��Œ�g��\���v�ɐݒ肷��
	�@�i������̐ݒ���@�ɂ��Ă͂��g����PC�⃂�j�^�̃}�j���A�������m�F���������B
	�@�@���[�J�[��@��ɂ���Ă͐ݒ�ł��Ȃ�������A�p�ꂪ�����قȂ�ꍇ������܂��j
	@/ul


	��[indent]�t���X�N���[���łȂ��E�B���h�E�\���ł��̖�肪�N����ꍇ�́AWindows��[_exec text=���j�^�𑜓x exec="control.exe" param="desk.cpl @3"]�̐ݒ��
	���g���̃��j�^�ɍ��������̂ɕύX���Ă݂Ă��������B[endindent]

	���u���E���ǃ��j�^�������p�̕���[_link tag=faq.wide.crt text=����������m�F��������]�B

@_end
*faq.wide.crt|��ʂ������܂��͏c���ɂȂ�^�u���E���ǃ��j�^
@_begin

	�u���E���ǃ��j�^(CRT)�������p�̕��́A���j�^�{�̂���������������Ă��Ȃ���
	���̖�肪�N����ꍇ������܂��B

	�s�N�Z���A�X�y�N�g�䂪�P�F�P�̐����`�ɂȂ�悤�Ƀ��j�^�{�̂𒲐����Ă��������B
	�ڂ����͂��g���̃��j�^�̃}�j���A�������m�F���������B

@_end
;----------------------------------------------------------------
*faq.movie|���[�r�[���Đ�����Ȃ��A���邢�͕\������������
@_begin

	�ȉ��̍��ڂɂ��Ă��m�F���������B

	@ul
	[li]Windows Media Player���ŐV�łɃA�b�v�f�[�g����

	[li][_link tag=menu.vomstyle]�̐ݒ��ύX����

	[li]DVD�Đ��\�t�g�Ŏg���Ă��Ȃ����̂�����΃A���C���X�g�[������
	@/ul

	����ł��Đ�����Ȃ��ꍇ��[_link tag=support text=�T�|�[�g�ւ��₢���킹]���������B

@_end
;----------------------------------------------------------------
*faq.tier|��ʂ������ƕ\�����`���`������
@_begin

	�Q�[���̉�ʂ������������ƁA��ʂ̕\�����`���`������ꍇ������܂��B
	���̏ꍇ��Windows�x�[�X��PC�ł̕\����̐����ɂ����̂ł����A�ǂ����Ă��C�ɂȂ�ꍇ�́A
	�ȉ��̍��ڂɂ��Ă��m�F���������B

	@ul
	[li]���g����PC�̃r�f�I�h���C�o���ŐV�̂��̂ɃA�b�v�f�[�g����
	�@�i������̕��@�ɂ��Ă͂��g����PC�̃��[�J�[�ɂ��₢���킹���������j

	[li][_link tag=menu.dbuf]�́u[_click tag=dbstyle.d3d]�v�܂��́u[_click tag=dbstyle.ddraw]�v��I������

	[li][_link tag=menu.fps]���u[_click tag=contfreq.0]�v��I������
	�@�i������̐ݒ�ŃQ�[���̓��삪�d���Ȃ�ꍇ������܂��j

	[li][_link tag=menu.vsync]��[_click tag=waitVSyncMenuItem text=�`�F�b�N]������
	�@�i������̐ݒ�ŃQ�[���̓��삪�d���Ȃ�ꍇ������܂��j
	@/ul

@_end
;----------------------------------------------------------------
*faq.fullscr|�t���X�N���[���̕\�������ɂ���
@_begin

	�t���X�N���[���\���́A�ЂƂ̃��j�^���L����[_text game=���̃Q�[��]�݂̂�\�����郂�[�h�ł��B
	�ߔN�̉t�����j�^�̕��y�⃏�C�h�\���𑜓x�̋K�i�Ȃǂɂ��A���̃��[�h�̕\�������܂������Ȃ����Ƃ�����܂��B
	��Ƃ��ẮA[_link tag=faq.wide]�Ȃǂ�����܂��B

	�}���`���j�^���Ńt���X�N���[���ɂ���ꍇ
	@ul
	[li][_text name=fullscreenmode.auto]�v
	[li][_text name=fullscreenmode.primaryonly]�v
	[li][_text name=fullscreenmode.usepseudo]�v
	[li][_text name=fullscreenmode.pseudoall]�v
	@/ul

@_end
;----------------------------------------------------------------
*menu|���j���[�̐ݒ荀�ڂ̏ڍ�
@_begin

	�Q�[���{�҂̋@�\�i[_text name=storeMenu]��[_text name=restoreMenu]�Ȃǁj�ɂ��Ă�[_text game=���̃Q�[��]�̃}�j���A�������m�F���������B
	�����ł�[_text pos=displayMenu]�Ȃǂ̍��x�Ȑݒ�̋@�\�ɂ��Đ������܂��B

	@ul
	[li][_link tag=menu.winres]
	[li][_link tag=menu.fsres]
	[li][_link tag=menu.dbuf]
	[li][_link tag=menu.smooth]
	[li][_link tag=menu.effect]
	[li][_link tag=menu.fps]
	[li][_link tag=menu.vomstyle]
	[li][_link tag=menu.fsmode]
	[li][_link tag=menu.fsmethod]
	[li][_link tag=menu.vsync]
	[li][_link tag=menu.wheel]
	[li][_link tag=menu.joypad]
	[li][_link tag=menu.lowmem]
	@/ul

@_end

*menu.winres|&brows.getText("pos","winResMenu")
@_begin

	@ul
	[li][indent]�u[_text name=resetWindowSizeMenuItem]�v�Ɓu�c�T�C�Y x ���T�C�Y�v
	�E�B���h�E�\�����̃T�C�Y��ύX���܂��B
	�u[emb exp="@'${kag.scWidth} x ${kag.scHeight}'"]�v�ȊO�̃T�C�Y�ł͉摜���g��܂��͏k�����ĕ\�����܂��B[endindent]
	[ul]
	[li][indent]�u[_click tag=disableWindowResizeMenuItem]�v
	@_rimg file=help_resize
	�`�F�b�N������ƃE�B���h�E�g�̃h���b�O�ɂ�郊�T�C�Y���֎~���܂��B
	�s�p�ӂɃT�C�Y��ύX�������Ȃ����Ɏg�p���Ă��������B

	���̐ݒ�̓E�B���h�E�g�ɂ��T�C�Y�ύX���֎~�ɂȂ邾���ŁA
	[_text pos=winResMenu]�̃��j���[�ł̃T�C�Y�ύX�͏�ɗL���ł��B

	�T�C�Y�Œ��Ԃł́A�E�B���h�E�^�C�g���o�[�̍ő剻�{�^����
	�t���X�N���[���\������ɂȂ�܂��B
	[endindent]
	@/ul

@_end
*menu.fsres|&brows.getText("pos","fsres")
@_begin

	�t���X�N���[���ɐ؂�ւ��鎞�Ƀ��j�^�̉𑜓x��ύX���邩�ǂ������ȉ��őI���ł��܂��B

	@ul
	[li]�u[_fullsel tag=fsres.auto]�v�͎����œK�؂ȉ𑜓x��I�����܂��B
	[li]�u[_fullsel tag=fsres.nochange]�v�͉𑜓x��ύX�����Ƀ\�t�g�E�F�A�Ŋg�債�ĕ\�����܂��B
	[li]�u[_fullsel tag=fsres.nearest]�v�̓Q�[���̉�ʃT�C�Y�ɍł��߂��𑜓x�ɕύX���܂��B
	[li]�u[_fullsel tag=fsres.proportional]�v�̓Q�[����ʂ̏c����Ɠ����𑜓x�ōł��߂����̂ɕύX���܂��B
	@/ul


	�c����̈Ⴂ�Ń��j�^��ʂɃt�B�b�g���Ȃ��ꍇ�A�ǂ̂悤�ɕ\�����邩���ȉ��őI���ł��܂��B
	�ݒ���e�͉��̐}���Q�l�ɂ��Ă��������B

	@ul
	[li]�u[_fullsel tag=fszoom.inner]�v
	[li]�u[_fullsel tag=fszoom.outer]�v
	[li]�u[_fullsel tag=fszoom.no]�v
	@/ul
	[_cimg file=help_fszoom]
	����Ԃɂ���Ă͐ݒ��ύX�ł��Ȃ��ꍇ������܂��B�ڂ�����[_link tag=faq.fullscr text=�������������������]�B
@_end
*menu.dbuf|&brows.getText("pos","dbstyle")
@_begin

	@ul
	[li][_text pos=dbstyle]
	�@��ʂ̕\��������ύX���܂��B
	�@�u[_text name=dbstyle.auto]�v�͍œK�ȃp�t�H�[�}���X���o��悤�ȕ����������őI�����܂��B

	[li][_text name=usedb]
	�@�E�B���h�E�T�C�Y���W���̎��ȂǁA�\���̊g���k���������ꍇ�ɂ�
	�@DIB�����i�o�b�t�@�����O�Ȃ��̉摜�]���j���g�p����悤�ɂ��܂��B
	�@���̍��ڂ�[_text pos=dbstyle]���u[_text name=dbstyle.d3d]�v��u[_text name=dbstyle.ddraw]�v�ł͏�ɖ����ƂȂ�܂��B
	@/ul

@_end
*menu.smooth|&brows.getText("pos","smoothzoom")
@_begin

	[_click tag=smoothzoom text=�`�F�b�N]������ƃ\�t�g�E�F�A�ɂ��g��\�����s��ꂽ�Ƃ��ɁA
	�摜�̃X���[�W���O�i�����L�΂��̕�ԏ����j���s���܂��B

	�E�B���h�E�̃T�C�Y��ύX��������A�𑜓x��ύX���Ȃ��t���X�N���[���ɂ������ɈӖ��������܂��B
	[_text pos=dbstyle]��[_text pos=fsres]�̐ݒ�ɂ���Ă͌��ʂ��Ȃ��ꍇ������܂��B

@_end
*menu.effect|&brows.getText("pos","effectCheckMenuItem")
@_begin

	�`�F�b�N������Ɖ�ʂ̃t�F�[�h�؂�ւ��Ȃǂ̉��o���J�b�g���܂��B

@_end
*menu.fps|&brows.getText("pos","contfreq")
@_begin

	��ʂ̍X�V�̊Ԋu���w�肵�܂��B
	�u[_text name=contfreq.0]�v��u[_text name=contfreq.60]�v�ɂ���ƕ\�����Ȃ߂炩�ɂȂ�܂����ACPU�ւ̕��S���傫���Ȃ�܂��B

@_end
*menu.vomstyle|&brows.getText("pos","vomstyle.")
@_begin

	���[�r�[�̕\��������ύX���܂��B
	�\������Ȃ��ꍇ��g��\�����Y��łȂ��ꍇ�ɕύX���Ă��������B

	@ul
	[li]�u[_click tag=vomstyle.auto]�v��Windows�̃o�[�W�����ōœK�ȕ��@�������őI�����܂��B

	[li]�u[_click tag=vomstyle.overlay]�v�͋����̃I�[�o���C�������g�p���܂��B

	[li]�u[_click tag=vomstyle.mixer]�v��DirectX9�ȍ~���K�v�ł��B�\���Ɏ��s����Ɓu[_text name=vomstyle.overlay]�v�������g�p����܂��B

	[li][indent]�u[_click tag=vomstyle.layer]�v�͑��̏ꍇ�ɐ������\������܂����A
	�����̌��������[�r�[�ł�[_link tag=faq.tier text=��ʂ��`���`������]���Ƃ�����܂��B
	@endindent

@_end
*menu.fsmode|&brows.getText("pos","fullscreenmode.")
@_begin

	�}���`���j�^���ł�[_link tag=faq.fullscr text=�t���X�N���[������]��ݒ肵�܂��B

	@ul
	[li][indent]�u[_fullsel tag=fullscreenmode.auto]�v
	�V���O�����j�^���ł́u[_text name=fullscreenmode.primaryonly]�v���A
	�}���`���j�^���ł́u[_text name=fullscreenmode.pseudoall]�v���A�����őI������܂��B[endindent]
	[ul]
	[li]�u[_fullsel tag=fullscreenmode.primaryonly]�v��

	[li]�u[_fullsel tag=fullscreenmode.usepseudo]�v��

	[li]�u[_fullsel tag=fullscreenmode.pseudoall]�v��
	@/ul

@_end
*menu.fsmethod|&brows.getText("pos","fsmethod")
@_begin

	�𑜓x��؂�ւ���̂�DirectX�̋@�\���g��Ȃ��悤�ɂ���ݒ�ł��B
	�`�F�b�N�������Windows�W���̉𑜓x�؂�ւ����@���g�p���܂��B

@_end
*menu.vsync|&brows.getText("pos","waitvsync")
@_begin

	���j�^�̐���������҂��Ă���`�悷�邩�ǂ����̐ݒ�ł��B
	�`�F�b�N�����ėL���ɂ���ƕ`��̃p�t�H�[�}���X���ቺ���邱�Ƃ�����܂��B
	�܂��A�L���ɂ����ꍇ[_link tag=menu.fps]�̐ݒ�͖�������܂��B

@_end
*menu.wheel|&brows.getText("pos","wheel")
@_begin

	�}�E�X�̃z�C�[�����͂�DirectInput���g�p���Ȃ��悤�ɂ���ݒ�ł��B
	�`�F�b�N�������DirectInput�̑���ɃE�B���h�E���b�Z�[�W���g�p���܂��B
	�}�E�X�̃z�C�[�����������Ȃ��ꍇ�ɂ�����������Ă݂Ă��������B

@_end
*menu.joypad|&brows.getText("pos","joypad")
@_begin

	�Q�[���p�b�h�̔����𖳌��ɂ��邩�ǂ����̐ݒ�ł��B
	�`�F�b�N�����Ė����ɂ���ƁA�Q�[���p�b�h���ڑ�����Ă��Ă��������܂��B
	�Q�[���p�b�h���L�[�{�[�h���͂Ɋ��蓖�Ă�\�t�g���g���Ă���ꍇ�ɂ��g�p���������B

@_end
*menu.lowmem|&brows.getText("pos","memusage")
@_begin

	[_click tag=memusage text=�`�F�b�N]�����čċN������ƁA�ł��邾�����Ȃ��������œ��삷��悤�ɂȂ�܂��B

	�������̏��Ȃ����ł̓Q�[���S�ʂ̓��쑬�x�����P�����ꍇ������܂����A
	�������̏\��������ł́i�摜�L���b�V���Ȃǂ������ɂȂ邽�߁j�t�ɓ��삪�x���Ȃ�܂��B

	@ul
	[li][_text section=faq]��[_link tag=faq.slow]���Q�Ƃ��Ă��������B
	@/ul

@_end
;----------------------------------------------------------------
*support|���₢���킹�ɂ���
@_begin

	[_text pos=helpWebMenuItem default=���j���[]����[_homepage text=�z�[���y�[�W]���J���A\
	[_text game=���̃Q�[��]�̃T�|�[�g�y�[�W���炨�₢���킹���������B

	@if exp='brows.getEnabledMenuItem("helpReadmeMenuItem")'
		�z�[���y�[�W���J���Ȃ��ꍇ�́u[_readme]�v��[_text game=���̃Q�[��]�̃}�j���A�������m�F���������B
		
	@endif
	����̂��₢���킹�̍ۂɂ�[_text pos=helpSupportToolsMenuItem]����[_sptool text=�T�|�[�g�c�[��]���N�����A
	�w�����ۑ��x��I��ŕ\�����ꂽ�e�L�X�g���R�s�[���Ă��m�点���������B

	@_cimg file=help_env

@_end
;----------------------------------------------------------------

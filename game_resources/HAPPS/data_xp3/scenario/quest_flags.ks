;///////////////////////////////////////////////////////////////////////////////
; �N�G�X�g��`�t�@�C��
;
; �����̃V�i���I�͌��肳�ꂽ�^�O�����g���܂���i�ʏ�̃V�i���I�Ŏg����^�O��NG�j
;
;
;-------------------------------------------------------------------------------
; �S�̐ݒ�
;
; �����G�L�����ړ���[px]
@option chmove=50
;
; �V�i���I�J�n���Ƀo�b�N���O�Ɏc���e�L�X�g(comment=�������"�F"�Ōq���ĕ\���j
@option scnselected="�v���C�J�n"
;
; �^�C�g����ʂ���̕\���̏ꍇ�� f.* �ł͂Ȃ� sf.* ���Q�Ƃ���(�I�i�j�[�����ɉe���F���܂ł̃v���C�̗ݐςŕ\��)
@option staticflag=&'page.indexOf("title")>=0'
;
; �I�i�j�[�����i��`�t�@�C���j            ���e�L�X�g�\���ɂ��āCUI����̉摜���g�p����ꍇ��false
@option subtext="ona_history.ks" drawtext=true hidetext=false
;                                                       ����0�̃L�����̗������ƕ\�����Ȃ��ꍇ��true
;
; �y�[�W����p�}�N���ipage=xyz �Ō��݂̃y�[�W�������ꍇ�� *xyz �փW�����v����j
[macro name="page_branch"][jump target='&@"*${mp.page}"' cond='&@"page==${$34}${mp.page}${$34}"'][endmacro]
@page_branch page="title"
;
;-------------------------------------------------------------------------------
; ���C���L�����U���󋵏���
;
@pmacro name="�U���󋵁F仉�"			comment="仉�"		point="sca01h:sca02h:sca03h:sca04h:sca05h:sca06h"
@pmacro name="�U���󋵁F���T��"			comment="���T��"	point="scb01h:scb02h:scb03h:scb04h:scb05h"
@pmacro name="�U���󋵁F��"			comment="��"		point="scc01h:scc02h:scc03h:scc04h:scc05h"
@pmacro name="�U���󋵁F�ށX�q"			comment="�ށX�q"	point="scd01h:scd02h:scd03h:scd04h:scd05h:scd06h"
@pmacro name="�U���󋵁F����"			comment="����"		point="sce01h:sce02h:sce03h:sce04h:sce05h"
@pmacro name="�U���󋵁F�ЂȂ�"			comment="�ЂȂ�"	point="scf01h:scf02h:scf03h:scf04h:scf05h"
@pmacro name="�U���󋵁F��"			comment="��"		point="scg01h:scg02h:scg03h:scg04h:scg05h"
@pmacro name="�U���󋵁F�D�ؗ�"			comment="�D�ؗ�"	point="sch01h:sch02h:sch03h:sch04h:sch05h"
@pmacro name="�U���󋵁F�����A"			comment="�����A"	point="sci01h:sci02h:sci03h:sci04h:sci05h"
@pmacro name="�U���󋵁F���[�V��"		comment="���[�V��"	point="scj01h:scj02h:scj03h:scj04h:scj05h"
;
;-------------------------------------------------------------------------------
; �G���h����
;
@pmacro name="�G���h�����F�n�[����"		eval="sca03h && scb03h && scc03h && scd03h && sce03h && scf03h && scg03h && sch03h && sci03h && scj03h"
@pmacro name="�G���h�����F��e�n�[����"		eval="sca20h && scb20h && scc20h && scd20h && sce20h && scf20h && scg20h && sch20h && sci20h && scj20h"
@pmacro name="�G���h�����F仉�"    		eval="sca06h"
;
;-------------------------------------------------------------------------------
; �T�u�L�����g�I�[�v������
;
@pmacro name="�T�u�L�����F�G����"		comment="�G����"	eval="st03"	point="sck01h"
@pmacro name="�T�u�L�����F�߂���"		comment="�߂���"	eval="st02"	point="scl01h"
@pmacro name="�T�u�L�����F�O"			comment="�O"		eval="st01"	point="scm01h"
@pmacro name="�T�u�L�����F���"			comment="���"		eval="st07"	point="scn01h"
@pmacro name="�T�u�L�����F��"			comment="��"		eval="st06"	point="sco01h"
@pmacro name="�T�u�L�����F�F�q"			comment="�F�q"		eval="st04"	point="scp01h"
@pmacro name="�T�u�L�����F���Ȃ�"		comment="���Ȃ�"	eval="st05"	point="scq01h"
@pmacro name="�T�u�L�����F���q"			comment="���q"		eval="st09"	point="scr01h"
@pmacro name="�T�u�L�����F��q"			comment="��q"		eval="st08"	point="scs01h"
@pmacro name="�T�u�L�����Fꡍ�"			comment="ꡍ�"		eval="sch01h"	point="sct01h"
;
;-------------------------------------------------------------------------------
; �e�q���g�I�[�v������
;
@pmacro name="�e�q���F仉�"			eval="sca03h"
@pmacro name="�e�q���F���T��"			eval="scb04h"
@pmacro name="�e�q���F��"			eval="scc02h"
@pmacro name="�e�q���F�ށX�q"			eval="scd04h"
@pmacro name="�e�q���F����"			eval="sce02h"
@pmacro name="�e�q���F�ЂȂ�"			eval="scf03h"
@pmacro name="�e�q���F��"			eval="scg04h"
@pmacro name="�e�q���F�D�ؗ�"			eval="sch04h"
@pmacro name="�e�q���F�����A"			eval="sci04h"
@pmacro name="�e�q���F���[�V��"			eval="scj04h"
;
;-------------------------------------------------------------------------------
; �u�[�g�L�����v�g�I�[�v������
;
@pmacro name="�u�[�g�L�����v�F仉�"		eval="sca01h"
@pmacro name="�u�[�g�L�����v�F���T��"		eval="scb03h"
@pmacro name="�u�[�g�L�����v�F��"		eval="scc04h"
@pmacro name="�u�[�g�L�����v�F�ށX�q"		eval="scd03h"
@pmacro name="�u�[�g�L�����v�F����"		eval="sce02h"
@pmacro name="�u�[�g�L�����v�F�ЂȂ�"		eval="scf01h"
@pmacro name="�u�[�g�L�����v�F��"		eval="scg02h"
@pmacro name="�u�[�g�L�����v�F�D�ؗ�"		eval="sch03h"
@pmacro name="�u�[�g�L�����v�F�����A"		eval="sci02h"
@pmacro name="�u�[�g�L�����v�F���[�V��"		eval="scj03h"
;
;-------------------------------------------------------------------------------
; ���l���g�I�[�v������
;
@pmacro name="���l���F�l�Ȃ����ς��o���["	eval="sca20h && scb20h && scc20h && scj20h"
@pmacro name="���l���F����I�V���C"		eval="scx08h"
@pmacro name="���l���F�p�C�Y���ŕa"		eval="scb03h && scd03h && scf03h"
@pmacro name="���l���F�ĔL�J�t�F"		eval="scx01h"
@pmacro name="���l���F���o���ԉΑ��"		eval="scx02h"
@pmacro name="���l���F�����o�j�[�K�[��"		eval="scx03h"
@pmacro name="���l���F�����ς��l�ȗ�̎Q�ϓ�"	eval="sca20h && scd20h && sce20h && scf20h && scg20h && sch20h"
;
;-------------------------------------------------------------------------------
; main2�I��
; �U���󋵂̈ꗗ����{�^�������ԂɊJ���Ă������߂̃}�N��
[macro name="screen_main2"]
@screen page=%page storage='&"quest_"+mp.page' rclick=main
@main   page=%page name=wave0 pointtag=%page pointnew=%point pointindex=0	storage=gameloop.txt target='&mp.target+"_1"'
@main   page=%page name=wave1 pointtag=%page pointnew=%point pointindex=1	storage=gameloop.txt target='&mp.target+"_2"'
@main   page=%page name=wave2 pointtag=%page pointnew=%point pointindex=2	storage=gameloop.txt target='&mp.target+"_3"'
@main   page=%page name=wave3 pointtag=%page pointnew=%point pointindex=3	storage=gameloop.txt target='&mp.target+"_4"'
@main   page=%page name=wave4 pointtag=%page pointnew=%point pointindex=4	storage=gameloop.txt target='&mp.target+"_5"'
@main   page=%page name=wave5 pointtag=%page pointnew=%point pointindex=5	storage=gameloop.txt target='&mp.target+"_6"'
@main   page=%page name=wave6 pointtag=%page pointnew=%point pointindex=6	storage=gameloop.txt target='&mp.target+"_7"' cond="&GetQuestPointCount(mp.point)>5"
@button page=%page name=back to=main
@exit
[endmacro]
;
;-------------------------------------------------------------------------------
;���C���t�H�[���[�V�����\�����s�v�ȃy�[�W�͂��̒i�K�ŕ���
;
; ���o�����I���i�V�i���I�r���ł̌Ăяo���j
@page_branch page="odekake"
;
; �e��X�e�[�^�X���
@page_branch page="status"
@page_branch page="status_sub"
@page_branch page="status_sub_title"
@page_branch page="status_main_title"
;
; �C���t�H�[���[�V�����͑I����ʂ��J��������݂̂ŏ\���Ȃ̂Ńy�[�W�J�ڎ��̓X�L�b�v
@jump target=*page cond=reload
;-------------------------------------------------------------------------------
; �C���t�H�[���[�V�����\�������ꗗ
;
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=k	flag=sub_k	�T�u�L�����F�G����
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=l	flag=sub_l	�T�u�L�����F�߂���
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=m	flag=sub_m	�T�u�L�����F�O
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=n	flag=sub_n	�T�u�L�����F���
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=o	flag=sub_o	�T�u�L�����F��
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=p	flag=sub_p	�T�u�L�����F�F�q
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=q	flag=sub_q	�T�u�L�����F���Ȃ�
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=r	flag=sub_r	�T�u�L�����F���q
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=s	flag=sub_s	�T�u�L�����F��q
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I"	subtag=t	flag=sub_t	�T�u�L�����Fꡍ�
;
@info tag=i_x01 text="�w���C�h�ĔL�J�t�F�A�v���I�x�����l���G���y�[�W�ɒǉ��I"				flag=mul_1	���l���F�ĔL�J�t�F
@info tag=i_x02 text="�w�Z�[���[�������o���ԉΑ��A�v���I�x�����l���G���y�[�W�ɒǉ��I"			flag=mul_2	���l���F���o���ԉΑ��
@info tag=i_x03 text="�w�����o�j�[�K�[���A�v���I�x�����l���G���y�[�W�ɒǉ��I"				flag=mul_3	���l���F�����o�j�[�K�[��
@info tag=i_x04 text="�w�g���v���p�C�Y���i�[�X�A�v���I�x�����l���G���y�[�W�ɒǉ��I"			flag=mul_4	���l���F�p�C�Y���ŕa
@info tag=i_x05 text="�w�l�Ȃ����ς��o���[�n�[�����I�x�����l���G���y�[�W�ɒǉ��I"			flag=mul_5	���l���F�l�Ȃ����ς��o���[
@info tag=i_x06 text="�w�����ς��l�ȗ�̃v�[���Q�ϓ��A�v���I�x�����l���G���y�[�W�ɒǉ��I"		flag=mul_6	���l���F�����ς��l�ȗ�̎Q�ϓ�
@info tag=i_x07 text="�w���������I����I�V���C�I�x�����l���G���y�[�W�ɒǉ��I"				flag=mul_7	���l���F����I�V���C
;
@info tag=i_a01 text="�s�܂��n�[�����G���h�����i仉��j�𖞂����܂����I"					eval="sca03h"
@info tag=i_b01 text="�s�܂��n�[�����G���h�����i���T���j�𖞂����܂����I"				eval="scb03h"
@info tag=i_c01 text="�s�܂��n�[�����G���h�����i���j�𖞂����܂����I"					eval="scc03h"
@info tag=i_d01 text="�s�܂��n�[�����G���h�����i�ށX�q�j�𖞂����܂����I"				eval="scd03h"
@info tag=i_e01 text="�s�܂��n�[�����G���h�����i����j�𖞂����܂����I"					eval="sce03h"
@info tag=i_f01 text="�s�܂��n�[�����G���h�����i�ЂȂ��j�𖞂����܂����I"				eval="scf03h"
@info tag=i_g01 text="�s�܂��n�[�����G���h�����i���j�𖞂����܂����I"					eval="scg03h"
@info tag=i_h01 text="�s�܂��n�[�����G���h�����i�D�ؗ��j�𖞂����܂����I"				eval="sch03h"
@info tag=i_i01 text="�s�܂��n�[�����G���h�����i�����A�j�𖞂����܂����I"				eval="sci03h"
@info tag=i_j01 text="�s�܂��n�[�����G���h�����i���[�V���j�𖞂����܂����I"				eval="scj03h"
;													�����u�G���h�����F�n�[�����v�̌X�̃V�i���I�ʉ߃t���O�ł��邱�Ƃɒ���
;
@info tag=i_a02 text="仉��̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_a	�e�q���F仉�
@info tag=i_b02 text="���T���̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_b	�e�q���F���T��
@info tag=i_c02 text="���̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_c	�e�q���F��
@info tag=i_d02 text="�ށX�q�̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_d	�e�q���F�ށX�q
@info tag=i_e02 text="����̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_e	�e�q���F����
@info tag=i_f02 text="�ЂȂ��̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_f	�e�q���F�ЂȂ�
@info tag=i_g02 text="���̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_g	�e�q���F��
@info tag=i_h02 text="�D�ؗ��̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_h	�e�q���F�D�ؗ�
@info tag=i_i02 text="�����A�̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_i	�e�q���F�����A
@info tag=i_j02 text="���[�V���̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_j	�e�q���F���[�V��
;
@info tag=i_a03	text="�����ς�����u�[�g�L�����v�y�[�W��仉��V�i���I���ǉ�����܂����I"			�u�[�g�L�����v�F仉�		flag=camp_a
@info tag=i_b03	text="�����ς�����u�[�g�L�����v�y�[�W�ɗ��T���V�i���I���ǉ�����܂����I"		�u�[�g�L�����v�F���T��		flag=camp_b
@info tag=i_c03	text="�����ς�����u�[�g�L�����v�y�[�W�ɏ��V�i���I���ǉ�����܂����I"			�u�[�g�L�����v�F��		flag=camp_c
@info tag=i_d03	text="�����ς�����u�[�g�L�����v�y�[�W�ɓށX�q�V�i���I���ǉ�����܂����I"		�u�[�g�L�����v�F�ށX�q		flag=camp_d
@info tag=i_e03	text="�����ς�����u�[�g�L�����v�y�[�W�ɖ���V�i���I���ǉ�����܂����I"			�u�[�g�L�����v�F����		flag=camp_e
@info tag=i_f03	text="�����ς�����u�[�g�L�����v�y�[�W�ɂЂȂ��V�i���I���ǉ�����܂����I"		�u�[�g�L�����v�F�ЂȂ�		flag=camp_f
@info tag=i_g03	text="�����ς�����u�[�g�L�����v�y�[�W�ɕ��V�i���I���ǉ�����܂����I"			�u�[�g�L�����v�F��		flag=camp_g
@info tag=i_h03	text="�����ς�����u�[�g�L�����v�y�[�W�ɗD�ؗ��V�i���I���ǉ�����܂����I"		�u�[�g�L�����v�F�D�ؗ�		flag=camp_h
@info tag=i_i03	text="�����ς�����u�[�g�L�����v�y�[�W�Ƀ����A�V�i���I���ǉ�����܂����I"		�u�[�g�L�����v�F�����A		flag=camp_i
@info tag=i_j03	text="�����ς�����u�[�g�L�����v�y�[�W�Ƀ��[�V���V�i���I���ǉ�����܂����I"		�u�[�g�L�����v�F���[�V��	flag=camp_j
;
; �I�i�j�[�񐔂݂̂̍X�V�ōX�V�ʒm���K�v�ȏꍇ�͉��L���R�����g�A�E�g
@pmacro name=onakeep text=""
;
; �L�����ʃI�i�j�[����							�񐔂̂݁H	�i���x		����
@info tag=i_a04 text="仉��̃I�i�j�[�������X�V���܂����I"				subtag=_1	eval="sca01h"	withsflag	flag=ona_a1
@info tag=i_a04 text="仉��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_2	eval="sca02h"	withsflag	flag=ona_a2
@info tag=i_a04 text="仉��̃I�i�j�[�������X�V���܂����I"				subtag=_3	eval="sca03h"	withsflag	flag=ona_a3
@info tag=i_a04 text="仉��̃I�i�j�[�������X�V���܂����I"				subtag=_4	eval="sca04h"	withsflag	flag=ona_a4
@info tag=i_a04 text="仉��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_5	eval="sca05h"	withsflag	flag=ona_a5
@info tag=i_a04 text="仉��̃I�i�j�[�������X�V���܂����I"				subtag=_6	eval="sca06h"	withsflag	flag=ona_a6
@info tag=i_a04 text="仉��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_oya	eval="sca20h"	withsflag	flag=ona_a_oya
@info tag=i_a04 text="仉��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_camp	eval="sca30h"	withsflag	flag=ona_a_camp
;
@info tag=i_b04 text="���T���̃I�i�j�[�������X�V���܂����I"				subtag=_1	eval="scb01h"	withsflag	flag=ona_b1
@info tag=i_b04 text="���T���̃I�i�j�[�������X�V���܂����I"				subtag=_2	eval="scb02h"	withsflag	flag=ona_b2
@info tag=i_b04 text="���T���̃I�i�j�[�������X�V���܂����I"				subtag=_3	eval="scb03h"	withsflag	flag=ona_b3
@info tag=i_b04 text="���T���̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_4	eval="scb04h"	withsflag	flag=ona_b4
@info tag=i_b04 text="���T���̃I�i�j�[�������X�V���܂����I"				subtag=_5	eval="scb05h"	withsflag	flag=ona_b5
@info tag=i_b04 text="���T���̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_oya	eval="scb20h"	withsflag	flag=ona_b_oya
@info tag=i_b04 text="���T���̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_camp	eval="scb30h"	withsflag	flag=ona_b_camp
;
@info tag=i_c04 text="���̃I�i�j�[�������X�V���܂����I"					subtag=_1	eval="scc01h"	withsflag	flag=ona_c1
@info tag=i_c04 text="���̃I�i�j�[�������X�V���܂����I"					subtag=_2	eval="scc02h"	withsflag	flag=ona_c2
@info tag=i_c04 text="���̃I�i�j�[�������X�V���܂����I"			onakeep		subtag=_3	eval="scc03h"	withsflag	flag=ona_c3
@info tag=i_c04 text="���̃I�i�j�[�������X�V���܂����I"					subtag=_4	eval="scc04h"	withsflag	flag=ona_c4
@info tag=i_c04 text="���̃I�i�j�[�������X�V���܂����I"					subtag=_5	eval="scc05h"	withsflag	flag=ona_c5
@info tag=i_c04 text="���̃I�i�j�[�������X�V���܂����I"			onakeep		subtag=_oya	eval="scc20h"	withsflag	flag=ona_c_oya
@info tag=i_c04 text="���̃I�i�j�[�������X�V���܂����I"			onakeep		subtag=_camp	eval="scc30h"	withsflag	flag=ona_c_camp
;
@info tag=i_d04 text="�ށX�q�̃I�i�j�[�������X�V���܂����I"				subtag=_1	eval="scd01h"	withsflag	flag=ona_d1
@info tag=i_d04 text="�ށX�q�̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_2	eval="scd02h"	withsflag	flag=ona_d2
@info tag=i_d04 text="�ށX�q�̃I�i�j�[�������X�V���܂����I"				subtag=_3	eval="scd03h"	withsflag	flag=ona_d3
@info tag=i_d04 text="�ށX�q�̃I�i�j�[�������X�V���܂����I"				subtag=_4	eval="scd04h"	withsflag	flag=ona_d4
@info tag=i_d04 text="�ށX�q�̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_5	eval="scd05h"	withsflag	flag=ona_d5
@info tag=i_d04 text="�ށX�q�̃I�i�j�[�������X�V���܂����I"				subtag=_6	eval="scd06h"	withsflag	flag=ona_d6
@info tag=i_d04 text="�ށX�q�̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_oya	eval="scd20h"	withsflag	flag=ona_d_oya
@info tag=i_d04 text="�ށX�q�̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_camp	eval="scd30h"	withsflag	flag=ona_d_camp
;
@info tag=i_e04 text="����̃I�i�j�[�������X�V���܂����I"				subtag=_1	eval="sce01h"	withsflag	flag=ona_e1
@info tag=i_e04 text="����̃I�i�j�[�������X�V���܂����I"				subtag=_2	eval="sce02h"	withsflag	flag=ona_e2
@info tag=i_e04 text="����̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_3	eval="sce03h"	withsflag	flag=ona_e3
@info tag=i_e04 text="����̃I�i�j�[�������X�V���܂����I"				subtag=_4	eval="sce04h"	withsflag	flag=ona_e4
@info tag=i_e04 text="����̃I�i�j�[�������X�V���܂����I"				subtag=_5	eval="sce05h"	withsflag	flag=ona_e5
@info tag=i_e04 text="����̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_oya	eval="sce20h"	withsflag	flag=ona_e_oya
@info tag=i_e04 text="����̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_camp	eval="sce30h"	withsflag	flag=ona_e_camp
;
@info tag=i_f04 text="�ЂȂ��̃I�i�j�[�������X�V���܂����I"				subtag=_1	eval="scf01h"	withsflag	flag=ona_f1
@info tag=i_f04 text="�ЂȂ��̃I�i�j�[�������X�V���܂����I"				subtag=_2	eval="scf02h"	withsflag	flag=ona_f2
@info tag=i_f04 text="�ЂȂ��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_3	eval="scf03h"	withsflag	flag=ona_f3
@info tag=i_f04 text="�ЂȂ��̃I�i�j�[�������X�V���܂����I"				subtag=_4	eval="scf04h"	withsflag	flag=ona_f4
@info tag=i_f04 text="�ЂȂ��̃I�i�j�[�������X�V���܂����I"				subtag=_5	eval="scf05h"	withsflag	flag=ona_f5
@info tag=i_f04 text="�ЂȂ��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_oya	eval="scf20h"	withsflag	flag=ona_f_oya
@info tag=i_f04 text="�ЂȂ��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_camp	eval="scf30h"	withsflag	flag=ona_f_camp
;
@info tag=i_g04 text="���̃I�i�j�[�������X�V���܂����I"					subtag=_1	eval="scg01h"	withsflag	flag=ona_g1
@info tag=i_g04 text="���̃I�i�j�[�������X�V���܂����I"					subtag=_2	eval="scg02h"	withsflag	flag=ona_g2
@info tag=i_g04 text="���̃I�i�j�[�������X�V���܂����I"					subtag=_3	eval="scg03h"	withsflag	flag=ona_g3
@info tag=i_g04 text="���̃I�i�j�[�������X�V���܂����I"			onakeep		subtag=_4	eval="scg04h"	withsflag	flag=ona_g4
@info tag=i_g04 text="���̃I�i�j�[�������X�V���܂����I"					subtag=_5	eval="scg05h"	withsflag	flag=ona_g5
@info tag=i_g04 text="���̃I�i�j�[�������X�V���܂����I"			onakeep		subtag=_oya	eval="scg20h"	withsflag	flag=ona_g_oya
@info tag=i_g04 text="���̃I�i�j�[�������X�V���܂����I"			onakeep		subtag=_camp	eval="scg30h"	withsflag	flag=ona_g_camp
;
@info tag=i_h04 text="�D�ؗ��̃I�i�j�[�������X�V���܂����I"				subtag=_1	eval="sch01h"	withsflag	flag=ona_h1
@info tag=i_h04 text="�D�ؗ��̃I�i�j�[�������X�V���܂����I"				subtag=_2	eval="sch02h"	withsflag	flag=ona_h2
@info tag=i_h04 text="�D�ؗ��̃I�i�j�[�������X�V���܂����I"				subtag=_3	eval="sch03h"	withsflag	flag=ona_h3
@info tag=i_h04 text="�D�ؗ��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_4	eval="sch04h"	withsflag	flag=ona_h4
@info tag=i_h04 text="�D�ؗ��̃I�i�j�[�������X�V���܂����I"				subtag=_5	eval="sch05h"	withsflag	flag=ona_h5
@info tag=i_h04 text="�D�ؗ��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_oya	eval="sch20h"	withsflag	flag=ona_h_oya
@info tag=i_h04 text="�D�ؗ��̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_camp	eval="sch30h"	withsflag	flag=ona_h_camp
;
@info tag=i_i04 text="�����A�̃I�i�j�[�������X�V���܂����I"				subtag=_1	eval="sci01h"	withsflag	flag=ona_i1
@info tag=i_i04 text="�����A�̃I�i�j�[�������X�V���܂����I"				subtag=_2	eval="sci02h"	withsflag	flag=ona_i2
@info tag=i_i04 text="�����A�̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_3	eval="sci03h"	withsflag	flag=ona_i3
@info tag=i_i04 text="�����A�̃I�i�j�[�������X�V���܂����I"				subtag=_4	eval="sci04h"	withsflag	flag=ona_i4
@info tag=i_i04 text="�����A�̃I�i�j�[�������X�V���܂����I"				subtag=_5	eval="sci05h"	withsflag	flag=ona_i5
@info tag=i_i04 text="�����A�̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_oya	eval="sci20h"	withsflag	flag=ona_i_oya
@info tag=i_i04 text="�����A�̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_camp	eval="sci30h"	withsflag	flag=ona_i_camp
;
@info tag=i_j04 text="���[�V���̃I�i�j�[�������X�V���܂����I"				subtag=_1	eval="scj01h"	withsflag	flag=ona_j1
@info tag=i_j04 text="���[�V���̃I�i�j�[�������X�V���܂����I"				subtag=_2	eval="scj02h"	withsflag	flag=ona_j2
@info tag=i_j04 text="���[�V���̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_3	eval="scj03h"	withsflag	flag=ona_j3
@info tag=i_j04 text="���[�V���̃I�i�j�[�������X�V���܂����I"				subtag=_4	eval="scj04h"	withsflag	flag=ona_j4
@info tag=i_j04 text="���[�V���̃I�i�j�[�������X�V���܂����I"				subtag=_5	eval="scj05h"	withsflag	flag=ona_j5
@info tag=i_j04 text="���[�V���̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_oya	eval="scj20h"	withsflag	flag=ona_j_oya
@info tag=i_j04 text="���[�V���̃I�i�j�[�������X�V���܂����I"		onakeep		subtag=_camp	eval="scj30h"	withsflag	flag=ona_j_camp
;
@info tag=i_a05 text="仉��V�i���I�����S�U�����܂����I"							eval="sca06h"
@info tag=i_b05 text="���T���V�i���I�����S�U�����܂����I"						eval="scb05h"
@info tag=i_c05 text="���V�i���I�����S�U�����܂����I"							eval="scc05h"
@info tag=i_d05 text="�ށX�q�V�i���I�����S�U�����܂����I"						eval="scd06h"
@info tag=i_e05 text="����V�i���I�����S�U�����܂����I"							eval="sce05h"
@info tag=i_f05 text="�ЂȂ��V�i���I�����S�U�����܂����I"						eval="scf05h"
@info tag=i_g05 text="���V�i���I�����S�U�����܂����I"							eval="scg05h"
@info tag=i_h05 text="�D�ؗ��V�i���I�����S�U�����܂����I"						eval="sch05h"
@info tag=i_i05 text="�����A�V�i���I�����S�U�����܂����I"						eval="sci05h"
@info tag=i_j05 text="���[�V���V�i���I�����S�U�����܂����I"						eval="scj05h"
;
@info tag=i_s01 text="�u�s�܂��I�n�[�����G���h�I�v�����𖞂����܂����I"			flag=end_1	�G���h�����F�n�[����
@info tag=i_s02 text="�u�����ς���e�I�s�܂��I�n�[�����G���h�I�v�����𖞂����܂����I"	flag=end_2	�G���h�����F��e�n�[����
@info tag=i_a06 text="�w仉��G���f�B���O�x�̏����𖞂����܂����I"			flag=end_a	�G���h�����F仉�
@info tag=i_s03 text="CG��100���ɂȂ�܂����I"						sflag		eval=".sf.cg_complete"
;
@info tag=i_s05 text="�u�G���f�B���O�I�����v�ɂ�����悤�ɂȂ�܂����I"			flag=ending	eval="end_1 || end_2 || end_a"
@info tag=i_s06 text="�u�X�e�[�W�X�L�b�v�{�^���v���g����悤�ɂȂ�܂����I"		flag=chaptskip	eval="end_1 || end_2 || end_a"
@info tag=i_s99 text="����ȍ~�̃X�e�[�W�͂���܂���I\n�G���f�B���O�I���ŃQ�[�����N���A���Ă��������I"	eval="���݂̃X�e�[�W==14"
;
; �I�i�j�[�������X�V(info�����Ă�t���O�Ɉˑ�����̂ł����ɔz�u)
@subtext
;
;-------------------------------------------------------------------------------
;���e�y�[�W�̐ݒ�փW�����v
;
*page
@page_branch page="main"
@page_branch page="sub"
@page_branch page="boot_camp"
@page_branch page="oyako"
@page_branch page="multi"
@page_branch page="ending"
;@page_branch page="ending14"
; ���I�i�j�[�񐔂̍X�V�������K�v�Ȃ��߁Cstatus_main�͂��̈ʒu�ɔz�u
@page_branch page="status_main"
;
; �emain2�I����
@page_branch page="main2_a"
@page_branch page="main2_b"
@page_branch page="main2_c"
@page_branch page="main2_d"
@page_branch page="main2_e"
@page_branch page="main2_f"
@page_branch page="main2_g"
@page_branch page="main2_h"
@page_branch page="main2_i"
@page_branch page="main2_j"
;-------------------------------------------------------------------------------
; ����ȊO�̃y�[�W�̓G���[
@error message='&"�s���ȃy�[�W�ł�:"+page'
;-------------------------------------------------------------------------------
; ���C���I��
;
*main|
@screen page=main storage=quest_main rclick=""
;
@button page=main name=to_status      comment="��l���v���t�B�[��"	to=status
@button page=main name=to_status_main comment="���C���L�����v���t"	to=status_main
@button page=main name=to_status_sub  comment="�T�u�L�����v���t�B�[��"	to=status_sub
@button page=main name=to_endsel      comment="�G���f�B���O�I�����"	to=ending	eval="ending" dshide
@button page=main name=to_sub         comment="�T�u�L�����I�����"	to=sub		badge="sub_k:sub_l:sub_m:sub_n:sub_o:sub_p:sub_q:sub_r:sub_s:sub_t"
@button page=main name=to_oyako       comment="�e�q���I�����"		to=oyako	badge="oya_a:oya_b:oya_c:oya_d:oya_e:oya_f:oya_g:oya_h:oya_i:oya_j"
@button page=main name=to_boot_camp   comment="�u�[�g�L�����v�I�����"	to=boot_camp	badge="camp_a:camp_b:camp_c:camp_d:camp_e:camp_f:camp_g:camp_h:camp_i:camp_j"
@button page=main name=to_multi       comment="���l���I�����"		to=multi	badge="mul_1:mul_2:mul_3:mul_4:mul_5:mul_6:mul_7"
@button page=main name=quest_skip     comment="�̓X�L�b�v"				storage=gameloop.txt target=*nextchapter	eval="chaptskip && ���݂̃X�e�[�W<14" dshide
;												���e�q���^�����ς�����̃t���O
@main   page=main name=ch0	to=main2_a	nodisable	�U���󋵁F仉�		partcomp="state_oyako:sca20n|state_camp:sca30n"
@main   page=main name=ch1	to=main2_b	nodisable	�U���󋵁F���T��	partcomp="state_oyako:scb20n|state_camp:scb30n"
@main   page=main name=ch2	to=main2_c	nodisable	�U���󋵁F��		partcomp="state_oyako:scc20n|state_camp:scc30n"
@main   page=main name=ch3	to=main2_d	nodisable	�U���󋵁F�ށX�q	partcomp="state_oyako:scd20n|state_camp:scd30n"
@main   page=main name=ch4	to=main2_e	nodisable	�U���󋵁F����		partcomp="state_oyako:sce20n|state_camp:sce30n"
@main   page=main name=ch5	to=main2_f	nodisable	�U���󋵁F�ЂȂ�	partcomp="state_oyako:scf20n|state_camp:scf30n"
@main   page=main name=ch6	to=main2_g	nodisable	�U���󋵁F��		partcomp="state_oyako:scg20n|state_camp:scg30n"
@main   page=main name=ch7	to=main2_h	nodisable	�U���󋵁F�D�ؗ�	partcomp="state_oyako:sch20n|state_camp:sch30n"
@main   page=main name=ch8	to=main2_i	nodisable	�U���󋵁F�����A	partcomp="state_oyako:sci20n|state_camp:sci30n"
@main   page=main name=ch9	to=main2_j	nodisable	�U���󋵁F���[�V��	partcomp="state_oyako:scj20n|state_camp:scj30n"
;
@prof   page=main name=prof	flag=prof_main	prefix=ch	layers=prof_name:prof_stand:prof_base
;
@number page=main name=chapter cpref=num flag=���݂̃X�e�[�W
@number page=main name=quest   cpref=num flag=���݂̃E�F�[�u
;
@exit
;-------------------------------------------------------------------------------
; ���C���e�L�����̃G�s�\�[�h�I��
*main2_a|
	@screen_main2 page=main2_a target=*goto_main_a �U���󋵁F仉�
*main2_b|
	@screen_main2 page=main2_b target=*goto_main_b �U���󋵁F���T��
*main2_c|
	@screen_main2 page=main2_c target=*goto_main_c �U���󋵁F��
*main2_d|
	@screen_main2 page=main2_d target=*goto_main_d �U���󋵁F�ށX�q
*main2_e|
	@screen_main2 page=main2_e target=*goto_main_e �U���󋵁F����
*main2_f|
	@screen_main2 page=main2_f target=*goto_main_f �U���󋵁F�ЂȂ�
*main2_g|
	@screen_main2 page=main2_g target=*goto_main_g �U���󋵁F��
*main2_h|
	@screen_main2 page=main2_h target=*goto_main_h �U���󋵁F�D�ؗ�
*main2_i|
	@screen_main2 page=main2_i target=*goto_main_i �U���󋵁F�����A
*main2_j|
	@screen_main2 page=main2_j target=*goto_main_j �U���󋵁F���[�V��

;-------------------------------------------------------------------------------
; �T�u�I��
;
*sub|
@screen page=sub  storage=quest_sub rclick=main
;
@sub    page=sub  name=subch0	�T�u�L�����F�G����	new="sub_k"	storage=gameloop.txt target=*goto_sub_k
@sub    page=sub  name=subch1	�T�u�L�����F�߂���	new="sub_l"	storage=gameloop.txt target=*goto_sub_l
@sub    page=sub  name=subch2	�T�u�L�����F�O		new="sub_m"	storage=gameloop.txt target=*goto_sub_m
@sub    page=sub  name=subch3	�T�u�L�����F���	new="sub_n"	storage=gameloop.txt target=*goto_sub_n
@sub    page=sub  name=subch4	�T�u�L�����F��		new="sub_o"	storage=gameloop.txt target=*goto_sub_o
@sub    page=sub  name=subch5	�T�u�L�����F�F�q	new="sub_p"	storage=gameloop.txt target=*goto_sub_p
@sub    page=sub  name=subch6	�T�u�L�����F���Ȃ�	new="sub_q"	storage=gameloop.txt target=*goto_sub_q
@sub    page=sub  name=subch7	�T�u�L�����F���q	new="sub_r"	storage=gameloop.txt target=*goto_sub_r
@sub    page=sub  name=subch8	�T�u�L�����F��q	new="sub_s"	storage=gameloop.txt target=*goto_sub_s
@sub    page=sub  name=subch9	�T�u�L�����Fꡍ�	new="sub_t"	storage=gameloop.txt target=*goto_sub_t
;
@prof   page=sub  name=prof	flag=prof_sub	prefix=subch	layers=prof_text:prof_stand:prof_name
;
@button page=sub  name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; �e�q���I��
;
*oyako|
@screen page=oyako storage=quest_oyako rclick=main
;
@oyako page=oyako name=oyako0	comment="仉����V����"			withnew eval="oya_a"	storage=gameloop.txt target=*goto_oyako_a
@oyako page=oyako name=oyako1	comment="���T�������q"			withnew eval="oya_b"	storage=gameloop.txt target=*goto_oyako_b
@oyako page=oyako name=oyako2	comment="�����������_"			withnew eval="oya_c"	storage=gameloop.txt target=*goto_oyako_c
@oyako page=oyako name=oyako3	comment="�ށX�q������"			withnew eval="oya_d"	storage=gameloop.txt target=*goto_oyako_d
@oyako page=oyako name=oyako4	comment="���끕�x�q"			withnew eval="oya_e"	storage=gameloop.txt target=*goto_oyako_e
@oyako page=oyako name=oyako5	comment="�ЂȂ�������"			withnew eval="oya_f"	storage=gameloop.txt target=*goto_oyako_f
@oyako page=oyako name=oyako6	comment="��������"			withnew eval="oya_g"	storage=gameloop.txt target=*goto_oyako_g
@oyako page=oyako name=oyako7	comment="�D�ؗ������S��"		withnew eval="oya_h"	storage=gameloop.txt target=*goto_oyako_h
@oyako page=oyako name=oyako8	comment="�����A�����C"			withnew eval="oya_i"	storage=gameloop.txt target=*goto_oyako_i
@oyako page=oyako name=oyako9	comment="���[�V�������E�_"		withnew eval="oya_j"	storage=gameloop.txt target=*goto_oyako_j
;
@button page=oyako name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; �u�[�g�L�����v�I��
;
*boot_camp|
@screen page=boot_camp storage=quest_boot_camp rclick=main
;
@camp page=boot_camp name=boot_camp0	comment="仉�"			withnew eval="camp_a"	storage=gameloop.txt target=*goto_boot_camp_a
@camp page=boot_camp name=boot_camp1	comment="���T��"		withnew eval="camp_b"	storage=gameloop.txt target=*goto_boot_camp_b
@camp page=boot_camp name=boot_camp2	comment="��"			withnew eval="camp_c"	storage=gameloop.txt target=*goto_boot_camp_c
@camp page=boot_camp name=boot_camp3	comment="�ށX�q"		withnew eval="camp_d"	storage=gameloop.txt target=*goto_boot_camp_d
@camp page=boot_camp name=boot_camp4	comment="����"			withnew eval="camp_e"	storage=gameloop.txt target=*goto_boot_camp_e
@camp page=boot_camp name=boot_camp5	comment="�ЂȂ�"		withnew eval="camp_f"	storage=gameloop.txt target=*goto_boot_camp_f
@camp page=boot_camp name=boot_camp6	comment="��"			withnew eval="camp_g"	storage=gameloop.txt target=*goto_boot_camp_g
@camp page=boot_camp name=boot_camp7	comment="�D�ؗ�"		withnew eval="camp_h"	storage=gameloop.txt target=*goto_boot_camp_h
@camp page=boot_camp name=boot_camp8	comment="�����A"		withnew eval="camp_i"	storage=gameloop.txt target=*goto_boot_camp_i
@camp page=boot_camp name=boot_camp9	comment="���[�V��"		withnew eval="camp_j"	storage=gameloop.txt target=*goto_boot_camp_j
;
@button page=boot_camp name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; ���l���I��
;
@info tag=i_x01 text="�w���C�h�ĔL�J�t�F�A�v���I�x�����l���G���y�[�W�ɒǉ��I"				flag=mul_1	���l���F�L�J�t�F
*multi|
@screen page=multi storage=quest_multi rclick=main
;
@layer page=multi name=fullhdanim comment="�A�j���[�V�������m�点�ʒm"	        eval="mul_4"
;
@multi page=multi name=multi0	comment="�l�Ȃ����ς��o���[�n�[�����I"		withnew eval="mul_5"	storage=gameloop.txt target=*goto_multi_5
@multi page=multi name=multi1	comment="���������I����I�V���C�I"		withnew eval="mul_7"	storage=gameloop.txt target=*goto_multi_7
@multi page=multi name=multi2	comment="�g���v���p�C�Y���i�[�X�A�v���I"	withnew eval="mul_4"	storage=gameloop.txt target=*goto_multi_4
@multi page=multi name=multi3	comment="���C�h�ĔL�J�t�F�A�v���I"		withnew eval="mul_1"	storage=gameloop.txt target=*goto_multi_1
@multi page=multi name=multi4	comment="�Z�[���[�������o���ԉΑ��A�v���I"	withnew eval="mul_2"	storage=gameloop.txt target=*goto_multi_2
@multi page=multi name=multi5	comment="�����o�j�[�K�[���A�v���I"		withnew eval="mul_3"	storage=gameloop.txt target=*goto_multi_3
@multi page=multi name=multi6	comment="�����ς��l�ȗ�̃v�[���Q�ϓ��A�v���I"	withnew eval="mul_6"	storage=gameloop.txt target=*goto_multi_6
;
@button page=multi name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; ���o�����I���iscx08�ʉߔŁj�@��scx0?h �͑��l����ʂ̃t���O�Ŏg�p�����̂ł����ł� scx0?n ���g�p����
*odekake|
@screen page=odekake storage=odekake rclick=""
;
; ���ǃ`�F�b�N
@layer page=odekake name=odekake1_read eval="scx01n"
@layer page=odekake name=odekake2_read eval="scx02n"
@layer page=odekake name=odekake3_read eval="scx03n"
;
; ��������I��s�H
@button page=odekake name=odekake1  eval="!scx01n" storage=gameloop.txt target=*goto_odekake_1
@button page=odekake name=odekake2  eval="!scx02n" storage=gameloop.txt target=*goto_odekake_2
@button page=odekake name=odekake3  eval="!scx03n" storage=gameloop.txt target=*goto_odekake_3
;
; �I���{�^���i���̃X�e�[�W�ցj
@button page=odekake name=nextstage                storage=gameloop.txt target=*stage
;
@exit
;-------------------------------------------------------------------------------
; �G���f�B���O�I��
;
*ending|
@screen page=ending storage=ending_select rclick=main
;
; new�}�[�N���ꏈ���i�ߋ��ɃG���f�B���O�����ĂȂ��ꍇ�ɂ̂ݕ\���j
@layer  page=ending name=end0_new eval="end_1 && !.sf.sced01h"
@layer  page=ending name=end1_new eval="end_2 && !.sf.sced02h"
@layer  page=ending name=end2_new eval="end_a && !.sf.sca50h"
;
@ending page=ending name=end0	comment="�s�܂��I�n�[�����G���h�I"			eval="end_1"	storage=gameloop.txt target=*goto_end_1
@ending page=ending name=end1	comment="�����ς���e�I�s�܂��I�n�[�����G���h�I"	eval="end_2"	storage=gameloop.txt target=*goto_end_2
@ending page=ending name=end2	comment="仉��Ǝq��艷�򗷍s"				eval="end_a"	storage=gameloop.txt target=*goto_end_a
;
@button page=ending name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; �G���f�B���O�I��sc14�ʉߔ�
;
;*ending14|
;@screen page=ending14 storage=ending_select rclick=""
;
;@ending page=ending14 name=end0	comment="�s�܂��I�n�[�����G���h�I"			eval="end_1"	storage=gameloop.txt target=*goto_end_1
;@ending page=ending14 name=end1	comment="�����ς���e�I�s�܂��I�n�[�����G���h�I"	eval="end_2"	storage=gameloop.txt target=*goto_end_2
;@ending page=ending14 name=end2	comment="仉��Ǝq��艷�򗷍s"				eval="end_a"	storage=gameloop.txt target=*goto_end_a
;
;@exit
;-------------------------------------------------------------------------------
; �X�e�[�^�X���
;
*status|
@screen page=status storage=status click=main rclick=main nomenu
;
@status page=status	name=ch0	�U���󋵁F仉�
@status page=status	name=ch1	�U���󋵁F���T��
@status page=status	name=ch2	�U���󋵁F��
@status page=status	name=ch3	�U���󋵁F�ށX�q
@status page=status	name=ch4	�U���󋵁F����
@status page=status	name=ch5	�U���󋵁F�ЂȂ�
@status page=status	name=ch6	�U���󋵁F��
@status page=status	name=ch7	�U���󋵁F�D�ؗ�
@status page=status	name=ch8	�U���󋵁F�����A
@status page=status	name=ch9	�U���󋵁F���[�V��
;
@complete page=status	name=harem	eval=".sf.sced01h"
@complete page=status	name=hmase	eval=".sf.sced02h"
@complete page=status	name=rio	eval=".sf.sca50h"
@number   page=status	name=cgcomp	flag=".sf.cg_ratio" keta=3 cpref=num
@text     page=status	name=player	flag="name"
;
@exit
;-------------------------------------------------------------------------------
; �X�e�[�^�X��ʃ��C���i�v���t�B�[����ʃ��C���L�����p�j
;
*status_main|
@screen page=status_main storage=status_main rclick=main nomenu

@call target=*status_main_common
@button page=status_main name=to_status_sub to=status_sub
@button page=status_main name=back to=main withsubtext
;
@exit
;
; ���ʏ���(�Q�[����/�^�C�g������Ăяo��)
*status_main_common
@button page=status_main name=ch0	withsubtext profile=0	toggle	comment="a:仉�"
@button page=status_main name=ch1	withsubtext profile=1	toggle	comment="b:���T��"
@button page=status_main name=ch2	withsubtext profile=2	toggle	comment="c:��"
@button page=status_main name=ch3	withsubtext profile=3	toggle	comment="d:�ށX�q"
@button page=status_main name=ch4	withsubtext profile=4	toggle	comment="e:����"
@button page=status_main name=ch5	withsubtext profile=5	toggle	comment="f:�ЂȂ�"
@button page=status_main name=ch6	withsubtext profile=6	toggle	comment="g:��"
@button page=status_main name=ch7	withsubtext profile=7	toggle	comment="h:�D�ؗ�"
@button page=status_main name=ch8	withsubtext profile=8	toggle	comment="i:�����A"
@button page=status_main name=ch9	withsubtext profile=9	toggle	comment="j:���[�V��"
;
; ���L�Q�s�͍X�V�̓s���ɂ��prof���O�ɔz�u���邱��
@number page=status_main name=ona_count		flag="0" keta=3 cpref=num
@text   page=status_main name=ona_text		default="�������͂���܂���"
;
@prof   page=status_main name=prof	flag=status_main	prefix="ch"	layers=prof_stand:prof_name radio dress subtext=*update
@button page=status_main name=dress0	dress=0
@button page=status_main name=dress1	dress=1
@button page=status_main name=dress2	dress=2
@button page=status_main name=dress3	dress=3
@button page=status_main name=dress4	dress=4
@button page=status_main name=dress5	dress=5
;
;
;���Y�[�����͗����G���g���̂ŃL�������ƕ�����`���K�v�izoomview="�L����2:����1:����2:...|�L����2:����..."�j �L�����E�����̏��Ԃ͉��UI�̕��тɏ]������
@button page=status_main name=zoom	zoomview="仉�:����:����:�e�j�X�E�F�A:�X�[�c:��:����|���T��:�������{���s���N:����:�A�C�h��:�X�[�c:��|��:����:����:����:�X�[�c:��:����|�ށX�q:����:����:����:�X�[�c:��|����:����:����:�X�[�c:��:�����X�J�[�g����|�ЂȂ�:����:����:����:�X�[�c:��|��:����:����:�X�[�c:��:�E�F�C�g���X|�D�ؗ�:����:����:����:�X�[�c:��|�����A:����:����:����:�X�[�c:��|���[�V��:����:����:����:�X�[�c:��"
;
@return
;-------------------------------------------------------------------------------
; �X�e�[�^�X��ʃT�u�i�v���t�B�[����ʃT�u�L�����p�j
;
*status_sub|
@screen page=status_sub storage=status_sub rclick=main nomenu
;
@call target=*status_sub_common
;
@button page=status_sub name=to_status_main to=status_main
@button page=status_sub name=back to=main
;
@exit
;
; ���ʏ���(�Q�[����/�^�C�g������Ăяo��)
*status_sub_common
@button page=status_sub name=subch0	profile=0	toggle	comment="k:�G����"
@button page=status_sub name=subch1	profile=1	toggle	comment="l:�߂���"
@button page=status_sub name=subch2	profile=2	toggle	comment="m:�O"
@button page=status_sub name=subch3	profile=3	toggle	comment="n:���"
@button page=status_sub name=subch4	profile=4	toggle	comment="o:��"
@button page=status_sub name=subch5	profile=5	toggle	comment="p:�F�q"
@button page=status_sub name=subch6	profile=6	toggle	comment="q:���Ȃ�"
@button page=status_sub name=subch7	profile=7	toggle	comment="r:���q"
@button page=status_sub name=subch8	profile=8	toggle	comment="s:��q"
@button page=status_sub name=subch9	profile=9	toggle	comment="t:ꡍ�"
;
@prof   page=status_sub name=prof	flag=status_sub		prefix="subch"	layers=prof_stand:prof_name radio dress
@button page=status_sub name=dress0	dress=0
@button page=status_sub name=dress1	dress=1
@button page=status_sub name=dress2	dress=2
;
;���Y�[�����͗����G���g���̂ŃL�������ƕ�����`���K�v�izoomview="�L����2:����1:����2:...|�L����2:����..."�j
@button page=status_sub name=zoom	zoomview="�G����:����|�߂���:��:����:��|�O:����|���:��|��:��|�F�q:����|���Ȃ�:��|���q:��|��q:����:�X�J�[�g����|ꡍ�:��"
;
@return
;-------------------------------------------------------------------------------
; �^�C�g������̃X�e�[�^�X��ʌĂяo��

*title
@close storage=custom.ks target=*close_status
@exit

*status_main_title|
; �I�i�j�[�������X�V(�^�C�g������̌Ăяo����info~subtext���Ă΂�Ȃ��̂ł����ŌĂ�)
@subtext
@screen page=status_main_title storage=status_main rclick=title nomenu exp="this.page=tf.title_status='status_main'"
;
@call target=*status_main_common
@button page=status_main name=to_status_sub to=status_sub_title
@button page=status_main name=back to=title
@exit

*status_sub_title|
@screen page=status_sub_title storage=status_sub rclick=title nomenu exp="this.page=tf.title_status='status_sub'"
;
@call target=*status_sub_common
@button page=status_sub name=to_status_main to=status_main_title
@button page=status_sub name=back to=title
@exit

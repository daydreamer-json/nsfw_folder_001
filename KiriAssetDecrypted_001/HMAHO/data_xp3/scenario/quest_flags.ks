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
;-------------------------------------------------------------------------------
; ���C���L�����U���󋵏���
;
@pmacro name="�U���󋵁F�p���"			comment="�p���"	point="sc_a01h:sc_a02h:sc_a03h:sc_a04h:sc_a05h"
@pmacro name="�U���󋵁F�I���K"			comment="�I���K"	point="sc_b01h:sc_b02h:sc_b03h:sc_b04h:sc_b05h"
@pmacro name="�U���󋵁F�t�B�["			comment="�t�B�["	point="sc_c01h:sc_c02h:sc_c03h:sc_c04h:sc_c05h"
@pmacro name="�U���󋵁F���f�B�A"		comment="���f�B�A"	point="sc_d01h:sc_d02h:sc_d03h:sc_d04h:sc_d05h:sc_d06h"
@pmacro name="�U���󋵁F�J�V���j�A"		comment="�J�V���j�A"	point="sc_e01h:sc_e02h:sc_e03h:sc_e04h:sc_e05h"
@pmacro name="�U���󋵁F�i�I�~��"		comment="�i�I�~��"	point="sc_f01h:sc_f02h:sc_f03h:sc_f04h:sc_f05h"
@pmacro name="�U���󋵁F�J�g���[�k"		comment="�J�g���[�k"	point="sc_g01h:sc_g02h:sc_g03h:sc_g04h"
@pmacro name="�U���󋵁F�~���E"			comment="�~���E"	point="sc_h01h:sc_h02h:sc_h03h:sc_h04h"
@pmacro name="�U���󋵁F������"			comment="������"	point="sc_i01h:sc_i02h:sc_i03h:sc_i04h"
@pmacro name="�U���󋵁F�݂���"			comment="�݂���"	point="sc_j01h:sc_j02h:sc_j03h:sc_j04h:sc_j05h"
;
;-------------------------------------------------------------------------------
; �G���h����
;
@pmacro name="�G���h�����F�n�[����"		eval="sc_a01h && sc_b01h && sc_c02h && sc_d01h && sc_e01h && sc_f01h && sc_g01h && sc_h01h && sc_i01h && sc_j01h"
@pmacro name="�G���h�����F�s�܂�"		eval="sc_a05h && sc_b05h && sc_c05h && sc_d06h && sc_e05h && sc_f05h && sc_g04h && sc_h04h && sc_i04h && sc_j05h"
@pmacro name="�G���h�����F�p���"    eval="sc_a05h && sc_a20h && sc_b01h && sc_c02h && sc_d01h && sc_e01h && sc_f01h && sc_g01h && sc_h01h && sc_i01h && sc_j01h"
;
;-------------------------------------------------------------------------------
; �T�u�L�����g�I�[�v������
;
@pmacro name="�T�u�L�����F�G����"		comment="�G����"		eval="sc_01"	point="sc_k01h"
@pmacro name="�T�u�L�����F�T���P"		comment="�T���P"		eval="sc_03"	point="sc_l01h:sc_l02h"
@pmacro name="�T�u�L�����F�T���Q"		comment="�T���Q"		eval="sc_l01h"	point="sc_l01h:sc_l02h"
@pmacro name="�T�u�L�����F���~�A�P"		comment="���~�A�P"		eval="sc_05"	point="sc_m01h:sc_m02h"
@pmacro name="�T�u�L�����F���~�A�Q"		comment="���~�A�Q"		eval="sc_m01h"	point="sc_m01h:sc_m02h"
@pmacro name="�T�u�L�����F�W���_"		comment="�W���_"		eval="sc_06"	point="sc_n01h"
@pmacro name="�T�u�L�����F�}���B"		comment="�}���B"		eval="sc_07"	point="sc_o01h"
@pmacro name="�T�u�L�����F�Z���J�P"		comment="�Z���J�P"		eval="sc_f03h"	point="sc_p01h:sc_p02h"
@pmacro name="�T�u�L�����F�Z���J�Q"		comment="�Z���J�Q"		eval="sc_p01h"	point="sc_p01h:sc_p02h"
@pmacro name="�T�u�L�����F�~���t�@�P"		comment="�~���t�@�P"		eval="sc_g03h"	point="sc_q01h:sc_q02h"
@pmacro name="�T�u�L�����F�~���t�@�Q"		comment="�~���t�@�Q"		eval="sc_q01h"	point="sc_q01h:sc_q02h"
@pmacro name="�T�u�L�����F�V�X�e�B�[�l�P"	comment="�V�X�e�B�[�l�P"	eval="sc_02"	point="sc_r01h:sc_r02h"
@pmacro name="�T�u�L�����F�V�X�e�B�[�l�Q"	comment="�V�X�e�B�[�l�Q"	eval="sc_r01h"	point="sc_r01h:sc_r02h"
@pmacro name="�T�u�L�����F�A�T�~"		comment="�A�T�~"		eval="sc_08"	point="sc_s01h"
@pmacro name="�T�u�L�����F�e�B�A�i"		comment="�e�B�A�i"		eval="sc_09"	point="sc_t01h"
;
;-------------------------------------------------------------------------------
; �e�q���g�I�[�v������
;
@pmacro name="�e�q���F�p���"			eval="sc_a02h"
@pmacro name="�e�q���F�I���K"			eval="sc_b01h"
@pmacro name="�e�q���F�t�B�["			eval="sc_c04h"
@pmacro name="�e�q���F���f�B�A"			eval="sc_d04h"
@pmacro name="�e�q���F�J�V���j�A"		eval="sc_x03h"
@pmacro name="�e�q���F�i�I�~��"			eval="sc_f02h"
@pmacro name="�e�q���F�J�g���[�k"		eval="sc_g03h"
@pmacro name="�e�q���F�~���E"			eval="sc_h03h"
@pmacro name="�e�q���F������"			eval="sc_i02h"
@pmacro name="�e�q���F�݂���"			eval="sc_j04h"
;
;-------------------------------------------------------------------------------
; ���l���g�I�[�v������
;
@pmacro name="���l���F�e�j�X"			eval="sc_f20h"
@pmacro name="���l���F���C�h"			eval="sc_c03h && sc_f03h && sc_h02h"
@pmacro name="���l���F�^����"			eval="sc_x03h"
@pmacro name="���l���F�I�V���C"			eval="sc_x11h"
@pmacro name="���l���F�c�C�X�^"			eval="sc_x14h"
;
;-------------------------------------------------------------------------------
;���X�e�[�^�X��ʂł̓C���t�H�[���[�V�����͕s�v
@jump target=*status cond="page=='status'"
;-------------------------------------------------------------------------------
; �C���t�H�[���[�V�����\�������ꗗ
;
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=k		flag=sub_k	�T�u�L�����F�G����
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=l1		flag=sub_l1	�T�u�L�����F�T���P
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=l2		flag=sub_l2	�T�u�L�����F�T���Q
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=m1		flag=sub_m1	�T�u�L�����F���~�A�P
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=m2		flag=sub_m2	�T�u�L�����F���~�A�Q
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=n		flag=sub_n	�T�u�L�����F�W���_
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=o		flag=sub_o	�T�u�L�����F�}���B
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=p1		flag=sub_p1	�T�u�L�����F�Z���J�P
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=p2		flag=sub_p2	�T�u�L�����F�Z���J�Q
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=q1		flag=sub_q1	�T�u�L�����F�~���t�@�P
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=q2		flag=sub_q2	�T�u�L�����F�~���t�@�Q
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=r1		flag=sub_r1	�T�u�L�����F�V�X�e�B�[�l�P
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=r2		flag=sub_r2	�T�u�L�����F�V�X�e�B�[�l�Q
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=s		flag=sub_s	�T�u�L�����F�A�T�~
@info tag=i_s04 text="�u�T�u�L�����V�i���I�v���ǉ��X�V����܂����I" subtag=t		flag=sub_t	�T�u�L�����F�e�B�A�i
;
@info tag=i_x01 text="�w�l�ȃG���t�e�j�X��y���x�����l���G���y�[�W�ɒǉ��I"		flag=mul_1	���l���F�e�j�X
@info tag=i_x02 text="�w�ِ��E���C�h�g���v���p�C�Y���x�����l���G���y�[�W�ɒǉ��I"	flag=mul_2	���l���F���C�h
@info tag=i_x03 text="�w��e�΍R�p�C�Y�����[�x�����l���G���y�[�W�ɒǉ��I"		flag=mul_3	���l���F�^����
@info tag=i_x04 text="�w����I�V���C�x�����l���G���y�[�W�ɒǉ��I"			flag=mul_4	���l���F�I�V���C
@info tag=i_x05 text="�w�s�܂��g�D�C�X�^�[�Q�[���x�����l���G���y�[�W�ɒǉ��I"		flag=mul_5	���l���F�c�C�X�^
;
@info tag=i_a01 text="�n�[�����G���h�����i�p��ށj�𖞂����܂����I"					eval="sc_a01h"
@info tag=i_b01 text="�n�[�����G���h�����i�I���K�j�𖞂����܂����I"					eval="sc_b01h"
@info tag=i_c01 text="�n�[�����G���h�����i�t�B�[�j�𖞂����܂����I"					eval="sc_c02h"
@info tag=i_d01 text="�n�[�����G���h�����i���f�B�A�j�𖞂����܂����I"					eval="sc_d01h"
@info tag=i_e01 text="�n�[�����G���h�����i�J�V���j�A�j�𖞂����܂����I"					eval="sc_e01h"
@info tag=i_f01 text="�n�[�����G���h�����i�i�I�~���j�𖞂����܂����I"					eval="sc_f01h"
@info tag=i_g01 text="�n�[�����G���h�����i�J�g���[�k�j�𖞂����܂����I"					eval="sc_g01h"
@info tag=i_h01 text="�n�[�����G���h�����i�~���E�j�𖞂����܂����I"					eval="sc_h01h"
@info tag=i_i01 text="�n�[�����G���h�����i������j�𖞂����܂����I"					eval="sc_i01h"
@info tag=i_j01 text="�n�[�����G���h�����i�݂���j�𖞂����܂����I"					eval="sc_j01h"
;													�����u�G���h�����F�n�[�����v�̌X�̃V�i���I�ʉ߃t���O�ł��邱�Ƃɒ���
;
@info tag=i_a02 text="�p��ނ̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_a	�e�q���F�p���
@info tag=i_b02 text="�I���K�̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_b	�e�q���F�I���K
@info tag=i_c02 text="�t�B�[�̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_c	�e�q���F�t�B�[
@info tag=i_d02 text="���f�B�A�̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_d	�e�q���F���f�B�A
@info tag=i_e02 text="�J�V���j�A�̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"	flag=oya_e	�e�q���F�J�V���j�A
@info tag=i_f02 text="�i�I�~���̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_f	�e�q���F�i�I�~��
@info tag=i_g02 text="�J�g���[�k�̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"	flag=oya_g	�e�q���F�J�g���[�k
@info tag=i_h02 text="�~���E�̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_h	�e�q���F�~���E
@info tag=i_i02 text="������̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_i	�e�q���F������
@info tag=i_j02 text="�݂���̐e�q���V�i���I���e�q���y�[�W�ɒǉ�����܂����I"		flag=oya_j	�e�q���F�݂���
;
@info tag=i_a03 text="�p��ރV�i���I�����S�U�����܂����I"						eval="sc_a05h"
@info tag=i_b03 text="�I���K�V�i���I�����S�U�����܂����I"						eval="sc_b05h"
@info tag=i_c03 text="�t�B�[�V�i���I�����S�U�����܂����I"						eval="sc_c05h"
@info tag=i_d03 text="���f�B�A�V�i���I�����S�U�����܂����I"						eval="sc_d06h"
@info tag=i_e03 text="�J�V���j�A�V�i���I�����S�U�����܂����I"						eval="sc_e05h"
@info tag=i_f03 text="�i�I�~���V�i���I�����S�U�����܂����I"						eval="sc_f05h"
@info tag=i_g03 text="�J�g���[�k�V�i���I�����S�U�����܂����I"						eval="sc_g04h"
@info tag=i_h03 text="�~���E�V�i���I�����S�U�����܂����I"						eval="sc_h04h"
@info tag=i_i03 text="������V�i���I�����S�U�����܂����I"						eval="sc_i04h"
@info tag=i_j03 text="�݂���V�i���I�����S�U�����܂����I"						eval="sc_j05h"
;													�����u�G���h�����F�s�܂��v�̌X�̃V�i���I�ʉ߃t���O�ł��邱�ƁH
;
@info tag=i_s01 text="�u�n�[�����G���f�B���O�v�����𖞂����܂����I"			flag=end_1	�G���h�����F�n�[����
@info tag=i_s02 text="�u�s�܂��G���f�B���O�v�����𖞂����܂����I"			flag=end_2	�G���h�����F�s�܂�
@info tag=i_a04 text="�w�p��ރG���f�B���O�x�̏����𖞂����܂����I"			flag=end_a	�G���h�����F�p���
@info tag=i_s03 text="CG��100���ɂȂ�܂����I"						sflag		eval=".sf.cg_complete"
;
@info tag=i_s05 text="�u�G���f�B���O�I�����v�ɂ�����悤�ɂȂ�܂����I"			flag=ending	�G���h�����F�n�[����
@info tag=i_s06 text="�u�̓X�L�b�v�{�^���v���g����悤�ɂȂ�܂����I"			flag=chaptskip	eval="sc_13"
;
;-------------------------------------------------------------------------------
;���e�y�[�W�̐ݒ�փW�����v
@jump target=*main   cond="page=='main'"
@jump target=*sub    cond="page=='sub'"
@jump target=*oyako  cond="page=='oyako'"
@jump target=*multi  cond="page=='multi'"
@jump target=*ending cond="page=='ending'"
@jump target=*ending14 cond="page=='ending14'"
@error message=&"�s���ȃy�[�W�ł�:"+page
;-------------------------------------------------------------------------------
; ���C���I��
;
*main|
@screen page=main storage=quest_main rclick=""
;
@button page=main name=to_status comment="��l���v���t�B�[��"	to=status
@button page=main name=to_endsel comment="�G���f�B���O�I�����"	to=ending	eval="ending" dshide
@button page=main name=to_sub    comment="�T�u�L�����I�����"	to=sub		badge="sub_k:sub_l1:sub_l2:sub_m1:sub_m2:sub_n:sub_o:sub_p1:sub_p2:sub_q1:sub_q2:sub_r1:sub_r2:sub_s:sub_t"
@button page=main name=to_oyako  comment="�e�q���I�����"	to=oyako	badge="oya_a:oya_b:oya_c:oya_d:oya_e:oya_f:oya_g:oya_h:oya_i:oya_j"
@button page=main name=to_multi  comment="���l���I�����"	to=multi	badge="mul_1:mul_2:mul_3:mul_4:mul_5"
@button page=main name=quest_skip comment="�̓X�L�b�v"				storage=gameloop.txt target=*nextchapter	eval="chaptskip" dshide
;
@main   page=main name=ch0	�U���󋵁F�p���				storage=gameloop.txt target=*goto_main_a
@main   page=main name=ch1	�U���󋵁F�I���K				storage=gameloop.txt target=*goto_main_b
@main   page=main name=ch2	�U���󋵁F�t�B�[				storage=gameloop.txt target=*goto_main_c
@main   page=main name=ch3	�U���󋵁F���f�B�A				storage=gameloop.txt target=*goto_main_d
@main   page=main name=ch4	�U���󋵁F�J�V���j�A				storage=gameloop.txt target=*goto_main_e
@main   page=main name=ch5	�U���󋵁F�i�I�~��				storage=gameloop.txt target=*goto_main_f
@main   page=main name=ch6	�U���󋵁F�J�g���[�k				storage=gameloop.txt target=*goto_main_g
@main   page=main name=ch7	�U���󋵁F�~���E				storage=gameloop.txt target=*goto_main_h
@main   page=main name=ch8	�U���󋵁F������				storage=gameloop.txt target=*goto_main_i
@main   page=main name=ch9	�U���󋵁F�݂���				storage=gameloop.txt target=*goto_main_j
;
@prof   page=main name=prof	flag=prof_main	prefix=ch	layers=prof_name:prof_stand	dress
@button page=main name=dress0	dress=0
@button page=main name=dress1	dress=1
@button page=main name=dress2	dress=2
@button page=main name=dress3	dress=3
@button page=main name=dress3c	dress=3
@button page=main name=dress3h	dress=3
@button page=main name=dress4	dress=4
;
@number page=main name=chapter cpref=num flag=���݂̏�
@number page=main name=quest   cpref=num flag=�N�G�X�g�I����
;
@exit
;-------------------------------------------------------------------------------
; �T�u�I��
;
*sub|
@screen page=sub  storage=quest_sub rclick=main
;
@sub    page=sub  name=subch0	�T�u�L�����F�G����		new="sub_k"	storage=gameloop.txt target=*goto_sub_k
@sub    page=sub  name=subch1	�T�u�L�����F�T���P		new="sub_l1"	storage=gameloop.txt target=*goto_sub_l1
@sub    page=sub  name=subch2	�T�u�L�����F�T���Q		new="sub_l2"	storage=gameloop.txt target=*goto_sub_l2
@sub    page=sub  name=subch3	�T�u�L�����F���~�A�P		new="sub_m1"	storage=gameloop.txt target=*goto_sub_m1
@sub    page=sub  name=subch4	�T�u�L�����F���~�A�Q		new="sub_m2"	storage=gameloop.txt target=*goto_sub_m2
@sub    page=sub  name=subch5	�T�u�L�����F�W���_		new="sub_n"	storage=gameloop.txt target=*goto_sub_n
@sub    page=sub  name=subch6	�T�u�L�����F�}���B		new="sub_o"	storage=gameloop.txt target=*goto_sub_o
@sub    page=sub  name=subch7	�T�u�L�����F�Z���J�P		new="sub_p1"	storage=gameloop.txt target=*goto_sub_p1
@sub    page=sub  name=subch8	�T�u�L�����F�Z���J�Q		new="sub_p2"	storage=gameloop.txt target=*goto_sub_p2
@sub    page=sub  name=subch9	�T�u�L�����F�~���t�@�P		new="sub_q1"	storage=gameloop.txt target=*goto_sub_q1
@sub    page=sub  name=subch10	�T�u�L�����F�~���t�@�Q		new="sub_q2"	storage=gameloop.txt target=*goto_sub_q2
@sub    page=sub  name=subch11	�T�u�L�����F�V�X�e�B�[�l�P	new="sub_r1"	storage=gameloop.txt target=*goto_sub_r1
@sub    page=sub  name=subch12	�T�u�L�����F�V�X�e�B�[�l�Q	new="sub_r2"	storage=gameloop.txt target=*goto_sub_r2
@sub    page=sub  name=subch13	�T�u�L�����F�A�T�~		new="sub_s"	storage=gameloop.txt target=*goto_sub_s
@sub    page=sub  name=subch14	�T�u�L�����F�e�B�A�i		new="sub_t"	storage=gameloop.txt target=*goto_sub_t
;
@prof   page=sub  name=prof	flag=prof_sub	prefix=subch	layers=prof_stand:prof_name:prof_text	order="k:l1:l2:m1:m2:n:o:p1:p2:q1:q2:r1:r2:s:t"
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
@oyako page=oyako name=oyako0	comment="�p��ށ�����"			withnew eval="oya_a"	storage=gameloop.txt target=*goto_oyako_a
@oyako page=oyako name=oyako1	comment="�I���K���}���A"		withnew eval="oya_b"	storage=gameloop.txt target=*goto_oyako_b
@oyako page=oyako name=oyako2	comment="�t�B�[�����t�B�[�i"		withnew eval="oya_c"	storage=gameloop.txt target=*goto_oyako_c
@oyako page=oyako name=oyako3	comment="���f�B�A���������_"		withnew eval="oya_d"	storage=gameloop.txt target=*goto_oyako_d
@oyako page=oyako name=oyako4	comment="�J�V���j�A���i�X�^�[�V��"	withnew eval="oya_e"	storage=gameloop.txt target=*goto_oyako_e
@oyako page=oyako name=oyako5	comment="�i�I�~������������"		withnew eval="oya_f"	storage=gameloop.txt target=*goto_oyako_f
@oyako page=oyako name=oyako6	comment="�J�g���[�k�������[�k"		withnew eval="oya_g"	storage=gameloop.txt target=*goto_oyako_g
@oyako page=oyako name=oyako7	comment="�~���E���f�B�[��"		withnew eval="oya_h"	storage=gameloop.txt target=*goto_oyako_h
@oyako page=oyako name=oyako8	comment="�����⁕���|"			withnew eval="oya_i"	storage=gameloop.txt target=*goto_oyako_i
@oyako page=oyako name=oyako9	comment="�݂��ꁕ�[��"			withnew eval="oya_j"	storage=gameloop.txt target=*goto_oyako_j
;
@button page=oyako name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; ���l���I��
;
*multi|
@screen page=multi storage=quest_multi rclick=main
;
@multi page=multi name=multi0	comment="�l�ȃG���t�e�j�X��y��"		withnew eval="mul_1"	storage=gameloop.txt target=*goto_multi_1
@multi page=multi name=multi1	comment="�ِ��E���C�h�@�g���v���p�C�Y��"	withnew eval="mul_2"	storage=gameloop.txt target=*goto_multi_2
@multi page=multi name=multi2	comment="�e�q��^����@��e�΍R�p�C�Y�����["	withnew eval="mul_3"	storage=gameloop.txt target=*goto_multi_3
@multi page=multi name=multi3	comment="����I�V���C�I"			withnew eval="mul_4"	storage=gameloop.txt target=*goto_multi_4
@multi page=multi name=multi4	comment="�s�܂��g�D�C�X�^�[�Q�[���I"		withnew eval="mul_5"	storage=gameloop.txt target=*goto_multi_5
;
@button page=multi name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; �G���f�B���O�I��
;
*ending|
@screen page=ending storage=ending_select rclick=main
;
@ending page=ending name=end0	comment="�ِ��E�����ς��n�[�����G���h�I"	eval="end_1"	storage=gameloop.txt target=*goto_end_1
@ending page=ending name=end1	comment="�����ƁI�s�܂��I�n�[�����G���h�I"	eval="end_2"	storage=gameloop.txt target=*goto_end_2
@ending page=ending name=end2	comment="�p��ނƐV��������"			eval="end_a"	storage=gameloop.txt target=*goto_end_a
;
@button page=ending name=back to=main
;
@exit
;-------------------------------------------------------------------------------
; �G���f�B���O�I��sc_14�ʉߔ�
;
*ending14|
@screen page=ending14 storage=ending_select rclick=""
;
@ending page=ending14 name=end0	comment="�ِ��E�����ς��n�[�����G���h�I"	eval="end_1"	storage=gameloop.txt target=*goto_end_1
@ending page=ending14 name=end1	comment="�����ƁI�s�܂��I�n�[�����G���h�I"	eval="end_2"	storage=gameloop.txt target=*goto_end_2
@ending page=ending14 name=end2	comment="�p��ނƐV��������"			eval="end_a"	storage=gameloop.txt target=*goto_end_a

;
@exit
;-------------------------------------------------------------------------------
; �X�e�[�^�X���
;
*status|
@screen page=status storage=status click=main rclick=main nomenu
;
@status page=status	name=ch0	�U���󋵁F�p���
@status page=status	name=ch1	�U���󋵁F�I���K
@status page=status	name=ch2	�U���󋵁F�t�B�[
@status page=status	name=ch3	�U���󋵁F���f�B�A
@status page=status	name=ch4	�U���󋵁F�J�V���j�A
@status page=status	name=ch5	�U���󋵁F�i�I�~��
@status page=status	name=ch6	�U���󋵁F�J�g���[�k
@status page=status	name=ch7	�U���󋵁F�~���E
@status page=status	name=ch8	�U���󋵁F������
@status page=status	name=ch9	�U���󋵁F�݂���
;
@complete page=status	name=harem	eval=".sf.sc_xed01"
@complete page=status	name=hmase	eval=".sf.sc_xed02"
@number   page=status	name=cgcomp	flag=".sf.cg_ratio" keta=3 cpref=num
@text     page=status	name=player	flag="name"
;
@exit

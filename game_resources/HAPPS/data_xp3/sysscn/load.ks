;
; ���[�h���
;

*start_title
	[dialog name=load load fromTitle]
	[syshook name="load.start"]
	[jump target=*open]

; �Z�[�u��ʂ���̑J��
*start_save
	[history enabled=false]
	[dialog name=load load askload]
	[syshook name="load.start"]

*open
	[stoptrans]
	[backlay]

	[syshook name="load.open.init"]
	[syspage uiload page=back]

	[systrans name="load.open" method=crossfade time=300]
	[wt]
	[jump target=*page_done]

*page
	[stoptrans]
	[backlay]

	[syshook name="load.page.init"]
	[syspage uiload page=back]

	[systrans name="load.page" method=crossfade time=300]
	[wt]
*page_done
	[syspage current page=fore]
	[rclick enabled jump storage="" target=*back_rclick]

	[syshook name="load.page.done"]
*wait
	[s]
	[s]

*load
	[syshook name="load.select"]
	[dialog  action=invokeLoad]
	[jump target=*back]

;	[rclick enabled=false jump=false]
;	[locklink]
;	[stoptrans]
;	[backlay]

;	[clearlayers page=back]
;	[systrans name="load.action" method=crossfade time=300]
;	[wt]


; �Z�[�u��ʂ�
*save
	[sysjump to="save" from="load"]

*back_rclick
	; �E�N���b�N���ʉ�
	[sysse name="load.rclick"]
*back
	[syshook name="load.back"]
	[jump target=*title cond=&Current.propget("fromTitle")]

; �Q�[���ɖ߂�
*game
	[sysjump from="load" to="game" back]

*return
	[backlay]
	[syspage free page=back]
	[syshook name="load.close.init"]

	[systrans name="load.close" method=crossfade time=300]
	[wt]
*return_done
	[syshook name="load.close.done"]
	[sysrestore]
	[freesnapshot]

	[return]

; �^�C�g���ɖ߂�
*title
	[sysjump from="load" to="title" back]


; �Q�[������ startLoad() ����̌Ăяo��
*sysfrom_game
	[locksnapshot]
	[sysjump from="game" to="load"]

; �^�C�g����ʒ��̃E�B���h�E���j���[����̌Ăяo��
*sysfrom_title
	[sysjump from="title" to="load"]

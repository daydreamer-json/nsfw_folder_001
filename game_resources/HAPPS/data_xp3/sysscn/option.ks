; 
; ���ݒ�
;

*start_title
	[dialog name="option" fromTitle]
	[syshook name="option.start"]
	[jump target=*open]

*start_game
	[history enabled=false]
	[dialog name="option"]
	[syshook name="option.start"]

*open
	[stoptrans]
	[backlay]

	[syshook name="option.open.init"]
	[syspage uiload page=back]

	[systrans name="option.open" method=crossfade time=300]
	[wt]
	[jump target=*page_done]

*page
	[stoptrans]
	[backlay]

	[syshook name="option.page.init"]
	[syspage uiload page=back]

	[systrans name="option.page" method=crossfade time=300]
	[wt]
*page_done
	[syspage current page=fore]
	[rclick enabled jump storage="" target=*back_rclick]

	[syshook name="option.page.done"]
*wait
	[s]
	[s]

*redraw
	[syspage uiload page=fore]
	[jump target=*page_done]

*back_rclick
	[syshook name="option.rclick"]
	; �E�N���b�N���ʉ�
	[sysse   name="option.rclick"]
*back
	[syshook name="option.back"]
	[jump target=*title cond=&'Current.propget("fromTitle")']

; �Q�[���ɖ߂�
*game
	[sysjump from="option" to="game" back]

; ���A����
*return
	[backlay]
	[syspage free page=back]
	[syshook name="option.close.init"]

	[systrans name="option.close" method=crossfade time=300]
	[wt]
*return_done
	[syshook name="option.close.done"]
	[sysrestore]
	[return]

; �^�C�g���ɖ߂�
*title
	[sysjump from="option" to="title" back]

; startOption() �ɂ��Ăяo��
*sysfrom_title
	[sysjump from="title" to="option"]

*sysfrom_game
	[sysjump from="game"  to="option"]

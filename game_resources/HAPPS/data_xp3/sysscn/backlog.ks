;
; �p�[�X�R���o�[�g�p�̃o�b�N���O
;

*start
	[dialog   name="backlog"]
	[syshook  name="backlog.start"]
	[sysse    name="backlog.open"]

*open
	[stoptrans]
	[backlay]

	[syshook  name="backlog.open.init"]
	[syspage current page=back]
	[syspage  uiload page=back]

	[dialog   action="onShow"]
	[systrans name="backlog.open" method=crossfade time=300]
	[wt]
	[jump target=*page_done]

*page
	[stoptrans]
	[backlay]

	[syshook  name="backlog.page.init"]
	[syspage current page=back]
	[syspage  uiload page=back]

	[dialog   action="onShow"]
	[systrans name="backlog.page" method=crossfade time=300]
	[wt]
*page_done
	[syspage  current page=fore]
	[rclick   enabled jump storage="" target=*back_rclick]

	[syshook  name="backlog.page.done"]
*wait
	[dialog   action="onWait"]
	[s]
	[s]

*jump
	[locklink]
	[stoptrans]
	[begintrans]
	[syspage  free page=back]
	[dialog   action="onHide"]
	[syshook  name="backlog.jump.init"]
	[clearlayers page=back]
;;	[allimage hide delete]
	[all ontype=layer delete]
	[all ontype=dlayer delete]
	[systrans env name="backlog.jump" method=crossfade time=1000]
	[syshook  name="backlog.jump.done"]
*jump_go
	[syscurrent name="game"]
	[sysrestore]

	[syshook  name="backlog.jump"]
	[dialog  action=invokeJump]
	[s]

; [MEMO] sytrans.ini �ɉ��L��ǉ����CgetJumpTarget() { return %[ target:"*jump_meslay" ]; } �ɒu��������
; backlog.jump = 500 : normal : message1
*jump_meslay_withfadeout
	[fadeoutbgm time=500]
	[envstop    time=500]
*jump_meslay
	[locklink]
	[stoptrans]
	[backlay]
	[syspage  free page=back]
	[syshook  name="backlog.jump.init"]

	[dialog   action="onHide"]
	[systrans name="backlog.jump" method=crossfade time=500]
	[wt]
	[jump storage="backlog.ks" target=*jump_go]


*back_rclick
	[syshook  name="backlog.rclick"]
*back
	[sysse    name="backlog.close"]
	[syshook  name="backlog.back"]

; �Q�[���ɖ߂�
*game
	[locklink]
	[stoptrans]
	[backlay]
	[syspage  free page=back]
	[syshook  name="backlog.close.init"]

	[dialog   action="onHide"]
	[systrans name="backlog.close" method=crossfade time=300]
	[wt]

	[syshook  name="backlog.close.done"]
	[sysjump  from="backlog" to="game" back]

; ���A����
*return
	[sysrestore]
	[return]

*sysfrom_game
	[sysjump  from="game" to="backlog"]

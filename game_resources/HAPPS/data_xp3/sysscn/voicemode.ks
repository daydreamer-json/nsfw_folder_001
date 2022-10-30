;
; �{�C�X���
;

; ���[�h��ʂ���̑J��
*start_title
	[dialog name=voicemode load fromTitle]
	[jump target=*start]

*start_load
	[history enabled=false]
	[dialog name=voicemode load]
	[jump target=*start]

*start_save_search
	[history enabled=false]
	[dialog name=voicemode save fromTitle=-1]
	[jump target=*start]

*start_save
	[history enabled=false]
	[dialog name=voicemode save]
	[jump target=*start]

*start
	[syscurrent name="voicemode"]
	[syshook name="voicemode.start"]

; UI�ǂݍ���
*open
	[stoptrans]
	[backlay]

	[syshook name="voicemode.open.init"]
	[syspage uiload page=back]

	[systrans name="voicemode.open" method=crossfade time=300]
	[wt]
	[jump target=*page_done]

*page
	[stoptrans]
	[backlay]

	[syshook name="voicemode.page.init"]
	[syspage uiload page=back]

	[systrans name="voicemode.page" method=crossfade time=300]
	[wt]
*page_done
	[syspage current page=fore]
	[rclick enabled jump storage="" target=*back_rclick]

	[syshook name="voicemode.page.done"]
*wait
	[s]
	[s]


*back_rclick
	[syshook name="voicemode.rclick"]
	; �E�N���b�N���ʉ�
	[sysse name="voicemode.rclick"]
*back
	[dialog action=stopVoice back]
	[syshook name="voicemode.back"]
	[jump target=*search cond=&'Current.propget("fromTitle")<0']
	[jump target=*title  cond=&'Current.propget("fromTitle")']

; �Q�[���ɖ߂�
*game
	[sysjump from="voicemode" to="game" back]

; ���A����
*return
	[backlay]
	[syspage free page=back]
	[syshook name="voicemode.close.init"]

	[systrans name="voicemode.close" method=crossfade time=300]
	[wt]
*return_done
	[syshook name="voicemode.close.done"]
	[sysrestore]
	[freesnapshot]
	[return]

; �^�C�g���ɖ߂�
*title
	[sysjump from="voicemode" to="title" back]

; ������ʂɖ߂�
*search
	[sysjump from="voicemode" to="search" back]


; �Z�[�u��ʂ�
*save
	[sysjump to="save" from="load"]

; SystemAction.vsave() �ɂ��Ăяo��
*sysfrom_title
	[sysjump from="title" to="voicemode"]

*sysfrom_game
	[locksnapshot]
	[sysjump from="game"  to="voicemode"]

*sysfrom_game_load
	[locksnapshot]
	[sysjump from="game.load"  to="voicemode"]

*sysfrom_game_save
	[locksnapshot]
	[sysjump from="game.save"  to="voicemode"]

*sysfrom_backlog
	[dialog   action="onHide"]
	[locksnapshot]
	[sysjump from="backlog"    to="voicemode"]

*sysfrom_search
	[dialog   action="onHide"]
	[sysjump from="search"     to="voicemode"]



*scene_replay
	[syshook name=voicemode.replay]
	[eval exp='loadFunction("voiceload")']
	[s]

; �V�[����z�p
*voice_jump
	[syshook name=voicemode.jump]
	[initscene]
	[voiceload_jump]
	[jump storage="envplay.ks" target=*replay ignorewarn]

; �V�[����z���A
*voice_restore
	[sysse name="voice.back"]
	[eval exp="loadFunction('voicerestore')" cond=f.resumegame]
	;
	[bgm stop time=500]
	[begintrans]
	[clearlayers page=back]
	[envclearimage]
	[endtrans fade=300]
	[call storage=start.ks target=*reset]
	;
	[syshook name=voicemode.restore]
	[sysjump from="title" to="voicemode"]


*start|�v�����[�O
[initscene]
[quickmenu fadein notify]

;�J�n�V�i���I�����L�ɋL��
[�Q�[���J�n storage=sc_pr.txt]

;---------------------------------------------------------------------
; �N�������p�X�N���v�g�B�R���o�[�g���[�h���ǂ����ŋ�����ύX
*jump|
[jump target=*envstart cond=world_object.playerExecMode ignorewarn]
[next storage=&tf.start_storage target=&tf.start_target]

*envstart|
	[initscene]
	[syscurrent name="game"]
	[scenestart storage=&tf.start_storage target=&tf.start_target]
*envplay|
	[sceneplay]
	[exit storage="start.ks" target="*gameend_title"]
	[s]

*gameend_title
	[call target=*reset]
	[sysjump from="game" to="title"]
	[gotostart]
	[s]

*gameend_logo
	[call target=*reset]
	[sysjump from="game" to="logo"]
	[gotostart]
	[s]

*reset
	[envclear]
	[endrecollection]
	[initbase]
	[cancelskip]
	[cancelautomode]
	[linemode]
	[return]


*start|
[syscurrent name="game"]
[initscene]
[linemode mode=none]
[historyopt uiload]
[freesnapshot]
[syshook name="envplay.start"]
[next storage=&tf.storage target=&tf.target eval="world_object.playerReadOnly && !Storages.isExistentStorage(tf.storage+'.scn')" exp="kag.errorCmd('�R���o�[�g�ς݃V�i���I������܂���:'+Storages.extractStorageName(tf.storage))"]
*prepare|
[sysupdate]
[scenestart storage=&tf.storage target=&tf.target]
*play|
[sceneplay]
[gotostart]

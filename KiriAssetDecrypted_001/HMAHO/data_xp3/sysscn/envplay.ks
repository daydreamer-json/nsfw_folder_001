*start|
[syscurrent name="game"]
[initscene]
[linemode mode=none]
[historyopt uiload]
[freesnapshot]
[syshook name="envplay.start"]
[next storage=&tf.storage target=&tf.target eval="world_object.playerReadOnly && !Storages.isExistentStorage(tf.storage+'.scn')" exp="kag.errorCmd('コンバート済みシナリオがありません:'+Storages.extractStorageName(tf.storage))"]
*prepare|
[sysupdate]
[scenestart storage=&tf.storage target=&tf.target]
*play|
[sceneplay]
[gotostart]

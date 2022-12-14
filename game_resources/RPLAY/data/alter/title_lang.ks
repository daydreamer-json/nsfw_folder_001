
@iscript

// 言語変更のサンプル。
// 基本的には自動検索パスのケツに英語用のUIが入ったフォルダを付けたり、外したり。

if(sf.lang === void)sf.lang = "jp";
function setEnglish(force = false){
	if(sf.lang == "jp" || force){
		kag.removePlugin(global.config_object);
		invalidate global.config_object;
		Storages.addAutoPath("#en_image/");
		Storages.addAutoPath("#en_image/others/");
		Storages.addAutoPath("#en_image/title/");
		Storages.addAutoPath("#en_image/config/");
		Storages.addAutoPath("#en_image/extra/");
		Storages.addAutoPath("#en_image/extra/chapter/");
		Storages.addAutoPath("#en_image/extra/sound/");
		Storages.addAutoPath("#en_image/extra/sound/himawari/");
		Storages.addAutoPath("#en_image/extra/sound/yukyu/");
		System.doCompact(clAll);		// 画像キャッシュクリア
		kag.addPlugin(global.config_object = new ConfigPlugin(kag));
		sf.lang = "en";
		kag.rebuildMenu();
	}
}
function setJapanese(){
	if(sf.lang == "en"){
		Storages.removeAutoPath("#en_image/");
		Storages.removeAutoPath("#en_image/others/");
		Storages.removeAutoPath("#en_image/title/");
		Storages.removeAutoPath("#en_image/config/");
		Storages.removeAutoPath("#en_image/extra/");
		Storages.removeAutoPath("#en_image/extra/chapter/");
		Storages.removeAutoPath("#en_image/extra/sound/");
		Storages.removeAutoPath("#en_image/extra/sound/himawari/");
		Storages.removeAutoPath("#en_image/extra/sound/yukyu/");
		System.doCompact(clAll);		// 画像キャッシュクリア
		kag.removePlugin(global.config_object);
		invalidate global.config_object;
		kag.addPlugin(global.config_object = new ConfigPlugin(kag));
		sf.lang = "jp";
		kag.rebuildMenu();
	}
}
if(!tf.en_once && sf.lang == "en"){
	tf.en_once = true;
	setEnglish(true);
}
@endscript
@current layer=message0 page=back
[nowait]
[locate x=5 y="&kag.scHeight-33"][link target=*restart exp="setEnglish()" target=*title_init][font size=15][font color=0xff0000 cond="sf.lang == 'en'"]English UI[resetfont][endlink]
[locate x=80 y="&kag.scHeight-33"][link target=*restart exp="setJapanese()" target=*title_init][font size=15][font color=0xff0000 cond="sf.lang == 'jp'"]Japanese UI[resetfont][endlink]

@return
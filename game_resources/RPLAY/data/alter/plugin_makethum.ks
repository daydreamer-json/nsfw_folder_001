@if exp="typeof(global.makethumbs_object) == 'undefined'"
@iscript

// 注意：レイヤーの増減には対応していないので、余裕を持った枚数のレイヤーを準備しておくこと。

class MakeThumbs extends KAGPlugin
{
	var base;
	var chr = [];
	var msg = [];
	var eff = [];

	function MakeThumbs()
	{
		super.KAGPlugin();

		// ベースレイヤー作成
		//base = new Layer(kag, kag.primaryLayer);
		base = new Layer(kag, global.SaveLoad_object.saveload);
		base.type = ltAlpha;
		base.face = dfAuto;
		base.hitType = htMask;
		base.hitThreshold = 256;
		base.visible = false;

		// キャラクターレイヤー作成
		for(var i = 0; i < kag.numCharacterLayers; i++){
			chr.add(new CharacterLayer(kag, base, "サムネイル生成用レイヤー"+i, i));
		}

		// メッセージレイヤー作成
		//for(var i = 0; i < kag.numMessageLayers; i++){
		//	f.foreMessageLayers[i];
		//}

		// エフェクト作成
		for(var i = 0; i < global.effect_object.count; i++){
			eff.add(new global.Layer(kag, base));
		}
	}

	function finalize()
	{
		invalidate base;
		for(var i = 0; i < chr.count; i++)invalidate chr[i];
		//for(var i = 0; i < msg.count; i++)invalidate msg[i];
		for(var i = 0; i < eff.count; i++)invalidate eff[i];
		super.finalize(...);
	}

	function make(num)
	{
		var modestr;
		// 旧コード、サムネイルがBMPだったころの名残
		//if(kag.saveThumbnail)modestr += "o" + kag.calcThumbnailSize().size;
		//var data = Scripts.evalStorage(kag.getBookMarkFileNameAtNum(num), modestr);
		var data = Scripts.evalStorage(kag.getBookMarkFileNameAtNum(num));
		var f = data.core;

		// ベースをサイズを合わせて黒に塗りつぶす
		base.setImageSize(kag.scWidth, kag.scHeight);
		base.setSizeToImageSize();
		base.fillRect(0,0,base.imageWidth,base.imageHeight,0xff000000);

		try{
			//global.efthum_object
			var no = global.efthum_object.obj_no;
			for(var i=0; i<eff.count; i++){
				var dic = f["effect"+i];
				if(dic !== void){
					dic.time = 0;
					dic.page = void;
					//global.efthum_object.startEffect(dic);

					//parentの疑似対応
					if(dic.effectparent !== void){
						dic.alphaeffect = dic.effectparent;
						dic.effectparent = void;
					}
					
					if(dic.alphaeffect !== void){
						var no2 = global.efthum_object_sub.obj_no;
						global.efthum_object_sub.obj_no = +dic.alphaeffect;
						global.efthum_object_sub.onRestore(f);
						//dic.alphaeffect = no2;
						dic.alphaeffect = "thumbnail_sub";
						global.efthum_object_sub.obj_no = no2;
					}
					global.efthum_object.obj_no = i;
					global.efthum_object.onRestore(f);
					var t = global.efthum_object.targetLayer;
					eff[i].setImageSize(t.imageWidth, t.imageHeight);
					eff[i].setSizeToImageSize();
					eff[i].copyRect(0,0,t,0,0,t.imageWidth,t.imageHeight);
					eff[i].absolute = t.absolute + ((dic.absolute === void)?i:0);
					eff[i].setPos(t.left, t.top);
					eff[i].opacity = t.opacity;
					if(dic.mode !== void)eff[i].type = imageTagLayerType[dic.mode].type;
					else eff[i].type = ltAlpha;
					eff[i].hitType = htMask;
					eff[i].hitThreshold = 256;
					if(dic.sub === "true") eff[i].visible = false;
					else eff[i].visible = true;
				}else eff[i].visible = false;
			}
			global.efthum_object.obj_no = no;
			if(global.efthum_object.alive)global.efthum_object.DeleteObjectNow();
			if(global.efthum_object_sub.alive)global.efthum_object_sub.DeleteObjectNow();
		}catch(e){
			dm("eff命令のサムネイル生成に失敗しました");
		}

		// 選択肢再現
		if(data.user.exlinkDic !== void){
			global.exlink_thumb.endLink();
			global.exlink_thumb.setLinkPos(%[], base, data.user.exlinkDic);
		}else global.exlink_thumb.endLink();

		// 一時的に背景時間を詐称する
		var nowTime = global.f.nowBgTime;
		global.f.nowBgTime = data.user.nowBgTime;

		try{
			for(var i = 0; i < chr.count; i++){
				chr[i].restore(f.foreCharacterLayers[i]);
				// 立ち絵の色変え対応
				if(sysCharCorrect){
					var target = chr[i];
					if(target.Anim_loadParams!=void){
						var storage = target.Anim_loadParams.storage;
						if(storage != "" && storage.substr(0,2)=="st"){
							doCharacterCorrect(target);
						}
					}
				}
			}
		}catch(e){
			dm("サムネイル生成時の立ち絵色変えに失敗\n" + e.message);
		}
		// 背景時間を元に戻す
		global.f.nowBgTime = nowTime;

		base.absolute = 0;
		base.visible = true;
	}

	function clear()
	{
		global.exlink_thumb.endLink();
		base.visible = false;
		for(var i = 0; i < chr.count; i++)chr[i].freeImage();
		for(var i = 0; i < eff.count; i++){
			eff[i].setImageSize(32, 32);
			eff[i].setSizeToImageSize();
			eff[i].fillRect(0,0,32,32,0x0);
			eff[i].visible = false;
		}
	}
}

kag.addPlugin(global.makethumbs_object = new MakeThumbs());

@endscript
@endif
@return

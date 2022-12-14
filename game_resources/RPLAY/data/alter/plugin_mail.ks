@if exp="typeof(global.mail_object) == 'undefined'"
@iscript

class MailPlugin extends KAGPlugin
{
	var lay;
	var layb;
	var clearFlag = false;

	var _data;
	var _name;
	var _sub;
	var _txt;

	var showing = false;

	function MailPlugin()
	{
		super.KAGPlugin(...);
		lay = new Layer(kag, kag.fore.base);
		lay.type = ltAlpha;
		lay.face = dfAlpha;
		lay.font.height = 20;
		lay.font.face = "VLG22";
		lay.font.mapPrerenderedFont("vlg22.tft");

		layb = new Layer(kag, kag.back.base);
		layb.type = ltAlpha;
		layb.face = dfAlpha;

		clear();
	}

	function finalize()
	{
		invalidate lay;
		invalidate layb;
		super.finalize(...);
	}

	function draw(target, data, name, sub, txt, vbl = false)
	{
		_data = data;
		_name = name;
		_sub = sub;
		_txt = txt;

		// 名前・苗字置き換え対応
		//txt = txt.replace(/\[苗字\]/,sf.苗字);
		//txt = txt.replace(/\[名前\]/,sf.名前);

		//txt = txt.replace(/\[ささやき\]/,getNickName());
		//txt = txt.replace(/\[通常\]/,getNickName());
		//txt = txt.replace(/\[Ｈ\]/,getNickName());
		//txt = txt.replace(/\[呼び名\]/,getNickName());

		with(lay){
			.setImageSize(target.imageWidth, target.imageHeight);
			.fillRect(0,0,target.imageWidth, target.imageHeight,0x0);
			.setSizeToImageSize();
			.parent = target;
			.setPos(0, 0);
			.drawText(100,122,name,0x555555,255,true);
			.drawText(100,160,data,0x555555,255,true);
			.drawText(100,197,sub,0x555555,255,true);
			var ar = txt.split(/￥ｎ/,,false);
			var lineCount = 0;
			// 任意改行
			for(var i=0; i<ar.count; i++){
				var t = ar[i];
				if(t == ""){
					lineCount++;
					continue;
				}
				if(t.length <= 16){
					.drawText(35,235+(30*lineCount++),t,0x555555,255,true);
				}else{
					// 自動改行
					var max = Math.ceil(t.length/16);
					for(var j=0; j<max; j++){
						.drawText(35,235+(30*lineCount++),t.substr(j*16, 16),0x555555,255,true);
					}
				}
			}
			.visible = true;
		}
		with(layb){
			.setImageSize(target.imageWidth, target.imageHeight);
			.setSizeToImageSize();
			.parent = target.comp;
			.assignImages(lay);
			.visible = vbl;
		}
		showing = true;
	}

	function clear()
	{
		showing = false;
		clearFlag = false;
		lay.setImageSize(32, 32);
		lay.setSizeToImageSize();
		lay.fillRect(0,0,32,32,0x0);
		lay.visible = false;

		layb.setImageSize(32, 32);
		layb.setSizeToImageSize();
		layb.fillRect(0,0,32,32,0x0);
		layb.visible = false;
	}

	function next_trans_clear(){
		clearFlag = true;
		if(lay.parent == kag.back.layers[12])lay.visible = false;
		else layb.visible = false;
	}

	function onStore(f, elm){
		if(showing){
			f.mail_drawing = %[
				"data"=>_data,
				"name"=>_name,
				"sub"=>_sub,
				"txt"=>_txt
			];
		}else f.mail_drawing = void;
	}

	function onRestore(f, clear, elm){
		if(f.mail_drawing !== void){
			draw(kag.fore.layers[12], f.mail_drawing.data, f.mail_drawing.name, f.mail_drawing.sub, f.mail_drawing.txt, true);
		}else this.clear();
	}

	function onExchangeForeBack(){
		if(clearFlag){
			clear();
		}else if(showing){
			if(kag.conductor.curStorage == "title.ks")clear();
			else lay.visible = layb.visible = true;
		}
	}
}

kag.addPlugin(global.mail_object = new MailPlugin());

@endscript
@endif


@macro name="mail"
@backlay
@simg storage=sp_pda_mail_bg page=back layer=12 left=%left|0
@eval exp="global.mail_object.draw(kag.back.layers[12] , mp.data, mp.name, mp.sub, mp.txt)"
@trans method=crossfade time=500
@wt
@endmacro

@macro name="mail_hide"
@freeimage layer=12 page=back
@eval exp="global.mail_object.next_trans_clear()"
@trans method=crossfade time=500
@wt
@endmacro

@return
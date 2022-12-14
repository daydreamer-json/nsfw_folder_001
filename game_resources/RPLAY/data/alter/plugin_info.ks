@if exp="typeof(global.info_object) == 'undefined'"
@iscript

// なんか情報を表示する(クイックセーブを行いました！とか)

class InfoPlugin extends KAGPlugin
{
	var lay;		// 描画レイヤー
	var timer;		// タイマー
	var startTick;	// 開始時間の記録

	var infoTop = 20; // kag.scHeight-50-228;
	var fadeinTime = 300;		// フェードインの時間
	var fadeoutTime = 500;		// フェードアウトの時間
	var waitingTime = 1000;		// 現状ここで設定しても意味に無い
	var moveWidth = 200;		// 移動幅
	var sx = 0;					// 初期地点
	var dx = 0;					// 到達地点
	var defDx = void;			// 到達地点の指定できる値
	var marginL = 50;			// 文字描画のマージン/これもここで設定しても意味ない
	var locate = 1;				// 出現場所/0:左から/1:右から
	var bgColor = 0xcc5555aa;	// 画像が呼び出せなかった場合の背景色
	var chColor = 0xffffff;		// 文字色

	var bgImgL = "bgm_title_left";
	var bgImgC = "bgm_title_center";
	var bgImgR = "bgm_title_right";

	function InfoPlugin(){ super.KAGPlugin(); }

	function finalize()
	{
		finish();
		super.finalize(...);
	}

	function setOption(elm)
	{
		if(elm.align == "left")locate = 0;
		else if(elm.align == "right")locate = 1;

		if(elm.top !== void)infoTop = (+elm.top);
	}

	function start(txt = void, file = void, force = void, addImg = void)
	{
		// ゲームメニューの設置位置によって出す方向を変更する場合の設定
		//global.info_object.locate = (sf.gameButtonPos!=2)

		// クイックセーブのダイアログ出すか出さないかの判定
		if(!sysDialogQSave && txt === void && file === void)return;

		// 画面はださなくていい場面の設定
		var curs = kag.conductor.curStorage;
		if( !force && (curs == "title.ks" || curs == "title_trial.ks" || curs == "title_after.ks" || curs == "ex_sound.ks" || curs == "ex_cg.ks" || curs == "ex_replay.ks" || curs == "ex_anime.ks" || curs == "ex_after.ks"  || curs == "ex_stand.ks"  || curs == "ex_onasup.ks"))return;

		if(timer == void){
			lay = new Layer(kag, kag.primaryLayer);
			timer = new Timer(onTimer, '');
		}
		timer.enabled=false;

		lay.absolute = 50;

		// マウスメッセージは全域透過
		lay.hitType = htMask;
		lay.hitThreshold = 256;

		if(txt == void){
			waitingTime = 1000;
			if(file != void){
				// テキスト指定されてなくて画像だけ指定がある場合
				waitingTime = 5000;
				try{ lay.loadImages(file); } catch(e){ dm("info画像読み込み失敗："+e.message); return; }
			}else{
				// テキストも画像も指定されていないのであればクイックセーブ成功の画像へ
				lay.loadImages("do_qsave");
			}
			lay.setSizeToImageSize();
			lay.face=dfAlpha;
			lay.type=ltAlpha;
		}else{
			// 以下テキスト指定がある場合
			waitingTime = 3000;
			lay.font.face = "ＭＳ Ｐゴシック";
			lay.font.height = 15;
			var tw = 0;
			var th = lay.font.getTextHeight(txt);
			var mr = 80;
			for(var i=0; i<txt.length; i++)tw += lay.font.getTextWidth(txt.charAt(i));

			// テキスト＋画像の指定がある場合
			if(file !== void){
				try{ lay.loadImages(file); } catch(e) { dm("info背景読み込み失敗"); return; }
				lay.setSizeToImageSize();
				marginL = (lay.imageWidth>>1)-(tw>>1);	// センタリング
			}else{
				try{
					// 3画像引き伸ばしバージョン
					var tmp = new global.Layer(kag, kag.primaryLayer);
					
					if(addImg !== void){
						tmp.loadImages(addImg);
						tw = tmp.imageWidth-30;		// 長すぎるみたいなので調整
					}
					
					tmp.loadImages(bgImgL);
					var lw = tmp.imageWidth;
					marginL = lw + 10;
					tmp.loadImages(bgImgR);
					var rw = tmp.imageWidth;
					tmp.loadImages(bgImgC);
					lay.setImageSize( tw+lw+rw, tmp.imageHeight );
					lay.setSizeToImageSize();
					for(var i = 0; i < lay.width; i += tmp.imageWidth){
						lay.copyRect(i, 0, tmp, 0,0,tmp.imageWidth,tmp.imageHeight);
					}
					tmp.loadImages(bgImgL);
					lay.copyRect(0, 0, tmp, 0,0,tmp.imageWidth,tmp.imageHeight);
					tmp.loadImages(bgImgR);
					lay.copyRect(lay.width-tmp.imageWidth, 0, tmp, 0,0,tmp.imageWidth,tmp.imageHeight);
					
					if(addImg !== void)addImgFunc(tmp, addImg);
					
					invalidate tmp;
				}catch(e){
					// 画像呼び出しできなかったよ・・・
					dm("info用3枚画像の呼び出しに失敗しました："+e.message);
					makeBG(tw+30, th+14);
					marginL = 15;
				}
			}
			// ここの数値"-5"は画像によって変動する
			lay.drawText(marginL, ((lay.imageHeight-th)>>1), txt, chColor, 255, false, 1024, 0, 2, 0, 0);
		}

		// 初期位置
		if(locate){
			sx = kag.scWidth-lay.imageWidth+moveWidth;	// 右から出る
			dx = defDx !== void ? kag.scWidth-(defDx+lay.imageWidth) : kag.scWidth-lay.imageWidth;
		}else{
			sx = -moveWidth;	// 左から出る
			dx = defDx !== void ? defDx : 0;
		}
		lay.setPos(sx, infoTop);
		lay.opacity = 0;
		lay.visible = true;

		startTick = System.getTickCount();

		timer.interval = 20;
		timer.enabled = true;
	}

	// 3枚画像がなかった場合背景を適当に作る
	function makeBG(w, h)
	{
		lay.type = ltAlpha;
		lay.face = dfAlpha;
		lay.setImageSize(w, h);
		lay.setSizeToImageSize();
		lay.fillRect(0, 0, lay.imageWidth, lay.imageHeight, bgColor);
		lay.fillRect(2, 2, lay.imageWidth-4, 1, 0xffffffff);					// 上
		lay.fillRect(2, lay.imageHeight-3, lay.imageWidth-4, 1, 0xffffffff);	// 下
		lay.fillRect(2, 3, 1, lay.imageHeight-5, 0xffffffff);					// 左
		lay.fillRect(lay.imageWidth-3, 3, 1, lay.imageHeight-5, 0xffffffff);	// 右
	}
	
	function addImgFunc(obj, img){
		var ies = Storages.isExistentStorage;
		if(ies(img+".tlg") || ies(img+".png") || ies(img+".jpg")){
			try{
				obj.loadImages(img);
				lay.operateRect(85, 11, obj, 0,0,obj.imageWidth, obj.imageHeight, omAlpha, 255);
			}catch(e){
				if(e)si(e.message);
			}
		}else{
			System.inform("ボーナスの画像の読み込みに失敗しました："+img);
		}
	}

	function onTimer()
	{
		var nowTime = System.getTickCount() - startTick;

		if(nowTime <= fadeinTime){
			var par = (nowTime / fadeinTime);
			if(par > 1.0)par = 1.0;
			lay.opacity = 255 * par;
			lay.left = sx + (dx - sx)*par;
		}else if(nowTime <= fadeinTime+waitingTime){
			lay.opacity = 255;
			lay.left = dx;
		}else if(nowTime <= fadeinTime+waitingTime+fadeoutTime){
			var par = (nowTime-(fadeinTime+waitingTime))/fadeoutTime;
			if(par > 1.0)par = 1.0;
			lay.opacity = 255 * (1-par);
		}else finish();
	}

	function finish()
	{
		if(timer !== void){
			timer.enabled = false;
			invalidate timer;
		}
		if(lay !== void){
			lay.visible = false;
			invalidate lay;
		}
		timer = lay = void;
	}
}

// プラグイン登録
kag.addPlugin(global.info_object = new InfoPlugin());
// ※Cation用カレンダー表示
kag.addPlugin(global.info_object2 = new InfoPlugin());
info_object2.locate = 0;
info_object2.waitingTime = 10000;
// ※Cation用ボーナス表示
kag.addPlugin(global.info_object3 = new InfoPlugin());
info_object3.bgImgL = "lcg_infobg_left";
info_object3.infoTop = 50;


// BGMタイトル用画像が存在した場合は画像呼び出しを行う
function showBgmTitle(mp){
	var elm = %[];
	(Dictionary.assign incontextof elm)(mp);
	var no = elm.storage;
	if(no != "" && no !== void){
		//no = (/^(.*[0-9][0-9])/gi.exec(no))[0];		// 特殊処理、差分削除。２桁の数値の連続までに変更
		var ies = Storages.isExistentStorage;
		var fileName = "info_"+no;
		if(ies(fileName+".tlg") || ies(fileName+".png") || ies(fileName+".jpg")){
			global.info_object.start(void, fileName);
		}else{
			if(bgmTitleList[no] != "")global.info_object.start(bgmTitleList[no]);
		}
	}
}

@endscript
@endif

@macro name="showbgmtitle"
@eval exp="global.info_object.setOption(mp)"
@eval exp="showBgmTitle(mp)"
@endmacro

@macro name="info"
@eval exp="global.info_object.setOption(mp)"
@eval exp="global.info_object.start(mp.txt, mp.storage)" cond="mp.txt !== void || mp.storage !== void"
@endmacro

@macro name="info_stop"
@eval exp="global.info_object.finish()"
@endmacro

; ※Cation用
; ※使い方：@info_bonus name="器用" enabled="&getStatus('器用')>100"
@macro name="info_bonus"
@eval exp="global.info_object3.start(' ',,,'lcg_'+mp.name+'_' +(mp.enabled ? 'on' : 'off'))"
@endmacro

; 必要な場合はもう一つ。
;@eval exp="kag.addPlugin(global.info_object2 = new InfoPlugin());"
;@macro name="info2"
;@eval exp="global.info_object2.setOption(mp)"
;@eval exp="global.info_object2.start(mp.txt, mp.storage)" cond="mp.txt !== void || mp.storage !== void"
;@endmacro
;
;@macro name="info_stop2"
;@eval exp="global.info_object2.finish()"
;@endmacro

@return

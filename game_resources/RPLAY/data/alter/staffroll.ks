@if exp=false
;※how to use
;********************************************************
;@staffroll slide=0 bgm=bgm01 chcolor=0xffffff edgechcolor=0x082889 shadowchcolor=0xb9b9ff
@staffroll slide=0 bgm=bgm01
;// 描画系スクリプト

;// 描画系スクリプト終わり
@staffrollwait
*staffroll_skip
@staffroll_end
;********************************************************
;@staffroll slide=200 bgm=bgm_23 chcolor=0xffffff edgechcolor=0x082889 shadowchcolor=0xb9b9ff
@staffroll slide=200 bgm=bgm_23
@make_staff_img left=150 top=200 s=ev_0001,ev_0002a,ev_0003a,ev_0008a rate=0.4 output=false
*image_loop
@staffroll_img_loop
@staffrollwait
*staffroll_skip
@eval exp="clearStaffRollImg()"
@staffroll_end
;********************************************************
@endif

@if exp="typeof(global.staffroll_object) == 'undefined'"
@iscript

// スタッフロールプラグイン


class StaffRollPlugin extends KAGPlugin
{
	var imgLayers = [];
	var foreLayers = [];
	var currentPos;
	var moveHeight;
	var moveTime;
	var moveStartTick;
	var moving = false;
	var vertical = false;

	var scrollHeight = 0;
	var beforeTick = 0;

	var slide = 0;	// 全体をずらす量
	var addTick = 0;// 時間早送り用
	var readySize = 1.5;	// 準備する文字のサイズ
	var afterSize = 1/readySize;	// どれだけ掛けると希望のサイズになるか

	var staffChColor = 0xffffff;
	var staffEdge = true;		// 文字に縁取りをつけるか（影より優先）
	var staffShadow = false;	// 文字の影をつけるか
	var staffEdgeColor = 0x082889;		// 文字の縁取り色
	var staffEdgeLebel = 512;
	var staffEdgeSize = 3;
	var staffShadowColor = 0xB9B9FF;	// 文字の影の色
	var staffShadowLebel = 512;
	var staffShadowSize = 3;
	var staffShadowOfsX = 3;
	var staffShadowOfsY = 3;

	var staffDefFontFlag = true;
	var staffDefFont     = "ＭＳ ゴシック";	// デフォルトフォント
	var staffFont        = "マティスprodb";

	var staffDefBold = true;		// 太字にするか
	var staffAbsolute = 10000+2;

	var brightLayer;		// なんか上に効果画像乗せるときのレイヤー

	var useBmpFont = true;	// 組み込みフォントを使うか

	function StaffRollPlugin()
	{
		super.KAGPlugin();
	}

	function finalize()
	{
		uninit();
		super.finalize(...);
	}


	function init(slide_all = 0)
	{
		// スタッフロールの初期化
		uninit();
		vertical = kag.current.vertical;

		// ビットマップフォントを使う場合、サイズは固定でいい
		if(useBmpFont){
			readySize = afterSize = 1;
		}

		if(!vertical)currentPos = 0;
		else currentPos = kag.fore.base.width;

		// 効果用レイヤー
//		brightLayer = new Layer(kag, kag.primaryLayer);
//		brightLayer.loadImages("staff_bright_img");
//		brightLayer.setSizeToImageSize();
//		//brightLayer.type = ltPsSoftLight;	// PSのソフトライト合成
//		brightLayer.setPos(0, 0);
//		brightLayer.absolute = staffAbsolute + 100;
//		brightLayer.visible = true;

		scrollHeight = 0;
		slide = +slide_all;

		addTick = 0;
	}

	function addText(opt)
	{
		// スタッフロールにテキストを追加
		var img = new Layer(kag, kag.primaryLayer);

		scrollHeight += +opt.y;

		var ff = img.font;
		var ml = kag.current;

		ml.changeLineSize() if ml.sizeChanged;

		var ref = kag.current.lineLayer;
		var reff = ref.font;
		ff.bold = opt.bold !== void ? +opt.bold : staffDefBold;
		ff.face = opt.face !== void ? opt.face : staffDefFont;
		ff.height = opt.size !== void ? +opt.size : reff.height;
		//ff.height += 1;	// なんだろこれ？
		ff.height *= readySize;	// 文字を大きめに準備する処理
		ff.italic = opt.italic !== void ? opt.italic : reff.italic;
		ff.angle = reff.angle;
		ff.strikeout = reff.strikeout;
		ff.underline = reff.underline;

		
		if(ff.height == 18)
		{
			var _tempFont = staffDefFontFlag ? "vlg20" : staffFont+"_18";
			img.font.face = _tempFont;
			img.font.mapPrerenderedFont( _tempFont+".tft" );
		}
		else
		{
			var _tempFont = staffDefFontFlag ? "vlg22" : staffFont+"_20";
			img.font.face = _tempFont;
			img.font.mapPrerenderedFont( _tempFont+".tft" );
		}

		var cx, cy;
		var text = opt.text;
		cx = ff.getTextWidth(text);
		cy = ff.getTextHeight(text);

		var tx, ty;

		if(!vertical){
			img.setImageSize(cx + 8, cy + 8);
			tx = 4; ty = 4;
		}else{
			img.setImageSize(cy + 8, cx + 8);
			tx = cy + 8 - 4;
			ty = 4;
		}
		if(!(img.imageWidth%2))img.imageWidth += 1;		// アフィンで整数値が入れられる方向は奇数の方が美しい

		img.face = dfBoth;
		img.fillRect(0, 0, img.imageWidth, img.imageHeight, 0);

		if(staffEdge)
			img.drawText(tx, ty, text, staffChColor, 255, ml.antialiased, staffEdgeLebel, staffEdgeColor, staffEdgeSize, 0, 0); // 文字
		else if(staffShadow)
			img.drawText(tx, ty, text, staffChColor, 255, ml.antialiased, staffShadowLebel, staffShadowColor, staffShadowSize, staffShadowOfsX, staffShadowOfsY); // 文字
		else
			img.drawText(tx, ty, text, staffChColor, 255, ml.antialiased); // 文字

		var fore = new Layer(kag, kag.primaryLayer);
		fore.absolute = staffAbsolute;
		fore.setImageSize(img.imageWidth*afterSize+2, img.imageHeight*afterSize+2);
		fore.setSizeToImageSize();
		fore.hitType = htMask;
		fore.hitThreshold = 256;
		fore.visible = true;
		fore.typeis = "txt";

		// 場所決め
		var x, y;
		if(!vertical)
		{
			if(opt.sp == 1)x = kag.scWidth\2 - fore.width\2 -5;
            else if(opt.sp == 2)x = kag.scWidth\2 + fore.width\2 + 5;
			else x = opt.x !== void ? +opt.x : (kag.scWidth\2);
			x -= fore.imageWidth/2;
			y = currentPos += +opt.y;
		}
		else
		{
			x = (currentPos -= +opt.x) - cy;
			y = +opt.y;
		}

		// 全体のスライド命令を受け入れ
		x += slide;

		fore.setPos(x, y);
		if(!vertical){
			fore.orgY = y;
		}else{
			fore.orgX = x;
		}

		imgLayers.add(img);
		foreLayers.add(fore);
	}

	function addImage(opt)
	{
		// スタッフロールに画像を追加
		var img = new Layer(kag, kag.primaryLayer);
		img.loadImages(opt.storage);
		img.setSizeToImageSize();

		var fore = new Layer(kag, kag.primaryLayer);
		fore.absolute = staffAbsolute;
		fore.setImageSize(img.imageWidth+2, img.imageHeight+2);
		fore.setSizeToImageSize();
		fore.hitType = htMask;
		fore.hitThreshold = 256;
		fore.visible = true;
		fore.typeis = "img";

		// スタッフロールの高さに画像の高さ追加
		scrollHeight += fore.imageHeight;

		// 場所決め
		var x, y;
		if(!vertical){
			//x = opt.x !== void ? +opt.x : ((kag.scWidth\2) - (fore.width\2));
			x = opt.x !== void ? (+opt.x+fore.imageWidth\2) : ((kag.scWidth\2)-fore.imageWidth\2);
			y = (currentPos += +opt.y + fore.imageHeight\2);
		}else{
			x = (currentPos -= +opt.x) - fore.imageWidth;
			y = +opt.y;
		}

		// 全体のスライド命令を受け入れ
		x += slide;

		fore.setPos(x, y);
		if(!vertical){
			fore.orgY = y;
		}else{
			fore.orgX = x;
		}

		imgLayers.add(img);
		foreLayers.add(fore);
	}

	function addSpace(opt)
	{
		scrollHeight += (int)opt.y;
		currentPos += (int)opt.y;
	}

	function doAffine(obj, img, x, y, r=0, s=1)
	{
		if(obj.typeis!="img")
		s -= (1-afterSize);	// 大きく準備した文字を縮小する
		if(s < 0)s=0.0000000001;	// サイズは0以下にはならないように
		var l = obj.imageWidth/2;
		var t = obj.imageHeight/2 - y;
		var cx = img.imageWidth/2;
		var cy = img.imageHeight/2;

		// pathで指定するのは画像における中心を画面のどこに置くか
//		l -= (obj.imageWidth/2-cx)*s;
//		t -= (obj.imageHeight/2-cy)*s;

//		var rc = Math.cos(r);
//		var rs = Math.cos((Math.PI/2.0) - r);
		var rc = 1;
		var rs = Math.cos((Math.PI/2.0));

		var m00 = s * rc;
		var m01 = s * -rs;
		var m10 = s * rs;
		var m11 = s * rc;
		var mtx = (m00*-cx) + (m10*-cy) + l;
		var mty = (m01*-cx) + (m11*-cy) + t;

		// アフィン変換転送
		obj.affineCopy(
					img, 0, 0, img.imageWidth, img.imageHeight, true,
					m00, m01, m10, m11, mtx, mty, stFastLinear, false
					);
	}

	function startMove(addHeight, time)
	{
		// 移動を開始

		if(moving) return;

		moveStartTick = System.getTickCount();
		moveHeight = scrollHeight + foreLayers[-1].height + addHeight;
		moveTime = time;

		beforeTick = System.getTickCount();

		System.addContinuousHandler(moveHandler);
		moving = true;
	}

	function uninit()
	{
		// 停止とクリーンアップ

		if(moving)System.removeContinuousHandler(moveHandler);
		moving = false;

		for(var i = 0; i < imgLayers.count; i ++)invalidate imgLayers[i];
		for(var i = 0; i < foreLayers.count; i ++)invalidate foreLayers[i];

		imgLayers.count = 0;
		foreLayers.count = 0;

		if(brightLayer !== void){
			invalidate brightLayer;
			brightLayer = void;
		}
	}

	function chColor( aChColor, aEdgeChColor, aShadowChColor )
	{
		staffChColor     = aChColor;
		staffEdgeColor   = aEdgeChColor;
		staffShadowColor = aShadowChColor;
	}

	function moveHandler(tick)
	{
		//if(tick - beforeTick < 16)return;
		beforeTick = tick;

		if(System.getKeyState(VK_CONTROL))addTick+=20;
		tick+=addTick;

		// 移動ハンドラ
		var current = tick - moveStartTick;
		var orgNowMoveHeight = moveHeight * current / moveTime;
		var nowMoveHeight = Math.floor(orgNowMoveHeight);
		var affine = orgNowMoveHeight - nowMoveHeight;

		var f = foreLayers;
		var laycount = f.count;

		if((f[-1].orgY-nowMoveHeight) <= -(f[-1].height)){
			kag.trigger('staffroll');
			return uninit();
		}

		for(var i = laycount - 1; i >= 0; i--)
		{
			var fl = f[i];
			var nowTop = (fl.orgY-nowMoveHeight);

			// 画面外は処理しない
			if(nowTop <= kag.scHeight && (nowTop+fl.imageHeight) >= 0){
				fl.visible = true;
				fl.top = nowTop;
				doAffine(fl, imgLayers[i], fl.imageWidth/2, affine);
			}else fl.visible = false;
		}
	}

	function onExchangeForeBack(){}
}

kag.addPlugin(global.staffroll_object = new StaffRollPlugin());
	// プラグインオブジェクトを作成し、登録する


// 以下汎用のスタッフロール画像作成用関数

// 画像をマスクして返す
function maskCopy(obj, storage, aMask){

	var test  = new Layer(kag, kag.fore.base);
	var test2 = new Layer(kag, test);
	var test3 = new Layer(kag,kag.fore.base);
	var _mask = "alpha_bore_center_00";

	if( aMask !== void && aMask != "" )	_mask = aMask;

	test.fillRect(0,0,test.width,test.height,0x0);
	test.loadImages(_mask);
	test.setSizeToImageSize();
	test.turnAlpha();

	test2.loadImages(storage);
	test2.setSizeToImageSize();
	test2.visible = true;
	test2.type = ltAdditive;

	test3.setImageSize(test.width,test.height);
	test3.setSizeToImageSize();
	test3.piledCopy(0,0,test,0,0,test.width,test.height);
	test3.visible = true;
	obj.setImageSize(test3.imageWidth,test3.imageHeight);
	obj.setSizeToImageSize();
	obj.copyRect(0,0,test3,0,0,test3.imageWidth,test3.imageHeight);
	invalidate test;
	invalidate test2;
	invalidate test3;
}
function createStaffRollImage(obj, s, rate, output, mask){
	var ies = Storages.isExistentStorage;
	var s2 = "staffimg_"+s;
	if(ies(s2+".bmp") || ies(s2+".jpg") || ies(s2+".png") || ies(s2+".tlg")){
		obj.loadImages(s2);
		obj.setSizeToImageSize();
	}else{
		var img = new Layer(kag, kag.primaryLayer);
		maskCopy(img, s, mask);
		var w = img.imageWidth*rate;
		var h = img.imageHeight*rate;
		obj.setImageSize(w, h);
		obj.stretchCopy(0,0,w,h,img,0,0,img.imageWidth,img.imageHeight,stLinear/*stCubic*/);
		if(output){
			obj.saveLayerImage(System.exePath + "!staffroll_img/" + s2 + ".bmp", "bmp32");
			Storages.addAutoPath(System.exePath + "!staffroll_img/");
		}
		invalidate img;
	}
	
}
function readyStaffRoll(elm){
	tf.staffImgArray = [];
	var ar = (elm.s).split(",");
	for(var i=0; i<ar.count; i++){
		var index = tf.staffImgArray.add(new KAGLayer(kag, kag.fore.base));
		kag.add(tf.staffImgArray[index]);
		with(tf.staffImgArray[index]){
			createStaffRollImage(tf.staffImgArray[index], ar[i], (elm.rate===void ? 0.4 : +elm.rate), elm.output=="true", elm.mask);
			.setSizeToImageSize();
			.setPos(+elm.left, +elm.top);
			.opacity = 0;
			.hitType = htMask;
			.hitThreshold = 256;
			.visible = true;
		}
		tf.staffImgCount = 0;
	}
	//var t = kag.bgm.currentBuffer.totalTime-8000;
	if( elm.time === void | elm.time == '' ) elm.time = global.staffroll_object.moveTime-8000;

	var t = elm.time;
	tf.staffImgChangeTime = (t-(ar.count*1000))/ar.count-1000;
}
function showStaffRollImg(){
	var target = tf.staffImgArray[tf.staffImgCount];

	target.beginMove(%[path:target.left+","+target.top+",0,"+target.left+","+target.top+",255", time:500]);
	hideStaffRollImg();
}
function hideStaffRollImg(){
	if(tf.staffImgCount-1 >= 0){
		var target = tf.staffImgArray[tf.staffImgCount-1];
		target.beginMove(%[path:target.left+","+target.top+",0,"+target.left+","+target.top+",0", time:500]);
	}
	tf.staffImgCount += 1;
}
function clearStaffRollImg(){
	for(var i=0; i<tf.staffImgArray.count; i++){
		kag.remove(tf.staffImgArray[i]);
		invalidate tf.staffImgArray[i];
	}
	tf.staffImgArray.clear();
}

@endscript
@endif

; 標準マクロ定義
@macro name=staffrollinit
@eval exp="staffroll_object.init(mp.slide)"
@endmacro
@macro name=staffrolltext
@eval exp="staffroll_object.addText(mp)"
@endmacro
@macro name=staffrollspace
@eval exp="staffroll_object.addSpace(mp)"
@endmacro
@macro name=staffrollimage
@eval exp="staffroll_object.addImage(mp)"
@endmacro
@macro name=staffrollstart
@eval exp="staffroll_object.startMove(+mp.addheight, +mp.time)"
@clickskip enabled=true
@endmacro
@macro name=staffrollwait
@waittrig name="staffroll" canskip="&sf.show_staffroll" cond="global.staffroll_object!=void && global.staffroll_object.moving"
@endmacro
@macro name=staffrolluninit
@eval exp="sf.show_staffroll=true"
@eval exp="staffroll_object.uninit()"
@endmacro
@macro name=staffrollchcolor
@eval exp="staffroll_object.chColor( mp.chcolor, mp.edgechcolor, mp.shadowchcolor )"
@endmacro
; 使いやすく調整したマクロ定義
@macro name="staff_caption"
;@eval exp="mp.caption = '―― ' + mp.caption + ' ――'"
@staffrolltext y=%y|150 text=%caption size=18
@staffrollspace y=15
@endmacro

@macro name="staff_eng_caption"
@eval exp="mp.caption = '- ' + mp.caption + ' -'"
@staffrolltext y=%y|5 text=%caption size=18
@staffrollspace y=15
@endmacro

@macro name="staff_sub_caption"
@staffrolltext y=%y|25 text=%caption size=20
@endmacro

@macro name="staff_name"
@staffrolltext y=25 text=%name size=20
@endmacro

@macro name="staff_item"
@staffrolltext y=%y|25 text=%section size=20 sp=1
@staffrolltext y=0 text=%name size=20 sp=2
@endmacro

@macro name="staff_item2"
@staffrolltext y=%y|25 text=%name size=20 x=540
@staffrolltext y=0 text=%name2 size=20 x=740
@endmacro

@macro name="staff_img"
@staffrollimage *
@endmacro

@macro name="staff_img2"
@staffrollimage * fillcolor="&tf.staffFillColor"
@staffrollspace y=60
@endmacro

@macro name="make_staff_img"
;@eval exp="createStaffRoll(mp)"
@eval exp="readyStaffRoll(mp)"
@endmacro
@macro name="staffroll_img_loop"
[eval exp="showStaffRollImg()"][wm canskip=false][wm canskip=false][wait time="&tf.staffImgChangeTime" canskip=false]
[eval exp="kag.cancelSkip()"]
[jump target="*image_loop" cond="tf.staffImgCount<tf.staffImgArray.count"]
[eval exp="hideStaffRollImg()"][wm canskip=false]
@endmacro

;-------------------------------------------------------
; スタッフロール準備
;-------------------------------------------------------
@macro name="staffroll"
@eval exp="skipAutoPause()"
@eval exp="tf.isStaffroll = true"
; 右にスライド
@staffrollinit slide=%slide|0
; 履歴を無効化
@history enabled=false
; ボイス停止、BGMタイトル表示停止
@fovo
@info_stop
; スタッフロール文字色を変更
@staffrollchcolor chcolor=%chcolor|0xffffff edgechcolor=%edgechcolor|0x082889 shadowchcolor=%shadowchcolor|0xb9b9ff
; スタッフ名をセット
@call storage="staffroll.ks" target="*set_staffname"
; ＢＧＭ
@sbgm cond="mp.nobgm != 'true'"
@bgm storage=%bgm|ed_theme loop=false notitle=true cond="mp.nobgm != 'true'"
; スタート
@staffrollstart addheight=0 time="&(kag.bgm.currentBuffer.status=='play') ? (kag.bgm.currentBuffer.totalTime-5000) : (2*60000)"
@wait time=3000 canskip=false
; 3秒後にショートカット設定
@call storage="staffroll.ks" target="*set_shortcut"
@endmacro

;-------------------------------------------------------
; スタッフロール解除
;-------------------------------------------------------
@macro name="staffroll_end"
@call storage="staffroll.ks" target="*key_release"
; ロゴ表示
@stoptrans
@stopmove
@staffrolluninit
;@wait time=1000
@clearlayers
@eff_all_delete
@simg storage=white layer=0 page=back left=0 top=0 opacity=255 visible=true
@simg storage=t_blogo layer=1 page=back left=0 top=0 opacity=255 visible=true
@eval exp="kag.back.layers[1].setPos((kag.scWidth>>1)-(kag.back.layers[1].imageWidth>>1),(kag.scHeight>>1)-(kag.back.layers[1].imageHeight>>1))"
@trans method=crossfade time=1000
@wt
@wait time=2000
;@waitclick cond="mp.noclick === void"
@fobgm time=2000
@white time=2000
; 履歴を有効化
@history enabled=true
; ゲーム用ショートカットを設定
@call storage="staffroll.ks" target="*key_shortcut_game"
@eval exp="delete tf.isStaffroll"
@eval exp="skipAutoResume()"
@endmacro

@return

;-------------------------------------------------------
; スタッフ名登録
;-------------------------------------------------------
*set_staffname
@iscript
{
	var staffList = [];
	staffList.load("staffroll.txt");
	with(staffroll_object){
		.addSpace(%[y:kag.scHeight]);
		for(var i=0; i<staffList.count; i++){
			var line = staffList[i];
			if(line == "")continue;	// 空白行
			if(line.substr(0,2) == "//")continue;	// コメント行
			var head = line.charAt(0);
			var txt = line.substr(1);
			switch(head){
			case "&":	// 置換
				try{
					var str = txt!;
					// 評価の結果からっぽなら無視
					if(str != "").addText(%[y:25, text:str, size:20]);
				}catch(e){
					dm(e.message);
				}
				break;
			case "■":	// 担当
				.addText(%[y:150, text:"― "+txt+" ―", size:18]);
				//.addText(%[y:150, text:txt, size:18]);
				.addSpace(%[y:15]);
				break;
			case "@":	// 担当英語名
				.addText(%[y:5, text:'- '+txt+ ' -', size:18]);
				.addSpace(%[y:15]);
				break;
			case "●":	// 曲タイトル用
				.addText(%[y:25, text:txt, size:20]);
				break;
			case "#":	// 画像
				.addImage(%[storage:txt]);
				break;
			case "%":	// スペース
				.addSpace(%[y:12]);
				break;
			default:
				if(/\t/i.test(line)){	// 担当付き名前
					var ar = line.split(/\t/,,true);
					if(ar.count == 2){
						.addText(%[y:25, text:ar[0], size:20, sp:1]);
						.addText(%[y:0, text:ar[1], size:20, sp:2]);
					}else{
						System.inform("担当付き名前の分割に失敗しました。記述を確認してください。\n"+(i+1)+"行目\n"+txt);
					}
				}else{	// 通常の名前
					.addText(%[y:25, text:line, size:20]);
				}
				break;
			}
		}
	}
}
@endscript
@return

;-------------------------------------------------------
; スタッフロール用ショートカット設定
;-------------------------------------------------------
*set_shortcut
@iscript
kag.cancelSkip();
tf.noCtrlSkip = true;
kag.clickSkipEnabled=false;
// キー及び右クリックの設定
kag.rightClickHook.clear();
kag.keyDownHook.clear();
if(sf.show_staffroll){
	kag.rightClickHook.add(function(){kag.process("", "*staffroll_skip");});
	kag.leftClickHook.add(function(){kag.process("", "*staffroll_skip");});
}
@endscript
@return

;-------------------------------------------------------
; ショートカット設定解除
;-------------------------------------------------------
*key_release
@iscript
kag.rightClickHook.clear();
kag.leftClickHook.clear();
@endscript
@return

;-------------------------------------------------------
; ゲーム用ショートカット設定
;-------------------------------------------------------
*key_shortcut_game
@iscript
kag.cancelSkip();
tf.noCtrlSkip = false;
kag.clickSkipEnabled = sysClickSkip;
// キー及び右クリックの設定
kag.rightClickHook.clear();
kag.keyDownHook.clear();
kag.rightClickHook.add(gameRClickFunc);
kag.keyDownHook.add(gameKeyFunc);
@endscript
@return

@if exp="typeof(global.lineFrameObject) == 'undefined'"
@iscript
//--------------------------------------------------------------------------
// 行ごとにフレームが生成されるプラグイン
//		メモ：不透明度はsysMsgOpacity参照
//			：ウィンドウのデザイン(sysMsgDesign)が1の時に下記を適用
//			：フレームの生成自体は常に行い、表示状態をvisibleで切り替える
//			：通常のフレームの表示状態はopacityで切り替える
//--------------------------------------------------------------------------

// 対象となる文字描画レイヤー
//------------------------------------------------------------------
global.LineFrameTarget = kag.messageLayer;

// 常にsysMsgDesignでウィンドウを変える場合↓は0
// HシーンのみsysHMsgDesignでウィンドウを変える場合↓は1
@set(HMSGUSE=1)

// 一行フレーム
//------------------------------------------------------------------
class LineFrameLayer
{
	var l, c, r;
	var _width = 0;
	var _opacity = 255;
	var _visible = false;	// 実際に表示しているかどうか
	var state = false;		// 表示するべき状況下どうか
	var minw = 0;
	var init = false;
	var cw = 0;
	
	var filel = "g_frame_ml";
	var filec = "g_frame_mc";
	var filer = "g_frame_mr";
	

	function LineFrameLayer(){
		l = new global.Layer(kag, kag.primaryLayer);
		c = new global.Layer(kag, kag.primaryLayer);
		r = new global.Layer(kag, kag.primaryLayer);
		l.loadImages(filel);
		c.loadImages(filec);
		r.loadImages(filer);
		basePropSet(l);
		basePropSet(c);
		basePropSet(r);
		cw = c.imageWidth;
		minw = (l.imageWidth + r.imageWidth);
		width = minw;
	}
	function finalize(){
		invalidate l;
		invalidate c;
		invalidate r;
	}
	function basePropSet(target){
		with(target){
			.setSizeToImageSize();
			.face = dfAlpha;
			.type = ltAlpha;
			.hitType = htMask;
			.hitThreshold = 256;
			.opacity = 255;
			.visible = false;
		}
	}
	function setPos(x, y){
		l.setPos(x, y);
		c.setPos(x+l.imageWidth, y);
		r.setPos(x+l.imageWidth, y);
	}
	function c_stretch(w){
		var curx = c.imageWidth;
		var width = w - curx;		// どれだけ伸びるか
		c.imageWidth = w;
		c.setSizeToImageSize();
		while(curx < w){
			c.copyRect(curx,0,c,0,0,cw,c.imageHeight);
			curx += cw;
		}
	}
	property width{
		setter(w){
			_width = w;
			if(_width <= minw){
				r.left = l.left + l.imageWidth;
				c.visible = false;
			}else{
				var cwidth = _width - minw;
				if(cwidth > c.imageWidth){
					c_stretch(cwidth);
				}
				c.width = cwidth;
				if(visible)c.visible = true;
				r.left = l.left + _width - r.imageWidth;
			}
		}
		getter{ return _width; }
	}
	property opacity{
		setter(o){
			l.opacity = c.opacity = r.opacity = _opacity = o;
		}
		getter{ return _opacity; }
	}
	property absolute{
		setter(a){
			l.absolute = a;
			c.absolute = a;
			r.absolute = a;
		}
		getter{ return l.absolute; }
	}
	property visible{
		setter(v){
			l.visible = c.visible = r.visible = _visible = v;
			if(_width <= minw)c.visible = false;
		}
		getter{ return _visible; }
	}
}


// 一行フレームをまとめて管理
//------------------------------------------------------------------
class LineFrameControl
{
	var lineCount = 3;	// 初期生成数、足りない時は増える
	var margin = 10;	// 両端の余裕
	var layers = [];
	function LineFrameControl(){
		for(var i=0; i<lineCount; i++)layers.add(new LineFrameLayer());
	}
	function finalize(){
		for(var i=0; i<layers.count; i++)invalidate layers[i];
		layers.clear();
	}
	function set(ch){
		// フレームの濃度が違ったら再設定
@if(HMSGUSE)
		if(layers[0].opacity != sysHMsgOpacity){
			for(var i=0; i<layers.count; i++)layers[i].opacity = sysHMsgOpacity;
@endif
@if(HMSGUSE==0)
		if(layers[0].opacity != sysMsgOpacity){
			for(var i=0; i<layers.count; i++)layers[i].opacity = sysMsgOpacity;
@endif
		}
		with(LineFrameTarget){
			var top = .y - .marginT;
			var index = top / (.lineSpacing + .lineSize);
			var offsetx = LineFrameTarget.font.getTextWidth("　");// 開始横位置調整
			// 足りない場合追加生成
			while(index >= layers.count)layers.add(new LineFrameLayer());
			if(index >= 0){
				var target = layers[index];
				if(!target.init){
					target.absolute = .absolute - 1;
					target.init = true;
				}
				target.setPos(.left + .marginL - margin + offsetx, .top + .y - 5);
				// processchより前に処理する場合のコード
				//target.width = (.x - .marginL) + LineFrameTarget.lineLayer.font.getTextWidth(ch) + margin*2;
				target.width = (.x - .marginL) +  margin*2;
				target.state = true;
@if(HMSGUSE)
				if(f.isHScene == 1 && sysHMsgDesign == 1)target.visible = true;		// 実際に表示するかどうかはウィンドウデザインによる
@endif
@if(HMSGUSE==0)
				if(sysMsgDesign == 1)target.visible = true;		// 実際に表示するかどうかはウィンドウデザインによる
@endif
			}
		}
	}
	function clear(){
		for(var i=0; i<layers.count; i++){
			layers[i].visible = false;
			layers[i].state = false;
		}
	}
	function stateChange(tof){
		for(var i=0; i<layers.count; i++){
			if(tof && layers[i].state)layers[i].visible = true;
			else layers[i].visible = false;
		}
	}
	property opacity{
		setter(o){
			for(var i=0; i<layers.count; i++)layers[i].opacity = o;
		}
		getter(){ return layers[0].opacity; }
	}
}
// 生成＆kagに登録
var lineFrameObject = new LineFrameControl();
kag.add(lineFrameObject);

// 対象の文字描画レイヤーの文字描画と文字クリアをフック
//------------------------------------------------------------------
LineFrameTarget.lframe_processCh = LineFrameTarget.processCh;
LineFrameTarget.processCh = function(ch){
	var re = lframe_processCh(...);
	lineFrameObject.set(ch);
	return re;
}incontextof LineFrameTarget;

LineFrameTarget.lframe_clear = LineFrameTarget.clear;
LineFrameTarget.clear = function(){
	lineFrameObject.clear();
	return lframe_clear(...);
}incontextof LineFrameTarget;


// シナリオフォルダ以下のファイルが実行中か取得する関数
//------------------------------------------------------------------
function isScenario(){
	var snr = kag.mainConductor.curStorage;
	var filePath = Storages.getPlacedPath(snr);
	var reg = new RegExp("scenario/","gi");
	// scenarioフォルダ以下を実行中のみデザイン即時変更が有効化
@if(HMSGUSE)
	if(f.isHScene == 1 && filePath != "" && filePath !== void && reg.test(filePath))return true;
@endif
@if(HMSGUSE==0)
	if(filePath != "" && filePath !== void && reg.test(filePath))return true;
@endif
	//立ち絵鑑賞モードのみ例外
	if(snr == "ex_stand.ks") return true;
	if(snr == "ex_stand_e-mote.ks") return true;
	// バックログジャンプ中のシナリオ判定用
	if(snr != "" && snr.substr(0,6) == "@@sbgm")return true;
	
	if(snr == "app_001_00_h.ks") return true;
	return false;
}


// メッセージレイヤー(フレーム置いてあるとこ)のopacityプロパティ乗っ取り
// ウィンドウデザインが1の時は不透明度を0にする
//------------------------------------------------------------------
kag.fore.messages[0].opacitySetting = kag.fore.messages[0].opacity;
kag.back.messages[0].opacitySetting = kag.back.messages[0].opacity;
kag.fore.messages[0].a34f6ce3e100_opacity = &kag.fore.messages[0].opacity;
kag.back.messages[0].d2636ee7602b_opacity = &kag.back.messages[0].opacity;
kag.fore.messages[1].opacitySetting = kag.fore.messages[1].opacity;// ネームボックスも
kag.back.messages[1].opacitySetting = kag.back.messages[1].opacity;
kag.fore.messages[1].a34f6ce3e100_opacity = &kag.fore.messages[1].opacity;
kag.back.messages[1].d2636ee7602b_opacity = &kag.back.messages[1].opacity;
property a34f6ce3e100{
	setter(v){

@if(HMSGUSE)
		if(isScenario() && sysHMsgDesign == 1 && f.isHScene == 1){
			kag.fore.messages[0].setPosition(%[frame:'g_frame']);
@endif
@if(HMSGUSE==0)
		if(isScenario() && sysMsgDesign == 1){
@endif
			
			a34f6ce3e100_opacity = 0;
		}else a34f6ce3e100_opacity = v;
		opacitySetting = v;
	}
	getter{ return opacitySetting; }
}
property d2636ee7602b{
	setter(v){

@if(HMSGUSE)
		if(isScenario() && sysHMsgDesign == 1 && f.isHScene == 1){
			kag.back.messages[0].setPosition(%[frame:'g_frame']);
@endif
@if(HMSGUSE==0)
		if(isScenario() && sysMsgDesign == 1){
@endif

			d2636ee7602b_opacity = 0;
		}else d2636ee7602b_opacity = v;
		opacitySetting = v;
	}
	getter{ return opacitySetting; }
}
&kag.fore.messages[0].opacity = &a34f6ce3e100 incontextof kag.fore.messages[0];
&kag.back.messages[0].opacity = &d2636ee7602b incontextof kag.back.messages[0];
&kag.fore.messages[1].opacity = &a34f6ce3e100 incontextof kag.fore.messages[1];// ネームボックスも
&kag.back.messages[1].opacity = &d2636ee7602b incontextof kag.back.messages[1];
// メッセージデザイン用プロパティの名称変更して乗っ取り
// ウィンドウデザインを変更された際に通常フレームとラインフレームの表示状態を切り替える
//------------------------------------------------------------------
@if(HMSGUSE)
	var l_frame_sysMsgDesign = &sysHMsgDesign;
@endif
@if(HMSGUSE==0)
	var l_frame_sysMsgDesign = &sysMsgDesign;
@endif
property aee815b9e2e5{
	setter(x){
		l_frame_sysMsgDesign = x;
		if(isScenario){
			kag.fore.messages[0].opacity = kag.fore.messages[0].opacity;
			kag.back.messages[0].opacity = kag.back.messages[0].opacity;
			kag.fore.messages[1].opacity = kag.fore.messages[1].opacity;// ネームボックスも
			kag.back.messages[1].opacity = kag.back.messages[1].opacity;
@if(HMSGUSE)
			lineFrameObject.stateChange(l_frame_sysMsgDesign == 1 && f.isHScene == 1);
@endif
@if(HMSGUSE==0)
			lineFrameObject.stateChange(l_frame_sysMsgDesign == 1);
@endif
		}
	}
	getter(){
		return l_frame_sysMsgDesign;
	}
}
@if(HMSGUSE)
	&global.sysHMsgDesign = &aee815b9e2e5;
@endif
@if(HMSGUSE==0)
	&global.sysMsgDesign = &aee815b9e2e5;
@endif

// メッセージの不透明度用プロパティの名称変更して乗っ取り
// ラインフレームにも適用するように
//------------------------------------------------------------------
@if(HMSGUSE)
	var l_frame_sysMsgOpacity = &sysHMsgOpacity;
@endif
@if(HMSGUSE==0)
	var l_frame_sysMsgOpacity = &sysMsgOpacity;
@endif
property ff8409a0ac08{
	setter(x){
		l_frame_sysMsgOpacity = x;
		lineFrameObject.opacity = x;
	}
	getter(){
		return l_frame_sysMsgOpacity;
	}
}
@if(HMSGUSE)
	&global.sysHMsgOpacity = &ff8409a0ac08;
@endif
@if(HMSGUSE==0)
	&global.sysMsgOpacity = &ff8409a0ac08;
@endif


// 一時的にメッセージウィンドウを非表示、
// 一時的にメッセージウィンドウを非表示にしたものを表示する処理を乗っ取り
// ラインフレームにも適用
// （関数を乗っ取るときは元の関数に戻り値があることを考慮して「return」処理をしておくことをオススメ）
//------------------------------------------------------------------
kag.c67b6713 = kag.hideMessageLayerByUser;
kag.e30a9c70 = kag.showMessageLayerByUser;

kag.hideMessageLayerByUser = function(){
	var _result = kag.c67b6713();	// 元の「hideMessageLayerByUser」
	lineFrameObject.stateChange(false);
	return (_result);
};

kag.showMessageLayerByUser = function(){
	var _result = kag.e30a9c70();	// 元の「showMessageLayerByUser」
@if(HMSGUSE)
	lineFrameObject.stateChange(l_frame_sysMsgDesign == 1 && f.isHScene == 1);
@endif
@if(HMSGUSE==0)
	lineFrameObject.stateChange(l_frame_sysMsgDesign == 1);
@endif
	return (_result);
};

@endscript
@endif

@return
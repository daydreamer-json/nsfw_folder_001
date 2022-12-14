@if exp="typeof(global.counterObj) == 'undefined'"
@iscript
class SyaseiCounterPlugin extends KAGPlugin
{
	var mCNT_MAX = 11;
	var mCNT_MIN = 0;

	var imgLayer, imgLayerb;
	var counter      = mCNT_MAX;
	var active       = false;
	var isImgCntDown = true;  // 「g_scounter」の画像が左からカウントダウンかどうかのフラグ／true：カウントダウン false：カウントアップ

	function SyaseiCounterPlugin()
	{
		super.KAGPlugin(...);

		imgLayer = new Layer(kag, kag.fore.base);
		imgLayerb = new Layer(kag, kag.back.base);
		imgLayer.loadImages("g_scounter");
		imgLayerb.assignImages(imgLayer);
		imgLayer.setSize(imgLayer.imageWidth\mCNT_MAX, imgLayer.imageHeight);
		imgLayerb.setSize(imgLayer.width, imgLayer.height);
		imgLayer.absolute = imgLayerb.absolute = (kag.fore.messages[-1].absolute+1);
		imgLayer.hitType = imgLayerb.hitType = htMask;
		imgLayer.hitThreshold = imgLayerb.hitThreshold = 256;
		kag.sCounter_onConductorLabel = kag.onConductorLabel;
		kag.onConductorLabel = function(label, page){
			if(typeof global.counterObj != "undefined"){
				var curs = conductor.curStorage;
				if(curs == "title.ks" || curs == "ex_replay.ks"){
					if(global.counterObj.active || global.counterObj.imgLayer.visible || global.counterObj.imgLayerb.visible)global.counterObj.disable();
				}else if(global.counterObj.active){
					if(label !== void && /\*p[0-9]*/gi.test(label))global.counterObj.countDown();
				}
			}
			return sCounter_onConductorLabel(...);
		}incontextof kag;
	}
	function finalize()
	{
		invalidate imgLayer if imgLayer !== void;
		super.finalize(...);
	}
	function countDown()
	{
		if(--counter < 0){
			disable();
			return;
		}
		draw();
	}
	function drawNo(no){
		counter = no;
		draw();
	}
	function draw(){
		var offsetRectPos;
		if(counter >= mCNT_MAX)counter = mCNT_MAX - 1;
		if(counter < 0)counter = 0;
		offsetRectPos = counter;

		if( isImgCntDown ) offsetRectPos = (mCNT_MAX - 1) - offsetRectPos;

		imgLayer.imageLeft = imgLayerb.imageLeft = -imgLayer.width * offsetRectPos;
		adjustPosition();
		imgLayer.visible = imgLayerb.visible = sysDoSyaseiCounter;
	}
	function enable(cnt = mCNT_MAX)
	{
		counter = cnt;
		active = true;
	}
	function disable()
	{
		counter = mCNT_MAX;
		active = false;
		imgLayer.visible = imgLayerb.visible = false;
	}
	function adjustPosition()
	{
		var x = (sysSyaseiCounterPos ? 1055 : 30);
		var y = 605;
		imgLayer.setPos(x, y);
		imgLayerb.setPos(x, y);
	}
	function visibleChange()
	{
		if(active)imgLayer.visible = imgLayerb.visible = sysDoSyaseiCounter;
	}
	function onExchangeForeBack(){}
	function onStableStateChanged(stable){}
	function onStore(f, elm){
		f.syaseiCounterActive = active;
		f.syaseiCounterCount = counter;
	}
	function onRestore(f, clear, elm){
		if(f.syaseiCounterActive)enable(f.syaseiCounterCount+1);
		else disable();
	}
	function onMessageHiddenStateChanged(hidden){
		if(active)imgLayer.visible = imgLayerb.visible = (hidden ? false : sysDoSyaseiCounter);
	}
	function onCopyLayer(toback){}
	function onSaveSystemVariables(){}
}
kag.addPlugin(global.counterObj = new SyaseiCounterPlugin());

@endscript
@macro name="syaseicounter"
@eval exp="global.counterObj.enable()"
@endmacro

; 射精カウンターの直接表示、storeされないのでラベルの下に書きましょう
; howtouse：syaseicounter_manual no="&sysLive2D ? 8 : 10"
@macro name="syaseicounter_manual"
@eval exp="global.counterObj.drawNo(mp.no)"
@endmacro

; 射精カウンターの終了
@macro name="syaseicounter_stop"
@eval exp="global.counterObj.disable()"
@endmacro

@return
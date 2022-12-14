@if exp="typeof(global.autoMoveCursorObject) == 'undefined'"
@iscript

// 任意のレイヤー上でのマウスカーソルの指定座標への移動のプラグイン

class AutoMoveCursorPlugin
{
	var timer;
	var sx = 0;
	var sy = 0;
	var dx = 0;
	var dy = 0;
	var s_tick = 0;
	var m_time = 200;
	var targetLayer;

	function AutoMoveCursorPlugin()
	{
		targetLayer = kag.primaryLayer;
		timer = new Timer(onMoveCursor, "");
		timer.interval = 20;
	}

	function finalize()
	{
		invalidate timer;
	}
	function moveCursor(lay, x, y)
	{
		stop();
		targetLayer = lay;
		sx = targetLayer.cursorX;
		sy = targetLayer.cursorY;
		dx = x;
		dy = y;
		s_tick = System.getTickCount();
		timer.enabled = true;
	}
	function onMoveCursor()
	{
		var par = (System.getTickCount()-s_tick)/m_time;
		if(par < 1.0){
			if(isvalid targetLayer)targetLayer.setCursorPos(sx + (dx-sx)*par, sy + (dy-sy)*par);
			else stop();
		}else{
			finish();
		}
	}
	function finish(_lay=void, _x=void, _y=void){
		if(_lay !== void)targetLayer = _lay;
		if(_x !== void)dx = _x;
		if(_y !== void)dy = _y;
		if(isvalid targetLayer)targetLayer.setCursorPos(dx, dy);
		stop();
	}
	function stop(){ timer.enabled = false; }
}
global.autoMoveCursorObject = new AutoMoveCursorPlugin();
@endscript
@endif

@iscript
/*
	in.
		lay	:対象レイヤー
		x	:移動先x
		y	:移動先y
 */
function moveCursor(lay, x, y){
	if(sf.cursorMoveType == 1){	// 瞬間移動
		if(typeof global.autoMoveCursorObject != "undefined" && global.autoMoveCursorObject !== void){
			global.autoMoveCursorObject.finish(lay, x, y);
		}
	}else if(sf.cursorMoveType == 2){	// ゆっくり移動
		if(typeof global.autoMoveCursorObject != "undefined" && global.autoMoveCursorObject !== void){
			global.autoMoveCursorObject.moveCursor(lay, x, y);
		}
	}
}
//YesNoDialogでの使い方
//if(typeof global.moveCursor != "undefined")global.moveCursor(this.primaryLayer, yx+(yesButton.width>>1), yy+(yesButton.height>>1));
@endscript
@return

;-----------------------
; ブランドロゴ
;-----------------------
@eff_delete_now obj=0
@eff_delete_now obj=1
@black time=200
@fobgm
@sbgm

@iscript
kag.leftClickHook.clear();
kag.rightClickHook.clear();
kag.leftClickHook.add(function(){kag.process("","*logoskip");});
kag.rightClickHook.add(function(){kag.process("","*logoskip");});
@endscript


;@img storage=t_blogo_white layer=0

@eff obj=0 storage=logo_ab2 path=(640,360,0)(640,360,255) size=(3,1.2) time=500
@eff obj=1 storage=logo_akabei path=(640,360,0)(640,360,255) size=(0.1,0.9) time=500
@weff
@aseff
@eff obj=0 storage=logo_ab2 path=(640,360,255) size=(1.2,1) time=2000
@eff obj=1 storage=logo_akabei path=(640,360,255) size=(0.9,1) time=2000
@weff

*logoskip
@eff_delete obj=0
@eff_delete obj=1
@simg page=back layer=0 storage=white
@simg page=back layer=1 storage=t_blogo_white left=240 top=60
@extrans time=1000
@stoptrans

; ブランドコール
@eval exp="try{ systemSE(defBrandCall); }catch(e){ dm(e.message); }"

@stoptrans
@iscript
kag.leftClickHook.clear();
kag.rightClickHook.clear();
kag.cancelSkip();	// なんでかこれ入れないとスキップされる
@endscript
@waitclick
@stoptrans
@white time=1000

;-----------------------
; 警告画面
;-----------------------
;//製品版仕様↓
@img storage=t_notice layer=0 opacity=255 visible=true time=1000
;//体験版仕様↓
;@img storage=t_notice_trial layer=0 opacity=255 visible=true time=1000
@wait time=50
@return

;//----------------------------------------------------------------
; ■エフェクト再生用のマクロ
;//----------------------------------------------------------------

;@macro name="anm_w"
;@if exp="!tf.effectSkipFlag"
;@simg layer=%layer|14 storage=%storage fliplr=%fliplr flipud=%flipud left=%left|0 top=%top|0 opacity=%opacity|255 index=%index|25000
;@endif
;@wait time=%wait|30
;; cond="sysDoEffFade"
;@endmacro
;
;@macro name="anm_trs"
;@simg layer=%layer|14 page=back storage=%storage fliplr=%fliplr flipud=%flipud left=%left|0 index=%index|25000
;@eval exp="mp.time=1"
;; cond="!sysDoEffFade"
;@trans method=crossfade time=%trans|250
;@wt
;@wait time=%wait|30
;; cond="sysDoEffFade"
;@endmacro
;
;@macro name="anm_d"
;@freeimage layer=%layer|14 page=fore cond=%delete
;@endmacro
;
;@macro name="anm_d_trs"
;@freeimage layer=%layer|14 page=back
;@eval exp="mp.time=1"
;; cond="!sysDoEffFade"
;@trans method=crossfade time=%trans|250
;@wt
;@backlay
;@endmacro
;
;@macro name="eff_anm_w"
;@eff obj=%obj|11 storage=%storage path=%path|(640,360,255)(640,360,255) index=%absolute|25000 rad=%rad|(0,0) size=%size|(1,1) time=%time|30 fliplr=%fliplr flipud=%flipud
;@weff obj=%obj|11
;@endmacro
;
;@macro name="eff_anm_trs"
;@eff obj=%obj|11 storage=%storage path=%path|(640,360,255)(640,360,255) index=%absolute|25000 rad=%rad|(0,0) size=%size|(1,1) time=%time|30 fliplr=%fliplr flipud=%flipud page=back show=true
;@eval exp="mp.time=1"
;; cond="!sysDoEffFade"
;@trans method=crossfade time=%trans|250
;@wt
;@wait time=%wait|30
;@endmacro
;
;@macro name="eff_anm_d"
;@eff_delete_now obj=%obj|11 cond=%delete
;@endmacro
;
;@macro name="eff_anm_d_trs"
;@eff_delete obj=%obj|11
;@eval exp="mp.time=1"
;; cond="!sysDoEffFade"
;@trans method=crossfade time=%trans|250
;@wt
;@backlay
;@endmacro
;
;@macro name="anm_q"
;@shide cond=%shide
;;@quake sx=20 sy=20 xcnt=14 ycnt=9 fade=true time=400
;@endmacro
;
;@macro name="anm_s"
;@sshow cond=%sshow
;;@quake sx=20 sy=20 xcnt=14 ycnt=9 fade=true time=400
;@endmacro

@macro name="anm_w"
@eval exp="tf.effect_number++" cond="tf.effect_number !== void"
@eval exp="tf.effect_number = 0" cond="tf.effect_number === void"
@simg * layer=%layer|7 storage=%storage fliplr=%fliplr flipud=%flipud left=%left|0 top=%top|0 opacity=%opacity|255 cond="mp.delay === void"
@wait time=%wait|50 cond="sysDoEffFade && mp.delay === void"
@eval exp="mp.delay = +mp.delay + 70 * +tf.effect_number;" cond="mp.delay !== void && mp.wait === void"
@eval exp="mp.delay = +mp.delay + +mp.wait * +tf.effect_number;" cond="mp.delay !== void && mp.wait !== void"
@dsimg * layer=%layer|7 storage=%storage fliplr=%fliplr flipud=%flipud left=%left|0 top=%top|0 opacity=%opacity|255 cond="mp.delay !== void"
@endmacro

@macro name="anm_trs"
@simg layer=%layer|7 page=back storage=%storage fliplr=%fliplr flipud=%flipud left=%left|0
@eval exp="mp.time=1" cond="!sysDoEffFade"
@trans method=crossfade time=%trans|250
@wt
@wait time=%wait|50 cond="sysDoEffFade"
@endmacro

@macro name="anm_d"
@eval exp="tf.effect_number++" cond="tf.effect_number !== void"
@eval exp="mp.delay = +mp.delay + 70 * +tf.effect_number;" cond="mp.delay !== void && mp.wait === void"
@eval exp="mp.delay = +mp.delay + +mp.wait * +tf.effect_number;" cond="mp.delay !== void && mp.wait !== void"
@freeimage layer=%layer|7 page=fore cond="mp.delete == 'true' && mp.delay === void"
@dfreeimage layer=%layer|7 page=fore delay=%delay cond="mp.delete == 'true' && mp.delay !== void"
@eval exp="tf.effect_number = void" cond="tf.effect_number !== void"
@endmacro

@macro name="anm_d_trs"
@freeimage layer=%layer|7 page=back
@eval exp="mp.time=1" cond="!sysDoEffFade"
@trans method=crossfade time=%trans|250
@wt
@backlay
@endmacro

@macro name="anm_q"
@shide cond="mp.delay === void"
;@quake sx=20 sy=20 xcnt=7 ycnt=9 fade=true time=400
@endmacro



;//----------------------------------------------------------------
; ■エフェクト一覧
;//----------------------------------------------------------------


;############################################################
;#BV qgp
@macro name="qgp"
@eval exp="kag.leftClickHook.clear(); kag.leftClickHook.add(function(){kag.leftClickHook.clear(); tf.effectSkipFlag = true; kag.skipToStop2();});"
;@anm_q * 
@anm_w * storage=QGP_01
@anm_w * storage=QGP_02
@anm_w * storage=QGP_03
@anm_w * storage=QGP_04
@anm_w * storage=QGP_05
@anm_w * storage=QGP_06
@anm_w * storage=QGP_07
@anm_w * storage=QGP_08
@anm_w * storage=QGP_09
@anm_w * storage=QGP_10
@anm_w * storage=QGP_11
@anm_w * storage=QGP_12
@anm_w * storage=QGP_13
@anm_w * storage=QGP_14
@anm_w * storage=QGP_15
@anm_w * storage=QGP_16
@anm_w * storage=QGP_17
@anm_w * storage=QGP_18
@anm_w * storage=QGP_19
@anm_w * storage=QGP_20
@anm_w * storage=QGP_21
@anm_w * storage=QGP_22
@anm_w * storage=QGP_23
@eval exp="kag.leftClickHook.clear(); if(tf.effectSkipFlag){ kag.cancelSkip(); } tf.effectSkipFlag = false;"
@anm_w * storage=QGP_24
@anm_d *
@endmacro

@macro name="qgp_s"
@eval exp="kag.leftClickHook.clear(); kag.leftClickHook.add(function(){kag.leftClickHook.clear(); tf.effectSkipFlag = true; kag.skipToStop2();});"
;@anm_q * 
@anm_w * storage=QGP_s_06
@anm_w * storage=QGP_s_05
@anm_w * storage=QGP_s_04
@anm_w * storage=QGP_s_03
@anm_w * storage=QGP_s_04
@anm_w * storage=QGP_s_03
@anm_w * storage=QGP_s_02
@eval exp="kag.leftClickHook.clear(); if(tf.effectSkipFlag){ kag.cancelSkip(); } tf.effectSkipFlag = false;"
@anm_w * storage=QGP_s_01
@anm_d *
@endmacro


@if exp=0

; 単発
@mveff_blood_01
@mveff_heart_01
@zangeki_01
@zangeki_02
@zangeki_03
@zangeki_04

; ループ
@mveff_heart_01_loop
@mveff_dash_01_loop
@mveff_sandstorm_01_loop
@mveff_smoke_01_loop
@mveff_thunder_01_loop
; ループ停止
@mveff_stop
; フェードアウト(停止まで面倒見ないので注意)
@mveff_fadeout

; 鋼腕生成
@fg_movie storage="mv_wan_seisei.mpg"
; 鋼腕生成：第一臂～第六臂
@fg_movie storage="mv_wan_01.mpg"
@fg_movie storage="mv_wan_02.mpg"
@fg_movie storage="mv_wan_03.mpg"
@fg_movie storage="mv_wan_04.mpg"
@fg_movie storage="mv_wan_05.mpg"
@fg_movie storage="mv_wan_06.mpg"
; 鋼腕解除
@fg_movie storage="mv_wan_kaizyo.mpg"

@endif

; ■エフェクト用マクロ定義
[macro name="zangeki_sub"]
;キャッシュに詰め込む
[simg layer=%layer|10 storage="&'eff_zengeki'+mp.storage+'_01'" visible=false fliplr=%fliplr|false flipud=%flipud|false][simg layer=%layer|10 storage="&'eff_zengeki'+mp.storage+'_02'" visible=false fliplr=%fliplr|false flipud=%flipud|false][simg layer=%layer|10 storage="&'eff_zengeki'+mp.storage+'_03'" visible=false fliplr=%fliplr|false flipud=%flipud|false]
[simg layer=%layer|10 storage="&'eff_zengeki'+mp.storage+'_01'" fliplr=%fliplr|false flipud=%flipud|false][wait time=%wait1|80][simg layer=%layer|10 storage="&'eff_zengeki'+mp.storage+'_02'" fliplr=%fliplr|false flipud=%flipud|false][wait time=%wait2|50][simg layer=%layer|10 storage="&'eff_zengeki'+mp.storage+'_03'" fliplr=%fliplr|false flipud=%flipud|false][wait time=%wait3|80][freeimage layer=%layer|10][endmacro]
[macro name="zangeki_01"][zangeki_sub * storage=01][endmacro]
[macro name="zangeki_02"][zangeki_sub * storage=02][endmacro]
[macro name="zangeki_03"][zangeki_sub * storage=03][endmacro]
[macro name="zangeki_04"][zangeki_sub * storage=04][endmacro]

@macro name="effmv_start"
@playamov * slot=0 storage=%storage left=0 top=0 loop=%loop|true
@amovopt slot=0 visible=true opacity="&mp.fade == 'true' ? 0 : 255"
@if exp="mp.fade == 'true'"
@amovmove path=(15,255)
@wm
@endif
@endmacro

@macro name="effmv_stop"
@wm
@amovopt slot=0 visible=false
@stopamov slot=0
@endmacro

@macro name="effmv_base"
@effmv_start * loop=%loop|false
@wam
@effmv_stop
@endmacro
[macro name="mveff_blood_01"][effmv_base storage="mveff_blood_01.amv"][endmacro]
[macro name="mveff_heart_01"][effmv_base storage="mveff_heart_01.amv"][endmacro]

[macro name="mveff_heart_01_loop"][effmv_start * storage="mveff_heart_01.amv"][endmacro]
[macro name="mveff_dash_01_loop"][effmv_start * storage="mveff_dash_01.amv"][endmacro]
[macro name="mveff_sandstorm_01_loop"][effmv_start * storage="mveff_sandstorm_01.amv"][endmacro]
[macro name="mveff_smoke_01_loop"][effmv_start * storage="mveff_smoke_01.amv" sploop=true][endmacro]
[macro name="mveff_thunder_01_loop"][effmv_start * storage="mveff_thunder_01.amv"][endmacro]
[macro name="mveff_stop"][effmv_stop][endmacro]
[macro name="mveff_fadeout"][amovmove path=(15,0)][endmacro]
; ■--------------------------------------------------------------------------------------------------------

;############################################################


;############################################################
; 移動
;############################################################

;移動_白
@macro name="effect_b_00_move_00w"
@anm_q *
@anm_w * storage=effect_b_00_move_00w_00
@anm_w * storage=effect_b_00_move_00w_01
@anm_w * storage=effect_b_00_move_00w_02
@anm_w * storage=effect_b_00_move_00w_03
@anm_w * storage=effect_b_00_move_00w_04
@anm_d * delete=%delete|true
@endmacro

;移動_横長_白
@macro name="effect_b_00_move_01w"
@anm_q *
@anm_w * storage=effect_b_00_move_01w_00
@anm_d * delete=%delete|true
@endmacro

;移動_横長2_白
@macro name="effect_b_00_move_02w"
@anm_q *
@anm_w * storage=effect_b_00_move_02w_00
@anm_d * delete=%delete|true
@endmacro

;移動_横長_赤
@macro name="effect_b_00_move_02r"
@anm_q *
@anm_w * storage=effect_b_00_move_02r_00
@anm_d * delete=%delete|true
@endmacro

;移動_横長_緑
@macro name="effect_b_00_move_02g"
@anm_q *
@anm_w * storage=effect_b_00_move_02g_00
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 集中線
;############################################################

;集中線_白
@macro name="effect_a_00_focusline_00w"
@anm_q *
@anm_w * storage=effect_a_00_focusline_00w_00
@anm_w * storage=effect_a_00_focusline_00w_01
@anm_w * storage=effect_a_00_focusline_00w_02
@anm_d * delete=%delete|true
@endmacro

;集中線_白
@macro name="effect_b_00_focusline_00w"
@anm_q *
@anm_w * storage=effect_b_00_focusline_00w_00
@anm_w * storage=effect_b_00_focusline_00w_01
@anm_w * storage=effect_b_00_focusline_00w_02
@anm_d * delete=%delete|true
@endmacro

;集中線_赤
@macro name="effect_a_00_focusline_00r"
@anm_q *
@anm_w * storage=effect_a_00_focusline_00r_00
@anm_w * storage=effect_a_00_focusline_00r_01
@anm_w * storage=effect_a_00_focusline_00r_02
@anm_d * delete=%delete|true
@endmacro

;集中線_赤
@macro name="effect_b_00_focusline_00r"
@anm_q *
@anm_w * storage=effect_b_00_focusline_00r_00
@anm_w * storage=effect_b_00_focusline_00r_01
@anm_w * storage=effect_b_00_focusline_00r_02
@anm_d * delete=%delete|true
@endmacro

;集中線_緑
@macro name="effect_a_00_focusline_00g"
@anm_q *
@anm_w * storage=effect_a_00_focusline_00g_00
@anm_w * storage=effect_a_00_focusline_00g_01
@anm_w * storage=effect_a_00_focusline_00g_02
@anm_d * delete=%delete|true
@endmacro

;集中線_緑
@macro name="effect_b_00_focusline_00g"
@anm_q *
@anm_w * storage=effect_b_00_focusline_00g_00
@anm_w * storage=effect_b_00_focusline_00g_01
@anm_w * storage=effect_b_00_focusline_00g_02
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 殴り
;############################################################

;殴り_白
@macro name="effect_a_00_punch_00w"
@anm_q *
@anm_w * storage=effect_a_00_punch_00w_00
@anm_w * storage=effect_a_00_punch_00w_01
@anm_w * storage=effect_a_00_punch_00w_02
@anm_w * storage=effect_a_00_punch_00w_03
@anm_d * delete=%delete|true
@endmacro

;殴り_白
@macro name="effect_b_00_punch_00w"
@anm_q *
@anm_w * storage=effect_b_00_punch_00w_00
@anm_w * storage=effect_b_00_punch_00w_01
@anm_w * storage=effect_b_00_punch_00w_02
@anm_w * storage=effect_b_00_punch_00w_03
@anm_d * delete=%delete|true
@endmacro

;殴り_茶色
@macro name="effect_a_00_punch_01br"
@anm_q *
@anm_w * storage=effect_a_00_punch_01br_00
@anm_w * storage=effect_a_00_punch_01br_01
@anm_w * storage=effect_a_00_punch_01br_02
@anm_w * storage=effect_a_00_punch_01br_03
@anm_w * storage=effect_a_00_punch_01br_04
@anm_w * storage=effect_a_00_punch_01br_05
@anm_w * storage=effect_a_00_punch_01br_06
@anm_d * delete=%delete|true
@endmacro

;殴り_茶色
@macro name="effect_b_00_punch_01br"
@anm_q *
@anm_w * storage=effect_b_00_punch_01br_00
@anm_w * storage=effect_b_00_punch_01br_01
@anm_w * storage=effect_b_00_punch_01br_02
@anm_w * storage=effect_b_00_punch_01br_03
@anm_w * storage=effect_b_00_punch_01br_04
@anm_w * storage=effect_b_00_punch_01br_05
@anm_w * storage=effect_b_00_punch_01br_06
@anm_d * delete=%delete|true
@endmacro

;殴り_突き_白
@macro name="effect_a_00_punch_02w"
@anm_q *
@anm_w * storage=effect_a_00_punch_02w_00
@anm_w * storage=effect_a_00_punch_02w_01
@anm_w * storage=effect_a_00_punch_02w_02
@anm_w * storage=effect_a_00_punch_02w_03
@anm_d * delete=%delete|true
@endmacro

;殴り_突き_白
@macro name="effect_b_00_punch_02w"
@anm_q *
@anm_w * storage=effect_b_00_punch_02w_00
@anm_w * storage=effect_b_00_punch_02w_01
@anm_w * storage=effect_b_00_punch_02w_02
@anm_w * storage=effect_b_00_punch_02w_03
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 蹴り
;############################################################

;蹴り_横_紫
@macro name="effect_a_00_kick_00m"
@anm_q *
@anm_w * storage=effect_a_00_kick_00m_00
@anm_w * storage=effect_a_00_kick_00m_01
@anm_w * storage=effect_a_00_kick_00m_02
@anm_w * storage=effect_a_00_kick_00m_03
@anm_w * storage=effect_a_00_kick_00m_04
@anm_d * delete=%delete|true
@endmacro

;蹴り_横_紫
@macro name="effect_b_00_kick_00m"
@anm_q *
@anm_w * storage=effect_b_00_kick_00m_00
@anm_w * storage=effect_b_00_kick_00m_01
@anm_w * storage=effect_b_00_kick_00m_02
@anm_w * storage=effect_b_00_kick_00m_03
@anm_w * storage=effect_b_00_kick_00m_04
@anm_d * delete=%delete|true
@endmacro

;蹴り上げ_紫
@macro name="effect_a_00_kick_01m"
@anm_q *
@anm_w * storage=effect_a_00_kick_01m_00
@anm_w * storage=effect_a_00_kick_01m_01
@anm_w * storage=effect_a_00_kick_01m_02
@anm_w * storage=effect_a_00_kick_01m_03
@anm_w * storage=effect_a_00_kick_01m_04
@anm_d * delete=%delete|true
@endmacro

;蹴り上げ_紫
@macro name="effect_b_00_kick_01m"
@anm_q *
@anm_w * storage=effect_b_00_kick_01m_00
@anm_w * storage=effect_b_00_kick_01m_01
@anm_w * storage=effect_b_00_kick_01m_02
@anm_w * storage=effect_b_00_kick_01m_03
@anm_w * storage=effect_b_00_kick_01m_04
@anm_d * delete=%delete|true
@endmacro

;蹴り上げ_茶色
@macro name="effect_a_00_kick_02br"
@anm_q *
@anm_w * storage=effect_a_00_kick_02br_00
@anm_w * storage=effect_a_00_kick_02br_01
@anm_w * storage=effect_a_00_kick_02br_02
@anm_w * storage=effect_a_00_kick_02br_03
@anm_w * storage=effect_a_00_kick_02br_04
@anm_w * storage=effect_a_00_kick_02br_05
@anm_w * storage=effect_a_00_kick_02br_06
@anm_w * storage=effect_a_00_kick_02br_07
@anm_d * delete=%delete|true
@endmacro

;蹴り上げ_茶色
@macro name="effect_b_00_kick_02br"
@anm_q *
@anm_w * storage=effect_b_00_kick_02br_00
@anm_w * storage=effect_b_00_kick_02br_01
@anm_w * storage=effect_b_00_kick_02br_02
@anm_w * storage=effect_b_00_kick_02br_03
@anm_w * storage=effect_b_00_kick_02br_04
@anm_w * storage=effect_b_00_kick_02br_05
@anm_w * storage=effect_b_00_kick_02br_06
@anm_w * storage=effect_b_00_kick_02br_07
@anm_d * delete=%delete|true
@endmacro

;蹴り上げ2_茶色
@macro name="effect_a_00_kick_03br"
@anm_q *
@anm_w * storage=effect_a_00_kick_03br_00
@anm_w * storage=effect_a_00_kick_03br_01
@anm_w * storage=effect_a_00_kick_03br_02
@anm_w * storage=effect_a_00_kick_03br_03
@anm_w * storage=effect_a_00_kick_03br_04
@anm_w * storage=effect_a_00_kick_03br_05
@anm_d * delete=%delete|true
@endmacro

;蹴り上げ2_茶色
@macro name="effect_b_00_kick_03br"
@anm_q *
@anm_w * storage=effect_b_00_kick_03br_00
@anm_w * storage=effect_b_00_kick_03br_01
@anm_w * storage=effect_b_00_kick_03br_02
@anm_w * storage=effect_b_00_kick_03br_03
@anm_w * storage=effect_b_00_kick_03br_04
@anm_w * storage=effect_b_00_kick_03br_05
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 投げ
;############################################################

;投げ飛ばし_白
@macro name="effect_a_00_throw_00w"
@anm_q *
@anm_w * storage=effect_a_00_throw_00w_00
@anm_w * storage=effect_a_00_throw_00w_01
@anm_w * storage=effect_a_00_throw_00w_02
@anm_w * storage=effect_a_00_throw_00w_03
@anm_w * storage=effect_a_00_throw_00w_04
@anm_w * storage=effect_a_00_throw_00w_05
@anm_d * delete=%delete|true
@endmacro

;投げ飛ばし_白
@macro name="effect_b_00_throw_00w"
@anm_q *
@anm_w * storage=effect_b_00_throw_00w_00
@anm_w * storage=effect_b_00_throw_00w_01
@anm_w * storage=effect_b_00_throw_00w_02
@anm_w * storage=effect_b_00_throw_00w_03
@anm_w * storage=effect_b_00_throw_00w_04
@anm_w * storage=effect_b_00_throw_00w_05
@anm_d * delete=%delete|true
@endmacro

;投げ飛ばし2_白
@macro name="effect_a_00_throw_01w"
@anm_q *
@anm_w * storage=effect_a_00_throw_01w_00
@anm_w * storage=effect_a_00_throw_01w_01
@anm_w * storage=effect_a_00_throw_01w_02
@anm_w * storage=effect_a_00_throw_01w_03
@anm_w * storage=effect_a_00_throw_01w_04
@anm_d * delete=%delete|true
@endmacro

;投げ飛ばし2_白
@macro name="effect_b_00_throw_01w"
@anm_q *
@anm_w * storage=effect_b_00_throw_01w_00
@anm_w * storage=effect_b_00_throw_01w_01
@anm_w * storage=effect_b_00_throw_01w_02
@anm_w * storage=effect_b_00_throw_01w_03
@anm_w * storage=effect_b_00_throw_01w_04
@anm_d * delete=%delete|true
@endmacro

;投げ飛ばし3_白
@macro name="effect_a_00_throw_02w"
@anm_q *
@anm_w * storage=effect_a_00_throw_02w_00
@anm_w * storage=effect_a_00_throw_02w_01
@anm_w * storage=effect_a_00_throw_02w_02
@anm_w * storage=effect_a_00_throw_02w_03
@anm_w * storage=effect_a_00_throw_02w_04
@anm_w * storage=effect_a_00_throw_02w_05
@anm_w * storage=effect_a_00_throw_02w_06
@anm_w * storage=effect_a_00_throw_02w_07
@anm_w * storage=effect_a_00_throw_02w_08
@anm_d * delete=%delete|true
@endmacro

;投げ飛ばし3_白
@macro name="effect_b_00_throw_02w"
@anm_q *
@anm_w * storage=effect_b_00_throw_02w_00
@anm_w * storage=effect_b_00_throw_02w_01
@anm_w * storage=effect_b_00_throw_02w_02
@anm_w * storage=effect_b_00_throw_02w_03
@anm_w * storage=effect_b_00_throw_02w_04
@anm_w * storage=effect_b_00_throw_02w_05
@anm_w * storage=effect_b_00_throw_02w_06
@anm_w * storage=effect_b_00_throw_02w_07
@anm_w * storage=effect_b_00_throw_02w_08
@anm_d * delete=%delete|true
@endmacro

;投げ落とし_白
@macro name="effect_a_00_throw_03w"
@anm_q *
@anm_w * storage=effect_a_00_throw_03w_00
@anm_w * storage=effect_a_00_throw_03w_01
@anm_w * storage=effect_a_00_throw_03w_02
@anm_w * storage=effect_a_00_throw_03w_03
@anm_d * delete=%delete|true
@endmacro

;投げ落とし_白
@macro name="effect_b_00_throw_03w"
@anm_q *
@anm_w * storage=effect_b_00_throw_03w_00
@anm_w * storage=effect_b_00_throw_03w_01
@anm_w * storage=effect_b_00_throw_03w_02
@anm_w * storage=effect_b_00_throw_03w_03
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 尻尾
;############################################################

;尻尾回転_茶
@macro name="effect_a_01_tail_00br"
@anm_q *
@anm_w * storage=effect_a_01_tail_00br_00
@anm_w * storage=effect_a_01_tail_00br_01
@anm_w * storage=effect_a_01_tail_00br_02
@anm_w * storage=effect_a_01_tail_00br_03
@anm_w * storage=effect_a_01_tail_00br_04
@anm_w * storage=effect_a_01_tail_00br_05
@anm_w * storage=effect_a_01_tail_00br_06
@anm_w * storage=effect_a_01_tail_00br_07
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 爪
;############################################################

;きりさく_紫
@macro name="effect_a_01_claw_00m"
@anm_q *
@anm_w * storage=effect_a_01_claw_00m_00
@anm_w * storage=effect_a_01_claw_00m_01
@anm_w * storage=effect_a_01_claw_00m_02
@anm_w * storage=effect_a_01_claw_00m_03
@anm_w * storage=effect_a_01_claw_00m_04
@anm_w * storage=effect_a_01_claw_00m_05
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 斬撃
;############################################################

;縦_上から_白
@macro name="effect_a_00_slash_00w"
@anm_q *
@anm_w * storage=effect_a_00_slash_00w_00
@anm_w * storage=effect_a_00_slash_00w_01
@anm_w * storage=effect_a_00_slash_00w_02
@anm_w * storage=effect_a_00_slash_00w_03
@anm_d * delete=%delete|true
@endmacro

;縦_上から_白
@macro name="effect_b_00_slash_00w"
@anm_q *
@anm_w * storage=effect_b_00_slash_00w_00
@anm_w * storage=effect_b_00_slash_00w_01
@anm_w * storage=effect_b_00_slash_00w_02
@anm_w * storage=effect_b_00_slash_00w_03
@anm_d * delete=%delete|true
@endmacro

;縦_上から_青
@macro name="effect_a_00_slash_01b"
@anm_q *
@anm_w * storage=effect_a_00_slash_01b_00
@anm_w * storage=effect_a_00_slash_01b_01
@anm_w * storage=effect_a_00_slash_01b_02
@anm_w * storage=effect_a_00_slash_01b_03
@anm_w * storage=effect_a_00_slash_01b_04
@anm_w * storage=effect_a_00_slash_01b_05
@anm_d * delete=%delete|true
@endmacro

;縦_上から_青
@macro name="effect_b_00_slash_01b"
@anm_q *
@anm_w * storage=effect_b_00_slash_01b_00
@anm_w * storage=effect_b_00_slash_01b_01
@anm_w * storage=effect_b_00_slash_01b_02
@anm_w * storage=effect_b_00_slash_01b_03
@anm_w * storage=effect_b_00_slash_01b_04
@anm_w * storage=effect_b_00_slash_01b_05
@anm_d * delete=%delete|true
@endmacro

;縦_上から_紫
@macro name="effect_a_00_slash_01m"
@anm_q *
@anm_w * storage=effect_a_00_slash_01m_00
@anm_w * storage=effect_a_00_slash_01m_01
@anm_w * storage=effect_a_00_slash_01m_02
@anm_w * storage=effect_a_00_slash_01m_03
@anm_w * storage=effect_a_00_slash_01m_04
@anm_w * storage=effect_a_00_slash_01m_05
@anm_d * delete=%delete|true
@endmacro

;縦_上から_紫
@macro name="effect_b_00_slash_01m"
@anm_q *
@anm_w * storage=effect_b_00_slash_01m_00
@anm_w * storage=effect_b_00_slash_01m_01
@anm_w * storage=effect_b_00_slash_01m_02
@anm_w * storage=effect_b_00_slash_01m_03
@anm_w * storage=effect_b_00_slash_01m_04
@anm_w * storage=effect_b_00_slash_01m_05
@anm_d * delete=%delete|true
@endmacro

;縦_上から_茶色
@macro name="effect_a_00_slash_01br"
@anm_q *
@anm_w * storage=effect_a_00_slash_01br_00
@anm_w * storage=effect_a_00_slash_01br_01
@anm_w * storage=effect_a_00_slash_01br_02
@anm_w * storage=effect_a_00_slash_01br_03
@anm_w * storage=effect_a_00_slash_01br_04
@anm_w * storage=effect_a_00_slash_01br_05
@anm_d * delete=%delete|true
@endmacro

;縦_上から_茶色
@macro name="effect_b_00_slash_01br"
@anm_q *
@anm_w * storage=effect_b_00_slash_01br_00
@anm_w * storage=effect_b_00_slash_01br_01
@anm_w * storage=effect_b_00_slash_01br_02
@anm_w * storage=effect_b_00_slash_01br_03
@anm_w * storage=effect_b_00_slash_01br_04
@anm_w * storage=effect_b_00_slash_01br_05
@anm_d * delete=%delete|true
@endmacro

;弧_上から_白
@macro name="effect_a_00_slash_02w"
@anm_q *
@anm_w * storage=effect_a_00_slash_02w_00
@anm_w * storage=effect_a_00_slash_02w_01
@anm_w * storage=effect_a_00_slash_02w_02
@anm_w * storage=effect_a_00_slash_02w_03
@anm_w * storage=effect_a_00_slash_02w_04
@anm_d * delete=%delete|true
@endmacro

;弧_上から_白
@macro name="effect_b_00_slash_02w"
@anm_q *
@anm_w * storage=effect_b_00_slash_02w_00
@anm_w * storage=effect_b_00_slash_02w_01
@anm_w * storage=effect_b_00_slash_02w_02
@anm_w * storage=effect_b_00_slash_02w_03
@anm_w * storage=effect_b_00_slash_02w_04
@anm_d * delete=%delete|true
@endmacro

;弧_上から_赤
@macro name="effect_a_00_slash_02r"
@anm_q *
@anm_w * storage=effect_a_00_slash_02r_00
@anm_w * storage=effect_a_00_slash_02r_01
@anm_w * storage=effect_a_00_slash_02r_02
@anm_w * storage=effect_a_00_slash_02r_03
@anm_w * storage=effect_a_00_slash_02r_04
@anm_d * delete=%delete|true
@endmacro

;弧_上から_赤
@macro name="effect_b_00_slash_02r"
@anm_q *
@anm_w * storage=effect_b_00_slash_02r_00
@anm_w * storage=effect_b_00_slash_02r_01
@anm_w * storage=effect_b_00_slash_02r_02
@anm_w * storage=effect_b_00_slash_02r_03
@anm_w * storage=effect_b_00_slash_02r_04
@anm_d * delete=%delete|true
@endmacro

;弧_上から_緑
@macro name="effect_a_00_slash_02g"
@anm_q *
@anm_w * storage=effect_a_00_slash_02g_00
@anm_w * storage=effect_a_00_slash_02g_01
@anm_w * storage=effect_a_00_slash_02g_02
@anm_w * storage=effect_a_00_slash_02g_03
@anm_w * storage=effect_a_00_slash_02g_04
@anm_d * delete=%delete|true
@endmacro

;弧_上から_緑
@macro name="effect_b_00_slash_02g"
@anm_q *
@anm_w * storage=effect_b_00_slash_02g_00
@anm_w * storage=effect_b_00_slash_02g_01
@anm_w * storage=effect_b_00_slash_02g_02
@anm_w * storage=effect_b_00_slash_02g_03
@anm_w * storage=effect_b_00_slash_02g_04
@anm_d * delete=%delete|true
@endmacro

;横一閃_白
@macro name="effect_a_00_slash_03w"
@anm_q *
@anm_w * storage=effect_a_00_slash_03w_00
@anm_w * storage=effect_a_00_slash_03w_01
@anm_w * storage=effect_a_00_slash_03w_02
@anm_w * storage=effect_a_00_slash_03w_03
@anm_w * storage=effect_a_00_slash_03w_04
@anm_d * delete=%delete|true
@endmacro

;横一閃_白
@macro name="effect_b_00_slash_03w"
@anm_q *
@anm_w * storage=effect_b_00_slash_03w_00
@anm_w * storage=effect_b_00_slash_03w_01
@anm_w * storage=effect_b_00_slash_03w_02
@anm_w * storage=effect_b_00_slash_03w_03
@anm_w * storage=effect_b_00_slash_03w_04
@anm_d * delete=%delete|true
@endmacro

;横一閃_青
@macro name="effect_a_00_slash_03b"
@anm_q *
@anm_w * storage=effect_a_00_slash_03b_00
@anm_w * storage=effect_a_00_slash_03b_01
@anm_w * storage=effect_a_00_slash_03b_02
@anm_w * storage=effect_a_00_slash_03b_03
@anm_w * storage=effect_a_00_slash_03b_04
@anm_w * storage=effect_a_00_slash_03b_05
@anm_d * delete=%delete|true
@endmacro

;横一閃_青
@macro name="effect_b_00_slash_03b"
@anm_q *
@anm_w * storage=effect_b_00_slash_03b_00
@anm_w * storage=effect_b_00_slash_03b_01
@anm_w * storage=effect_b_00_slash_03b_02
@anm_w * storage=effect_b_00_slash_03b_03
@anm_w * storage=effect_b_00_slash_03b_04
@anm_w * storage=effect_b_00_slash_03b_05
@anm_d * delete=%delete|true
@endmacro

;横一閃_紫
@macro name="effect_a_00_slash_03m"
@anm_q *
@anm_w * storage=effect_a_00_slash_03m_00
@anm_w * storage=effect_a_00_slash_03m_01
@anm_w * storage=effect_a_00_slash_03m_02
@anm_w * storage=effect_a_00_slash_03m_03
@anm_w * storage=effect_a_00_slash_03m_04
@anm_w * storage=effect_a_00_slash_03m_05
@anm_d * delete=%delete|true
@endmacro

;横一閃_紫
@macro name="effect_b_00_slash_03m"
@anm_q *
@anm_w * storage=effect_b_00_slash_03m_00
@anm_w * storage=effect_b_00_slash_03m_01
@anm_w * storage=effect_b_00_slash_03m_02
@anm_w * storage=effect_b_00_slash_03m_03
@anm_w * storage=effect_b_00_slash_03m_04
@anm_w * storage=effect_b_00_slash_03m_05
@anm_d * delete=%delete|true
@endmacro

;横一閃_茶色
@macro name="effect_a_00_slash_03br"
@anm_q *
@anm_w * storage=effect_a_00_slash_03br_00
@anm_w * storage=effect_a_00_slash_03br_01
@anm_w * storage=effect_a_00_slash_03br_02
@anm_w * storage=effect_a_00_slash_03br_03
@anm_w * storage=effect_a_00_slash_03br_04
@anm_w * storage=effect_a_00_slash_03br_05
@anm_d * delete=%delete|true
@endmacro

;横一閃_茶色
@macro name="effect_b_00_slash_03br"
@anm_q *
@anm_w * storage=effect_b_00_slash_03br_00
@anm_w * storage=effect_b_00_slash_03br_01
@anm_w * storage=effect_b_00_slash_03br_02
@anm_w * storage=effect_b_00_slash_03br_03
@anm_w * storage=effect_b_00_slash_03br_04
@anm_w * storage=effect_b_00_slash_03br_05
@anm_d * delete=%delete|true
@endmacro

;横一閃2_白
@macro name="effect_a_00_slash_04w"
@anm_q *
@anm_w * storage=effect_a_00_slash_04w_00
@anm_w * storage=effect_a_00_slash_04w_01
@anm_w * storage=effect_a_00_slash_04w_02
@anm_d * delete=%delete|true
@endmacro

;横一閃2_白
@macro name="effect_b_00_slash_04w"
@anm_q *
@anm_w * storage=effect_b_00_slash_04w_00
@anm_w * storage=effect_b_00_slash_04w_01
@anm_w * storage=effect_b_00_slash_04w_02
@anm_d * delete=%delete|true
@endmacro

;横一閃2_緑
@macro name="effect_a_00_slash_04g"
@anm_q *
@anm_w * storage=effect_a_00_slash_04g_00
@anm_w * storage=effect_a_00_slash_04g_01
@anm_w * storage=effect_a_00_slash_04g_02
@anm_d * delete=%delete|true
@endmacro

;横一閃2_緑
@macro name="effect_b_00_slash_04g"
@anm_q *
@anm_w * storage=effect_b_00_slash_04g_00
@anm_w * storage=effect_b_00_slash_04g_01
@anm_w * storage=effect_b_00_slash_04g_02
@anm_d * delete=%delete|true
@endmacro

;横一閃2_赤
@macro name="effect_a_00_slash_04r"
@anm_q *
@anm_w * storage=effect_a_00_slash_04r_00
@anm_w * storage=effect_a_00_slash_04r_01
@anm_w * storage=effect_a_00_slash_04r_02
@anm_d * delete=%delete|true
@endmacro

;横一閃2_赤
@macro name="effect_b_00_slash_04r"
@anm_q *
@anm_w * storage=effect_b_00_slash_04r_00
@anm_w * storage=effect_b_00_slash_04r_01
@anm_w * storage=effect_b_00_slash_04r_02
@anm_d * delete=%delete|true
@endmacro

;左上から_ななめ_白
@macro name="effect_a_00_slash_05w"
@anm_q *
@anm_w * storage=effect_a_00_slash_05w_00
@anm_w * storage=effect_a_00_slash_05w_01
@anm_w * storage=effect_a_00_slash_05w_02
@anm_d * delete=%delete|true
@endmacro

;左上から_ななめ_白
@macro name="effect_b_00_slash_05w"
@anm_q *
@anm_w * storage=effect_b_00_slash_05w_00
@anm_w * storage=effect_b_00_slash_05w_01
@anm_w * storage=effect_b_00_slash_05w_02
@anm_w * storage=effect_b_00_slash_05w_03
@anm_d * delete=%delete|true
@endmacro

;左上から_ななめ_緑
@macro name="effect_a_00_slash_05g"
@anm_q *
@anm_w * storage=effect_a_00_slash_05g_00
@anm_w * storage=effect_a_00_slash_05g_01
@anm_w * storage=effect_a_00_slash_05g_02
@anm_d * delete=%delete|true
@endmacro

;左上から_ななめ_緑
@macro name="effect_b_00_slash_05g"
@anm_q *
@anm_w * storage=effect_b_00_slash_05g_00
@anm_w * storage=effect_b_00_slash_05g_01
@anm_w * storage=effect_b_00_slash_05g_02
@anm_w * storage=effect_b_00_slash_05g_03
@anm_d * delete=%delete|true
@endmacro

;左上から_ななめ_赤
@macro name="effect_a_00_slash_05r"
@anm_q *
@anm_w * storage=effect_a_00_slash_05r_00
@anm_w * storage=effect_a_00_slash_05r_01
@anm_w * storage=effect_a_00_slash_05r_02
@anm_d * delete=%delete|true
@endmacro

;左上から_ななめ_赤
@macro name="effect_b_00_slash_05r"
@anm_q *
@anm_w * storage=effect_b_00_slash_05r_00
@anm_w * storage=effect_b_00_slash_05r_01
@anm_w * storage=effect_b_00_slash_05r_02
@anm_w * storage=effect_b_00_slash_05r_03
@anm_d * delete=%delete|true
@endmacro

;左上から2_ななめ_青
@macro name="effect_a_00_slash_06b"
@anm_q *
@anm_w * storage=effect_a_00_slash_06b_00
@anm_w * storage=effect_a_00_slash_06b_01
@anm_w * storage=effect_a_00_slash_06b_02
@anm_d * delete=%delete|true
@endmacro

;左上から3_ななめ_緑
@macro name="effect_a_00_slash_07g"
@anm_q *
@anm_w * storage=effect_a_00_slash_07g_00
@anm_w * storage=effect_a_00_slash_07g_01
@anm_w * storage=effect_a_00_slash_07g_02
@anm_d * delete=%delete|true
@endmacro

;右上から_ななめ_白
@macro name="effect_a_00_slash_08w"
@anm_q *
@anm_w * storage=effect_a_00_slash_08w_00
@anm_w * storage=effect_a_00_slash_08w_01
@anm_w * storage=effect_a_00_slash_08w_02
@anm_w * storage=effect_a_00_slash_08w_03
@anm_w * storage=effect_a_00_slash_08w_04
@anm_d * delete=%delete|true
@endmacro

;右上から_ななめ_白
@macro name="effect_b_00_slash_08w"
@anm_q *
@anm_w * storage=effect_b_00_slash_08w_00
@anm_w * storage=effect_b_00_slash_08w_01
@anm_w * storage=effect_b_00_slash_08w_02
@anm_w * storage=effect_b_00_slash_08w_03
@anm_w * storage=effect_b_00_slash_08w_04
@anm_d * delete=%delete|true
@endmacro

;右上から2_ななめ_青
@macro name="effect_a_00_slash_09b"
@anm_q *
@anm_w * storage=effect_a_00_slash_09b_00
@anm_w * storage=effect_a_00_slash_09b_01
@anm_w * storage=effect_a_00_slash_09b_02
@anm_w * storage=effect_a_00_slash_09b_03
@anm_w * storage=effect_a_00_slash_09b_04
@anm_w * storage=effect_a_00_slash_09b_05
@anm_d * delete=%delete|true
@endmacro

;右上から2_ななめ_青
@macro name="effect_b_00_slash_09b"
@anm_q *
@anm_w * storage=effect_b_00_slash_09b_00
@anm_w * storage=effect_b_00_slash_09b_01
@anm_w * storage=effect_b_00_slash_09b_02
@anm_w * storage=effect_b_00_slash_09b_03
@anm_w * storage=effect_b_00_slash_09b_04
@anm_w * storage=effect_b_00_slash_09b_05
@anm_d * delete=%delete|true
@endmacro

;右上から2_ななめ_紫
@macro name="effect_a_00_slash_09m"
@anm_q *
@anm_w * storage=effect_a_00_slash_09m_00
@anm_w * storage=effect_a_00_slash_09m_01
@anm_w * storage=effect_a_00_slash_09m_02
@anm_w * storage=effect_a_00_slash_09m_03
@anm_w * storage=effect_a_00_slash_09m_04
@anm_w * storage=effect_a_00_slash_09m_05
@anm_d * delete=%delete|true
@endmacro

;右上から2_ななめ_紫
@macro name="effect_b_00_slash_09m"
@anm_q *
@anm_w * storage=effect_b_00_slash_09m_00
@anm_w * storage=effect_b_00_slash_09m_01
@anm_w * storage=effect_b_00_slash_09m_02
@anm_w * storage=effect_b_00_slash_09m_03
@anm_w * storage=effect_b_00_slash_09m_04
@anm_w * storage=effect_b_00_slash_09m_05
@anm_d * delete=%delete|true
@endmacro

;右上から2_ななめ_茶色
@macro name="effect_a_00_slash_09br"
@anm_q *
@anm_w * storage=effect_a_00_slash_09br_00
@anm_w * storage=effect_a_00_slash_09br_01
@anm_w * storage=effect_a_00_slash_09br_02
@anm_w * storage=effect_a_00_slash_09br_03
@anm_w * storage=effect_a_00_slash_09br_04
@anm_w * storage=effect_a_00_slash_09br_05
@anm_d * delete=%delete|true
@endmacro

;右上から2_ななめ_茶色
@macro name="effect_b_00_slash_09br"
@anm_q *
@anm_w * storage=effect_b_00_slash_09br_00
@anm_w * storage=effect_b_00_slash_09br_01
@anm_w * storage=effect_b_00_slash_09br_02
@anm_w * storage=effect_b_00_slash_09br_03
@anm_w * storage=effect_b_00_slash_09br_04
@anm_w * storage=effect_b_00_slash_09br_05
@anm_d * delete=%delete|true
@endmacro

;弧_右上から_ななめ_白
@macro name="effect_a_00_slash_10w"
@anm_q *
@anm_w * storage=effect_a_00_slash_10w_00
@anm_w * storage=effect_a_00_slash_10w_01
@anm_w * storage=effect_a_00_slash_10w_02
@anm_d * delete=%delete|true
@endmacro

;弧_右上から_ななめ_白
@macro name="effect_b_00_slash_10w"
@anm_q *
@anm_w * storage=effect_b_00_slash_10w_00
@anm_w * storage=effect_b_00_slash_10w_01
@anm_w * storage=effect_b_00_slash_10w_02
@anm_w * storage=effect_b_00_slash_10w_03
@anm_d * delete=%delete|true
@endmacro

;弧_右上から_ななめ_赤
@macro name="effect_a_00_slash_10r"
@anm_q *
@anm_w * storage=effect_a_00_slash_10r_00
@anm_w * storage=effect_a_00_slash_10r_01
@anm_w * storage=effect_a_00_slash_10r_02
@anm_d * delete=%delete|true
@endmacro

;弧_右上から_ななめ_赤
@macro name="effect_b_00_slash_10r"
@anm_q *
@anm_w * storage=effect_b_00_slash_10r_00
@anm_w * storage=effect_b_00_slash_10r_01
@anm_w * storage=effect_b_00_slash_10r_02
@anm_w * storage=effect_b_00_slash_10r_03
@anm_d * delete=%delete|true
@endmacro

;弧_右上から_ななめ_緑
@macro name="effect_a_00_slash_10g"
@anm_q *
@anm_w * storage=effect_a_00_slash_10g_00
@anm_w * storage=effect_a_00_slash_10g_01
@anm_w * storage=effect_a_00_slash_10g_02
@anm_d * delete=%delete|true
@endmacro

;弧_右上から_ななめ_緑
@macro name="effect_b_00_slash_10g"
@anm_q *
@anm_w * storage=effect_b_00_slash_10g_00
@anm_w * storage=effect_b_00_slash_10g_01
@anm_w * storage=effect_b_00_slash_10g_02
@anm_w * storage=effect_b_00_slash_10g_03
@anm_d * delete=%delete|true
@endmacro

;弧_右上から_ななめ_黒緑
@macro name="effect_a_00_slash_10k"
@anm_q *
@anm_w * storage=effect_a_00_slash_10k_00
@anm_w * storage=effect_a_00_slash_10k_01
@anm_w * storage=effect_a_00_slash_10k_02
@anm_w * storage=effect_a_00_slash_10k_03
@anm_d * delete=%delete|true
@endmacro

;右上から3_ななめ_緑
@macro name="effect_a_00_slash_11g"
@anm_q *
@anm_w * storage=effect_a_00_slash_11g_00
@anm_w * storage=effect_a_00_slash_11g_01
@anm_w * storage=effect_a_00_slash_11g_02
@anm_d * delete=%delete|true
@endmacro

;右上から4_ななめ_青
@macro name="effect_a_00_slash_12b"
@anm_q *
@anm_w * storage=effect_a_00_slash_12b_00
@anm_w * storage=effect_a_00_slash_12b_01
@anm_w * storage=effect_a_00_slash_12b_02
@anm_d * delete=%delete|true
@endmacro

;弧_左下から_ななめ_白
@macro name="effect_a_00_slash_13w"
@anm_q *
@anm_w * storage=effect_a_00_slash_13w_00
@anm_w * storage=effect_a_00_slash_13w_01
@anm_w * storage=effect_a_00_slash_13w_02
@anm_w * storage=effect_a_00_slash_13w_03
@anm_d * delete=%delete|true
@endmacro

;弧_左下から_ななめ_白
@macro name="effect_b_00_slash_13w"
@anm_q *
@anm_w * storage=effect_b_00_slash_13w_00
@anm_w * storage=effect_b_00_slash_13w_01
@anm_w * storage=effect_b_00_slash_13w_02
@anm_w * storage=effect_b_00_slash_13w_03
@anm_d * delete=%delete|true
@endmacro

;弧_左下から_ななめ_赤
@macro name="effect_a_00_slash_13r"
@anm_q *
@anm_w * storage=effect_a_00_slash_13r_00
@anm_w * storage=effect_a_00_slash_13r_01
@anm_w * storage=effect_a_00_slash_13r_02
@anm_w * storage=effect_a_00_slash_13r_03
@anm_d * delete=%delete|true
@endmacro

;弧_左下から_ななめ_赤
@macro name="effect_b_00_slash_13r"
@anm_q *
@anm_w * storage=effect_b_00_slash_13r_00
@anm_w * storage=effect_b_00_slash_13r_01
@anm_w * storage=effect_b_00_slash_13r_02
@anm_w * storage=effect_b_00_slash_13r_03
@anm_d * delete=%delete|true
@endmacro

;弧_左下から_ななめ_緑
@macro name="effect_a_00_slash_13g"
@anm_q *
@anm_w * storage=effect_a_00_slash_13g_00
@anm_w * storage=effect_a_00_slash_13g_01
@anm_w * storage=effect_a_00_slash_13g_02
@anm_w * storage=effect_a_00_slash_13g_03
@anm_d * delete=%delete|true
@endmacro

;弧_左下から_ななめ_緑
@macro name="effect_b_00_slash_13g"
@anm_q *
@anm_w * storage=effect_b_00_slash_13g_00
@anm_w * storage=effect_b_00_slash_13g_01
@anm_w * storage=effect_b_00_slash_13g_02
@anm_w * storage=effect_b_00_slash_13g_03
@anm_d * delete=%delete|true
@endmacro

;二連撃_白
@macro name="effect_a_00_slash_14w"
@anm_q *
@anm_w * storage=effect_a_00_slash_14w_00
@anm_w * storage=effect_a_00_slash_14w_01
@anm_w * storage=effect_a_00_slash_14w_02
@anm_w * storage=effect_a_00_slash_14w_03
@anm_w * storage=effect_a_00_slash_14w_04
@anm_w * storage=effect_a_00_slash_14w_05
@anm_w * storage=effect_a_00_slash_14w_06
@anm_w * storage=effect_a_00_slash_14w_07
@anm_d * delete=%delete|true
@endmacro

;二連撃_白
@macro name="effect_b_00_slash_14w"
@anm_q *
@anm_w * storage=effect_b_00_slash_14w_00
@anm_w * storage=effect_b_00_slash_14w_01
@anm_w * storage=effect_b_00_slash_14w_02
@anm_w * storage=effect_b_00_slash_14w_03
@anm_w * storage=effect_b_00_slash_14w_04
@anm_w * storage=effect_b_00_slash_14w_05
@anm_w * storage=effect_b_00_slash_14w_06
@anm_w * storage=effect_b_00_slash_14w_07
@anm_d * delete=%delete|true
@endmacro

;二連撃_赤
@macro name="effect_a_00_slash_14r"
@anm_q *
@anm_w * storage=effect_a_00_slash_14r_00
@anm_w * storage=effect_a_00_slash_14r_01
@anm_w * storage=effect_a_00_slash_14r_02
@anm_w * storage=effect_a_00_slash_14r_03
@anm_w * storage=effect_a_00_slash_14r_04
@anm_w * storage=effect_a_00_slash_14r_05
@anm_w * storage=effect_a_00_slash_14r_06
@anm_w * storage=effect_a_00_slash_14r_07
@anm_d * delete=%delete|true
@endmacro

;二連撃_赤
@macro name="effect_b_00_slash_14r"
@anm_q *
@anm_w * storage=effect_b_00_slash_14r_00
@anm_w * storage=effect_b_00_slash_14r_01
@anm_w * storage=effect_b_00_slash_14r_02
@anm_w * storage=effect_b_00_slash_14r_03
@anm_w * storage=effect_b_00_slash_14r_04
@anm_w * storage=effect_b_00_slash_14r_05
@anm_w * storage=effect_b_00_slash_14r_06
@anm_w * storage=effect_b_00_slash_14r_07
@anm_d * delete=%delete|true
@endmacro

;二連撃_緑
@macro name="effect_a_00_slash_14g"
@anm_q *
@anm_w * storage=effect_a_00_slash_14g_00
@anm_w * storage=effect_a_00_slash_14g_01
@anm_w * storage=effect_a_00_slash_14g_02
@anm_w * storage=effect_a_00_slash_14g_03
@anm_w * storage=effect_a_00_slash_14g_04
@anm_w * storage=effect_a_00_slash_14g_05
@anm_w * storage=effect_a_00_slash_14g_06
@anm_w * storage=effect_a_00_slash_14g_07
@anm_d * delete=%delete|true
@endmacro

;二連撃_緑
@macro name="effect_b_00_slash_14g"
@anm_q *
@anm_w * storage=effect_b_00_slash_14g_00
@anm_w * storage=effect_b_00_slash_14g_01
@anm_w * storage=effect_b_00_slash_14g_02
@anm_w * storage=effect_b_00_slash_14g_03
@anm_w * storage=effect_b_00_slash_14g_04
@anm_w * storage=effect_b_00_slash_14g_05
@anm_w * storage=effect_b_00_slash_14g_06
@anm_w * storage=effect_b_00_slash_14g_07
@anm_d * delete=%delete|true
@endmacro

;三連撃_白
@macro name="effect_a_00_slash_15w"
@anm_q *
@anm_w * storage=effect_a_00_slash_15w_00
@anm_w * storage=effect_a_00_slash_15w_01
@anm_w * storage=effect_a_00_slash_15w_02
@anm_w * storage=effect_a_00_slash_15w_03
@anm_w * storage=effect_a_00_slash_15w_04
@anm_w * storage=effect_a_00_slash_15w_05
@anm_d * delete=%delete|true
@endmacro

;三連撃_白
@macro name="effect_b_00_slash_15w"
@anm_q *
@anm_w * storage=effect_b_00_slash_15w_00
@anm_w * storage=effect_b_00_slash_15w_01
@anm_w * storage=effect_b_00_slash_15w_02
@anm_w * storage=effect_b_00_slash_15w_03
@anm_w * storage=effect_b_00_slash_15w_04
@anm_w * storage=effect_b_00_slash_15w_05
@anm_d * delete=%delete|true
@endmacro

;三連撃_赤
@macro name="effect_a_00_slash_15r"
@anm_q *
@anm_w * storage=effect_a_00_slash_15r_00
@anm_w * storage=effect_a_00_slash_15r_01
@anm_w * storage=effect_a_00_slash_15r_02
@anm_w * storage=effect_a_00_slash_15r_03
@anm_w * storage=effect_a_00_slash_15r_04
@anm_w * storage=effect_a_00_slash_15r_05
@anm_d * delete=%delete|true
@endmacro

;三連撃_赤
@macro name="effect_b_00_slash_15r"
@anm_q *
@anm_w * storage=effect_b_00_slash_15r_00
@anm_w * storage=effect_b_00_slash_15r_01
@anm_w * storage=effect_b_00_slash_15r_02
@anm_w * storage=effect_b_00_slash_15r_03
@anm_w * storage=effect_b_00_slash_15r_04
@anm_w * storage=effect_b_00_slash_15r_05
@anm_d * delete=%delete|true
@endmacro

;三連撃_緑
@macro name="effect_a_00_slash_15g"
@anm_q *
@anm_w * storage=effect_a_00_slash_15g_00
@anm_w * storage=effect_a_00_slash_15g_01
@anm_w * storage=effect_a_00_slash_15g_02
@anm_w * storage=effect_a_00_slash_15g_03
@anm_w * storage=effect_a_00_slash_15g_04
@anm_w * storage=effect_a_00_slash_15g_05
@anm_d * delete=%delete|true
@endmacro

;三連撃_緑
@macro name="effect_b_00_slash_15g"
@anm_q *
@anm_w * storage=effect_b_00_slash_15g_00
@anm_w * storage=effect_b_00_slash_15g_01
@anm_w * storage=effect_b_00_slash_15g_02
@anm_w * storage=effect_b_00_slash_15g_03
@anm_w * storage=effect_b_00_slash_15g_04
@anm_w * storage=effect_b_00_slash_15g_05
@anm_d * delete=%delete|true
@endmacro

;三連撃2_白
@macro name="effect_a_00_slash_16w"
@anm_q *
@anm_w * storage=effect_a_00_slash_16w_00
@anm_w * storage=effect_a_00_slash_16w_01
@anm_w * storage=effect_a_00_slash_16w_02
@anm_w * storage=effect_a_00_slash_16w_03
@anm_w * storage=effect_a_00_slash_16w_04
@anm_w * storage=effect_a_00_slash_16w_05
@anm_w * storage=effect_a_00_slash_16w_06
@anm_w * storage=effect_a_00_slash_16w_07
@anm_w * storage=effect_a_00_slash_16w_08
@anm_w * storage=effect_a_00_slash_16w_09
@anm_w * storage=effect_a_00_slash_16w_10
@anm_w * storage=effect_a_00_slash_16w_11
@anm_w * storage=effect_a_00_slash_16w_12
@anm_w * storage=effect_a_00_slash_16w_13
@anm_d * delete=%delete|true
@endmacro

;三連撃2_白
@macro name="effect_b_00_slash_16w"
@anm_q *
@anm_w * storage=effect_b_00_slash_16w_00
@anm_w * storage=effect_b_00_slash_16w_01
@anm_w * storage=effect_b_00_slash_16w_02
@anm_w * storage=effect_b_00_slash_16w_03
@anm_w * storage=effect_b_00_slash_16w_04
@anm_w * storage=effect_b_00_slash_16w_05
@anm_w * storage=effect_b_00_slash_16w_06
@anm_w * storage=effect_b_00_slash_16w_07
@anm_w * storage=effect_b_00_slash_16w_08
@anm_w * storage=effect_b_00_slash_16w_09
@anm_w * storage=effect_b_00_slash_16w_10
@anm_w * storage=effect_b_00_slash_16w_11
@anm_w * storage=effect_b_00_slash_16w_12
@anm_w * storage=effect_b_00_slash_16w_13
@anm_d * delete=%delete|true
@endmacro

;三連撃2_赤
@macro name="effect_a_00_slash_16r"
@anm_q *
@anm_w * storage=effect_a_00_slash_16r_00
@anm_w * storage=effect_a_00_slash_16r_01
@anm_w * storage=effect_a_00_slash_16r_02
@anm_w * storage=effect_a_00_slash_16r_03
@anm_w * storage=effect_a_00_slash_16r_04
@anm_w * storage=effect_a_00_slash_16r_05
@anm_w * storage=effect_a_00_slash_16r_06
@anm_w * storage=effect_a_00_slash_16r_07
@anm_w * storage=effect_a_00_slash_16r_08
@anm_w * storage=effect_a_00_slash_16r_09
@anm_w * storage=effect_a_00_slash_16r_10
@anm_w * storage=effect_a_00_slash_16r_11
@anm_w * storage=effect_a_00_slash_16r_12
@anm_w * storage=effect_a_00_slash_16r_13
@anm_d * delete=%delete|true
@endmacro

;三連撃2_赤
@macro name="effect_b_00_slash_16r"
@anm_q *
@anm_w * storage=effect_b_00_slash_16r_00
@anm_w * storage=effect_b_00_slash_16r_01
@anm_w * storage=effect_b_00_slash_16r_02
@anm_w * storage=effect_b_00_slash_16r_03
@anm_w * storage=effect_b_00_slash_16r_04
@anm_w * storage=effect_b_00_slash_16r_05
@anm_w * storage=effect_b_00_slash_16r_06
@anm_w * storage=effect_b_00_slash_16r_07
@anm_w * storage=effect_b_00_slash_16r_08
@anm_w * storage=effect_b_00_slash_16r_09
@anm_w * storage=effect_b_00_slash_16r_10
@anm_w * storage=effect_b_00_slash_16r_11
@anm_w * storage=effect_b_00_slash_16r_12
@anm_w * storage=effect_b_00_slash_16r_13
@anm_d * delete=%delete|true
@endmacro

;三連撃2_緑
@macro name="effect_a_00_slash_16g"
@anm_q *
@anm_w * storage=effect_a_00_slash_16g_00
@anm_w * storage=effect_a_00_slash_16g_01
@anm_w * storage=effect_a_00_slash_16g_02
@anm_w * storage=effect_a_00_slash_16g_03
@anm_w * storage=effect_a_00_slash_16g_04
@anm_w * storage=effect_a_00_slash_16g_05
@anm_w * storage=effect_a_00_slash_16g_06
@anm_w * storage=effect_a_00_slash_16g_07
@anm_w * storage=effect_a_00_slash_16g_08
@anm_w * storage=effect_a_00_slash_16g_09
@anm_w * storage=effect_a_00_slash_16g_10
@anm_w * storage=effect_a_00_slash_16g_11
@anm_w * storage=effect_a_00_slash_16g_12
@anm_w * storage=effect_a_00_slash_16g_13
@anm_d * delete=%delete|true
@endmacro

;三連撃2_緑
@macro name="effect_b_00_slash_16g"
@anm_q *
@anm_w * storage=effect_b_00_slash_16g_00
@anm_w * storage=effect_b_00_slash_16g_01
@anm_w * storage=effect_b_00_slash_16g_02
@anm_w * storage=effect_b_00_slash_16g_03
@anm_w * storage=effect_b_00_slash_16g_04
@anm_w * storage=effect_b_00_slash_16g_05
@anm_w * storage=effect_b_00_slash_16g_06
@anm_w * storage=effect_b_00_slash_16g_07
@anm_w * storage=effect_b_00_slash_16g_08
@anm_w * storage=effect_b_00_slash_16g_09
@anm_w * storage=effect_b_00_slash_16g_10
@anm_w * storage=effect_b_00_slash_16g_11
@anm_w * storage=effect_b_00_slash_16g_12
@anm_w * storage=effect_b_00_slash_16g_13
@anm_d * delete=%delete|true
@endmacro

;横回転切り_青
@macro name="effect_a_00_slash_17b"
@anm_q *
@anm_w * storage=effect_a_00_slash_17b_00
@anm_w * storage=effect_a_00_slash_17b_01
@anm_w * storage=effect_a_00_slash_17b_02
@anm_w * storage=effect_a_00_slash_17b_03
@anm_w * storage=effect_a_00_slash_17b_04
@anm_w * storage=effect_a_00_slash_17b_05
@anm_d * delete=%delete|true
@endmacro

;横回転切り_青
@macro name="effect_b_00_slash_17b"
@anm_q *
@anm_w * storage=effect_b_00_slash_17b_00
@anm_w * storage=effect_b_00_slash_17b_01
@anm_w * storage=effect_b_00_slash_17b_02
@anm_w * storage=effect_b_00_slash_17b_03
@anm_w * storage=effect_b_00_slash_17b_04
@anm_w * storage=effect_b_00_slash_17b_05
@anm_d * delete=%delete|true
@endmacro

;横回転切り_紫
@macro name="effect_a_00_slash_17m"
@anm_q *
@anm_w * storage=effect_a_00_slash_17m_00
@anm_w * storage=effect_a_00_slash_17m_01
@anm_w * storage=effect_a_00_slash_17m_02
@anm_w * storage=effect_a_00_slash_17m_03
@anm_w * storage=effect_a_00_slash_17m_04
@anm_w * storage=effect_a_00_slash_17m_05
@anm_d * delete=%delete|true
@endmacro

;横回転切り_紫
@macro name="effect_b_00_slash_17m"
@anm_q *
@anm_w * storage=effect_b_00_slash_17m_00
@anm_w * storage=effect_b_00_slash_17m_01
@anm_w * storage=effect_b_00_slash_17m_02
@anm_w * storage=effect_b_00_slash_17m_03
@anm_w * storage=effect_b_00_slash_17m_04
@anm_w * storage=effect_b_00_slash_17m_05
@anm_d * delete=%delete|true
@endmacro

;大剣_縦_上から_黄色
@macro name="effect_a_00_slash_18y"
@anm_q *
@anm_w * storage=effect_a_00_slash_18y_00
@anm_w * storage=effect_a_00_slash_18y_01
@anm_w * storage=effect_a_00_slash_18y_02
@anm_w * storage=effect_a_00_slash_18y_03
@anm_w * storage=effect_a_00_slash_18y_04
@anm_w * storage=effect_a_00_slash_18y_05
@anm_w * storage=effect_a_00_slash_18y_06
@anm_d * delete=%delete|true
@endmacro

;大剣_縦_上から_黄色
@macro name="effect_b_00_slash_18y"
@anm_q *
@anm_w * storage=effect_b_00_slash_18y_00
@anm_w * storage=effect_b_00_slash_18y_01
@anm_w * storage=effect_b_00_slash_18y_02
@anm_w * storage=effect_b_00_slash_18y_03
@anm_w * storage=effect_b_00_slash_18y_04
@anm_w * storage=effect_b_00_slash_18y_05
@anm_w * storage=effect_b_00_slash_18y_06
@anm_d * delete=%delete|true
@endmacro

;大剣_縦_上から2_黄色
@macro name="effect_a_00_slash_19y"
@anm_q *
@anm_w * storage=effect_a_00_slash_19y_00
@anm_w * storage=effect_a_00_slash_19y_01
@anm_w * storage=effect_a_00_slash_19y_02
@anm_w * storage=effect_a_00_slash_19y_03
@anm_w * storage=effect_a_00_slash_19y_04
@anm_w * storage=effect_a_00_slash_19y_05
@anm_w * storage=effect_a_00_slash_19y_06
@anm_w * storage=effect_a_00_slash_19y_07
@anm_d * delete=%delete|true
@endmacro

;大剣_縦_上から2_黄色
@macro name="effect_b_00_slash_19y"
@anm_q *
@anm_w * storage=effect_b_00_slash_19y_00
@anm_w * storage=effect_b_00_slash_19y_01
@anm_w * storage=effect_b_00_slash_19y_02
@anm_w * storage=effect_b_00_slash_19y_03
@anm_w * storage=effect_b_00_slash_19y_04
@anm_w * storage=effect_b_00_slash_19y_05
@anm_w * storage=effect_b_00_slash_19y_06
@anm_w * storage=effect_b_00_slash_19y_07
@anm_d * delete=%delete|true
@endmacro

;大剣_縦_上から3_黄色
@macro name="effect_a_00_slash_20y"
@anm_q *
@anm_w * storage=effect_a_00_slash_20y_00
@anm_w * storage=effect_a_00_slash_20y_01
@anm_w * storage=effect_a_00_slash_20y_02
@anm_w * storage=effect_a_00_slash_20y_03
@anm_w * storage=effect_a_00_slash_20y_04
@anm_w * storage=effect_a_00_slash_20y_05
@anm_w * storage=effect_a_00_slash_20y_06
@anm_w * storage=effect_a_00_slash_20y_07
@anm_d * delete=%delete|true
@endmacro

;大剣_縦_上から3_黄色
@macro name="effect_b_00_slash_20y"
@anm_q *
@anm_w * storage=effect_b_00_slash_20y_00
@anm_w * storage=effect_b_00_slash_20y_01
@anm_w * storage=effect_b_00_slash_20y_02
@anm_w * storage=effect_b_00_slash_20y_03
@anm_w * storage=effect_b_00_slash_20y_04
@anm_w * storage=effect_b_00_slash_20y_05
@anm_w * storage=effect_b_00_slash_20y_06
@anm_w * storage=effect_b_00_slash_20y_07
@anm_d * delete=%delete|true
@endmacro

;大剣_横_一閃_黄色
@macro name="effect_a_00_slash_21y"
@anm_q *
@anm_w * storage=effect_a_00_slash_21y_00
@anm_w * storage=effect_a_00_slash_21y_01
@anm_w * storage=effect_a_00_slash_21y_02
@anm_w * storage=effect_a_00_slash_21y_03
@anm_w * storage=effect_a_00_slash_21y_04
@anm_w * storage=effect_a_00_slash_21y_05
@anm_d * delete=%delete|true
@endmacro

;大剣_横_一閃_黄色
@macro name="effect_b_00_slash_21y"
@anm_q *
@anm_w * storage=effect_b_00_slash_21y_00
@anm_w * storage=effect_b_00_slash_21y_01
@anm_w * storage=effect_b_00_slash_21y_02
@anm_w * storage=effect_b_00_slash_21y_03
@anm_w * storage=effect_b_00_slash_21y_04
@anm_w * storage=effect_b_00_slash_21y_05
@anm_d * delete=%delete|true
@endmacro

;大剣_ななめ_黄色
@macro name="effect_a_00_slash_22y"
@anm_q *
@anm_w * storage=effect_a_00_slash_22y_00
@anm_w * storage=effect_a_00_slash_22y_01
@anm_w * storage=effect_a_00_slash_22y_02
@anm_w * storage=effect_a_00_slash_22y_03
@anm_w * storage=effect_a_00_slash_22y_04
@anm_w * storage=effect_a_00_slash_22y_05
@anm_d * delete=%delete|true
@endmacro

;大剣_ななめ_黄色
@macro name="effect_b_00_slash_22y"
@anm_q *
@anm_w * storage=effect_b_00_slash_22y_00
@anm_w * storage=effect_b_00_slash_22y_01
@anm_w * storage=effect_b_00_slash_22y_02
@anm_w * storage=effect_b_00_slash_22y_03
@anm_w * storage=effect_b_00_slash_22y_04
@anm_w * storage=effect_b_00_slash_22y_05
@anm_d * delete=%delete|true
@endmacro

;ナイフ_縦_上から_白
@macro name="effect_a_00_slash_23w"
@anm_q *
@anm_w * storage=effect_a_00_slash_23w_00
@anm_w * storage=effect_a_00_slash_23w_01
@anm_w * storage=effect_a_00_slash_23w_02
@anm_w * storage=effect_a_00_slash_23w_03
@anm_w * storage=effect_a_00_slash_23w_04
@anm_d * delete=%delete|true
@endmacro

;ナイフ_縦_上から_白
@macro name="effect_b_00_slash_23w"
@anm_q *
@anm_w * storage=effect_b_00_slash_23w_00
@anm_w * storage=effect_b_00_slash_23w_01
@anm_w * storage=effect_b_00_slash_23w_02
@anm_w * storage=effect_b_00_slash_23w_03
@anm_w * storage=effect_b_00_slash_23w_04
@anm_d * delete=%delete|true
@endmacro

;ナイフ_弧_右上から_ななめ_白
@macro name="effect_a_00_slash_24w"
@anm_q *
@anm_w * storage=effect_a_00_slash_24w_00
@anm_w * storage=effect_a_00_slash_24w_01
@anm_w * storage=effect_a_00_slash_24w_02
@anm_w * storage=effect_a_00_slash_24w_03
@anm_w * storage=effect_a_00_slash_24w_04
@anm_d * delete=%delete|true
@endmacro

;ナイフ_弧_右上から_ななめ_白
@macro name="effect_b_00_slash_24w"
@anm_q *
@anm_w * storage=effect_b_00_slash_24w_00
@anm_w * storage=effect_b_00_slash_24w_01
@anm_w * storage=effect_b_00_slash_24w_02
@anm_w * storage=effect_b_00_slash_24w_03
@anm_w * storage=effect_b_00_slash_24w_04
@anm_d * delete=%delete|true
@endmacro

;はさみ_クロス_青
@macro name="effect_a_00_slash_25b"
@anm_q *
@anm_w * storage=effect_a_00_slash_25b_00
@anm_w * storage=effect_a_00_slash_25b_01
@anm_w * storage=effect_a_00_slash_25b_02
@anm_w * storage=effect_a_00_slash_25b_03
@anm_w * storage=effect_a_00_slash_25b_04
@anm_d * delete=%delete|true
@endmacro

;はさみ_クロス_青
@macro name="effect_b_00_slash_25b"
@anm_q *
@anm_w * storage=effect_b_00_slash_25b_00
@anm_w * storage=effect_b_00_slash_25b_01
@anm_w * storage=effect_b_00_slash_25b_02
@anm_w * storage=effect_b_00_slash_25b_03
@anm_w * storage=effect_b_00_slash_25b_04
@anm_d * delete=%delete|true
@endmacro

;鉤爪_青
@macro name="effect_a_00_slash_26b"
@anm_q *
@anm_w * storage=effect_a_00_slash_26b_00
@anm_w * storage=effect_a_00_slash_26b_01
@anm_w * storage=effect_a_00_slash_26b_02
@anm_w * storage=effect_a_00_slash_26b_03
@anm_d * delete=%delete|true
@endmacro

;鉤爪_青
@macro name="effect_b_00_slash_26b"
@anm_q *
@anm_w * storage=effect_b_00_slash_26b_00
@anm_w * storage=effect_b_00_slash_26b_01
@anm_w * storage=effect_b_00_slash_26b_02
@anm_w * storage=effect_b_00_slash_26b_03
@anm_w * storage=effect_b_00_slash_26b_04
@anm_w * storage=effect_b_00_slash_26b_05
@anm_d * delete=%delete|true
@endmacro

;チェーンソー_赤
@macro name="effect_a_00_slash_27r"
@anm_q *
@anm_w * storage=effect_a_00_slash_27r_00
@anm_w * storage=effect_a_00_slash_27r_01
@anm_w * storage=effect_a_00_slash_27r_02
@anm_w * storage=effect_a_00_slash_27r_03
@anm_w * storage=effect_a_00_slash_27r_04
@anm_w * storage=effect_a_00_slash_27r_05
@anm_d * delete=%delete|true
@endmacro

;チェーンソー_赤
@macro name="effect_b_00_slash_27r"
@anm_q *
@anm_w * storage=effect_b_00_slash_27r_00
@anm_w * storage=effect_b_00_slash_27r_01
@anm_w * storage=effect_b_00_slash_27r_02
@anm_w * storage=effect_b_00_slash_27r_03
@anm_w * storage=effect_b_00_slash_27r_04
@anm_w * storage=effect_b_00_slash_27r_05
@anm_d * delete=%delete|true
@endmacro

;チェーンソー_三連撃_赤
@macro name="effect_a_00_slash_28r"
@anm_q *
@anm_w * storage=effect_a_00_slash_28r_00
@anm_w * storage=effect_a_00_slash_28r_01
@anm_w * storage=effect_a_00_slash_28r_02
@anm_w * storage=effect_a_00_slash_28r_03
@anm_w * storage=effect_a_00_slash_28r_04
@anm_w * storage=effect_a_00_slash_28r_05
@anm_w * storage=effect_a_00_slash_28r_06
@anm_w * storage=effect_a_00_slash_28r_07
@anm_w * storage=effect_a_00_slash_28r_08
@anm_w * storage=effect_a_00_slash_28r_09
@anm_w * storage=effect_a_00_slash_28r_10
@anm_w * storage=effect_a_00_slash_28r_11
@anm_w * storage=effect_a_00_slash_28r_12
@anm_w * storage=effect_a_00_slash_28r_13
@anm_d * delete=%delete|true
@endmacro

;チェーンソー_三連撃_赤
@macro name="effect_b_00_slash_28r"
@anm_q *
@anm_w * storage=effect_b_00_slash_28r_00
@anm_w * storage=effect_b_00_slash_28r_01
@anm_w * storage=effect_b_00_slash_28r_02
@anm_w * storage=effect_b_00_slash_28r_03
@anm_w * storage=effect_b_00_slash_28r_04
@anm_w * storage=effect_b_00_slash_28r_05
@anm_w * storage=effect_b_00_slash_28r_06
@anm_w * storage=effect_b_00_slash_28r_07
@anm_w * storage=effect_b_00_slash_28r_08
@anm_w * storage=effect_b_00_slash_28r_09
@anm_w * storage=effect_b_00_slash_28r_10
@anm_w * storage=effect_b_00_slash_28r_11
@anm_w * storage=effect_b_00_slash_28r_12
@anm_w * storage=effect_b_00_slash_28r_13
@anm_d * delete=%delete|true
@endmacro

;剣線_ななめ_青
@macro name="effect_a_00_slash_29b"
@anm_q *
@anm_w * storage=effect_a_00_slash_29b_00
@anm_d * delete=%delete|true
@endmacro

;剣線_ななめ_青
@macro name="effect_b_00_slash_29b"
@anm_q *
@anm_w * storage=effect_b_00_slash_29b_00
@anm_d * delete=%delete|true
@endmacro

;剣線_三連撃_青
@macro name="effect_a_00_slash_30b"
@anm_q *
@anm_w * storage=effect_a_00_slash_30b_00
@anm_w * storage=effect_a_00_slash_30b_01
@anm_w * storage=effect_a_00_slash_30b_02
@anm_d * delete=%delete|true
@endmacro

;剣線_三連撃_青
@macro name="effect_b_00_slash_30b"
@anm_q *
@anm_w * storage=effect_b_00_slash_30b_00
@anm_w * storage=effect_b_00_slash_30b_01
@anm_w * storage=effect_b_00_slash_30b_02
@anm_d * delete=%delete|true
@endmacro

;剣線_八連撃_青
@macro name="effect_a_00_slash_31b"
@anm_q *
@anm_w * storage=effect_a_00_slash_31b_00
@anm_w * storage=effect_a_00_slash_31b_01
@anm_w * storage=effect_a_00_slash_31b_02
@anm_w * storage=effect_a_00_slash_31b_03
@anm_w * storage=effect_a_00_slash_31b_04
@anm_w * storage=effect_a_00_slash_31b_05
@anm_w * storage=effect_a_00_slash_31b_06
@anm_w * storage=effect_a_00_slash_31b_07
@anm_d * delete=%delete|true
@endmacro

;剣線_八連撃_青
@macro name="effect_b_00_slash_31b"
@anm_q *
@anm_w * storage=effect_b_00_slash_31b_00
@anm_w * storage=effect_b_00_slash_31b_01
@anm_w * storage=effect_b_00_slash_31b_02
@anm_w * storage=effect_b_00_slash_31b_03
@anm_w * storage=effect_b_00_slash_31b_04
@anm_w * storage=effect_b_00_slash_31b_05
@anm_w * storage=effect_b_00_slash_31b_06
@anm_w * storage=effect_b_00_slash_31b_07
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 刺突
;############################################################

;奥から_青
@macro name="effect_a_00_sting_00b"
@anm_q *
@anm_w * storage=effect_a_00_sting_00b_00
@anm_w * storage=effect_a_00_sting_00b_01
@anm_w * storage=effect_a_00_sting_00b_02
@anm_w * storage=effect_a_00_sting_00b_03
@anm_w * storage=effect_a_00_sting_00b_04
@anm_w * storage=effect_a_00_sting_00b_05
@anm_w * storage=effect_a_00_sting_00b_06
@anm_d * delete=%delete|true
@endmacro

;奥から_青
@macro name="effect_b_00_sting_00b"
@anm_q *
@anm_w * storage=effect_b_00_sting_00b_00
@anm_w * storage=effect_b_00_sting_00b_01
@anm_w * storage=effect_b_00_sting_00b_02
@anm_w * storage=effect_b_00_sting_00b_03
@anm_w * storage=effect_b_00_sting_00b_04
@anm_w * storage=effect_b_00_sting_00b_05
@anm_w * storage=effect_b_00_sting_00b_06
@anm_d * delete=%delete|true
@endmacro

;奥から_紫
@macro name="effect_a_00_sting_00m"
@anm_q *
@anm_w * storage=effect_a_00_sting_00m_00
@anm_w * storage=effect_a_00_sting_00m_01
@anm_w * storage=effect_a_00_sting_00m_02
@anm_w * storage=effect_a_00_sting_00m_03
@anm_w * storage=effect_a_00_sting_00m_04
@anm_w * storage=effect_a_00_sting_00m_05
@anm_w * storage=effect_a_00_sting_00m_06
@anm_d * delete=%delete|true
@endmacro

;奥から_紫
@macro name="effect_b_00_sting_00m"
@anm_q *
@anm_w * storage=effect_b_00_sting_00m_00
@anm_w * storage=effect_b_00_sting_00m_01
@anm_w * storage=effect_b_00_sting_00m_02
@anm_w * storage=effect_b_00_sting_00m_03
@anm_w * storage=effect_b_00_sting_00m_04
@anm_w * storage=effect_b_00_sting_00m_05
@anm_w * storage=effect_b_00_sting_00m_06
@anm_d * delete=%delete|true
@endmacro

;奥から_茶色
@macro name="effect_a_00_sting_00br"
@anm_q *
@anm_w * storage=effect_a_00_sting_00br_00
@anm_w * storage=effect_a_00_sting_00br_01
@anm_w * storage=effect_a_00_sting_00br_02
@anm_w * storage=effect_a_00_sting_00br_03
@anm_w * storage=effect_a_00_sting_00br_04
@anm_w * storage=effect_a_00_sting_00br_05
@anm_w * storage=effect_a_00_sting_00br_06
@anm_d * delete=%delete|true
@endmacro

;奥から_茶色
@macro name="effect_b_00_sting_00br"
@anm_q *
@anm_w * storage=effect_b_00_sting_00br_00
@anm_w * storage=effect_b_00_sting_00br_01
@anm_w * storage=effect_b_00_sting_00br_02
@anm_w * storage=effect_b_00_sting_00br_03
@anm_w * storage=effect_b_00_sting_00br_04
@anm_w * storage=effect_b_00_sting_00br_05
@anm_w * storage=effect_b_00_sting_00br_06
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_青
@macro name="effect_a_00_sting_01b"
@anm_q *
@anm_w * storage=effect_a_00_sting_01b_00
@anm_w * storage=effect_a_00_sting_01b_01
@anm_w * storage=effect_a_00_sting_01b_02
@anm_w * storage=effect_a_00_sting_01b_03
@anm_w * storage=effect_a_00_sting_01b_04
@anm_w * storage=effect_a_00_sting_01b_05
@anm_w * storage=effect_a_00_sting_01b_06
@anm_w * storage=effect_a_00_sting_01b_07
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_青
@macro name="effect_b_00_sting_01b"
@anm_q *
@anm_w * storage=effect_b_00_sting_01b_00
@anm_w * storage=effect_b_00_sting_01b_01
@anm_w * storage=effect_b_00_sting_01b_02
@anm_w * storage=effect_b_00_sting_01b_03
@anm_w * storage=effect_b_00_sting_01b_04
@anm_w * storage=effect_b_00_sting_01b_05
@anm_w * storage=effect_b_00_sting_01b_06
@anm_w * storage=effect_b_00_sting_01b_07
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_紫
@macro name="effect_a_00_sting_01m"
@anm_q *
@anm_w * storage=effect_a_00_sting_01m_00
@anm_w * storage=effect_a_00_sting_01m_01
@anm_w * storage=effect_a_00_sting_01m_02
@anm_w * storage=effect_a_00_sting_01m_03
@anm_w * storage=effect_a_00_sting_01m_04
@anm_w * storage=effect_a_00_sting_01m_05
@anm_w * storage=effect_a_00_sting_01m_06
@anm_w * storage=effect_a_00_sting_01m_07
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_紫
@macro name="effect_b_00_sting_01m"
@anm_q *
@anm_w * storage=effect_b_00_sting_01m_00
@anm_w * storage=effect_b_00_sting_01m_01
@anm_w * storage=effect_b_00_sting_01m_02
@anm_w * storage=effect_b_00_sting_01m_03
@anm_w * storage=effect_b_00_sting_01m_04
@anm_w * storage=effect_b_00_sting_01m_05
@anm_w * storage=effect_b_00_sting_01m_06
@anm_w * storage=effect_b_00_sting_01m_07
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_茶色
@macro name="effect_a_00_sting_01br"
@anm_q *
@anm_w * storage=effect_a_00_sting_01br_00
@anm_w * storage=effect_a_00_sting_01br_01
@anm_w * storage=effect_a_00_sting_01br_02
@anm_w * storage=effect_a_00_sting_01br_03
@anm_w * storage=effect_a_00_sting_01br_04
@anm_w * storage=effect_a_00_sting_01br_05
@anm_w * storage=effect_a_00_sting_01br_06
@anm_w * storage=effect_a_00_sting_01br_07
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_茶色
@macro name="effect_b_00_sting_01br"
@anm_q *
@anm_w * storage=effect_b_00_sting_01br_00
@anm_w * storage=effect_b_00_sting_01br_01
@anm_w * storage=effect_b_00_sting_01br_02
@anm_w * storage=effect_b_00_sting_01br_03
@anm_w * storage=effect_b_00_sting_01br_04
@anm_w * storage=effect_b_00_sting_01br_05
@anm_w * storage=effect_b_00_sting_01br_06
@anm_w * storage=effect_b_00_sting_01br_07
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_白
@macro name="effect_a_00_sting_02w"
@anm_q *
@anm_w * storage=effect_a_00_sting_02w_00
@anm_w * storage=effect_a_00_sting_02w_01
@anm_w * storage=effect_a_00_sting_02w_02
@anm_w * storage=effect_a_00_sting_02w_03
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_白
@macro name="effect_b_00_sting_02w"
@anm_q *
@anm_w * storage=effect_b_00_sting_02w_00
@anm_w * storage=effect_b_00_sting_02w_01
@anm_w * storage=effect_b_00_sting_02w_02
@anm_w * storage=effect_b_00_sting_02w_03
@anm_w * storage=effect_b_00_sting_02w_04
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_赤
@macro name="effect_a_00_sting_02r"
@anm_q *
@anm_w * storage=effect_a_00_sting_02r_00
@anm_w * storage=effect_a_00_sting_02r_01
@anm_w * storage=effect_a_00_sting_02r_02
@anm_w * storage=effect_a_00_sting_02r_03
@anm_w * storage=effect_a_00_sting_02r_04
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_赤
@macro name="effect_b_00_sting_02r"
@anm_q *
@anm_w * storage=effect_b_00_sting_02r_00
@anm_w * storage=effect_b_00_sting_02r_01
@anm_w * storage=effect_b_00_sting_02r_02
@anm_w * storage=effect_b_00_sting_02r_03
@anm_w * storage=effect_b_00_sting_02r_04
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_緑
@macro name="effect_a_00_sting_02g"
@anm_q *
@anm_w * storage=effect_a_00_sting_02g_00
@anm_w * storage=effect_a_00_sting_02g_01
@anm_w * storage=effect_a_00_sting_02g_02
@anm_w * storage=effect_a_00_sting_02g_03
@anm_w * storage=effect_a_00_sting_02g_04
@anm_d * delete=%delete|true
@endmacro

;右奥から_ななめ_緑
@macro name="effect_b_00_sting_02g"
@anm_q *
@anm_w * storage=effect_b_00_sting_02g_00
@anm_w * storage=effect_b_00_sting_02g_01
@anm_w * storage=effect_b_00_sting_02g_02
@anm_w * storage=effect_b_00_sting_02g_03
@anm_w * storage=effect_b_00_sting_02g_04
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)殺生牙_non
@macro name="effect_a_00_sting_03non"
@anm_q *
@anm_w * storage=effect_a_00_sting_03non_00
@anm_w * storage=effect_a_00_sting_03non_01
@anm_w * storage=effect_a_00_sting_03non_02
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)殺生牙_non
@macro name="effect_b_00_sting_03non"
@anm_q *
@anm_w * storage=effect_b_00_sting_03non_00
@anm_w * storage=effect_b_00_sting_03non_01
@anm_w * storage=effect_b_00_sting_03non_02
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)殺生牙_赤
@macro name="effect_b_00_sting_03r"
@anm_q *
@anm_w * storage=effect_b_00_sting_03r_00
@anm_w * storage=effect_b_00_sting_03r_01
@anm_w * storage=effect_b_00_sting_03r_02
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)殺生牙・ねじり_non
@macro name="effect_b_00_sting_04non"
@anm_q *
@anm_w * storage=effect_b_00_sting_04non_00
@anm_w * storage=effect_b_00_sting_04non_01
@anm_w * storage=effect_b_00_sting_04non_02
@anm_w * storage=effect_b_00_sting_04non_03
@anm_w * storage=effect_b_00_sting_04non_04
@anm_w * storage=effect_b_00_sting_04non_05
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)殺生牙・ねじり_赤
@macro name="effect_b_00_sting_04r"
@anm_q *
@anm_w * storage=effect_b_00_sting_04r_00
@anm_w * storage=effect_b_00_sting_04r_01
@anm_w * storage=effect_b_00_sting_04r_02
@anm_w * storage=effect_b_00_sting_04r_03
@anm_w * storage=effect_b_00_sting_04r_04
@anm_w * storage=effect_b_00_sting_04r_05
@anm_d * delete=%delete|true
@endmacro


;############################################################
; ワイヤー
;############################################################

;捕縛_青
@macro name="effect_a_00_wire_00b"
@anm_q *
@anm_w * storage=effect_a_00_wire_00b_00
@anm_w * storage=effect_a_00_wire_00b_01
@anm_d * delete=%delete|true
@endmacro

;捕縛_青
@macro name="effect_b_00_wire_00b"
@anm_q *
@anm_w * storage=effect_b_00_wire_00b_00
@anm_w * storage=effect_b_00_wire_00b_01
@anm_d * delete=%delete|true
@endmacro

;捕縛_紫
@macro name="effect_b_00_wire_00m"
@anm_q *
@anm_w * storage=effect_b_00_wire_00m_00
@anm_w * storage=effect_b_00_wire_00m_01
@anm_d * delete=%delete|true
@endmacro

;捕縛2_青
@macro name="effect_a_00_wire_01b"
@anm_q *
@anm_w * storage=effect_a_00_wire_01b_00
@anm_w * storage=effect_a_00_wire_01b_01
@anm_w * storage=effect_a_00_wire_01b_02
@anm_w * storage=effect_a_00_wire_01b_03
@anm_d * delete=%delete|true
@endmacro

;捕縛2_青
@macro name="effect_b_00_wire_01b"
@anm_q *
@anm_w * storage=effect_b_00_wire_01b_00
@anm_w * storage=effect_b_00_wire_01b_01
@anm_w * storage=effect_b_00_wire_01b_02
@anm_w * storage=effect_b_00_wire_01b_03
@anm_d * delete=%delete|true
@endmacro

;捕縛2_紫
@macro name="effect_b_00_wire_01m"
@anm_q *
@anm_w * storage=effect_b_00_wire_01m_00
@anm_w * storage=effect_b_00_wire_01m_01
@anm_w * storage=effect_b_00_wire_01m_02
@anm_w * storage=effect_b_00_wire_01m_03
@anm_d * delete=%delete|true
@endmacro

;捕縛3_青
@macro name="effect_a_00_wire_02b"
@anm_q *
@anm_w * storage=effect_a_00_wire_02b_00
@anm_w * storage=effect_a_00_wire_02b_01
@anm_w * storage=effect_a_00_wire_02b_02
@anm_d * delete=%delete|true
@endmacro

;捕縛3_青
@macro name="effect_b_00_wire_02b"
@anm_q *
@anm_w * storage=effect_b_00_wire_02b_00
@anm_w * storage=effect_b_00_wire_02b_01
@anm_w * storage=effect_b_00_wire_02b_02
@anm_d * delete=%delete|true
@endmacro

;捕縛3_紫
@macro name="effect_b_00_wire_02m"
@anm_q *
@anm_w * storage=effect_b_00_wire_02m_00
@anm_w * storage=effect_b_00_wire_02m_01
@anm_w * storage=effect_b_00_wire_02m_02
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 射撃
;############################################################

;サブマシンガン_乱射_non
@macro name="effect_a_00_gunshot_00non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_00non_00
@anm_w * storage=effect_a_00_gunshot_00non_01
@anm_w * storage=effect_a_00_gunshot_00non_02
@anm_w * storage=effect_a_00_gunshot_00non_03
@anm_w * storage=effect_a_00_gunshot_00non_04
@anm_w * storage=effect_a_00_gunshot_00non_05
@anm_w * storage=effect_a_00_gunshot_00non_06
@anm_w * storage=effect_a_00_gunshot_00non_07
@anm_w * storage=effect_a_00_gunshot_00non_08
@anm_w * storage=effect_a_00_gunshot_00non_09
@anm_w * storage=effect_a_00_gunshot_00non_10
@anm_w * storage=effect_a_00_gunshot_00non_11
@anm_w * storage=effect_a_00_gunshot_00non_12
@anm_d * delete=%delete|true
@endmacro

;サブマシンガン_乱射_non
@macro name="effect_b_00_gunshot_00non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_00non_00
@anm_w * storage=effect_b_00_gunshot_00non_01
@anm_w * storage=effect_b_00_gunshot_00non_02
@anm_w * storage=effect_b_00_gunshot_00non_03
@anm_w * storage=effect_b_00_gunshot_00non_04
@anm_w * storage=effect_b_00_gunshot_00non_05
@anm_w * storage=effect_b_00_gunshot_00non_06
@anm_w * storage=effect_b_00_gunshot_00non_07
@anm_w * storage=effect_b_00_gunshot_00non_08
@anm_w * storage=effect_b_00_gunshot_00non_09
@anm_w * storage=effect_b_00_gunshot_00non_10
@anm_w * storage=effect_b_00_gunshot_00non_11
@anm_w * storage=effect_b_00_gunshot_00non_12
@anm_d * delete=%delete|true
@endmacro

;連射_non
@macro name="effect_a_00_gunshot_01non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_01non_00
@anm_w * storage=effect_a_00_gunshot_01non_01
@anm_w * storage=effect_a_00_gunshot_01non_02
@anm_w * storage=effect_a_00_gunshot_01non_03
@anm_w * storage=effect_a_00_gunshot_01non_04
@anm_d * delete=%delete|true
@endmacro

;連射_non
@macro name="effect_b_00_gunshot_01non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_01non_00
@anm_w * storage=effect_b_00_gunshot_01non_01
@anm_w * storage=effect_b_00_gunshot_01non_02
@anm_w * storage=effect_b_00_gunshot_01non_03
@anm_w * storage=effect_b_00_gunshot_01non_04
@anm_d * delete=%delete|true
@endmacro

;連射2_non
@macro name="effect_a_00_gunshot_02non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_02non_00
@anm_w * storage=effect_a_00_gunshot_02non_01
@anm_w * storage=effect_a_00_gunshot_02non_02
@anm_w * storage=effect_a_00_gunshot_02non_03
@anm_w * storage=effect_a_00_gunshot_02non_04
@anm_w * storage=effect_a_00_gunshot_02non_05
@anm_d * delete=%delete|true
@endmacro

;連射2_non
@macro name="effect_b_00_gunshot_02non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_02non_00
@anm_w * storage=effect_b_00_gunshot_02non_01
@anm_w * storage=effect_b_00_gunshot_02non_02
@anm_w * storage=effect_b_00_gunshot_02non_03
@anm_w * storage=effect_b_00_gunshot_02non_04
@anm_w * storage=effect_b_00_gunshot_02non_05
@anm_w * storage=effect_b_00_gunshot_02non_06
@anm_d * delete=%delete|true
@endmacro

;銃弾_連射_non
@macro name="effect_a_00_gunshot_03non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_03non_00
@anm_w * storage=effect_a_00_gunshot_03non_01
@anm_w * storage=effect_a_00_gunshot_03non_02
@anm_w * storage=effect_a_00_gunshot_03non_03
@anm_w * storage=effect_a_00_gunshot_03non_04
@anm_w * storage=effect_a_00_gunshot_03non_05
@anm_w * storage=effect_a_00_gunshot_03non_06
@anm_w * storage=effect_a_00_gunshot_03non_07
@anm_w * storage=effect_a_00_gunshot_03non_08
@anm_w * storage=effect_a_00_gunshot_03non_09
@anm_d * delete=%delete|true
@endmacro

;銃弾_連射_non
@macro name="effect_b_00_gunshot_03non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_03non_00
@anm_w * storage=effect_b_00_gunshot_03non_01
@anm_w * storage=effect_b_00_gunshot_03non_02
@anm_w * storage=effect_b_00_gunshot_03non_03
@anm_w * storage=effect_b_00_gunshot_03non_04
@anm_w * storage=effect_b_00_gunshot_03non_05
@anm_w * storage=effect_b_00_gunshot_03non_06
@anm_w * storage=effect_b_00_gunshot_03non_07
@anm_w * storage=effect_b_00_gunshot_03non_08
@anm_w * storage=effect_b_00_gunshot_03non_09
@anm_d * delete=%delete|true
@endmacro

;機関銃_跳弾_non
@macro name="effect_a_00_gunshot_04non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_04non_00
@anm_w * storage=effect_a_00_gunshot_04non_01
@anm_w * storage=effect_a_00_gunshot_04non_02
@anm_w * storage=effect_a_00_gunshot_04non_03
@anm_w * storage=effect_a_00_gunshot_04non_04
@anm_w * storage=effect_a_00_gunshot_04non_05
@anm_w * storage=effect_a_00_gunshot_04non_06
@anm_w * storage=effect_a_00_gunshot_04non_07
@anm_w * storage=effect_a_00_gunshot_04non_08
@anm_w * storage=effect_a_00_gunshot_04non_09
@anm_w * storage=effect_a_00_gunshot_04non_10
@anm_w * storage=effect_a_00_gunshot_04non_11
@anm_w * storage=effect_a_00_gunshot_04non_12
@anm_w * storage=effect_a_00_gunshot_04non_13
@anm_w * storage=effect_a_00_gunshot_04non_14
@anm_w * storage=effect_a_00_gunshot_04non_15
@anm_w * storage=effect_a_00_gunshot_04non_16
@anm_w * storage=effect_a_00_gunshot_04non_17
@anm_w * storage=effect_a_00_gunshot_04non_18
@anm_w * storage=effect_a_00_gunshot_04non_19
@anm_d * delete=%delete|true
@endmacro

;機関銃_跳弾_non
@macro name="effect_b_00_gunshot_04non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_04non_00
@anm_w * storage=effect_b_00_gunshot_04non_01
@anm_w * storage=effect_b_00_gunshot_04non_02
@anm_w * storage=effect_b_00_gunshot_04non_03
@anm_w * storage=effect_b_00_gunshot_04non_04
@anm_w * storage=effect_b_00_gunshot_04non_05
@anm_w * storage=effect_b_00_gunshot_04non_06
@anm_w * storage=effect_b_00_gunshot_04non_07
@anm_w * storage=effect_b_00_gunshot_04non_08
@anm_w * storage=effect_b_00_gunshot_04non_09
@anm_w * storage=effect_b_00_gunshot_04non_10
@anm_w * storage=effect_b_00_gunshot_04non_11
@anm_w * storage=effect_b_00_gunshot_04non_12
@anm_w * storage=effect_b_00_gunshot_04non_13
@anm_w * storage=effect_b_00_gunshot_04non_14
@anm_w * storage=effect_b_00_gunshot_04non_15
@anm_w * storage=effect_b_00_gunshot_04non_16
@anm_w * storage=effect_b_00_gunshot_04non_17
@anm_w * storage=effect_b_00_gunshot_04non_18
@anm_w * storage=effect_b_00_gunshot_04non_19
@anm_d * delete=%delete|true
@endmacro

;トカレフ_non
@macro name="effect_a_00_gunshot_05non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_05non_00
@anm_w * storage=effect_a_00_gunshot_05non_01
@anm_w * storage=effect_a_00_gunshot_05non_02
@anm_d * delete=%delete|true
@endmacro

;トカレフ_non
@macro name="effect_b_00_gunshot_05non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_05non_00
@anm_w * storage=effect_b_00_gunshot_05non_01
@anm_w * storage=effect_b_00_gunshot_05non_02
@anm_d * delete=%delete|true
@endmacro

;トカレフ2_non
@macro name="effect_a_00_gunshot_06non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_06non_00
@anm_w * storage=effect_a_00_gunshot_06non_01
@anm_w * storage=effect_a_00_gunshot_06non_02
@anm_d * delete=%delete|true
@endmacro

;トカレフ2_non
@macro name="effect_b_00_gunshot_06non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_06non_00
@anm_w * storage=effect_b_00_gunshot_06non_01
@anm_w * storage=effect_b_00_gunshot_06non_02
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ_non
@macro name="effect_a_00_gunshot_07non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_07non_00
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ_non
@macro name="effect_b_00_gunshot_07non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_07non_00
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ2_non
@macro name="effect_a_00_gunshot_08non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_08non_00
@anm_w * storage=effect_a_00_gunshot_08non_01
@anm_w * storage=effect_a_00_gunshot_08non_02
@anm_w * storage=effect_a_00_gunshot_08non_03
@anm_w * storage=effect_a_00_gunshot_08non_04
@anm_w * storage=effect_a_00_gunshot_08non_05
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ2_non
@macro name="effect_b_00_gunshot_08non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_08non_00
@anm_w * storage=effect_b_00_gunshot_08non_01
@anm_w * storage=effect_b_00_gunshot_08non_02
@anm_w * storage=effect_b_00_gunshot_08non_03
@anm_w * storage=effect_b_00_gunshot_08non_04
@anm_w * storage=effect_b_00_gunshot_08non_05
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ3_non
@macro name="effect_b_00_gunshot_09non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_09non_00
@anm_w * storage=effect_b_00_gunshot_09non_01
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ4_non
@macro name="effect_b_00_gunshot_10non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_10non_00
@anm_w * storage=effect_b_00_gunshot_10non_01
@anm_w * storage=effect_b_00_gunshot_10non_02
@anm_w * storage=effect_b_00_gunshot_10non_03
@anm_w * storage=effect_b_00_gunshot_10non_04
@anm_w * storage=effect_b_00_gunshot_10non_05
@anm_w * storage=effect_b_00_gunshot_10non_06
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ_乱射_non
@macro name="effect_a_00_gunshot_11non"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_11non_00
@anm_w * storage=effect_a_00_gunshot_11non_01
@anm_w * storage=effect_a_00_gunshot_11non_02
@anm_w * storage=effect_a_00_gunshot_11non_03
@anm_w * storage=effect_a_00_gunshot_11non_04
@anm_w * storage=effect_a_00_gunshot_11non_05
@anm_w * storage=effect_a_00_gunshot_11non_06
@anm_w * storage=effect_a_00_gunshot_11non_07
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ_乱射_non
@macro name="effect_b_00_gunshot_11non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_11non_00
@anm_w * storage=effect_b_00_gunshot_11non_01
@anm_w * storage=effect_b_00_gunshot_11non_02
@anm_w * storage=effect_b_00_gunshot_11non_03
@anm_w * storage=effect_b_00_gunshot_11non_04
@anm_w * storage=effect_b_00_gunshot_11non_05
@anm_w * storage=effect_b_00_gunshot_11non_06
@anm_w * storage=effect_b_00_gunshot_11non_07
@anm_d * delete=%delete|true
@endmacro

;マズルフラッシュ_乱射2_non
@macro name="effect_b_00_gunshot_12non"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_12non_00
@anm_w * storage=effect_b_00_gunshot_12non_01
@anm_w * storage=effect_b_00_gunshot_12non_02
@anm_w * storage=effect_b_00_gunshot_12non_03
@anm_w * storage=effect_b_00_gunshot_12non_04
@anm_w * storage=effect_b_00_gunshot_12non_05
@anm_w * storage=effect_b_00_gunshot_12non_06
@anm_w * storage=effect_b_00_gunshot_12non_07
@anm_w * storage=effect_b_00_gunshot_12non_08
@anm_w * storage=effect_b_00_gunshot_12non_09
@anm_w * storage=effect_b_00_gunshot_12non_10
@anm_w * storage=effect_b_00_gunshot_12non_11
@anm_w * storage=effect_b_00_gunshot_12non_12
@anm_w * storage=effect_b_00_gunshot_12non_13
@anm_w * storage=effect_b_00_gunshot_12non_14
@anm_w * storage=effect_b_00_gunshot_12non_15
@anm_d * delete=%delete|true
@endmacro

;ボウガン_白
@macro name="effect_a_00_gunshot_13w"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_13w_00
@anm_w * storage=effect_a_00_gunshot_13w_01
@anm_w * storage=effect_a_00_gunshot_13w_02
@anm_w * storage=effect_a_00_gunshot_13w_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_白
@macro name="effect_b_00_gunshot_13w"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_13w_00
@anm_w * storage=effect_b_00_gunshot_13w_01
@anm_d * delete=%delete|true
@endmacro

;ボウガン_赤
@macro name="effect_a_00_gunshot_13r"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_13r_00
@anm_w * storage=effect_a_00_gunshot_13r_01
@anm_w * storage=effect_a_00_gunshot_13r_02
@anm_w * storage=effect_a_00_gunshot_13r_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_赤
@macro name="effect_b_00_gunshot_13r"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_13r_00
@anm_w * storage=effect_b_00_gunshot_13r_01
@anm_w * storage=effect_b_00_gunshot_13r_02
@anm_w * storage=effect_b_00_gunshot_13r_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_緑
@macro name="effect_a_00_gunshot_13g"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_13g_00
@anm_w * storage=effect_a_00_gunshot_13g_01
@anm_w * storage=effect_a_00_gunshot_13g_02
@anm_w * storage=effect_a_00_gunshot_13g_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_緑
@macro name="effect_b_00_gunshot_13g"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_13g_00
@anm_w * storage=effect_b_00_gunshot_13g_01
@anm_w * storage=effect_b_00_gunshot_13g_02
@anm_w * storage=effect_b_00_gunshot_13g_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン2_青
@macro name="effect_a_00_gunshot_14b"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_14b_00
@anm_w * storage=effect_a_00_gunshot_14b_01
@anm_w * storage=effect_a_00_gunshot_14b_02
@anm_w * storage=effect_a_00_gunshot_14b_03
@anm_w * storage=effect_a_00_gunshot_14b_04
@anm_d * delete=%delete|true
@endmacro

;ボウガン2_青
@macro name="effect_b_00_gunshot_14b"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_14b_00
@anm_w * storage=effect_b_00_gunshot_14b_01
@anm_w * storage=effect_b_00_gunshot_14b_02
@anm_w * storage=effect_b_00_gunshot_14b_03
@anm_w * storage=effect_b_00_gunshot_14b_04
@anm_d * delete=%delete|true
@endmacro

;ボウガン_三連射_白
@macro name="effect_a_00_gunshot_15w"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_15w_00
@anm_w * storage=effect_a_00_gunshot_15w_01
@anm_w * storage=effect_a_00_gunshot_15w_02
@anm_w * storage=effect_a_00_gunshot_15w_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_三連射_白
@macro name="effect_b_00_gunshot_15w"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_15w_00
@anm_w * storage=effect_b_00_gunshot_15w_01
@anm_w * storage=effect_b_00_gunshot_15w_02
@anm_w * storage=effect_b_00_gunshot_15w_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_三連射_赤
@macro name="effect_a_00_gunshot_15r"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_15r_00
@anm_w * storage=effect_a_00_gunshot_15r_01
@anm_w * storage=effect_a_00_gunshot_15r_02
@anm_w * storage=effect_a_00_gunshot_15r_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_三連射_赤
@macro name="effect_b_00_gunshot_15r"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_15r_00
@anm_w * storage=effect_b_00_gunshot_15r_01
@anm_w * storage=effect_b_00_gunshot_15r_02
@anm_w * storage=effect_b_00_gunshot_15r_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_三連射_緑
@macro name="effect_a_00_gunshot_15g"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_15g_00
@anm_w * storage=effect_a_00_gunshot_15g_01
@anm_w * storage=effect_a_00_gunshot_15g_02
@anm_w * storage=effect_a_00_gunshot_15g_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_三連射_緑
@macro name="effect_b_00_gunshot_15g"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_15g_00
@anm_w * storage=effect_b_00_gunshot_15g_01
@anm_w * storage=effect_b_00_gunshot_15g_02
@anm_w * storage=effect_b_00_gunshot_15g_03
@anm_d * delete=%delete|true
@endmacro

;ボウガン_連射_白
@macro name="effect_a_00_gunshot_16w"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_16w_00
@anm_w * storage=effect_a_00_gunshot_16w_01
@anm_w * storage=effect_a_00_gunshot_16w_02
@anm_w * storage=effect_a_00_gunshot_16w_03
@anm_w * storage=effect_a_00_gunshot_16w_04
@anm_w * storage=effect_a_00_gunshot_16w_05
@anm_w * storage=effect_a_00_gunshot_16w_06
@anm_d * delete=%delete|true
@endmacro

;ボウガン_連射_白
@macro name="effect_b_00_gunshot_16w"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_16w_00
@anm_w * storage=effect_b_00_gunshot_16w_01
@anm_w * storage=effect_b_00_gunshot_16w_02
@anm_w * storage=effect_b_00_gunshot_16w_03
@anm_w * storage=effect_b_00_gunshot_16w_04
@anm_w * storage=effect_b_00_gunshot_16w_05
@anm_w * storage=effect_b_00_gunshot_16w_06
@anm_d * delete=%delete|true
@endmacro

;ボウガン_連射_赤
@macro name="effect_a_00_gunshot_16r"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_16r_00
@anm_w * storage=effect_a_00_gunshot_16r_01
@anm_w * storage=effect_a_00_gunshot_16r_02
@anm_w * storage=effect_a_00_gunshot_16r_03
@anm_w * storage=effect_a_00_gunshot_16r_04
@anm_w * storage=effect_a_00_gunshot_16r_05
@anm_w * storage=effect_a_00_gunshot_16r_06
@anm_d * delete=%delete|true
@endmacro

;ボウガン_連射_赤
@macro name="effect_b_00_gunshot_16r"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_16r_00
@anm_w * storage=effect_b_00_gunshot_16r_01
@anm_w * storage=effect_b_00_gunshot_16r_02
@anm_w * storage=effect_b_00_gunshot_16r_03
@anm_w * storage=effect_b_00_gunshot_16r_04
@anm_w * storage=effect_b_00_gunshot_16r_05
@anm_w * storage=effect_b_00_gunshot_16r_06
@anm_d * delete=%delete|true
@endmacro

;ボウガン_連射_緑
@macro name="effect_a_00_gunshot_16g"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_16g_00
@anm_w * storage=effect_a_00_gunshot_16g_01
@anm_w * storage=effect_a_00_gunshot_16g_02
@anm_w * storage=effect_a_00_gunshot_16g_03
@anm_w * storage=effect_a_00_gunshot_16g_04
@anm_w * storage=effect_a_00_gunshot_16g_05
@anm_w * storage=effect_a_00_gunshot_16g_06
@anm_d * delete=%delete|true
@endmacro

;ボウガン_連射_緑
@macro name="effect_b_00_gunshot_16g"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_16g_00
@anm_w * storage=effect_b_00_gunshot_16g_01
@anm_w * storage=effect_b_00_gunshot_16g_02
@anm_w * storage=effect_b_00_gunshot_16g_03
@anm_w * storage=effect_b_00_gunshot_16g_04
@anm_w * storage=effect_b_00_gunshot_16g_05
@anm_w * storage=effect_b_00_gunshot_16g_06
@anm_d * delete=%delete|true
@endmacro

;ボウガン_乱射_青
@macro name="effect_a_00_gunshot_17b"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_17b_00
@anm_w * storage=effect_a_00_gunshot_17b_01
@anm_w * storage=effect_a_00_gunshot_17b_02
@anm_w * storage=effect_a_00_gunshot_17b_03
@anm_w * storage=effect_a_00_gunshot_17b_04
@anm_w * storage=effect_a_00_gunshot_17b_05
@anm_w * storage=effect_a_00_gunshot_17b_06
@anm_w * storage=effect_a_00_gunshot_17b_07
@anm_w * storage=effect_a_00_gunshot_17b_08
@anm_w * storage=effect_a_00_gunshot_17b_09
@anm_w * storage=effect_a_00_gunshot_17b_10
@anm_d * delete=%delete|true
@endmacro

;ボウガン_乱射_青
@macro name="effect_b_00_gunshot_17b"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_17b_00
@anm_w * storage=effect_b_00_gunshot_17b_01
@anm_w * storage=effect_b_00_gunshot_17b_02
@anm_w * storage=effect_b_00_gunshot_17b_03
@anm_w * storage=effect_b_00_gunshot_17b_04
@anm_w * storage=effect_b_00_gunshot_17b_05
@anm_w * storage=effect_b_00_gunshot_17b_06
@anm_w * storage=effect_b_00_gunshot_17b_07
@anm_w * storage=effect_b_00_gunshot_17b_08
@anm_w * storage=effect_b_00_gunshot_17b_09
@anm_w * storage=effect_b_00_gunshot_17b_10
@anm_d * delete=%delete|true
@endmacro

;クナイ_連射_白
@macro name="effect_a_00_gunshot_18w"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_18w_00
@anm_w * storage=effect_a_00_gunshot_18w_01
@anm_w * storage=effect_a_00_gunshot_18w_02
@anm_d * delete=%delete|true
@endmacro

;クナイ_連射_白
@macro name="effect_b_00_gunshot_18w"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_18w_00
@anm_w * storage=effect_b_00_gunshot_18w_01
@anm_w * storage=effect_b_00_gunshot_18w_02
@anm_d * delete=%delete|true
@endmacro

;クナイ_連射_青
@macro name="effect_a_00_gunshot_18b"
@anm_q *
@anm_w * storage=effect_a_00_gunshot_18b_00
@anm_w * storage=effect_a_00_gunshot_18b_01
@anm_w * storage=effect_a_00_gunshot_18b_02
@anm_d * delete=%delete|true
@endmacro

;クナイ_連射_青
@macro name="effect_b_00_gunshot_18b"
@anm_q *
@anm_w * storage=effect_b_00_gunshot_18b_00
@anm_w * storage=effect_b_00_gunshot_18b_01
@anm_w * storage=effect_b_00_gunshot_18b_02
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 血
;############################################################

;下から吹き出し_赤
@macro name="effect_a_01_blood_00r"
@anm_q *
@anm_w * storage=effect_a_01_blood_00r_00
@anm_w * storage=effect_a_01_blood_00r_01
@anm_w * storage=effect_a_01_blood_00r_02
@anm_w * storage=effect_a_01_blood_00r_03
@anm_w * storage=effect_a_01_blood_00r_04
@anm_w * storage=effect_a_01_blood_00r_05
@anm_d * delete=%delete|true
@endmacro

;血しぶき_中央_赤
@macro name="effect_a_00_blood_00r"
@anm_q *
@anm_w * storage=effect_a_00_blood_00r_00
@anm_w * storage=effect_a_00_blood_00r_01
@anm_d * delete=%delete|true
@endmacro

;血しぶき_中央_赤
@macro name="effect_b_00_blood_00r"
@anm_q *
@anm_w * storage=effect_b_00_blood_00r_00
@anm_w * storage=effect_b_00_blood_00r_01
@anm_d * delete=%delete|true
@endmacro

;血しぶき_中央2_赤
@macro name="effect_a_00_blood_01r"
@anm_q *
@anm_w * storage=effect_a_00_blood_01r_00
@anm_w * storage=effect_a_00_blood_01r_01
@anm_d * delete=%delete|true
@endmacro

;血しぶき_中央2_赤
@macro name="effect_b_00_blood_01r"
@anm_q *
@anm_w * storage=effect_b_00_blood_01r_00
@anm_w * storage=effect_b_00_blood_01r_01
@anm_d * delete=%delete|true
@endmacro

;血しぶき_右_赤
@macro name="effect_a_00_blood_02r"
@anm_q *
@anm_w * storage=effect_a_00_blood_02r_00
@anm_w * storage=effect_a_00_blood_02r_01
@anm_w * storage=effect_a_00_blood_02r_02
@anm_d * delete=%delete|true
@endmacro

;血しぶき_右_赤
@macro name="effect_b_00_blood_02r"
@anm_q *
@anm_w * storage=effect_b_00_blood_02r_00
@anm_w * storage=effect_b_00_blood_02r_01
@anm_w * storage=effect_b_00_blood_02r_02
@anm_w * storage=effect_b_00_blood_02r_03
@anm_d * delete=%delete|true
@endmacro

;血しぶき_右2_赤
@macro name="effect_a_00_blood_03r"
@anm_q *
@anm_w * storage=effect_a_00_blood_03r_00
@anm_w * storage=effect_a_00_blood_03r_01
@anm_w * storage=effect_a_00_blood_03r_02
@anm_d * delete=%delete|true
@endmacro

;血しぶき_右2_赤
@macro name="effect_b_00_blood_03r"
@anm_q *
@anm_w * storage=effect_b_00_blood_03r_00
@anm_w * storage=effect_b_00_blood_03r_01
@anm_w * storage=effect_b_00_blood_03r_02
@anm_w * storage=effect_b_00_blood_03r_03
@anm_d * delete=%delete|true
@endmacro

;血滴り_赤
@macro name="effect_a_00_blood_04r"
@anm_q *
@anm_w * storage=effect_a_00_blood_04r_00
@anm_w * storage=effect_a_00_blood_04r_01
@anm_w * storage=effect_a_00_blood_04r_02
@anm_d * delete=%delete|true
@endmacro

;血滴り_赤
@macro name="effect_b_00_blood_04r"
@anm_q *
@anm_w * storage=effect_b_00_blood_04r_00
@anm_w * storage=effect_b_00_blood_04r_01
@anm_w * storage=effect_b_00_blood_04r_02
@anm_d * delete=%delete|true
@endmacro

;血滴り2_赤
@macro name="effect_a_00_blood_05r"
@anm_q *
@anm_w * storage=effect_a_00_blood_05r_00
@anm_w * storage=effect_a_00_blood_05r_01
@anm_w * storage=effect_a_00_blood_05r_02
@anm_d * delete=%delete|true
@endmacro

;血滴り2_赤
@macro name="effect_b_00_blood_05r"
@anm_q *
@anm_w * storage=effect_b_00_blood_05r_00
@anm_w * storage=effect_b_00_blood_05r_01
@anm_w * storage=effect_b_00_blood_05r_02
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 水
;############################################################

;水しぶき小_non
@macro name="effect_a_00_water_00non"
@anm_q *
@anm_w * storage=effect_a_00_water_00non_00
@anm_w * storage=effect_a_00_water_00non_01
@anm_w * storage=effect_a_00_water_00non_02
@anm_w * storage=effect_a_00_water_00non_03
@anm_w * storage=effect_a_00_water_00non_04
@anm_w * storage=effect_a_00_water_00non_05
@anm_w * storage=effect_a_00_water_00non_06
@anm_w * storage=effect_a_00_water_00non_07
@anm_d * delete=%delete|true
@endmacro

;水しぶき小_non
@macro name="effect_b_00_water_00non"
@anm_q *
@anm_w * storage=effect_b_00_water_00non_00
@anm_w * storage=effect_b_00_water_00non_01
@anm_w * storage=effect_b_00_water_00non_02
@anm_w * storage=effect_b_00_water_00non_03
@anm_w * storage=effect_b_00_water_00non_04
@anm_w * storage=effect_b_00_water_00non_05
@anm_w * storage=effect_b_00_water_00non_06
@anm_w * storage=effect_b_00_water_00non_07
@anm_d * delete=%delete|true
@endmacro

;水しぶき中_non
@macro name="effect_a_00_water_01non"
@anm_q *
@anm_w * storage=effect_a_00_water_01non_00
@anm_w * storage=effect_a_00_water_01non_01
@anm_w * storage=effect_a_00_water_01non_02
@anm_w * storage=effect_a_00_water_01non_03
@anm_w * storage=effect_a_00_water_01non_04
@anm_d * delete=%delete|true
@endmacro

;水しぶき中_non
@macro name="effect_b_00_water_01non"
@anm_q *
@anm_w * storage=effect_b_00_water_01non_00
@anm_w * storage=effect_b_00_water_01non_01
@anm_w * storage=effect_b_00_water_01non_02
@anm_w * storage=effect_b_00_water_01non_03
@anm_w * storage=effect_b_00_water_01non_04
@anm_d * delete=%delete|true
@endmacro

;水しぶき大_non
@macro name="effect_a_00_water_02non"
@anm_q *
@anm_w * storage=effect_a_00_water_02non_00
@anm_w * storage=effect_a_00_water_02non_01
@anm_w * storage=effect_a_00_water_02non_02
@anm_w * storage=effect_a_00_water_02non_03
@anm_w * storage=effect_a_00_water_02non_04
@anm_w * storage=effect_a_00_water_02non_05
@anm_w * storage=effect_a_00_water_02non_06
@anm_w * storage=effect_a_00_water_02non_07
@anm_w * storage=effect_a_00_water_02non_08
@anm_w * storage=effect_a_00_water_02non_09
@anm_w * storage=effect_a_00_water_02non_10
@anm_w * storage=effect_a_00_water_02non_11
@anm_d * delete=%delete|true
@endmacro

;水しぶき大_non
@macro name="effect_b_00_water_02non"
@anm_q *
@anm_w * storage=effect_b_00_water_02non_00
@anm_w * storage=effect_b_00_water_02non_01
@anm_w * storage=effect_b_00_water_02non_02
@anm_w * storage=effect_b_00_water_02non_03
@anm_w * storage=effect_b_00_water_02non_04
@anm_w * storage=effect_b_00_water_02non_05
@anm_w * storage=effect_b_00_water_02non_06
@anm_w * storage=effect_b_00_water_02non_07
@anm_w * storage=effect_b_00_water_02non_08
@anm_w * storage=effect_b_00_water_02non_09
@anm_w * storage=effect_b_00_water_02non_10
@anm_w * storage=effect_b_00_water_02non_11
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 炎
;############################################################

;ドラゴン火炎ブレス_赤
@macro name="effect_b_01_fire_00r"
@anm_q *
@anm_w * storage=effect_b_01_fire_00r_00
@anm_w * storage=effect_b_01_fire_00r_01
@anm_w * storage=effect_b_01_fire_00r_02
@anm_w * storage=effect_b_01_fire_00r_03
@anm_w * storage=effect_b_01_fire_00r_04
@anm_w * storage=effect_b_01_fire_00r_05
@anm_w * storage=effect_b_01_fire_00r_06
@anm_w * storage=effect_b_01_fire_00r_07
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 火の粉
;############################################################

;火の粉_赤
@macro name="effect_a_00_firepowder_00r"
@anm_q *
@anm_w * storage=effect_a_00_firepowder_00r_00
@anm_w * storage=effect_a_00_firepowder_00r_01
@anm_w * storage=effect_a_00_firepowder_00r_02
@anm_w * storage=effect_a_00_firepowder_00r_03
@anm_w * storage=effect_a_00_firepowder_00r_04
@anm_w * storage=effect_a_00_firepowder_00r_05
@anm_w * storage=effect_a_00_firepowder_00r_06
@anm_w * storage=effect_a_00_firepowder_00r_07
@anm_w * storage=effect_a_00_firepowder_00r_08
@anm_w * storage=effect_a_00_firepowder_00r_09
@anm_w * storage=effect_a_00_firepowder_00r_10
@anm_w * storage=effect_a_00_firepowder_00r_11
@anm_w * storage=effect_a_00_firepowder_00r_12
@anm_w * storage=effect_a_00_firepowder_00r_13
@anm_w * storage=effect_a_00_firepowder_00r_14
@anm_w * storage=effect_a_00_firepowder_00r_15
@anm_w * storage=effect_a_00_firepowder_00r_16
@anm_w * storage=effect_a_00_firepowder_00r_17
@anm_w * storage=effect_a_00_firepowder_00r_18
@anm_w * storage=effect_a_00_firepowder_00r_19
@anm_w * storage=effect_a_00_firepowder_00r_20
@anm_w * storage=effect_a_00_firepowder_00r_21
@anm_w * storage=effect_a_00_firepowder_00r_22
@anm_w * storage=effect_a_00_firepowder_00r_23
@anm_w * storage=effect_a_00_firepowder_00r_24
@anm_w * storage=effect_a_00_firepowder_00r_25
@anm_w * storage=effect_a_00_firepowder_00r_26
@anm_w * storage=effect_a_00_firepowder_00r_27
@anm_w * storage=effect_a_00_firepowder_00r_28
@anm_w * storage=effect_a_00_firepowder_00r_29
@anm_w * storage=effect_a_00_firepowder_00r_30
@anm_w * storage=effect_a_00_firepowder_00r_31
@anm_w * storage=effect_a_00_firepowder_00r_32
@anm_w * storage=effect_a_00_firepowder_00r_33
@anm_w * storage=effect_a_00_firepowder_00r_34
@anm_w * storage=effect_a_00_firepowder_00r_35
@anm_w * storage=effect_a_00_firepowder_00r_36
@anm_w * storage=effect_a_00_firepowder_00r_37
@anm_w * storage=effect_a_00_firepowder_00r_38
@anm_w * storage=effect_a_00_firepowder_00r_39
@anm_w * storage=effect_a_00_firepowder_00r_40
@anm_w * storage=effect_a_00_firepowder_00r_41
@anm_w * storage=effect_a_00_firepowder_00r_42
@anm_w * storage=effect_a_00_firepowder_00r_43
@anm_w * storage=effect_a_00_firepowder_00r_44
@anm_w * storage=effect_a_00_firepowder_00r_45
@anm_w * storage=effect_a_00_firepowder_00r_46
@anm_w * storage=effect_a_00_firepowder_00r_47
@anm_w * storage=effect_a_00_firepowder_00r_48
@anm_w * storage=effect_a_00_firepowder_00r_49
@anm_w * storage=effect_a_00_firepowder_00r_50
@anm_w * storage=effect_a_00_firepowder_00r_51
@anm_w * storage=effect_a_00_firepowder_00r_52
@anm_w * storage=effect_a_00_firepowder_00r_53
@anm_w * storage=effect_a_00_firepowder_00r_54
@anm_w * storage=effect_a_00_firepowder_00r_55
@anm_w * storage=effect_a_00_firepowder_00r_56
@anm_w * storage=effect_a_00_firepowder_00r_57
@anm_w * storage=effect_a_00_firepowder_00r_58
@anm_w * storage=effect_a_00_firepowder_00r_59
@anm_w * storage=effect_a_00_firepowder_00r_60
@anm_w * storage=effect_a_00_firepowder_00r_61
@anm_w * storage=effect_a_00_firepowder_00r_62
@anm_w * storage=effect_a_00_firepowder_00r_63
@anm_w * storage=effect_a_00_firepowder_00r_64
@anm_w * storage=effect_a_00_firepowder_00r_65
@anm_w * storage=effect_a_00_firepowder_00r_66
@anm_w * storage=effect_a_00_firepowder_00r_67
@anm_w * storage=effect_a_00_firepowder_00r_68
@anm_w * storage=effect_a_00_firepowder_00r_69
@anm_w * storage=effect_a_00_firepowder_00r_70
@anm_w * storage=effect_a_00_firepowder_00r_71
@anm_w * storage=effect_a_00_firepowder_00r_72
@anm_w * storage=effect_a_00_firepowder_00r_73
@anm_d * delete=%delete|true
@endmacro

;火の粉_赤
@macro name="effect_b_00_firepowder_00r"
@anm_q *
@anm_w * storage=effect_b_00_firepowder_00r_00
@anm_w * storage=effect_b_00_firepowder_00r_01
@anm_w * storage=effect_b_00_firepowder_00r_02
@anm_w * storage=effect_b_00_firepowder_00r_03
@anm_w * storage=effect_b_00_firepowder_00r_04
@anm_w * storage=effect_b_00_firepowder_00r_05
@anm_w * storage=effect_b_00_firepowder_00r_06
@anm_w * storage=effect_b_00_firepowder_00r_07
@anm_w * storage=effect_b_00_firepowder_00r_08
@anm_w * storage=effect_b_00_firepowder_00r_09
@anm_w * storage=effect_b_00_firepowder_00r_10
@anm_w * storage=effect_b_00_firepowder_00r_11
@anm_w * storage=effect_b_00_firepowder_00r_12
@anm_w * storage=effect_b_00_firepowder_00r_13
@anm_w * storage=effect_b_00_firepowder_00r_14
@anm_w * storage=effect_b_00_firepowder_00r_15
@anm_w * storage=effect_b_00_firepowder_00r_16
@anm_w * storage=effect_b_00_firepowder_00r_17
@anm_w * storage=effect_b_00_firepowder_00r_18
@anm_w * storage=effect_b_00_firepowder_00r_19
@anm_w * storage=effect_b_00_firepowder_00r_20
@anm_w * storage=effect_b_00_firepowder_00r_21
@anm_w * storage=effect_b_00_firepowder_00r_22
@anm_w * storage=effect_b_00_firepowder_00r_23
@anm_w * storage=effect_b_00_firepowder_00r_24
@anm_w * storage=effect_b_00_firepowder_00r_25
@anm_w * storage=effect_b_00_firepowder_00r_26
@anm_w * storage=effect_b_00_firepowder_00r_27
@anm_w * storage=effect_b_00_firepowder_00r_28
@anm_w * storage=effect_b_00_firepowder_00r_29
@anm_w * storage=effect_b_00_firepowder_00r_30
@anm_w * storage=effect_b_00_firepowder_00r_31
@anm_w * storage=effect_b_00_firepowder_00r_32
@anm_w * storage=effect_b_00_firepowder_00r_33
@anm_w * storage=effect_b_00_firepowder_00r_34
@anm_w * storage=effect_b_00_firepowder_00r_35
@anm_w * storage=effect_b_00_firepowder_00r_36
@anm_w * storage=effect_b_00_firepowder_00r_37
@anm_w * storage=effect_b_00_firepowder_00r_38
@anm_w * storage=effect_b_00_firepowder_00r_39
@anm_w * storage=effect_b_00_firepowder_00r_40
@anm_w * storage=effect_b_00_firepowder_00r_41
@anm_w * storage=effect_b_00_firepowder_00r_42
@anm_w * storage=effect_b_00_firepowder_00r_43
@anm_w * storage=effect_b_00_firepowder_00r_44
@anm_w * storage=effect_b_00_firepowder_00r_45
@anm_w * storage=effect_b_00_firepowder_00r_46
@anm_w * storage=effect_b_00_firepowder_00r_47
@anm_w * storage=effect_b_00_firepowder_00r_48
@anm_w * storage=effect_b_00_firepowder_00r_49
@anm_w * storage=effect_b_00_firepowder_00r_50
@anm_w * storage=effect_b_00_firepowder_00r_51
@anm_w * storage=effect_b_00_firepowder_00r_52
@anm_w * storage=effect_b_00_firepowder_00r_53
@anm_w * storage=effect_b_00_firepowder_00r_54
@anm_w * storage=effect_b_00_firepowder_00r_55
@anm_w * storage=effect_b_00_firepowder_00r_56
@anm_w * storage=effect_b_00_firepowder_00r_57
@anm_w * storage=effect_b_00_firepowder_00r_58
@anm_w * storage=effect_b_00_firepowder_00r_59
@anm_w * storage=effect_b_00_firepowder_00r_60
@anm_w * storage=effect_b_00_firepowder_00r_61
@anm_w * storage=effect_b_00_firepowder_00r_62
@anm_w * storage=effect_b_00_firepowder_00r_63
@anm_w * storage=effect_b_00_firepowder_00r_64
@anm_w * storage=effect_b_00_firepowder_00r_65
@anm_w * storage=effect_b_00_firepowder_00r_66
@anm_w * storage=effect_b_00_firepowder_00r_67
@anm_w * storage=effect_b_00_firepowder_00r_68
@anm_w * storage=effect_b_00_firepowder_00r_69
@anm_w * storage=effect_b_00_firepowder_00r_70
@anm_w * storage=effect_b_00_firepowder_00r_71
@anm_w * storage=effect_b_00_firepowder_00r_72
@anm_w * storage=effect_b_00_firepowder_00r_73
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 火花
;############################################################

;火花中央・小_non
@macro name="effect_a_00_spark_00non"
@anm_q *
@anm_w * storage=effect_a_00_spark_00non_00
@anm_w * storage=effect_a_00_spark_00non_01
@anm_w * storage=effect_a_00_spark_00non_02
@anm_w * storage=effect_a_00_spark_00non_03
@anm_d * delete=%delete|true
@endmacro

;火花中央・小_non
@macro name="effect_b_00_spark_00non"
@anm_q *
@anm_w * storage=effect_b_00_spark_00non_00
@anm_w * storage=effect_b_00_spark_00non_01
@anm_w * storage=effect_b_00_spark_00non_02
@anm_w * storage=effect_b_00_spark_00non_03
@anm_d * delete=%delete|true
@endmacro

;火花中央・中_non
@macro name="effect_a_00_spark_01non"
@anm_q *
@anm_w * storage=effect_a_00_spark_01non_00
@anm_w * storage=effect_a_00_spark_01non_01
@anm_w * storage=effect_a_00_spark_01non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央・中_non
@macro name="effect_b_00_spark_01non"
@anm_q *
@anm_w * storage=effect_b_00_spark_01non_00
@anm_w * storage=effect_b_00_spark_01non_01
@anm_w * storage=effect_b_00_spark_01non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央・大_non
@macro name="effect_a_00_spark_02non"
@anm_q *
@anm_w * storage=effect_a_00_spark_02non_00
@anm_w * storage=effect_a_00_spark_02non_01
@anm_w * storage=effect_a_00_spark_02non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央・大_non
@macro name="effect_b_00_spark_02non"
@anm_q *
@anm_w * storage=effect_b_00_spark_02non_00
@anm_w * storage=effect_b_00_spark_02non_01
@anm_w * storage=effect_b_00_spark_02non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央2・小_non
@macro name="effect_a_00_spark_03non"
@anm_q *
@anm_w * storage=effect_a_00_spark_03non_00
@anm_w * storage=effect_a_00_spark_03non_01
@anm_w * storage=effect_a_00_spark_03non_02
@anm_w * storage=effect_a_00_spark_03non_03
@anm_d * delete=%delete|true
@endmacro

;火花中央2・小_non
@macro name="effect_b_00_spark_03non"
@anm_q *
@anm_w * storage=effect_b_00_spark_03non_00
@anm_w * storage=effect_b_00_spark_03non_01
@anm_w * storage=effect_b_00_spark_03non_02
@anm_w * storage=effect_b_00_spark_03non_03
@anm_d * delete=%delete|true
@endmacro

;火花中央2・中_non
@macro name="effect_a_00_spark_04non"
@anm_q *
@anm_w * storage=effect_a_00_spark_04non_00
@anm_w * storage=effect_a_00_spark_04non_01
@anm_w * storage=effect_a_00_spark_04non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央2・中_non
@macro name="effect_b_00_spark_04non"
@anm_q *
@anm_w * storage=effect_b_00_spark_04non_00
@anm_w * storage=effect_b_00_spark_04non_01
@anm_w * storage=effect_b_00_spark_04non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央2・大_non
@macro name="effect_a_00_spark_05non"
@anm_q *
@anm_w * storage=effect_a_00_spark_05non_00
@anm_w * storage=effect_a_00_spark_05non_01
@anm_w * storage=effect_a_00_spark_05non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央2・大_non
@macro name="effect_b_00_spark_05non"
@anm_q *
@anm_w * storage=effect_b_00_spark_05non_00
@anm_w * storage=effect_b_00_spark_05non_01
@anm_w * storage=effect_b_00_spark_05non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央3・小_non
@macro name="effect_a_00_spark_06non"
@anm_q *
@anm_w * storage=effect_a_00_spark_06non_00
@anm_w * storage=effect_a_00_spark_06non_01
@anm_w * storage=effect_a_00_spark_06non_02
@anm_w * storage=effect_a_00_spark_06non_03
@anm_d * delete=%delete|true
@endmacro

;火花中央3・小_non
@macro name="effect_b_00_spark_06non"
@anm_q *
@anm_w * storage=effect_b_00_spark_06non_00
@anm_w * storage=effect_b_00_spark_06non_01
@anm_w * storage=effect_b_00_spark_06non_02
@anm_w * storage=effect_b_00_spark_06non_03
@anm_d * delete=%delete|true
@endmacro

;火花中央3・中_non
@macro name="effect_a_00_spark_07non"
@anm_q *
@anm_w * storage=effect_a_00_spark_07non_00
@anm_w * storage=effect_a_00_spark_07non_01
@anm_w * storage=effect_a_00_spark_07non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央3・中_non
@macro name="effect_b_00_spark_07non"
@anm_q *
@anm_w * storage=effect_b_00_spark_07non_00
@anm_w * storage=effect_b_00_spark_07non_01
@anm_w * storage=effect_b_00_spark_07non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央3・大_non
@macro name="effect_a_00_spark_08non"
@anm_q *
@anm_w * storage=effect_a_00_spark_08non_00
@anm_w * storage=effect_a_00_spark_08non_01
@anm_w * storage=effect_a_00_spark_08non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央3・大_non
@macro name="effect_b_00_spark_08non"
@anm_q *
@anm_w * storage=effect_b_00_spark_08non_00
@anm_w * storage=effect_b_00_spark_08non_01
@anm_w * storage=effect_b_00_spark_08non_02
@anm_d * delete=%delete|true
@endmacro

;火花中央4・大_黒
@macro name="effect_a_00_spark_09k"
@anm_q *
@anm_w * storage=effect_a_00_spark_09k_00
@anm_w * storage=effect_a_00_spark_09k_01
@anm_w * storage=effect_a_00_spark_09k_02
@anm_d * delete=%delete|true
@endmacro

;火花中央4・中_黒
@macro name="effect_b_00_spark_09k"
@anm_q *
@anm_w * storage=effect_b_00_spark_09k_00
@anm_w * storage=effect_b_00_spark_09k_01
@anm_w * storage=effect_b_00_spark_09k_02
@anm_d * delete=%delete|true
@endmacro

;火花左下・小_non
@macro name="effect_a_00_spark_10non"
@anm_q *
@anm_w * storage=effect_a_00_spark_10non_00
@anm_w * storage=effect_a_00_spark_10non_01
@anm_w * storage=effect_a_00_spark_10non_02
@anm_w * storage=effect_a_00_spark_10non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下・小_non
@macro name="effect_b_00_spark_10non"
@anm_q *
@anm_w * storage=effect_b_00_spark_10non_00
@anm_w * storage=effect_b_00_spark_10non_01
@anm_w * storage=effect_b_00_spark_10non_02
@anm_w * storage=effect_b_00_spark_10non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下・中_non
@macro name="effect_a_00_spark_11non"
@anm_q *
@anm_w * storage=effect_a_00_spark_11non_00
@anm_w * storage=effect_a_00_spark_11non_01
@anm_w * storage=effect_a_00_spark_11non_02
@anm_w * storage=effect_a_00_spark_11non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下・中_non
@macro name="effect_b_00_spark_11non"
@anm_q *
@anm_w * storage=effect_b_00_spark_11non_00
@anm_w * storage=effect_b_00_spark_11non_01
@anm_w * storage=effect_b_00_spark_11non_02
@anm_w * storage=effect_b_00_spark_11non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下・大_non
@macro name="effect_a_00_spark_12non"
@anm_q *
@anm_w * storage=effect_a_00_spark_12non_00
@anm_w * storage=effect_a_00_spark_12non_01
@anm_w * storage=effect_a_00_spark_12non_02
@anm_w * storage=effect_a_00_spark_12non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下・大_non
@macro name="effect_b_00_spark_12non"
@anm_q *
@anm_w * storage=effect_b_00_spark_12non_00
@anm_w * storage=effect_b_00_spark_12non_01
@anm_w * storage=effect_b_00_spark_12non_02
@anm_w * storage=effect_b_00_spark_12non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下2・小_non
@macro name="effect_a_00_spark_13non"
@anm_q *
@anm_w * storage=effect_a_00_spark_13non_00
@anm_w * storage=effect_a_00_spark_13non_01
@anm_w * storage=effect_a_00_spark_13non_02
@anm_w * storage=effect_a_00_spark_13non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下2・小_non
@macro name="effect_b_00_spark_13non"
@anm_q *
@anm_w * storage=effect_b_00_spark_13non_00
@anm_w * storage=effect_b_00_spark_13non_01
@anm_w * storage=effect_b_00_spark_13non_02
@anm_w * storage=effect_b_00_spark_13non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下2・中_non
@macro name="effect_a_00_spark_14non"
@anm_q *
@anm_w * storage=effect_a_00_spark_14non_00
@anm_w * storage=effect_a_00_spark_14non_01
@anm_w * storage=effect_a_00_spark_14non_02
@anm_w * storage=effect_a_00_spark_14non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下2・中_non
@macro name="effect_b_00_spark_14non"
@anm_q *
@anm_w * storage=effect_b_00_spark_14non_00
@anm_w * storage=effect_b_00_spark_14non_01
@anm_w * storage=effect_b_00_spark_14non_02
@anm_w * storage=effect_b_00_spark_14non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下2・大_non
@macro name="effect_a_00_spark_15non"
@anm_q *
@anm_w * storage=effect_a_00_spark_15non_00
@anm_w * storage=effect_a_00_spark_15non_01
@anm_w * storage=effect_a_00_spark_15non_02
@anm_w * storage=effect_a_00_spark_15non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下2・大_non
@macro name="effect_b_00_spark_15non"
@anm_q *
@anm_w * storage=effect_b_00_spark_15non_00
@anm_w * storage=effect_b_00_spark_15non_01
@anm_w * storage=effect_b_00_spark_15non_02
@anm_w * storage=effect_b_00_spark_15non_03
@anm_d * delete=%delete|true
@endmacro

;火花左下3・小_non
@macro name="effect_a_00_spark_16non"
@anm_q *
@anm_w * storage=effect_a_00_spark_16non_00
@anm_w * storage=effect_a_00_spark_16non_01
@anm_w * storage=effect_a_00_spark_16non_02
@anm_d * delete=%delete|true
@endmacro

;火花左下3・小_non
@macro name="effect_b_00_spark_16non"
@anm_q *
@anm_w * storage=effect_b_00_spark_16non_00
@anm_w * storage=effect_b_00_spark_16non_01
@anm_w * storage=effect_b_00_spark_16non_02
@anm_d * delete=%delete|true
@endmacro

;火花左下3・中_non
@macro name="effect_a_00_spark_17non"
@anm_q *
@anm_w * storage=effect_a_00_spark_17non_00
@anm_w * storage=effect_a_00_spark_17non_01
@anm_w * storage=effect_a_00_spark_17non_02
@anm_d * delete=%delete|true
@endmacro

;火花左下3・中_non
@macro name="effect_b_00_spark_17non"
@anm_q *
@anm_w * storage=effect_b_00_spark_17non_00
@anm_w * storage=effect_b_00_spark_17non_01
@anm_w * storage=effect_b_00_spark_17non_02
@anm_d * delete=%delete|true
@endmacro

;火花左下3・大_non
@macro name="effect_a_00_spark_18non"
@anm_q *
@anm_w * storage=effect_a_00_spark_18non_00
@anm_w * storage=effect_a_00_spark_18non_01
@anm_w * storage=effect_a_00_spark_18non_02
@anm_d * delete=%delete|true
@endmacro

;火花左下3・大_non
@macro name="effect_b_00_spark_18non"
@anm_q *
@anm_w * storage=effect_b_00_spark_18non_00
@anm_w * storage=effect_b_00_spark_18non_01
@anm_w * storage=effect_b_00_spark_18non_02
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 爆発
;############################################################

;爆発_中_赤
@macro name="effect_a_00_explosion_00r"
@anm_q *
@anm_w * storage=effect_a_00_explosion_00r_00
@anm_w * storage=effect_a_00_explosion_00r_01
@anm_w * storage=effect_a_00_explosion_00r_02
@anm_w * storage=effect_a_00_explosion_00r_03
@anm_w * storage=effect_a_00_explosion_00r_04
@anm_d * delete=%delete|true
@endmacro

;爆発_中_赤
@macro name="effect_b_00_explosion_00r"
@anm_q *
@anm_w * storage=effect_b_00_explosion_00r_00
@anm_w * storage=effect_b_00_explosion_00r_01
@anm_w * storage=effect_b_00_explosion_00r_02
@anm_w * storage=effect_b_00_explosion_00r_03
@anm_w * storage=effect_b_00_explosion_00r_04
@anm_d * delete=%delete|true
@endmacro

;爆発_大_赤
@macro name="effect_a_00_explosion_01r"
@anm_q *
@anm_w * storage=effect_a_00_explosion_01r_00
@anm_w * storage=effect_a_00_explosion_01r_01
@anm_w * storage=effect_a_00_explosion_01r_02
@anm_w * storage=effect_a_00_explosion_01r_03
@anm_w * storage=effect_a_00_explosion_01r_04
@anm_d * delete=%delete|true
@endmacro

;爆発_大_赤
@macro name="effect_b_00_explosion_01r"
@anm_q *
@anm_w * storage=effect_b_00_explosion_01r_00
@anm_w * storage=effect_b_00_explosion_01r_01
@anm_w * storage=effect_b_00_explosion_01r_02
@anm_w * storage=effect_b_00_explosion_01r_03
@anm_w * storage=effect_b_00_explosion_01r_04
@anm_w * storage=effect_b_00_explosion_01r_05
@anm_d * delete=%delete|true
@endmacro

;爆発_中_赤
@macro name="effect_a_00_explosion_02r"
@anm_q *
@anm_w * storage=effect_a_00_explosion_02r_00
@anm_w * storage=effect_a_00_explosion_02r_01
@anm_w * storage=effect_a_00_explosion_02r_02
@anm_w * storage=effect_a_00_explosion_02r_03
@anm_w * storage=effect_a_00_explosion_02r_04
@anm_d * delete=%delete|true
@endmacro

;爆発_中_赤
@macro name="effect_b_00_explosion_02r"
@anm_q *
@anm_w * storage=effect_b_00_explosion_02r_00
@anm_w * storage=effect_b_00_explosion_02r_01
@anm_w * storage=effect_b_00_explosion_02r_02
@anm_w * storage=effect_b_00_explosion_02r_03
@anm_w * storage=effect_b_00_explosion_02r_04
@anm_w * storage=effect_b_00_explosion_02r_05
@anm_d * delete=%delete|true
@endmacro

;爆発_大_赤
@macro name="effect_a_00_explosion_03r"
@anm_q *
@anm_w * storage=effect_a_00_explosion_03r_00
@anm_w * storage=effect_a_00_explosion_03r_01
@anm_w * storage=effect_a_00_explosion_03r_02
@anm_w * storage=effect_a_00_explosion_03r_03
@anm_d * delete=%delete|true
@endmacro

;爆発_大_赤
@macro name="effect_b_00_explosion_03r"
@anm_q *
@anm_w * storage=effect_b_00_explosion_03r_00
@anm_w * storage=effect_b_00_explosion_03r_01
@anm_w * storage=effect_b_00_explosion_03r_02
@anm_w * storage=effect_b_00_explosion_03r_03
@anm_d * delete=%delete|true
@endmacro

;爆発_特大_黄色
@macro name="effect_a_00_explosion_04y"
@anm_q *
@anm_w * storage=effect_a_00_explosion_04y_00
@anm_w * storage=effect_a_00_explosion_04y_01
@anm_w * storage=effect_a_00_explosion_04y_02
@anm_w * storage=effect_a_00_explosion_04y_03
@anm_w * storage=effect_a_00_explosion_04y_04
@anm_w * storage=effect_a_00_explosion_04y_05
@anm_w * storage=effect_a_00_explosion_04y_06
@anm_w * storage=effect_a_00_explosion_04y_07
@anm_w * storage=effect_a_00_explosion_04y_08
@anm_d * delete=%delete|true
@endmacro

;爆発_特大_黄色
@macro name="effect_b_00_explosion_04y"
@anm_q *
@anm_w * storage=effect_b_00_explosion_04y_00
@anm_w * storage=effect_b_00_explosion_04y_01
@anm_w * storage=effect_b_00_explosion_04y_02
@anm_w * storage=effect_b_00_explosion_04y_03
@anm_w * storage=effect_b_00_explosion_04y_04
@anm_w * storage=effect_b_00_explosion_04y_05
@anm_w * storage=effect_b_00_explosion_04y_06
@anm_w * storage=effect_b_00_explosion_04y_07
@anm_w * storage=effect_b_00_explosion_04y_08
@anm_d * delete=%delete|true
@endmacro

;爆発2_特大_黄色
@macro name="effect_a_00_explosion_05y"
@anm_q *
@anm_w * storage=effect_a_00_explosion_05y_00
@anm_w * storage=effect_a_00_explosion_05y_01
@anm_w * storage=effect_a_00_explosion_05y_02
@anm_w * storage=effect_a_00_explosion_05y_03
@anm_d * delete=%delete|true
@endmacro

;爆発2_特大_黄色
@macro name="effect_b_00_explosion_05y"
@anm_q *
@anm_w * storage=effect_b_00_explosion_05y_00
@anm_w * storage=effect_b_00_explosion_05y_01
@anm_w * storage=effect_b_00_explosion_05y_02
@anm_w * storage=effect_b_00_explosion_05y_03
@anm_d * delete=%delete|true
@endmacro

;爆発3_non
@macro name="effect_a_00_explosion_06non"
@anm_q *
@anm_w * storage=effect_a_00_explosion_06non_00
@anm_w * storage=effect_a_00_explosion_06non_01
@anm_w * storage=effect_a_00_explosion_06non_02
@anm_w * storage=effect_a_00_explosion_06non_03
@anm_w * storage=effect_a_00_explosion_06non_04
@anm_w * storage=effect_a_00_explosion_06non_05
@anm_w * storage=effect_a_00_explosion_06non_06
@anm_w * storage=effect_a_00_explosion_06non_07
@anm_w * storage=effect_a_00_explosion_06non_08
@anm_w * storage=effect_a_00_explosion_06non_09
@anm_d * delete=%delete|true
@endmacro

;爆発3_non
@macro name="effect_b_00_explosion_06non"
@anm_q *
@anm_w * storage=effect_b_00_explosion_06non_00
@anm_w * storage=effect_b_00_explosion_06non_01
@anm_w * storage=effect_b_00_explosion_06non_02
@anm_w * storage=effect_b_00_explosion_06non_03
@anm_w * storage=effect_b_00_explosion_06non_04
@anm_w * storage=effect_b_00_explosion_06non_05
@anm_w * storage=effect_b_00_explosion_06non_06
@anm_w * storage=effect_b_00_explosion_06non_07
@anm_w * storage=effect_b_00_explosion_06non_08
@anm_w * storage=effect_b_00_explosion_06non_09
@anm_d * delete=%delete|true
@endmacro

;爆発_打ち落とし_non
@macro name="effect_a_00_explosion_07non"
@anm_q *
@anm_w * storage=effect_a_00_explosion_07non_00
@anm_w * storage=effect_a_00_explosion_07non_01
@anm_w * storage=effect_a_00_explosion_07non_02
@anm_w * storage=effect_a_00_explosion_07non_03
@anm_w * storage=effect_a_00_explosion_07non_04
@anm_w * storage=effect_a_00_explosion_07non_05
@anm_w * storage=effect_a_00_explosion_07non_06
@anm_w * storage=effect_a_00_explosion_07non_07
@anm_w * storage=effect_a_00_explosion_07non_08
@anm_w * storage=effect_a_00_explosion_07non_09
@anm_d * delete=%delete|true
@endmacro

;爆発_打ち落とし_non
@macro name="effect_b_00_explosion_07non"
@anm_q *
@anm_w * storage=effect_b_00_explosion_07non_00
@anm_w * storage=effect_b_00_explosion_07non_01
@anm_w * storage=effect_b_00_explosion_07non_02
@anm_w * storage=effect_b_00_explosion_07non_03
@anm_w * storage=effect_b_00_explosion_07non_04
@anm_w * storage=effect_b_00_explosion_07non_05
@anm_w * storage=effect_b_00_explosion_07non_06
@anm_w * storage=effect_b_00_explosion_07non_07
@anm_w * storage=effect_b_00_explosion_07non_08
@anm_w * storage=effect_b_00_explosion_07non_09
@anm_d * delete=%delete|true
@endmacro

;爆発_きのこ雲_non
@macro name="effect_a_00_explosion_08non"
@anm_q *
@anm_w * storage=effect_a_00_explosion_08non_00
@anm_w * storage=effect_a_00_explosion_08non_01
@anm_w * storage=effect_a_00_explosion_08non_02
@anm_w * storage=effect_a_00_explosion_08non_03
@anm_w * storage=effect_a_00_explosion_08non_04
@anm_w * storage=effect_a_00_explosion_08non_05
@anm_w * storage=effect_a_00_explosion_08non_06
@anm_w * storage=effect_a_00_explosion_08non_07
@anm_w * storage=effect_a_00_explosion_08non_08
@anm_w * storage=effect_a_00_explosion_08non_09
@anm_w * storage=effect_a_00_explosion_08non_10
@anm_w * storage=effect_a_00_explosion_08non_11
@anm_w * storage=effect_a_00_explosion_08non_12
@anm_d * delete=%delete|true
@endmacro

;爆発_きのこ雲_non
@macro name="effect_b_00_explosion_08non"
@anm_q *
@anm_w * storage=effect_b_00_explosion_08non_00
@anm_w * storage=effect_b_00_explosion_08non_01
@anm_w * storage=effect_b_00_explosion_08non_02
@anm_w * storage=effect_b_00_explosion_08non_03
@anm_w * storage=effect_b_00_explosion_08non_04
@anm_w * storage=effect_b_00_explosion_08non_05
@anm_w * storage=effect_b_00_explosion_08non_06
@anm_w * storage=effect_b_00_explosion_08non_07
@anm_w * storage=effect_b_00_explosion_08non_08
@anm_w * storage=effect_b_00_explosion_08non_09
@anm_w * storage=effect_b_00_explosion_08non_10
@anm_w * storage=effect_b_00_explosion_08non_11
@anm_w * storage=effect_b_00_explosion_08non_12
@anm_d * delete=%delete|true
@endmacro

;爆発_連鎖(4回)_non
@macro name="effect_a_00_explosion_09non"
@anm_q *
@anm_w * storage=effect_a_00_explosion_09non_00
@anm_w * storage=effect_a_00_explosion_09non_01
@anm_w * storage=effect_a_00_explosion_09non_02
@anm_w * storage=effect_a_00_explosion_09non_03
@anm_w * storage=effect_a_00_explosion_09non_04
@anm_w * storage=effect_a_00_explosion_09non_05
@anm_w * storage=effect_a_00_explosion_09non_06
@anm_w * storage=effect_a_00_explosion_09non_07
@anm_w * storage=effect_a_00_explosion_09non_08
@anm_w * storage=effect_a_00_explosion_09non_09
@anm_w * storage=effect_a_00_explosion_09non_10
@anm_w * storage=effect_a_00_explosion_09non_11
@anm_w * storage=effect_a_00_explosion_09non_12
@anm_w * storage=effect_a_00_explosion_09non_13
@anm_w * storage=effect_a_00_explosion_09non_14
@anm_w * storage=effect_a_00_explosion_09non_15
@anm_w * storage=effect_a_00_explosion_09non_16
@anm_w * storage=effect_a_00_explosion_09non_17
@anm_w * storage=effect_a_00_explosion_09non_18
@anm_w * storage=effect_a_00_explosion_09non_19
@anm_w * storage=effect_a_00_explosion_09non_20
@anm_w * storage=effect_a_00_explosion_09non_21
@anm_w * storage=effect_a_00_explosion_09non_22
@anm_w * storage=effect_a_00_explosion_09non_23
@anm_w * storage=effect_a_00_explosion_09non_24
@anm_w * storage=effect_a_00_explosion_09non_25
@anm_w * storage=effect_a_00_explosion_09non_26
@anm_w * storage=effect_a_00_explosion_09non_27
@anm_w * storage=effect_a_00_explosion_09non_28
@anm_w * storage=effect_a_00_explosion_09non_29
@anm_w * storage=effect_a_00_explosion_09non_30
@anm_w * storage=effect_a_00_explosion_09non_31
@anm_w * storage=effect_a_00_explosion_09non_32
@anm_w * storage=effect_a_00_explosion_09non_33
@anm_w * storage=effect_a_00_explosion_09non_34
@anm_w * storage=effect_a_00_explosion_09non_35
@anm_w * storage=effect_a_00_explosion_09non_36
@anm_w * storage=effect_a_00_explosion_09non_37
@anm_w * storage=effect_a_00_explosion_09non_38
@anm_w * storage=effect_a_00_explosion_09non_39
@anm_d * delete=%delete|true
@endmacro

;爆発_連鎖(4回)_non
@macro name="effect_b_00_explosion_09non"
@anm_q *
@anm_w * storage=effect_b_00_explosion_09non_00
@anm_w * storage=effect_b_00_explosion_09non_01
@anm_w * storage=effect_b_00_explosion_09non_02
@anm_w * storage=effect_b_00_explosion_09non_03
@anm_w * storage=effect_b_00_explosion_09non_04
@anm_w * storage=effect_b_00_explosion_09non_05
@anm_w * storage=effect_b_00_explosion_09non_06
@anm_w * storage=effect_b_00_explosion_09non_07
@anm_w * storage=effect_b_00_explosion_09non_08
@anm_w * storage=effect_b_00_explosion_09non_09
@anm_w * storage=effect_b_00_explosion_09non_10
@anm_w * storage=effect_b_00_explosion_09non_11
@anm_w * storage=effect_b_00_explosion_09non_12
@anm_w * storage=effect_b_00_explosion_09non_13
@anm_w * storage=effect_b_00_explosion_09non_14
@anm_w * storage=effect_b_00_explosion_09non_15
@anm_w * storage=effect_b_00_explosion_09non_16
@anm_w * storage=effect_b_00_explosion_09non_17
@anm_w * storage=effect_b_00_explosion_09non_18
@anm_w * storage=effect_b_00_explosion_09non_19
@anm_w * storage=effect_b_00_explosion_09non_20
@anm_w * storage=effect_b_00_explosion_09non_21
@anm_w * storage=effect_b_00_explosion_09non_22
@anm_w * storage=effect_b_00_explosion_09non_23
@anm_w * storage=effect_b_00_explosion_09non_24
@anm_w * storage=effect_b_00_explosion_09non_25
@anm_w * storage=effect_b_00_explosion_09non_26
@anm_w * storage=effect_b_00_explosion_09non_27
@anm_w * storage=effect_b_00_explosion_09non_28
@anm_w * storage=effect_b_00_explosion_09non_29
@anm_w * storage=effect_b_00_explosion_09non_30
@anm_w * storage=effect_b_00_explosion_09non_31
@anm_w * storage=effect_b_00_explosion_09non_32
@anm_w * storage=effect_b_00_explosion_09non_33
@anm_w * storage=effect_b_00_explosion_09non_34
@anm_w * storage=effect_b_00_explosion_09non_35
@anm_w * storage=effect_b_00_explosion_09non_36
@anm_w * storage=effect_b_00_explosion_09non_37
@anm_w * storage=effect_b_00_explosion_09non_38
@anm_w * storage=effect_b_00_explosion_09non_39
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 破壊
;############################################################

;壁砕き_non
@macro name="effect_a_00_destroy_00non"
@anm_q *
@anm_w * storage=effect_a_00_destroy_00non_00
@anm_w * storage=effect_a_00_destroy_00non_01
@anm_w * storage=effect_a_00_destroy_00non_02
@anm_w * storage=effect_a_00_destroy_00non_03
@anm_w * storage=effect_a_00_destroy_00non_04
@anm_w * storage=effect_a_00_destroy_00non_05
@anm_w * storage=effect_a_00_destroy_00non_06
@anm_w * storage=effect_a_00_destroy_00non_07
@anm_w * storage=effect_a_00_destroy_00non_08
@anm_w * storage=effect_a_00_destroy_00non_09
@anm_w * storage=effect_a_00_destroy_00non_10
@anm_w * storage=effect_a_00_destroy_00non_11
@anm_w * storage=effect_a_00_destroy_00non_12
@anm_d * delete=%delete|true
@endmacro

;壁砕き_non
@macro name="effect_b_00_destroy_00non"
@anm_q *
@anm_w * storage=effect_b_00_destroy_00non_00
@anm_w * storage=effect_b_00_destroy_00non_01
@anm_w * storage=effect_b_00_destroy_00non_02
@anm_w * storage=effect_b_00_destroy_00non_03
@anm_w * storage=effect_b_00_destroy_00non_04
@anm_w * storage=effect_b_00_destroy_00non_05
@anm_w * storage=effect_b_00_destroy_00non_06
@anm_w * storage=effect_b_00_destroy_00non_07
@anm_w * storage=effect_b_00_destroy_00non_08
@anm_w * storage=effect_b_00_destroy_00non_09
@anm_w * storage=effect_b_00_destroy_00non_10
@anm_w * storage=effect_b_00_destroy_00non_11
@anm_w * storage=effect_b_00_destroy_00non_12
@anm_d * delete=%delete|true
@endmacro

;アエリアル_天井ドーム割れ_non
@macro name="effect_a_00_destroy_01non"
@anm_q *
@anm_w * storage=effect_a_00_destroy_01non_00
@anm_w * storage=effect_a_00_destroy_01non_01
@anm_w * storage=effect_a_00_destroy_01non_02
@anm_w * storage=effect_a_00_destroy_01non_03
@anm_w * storage=effect_a_00_destroy_01non_04
@anm_w * storage=effect_a_00_destroy_01non_05
@anm_w * storage=effect_a_00_destroy_01non_06
@anm_w * storage=effect_a_00_destroy_01non_07
@anm_w * storage=effect_a_00_destroy_01non_08
@anm_w * storage=effect_a_00_destroy_01non_09
@anm_w * storage=effect_a_00_destroy_01non_10
@anm_d * delete=%delete|true
@endmacro

;アエリアル_天井ドーム割れ_non
@macro name="effect_b_00_destroy_01non"
@anm_q *
@anm_w * storage=effect_b_00_destroy_01non_00
@anm_w * storage=effect_b_00_destroy_01non_01
@anm_w * storage=effect_b_00_destroy_01non_02
@anm_w * storage=effect_b_00_destroy_01non_03
@anm_w * storage=effect_b_00_destroy_01non_04
@anm_w * storage=effect_b_00_destroy_01non_05
@anm_w * storage=effect_b_00_destroy_01non_06
@anm_w * storage=effect_b_00_destroy_01non_07
@anm_w * storage=effect_b_00_destroy_01non_08
@anm_w * storage=effect_b_00_destroy_01non_09
@anm_w * storage=effect_b_00_destroy_01non_10
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 兵器
;############################################################

;戦艦ミサイル_non
@macro name="effect_a_00_weapon_00non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_00non_00
@anm_w * storage=effect_a_00_weapon_00non_01
@anm_w * storage=effect_a_00_weapon_00non_02
@anm_w * storage=effect_a_00_weapon_00non_03
@anm_w * storage=effect_a_00_weapon_00non_04
@anm_w * storage=effect_a_00_weapon_00non_05
@anm_w * storage=effect_a_00_weapon_00non_06
@anm_w * storage=effect_a_00_weapon_00non_07
@anm_w * storage=effect_a_00_weapon_00non_08
@anm_w * storage=effect_a_00_weapon_00non_09
@anm_w * storage=effect_a_00_weapon_00non_10
@anm_w * storage=effect_a_00_weapon_00non_11
@anm_w * storage=effect_a_00_weapon_00non_12
@anm_w * storage=effect_a_00_weapon_00non_13
@anm_w * storage=effect_a_00_weapon_00non_14
@anm_d * delete=%delete|true
@endmacro

;戦艦ミサイル_non
@macro name="effect_b_00_weapon_00non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_00non_00
@anm_w * storage=effect_b_00_weapon_00non_01
@anm_w * storage=effect_b_00_weapon_00non_02
@anm_w * storage=effect_b_00_weapon_00non_03
@anm_w * storage=effect_b_00_weapon_00non_04
@anm_w * storage=effect_b_00_weapon_00non_05
@anm_w * storage=effect_b_00_weapon_00non_06
@anm_w * storage=effect_b_00_weapon_00non_07
@anm_w * storage=effect_b_00_weapon_00non_08
@anm_w * storage=effect_b_00_weapon_00non_09
@anm_w * storage=effect_b_00_weapon_00non_10
@anm_w * storage=effect_b_00_weapon_00non_11
@anm_w * storage=effect_b_00_weapon_00non_12
@anm_w * storage=effect_b_00_weapon_00non_13
@anm_w * storage=effect_b_00_weapon_00non_14
@anm_d * delete=%delete|true
@endmacro

;ヘリ_魚雷_投下_non
@macro name="effect_a_00_weapon_01non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_01non_00
@anm_w * storage=effect_a_00_weapon_01non_01
@anm_w * storage=effect_a_00_weapon_01non_02
@anm_w * storage=effect_a_00_weapon_01non_03
@anm_w * storage=effect_a_00_weapon_01non_04
@anm_w * storage=effect_a_00_weapon_01non_05
@anm_w * storage=effect_a_00_weapon_01non_06
@anm_w * storage=effect_a_00_weapon_01non_07
@anm_w * storage=effect_a_00_weapon_01non_08
@anm_w * storage=effect_a_00_weapon_01non_09
@anm_w * storage=effect_a_00_weapon_01non_10
@anm_w * storage=effect_a_00_weapon_01non_11
@anm_w * storage=effect_a_00_weapon_01non_12
@anm_w * storage=effect_a_00_weapon_01non_13
@anm_w * storage=effect_a_00_weapon_01non_14
@anm_w * storage=effect_a_00_weapon_01non_15
@anm_w * storage=effect_a_00_weapon_01non_16
@anm_w * storage=effect_a_00_weapon_01non_17
@anm_w * storage=effect_a_00_weapon_01non_18
@anm_w * storage=effect_a_00_weapon_01non_19
@anm_w * storage=effect_a_00_weapon_01non_20
@anm_d * delete=%delete|true
@endmacro

;ヘリ_魚雷_投下_non
@macro name="effect_b_00_weapon_01non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_01non_00
@anm_w * storage=effect_b_00_weapon_01non_01
@anm_w * storage=effect_b_00_weapon_01non_02
@anm_w * storage=effect_b_00_weapon_01non_03
@anm_w * storage=effect_b_00_weapon_01non_04
@anm_w * storage=effect_b_00_weapon_01non_05
@anm_w * storage=effect_b_00_weapon_01non_06
@anm_w * storage=effect_b_00_weapon_01non_07
@anm_w * storage=effect_b_00_weapon_01non_08
@anm_w * storage=effect_b_00_weapon_01non_09
@anm_w * storage=effect_b_00_weapon_01non_10
@anm_w * storage=effect_b_00_weapon_01non_11
@anm_w * storage=effect_b_00_weapon_01non_12
@anm_w * storage=effect_b_00_weapon_01non_13
@anm_w * storage=effect_b_00_weapon_01non_14
@anm_w * storage=effect_b_00_weapon_01non_15
@anm_w * storage=effect_b_00_weapon_01non_16
@anm_w * storage=effect_b_00_weapon_01non_17
@anm_w * storage=effect_b_00_weapon_01non_18
@anm_w * storage=effect_b_00_weapon_01non_19
@anm_w * storage=effect_b_00_weapon_01non_20
@anm_d * delete=%delete|true
@endmacro

;ヘリ_魚雷_水の中_non
@macro name="effect_a_00_weapon_02non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_02non_00
@anm_w * storage=effect_a_00_weapon_02non_01
@anm_w * storage=effect_a_00_weapon_02non_02
@anm_w * storage=effect_a_00_weapon_02non_03
@anm_w * storage=effect_a_00_weapon_02non_04
@anm_w * storage=effect_a_00_weapon_02non_05
@anm_w * storage=effect_a_00_weapon_02non_06
@anm_w * storage=effect_a_00_weapon_02non_07
@anm_d * delete=%delete|true
@endmacro

;ヘリ_魚雷_水の中_non
@macro name="effect_b_00_weapon_02non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_02non_00
@anm_w * storage=effect_b_00_weapon_02non_01
@anm_w * storage=effect_b_00_weapon_02non_02
@anm_w * storage=effect_b_00_weapon_02non_03
@anm_w * storage=effect_b_00_weapon_02non_04
@anm_w * storage=effect_b_00_weapon_02non_05
@anm_w * storage=effect_b_00_weapon_02non_06
@anm_w * storage=effect_b_00_weapon_02non_07
@anm_d * delete=%delete|true
@endmacro

;機銃掃射_non
@macro name="effect_a_00_weapon_03non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_03non_00
@anm_w * storage=effect_a_00_weapon_03non_01
@anm_w * storage=effect_a_00_weapon_03non_02
@anm_w * storage=effect_a_00_weapon_03non_03
@anm_w * storage=effect_a_00_weapon_03non_04
@anm_w * storage=effect_a_00_weapon_03non_05
@anm_w * storage=effect_a_00_weapon_03non_06
@anm_w * storage=effect_a_00_weapon_03non_07
@anm_w * storage=effect_a_00_weapon_03non_08
@anm_w * storage=effect_a_00_weapon_03non_09
@anm_w * storage=effect_a_00_weapon_03non_10
@anm_w * storage=effect_a_00_weapon_03non_11
@anm_w * storage=effect_a_00_weapon_03non_12
@anm_w * storage=effect_a_00_weapon_03non_13
@anm_w * storage=effect_a_00_weapon_03non_14
@anm_w * storage=effect_a_00_weapon_03non_15
@anm_w * storage=effect_a_00_weapon_03non_16
@anm_w * storage=effect_a_00_weapon_03non_17
@anm_w * storage=effect_a_00_weapon_03non_18
@anm_d * delete=%delete|true
@endmacro

;機銃掃射_non
@macro name="effect_b_00_weapon_03non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_03non_00
@anm_w * storage=effect_b_00_weapon_03non_01
@anm_w * storage=effect_b_00_weapon_03non_02
@anm_w * storage=effect_b_00_weapon_03non_03
@anm_w * storage=effect_b_00_weapon_03non_04
@anm_w * storage=effect_b_00_weapon_03non_05
@anm_w * storage=effect_b_00_weapon_03non_06
@anm_w * storage=effect_b_00_weapon_03non_07
@anm_w * storage=effect_b_00_weapon_03non_08
@anm_w * storage=effect_b_00_weapon_03non_09
@anm_w * storage=effect_b_00_weapon_03non_10
@anm_w * storage=effect_b_00_weapon_03non_11
@anm_w * storage=effect_b_00_weapon_03non_12
@anm_w * storage=effect_b_00_weapon_03non_13
@anm_w * storage=effect_b_00_weapon_03non_14
@anm_w * storage=effect_b_00_weapon_03non_15
@anm_w * storage=effect_b_00_weapon_03non_16
@anm_w * storage=effect_b_00_weapon_03non_17
@anm_w * storage=effect_b_00_weapon_03non_18
@anm_d * delete=%delete|true
@endmacro

;機銃掃射2_non
@macro name="effect_a_00_weapon_04non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_04non_00
@anm_w * storage=effect_a_00_weapon_04non_01
@anm_w * storage=effect_a_00_weapon_04non_02
@anm_w * storage=effect_a_00_weapon_04non_03
@anm_w * storage=effect_a_00_weapon_04non_04
@anm_w * storage=effect_a_00_weapon_04non_05
@anm_w * storage=effect_a_00_weapon_04non_06
@anm_w * storage=effect_a_00_weapon_04non_07
@anm_w * storage=effect_a_00_weapon_04non_08
@anm_w * storage=effect_a_00_weapon_04non_09
@anm_w * storage=effect_a_00_weapon_04non_10
@anm_w * storage=effect_a_00_weapon_04non_11
@anm_w * storage=effect_a_00_weapon_04non_12
@anm_w * storage=effect_a_00_weapon_04non_13
@anm_w * storage=effect_a_00_weapon_04non_14
@anm_w * storage=effect_a_00_weapon_04non_15
@anm_w * storage=effect_a_00_weapon_04non_16
@anm_w * storage=effect_a_00_weapon_04non_17
@anm_w * storage=effect_a_00_weapon_04non_18
@anm_w * storage=effect_a_00_weapon_04non_19
@anm_d * delete=%delete|true
@endmacro

;機銃掃射2_non
@macro name="effect_b_00_weapon_04non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_04non_00
@anm_w * storage=effect_b_00_weapon_04non_01
@anm_w * storage=effect_b_00_weapon_04non_02
@anm_w * storage=effect_b_00_weapon_04non_03
@anm_w * storage=effect_b_00_weapon_04non_04
@anm_w * storage=effect_b_00_weapon_04non_05
@anm_w * storage=effect_b_00_weapon_04non_06
@anm_w * storage=effect_b_00_weapon_04non_07
@anm_w * storage=effect_b_00_weapon_04non_08
@anm_w * storage=effect_b_00_weapon_04non_09
@anm_w * storage=effect_b_00_weapon_04non_10
@anm_w * storage=effect_b_00_weapon_04non_11
@anm_w * storage=effect_b_00_weapon_04non_12
@anm_w * storage=effect_b_00_weapon_04non_13
@anm_w * storage=effect_b_00_weapon_04non_14
@anm_w * storage=effect_b_00_weapon_04non_15
@anm_w * storage=effect_b_00_weapon_04non_16
@anm_w * storage=effect_b_00_weapon_04non_17
@anm_w * storage=effect_b_00_weapon_04non_18
@anm_w * storage=effect_b_00_weapon_04non_19
@anm_d * delete=%delete|true
@endmacro

;機銃掃射3_non
@macro name="effect_a_00_weapon_05non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_05non_00
@anm_w * storage=effect_a_00_weapon_05non_01
@anm_w * storage=effect_a_00_weapon_05non_02
@anm_w * storage=effect_a_00_weapon_05non_03
@anm_w * storage=effect_a_00_weapon_05non_04
@anm_w * storage=effect_a_00_weapon_05non_05
@anm_w * storage=effect_a_00_weapon_05non_06
@anm_w * storage=effect_a_00_weapon_05non_07
@anm_w * storage=effect_a_00_weapon_05non_08
@anm_w * storage=effect_a_00_weapon_05non_09
@anm_w * storage=effect_a_00_weapon_05non_10
@anm_d * delete=%delete|true
@endmacro

;機銃掃射3_non
@macro name="effect_b_00_weapon_05non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_05non_00
@anm_w * storage=effect_b_00_weapon_05non_01
@anm_w * storage=effect_b_00_weapon_05non_02
@anm_w * storage=effect_b_00_weapon_05non_03
@anm_w * storage=effect_b_00_weapon_05non_04
@anm_w * storage=effect_b_00_weapon_05non_05
@anm_w * storage=effect_b_00_weapon_05non_06
@anm_w * storage=effect_b_00_weapon_05non_07
@anm_w * storage=effect_b_00_weapon_05non_08
@anm_w * storage=effect_b_00_weapon_05non_09
@anm_w * storage=effect_b_00_weapon_05non_10
@anm_d * delete=%delete|true
@endmacro

;機銃掃射4_non
@macro name="effect_a_00_weapon_06non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_06non_00
@anm_w * storage=effect_a_00_weapon_06non_01
@anm_w * storage=effect_a_00_weapon_06non_02
@anm_w * storage=effect_a_00_weapon_06non_03
@anm_w * storage=effect_a_00_weapon_06non_04
@anm_w * storage=effect_a_00_weapon_06non_05
@anm_w * storage=effect_a_00_weapon_06non_06
@anm_w * storage=effect_a_00_weapon_06non_07
@anm_w * storage=effect_a_00_weapon_06non_08
@anm_w * storage=effect_a_00_weapon_06non_09
@anm_w * storage=effect_a_00_weapon_06non_10
@anm_w * storage=effect_a_00_weapon_06non_11
@anm_w * storage=effect_a_00_weapon_06non_12
@anm_w * storage=effect_a_00_weapon_06non_13
@anm_w * storage=effect_a_00_weapon_06non_14
@anm_w * storage=effect_a_00_weapon_06non_15
@anm_w * storage=effect_a_00_weapon_06non_16
@anm_w * storage=effect_a_00_weapon_06non_17
@anm_w * storage=effect_a_00_weapon_06non_18
@anm_w * storage=effect_a_00_weapon_06non_19
@anm_w * storage=effect_a_00_weapon_06non_20
@anm_w * storage=effect_a_00_weapon_06non_21
@anm_w * storage=effect_a_00_weapon_06non_22
@anm_w * storage=effect_a_00_weapon_06non_23
@anm_w * storage=effect_a_00_weapon_06non_24
@anm_w * storage=effect_a_00_weapon_06non_25
@anm_w * storage=effect_a_00_weapon_06non_26
@anm_w * storage=effect_a_00_weapon_06non_27
@anm_d * delete=%delete|true
@endmacro

;機銃掃射4_non
@macro name="effect_b_00_weapon_06non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_06non_00
@anm_w * storage=effect_b_00_weapon_06non_01
@anm_w * storage=effect_b_00_weapon_06non_02
@anm_w * storage=effect_b_00_weapon_06non_03
@anm_w * storage=effect_b_00_weapon_06non_04
@anm_w * storage=effect_b_00_weapon_06non_05
@anm_w * storage=effect_b_00_weapon_06non_06
@anm_w * storage=effect_b_00_weapon_06non_07
@anm_w * storage=effect_b_00_weapon_06non_08
@anm_w * storage=effect_b_00_weapon_06non_09
@anm_w * storage=effect_b_00_weapon_06non_10
@anm_w * storage=effect_b_00_weapon_06non_11
@anm_w * storage=effect_b_00_weapon_06non_12
@anm_w * storage=effect_b_00_weapon_06non_13
@anm_w * storage=effect_b_00_weapon_06non_14
@anm_w * storage=effect_b_00_weapon_06non_15
@anm_w * storage=effect_b_00_weapon_06non_16
@anm_w * storage=effect_b_00_weapon_06non_17
@anm_w * storage=effect_b_00_weapon_06non_18
@anm_w * storage=effect_b_00_weapon_06non_19
@anm_w * storage=effect_b_00_weapon_06non_20
@anm_w * storage=effect_b_00_weapon_06non_21
@anm_w * storage=effect_b_00_weapon_06non_22
@anm_w * storage=effect_b_00_weapon_06non_23
@anm_w * storage=effect_b_00_weapon_06non_24
@anm_w * storage=effect_b_00_weapon_06non_25
@anm_w * storage=effect_b_00_weapon_06non_26
@anm_w * storage=effect_b_00_weapon_06non_27
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_non
@macro name="effect_a_00_weapon_07non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_07non_00
@anm_w * storage=effect_a_00_weapon_07non_01
@anm_w * storage=effect_a_00_weapon_07non_02
@anm_w * storage=effect_a_00_weapon_07non_03
@anm_w * storage=effect_a_00_weapon_07non_04
@anm_w * storage=effect_a_00_weapon_07non_05
@anm_w * storage=effect_a_00_weapon_07non_06
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_non
@macro name="effect_b_00_weapon_07non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_07non_00
@anm_w * storage=effect_b_00_weapon_07non_01
@anm_w * storage=effect_b_00_weapon_07non_02
@anm_w * storage=effect_b_00_weapon_07non_03
@anm_w * storage=effect_b_00_weapon_07non_04
@anm_w * storage=effect_b_00_weapon_07non_05
@anm_w * storage=effect_b_00_weapon_07non_06
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_奥から_non
@macro name="effect_a_00_weapon_08non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_08non_00
@anm_w * storage=effect_a_00_weapon_08non_01
@anm_w * storage=effect_a_00_weapon_08non_02
@anm_w * storage=effect_a_00_weapon_08non_03
@anm_w * storage=effect_a_00_weapon_08non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_奥から_non
@macro name="effect_b_00_weapon_08non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_08non_00
@anm_w * storage=effect_b_00_weapon_08non_01
@anm_w * storage=effect_b_00_weapon_08non_02
@anm_w * storage=effect_b_00_weapon_08non_03
@anm_w * storage=effect_b_00_weapon_08non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_奥から2_non
@macro name="effect_a_00_weapon_09non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_09non_00
@anm_w * storage=effect_a_00_weapon_09non_01
@anm_w * storage=effect_a_00_weapon_09non_02
@anm_w * storage=effect_a_00_weapon_09non_03
@anm_w * storage=effect_a_00_weapon_09non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_奥から2_non
@macro name="effect_b_00_weapon_09non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_09non_00
@anm_w * storage=effect_b_00_weapon_09non_01
@anm_w * storage=effect_b_00_weapon_09non_02
@anm_w * storage=effect_b_00_weapon_09non_03
@anm_w * storage=effect_b_00_weapon_09non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_横_non
@macro name="effect_a_00_weapon_10non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_10non_00
@anm_w * storage=effect_a_00_weapon_10non_01
@anm_w * storage=effect_a_00_weapon_10non_02
@anm_w * storage=effect_a_00_weapon_10non_03
@anm_w * storage=effect_a_00_weapon_10non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_横_non
@macro name="effect_b_00_weapon_10non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_10non_00
@anm_w * storage=effect_b_00_weapon_10non_01
@anm_w * storage=effect_b_00_weapon_10non_02
@anm_w * storage=effect_b_00_weapon_10non_03
@anm_w * storage=effect_b_00_weapon_10non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_４発_non
@macro name="effect_a_00_weapon_11non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_11non_00
@anm_w * storage=effect_a_00_weapon_11non_01
@anm_w * storage=effect_a_00_weapon_11non_02
@anm_w * storage=effect_a_00_weapon_11non_03
@anm_w * storage=effect_a_00_weapon_11non_04
@anm_w * storage=effect_a_00_weapon_11non_05
@anm_w * storage=effect_a_00_weapon_11non_06
@anm_w * storage=effect_a_00_weapon_11non_07
@anm_w * storage=effect_a_00_weapon_11non_08
@anm_w * storage=effect_a_00_weapon_11non_09
@anm_w * storage=effect_a_00_weapon_11non_10
@anm_w * storage=effect_a_00_weapon_11non_11
@anm_w * storage=effect_a_00_weapon_11non_12
@anm_w * storage=effect_a_00_weapon_11non_13
@anm_w * storage=effect_a_00_weapon_11non_14
@anm_w * storage=effect_a_00_weapon_11non_15
@anm_w * storage=effect_a_00_weapon_11non_16
@anm_w * storage=effect_a_00_weapon_11non_17
@anm_w * storage=effect_a_00_weapon_11non_18
@anm_w * storage=effect_a_00_weapon_11non_19
@anm_w * storage=effect_a_00_weapon_11non_20
@anm_w * storage=effect_a_00_weapon_11non_21
@anm_w * storage=effect_a_00_weapon_11non_22
@anm_w * storage=effect_a_00_weapon_11non_23
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(SideWinder)_４発_non
@macro name="effect_b_00_weapon_11non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_11non_00
@anm_w * storage=effect_b_00_weapon_11non_01
@anm_w * storage=effect_b_00_weapon_11non_02
@anm_w * storage=effect_b_00_weapon_11non_03
@anm_w * storage=effect_b_00_weapon_11non_04
@anm_w * storage=effect_b_00_weapon_11non_05
@anm_w * storage=effect_b_00_weapon_11non_06
@anm_w * storage=effect_b_00_weapon_11non_07
@anm_w * storage=effect_b_00_weapon_11non_08
@anm_w * storage=effect_b_00_weapon_11non_09
@anm_w * storage=effect_b_00_weapon_11non_10
@anm_w * storage=effect_b_00_weapon_11non_11
@anm_w * storage=effect_b_00_weapon_11non_12
@anm_w * storage=effect_b_00_weapon_11non_13
@anm_w * storage=effect_b_00_weapon_11non_14
@anm_w * storage=effect_b_00_weapon_11non_15
@anm_w * storage=effect_b_00_weapon_11non_16
@anm_w * storage=effect_b_00_weapon_11non_17
@anm_w * storage=effect_b_00_weapon_11non_18
@anm_w * storage=effect_b_00_weapon_11non_19
@anm_w * storage=effect_b_00_weapon_11non_20
@anm_w * storage=effect_b_00_weapon_11non_21
@anm_w * storage=effect_b_00_weapon_11non_22
@anm_w * storage=effect_b_00_weapon_11non_23
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_non
@macro name="effect_a_00_weapon_12non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_12non_00
@anm_w * storage=effect_a_00_weapon_12non_01
@anm_w * storage=effect_a_00_weapon_12non_02
@anm_w * storage=effect_a_00_weapon_12non_03
@anm_w * storage=effect_a_00_weapon_12non_04
@anm_w * storage=effect_a_00_weapon_12non_05
@anm_w * storage=effect_a_00_weapon_12non_06
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_non
@macro name="effect_b_00_weapon_12non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_12non_00
@anm_w * storage=effect_b_00_weapon_12non_01
@anm_w * storage=effect_b_00_weapon_12non_02
@anm_w * storage=effect_b_00_weapon_12non_03
@anm_w * storage=effect_b_00_weapon_12non_04
@anm_w * storage=effect_b_00_weapon_12non_05
@anm_w * storage=effect_b_00_weapon_12non_06
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_奥から_non
@macro name="effect_a_00_weapon_13non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_13non_00
@anm_w * storage=effect_a_00_weapon_13non_01
@anm_w * storage=effect_a_00_weapon_13non_02
@anm_w * storage=effect_a_00_weapon_13non_03
@anm_w * storage=effect_a_00_weapon_13non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_奥から_non
@macro name="effect_b_00_weapon_13non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_13non_00
@anm_w * storage=effect_b_00_weapon_13non_01
@anm_w * storage=effect_b_00_weapon_13non_02
@anm_w * storage=effect_b_00_weapon_13non_03
@anm_w * storage=effect_b_00_weapon_13non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_奥から2_non
@macro name="effect_a_00_weapon_14non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_14non_00
@anm_w * storage=effect_a_00_weapon_14non_01
@anm_w * storage=effect_a_00_weapon_14non_02
@anm_w * storage=effect_a_00_weapon_14non_03
@anm_w * storage=effect_a_00_weapon_14non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_奥から2_non
@macro name="effect_b_00_weapon_14non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_14non_00
@anm_w * storage=effect_b_00_weapon_14non_01
@anm_w * storage=effect_b_00_weapon_14non_02
@anm_w * storage=effect_b_00_weapon_14non_03
@anm_w * storage=effect_b_00_weapon_14non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_横_non
@macro name="effect_a_00_weapon_15non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_15non_00
@anm_w * storage=effect_a_00_weapon_15non_01
@anm_w * storage=effect_a_00_weapon_15non_02
@anm_w * storage=effect_a_00_weapon_15non_03
@anm_w * storage=effect_a_00_weapon_15non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_横_non
@macro name="effect_b_00_weapon_15non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_15non_00
@anm_w * storage=effect_b_00_weapon_15non_01
@anm_w * storage=effect_b_00_weapon_15non_02
@anm_w * storage=effect_b_00_weapon_15non_03
@anm_w * storage=effect_b_00_weapon_15non_04
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_４発_non
@macro name="effect_a_00_weapon_16non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_16non_00
@anm_w * storage=effect_a_00_weapon_16non_01
@anm_w * storage=effect_a_00_weapon_16non_02
@anm_w * storage=effect_a_00_weapon_16non_03
@anm_w * storage=effect_a_00_weapon_16non_04
@anm_w * storage=effect_a_00_weapon_16non_05
@anm_w * storage=effect_a_00_weapon_16non_06
@anm_w * storage=effect_a_00_weapon_16non_07
@anm_w * storage=effect_a_00_weapon_16non_08
@anm_w * storage=effect_a_00_weapon_16non_09
@anm_w * storage=effect_a_00_weapon_16non_10
@anm_w * storage=effect_a_00_weapon_16non_11
@anm_w * storage=effect_a_00_weapon_16non_12
@anm_w * storage=effect_a_00_weapon_16non_13
@anm_w * storage=effect_a_00_weapon_16non_14
@anm_w * storage=effect_a_00_weapon_16non_15
@anm_w * storage=effect_a_00_weapon_16non_16
@anm_w * storage=effect_a_00_weapon_16non_17
@anm_w * storage=effect_a_00_weapon_16non_18
@anm_w * storage=effect_a_00_weapon_16non_19
@anm_w * storage=effect_a_00_weapon_16non_20
@anm_w * storage=effect_a_00_weapon_16non_21
@anm_w * storage=effect_a_00_weapon_16non_22
@anm_w * storage=effect_a_00_weapon_16non_23
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_４発_non
@macro name="effect_b_00_weapon_16non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_16non_00
@anm_w * storage=effect_b_00_weapon_16non_01
@anm_w * storage=effect_b_00_weapon_16non_02
@anm_w * storage=effect_b_00_weapon_16non_03
@anm_w * storage=effect_b_00_weapon_16non_04
@anm_w * storage=effect_b_00_weapon_16non_05
@anm_w * storage=effect_b_00_weapon_16non_06
@anm_w * storage=effect_b_00_weapon_16non_07
@anm_w * storage=effect_b_00_weapon_16non_08
@anm_w * storage=effect_b_00_weapon_16non_09
@anm_w * storage=effect_b_00_weapon_16non_10
@anm_w * storage=effect_b_00_weapon_16non_11
@anm_w * storage=effect_b_00_weapon_16non_12
@anm_w * storage=effect_b_00_weapon_16non_13
@anm_w * storage=effect_b_00_weapon_16non_14
@anm_w * storage=effect_b_00_weapon_16non_15
@anm_w * storage=effect_b_00_weapon_16non_16
@anm_w * storage=effect_b_00_weapon_16non_17
@anm_w * storage=effect_b_00_weapon_16non_18
@anm_w * storage=effect_b_00_weapon_16non_19
@anm_w * storage=effect_b_00_weapon_16non_20
@anm_w * storage=effect_b_00_weapon_16non_21
@anm_w * storage=effect_b_00_weapon_16non_22
@anm_w * storage=effect_b_00_weapon_16non_23
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_いっぱい_non
@macro name="effect_a_00_weapon_17non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_17non_00
@anm_w * storage=effect_a_00_weapon_17non_01
@anm_w * storage=effect_a_00_weapon_17non_02
@anm_w * storage=effect_a_00_weapon_17non_03
@anm_w * storage=effect_a_00_weapon_17non_04
@anm_w * storage=effect_a_00_weapon_17non_05
@anm_w * storage=effect_a_00_weapon_17non_06
@anm_w * storage=effect_a_00_weapon_17non_07
@anm_w * storage=effect_a_00_weapon_17non_08
@anm_w * storage=effect_a_00_weapon_17non_09
@anm_w * storage=effect_a_00_weapon_17non_10
@anm_w * storage=effect_a_00_weapon_17non_11
@anm_w * storage=effect_a_00_weapon_17non_12
@anm_w * storage=effect_a_00_weapon_17non_13
@anm_w * storage=effect_a_00_weapon_17non_14
@anm_w * storage=effect_a_00_weapon_17non_15
@anm_w * storage=effect_a_00_weapon_17non_16
@anm_w * storage=effect_a_00_weapon_17non_17
@anm_w * storage=effect_a_00_weapon_17non_18
@anm_w * storage=effect_a_00_weapon_17non_19
@anm_w * storage=effect_a_00_weapon_17non_20
@anm_w * storage=effect_a_00_weapon_17non_21
@anm_w * storage=effect_a_00_weapon_17non_22
@anm_w * storage=effect_a_00_weapon_17non_23
@anm_w * storage=effect_a_00_weapon_17non_24
@anm_w * storage=effect_a_00_weapon_17non_25
@anm_d * delete=%delete|true
@endmacro

;戦闘機ミサイル(FMRAAM)_いっぱい_non
@macro name="effect_b_00_weapon_17non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_17non_00
@anm_w * storage=effect_b_00_weapon_17non_01
@anm_w * storage=effect_b_00_weapon_17non_02
@anm_w * storage=effect_b_00_weapon_17non_03
@anm_w * storage=effect_b_00_weapon_17non_04
@anm_w * storage=effect_b_00_weapon_17non_05
@anm_w * storage=effect_b_00_weapon_17non_06
@anm_w * storage=effect_b_00_weapon_17non_07
@anm_w * storage=effect_b_00_weapon_17non_08
@anm_w * storage=effect_b_00_weapon_17non_09
@anm_w * storage=effect_b_00_weapon_17non_10
@anm_w * storage=effect_b_00_weapon_17non_11
@anm_w * storage=effect_b_00_weapon_17non_12
@anm_w * storage=effect_b_00_weapon_17non_13
@anm_w * storage=effect_b_00_weapon_17non_14
@anm_w * storage=effect_b_00_weapon_17non_15
@anm_w * storage=effect_b_00_weapon_17non_16
@anm_w * storage=effect_b_00_weapon_17non_17
@anm_w * storage=effect_b_00_weapon_17non_18
@anm_w * storage=effect_b_00_weapon_17non_19
@anm_w * storage=effect_b_00_weapon_17non_20
@anm_w * storage=effect_b_00_weapon_17non_21
@anm_w * storage=effect_b_00_weapon_17non_22
@anm_w * storage=effect_b_00_weapon_17non_23
@anm_w * storage=effect_b_00_weapon_17non_24
@anm_w * storage=effect_b_00_weapon_17non_25
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)天神最終兵器：ミサイル・一斉掃射_non
@macro name="effect_a_00_weapon_18non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_18non_00
@anm_w * storage=effect_a_00_weapon_18non_01
@anm_w * storage=effect_a_00_weapon_18non_02
@anm_w * storage=effect_a_00_weapon_18non_03
@anm_w * storage=effect_a_00_weapon_18non_04
@anm_w * storage=effect_a_00_weapon_18non_05
@anm_w * storage=effect_a_00_weapon_18non_06
@anm_w * storage=effect_a_00_weapon_18non_07
@anm_w * storage=effect_a_00_weapon_18non_08
@anm_w * storage=effect_a_00_weapon_18non_09
@anm_w * storage=effect_a_00_weapon_18non_10
@anm_w * storage=effect_a_00_weapon_18non_11
@anm_w * storage=effect_a_00_weapon_18non_12
@anm_w * storage=effect_a_00_weapon_18non_13
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)天神最終兵器：ミサイル・一斉掃射_non
@macro name="effect_b_00_weapon_18non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_18non_00
@anm_w * storage=effect_b_00_weapon_18non_01
@anm_w * storage=effect_b_00_weapon_18non_02
@anm_w * storage=effect_b_00_weapon_18non_03
@anm_w * storage=effect_b_00_weapon_18non_04
@anm_w * storage=effect_b_00_weapon_18non_05
@anm_w * storage=effect_b_00_weapon_18non_06
@anm_w * storage=effect_b_00_weapon_18non_07
@anm_w * storage=effect_b_00_weapon_18non_08
@anm_w * storage=effect_b_00_weapon_18non_09
@anm_w * storage=effect_b_00_weapon_18non_10
@anm_w * storage=effect_b_00_weapon_18non_11
@anm_w * storage=effect_b_00_weapon_18non_12
@anm_w * storage=effect_b_00_weapon_18non_13
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)天神最終兵器：ミサイル・一斉掃射2_non
@macro name="effect_a_00_weapon_19non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_19non_00
@anm_w * storage=effect_a_00_weapon_19non_01
@anm_w * storage=effect_a_00_weapon_19non_02
@anm_w * storage=effect_a_00_weapon_19non_03
@anm_w * storage=effect_a_00_weapon_19non_04
@anm_w * storage=effect_a_00_weapon_19non_05
@anm_w * storage=effect_a_00_weapon_19non_06
@anm_w * storage=effect_a_00_weapon_19non_07
@anm_w * storage=effect_a_00_weapon_19non_08
@anm_w * storage=effect_a_00_weapon_19non_09
@anm_w * storage=effect_a_00_weapon_19non_10
@anm_w * storage=effect_a_00_weapon_19non_11
@anm_w * storage=effect_a_00_weapon_19non_12
@anm_w * storage=effect_a_00_weapon_19non_13
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)天神最終兵器：ミサイル・一斉掃射2_non
@macro name="effect_b_00_weapon_19non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_19non_00
@anm_w * storage=effect_b_00_weapon_19non_01
@anm_w * storage=effect_b_00_weapon_19non_02
@anm_w * storage=effect_b_00_weapon_19non_03
@anm_w * storage=effect_b_00_weapon_19non_04
@anm_w * storage=effect_b_00_weapon_19non_05
@anm_w * storage=effect_b_00_weapon_19non_06
@anm_w * storage=effect_b_00_weapon_19non_07
@anm_w * storage=effect_b_00_weapon_19non_08
@anm_w * storage=effect_b_00_weapon_19non_09
@anm_w * storage=effect_b_00_weapon_19non_10
@anm_w * storage=effect_b_00_weapon_19non_11
@anm_w * storage=effect_b_00_weapon_19non_12
@anm_w * storage=effect_b_00_weapon_19non_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)ppr_青
@macro name="effect_a_00_weapon_20b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_20b_00
@anm_w * storage=effect_a_00_weapon_20b_01
@anm_w * storage=effect_a_00_weapon_20b_02
@anm_w * storage=effect_a_00_weapon_20b_03
@anm_w * storage=effect_a_00_weapon_20b_04
@anm_w * storage=effect_a_00_weapon_20b_05
@anm_w * storage=effect_a_00_weapon_20b_06
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)ppr_青
@macro name="effect_b_00_weapon_20b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_20b_00
@anm_w * storage=effect_b_00_weapon_20b_01
@anm_w * storage=effect_b_00_weapon_20b_02
@anm_w * storage=effect_b_00_weapon_20b_03
@anm_w * storage=effect_b_00_weapon_20b_04
@anm_w * storage=effect_b_00_weapon_20b_05
@anm_w * storage=effect_b_00_weapon_20b_06
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_刺突_青
@macro name="effect_a_00_weapon_21b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_21b_00
@anm_w * storage=effect_a_00_weapon_21b_01
@anm_w * storage=effect_a_00_weapon_21b_02
@anm_w * storage=effect_a_00_weapon_21b_03
@anm_w * storage=effect_a_00_weapon_21b_04
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_刺突_青
@macro name="effect_b_00_weapon_21b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_21b_00
@anm_w * storage=effect_b_00_weapon_21b_01
@anm_w * storage=effect_b_00_weapon_21b_02
@anm_w * storage=effect_b_00_weapon_21b_03
@anm_w * storage=effect_b_00_weapon_21b_04
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_青
@macro name="effect_a_00_weapon_22b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_22b_00
@anm_w * storage=effect_a_00_weapon_22b_01
@anm_w * storage=effect_a_00_weapon_22b_02
@anm_w * storage=effect_a_00_weapon_22b_03
@anm_w * storage=effect_a_00_weapon_22b_04
@anm_w * storage=effect_a_00_weapon_22b_05
@anm_w * storage=effect_a_00_weapon_22b_06
@anm_w * storage=effect_a_00_weapon_22b_07
@anm_w * storage=effect_a_00_weapon_22b_08
@anm_w * storage=effect_a_00_weapon_22b_09
@anm_w * storage=effect_a_00_weapon_22b_10
@anm_w * storage=effect_a_00_weapon_22b_11
@anm_w * storage=effect_a_00_weapon_22b_12
@anm_w * storage=effect_a_00_weapon_22b_13
@anm_w * storage=effect_a_00_weapon_22b_14
@anm_w * storage=effect_a_00_weapon_22b_15
@anm_w * storage=effect_a_00_weapon_22b_16
@anm_w * storage=effect_a_00_weapon_22b_17
@anm_w * storage=effect_a_00_weapon_22b_18
@anm_w * storage=effect_a_00_weapon_22b_19
@anm_w * storage=effect_a_00_weapon_22b_20
@anm_w * storage=effect_a_00_weapon_22b_21
@anm_w * storage=effect_a_00_weapon_22b_22
@anm_w * storage=effect_a_00_weapon_22b_23
@anm_w * storage=effect_a_00_weapon_22b_24
@anm_w * storage=effect_a_00_weapon_22b_25
@anm_w * storage=effect_a_00_weapon_22b_26
@anm_w * storage=effect_a_00_weapon_22b_27
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_青
@macro name="effect_b_00_weapon_22b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_22b_00
@anm_w * storage=effect_b_00_weapon_22b_01
@anm_w * storage=effect_b_00_weapon_22b_02
@anm_w * storage=effect_b_00_weapon_22b_03
@anm_w * storage=effect_b_00_weapon_22b_04
@anm_w * storage=effect_b_00_weapon_22b_05
@anm_w * storage=effect_b_00_weapon_22b_06
@anm_w * storage=effect_b_00_weapon_22b_07
@anm_w * storage=effect_b_00_weapon_22b_08
@anm_w * storage=effect_b_00_weapon_22b_09
@anm_w * storage=effect_b_00_weapon_22b_10
@anm_w * storage=effect_b_00_weapon_22b_11
@anm_w * storage=effect_b_00_weapon_22b_12
@anm_w * storage=effect_b_00_weapon_22b_13
@anm_w * storage=effect_b_00_weapon_22b_14
@anm_w * storage=effect_b_00_weapon_22b_15
@anm_w * storage=effect_b_00_weapon_22b_16
@anm_w * storage=effect_b_00_weapon_22b_17
@anm_w * storage=effect_b_00_weapon_22b_18
@anm_w * storage=effect_b_00_weapon_22b_19
@anm_w * storage=effect_b_00_weapon_22b_20
@anm_w * storage=effect_b_00_weapon_22b_21
@anm_w * storage=effect_b_00_weapon_22b_22
@anm_w * storage=effect_b_00_weapon_22b_23
@anm_w * storage=effect_b_00_weapon_22b_24
@anm_w * storage=effect_b_00_weapon_22b_25
@anm_w * storage=effect_b_00_weapon_22b_26
@anm_w * storage=effect_b_00_weapon_22b_27
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_横_青
@macro name="effect_a_00_weapon_23b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_23b_00
@anm_w * storage=effect_a_00_weapon_23b_01
@anm_w * storage=effect_a_00_weapon_23b_02
@anm_w * storage=effect_a_00_weapon_23b_03
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_横_青
@macro name="effect_b_00_weapon_23b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_23b_00
@anm_w * storage=effect_b_00_weapon_23b_01
@anm_w * storage=effect_b_00_weapon_23b_02
@anm_w * storage=effect_b_00_weapon_23b_03
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_三連撃_青
@macro name="effect_a_00_weapon_24b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_24b_00
@anm_w * storage=effect_a_00_weapon_24b_01
@anm_w * storage=effect_a_00_weapon_24b_02
@anm_w * storage=effect_a_00_weapon_24b_03
@anm_w * storage=effect_a_00_weapon_24b_04
@anm_w * storage=effect_a_00_weapon_24b_05
@anm_w * storage=effect_a_00_weapon_24b_06
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_三連撃_青
@macro name="effect_b_00_weapon_24b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_24b_00
@anm_w * storage=effect_b_00_weapon_24b_01
@anm_w * storage=effect_b_00_weapon_24b_02
@anm_w * storage=effect_b_00_weapon_24b_03
@anm_w * storage=effect_b_00_weapon_24b_04
@anm_w * storage=effect_b_00_weapon_24b_05
@anm_w * storage=effect_b_00_weapon_24b_06
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_二つ振り下ろし_青
@macro name="effect_a_00_weapon_25b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_25b_00
@anm_w * storage=effect_a_00_weapon_25b_01
@anm_w * storage=effect_a_00_weapon_25b_02
@anm_w * storage=effect_a_00_weapon_25b_03
@anm_w * storage=effect_a_00_weapon_25b_04
@anm_w * storage=effect_a_00_weapon_25b_05
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_二つ振り下ろし_青
@macro name="effect_b_00_weapon_25b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_25b_00
@anm_w * storage=effect_b_00_weapon_25b_01
@anm_w * storage=effect_b_00_weapon_25b_02
@anm_w * storage=effect_b_00_weapon_25b_03
@anm_w * storage=effect_b_00_weapon_25b_04
@anm_w * storage=effect_b_00_weapon_25b_05
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_二つ振り下ろし_空振り_青
@macro name="effect_a_00_weapon_26b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_26b_00
@anm_w * storage=effect_a_00_weapon_26b_01
@anm_w * storage=effect_a_00_weapon_26b_02
@anm_w * storage=effect_a_00_weapon_26b_03
@anm_w * storage=effect_a_00_weapon_26b_04
@anm_w * storage=effect_a_00_weapon_26b_05
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルダガー_二つ振り下ろし_空振り_青
@macro name="effect_b_00_weapon_26b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_26b_00
@anm_w * storage=effect_b_00_weapon_26b_01
@anm_w * storage=effect_b_00_weapon_26b_02
@anm_w * storage=effect_b_00_weapon_26b_03
@anm_w * storage=effect_b_00_weapon_26b_04
@anm_w * storage=effect_b_00_weapon_26b_05
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル1_1_青
@macro name="effect_a_00_weapon_27b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_27b_00
@anm_w * storage=effect_a_00_weapon_27b_01
@anm_w * storage=effect_a_00_weapon_27b_02
@anm_w * storage=effect_a_00_weapon_27b_03
@anm_w * storage=effect_a_00_weapon_27b_04
@anm_w * storage=effect_a_00_weapon_27b_05
@anm_w * storage=effect_a_00_weapon_27b_06
@anm_w * storage=effect_a_00_weapon_27b_07
@anm_w * storage=effect_a_00_weapon_27b_08
@anm_w * storage=effect_a_00_weapon_27b_09
@anm_w * storage=effect_a_00_weapon_27b_10
@anm_w * storage=effect_a_00_weapon_27b_11
@anm_w * storage=effect_a_00_weapon_27b_12
@anm_w * storage=effect_a_00_weapon_27b_13
@anm_w * storage=effect_a_00_weapon_27b_14
@anm_w * storage=effect_a_00_weapon_27b_15
@anm_w * storage=effect_a_00_weapon_27b_16
@anm_w * storage=effect_a_00_weapon_27b_17
@anm_w * storage=effect_a_00_weapon_27b_18
@anm_w * storage=effect_a_00_weapon_27b_19
@anm_w * storage=effect_a_00_weapon_27b_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル1_1_青
@macro name="effect_b_00_weapon_27b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_27b_00
@anm_w * storage=effect_b_00_weapon_27b_01
@anm_w * storage=effect_b_00_weapon_27b_02
@anm_w * storage=effect_b_00_weapon_27b_03
@anm_w * storage=effect_b_00_weapon_27b_04
@anm_w * storage=effect_b_00_weapon_27b_05
@anm_w * storage=effect_b_00_weapon_27b_06
@anm_w * storage=effect_b_00_weapon_27b_07
@anm_w * storage=effect_b_00_weapon_27b_08
@anm_w * storage=effect_b_00_weapon_27b_09
@anm_w * storage=effect_b_00_weapon_27b_10
@anm_w * storage=effect_b_00_weapon_27b_11
@anm_w * storage=effect_b_00_weapon_27b_12
@anm_w * storage=effect_b_00_weapon_27b_13
@anm_w * storage=effect_b_00_weapon_27b_14
@anm_w * storage=effect_b_00_weapon_27b_15
@anm_w * storage=effect_b_00_weapon_27b_16
@anm_w * storage=effect_b_00_weapon_27b_17
@anm_w * storage=effect_b_00_weapon_27b_18
@anm_w * storage=effect_b_00_weapon_27b_19
@anm_w * storage=effect_b_00_weapon_27b_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル2_1(パラライズ)_黄色
@macro name="effect_a_00_weapon_27y"
@anm_q *
@anm_w * storage=effect_a_00_weapon_27y_00
@anm_w * storage=effect_a_00_weapon_27y_01
@anm_w * storage=effect_a_00_weapon_27y_02
@anm_w * storage=effect_a_00_weapon_27y_03
@anm_w * storage=effect_a_00_weapon_27y_04
@anm_w * storage=effect_a_00_weapon_27y_05
@anm_w * storage=effect_a_00_weapon_27y_06
@anm_w * storage=effect_a_00_weapon_27y_07
@anm_w * storage=effect_a_00_weapon_27y_08
@anm_w * storage=effect_a_00_weapon_27y_09
@anm_w * storage=effect_a_00_weapon_27y_10
@anm_w * storage=effect_a_00_weapon_27y_11
@anm_w * storage=effect_a_00_weapon_27y_12
@anm_w * storage=effect_a_00_weapon_27y_13
@anm_w * storage=effect_a_00_weapon_27y_14
@anm_w * storage=effect_a_00_weapon_27y_15
@anm_w * storage=effect_a_00_weapon_27y_16
@anm_w * storage=effect_a_00_weapon_27y_17
@anm_w * storage=effect_a_00_weapon_27y_18
@anm_w * storage=effect_a_00_weapon_27y_19
@anm_w * storage=effect_a_00_weapon_27y_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル2_1(パラライズ)_黄色
@macro name="effect_b_00_weapon_27y"
@anm_q *
@anm_w * storage=effect_b_00_weapon_27y_00
@anm_w * storage=effect_b_00_weapon_27y_01
@anm_w * storage=effect_b_00_weapon_27y_02
@anm_w * storage=effect_b_00_weapon_27y_03
@anm_w * storage=effect_b_00_weapon_27y_04
@anm_w * storage=effect_b_00_weapon_27y_05
@anm_w * storage=effect_b_00_weapon_27y_06
@anm_w * storage=effect_b_00_weapon_27y_07
@anm_w * storage=effect_b_00_weapon_27y_08
@anm_w * storage=effect_b_00_weapon_27y_09
@anm_w * storage=effect_b_00_weapon_27y_10
@anm_w * storage=effect_b_00_weapon_27y_11
@anm_w * storage=effect_b_00_weapon_27y_12
@anm_w * storage=effect_b_00_weapon_27y_13
@anm_w * storage=effect_b_00_weapon_27y_14
@anm_w * storage=effect_b_00_weapon_27y_15
@anm_w * storage=effect_b_00_weapon_27y_16
@anm_w * storage=effect_b_00_weapon_27y_17
@anm_w * storage=effect_b_00_weapon_27y_18
@anm_w * storage=effect_b_00_weapon_27y_19
@anm_w * storage=effect_b_00_weapon_27y_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル3_1(フリーズ)_水色
@macro name="effect_a_00_weapon_27c"
@anm_q *
@anm_w * storage=effect_a_00_weapon_27c_00
@anm_w * storage=effect_a_00_weapon_27c_01
@anm_w * storage=effect_a_00_weapon_27c_02
@anm_w * storage=effect_a_00_weapon_27c_03
@anm_w * storage=effect_a_00_weapon_27c_04
@anm_w * storage=effect_a_00_weapon_27c_05
@anm_w * storage=effect_a_00_weapon_27c_06
@anm_w * storage=effect_a_00_weapon_27c_07
@anm_w * storage=effect_a_00_weapon_27c_08
@anm_w * storage=effect_a_00_weapon_27c_09
@anm_w * storage=effect_a_00_weapon_27c_10
@anm_w * storage=effect_a_00_weapon_27c_11
@anm_w * storage=effect_a_00_weapon_27c_12
@anm_w * storage=effect_a_00_weapon_27c_13
@anm_w * storage=effect_a_00_weapon_27c_14
@anm_w * storage=effect_a_00_weapon_27c_15
@anm_w * storage=effect_a_00_weapon_27c_16
@anm_w * storage=effect_a_00_weapon_27c_17
@anm_w * storage=effect_a_00_weapon_27c_18
@anm_w * storage=effect_a_00_weapon_27c_19
@anm_w * storage=effect_a_00_weapon_27c_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル3_1(フリーズ)_水色
@macro name="effect_b_00_weapon_27c"
@anm_q *
@anm_w * storage=effect_b_00_weapon_27c_00
@anm_w * storage=effect_b_00_weapon_27c_01
@anm_w * storage=effect_b_00_weapon_27c_02
@anm_w * storage=effect_b_00_weapon_27c_03
@anm_w * storage=effect_b_00_weapon_27c_04
@anm_w * storage=effect_b_00_weapon_27c_05
@anm_w * storage=effect_b_00_weapon_27c_06
@anm_w * storage=effect_b_00_weapon_27c_07
@anm_w * storage=effect_b_00_weapon_27c_08
@anm_w * storage=effect_b_00_weapon_27c_09
@anm_w * storage=effect_b_00_weapon_27c_10
@anm_w * storage=effect_b_00_weapon_27c_11
@anm_w * storage=effect_b_00_weapon_27c_12
@anm_w * storage=effect_b_00_weapon_27c_13
@anm_w * storage=effect_b_00_weapon_27c_14
@anm_w * storage=effect_b_00_weapon_27c_15
@anm_w * storage=effect_b_00_weapon_27c_16
@anm_w * storage=effect_b_00_weapon_27c_17
@anm_w * storage=effect_b_00_weapon_27c_18
@anm_w * storage=effect_b_00_weapon_27c_19
@anm_w * storage=effect_b_00_weapon_27c_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル1_2_青
@macro name="effect_a_00_weapon_28b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_28b_00
@anm_w * storage=effect_a_00_weapon_28b_01
@anm_w * storage=effect_a_00_weapon_28b_02
@anm_w * storage=effect_a_00_weapon_28b_03
@anm_w * storage=effect_a_00_weapon_28b_04
@anm_w * storage=effect_a_00_weapon_28b_05
@anm_w * storage=effect_a_00_weapon_28b_06
@anm_w * storage=effect_a_00_weapon_28b_07
@anm_w * storage=effect_a_00_weapon_28b_08
@anm_w * storage=effect_a_00_weapon_28b_09
@anm_w * storage=effect_a_00_weapon_28b_10
@anm_w * storage=effect_a_00_weapon_28b_11
@anm_w * storage=effect_a_00_weapon_28b_12
@anm_w * storage=effect_a_00_weapon_28b_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル1_2_青
@macro name="effect_b_00_weapon_28b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_28b_00
@anm_w * storage=effect_b_00_weapon_28b_01
@anm_w * storage=effect_b_00_weapon_28b_02
@anm_w * storage=effect_b_00_weapon_28b_03
@anm_w * storage=effect_b_00_weapon_28b_04
@anm_w * storage=effect_b_00_weapon_28b_05
@anm_w * storage=effect_b_00_weapon_28b_06
@anm_w * storage=effect_b_00_weapon_28b_07
@anm_w * storage=effect_b_00_weapon_28b_08
@anm_w * storage=effect_b_00_weapon_28b_09
@anm_w * storage=effect_b_00_weapon_28b_10
@anm_w * storage=effect_b_00_weapon_28b_11
@anm_w * storage=effect_b_00_weapon_28b_12
@anm_w * storage=effect_b_00_weapon_28b_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル2_2(パラライズ)_黄色
@macro name="effect_a_00_weapon_28y"
@anm_q *
@anm_w * storage=effect_a_00_weapon_28y_00
@anm_w * storage=effect_a_00_weapon_28y_01
@anm_w * storage=effect_a_00_weapon_28y_02
@anm_w * storage=effect_a_00_weapon_28y_03
@anm_w * storage=effect_a_00_weapon_28y_04
@anm_w * storage=effect_a_00_weapon_28y_05
@anm_w * storage=effect_a_00_weapon_28y_06
@anm_w * storage=effect_a_00_weapon_28y_07
@anm_w * storage=effect_a_00_weapon_28y_08
@anm_w * storage=effect_a_00_weapon_28y_09
@anm_w * storage=effect_a_00_weapon_28y_10
@anm_w * storage=effect_a_00_weapon_28y_11
@anm_w * storage=effect_a_00_weapon_28y_12
@anm_w * storage=effect_a_00_weapon_28y_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル2_2(パラライズ)_黄色
@macro name="effect_b_00_weapon_28y"
@anm_q *
@anm_w * storage=effect_b_00_weapon_28y_00
@anm_w * storage=effect_b_00_weapon_28y_01
@anm_w * storage=effect_b_00_weapon_28y_02
@anm_w * storage=effect_b_00_weapon_28y_03
@anm_w * storage=effect_b_00_weapon_28y_04
@anm_w * storage=effect_b_00_weapon_28y_05
@anm_w * storage=effect_b_00_weapon_28y_06
@anm_w * storage=effect_b_00_weapon_28y_07
@anm_w * storage=effect_b_00_weapon_28y_08
@anm_w * storage=effect_b_00_weapon_28y_09
@anm_w * storage=effect_b_00_weapon_28y_10
@anm_w * storage=effect_b_00_weapon_28y_11
@anm_w * storage=effect_b_00_weapon_28y_12
@anm_w * storage=effect_b_00_weapon_28y_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル3_2(フリーズ)_水色
@macro name="effect_a_00_weapon_28c"
@anm_q *
@anm_w * storage=effect_a_00_weapon_28c_00
@anm_w * storage=effect_a_00_weapon_28c_01
@anm_w * storage=effect_a_00_weapon_28c_02
@anm_w * storage=effect_a_00_weapon_28c_03
@anm_w * storage=effect_a_00_weapon_28c_04
@anm_w * storage=effect_a_00_weapon_28c_05
@anm_w * storage=effect_a_00_weapon_28c_06
@anm_w * storage=effect_a_00_weapon_28c_07
@anm_w * storage=effect_a_00_weapon_28c_08
@anm_w * storage=effect_a_00_weapon_28c_09
@anm_w * storage=effect_a_00_weapon_28c_10
@anm_w * storage=effect_a_00_weapon_28c_11
@anm_w * storage=effect_a_00_weapon_28c_12
@anm_w * storage=effect_a_00_weapon_28c_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル3_2(フリーズ)_水色
@macro name="effect_b_00_weapon_28c"
@anm_q *
@anm_w * storage=effect_b_00_weapon_28c_00
@anm_w * storage=effect_b_00_weapon_28c_01
@anm_w * storage=effect_b_00_weapon_28c_02
@anm_w * storage=effect_b_00_weapon_28c_03
@anm_w * storage=effect_b_00_weapon_28c_04
@anm_w * storage=effect_b_00_weapon_28c_05
@anm_w * storage=effect_b_00_weapon_28c_06
@anm_w * storage=effect_b_00_weapon_28c_07
@anm_w * storage=effect_b_00_weapon_28c_08
@anm_w * storage=effect_b_00_weapon_28c_09
@anm_w * storage=effect_b_00_weapon_28c_10
@anm_w * storage=effect_b_00_weapon_28c_11
@anm_w * storage=effect_b_00_weapon_28c_12
@anm_w * storage=effect_b_00_weapon_28c_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル4_1(トーピドー)_青
@macro name="effect_a_00_weapon_29b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_29b_00
@anm_w * storage=effect_a_00_weapon_29b_01
@anm_w * storage=effect_a_00_weapon_29b_02
@anm_w * storage=effect_a_00_weapon_29b_03
@anm_w * storage=effect_a_00_weapon_29b_04
@anm_w * storage=effect_a_00_weapon_29b_05
@anm_w * storage=effect_a_00_weapon_29b_06
@anm_w * storage=effect_a_00_weapon_29b_07
@anm_w * storage=effect_a_00_weapon_29b_08
@anm_w * storage=effect_a_00_weapon_29b_09
@anm_w * storage=effect_a_00_weapon_29b_10
@anm_w * storage=effect_a_00_weapon_29b_11
@anm_w * storage=effect_a_00_weapon_29b_12
@anm_w * storage=effect_a_00_weapon_29b_13
@anm_w * storage=effect_a_00_weapon_29b_14
@anm_w * storage=effect_a_00_weapon_29b_15
@anm_w * storage=effect_a_00_weapon_29b_16
@anm_w * storage=effect_a_00_weapon_29b_17
@anm_w * storage=effect_a_00_weapon_29b_18
@anm_w * storage=effect_a_00_weapon_29b_19
@anm_w * storage=effect_a_00_weapon_29b_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル4_1(トーピドー)_青
@macro name="effect_b_00_weapon_29b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_29b_00
@anm_w * storage=effect_b_00_weapon_29b_01
@anm_w * storage=effect_b_00_weapon_29b_02
@anm_w * storage=effect_b_00_weapon_29b_03
@anm_w * storage=effect_b_00_weapon_29b_04
@anm_w * storage=effect_b_00_weapon_29b_05
@anm_w * storage=effect_b_00_weapon_29b_06
@anm_w * storage=effect_b_00_weapon_29b_07
@anm_w * storage=effect_b_00_weapon_29b_08
@anm_w * storage=effect_b_00_weapon_29b_09
@anm_w * storage=effect_b_00_weapon_29b_10
@anm_w * storage=effect_b_00_weapon_29b_11
@anm_w * storage=effect_b_00_weapon_29b_12
@anm_w * storage=effect_b_00_weapon_29b_13
@anm_w * storage=effect_b_00_weapon_29b_14
@anm_w * storage=effect_b_00_weapon_29b_15
@anm_w * storage=effect_b_00_weapon_29b_16
@anm_w * storage=effect_b_00_weapon_29b_17
@anm_w * storage=effect_b_00_weapon_29b_18
@anm_w * storage=effect_b_00_weapon_29b_19
@anm_w * storage=effect_b_00_weapon_29b_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル5_1(トーピドーフリーズ)_水色
@macro name="effect_a_00_weapon_29c"
@anm_q *
@anm_w * storage=effect_a_00_weapon_29c_00
@anm_w * storage=effect_a_00_weapon_29c_01
@anm_w * storage=effect_a_00_weapon_29c_02
@anm_w * storage=effect_a_00_weapon_29c_03
@anm_w * storage=effect_a_00_weapon_29c_04
@anm_w * storage=effect_a_00_weapon_29c_05
@anm_w * storage=effect_a_00_weapon_29c_06
@anm_w * storage=effect_a_00_weapon_29c_07
@anm_w * storage=effect_a_00_weapon_29c_08
@anm_w * storage=effect_a_00_weapon_29c_09
@anm_w * storage=effect_a_00_weapon_29c_10
@anm_w * storage=effect_a_00_weapon_29c_11
@anm_w * storage=effect_a_00_weapon_29c_12
@anm_w * storage=effect_a_00_weapon_29c_13
@anm_w * storage=effect_a_00_weapon_29c_14
@anm_w * storage=effect_a_00_weapon_29c_15
@anm_w * storage=effect_a_00_weapon_29c_16
@anm_w * storage=effect_a_00_weapon_29c_17
@anm_w * storage=effect_a_00_weapon_29c_18
@anm_w * storage=effect_a_00_weapon_29c_19
@anm_w * storage=effect_a_00_weapon_29c_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル5_1(トーピドーフリーズ)_水色
@macro name="effect_b_00_weapon_29c"
@anm_q *
@anm_w * storage=effect_b_00_weapon_29c_00
@anm_w * storage=effect_b_00_weapon_29c_01
@anm_w * storage=effect_b_00_weapon_29c_02
@anm_w * storage=effect_b_00_weapon_29c_03
@anm_w * storage=effect_b_00_weapon_29c_04
@anm_w * storage=effect_b_00_weapon_29c_05
@anm_w * storage=effect_b_00_weapon_29c_06
@anm_w * storage=effect_b_00_weapon_29c_07
@anm_w * storage=effect_b_00_weapon_29c_08
@anm_w * storage=effect_b_00_weapon_29c_09
@anm_w * storage=effect_b_00_weapon_29c_10
@anm_w * storage=effect_b_00_weapon_29c_11
@anm_w * storage=effect_b_00_weapon_29c_12
@anm_w * storage=effect_b_00_weapon_29c_13
@anm_w * storage=effect_b_00_weapon_29c_14
@anm_w * storage=effect_b_00_weapon_29c_15
@anm_w * storage=effect_b_00_weapon_29c_16
@anm_w * storage=effect_b_00_weapon_29c_17
@anm_w * storage=effect_b_00_weapon_29c_18
@anm_w * storage=effect_b_00_weapon_29c_19
@anm_w * storage=effect_b_00_weapon_29c_20
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル4_2(トーピドー)_青
@macro name="effect_a_00_weapon_30b"
@anm_q *
@anm_w * storage=effect_a_00_weapon_30b_00
@anm_w * storage=effect_a_00_weapon_30b_01
@anm_w * storage=effect_a_00_weapon_30b_02
@anm_w * storage=effect_a_00_weapon_30b_03
@anm_w * storage=effect_a_00_weapon_30b_04
@anm_w * storage=effect_a_00_weapon_30b_05
@anm_w * storage=effect_a_00_weapon_30b_06
@anm_w * storage=effect_a_00_weapon_30b_07
@anm_w * storage=effect_a_00_weapon_30b_08
@anm_w * storage=effect_a_00_weapon_30b_09
@anm_w * storage=effect_a_00_weapon_30b_10
@anm_w * storage=effect_a_00_weapon_30b_11
@anm_w * storage=effect_a_00_weapon_30b_12
@anm_w * storage=effect_a_00_weapon_30b_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル4_2(トーピドー)_青
@macro name="effect_b_00_weapon_30b"
@anm_q *
@anm_w * storage=effect_b_00_weapon_30b_00
@anm_w * storage=effect_b_00_weapon_30b_01
@anm_w * storage=effect_b_00_weapon_30b_02
@anm_w * storage=effect_b_00_weapon_30b_03
@anm_w * storage=effect_b_00_weapon_30b_04
@anm_w * storage=effect_b_00_weapon_30b_05
@anm_w * storage=effect_b_00_weapon_30b_06
@anm_w * storage=effect_b_00_weapon_30b_07
@anm_w * storage=effect_b_00_weapon_30b_08
@anm_w * storage=effect_b_00_weapon_30b_09
@anm_w * storage=effect_b_00_weapon_30b_10
@anm_w * storage=effect_b_00_weapon_30b_11
@anm_w * storage=effect_b_00_weapon_30b_12
@anm_w * storage=effect_b_00_weapon_30b_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル5_2(トーピドーフリーズ)_水色
@macro name="effect_a_00_weapon_30c"
@anm_q *
@anm_w * storage=effect_a_00_weapon_30c_00
@anm_w * storage=effect_a_00_weapon_30c_01
@anm_w * storage=effect_a_00_weapon_30c_02
@anm_w * storage=effect_a_00_weapon_30c_03
@anm_w * storage=effect_a_00_weapon_30c_04
@anm_w * storage=effect_a_00_weapon_30c_05
@anm_w * storage=effect_a_00_weapon_30c_06
@anm_w * storage=effect_a_00_weapon_30c_07
@anm_w * storage=effect_a_00_weapon_30c_08
@anm_w * storage=effect_a_00_weapon_30c_09
@anm_w * storage=effect_a_00_weapon_30c_10
@anm_w * storage=effect_a_00_weapon_30c_11
@anm_w * storage=effect_a_00_weapon_30c_12
@anm_w * storage=effect_a_00_weapon_30c_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)エレメンタルミサイル5_2(トーピドーフリーズ)_水色
@macro name="effect_b_00_weapon_30c"
@anm_q *
@anm_w * storage=effect_b_00_weapon_30c_00
@anm_w * storage=effect_b_00_weapon_30c_01
@anm_w * storage=effect_b_00_weapon_30c_02
@anm_w * storage=effect_b_00_weapon_30c_03
@anm_w * storage=effect_b_00_weapon_30c_04
@anm_w * storage=effect_b_00_weapon_30c_05
@anm_w * storage=effect_b_00_weapon_30c_06
@anm_w * storage=effect_b_00_weapon_30c_07
@anm_w * storage=effect_b_00_weapon_30c_08
@anm_w * storage=effect_b_00_weapon_30c_09
@anm_w * storage=effect_b_00_weapon_30c_10
@anm_w * storage=effect_b_00_weapon_30c_11
@anm_w * storage=effect_b_00_weapon_30c_12
@anm_w * storage=effect_b_00_weapon_30c_13
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)γレイバースト_non
@macro name="effect_a_00_weapon_31non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_31non_00
@anm_w * storage=effect_a_00_weapon_31non_01
@anm_w * storage=effect_a_00_weapon_31non_02
@anm_w * storage=effect_a_00_weapon_31non_03
@anm_w * storage=effect_a_00_weapon_31non_04
@anm_w * storage=effect_a_00_weapon_31non_05
@anm_w * storage=effect_a_00_weapon_31non_06
@anm_w * storage=effect_a_00_weapon_31non_07
@anm_w * storage=effect_a_00_weapon_31non_08
@anm_w * storage=effect_a_00_weapon_31non_09
@anm_w * storage=effect_a_00_weapon_31non_10
@anm_w * storage=effect_a_00_weapon_31non_11
@anm_w * storage=effect_a_00_weapon_31non_12
@anm_w * storage=effect_a_00_weapon_31non_13
@anm_w * storage=effect_a_00_weapon_31non_14
@anm_w * storage=effect_a_00_weapon_31non_15
@anm_w * storage=effect_a_00_weapon_31non_16
@anm_w * storage=effect_a_00_weapon_31non_17
@anm_w * storage=effect_a_00_weapon_31non_18
@anm_w * storage=effect_a_00_weapon_31non_19
@anm_w * storage=effect_a_00_weapon_31non_20
@anm_w * storage=effect_a_00_weapon_31non_21
@anm_w * storage=effect_a_00_weapon_31non_22
@anm_w * storage=effect_a_00_weapon_31non_23
@anm_w * storage=effect_a_00_weapon_31non_24
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)γレイバースト_non
@macro name="effect_b_00_weapon_31non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_31non_00
@anm_w * storage=effect_b_00_weapon_31non_01
@anm_w * storage=effect_b_00_weapon_31non_02
@anm_w * storage=effect_b_00_weapon_31non_03
@anm_w * storage=effect_b_00_weapon_31non_04
@anm_w * storage=effect_b_00_weapon_31non_05
@anm_w * storage=effect_b_00_weapon_31non_06
@anm_w * storage=effect_b_00_weapon_31non_07
@anm_w * storage=effect_b_00_weapon_31non_08
@anm_w * storage=effect_b_00_weapon_31non_09
@anm_w * storage=effect_b_00_weapon_31non_10
@anm_w * storage=effect_b_00_weapon_31non_11
@anm_w * storage=effect_b_00_weapon_31non_12
@anm_w * storage=effect_b_00_weapon_31non_13
@anm_w * storage=effect_b_00_weapon_31non_14
@anm_w * storage=effect_b_00_weapon_31non_15
@anm_w * storage=effect_b_00_weapon_31non_16
@anm_w * storage=effect_b_00_weapon_31non_17
@anm_w * storage=effect_b_00_weapon_31non_18
@anm_w * storage=effect_b_00_weapon_31non_19
@anm_w * storage=effect_b_00_weapon_31non_20
@anm_w * storage=effect_b_00_weapon_31non_21
@anm_w * storage=effect_b_00_weapon_31non_22
@anm_w * storage=effect_b_00_weapon_31non_23
@anm_w * storage=effect_b_00_weapon_31non_24
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)γレイバースト大_non
@macro name="effect_a_00_weapon_32non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_32non_00
@anm_w * storage=effect_a_00_weapon_32non_01
@anm_w * storage=effect_a_00_weapon_32non_02
@anm_w * storage=effect_a_00_weapon_32non_03
@anm_w * storage=effect_a_00_weapon_32non_04
@anm_w * storage=effect_a_00_weapon_32non_05
@anm_w * storage=effect_a_00_weapon_32non_06
@anm_w * storage=effect_a_00_weapon_32non_07
@anm_w * storage=effect_a_00_weapon_32non_08
@anm_w * storage=effect_a_00_weapon_32non_09
@anm_w * storage=effect_a_00_weapon_32non_10
@anm_w * storage=effect_a_00_weapon_32non_11
@anm_w * storage=effect_a_00_weapon_32non_12
@anm_w * storage=effect_a_00_weapon_32non_13
@anm_w * storage=effect_a_00_weapon_32non_14
@anm_w * storage=effect_a_00_weapon_32non_15
@anm_w * storage=effect_a_00_weapon_32non_16
@anm_w * storage=effect_a_00_weapon_32non_17
@anm_w * storage=effect_a_00_weapon_32non_18
@anm_w * storage=effect_a_00_weapon_32non_19
@anm_w * storage=effect_a_00_weapon_32non_20
@anm_w * storage=effect_a_00_weapon_32non_21
@anm_w * storage=effect_a_00_weapon_32non_22
@anm_w * storage=effect_a_00_weapon_32non_23
@anm_w * storage=effect_a_00_weapon_32non_24
@anm_w * storage=effect_a_00_weapon_32non_25
@anm_w * storage=effect_a_00_weapon_32non_26
@anm_w * storage=effect_a_00_weapon_32non_27
@anm_w * storage=effect_a_00_weapon_32non_28
@anm_w * storage=effect_a_00_weapon_32non_29
@anm_w * storage=effect_a_00_weapon_32non_30
@anm_w * storage=effect_a_00_weapon_32non_31
@anm_w * storage=effect_a_00_weapon_32non_32
@anm_w * storage=effect_a_00_weapon_32non_33
@anm_d * delete=%delete|true
@endmacro

;(アエリアル)γレイバースト大_non
@macro name="effect_b_00_weapon_32non"
@anm_q *
@anm_w * storage=effect_b_00_weapon_32non_00
@anm_w * storage=effect_b_00_weapon_32non_01
@anm_w * storage=effect_b_00_weapon_32non_02
@anm_w * storage=effect_b_00_weapon_32non_03
@anm_w * storage=effect_b_00_weapon_32non_04
@anm_w * storage=effect_b_00_weapon_32non_05
@anm_w * storage=effect_b_00_weapon_32non_06
@anm_w * storage=effect_b_00_weapon_32non_07
@anm_w * storage=effect_b_00_weapon_32non_08
@anm_w * storage=effect_b_00_weapon_32non_09
@anm_w * storage=effect_b_00_weapon_32non_10
@anm_w * storage=effect_b_00_weapon_32non_11
@anm_w * storage=effect_b_00_weapon_32non_12
@anm_w * storage=effect_b_00_weapon_32non_13
@anm_w * storage=effect_b_00_weapon_32non_14
@anm_w * storage=effect_b_00_weapon_32non_15
@anm_w * storage=effect_b_00_weapon_32non_16
@anm_w * storage=effect_b_00_weapon_32non_17
@anm_w * storage=effect_b_00_weapon_32non_18
@anm_w * storage=effect_b_00_weapon_32non_19
@anm_w * storage=effect_b_00_weapon_32non_20
@anm_w * storage=effect_b_00_weapon_32non_21
@anm_w * storage=effect_b_00_weapon_32non_22
@anm_w * storage=effect_b_00_weapon_32non_23
@anm_w * storage=effect_b_00_weapon_32non_24
@anm_w * storage=effect_b_00_weapon_32non_25
@anm_w * storage=effect_b_00_weapon_32non_26
@anm_w * storage=effect_b_00_weapon_32non_27
@anm_w * storage=effect_b_00_weapon_32non_28
@anm_w * storage=effect_b_00_weapon_32non_29
@anm_w * storage=effect_b_00_weapon_32non_30
@anm_w * storage=effect_b_00_weapon_32non_31
@anm_w * storage=effect_b_00_weapon_32non_32
@anm_w * storage=effect_b_00_weapon_32non_33
@anm_d * delete=%delete|true
@endmacro

;(Queen)レーザー_赤
@macro name="effect_a_00_weapon_33r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_33r_00
@anm_w * storage=effect_a_00_weapon_33r_01
@anm_w * storage=effect_a_00_weapon_33r_02
@anm_w * storage=effect_a_00_weapon_33r_03
@anm_w * storage=effect_a_00_weapon_33r_04
@anm_w * storage=effect_a_00_weapon_33r_05
@anm_w * storage=effect_a_00_weapon_33r_06
@anm_w * storage=effect_a_00_weapon_33r_07
@anm_w * storage=effect_a_00_weapon_33r_08
@anm_w * storage=effect_a_00_weapon_33r_09
@anm_w * storage=effect_a_00_weapon_33r_10
@anm_w * storage=effect_a_00_weapon_33r_11
@anm_w * storage=effect_a_00_weapon_33r_12
@anm_w * storage=effect_a_00_weapon_33r_13
@anm_w * storage=effect_a_00_weapon_33r_14
@anm_w * storage=effect_a_00_weapon_33r_15
@anm_w * storage=effect_a_00_weapon_33r_16
@anm_w * storage=effect_a_00_weapon_33r_17
@anm_w * storage=effect_a_00_weapon_33r_18
@anm_w * storage=effect_a_00_weapon_33r_19
@anm_w * storage=effect_a_00_weapon_33r_20
@anm_w * storage=effect_a_00_weapon_33r_21
@anm_w * storage=effect_a_00_weapon_33r_22
@anm_w * storage=effect_a_00_weapon_33r_23
@anm_d * delete=%delete|true
@endmacro

;(Queen)レーザー_赤
@macro name="effect_b_00_weapon_33r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_33r_00
@anm_w * storage=effect_b_00_weapon_33r_01
@anm_w * storage=effect_b_00_weapon_33r_02
@anm_w * storage=effect_b_00_weapon_33r_03
@anm_w * storage=effect_b_00_weapon_33r_04
@anm_w * storage=effect_b_00_weapon_33r_05
@anm_w * storage=effect_b_00_weapon_33r_06
@anm_w * storage=effect_b_00_weapon_33r_07
@anm_w * storage=effect_b_00_weapon_33r_08
@anm_w * storage=effect_b_00_weapon_33r_09
@anm_w * storage=effect_b_00_weapon_33r_10
@anm_w * storage=effect_b_00_weapon_33r_11
@anm_w * storage=effect_b_00_weapon_33r_12
@anm_w * storage=effect_b_00_weapon_33r_13
@anm_w * storage=effect_b_00_weapon_33r_14
@anm_w * storage=effect_b_00_weapon_33r_15
@anm_w * storage=effect_b_00_weapon_33r_16
@anm_w * storage=effect_b_00_weapon_33r_17
@anm_w * storage=effect_b_00_weapon_33r_18
@anm_w * storage=effect_b_00_weapon_33r_19
@anm_w * storage=effect_b_00_weapon_33r_20
@anm_w * storage=effect_b_00_weapon_33r_21
@anm_w * storage=effect_b_00_weapon_33r_22
@anm_w * storage=effect_b_00_weapon_33r_23
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_刺突_赤
@macro name="effect_a_00_weapon_34r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_34r_00
@anm_w * storage=effect_a_00_weapon_34r_01
@anm_w * storage=effect_a_00_weapon_34r_02
@anm_w * storage=effect_a_00_weapon_34r_03
@anm_w * storage=effect_a_00_weapon_34r_04
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_刺突_赤
@macro name="effect_b_00_weapon_34r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_34r_00
@anm_w * storage=effect_b_00_weapon_34r_01
@anm_w * storage=effect_b_00_weapon_34r_02
@anm_w * storage=effect_b_00_weapon_34r_03
@anm_w * storage=effect_b_00_weapon_34r_04
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)_エレメンタルダガー_赤
@macro name="effect_a_00_weapon_35r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_35r_00
@anm_w * storage=effect_a_00_weapon_35r_01
@anm_w * storage=effect_a_00_weapon_35r_02
@anm_w * storage=effect_a_00_weapon_35r_03
@anm_w * storage=effect_a_00_weapon_35r_04
@anm_w * storage=effect_a_00_weapon_35r_05
@anm_w * storage=effect_a_00_weapon_35r_06
@anm_w * storage=effect_a_00_weapon_35r_07
@anm_w * storage=effect_a_00_weapon_35r_08
@anm_w * storage=effect_a_00_weapon_35r_09
@anm_w * storage=effect_a_00_weapon_35r_10
@anm_w * storage=effect_a_00_weapon_35r_11
@anm_w * storage=effect_a_00_weapon_35r_12
@anm_w * storage=effect_a_00_weapon_35r_13
@anm_w * storage=effect_a_00_weapon_35r_14
@anm_w * storage=effect_a_00_weapon_35r_15
@anm_w * storage=effect_a_00_weapon_35r_16
@anm_w * storage=effect_a_00_weapon_35r_17
@anm_w * storage=effect_a_00_weapon_35r_18
@anm_w * storage=effect_a_00_weapon_35r_19
@anm_w * storage=effect_a_00_weapon_35r_20
@anm_w * storage=effect_a_00_weapon_35r_21
@anm_w * storage=effect_a_00_weapon_35r_22
@anm_w * storage=effect_a_00_weapon_35r_23
@anm_w * storage=effect_a_00_weapon_35r_24
@anm_w * storage=effect_a_00_weapon_35r_25
@anm_w * storage=effect_a_00_weapon_35r_26
@anm_w * storage=effect_a_00_weapon_35r_27
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)_エレメンタルダガー_赤
@macro name="effect_b_00_weapon_35r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_35r_00
@anm_w * storage=effect_b_00_weapon_35r_01
@anm_w * storage=effect_b_00_weapon_35r_02
@anm_w * storage=effect_b_00_weapon_35r_03
@anm_w * storage=effect_b_00_weapon_35r_04
@anm_w * storage=effect_b_00_weapon_35r_05
@anm_w * storage=effect_b_00_weapon_35r_06
@anm_w * storage=effect_b_00_weapon_35r_07
@anm_w * storage=effect_b_00_weapon_35r_08
@anm_w * storage=effect_b_00_weapon_35r_09
@anm_w * storage=effect_b_00_weapon_35r_10
@anm_w * storage=effect_b_00_weapon_35r_11
@anm_w * storage=effect_b_00_weapon_35r_12
@anm_w * storage=effect_b_00_weapon_35r_13
@anm_w * storage=effect_b_00_weapon_35r_14
@anm_w * storage=effect_b_00_weapon_35r_15
@anm_w * storage=effect_b_00_weapon_35r_16
@anm_w * storage=effect_b_00_weapon_35r_17
@anm_w * storage=effect_b_00_weapon_35r_18
@anm_w * storage=effect_b_00_weapon_35r_19
@anm_w * storage=effect_b_00_weapon_35r_20
@anm_w * storage=effect_b_00_weapon_35r_21
@anm_w * storage=effect_b_00_weapon_35r_22
@anm_w * storage=effect_b_00_weapon_35r_23
@anm_w * storage=effect_b_00_weapon_35r_24
@anm_w * storage=effect_b_00_weapon_35r_25
@anm_w * storage=effect_b_00_weapon_35r_26
@anm_w * storage=effect_b_00_weapon_35r_27
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_横_赤
@macro name="effect_a_00_weapon_36r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_36r_00
@anm_w * storage=effect_a_00_weapon_36r_01
@anm_w * storage=effect_a_00_weapon_36r_02
@anm_w * storage=effect_a_00_weapon_36r_03
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_横_赤
@macro name="effect_b_00_weapon_36r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_36r_00
@anm_w * storage=effect_b_00_weapon_36r_01
@anm_w * storage=effect_b_00_weapon_36r_02
@anm_w * storage=effect_b_00_weapon_36r_03
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_三連撃_赤
@macro name="effect_a_00_weapon_37r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_37r_00
@anm_w * storage=effect_a_00_weapon_37r_01
@anm_w * storage=effect_a_00_weapon_37r_02
@anm_w * storage=effect_a_00_weapon_37r_03
@anm_w * storage=effect_a_00_weapon_37r_04
@anm_w * storage=effect_a_00_weapon_37r_05
@anm_w * storage=effect_a_00_weapon_37r_06
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_三連撃_赤
@macro name="effect_b_00_weapon_37r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_37r_00
@anm_w * storage=effect_b_00_weapon_37r_01
@anm_w * storage=effect_b_00_weapon_37r_02
@anm_w * storage=effect_b_00_weapon_37r_03
@anm_w * storage=effect_b_00_weapon_37r_04
@anm_w * storage=effect_b_00_weapon_37r_05
@anm_w * storage=effect_b_00_weapon_37r_06
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_二つ振り下ろし_赤
@macro name="effect_a_00_weapon_38r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_38r_00
@anm_w * storage=effect_a_00_weapon_38r_01
@anm_w * storage=effect_a_00_weapon_38r_02
@anm_w * storage=effect_a_00_weapon_38r_03
@anm_w * storage=effect_a_00_weapon_38r_04
@anm_w * storage=effect_a_00_weapon_38r_05
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_二つ振り下ろし_赤
@macro name="effect_b_00_weapon_38r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_38r_00
@anm_w * storage=effect_b_00_weapon_38r_01
@anm_w * storage=effect_b_00_weapon_38r_02
@anm_w * storage=effect_b_00_weapon_38r_03
@anm_w * storage=effect_b_00_weapon_38r_04
@anm_w * storage=effect_b_00_weapon_38r_05
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_二つ振り下ろし_空振り_赤
@macro name="effect_a_00_weapon_39r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_39r_00
@anm_w * storage=effect_a_00_weapon_39r_01
@anm_w * storage=effect_a_00_weapon_39r_02
@anm_w * storage=effect_a_00_weapon_39r_03
@anm_w * storage=effect_a_00_weapon_39r_04
@anm_w * storage=effect_a_00_weapon_39r_05
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルダガー_二つ振り下ろし_空振り_赤
@macro name="effect_b_00_weapon_39r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_39r_00
@anm_w * storage=effect_b_00_weapon_39r_01
@anm_w * storage=effect_b_00_weapon_39r_02
@anm_w * storage=effect_b_00_weapon_39r_03
@anm_w * storage=effect_b_00_weapon_39r_04
@anm_w * storage=effect_b_00_weapon_39r_05
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルミサイル1_1_赤
@macro name="effect_a_00_weapon_40r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_40r_00
@anm_w * storage=effect_a_00_weapon_40r_01
@anm_w * storage=effect_a_00_weapon_40r_02
@anm_w * storage=effect_a_00_weapon_40r_03
@anm_w * storage=effect_a_00_weapon_40r_04
@anm_w * storage=effect_a_00_weapon_40r_05
@anm_w * storage=effect_a_00_weapon_40r_06
@anm_w * storage=effect_a_00_weapon_40r_07
@anm_w * storage=effect_a_00_weapon_40r_08
@anm_w * storage=effect_a_00_weapon_40r_09
@anm_w * storage=effect_a_00_weapon_40r_10
@anm_w * storage=effect_a_00_weapon_40r_11
@anm_w * storage=effect_a_00_weapon_40r_12
@anm_w * storage=effect_a_00_weapon_40r_13
@anm_w * storage=effect_a_00_weapon_40r_14
@anm_w * storage=effect_a_00_weapon_40r_15
@anm_w * storage=effect_a_00_weapon_40r_16
@anm_w * storage=effect_a_00_weapon_40r_17
@anm_w * storage=effect_a_00_weapon_40r_18
@anm_w * storage=effect_a_00_weapon_40r_19
@anm_w * storage=effect_a_00_weapon_40r_20
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルミサイル1_1_赤
@macro name="effect_b_00_weapon_40r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_40r_00
@anm_w * storage=effect_b_00_weapon_40r_01
@anm_w * storage=effect_b_00_weapon_40r_02
@anm_w * storage=effect_b_00_weapon_40r_03
@anm_w * storage=effect_b_00_weapon_40r_04
@anm_w * storage=effect_b_00_weapon_40r_05
@anm_w * storage=effect_b_00_weapon_40r_06
@anm_w * storage=effect_b_00_weapon_40r_07
@anm_w * storage=effect_b_00_weapon_40r_08
@anm_w * storage=effect_b_00_weapon_40r_09
@anm_w * storage=effect_b_00_weapon_40r_10
@anm_w * storage=effect_b_00_weapon_40r_11
@anm_w * storage=effect_b_00_weapon_40r_12
@anm_w * storage=effect_b_00_weapon_40r_13
@anm_w * storage=effect_b_00_weapon_40r_14
@anm_w * storage=effect_b_00_weapon_40r_15
@anm_w * storage=effect_b_00_weapon_40r_16
@anm_w * storage=effect_b_00_weapon_40r_17
@anm_w * storage=effect_b_00_weapon_40r_18
@anm_w * storage=effect_b_00_weapon_40r_19
@anm_w * storage=effect_b_00_weapon_40r_20
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルミサイル2_2_赤
@macro name="effect_a_00_weapon_41r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_41r_00
@anm_w * storage=effect_a_00_weapon_41r_01
@anm_w * storage=effect_a_00_weapon_41r_02
@anm_w * storage=effect_a_00_weapon_41r_03
@anm_w * storage=effect_a_00_weapon_41r_04
@anm_w * storage=effect_a_00_weapon_41r_05
@anm_w * storage=effect_a_00_weapon_41r_06
@anm_w * storage=effect_a_00_weapon_41r_07
@anm_w * storage=effect_a_00_weapon_41r_08
@anm_w * storage=effect_a_00_weapon_41r_09
@anm_w * storage=effect_a_00_weapon_41r_10
@anm_w * storage=effect_a_00_weapon_41r_11
@anm_w * storage=effect_a_00_weapon_41r_12
@anm_w * storage=effect_a_00_weapon_41r_13
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)エレメンタルミサイル2_2_赤
@macro name="effect_b_00_weapon_41r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_41r_00
@anm_w * storage=effect_b_00_weapon_41r_01
@anm_w * storage=effect_b_00_weapon_41r_02
@anm_w * storage=effect_b_00_weapon_41r_03
@anm_w * storage=effect_b_00_weapon_41r_04
@anm_w * storage=effect_b_00_weapon_41r_05
@anm_w * storage=effect_b_00_weapon_41r_06
@anm_w * storage=effect_b_00_weapon_41r_07
@anm_w * storage=effect_b_00_weapon_41r_08
@anm_w * storage=effect_b_00_weapon_41r_09
@anm_w * storage=effect_b_00_weapon_41r_10
@anm_w * storage=effect_b_00_weapon_41r_11
@anm_w * storage=effect_b_00_weapon_41r_12
@anm_w * storage=effect_b_00_weapon_41r_13
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)レーザー_赤
@macro name="effect_a_00_weapon_42r"
@anm_q *
@anm_w * storage=effect_a_00_weapon_42r_00
@anm_w * storage=effect_a_00_weapon_42r_01
@anm_w * storage=effect_a_00_weapon_42r_02
@anm_w * storage=effect_a_00_weapon_42r_03
@anm_w * storage=effect_a_00_weapon_42r_04
@anm_w * storage=effect_a_00_weapon_42r_05
@anm_w * storage=effect_a_00_weapon_42r_06
@anm_w * storage=effect_a_00_weapon_42r_07
@anm_w * storage=effect_a_00_weapon_42r_08
@anm_w * storage=effect_a_00_weapon_42r_09
@anm_w * storage=effect_a_00_weapon_42r_10
@anm_w * storage=effect_a_00_weapon_42r_11
@anm_w * storage=effect_a_00_weapon_42r_12
@anm_w * storage=effect_a_00_weapon_42r_13
@anm_w * storage=effect_a_00_weapon_42r_14
@anm_w * storage=effect_a_00_weapon_42r_15
@anm_w * storage=effect_a_00_weapon_42r_16
@anm_w * storage=effect_a_00_weapon_42r_17
@anm_w * storage=effect_a_00_weapon_42r_18
@anm_d * delete=%delete|true
@endmacro

;(Queen's Guard)レーザー_赤
@macro name="effect_b_00_weapon_42r"
@anm_q *
@anm_w * storage=effect_b_00_weapon_42r_00
@anm_w * storage=effect_b_00_weapon_42r_01
@anm_w * storage=effect_b_00_weapon_42r_02
@anm_w * storage=effect_b_00_weapon_42r_03
@anm_w * storage=effect_b_00_weapon_42r_04
@anm_w * storage=effect_b_00_weapon_42r_05
@anm_w * storage=effect_b_00_weapon_42r_06
@anm_w * storage=effect_b_00_weapon_42r_07
@anm_w * storage=effect_b_00_weapon_42r_08
@anm_w * storage=effect_b_00_weapon_42r_09
@anm_w * storage=effect_b_00_weapon_42r_10
@anm_w * storage=effect_b_00_weapon_42r_11
@anm_w * storage=effect_b_00_weapon_42r_12
@anm_w * storage=effect_b_00_weapon_42r_13
@anm_w * storage=effect_b_00_weapon_42r_14
@anm_w * storage=effect_b_00_weapon_42r_15
@anm_w * storage=effect_b_00_weapon_42r_16
@anm_w * storage=effect_b_00_weapon_42r_17
@anm_w * storage=effect_b_00_weapon_42r_18
@anm_d * delete=%delete|true
@endmacro

;(クラーケン)レーザー_緑
@macro name="effect_a_00_weapon_43g"
@anm_q *
@anm_w * storage=effect_a_00_weapon_43g_00
@anm_w * storage=effect_a_00_weapon_43g_01
@anm_w * storage=effect_a_00_weapon_43g_02
@anm_w * storage=effect_a_00_weapon_43g_03
@anm_w * storage=effect_a_00_weapon_43g_04
@anm_w * storage=effect_a_00_weapon_43g_05
@anm_w * storage=effect_a_00_weapon_43g_06
@anm_w * storage=effect_a_00_weapon_43g_07
@anm_w * storage=effect_a_00_weapon_43g_08
@anm_w * storage=effect_a_00_weapon_43g_09
@anm_w * storage=effect_a_00_weapon_43g_10
@anm_w * storage=effect_a_00_weapon_43g_11
@anm_w * storage=effect_a_00_weapon_43g_12
@anm_w * storage=effect_a_00_weapon_43g_13
@anm_w * storage=effect_a_00_weapon_43g_14
@anm_w * storage=effect_a_00_weapon_43g_15
@anm_w * storage=effect_a_00_weapon_43g_16
@anm_w * storage=effect_a_00_weapon_43g_17
@anm_w * storage=effect_a_00_weapon_43g_18
@anm_w * storage=effect_a_00_weapon_43g_19
@anm_w * storage=effect_a_00_weapon_43g_20
@anm_w * storage=effect_a_00_weapon_43g_21
@anm_w * storage=effect_a_00_weapon_43g_22
@anm_w * storage=effect_a_00_weapon_43g_23
@anm_d * delete=%delete|true
@endmacro

;(クラーケン)レーザー_緑
@macro name="effect_b_00_weapon_43g"
@anm_q *
@anm_w * storage=effect_b_00_weapon_43g_00
@anm_w * storage=effect_b_00_weapon_43g_01
@anm_w * storage=effect_b_00_weapon_43g_02
@anm_w * storage=effect_b_00_weapon_43g_03
@anm_w * storage=effect_b_00_weapon_43g_04
@anm_w * storage=effect_b_00_weapon_43g_05
@anm_w * storage=effect_b_00_weapon_43g_06
@anm_w * storage=effect_b_00_weapon_43g_07
@anm_w * storage=effect_b_00_weapon_43g_08
@anm_w * storage=effect_b_00_weapon_43g_09
@anm_w * storage=effect_b_00_weapon_43g_10
@anm_w * storage=effect_b_00_weapon_43g_11
@anm_w * storage=effect_b_00_weapon_43g_12
@anm_w * storage=effect_b_00_weapon_43g_13
@anm_w * storage=effect_b_00_weapon_43g_14
@anm_w * storage=effect_b_00_weapon_43g_15
@anm_w * storage=effect_b_00_weapon_43g_16
@anm_w * storage=effect_b_00_weapon_43g_17
@anm_w * storage=effect_b_00_weapon_43g_18
@anm_w * storage=effect_b_00_weapon_43g_19
@anm_w * storage=effect_b_00_weapon_43g_20
@anm_w * storage=effect_b_00_weapon_43g_21
@anm_w * storage=effect_b_00_weapon_43g_22
@anm_w * storage=effect_b_00_weapon_43g_23
@anm_d * delete=%delete|true
@endmacro

;(???)エレメンタルダガー_刺突_non
@macro name="effect_a_00_weapon_44non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_44non_00
@anm_w * storage=effect_a_00_weapon_44non_01
@anm_w * storage=effect_a_00_weapon_44non_02
@anm_w * storage=effect_a_00_weapon_44non_03
@anm_w * storage=effect_a_00_weapon_44non_04
@anm_w * storage=effect_a_00_weapon_44non_05
@anm_d * delete=%delete|true
@endmacro

;(???)レーザー_non
@macro name="effect_a_00_weapon_45non"
@anm_q *
@anm_w * storage=effect_a_00_weapon_45non_00
@anm_w * storage=effect_a_00_weapon_45non_01
@anm_w * storage=effect_a_00_weapon_45non_02
@anm_w * storage=effect_a_00_weapon_45non_03
@anm_w * storage=effect_a_00_weapon_45non_04
@anm_w * storage=effect_a_00_weapon_45non_05
@anm_w * storage=effect_a_00_weapon_45non_06
@anm_w * storage=effect_a_00_weapon_45non_07
@anm_w * storage=effect_a_00_weapon_45non_08
@anm_w * storage=effect_a_00_weapon_45non_09
@anm_w * storage=effect_a_00_weapon_45non_10
@anm_w * storage=effect_a_00_weapon_45non_11
@anm_w * storage=effect_a_00_weapon_45non_12
@anm_w * storage=effect_a_00_weapon_45non_13
@anm_w * storage=effect_a_00_weapon_45non_14
@anm_w * storage=effect_a_00_weapon_45non_15
@anm_w * storage=effect_a_00_weapon_45non_16
@anm_w * storage=effect_a_00_weapon_45non_17
@anm_w * storage=effect_a_00_weapon_45non_18
@anm_w * storage=effect_a_00_weapon_45non_19
@anm_w * storage=effect_a_00_weapon_45non_20
@anm_w * storage=effect_a_00_weapon_45non_21
@anm_w * storage=effect_a_00_weapon_45non_22
@anm_w * storage=effect_a_00_weapon_45non_23
@anm_d * delete=%delete|true
@endmacro


;############################################################
; 必殺技
;############################################################

;(イヅナ)一から十二の数字_non
@macro name="effect_a_00_deadlyskill_00non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_00non_00
@anm_w * storage=effect_a_00_deadlyskill_00non_01
@anm_w * storage=effect_a_00_deadlyskill_00non_02
@anm_w * storage=effect_a_00_deadlyskill_00non_03
@anm_w * storage=effect_a_00_deadlyskill_00non_04
@anm_w * storage=effect_a_00_deadlyskill_00non_05
@anm_w * storage=effect_a_00_deadlyskill_00non_06
@anm_w * storage=effect_a_00_deadlyskill_00non_07
@anm_w * storage=effect_a_00_deadlyskill_00non_08
@anm_w * storage=effect_a_00_deadlyskill_00non_09
@anm_w * storage=effect_a_00_deadlyskill_00non_10
@anm_w * storage=effect_a_00_deadlyskill_00non_11
@anm_w * storage=effect_a_00_deadlyskill_00non_12
@anm_w * storage=effect_a_00_deadlyskill_00non_13
@anm_w * storage=effect_a_00_deadlyskill_00non_14
@anm_w * storage=effect_a_00_deadlyskill_00non_15
@anm_w * storage=effect_a_00_deadlyskill_00non_16
@anm_w * storage=effect_a_00_deadlyskill_00non_17
@anm_w * storage=effect_a_00_deadlyskill_00non_18
@anm_w * storage=effect_a_00_deadlyskill_00non_19
@anm_w * storage=effect_a_00_deadlyskill_00non_20
@anm_w * storage=effect_a_00_deadlyskill_00non_21
@anm_w * storage=effect_a_00_deadlyskill_00non_22
@anm_w * storage=effect_a_00_deadlyskill_00non_23
@anm_w * storage=effect_a_00_deadlyskill_00non_24
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)一から十二の数字_non
@macro name="effect_b_00_deadlyskill_00non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_00non_00
@anm_w * storage=effect_b_00_deadlyskill_00non_01
@anm_w * storage=effect_b_00_deadlyskill_00non_02
@anm_w * storage=effect_b_00_deadlyskill_00non_03
@anm_w * storage=effect_b_00_deadlyskill_00non_04
@anm_w * storage=effect_b_00_deadlyskill_00non_05
@anm_w * storage=effect_b_00_deadlyskill_00non_06
@anm_w * storage=effect_b_00_deadlyskill_00non_07
@anm_w * storage=effect_b_00_deadlyskill_00non_08
@anm_w * storage=effect_b_00_deadlyskill_00non_09
@anm_w * storage=effect_b_00_deadlyskill_00non_10
@anm_w * storage=effect_b_00_deadlyskill_00non_11
@anm_w * storage=effect_b_00_deadlyskill_00non_12
@anm_w * storage=effect_b_00_deadlyskill_00non_13
@anm_w * storage=effect_b_00_deadlyskill_00non_14
@anm_w * storage=effect_b_00_deadlyskill_00non_15
@anm_w * storage=effect_b_00_deadlyskill_00non_16
@anm_w * storage=effect_b_00_deadlyskill_00non_17
@anm_w * storage=effect_b_00_deadlyskill_00non_18
@anm_w * storage=effect_b_00_deadlyskill_00non_19
@anm_w * storage=effect_b_00_deadlyskill_00non_20
@anm_w * storage=effect_b_00_deadlyskill_00non_21
@anm_w * storage=effect_b_00_deadlyskill_00non_22
@anm_w * storage=effect_b_00_deadlyskill_00non_23
@anm_w * storage=effect_b_00_deadlyskill_00non_24
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)魂振鼬神楽_non
@macro name="effect_a_00_deadlyskill_01non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_01non_00
@anm_w * storage=effect_a_00_deadlyskill_01non_01
@anm_w * storage=effect_a_00_deadlyskill_01non_02
@anm_w * storage=effect_a_00_deadlyskill_01non_03
@anm_w * storage=effect_a_00_deadlyskill_01non_04
@anm_w * storage=effect_a_00_deadlyskill_01non_05
@anm_w * storage=effect_a_00_deadlyskill_01non_06
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)魂振鼬神楽_non
@macro name="effect_b_00_deadlyskill_01non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_01non_00
@anm_w * storage=effect_b_00_deadlyskill_01non_01
@anm_w * storage=effect_b_00_deadlyskill_01non_02
@anm_w * storage=effect_b_00_deadlyskill_01non_03
@anm_w * storage=effect_b_00_deadlyskill_01non_04
@anm_w * storage=effect_b_00_deadlyskill_01non_05
@anm_w * storage=effect_b_00_deadlyskill_01non_06
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)重ね破鋼斬_non
@macro name="effect_a_00_deadlyskill_02non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_02non_00
@anm_w * storage=effect_a_00_deadlyskill_02non_01
@anm_w * storage=effect_a_00_deadlyskill_02non_02
@anm_w * storage=effect_a_00_deadlyskill_02non_03
@anm_w * storage=effect_a_00_deadlyskill_02non_04
@anm_w * storage=effect_a_00_deadlyskill_02non_05
@anm_w * storage=effect_a_00_deadlyskill_02non_06
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)重ね破鋼斬_non
@macro name="effect_b_00_deadlyskill_02non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_02non_00
@anm_w * storage=effect_b_00_deadlyskill_02non_01
@anm_w * storage=effect_b_00_deadlyskill_02non_02
@anm_w * storage=effect_b_00_deadlyskill_02non_03
@anm_w * storage=effect_b_00_deadlyskill_02non_04
@anm_w * storage=effect_b_00_deadlyskill_02non_05
@anm_w * storage=effect_b_00_deadlyskill_02non_06
@anm_w * storage=effect_b_00_deadlyskill_02non_07
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)重ね破鋼斬_横_non
@macro name="effect_a_00_deadlyskill_03non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_03non_00
@anm_w * storage=effect_a_00_deadlyskill_03non_01
@anm_w * storage=effect_a_00_deadlyskill_03non_02
@anm_w * storage=effect_a_00_deadlyskill_03non_03
@anm_w * storage=effect_a_00_deadlyskill_03non_04
@anm_w * storage=effect_a_00_deadlyskill_03non_05
@anm_w * storage=effect_a_00_deadlyskill_03non_06
@anm_w * storage=effect_a_00_deadlyskill_03non_07
@anm_w * storage=effect_a_00_deadlyskill_03non_08
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)重ね破鋼斬_横_non
@macro name="effect_b_00_deadlyskill_03non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_03non_00
@anm_w * storage=effect_b_00_deadlyskill_03non_01
@anm_w * storage=effect_b_00_deadlyskill_03non_02
@anm_w * storage=effect_b_00_deadlyskill_03non_03
@anm_w * storage=effect_b_00_deadlyskill_03non_04
@anm_w * storage=effect_b_00_deadlyskill_03non_05
@anm_w * storage=effect_b_00_deadlyskill_03non_06
@anm_w * storage=effect_b_00_deadlyskill_03non_07
@anm_w * storage=effect_b_00_deadlyskill_03non_08
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)破鋼斬_non
@macro name="effect_a_00_deadlyskill_04non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_04non_00
@anm_w * storage=effect_a_00_deadlyskill_04non_01
@anm_w * storage=effect_a_00_deadlyskill_04non_02
@anm_w * storage=effect_a_00_deadlyskill_04non_03
@anm_w * storage=effect_a_00_deadlyskill_04non_04
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)破鋼斬_non
@macro name="effect_b_00_deadlyskill_04non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_04non_00
@anm_w * storage=effect_b_00_deadlyskill_04non_01
@anm_w * storage=effect_b_00_deadlyskill_04non_02
@anm_w * storage=effect_b_00_deadlyskill_04non_03
@anm_w * storage=effect_b_00_deadlyskill_04non_04
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)姫川流 氷雨削ぎ_non
@macro name="effect_a_00_deadlyskill_05non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_05non_00
@anm_w * storage=effect_a_00_deadlyskill_05non_01
@anm_w * storage=effect_a_00_deadlyskill_05non_02
@anm_w * storage=effect_a_00_deadlyskill_05non_03
@anm_w * storage=effect_a_00_deadlyskill_05non_04
@anm_w * storage=effect_a_00_deadlyskill_05non_05
@anm_w * storage=effect_a_00_deadlyskill_05non_06
@anm_w * storage=effect_a_00_deadlyskill_05non_07
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)姫川流 氷雨削ぎ_non
@macro name="effect_b_00_deadlyskill_05non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_05non_00
@anm_w * storage=effect_b_00_deadlyskill_05non_01
@anm_w * storage=effect_b_00_deadlyskill_05non_02
@anm_w * storage=effect_b_00_deadlyskill_05non_03
@anm_w * storage=effect_b_00_deadlyskill_05non_04
@anm_w * storage=effect_b_00_deadlyskill_05non_05
@anm_w * storage=effect_b_00_deadlyskill_05non_06
@anm_w * storage=effect_b_00_deadlyskill_05non_07
@anm_w * storage=effect_b_00_deadlyskill_05non_08
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)砲突一閃_non
@macro name="effect_a_00_deadlyskill_06non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_06non_00
@anm_w * storage=effect_a_00_deadlyskill_06non_01
@anm_w * storage=effect_a_00_deadlyskill_06non_02
@anm_w * storage=effect_a_00_deadlyskill_06non_03
@anm_w * storage=effect_a_00_deadlyskill_06non_04
@anm_w * storage=effect_a_00_deadlyskill_06non_05
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)砲突一閃_non
@macro name="effect_b_00_deadlyskill_06non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_06non_00
@anm_w * storage=effect_b_00_deadlyskill_06non_01
@anm_w * storage=effect_b_00_deadlyskill_06non_02
@anm_w * storage=effect_b_00_deadlyskill_06non_03
@anm_w * storage=effect_b_00_deadlyskill_06non_04
@anm_w * storage=effect_b_00_deadlyskill_06non_05
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)乱空氷雨削ぎ_non
@macro name="effect_a_00_deadlyskill_07non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_07non_00
@anm_w * storage=effect_a_00_deadlyskill_07non_01
@anm_w * storage=effect_a_00_deadlyskill_07non_02
@anm_w * storage=effect_a_00_deadlyskill_07non_03
@anm_w * storage=effect_a_00_deadlyskill_07non_04
@anm_w * storage=effect_a_00_deadlyskill_07non_05
@anm_w * storage=effect_a_00_deadlyskill_07non_06
@anm_w * storage=effect_a_00_deadlyskill_07non_07
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)乱空氷雨削ぎ_non
@macro name="effect_b_00_deadlyskill_07non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_07non_00
@anm_w * storage=effect_b_00_deadlyskill_07non_01
@anm_w * storage=effect_b_00_deadlyskill_07non_02
@anm_w * storage=effect_b_00_deadlyskill_07non_03
@anm_w * storage=effect_b_00_deadlyskill_07non_04
@anm_w * storage=effect_b_00_deadlyskill_07non_05
@anm_w * storage=effect_b_00_deadlyskill_07non_06
@anm_w * storage=effect_b_00_deadlyskill_07non_07
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)六角流 天地斬_non
@macro name="effect_a_00_deadlyskill_08non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_08non_00
@anm_w * storage=effect_a_00_deadlyskill_08non_01
@anm_w * storage=effect_a_00_deadlyskill_08non_02
@anm_w * storage=effect_a_00_deadlyskill_08non_03
@anm_w * storage=effect_a_00_deadlyskill_08non_04
@anm_w * storage=effect_a_00_deadlyskill_08non_05
@anm_w * storage=effect_a_00_deadlyskill_08non_06
@anm_w * storage=effect_a_00_deadlyskill_08non_07
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)六角流 天地斬_non
@macro name="effect_b_00_deadlyskill_08non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_08non_00
@anm_w * storage=effect_b_00_deadlyskill_08non_01
@anm_w * storage=effect_b_00_deadlyskill_08non_02
@anm_w * storage=effect_b_00_deadlyskill_08non_03
@anm_w * storage=effect_b_00_deadlyskill_08non_04
@anm_w * storage=effect_b_00_deadlyskill_08non_05
@anm_w * storage=effect_b_00_deadlyskill_08non_06
@anm_w * storage=effect_b_00_deadlyskill_08non_07
@anm_w * storage=effect_b_00_deadlyskill_08non_08
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)飯綱十三衝_non
@macro name="effect_a_00_deadlyskill_09non"
@anm_q *
@anm_w * storage=effect_a_00_deadlyskill_09non_00
@anm_w * storage=effect_a_00_deadlyskill_09non_01
@anm_w * storage=effect_a_00_deadlyskill_09non_02
@anm_w * storage=effect_a_00_deadlyskill_09non_03
@anm_w * storage=effect_a_00_deadlyskill_09non_04
@anm_w * storage=effect_a_00_deadlyskill_09non_05
@anm_w * storage=effect_a_00_deadlyskill_09non_06
@anm_w * storage=effect_a_00_deadlyskill_09non_07
@anm_w * storage=effect_a_00_deadlyskill_09non_08
@anm_d * delete=%delete|true
@endmacro

;(イヅナ)飯綱十三衝_non
@macro name="effect_b_00_deadlyskill_09non"
@anm_q *
@anm_w * storage=effect_b_00_deadlyskill_09non_00
@anm_w * storage=effect_b_00_deadlyskill_09non_01
@anm_w * storage=effect_b_00_deadlyskill_09non_02
@anm_w * storage=effect_b_00_deadlyskill_09non_03
@anm_w * storage=effect_b_00_deadlyskill_09non_04
@anm_w * storage=effect_b_00_deadlyskill_09non_05
@anm_w * storage=effect_b_00_deadlyskill_09non_06
@anm_w * storage=effect_b_00_deadlyskill_09non_07
@anm_w * storage=effect_b_00_deadlyskill_09non_08
@anm_d * delete=%delete|true
@endmacro



;//■エフェクトのマクロ
@return
;//特殊
;@anm_w * storage=effect_b_移動green
;@anm_w * storage=effect_b_移動red
;@anm_w * storage=effect_b_移動white
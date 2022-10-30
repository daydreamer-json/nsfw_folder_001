; コンバートモードではKAG用の初期化は不要
[macro name=initbase]
[init nostopbgm=%nostopbgm]
[stopquake]
[endmacro]

; ムービー再生のsflagはコンバートモード時のみ有効
[macro name=movieflag][sflag name=%name][endmacro]

[call storage=macro.ks target=*common_macro]

@loadcell
@loop
;
@macro name=copyone
@copy dx=0 dy=0 sx=%x sy=0 sw=35 sh=35
@wait time=100
@endmacro
;
*loop

@copyone x=0
@copyone x=35

@jump target="*loop"

@loadcell
@loop
;
@macro name=copyone
@copy dx=0 dy=0 sx=%x sy=0 sw=35 sh=35
@wait time=100
@endmacro
;

*loop
@copyone x=35
@copyone x=70
@copyone x=105
@copyone x=140
@copyone x=175
@copyone x=210
@copyone x=245
@copyone x=280
@copyone x=315
@copyone x=0
@jump target="*loop"

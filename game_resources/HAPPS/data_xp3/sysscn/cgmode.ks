;
; CGモード
;

*start
	[syshook name="cgmode.start"]
	[rclick enabled=false jump=false]
	[dialog name=cgmode]
;;	[jump target=*open]

*open
	[stoptrans]
	[backlay]

	[syshook name="cgmode.open.init"]
	[syspage uiload page=back]

	[systrans name="cgmode.open" method=crossfade time=300]
	[wt]
	[jump target=*page_done]

*page
	[stoptrans]
	[backlay]

	[syshook name="cgmode.page.init"]
	[syspage uiload page=back]
	[dialog action=lockView]

	[systrans name="cgmode.page" method=crossfade time=300]
	[wt]
*page_done
	[dialog action=hideView]
	[syspage current page=fore]
	[rclick enabled jump storage="" target=*back_rclick]

	[syshook name="cgmode.page.done"]
*wait
	[s]
	[s]

*view
	[dialog action=initView]
	[syshook name="cgmode.view.init"]
	[rclick enabled jump storage="" target=*view_rclick]
	[locklink]

*viewloop
	[jump target=*view_quit cond=Current.propget("isQuitViewLoop")]
	[stoptrans]
	[backlay]

	[dialog action=view]
	[jump target=*localtrans cond=Current.propget("useLocalTrans")]
	[systrans		 name="cgmode.view" method=crossfade time=300]
	[jump target=*viewtrans]
*localtrans
	[systrans layer='&"message"+Current.propget("localTransMsgNum")' name="cgmode.view" method=crossfade time=300]
*viewtrans
	[wt]

	[syspage current page=fore]
	[dialog action=focusView]
	[s]
*view_next
	[syshook name="cgmode.view.next"]
	[sysse name="cgmode.next"  cond=!Current.propget("isCancelView")]
	[sysse name="cgmode.cancel" cond=Current.propget("isCancelView")]
	[jump target=*viewloop]

*view_rclick
	[syshook name="cgmode.view.cancel"]
	[sysse name="cgmode.cancel"]
*view_quit
	[clickskip enabled=true]
	[syshook name="cgmode.view.quit"]
	[jump target=*page cond=!Current.propget("useLocalTrans")]
	[dialog action=hideView backonly]
	[systrans layer='&"message"+Current.propget("localTransMsgNum")' name="cgmode.hide" method=crossfade time=300]
	[wt]
	[unlocklink]
	[jump target=*page_done]

*back_rclick
	; 右クリック効果音
	[sysse name="cgmode.rclick"]
*back
	[dialog action=hideBack]
	[syshook name="cgmode.back"]
	[sysjump from="cgmode" to="title" back]

*scenemode
	[sysjump from="cgmode" to="scenemode"]

*soundmode
	[sysjump from="cgmode" to="soundmode"]

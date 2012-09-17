"#########################################################################
"# syntax/vo_base.vim: VimOutliner syntax highlighting
"# version 0.3.7
"#   Copyright (C) 2001,2003 by Steve Litt (slitt@troubleshooters.com)
"#
"#   This program is free software; you can redistribute it and/or modify
"#   it under the terms of the GNU General Public License as published by
"#   the Free Software Foundation; either version 2 of the License, or
"#   (at your option) any later version.
"#
"#   This program is distributed in the hope that it will be useful,
"#   but WITHOUT ANY WARRANTY; without even the implied warranty of
"#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"#   GNU General Public License for more details.
"#
"#   You should have received a copy of the GNU General Public License
"#   along with this program; if not, write to the Free Software
"#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
"#
"# Steve Litt, slitt@troubleshooters.com, http://www.troubleshooters.com
"#########################################################################

" HISTORY {{{1
"#########################################################################
"#  V0.1.0 Pre-alpha
"#      Set of outliner friendly settings
"# Steve Litt, 5/28/2001
"# End of version 0.1.0
"# 
"#  V0.1.1 Pre-alpha
"#      No change
"# 
"# Steve Litt, 5/28/2001
"# End of version 0.1.1
"# 
"#  V0.1.2 Pre-alpha
"# 	No Change
"# Steve Litt, 5/30/2001
"# End of version 0.1.2
"#  V0.1.3 Pre-alpha
"# 	No Change
"# Steve Litt, 5/30/2001
"# End of version 0.1.3
"#  V0.2.0 
"# 	Noel Henson adds code for outliner-friendly expand and
"# 	collapse, comma comma commands, color coding, hooks for a
"# 	spellchecker, sorting, and date insertion.
"# Noel Henson, 11/24/2002
"# End of version 0.2.0
"# END OF HISTORY
"# 
"#########################################################################

" Colors linked {{{1
" Bill Powell, http://www.billpowellisalive.com
" Linked colors to normal groups. Different schemes will need tweaking.
" Occasionally certain groups will be rendered invisible. ;)
"
" Changelog {{{2
"2007 Jan 23, 21:23 Tue - 0.3.0, Modified version 0.1
    " Linked syntax groups to standard Vim color groups, intsead of to
    " particular colors. Now each colorscheme can work its own magic on
    " a VO file.
"2007 Apr 30,  9:36 Mon - 0.3.0, Modified version 0.2
    " Changed a few linked groups to reduce chances of groups being invisible.
    " No longer use Ignore group for anything.
    " Still a little redundancy; different groups might linked to same color group.
        " E.g., PT1 and UT1. But some color schemes (e.g. astronout) will differentiate between 
        " Special and Debug. Others will use the same colors for, say, Identifier and Debug. 
        " It just depends.
    " To tweak these groups, try :h syntax and go to group-name.
    " This shows the color groups, highlighted in your current colorscheme.
" }}}
hi link OL1 Statement 
hi link OL2 Identifier
hi link OL3 Constant
hi link OL4 PreProc   
hi link OL5 Statement 
hi link OL6 Identifier
hi link OL7 Constant
hi link OL8 PreProc   
hi link OL9 Statement

"colors for tags
"hi link outlTags Tag
hi link outlTags Todo

"color for body text
hi link BT1 Comment
hi link BT2 Comment
hi link BT3 Comment
hi link BT4 Comment
hi link BT5 Comment
hi link BT6 Comment
hi link BT7 Comment
hi link BT8 Comment
hi link BT9 Comment

"color for pre-formatted text
hi link PT1 Special
hi link PT2 Special
hi link PT3 Special
hi link PT4 Special
hi link PT5 Special
hi link PT6 Special
hi link PT7 Special
hi link PT8 Special
hi link PT9 Special

"color for tables 
hi link TA1 Type
hi link TA2 Type
hi link TA3 Type
hi link TA4 Type
hi link TA5 Type
hi link TA6 Type
hi link TA7 Type
hi link TA8 Type
hi link TA9 Type

"color for user text (wrapping)
hi link UT1 Debug
hi link UT2 Debug
hi link UT3 Debug
hi link UT4 Debug
hi link UT5 Debug
hi link UT6 Debug
hi link UT7 Debug
hi link UT8 Debug
hi link UT9 Debug

"color for user text (non-wrapping)
hi link UB1 Underlined
hi link UB2 Underlined
hi link UB3 Underlined
hi link UB4 Underlined
hi link UB5 Underlined
hi link UB6 Underlined
hi link UB7 Underlined
hi link UB8 Underlined
hi link UB9 Underlined

"colors for folded sections
"hi link Folded Special
"hi link FoldColumn Type

"colors for experimental spelling error highlighting
"this only works for spellfix.vim with will be cease to exist soon
hi link spellErr Error
hi link BadWord Todo

" Syntax {{{1
syn clear
syn sync fromstart

syn match outlTags '_tag_\w*' contained

"comment-style bodytext formatting as per Steve Litt
syntax match Comment "^\s*:.*$"
setlocal fo-=t fo+=crqno
setlocal com=sO:\:\ -,mO:\:\ \ ,eO:\:\:,:\:,sO:\>\ -,mO:\>\ \ ,eO:\>\>,:\>

"
" Headings {{{2

function! CreateSyntax()
    for num in [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let nextOL = (num == 9 ? "" : (",OL" . (num + 1)))
        let start = (num == 1 ? "" : "\\(\\t\\)\\{". (num - 1) . "}")
        let blockEnd = (num == 1 ? "end=+^\\S+me=e-1 end=+^\\(\\t\\)\\{1}\\S+me=e-2" : "end=+^\\(\\t\\)*\\S+me=s-1")
        let blockContains = "spellErr,SpellErrors,BadWord"
        let headingContains = "outlTags,BT1,BT2,PT1,PT2,TA1,TA2,UT1,UT2,UB1,UB2," . blockContains . nextOL
        "headings
        exec "syntax region OL" . num . " start=+^" . start . "[^:\\t]+ end=+^" . start . "[^:\\t]+me=e-" . num . " contains=" . headingContains . " keepend"
        " blocks
        for [name, chars] in [["UB", "<"], ["UT", ">"], ["TA", "|"], ["PT", ";"], ["BT", ":"], ["BT", " \\S"]]
            let match = "+^" . start . chars . "+"
            exec "syntax region " . name . num . " start=" . match " skip=" . match . " " . blockEnd . " contains=" . blockContains . " contained"
        endfor
    endfor
endfun
call CreateSyntax()

" Auto-commands {{{1
if !exists("autocommand_vo_loaded")
	let autocommand_vo_loaded = 1
	au BufNewFile,BufRead *.otl                     setf outliner
"	au CursorHold *.otl                             syn sync fromstart
"	set updatetime=500
endif

" The End
" vim600: set foldmethod=marker foldlevel=0:

if exists("b:did_indent") | finish | endif
let b:did_indent = 1

setlocal indentexpr=GetMarkdownIndent()
setlocal nolisp
setlocal autoindent

" Automatically insert bullets
setlocal formatoptions+=r
" Do not automatically insert bullets when auto-wrapping with text-width
setlocal formatoptions-=c
" Accept various markers as bullets
setlocal comments=b:*,b:+,b:-,b:1.

" Automatically continue blockquote on line break
setlocal comments+=bn:>

" Only define the function once
if exists("*GetMarkdownIndent") | finish | endif

function! s:IsBlankLine(line)
    return a:line =~ '^$'
endfunction

function! s:PrevNonBlank(lnum)
    let i = a:lnum
    while i > 0 && s:IsBlankLine(getline(i))
        let i -= 1
    endwhile
    return i
endfunction

function GetMarkdownIndent()
    " Find a non-blank line above the current line.
    let lnum = s:PrevNonBlank(v:lnum - 1)
    " At the start of the file use zero indent.
    if lnum == 0 | return 0 | endif
    if v:lnum - lnum < 2
        return indent(lnum)
    else
        return 0
    endif
endfunction

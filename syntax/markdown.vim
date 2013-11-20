" Vim syntax file
" Language:	Markdown
" Maintainer:	Ben Williams <benw@plasticboy.com>
" URL:		http://plasticboy.com/markdown-vim-mode/
" Version:	9
" Last Change:  2009 May 18 
" Remark:	Uses HTML syntax file
" Remark:	I don't do anything with angle brackets (<>) because that would too easily
"		easily conflict with HTML syntax
" TODO: 	Handle stuff contained within stuff (e.g. headings within blockquotes)


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlItalic start="\\\@<!\*\S\@=" end="\S\@<=\\\@<!\*" keepend oneline contains=@Spell
syn region htmlItalic start="\(^\|\s\)\@<=_\|\\\@<!_\([^_]\+\s\)\@=" end="\S\@<=_\|_\S\@=" keepend oneline contains=@Spell
syn region htmlBold start="\S\@<=\*\*\|\*\*\S\@=" end="\S\@<=\*\*\|\*\*\S\@=" keepend oneline contains=@Spell
syn region htmlBold start="\S\@<=__\|__\S\@=" end="\S\@<=__\|__\S\@=" keepend oneline contains=@Spell
syn region htmlBoldItalic start="\S\@<=\*\*\*\|\*\*\*\S\@=" end="\S\@<=\*\*\*\|\*\*\*\S\@=" keepend oneline contains=@Spell
syn region htmlBoldItalic start="\S\@<=___\|___\S\@=" end="\S\@<=___\|___\S\@=" keepend oneline contains=@Spell

" [link](URL) | [link][id] | [link][]
syn region mkdFootnotes matchgroup=mkdDelimiter start="\[^"    end="\]"
syn region mkdID matchgroup=mkdDelimiter        start="\["    end="\]" contained oneline
syn region mkdURL matchgroup=mkdDelimiter       start="\(\]\)\@<=("     end=")"  contained oneline
syn region mkdLink matchgroup=mkdDelimiter      start="\\\@<!\[" end="\]\ze\s*[[(]" contains=@Spell nextgroup=mkdURL,mkdID skipwhite oneline

" Inline url (http(s)://, ftp://, //)
syn region mkdInlineURL matchgroup=mkdInlineURL start="\(https\?:\|ftp:\|^\|[^:]\@<=\)\/\/" end="\()\|}\|]\|,\|\"\|\'\| \|$\|\. \|\.$\)\@="
syn region mkdInlineURL matchgroup=mkdDelimiter start="<\(\(https\?:\|ftp:\|^\|[^:]\@<=\)\/\/\)\@=" end=">"
" Inline mail (user@mail.com)
syn region mkdInlineURL matchgroup=Normal start="\(^\| \|(\|=\)\([-.[:alnum:]_~+]\+@\)\@=" end="\()\|}\|]\|,\|\"\|\'\| \|$\|\. \|\.$\)\@="
syn region mkdInlineURL matchgroup=mkdDelimiter start="<\([-.[:alnum:]_~+]\+@\)\@=" end=">"

" Link definitions: [id]: URL (Optional Title)
syn region mkdLinkDef matchgroup=mkdDelimiter   start="^ \{,3}\zs\[" end="]:" oneline nextgroup=mkdLinkDefTarget skipwhite
syn region mkdLinkDefTarget start="<\?\zs\S" excludenl end="\ze[>[:space:]\n]"   contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+"+     end=+"+  contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+'+     end=+'+  contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+(+     end=+)+  contained

"define Markdown groups
syn match  mkdLineContinue ".$" contained
syn match  mkdLineBreak    /  \+$/
syn region mkdBlockquote   start=/^\s*>/                   end=/$/ contains=mkdLineBreak,mkdLineContinue,@Spell
syn region mkdCode matchgroup=mkdDelimiter start=/\(\([^\\]\|^\)\\\)\@<!`/ end=/\(\([^\\]\|^\)\\\)\@<!`/
syn region mkdCode matchgroup=mkdDelimiter start=/\s*``[^`]*/ end=/[^`]*``\s*/
syn region mkdCode matchgroup=mkdDelimiter start=/^```.*$/ end=/^```\s*$/
syn region mkdCode matchgroup=mkdDelimiter start=/^[~]\{3,}.*$/ end=/^[~]\{3,}$/
syn region mkdCode matchgroup=mkdDelimiter start="<pre[^>]*>" end="</pre>"
syn region mkdCode matchgroup=mkdDelimiter start="<code[^>]*>" end="</code>"
syn region mkdFootnote     start="\[^"                     end="\]"
syn match  mkdCode         /^\s*\n\(\(\s\{4,}[^ ]\|\t\t\+[^\t]\).*\n\)\+/
syn match  mkdListItem     "^\s*[-*+]\s\+"
syn match  mkdListItem     "^\s*\d\+\.\s\+"
syn match  mkdRule         /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  mkdRule         /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  mkdRule         /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match  mkdRule         /^\s*-\{3,}$/
syn match  mkdRule         /^\s*\*\{3,5}$/

"HTML headings
syn region htmlH1       start="^\s*#"                   end="\($\|#\+\)" contains=@Spell
syn region htmlH2       start="^\s*##"                  end="\($\|#\+\)" contains=@Spell
syn region htmlH3       start="^\s*###"                 end="\($\|#\+\)" contains=@Spell
syn region htmlH4       start="^\s*####"                end="\($\|#\+\)" contains=@Spell
syn region htmlH5       start="^\s*#####"               end="\($\|#\+\)" contains=@Spell
syn region htmlH6       start="^\s*######"              end="\($\|#\+\)" contains=@Spell
syn match  htmlH1       /^.\+\n=\+$/ contains=@Spell
syn match  htmlH2       /^.\+\n-\+$/ contains=@Spell

" Liquid
syn region liquidTag matchgroup=mkdDelimiter start="{%"    end="%}" oneline
syn region liquidTag matchgroup=mkdDelimiter start="{{"    end="}}" oneline
syn region mkdCode   matchgroup=liquidTag start=/^{%\s*codeblock.*$/ end=/^{%\s*endcodeblock.*$/
syn region liquidComment  start="{%\s*comment\s*%}" end="{%\s*endcomment\s*%}"
syn region liquidOutput matchgroup=mkdDelimiter start="{{"    end="}}" oneline

"highlighting for Markdown groups
HtmlHiLink mkdString	    String
HtmlHiLink mkdCode          String
HtmlHiLink mkdIndentCode    String
HtmlHiLink mkdFootnote    Comment
HtmlHiLink mkdBlockquote    Comment
HtmlHiLink mkdLineContinue  Comment
HtmlHiLink mkdListItem      Identifier
HtmlHiLink mkdRule          Identifier
HtmlHiLink mkdLineBreak     Todo
HtmlHiLink mkdFootnotes     htmlLink
HtmlHiLink mkdLink          htmlLink
HtmlHiLink mkdURL           htmlString
HtmlHiLink mkdInlineURL     htmlLink
HtmlHiLink mkdID            Identifier
HtmlHiLink mkdLinkDef       mkdID
HtmlHiLink mkdLinkDefTarget mkdURL
HtmlHiLink mkdLinkTitle     htmlString

HtmlHiLink liquidTag        MoreMsg
HtmlHiLink liquidComment    NonText
HtmlHiLink liquidOutput     Directory

HtmlHiLink mkdDelimiter     Delimiter

" Automatically insert bullets
setlocal formatoptions+=r
" Accept various markers as bullets
setlocal comments=b:*,b:+,b:-

let b:current_syntax = "markdown"

delcommand HtmlHiLink
" vim: ts=8

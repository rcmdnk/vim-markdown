" Vim syntax file
" Language:     Markdown
" Maintainer:   Ben Williams <benw@plasticboy.com>
" URL:          http://plasticboy.com/markdown-vim-mode/
" Remark:       Uses HTML syntax file
" TODO:         Handle stuff contained within stuff (e.g. headings within blockquotes)


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim

  if exists('b:current_syntax')
    unlet b:current_syntax
  endif
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

let s:conceal = ''
let s:concealends = ''
if has('conceal') && get(g:, 'vim_markdown_conceal', 1)
  let s:conceal = ' conceal'
  let s:concealends = ' concealends'
endif

" additions to HTML groups
if get(g:, 'vim_markdown_emphasis_multiline', 0)
    let s:oneline = ''
else
    let s:oneline = ' oneline'
endif
execute 'syn region htmlItalic matchgroup=mkdItalic start="\%(^\|[^\\\*]\)\zs\*\ze[^\\\*\t ]" end="[^\\\*\t ]\zs\*\ze" keepend contains=@Spell oneline' . s:concealends
execute 'syn region htmlItalic matchgroup=mkdItalic start="\%(^\|\s\)\zs_\ze[^\\_\t ]" end="[^\\_\t ]\zs_\ze\_W" keepend contains=@Spell oneline' . s:concealends
execute 'syn region htmlBold matchgroup=mkdBold start="\%(^\|[^\\\*]\)\zs\*\*\ze[^\\\*\t ]" end="[^\\\*\t ]\zs\*\*" keepend contains=@Spell oneline' . s:concealends
execute 'syn region htmlBold matchgroup=mkdBold start="\%(^\|\s\)\zs__\ze[^\\_\t ]" end="[^\\_\t ]\zs__" keepend contains=@Spell oneline' . s:concealends
execute 'syn region htmlBoldItalic matchgroup=mkdBoldItalic start="\%(^\|[^\\\*]\)\zs\*\*\*\ze[^\\\*\t ]" end="[^\\\*\t ]\zs\*\*\*" keepend contains=@Spell oneline' . s:concealends
execute 'syn region htmlBoldItalic matchgroup=mkdBoldItalic start="\%(^\|\s\)\zs___\ze[^\\_\t ]" end="[^\\_\t ]\zs___" keepend contains=@Spell oneline' . s:concealends

" [link](URL) | [link][id] | [link][] | ![image](URL)
syn region mkdFootnotes matchgroup=mkdFootnotesDelimiter start="\[^"    end="\]"
execute 'syn region mkdID matchgroup=mkdIDDelimiter    start="\["    end="\]" contained oneline' . s:conceal
execute 'syn region mkdURL matchgroup=mkdDelimiter   start="("     end=")"  contained oneline' . s:conceal
execute 'syn region mkdLink matchgroup=mkdLinkDelimiter  start="\\\@<!!\?\[\ze[^]\n]*\n\?[^]\n]*\][[(]" end="\]" contains=@mkdNonListItem,@Spell nextgroup=mkdURL,mkdID skipwhite' . s:concealends

" Inline url (http(s)://, ftp://, //)
syn region mkdInlineURL start=/\%([[:alnum:]._-]\+:\)\=\/\// end=/\%()\|}\|]\|,\|\"\|\'\| \|$\|\. \|\.$\)\@=/
syn region mkdInlineURL matchgroup=mkdDelimiter start=/\\\@<!<\%(\%([[:alnum:]._-]\+:\)\=\/\/[^> ]*>\)\@=/ end=/>/
" Inline mail (user@mail.com)
syn region mkdInlineURL start=/\%(mailto:\)\=[[:alnum:]._-~+]\+@[[:alnum:]_-]\+\.[[:alnum:]_-]\+/ end=/\%()\|}\|]\|,\|\"\|\'\| \|$\|\. \|\.$\)\@=/
syn region mkdInlineURL matchgroup=mkdDelimiter start="\\\@<!<\%(\(mailto:\)\=[[:alnum:]._-~+]\+@[^> .]\+\.[^> .]\+>\)\@=" end=">"

" Link definitions: [id]: URL (Optional Title)
syn region mkdLinkDef matchgroup=mkdDelimiter   start="^ \{,3}\zs\[\^\@!" end="]:" oneline nextgroup=mkdLinkDefTarget skipwhite

syn region mkdLinkDefTarget start="<\?\zs\S" excludenl end="\ze[>[:space:]\n]"   contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+"+     end=+"+  contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+'+     end=+'+  contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+(+     end=+)+  contained

"HTML headings
syn region htmlH1       start="^\s*#"                   end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH2       start="^\s*##"                  end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH3       start="^\s*###"                 end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH4       start="^\s*####"                end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH5       start="^\s*#####"               end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH6       start="^\s*######"              end="$" contains=mkdLink,mkdInlineURL,@Spell
syn match  htmlH1       /^.\+\n=\+$/ contains=mkdLink,mkdInlineURL,@Spell
syn match  htmlH2       /^.\+\n-\+$/ contains=mkdLink,mkdInlineURL,@Spell

"define Markdown groups
syn match  mkdLineBreak    /  \+$/
syn region mkdBlockquote   start=/^\s*>/                   end=/$/ contains=mkdLink,mkdInlineURL,mkdLineBreak,@Spell
syn region mkdCode matchgroup=mkdInlineCodeDelimiter start=/\(\([^\\]\|^\)\\\)\@<!`/ end=/\(\([^\\]\|^\)\\\)\@<!`/
syn region mkdCode matchgroup=mkdInlineCodeDelimiter start=/\s*``[^`]*/              end=/[^`]*``\s*/
syn region mkdCode matchgroup=mkdCodeDelimiter       start=/^\s*\z(`\{3,}\)[^`]*$/   end=/^\s*\z1`*\s*$/
syn region mkdCode matchgroup=mkdCodeDelimiter       start=/\s*\~\~[^\~]*/           end=/[^\~]*\~\~\s*/
syn region mkdCode matchgroup=mkdCodeDelimiter       start=/^\s*\z(\~\{3,}\)\s*[0-9A-Za-z_+-]*\s*$/         end=/^\s*\z1\~*\s*$/
syn region mkdCode matchgroup=mkdInlineCodeDelimiter start="<\z(pre\|code\)[^>]*\\\@<!>"        end="</\z1>"
syn match  mkdIndentCode   /\%(^\s*\n\|\%^\)\%(\%(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/
syn match  mkdIndentCode0   /^\s*\n\%(\%(\s\{8,}[^ ]\|\t\t\+[^\t]\).*\n\)\+/ contained
syn match  mkdIndentCode1   /^\s*\n\%(\%(\s\{12,}[^ ]\|\t\t\t\+[^\t]\).*\n\)\+/ contained
syn match  mkdListItem     /^\s*\%([-*+]\|\d\+\.\)\ze\s\+/ contained
syn region mkdListBlock0    start=/^\%([-*+]\|\d\+\.\)\s\+/ end="\ze\(^\S\|^$^$\|\%$\)" contains=@mkdNonListItem,mkdListItem,@Spell,mkdListBlock1,mkdIndentCode0
syn region mkdListBlock1    start=/^\s\{4}\%([-*+]\|\d\+\.\)\s\+/ end="\ze\(^\S\|^$^$\|\%$\)" contained contains=@mkdNonListItem,mkdListItem,@Spell,mkdListBlock2,mkdIndentCode1
syn region mkdListBlock2    start=/^\s\{8}\%([-*+]\|\d\+\.\)\s\+/ end="\ze\(^\S\|^$^$\|\%$\)" contained contains=@mkdNonListItem,mkdListItem,@Spell,mkdIndentCode2
syn match  mkdRule         /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  mkdRule         /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  mkdRule         /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match  mkdRule         /^\s*-\{3,}$/
syn match  mkdRule         /^\s*\*\{3,5}$/

" Liquid
if get(g:, "vim_markdown_liquid", 1)
  syn region liquidTag matchgroup=mkdDelimiter start="{%"    end="%}" oneline
  syn region liquidOutput matchgroup=mkdDelimiter start="{{"    end="}}" oneline
  syn region mkdCode matchgroup=liquidCodeTag start=/^{%\s*codeblock\%( .*\|\)%}/ end=/^{%\s*endcodeblock\%( .*\|\)%}/
  syn region liquidComment matchgroup=liquidCommentTag start="{%\s*comment\s*%}" end="{%\s*endcomment\s*%}"
endif

" YAML frontmatter
if get(g:, 'vim_markdown_frontmatter', 0)
  try
    syn include @yamlTop syntax/yaml.vim
    syn region Comment matchgroup=mkdFrontmatterDelimiter start="\%^---$" end="^---$" contains=@yamlTop
    unlet! b:current_syntax
  catch /E484/
    syn region Comment matchgroup=mkdFrontmatterDelimiter start="\%^---$" end="^---$"
  endtry
endif

" TOML
if get(g:, 'vim_markdown_toml_frontmatter', 0)
  try
    syn include @tomlTop syntax/toml.vim
    syn region Comment matchgroup=mkdFrontmatterDelimiter start="\%^+++$" end="^+++$" transparent contains=@tomlTop
    unlet! b:current_syntax
  catch /E484/
    syn region Comment matchgroup=mkdFrontmatterDelimiter start="\%^+++$" end="^+++$" transparent
  endtry
endif

" JSON
if get(g:, 'vim_markdown_json_frontmatter', 0)
  try
    syn include @jsonTop syntax/json.vim
    syn region Comment matchgroup=mkdFrontmatterDelimiter start="\%^{$" end="^}$" contains=@jsonTop
    unlet! b:current_syntax
  catch /E484/
    syn region Comment matchgroup=mkdFrontmatterDelimiter start="\%^{$" end="^}$"
  endtry
endif

" Math
if get(g:, 'vim_markdown_math', 0)
  try
    syn include @tex syntax/tex.vim
    syn region mkdMath start="\\\@<!\$" end="\$" skip="\\\$" oneline contains=@tex keepend
    syn region mkdMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" contains=@tex keepend
    unlet! b:current_syntax
  catch /E484/
    syn region mkdMath start="\\\@<!\$" end="\$" skip="\\\$" oneline keepend
    syn region mkdMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" oneline keepend
  endtry
endif

syn cluster mkdNonListItem contains=@htmlTop,htmlItalic,htmlBold,htmlBoldItalic,mkdFootnotes,mkdInlineURL,mkdLink,mkdLinkDef,mkdLineBreak,mkdBlockquote,mkdCode,mkdRule,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,mkdMath,LiquidTag,LiquidOutput,LiquidComment

"highlighting for Markdown groups
HtmlHiLink mkdString        String
HtmlHiLink mkdItalic        htmlItalic
HtmlHiLink mkdBold          htmlBold
HtmlHiLink mkdBoldItalic    htmlBoldItalic
HtmlHiLink mkdCode          String
HtmlHiLink mkdIndentCode    mkdCode
HtmlHiLink mkdIndentCode0   mkdCode
HtmlHiLink mkdIndentCode1   mkdCode
HtmlHiLink mkdBlockquote    Comment
HtmlHiLink mkdListItem      Identifier
HtmlHiLink mkdRule          Identifier
HtmlHiLink mkdLineBreak     Visual
HtmlHiLink mkdFootnotes     htmlLink
HtmlHiLink mkdLink          htmlLink
HtmlHiLink mkdURL           htmlString
HtmlHiLink mkdInlineURL     htmlLink
HtmlHiLink mkdID            Identifier
HtmlHiLink mkdLinkDef       mkdID
HtmlHiLink mkdLinkDefTarget mkdURL
HtmlHiLink mkdLinkTitle     htmlString
HtmlHiLink mkdDelimiter     Delimiter
HtmlHiLink mkdFootnotesDelimiter mkdDelimiter
HtmlHiLink mkdIDDelimiter   mkdDelimiter
HtmlHiLink mkdURLDelimiter  mkdDelimiter
HtmlHiLink mkdLinkDelimiter mkdDelimiter
HtmlHiLink mkdCodeDelimiter mkdDelimiter
HtmlHiLink mkdInlineCodeDelimiter Delimiter
HtmlHiLink mkdFrontmatterDelimiter     Delimiter
HtmlHiLink liquidTag        MoreMsg
HtmlHiLink liquidCodeTag    LiquidTag
HtmlHiLink liquidComment    NonText
HtmlHiLink liquidCommentTag NonText
HtmlHiLink liquidOutput     Directory
" For markdown_quote_syntax
HtmlHiLink markdownCodeDelimiter liquidTag

let b:current_syntax = "markdown"

delcommand HtmlHiLink
" vim: ts=8

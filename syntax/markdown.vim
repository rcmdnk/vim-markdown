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
if get(g:, 'vim_markdown_emphasis_multiline', 1)
    let s:oneline = ''
else
    let s:oneline = ' oneline'
endif
execute 'syn region htmlItalic matchgroup=mkdItalic start="\%(^\|\s\)\@<=\*\%([^\*]\)\@=" end="\*\@<!\*\%(\s\|$\)\@=" contains=@Spell' . s:oneline . s:concealends
execute 'syn region htmlItalic matchgroup=mkdItalic start="\%(^\|\s\)\@<=_\%([^_]\)\@=" end="_\@<!_\%(\s\|$\)\@=" contains=@Spell' . s:oneline . s:concealends
execute 'syn region htmlBold matchgroup=mkdBold start="\%(^\|\s\)\@<=\*\*\%([^\*]\)\@=" end="\*\@<!\*\*\%(\s\|$\)\@=" contains=@Spell' . s:oneline . s:concealends
execute 'syn region htmlBold matchgroup=mkdBold start="\%(^\|\s\)\@<=__\%([^_]\)\@=" end="_\@<!__\%(\s\|$\)\@=" contains=@Spell' . s:oneline . s:concealends
execute 'syn region htmlBoldItalic matchgroup=mkdBoldItalic start="\%(^\|\s\)\@<=\*\*\*\%([^\*]\)\@=" end="\*\@<!\*\*\*\%(\s\|$\)\@=" contains=@Spell' . s:oneline . s:concealends
execute 'syn region htmlBoldItalic matchgroup=mkdBoldItalic start="\%(^\|\s\)\@<=___\%([^_]\)\@=" end="_\@<!___\%(\s\|$\)\@=" contains=@Spell' . s:oneline . s:concealends

" [link](URL) | [link][id] | [link][] | ![image](URL)
syn region mkdFootnotes matchgroup=mkdDelimiter start="\[^"   end="\]"
execute 'syn region mkdID matchgroup=mkdDelimiter    start="\["    end="\]" contained oneline' . s:conceal
execute 'syn match  mkdURL "(\@<=\S\+\%(.*)\)\@=" contained oneline' . s:conceal
execute 'syn region mkdURLBracket matchgroup=mkdDelimiter start="\%(\]\)\@<=(" end=")"  contained oneline contains=mkdURL keepend' . s:concealends
execute 'syn region mkdLink matchgroup=mkdDelimiter  start="\\\@<!\[" end="\]\ze\s*[[(]" contains=@Spell nextgroup=mkdURLBracket,mkdID skipwhite oneline' . s:concealends

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
syn region mkdCode matchgroup=mkdInlineCodeDelimiter start=/\%(\%([^\\]\|^\)\\\)\@<!`/ end=/\%(\%([^\\]\|^\)\\\)\@<!`/
syn region mkdCode matchgroup=mkdInlineCodeDelimiter start=/\s*``[^`]*/ end=/[^`]*``\s*/
syn region mkdCode matchgroup=mkdCodeDelimiter start=/^\s*```\s*[0-9A-Za-z_-]*\s*$/ end=/^\s*```\s*$/
syn region mkdCode matchgroup=mkdCodeDelimiter start=/^[~]\{3,}.*$/ end=/^[~]\{3,}$/
syn region mkdCode matchgroup=mkdInlineCodeDelimiter start="<pre[^>]*>" end="</pre>"
syn region mkdCode matchgroup=mkdInlineCodeDelimiter start="<code[^>]*>" end="</code>"
syn match  mkdIndentCode   /^\s*\n\%(\%(\s\{4,}[^ ]\|\t\t\+[^\t]\).*\n\)\+/
syn match  mkdListItem     "^\s*[-*+]\s\+"
syn match  mkdListItem     "^\s*\d\+\.\s\+"
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
    syn region mkdMath start="\\\@<!\$" end="\$" skip="\\\$" contains=@tex keepend
    syn region mkdMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" contains=@tex keepend
    unlet! b:current_syntax
  catch /E484/
    syn region mkdMath start="\\\@<!\$" end="\$" skip="\\\$" keepend
    syn region mkdMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" keepend
  endtry
endif

"highlighting for Markdown groups
HtmlHiLink mkdString        String
HtmlHiLink mkdCode          String
HtmlHiLink mkdIndentCode    String
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
HtmlHiLink mkdCodeDelimiter Delimiter
HtmlHiLink mkdInlineCodeDelimiter Delimiter
HtmlHiLink mkdFrontmatterDelimiter     Delimiter
HtmlHiLink liquidTag        MoreMsg
HtmlHiLink liquidCodeTag    MoreMsg
HtmlHiLink liquidComment    NonText
HtmlHiLink liquidCommentTag NonText
HtmlHiLink liquidOutput     Directory
" For markdown_quote_syntax
HtmlHiLink markdownCodeDelimiter liquidTag

let b:current_syntax = "markdown"

delcommand HtmlHiLink
" vim: ts=8

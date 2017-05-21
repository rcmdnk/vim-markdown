" folding for Markdown headers, both styles (atx- and setex-)
" http://daringfireball.net/projects/markdown/syntax#header
"
" this code can be placed in file
"   $HOME/.vim/after/ftplugin/markdown.vim
"
" original version from Steve Losh's gist: https://gist.github.com/1038710

func! Foldexpr_markdown(lnum)
  if get(g:, 'vim_markdown_better_folding', 1)

    let syn1 = synIDattr(synID(a:lnum,1,1), 'name')

    " Frontmatter
    if syn1 == 'mkdFrontmatterDelimiter'
      if b:frontmatter == 0
        let b:frontmatter = 1
        return 'a1'
      else
        let b:frontmatter = 0
        return 's1'
      endif
    elseif b:frontmatter == 1
      return '='
    endif

    " Liquid Comment
    if syn1 == 'liquidCommentTag'
      if b:comment == 0
        let b:comment = 1
        return 'a1'
      else
        let b:comment = 0
        return 's1'
      endif
    elseif b:comment == 1
      return '='
    endif

    " Code
    if syn1 == 'liquidCodeTag' || syn1 == 'mkdCodeDelimiter' || syn1 == 'markdownCodeDelimiter'
      if b:codeblock == 0
        let b:codeblock = 1
        return 'a1'
      else
        let b:codeblock = 0
        return 's1'
      endif
    elseif b:codeblock == 1
      return '='
    endif

    " Code with four spaces
    if syn1 == 'mkdIndentCode'
      if b:indent_codeblock == 0
        let b:indent_codeblock = 1
        return 'a1'
      else
        return '='
      endif
    elseif b:indent_codeblock == 1
      let syn2 = synIDattr(synID(a:lnum+1,1,1), 'name')
      if syn2 == 'mkdIndentCode'
        return '='
      else
        let b:indent_codeblock = 0
        return 's1'
      endif
    endif

  endif

  " Get line contents
  let l0 = getline(a:lnum-1)
  let l1 = getline(a:lnum)
  let l2 = getline(a:lnum+1)

  " Section
  if  l2 =~ '^==\+\s*$'
    " next line is underlined (level 1)
    return '>1'
  elseif l2 =~ '^--\+\s*$'
    " next line is underlined (level 2)
    if s:vim_markdown_folding_level >= 2
      return '>2'
    else
      return '='
    endif
  elseif l1 =~ '^#[^!]' && matchend(l1, '^#\+') <= s:vim_markdown_folding_level
    " current line starts with hashes
    return '>'.matchend(l1, '^#\+')
  endif

  " keep previous foldlevel
  return '='
endfunc

let b:frontmatter = 0
let b:comment = 0
let b:codeblock = 0
let b:indent_codeblock = 0
let s:vim_markdown_folding_level = get(g:, "vim_markdown_folding_level", 1)

if !get(g:, "vim_markdown_folding_disabled", 0)
  setlocal foldexpr=Foldexpr_markdown(v:lnum)
  setlocal foldmethod=expr
endif

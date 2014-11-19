" folding for Markdown headers, both styles (atx- and setex-)
" http://daringfireball.net/projects/markdown/syntax#header
"
" this code can be placed in file
"   $HOME/.vim/after/ftplugin/markdown.vim
"
" original version from Steve Losh's gist: https://gist.github.com/1038710

func! Foldexpr_markdown(lnum)
  " Get line contents
  let l0 = getline(a:lnum-1)
  let l1 = getline(a:lnum)
  let l2 = getline(a:lnum+1)

  if get(g:, 'vim_markdown_better_folding', 0)
    " Get syntaxes
    let syn0 = synIDattr(synID(a:lnum-1,1,1), 'name')
    let syn1 = synIDattr(synID(a:lnum,1,1), 'name')
    let syn2 = synIDattr(synID(a:lnum+1,1,1), 'name')

    " YAML block
    if syn1 == 'yamlDelimiter'
      if a:lnum == 1
        return 'a1'
      else
        return 's1'
      endif
    endif
    if syn1 == 'yamlBlockMappingKey'
      return '='
    endif

    " Code
    if syn1 == 'mkdDelimiter' || syn1 == 'liquidTag'
      if syn2 == 'mkdCode'
        return 'a1'
      elseif syn0 == 'mkdCode'
        return 's1'
      endif
    endif

    " Code with vim-markdown-quote-syntax
    if syn1 == 'markdownCodeDelimiter'
      if syn0 == ''
        return 'a1'
      elseif syn2 == ''
        return 's1'
      endif
    endif

    " Code with four spaces
    if syn1 == 'mkdCode'
      if syn0 == ''
        " Avoid one line code
        if syn2 != ''
          return 'a1'
        endif
      elseif syn2 == ''
        return 's1'
      endif
    endif

    " Liquid Comment
    if syn1 == 'liquidComment'
      if syn0 != 'liquidComment'
        return 'a1'
      elseif syn2 != 'liquidComment'
        return 's1'
      endif
    endif
  endif

  " Section
  if  l2 =~ '^==\+\s*'
      " next line is underlined (level 1)
      return '>1'
  elseif l2 =~ '^--\+\s*'
      " next line is underlined (level 2)
      return '>2'
  elseif l1 =~ '^#'
      " don't include the section title in the fold
      return '-1'
  elseif l0 =~ '^#[^!]'
      " current line starts with hashes
      return '>'.matchend(l0, '^#\+')
  endif

  " keep previous foldlevel
  return '='
endfunc

if !get(g:, "vim_markdown_folding_disabled", 0)
  setlocal foldexpr=Foldexpr_markdown(v:lnum)
  setlocal foldmethod=expr
endif

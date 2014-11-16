" folding for Markdown headers, both styles (atx- and setex-)
" http://daringfireball.net/projects/markdown/syntax#header
"
" this code can be placed in file
"   $HOME/.vim/after/ftplugin/markdown.vim
"
" original version from Steve Losh's gist: https://gist.github.com/1038710

func! Foldexpr_markdown(lnum)
  let syn0 = synIDattr(synID(a:lnum-1,1,1), 'name')
  let syn1 = synIDattr(synID(a:lnum,1,1), 'name')
  let syn2 = synIDattr(synID(a:lnum+1,1,1), 'name')
  if get(g:, 'vim_markdown_frontmatter', 0)
    if syn1 == 'mkdDelimiter'
      if syn2 == 'yamlBlockMappingKey'
        return '>1'
      elseif syn0 == 'yamlBlockMappingKey'
        return '<1'
      endif
    elseif syn1 == 'yamlBlockMappingKey'
      return '='
    endif
  endif
  if syn1 != 'mkdCode' && syn2 == 'mkdCode'
    return 'a1'
  elseif syn1 != 'mkdCode' && syn0 == 'mkdCode'
    return 's1'
  endif
  let l0 = getline(a:lnum-1)
  let l1 = getline(a:lnum)
  let l2 = getline(a:lnum+1)
  if syn2 =~ 'htmlH[0-9]'
    if  l2 =~ '^==\+\s*'
      " next line is underlined (level 1)
      return '>1'
    elseif l2 =~ '^--\+\s*'
      " next line is underlined (level 2)
      return '>2'
    endif
  elseif syn1 =~ 'htmlH[0-9]' && l1 =~ '^#'
    " don't include the section title in the fold
    return '-1'
  elseif syn0 =~ 'htmlH[0-9]' && l0 =~ '^#'
    " current line starts with hashes
    return '>'.matchend(l0, '^#\+')
  elseif get(g:, 'vim_markdown_frontmatter', 0)
    let syn00 = synIDattr(synID(a:lnum-2,1,1), 'name')
    if syn0 == 'mkdDelimiter' && syn00 == 'yamlBlockMappingKey'
      return 0
    endif
  endif
  " keep previous foldlevel
  return '='
endfunc


if !get(g:, "vim_markdown_folding_disabled", 0)
  setlocal foldexpr=Foldexpr_markdown(v:lnum)
  setlocal foldmethod=expr
endif

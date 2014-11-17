---
layout: test
title: "vim-markdown: test with vim-markdown-quote-syntax"
subtitle: "Here is yaml block test"
comments: true
categories: Computer
tags: ["Vim", "Markdown"]
keywords: Vim, Markdown
---

To install with [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim),
add following lines in **~/.vimrc**:

```vim
" Markdown syntax
NeoBundle "junegunn/vader.vim"
NeoBundle "godlygeek/tabular"
NeoBundle "rcmdnk/vim-markdown-quote-syntax"
NeoBundle "rcmdnk/vim-markdown"
```

In addition, following settings are useful:

```vim
let g:vim_markdown_liquid=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_math=1
au BufRead,BufNewFile *.{txt,text} set filetype=markdown
```

colorscheme ron
hi link htmlItalic LineNr
hi link htmlBold WarningMsg
hi link htmlBoldItalic ErrorMsg

[Daring Fireball: Markdown Syntax Documentation](http://daringfireball.net/projects/markdown/syntax)

This is an H1
=============

This is an H2
-------------

# This is an H1
Test

# This is an H1 #

> ## This is a header.
> 
> 1.   This is the first list item.
> 2.   This is the second list item.
> 
> Here's some example code:
> 
>     return shell_exec("echo $input | $markdown_script");

* Red
* Green
* Blue

1. Bird
2. McHale
3. Parish

This is a normal paragraph:

    This is a code block.

* * *

This is [an example](http://example.com/ "Title") inline link.
This is [an example][id] reference-style link.
[id]: http://example.com/  "Optional Title Here"
[foo]: http://example.com/  "Optional Title Here"
[foo]: http://example.com/  'Optional Title Here'
[foo]: http://example.com/  (Optional Title Here)
[foo]: <http://example.com/>  "Optional Title Here"

I get 10 times more traffic from [Google] [1] than from
[Yahoo] [2] or [MSN] [3].

  [1]: http://google.com/        "Google"
  [2]: http://search.yahoo.com/  "Yahoo Search"
  [3]: http://search.msn.com/    "MSN Search"

*single asterisks*
_single underscores_
**double asterisks**
__double underscores__
***triple asterisks***
___triple underscores___

un*frigging*believable
\*this text is surrounded by literal asterisks\*

Use the `printf()` function.
``There is a literal backtick (`) here.``
A single backtick in a code span: `` ` ``
A backtick-delimited string in a code span: `` `foo` ``
Please don't use any `<blink>` tags.

![Alt text](/path/to/img.jpg)
![Alt text](/path/to/img.jpg "Optional title")
![Alt text][id]
[id]: url/to/image  "Optional title attribute"


[Michel Fortin – PHP Markdown Extra](http://michelf.ca/projects/php-markdown/extra/)

<div markdown="1">
This is *true* markdown text.
</div>

Apple
:   Pomaceous fruit of plants of the genus Malus in 
    the family Rosaceae.

That's some text with a footnote.[^1]

[^1]: And that's the footnote.

    That's the second paragraph.

~~~~~~~~~~~~~~~~~~~~~

a one-line code block

~~~~~~~~~~~~~~~~~~~~~


# others

Remails html syntax in most places: `runtime! syntax/html.vim`

<div class="html">Use html syntax</div>
<a href="http...">aaa</a>
<code>code</code>
<pre>pre</pre>

```
triple backticks
```

(Only Parentheses)
{Only Braces}
[Only Square Brackets]
<Only Angle Brackets: This is "html tag">

This is https://inline.url. End with `.`, `,`, ` ` or etc... (don't markup last `.`)
ftp://ftp.is.also.markuped end with space.
(https://url.in.brackets)
Double slash is //also.url, ok.

Mail address: user@mail.com.
Mail address: <user@mail.com>.
Mail address: mailto:user@mail.com
Wrong Mail address in brackets: <user@mail.com.>.

Single asterisk *is not markupped.
Single underscore _is not markupped.

{%Liquid Tag%}

{%comment%}
Here is Liquid Comment.
{%endcomment%}

{%codeblock%}
Jekyll Codeblocke
{%endcodeblock%}

    code with 4 spaces
    code with 4 spaces
    code with 4 spaces

One line test

    code with 4 spaces

```
echo no lang, triple backticks
```

```sh
#!/bin/sh
echo triple backticks
valu=${aaa}
```

~~~
triple waves
~~~

{%codeblock lang:cpp%}
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "codeblock" << std::endl;
}
{%endcodeblock%}

{%codeblock title lang:cpp%}
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "codeblock with lang" << std::endl;
}
{%endcodeblock%}

{%codeblock a.cpp %}
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "codeblock with file extension" << std::endl;
}
{%endcodeblock%}

{%codeblock a.vim lang:cpp%}
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "If both lang and extension are available, lang is used for the syntax" << std::endl;
}
{%endcodeblock%}

```java
import java.awt.Color;
public void test() {
  System.out.println("Java is now available.");
  return;
}
```

~~~ .ruby
puts "PHP Markdown Extra wave codeblock"
def func(flag)
  if(flag)
    puts "OK"
  else
    puts "FAILED"
  end
end
~~~

# Spell Check
spelll check is available in normal place.

# spelll check is also available in the title or some places.

    spelll cehck is disabled in the code block.


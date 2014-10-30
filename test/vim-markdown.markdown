https://github.com/rcmdnk/vim-markdown

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
<Only Angle Brackets>

This is https://inline.url. End with `.`, `,`, ` ` or etc... (don't markup last `.`)
ftp://ftp.is.also.markuped end with space.
(https://url.in.brackets)
Double slash is //also.url, ok.

mail address: user@mail.com.
mail address: <user@mail.com>.

Single asterisk *is not markupped.
Single underscore _is not markupped.

{%Liquid Tag%}

{%codeblock%}
Jekyll Codeblocke
{%endcodeblock%}

{%comment%}
Here is Liquid Comment.
{%endcomment%}

```
echo no lang
```

```sh
#!/bin/sh
echo triple backtick
valu=${aaa}

```

```java
import java.awt.Color;
public void test() {
  return;
}
```

{%codeblock lang:cpp%}
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "codeblock" << std::endl;
}
{%endcodeblock%}

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
spelll check

# spelll check


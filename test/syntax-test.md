---
layout: page
title: "Syntax tests"
date: 2017-05-19 12:00
published: true
---

Before more

<!-- more -->
{%include after_excerpt.html%}

After more

# Bracket, Link, etc...

(Only Parentheses)
{Only Braces}
[Only Square Brackets]
<Only Angle Brackets: This is "html tag">

Bracket test [  w/o line break ]

Bracket test [  w/ line break
]

Bracket Link test [  w/o line break ](/link/)

Bracket test [  w/ line break
](/link)

[Link](https://url)

[Link] (https://url/with/space)

This is https://inline.url. End with `.`, `,`, ` ` or etc... (don't markup last `.`)
ftp://ftp.is.also.markuped end with space.
(https://url.in.brackets)
Double slash is //also.url, ok.
Single slash starting word is /not.highlighted.

Mail address: user@mail.com.
Mail address: <user@mail.com>.
Mail address: mailto:user@mail.com
Wrong Mail address in brackets: <user@mail.com.>.

Single asterisk *is not markupped.
Single underscore _is not markupped.

*Multi* *asterisks*between** *words*test*test*test.

__Multi__ _underscores_between__ _words_test_test_test.

* List
* List
    * List (https://url.in.brackets)
    * *List* __List__

*NotList

{%Liquid Tag%}

{%comment%}
Here is Liquid Comment.
{%endcomment%}

# Codes test

~~~~~~~~~~~~~~~~~~~~~

a one-line code block

~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~
a one-line code block
a one-line code block
~~~~~~~~~~~~~~~~~~~~~

Remain html syntax in most places: `runtime! syntax/html.vim`

<div class="html">Use html syntax</div>
<a href="http...">aaa</a>
<code>code</code>
<pre>pre</pre>

```
triple backticks
```

{%codeblock%}
Jekyll Codeblocke
{%endcodeblock%}

    code with 4 spaces
    code with 4 spaces
    code with 4 spaces


With space

    code with 4 spaces
    code with 4 spaces
    code with 4 spaces

One line test

    code with 4 spaces

Seprated line test

    code with 4 spaces
    code with 4 spaces
    code with 4 spaces

    code with 4 spaces

Indent code in the list

* List start

    This is not a code

        This is a code

    * Second List

      This is not a code

        This is not a code

            This is a code

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
  System.out.println("Java is now available. with triple backtick ```");
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

~~~ruby
puts "PHP Markdown Extra wave codeblock"
def func(flag)
  if(flag)
    puts "OK"
  else
    puts "FAILED"
  end
end
~~~


{%codeblock Rakefile lang:ruby%}
 ## -- Misc Configs -- ##
stash_dir       = "_stash"    # directory to stash posts for speedy generation
full_stash_dir  = "#{source_dir}/#{stash_dir}"    # full path for stash dir
stash_root_dir  = "_stash_root" # directory to stash pages (in /source/)
full_stash_root_dir = "#{source_dir}/#{stash_root_dir}" # full path for stash_root dir
root_stashes    = ['Your-Page'] # directories to be stashed in /source/


# usage rake isolate[my-post]
desc "Move all other posts than the one currently being worked on to a temporary stash location (stash) so regenerating the site happens much more quickly."
task :isolate, :filename do |t, args|
  if args.filename
    filename = args.filename
  else
    filename = Dir.glob("#{source_dir}/#{posts_dir}/*.#{new_post_ext}").sort_by{|f| File.mtime(f)}.last
  end
  if filename == nil
    puts ""
    puts "There is no markdown file (*.#{new_post_ext}) in #{source_dir}/#{posts_dir}."
    exit 1
  end
  puts "## Stashing other posts than #{filename}"
  FileUtils.mkdir(full_stash_dir) unless File.exist?(full_stash_dir)
  Dir.glob("#{source_dir}/#{posts_dir}/*") do |post|
    if post.include?(filename)
      p "Remaining #{post}..."
    else
      FileUtils.mv post, full_stash_dir
    end
  end
  FileUtils.mkdir(full_stash_root_dir) unless File.exist?(full_stash_root_dir)
  if defined? root_stashes == nil
    if root_stashes.class == String
      FileUtils.mv "#{source_dir}/#{root_stashes}", full_stash_root_dir
    elsif root_stashes.class == Array
      for d in root_stashes do
        FileUtils.mv "#{source_dir}/#{d}", full_stash_root_dir
      end
    end
  end
  system "touch .isolated"
end

desc "Move all stashed posts back into the posts directory, ready for site generation."
task :integrate do
  FileUtils.mv Dir.glob("#{full_stash_dir}/*"), "#{source_dir}/#{posts_dir}/"
  FileUtils.mv Dir.glob("#{full_stash_root_dir}/*"), "#{source_dir}/"
  system "rm -f .isolated"
  system "touch .integrated"
end
{%endcodeblock%}

{%codeblock source/javascript/utils.js lang:javascript%}
jQuery(function($){
  $(document).on('copy', function(e) {
    var selected = "";
    if (typeof window.getSelection != "undefined") {
        var sel = window.getSelection();
        if (sel.rangeCount) {
            var container = document.createElement("div");
            for (var i = 0, len = sel.rangeCount; i < len; ++i) {
                container.appendChild(sel.getRangeAt(i).cloneContents());
            }
            selected = container.innerHTML;
        }
    } else if (typeof document.selection != "undefined") {
        if (document.selection.type == "Text") {
            selected = document.selection.createRange().htmlText;
        }
    }
    var title = document.title;
    var  url = location.href;
    $.ajax({
      type: "POST",
      url: "https://mandrillapp.com/api/1.0/messages/send.json",
      data: {
        'key': 'YOUR_API_KEY',
        'message': {
          'from_email': 'your_sender@example.com',
          'to': [
            {
              'email': 'your_receiver@example.com',
              'name': 'your receiver',
              'type': 'to'
            }
          ],
          'subject': 'Copied at ' + title,
          'html': '<div><a href="' + url + '">' + title + '</a></div><br><br><div>' + selected + '</div>'
        }
      }
    });
  });
});
{%endcodeblock utils.js lang:javascript%}

In Octopress, I made `source/javascript/utils.js`
and put my functions there.

It is read from `source/_includes/head.html`:

{%codeblock source/_includes/head.html%}
...
<head>
...
  <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
...
  <script src="{{root_url}}/javascripts/utils.js"></script>
</head>
...
{%endcodeblock%}

{%codeblock lang:sh%}
{%raw%}
# Execution part {{{
_s_is_exec=1
_sf_check_args_first () { # {{{
  while [ $# -gt 0 ];do
    case $1 in
      "-h"|"-N"|"-m"|"-p"|"-F"|"-v" ) _s_is_exec=2;shift;;
      "-n" ) _s_is_exec=0;shift;;
      "-c" ) _SENTAKU_CHILD=1;shift;;
    * )break;;
    esac
  done
} # }}}

_sf_check_args_first "$@"

# Execute if stdin is available, or any of help/file/push is on
if [ $_s_is_exec -ne 0 ];then
  if [ -p /dev/stdin ] || [ $_s_is_exec -eq 2 ];then
    _sf_main "$@"
  fi
fi

# Clean up
unset _s_is_exec
# }}}
{%endraw%}
{%endcodeblock lang:sh%}

{%codeblock lang:diff%}
diff --git a/.themes/octogray b/.themes/octogray
index 69e224c..a519ddb 160000
--- a/.themes/octogray
+++ b/.themes/octogray
@@ -1 +1 @@
-Subproject commit 69e224c5def49917f7fe5527532f8cb50614e81f
+Subproject commit a519ddbdb6a3b40e48ef7713c3be5d15f853b880
{%endcodeblock%}

{%codeblock test.cxx lang:cpp%}
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "coeblock" << std::endl;
}
{%endcodeblock%}

```cpp
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "triple backticks" << std::endl;
}
```

~~~cpp
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "triple ~" << std::endl;
}
~~~

```cpp
{%codeblock test.cxx lang:cpp%}
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "coeblock" << std::endl;
}
{%endcodeblock%}
```

{%comment%}
need space after raw before ```,
otherwise Jekyll will give error like

    jekyll 2.5.3 | Error:  Pygments can't parse unknown language: </p>.
    rake aborted!
    FAILD

{%endcomment%}

{%raw%}

```cpp

{%codeblock test.cxx lang:cpp%}
#include <iostream>
for(int i=0;i<10;i++){
  std::cout << "coeblock" << std::endl;
}
{%endcodeblock%}
```

{%endraw%}

{{site.title}}

## Gist

{%gist 6807826 %}

## HTML Blocks

> [HTML Blocks (Kramdown)](http://kramdown.gettalong.org/syntax.html#html-blocks)

<div>
This is *nottrue* markdown text.
</div>

<div markdown="1">
This is *true* markdown text.
</div>

{%comment%}
<table>
<tr>
<td markdown="1">This is *first* markdown text.</td>
</tr>
</table>
{%endcomment%}

<div markdown="block">
<table>
<tr>
<td>This is *divtest* markdown text.</td>
</tr>
</table>
</div>

<table markdown="block">
<tr>
<td>This is *second* markdown text.</td>
</tr>
</table>

{%comment%}
<table >
<tr>
<td markdown="block">This is *third* markdown text.</td>
</tr>
</table>
{%endcomment%}

<table >
<tr markdown="block">
<td>This is *4th* markdown text.</td>
</tr>
</table>

<table >
<tr markdown="1">
<td>This is *5th* markdown text.</td>
</tr>
</table>

<div>
This is *6th* markdown text.
</div>

## postscript

{%ps 2013/05/03%}

PS test

{%endps%}


## Footnote

footnote{%fnin%}
test test test

hoge 

    indent code

aaa

* 1 
* 2
* 3
{%endfnin%}。


# [Daring Fireball: Markdown Syntax Documentation](http://daringfireball.net/projects/markdown/syntax)

This is an H1
=============

This is an H2
-------------

## This is an H1
Test

## This is an H1 #

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
[![Alt text](/path/to/img.jpg "Optional title")](/img/url)
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


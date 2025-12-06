[Go Up](../README.md)
[Back to Readme](./readme.md)

- [Misc](#misc)
  - [Search `Properties`](#search-properties)
  - [Drag Drop Paths](#drag-drop-paths)
  - [Match start/end of text with `^` / `$` **without using regex**](#match-startend-of-text-with----without-using-regex)
  - [Search Delay](#search-delay)
  - [Window Title Format](#window-title-format)

Many of these are added after `1.5a` 

# Misc

## Search `Properties`

- [Search `Properties` announcement](https://www.voidtools.com/forum/viewtopic.php?f=12&t=9788)

## Drag Drop Paths

```yml
command: '/hdrop_file_format=1'
description: 'drag drop files onto the search box'
```

| Value | Description                 |
| ----- | --------------------------- |
| `0`   | use the full path (default) |
| `1`   | use the base name           |

## Match start/end of text with `^` / `$` **without using regex**

```yml
command: '/match_start_of_filename_with_caret=2'
description: |
    Regex matches the start of a filename with the caret (^)
    This option allows you to use a caret to match the start of the filename with a normal search (without regex):

```
```yml
command: '/match_end_of_filename_with_dollar_sign=1'
description: |
    Regex matches the end of a filename with the (^) without regex
```

| Value | Description                 |
| ----- | --------------------------- |
| `0`   | off (default)  |
| `1`   | matches start of `filename` (or `fullpath` when **match path** is enabled)  |
| `2`   | match start of `basename`  |


where 2 is match start of basename, 1 is match start of filename (or full path when match path is enabled) and 0 is off (default).

| Query         | Description                                     |
| ------------- | ----------------------------------------------- |
| `^everything` | match start of name with a **non-regex** string |


## Search Delay

```yml
command: '/search_delay=3000'
description: 'delay in `MS`, default = 0 '
```


## Window Title Format

[New Window Title Format announcement](https://www.voidtools.com/forum/viewtopic.php?f=12&t=9803)

<!--

<dl>
<dt><pre>$search:
$s
$s?{$s - }</pre></dt>
<dd>Search using regular expressions.</dd>
<dt>-i, -case</dt>
<dd>Match case.</dd>
</dl>


```
$search:
$s
$s?{$s - }
      The current search.
    Use $s?{text} to insert text only when $s is not empty.

$a
$a?{$a - }
    The active filter.
    Use $a?{text} to insert text only when $a is not empty.

$d
$d?{$d - }
    The active directory.
    Use $d?{text} to insert text only when $d is not empty.
$version:
$v
  The current version.
$instance:
$i
$i?{ ($i)}
  The current instance.
  Use $i?{text} to insert text only when $i is not empty.
$t
Everything
$$
Literal $
$?
Literal ?
${
Literal {
$}
Literal }
$l:
Set to 1 if the last used variable had a non-zero length.
Otherwise, it is empty.
$filelist-filename:
$f
The filename of the opened filelist.
$current-filter:
$filter:
The name of the active filter.
$directory:
The folder sidebar selection.
$match-case:
1 if match case is enabled. Otherwise 0
$match-diacritics:
1 if match diacritics is enabled. Otherwise 0
$match-path:
if match path is enabled. Otherwise 0
$match-whole-words:
1 if match whole words is enabled. Otherwise 0
$match-prefix:
1 if match prefix is enabled. Otherwise 0
$match-suffix:
1 if match suffix is enabled. Otherwise 0
$ignore-punctuation:
1 if ignore punctuation is enabled. Otherwise 0
$ignore-white-space:
1 if ignore white space is enabled. Otherwise 0
$match-regex:
1 if match regex is enabled. Otherwise 0
$is-omit:
1 if a result is omitted. Otherwise 0
$is-temp-omit:
1 if a result is temporarily omitted. Otherwise 0
$is-dupe:
1 if there is a current find dupe operation. Otherwise 0
$is-paused:
1 if index updates are currently paused. Otherwise 0
$is-stopped:
1 if index updates are currently stopped. Otherwise 0
$is-admin:
1 if currently running as administrator. Otherwise 0
$is-read-only:
1 if the database is currently in read-only mode. Otherwise 0
$is-safe-mode:
1 if currently started in safe mode. Otherwise 0
```
-->
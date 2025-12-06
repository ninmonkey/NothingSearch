[Back to Readme](./readme.md)

- [Docs](#docs)
- [Modifiers](#modifiers)
- [New Wildcard Syntax: `*`, `?`, `[ ]`, `[! ]`, `\`](#new-wildcard-syntax-------)
- [Group Expansion](#group-expansion)
- [Preprocessor](#preprocessor)
  - [Command Line](#command-line)
  - [Advanced](#advanced)
  - [Functions](#functions)

## Docs

- [Current Search Modifiers](https://www.voidtools.com/support/everything/searching/#modifiers)
- [Search Preprocessor](https://www.voidtools.com/forum/viewtopic.php?f=12&t=10099)
 
Many of these are added after `1.5a` 

## Modifiers 

| Modifier      | Description                                                                                               | Example                           |
| ------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------- |
| `len`         | is now a search modifier.                                                                                 | `len:stem:>100`                   |
| `binary`      | Treat the search and file content as a byte stream.                                                       | `binary:content:\x00\x00\x01\x10` |
| `hex`         | Convert 2 character hex codes into a single byte and treats the search and file content as a byte stream. | `hex:48656C6C6F`                  |
| `nopunc`      | Ignore punctuation.                                                                                       | `nopunc:spiderman`                |
| `nows`        | Ignore White-space.                                                                                       | `nows:spiderman`                  |
| `prefix`      | Match the start of words.                                                                                 | `prefix:ever`                     |
| `suffix`      | Match the end of words.                                                                                   | `suffix:hosts`                    |
| `atoi`        | Compare a property as an integer.                                                                         | `atoi:album:>10`                  |
| `atof`        | Compare a property as a real number.                                                                      | `atof:album:>1.5`                 |
| `tostring`    | Compare a property as text.                                                                               | `tostring:dm:/02/`                |
| `metric`      | Use the metric size format.                                                                               | `metric:size:1kb == size:1000`    |
| `notindexed`  | Lookup properties and content on disk (not from the index).                                               | `notindexed:length:>5m`           |
| `nohighlight` | Disable highlighting for this term.                                                                       | .                                 |

## New Wildcard Syntax: `*`, `?`, `[ ]`, `[! ]`, `\`

| Modifier | Description                                                                |
| -------- | -------------------------------------------------------------------------- |
| `*`      | Matches any character zero or more times.                                  |
| `?`      | Matches any single character including `/` or `\\`                         |
| `#`      | Matches any single digit `0-9`                                             |
| `[ ]`    | Matches any one of the characters specified in the set.                    |
| `[! ]`   | Matches any one character that is not specified in the set.                |
| `\`      | Escape the following character. (treat the following character as literal) |

New in 1.5

| Wildcard | Description                                                         |
| -------- | ------------------------------------------------------------------- |
| `*`      | will match any character (except `/` or `\\` ) any number of times. |
| `**`     | will match any character any number of times.                       |

## Group Expansion

[Group Expansion](https://www.voidtools.com/forum/viewtopic.php?f=12&t=9795#groupexpansion)

```md
Use <text> near other text to expand.
For example: `gr<a|e>y` is expanded to: `gray|grey`

Use `""` to group expand two groups.
For example: `<fast|slow>""<dog|cat>` is expanded to: `fastdog|slowdog|fastcat|slowcat`

Group expansion also works with search functions that do not support sub-expressions.
For example: `height:<720|1080>` is expanded to: `height:720|height:1080`

## Sub Expressions

[Sub Expressions](https://www.voidtools.com/forum/viewtopic.php?f=12&t=9795#subexpr)

It expands ` ` as `AND` and `|` as `OR` 
```ts
content:<abc 123>
```
becomes

```ts
content:abc content:123
```

```ts
content:<abc|123>
```
becomes
```ts
content:abc | content:123
```

## Preprocessor

```
clipboard:
[len:abc] => 3
[len:"[abc]"] => 5
[eval:1<<17] => 131072
[rand:%10][rand:%10][rand:%10] => (random 3 digits)
[pathpart:"c:\windows\system32"] => "c:\windows"
[day:now:] => (the current day: 1-31)
[formatfiletime:[edate:now:,-12],"YYYYMMDD"] => (same date as now with the previous year)
[define:mylist="Red,Green,Blue,Yellow"][element:$mylist:,",",[randbetween:1,[elementcount:$mylist:,","]]] (pick a random color name)
[define:f<x>="[if:$x:>1,[eval:$x:*[f:[eval:$x:-1]]],1]"][f:5] (factorial 5)

[HKEY_CLASSES_ROOT\*\shell\Find Dupes in Everything\command]
"C:\Program Files\Everything\Everything64.exe" -s size:[getsize:"%1"]
```

### Command Line
```
Set the search to the current date as ISO8601:
Everything64.exe -s [year:now:]-[text:month:now:,00]-[text:day:now:,00]

Set the search to the basename of a full path:
Everything64.exe -s nopath:[basename:"c:\windows\notepad.exe"]

Set the search to a size search for the size of a specified file by filename:
Everything64.exe -s size:[getsize:"c:\windows\notepad.exe"]
```

### Advanced

```
The follow syntax is also supported and is expanded before any other syntax:
#[function:arg1#,:arg2#,:arg3#,:...#]:

Double quotes (") are treated literally.
The following can be used to escape a block of text:
#[[:a literal block of text#]]:

Search operators are preserved in the expanded result.

Parsing a function terminates at a space or OR operator (|) when no []{}<>() call syntax is used.
Use double quotes (") to escape spaces and |.

[function:...] is the "termprocessors" - Search operators in the output are escaped.
#[function:...#]: is the "preprocessor" - Search operators in the output will be processed.
Preprocessor is applied first.
termprocessor is applied last.

#num: = #
#comma: = ,
#colon: = :
#param: = macro parameter

Examples:
#<define:f<x>=#<<:#<if:#x:>1#,:#<eval:#x:*#<f:#<eval:#x:-1#>:#>:#>:#,:1#>:#>>:#>:#<f:5#>: (factorial 5)
```

### Functions 

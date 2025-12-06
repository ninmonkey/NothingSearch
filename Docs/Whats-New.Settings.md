[Back to Readme](./readme.md)

- [Misc](#misc)
  - [Drag Drop Paths](#drag-drop-paths)
  - [Match start of text with `^` **without using regex**](#match-start-of-text-with--without-using-regex)

Many of these are added after `1.5a` 

# Misc

## Drag Drop Paths

```yml
command: '/hdrop_file_format=1'
description: 'drag drop files onto the search box'
```

| Value | Description                 |
| ----- | --------------------------- |
| `0`   | use the full path (default) |
| `1`   | use the base name           |

## Match start of text with `^` **without using regex**

```yml
command: '/match_start_of_filename_with_caret=2'
description: >-
  hji worl

      with indent

  some long text
```

| Value | Description                 |
| ----- | --------------------------- |
| `0`   | use the full path (default) |
| `1`   | use the base name           |

[Back to Readme](./readme.md)

- [Modifiers](#modifiers)
- [Group Expansion](#group-expansion)
- [Sub Expressions](#sub-expressions)

Many of these are added after `1.5a` 

## Modifiers 

- `prefix:<str>`
- `suffix:<str>`

## Group Expansion

[Group Expansion](https://www.voidtools.com/forum/viewtopic.php?f=12&t=9795#groupexpansion)

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
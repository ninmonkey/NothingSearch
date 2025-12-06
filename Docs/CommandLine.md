# Invoking Everything Search

## Basics

### Directly calling `Everything64.exe`
```ps1
$binES = gcm 'C:\Program Files\Everything 1.5a\Everything64.exe'
$binArgs = @( '--help' )
& $binEs @binArgs
```

### Using `es:` protocol

### Using Start-Process -FilePath `es:...` 

```ps1
start-process -FilePath 'es:dm:last3years ext:ps1'
```


### Using `es.exe` command

[`ES` Command Line Arguments ](https://www.voidtools.com/forum/viewtopic.php?t=5762)
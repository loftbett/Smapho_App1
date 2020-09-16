# Memo

## VSC関連
1.  末尾スペース除去をMarkdownの場合に対象外とする方法
https://github.com/microsoft/vscode/issues/1679
```
    "files.trimTrailingWhitespace": true,
    "[markdown]": {
        "files.trimTrailingWhitespace": false
    },
```


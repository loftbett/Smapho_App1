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

## Flutter関連
1. 新規にクラスを作成した場合は、ホットリロードでは適用されないことに注意！  
　クラスの中の動きは変えればリロードで動く  
　変わらないと思ったら、デバッグのリロードボタンを押下
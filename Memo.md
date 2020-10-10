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
1. Controllerクラスを使ったテキストボックスの情報取得  
　https://flutter.keicode.com/basics/textcontroller.php

## その他雑多事項
1. Dartのコーディング記法  
　https://qiita.com/najeira/items/6982eb926f57ae0f2143
1. Flutter開発をする際のDart記法の気持ち悪い点(発表スライド)  
　https://logmi.jp/tech/articles/303939 
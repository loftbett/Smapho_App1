# 勉強した流れ
1. Flutterの公式スターターページを勉強  
    本家(英語)  
    https://flutter.dev/docs/get-started/codelab  
    英語が読めなかったので日本語訳されたページに途中でシフト  
    https://flutter.ctrnost.com/tutorial/tutorial03/  
    ※本家の古いバージョンの日本語訳なので、もしかすると最新Flutterだと表記が異なる可能性あり。   

    途中で分からない書き方などがあったので、次のDart勉強と並行して進める。  
    途中で出てくる画面遷移は難しくなるので、一旦そこでストップして3.に  
    デザインを先に決めて取り掛かろうとAdobeXDなども入れてみたが、先に書き方を把握しないと  
    自動出力されるWidgetについてなどが理解できないため、ひとまず書き方をメインで学習する  

1. Dart文法の勉強  
　Flutterの基になっているDartについて勉強。  
　基本的にJavaやJavaScriptに書き方が似ているので 0からの勉強はせず。  

    参考サイト
    - Dartのコーディング記法  
    　https://qiita.com/najeira/items/6982eb926f57ae0f2143
    - Flutter開発をする際のDart記法の気持ち悪い点(発表スライド)  
    　https://logmi.jp/tech/articles/303939 
    - Flutterユーザーに贈る、Dart言語でハマりがちな問題とその解決法  
    　https://logmi.jp/tech/articles/303939

1. Flutterで簡単なアプリを作ろうと試みる(躓く)   
    最初はStateless, Stateful(SetState)で進めていこうとするが  
    実際にやろうとすると画面遷移(Navigator)やSetState以外の  
    再描画(Stream)、データ補完(Bloc)などの知識が必要になる。  
    1.の公式マニュアルに基本は書いてあるがアプリとしてどうすれば良いのか  
    悩んだため他の人が作ったものを参考に書き進める.

    - Todoリストアプリ(Bloc、Navigatorなど利用)
    　https://qiita.com/popy1017/items/6b2c95d3c03b35ae97e0

1. Flutterで簡単なアプリを作ろうと試みる(SQLite版)  
    Blocでのデータ持ちはアプリの起動で消えてしまうため、ローカルストレージ  
    保管を可能にする必要が出る。Todoアプリで切り替えたものがあるため、  
    それを参考にする。
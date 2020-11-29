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

1. ランダム情報の作成ツール(vscode-random)

    ```
    　　　挿入したい場所にカーソルを持って行き、
    　　　コマンドパレット(command+p)を開いて"random"と打つ
    ```

1. 補完処理のショートカット  
    Command + . で補完候補が出てくる。
    
## Flutter関連
1. 新規にクラスを作成した場合は、ホットリロードでは適用されないことに注意！  
　クラスの中の動きは変えればリロードで動く  
　変わらないと思ったら、デバッグのリロードボタンを押下

## Dart関連
1. ラムダ式について  
　基本的にまずDartで表現される関数は下記のフォーマットがベース。

    ```
    (int a) {           // 引数を()で指定。
        return a+1;　   // 関数内の式は;で終わる
    };                  // 関数自体も;で終わる
    ```
    また、関数を変数とすることが可能。

    ```
    // 返値の型 変数の型(引数) 変数名 = 内容
    int addValue = (int a) { return a+1; };
    
    print(addValue(1)); // 2が表示
    ```
    ラムダ式を用いると下記の形に書き換え可能
    
    ```
    // returnのみの関数であれば、{return }を => に変更可能
    int addValue = (int a) => a + 1;
    // 無名関数として使用することも可能。
    print((int a)=> a+1);
    ```
    関数の引数に関数を渡すことも可能なため、下記の書き方もある?
    ```
    int addValue = (int a)=>a+1;
    int mulValue(addValue(1)) = (int a) => a*1; 
    ```

1. ：について  
    出てくるケースを下記に記載する。
    1. プロパティの指定  
        Widgetなどで 「color: Colors.red」などと記載する
    1. コンストラクタのリダイレクト  
        :の後にリダイレクトするコンストラクタを記載。リダイレクト先の処理→元の処理という実行順
        ```
        Class Person{
            String _name = "";
            Person():this.SetName(){
                print(this._name);
            };
            Person.SetName(){
                this._name = "名前";
            }
        }
        ```
    1. コンストラクタの変数初期化処理  
        ```
        Class Person{
            String _name;
            int _age;
            Person(): this.SetName();
            SetName(String):_name="",
                        _age=18
                    {
                        print(_name);
                    }
        }
        ```
        ※名前付きコンストラクタが存在する場合、そちらには適用されないので注意。
        ※親のコンストラクタを利用する際に利用される(内部では呼び出し不可)
        ```
        class Dog {
            var name;
            var age;
            
            Dog() : this.anonymous();
            Dog.anonymous() : this.name = 'Anonymous',
            this.age = 0;
            Dog.nameAge(name, age) : this.name = name,
            this.age = age;
        }
        class Pochi extends Dog {
          ⭕️　Pochi() : super.nameAge('Pochi', 5);
          ❌　Pochi(){
                super.nameAge('Pochi', 5);
                }
        }
        ```
    1. import/export  
        importはクラス内に対象のライブラリを利用可能にする。  
        exportはクラス内に対象ライブラリのメソッドなどを展開する？
        　→exportで一箇所に全部出力しておいて、そいつをimportすると楽。
        　　→ライブラリによってはエラーが出る。?

    1. シングルトン(シングルトンパターン)  
        下記の要件を満たす
        ①同じ型のインスタンスが private なクラス変数として定義されている。
        ②コンストラクタの可視性が private である。
        ③同じ型のインスタンスを返す getInstance() がクラス関数として定義されている。

        ②はシングルトンを利用するときに勝手に初期化されないようにするため。
        ③が定義されていることで、利用する側はgetInstance()を実行することでシングルトンとなっている
        ものを取得して使うことができる
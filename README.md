# 環境構築

fvmとVSCodeの利用を想定している。  
VSCode用の設定は追加済みである。  

**Flutter SDK**  

- バージョン管理ツール : [FVM](https://fvm.app/)
    - FVMのインストール・設定については、[こちらの記事](https://zenn.dev/riscait/articles/flutter-version-management)が参考になります。
    - FVMの3系を利用しています。[こちらの記事](https://zenn.dev/altiveinc/articles/flutter-version-management-3)を参考ください。
    - ※ 私は`Homebrew`でインストールしています。
- 使用しているバージョンは [.fvmrc](.fvmrc) に記載されています。
- FVMのインストール後、以下の流れで環境構築を実施。
    - プロジェクトのルートディレクトリで、`fvm use`を実行すると、ローカル環境に該当のバージョンがなければインストールされる。
    - VSCode の場合
        - VSCode を再起動する
        - main.dart などの dart ファイルを開き、エディタの右下の「Dart」部分をクリックして、該当のバージョンのFlutterが読み込まれていればOK

### 環境分け
環境は以下を参考に`dev`（開発）と`prod`（本番）で分けています。  
[【Flutter 3.7未満】Dart-defineのみを使って開発環境と本番環境を分ける](https://zenn.dev/altiveinc/articles/separating-environments-in-flutter-old-edition) 

iOSのbuildを実行するため、以下のスクリプトに実行権限を与えてください。  
```console
$ chmod 755 ios/script/retrieve_dart_defines.sh
```

## 実行・ビルド方法

開発環境の実行コマンド  
※`fvm3`系にしたのでVSCodeでは`fvm`つけなくてもいいはずではある。
  
```console
$ fvm flutter run --debug --dart-define=FLAVOR=dev
```
  
本番環境の実行コマンド
```console
$ fvm flutter run --debug --dart-define=FLAVOR=prod
```

ビルドコマンド
```console
# Android
$ flutter build appbundle --release --dart-define=FLAVOR=prod
# iOS
$ flutter build ipa --dart-define=FLAVOR=prod
```

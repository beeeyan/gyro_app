各案件では削除してよい部分

----------------------------------

# 初期設定済みプロジェクト

## プロジェクト作成方法（fvm前提）

プロジェクトは以下で作成している。  

```console
$ fvm use 3.19.6 --force
 $ fvm flutter create \
   --platforms=ios,android \
   --org com.example \
   app
```

## 利用方法

本プロジェクトを`clone`後、以下を案件ごとに書き換える。

### アプリ名称

「アプリ名」で検索して、正しいアプリ名に痴漢

### パッケージ名（bundle Id Application ID）の変更
  
※プロジェクト直下で実行すること
  
```console
$ chmod 755 change_package_name.sh 
```
  
パッケージ名を引数とすると、変更が必要な箇所全て書き換わる。  
例) 「com.example.app」の場合  
  
```console
$ ./change_package_name.sh com.example.app
```
  
※注意  
**元々のパッケージ名と近い内容で変更しようとすると、フォルダを再作成時に余計なファイルまで削除してしまいます。**  
例)
`jp.co.xxx.app` から `jp.co.yyy.app`の変更など  
回避策として、全く違うパッケージ名に変更してからの処理してください。  
  
```console
$ ./change_package_name.sh xxx.yyyy.bbb
$ ./change_package_name.sh com.example.app
```
  
処理が終わったら`change_package_name.sh`は消しておいてもいいかと思う。  

### Flutterバージョン

fvmが使用しているFlutterのバージョンは[.fvmrc](.fvmrc)に記載されている。
Flutterのバージョンを変更したい場合は`fvm use`コマンドを使用する。  
※ 設定ファイルの書き換えもあるため、コマンドで実施する。  

```console
$ vm use 3.19.6
```

### Githubの設定

- 案件のリポジトリを作成
- remote urlを案件のリポジトリに変更。

```console
# 現在のremote url を確認
$ git remote -v
# remote url を変更
$ git remote set-url origin {new-url}
# 正しく変更できているか確認
$ git remote -v
```

## 事前追加している実装・対応

変更が必要な場合は、案件ごとに変更すること。  

### lintの設定  
[pedantic_mono](https://pub.dev/packages/pedantic_mono)を採用。versionはanyとしている。  
変更可否の判断基準 : 外的要因で指定がある場合。それ以外は変更しないことを推奨。  

### 輸出コンプライアンスの設定  
  
暗号化を使用していない、もしくは免除の対象になる暗号化のみを使用していることを示す。　
Appleのストアでの操作を楽にできる。([参考](https://tommy10344.hatenablog.com/entry/2020/04/29/025809))  
免除の対象になる暗号化 : HTTPSや、OSに組み込まれた標準の暗号化  
変更可否の判断基準 : 免除の対象になる暗号化以外を使用している場合。※ 2023/1/5時点では、今まで経験はない。  

### パッケージのimport方法を自動で修正する設定

相対パス・絶対パスを使い分けるようにしており、人力でやるとミスが発生するので自動でimport方法を修正するように追加した。  
「相対パス・絶対パスを使い分ける」方針にしたのは以下の公式ガイドが参考。  
[PREFER relative import paths](https://dart.dev/effective-dart/usage#prefer-relative-import-paths)  
  
変更可否の判断基準 : 「絶対パス」で統一する指定がある場合など。  

### Appleの対応言語に日本語を追加
  
Apple Storeで言語表示を「日本語」にするには本対応が必要。
最低限の対応しかしていない。  
参考 : https://eda-inc.jp/post-4472/  
注意 言語ごとにATTを設定する場合は、対応言語のファイルに記載する必要がある。（日本語のみの場合は`info.plist`のみの記載でも最悪可能）  
  
変更可否の判断基準 : 対応言語に日本語がない  

### Dioの実装

[フォルダ](./lib/api/)  

元々の参考  
https://github.com/KosukeSaigusa/flutterfire-commons/tree/main/packages/routing_with_riverpod/example  
  
変更可否の判断基準 : APIとのやりとりがない場合は削除推奨。  
  
また[base_response_data](./lib/api/model/base_response_data/base_response_data.dart)は要件によって変えた方がいいかもしれない。  
※ 現状そのままmainにデータ入れている。「参考」の実装などでは「message」はどのAPIでも存在する想定で作成されている。

### PrivateManifestの設定

shared_preferencesはほぼほぼ利用する想定で、以下のみデフォルトで追加している。  
※ 必要なければ消す・適宜アプリごとに必要な設定を追加すること。  
Privacy Accessed API Type : User Defaults  
Privacy Accessed API Reasons : CA92.1  
  
[参考](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files/describing_use_of_required_reason_api/#4278401)

以下README雛形

----------------------------------

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
    - プロジェクトのルートディレクトリで、`fvm flutter --version`を実行すると、ローカル環境に該当のバージョンがなければインストールされる。
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

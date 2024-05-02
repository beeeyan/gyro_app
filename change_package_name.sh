#!/bin/sh

if [ $# != 1 ]; then
    echo 引数エラー、パッケージ名を引数で渡してください: $*
    exit 1
else
    echo パッケージ名（bundle Id Application ID）を「$1」に変更
    #「package="(初期パッケージ)"」を「package="(引数)"」で置換
    sed -i "" -E s/package=\".*\"/package=\"$1\"/g ./android/app/src/main/AndroidManifest.xml
    sed -i "" -E s/package=\".*\"/package=\"$1\"/g ./android/app/src/debug/AndroidManifest.xml
    sed -i "" -E s/package=\".*\"/package=\"$1\"/g ./android/app/src/profile/AndroidManifest.xml
    echo AndroidManifest.xmlの変更完了
    # 「applicationId "(初期パッケージ)"」を「applicationId "(引数)"」で置換
    sed -i "" -E s/applicationId" \".*\""/applicationId" \"$1\""/g ./android/app/build.gradle 
    echo build.gradleの変更完了
    # MainActivityのpackage名を変更
    # MainActivityの場所は初期のパッケージ名で変わるのでfindコマンドで取得する
    KTPATH=`find . -name MainActivity.kt`
    sed -i "" -E s/package" .*"/package" $1"/g $KTPATH
    echo MainActivity.ktの変更完了
    # フォルダ名の作成用に「.」を「/」に変換
    DIR=`echo $1 | sed -e "s/\./\//g"`
    # 新しいパッケージ名でフォルダ作成
    mkdir -p ./android/app/src/main/kotlin/$DIR
    # ファイルの移動
    mv $KTPATH ./android/app/src/main/kotlin/$DIR
    # 以前のフォルダを削除
    rm -r $(echo $KTPATH | grep -o ./android/app/src/main/kotlin/'[^/]*/')
    echo フォルダ変更完了
    # iOSのバンドルIDの変更
    # Xcodeで変更する場合も、変更箇所は一箇所だけ
    sed -i "" -E s/PRODUCT_BUNDLE_IDENTIFIER" = .*"/PRODUCT_BUNDLE_IDENTIFIER" = \"$1\$(APP_ID_SUFFIX)\";"/g ./ios/Runner.xcodeproj/project.pbxproj
    echo バンドルID変更完了
fi
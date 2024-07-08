@echo off
setlocal enabledelayedexpansion

set "SOURCE={SOURCE_DIR}"
set "DESTINATION={DIST_DIR}"

:: 7-Zipのパスを設定（インストールされている場合）
set "SEVENZIP=C:\Program Files\7-Zip\7z.exe"

:: 7-Zipが見つからない場合は、標準のexpand.exeを使用
if not exist "%SEVENZIP%" (
    set "SEVENZIP=expand"
)

:: ソースディレクトリ内のZIPファイルを古い順にソート
for /f "delims=" %%F in ('dir /b /s /o:d "%SOURCE%\*.zip"') do (
    set "ZIPFILE=%%F"
    
    :: ZIPファイルの解凍
    if "%SEVENZIP%"=="expand" (
        expand "!ZIPFILE!" -F:* "%DESTINATION%"
    ) else (
        "%SEVENZIP%" x "!ZIPFILE!" -o"%DESTINATION%" -y
    )
    
    if errorlevel 1 (
        echo エラー: !ZIPFILE! の解凍に失敗しました。
    ) else (
        echo !ZIPFILE! を正常に解凍しました。
    )
)

echo 処理が完了しました。
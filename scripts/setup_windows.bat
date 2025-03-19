@echo off
setlocal enabledelayedexpansion

REM Check if typst.toml file exists in the current directory
if not exist "typst.toml" (
    echo Error: This script must be run from the root directory of the project.
    exit /b 1
)

REM Get the current directory (equivalent to $(pwd))
set PKG_DIR=%cd%
echo Current package directory: %PKG_DIR%

REM Set target directory
set TARGET_DIR=%USERPROFILE%\AppData\Local\typst\packages\local\superTheorems
echo Target directory: %TARGET_DIR%

REM Use PowerShell to extract the version from typst.toml
echo Extracting version from typst.toml using PowerShell...
for /f "delims=" %%i in ('powershell -Command "Select-String -Pattern '^version = ' -Path typst.toml | ForEach-Object { $_.Line -replace 'version = \"|\"', '' }"') do (
    set VERSION=%%i
    echo Found version: !VERSION!
)

REM Check if the version was extracted
if not defined VERSION (
    echo Error: Version not found in typst.toml.
    exit /b 1
)

REM Create target directory if it doesn't exist
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
    echo Created target directory: %TARGET_DIR%
)

REM Create symbolic link (if possible) to the version directory
echo Creating symbolic link...
mklink /d "%TARGET_DIR%\%VERSION%" "%PKG_DIR%"
echo Symbolic link created: %TARGET_DIR%\%VERSION%

endlocal

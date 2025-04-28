@echo off
setlocal enabledelayedexpansion

REM Get the folder where the script is located
set "base_path=%~dp0"

REM Define the input and output folders relative to the script's location
set "input_folder=%base_path%HEIC"
set "output_folder=%base_path%JPG"

REM Check if ImageMagick is installed
magick -version >nul 2>&1
if errorlevel 1 (
    echo ImageMagick is not installed or not added to PATH. Please install it first.
    pause
    exit /b
)

REM Check if input folder exists
if not exist "%input_folder%" (
    echo Input folder does not exist: %input_folder%
    pause
    exit /b
)

REM Create output folder if it doesn't exist
if not exist "%output_folder%" (
    mkdir "%output_folder%"
)

REM Navigate to the input folder
cd /d "%input_folder%"

REM Initialize a counter
set "counter=1"

REM Loop through all HEIC files in the folder
for %%f in (*.heic) do (
    REM Generate the output filename
    set "output_file=%output_folder%\image!counter!.jpg"
    REM Convert HEIC to JPG using ImageMagick
    magick convert "%%~f" "!output_file!"
    REM Increment the counter
    set /a "counter+=1"
)

echo All HEIC files have been converted to JPG in %output_folder%.
pause

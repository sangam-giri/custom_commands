@echo off
if "%1"=="generate" (
    if "%2"=="bloc" (
    echo Enter bloc name:
    set /p name=
    )
) else (
    echo "Invalid Command"
)
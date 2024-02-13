@echo off
setlocal enabledelayedexpansion

set FILE_PATH="%~dp0../git-x/origin_branch.txt"

if "%1"=="commit" (
    if not "%2"=="" (
        for /f "tokens=*" %%a in ('type "%FILE_PATH%"') do (
            echo git init
            echo git add .
            echo git commit -m %2
            echo git pull origin %%a --no-rebase
        )
    ) else (
        echo Missing commit message argument.
    )
) else if "%1"=="branch" (
    if "%2"=="reset" (
        set /p USER_INPUT="Enter the new origin: "
        if exist "%FILE_PATH%" (
            echo !USER_INPUT! > "%FILE_PATH%"
            echo Origin updated successfully.
        ) else (
            echo !USER_INPUT! > "%FILE_PATH%"
            echo Origin added successfully.
        )
    ) else (
        echo Invalid branch argument. Please use "reset".
    )
) else (
    if "%1"=="all" (
        if "%2"=="commands" (
           echo ================================================================
           echo                           ALL COMMAND                           
           echo ================================================================
           echo 1. git-x branch reset                   Updating origin branch
           echo 2. git-x origin branch                  Get current origin branch
           echo 3. git-x branch reset                   Update origin branch
           echo 4. git-x commit [commit_message]        Updating origin branch
           echo ================================================================
        ) 
    ) else (
        echo Invalid command.
    )
)

endlocal

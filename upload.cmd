@echo off
title Git Uploader
color 0A

:: Set the working directory variable
set WORKING_DIR=c:\Temp\matlab

:: Change to the working directory
echo [INFO] Changing to working directory: %WORKING_DIR%
cd /d %WORKING_DIR%
if %errorlevel% neq 0 (
    echo [ERROR] Failed to change directory to %WORKING_DIR%
    pause
    exit /b 1
)

echo ==============================================
echo  Git Uploader - Uploading Changes to GitHub
echo ==============================================
echo.

:: Check Git status
echo [STATUS] Checking repository status...
git status
if %errorlevel% neq 0 (
    echo [ERROR] Failed to check Git status
    pause
    exit /b 1
)
echo.

:: Stage all changes
echo [STAGING] Adding all changes to the staging area...
git add .
if %errorlevel% neq 0 (
    echo [ERROR] Failed to stage changes
    pause
    exit /b 1
)
echo [SUCCESS] All changes staged successfully!
echo.

:: Commit changes
echo [COMMIT] Committing changes with message "upload"...
git commit -m "upload"
if %errorlevel% neq 0 (
    echo [ERROR] Failed to commit changes
    pause
    exit /b 1
)
echo [SUCCESS] Changes committed successfully!
echo.

:: Push changes to remote
echo [PUSH] Pushing changes to origin/main...
git push origin main
if %errorlevel% neq 0 (
    echo [ERROR] Failed to push changes
    pause
    exit /b 1
)
echo [SUCCESS] Changes pushed to GitHub successfully!
echo.

:: Final status check
echo [STATUS] Checking final repository status...
git status
if %errorlevel% neq 0 (
    echo [ERROR] Failed to check final Git status
    pause
    exit /b 1
)
echo.

echo ==============================================
echo  Git Uploader - Upload Complete!
echo ==============================================
pause
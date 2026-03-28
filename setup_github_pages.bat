@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ============================================================
:: setup_github_pages.bat — First-time GitHub Pages Setup
:: รันครั้งเดียวเพื่อ setup ทุกอย่างตั้งแต่ต้น
:: ============================================================

echo.
echo ============================================================
echo   AT Athina — GitHub Pages First-Time Setup
echo ============================================================
echo.
echo สคริปต์นี้จะ:
echo   1. ถาม GitHub username + email + token
echo   2. สร้าง repo บน GitHub อัตโนมัติ (ผ่าน API)
echo   3. Push เว็บขึ้น GitHub
echo   4. เปิด GitHub Pages Settings ให้อัตโนมัติ
echo   5. บันทึกการตั้งค่าไว้ใช้ครั้งต่อไป
echo.
echo ============================================================
echo.

:: ---- รับข้อมูลจากผู้ใช้ ----
set /p GITHUB_USER="กรอก GitHub Username (เช่น atathina-office): "
set /p GITHUB_EMAIL="กรอก Email ที่สมัคร GitHub: "
set /p GITHUB_TOKEN="วาง Personal Access Token (จะไม่แสดง ปกติ): "
set GITHUB_REPO=atathina
set WEBSITE_DIR=C:\Users\ntnsi\Documents\accounting_office_secret\website

echo.
echo ---- ข้อมูลที่รับ ----
echo Username : %GITHUB_USER%
echo Email    : %GITHUB_EMAIL%
echo Repo     : %GITHUB_REPO%
echo Token    : [ซ่อน]
echo.

:: ---- บันทึก config ไว้ใช้ครั้งต่อไป ----
echo Saving config for deploy.bat...
powershell -Command "(Get-Content '%WEBSITE_DIR%\deploy.bat') -replace 'YOUR_USERNAME', '%GITHUB_USER%' -replace 'YOUR_EMAIL', '%GITHUB_EMAIL%' | Set-Content '%WEBSITE_DIR%\deploy.bat'"

:: ---- สร้าง Repository บน GitHub ผ่าน API ----
echo.
echo [1/4] สร้าง GitHub Repository "%GITHUB_REPO%"...
curl -s -X POST ^
  -H "Authorization: token %GITHUB_TOKEN%" ^
  -H "Accept: application/vnd.github.v3+json" ^
  -d "{\"name\":\"%GITHUB_REPO%\",\"description\":\"AT Athina - สำนักงานบัญชีและที่ปรึกษาภาษี\",\"homepage\":\"https://%GITHUB_USER%.github.io/%GITHUB_REPO%\",\"private\":false,\"has_pages\":true}" ^
  https://api.github.com/user/repos > "%TEMP%\gh_create_result.json" 2>&1

:: ตรวจสอบผล
findstr /C:"\"full_name\"" "%TEMP%\gh_create_result.json" >nul 2>&1
if errorlevel 1 (
    findstr /C:"already exists" "%TEMP%\gh_create_result.json" >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] สร้าง repo ไม่สำเร็จ ตรวจสอบ Token และ Username
        type "%TEMP%\gh_create_result.json"
        pause
        exit /b 1
    ) else (
        echo [INFO] Repo มีอยู่แล้ว — ใช้ต่อได้เลย
    )
) else (
    echo [OK] สร้าง repo สำเร็จ!
)

:: ---- Setup git ----
echo.
echo [2/4] Setup git config...
cd /d "%WEBSITE_DIR%"
git config user.name "AT Athina"
git config user.email "%GITHUB_EMAIL%"
git remote remove origin 2>nul
git remote add origin https://%GITHUB_USER%:%GITHUB_TOKEN%@github.com/%GITHUB_USER%/%GITHUB_REPO%.git
git branch -M main

:: ---- Push ----
echo.
echo [3/4] Push เว็บขึ้น GitHub...
git push -u origin main --force

if errorlevel 1 (
    echo [ERROR] Push ไม่สำเร็จ — ตรวจสอบ Token หรือ network
    pause
    exit /b 1
)
echo [OK] Push สำเร็จ!

:: ---- เปิด GitHub Pages Settings ----
echo.
echo [4/4] เปิด GitHub Pages Settings...
echo กรุณาทำในหน้าต่างที่เปิดขึ้น:
echo   Source: Deploy from a branch
echo   Branch: main  /  / (root)  → Save
echo.
start "" "https://github.com/%GITHUB_USER%/%GITHUB_REPO%/settings/pages"
timeout /t 3 >nul

:: ---- เปิดใช้ Pages ผ่าน API ----
curl -s -X POST ^
  -H "Authorization: token %GITHUB_TOKEN%" ^
  -H "Accept: application/vnd.github.v3+json" ^
  -d "{\"source\":{\"branch\":\"main\",\"path\":\"/\"}}" ^
  https://api.github.com/repos/%GITHUB_USER%/%GITHUB_REPO%/pages > "%TEMP%\gh_pages_result.json" 2>&1

findstr /C:"\"url\"" "%TEMP%\gh_pages_result.json" >nul 2>&1
if not errorlevel 1 (
    echo [OK] GitHub Pages เปิดใช้งานแล้วผ่าน API!
)

:: ---- อัปเดต URL ใน index.html และ sitemap.xml ----
echo.
echo [BONUS] อัปเดต URL ใน meta tags...
set NEW_URL=https://%GITHUB_USER%.github.io/%GITHUB_REPO%
powershell -Command "(Get-Content '%WEBSITE_DIR%\index.html') -replace 'https://atathina\.com', '%NEW_URL%' | Set-Content '%WEBSITE_DIR%\index.html' -Encoding UTF8"
powershell -Command "(Get-Content '%WEBSITE_DIR%\sitemap.xml') -replace 'https://atathina\.com', '%NEW_URL%' | Set-Content '%WEBSITE_DIR%\sitemap.xml' -Encoding UTF8"
powershell -Command "(Get-Content '%WEBSITE_DIR%\robots.txt') -replace 'https://atathina\.com', '%NEW_URL%' | Set-Content '%WEBSITE_DIR%\robots.txt' -Encoding UTF8"

:: Commit URL changes
git add index.html sitemap.xml robots.txt
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Auto: update URLs to %NEW_URL%"
    git push origin main
    echo [OK] อัปเดต URL สำเร็จ!
)

:: ---- บันทึกสรุป ----
echo.
echo ============================================================
echo   SETUP สำเร็จทั้งหมด!
echo.
echo   URL เว็บไซต์: %NEW_URL%
echo   (รอ 2-5 นาที แล้วเปิดในเบราว์เซอร์)
echo.
echo   อัปเดตเว็บครั้งต่อไป: ดับเบิ้ลคลิก deploy.bat
echo ============================================================
echo.

:: เปิดเว็บในเบราว์เซอร์
timeout /t 5 >nul
start "" "%NEW_URL%"

pause

@echo off
chcp 65001 >nul
setlocal

:: ============================================================
:: deploy.bat — AT Athina Website Deployer
:: วิธีใช้: ดับเบิ้ลคลิกไฟล์นี้ หรือรันใน terminal
:: ============================================================

set GITHUB_USER=YOUR_USERNAME
set GITHUB_REPO=atathina
set GITHUB_EMAIL=YOUR_EMAIL
set WEBSITE_DIR=C:\Users\ntnsi\Documents\accounting_office_secret\website

echo.
echo ============================================================
echo   AT Athina — Deploy to GitHub Pages
echo ============================================================
echo.

:: ไปที่โฟลเดอร์เว็บ
cd /d "%WEBSITE_DIR%"

:: ตรวจสอบว่ามี git repo แล้ว
if not exist ".git" (
    echo [SETUP] เริ่มต้น git repo...
    git init
    git config user.name "AT Athina"
    git config user.email "%GITHUB_EMAIL%"
)

:: ตรวจสอบว่า remote ถูกต้อง
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo [SETUP] เชื่อม GitHub...
    git remote add origin https://github.com/%GITHUB_USER%/%GITHUB_REPO%.git
) else (
    git remote set-url origin https://github.com/%GITHUB_USER%/%GITHUB_REPO%.git
)

:: Rename branch เป็น main
git branch -M main

:: Commit การเปลี่ยนแปลง
echo.
echo [GIT] กำลัง commit...
git add index.html netlify.toml robots.txt sitemap.xml .gitignore
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Update website %DATE% %TIME:~0,5%"
    echo [GIT] Committed!
) else (
    echo [GIT] ไม่มีการเปลี่ยนแปลง — ข้ามขั้นตอน commit
)

:: Push ขึ้น GitHub
echo.
echo [PUSH] กำลัง push ขึ้น GitHub...
echo หมายเหตุ: ถ้ามีช่องให้กรอก Password ให้ใส่ TOKEN (ไม่ใช่รหัสผ่าน GitHub จริง)
echo ดูคู่มือ: MAINTENANCE_GUIDE.md
echo.
git push -u origin main

echo.
echo ============================================================
echo   สำเร็จ! เว็บไซต์พร้อมใช้งาน:
echo   https://%GITHUB_USER%.github.io/%GITHUB_REPO%
echo ============================================================
echo.
echo (ครั้งแรก: ต้องเปิด GitHub Settings → Pages ด้วย — ดูคู่มือ)
echo.
pause

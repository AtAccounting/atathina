@echo off
chcp 65001 >nul
:: ============================================================
:: update_urls.bat — แก้ URL ทุกจุดในเว็บพร้อมกัน
:: ใช้เมื่อ: ได้ domain ใหม่ หรือย้าย hosting
:: ============================================================

set WEBSITE_DIR=C:\Users\ntnsi\Documents\accounting_office_secret\website

echo.
echo ============================================================
echo   AT Athina — Update URLs
echo ============================================================
set /p OLD_URL="URL เก่า (ที่ต้องการแทนที่): "
set /p NEW_URL="URL ใหม่: "
echo.
echo กำลังแทนที่: %OLD_URL%  -->  %NEW_URL%

cd /d "%WEBSITE_DIR%"
powershell -Command "(Get-Content 'index.html') -replace [regex]::Escape('%OLD_URL%'), '%NEW_URL%' | Set-Content 'index.html' -Encoding UTF8"
powershell -Command "(Get-Content 'sitemap.xml') -replace [regex]::Escape('%OLD_URL%'), '%NEW_URL%' | Set-Content 'sitemap.xml' -Encoding UTF8"
powershell -Command "(Get-Content 'robots.txt') -replace [regex]::Escape('%OLD_URL%'), '%NEW_URL%' | Set-Content 'robots.txt' -Encoding UTF8"

echo [OK] อัปเดตครบทุกไฟล์แล้ว!
echo รัน deploy.bat เพื่ออัปโหลดขึ้นเว็บ
echo.
pause

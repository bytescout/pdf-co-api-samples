@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ReplaceTextWithImageFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
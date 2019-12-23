@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ReplaceTextWithImageFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
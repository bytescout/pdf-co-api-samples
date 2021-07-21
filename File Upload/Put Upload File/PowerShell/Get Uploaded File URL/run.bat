@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\UploadFileAndGetURL.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\replaceStringFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
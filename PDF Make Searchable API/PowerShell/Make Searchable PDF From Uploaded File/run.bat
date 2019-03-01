@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\MakeSearchablePdfFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
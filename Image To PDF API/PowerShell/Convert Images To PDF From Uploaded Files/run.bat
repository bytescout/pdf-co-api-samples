@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertImagesToPdfFromUploadedFiles.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
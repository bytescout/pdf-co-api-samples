@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ClassifyPdfWithUploadAsync.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
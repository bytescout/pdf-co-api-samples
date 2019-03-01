@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ReadBarcodeFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
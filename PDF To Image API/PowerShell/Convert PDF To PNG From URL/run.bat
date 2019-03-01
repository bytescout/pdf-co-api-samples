@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToPngFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
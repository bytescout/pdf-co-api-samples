@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToCsvFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
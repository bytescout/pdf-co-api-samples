@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToJsonFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
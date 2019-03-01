@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToTextFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
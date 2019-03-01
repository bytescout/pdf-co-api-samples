@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToHtmlFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
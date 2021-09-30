@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXlsxFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
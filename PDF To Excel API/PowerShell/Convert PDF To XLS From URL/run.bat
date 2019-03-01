@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXlsFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
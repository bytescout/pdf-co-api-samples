@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXmlFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
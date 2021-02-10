@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToCsvFromUploadedFileAsync.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
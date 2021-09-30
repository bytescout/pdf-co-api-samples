@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXlsFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
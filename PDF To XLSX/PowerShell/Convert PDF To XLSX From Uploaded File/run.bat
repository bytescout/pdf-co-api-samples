@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXlsxFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
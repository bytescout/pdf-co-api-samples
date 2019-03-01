@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GetPdfInfoFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
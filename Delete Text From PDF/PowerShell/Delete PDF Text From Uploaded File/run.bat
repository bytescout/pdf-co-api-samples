@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\DeletePdfTextFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
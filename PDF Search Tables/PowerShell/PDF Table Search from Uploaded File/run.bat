@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\PDFTableSearchFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
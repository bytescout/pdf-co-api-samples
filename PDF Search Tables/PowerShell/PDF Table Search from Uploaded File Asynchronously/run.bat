@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\PDFTableSearchFromUploadedFileAsync.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
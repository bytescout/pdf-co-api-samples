@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\PDFTextSearchFromUploadedFileAsync.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
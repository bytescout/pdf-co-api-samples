@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\SplitPdfFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
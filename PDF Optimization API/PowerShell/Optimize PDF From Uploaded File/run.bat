@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\OptimizePdfFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
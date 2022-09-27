@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\OptimizePdfFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
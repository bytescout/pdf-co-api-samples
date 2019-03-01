@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\OptimizePdfFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
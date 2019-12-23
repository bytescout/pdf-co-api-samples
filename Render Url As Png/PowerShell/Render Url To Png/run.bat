@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\RenderUrlToPng.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
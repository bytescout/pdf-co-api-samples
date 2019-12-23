@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\RenderUrlToJpg.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertDocToPdfFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
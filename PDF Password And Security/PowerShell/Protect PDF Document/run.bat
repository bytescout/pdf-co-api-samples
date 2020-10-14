@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ProtectPDFDocument.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
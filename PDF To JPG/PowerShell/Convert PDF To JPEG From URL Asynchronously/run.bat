@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToJpegFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
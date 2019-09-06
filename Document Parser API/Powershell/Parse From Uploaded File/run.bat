@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ParseFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
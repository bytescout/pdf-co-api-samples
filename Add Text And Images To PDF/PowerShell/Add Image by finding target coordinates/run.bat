@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\AddImageByFindingTargetCoordinates.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
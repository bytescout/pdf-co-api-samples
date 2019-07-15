@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\AddTextByFindingTargetCoordinates.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
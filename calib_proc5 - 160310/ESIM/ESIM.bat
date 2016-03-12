@echo off
echo Starting ESIM
%GSEDRIVE%
cd %GSEPATH%
if exist %GSEPATH%\GSEERROR del %GSEPATH%\GSEERROR > nul
set GSEACTION=SCENARIO
GAMS esim.gms
echo %errorlevel% > %gsepath%gseerror
echo Finished!

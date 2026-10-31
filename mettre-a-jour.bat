@echo off
rem Met a jour le fond d ecran avec la derniere version publiee sur GitHub
cd /d "%~dp0"
git pull
echo.
echo Termine. Dans Wallpaper Engine, re-applique le fond d ecran pour voir les changements.
pause

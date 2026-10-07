@echo off
REM Jednym kliknieciem: srodowisko, obliczenia i podglad strony (Windows).
cd /d "%~dp0"
chcp 65001 >nul

if not exist ".venv\Scripts\python.exe" (
    echo [1/4] Tworze srodowisko .venv ...
    py -3.12 -m venv .venv 2>nul || python -m venv .venv
    if errorlevel 1 ( echo Nie udalo sie utworzyc .venv. Zainstaluj Python 3.12 z python.org. & pause & exit /b 1 )
    echo [2/4] Instaluje biblioteki ...
    ".venv\Scripts\python.exe" -m pip install --upgrade pip
    ".venv\Scripts\python.exe" -m pip install -r requirements.txt
    if errorlevel 1 ( echo Instalacja bibliotek nie powiodla sie. & pause & exit /b 1 )
)

if not exist "outputs\site\index.html" (
    echo [3/4] Licze wskazniki i generuje strone ...
    ".venv\Scripts\python.exe" src\landsat_lab.py
    if errorlevel 1 ( echo Obliczenia nie powiodly sie. & pause & exit /b 1 )
)

echo [4/4] Strona: http://127.0.0.1:8000/   (zatrzymanie: Ctrl+C)
start "" http://127.0.0.1:8000/
".venv\Scripts\python.exe" -m http.server 8000 --bind 127.0.0.1 --directory outputs\site

#!/usr/bin/env bash
# Srodowisko, obliczenia i podglad strony (macOS / Linux).
set -e
cd "$(dirname "$0")"
PY=$(command -v python3.12 || command -v python3)
if [ ! -x .venv/bin/python ]; then
  "$PY" -m venv .venv
  .venv/bin/python -m pip install --upgrade pip
  .venv/bin/python -m pip install -r requirements.txt
fi
[ -f outputs/site/index.html ] || .venv/bin/python src/landsat_lab.py
echo "Strona: http://127.0.0.1:8000/  (zatrzymanie: Ctrl+C)"
.venv/bin/python -m http.server 8000 --bind 127.0.0.1 --directory outputs/site

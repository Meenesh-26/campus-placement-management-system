@echo off
color 0B
title CampusHire Pro Startup
echo =========================================================
echo      CampusHire Pro - Full Project Startup Script
echo =========================================================
echo This script will install all dependencies and start both 
echo the Backend and Frontend servers in separate windows.
echo.

cd /d "%~dp0"

:: ---- BACKEND SETUP ----
echo [1/4] Checking Backend Environment...
cd backend
if not exist ".venv\" (
    echo Creating Python virtual environment...
    python -m venv .venv
)

echo [2/4] Installing Backend Dependencies and Starting Server...
:: Open a new command prompt for the backend that installs dependencies, runs DB migrations, and starts the server
start "CampusHire Backend" cmd /k "echo Activating Virtual Environment... && call .venv\Scripts\activate.bat && echo Installing Requirements... && pip install -r requirements.txt && echo Applying Database Migrations... && alembic upgrade head && echo Starting Backend Server... && python -m uvicorn app.main:app --reload --port 8000"

:: ---- FRONTEND SETUP ----
cd ..\frontend
echo.
echo [3/4] Checking Frontend Dependencies...
if not exist "node_modules\" (
    echo Installing node modules (this may take a few minutes)...
    call npm install
)

echo.
echo [4/4] Starting Frontend Server...
:: Open a new command prompt for the frontend and start the dev server
start "CampusHire Frontend" cmd /k "echo Starting Frontend... && npm run dev"

cd ..
echo.
echo =========================================================
echo  Success! Both servers are starting up in new windows.
echo  - Backend is running on http://localhost:8000
echo  - Frontend is running on http://localhost:5173 (typically)
echo.
echo  Note: If this is the very first time on a new system, 
echo  wait a minute for the dependency installation to finish 
echo  in the newly opened windows.
echo =========================================================
pause

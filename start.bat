@echo off
setlocal

rem === Paths & project name ===
set "DIR=%~dp0"
set "GPU_FILE=%DIR%/config/docker-compose-gpu.yml"
set "CPU_FILE=%DIR%/config/docker-compose-cpu.yml"
set "PROJECT=local-ai-infra"

echo Select mode:
echo   [1] GPU
echo   [2] CPU
choice /c 12 /n /m "Enter 1 or 2: "
if errorlevel 2 set "MODE=2"
if errorlevel 1 set "MODE=1"

if "%MODE%"=="1" (
  set "FILE=%GPU_FILE%"
  echo Using GPU mode.
) else if "%MODE%"=="2" (
  if exist "%CPU_FILE%" (
    set "FILE=%CPU_FILE%"
  ) else (
    echo ERROR: CPU compose file not found: "%CPU_FILE%".
    exit /b 1
  )
  echo Using CPU mode.
) else (
  echo Invalid choice.
  exit /b 1
)

if not exist "%FILE%" (
  echo ERROR: Compose file "%FILE%" not found.
  exit /b 1
)

rem Prefer Docker Compose v2, fall back to v1
docker compose version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
  echo Running: docker compose -f "%FILE%" -p "%PROJECT%" up -d
  docker compose -f "%FILE%" -p "%PROJECT%" up -d
  goto :end
)

docker-compose --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
  echo Running: docker-compose -f "%FILE%" -p "%PROJECT%" up -d
  docker-compose -f "%FILE%" -p "%PROJECT%" up -d
  goto :end
)

echo.
echo ERROR: Docker Compose not found.
echo - Install Docker Desktop (includes "docker compose") or docker-compose v1.
exit /b 1

:end
echo.
echo Done.
endlocal
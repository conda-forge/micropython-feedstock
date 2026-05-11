@echo on

msbuild "%SRC_DIR%\mpy-cross\mpy-cross.vcxproj" ^
  /p:Configuration=Release ^
  /p:Platform=x64 ^
  /m
if errorlevel 1 exit /b 1

msbuild "%SRC_DIR%\ports\windows\micropython.vcxproj" ^
  /p:Configuration=Release ^
  /p:Platform=x64 ^
  /p:PyVariant=standard ^
  /m
if errorlevel 1 exit /b 1

if not exist "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"

copy /Y "%SRC_DIR%\ports\windows\build-standard\micropython.exe" "%LIBRARY_BIN%\micropython.exe"
if errorlevel 1 exit /b 1

copy /Y "%SRC_DIR%\mpy-cross\build\mpy-cross.exe" "%LIBRARY_BIN%\mpy-cross.exe"
if errorlevel 1 exit /b 1

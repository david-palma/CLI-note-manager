:: Simple CLI-based note manager
@echo off

:: Set the preferred editor (default to Notepad)
set "EDITOR=notepad"

:: Check if micro is available, and use it as the editor if found
if exist "%ProgramFiles%\Micro\micro.exe" (
    set "EDITOR=%ProgramFiles%\Micro\micro.exe"
) else if exist "%ProgramFiles(x86)%\Micro\micro.exe" (
    set "EDITOR=%ProgramFiles(x86)%\Micro\micro.exe"
)

:: Set directory for notes
if exist "D:\" (
    set notes=D:\Documents\.notes
    if not exist "%notes%" mkdir "%notes%"
) else (
    set notes=C:\Documents\.notes
    if not exist "%notes%" mkdir "%notes%"
)

:: Change directory to notes
pushd "%notes%"

:: Check the number of inputs
set /a args=0
for %%A in (%*) do set /a args+=1

:: Validate command-line arguments
if %args% gtr 2 (
    echo Error: Too many arguments.
    echo.
    goto:HELP
)

:: Route commands
if "%~1" neq "" (
    if /i "%~1"=="-l"       goto:LIST_NOTES
    if /i "%~1"=="--list"   goto:LIST_NOTES
    if /i "%~1"=="-n"       goto:NEW_NOTE
    if /i "%~1"=="--new"    goto:NEW_NOTE
    if /i "%~1"=="-e"       goto:EDIT_NOTE
    if /i "%~1"=="--edit"   goto:EDIT_NOTE
    if /i "%~1"=="-d"       goto:DELETE_NOTE
    if /i "%~1"=="--delete" goto:DELETE_NOTE
    if /i "%~1"=="-s"       goto:SHOW_NOTE
    if /i "%~1"=="--show"   goto:SHOW_NOTE
    if /i "%~1"=="-h"       goto:HELP
    if /i "%~1"=="--help"   goto:HELP
) else (
    goto:LIST_NOTES
)

:: Unknown command
echo Error: Unknown command "%~1".
goto:HELP


:HELP
:: Display help information
echo A very simple CLI-based note taking and note files manager application.
echo.
echo Usage: note [OPTION] [FILENAME]
echo.
echo OPTIONS:
echo   -l, --list      List all note files (default command).
echo   -n, --new       Create a new note.
echo   -e, --edit      Edit an existing note file.
echo   -d, --delete    Delete a note file.
echo   -s, --show      Show contents of a note file.
echo   -h, --help      Show this help message.
echo.
echo The default editor is "%EDITOR%".
echo You can change it by modifying the EDITOR variable in the script.
echo.
goto:END


:LIST_NOTES
:: List note files in the directory
call :CountNotes
echo List of files:
echo --------------
setlocal enabledelayedexpansion
for %%A in (*) do (
	if %%~zA GEQ 1048576 (
			set /a size=%%~zA/1048576
			echo %%~tA     !size! MB	%%~nxA
	) else if %%~zA GEQ 1024 (
		set /a size=%%~zA/1024
		echo %%~tA     !size! kB	%%~nxA
	) else (
		echo %%~tA     %%~zA B	%%~nxA
	)
)
endlocal
echo.
echo Total notes: %no_notes%
goto:END


:NEW_NOTE
:: Create a new note
call :PromptFileName "Enter file name for new note: " "%~2"
if "%filename%"=="" goto:END
if exist "%filename%" (
    echo Error: File "%filename%" already exists.
) else (
    "%EDITOR%" "%notes%\%filename%"
)
goto:END


:EDIT_NOTE
:: Edit an existing note
call :PromptFileName "Enter file name to edit: " "%~2"
if "%filename%"=="" goto:END
if not exist "%filename%" (
    echo Error: File "%filename%" not found.
) else (
    "%EDITOR%" "%notes%\%filename%"
)
goto:END


:DELETE_NOTE
:: Delete an existing note
call :PromptFileName "Enter file name to delete: " "%~2"
if "%filename%"=="" goto:END
if not exist "%filename%" (
    echo Error: File "%filename%" not found.
) else (
    del /p "%filename%"
)
goto:END


:SHOW_NOTE
:: Show contents of a note
call :PromptFileName "Enter file name to view: " "%~2"
if "%filename%"=="" goto:END
if not exist "%filename%" (
    echo Error: File "%filename%" not found.
) else (
    type "%filename%"
)
goto:END


:END
popd
exit /b 0


:CountNotes
:: Count the number of notes in the directory
setlocal
set /a cnt=0
for %%A in (*) do set /a cnt+=1
endlocal & set no_notes=%cnt%
goto:eof


:PromptFileName
:: Prompt for file name if not provided
:: %1: Prompt message, %2: Argument
if "%~2"=="" (
    set /p filename=%~1
) else (
    set filename=%~2
)
goto:eof

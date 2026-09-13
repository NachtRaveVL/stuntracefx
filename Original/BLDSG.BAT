set path=%path%;c:\bin
set sasmheap=14400
cd xl
del *.sob
del lastasm.*
make xl.rom
if errorlevel 1 goto failed
cd ..
copy xl\xl.rom xl.sfc
del xl\xl.rom
del xl\*.bak
del xl\*.sob
goto finished
:failed
cd ..
echo Build failed. No ROM was copied.
:finished
pause
exit
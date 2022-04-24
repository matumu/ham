@echo off
cd /d "%~dp0"
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
set datetime=%datetime:~0,4%_%datetime:~4,2%_%datetime:~6,2%
rem git archive -v --format=tar.zst --prefix=ham_%datetime%_HEAD/ -19 --output=../ham_%datetime%_HEAD.tar.zst HEAD
del /q ..\ham_*.pdf ..\ham_*.7z ham_*.7z 2>nul
COPY /Y ham_a.pdf ..\ >nul
COPY /Y ham_b.pdf ..\ >nul
COPY /Y ham_c.pdf ..\ >nul
E:\cmdtool\7z.exe a -t7z ham_a_%datetime%.7z ham_a.pdf LICENSE.md README.md
E:\cmdtool\7z.exe a -t7z ham_b_%datetime%.7z ham_b.pdf LICENSE.md README.md
E:\cmdtool\7z.exe a -t7z ham_c_%datetime%.7z ham_c.pdf LICENSE.md README.md
rem generate sha256sums
E:\cmdtool\generic_sum.exe SHA256 ham_a_*.7z ham_b_*.7z > ..\sha256sum.txt
rem D:\cmdtool\awk.exe "{ print \"- \" $2 \" �� SHA256 ��ϣ:\"; print \"`\" $1 \"`\" }" sha256sum.txt > ..\sha256sums.txt
pause
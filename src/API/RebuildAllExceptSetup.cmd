set ORIGINAL_DIR=%CD% 

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\Tools\vsdevcmd.bat"

chdir /d %ORIGINAL_DIR% 

msbuild Export2SQLCE.sln /t:Rebuild /p:Configuration=Release
copy bin\Release\*.dll ..\..\..\
copy bin\x86\Release\*.dll ..\..\..\
cd lib
.\ilmerge /targetplatform:"v4,C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0" /out:..\..\..\..\Export2SqlCe.exe ..\bin\release\export2sqlce.exe QuickGraph.dll QuickGraph.Data.dll QuickGraph.GraphViz.dll
cd ..
pause

msbuild ExportSQLCE.sln /t:Rebuild /p:Configuration=Release
copy bin\Release\*.dll ..\..\..\
copy bin\x86\Release\*.dll ..\..\..\
cd lib
.\ilmerge /targetplatform:"v4,C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0" /out:..\..\..\..\ExportSqlCe.exe ..\bin\release\exportsqlce.exe QuickGraph.dll QuickGraph.Data.dll QuickGraph.GraphViz.dll
cd ..
pause

rem msbuild ExportSQLCE31.sln /t:Rebuild /p:Configuration=Release
rem copy bin\Release\*.dll ..\..\..\
rem copy bin\x86\Release\*.dll ..\..\..\
rem cd lib
rem .\ilmerge /targetplatform:"v4,C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0" /out:..\..\..\..\ExportSqlCe31.exe ..\bin\x86\release\exportsqlce31.exe QuickGraph.dll QuickGraph.Data.dll rem QuickGraph.GraphViz.dll
rem cd ..
rem pause

msbuild ExportSQLCE40.sln /t:Rebuild /p:Configuration=Release
copy bin\Release\*.dll ..\..\..\
copy bin\x86\Release\*.dll ..\..\..\
cd lib
.\ilmerge /targetplatform:"v4,C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0" /out:..\..\..\..\ExportSqlCe40.exe ..\bin\release\exportsqlce40.exe QuickGraph.dll QuickGraph.Data.dll QuickGraph.GraphViz.dll
cd ..
pause

msbuild SqlCeScripting40.sln /t:Rebuild /p:Configuration=Release
copy bin\Release\*.dll ..\..\..\
copy bin\x86\Release\*.dll ..\..\..\
pause
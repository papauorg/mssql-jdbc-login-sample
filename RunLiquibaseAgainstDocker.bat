@echo off
cls

If "%1"=="" GOTO EXECWITHRUN 

SET ServerName=localhost
SET PortNr=1434
SET DataBase=Testdatabase
SET DataBaseUser=sa
SET DataBasePW=ThisIs1Strong_Password

CLS
echo.
echo Dropping SQL Database
SQLCMD.exe -U %DatabaseUser% -P %DataBasePW% -S %ServerName%,%PortNr% -Q "IF db_id('%DataBase%') IS NOT NULL BEGIN ALTER DATABASE [%DataBase%] SET OFFLINE WITH ROLLBACK IMMEDIATE; ALTER DATABASE [%DataBase%] SET ONLINE; DROP DATABASE [%DataBase%]; END; CREATE DATABASE [%DataBase%];" -b -V 1
echo Restoring Database

echo.
echo Starting Liquibase
echo.
REM Liquibase mit den zuvor eingegebenen Daten aufrufen
"liquibase\liquibase.bat" ^
 --changeLogFile=.\MasterChangeLog.xml ^
 --driver=com.microsoft.sqlserver.jdbc.SQLServerDriver ^
 --url="jdbc:sqlserver://%ServerName%:%PortNr%;DatabaseName=%DataBase%" ^
 --username=%DataBaseUser% ^
 --password=%DataBasePW% ^
 --logLevel=debug ^
 update


:END
	EXIT /B

:EXECWITHRUN
	cmd.exe /K %0 RUN
	GOTO END

@echo on
@echo off
set LIB_PATH=..\lib
set CONFIG_PATH=..\config
set EXE_JAR_PATH=..\build\dist


rem JVM settings for proxy tunneling
set JVM_SETTINGS=
rem set JVM_SETTINGS=%JVM_SETTINGS% -Dhttp.proxyHost=javadb2 -Dhttp.proxyPort=8080

rem JVM Memory settings
set JVM_SETTINGS=%JVM_SETTINGS% -Xms128m -Xmx512m -Xss256k -XX:MaxPermSize=64m

set AGENT_CLASS_PATH=

SETLOCAL ENABLEDELAYEDEXPANSION
for /f %%a IN ('dir /b /S %LIB_PATH%\*.jar') do set AGENT_CLASS_PATH=!AGENT_CLASS_PATH!;%%a

rem set the config dir and the main executable jar in the classpath
set AGENT_CLASS_PATH=%AGENT_CLASS_PATH%;%CONFIG_PATH%;%EXE_JAR_PATH%\sifbootcamp.jar

echo ======================================================================================================
echo Start Agent with JVM Settings:
echo %JVM_SETTINGS%
echo ======================================================================================================
echo Start Agent with Classpath:
echo %AGENT_CLASS_PATH%
echo Name of Agent: %1%
echo ======================================================================================================

%JAVA_HOME%\bin\java %JVM_SETTINGS% -cp %AGENT_CLASS_PATH% systemic.sif.sifcommon.agent.SIFCommonAgent %1%

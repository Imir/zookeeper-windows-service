@echo off

SET HOME=C:\zookeeper-3.4.6
SET SERVICE_DIR=C:\zookeeper-3.4.6\Service
SET SERVICE_LOGPATH=C:\zookeeper-3.4.6\logs

REM Service configuration
SET SERVICE_NAME=ZooKeeperService
SET PR_INSTALL=%SERVICE_DIR%\prunsrv.exe
SET PR_PIDFILE=servicepid

REM Service log configuration
SET PR_LOGPREFIX=%SERVICE_NAME%
SET PR_LOGPATH=%SERVICE_LOGPATH%
SET PR_STDOUTPUT=%SERVICE_LOGPATH%\stdout.txt
SET PR_STDERROR=%SERVICE_LOGPATH%\stderr.txt
SET PR_LOGLEVEL=All

REM Zookeeper - Classpath Configuration
SET ZOOCFGDIR=%HOME%\conf
SET ZOO_LOG_DIR=%HOME%
SET ZOO_LOG4J_PROP=INFO,CONSOLE
SET ZOOCFG=%ZOOCFGDIR%\zoo.cfg
SET ZOOMAIN=org.apache.zookeeper.server.quorum.QuorumPeerMain

SET CLASSPATH=%ZOOCFGDIR%
SET CLASSPATH=%HOME%\zookeeper-3.4.6.jar;%CLASSPATH%
SET CLASSPATH=%HOME%\lib\jline-0.9.94.jar;%CLASSPATH%
SET CLASSPATH=%HOME%\lib\log4j-1.2.16.jar;%CLASSPATH%
SET CLASSPATH=%HOME%\lib\netty-3.7.0.Final.jar;%CLASSPATH%
SET CLASSPATH=%HOME%\lib\slf4j-api-1.6.1.jar;%CLASSPATH%
SET CLASSPATH=%HOME%\lib\slf4j-log4j12-1.6.1.jar;%CLASSPATH%
SET PR_CLASSPATH=%CLASSPATH%

SET PR_JVMOPTIONS="-Dzookeeper.log.dir=%ZOO_LOG_DIR%";"-Dzookeeper.root.logger=%ZOO_LOG4J_PROP%"

REM Startup configuration
SET PR_STARTUP=manual
SET PR_STARTMODE=java
SET PR_STARTCLASS=%ZOOMAIN%
SET PR_STARTPARAMS=%ZOOCFG%
 
REM JVM configuration
SET PR_JVM=auto
SET PR_JVMMS=256
SET PR_JVMMX=1024

REM Service Shutdown configuration
SET PR_STOPMODE=exe
SET PR_STOPIMAGE=%SERVICE_DIR%\ServiceKiller.exe
SET PR_STOPPARAMS=%SERVICE_LOGPATH%\servicepid
 
REM Install service
prunsrv.exe //IS//%SERVICE_NAME%
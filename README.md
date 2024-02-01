# Docker_DotNET

# Dockerfiles

1) Windowsservercore-20H2

# escape=`
 
FROM mcr.microsoft.com/windows/servercore:20H2
RUN powershell -Command `
    Add-WindowsFeature Web-Server; `
    Invoke-WebRequest -UseBasicParsing -Uri "https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.10/ServiceMonitor.exe" -OutFile "C:\ServiceMonitor.exe"
 
ADD index.html /inetpub/wwwroot
 
EXPOSE 80
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]
MAINTAINER MehulSolanki
LABEL NAME=DotNET


2) Windowsservercore-ltsc2022


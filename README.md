# Docker_DotNET

# Dockerfiles

# 1) Windowsservercore-20H2

FROM mcr.microsoft.com/windows/servercore:20H2

RUN powershell -Command \
    Add-WindowsFeature Web-Server; \
    Invoke-WebRequest -UseBasicParsing -Uri "https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.10/ServiceMonitor.exe" -OutFile "C:\ServiceMonitor.exe"
 
ADD s/CICD/obj/Release/Package/PackageTmp/ /inetpub/wwwroot
 
EXPOSE 80

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]

MAINTAINER MehulSolanki

LABEL NAME=DotNET(DesktopOS)


# 2) Windowsservercore-ltsc2022

FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

WORKDIR /inetpub/wwwroot

ADD s/CICD/obj/Release/Package/PackageTmp/ /inetpub/wwwroot

RUN powershell -NoProfile -Command \
    Install-WindowsFeature NET-Framework-45-ASPNET; \
    Install-WindowsFeature Web-Asp-Net45; \
    Import-Module IISAdministration;	

EXPOSE 80

MAINTAINER MehulSolanki

LABEL NAME=DotNET(ServerOS)


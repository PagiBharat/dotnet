FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

WORKDIR /inetpub/wwwroot

ADD s/CICD/obj/Release/Package/PackageTmp/ /inetpub/wwwroot

RUN powershell -NoProfile -Command \
    Install-WindowsFeature NET-Framework-45-ASPNET; \
    Install-WindowsFeature Web-Asp-Net45; \
    Import-Module IISAdministration;	

EXPOSE 80

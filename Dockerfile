ARG BUILD_IMAGE=mcr.microsoft.com/windows/servercore:1809

FROM $BUILD_IMAGE as build
ARG STUNNEL_VERSION
ARG STUNNEL_SHA256

USER ContainerAdministrator

RUN mkdir "C:\Users\ContainerAdministrator\stunnel"

WORKDIR C:\\Users\\ContainerAdministrator\\stunnel

RUN curl -fSLo stunnel_installer_%STUNNEL_VERSION%.exe https://www.stunnel.org/downloads/stunnel-%STUNNEL_VERSION%-win64-installer.exe \
 && powershell -Command "if ((Get-FileHash -Path stunnel_installer_%STUNNEL_VERSION%.exe -Algorithm SHA256).Hash -ne \"%STUNNEL_SHA256%\") { Write-Output \"SHA256 does not match!\"; exit 1 }" \
 && stunnel_installer_%STUNNEL_VERSION%.exe /S \
 && del stunnel_installer_%STUNNEL_VERSION%.exe

COPY stunnel.conf WriteConfig.ps1 HealthCheck.bat ./

HEALTHCHECK --start-period=60s CMD .\HealthCheck.bat >NUL

CMD powershell -File .\WriteConfig.ps1

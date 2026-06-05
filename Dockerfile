FROM mcr.microsoft.comdotnetsdk9.0 AS build
WORKDIR app
COPY . .
RUN dotnet publish srcITServiceHelpDesk.WebITServiceHelpDesk.Web.csproj 
    -c Release -o out

FROM mcr.microsoft.comdotnetaspnet9.0
WORKDIR app
COPY --from=build out .
ENV ASPNETCORE_URLS=http+${PORT-8080}
EXPOSE 8080
ENTRYPOINT [dotnet, ITServiceHelpDesk.Web.dll]
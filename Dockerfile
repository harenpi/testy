FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app
COPY . .
RUN dotnet restore src/ITServiceHelpDesk.Web/ITServiceHelpDesk.Web.csproj
RUN dotnet publish src/ITServiceHelpDesk.Web/ITServiceHelpDesk.Web.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/out .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "ITServiceHelpDesk.Web.dll"]
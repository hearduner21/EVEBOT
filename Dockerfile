FROM microsoft/dotnet:3.1-sdk AS build-env
WORKDIR /app/ThunderED

COPY ThunderED/*.csproj ./
RUN dotnet restore

COPY ThunderED/. ./
COPY Version.cs /app
COPY version.txt /app
COPY LICENSE /app
RUN dotnet publish -c Release -r debian-x64 -o out

FROM microsoft/dotnet:3.1-aspnetcore-runtime
WORKDIR /app/ThunderED
COPY --from=build-env /app/ThunderED/out .
ENTRYPOINT ["dotnet", "ThunderED.dll"]

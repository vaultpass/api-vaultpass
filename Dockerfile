FROM microsoft/dotnet:5.0-sdk as build
WORKDIR /app

COPY api-vaultpass/VaultPass.Api/*.csproj ./VaultPass.Api/
RUN dotnet restore

COPY api-vaultpass/VaultPass.Api/. ../VaultPass.Api/
WORKDIR /app/VaultPass.Api
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:5.0-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/VaultPass.Api/out ./
ENTRYPOINT ["dotnet", "VaultPass.Api.dll"]
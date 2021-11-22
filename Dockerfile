FROM mcr.microsoft.com/dotnet/aspnet AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk AS build
WORKDIR /src
COPY ["*.csproj", "./"]
RUN dotnet restore
COPY . ./
WORKDIR /src
RUN dotnet build  -c Release -o /app

FROM build AS publish
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "SHKube.dll"]
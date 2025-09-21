# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy project files
COPY ["Demo.sln", "./"]
COPY ["Demo.AppHost/Demo.AppHost.csproj", "Demo.AppHost/"]
COPY ["Demo.ApiService/Demo.ApiService.csproj", "Demo.ApiService/"]
COPY ["Demo.Web/Demo.Web.csproj", "Demo.Web/"]
COPY ["Demo.ServiceDefaults/Demo.ServiceDefaults.csproj", "Demo.ServiceDefaults/"]

# Restore dependencies
RUN dotnet restore "Demo.AppHost/Demo.AppHost.csproj"

# Copy source code
COPY . .

# Build the entire Aspire application
WORKDIR "/src"
RUN dotnet build "Demo.AppHost/Demo.AppHost.csproj" -c Release -o /app/build --no-restore

# Publish stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy the built Aspire application
COPY --from=build /app/build .

# Expose ports for all services
# 8080 - Aspire Dashboard (mapped to 15000 externally)
# 8081 - API Service (mapped to 15001 externally)
# 8082 - Web Frontend (mapped to 15002 externally)
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Set environment variables
ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS=http://+:8080
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
ENV DOTNET_EnableDiagnostics=0
ENV DOTNET_UsePollingFileWatcher=true

# Health check for Aspire dashboard
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Start the Aspire application (this will start all services)
ENTRYPOINT ["dotnet", "Demo.AppHost.dll"]

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

# Build the application
WORKDIR "/src/Demo.AppHost"
RUN dotnet build "Demo.AppHost.csproj" -c Release -o /app/build

# Publish stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy the published app
COPY --from=build /app/build .

# Expose ports
EXPOSE 8080
EXPOSE 8081

# Set environment variables
ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS=http://+:8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Start the application
ENTRYPOINT ["dotnet", "Demo.AppHost.dll"]

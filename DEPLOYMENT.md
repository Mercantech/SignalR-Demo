# SignalR Demo - Dokploy Deployment Guide

## 🚀 Deployment til Dokploy

### Forudsætninger
- Dokploy server kørende
- Docker installeret på Dokploy serveren
- Git repository med koden

### 1. Forberedelse

#### Opret Git Repository
```bash
git init
git add .
git commit -m "Initial SignalR Demo commit"
git remote add origin <YOUR_GIT_REPO_URL>
git push -u origin main
```

### 2. Konfigurer Dokploy

#### Opret ny Application i Dokploy:
1. **Name**: `signalr-demo`
2. **Repository**: Din Git repository URL
3. **Branch**: `main`
4. **Build Pack**: `Docker`
5. **Dockerfile Path**: `./Dockerfile`
6. **Docker Compose**: `./docker-compose.yml`

#### Environment Variables:
```
ASPNETCORE_ENVIRONMENT=Production
ASPNETCORE_URLS=http://+:8080
```

### 3. Port Konfiguration

#### I Dokploy Dashboard:
- **Port 8080**: Main application (Aspire Dashboard)
- **Port 8081**: SignalR Hubs

#### Firewall/Proxy Settings:
- Åbn port 8080 for hovedapplikationen
- Åbn port 8081 for SignalR forbindelser

### 4. Deployment

#### Automatisk Deployment:
- Push til main branch triggerer automatisk deployment
- Dokploy bygger og deployer automatisk

#### Manuel Deployment:
1. Gå til Dokploy Dashboard
2. Vælg din application
3. Klik "Deploy"
4. Vent på build completion

### 5. Verificering

#### Efter deployment:
1. **Aspire Dashboard**: `http://your-server:8080`
2. **SignalR Info**: `http://your-server:8080/signalr-info`
3. **Chat Demo**: `http://your-server:8080/chat`
4. **Status Monitor**: `http://your-server:8080/status`

### 6. Monitoring

#### Health Checks:
- Applikationen har automatiske health checks
- Dokploy viser status i dashboard

#### Logs:
- Se logs i Dokploy dashboard
- Real-time log streaming tilgængelig

### 7. Troubleshooting

#### Almindelige problemer:

**Port ikke tilgængelig:**
- Tjek firewall settings
- Verificer port mapping i Dokploy

**SignalR forbindelse fejler:**
- Tjek at port 8081 er åben
- Verificer CORS settings

**Build fejler:**
- Tjek Dockerfile syntax
- Verificer .NET version compatibility

### 8. Performance Tips

#### For production:
- Overvej at bruge en reverse proxy (nginx)
- Konfigurer SSL/TLS
- Sæt op monitoring og alerting
- Overvej load balancing for høj trafik

### 9. Backup & Recovery

#### Database:
- Ingen database i denne demo
- Alle data er in-memory

#### Configuration:
- Backup docker-compose.yml
- Backup appsettings.Production.json

### 10. Scaling

#### Horizontal Scaling:
- Deploy flere instanser
- Brug load balancer
- Overvej Redis for SignalR backplane

#### Vertical Scaling:
- Øg container resources i Dokploy
- Monitor performance metrics

---

## 📞 Support

Hvis du støder på problemer:
1. Tjek Dokploy logs
2. Verificer port accessibility
3. Test lokalt først
4. Kontakt support hvis nødvendigt

## 🔗 Links

- [Dokploy Documentation](https://dokploy.com/docs)
- [Aspire Documentation](https://learn.microsoft.com/en-us/dotnet/aspire/)
- [SignalR Documentation](https://learn.microsoft.com/en-us/aspnet/core/signalr/)

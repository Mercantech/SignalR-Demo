# SignalR Demo

Dette er en simpel SignalR demo applikation, der viser hvordan man implementerer real-time kommunikation med ASP.NET Core SignalR og Blazor.

## Hvad er SignalR?

SignalR er en Microsoft teknologi, der gør det nemt at tilføje real-time funktionalitet til web applikationer. Den håndterer automatisk forbindelsesstyring og giver dig mulighed for at sende beskeder til alle forbundne klienter eller til specifikke grupper af klienter i realtid.

## Hub Pattern

Hub pattern er den primære måde at organisere SignalR funktionalitet på. En Hub er en klasse, der arver fra `Hub` klassen og fungerer som en centraliseret endpoint for real-time kommunikation.

## Funktioner

- **Real-time chat**: Send beskeder til alle forbundne brugere
- **Gruppe chat**: Opret grupper og send beskeder til specifikke grupper
- **Forbindelseshåndtering**: Automatisk håndtering af forbindelser og genforbindelser
- **Bruger notifikationer**: Se når brugere tilslutter sig eller forlader chatten

## Projekt Struktur

```
SignalR-Demo/
├── Demo.ApiService/          # SignalR Hub og API
│   ├── Hubs/
│   │   └── ChatHub.cs       # SignalR Hub implementering
│   └── Program.cs           # SignalR konfiguration
├── Demo.Web/                # Blazor frontend
│   ├── Components/Pages/
│   │   ├── Chat.razor       # Chat interface
│   │   └── SignalRInfo.razor # SignalR information
│   └── wwwroot/
│       ├── js/chat.js       # JavaScript hjælpefunktioner
│       └── css/chat.css     # Chat styling
└── Demo.AppHost/            # Aspire host
```

## Sådan kører du applikationen

1. **Kør applikationen**:
   ```bash
   dotnet run --project Demo.AppHost
   ```

2. **Åbn browseren** og gå til:
   - `https://localhost:7000` - Blazor applikation
   - `https://localhost:7001` - API service

3. **Naviger til SignalR siderne**:
   - **SignalR Info**: `/signalr-info` - Lær om SignalR og Hub pattern
   - **Chat Demo**: `/chat` - Prøv real-time chat funktionaliteten

## Sådan bruger du chatten

1. **Forbind til chatten**:
   - Indtast dit navn
   - Klik på "Forbind til Chat"

2. **Send beskeder**:
   - Skriv en besked i tekstfeltet
   - Tryk Enter eller klik "Send"

3. **Opret grupper** (valgfrit):
   - Indtast et gruppe navn
   - Klik på "Tilslut gruppe"
   - Beskeder sendes kun til gruppemedlemmer

## Teknisk Implementation

### Server-side (API Service)

- **ChatHub.cs**: Hub klasse med chat funktionalitet
- **SignalR service registrering**: I `Program.cs`
- **CORS konfiguration**: For cross-origin requests
- **Hub mapping**: Til `/chathub` endpoint

### Client-side (Blazor)

- **SignalR Client forbindelse**: Real-time kommunikation
- **Event handling**: For forbindelser og beskeder
- **UI opdateringer**: Real-time opdatering af chat interface
- **Gruppe management**: Tilslut/forlad grupper

## SignalR Metoder

### Hub Metoder (Server)
- `SendMessage(user, message)`: Send besked til alle
- `SendMessageToGroup(groupName, user, message)`: Send besked til gruppe
- `JoinGroup(groupName)`: Tilslut gruppe
- `LeaveGroup(groupName)`: Forlad gruppe

### Client Events
- `ReceiveMessage`: Modtag besked
- `UserJoined`: Bruger tilsluttet
- `UserLeft`: Bruger forladt
- `UserJoinedGroup`: Bruger tilsluttet gruppe
- `UserLeftGroup`: Bruger forladt gruppe

## Pakker

- **Demo.ApiService**: `Microsoft.AspNetCore.SignalR`
- **Demo.Web**: `Microsoft.AspNetCore.SignalR.Client`

## Lær mere

- [SignalR Dokumentation](https://docs.microsoft.com/en-us/aspnet/core/signalr/)
- [Blazor SignalR Guide](https://docs.microsoft.com/en-us/aspnet/core/blazor/tutorials/signalr-blazor)
- [Hub Pattern](https://docs.microsoft.com/en-us/aspnet/core/signalr/hubs)
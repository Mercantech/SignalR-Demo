namespace Demo.Web;

public class WeatherApiClient
{
    private readonly HttpClient _httpClient;

    public WeatherApiClient(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }
    public async Task<WeatherForecast[]> GetWeatherAsync(int maxItems = 10, CancellationToken cancellationToken = default)
    {
        List<WeatherForecast>? forecasts = null;

        await foreach (var forecast in _httpClient.GetFromJsonAsAsyncEnumerable<WeatherForecast>("/weatherforecast", cancellationToken))
        {
            if (forecasts?.Count >= maxItems)
            {
                break;
            }
            if (forecast is not null)
            {
                forecasts ??= new List<WeatherForecast>();
                forecasts.Add(forecast);
            }
        }

        return forecasts?.ToArray() ?? new WeatherForecast[0];
    }
}

public record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}

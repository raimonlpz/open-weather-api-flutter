import 'package:http/http.dart' show Client;
import '../model/WeatherData.dart';

class MapApi {
  static const _apiKey = 'f6a037e18fe527f213ca5e678e375704';
  static const _endpoint = 'http://api.openweathermap.org/data/2.5';
  double lat, lon;

  Client client = Client();

  static MapApi _instance;
  static MapApi getInstance() => _instance ??= MapApi();

  String _apiCall({double lat, double lon}) {
    return '$_endpoint/weather?lat=${lat.toString()}&lon=${lon.toString()}&APPID=$_apiKey&units=metric';
  }

  getWeather({double lat, double lon}) async {
    var response = await client.get(
      Uri.encodeFull(
        _apiCall(lat: lat, lon: lon),
      ),
      headers: {
        'Accept': 'application/json',
      },
    );
    return WeatherData.deserialize(response.body);
  }
}

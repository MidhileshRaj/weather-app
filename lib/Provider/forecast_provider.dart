import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:whether_app/data/models/forecastModel.dart';

class ForecastProvider extends ChangeNotifier {

  String baseUrl = 'api.weatherapi.com';
  final String token = 'aa5da7ccfa1b4ab4be044825231912';
  Forecast? forecastWeather;

  fetchData() async {
    var queryParameters = {
      'key': token,
      'q': 'kochi',
    };
    var urlForecast = Uri.https(baseUrl, '/v1/forecast.json', queryParameters);
    print(urlForecast);
    try {
      final response = await http.get(urlForecast);

      if (response.statusCode == 200) {
        print("=====${response.body}");
        forecastWeather = forecastFromJson(response.body);
        notifyListeners();

      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during data fetching: $error');

    }
  }
}
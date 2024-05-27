import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../data/models/wheather.dart';

class WeatherProvider extends ChangeNotifier{

  String baseUrl = 'api.weatherapi.com';
  final String token = 'aa5da7ccfa1b4ab4be044825231912';
  Weather? currentWeather;

  fetchData() async {
    var queryParameters = {
      'key': token,
      'q': 'kochi',
    };
    var urlCurrent = Uri.https(baseUrl, '/v1/current.json', queryParameters);

    try{
      final response = await http.get(urlCurrent);

      if (response.statusCode == 200) {
        currentWeather = weatherFromJson(response.body);
        notifyListeners();
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during data fetching: $error');
    }
  }
}
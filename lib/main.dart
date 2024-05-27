import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/forecast_provider.dart';
import 'Provider/weather_provider.dart';
import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return WeatherProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return ForecastProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}

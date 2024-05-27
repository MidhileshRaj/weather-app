import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:whether_app/Provider/forecast_provider.dart';
import 'package:whether_app/Provider/weather_provider.dart';
import 'package:whether_app/constants/colors.dart';
import 'package:whether_app/screens/widgets/circle_icon_container.dart';
import 'package:whether_app/screens/widgets/temperaturewidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _color;
  late final Animation<Color?> _colorAnimation;
  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(vsync: this);
    _color = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    Provider.of<WeatherProvider>(context, listen: false).fetchData();
    Provider.of<ForecastProvider>(context, listen: false).fetchData();
    _colorAnimation = ColorTween(
      begin: kWhite, // Change this to your initial color
      end: kblack, // Change this to your target color
    ).animate(_color);
    super.initState();
  }

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final providerWeather = Provider.of<WeatherProvider>(context);
    final providerForecast = Provider.of<ForecastProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: providerWeather.currentWeather == null
            ? const Center(child: CircularProgressIndicator())
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  key: ValueKey<bool>(isPressed),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: isPressed
                              ? const AssetImage(
                                  'assets/images/Japan---mt.-fuji.png')
                              : const AssetImage(
                                  'assets/images/Japan---mt.-fuji-night-.png'))),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40, left: 10),
                        child: Row(
                          children: [
                            const IconButtonWidget(
                                icon: CupertinoIcons.location_fill),
                            const SizedBox(
                              width: 10,
                            ),
                            const IconButtonWidget(icon: CupertinoIcons.plus),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isPressed = !isPressed;
                                });
                                if (isPressed) {
                                  _color.forward();
                                  _controller.animateTo(0.125);
                                } else {
                                  _color.reverse();
                                  _controller.animateBack(0);
                                }
                              },
                              child: Container(
                                child: Lottie.asset(
                                    height: 60,
                                    'assets/json/switch.json',
                                    repeat: false,
                                    reverse: false,
                                    controller: _controller,
                                    onLoaded: (composition) {
                                  _controller.duration = composition.duration;
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                providerWeather.currentWeather!.location.name
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'BlackOpsOne',
                                    color: isPressed ? kblack : kWhite)),
                            Text(
                                providerWeather
                                    .currentWeather!.current.condition.text
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 27,
                                    fontFamily: 'RussoOne',
                                    color: isPressed ? kblack : kWhite)),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: height / 1.9,
                        child: AnimatedBuilder(
                          animation: _color,
                          builder: (BuildContext context, Widget? child) {
                            return Text(
                                '${providerWeather.currentWeather?.current.tempC.round().toString()}°',
                                style: TextStyle(
                                  fontSize: 150,
                                  fontFamily: 'BlackOpsOne',
                                  color: _colorAnimation.value,
                                ));
                          },
                        ),
                      ),
                      Positioned(
                        left: 10,
                        right: 10,
                        bottom: height / 16,
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: kblack,
                                borderRadius: BorderRadius.circular(25)),
                            height: height / 5.5,
                            width: width,
                            child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if (providerForecast.forecastWeather !=
                                      null) {
                                    var forecastDay = providerForecast
                                        .forecastWeather!
                                        .forecast
                                        .forecastday[0];
                                    var hour = forecastDay.hour[index];
                                    return TempWidget(
                                        temperature:
                                            hour.tempC.round().toString(),
                                        time: hour.time.split(' ')[1] == '00:00'
                                            ? 'Now'
                                            : hour.time
                                                .split(' ')[1]
                                                .toString(),
                                        url: hour.condition.text.name == 'SUNNY'
                                            ? 'assets/json/Sunny_day.json'
                                            : 'assets/json/cloud.json');
                                  } else {
                                    return Container();
                                  }
                                })
                            // Use the forecast data to populate TempWidget widgets

                            ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}

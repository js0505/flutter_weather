import 'package:flutter/material.dart';
import 'package:weather/data/my_location.dart';
import 'package:weather/data/network.dart';
import 'package:weather/screens/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//dd
const apiKey = '356413715b025e450248ad5cede4f17e';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? latitude3;
  double? longitude3;

  void getLocation() async {
    //현재 GPS상의 위도, 경도 데이터 가져오기.
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();

    //가져온 데이터를 변수에 저장
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    //위도, 경도 값으로 API 호출
    Network network = Network(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
      'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey',
    );
    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();

    //데이터를 다 가지고 오면 페이지 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(
            parseWeatherData: weatherData,
            parseAirPolutionData: airData,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}

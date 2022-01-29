import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? latitude2;
  double? longitude2;

  // 휴대폰의 GPS 기능을 이용해서 위도, 경도 값 받아서 변수에 저장
  Future<void> getMyCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude2 = position.latitude;
      longitude2 = position.longitude;
    } catch (e) {
      print('Have some problem');
    }
  }
}

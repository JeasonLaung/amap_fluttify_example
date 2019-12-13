


import 'dart:async';

import 'package:amap_all_fluttify/amap_all_fluttify.dart';

class GlobalLocation {
  static Stream stream;
  static StreamController _streamController;
  static List<LatLng> latLngList = [];
  static List<LocationWithTime> locationWithTimeList = [];
  /// 当前位置
  static Location location;

  static dispose() {
    _streamController.close();
  }

  static Future init() async{
    _streamController = StreamController();
    stream = _streamController.stream.asBroadcastStream();

    AmapLocation.listenLocation(
      mode: LocationAccuracy.High,
      needAddress: true
    ).listen((loc) async{
      LatLng latLng = await loc.latLng;
      double altitude = await loc.altitude;
      LocationWithTime locationWithTime = LocationWithTime(
        latLng: latLng, 
        time: (DateTime.now().millisecondsSinceEpoch / 1000).round(),
        altitude: altitude
      );
      locationWithTimeList.add(locationWithTime);
      latLngList.add(latLng);

      /// 传下方
      _streamController?.sink?.add(loc);
    });
    
  }
}

/// 带时间的坐标
class LocationWithTime {
  final LatLng latLng;
  final double altitude;
  final int time;
  LocationWithTime({this.latLng, this.time ,this.altitude});
}
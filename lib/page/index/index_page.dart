import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:location_to_drive/common/global.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  AmapController amapController;
  Polyline polyline;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('方法实践'),),
      body: AmapView(
        onMapCreated: (_controller) async{
          amapController = _controller;
          _controller.showMyLocation(
            true,
          );
          amapController.showMyLocation(true);
          GlobalLocation.stream.listen((loc) async{
            await polyline?.remove();
            polyline = await _controller.addPolyline(PolylineOption(
              latLngList: GlobalLocation.latLngList,
              width: 40,
              // customTexture: Uri(path: 'assets/images/polyline.jpg')
            ));
          });


        },
      ),
    );
  }
}
import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:permission_handler/permission_handler.dart';
import './page/index/index_page.dart';
import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import 'common/global.dart';
main() async{
  await Fluwe.init(
    /// 可不配置
    routesConfig: []
  );
  await AmapCore.init('a025de332f474095ef739f19060ba549');
  await GlobalLocation.init();
  await PermissionHandler().requestPermissions([
    PermissionGroup.location,
    PermissionGroup.locationAlways,
    PermissionGroup.locationWhenInUse
    ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Router.navigatorKey,
      onGenerateRoute: Router.onGenerateRoute,
      home: FluweApp(
        child: IndexPage(),
      )
    );
  }
}
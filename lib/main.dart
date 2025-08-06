import 'package:anchorageislamabad/firebase_options.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/utils/initial_bindings.dart';
import 'core/utils/logger.dart';
import 'core/utils/size_utils.dart';
import 'localization/app_localization.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Permission.location.request();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ScreenUtilInit(
        minTextAdapt: true,
        child: GetMaterialApp(
          defaultTransition: Transition.fadeIn,

          debugShowCheckedModeBanner: false,
          translations: AppLocalization(),
          locale: Get.deviceLocale, //for setting localization strings
          fallbackLocale: Locale('en', 'US'),
          title: 'Anchorage Islamabad',
          initialBinding: InitialBindings(),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.pages,
        ),
      );
    });
  } 
}

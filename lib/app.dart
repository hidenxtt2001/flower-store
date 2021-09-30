import 'package:flower_store/src/utils/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/utils/routes/app_routes.dart';
import 'src/utils/themes/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    printLog("[AppState] build");
    return ScreenUtilInit(
      designSize: Size(411, 823),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flower Store',
        theme: appTheme(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}

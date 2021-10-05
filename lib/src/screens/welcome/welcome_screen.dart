import 'package:flower_store/src/prefs/PrefKeys.dart';
import 'package:flower_store/src/screens/base/screen_config.dart';
import 'package:flower_store/src/utils/helper/app_preferences.dart';
import 'package:flower_store/src/utils/themes/app_colors.dart';
import 'package:flower_store/src/utils/themes/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String nameRoute = '/welcome';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => WelcomeScreen(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenConfig(
      builder: () => Scaffold(
        body: _BodyScreen(),
      ),
    );
  }
}

class _BodyScreen extends StatelessWidget {
  const _BodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 71.h,
          ),
          SvgPicture.asset(
            'assets/ico_welcome.svg',
            width: 1.sw,
            height: 461.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 25.w,
              right: 25.w,
              top: 17.h,
              bottom: 20.h,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 281.w,
                ),
                child: Text(
                  'Delivering greenery at your door step',
                  style: AppTextStyle.header2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  primary: AppColors.color2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                onPressed: () => _gotoLoginScreen(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 42.w,
                    vertical: 22.w,
                  ),
                  child: Text(
                    'Get Started',
                    style: AppTextStyle.header5.copyWith(
                      color: AppColors.color9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _gotoLoginScreen(BuildContext context) {
  AppPreferences.prefs.setBool(PrefKeys.SHOW_WELCOME_SCREEN, true);
  Navigator.of(context)
      .pushNamedAndRemoveUntil(LoginScreen.nameRoute, (route) => false);
}

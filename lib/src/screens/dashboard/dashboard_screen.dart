import 'package:flower_store/src/blocs/bloc.dart';
import 'package:flower_store/src/screens/screen.dart';
import 'package:flower_store/src/utils/themes/app_colors.dart';
import 'package:flower_store/src/utils/themes/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_slider_bar.dart';
import 'bill/bill_page.dart';
import 'home/home_page.dart';
import 'package/package_page.dart';
import 'statistical/statistical_page.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(),
        ),
      ],
      child: ScreenConfig(
        builder: () => BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) => Scaffold(
            key: scaffoldKey,
            drawer:
                AppSliderBar(staff: BlocProvider.of<AuthBloc>(context).staff!),
            appBar: _buildAppbar(scaffoldKey, context),
            body: _BodyScreen(
              state: state,
            ),
            bottomNavigationBar: _buildBottomNavigation(context),
          ),
        ),
      ),
    );
  }
}

_buildAppbar(GlobalKey<ScaffoldState> key, BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.color10,
    elevation: 0.5,
    title: Text(
      BlocProvider.of<DashboardBloc>(context)
          .curentPage
          .toString()
          .split('.')
          .last,
      style: AppTextStyle.header4.copyWith(
        color: AppColors.color6,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      onPressed: () => key.currentState?.openDrawer(),
      icon: SvgPicture.asset('assets/ico_menu.svg'),
    ),
    actions: [],
  );
}

_buildBottomNavigation(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: BlocProvider.of<DashboardBloc>(context).curentPage.index,
    onTap: (value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(NavigatorPageTappedEvent(curentPage: PageName.values[value]));
    },
    type: BottomNavigationBarType.fixed,
    iconSize: 32.w,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: AppColors.color2,
    backgroundColor: AppColors.color10,
    items: [
      _buildBottomNavigationItem(
        SvgPicture.asset(
          'assets/ico_home.svg',
          color: BlocProvider.of<DashboardBloc>(context).curentPage ==
                  PageName.Home
              ? AppColors.color2
              : AppColors.color6,
        ),
        PageName.Home.toString().split('.').last,
      ),
      _buildBottomNavigationItem(
        SvgPicture.asset(
          'assets/ico_package.svg',
          color: BlocProvider.of<DashboardBloc>(context).curentPage ==
                  PageName.Package
              ? AppColors.color2
              : AppColors.color6,
        ),
        PageName.Package.toString().split('.').last,
      ),
      _buildBottomNavigationItem(
        SvgPicture.asset(
          'assets/ico_bill.svg',
          color: BlocProvider.of<DashboardBloc>(context).curentPage ==
                  PageName.Bill
              ? AppColors.color2
              : AppColors.color6,
        ),
        PageName.Bill.toString().split('.').last,
      ),
      _buildBottomNavigationItem(
        SvgPicture.asset(
          'assets/ico_statistical.svg',
          color: BlocProvider.of<DashboardBloc>(context).curentPage ==
                  PageName.Statistical
              ? AppColors.color2
              : AppColors.color6,
        ),
        PageName.Statistical.toString().split('.').last,
      ),
    ],
  );
}

_buildBottomNavigationItem(Widget icon, String title) {
  return BottomNavigationBarItem(icon: icon, label: title);
}

class _BodyScreen extends StatelessWidget {
  final DashboardState state;
  const _BodyScreen({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch ((state as NavigatorTappedPageState).pageName) {
      case PageName.Home:
        return HomePage();
      case PageName.Package:
        return PackagePage();
      case PageName.Bill:
        return BillPage();
      case PageName.Statistical:
        return StatisticalPage();
      default:
        return Container();
    }
  }
}

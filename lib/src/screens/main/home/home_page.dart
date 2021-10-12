import 'package:flower_store/app.dart';
import 'package:flower_store/src/screens/main/home/add_product_page.dart';
import 'package:flower_store/src/screens/main/home/widget/product_widget.dart';
import 'package:flower_store/src/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color4,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 20.h),
          itemBuilder: (context, index) {
            return ProductWidget();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: SvgPicture.asset('assets/ico_plus.svg'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductPage()),
            );
          },
        ),
        backgroundColor: AppColors.color2,
      ),
    );
  }
}

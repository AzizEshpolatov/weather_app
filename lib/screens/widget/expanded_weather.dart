import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/utils/size/app_size.dart';
import '../../utils/appstyle/app_text_style.dart';

class GetWeather extends StatelessWidget {
  const GetWeather({super.key, required this.title, required this.time, required this.iconloc});
  final String title;
  final String iconloc;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.w,horizontal: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
           color: const Color(0xFF2566A3)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconloc,height: 50.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.w,
                    color: Colors.white,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

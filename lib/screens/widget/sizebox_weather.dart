import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SizeboxWeather extends StatelessWidget {
  const SizeboxWeather({super.key, required this.imgloc, required this.title});
  final String imgloc;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SvgPicture.asset(
            imgloc,
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(width: 5.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.w,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

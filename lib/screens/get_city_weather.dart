import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/screens/widget/expanded_weather.dart';
import 'package:weather_app/screens/widget/sizebox_weather.dart';
import 'package:weather_app/utils/extensions/my_extensions.dart';
import 'package:weather_app/utils/size/app_size.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../data/models/detail/one_call_data.dart';
import '../data/models/my_response.dart';
import '../data/network/api_provider.dart';
import '../utils/appcolors/app_colors.dart';

class GetCityWeather extends StatelessWidget {
  const GetCityWeather({super.key, required this.getCity});

  final String getCity;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xFF2566A3),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF2566A3),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: ApiProvider.getComplexWeatherInfoUz(getCity),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    OneCallData onCallData =
                        (snapshot.data as MyResponse).data as OneCallData;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.getW()),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        onCallData.hourly[0].weather[0].icon
                                            .getWeatherIconUrl(),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 30.getH(),
                                    child: ZoomTapAnimation(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 50.getW(),
                                        height: 50.getH(),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: Colors.blueGrey,
                                        ),
                                        child: const Icon(
                                            Icons
                                                .keyboard_double_arrow_left_sharp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        onCallData.timezone,
                                        style: TextStyle(
                                          fontSize: 22.getW(),
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10.getH()),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getIntType(
                                                    onCallData.hourly[0].temp)
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 66.getW(),
                                              height: 1,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Container(
                                            height: 25.getH(),
                                            width: 25.getW(),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 5.getW(),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "C",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 66.getW(),
                                              height: 1,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        onCallData.hourly[10].weather[0].main,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.getW(),
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5.getH()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Max : ${getIntType(onCallData.daily[0].dailyTemp.max)} C",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.getW(),
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 10.getW()),
                                          Text(
                                            "Min : ${getIntType(onCallData.daily[0].dailyTemp.min)} C",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.getW(),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 30.getH()),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    width: 2.getW(),
                                    color: Colors.blueAccent,
                                  ),
                                  color: const Color(0xFF2566A3),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.getH(), horizontal: 15.getW()),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizeboxWeather(
                                      imgloc: "assets/icons/rain.svg",
                                      title:
                                          "${onCallData.daily[0].pop * 100.toInt()} %",
                                    ),
                                    Container(
                                      height: 20.getH(),
                                      width: 1.getW(),
                                      color: Colors.white,
                                    ),
                                    SizeboxWeather(
                                      imgloc: "assets/icons/temp.svg",
                                      title: "${onCallData.daily[0].pressure}",
                                    ),
                                    Container(
                                      height: 20.getH(),
                                      width: 1.getW(),
                                      color: Colors.white,
                                    ),
                                    SizeboxWeather(
                                      imgloc: "assets/icons/wind.svg",
                                      title:
                                          "${onCallData.hourly[0].windSpeed} m/s",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.getH()),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.blueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.getW(), vertical: 12.getH()),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Today/24 hour",
                                          style: TextStyle(
                                            fontSize: 20.getW(),
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          onCallData.daily[0].dt
                                              .getParsedHourNow(),
                                          style: TextStyle(
                                            fontSize: 20.getW(),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.getH()),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...List.generate(
                                            onCallData.hourly.length,
                                            (index) => ZoomTapAnimation(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 6.getW()),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2566A3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.getW(),
                                                    vertical: 13.getH()),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${getIntType(onCallData.hourly[index].temp)}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.getW(),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: 2.getW()),
                                                        Container(
                                                          height: 9.getH(),
                                                          width: 9.getW(),
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2.getW(),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: 5.getW()),
                                                        Text(
                                                          "C",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.getW(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Image.network(
                                                      onCallData.hourly[index]
                                                          .weather[0].icon
                                                          .getWeatherIconUrl1(),
                                                      fit: BoxFit.none,
                                                      width: 70.getW(),
                                                    ),
                                                    SizedBox(height: 10.getH()),
                                                    Text(
                                                      onCallData
                                                          .hourly[index].dt
                                                          .getParsedHour(),
                                                      style: TextStyle(
                                                        fontSize: 16.w,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.getH()),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.blueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.getW(), vertical: 12.getH()),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      GetWeather(
                                          title: "sunrise",
                                          time: onCallData.daily[0].sunrise
                                              .getParsedHour(),
                                          iconloc: "assets/icons/sunsire.svg"),
                                      SizedBox(width: 10.getW()),
                                      GetWeather(
                                          title: "sunset",
                                          time: onCallData.daily[0].sunset
                                              .getParsedHour(),
                                          iconloc: "assets/icons/sunset.svg"),
                                    ]),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.getH()),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.blueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.getW(), vertical: 12.getH()),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ...List.generate(
                                        onCallData.daily.length,
                                        (index) => Row(
                                          children: [
                                            ZoomTapAnimation(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 6.getW()),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2566A3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.getW(),
                                                    vertical: 13.getH()),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      onCallData.daily[index].dt
                                                          .getParsedDateDay(),
                                                      style: TextStyle(
                                                        fontSize: 20.getW(),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Image.network(
                                                      onCallData.daily[index]
                                                          .weather[0].icon
                                                          .getWeatherIconUrl1(),
                                                      fit: BoxFit.none,
                                                      width: 70.getW(),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${getIntType(onCallData.daily[index].dailyTemp.day)}",
                                                          style: TextStyle(
                                                            fontSize: 20.getW(),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: 2.getW()),
                                                        Container(
                                                          height: 9.getH(),
                                                          width: 9.getW(),
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2.getW(),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: 5.getW()),
                                                        Text(
                                                          "C",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.getW(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.getW()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.getH()),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int getIntType(double number) {
  if ((number - number.toInt()) > 0.5) {
    return (number.toInt() + 1);
  } else {
    return number.toInt();
  }
}

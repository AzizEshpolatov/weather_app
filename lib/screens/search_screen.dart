import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../utils/size/app_size.dart';
import 'get_city_weather.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> fromUzCity = [
    "Samarkand",
    "Andijon",
    "Namangan",
    "Jizzax",
    "Sirdaryo",
    "Xorazm",
    "Navoiy",
    "Qashqadaryo",
    "Buxoro",
    "Toshkent",
  ];

  WeatherRepository weatherRepository = WeatherRepository();
  List<String> _filteredWords = [];

  @override
  void initState() {
    _filteredWords = fromUzCity;
    super.initState();
  }

  void _filterWords(String value) {
    setState(
      () {
        _filteredWords = fromUzCity
            .where((word) => word.toLowerCase().contains(value.toLowerCase()))
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    TextEditingController textEditingController = TextEditingController();

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xFF2566A3),
        systemNavigationBarColor: Color(0xFF2566A3),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF2566A3),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.getW()),
                child: Column(
                  children: [
                    SizedBox(height: 40.getH()),
                    SizedBox(
                      height: 60.getH(),
                      child: TextFormField(
                        controller: textEditingController,

                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              width: 1.getW(),
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              width: 1.getW(),
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              width: 1.getW(),
                              color: Colors.red,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.getW()),
                          filled: true,
                          fillColor: Colors.blueAccent,
                          hintText: "Qaysi viloyatni qo`shasiz?",
                          hintStyle: TextStyle(
                            fontSize: 16.getW(),
                            color: Colors.white.withOpacity(.56),
                          ),
                          suffixIcon:
                              const Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.getH()),
                    ...List.generate(
                      fromUzCity.length,
                      (index) {
                        return ZoomTapAnimation(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return GetCityWeather(
                                  getCity: fromUzCity[index],
                                );
                              }),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.blueGrey,
                            ),
                            margin: EdgeInsets.symmetric(vertical: 8.getH()),
                            padding: EdgeInsets.symmetric(vertical: 15.getH()),
                            child: Center(
                              child: Text(
                                "O`zbekiston Respublikasi ${fromUzCity[index]}",
                                style: TextStyle(
                                  fontSize: 16.getW(),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ZoomTapAnimation(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                color: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 10.getH()),
                child: Center(
                  child: Text(
                    "Orqaga Qaytish",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.getH(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

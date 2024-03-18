import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants/app_constants.dart';
import '../models/detail/one_call_data.dart';
import '../models/my_response.dart';
import '../models/simple/weather_main_model.dart';
class ApiProvider {
  static Future<MyResponse> getSimpleWeatherInfo(String city) async {
    Map<String, String> queryParams = {
      "appid": AppConstants.apiKey,
      "q": city,
    };
    Uri uri = Uri.https(
      AppConstants.baseUrl,
      "/data/2.5/weather",
      queryParams,
    );
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return MyResponse(
            data: WeatherMainModel.fromJson(jsonDecode(response.body)));
      } else {
        return MyResponse(errorText: "OTHER ERROR:${response.statusCode}");
      }
    }
    catch (error) {
      return MyResponse(errorText: error.toString());
    }
  }
  static Future<MyResponse> getComplexWeatherInfoUz(String cityLoc) async {

    var uzbekistanCities = {
      "Samarkand": [66.9597, 39.6542],
      "Andijon": [72.3442, 40.7821],
      "Namangan": [71.6726, 40.9983],
      "Jizzax": [67.8422, 40.1158],
      "Sirdaryo": [68.6617, 40.8436],
      "Xorazm": [68.6617, 40.8436],
      "Navoiy": [65.3792, 40.0844],
      "Qashqadaryo": [66.00, 38.5833],
      "Toshkent": [41.2646, 69.2163],
    };
    if (uzbekistanCities.containsKey(cityLoc)) {
      double lat = uzbekistanCities[cityLoc]![1];
      double lon = uzbekistanCities[cityLoc]![0];
      Map<String, String> queryParams = {
        "lat": lat.toString(),
        "lon": lon.toString(),
        "units": "metric",
        "exclude": "minutely,current",
        "appid": AppConstants.complexApiKey2,
      };
      Uri uri = Uri.https(
        AppConstants.baseUrl,
        "/data/2.5/onecall",
        queryParams,
      );
      try {
        http.Response response = await http.get(uri);
        if (response.statusCode == 200) {
          return MyResponse(
              data: OneCallData.fromJson(jsonDecode(response.body)));
        } else {
          return MyResponse(errorText: "OTHER ERROR:${response.statusCode}");
        }
      } catch (error) {
        return MyResponse(errorText: error.toString());
      }
    }
    else {
      return MyResponse(errorText: "Invalid city name");
    }
  }
  static Future<MyResponse> getComplexWeatherInfo() async {
    Map<String, String> queryParams = {
      "lat": "41.2646",
      "lon": "69.2163",
      "units": "metric",
      "exclude": "minutely,current",
      "appid": AppConstants.complexApiKey2,
    };

    Uri uri = Uri.https(
      AppConstants.baseUrl,
      "/data/2.5/onecall",
      queryParams,
    );

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return MyResponse(
            data: OneCallData.fromJson(jsonDecode(response.body)));
      } else {
        return MyResponse(errorText: "OTHER ERROR:${response.statusCode}");
      }
    } catch (error) {
      return MyResponse(errorText: error.toString());
    }
  }
}

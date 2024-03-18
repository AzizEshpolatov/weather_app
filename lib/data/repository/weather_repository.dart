import '../models/my_response.dart';
import '../network/api_provider.dart';

class WeatherRepository {
  Future<MyResponse> getSimpleWeatherInfo(String city) =>
      ApiProvider.getSimpleWeatherInfo(city);

  Future<MyResponse> getComplexWeatherInfo() =>
      ApiProvider.getComplexWeatherInfo();
}

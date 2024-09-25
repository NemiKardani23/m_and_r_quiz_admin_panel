
import 'package:country_state_city/country_state_city.dart';

class StateCityApi {

  static Future<List<State>> getStateList() async {
    List<State> stateList = [];

    try {
      return await getStatesOfCountry('IN');
    } catch (e) { 
      return stateList;
    }
  }

  static Future<List<City>> getCityList(String countryCode, String stateCode) async {
    List<City> cityList = [];
    try {
        return await getStateCities(countryCode,stateCode);
    } catch (e) {
      return cityList;
    }
  }
}

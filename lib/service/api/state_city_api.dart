import 'dart:convert';

import 'package:http/http.dart' as http;

class StateCityApi {
  static String stateUrl =
      "https://cdn-api.co-vin.in/api/v2/admin/location/states";
  static String cityUrl =
      "https://cdn-api.co-vin.in/api/v2/admin/location/districts/{stateId}";

 static Future<List<StateModel>> getStateList() async {
    List<StateModel> stateList = [];

    try {
      http.Response? response = await http.get(Uri.parse(stateUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var states = data["states"] as List;

        for (var state in states) {
          stateList.add(StateModel.fromJson(state));
        }
        return stateList;
      } else {
        return stateList;
      }
    } catch (e) {
      return stateList;
    }
  }

 static Future<List<CityModel>> getCityList(String stateId) async {
    List<CityModel> cityList = [];
    try {
      http.Response? response =
          await http.get(Uri.parse(cityUrl.replaceAll("{stateId}", stateId)));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var cities = data["districts"] as List;
        for (var city in cities) {
          cityList.add(CityModel.fromJson(city));
        }
        return cityList;
      } else {
        return cityList;
      }
    } catch (e) {
      return cityList;
    }
  }
}

class StateModel {
  int? id;
  String? stateName;

  StateModel({this.id, this.stateName});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['state_id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state_id'] = id;
    data['state_name'] = stateName;
    return data;
  }
}

class CityModel {
  int? id;
  String? districtName;

  CityModel({this.id, this.districtName});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['district_id'];
    districtName = json['district_name'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['district_id'] = id;
    data['district_name'] = districtName;
  
    return data;
  }
}

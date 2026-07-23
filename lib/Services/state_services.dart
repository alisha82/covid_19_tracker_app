import 'dart:convert';

import 'package:covid_19/Model/worldStateModel.dart';
import 'package:covid_19/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;
class StateServices {
  Future<WorldStateModel> fetchWorldStateRecord() async{
    final response =await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countryListApi() async{
    var data;
    final response =await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Error');
    }
  }
}


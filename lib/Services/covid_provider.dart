import 'package:flutter/foundation.dart';
import 'package:covid_19/Model/worldStateModel.dart';
import 'package:covid_19/Services/state_services.dart';

class CovidProvider with ChangeNotifier {
  // Instance of StateServices
  final StateServices _stateServices = StateServices();

  // Search Query for filtering countries
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Method to update search query and notify UI
  void setSearchQuery(String query) {
    _searchQuery = query;
    print("Search Query Updated: $_searchQuery");
    notifyListeners(); // Is se countries list real-time update hogi
  }

  // 1. Fetch World State Records
  Future<WorldStateModel> fetchWorldStateRecord() async {
    return await _stateServices.fetchWorldStateRecord();
  }

  // 2. Fetch Country List
  Future<List<dynamic>> countryListApi() async {
    return await _stateServices.countryListApi();
  }
}
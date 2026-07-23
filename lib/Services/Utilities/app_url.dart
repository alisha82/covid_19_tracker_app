
class AppUrl {
  //this is our base url
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  // Fetch world covid state
  static String worldStateApi = '${baseUrl}all';
  static String countriesList = '${baseUrl}countries';
}
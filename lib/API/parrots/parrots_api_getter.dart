import 'package:final_project/API/parrots/parrots_model_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_project/config/app_data.dart'; // Import AppConfig

class ApiService {
  //https://run.mocky.io/v3/9f1e784b-52c5-4436-8f96-bf1f6251d70a
  static final String apiUrl = 'https://run.mocky.io/v3/b5026a53-99f7-40ab-b73d-b5963de55542';

  static Future<void> fetchParrotInfoList() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Parrot> parrotList = jsonData.map((data) => Parrot.fromJson(data)).toList();

        AppConfig.Parrots.clear(); // Clear the list before adding
        AppConfig.Parrots.addAll(parrotList); // Add fetched parrots to the list
      } else {
        throw Exception('Failed to fetch parrot info');
      }
    } catch (e) {
      print("Error fetching parrot info: $e");
    }
  }
}

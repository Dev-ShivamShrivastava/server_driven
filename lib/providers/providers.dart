import 'dart:convert';

import '../utils/WidgetConfig.dart';
import 'package:http/http.dart' as http;


Future<List<WidgetConfig>> fetchWidgetConfig() async {
  final response = await http.get(Uri.parse('http://192.168.1.107:4000/user'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => WidgetConfig.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load widget config');
  }
}
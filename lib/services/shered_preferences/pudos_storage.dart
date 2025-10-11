import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/pudo_model.dart';

class PudosStorage {
  static const _keyPudos = 'pudos_list';

  static Future<void> savePudos(List<Pudo> pudos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = pudos.map((p) => p.toJson()).toList();
    await prefs.setString(_keyPudos, jsonEncode(jsonList));
  }

  static Future<List<Pudo>> loadPudos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyPudos);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Pudo.fromJson(e)).toList();
  }

  static Future<void> clearPudos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyPudos);
  }
}

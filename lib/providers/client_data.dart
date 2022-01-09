import 'dart:convert';

import 'client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'client';

  static Client myClient =Client(
    image:
        "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
    name: 'Test Test',
    email: 'test.test@gmail.com',
    phone: '(208) 206-5039',
    
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setClient(Client client) async {
    final json = jsonEncode(client.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static Client getClient() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myClient : Client.fromJson(jsonDecode(json));
  }
}

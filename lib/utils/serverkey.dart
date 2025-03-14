import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';

class get_server_key {
  Future<String> server_token() async {
    // Load JSON file from assets
    final String keyJson =
        await rootBundle.loadString('assets/json/teen-splah-142f4f955a5d.json');
    final Map<String, dynamic> keyData = json.decode(keyJson);
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    // Authenticate using the loaded key
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(keyData),
      scopes,
    );
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}

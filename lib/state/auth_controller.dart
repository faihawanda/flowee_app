import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ValueNotifier<bool> {
  AuthController._() : super(false);

  static final AuthController instance = AuthController._();

// ini akan kesimpan dilocalstrogare
  static const _prefsKey = 'flowee_is_logged_in';

// SharedPreferences-> bukan default class flutter. ini terparty yang dimiliki officialy flutter tapi buka default ya

// dipanggil sekali saat aplikasi baru dibuka (muncul splash screen)
// untuk membaca status login yang tersimpan dari sesi SEBELUMNYA
  Future<void> loadPersistedSession() async {
    final prefs = await SharedPreferences.getInstance();
    value = prefs.getBool(_prefsKey) ?? false;
    // ?? -> default value
    // SharedPreferences menyimpan value ke local storage dan punya kegunaannya banyak
  }

  Future<void> login() async {
    value = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, true);
  }

  // menyimpan session bahwa 'oh user udah keluar'
  Future<void> logout() async {
    value = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, false);
  }

}
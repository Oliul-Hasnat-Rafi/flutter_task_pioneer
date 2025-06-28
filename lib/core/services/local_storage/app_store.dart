import 'package:flutter/material.dart';

abstract class AppStorageI {
  Future<void> changeTheme(ThemeMode themeMode);
  Future<ThemeMode> retrieveTheme();

}

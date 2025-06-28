
import 'package:flutter/material.dart';
import 'package:flutter_task/core/services/local_storage/app_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageImp implements AppStorageI {
  static const String _keyTheme = 'theme';
  static const String _keyFavorites = 'favorites';

  @override
  Future<void> changeTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTheme, themeMode.name);
  }

  @override
  Future<ThemeMode> retrieveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_keyTheme);
    
    switch (themeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> addFavorite(int productId) async {
    final favorites = await getFavorites();
    if (!favorites.contains(productId)) {
      favorites.add(productId);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyFavorites, favorites.join(','));
    }
  }

  @override
  Future<void> removeFavorite(int productId) async {
    final favorites = await getFavorites();
    favorites.remove(productId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFavorites, favorites.join(','));
  }

  @override
  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesStr = prefs.getString(_keyFavorites);
    if (favoritesStr == null || favoritesStr.isEmpty) {
      return [];
    }
    
    try {
      return favoritesStr
          .split(',')
          .where((e) => e.isNotEmpty)
          .map((e) => int.parse(e))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
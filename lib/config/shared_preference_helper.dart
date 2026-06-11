import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


final ValueNotifier<int> itemTapBehaviorNotifier = ValueNotifier<int>(1);

class SharedPreferenceHelper {
  static const String _baseUrlKey = 'base_url';
  static const String _tokenKey = 'auth_token';
  static const String _databaseNameKey = 'database_name';
  static const String _loginDataKey = 'login_data';
  static const String _isSchoolRegisteredKey = 'is_school_registered';
  static const String _branchDataKey = 'branch_data';
  static const String _playStoreVersionKey = 'playstore_version';
  static const String _appStoreVersionKey = 'appstore_version';
  static const String _schoolCodeKey = 'school_code';
  static const String _schoolNameKey ='school_name';

  /// ------------------ SAVE FULL BRANCH DATA ------------------
  Future<void> saveBranchData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data);
    await prefs.setString(_branchDataKey, jsonString);
  }

  /// ------------------ GET FULL BRANCH DATA ------------------
  Future<Map<String, dynamic>?> getBranchData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_branchDataKey);

    if (jsonString == null) return null;

    return jsonDecode(jsonString);
  }

  /// ------------------ SCHOOL REGISTER ------------------
  Future<void> saveSchoolRegistered(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSchoolRegisteredKey, value);
  }

  Future<bool> isSchoolRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSchoolRegisteredKey) ?? false;
  }
  // static const String _vatStatusKey = 'vat_status';
  // static const String _vatTypeKey = 'vat_type';
  // static const _itemTapBehaviorKey = 'itemTapBehavior';
  // static const _paymentOptionKey = 'payment_option';
  // // ✅ GLOBAL NOTIFIER (this is what HomeScreen listens to)

  /// ------------------ BASE URL ------------------
  Future<void> setBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_baseUrlKey, url);
  }

  Future<String?> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_baseUrlKey);
  }

  /// ------------------ Play store version ------------------
  Future<void> setPlayStoreVersion(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_playStoreVersionKey, url);
  }

  Future<String?> getPlayStoreVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_playStoreVersionKey);
  }

  /// ------------------ App store version ------------------
  Future<void> setAppStoreVersion(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_appStoreVersionKey, url);
  }

  Future<String?> getAppStoreVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_appStoreVersionKey);
  }

  /// ------------------ School Code version ------------------
  Future<void> setSchoolCode(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_schoolCodeKey, url);
  }

  Future<String?> getSchoolCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_schoolCodeKey);
  }

  /// ------------------ School Name version ------------------
  Future<void> setSchoolName(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_schoolNameKey, url);
  }

  Future<String?> getSchoolName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_schoolNameKey);
  }

  /// ------------------ TOKEN ------------------
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// ------------------ BranchID ------------------
  Future<bool> setBranchId(String branchId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("branchId", branchId);
  }

  Future<String> getBranchId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("branchId") ?? '';
  }

  Future<void> setDatabaseName(String dbName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_databaseNameKey, dbName);
  }

  Future<String?> getDatabaseName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_databaseNameKey);
  }



  Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginDataKey);
    await prefs.remove(_tokenKey);
  }


  // Clear on logout
  static Future<void> clearSavedAccount() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('accounts');
  }


  //Clear account details
  static Future<void> clearAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('accounts', []);
  }

}

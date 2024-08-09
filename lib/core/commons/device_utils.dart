import 'dart:io';

import 'package:clean_architechture/core/models/shared_preferences.dart';
import 'package:clean_architechture/core/services/di_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/device_info.dart';
import 'dart:io' show Platform;

class DeviceUtils{
  static Future<DeviceInfo> getDeviceInfo(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    DeviceInfo info = DeviceInfo();
    try {
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        info.deviceId = iosInfo.identifierForVendor;
        info.deviceName = iosInfo.name;
        info.deviceOs = iosInfo.systemVersion;
        info.deviceType = 'iOS';
      } else {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        info.deviceId = androidInfo.id;
        info.deviceName = androidInfo.model ;
        info.deviceOs = androidInfo.version.release;
        info.deviceType = 'Android';
      }
      info.deviceUuid = getDeviceUuid();
    } catch (e) {
      print('Failed to get device info: $e');
    }
    return info;
  }
  static String getDeviceUuid(){
    SharedPreferences preferences = DIService.sl<SharedPreferences>();
    String uuid = preferences.getString(SharedPreferencesKey.deviceUUID) ?? "";
    if(uuid.isEmpty ){
      var uuidV4 = const Uuid().v4();
      preferences.setString(SharedPreferencesKey.deviceUUID, uuidV4);
      uuid = uuidV4;
    }
    return uuid;
  }
}
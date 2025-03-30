import 'dart:convert';

import 'package:aros_staff/features/auth/domain/entities/old_login_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/old_login_model.dart';



abstract class AuthUserLocalDataSource{


  Future<void> deleteUserInfo();
  OldLoginEntity? getOtpToken();
  Future<void> storeToken({required String otpInfo});



}

class AuthUserDataSourceIml implements AuthUserLocalDataSource{
  final Box _hiveBox;
  AuthUserDataSourceIml({required Box<dynamic> hiveBox}) : _hiveBox = hiveBox;

  static const String otpData = 'OtpData';
  

  @override
  Future<void> deleteUserInfo() async{
      await _hiveBox.delete(otpData);
  }
  
  @override
  OldLoginEntity? getOtpToken() {
    final otpJson = _hiveBox.get(otpData);
    if (otpJson != null) {

      return OldLoginModel.fromJson(jsonDecode(otpJson));
    }
    return null;
  }
  
  @override
  Future<void> storeToken({required String otpInfo}) async{
  await _hiveBox.put(otpData,otpInfo);
  }
  
}
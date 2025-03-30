
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';




class LocationService {

  static Future<Position?> getCurrentLocation(BuildContext context) async {

    try{


      if (! (await _handleLocationPermission())) {

        if(Platform.isAndroid)  {var data  = await Geolocator.openLocationSettings();

        }
        else  if(Platform.isIOS){ if(context.mounted) await _showLocationDialog(context);}

      }

      var result = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.medium);

      return result;

    }
    catch (e) {
      return null;
    }


  }

  static Future<bool> _handleLocationPermission() async {
    var status =   await Geolocator.checkPermission();
    if (status == LocationPermission.always || status == LocationPermission.whileInUse) {
      return true;
    }
    else if (status == LocationPermission.denied) {
      var result = await Geolocator.requestPermission();
      if(result == LocationPermission.always || result == LocationPermission.whileInUse) {
        return true;
      } else {
        return false;
      }
    }
    else {

      return false;
    }
  }
}

Future<void> _showLocationDialog (BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return  CupertinoAlertDialog(
        title: Text('Location Required'),
        content: Text('Please enable location services.'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Settings'),
            onPressed: () async {
              await  AppSettings.openAppSettings();
              if(context.mounted) Navigator.of(context).pop();// Open app settings
            },
          ),
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
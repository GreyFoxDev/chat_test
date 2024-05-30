import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceFirestore {
  ///~~~~~~~~~~~~ POST DATA ~~~~~~~~~~~~///
  dynamic postData(
      {required Map<String, dynamic> data,
      required DocumentReference<Map<String, dynamic>>
          documentReference}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Making Request
        var response = await documentReference.set(data).then((value) {
          return 200;
        }).catchError((error) {
          return error;
        });
        print('FIRESTORE RESPONSE ==> $response');
        return response;
      }
    } on SocketException catch (_) {
      return "No internet connectivity.";
    }
  }

  ///~~~~~~~~~~~~ DELETE DOCUMENT ~~~~~~~~~~~~///
  deleteDocument(
      {required DocumentReference<Map<String, dynamic>>
          documentReference}) async {
    ///~~~~~~~~~~~~ DELETE DOCUMENT ~~~~~~~~~~~~///
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Making Request
        var response = await documentReference.delete().then((value) {
          return 200;
        }).catchError((error) {
          return error;
        });
        print('FIRESTORE RESPONSE ==> $response');
        return response;
      }
    } on SocketException catch (_) {
      return "No internet connectivity.";
    }
  }
}

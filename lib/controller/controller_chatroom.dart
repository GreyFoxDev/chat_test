import 'package:chat_test/model/services/service_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ControllerChatroom extends ChangeNotifier {
  /// LIST OF MESSAGES
  List<types.Message> messages = [];

  /// USER
  final user = types.User(
    id: FirebaseAuth.instance.currentUser!.uid,
  );

  /// SINGLE CHAT ROOM ID
  String chatRoomId = "test-chat-room";

  /// ~~~~~~~~~~~~ MESSAGE SEND ACTION ~~~~~~~~~~~~ ///
  onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: user.id,
      text: message.text,
    );

    // INSERTING MESSAGE TO LIST
    messages.insert(0, textMessage);

    sendTextMessage(data: textMessage);

    // NOTIFYING LISTENER FOR CHANGES
    notifyListeners();
  }

  /// ~~~~~~~~~~~~ MESSAGE TAP ACTION ~~~~~~~~~~~~ ///
  onMessageTap(BuildContext context, types.Message p1) {
    /// TODO: Implement message tap action if required
  }

  /// ~~~~~~~~~~~~ MESSAGE PREVIEW DATA FETCHED ~~~~~~~~~~~~ ///
  onPreviewDataFetched(types.TextMessage p1, types.PreviewData p2) {
    /// TODO: Implement message preview data fetched if required
  }

  /// ~~~~~~~~~~~~ SETTING UP NEW USER DATA ~~~~~~~~~~~~ ///
  setUpUser() async {
    var response = await ServiceFirestore().postData(
        documentReference:
            FirebaseFirestore.instance.collection("users").doc(user.id),
        data: {
          "userId": user.id,
          "userName": user.firstName ?? user.id.toString().substring(0, 4),
          "userImage": user.imageUrl,
          "chatroomId": chatRoomId, // CAN BE DYNAMIC IN REAL CHAT APP
        });
    return response;
  }

  sendTextMessage({required types.TextMessage data}) async {
    // try {
    List<dynamic> messages = await fetchPreviousMessages();
    messages.add({
      "createdAt": data.createdAt.toString(),
      "id": data.id,
      "text": data.text,
      "type": data.type.toString(),
    });
    ///////////////////////////////////////////////////////
    // ADDING MESSAGE TO CURRENT USER CHAT ROOM
    ///////////////////////////////////////////////////////
    await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .update({"messages": messages}).whenComplete(() async {});
    return 200;
    // } catch (e) {
    //   print(e.toString());
    //   return e.toString();
    // }
  }

  fetchPreviousMessages() async {
    // try {
    var response = await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .get();
    return response["messages"] as List<dynamic>;
    // } catch (e) {
    //   print(e.toString());
    //   return e.toString();
    // }
  }

  extractListenableData(DocumentSnapshot<Object?> docSnapshot) {
    List<dynamic> messages = docSnapshot["messages"];
    List<types.Message> messagesData = [];
    for (var element in messages) {
      types.TextMessage data = types.TextMessage(
        author: types.User(id: element['id']),
        createdAt: int.parse(element['createdAt'].toString()),
        id: element['id'],
        text: element['text'],
      );
      messagesData.add(data);
    }
    messages = messagesData;
    notifyListeners();
  }
}

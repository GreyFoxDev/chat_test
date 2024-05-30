import 'package:chat_test/controller/controller_chatroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ScreenChatRoom extends StatefulWidget {
  const ScreenChatRoom({super.key});

  @override
  State<ScreenChatRoom> createState() => _ScreenChatRoomState();
}

class _ScreenChatRoomState extends State<ScreenChatRoom> {
  @override
  void initState() {
    ControllerChatroom().setUpUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Room"),
      ),
      body: _body(context),
    );
  }

  /// ~~~~~~~~~~~~ BODY ~~~~~~~~~~~~ ///
  _body(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection("chatroom")
            .doc("test-chat-room")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff35C9FF),
              ),
            );
          } else {
            // EXTRACT DATA
            var docSnapshot = snapshot.data as DocumentSnapshot;
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

            return ListView.builder(
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(messages[index]['text']),
                    ],
                  );
                });
          }
        });
    //

    // return Consumer<ControllerChatroom>(
    //     builder: ((context, providerValues, child) => StreamBuilder<Object>(
    //         stream: FirebaseFirestore.instance
    //             .collection("chatroom")
    //             .doc(providerValues.chatRoomId)
    //             .snapshots(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasError) {
    //             return const Text('Something went wrong');
    //           }
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const Center(
    //               child: CircularProgressIndicator(
    //                 color: Color(0xff35C9FF),
    //               ),
    //             );
    //           } else {
    //             // EXTRACT DATA
    //             providerValues
    //                 .extractListenableData(snapshot.data as DocumentSnapshot);
    //             var docSnapshot = snapshot.data as DocumentSnapshot;
    //             List<dynamic> messages = docSnapshot["messages"];
    //             List<types.Message> messagesData = [];
    //             for (var element in messages) {
    //               types.TextMessage data = types.TextMessage(
    //                 author: types.User(id: element['id']),
    //                 createdAt: int.parse(element['createdAt'].toString()),
    //                 id: element['id'],
    //                 text: element['text'],
    //               );
    //               messagesData.add(data);
    //             }
    //             providerValues.messages = messagesData;
    //
    //             return Chat(
    //               messages: providerValues.messages,
    //               // messages: messagesData,
    //               onAttachmentPressed: () {},
    //               scrollPhysics: const AlwaysScrollableScrollPhysics(),
    //               onMessageTap: providerValues.onMessageTap,
    //               onPreviewDataFetched: providerValues.onPreviewDataFetched,
    //               onSendPressed: providerValues.onSendPressed,
    //               user: providerValues.user,
    //             );
    //           }
    //         })));

    return Consumer<ControllerChatroom>(
        builder: ((context, providerValues, child) => Chat(
              avatarBuilder: (user) {
                return Container(child: Text(user.id));
              },
              messages: providerValues.messages,
              onAttachmentPressed: () {},
              scrollPhysics: const AlwaysScrollableScrollPhysics(),
              onMessageTap: providerValues.onMessageTap,
              onPreviewDataFetched: providerValues.onPreviewDataFetched,
              onSendPressed: providerValues.onSendPressed,
              user: providerValues.user,
            )));
  }
}

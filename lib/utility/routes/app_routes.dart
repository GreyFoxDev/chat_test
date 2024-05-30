import 'package:chat_test/view/auth/screen_auth.dart';
import 'package:chat_test/view/chatroom/screen_chatroom.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String routeInitial = '/auth';
  static const String routeScreenAuth = '/auth';
  static const String routeScreenChatRoom = '/chat-room';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// AUTH
      case routeScreenAuth:
        return MaterialPageRoute(builder: (_) => ScreenAuth());

      /// CHAT ROOM
      case routeScreenChatRoom:
        return MaterialPageRoute(builder: (_) => const ScreenChatRoom());

      default:
        // RETURNING AUTH SCREEN BY DEFAULT
        return MaterialPageRoute(builder: (_) => ScreenAuth());
    }
  }
}

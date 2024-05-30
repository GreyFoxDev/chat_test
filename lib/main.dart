import 'package:chat_test/controller/controller_auth.dart';
import 'package:chat_test/controller/controller_chatroom.dart';
import 'package:chat_test/utility/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ControllerChatroom()),
        ChangeNotifierProvider(create: (context) => ControllerAuth()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: (FirebaseAuth.instance.currentUser !=
                null) // CHECK IF USER ALREADY LOGGED IN
            ? AppRoutes.routeScreenChatRoom
            : AppRoutes.routeInitial,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}

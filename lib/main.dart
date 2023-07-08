import 'package:chat_app/chat_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/brand_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();

  runApp(ChangeNotifierProvider(
    create: (BuildContext context) {
      return AuthService();
    },
    child: const ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: BrandColor.themeColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.black,
          )),
      home: FutureBuilder<bool>(
          future: context.read<AuthService>().isLoggedIn(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData && snapshot.data!){
                return const ChatPage();
              }else {
                return LoginPage();
              }
            }
            return const CircularProgressIndicator();
          }),
      routes: {
        '/chat': (context) => const ChatPage(),
      },
    );
  }
}

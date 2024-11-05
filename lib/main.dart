import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:healio/core/const.dart';
import 'package:healio/view/gemini_chat/gemini_chat_page.dart';
import 'package:healio/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: AppRoutes.splash,
    //   getPages: AppPages.routes,
    //   theme: ThemeData.light().copyWith(
    //     scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 248),
    //   ),
    // );
    return MaterialApp(
      home: GeminiChatPage(),
    );
  }
}

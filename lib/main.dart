import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:healio/core/const.dart';
import 'package:healio/core/routes/routers.dart';
import 'package:healio/core/routes/routes.dart';
import 'package:healio/view_model/article_provider.dart';
import 'package:healio/view_model/medicine_provider.dart';
import 'package:healio/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: "assets/.env");
  Gemini.init(
    apiKey: dotenv.env["GEMINI_API_KEY"]!,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),  
        ChangeNotifierProvider(create: (_) => ArticleViewModel()),  
        ChangeNotifierProvider(create: (_) => MedicineViewModel()),  
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroungColor,
      ),
    );
  }
}

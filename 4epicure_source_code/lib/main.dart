import './auth_screens/signIn.dart';
import './auth_screens/signUp.dart';
import './screens/about_us_screen.dart';
import './screens/grocery_screen.dart';
import './screens/recipe_with_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart' as provider;
import './screens/tabs_screen.dart';
import './providers/chats_provider.dart';
import './providers/models_provider.dart';
import 'main_splash.dart';
import './screens/get_nutrients_screen.dart';

void main() {
  runApp(
    riverpod.ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => ModelsProvider(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Recipe And Meals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.amber,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          headline2: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          headline3: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          bodyText2: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      // home:const SignupScreen(),
      home: SplashScreen(),
      // home: ShakeToNavigate(),
      // home:getNutrientsScreen(),
      // home: AboutUsScreen(),
    );
  }
}

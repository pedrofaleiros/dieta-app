import 'package:flutter/material.dart';
import 'package:macros_app/src/features/auth/presentation/view/pages/auth_page.dart';
import 'package:macros_app/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:macros_app/src/features/home/presentation/view/pages/home_page.dart';
import 'package:macros_app/src/splash_page.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AuthViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _theme,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (_) => const SplashPage(),
          HomePage.routeName: (_) => const HomePage(),
          AuthPage.routeName: (_) => const AuthPage(),
        },
      ),
    );
  }
}

final _theme = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color(0xff0b0b0b),
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    titleMedium: TextStyle(
      color: Color(0xff0b0b0b),
      fontWeight: FontWeight.w700,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Color(0xff0b0b0b),
      fontWeight: FontWeight.w700,
      fontSize: 12,
    ),
    bodyLarge: TextStyle(
      color: Color(0xfffafafa),
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color: Color(0xfffafafa),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: Color(0xfffafafa),
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
  ),
  fontFamily: 'rawline',
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.dark,
    primary: const Color(0xff00D690),
    secondary: const Color(0xffc6c6c6),
    primaryContainer: const Color(0xff063827),
    background: const Color(0xff0b0b0b),
    onBackground: const Color(0xfffafafa),
    error: const Color(0xffe52207),
    errorContainer: const Color(0xffFDE0DB),
    surface: const Color(0xff18181a),
    outline: const Color(0xff3A3A40),
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/screen/home_screen.dart';
import 'package:newsapp/screen/indexScreen.dart';
import 'package:newsapp/screen/login_screen.dart';
import 'package:newsapp/screen/newScreen.dart';
import 'package:newsapp/screen/newsScreen.dart';
import 'package:newsapp/screen/register_login.dart';
import 'package:newsapp/themes/themes.dart';
import 'bloc/settings/settings_cubit.dart';
import 'bloc/settings/settings_state.dart';
import 'localizations/localizations.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(initialLocation: '/new_screen', routes: [
  GoRoute(
    path: '/home_screen',
    builder: (context, state) => home_screen(),
  ),
  GoRoute(
    path: '/login_screen',
    builder: (context, state) => login_screen(),
  ),
  GoRoute(
    path: '/register_screen',
    builder: (context, state) => register_screen(),
  ),
  GoRoute(
    path: '/index_screen',
    builder: (context, state) => indexScreen(),
  ),
  GoRoute(
    path: '/news_screen',
    builder: (context, state) => newsScreen(),
  ),
  GoRoute(
    path: "/haberler/:newsID",
    builder: (context, state) => newsDetailScreen(
      newsID: state.pathParameters['newsID']!,
    ),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(SettingsState()),
      child:
          BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
        return MaterialApp.router(
          routerConfig: _router,
          title: "CNN",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLanguages
              .map((e) => Locale(e, ""))
              .toList(),
          locale: Locale(state.language, ""),
          themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
        );
      }),
    );
  }
}

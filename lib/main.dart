import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/router/router.dart';
import 'config/theme/bloc/bloc.dart';
import 'config/theme/theme.dart';
import 'core/services/di_service.dart';
import 'core/utils/bloc_observer.dart';
import 'generated/l10n.dart';
import 'package:timezone/data/latest.dart' as tz;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIService().init();
  await setUpAppAgain();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}


Future<void> setUpAppAgain() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.remove(SharedPreferencesKey.userAuth);
  // prefs.remove(SharedPreferencesKey.home);
  //  AuthEntity.enableLoginRequired();
 // prefs.clear();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = GetIt.instance<AppTheme>();
    return BlocProvider<ThemeBloc>(
      create: (context) =>
          ThemeBloc()..add(ToggleThemeEvent(appTheme.getTheme())),
      child: BlocBuilder<ThemeBloc, ThemeType>(
        builder: (context, themeType) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: const Locale('en', 'US'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: themeType == ThemeType.light
                ? appTheme.lightTheme
                : appTheme.darkTheme,
            routerConfig: router,
          );
        },
      ),
    );
  }
}

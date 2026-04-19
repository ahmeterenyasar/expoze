import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_localization_constants.dart';
import 'core/theme/theme.dart';
import 'data/services/local_db_service.dart';
import 'features/onboarding/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbService = LocalDbService();
  await dbService.init();

  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.dbService,
  });

  final ILocalDbService dbService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expoze',
      theme: AppTheme.light,
      locale: AppLocalizationConstants.fallbackLocale,
      supportedLocales: AppLocalizationConstants.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: OnboardingScreen(dbService: dbService),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_localization_constants.dart';
import 'core/theme/theme.dart';
import 'data/services/local_db_service.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/tasks/tasks_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbService = LocalDbService();
  await dbService.init();

  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.dbService,
  });

  final ILocalDbService dbService;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<bool> _shouldShowOnboardingFuture;

  @override
  void initState() {
    super.initState();
    _shouldShowOnboardingFuture = _resolveShouldShowOnboarding();
  }

  Future<bool> _resolveShouldShowOnboarding() async {
    final user = await widget.dbService.getUser();
    if (user == null) {
      return true;
    }

    return user.onboardingFocusAreas.isEmpty;
  }

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
      home: FutureBuilder<bool>(
        future: _shouldShowOnboardingFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              backgroundColor: AppColors.backgroundCream,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final shouldShowOnboarding = snapshot.data ?? true;
          if (shouldShowOnboarding) {
            return OnboardingScreen(dbService: widget.dbService);
          }

          return TasksScreen(dbService: widget.dbService);
        },
      ),
    );
  }
}

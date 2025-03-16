import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/forgot_password_bloc.dart';
import 'features/authentication/presentation/pages/forgot_password_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/setting/presentation/bloc/settings_bloc.dart';
import 'features/setting/presentation/pages/settings_page.dart';
import 'features/splash/presentation/pages/splash_screen.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'features/project/presentation/pages/project_dashboard_page.dart';
import 'features/project/presentation/bloc/project_bloc.dart';
import 'core/utils/theme_provider.dart';
import 'injection_container.dart' as di;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => di.sl<AuthBloc>()),
              BlocProvider(create: (_) => di.sl<ProjectBloc>()), // Uses DI
              BlocProvider(create: (_) => di.sl<SplashBloc>()),
              BlocProvider(create: (_) => di.sl<SettingsBloc>()),
              BlocProvider(create: (_) => di.sl<ForgotPasswordBloc>()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'CoConstruct',
              theme: themeProvider.themeData,
              initialRoute: '/splash',
              routes: {
                '/splash': (context) => SplashScreen(),
                '/login': (context) => LoginPage(),
                '/dashboard': (context) => ProjectDashboardPage(),
                '/settings': (context) => BlocProvider(create: (context) => di.sl<SettingsBloc>(), child: SettingsPage(),),
                '/forgot_password': (context) => BlocProvider(create: (context) => di.sl<ForgotPasswordBloc>(), child: ForgotPasswordPage(),),

              },
              onUnknownRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Center(
                      child: Text('Route not found: ${settings.name}'),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
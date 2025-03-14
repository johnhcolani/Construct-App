import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/project/presentation/bloc/project_bloc.dart';
import 'core/utils/theme_provider.dart';
import 'features/project/presentation/bloc/project_event.dart';
import 'features/project/presentation/pages/project_dashboard_page.dart';
import 'features/splash/presentation/pages/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
              BlocProvider(create: (_) => di.sl<ProjectBloc>()..add(FetchProjects())),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'CoConstruct',
              theme: themeProvider.themeData,
              initialRoute: '/splash',
              routes: {
                '/splash': (context) => SplashScreen(), // Splash screen route
                '/login': (context) => LoginPage(),     // Login page route
                '/dashboard': (context) => ProjectDashboardPage(), // Dashboard route
              },
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/project/presentation/bloc/project_bloc.dart';
import 'features/project/presentation/bloc/project_event.dart';
import 'features/project/presentation/pages/project_dashboard_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<ProjectBloc>()..add(FetchProjects())),
      ],
      child: MaterialApp(
        title: 'CoConstruct',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/dashboard': (context) => ProjectDashboardPage(),
        },
      ),
    );
  }
}
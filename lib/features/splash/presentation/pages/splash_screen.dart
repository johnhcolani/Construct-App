import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../project/presentation/bloc/project_bloc.dart';
import '../../../project/presentation/bloc/project_event.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger CheckAuthStatus event when the widget is built
    context.read<SplashBloc>().add(CheckAuthStatus());

    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            // If user is logged in, dispatch LoadProjects and navigate to dashboard
            context.read<ProjectBloc>().add(LoadProjects());
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (state is SplashUnauthenticated) {
            // If user is not logged in, navigate to login page
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              Text(
                'CoConstruct',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
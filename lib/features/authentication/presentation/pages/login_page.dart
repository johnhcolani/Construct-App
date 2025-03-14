import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/theme_provider.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, '/dashboard');
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyle(color: ColorManager.textWhite),
                  ),
                  backgroundColor: ColorManager.errorRed,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                // Centered content (title, text fields, and Sign In button)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                  // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'COCONSTRUCT™',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.successGreen,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              LoginSubmitted(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Stack with image and overlaid Row
                Container(
                 // color: Colors.yellow,
                  height: 400, // Fixed height for the image section
                  child: Stack(
                    children: [
                      // Image with opacity
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.1, // Only the image has reduced opacity
                          child: Image.asset(
                            'assets/images/img.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      // Row overlaid at the bottom (full opacity)
                      Positioned(
                        left: 16.0,
                        right: 16.0,
                        bottom: 20.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Navigate to Forgot Password page
                              },
                              child: Text(
                                'I forgot my password',
                                style: TextStyle(color: ColorManager.primaryBlue,fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 20),
                            Consumer<ThemeProvider>(
                              builder: (context, themeProvider, child) {
                                return TextButton(
                                  onPressed: () {
                                    themeProvider.toggleTheme();
                                    print('Theme toggled. Is Dark Mode: ${themeProvider.isDarkMode}');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        themeProvider.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Toggle Theme',
                                        style: TextStyle(color: ColorManager.primaryBlue,fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
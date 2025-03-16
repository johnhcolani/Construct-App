import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/theme_provider.dart';
import '../bloc/forgot_password_bloc.dart';
import '../bloc/forgot_password_event.dart';
import '../bloc/forgot_password_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Password reset email sent! Check your inbox.',
                    style: TextStyle(color: ColorManager.textWhite),
                  ),
                  backgroundColor: ColorManager.successGreen,
                ),
              );
              Navigator.pop(context); // Navigate back to LoginPage
            } else if (state is ForgotPasswordFailure) {
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
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
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (emailController.text.isNotEmpty) {
                              context.read<ForgotPasswordBloc>().add(
                                ResetPasswordRequested(
                                  email: emailController.text,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please enter your email',
                                    style: TextStyle(color: ColorManager.textWhite),
                                  ),
                                  backgroundColor: ColorManager.errorRed,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: state is ForgotPasswordLoading
                              ? CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary)
                              : Text(
                            'Reset Password',
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
                SizedBox(
                  height: 400,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.1,
                          child: Image.asset(
                            'assets/images/img.png',
                            fit: BoxFit.cover,
                            width:  double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16.0,
                        right: 16.0,
                        bottom: 20.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Navigate back to LoginPage
                              },
                              child: Text(
                                'Back to Login',
                                style: TextStyle(
                                  color: ColorManager.primaryBlue,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                        style: TextStyle(
                                          color: ColorManager.primaryBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
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